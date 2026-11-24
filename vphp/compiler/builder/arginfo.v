module builder

import compiler.syntax as ast
import compiler.repr
import compiler.php_types

struct ArgTypeInfo {
	code            string
	mask            string
	mask_obj_class  string
	named_members   []string
	intersections   [][]string
	is_intersection bool
	allow_null      bool
}

fn union_type_info(decl PhpTypeDecl) ?ArgTypeInfo {
	if !decl.clean.contains('|') {
		if decl.allow_null || !decl.clean.contains('&') {
			return none
		}
		return ArgTypeInfo{
			intersections:   [intersection_members(decl.clean)?]
			is_intersection: true
		}
	}
	mut names := []string{}
	mut masks := []string{}
	mut groups := [][]string{}
	mut nullable := decl.allow_null
	for item in decl.clean.split('|') {
		name := item.trim_space().trim_left('\\')
		if name.contains('&') {
			if decl.allow_null || !name.starts_with('(') || !name.ends_with(')') {
				return none
			}
			groups << intersection_members(name[1..name.len - 1])?
		} else if name == 'null' {
			nullable = true
		} else if is_class_literal_type(name) && !name.starts_with('?') {
			if !names.any(it.to_lower() == name.to_lower()) {
				names << name
			}
		} else {
			mask := match name {
				'bool' { 'MAY_BE_BOOL' }
				'true' { 'MAY_BE_TRUE' }
				'false' { 'MAY_BE_FALSE' }
				'int', 'i64' { 'MAY_BE_LONG' }
				'float', 'f64', 'f32' { 'MAY_BE_DOUBLE' }
				'string' { 'MAY_BE_STRING' }
				'array' { 'MAY_BE_ARRAY' }
				'object' { 'MAY_BE_OBJECT' }
				'callable' { 'MAY_BE_CALLABLE' }
				else { return none }
			}
			if mask !in masks {
				masks << mask
			}
		}
	}
	if names.len == 0 && masks.len == 0 && groups.len == 0 {
		return none
	}
	if groups.len > 0 {
		if 'MAY_BE_OBJECT' in masks || has_redundant_intersections(names, groups) {
			return none
		}
	}
	return ArgTypeInfo{
		mask:          masks.join('|')
		named_members: names
		intersections: groups
		allow_null:    nullable
	}
}

fn has_redundant_intersections(names []string, groups [][]string) bool {
	for i, group in groups {
		keys := group.map(it.to_lower())
		if names.any(it.to_lower() in keys) {
			return true
		}
		for previous in groups[..i] {
			prior_keys := previous.map(it.to_lower())
			if keys.all(it in prior_keys) || prior_keys.all(it in keys) {
				return true
			}
		}
	}
	return false
}

fn intersection_members(raw string) ?[]string {
	mut members := []string{}
	for atom in raw.split('&') {
		name := atom.trim_space().trim_left('\\')
		if !is_class_literal_type(name) || name.starts_with('?')
			|| name.to_lower() in ['self', 'parent']
			|| members.any(it.to_lower() == name.to_lower()) {
			return none
		}
		members << name
	}
	return if members.len > 1 { members } else { none }
}

fn (info ArgTypeInfo) render_mask(by_ref string, variadic string) string {
	mut mask := []string{}
	if info.mask != '' {
		mask << info.mask
	}
	if info.allow_null {
		mask << 'MAY_BE_NULL'
	}
	mask << '_ZEND_ARG_INFO_FLAGS(${by_ref}, ${variadic}, 0)'
	return mask.join(' | ')
}

fn (info ArgTypeInfo) render_named_union(by_ref string, variadic string) string {
	// Zend splits the literal class-name list when registering internal arginfo.
	names := c_string_escape(info.named_members.join('|'))
	return 'ZEND_TYPE_INIT_CLASS_CONST_MASK("${names}", ${info.render_mask(by_ref, variadic)})'
}

