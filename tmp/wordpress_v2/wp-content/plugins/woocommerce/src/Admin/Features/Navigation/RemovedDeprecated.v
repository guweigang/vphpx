import rt

struct Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated.handle_deprecated_method_call(var_name rt.PhpVal) {
	mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
	if rt.is_true(var_logger) {
		rt.call_method(var_logger, 'warning', [
			rt.new_string('The WooCommerce Admin Navigation feature and its classes (Screen, Menu, CoreMenu) are deprecated since 9.3 with no alternative. Please remove the call to ${var_name.to_string()}.'),
		])
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Tracks')])) {
		mut iife_temp_0 := Class_WC_Tracks{}
		mut iife_result_0 :=
			iife_temp_0.record_event(rt.new_string('deprecated_navigation_method_called'))
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) {
	Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated.handle_deprecated_method_call(var_name.clone())
}

fn Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated.magic_callstatic(var_name rt.PhpVal, var_arguments rt.PhpVal) {
	Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated.handle_deprecated_method_call(var_name.clone())
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_navigation_removeddeprecated(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks(_args ...rt.PhpVal) &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'handle_deprecated_method_call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated.handle_deprecated_method_call(dispatch_arg_0)
			return rt.new_null()
		}
		'__call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_call(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__callStatic' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated.magic_callstatic(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
