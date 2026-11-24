module compiler

import compiler.php_types
import compiler.repr

pub enum RuntimeReturnKind {
	scalar
	void_
	result
	option
	static_factory
	static_object
	instance_object
}

pub struct RuntimeReturnInfo {
pub mut:
	tm        php_types.TypeMap
	kind      RuntimeReturnKind
	class_key string
	owns_vptr string
}

pub fn is_constructor_method(name string) bool {
	return php_method_name(name).to_lower() == '__construct'
}

pub fn php_method_name(name string) string {
	return repr.php_method_name(name)
}

pub fn effective_export_php_return_type(return_type string, php_return_type string, has_export bool) string {
	if php_return_type != '' {
		return php_return_type
	}
	if has_export && (return_type == '' || return_type == 'void') {
		return 'mixed'
	}
	return ''
}

fn base_runtime_return_info(return_type string) RuntimeReturnInfo {
	tm := php_types.TypeMap.get_type(return_type)
	if return_type.starts_with('!') {
		return RuntimeReturnInfo{
			tm:        tm
			kind:      .result
			owns_vptr: 'VPHP_OWNS_VPTR'
		}
	}
	if return_type.starts_with('?') {
		return RuntimeReturnInfo{
			tm:        tm
			kind:      .option
			owns_vptr: 'VPHP_OWNS_VPTR'
		}
	}
	if tm.v_type == 'void' {
		return RuntimeReturnInfo{
			tm:        tm
			kind:      .void_
			owns_vptr: 'VPHP_OWNS_VPTR'
		}
	}
	return RuntimeReturnInfo{
		tm:        tm
		kind:      .scalar
		owns_vptr: 'VPHP_OWNS_VPTR'
	}
}

pub fn method_runtime_return_info(owner_name string, method_name string, is_static bool, return_type string, borrowed_return bool) RuntimeReturnInfo {
	mut info := base_runtime_return_info(return_type)
	owner_key := php_types.normalize_export_type_key(owner_name)
	ret_key := php_types.normalize_export_type_key(return_type)
	if is_constructor_method(method_name) || (is_static && !borrowed_return && ret_key == owner_key
		&& info.kind !in [.option, .result]) {
		info.kind = .static_factory
		info.class_key = owner_key
		return info
	}
	if !return_type.starts_with('&') {
		return info
	}
	info.class_key = ret_key
	if borrowed_return {
		info.owns_vptr = 'VPHP_BORROWS_VPTR'
	}
	if is_static {
		info.kind = .static_object
		return info
	}
	info.kind = .instance_object
	return info
}

fn class_method_runtime_return_info(owner &repr.PhpClassRepr, method &repr.PhpMethodRepr) RuntimeReturnInfo {
	return_type := method.return_spec.effective_v_type()
	if return_type.starts_with('&') && !method.is_constructor()
		&& class_method_uses_context_arg(owner, method) {
		return base_runtime_return_info(return_type)
	}
	if (owner.is_native_trait && method.is_constructor()) || (owner.is_enum && !return_type.starts_with('&')) {
		return base_runtime_return_info(return_type)
	}
	return method_runtime_return_info(owner.name, method.name, method.is_static, return_type,
		method.borrowed_return)
}
