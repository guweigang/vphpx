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

pub fn init_wp_content_plugins_woocommerce_patterns_page_coming_soon_default_php() {
	mut var_fonts := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate{}
		return temp.get_font_families()
	}()
	mut var_heading_font_family := var_fonts.array_get('heading')
	mut var_body_font_family := var_fonts.array_get('body')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_body_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_body_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_heading_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_heading_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string("Pardon our dust! We're working on something amazing — check back soon!"),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
}
