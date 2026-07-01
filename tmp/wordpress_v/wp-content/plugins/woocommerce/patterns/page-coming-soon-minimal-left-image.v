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

pub fn init_wp_content_plugins_woocommerce_patterns_page_coming_soon_minimal_left_image_php() {
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
	mut var_default_image := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/green-glass-jars-on-stairs.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_site_tagline := rt.call_function('get_bloginfo', [
		rt.new_string('description'),
	])
	mut var_store_description := if !(!rt.is_true(var_site_tagline)) { var_site_tagline } else { rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('%s transforms your home with our curated collection of home decor, bringing inspiration and style to every corner.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('get_bloginfo', [
				rt.new_string('name'),
			]),
		]) }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_body_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_body_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_default_image.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_heading_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_heading_font_family.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Something big is brewing! Our store is in the works – Launching shortly!'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [if !var_paragraph_font_family.is_null() {
		var_paragraph_font_family
	} else {
		rt.new_string('')
	}]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [if !var_paragraph_font_family.is_null() {
		var_paragraph_font_family
	} else {
		rt.new_string('')
	}]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [if !var_paragraph_font_family.is_null() {
		var_paragraph_font_family
	} else {
		rt.new_string('')
	}]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_store_description.dup()]))
	// unsupported statement: Stmt_InlineHTML
}
