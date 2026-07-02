import rt

struct Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter {
	rt.PhpObjectBase
pub mut:
	results rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter) construct(mut var_results Class_Automattic_WooCommerce_Blueprint_ResultFormatters_array) {
	this.results = var_results
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter) format(message_type string) {
	mut var_header := rt.create_array([rt.ArrayItem{ key: none, val: 'Step Processor' },
		rt.ArrayItem{ key: none, val: 'Type' }, rt.ArrayItem{ key: none, val: 'Message' }])
	mut var_items := rt.new_array()
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
			var_items.array_push(rt.create_array([
				rt.ArrayItem{ key: 'Step Processor', val: var_step_name },
				rt.ArrayItem{ key: 'Type', val: var_message.array_get(rt.new_string('type')) },
				rt.ArrayItem{ key: 'Message', val: var_message.array_get(rt.new_string('message')) },
			]))
		}
	}
	mut var_format_items_exist := rt.call_function('function_exists', [
		rt.new_string('\\WP_CLI\\Utils\\format_items'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_format_items_exist)))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Blueprint_ResultFormatters_Exception',
			[]string{},
			create_automattic_woocommerce_blueprint_resultformatters_exception(rt.new_string('WP CLI Utils not found'))))
	}
	rt.call_function('format_items', [rt.new_string('table'),
		var_items.clone(), var_header.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter) is_success() bool {
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

struct Class_Automattic_WooCommerce_Blueprint_ResultFormatters_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_resultformatters_cliresultformatter(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter{
		PhpObjectBase: rt.PhpObjectBase{}
		results:       rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blueprint_resultformatters_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_ResultFormatters_Exception {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ResultFormatters_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			this.format(dispatch_arg_0)
			return rt.new_null()
		}
		'is_success' {
			return rt.new_bool(this.is_success())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'results' { return this.results }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResultFormatters_CliResultFormatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResultFormatters_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ResultFormatters_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ResultFormatters_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
