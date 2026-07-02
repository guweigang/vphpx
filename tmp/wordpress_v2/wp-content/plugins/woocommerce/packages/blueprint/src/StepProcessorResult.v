import rt

pub fn Class_Automattic_WooCommerce_Blueprint_StepProcessorResult.message_types() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'error' }, rt.ArrayItem{ key: none, val: 'info' }, rt.ArrayItem{ key: none, val: 'debug' }, rt.ArrayItem{ key: none, val: 'warn' }])
}
struct Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	rt.PhpObjectBase
pub mut:
		messages rt.PhpVal = rt.new_array()
		success bool
		step_name string
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) construct(success bool, step_name string) {
	this.success = success
	this.step_name = step_name
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) set_step_name(var_step_name rt.PhpVal) {
	this.step_name = (var_step_name).str()
}

fn Class_Automattic_WooCommerce_Blueprint_StepProcessorResult.success(stp_name string) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Blueprint_self', []string{}, create_automattic_woocommerce_blueprint_self(rt.new_bool(true), rt.new_string(stp_name)))
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) add_message(message string, type string) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(type), Class_Automattic_WooCommerce_Blueprint_Automattic_WooCommerce_Blueprint_StepProcessorResult.message_types(), rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception("${var_type} is not allowed. Type must be one of " + (rt.call_function('implode', [rt.new_string(','), Class_Automattic_WooCommerce_Blueprint_Automattic_WooCommerce_Blueprint_StepProcessorResult.message_types()])).str())))
	}
	this.messages.array_push(rt.call_function('compact', [rt.new_string('message'), rt.new_string('type')]))
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) merge_messages(mut var_other Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) {
	this.messages = rt.call_function('array_merge', [this.messages, var_other.get_messages('')])
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) add_error(message string) {
	this.add_message(message, '')
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) add_debug(message string) {
	this.add_message(message, 'debug')
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) add_info(message string) {
	this.add_message(message, 'info')
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) add_warn(message string) {
	this.add_message(message, 'warn')
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) get_messages(type string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('all'), rt.new_string(type))) {
		return this.messages
	}
	closure_1_fn := fn [var_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_message := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.new_string(type), rt.new_string((var_message).str()).array_get(rt.new_string('type')))
		}
	return rt.call_function('array_filter', [this.messages, rt.new_closure(closure_1_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) is_success() bool {
	return rt.is_true(rt.identical(rt.new_bool(true), this.success)) && 0 == this.get_messages('error').array_count()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) get_step_name() string {
	return this.step_name
}

struct Class_Automattic_WooCommerce_Blueprint_self {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_stepprocessorresult(success bool, step_name string) &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{
		PhpObjectBase: rt.PhpObjectBase{}
		messages: rt.new_array()
		success: false
		step_name: ''
	}
	obj.construct(success, step_name)
	return obj
}

fn create_automattic_woocommerce_blueprint_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_self {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_step_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_step_name(dispatch_arg_0)
			return rt.new_null()
		}
		'success' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Blueprint_StepProcessorResult.success(dispatch_arg_0)
		}
		'add_message' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.add_message(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'merge_messages' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_StepProcessorResult](if args.len > 0 { args[0] } else { rt.new_null() })
			this.merge_messages(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.add_error(dispatch_arg_0)
			return rt.new_null()
		}
		'add_debug' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.add_debug(dispatch_arg_0)
			return rt.new_null()
		}
		'add_info' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.add_info(dispatch_arg_0)
			return rt.new_null()
		}
		'add_warn' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.add_warn(dispatch_arg_0)
			return rt.new_null()
		}
		'get_messages' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_messages(dispatch_arg_0)
		}
		'is_success' {
			return rt.new_bool(this.is_success())
		}
		'get_step_name' {
			return rt.new_string(this.get_step_name())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'messages' { return this.messages }
		'success' { return rt.new_bool(this.success) }
		'step_name' { return rt.new_string(this.step_name) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'messages' { this.messages = val; return true }
		'success' { this.success = (val).to_bool(); return true }
		'step_name' { this.step_name = (val).str(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
