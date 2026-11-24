module syntax

import strconv
import v.embed_file
import v.flat
import v.parser
import v.pref
import v.scanner
import v.token

struct ExportAttributeField {
	name        string
	is_bool     bool
	enum_values []string
}

// Embed the schema declarations so standalone binaries can scan projects from any directory.
fn load_export_attribute_schemas() !map[string][]ExportAttributeField {
	mut schemas := map[string][]ExportAttributeField{}
	for source in [
		$embed_file('../../php_export_attributes.v').to_string(),
		$embed_file('../../php_bool_param.v').to_string(),
		$embed_file('../../php_string_param.v').to_string(),
		$embed_file('../../php_object_copy.v').to_string(),
	] {
		load_attribute_schemas(source, mut schemas)!
	}
	return schemas
}

fn load_attribute_schemas(source string, mut schemas map[string][]ExportAttributeField) ! {
	mut reader := parser.Parser.new(pref.new_preferences())
	tree := reader.parse_text('vphp_attribute_schema.v', source)
	for diagnostic in reader.diagnostics {
		if diagnostic.severity !in ['warning:', 'notice:'] {
			return error('php_export_attributes.v:${diagnostic.line}:${diagnostic.column}: ${diagnostic.message}')
		}
	}
	mut enums := map[string][]string{}
	for node in tree.nodes {
		if node.kind == .enum_decl {
			enums[node.value] = tree.children_of(node).filter(tree.node(it).kind == .enum_field).map('.' +
				tree.node(it).value)
		}
	}
	for node in tree.nodes {
		if node.kind != .directive || !node.value.starts_with('@attributes:')
			|| !node.generic_params().any(it == 'attribute' || it.starts_with('attribute:')) {
			continue
		}
		decl := tree.node(flat.NodeId(node.value.all_after(':').int()))
		if decl.kind != .struct_decl {
			continue
		}
		mut fields := []ExportAttributeField{}
		for child in tree.children_of(decl) {
			field := tree.node(child)
			if field.kind != .field_decl {
				continue
			}
			if field.typ_text() !in ['string', 'bool'] && field.typ_text() !in enums {
				return error('unsupported attribute schema field type ${decl.value}.${field.value}: ${field.typ_text()}')
			}
			fields << ExportAttributeField{field.value, field.typ_text() == 'bool', enums[field.typ_text()]}
		}
		schemas['vphp.${decl.value}'] = fields
	}
}

fn bind_export_attribute_args(attrs []Attr, raw []string, schemas map[string][]ExportAttributeField) ![]Attr {
	mut bound_attrs := []Attr{cap: attrs.len}
	mut i := 0
	for i < attrs.len {
		base := attrs[i]
		fields := schemas[base.name] or {
			bound_attrs << base
			i++
			continue
		}
		mut args := map[string]string{}
		prefix := base.name + '_'
		names := fields.map(it.name)
		mut bound := []bool{len: fields.len}
		for first := i; i < attrs.len && (i == first || attrs[i].name.starts_with(prefix)); {
			entry := attrs[i]
			spelling := raw[i].all_after(':').trim_space()
			i++
			if !entry.has_arg {
				continue
			}
			suffix := entry.name.all_after(prefix)
			position := if entry.name == base.name {
				0
			} else if suffix.len > 0 && suffix.bytes().all(it.is_digit()) {
				strconv.atoi(suffix) or { fields.len }
			} else {
				names.index(suffix)
			}
			if position < 0 {
				return error('unknown field `${suffix}` in attribute `${base.name}`')
			}
			if position >= fields.len {
				return error('attribute `${base.name}` expects at most ${fields.len} positional arguments')
			}
			field := fields[position]
			if bound[position] {
				return error('duplicate field `${field.name}` in attribute `${base.name}`')
			}
			name := base.name + '.' + field.name
			value := if field.enum_values.len > 0 {
				if spelling !in field.enum_values {
					return error('${name} expects an enum value: ${field.enum_values.join(', ')}')
				}
				spelling[1..]
			} else if field.is_bool {
				if spelling !in ['true', 'false'] {
					return error('${name} must be a V boolean literal')
				}
				spelling
			} else {
				parse_string_attr_literal(spelling) or { return error('${name} must be a V string literal') }
			}
			args[field.name] = value
			bound[position] = true
		}
		for position, field in fields {
			if !bound[position] && base.name != 'vphp.PhpExportConstant' {
				return error('attribute `${base.name}` is missing field `${field.name}`')
			}
		}
		bound_attrs << Attr{ name: base.name, args: args }
	}
	return bound_attrs
}

// The flat AST expands call arguments. Check the source spelling before
// folding those entries, while call syntax and standalone names are distinct.
fn validate_attribute_spelling(source string, imports map[string]string, schemas map[string][]ExportAttributeField) ! {
	if !source.contains('@[') {
		return
	}
	mut scanner_ := scanner.new_scanner(pref.new_preferences(), .skip_interpolation)
	mut file_set := token.FileSet{}
	file := file_set.add_file('attributes.v', source.len)
	scanner_.init(file, source)
	for {
		match scanner_.scan() {
			.eof { return }
			.attribute { validate_attribute_group(mut scanner_, imports, schemas)! }
			else {}
		}
	}
}

fn validate_attribute_group(mut lex scanner.Scanner, imports map[string]string, schemas map[string][]ExportAttributeField) ! {
	mut kind := lex.scan()
	mut parens := 0
	mut at_start := true
	for kind !in [.rsbr, .eof] {
		if at_start && kind == .name {
			module_name := imports[lex.lit] or { lex.lit }
			kind = lex.scan()
			if module_name == 'vphp' && kind == .dot && lex.scan() == .name {
				name := 'vphp.' + lex.lit
				kind = lex.scan()
				if name.contains('_') && name.all_before('_') in schemas {
					return error('use `${name.all_before('_')}(...)` instead of a separate attribute argument')
				}
				if name in schemas && kind == .colon {
					return error('use `${name}(...)` instead of colon syntax')
				}
			}
			at_start = false
			continue
		}
		match kind {
			.lpar { parens++ }
			.rpar { parens-- }
			.semicolon, .comma { at_start = parens == 0 }
			else { at_start = false }
		}
		kind = lex.scan()
	}
}