fn (info ArgTypeInfo) compound_setup(arginfo string, index int, by_ref string, variadic string) []string {
	if info.intersections.len == 0 {
		return []
	}
	target := '${arginfo}[${index}].type'
	if info.is_intersection {
		members := info.intersections[0].map('vphp_arginfo_class_type("${c_string_escape(it)}")')
		return ['${target} = vphp_arginfo_type_list((zend_type[]){${members.join(', ')}}, ${members.len}, _ZEND_TYPE_INTERSECTION_BIT | ${info.render_mask(by_ref, variadic)});']
	}
	mut members := info.named_members.map('vphp_arginfo_class_type("${c_string_escape(it)}")')
	for group in info.intersections {
		names := group.map('vphp_arginfo_class_type("${c_string_escape(it)}")')
		members << 'vphp_arginfo_type_list((zend_type[]){${names.join(', ')}}, ${names.len}, _ZEND_TYPE_INTERSECTION_BIT)'
	}
	return ['${target} = vphp_arginfo_type_list((zend_type[]){${members.join(', ')}}, ${members.len}, _ZEND_TYPE_UNION_BIT | ${info.render_mask(by_ref, variadic)});']
}

fn validate_php_return_type_or_panic(raw_type string, owner_name string) {
	decl := parse_php_type_decl(raw_type)
	if decl.clean == 'never' && decl.allow_null {
		panic('php_return_type "?never" is invalid for ${owner_name}')
	}
	validate_compound_type_or_panic(decl, 'return type in ${owner_name}')
}

fn validate_php_arg_type_or_panic(raw_type string, arg_name string, owner_name string) {
	decl := parse_php_type_decl(raw_type)
	if decl.clean == 'never' {
		panic('php_arg_type "never" is invalid for parameter ${arg_name} in ${owner_name}')
	}
	validate_compound_type_or_panic(decl, 'parameter ${arg_name} in ${owner_name}')
}

fn validate_compound_type_or_panic(decl PhpTypeDecl, location string) {
	if decl.clean.trim_left('&').contains('&') {
		_ := union_type_info(decl) or {
			panic('invalid intersection or DNF type "${decl.raw}" for ${location}')
		}
	}
}

pub fn validate_interface_signature_type(raw_type string, is_return bool) ! {
	decl := parse_php_type_decl(raw_type)
	if !is_return && decl.clean in ['void', 'never', 'static'] {
		return error('${raw_type} is only valid as a return type')
	}
	if decl.allow_null && (decl.clean.contains_any('|&')
		|| decl.clean in ['mixed', 'void', 'never', 'null']) {
		return error('invalid nullable type ${raw_type}')
	}
	if decl.clean.contains_any('|&') {
		_ := union_type_info(decl) or { return error('invalid compound type ${raw_type}') }
	} else if !is_php_builtin_type(decl.clean) && !is_class_literal_type(decl.clean) {
		return error('invalid type ${raw_type}')
	}
}

fn render_class_type_init_literal(raw_type string, by_ref string) string {
	mut php_type := raw_type
	mut allow_null := '0'
	if php_type.starts_with('?') {
		php_type = php_type[1..]
		allow_null = '1'
	}
	escaped := c_string_escape(php_types.normalize_php_type_literal(php_type))
	return 'ZEND_TYPE_INIT_CLASS_CONST("${escaped}", ${allow_null}, _ZEND_ARG_INFO_FLAGS(${by_ref}, 0, 0))'
}

