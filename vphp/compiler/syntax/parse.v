module syntax

import strconv
import v.flat
import v.parser
import v.pref

// Keep the V parser API and flat node layout at the boundary of the generator.
pub fn parse_file(path string, mut table Table) !File {
	if table.export_schemas.len == 0 {
		table.export_schemas = load_export_attribute_schemas()!
	}
	mut prefs := pref.new_preferences()
	prefs.enable_globals = true
	// Read source declarations even in inactive compile-time branches.
	prefs.is_fmt = true
	mut reader := parser.Parser.new(prefs)
	tree := reader.parse_file(path)
	for diagnostic in reader.diagnostics {
		if diagnostic.severity !in ['warning:', 'notice:'] {
			return error('${path}:${diagnostic.line}:${diagnostic.column}: ${diagnostic.message}')
		}
	}
	return decode_file(tree, mut table) or { return error('${path}: ${err.msg()}') }
}

struct Decoder {
	tree           &flat.FlatAst
	attrs          map[int][]Attr
	imports        map[string]string
	export_schemas map[string][]ExportAttributeField
}

fn decode_file(tree &flat.FlatAst, mut table Table) !File {
	mut file_imports := map[int]map[string]string{}
	for id in tree.file_node_ids {
		file := tree.node(flat.NodeId(id))
		if file.children_count > 0 {
			imports := decode_import_aliases(tree, file)
			validate_attribute_spelling(tree.formatter_file_sources[file.pos.id], imports,
				table.export_schemas)!
			file_imports[int(file.pos.id)] = imports
		}
	}
	mut attrs := map[int][]Attr{}
	for node in tree.nodes {
		if node.kind == .directive && node.value.starts_with('@attributes:') {
			id := node.value.all_after(':').int()
			imports := file_imports[int(tree.node(flat.NodeId(id)).pos.id)]
			attrs[id] = decode_source_attrs(node.generic_params(), imports, table.export_schemas)!
		}
	}
	mut module_name := 'main'
	mut stmts := []Stmt{}
	for id in tree.file_node_ids {
		file := tree.node(flat.NodeId(id))
		children := tree.children_of(file)
		d := Decoder{tree, attrs, file_imports[int(file.pos.id)], table.export_schemas}
		for child in children {
			node := tree.node(child)
			match node.kind {
				.module_decl {
					module_name = node.value
				}
				.fn_decl {
					stmts << d.function(child, module_name)
				}
				.struct_decl {
					decl := d.structure(child, module_name)!
					table.register(module_name, decl.name, Symbol{ kind: .struct_, info: Struct{decl.fields} })
					stmts << decl
				}
				.interface_decl {
					mut methods := []FnDecl{}
					mut embeds := []string{}
					for member_id in tree.children_of(node) {
						member := tree.node(member_id)
						if member.op == .dot {
							methods << d.function(member_id, module_name)
						} else if member.kind == .interface_field && member.typ_text() == '' {
							embeds << d.type_name(member.value)
						}
					}
					stmts << InterfaceDecl{
						name:        node.value
						module_name: module_name
						attrs:       attrs[int(child)]
						methods:     methods
						embeds:      embeds
					}
				}
				.enum_decl {
					table.register(module_name, node.value, Symbol{ kind: .enum })
					stmts << EnumDecl{
						name:         node.value
						attrs:        attrs[int(child)]
						fields:       d.enum_fields(node)!
						backing_type: flat.source_type_name(node.enum_backing_type_id())
					}
				}
				.const_decl {
					stmts << ConstDecl{attrs[int(child)], d.value_fields(node), module_name}
				}
				.type_decl {
					if node.children_count > 0 {
						variants := tree.children_of(node).map(d.type_name(tree.node(it).value_text()))
						table.register(module_name, node.value, Symbol{
							kind: .sum_type
							info: SumType{variants}
						})
					} else if node.typ_text() != '' && node.generic_params().len == 0 {
						table.type_aliases['${module_name}.${node.value}'] = d.type_name(node.typ_text())
					}
				}
				else {}
			}
		}
	}
	return File{module_name, stmts}
}

fn decode_import_aliases(tree &flat.FlatAst, file flat.Node) map[string]string {
	mut imports := map[string]string{}
	for child in tree.children_of(file) {
		node := tree.node(child)
		if node.kind == .import_decl {
			alias := node.typ_text()
			module_name_short := node.value.all_after_last('.')
			if alias != '' && alias != module_name_short {
				imports[alias] = module_name_short
			}
		}
	}
	return imports
}

