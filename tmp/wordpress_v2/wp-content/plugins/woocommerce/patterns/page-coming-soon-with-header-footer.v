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
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		print('<!-- wp:template-part {"slug":"header","tagName":"header"} /-->')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_heading_font_family.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_heading_font_family.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Great things are on the horizon'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_body_font_family.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_body_font_family.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Something big is brewing! Our store is in the works and will be launching soon!'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		print('<!-- wp:template-part {"slug":"footer","tagName":"footer"} /-->')
	}
	// unsupported statement: Stmt_InlineHTML
}