fn render_array_arginfo_header(c_func string, required_args int, resolved_return_type string, return_obj_type string, type_info ArgTypeInfo, by_ref string, mutable bool) string {
	storage := if mutable { 'static' } else { 'static const' }
	header := '${storage} zend_internal_arg_info arginfo_${c_func}[] = {\n    { (const char*)(uintptr_t)(${required_args}), '
	if type_info.intersections.len > 0 {
		return header + 'ZEND_TYPE_INIT_MASK(MAY_BE_ANY | _ZEND_ARG_INFO_FLAGS(${by_ref}, 0, 0)), NULL },'
	}
	if type_info.named_members.len > 0 {
		return header + '${type_info.render_named_union(by_ref, '0')}, NULL },'
	}
	if type_info.mask == '' && is_class_literal_type(resolved_return_type) {
		return header + '${render_class_type_init_literal(resolved_return_type, by_ref)}, NULL },'
	}
	if return_obj_type != '' {
		escaped := c_string_escape(php_types.normalize_php_type_literal(return_obj_type))
		return header + 'ZEND_TYPE_INIT_CLASS_CONST("${escaped}", 0, _ZEND_ARG_INFO_FLAGS(${by_ref}, 0, 0)), NULL },'
	}
	if type_info.mask_obj_class != '' {
		mut mask := type_info.mask
		if type_info.allow_null {
			mask += '|MAY_BE_NULL'
		}
		return header + 'ZEND_TYPE_INIT_CLASS_CONST_MASK("${type_info.mask_obj_class}", ${mask} | _ZEND_ARG_INFO_FLAGS(${by_ref}, 0, 0)), NULL },'
	}
	if type_info.mask != '' {
		mut mask := type_info.mask
		if type_info.allow_null {
			mask += '|MAY_BE_NULL'
		}
		return header + 'ZEND_TYPE_INIT_MASK(${mask} | _ZEND_ARG_INFO_FLAGS(${by_ref}, 0, 0)), NULL },'
	}
	if type_info.code != '' && type_info.code != 'IS_CALLABLE' {
		allow_null := if type_info.allow_null { '1' } else { '0' }
		return header + 'ZEND_TYPE_INIT_CODE(${type_info.code}, ${allow_null}, _ZEND_ARG_INFO_FLAGS(${by_ref}, 0, 0)), NULL },'
	}
	return header + 'ZEND_TYPE_INIT_NONE(_ZEND_ARG_INFO_FLAGS(${by_ref}, 0, 0)), NULL },'
}

fn render_standard_arginfo_header(c_func string, required_args int, resolved_return_type string, return_obj_type string, type_info ArgTypeInfo, by_ref string) string {
	if type_info.named_members.len > 0
		|| (type_info.mask == '' && is_class_literal_type(resolved_return_type)) {
		return render_array_arginfo_header(c_func, required_args, resolved_return_type,
			return_obj_type, type_info, by_ref, false)
	}
	if return_obj_type != '' {
		if return_obj_type.contains('\\') {
			return render_array_arginfo_header(c_func, required_args, resolved_return_type,
				return_obj_type, type_info, by_ref, false)
		}
		return 'ZEND_BEGIN_ARG_WITH_RETURN_OBJ_INFO_EX(arginfo_${c_func}, ${by_ref}, ${required_args}, ${return_obj_type}, 0)'
	}
	if type_info.mask_obj_class != '' {
		mut mask := type_info.mask
		if type_info.allow_null {
			mask += '|MAY_BE_NULL'
		}
		return 'ZEND_BEGIN_ARG_WITH_TENTATIVE_RETURN_OBJ_TYPE_MASK_EX(arginfo_${c_func}, ${by_ref}, ${required_args}, ${type_info.mask_obj_class}, ${mask})'
	}
	if type_info.mask != '' {
		mut mask := type_info.mask
		if type_info.allow_null {
			mask += '|MAY_BE_NULL'
		}
		return 'ZEND_BEGIN_ARG_WITH_RETURN_TYPE_MASK_EX(arginfo_${c_func}, ${by_ref}, ${required_args}, ${mask})'
	}
	if type_info.code != '' && type_info.code != 'IS_CALLABLE' {
		allow_null := if type_info.allow_null { '1' } else { '0' }
		return 'ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_${c_func}, ${by_ref}, ${required_args}, ${type_info.code}, ${allow_null})'
	}
	return 'ZEND_BEGIN_ARG_INFO_EX(arginfo_${c_func}, 0, ${by_ref}, ${required_args})'
}

fn render_method_arginfo_header(c_func string, php_name string, required_args int, resolved_return_type string, return_obj_type string, type_info ArgTypeInfo, by_ref string, force_array bool, mutable bool) string {
	validate_php_return_type_or_panic(resolved_return_type, php_name)
	if php_name == '__toString' {
		return 'ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_${c_func}, ${by_ref}, 0, IS_STRING, 0)'
	}
	if force_array || mutable {
		return render_array_arginfo_header(c_func, required_args, resolved_return_type,
			return_obj_type, type_info, by_ref, mutable)
	}
	return render_standard_arginfo_header(c_func, required_args, resolved_return_type,
		return_obj_type, type_info, by_ref)
}

