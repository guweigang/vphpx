import rt

struct Class_Automattic_WooCommerce_Internal_Email_EmailColors {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Email_EmailColors.get_default_colors(mut var_email_improvements_enabled Class_Automattic_WooCommerce_Internal_Email_?bool) rt.PhpVal {
	mut var_email_improvements_enabled_mutated := var_email_improvements_enabled
	if rt.is_true(rt.identical(rt.new_null(), var_email_improvements_enabled_mutated)) {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('email_improvements'))
	var_email_improvements_enabled_mutated = iife_result_0
	}
	mut var_base := rt.new_string('#720eec')
	mut var_bg := rt.new_string('#f7f7f7')
	mut var_body_bg := rt.new_string('#ffffff')
	mut var_body_text := rt.new_string('#3c3c3c')
	mut var_footer_text := rt.new_string('#3c3c3c')
	if rt.is_true(var_email_improvements_enabled_mutated) {
		var_base = rt.new_string('#8526ff')
		var_bg = rt.new_string('#ffffff')
		var_body_bg = rt.new_string('#ffffff')
		var_body_text = rt.new_string('#1e1e1e')
		var_footer_text = rt.new_string('#787c82')
		mut var_global_colors := Class_Automattic_WooCommerce_Internal_Email_EmailColors.get_colors_from_global_styles()
		if rt.is_true(var_global_colors) {
		var_base = var_global_colors.array_get(rt.new_string('base'))
		var_bg = var_global_colors.array_get(rt.new_string('bg'))
		var_body_bg = var_global_colors.array_get(rt.new_string('body_bg'))
		var_body_text = var_global_colors.array_get(rt.new_string('body_text'))
		var_footer_text = var_global_colors.array_get(rt.new_string('footer_text'))
		}
	}
	return rt.call_function('compact', [rt.new_string('base'), rt.new_string('bg'), rt.new_string('body_bg'), rt.new_string('body_text'), rt.new_string('footer_text')])
}

fn Class_Automattic_WooCommerce_Internal_Email_EmailColors.get_colors_from_global_styles() rt.PhpVal {
	mut var_styles := Class_Automattic_WooCommerce_Internal_Email_EmailColors.get_global_styles_data()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_styles)))) {
		return rt.new_null()
	}
	mut var_bg := if !(var_styles.array_get(rt.new_string('color')).array_get(rt.new_string('background'))).is_null() { var_styles.array_get(rt.new_string('color')).array_get(rt.new_string('background')) } else { rt.new_null() }
	mut var_body_bg := if !(var_styles.array_get(rt.new_string('color')).array_get(rt.new_string('background'))).is_null() { var_styles.array_get(rt.new_string('color')).array_get(rt.new_string('background')) } else { rt.new_null() }
	mut var_body_text := if !(var_styles.array_get(rt.new_string('color')).array_get(rt.new_string('text'))).is_null() { var_styles.array_get(rt.new_string('color')).array_get(rt.new_string('text')) } else { rt.new_null() }
	mut var_base := if !(var_styles.array_get(rt.new_string('elements')).array_get(rt.new_string('button')).array_get(rt.new_string('color')).array_get(rt.new_string('background'))).is_null() { var_styles.array_get(rt.new_string('elements')).array_get(rt.new_string('button')).array_get(rt.new_string('color')).array_get(rt.new_string('background')) } else { rt.new_null() }
	mut var_footer_text := if !(var_styles.array_get(rt.new_string('elements')).array_get(rt.new_string('caption')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))).is_null() { var_styles.array_get(rt.new_string('elements')).array_get(rt.new_string('caption')).array_get(rt.new_string('color')).array_get(rt.new_string('text')) } else { rt.new_null() }
	var_bg = if var_bg.clone().is_string() { rt.call_function('sanitize_hex_color', [var_bg.clone()]) } else { rt.new_string('') }
	var_body_bg = if var_body_bg.clone().is_string() { rt.call_function('sanitize_hex_color', [var_body_bg.clone()]) } else { rt.new_string('') }
	var_body_text = if var_body_text.clone().is_string() { rt.call_function('sanitize_hex_color', [var_body_text.clone()]) } else { rt.new_string('') }
	var_base = if var_base.clone().is_string() { rt.call_function('sanitize_hex_color', [var_base.clone()]) } else { var_body_text }
	var_footer_text = if var_footer_text.clone().is_string() { rt.call_function('sanitize_hex_color', [var_footer_text.clone()]) } else { var_body_text }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_bg)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_body_bg)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_body_text)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_base)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_footer_text)))) {
		return rt.new_null()
	}
	return rt.call_function('compact', [rt.new_string('base'), rt.new_string('bg'), rt.new_string('body_bg'), rt.new_string('body_text'), rt.new_string('footer_text')])
}

fn Class_Automattic_WooCommerce_Internal_Email_EmailColors.get_global_styles_data() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_is_block_theme')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_get_global_styles')]))))) {
		return rt.new_null()
	}
	return rt.call_function('wp_get_global_styles', [rt.new_array(), rt.create_array([rt.ArrayItem{ key: 'transforms', val: rt.create_array([rt.ArrayItem{ key: none, val: 'resolve-variables' }]) }])])
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_email_emailcolors(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Email_EmailColors {
	mut obj := &Class_Automattic_WooCommerce_Internal_Email_EmailColors{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailColors) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_default_colors' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Email_?bool](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Email_EmailColors.get_default_colors(mut dispatch_arg_0)
		}
		'get_colors_from_global_styles' {
			return Class_Automattic_WooCommerce_Internal_Email_EmailColors.get_colors_from_global_styles()
		}
		'get_global_styles_data' {
			return Class_Automattic_WooCommerce_Internal_Email_EmailColors.get_global_styles_data()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Email_EmailColors) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailColors) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
