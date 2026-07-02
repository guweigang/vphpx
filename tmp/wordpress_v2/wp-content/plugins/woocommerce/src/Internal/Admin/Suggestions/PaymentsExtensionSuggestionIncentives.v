import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives {
	rt.PhpObjectBase
pub mut:
		suggestion_incentives_class_map rt.PhpVal = rt.new_array()
		instances rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives) get_incentive(suggestion_id string, country_code string, incentive_type string, skip_visibility_check bool) rt.PhpVal {
	mut var_incentives := this.get_incentives(suggestion_id, country_code, incentive_type, skip_visibility_check)
	if !rt.is_true(var_incentives) {
		return rt.new_null()
	}
	return rt.call_function('reset', [var_incentives.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives) get_incentives(suggestion_id string, country_code string, incentive_type string, skip_visibility_check bool) rt.PhpVal {
	mut var_incentive := rt.new_null()
	mut var_provider := this.get_incentive_instance(suggestion_id)
	if rt.is_true(rt.identical(rt.new_null(), var_provider)) {
		return rt.new_array()
	}
	mut var_incentives := rt.call_method(var_provider, 'get_all', [rt.new_string(country_code), rt.new_string(incentive_type)])
	if !(var_skip_visibility_check) {
	closure_1_fn := fn [var_provider, var_country_code] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_incentive := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_provider, 'is_visible', [var_incentive.array_get(rt.new_string('id')), rt.new_string(country_code)])
		}
	var_incentives = rt.call_function('array_filter', [var_incentives.clone(), rt.new_closure(closure_1_fn)])
	}
	return rt.call_function('array_values', [var_incentives.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives) is_incentive_visible(incentive_id string, suggestion_id string, country_code string, skip_extension_active_check bool) bool {
	mut var_provider := this.get_incentive_instance(suggestion_id)
	if rt.is_true(rt.identical(rt.new_null(), var_provider)) {
		return false
	}
	return (rt.call_method(var_provider, 'is_visible', [rt.new_string(incentive_id), rt.new_string(country_code), rt.new_bool(skip_extension_active_check)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives) is_incentive_dismissed(incentive_id string, suggestion_id string, context string) bool {
	mut var_provider := this.get_incentive_instance(suggestion_id)
	if rt.is_true(rt.identical(rt.new_null(), var_provider)) {
		return false
	}
	return (rt.call_method(var_provider, 'is_dismissed', [rt.new_string(incentive_id), rt.new_string(context)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives) get_incentive_dismissals(incentive_id string, suggestion_id string) rt.PhpVal {
	mut var_provider := this.get_incentive_instance(suggestion_id)
	if rt.is_true(rt.identical(rt.new_null(), var_provider)) {
		return rt.new_array()
	}
	return rt.call_method(var_provider, 'get_dismissals', [rt.new_string(incentive_id)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives) dismiss_incentive(incentive_id string, suggestion_id string, context string) bool {
	mut var_provider := this.get_incentive_instance(suggestion_id)
	if rt.is_true(rt.identical(rt.new_null(), var_provider)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Suggestions_Exception', []string{}, create_automattic_woocommerce_internal_admin_suggestions_exception(rt.new_string('No incentives provider for the suggestion.'))))
	}
	return (rt.call_method(var_provider, 'dismiss', [rt.new_string(incentive_id), rt.new_string(context)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives) get_incentive_instance(suggestion_id string) rt.PhpVal {
	if this.instances.array_isset(rt.new_string(suggestion_id)) {
		return this.instances.array_get(rt.new_string(suggestion_id))
	}
	if !(this.suggestion_incentives_class_map.array_isset(rt.new_string(suggestion_id))) {
		this.instances.array_set(suggestion_id, rt.new_null())
		return rt.new_null()
	}
	mut var_provider_class := this.suggestion_incentives_class_map.array_get(rt.new_string(suggestion_id))
	this.instances.array_set(suggestion_id, rt.create_object_dynamically(var_provider_class, [rt.new_string(suggestion_id)]))
	return this.instances.array_get(rt.new_string(suggestion_id))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives) has_incentive_provider(suggestion_id string) bool {
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.get_incentive_instance(suggestion_id))))
}

struct Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_suggestions_paymentsextensionsuggestionincentives(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives{
		PhpObjectBase: rt.PhpObjectBase{}
		suggestion_incentives_class_map: rt.new_array()
		instances: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_suggestions_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_incentive' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.get_incentive(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_incentives' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.get_incentives(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'is_incentive_visible' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.is_incentive_visible(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'is_incentive_dismissed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_incentive_dismissed(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_incentive_dismissals' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_incentive_dismissals(dispatch_arg_0, dispatch_arg_1)
		}
		'dismiss_incentive' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.dismiss_incentive(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_incentive_instance' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_incentive_instance(dispatch_arg_0)
		}
		'has_incentive_provider' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_incentive_provider(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'suggestion_incentives_class_map' { return this.suggestion_incentives_class_map }
		'instances' { return this.instances }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'suggestion_incentives_class_map' { this.suggestion_incentives_class_map = val; return true }
		'instances' { this.instances = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_suggestions_paymentsextensionsuggestionincentives()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestionIncentives', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_Suggestions_Exception', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_suggestions_exception()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Suggestions_Exception', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
