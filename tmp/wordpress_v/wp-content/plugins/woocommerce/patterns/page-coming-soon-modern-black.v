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

pub fn init_wp_content_plugins_woocommerce_patterns_page_coming_soon_modern_black_php() {
	mut var_current_theme := rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}),
		'get_stylesheet', []rt.PhpVal{})
	mut var_fonts := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate{}
		return temp.get_font_families()
	}()
	mut var_heading_font_family := var_fonts.array_get('heading')
	mut var_body_font_family := var_fonts.array_get('body')
	mut var_default_image := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/music-black-and-white-white-photography-darkness-black.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_email := rt.call_function('get_option', [rt.new_string('admin_email'),
		rt.new_string('marianne.renoir@mail.com')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_default_image.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_default_image.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_body_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_heading_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_heading_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('_x', [rt.new_string('Stay tuned.'),
			rt.new_string('Coming Soon template heading'), rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_body_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_body_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_email.dup()]))
	// unsupported statement: Stmt_InlineHTML
}