fn render_context_arginfo(c_func string, php_name string, spec ReturnSpec, table &ast.Table) string {
	mut header := 'ZEND_BEGIN_ARG_INFO_EX(arginfo_${c_func}, 0, 0, 0)'
	if spec.has_context_object_return() {
		return_type := spec.resolved_type()
		validate_php_return_type_or_panic(return_type, php_name)
		info := arg_type_info(return_type, table)
		header = if info.intersections.len > 0 {
			render_array_arginfo_header(c_func, 0, return_type, spec.arginfo_obj_type(), info, '0', true)
		} else {
			render_standard_arginfo_header(c_func, 0, return_type, spec.arginfo_obj_type(), info, '0')
		}
	}
	return header + '\nZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)\nZEND_END_ARG_INFO()'
}

fn render_php_default_value_literal(default_value string) string {
	if default_value == '' {
		return 'NULL'
	}
	return '"${c_string_escape(default_value)}"'
}

fn required_arg_count(args []ClassMethodArg) int {
	mut required := args.len
	for required > 0 && (args[required - 1].is_optional || args[required - 1].is_variadic) {
		required--
	}
	return required
}

pub fn render_closure_arginfo(name string, fields []repr.PhpParamsField, required int, computed_defaults map[int]string, variadic_arg_type string, variadic_arg_name string, php_variadic_type string, returns_reference bool, php_return string, v_return string, table &ast.Table) (string, []string) {
	mut setup := []string{}
	named_return := closure_named_type(php_return, v_return.trim_string_left('!'))
	named_variadic := closure_named_type(php_variadic_type, variadic_arg_type)
	named_fields := fields.map(closure_named_type(it.php_named_type, it.v_type))
	storage := if named_return.name != '' || named_variadic.name != '' || named_fields.any(it.name != '') {
		'static'
	} else {
		'static const'
	}
	return_type := closure_return_arginfo(v_return, returns_reference, table)
	mut lines := [
		'${storage} zend_internal_arg_info ${name}_storage[] = {',
		'{ (const char *)(uintptr_t)(${required}), ${return_type}, NULL },',
	]
	if named_return.name != '' {
		setup << closure_class_arginfo_setup('${name}_storage[0].type', named_return)
	}
	for i, field in fields {
		default_value := if i >= required {
			computed_defaults[i] or { field.php_default }
		} else {
			''
		}
		by_ref := php_types.is_reference_parameter(field.v_type, false)
		if named_fields[i].name != '' {
			setup << closure_class_arginfo_setup('${name}_storage[${i + 1}].type',
				named_fields[i])
		}
		lines << render_arginfo_arg_line(field.name, if by_ref { 'mixed' } else { field.v_type },
			default_value, false, if by_ref { '1' } else { '0' }, table)
	}
	if variadic_arg_type != '' {
		by_ref := if php_types.is_reference_parameter(variadic_arg_type, true) { '1' } else { '0' }
		typ := if variadic_arg_type in ['int', 'i64', 'string', 'bool', 'f32', 'f64'] {
			variadic_arg_type
		} else {
			'mixed'
		}
		lines << render_arginfo_arg_line(variadic_arg_name, typ, '', true, by_ref, table)
		if named_variadic.name != '' {
			target := '${name}_storage[${fields.len + 1}].type'
			setup << closure_class_arginfo_setup(target, named_variadic)
			setup << '${target}.type_mask |= _ZEND_ARG_INFO_FLAGS(0, 1, 0);'
		}
	}
	lines << 'ZEND_END_ARG_INFO()'
	lines << 'void *${name} = (void *)${name}_storage;'
	return lines.join('\n'), setup
}

struct ClosureNamedType {
	name       string
	extra_mask string
}

fn closure_named_type(explicit string, v_type string) ClosureNamedType {
	if explicit != '' {
		return ClosureNamedType{ name: explicit }
	}
	spec := php_types.PhpTypeSpec.from_v_type(v_type) or { return ClosureNamedType{} }
	if spec.php_class == '' {
		return ClosureNamedType{}
	}
	return ClosureNamedType{
		name:       if v_type.starts_with('?') { '?' + spec.php_class } else { spec.php_class }
		extra_mask: spec.php_mask
	}
}

