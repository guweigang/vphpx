import rt

struct Class_Automattic_WooCommerce_Internal_Settings_OptionSanitizer {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Settings_OptionSanitizer) construct() {
	mut var_color_options := rt.create_array([
		rt.ArrayItem{ key: none, val: 'woocommerce_email_base_color' },
		rt.ArrayItem{ key: none, val: 'woocommerce_email_background_color' },
		rt.ArrayItem{ key: none, val: 'woocommerce_email_body_background_color' },
		rt.ArrayItem{ key: none, val: 'woocommerce_email_text_color' },
	])
	mut iter_1 := var_color_options.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_option_name := item_1.val
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_admin_settings_sanitize_option_${var_option_name.to_string()}'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Settings_OptionSanitizer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'sanitize_color_option' },
			]),
			rt.new_int(10),
			rt.new_int(2),
		])
	}
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_notify_no_stock_amount'),
		rt.new_string('absint'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Settings_OptionSanitizer) sanitize_color_option(var_value rt.PhpVal, var_option rt.PhpVal) string {
	mut var_value_mutated := var_value
	var_value_mutated = rt.call_function('sanitize_hex_color', [
		var_value_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_value_mutated))))
		&& !(!rt.is_true(var_option.array_get(rt.new_string('id')))) {
		var_value_mutated = rt.call_function('sanitize_hex_color', [
			rt.call_function('get_option', [var_option.array_get(rt.new_string('id'))]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_value_mutated))))
		&& !(!rt.is_true(var_option.array_get(rt.new_string('default')))) {
		var_value_mutated = rt.call_function('sanitize_hex_color', [
			var_option.array_get(rt.new_string('default')),
		])
	}
	return var_value_mutated.str()
}

fn create_automattic_woocommerce_internal_settings_optionsanitizer() &Class_Automattic_WooCommerce_Internal_Settings_OptionSanitizer {
	mut obj := &Class_Automattic_WooCommerce_Internal_Settings_OptionSanitizer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Settings_OptionSanitizer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'sanitize_color_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.sanitize_color_option(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Settings_OptionSanitizer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Settings_OptionSanitizer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
