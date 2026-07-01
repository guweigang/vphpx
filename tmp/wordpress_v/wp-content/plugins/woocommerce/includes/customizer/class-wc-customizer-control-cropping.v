import rt

struct Class_WC_Customizer_Control_Cropping {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('woocommerce-cropping-control')
}

fn (mut this Class_WC_Customizer_Control_Cropping) render_content() {
	if !rt.is_true(rt.get_property(rt.new_object('WC_Customizer_Control_Cropping', [
		'WP_Customize_Control',
	], &this), 'choices')) {
		return rt.new_null()
	}
	mut var_value := this.value(rt.new_string('cropping'))
	mut var_custom_width := this.value(rt.new_string('custom_width'))
	mut var_custom_height := this.value(rt.new_string('custom_height'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.get_property(rt.new_object('WC_Customizer_Control_Cropping', [
			'WP_Customize_Control',
		], &this), 'label'),
	]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_property(rt.new_object('WC_Customizer_Control_Cropping', [
		'WP_Customize_Control',
	], &this), 'description'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.get_property(rt.new_object('WC_Customizer_Control_Cropping', [
				'WP_Customize_Control',
			], &this), 'description'),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(rt.new_object('WC_Customizer_Control_Cropping', [
			'WP_Customize_Control',
		], &this), 'id'),
	]))
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := rt.get_property(rt.new_object('WC_Customizer_Control_Cropping', [
			'WP_Customize_Control',
		], &this), 'choices').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_radio := item_1.val
			mut var_key := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.get_property(rt.new_object('WC_Customizer_Control_Cropping', [
					'WP_Customize_Control',
				], &this), 'id'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_key.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.concat(rt.get_property(rt.new_object('WC_Customizer_Control_Cropping', [
					'WP_Customize_Control',
				], &this), 'id'), var_key),
			]))
			// unsupported statement: Stmt_InlineHTML
			this.link(rt.new_string('cropping'))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [var_value.dup(), var_key.dup()])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.concat(rt.get_property(rt.new_object('WC_Customizer_Control_Cropping', [
					'WP_Customize_Control',
				], &this), 'id'), var_key),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_radio.array_get('label')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_radio.array_get('description')]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.identical(rt.new_string('custom'), var_key)) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_custom_width.dup()]))
				// unsupported statement: Stmt_InlineHTML
				this.link(rt.new_string('custom_width'))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_custom_height.dup()]))
				// unsupported statement: Stmt_InlineHTML
				this.link(rt.new_string('custom_height'))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

fn create_wc_customizer_control_cropping() &Class_WC_Customizer_Control_Cropping {
	mut obj := &Class_WC_Customizer_Control_Cropping{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('woocommerce-cropping-control')
	}
	return obj
}

fn create_wp_customize_control() &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Customizer_Control_Cropping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			this.render_content()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Customizer_Control_Cropping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Customizer_Control_Cropping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Customize_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_customizer_class_wc_customizer_control_cropping_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
