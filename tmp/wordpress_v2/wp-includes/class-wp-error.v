import rt

struct Class_WP_Error {
	rt.PhpObjectBase
pub mut:
	errors          rt.PhpVal = rt.new_array()
	error_data      rt.PhpVal = rt.new_array()
	additional_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Error) construct(code string, message string, data string) {
	mut code_mutated := code
	mut data_mutated := data
	if code_mutated == '' {
		return
	}
	this.add(rt.new_string(code_mutated), rt.new_string(message), data_mutated)
}

fn (mut this Class_WP_Error) get_error_codes() rt.PhpVal {
	if !(this.has_errors()) {
		return rt.new_array()
	}
	return rt.func_array_keys(this.errors)
}

fn (mut this Class_WP_Error) get_error_code() string {
	mut var_codes := this.get_error_codes()
	if !rt.is_true(var_codes) {
		return ''
	}
	return (var_codes.array_get(rt.new_int(0))).str()
}

fn (mut this Class_WP_Error) get_error_messages(code string) rt.PhpVal {
	mut code_mutated := code
	if code_mutated == '' {
		mut var_all_messages := rt.new_array()
		mut iter_1 := rt.cast_array(this.errors).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_messages := item_1.val
			mut var_code_shadow := item_1.key
			var_all_messages = rt.call_function('array_merge', [
				var_all_messages.clone(), var_messages.clone()])
		}
		return var_all_messages.clone()
	}
	if this.errors.array_isset(rt.new_string(code_mutated)) {
		return this.errors.array_get(rt.new_string(code_mutated))
	} else {
		return rt.new_array()
	}
	return rt.new_null()
}

fn (mut this Class_WP_Error) get_error_message(code string) string {
	mut code_mutated := code
	if code_mutated == '' {
		code_mutated = this.get_error_code()
	}
	mut var_messages := this.get_error_messages(code_mutated)
	if !rt.is_true(var_messages) {
		return ''
	}
	return (var_messages.array_get(rt.new_int(0))).str()
}

fn (mut this Class_WP_Error) get_error_data(code string) rt.PhpVal {
	mut code_mutated := code
	if code_mutated == '' {
		code_mutated = this.get_error_code()
	}
	if this.error_data.array_isset(rt.new_string(code_mutated)) {
		return this.error_data.array_get(rt.new_string(code_mutated))
	}
	return rt.new_null()
}

fn (mut this Class_WP_Error) has_errors() bool {
	if !(!rt.is_true(this.errors)) {
		return true
	}
	return false
}

fn (mut this Class_WP_Error) add(var_code rt.PhpVal, var_message rt.PhpVal, data string) {
	mut var_code_mutated := var_code
	mut data_mutated := data
	this.errors.array_get_mut(var_code_mutated).array_push(var_message.clone())
	if !(data_mutated == '') {
		this.add_data(rt.new_string(data_mutated), var_code_mutated.str())
	}
	rt.call_function('do_action', [rt.new_string('wp_error_added'),
		var_code_mutated.clone(), var_message.clone(), rt.new_string(data_mutated).clone(),
		rt.new_object('WP_Error', []string{}, &this)])
}

fn (mut this Class_WP_Error) add_data(var_data rt.PhpVal, code string) {
	mut var_data_mutated := var_data
	mut code_mutated := code
	if code_mutated == '' {
		code_mutated = this.get_error_code()
	}
	if this.error_data.array_isset(rt.new_string(code_mutated)) {
		this.additional_data.array_get_mut(code_mutated).array_push(this.error_data.array_get(rt.new_string(code_mutated)))
	}
	this.error_data.array_set(code_mutated, var_data_mutated.clone())
}

fn (mut this Class_WP_Error) get_all_error_data(code string) rt.PhpVal {
	mut code_mutated := code
	if code_mutated == '' {
		code_mutated = this.get_error_code()
	}
	mut var_data := rt.new_array()
	if this.additional_data.array_isset(rt.new_string(code_mutated)) {
		var_data = this.additional_data.array_get(rt.new_string(code_mutated))
	}
	if this.error_data.array_isset(rt.new_string(code_mutated)) {
		var_data.array_push(this.error_data.array_get(rt.new_string(code_mutated)))
	}
	return var_data.clone()
}

fn (mut this Class_WP_Error) remove(var_code rt.PhpVal) {
	mut var_code_mutated := var_code
	this.errors.array_unset(var_code_mutated)
	this.error_data.array_unset(var_code_mutated)
	this.additional_data.array_unset(var_code_mutated)
}

fn (mut this Class_WP_Error) merge_from(mut var_error Class_WP_Error) {
	Class_WP_Error.copy_errors(mut var_error, mut this)
}

fn (mut this Class_WP_Error) export_to(mut var_error Class_WP_Error) {
	Class_WP_Error.copy_errors(mut this, mut var_error)
}

fn Class_WP_Error.copy_errors(mut var_from Class_WP_Error, mut var_to Class_WP_Error) {
	mut iter_2 := var_from.get_error_codes().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_code := item_2.val
		mut iter_3 := var_from.get_error_messages(var_code.str()).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_error_message := item_3.val
			var_to.add(var_code.clone(), var_error_message.clone(), '')
		}
		mut iter_4 := var_from.get_all_error_data(var_code.str()).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_data := item_4.val
			var_to.add_data(var_data.clone(), var_code.str())
		}
	}
}

fn create_wp_error(code string, message string, data string) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase:   rt.PhpObjectBase{}
		errors:          rt.new_array()
		error_data:      rt.new_array()
		additional_data: rt.new_array()
	}
	obj.construct(code, message, data)
	return obj
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_error_codes' {
			return this.get_error_codes()
		}
		'get_error_code' {
			return rt.new_string(this.get_error_code())
		}
		'get_error_messages' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_error_messages(dispatch_arg_0)
		}
		'get_error_message' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_error_message(dispatch_arg_0))
		}
		'get_error_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_error_data(dispatch_arg_0)
		}
		'has_errors' {
			return rt.new_bool(this.has_errors())
		}
		'add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.add(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'add_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.add_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_all_error_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_all_error_data(dispatch_arg_0)
		}
		'remove' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove(dispatch_arg_0)
			return rt.new_null()
		}
		'merge_from' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Error](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.merge_from(mut dispatch_arg_0)
			return rt.new_null()
		}
		'export_to' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Error](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.export_to(mut dispatch_arg_0)
			return rt.new_null()
		}
		'copy_errors' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Error](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_Error](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			Class_WP_Error.copy_errors(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'errors' { return this.errors }
		'error_data' { return this.error_data }
		'additional_data' { return this.additional_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'errors' {
			this.errors = val
			return true
		}
		'error_data' {
			this.error_data = val
			return true
		}
		'additional_data' {
			this.additional_data = val
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
