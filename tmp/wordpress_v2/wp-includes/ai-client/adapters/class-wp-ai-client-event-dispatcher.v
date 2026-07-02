import rt

struct Class_WP_AI_Client_Event_Dispatcher {
	rt.PhpObjectBase
}

fn (mut this Class_WP_AI_Client_Event_Dispatcher) dispatch(mut var_event Class_object) rt.PhpVal {
	mut var_event_name := rt.new_string(this.get_hook_name_portion_for_event(mut var_event))
	rt.call_function('do_action', [
		rt.new_string('wp_ai_client_${var_event_name.to_string()}'),
		var_event,
	])
	return rt.new_object('object', []string{}, var_event)
}

fn (mut this Class_WP_AI_Client_Event_Dispatcher) get_hook_name_portion_for_event(mut var_event Class_object) string {
	mut var_class_name := rt.call_function('get_class', [var_event])
	mut var_pos := rt.call_function('strrpos', [var_class_name.clone(),
		rt.new_string('\\')])
	mut var_short_name := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_pos)))) { rt.call_function('substr', [
			var_class_name.clone(),
			rt.add(var_pos, rt.new_int(1)),
		]) } else { var_class_name }
	mut var_snake_case := rt.new_string((rt.call_function('preg_replace', [
		rt.new_string('/([a-z])([A-Z])/'),
		rt.new_string('$1_$2'),
		var_short_name.clone(),
	])).str().to_lower())
	if rt.is_true(rt.call_function('str_ends_with', [var_snake_case.clone(),
		rt.new_string('_event')]))
	{
		var_snake_case = rt.new_string((rt.call_function('substr', [
			var_snake_case.clone(), rt.new_int(0), rt.new_int(-6)])).str())
	}
	return var_snake_case.str()
}

fn create_wp_ai_client_event_dispatcher(_args ...rt.PhpVal) &Class_WP_AI_Client_Event_Dispatcher {
	mut obj := &Class_WP_AI_Client_Event_Dispatcher{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_AI_Client_Event_Dispatcher) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'dispatch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_object](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.dispatch(mut dispatch_arg_0)
		}
		'get_hook_name_portion_for_event' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_object](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_hook_name_portion_for_event(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_AI_Client_Event_Dispatcher) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_AI_Client_Event_Dispatcher) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