fn closure_return_arginfo(v_return string, returns_reference bool, table &ast.Table) string {
	if returns_reference {
		return 'ZEND_TYPE_INIT_CODE(IS_MIXED, 0, _ZEND_ARG_INFO_FLAGS(1, 0, 0))'
	}
	info := arg_type_info(v_return.trim_string_left('!'), table)
	if info.code != '' && info.code != 'IS_CALLABLE' && !(info.allow_null && info.code == 'IS_VOID') {
		nullable := if info.allow_null && info.code != 'IS_MIXED' { 1 } else { 0 }
		return 'ZEND_TYPE_INIT_CODE(${info.code}, ${nullable}, 0)'
	}
	return 'ZEND_TYPE_INIT_NONE(0)'
}

fn closure_class_arginfo_setup(target string, php_type ClosureNamedType) []string {
	class_name := c_string_escape(php_types.class_lookup_name(php_type.name.trim_left('?')))
	// Zend's closure factory consumes runtime arginfo directly.
	mut setup := ['${target} = vphp_arginfo_class_type("${class_name}");']
	if php_type.extra_mask != '' {
		setup << '${target}.type_mask |= ${php_type.extra_mask};'
	}
	if php_type.name.starts_with('?') {
		setup << '${target}.type_mask |= MAY_BE_NULL;'
	}
	return setup
}

fn (arg ClassMethodArg) arginfo_type() string {
	if arg.php_type != '' {
		return arg.php_type
	}
	if php_types.is_reference_parameter(arg.type_, arg.is_variadic) {
		return 'mixed'
	}
	return arg.type_
}

fn compound_arginfo_setup(arginfo string, spec ReturnSpec, args []ClassMethodArg, table &ast.Table) []string {
	mut lines := arg_type_info(spec.resolved_type(), table).compound_setup(arginfo, 0, spec.arginfo_return_reference(), '0')
	for i, arg in args {
		by_ref := if php_types.is_reference_parameter(arg.type_, arg.is_variadic) {
			'1'
		} else {
			'0'
		}
		variadic := if arg.is_variadic { '1' } else { '0' }
		lines << arg_type_info(arg.arginfo_type(), table).compound_setup(arginfo, i + 1, by_ref, variadic)
	}
	return lines
}

fn registered_compound_arginfo_setup(php_name string, function_table string, spec ReturnSpec, args []ClassMethodArg, table &ast.Table) []string {
	setup := compound_arginfo_setup('(registered->common.arg_info - 1)', spec, args, table)
	if setup.len == 0 {
		return []
	}
	name := c_string_literal_bytes(php_name)
	mut lines := [
		'{',
		'    zend_function *registered = zend_hash_str_find_ptr_lc(${function_table}, "${name}", sizeof("${name}")-1);',
		'    if (!registered || !registered->common.arg_info) { return FAILURE; }',
	]
	lines << setup.map('    ' + it)
	lines << '}'
	return lines
}

fn (arg ClassMethodArg) render_arginfo_line(owner_name string, table &ast.Table) string {
	by_ref := php_types.is_reference_parameter(arg.type_, arg.is_variadic)
	raw_type := arg.arginfo_type()
	validate_php_arg_type_or_panic(raw_type, arg.name, owner_name)
	return render_arginfo_arg_line(arg.name, raw_type, arg.php_default, arg.is_variadic,
		if by_ref { '1' } else { '0' }, table)
}

fn variadic_element_type(raw_type string, is_variadic bool) string {
	return if is_variadic && raw_type.starts_with('[]') { raw_type[2..] } else { raw_type }
}

