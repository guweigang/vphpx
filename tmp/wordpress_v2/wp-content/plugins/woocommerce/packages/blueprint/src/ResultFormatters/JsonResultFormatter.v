import rt

struct Class_Automattic_WooCommerce_Blueprint_ResultFormatters_JsonResultFormatter {
	rt.PhpObjectBase
pub mut:
	results rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResultFormatters_JsonResultFormatter) construct(mut var_results Class_Automattic_WooCommerce_Blueprint_ResultFormatters_array) {
	this.results = var_results
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResultFormatters_JsonResultFormatter) format(message_type string) rt.PhpVal {
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'is_success', val: this.is_success() },
		rt.ArrayItem{ key: 'messages', val: rt.new_array() },
	])
	mut iter_1 := this.results.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_result := item_1.val
		mut var_step_name := rt.call_method(var_result, 'get_step_name', []rt.PhpVal{})
		mut iter_2 := rt.call_method(var_result, 'get_messages', [
			rt.new_string(message_type),
		]).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_message := item_2.val
			if !(var_data.array_get(rt.new_string('messages')).array_isset(var_message.array_get(rt.new_string('type')))) {
				var_data.array_get_mut('messages').array_set(var_message.array_get(rt.new_string('type')),
					rt.new_array())
			}
			var_data.array_get_mut('messages').array_get_mut(var_message.array_get(rt.new_string('type'))).array_push(rt.create_array([
				rt.ArrayItem{ key: 'step', val: var_step_name },
				rt.ArrayItem{ key: 'type', val: var_message.array_get(rt.new_string('type')) },
				rt.ArrayItem{ key: 'message', val: var_message.array_get(rt.new_string('message')) },
			]))
		}
	}
	return var_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResultFormatters_JsonResultFormatter) is_success() bool {
	mut iter_3 := this.results.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_result := item_3.val
		mut var_is_success := rt.call_method(var_result, 'is_success', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_success)))) {
			return false
		}
	}
	return true
}

fn create_automattic_woocommerce_blueprint_resultformatters_jsonresultformatter(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_ResultFormatters_JsonResultFormatter {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ResultFormatters_JsonResultFormatter{
		PhpObjectBase: rt.PhpObjectBase{}
		results:       rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResultFormatters_JsonResultFormatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_ResultFormatters_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'format' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.format(dispatch_arg_0)
		}
		'is_success' {
			return rt.new_bool(this.is_success())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ResultFormatters_JsonResultFormatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'results' { return this.results }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResultFormatters_JsonResultFormatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'results' {
			this.results = val
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
