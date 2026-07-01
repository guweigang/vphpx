import rt

struct Class_WC_Session {
	rt.PhpObjectBase
pub mut:
	_customer_id rt.PhpVal = rt.new_null()
	_data        rt.PhpVal = rt.new_array()
	_dirty       bool
}

fn (mut this Class_WC_Session) init() {
}

fn (mut this Class_WC_Session) cleanup_sessions() {
}

fn (mut this Class_WC_Session) magic_get(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	return this.get(var_key_mutated.dup(), rt.new_null())
}

fn (mut this Class_WC_Session) magic_set(var_key rt.PhpVal, var_value rt.PhpVal) {
	mut var_key_mutated := var_key
	this.set(var_key_mutated.dup(), var_value.dup())
}

fn (mut this Class_WC_Session) magic_isset(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	return rt.new_bool(this._data.array_isset(rt.call_function('sanitize_key', [
		var_key_mutated.dup()])))
}

fn (mut this Class_WC_Session) magic_unset(var_key rt.PhpVal) {
	mut var_key_mutated := var_key
	var_key_mutated = rt.call_function('sanitize_key', [var_key_mutated.dup()])
	if this._data.array_isset(var_key_mutated) {
		this._data.array_unset(var_key_mutated)
		this._dirty = true
	}
}

fn (mut this Class_WC_Session) get(var_key rt.PhpVal, var_default_value rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	var_key_mutated = rt.call_function('sanitize_key', [var_key_mutated.dup()])
	return if this._data.array_isset(var_key_mutated) { rt.call_function('maybe_unserialize', [
			this._data.array_get(var_key_mutated),
		]) } else { var_default_value }
}

fn (mut this Class_WC_Session) set(var_key rt.PhpVal, var_value rt.PhpVal) {
	mut var_key_mutated := var_key
	if rt.is_true(rt.identical(rt.new_null(), var_value)) {
		this.magic_unset(var_key_mutated.dup())
		return rt.new_null()
	}
	var_key_mutated = rt.call_function('sanitize_key', [var_key_mutated.dup()])
	mut var_serialized_original_value := if !(this._data.array_get(var_key_mutated)).is_null() {
		this._data.array_get(var_key_mutated)
	} else {
		rt.new_null()
	}
	mut var_serialized_value := rt.call_function('maybe_serialize', [
		var_value.dup()])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.identical(var_serialized_original_value, var_serialized_value))
		|| rt.is_true(rt.identical(rt.call_function('maybe_unserialize', [var_serialized_original_value.dup()]), var_value))))
	{
		return rt.new_null()
	}
	this._dirty = true
	this._data.array_set(var_key_mutated, var_serialized_value.dup())
}

fn (mut this Class_WC_Session) get_customer_id() rt.PhpVal {
	return if !(this._customer_id).is_null() { this._customer_id } else { rt.new_string('') }
}

fn create_wc_session() &Class_WC_Session {
	mut obj := &Class_WC_Session{
		PhpObjectBase: rt.PhpObjectBase{}
		_customer_id:  rt.new_null()
		_data:         rt.new_array()
		_dirty:        false
	}
	return obj
}

fn (mut this Class_WC_Session) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'cleanup_sessions' {
			this.cleanup_sessions()
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_isset(dispatch_arg_0)
		}
		'__unset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.magic_unset(dispatch_arg_0)
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get(dispatch_arg_0, dispatch_arg_1)
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_customer_id' {
			return this.get_customer_id()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Session) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'_customer_id' { return this._customer_id }
		'_data' { return this._data }
		'_dirty' { return rt.new_bool(this._dirty) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Session) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'_customer_id' {
			this._customer_id = val
			return true
		}
		'_data' {
			this._data = val
			return true
		}
		'_dirty' {
			this._dirty = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_includes_abstracts_abstract_wc_session_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