fn render_arginfo_arg_line(arg_name string, raw_type string, default_value string, is_variadic bool, by_ref string, table &ast.Table) string {
	actual_type := variadic_element_type(raw_type, is_variadic)
	arg_info := arg_type_info(actual_type, table)
	default_literal := render_php_default_value_literal(default_value)
	if arg_info.intersections.len > 0 {
		return '{ "${arg_name}", ZEND_TYPE_INIT_MASK(MAY_BE_ANY | _ZEND_ARG_INFO_FLAGS(${by_ref}, ${if is_variadic {
			'1'
		} else {
			'0'
		}}, 0)), ${default_literal} },'
	}
	if arg_info.named_members.len > 0 {
		initializer := arg_info.render_named_union(by_ref, if is_variadic { '1' } else { '0' })
		return '{ "${arg_name}", ${initializer}, ${default_literal} },'
	}

	if is_variadic {
		if arg_info.mask == '' && is_class_literal_type(actual_type) {
			mut classname := actual_type
			mut allow_null := '0'
			if classname.starts_with('?') {
				classname = classname[1..]
				allow_null = '1'
			}
			escaped := c_string_escape(php_types.normalize_php_type_literal(classname))
			return 'ZEND_ARG_VARIADIC_OBJ_INFO(${by_ref}, ${arg_name}, ${escaped}, ${allow_null})'
		}
		if arg_info.code == 'IS_CALLABLE' {
			allow_null := if arg_info.allow_null { '1' } else { '0' }
			return '{ "${arg_name}", ZEND_TYPE_INIT_CODE(IS_CALLABLE, ${allow_null}, _ZEND_ARG_INFO_FLAGS(${by_ref}, 1, 0)), NULL },'
		}
		if arg_info.mask_obj_class != '' {
			mut mask := arg_info.mask
			if arg_info.allow_null {
				mask += '|MAY_BE_NULL'
			}
			return 'ZEND_ARG_VARIADIC_OBJ_TYPE_MASK(${by_ref}, ${arg_name}, ${arg_info.mask_obj_class}, ${mask})'
		}
		if arg_info.mask != '' {
			mut mask := arg_info.mask
			if arg_info.allow_null {
				mask += '|MAY_BE_NULL'
			}
			return '{ "${arg_name}", ZEND_TYPE_INIT_MASK(${mask} | _ZEND_ARG_INFO_FLAGS(${by_ref}, 1, 0)), NULL },'
		}
		if arg_info.code != '' {
			allow_null := if arg_info.allow_null { '1' } else { '0' }
			return 'ZEND_ARG_VARIADIC_TYPE_INFO(${by_ref}, ${arg_name}, ${arg_info.code}, ${allow_null})'
		}
		return 'ZEND_ARG_VARIADIC_INFO(${by_ref}, ${arg_name})'
	}

	if arg_info.mask == '' && is_class_literal_type(raw_type) {
		return '{ "${arg_name}", ${render_class_type_init_literal(raw_type, by_ref)}, ${default_literal} },'
	}
	if arg_info.code == 'IS_CALLABLE' {
		allow_null := if arg_info.allow_null { '1' } else { '0' }
		if default_value != '' {
			return '{ "${arg_name}", ZEND_TYPE_INIT_CODE(IS_CALLABLE, ${allow_null}, _ZEND_ARG_INFO_FLAGS(${by_ref}, 0, 0)), ${default_literal} },'
		}
		return 'ZEND_ARG_CALLABLE_INFO(${by_ref}, ${arg_name}, ${allow_null})'
	}
	if arg_info.mask_obj_class != '' {
		mut mask := arg_info.mask
		if arg_info.allow_null {
			mask += '|MAY_BE_NULL'
		}
		return 'ZEND_ARG_OBJ_TYPE_MASK(${by_ref}, ${arg_name}, ${arg_info.mask_obj_class}, ${mask}, ${default_literal})'
	}
	if arg_info.mask != '' {
		mut mask := arg_info.mask
		if arg_info.allow_null {
			mask += '|MAY_BE_NULL'
		}
		return 'ZEND_ARG_TYPE_MASK(${by_ref}, ${arg_name}, ${mask}, ${default_literal})'
	}
	if arg_info.code != '' {
		allow_null := if arg_info.allow_null { '1' } else { '0' }
		if default_value != '' {
			return 'ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(${by_ref}, ${arg_name}, ${arg_info.code}, ${allow_null}, ${default_literal})'
		}
		return 'ZEND_ARG_TYPE_INFO(${by_ref}, ${arg_name}, ${arg_info.code}, ${allow_null})'
	}
	if default_value != '' {
		return 'ZEND_ARG_INFO_WITH_DEFAULT_VALUE(${by_ref}, ${arg_name}, ${default_literal})'
	}
	return 'ZEND_ARG_INFO(${by_ref}, ${arg_name})'
}
