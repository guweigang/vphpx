import rt

pub fn Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate.slug() string {
	return 'coming-soon'
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate) get_template_title() rt.PhpVal {
	return rt.call_function('_x', [rt.new_string('Page: Coming soon'),
		rt.new_string('Template name'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate) get_template_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Let your shoppers know your site or part of your site is under construction.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate) get_placeholder_page() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate) is_active_template() bool {
	return false
}

fn Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate.get_font_families() rt.PhpVal {
	mut var_default_fonts := rt.create_array([
		rt.ArrayItem{ key: 'heading', val: 'cardo' },
		rt.ArrayItem{ key: 'body', val: 'inter' },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		return var_default_fonts.dup()
	}
	mut var_current_theme := rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}),
		'get_stylesheet', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('twentytwentyfour'), var_current_theme)) {
		return rt.create_array([rt.ArrayItem{ key: 'heading', val: 'heading' },
			rt.ArrayItem{ key: 'body', val: 'body' }])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_get_global_settings'),
	])))))
	{
		return var_default_fonts.dup()
	}
	mut var_settings := rt.call_function('wp_get_global_settings', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(
		!(var_settings.array_get('typography').array_get('fontFamilies').array_isset(rt.new_string('theme')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_settings.array_get('typography').array_get('fontFamilies').array_get('theme').is_array())))))))
	{
		return var_default_fonts.dup()
	}
	mut var_theme_fonts :=
		var_settings.array_get('typography').array_get('fontFamilies').array_get('theme')
	if var_theme_fonts.array_get(0).array_isset(rt.new_string('slug'))
		&& !(!rt.is_true(var_theme_fonts.array_get(0).array_get('slug'))) {
		var_default_fonts.array_set('heading', rt.call_function('str_replace', [
			rt.new_string(' '),
			rt.new_string('-'),
			var_theme_fonts.array_get(0).array_get('slug'),
		]).to_string().to_lower())
	}
	if var_theme_fonts.array_get(1).array_isset(rt.new_string('slug'))
		&& !(!rt.is_true(var_theme_fonts.array_get(1).array_get('slug'))) {
		var_default_fonts.array_set('body', rt.call_function('str_replace', [
			rt.new_string(' '),
			rt.new_string('-'),
			var_theme_fonts.array_get(1).array_get('slug'),
		]).to_string().to_lower())
		var_default_fonts.array_set('paragraph', var_default_fonts.array_get('body'))
	}
	return var_default_fonts.dup()
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_comingsoontemplate() &Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstractpagetemplate() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_template_title' {
			return this.get_template_title()
		}
		'get_template_description' {
			return this.get_template_description()
		}
		'get_placeholder_page' {
			return this.get_placeholder_page()
		}
		'is_active_template' {
			return rt.new_bool(this.is_active_template())
		}
		'get_font_families' {
			return Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate.get_font_families()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractPageTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_templates_comingsoontemplate_php() {
}
