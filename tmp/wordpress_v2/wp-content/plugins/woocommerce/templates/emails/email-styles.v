import rt

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('email_improvements'))
	mut var_email_improvements_enabled := iife_result_0
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_1 := iife_temp_1.feature_is_enabled(rt.new_string('block_email_editor'))
	mut var_block_email_editor_enabled := iife_result_1
	mut var_bg := rt.call_function('get_option', [
		rt.new_string('woocommerce_email_background_color'),
	])
	mut var_body := rt.call_function('get_option', [
		rt.new_string('woocommerce_email_body_background_color'),
	])
	mut var_base := rt.call_function('get_option', [
		rt.new_string('woocommerce_email_base_color'),
	])
	mut var_text := rt.call_function('get_option', [
		rt.new_string('woocommerce_email_text_color'),
	])
	mut var_footer_text := rt.call_function('get_option', [
		rt.new_string('woocommerce_email_footer_text_color'),
	])
	mut var_header_alignment := rt.call_function('get_option', [
		rt.new_string('woocommerce_email_header_alignment'),
		if rt.is_true(var_email_improvements_enabled) {
			if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'right' } else { 'left' }
		} else {
			rt.new_bool(false)
		},
	])
	mut var_logo_image_width := rt.call_function('get_option', [
		rt.new_string('woocommerce_email_header_image_width'),
		rt.new_string('120'),
	])
	mut var_default_font := 'Helvetica'
	mut var_font_family := if rt.is_true(var_email_improvements_enabled) { rt.call_function('get_option', [
			rt.new_string('woocommerce_email_font_family'),
			rt.new_string(var_default_font.str()).clone(),
		]) } else { rt.new_string(var_default_font.str()) }
	mut var_is_email_preview := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_is_email_preview'),
		rt.new_bool(false),
	])
	if rt.is_true(var_is_email_preview) {
		mut var_bg_transient := rt.call_function('get_transient', [
			rt.new_string('woocommerce_email_background_color'),
		])
		mut var_body_transient := rt.call_function('get_transient', [
			rt.new_string('woocommerce_email_body_background_color'),
		])
		mut var_base_transient := rt.call_function('get_transient', [
			rt.new_string('woocommerce_email_base_color'),
		])
		mut var_text_transient := rt.call_function('get_transient', [
			rt.new_string('woocommerce_email_text_color'),
		])
		mut var_footer_text_transient := rt.call_function('get_transient', [
			rt.new_string('woocommerce_email_footer_text_color'),
		])
		mut var_header_alignment_transient := rt.call_function('get_transient', [
			rt.new_string('woocommerce_email_header_alignment'),
		])
		mut var_logo_image_width_transient := rt.call_function('get_transient', [
			rt.new_string('woocommerce_email_header_image_width'),
		])
		mut var_font_family_transient := rt.call_function('get_transient', [
			rt.new_string('woocommerce_email_font_family'),
		])
		var_bg = if rt.is_true(var_bg_transient) { var_bg_transient } else { var_bg }
		var_body = if rt.is_true(var_body_transient) { var_body_transient } else { var_body }
		var_base = if rt.is_true(var_base_transient) { var_base_transient } else { var_base }
		var_text = if rt.is_true(var_text_transient) { var_text_transient } else { var_text }
		var_footer_text = if rt.is_true(var_footer_text_transient) {
			var_footer_text_transient
		} else {
			var_footer_text
		}
		var_header_alignment = if rt.is_true(var_header_alignment_transient) {
			var_header_alignment_transient
		} else {
			var_header_alignment
		}
		var_logo_image_width = if rt.is_true(var_logo_image_width_transient) {
			var_logo_image_width_transient
		} else {
			var_logo_image_width
		}
		var_font_family = if rt.is_true(var_font_family_transient) {
			var_font_family_transient
		} else {
			var_font_family
		}
	}
	mut var_safe_font_family := if !(rt.get_static_prop('Automattic_WooCommerce_Internal_Email_EmailFont',
		'font').array_get(var_font_family)).is_null() {
		rt.get_static_prop('Automattic_WooCommerce_Internal_Email_EmailFont', 'font').array_get(var_font_family)
	} else {
		rt.get_static_prop('Automattic_WooCommerce_Internal_Email_EmailFont', 'font').array_get(rt.new_string(var_default_font.str()))
	}
	mut var_base_text := rt.call_function('wc_light_or_dark', [
		var_base.clone(), rt.new_string('#202020'), rt.new_string('#ffffff')])
	mut var_link_color := if rt.is_true(rt.call_function('wc_hex_is_light', [
		var_base.clone()]))
	{ var_base } else { var_base_text }
	if rt.is_true(rt.call_function('wc_hex_is_light', [var_body.clone()])) {
		var_link_color = if rt.is_true(rt.call_function('wc_hex_is_light', [
			var_base.clone()]))
		{ var_base_text } else { var_base }
	}
	if rt.is_true(var_email_improvements_enabled) {
		var_link_color = var_base.clone()
	}
	mut var_border_color := rt.call_function('wc_light_or_dark', [
		var_body.clone(), rt.new_string('rgba(0, 0, 0, .2)'),
		rt.new_string('rgba(255, 255, 255, .2)')])
	mut var_bg_darker_10 := rt.call_function('wc_hex_darker', [
		var_bg.clone(), rt.new_int(10)])
	mut var_body_darker_10 := rt.call_function('wc_hex_darker', [
		var_body.clone(), rt.new_int(10)])
	mut var_base_lighter_20 := rt.call_function('wc_hex_lighter', [
		var_base.clone(), rt.new_int(20)])
	mut var_base_lighter_40 := rt.call_function('wc_hex_lighter', [
		var_base.clone(), rt.new_int(40)])
	mut var_text_lighter_20 := rt.call_function('wc_hex_lighter', [
		var_text.clone(), rt.new_int(20)])
	mut var_text_lighter_40 := rt.call_function('wc_hex_lighter', [
		var_text.clone(), rt.new_int(40)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_bg.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_bg.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_email_improvements_enabled) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_body.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '24px 0' } else { '70px 0' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) {
		'none'
	} else {
		'0 1px 4px rgba(0, 0, 0, 0.1) !important'
	})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_body.clone()]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) {
		'0'
	} else {
		'1px solid ' + (rt.call_function('esc_attr', [var_bg_darker_10.clone()])).str()
	})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(var_email_improvements_enabled) {
		var_body
	} else {
		var_base
	}]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(var_email_improvements_enabled) {
		var_text
	} else {
		var_base_text
	}]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_safe_font_family)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(var_email_improvements_enabled) {
		var_text
	} else {
		var_base_text
	}]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_email_improvements_enabled) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_header_alignment.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_logo_image_width.clone()]))
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'left' } else { 'right' })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_link_color.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_safe_font_family)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_footer_text.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_text.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_safe_font_family)
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'right' } else { 'left' })
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '0' } else { '6px' })
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_email_improvements_enabled) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_border_color.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_footer_text.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_safe_font_family)
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '140%' } else { '150%' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '32px' } else { '24px 0' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '0' } else { '0 0 16px' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_body.clone()]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) {
		'20px 32px 32px'
	} else {
		'48px 48px 32px'
	})
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'right' } else { 'left' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'left' } else { 'right' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_border_color.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_border_color.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_border_color.clone()]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'right' } else { 'left' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'left' } else { 'right' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_text_lighter_20.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_safe_font_family)
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '16px' } else { '14px' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'right' } else { 'left' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_text_lighter_20.clone()]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) {
		'0'
	} else {
		'1px solid ' + (rt.call_function('esc_attr', [var_body_darker_10.clone()])).str()
	})
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_email_improvements_enabled) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_text.clone()]))
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_text_lighter_20.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_body_darker_10.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_email_improvements_enabled) {
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'right' } else { 'left' })
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_text_lighter_20.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_body_darker_10.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_text.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_safe_font_family)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_link_color.clone()]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '20px 32px 0' } else { '36px 48px' })
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_header_alignment) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_header_alignment.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_footer_text.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(var_email_improvements_enabled) {
		var_text
	} else {
		var_base
	}]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_safe_font_family)
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '32px' } else { '30px' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { 700 } else { 300 }.str())
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_email_improvements_enabled) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '120%' } else { '150%' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'right' } else { 'left' })
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(var_email_improvements_enabled)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_base_lighter_20.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(var_email_improvements_enabled) {
		var_text
	} else {
		var_base
	}]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_safe_font_family)
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '20px' } else { '18px' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '160%' } else { '130%' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'right' } else { 'left' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(var_email_improvements_enabled) {
		var_text
	} else {
		var_base
	}]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_safe_font_family)
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '160%' } else { '130%' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'right' } else { 'left' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_link_color.clone()]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_block_email_editor_enabled) { 'top' } else { 'middle' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'left' } else { 'right' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '24px' } else { '10px' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_footer_text.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_safe_font_family)
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'right' } else { 'left' })
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'left' } else { 'right' })
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_email_improvements_enabled) {
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