fn decode_source_attrs(raw []string, imports map[string]string, export_schemas map[string][]ExportAttributeField) ![]Attr {
	mut attrs := decode_attrs(raw)
	for index, attr in attrs {
		mut resolved := attr
		if dot := attr.name.index('.') {
			if module_name := imports[attr.name[..dot]] {
				resolved = Attr{ ...resolved, name: module_name + attr.name[dot..] }
			}
		}
		if resolved.has_arg && resolved.name in ['php_function', 'vphp.PhpExportFunction'] {
			if value := parse_string_attr_literal(raw[index].all_after(':').trim_space()) {
				resolved = Attr{ ...resolved, arg: value }
			}
		}
		attrs[index] = resolved
	}
	attrs = bind_export_attribute_args(attrs, raw, export_schemas)!
	normalize_export_attrs(mut attrs)
	return attrs
}

fn normalize_export_attrs(mut attrs []Attr) {
	for index, attr in attrs {
		legacy_name := match attr.name {
			'vphp.PhpExportClass' { 'php_class' }
			'vphp.PhpExportInterface' { 'php_interface' }
			'vphp.PhpExportEnum' { 'php_enum' }
			'vphp.PhpExtends', 'vphp.PhpExtendsInterfaces' { 'php_extends' }
			'vphp.PhpImplements' { 'php_implements' }
			'vphp.PhpProperty' { 'php_prop' }
			'vphp.PhpClassConstants' { 'php_const' }
			'vphp.PhpClassStatics' { 'php_static' }
			'vphp.PhpExportTask' { 'php_task' }
			'vphp.PhpArgNames' { 'php_arg_name' }
			'vphp.PhpArgTypes' { 'php_arg_type' }
			'vphp.PhpArgDefaults' { 'php_arg_default' }
			else { continue }
		}
		field := match legacy_name {
			'php_implements' { 'names' }
			'php_extends' {
				if attr.name == 'vphp.PhpExtendsInterfaces' { 'names' } else { 'name' }
			}
			'php_const', 'php_static' { 'source' }
			'php_arg_name' { 'names' }
			'php_arg_type' { 'types' }
			'php_arg_default' { 'defaults' }
			else { 'name' }
		}
		name := attr.args[field]
		// Type names retain the escaped spelling used by registration and C symbols.
		attrs[index] = Attr{
			name:    legacy_name
			arg:     match legacy_name {
				'php_prop', 'php_const', 'php_static', 'php_arg_name', 'php_arg_type',
				'php_arg_default' {
					name
				}
				'php_task' {
					// Task registration inserts the name into a single-quoted V literal.
					quoted := strconv.quote(name)
					quoted[1..quoted.len - 1].replace("'", r"\'").replace(r'$', r'\$')
				}
				else { name.replace('\\', '\\\\') }
			}
			has_arg: name != ''
		}
	}
}

fn parse_string_attr_literal(spelling string) ?string {
	// Use V's own literal decoding for raw strings, escapes and Unicode.
	mut reader := parser.Parser.new(pref.new_preferences())
	tree := reader.parse_text('vphp_attr.v', 'module main\nfn attr_default() string { return ${spelling} }')
	if reader.diagnostics.any(it.severity !in ['warning:', 'notice:']) {
		return none
	}
	for node in tree.nodes {
		if node.kind == .return_stmt && node.children_count == 1 {
			value := tree.node(tree.child(node, 0))
			if value.kind == .string_literal {
				return value.value
			}
		}
	}
	return none
}

// Glue is emitted in a separate file with its own imports. Qualify types using
// the imported module name so the source file's local aliases don't leak in.
fn (d &Decoder) type_name(spelling string) string {
	if d.imports.len == 0 {
		return spelling
	}
	mut result := []u8{cap: spelling.len}
	mut start := 0
	for i, ch in spelling {
		if ch.is_alnum() || ch == `_` {
			continue
		}
		if ch == `.` && start < i {
			name := spelling[start..i]
			result << (d.imports[name] or { name }).bytes()
		} else {
			result << spelling[start..i].bytes()
		}
		result << ch
		start = i + 1
	}
	result << spelling[start..].bytes()
	return result.bytestr()
}

fn (mut t Table) register(module_name string, name string, sym Symbol) {
	t.symbols[name] = sym
	t.symbols['${module_name}.${name}'] = sym
}

fn decode_attrs(raw []string) []Attr {
	mut result := []Attr{cap: raw.len}
	for text in raw {
		separator := text.index(':') or {
			result << Attr{ name: text }
			continue
		}
		name := text[..separator].trim_space()
		spelling := text[separator + 1..].trim_space()
		arg := if spelling.len >= 2 && spelling[0] in [`'`, `"`]
			&& spelling[0] == spelling[spelling.len - 1] {
			spelling[1..spelling.len - 1]
		} else {
			spelling
		}
		mut call_name := ''
		mut call_arg := ''
		for prefix in ['php_arg_type', 'php_arg_name', 'php_arg_optional', 'php_arg_default',
			'php_param_attr'] {
			if name.starts_with(prefix + '_') {
				call_name = prefix
				call_arg = name[prefix.len + 1..]
				break
			}
		}
		result << Attr{ name: name, arg: arg, call_name: call_name, call_arg_name: call_arg, has_arg: true }
	}
	return result
}

