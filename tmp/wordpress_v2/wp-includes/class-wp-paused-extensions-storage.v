import rt

struct Class_WP_Paused_Extensions_Storage {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Paused_Extensions_Storage) construct(var_extension_type rt.PhpVal) {
	this.prop_type = var_extension_type.clone()
}

fn (mut this Class_WP_Paused_Extensions_Storage) set(var_extension rt.PhpVal, var_error rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_api_loaded())))) {
		return false
	}
	mut var_option_name := rt.new_string(this.get_option_name())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_option_name)))) {
		return false
	}
	mut var_paused_extensions := rt.cast_array(rt.call_function('get_option', [
		var_option_name.clone(),
		rt.new_array(),
	]))
	if var_paused_extensions.array_get(this.prop_type).array_isset(var_extension)
		&& rt.is_true(rt.identical(var_paused_extensions.array_get(this.prop_type).array_get(var_extension), var_error)) {
		return true
	}
	var_paused_extensions.array_get_mut(this.prop_type).array_set(var_extension, var_error.clone())
	return (rt.call_function('update_option', [var_option_name.clone(),
		var_paused_extensions.clone(), rt.new_bool(false)])).to_bool()
}

fn (mut this Class_WP_Paused_Extensions_Storage) delete(var_extension rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_api_loaded())))) {
		return false
	}
	mut var_option_name := rt.new_string(this.get_option_name())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_option_name)))) {
		return false
	}
	mut var_paused_extensions := rt.cast_array(rt.call_function('get_option', [
		var_option_name.clone(),
		rt.new_array(),
	]))
	if !(var_paused_extensions.array_get(this.prop_type).array_isset(var_extension)) {
		return true
	}
	var_paused_extensions.array_get(this.prop_type).array_unset(var_extension)
	if !rt.is_true(var_paused_extensions.array_get(this.prop_type)) {
		var_paused_extensions.array_unset(this.prop_type)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_paused_extensions)))) {
		return (rt.call_function('delete_option', [var_option_name.clone()])).to_bool()
	}
	return (rt.call_function('update_option', [var_option_name.clone(),
		var_paused_extensions.clone(), rt.new_bool(false)])).to_bool()
}

fn (mut this Class_WP_Paused_Extensions_Storage) get(var_extension rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_api_loaded())))) {
		return rt.new_null()
	}
	mut var_paused_extensions := this.get_all()
	if !(var_paused_extensions.array_isset(var_extension)) {
		return rt.new_null()
	}
	return var_paused_extensions.array_get(var_extension)
}

fn (mut this Class_WP_Paused_Extensions_Storage) get_all() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_api_loaded())))) {
		return rt.new_array()
	}
	mut var_option_name := rt.new_string(this.get_option_name())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_option_name)))) {
		return rt.new_array()
	}
	mut var_paused_extensions := rt.cast_array(rt.call_function('get_option', [
		var_option_name.clone(),
		rt.new_array(),
	]))
	return if !(var_paused_extensions.array_get(this.prop_type)).is_null() {
		var_paused_extensions.array_get(this.prop_type)
	} else {
		rt.new_array()
	}
}

fn (mut this Class_WP_Paused_Extensions_Storage) delete_all() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_api_loaded())))) {
		return false
	}
	mut var_option_name := rt.new_string(this.get_option_name())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_option_name)))) {
		return false
	}
	mut var_paused_extensions := rt.cast_array(rt.call_function('get_option', [
		var_option_name.clone(),
		rt.new_array(),
	]))
	var_paused_extensions.array_unset(this.prop_type)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_paused_extensions)))) {
		return (rt.call_function('delete_option', [var_option_name.clone()])).to_bool()
	}
	return (rt.call_function('update_option', [var_option_name.clone(),
		var_paused_extensions.clone(), rt.new_bool(false)])).to_bool()
}

fn (mut this Class_WP_Paused_Extensions_Storage) is_api_loaded() rt.PhpVal {
	return rt.call_function('function_exists', [rt.new_string('get_option')])
}

fn (mut this Class_WP_Paused_Extensions_Storage) get_option_name() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('wp_recovery_mode',
		[]rt.PhpVal{}), 'is_active', []rt.PhpVal{})))))
	{
		return ''
	}
	mut var_session_id := rt.call_method(rt.call_function('wp_recovery_mode', []rt.PhpVal{}),
		'get_session_id', []rt.PhpVal{})
	if !rt.is_true(var_session_id) {
		return ''
	}
	return '${var_session_id.to_string()}_paused_extensions'
}

fn create_wp_paused_extensions_storage(arg_0 rt.PhpVal) &Class_WP_Paused_Extensions_Storage {
	mut obj := &Class_WP_Paused_Extensions_Storage{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_Paused_Extensions_Storage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.set(dispatch_arg_0, dispatch_arg_1))
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete(dispatch_arg_0))
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get(dispatch_arg_0)
		}
		'get_all' {
			return this.get_all()
		}
		'delete_all' {
			return rt.new_bool(this.delete_all())
		}
		'is_api_loaded' {
			return this.is_api_loaded()
		}
		'get_option_name' {
			return rt.new_string(this.get_option_name())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Paused_Extensions_Storage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Paused_Extensions_Storage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
