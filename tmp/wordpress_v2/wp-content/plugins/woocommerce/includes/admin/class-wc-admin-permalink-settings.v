import rt

struct Class_WC_Admin_Permalink_Settings {
	rt.PhpObjectBase
pub mut:
	permalinks rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Admin_Permalink_Settings) construct() {
	this.settings_init()
	this.settings_save()
}

fn (mut this Class_WC_Admin_Permalink_Settings) settings_init() {
	rt.call_function('add_settings_section', [rt.new_string('woocommerce-permalink'),
		rt.call_function('__', [rt.new_string('Product permalinks'),
			rt.new_string('woocommerce')]),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Permalink_Settings',
			[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'settings' }]),
		rt.new_string('permalink')])
	rt.call_function('add_settings_field', [
		rt.new_string('woocommerce_product_category_slug'),
		rt.call_function('__', [rt.new_string('Product category base'),
			rt.new_string('woocommerce')]),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Permalink_Settings',
			[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'product_category_slug_input' }]),
		rt.new_string('permalink'),
		rt.new_string('optional'),
	])
	rt.call_function('add_settings_field', [
		rt.new_string('woocommerce_product_tag_slug'),
		rt.call_function('__', [rt.new_string('Product tag base'),
			rt.new_string('woocommerce')]),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Permalink_Settings',
			[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'product_tag_slug_input' }]),
		rt.new_string('permalink'),
		rt.new_string('optional'),
	])
	rt.call_function('add_settings_field', [
		rt.new_string('woocommerce_product_attribute_slug'),
		rt.call_function('__', [rt.new_string('Product attribute base'),
			rt.new_string('woocommerce')]),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Permalink_Settings',
			[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'product_attribute_slug_input' }]),
		rt.new_string('permalink'),
		rt.new_string('optional'),
	])
	this.permalinks = rt.call_function('wc_get_permalink_structure', []rt.PhpVal{})
}