fn (d &Decoder) function(id flat.NodeId, module_name string) FnDecl {
	node := d.tree.node(id)
	mut params := []Param{}
	mut body := []flat.NodeId{}
	mut receiver := Param{}
	mut variadic := false
	for child in d.tree.children_of(node) {
		param := d.tree.node(child)
		if param.kind == .param {
			mut typ := d.type_name(param.typ_text())
			if typ.starts_with('...') {
				variadic = true
				typ = '[]' + typ[3..]
			}
			// The V parser records mut parameters separately from their type.
			if param.is_mut && param.op == .dot && !typ.starts_with('&') {
				typ = '&' + typ
			}
			item := Param{param.value, typ}
			params << item
			if param.op == .dot {
				receiver = item
			}
		} else {
			body << child
		}
	}
	mut name := if receiver.name != '' { node.value.all_after_last('.') } else { node.value }
	is_static := node.is_static_type_method()
	if is_static {
		if typ, method := flat.decode_static_type_method_name(name) {
			name = '${typ}__static__${method}'
		}
	}
	attrs := d.attrs[int(id)]
	return FnDecl{
		name:                  name
		module_name:           module_name
		attrs:                 attrs
		params:                params
		return_type:           d.type_name(node.typ_text())
		receiver:              receiver
		stmts:                 if receiver.name != '' { d.statements(body) } else { []Stmt{} }
		is_method:             receiver.name != ''
		is_static_type_method: is_static
		is_pub:                node.op == .arrow
		is_noreturn:           attrs.any(it.name == 'noreturn')
		is_variadic:           variadic
	}
}

fn (d &Decoder) structure(id flat.NodeId, module_name string) !StructDecl {
	node := d.tree.node(id)
	mut fields := []Field{}
	mut embeds := []Param{}
	mut implements_types := []Param{}
	for part in node.typ_text().split(',') {
		if part.starts_with('implements=') {
			for typ in part.all_after('=').split('|') {
				implements_types << Param{ typ: d.type_name(typ) }
			}
		}
	}
	for child in d.tree.children_of(node) {
		field := d.tree.node(child)
		if field.kind != .field_decl {
			continue
		}
		meta := field.generic_params()
		flags := if meta.len == 0 { '' } else { meta[0] }
		if flags.contains('e') || field.is_embed_payload() {
			embeds << Param{ typ: d.type_name(field.typ_text()) }
			continue
		}
		fields << Field{
			name:             field.value
			typ:              d.type_name(field.typ_text())
			attrs:            if meta.len > 1 {
				decode_source_attrs(meta[1..], d.imports, d.export_schemas)!
			} else {
				[]Attr{}
			}
			comments:         d.field_comments(field)
			is_pub:           flags.contains('p')
			is_mut:           flags.contains('m')
			has_default_expr: field.children_count > 0
			default_expr:     d.expr(d.tree.child(field, 0))
		}
	}
	return StructDecl{
		name:             node.value
		module_name:      module_name
		attrs:            d.attrs[int(id)]
		fields:           fields
		embeds:           embeds
		implements_types: implements_types
		is_implements:    implements_types.len > 0
	}
}

fn (d &Decoder) field_comments(field &flat.Node) []Comment {
	source := d.tree.formatter_file_sources[field.pos.id]
	if source.len == 0 || field.pos.end < 0 || field.pos.end >= source.len {
		return []
	}
	line := source[field.pos.end..].all_before('\n')
	if offset := line.index('//') {
		return [Comment{line[offset + 2..]}]
	}
	return []
}

fn (d &Decoder) value_fields(node &flat.Node) []ValueField {
	mut result := []ValueField{}
	for child in d.tree.children_of(node) {
		field := d.tree.node(child)
		result << ValueField{
			name:     field.value
			expr:     d.expr(d.tree.child(field, 0))
			has_expr: field.children_count > 0
		}
	}
	return result
}

fn (d &Decoder) enum_fields(node &flat.Node) ![]ValueField {
	mut result := []ValueField{}
	for child in d.tree.children_of(node) {
		field := d.tree.node(child)
		if field.kind != .enum_field {
			continue
		}
		result << ValueField{
			name:     field.value
			expr:     d.expr(d.tree.child(field, 0))
			has_expr: field.children_count > 0
			attrs:    decode_source_attrs(field.generic_params(), d.imports, d.export_schemas)!
		}
	}
	return result
}
