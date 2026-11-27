module parser

import compiler.syntax as ast
import compiler.repr

pub fn parse_enum_decl(stmt ast.Stmt, table &ast.Table) ?&repr.PhpEnumRepr {
	if stmt !is ast.EnumDecl {
		return none
	}
	enum_decl := stmt as ast.EnumDecl
	if enum_decl.attrs.any(it.name == 'php_ignore') {
		return none
	}
	mut enum_repr := repr.new_enum_repr()
	if !enum_decl.attrs.any(it.name == 'php_enum') {
		return none
	}

	enum_repr.name = enum_decl.name.all_after_last('.')
	enum_repr.unsigned_backing = enum_decl.backing_type in ['u8', 'u16', 'u32', 'u64', 'uint',
		'usize']
	enum_repr.attributes = parse_php_type_attributes(enum_decl.attrs, 'vphp.PhpEnumAttribute')
	enum_repr.constant_source = ast.find_attr_arg(enum_decl.attrs, 'vphp.PhpEnumConstants', 'source')
	if attr := ast.find_attr(enum_decl.attrs, 'php_enum') {
		enum_repr.php_name = if attr.arg != '' { attr.arg } else { enum_repr.name }
	} else {
		enum_repr.php_name = enum_repr.name
	}

	for attr in enum_decl.attrs {
		if attr.name == 'vphp.PhpEnumImplements' {
			enum_repr.interfaces << parse_attr_list(attr.args['names'])
		}
	}

	has_php_values := enum_decl.fields.any(ast.find_attr_arg(it.attrs, 'vphp.PhpEnumCaseValue',
		'value') != none)
	is_unit := enum_decl.attrs.any(it.name == 'vphp.PhpUnitEnum')
	if is_unit && has_php_values {
		enum_repr.parse_err = 'PHP unit enum ${enum_repr.php_name} cannot declare PhpEnumCaseValue'
		return enum_repr
	}
	enum_repr.backing = if is_unit {
		.unit
	} else if has_php_values {
		.string_
	} else {
		.integer
	}
	mut string_values := map[string]string{}
	for field in enum_decl.fields {
		mut value := ''
		match enum_repr.backing {
			.integer, .unit {}
			.string_ {
				value = ast.find_attr_arg(field.attrs, 'vphp.PhpEnumCaseValue', 'value') or {
					enum_repr.parse_err = 'PHP string-backed enum ${enum_repr.php_name}::${field.name} requires PhpEnumCaseValue'
					return enum_repr
				}
				if previous := string_values[value] {
					enum_repr.parse_err = 'PHP enum ${enum_repr.php_name}::${field.name} duplicates the backing value of ${previous}'
					return enum_repr
				}
				string_values[value] = field.name
			}
		}
		php_name := ast.find_attr_arg(field.attrs, 'vphp.PhpEnumCaseName', 'name') or { field.name }
		enum_repr.cases << repr.PhpEnumCaseRepr{
			v_name:     field.name
			php_name:   php_name
			value:      value
			attributes: parse_typed_php_attributes(field.attrs, 'vphp.PhpEnumCaseAttribute')
		}
	}

	return enum_repr
}
