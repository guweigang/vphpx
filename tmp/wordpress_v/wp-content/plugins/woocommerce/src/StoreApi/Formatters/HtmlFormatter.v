import rt

struct Class_Automattic_WooCommerce_StoreApi_Formatters_HtmlFormatter {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_HtmlFormatter) format(var_value rt.PhpVal, mut var_options Class_Automattic_WooCommerce_StoreApi_Formatters_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
		return rt.call_function('array_map', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Formatters_HtmlFormatter', [
					'FormatterInterface',
				], &this) },
				rt.ArrayItem{ key: none, val: 'format' },
			]),
			var_value.dup(),
		])
	}
	return if rt.is_true(rt.call_function('is_scalar', [var_value.dup()])) { rt.call_function('wp_kses_post', [
			rt.new_string(rt.call_function('convert_chars', [
				rt.call_function('wptexturize', [var_value.dup()]),
			]).to_string().trim_space()),
		]) } else { var_value }
}

fn create_automattic_woocommerce_storeapi_formatters_htmlformatter() &Class_Automattic_WooCommerce_StoreApi_Formatters_HtmlFormatter {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Formatters_HtmlFormatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_HtmlFormatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'format' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Formatters_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.format(dispatch_arg_0, mut dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Formatters_HtmlFormatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_HtmlFormatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_formatters_htmlformatter_php() {
}
