import rt

struct Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_comingsoontemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate{}
	mut iife_result_0 := iife_temp_0.get_font_families()
	mut var_fonts := iife_result_0
	mut var_heading_font_family := var_fonts.array_get(rt.new_string('heading'))
	mut var_body_font_family := var_fonts.array_get(rt.new_string('body'))
	mut var_featured_image_urls := [
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/gallery-1.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/gallery-2.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/gallery-3.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/gallery-4.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/gallery-5.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/gallery-6.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/gallery-7.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/gallery-8.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/gallery-9.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/gallery-10.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/gallery-11.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/gallery-12.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
	]
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_body_font_family.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_body_font_family.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_heading_font_family.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_heading_font_family.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Great things are coming soon'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
	if var_featured_image_urls.array_isset(rt.new_int(0)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_featured_image_urls[0]]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_featured_image_urls.array_isset(rt.new_int(4)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_featured_image_urls[4]]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_featured_image_urls.array_isset(rt.new_int(8)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_featured_image_urls[8]]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_featured_image_urls.array_isset(rt.new_int(1)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_featured_image_urls[1]]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_featured_image_urls.array_isset(rt.new_int(5)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_featured_image_urls[5]]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_featured_image_urls.array_isset(rt.new_int(9)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_featured_image_urls[9]]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_featured_image_urls.array_isset(rt.new_int(2)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_featured_image_urls[2]]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_featured_image_urls.array_isset(rt.new_int(6)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_featured_image_urls[6]]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_featured_image_urls.array_isset(rt.new_int(10)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_featured_image_urls[10]]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_featured_image_urls.array_isset(rt.new_int(3)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_featured_image_urls[3]]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_featured_image_urls.array_isset(rt.new_int(7)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_featured_image_urls[7]]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_featured_image_urls.array_isset(rt.new_int(11)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_featured_image_urls[11]]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