fn (mut this Class_WC_Admin_Permalink_Settings) product_category_slug_input() {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		this.permalinks.array_get(rt.new_string('category_base')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('product-category'),
		rt.new_string('slug'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Permalink_Settings) product_tag_slug_input() {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.permalinks.array_get(rt.new_string('tag_base'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('product-tag'),
		rt.new_string('slug'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Permalink_Settings) product_attribute_slug_input() {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		this.permalinks.array_get(rt.new_string('attribute_base')),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Permalink_Settings) settings() {
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('wpautop', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('If you like, you may enter custom structures for your product URLs here. For example, using <code>shop</code> would make your product links like <code>%sshop/sample-product/</code>. This setting affects product URLs only, not things such as product categories.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_url', [
					rt.call_function('home_url', [rt.new_string('/')]),
				]),
			]),
		]),
	]))
	mut var_shop_page_id := rt.call_function('wc_get_page_id', [
		rt.new_string('shop')])
	mut var_base_slug := rt.call_function('urldecode', [if rt.is_true(rt.greater(var_shop_page_id, rt.new_int(0))) && rt.is_true(rt.call_function('get_post', [var_shop_page_id.clone()])) { rt.call_function('get_page_uri', [
			var_shop_page_id.clone(),
		]) } else { rt.call_function('_x', [
			rt.new_string('shop'),
			rt.new_string('default-slug'),
			rt.new_string('woocommerce'),
		]) }])
	mut var_product_base := rt.call_function('_x', [rt.new_string('product'),
		rt.new_string('default-slug'), rt.new_string('woocommerce')])
	mut var_structures := ['',
		'/' + (rt.call_function('trailingslashit', [var_base_slug.clone()])).str(),
		'/' +
			(rt.call_function('trailingslashit', [var_base_slug.clone()])).str() +
			(rt.call_function('trailingslashit', [rt.new_string('%product_cat%')])).str()]
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string((var_structures[0]).str())]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string((var_structures[0]).str()),
		this.permalinks.array_get(rt.new_string('product_base'))])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Default'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('home_url', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('home_url', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_product_base.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_shop_page_id) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.new_string((var_structures[1]).str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string((var_structures[1]).str()),
			this.permalinks.array_get(rt.new_string('product_base'))])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Shop base'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('home_url', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_base_slug.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.new_string((var_structures[2]).str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string((var_structures[2]).str()),
			this.permalinks.array_get(rt.new_string('product_base'))])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Shop base with category'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('home_url', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_base_slug.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [
		rt.call_function('in_array', [this.permalinks.array_get(rt.new_string('product_base')),
			rt.create_array_from_list(var_structures), rt.new_bool(true)]),
		rt.new_bool(false),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Custom base'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(this.permalinks.array_get(rt.new_string('product_base'))) { rt.call_function('trailingslashit', [
			this.permalinks.array_get(rt.new_string('product_base')),
		]) } else { rt.new_string('') }]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Enter a custom base to use. A base must be set or WordPress will use default instead.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('wc-permalinks'),
		rt.new_string('wc-permalinks-nonce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Permalink_Settings) settings_save() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('permalink_structure'))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('wc-permalinks-nonce'))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_product_category_slug'))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_product_tag_slug'))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_product_attribute_slug'))
		&& rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('wc-permalinks-nonce'))]), rt.new_string('wc-permalinks')])) {
		rt.call_function('wc_switch_to_site_locale', []rt.PhpVal{})
		mut var_permalinks := rt.cast_array(rt.call_function('get_option', [
			rt.new_string('woocommerce_permalinks'),
			rt.new_array(),
		]))
		var_permalinks.array_set('category_base', rt.call_function('wc_sanitize_permalink', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('woocommerce_product_category_slug')),
			]),
		]))
		var_permalinks.array_set('tag_base', rt.call_function('wc_sanitize_permalink', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('woocommerce_product_tag_slug')),
			]),
		]))
		var_permalinks.array_set('attribute_base', rt.call_function('wc_sanitize_permalink', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('woocommerce_product_attribute_slug')),
			]),
		]))
		mut var_product_base := if rt.get_superglobal('_POST').array_isset(rt.new_string('product_permalink')) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('product_permalink')),
				]),
			]) } else { rt.new_string('') }
		if rt.is_true(rt.identical(rt.new_string('custom'), var_product_base)) {
			if rt.get_superglobal('_POST').array_isset(rt.new_string('product_permalink_structure')) {
				var_product_base = rt.call_function('preg_replace', [
					rt.new_string('#/+#'),
					rt.new_string('/'),
					rt.new_string('/' +(rt.call_function('str_replace', [rt.new_string('#'), rt.new_string(''), rt.new_string(rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('product_permalink_structure'))]).to_string().trim_space())])).str()),
				])
			} else {
				var_product_base = rt.new_string('/')
			}
			if rt.is_true(rt.identical(rt.new_string('/%product_cat%/'), rt.call_function('trailingslashit', [
				var_product_base.clone(),
			])))
			{
				var_product_base = rt.new_string('/' +
					(rt.call_function('_x', [rt.new_string('product'), rt.new_string('slug'), rt.new_string('woocommerce')])).str() +
					var_product_base.str())
			}
		} else if !rt.is_true(var_product_base) {
			var_product_base = rt.call_function('_x', [rt.new_string('product'),
				rt.new_string('slug'), rt.new_string('woocommerce')])
		}
		var_permalinks.array_set('product_base', rt.call_function('wc_sanitize_permalink', [
			var_product_base.clone(),
		]))
		mut var_shop_page_id := rt.call_function('wc_get_page_id', [
			rt.new_string('shop'),
		])
		mut var_shop_permalink := if rt.is_true(rt.greater(var_shop_page_id, rt.new_int(0))) && rt.is_true(rt.call_function('get_post', [var_shop_page_id.clone()])) { rt.call_function('get_page_uri', [
				var_shop_page_id.clone(),
			]) } else { rt.call_function('_x', [rt.new_string('shop'),
				rt.new_string('default-slug'), rt.new_string('woocommerce')]) }
		if rt.is_true(var_shop_page_id)
			&& rt.is_true(rt.call_function('stristr', [rt.new_string(var_permalinks.array_get(rt.new_string('product_base')).to_string().trim_space()), var_shop_permalink.clone()])) {
			var_permalinks.array_set('use_verbose_page_rules', true)
		}
		rt.call_function('update_option', [rt.new_string('woocommerce_permalinks'),
			var_permalinks.clone()])
		rt.call_function('wc_restore_locale', []rt.PhpVal{})
	}
}

fn create_wc_admin_permalink_settings() &Class_WC_Admin_Permalink_Settings {
	mut obj := &Class_WC_Admin_Permalink_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
		permalinks:    rt.new_array()
	}
	obj.construct()
	return obj
}

fn (mut this Class_WC_Admin_Permalink_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'settings_init' {
			this.settings_init()
			return rt.new_null()
		}
		'product_category_slug_input' {
			this.product_category_slug_input()
			return rt.new_null()
		}
		'product_tag_slug_input' {
			this.product_tag_slug_input()
			return rt.new_null()
		}
		'product_attribute_slug_input' {
			this.product_attribute_slug_input()
			return rt.new_null()
		}
		'settings' {
			this.settings()
			return rt.new_null()
		}
		'settings_save' {
			this.settings_save()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Permalink_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'permalinks' { return this.permalinks }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_Permalink_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'permalinks' {
			this.permalinks = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_Permalink_Settings'),
		rt.new_bool(false),
	]))
	{
		return rt.new_object('WC_Admin_Permalink_Settings', []string{},
			create_wc_admin_permalink_settings())
	}
	return rt.new_object('WC_Admin_Permalink_Settings', []string{},
		create_wc_admin_permalink_settings())
}
