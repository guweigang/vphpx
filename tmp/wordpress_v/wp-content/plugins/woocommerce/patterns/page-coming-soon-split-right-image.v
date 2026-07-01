import rt

struct Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_comingsoontemplate() &Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_patterns_page_coming_soon_split_right_image_php() {
	mut var_fonts := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate{}
		return temp.get_font_families()
	}()
	mut var_heading_font_family := var_fonts.array_get('heading')
	mut var_body_font_family := var_fonts.array_get('body')
	mut var_paragraph_font_family := if var_fonts.array_isset(rt.new_string('paragraph')) {
		var_fonts.array_get('paragraph')
	} else {
		rt.new_null()
	}
	mut var_left_image := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/wheel-leaf-bicycle-bike-vehicle-spoke.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_right_image := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/orange-wall-with-bicycle.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_body_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_body_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_body_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('opening soon'),
		rt.new_string('Used in the heading of the coming soon page'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_left_image.dup()]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_paragraph_font_family) {
		' has-' + (rt.call_function('esc_attr', [var_paragraph_font_family.dup()])).str() +
			'-font-family'
	} else {
		''
	})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Dedicated to providing top-quality bikes, accessories, and expert advice for riders of all experience levels. Stay tuned.'),
		rt.new_string('Used in the paragraph of the coming soon page'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_right_image.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_right_image.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_heading_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_heading_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Where cycling dreams take flight.'),
		rt.new_string('Used in the heading of the coming soon page'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
}
