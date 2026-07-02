import rt

struct Class_WC_Helper_Options {
	rt.PhpObjectBase
}

fn init_static_wc_helper_options() {
	rt.init_static_prop('WC_Helper_Options', 'option_name',
		rt.new_string('woocommerce_helper_data'))
}

fn Class_WC_Helper_Options.update(var_key rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_options := rt.call_function('get_option', [
		rt.get_static_prop('WC_Helper_Options', 'option_name'),
		rt.new_array(),
	])
	var_options.array_set(var_key, var_value.clone())
	return rt.call_function('update_option', [
		rt.get_static_prop('WC_Helper_Options', 'option_name'),
		var_options.clone(),
		rt.new_bool(true),
	])
}

fn Class_WC_Helper_Options.get(var_key rt.PhpVal, default bool) rt.PhpVal {
	mut var_options := rt.call_function('get_option', [
		rt.get_static_prop('WC_Helper_Options', 'option_name'),
		rt.new_array(),
	])
	if var_options.clone().is_array()
		&& rt.is_true(rt.new_bool(var_options.clone().array_isset(var_key.clone()))) {
		return var_options.array_get(var_key)
	}
	return rt.new_bool(default)
}

fn create_wc_helper_options(_args ...rt.PhpVal) &Class_WC_Helper_Options {
	mut obj := &Class_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Helper_Options.update(dispatch_arg_0, dispatch_arg_1)
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_WC_Helper_Options.get(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
