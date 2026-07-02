import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils) get_states_for_country(var_country rt.PhpVal) rt.PhpVal {
	return if rt.is_true(var_country) { rt.call_function('array_filter', [
			rt.cast_array(rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'countries'), 'get_states', [
				var_country.clone(),
			])),
		]) } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils) validate_state(var_state rt.PhpVal, var_country rt.PhpVal) bool {
	mut var_state_mutated := var_state
	mut var_states := this.get_states_for_country(var_country.clone())
	if rt.is_true(rt.new_int(var_states.clone().array_count()))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_function('wc_strtoupper', [var_state_mutated.clone()]), rt.call_function('array_map', [rt.new_string('\\wc_strtoupper'), rt.func_array_keys(var_states.clone())]), rt.new_bool(true)]))))) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils) format_state(var_state rt.PhpVal, var_country rt.PhpVal) rt.PhpVal {
	mut var_state_mutated := var_state
	mut var_states := this.get_states_for_country(var_country.clone())
	if rt.is_true(rt.new_int(var_states.clone().array_count())) {
		var_state_mutated = rt.call_function('wc_strtoupper', [
			var_state_mutated.clone()])
		mut var_state_values := rt.call_function('array_map', [
			rt.new_string('\\wc_strtoupper'),
			rt.call_function('array_flip', [
				rt.call_function('array_map', [rt.new_string('\\wc_strtoupper'),
					var_states.clone()]),
			]),
		])
		if var_state_values.array_isset(var_state_mutated) {
			return var_state_values.array_get(var_state_mutated)
		}
	}
	return var_state_mutated.clone()
}

fn create_automattic_woocommerce_storeapi_utilities_validationutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_states_for_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_states_for_country(dispatch_arg_0)
		}
		'validate_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.validate_state(dispatch_arg_0, dispatch_arg_1))
		}
		'format_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.format_state(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ValidationUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
