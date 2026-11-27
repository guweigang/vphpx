module parser

import compiler.syntax as ast
import compiler.repr
import compiler.php_types

pub fn collect_external_interfaces(stmts []ast.Stmt) !map[string]string {
	mut interfaces := map[string]string{}
	for stmt in stmts {
		if stmt !is ast.InterfaceDecl {
			continue
		}
		decl := stmt as ast.InterfaceDecl
		marker := ast.find_attr(decl.attrs, 'vphp.PhpExternalInterface') or { continue }
		if decl.attrs.any(it.name == 'php_ignore') {
			continue
		}
		key := qualified_v_type(decl.module_name, decl.name)
		if decl.attrs.any(it.name == 'php_interface') || key in interfaces {
			return error('V interface ${key} has conflicting PHP declarations')
		}
		name := php_types.class_lookup_name(marker.args['name'].trim_space())
		if !name.split('\\').all(interface_export_identifier(it)) {
			return error('V interface ${key}: PhpExternalInterface requires a valid PHP interface name')
		}
		interfaces[key] = name
	}
	return interfaces
}

pub fn parse_interface_decl(stmt ast.Stmt, table &ast.Table) ?&repr.PhpInterfaceRepr {
	if stmt !is ast.InterfaceDecl {
		return none
	}
	interface_decl := stmt as ast.InterfaceDecl
	if interface_decl.attrs.any(it.name == 'php_ignore') {
		return none
	}
	mut iface := repr.new_interface_repr()
	if !interface_decl.attrs.any(it.name == 'php_interface') {
		return none
	}

	iface.name = interface_decl.name.all_after_last('.')
	iface.module_name = interface_decl.module_name
	iface.extends_v = interface_decl.embeds.clone()
	iface.attributes = parse_php_type_attributes(interface_decl.attrs, 'vphp.PhpInterfaceAttribute')
	iface.constant_source = ast.find_attr_arg(interface_decl.attrs, 'vphp.PhpInterfaceConstants',
		'source')
	if attr := ast.find_attr(interface_decl.attrs, 'php_interface') {
		iface.php_name = if attr.arg != '' { attr.arg } else { iface.name }
	} else {
		iface.php_name = iface.name
	}
	for attr in interface_decl.attrs {
		if attr.name == 'php_extends' {
			iface.extends_attr << parse_attr_list(attr.arg)
		}
	}

	for method in interface_decl.methods {
		mut args := []repr.PhpArgRepr{}
		mut names := method.params.map(it.name)
		for i, param in method.params {
			param_type := strip_module(table.type_to_str(param.typ))
			mut name := param.name
			if name == '' {
				name = 'arg${i + 1}'
				for (name in names) {
					name += '_'
				}
				names << name
			}
			args << repr.PhpArgRepr{
				name:        name
				v_type:      param_type
				is_variadic: method.is_variadic && i == method.params.len - 1
				source:      repr.PhpArgSource{
					kind:        .direct
					direct_name: param.name
				}
			}
		}
		iface.methods << repr.PhpMethodRepr{
			name:        method.name
			v_name:      method.name
			v_c_func:    ''
			is_static:   false
			return_spec: repr.new_return_repr(strip_module(table.type_to_str(method.return_type)), '')
			args:        args
			has_export:  false
			visibility:  'public'
			is_abstract: true
		}
	}
	return iface
}

fn bind_interface_static_methods(mut iface repr.PhpInterfaceRepr, attrs []ast.Attr) ! {
	names := ast.find_attr_arg(attrs, 'vphp.PhpInterfaceStaticMethods', 'names') or { return }
	declared := parse_attr_list(names)
	if declared.len == 0 {
		return error('PHP interface ${iface.php_name}: PhpInterfaceStaticMethods requires at least one method')
	}
	methods := iface.methods.map(it.v_name)
	for name in declared {
		i := methods.index(name)
		if i < 0 {
			return error('PHP interface ${iface.php_name}::${name}: unknown static method')
		}
		if iface.methods[i].is_static {
			return error('PHP interface ${iface.php_name}::${name}: duplicate static declaration')
		}
		if iface.methods[i].is_constructor() {
			return error('PHP interface ${iface.php_name}::${name}: a constructor cannot be static')
		}
		iface.methods[i].is_static = true
	}
}

fn bind_interface_params(mut iface repr.PhpInterfaceRepr, params_structs map[string]repr.PhpParamsStruct) {
	for mut method in iface.methods {
		if method.args.len == 0 || method.args.last().is_variadic {
			continue
		}
		last := method.args.last()
		if params_struct := params_structs[repr.params_struct_key(iface.module_name, last.v_type)] {
			method.args.pop()
			method.args << flatten_params_fields(last.source.direct_name, params_struct)
		}
	}
}
