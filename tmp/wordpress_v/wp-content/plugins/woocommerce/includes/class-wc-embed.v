import rt

struct Class_WC_Embed {
	rt.PhpObjectBase
}

fn Class_WC_Embed.init() {
	rt.call_function('add_filter', [rt.new_string('the_excerpt_embed'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'the_excerpt' }]),
		rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('embed_content_meta'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'remove_comments_button' }]),
		rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('embed_content_meta'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'get_ratings' }]),
		rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('embed_head'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'print_embed_styles' }])])
}

fn Class_WC_Embed.remove_comments_button() {
	if rt.is_true(Class_WC_Embed.is_embedded_product()) {
		rt.call_function('remove_action', [rt.new_string('embed_content_meta'),
			rt.new_string('print_embed_comments_button')])
	}
}

fn Class_WC_Embed.is_embedded_product() bool {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_embed')]))
		&& rt.is_true(rt.call_function('is_embed', []rt.PhpVal{}))))
		&& rt.is_true(rt.call_function('is_product', []rt.PhpVal{}))))
	{
		return true
	}
	return false
}

fn Class_WC_Embed.the_excerpt(var_excerpt rt.PhpVal) rt.PhpVal {
	mut var_post := rt.new_null()
	mut var_excerpt_mutated := var_excerpt
	// unsupported statement: Stmt_Global
	mut var__product := rt.call_function('wc_get_product', [
		rt.call_function('get_the_ID', []rt.PhpVal{}),
	])
	if rt.is_true(Class_WC_Embed.is_embedded_product()) {
		print('<p><span class="wc-embed-price">' +
			(rt.call_method(var__product, 'get_price_html', []rt.PhpVal{})).str() + '</span></p>')
		if !(!rt.is_true(rt.get_property(var_post, 'post_excerpt'))) {
			rt.call_function('ob_start', []rt.PhpVal{})
			rt.call_function('woocommerce_template_single_excerpt', []rt.PhpVal{})
			var_excerpt_mutated = rt.call_function('ob_get_clean', []rt.PhpVal{})
		}
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_excerpt_mutated.dup()
}

fn Class_WC_Embed.product_buttons() string {
	mut var__product := rt.call_function('wc_get_product', [
		rt.call_function('get_the_ID', []rt.PhpVal{}),
	])
	mut var_buttons := []rt.PhpVal{}
	mut var_button :=
		rt.new_string(rt.new_string('<a href="%s" class="wp-embed-more wc-embed-button">%s</a>'))
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var__product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.simple()]))
		&& rt.is_true(rt.call_method(var__product, 'is_purchasable', []rt.PhpVal{}))))
		&& rt.is_true(rt.call_method(var__product, 'is_in_stock', []rt.PhpVal{}))))
	{
		var_buttons << rt.call_function('sprintf', [var_button.dup(),
			rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [rt.new_string('add-to-cart'),
					rt.call_function('get_the_ID', []rt.PhpVal{}),
					rt.call_function('wc_get_cart_url', []rt.PhpVal{})]),
			]),
			rt.call_function('esc_html__', [
				rt.new_string('Buy now'),
				rt.new_string('woocommerce'),
			])])
	}
	var_buttons << rt.call_function('sprintf', [var_button.dup(),
		rt.call_function('get_the_permalink', []rt.PhpVal{}),
		rt.call_function('esc_html__', [rt.new_string('Read more'),
			rt.new_string('woocommerce')])])
	return '<p>' + (rt.call_function('implode', [rt.new_string(' '), var_buttons.dup()])).str() +
		'</p>'
}

fn Class_WC_Embed.get_ratings() {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Embed.is_embedded_product())))) {
		return rt.new_null()
	}
	mut var__product := rt.call_function('wc_get_product', [
		rt.call_function('get_the_ID', []rt.PhpVal{}),
	])
	if rt.is_true(rt.new_bool(rt.is_true(var__product)
		&& rt.is_true(rt.greater(rt.call_method(var__product, 'get_average_rating', []rt.PhpVal{}), rt.new_int(0)))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('esc_html__', [rt.new_string('Rated %s out of 5'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_html', [
				rt.call_method(var__product, 'get_average_rating', []rt.PhpVal{}),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
}

fn Class_WC_Embed.print_embed_styles() {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Embed.is_embedded_product())))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
}

fn create_wc_embed() &Class_WC_Embed {
	mut obj := &Class_WC_Embed{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Embed) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Embed.init()
			return rt.new_null()
		}
		'remove_comments_button' {
			Class_WC_Embed.remove_comments_button()
			return rt.new_null()
		}
		'is_embedded_product' {
			return rt.new_bool(Class_WC_Embed.is_embedded_product())
		}
		'the_excerpt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Embed.the_excerpt(dispatch_arg_0)
		}
		'product_buttons' {
			return rt.new_string(Class_WC_Embed.product_buttons())
		}
		'get_ratings' {
			Class_WC_Embed.get_ratings()
			return rt.new_null()
		}
		'print_embed_styles' {
			Class_WC_Embed.print_embed_styles()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Embed) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Embed) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_class_wc_embed_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	Class_WC_Embed.init()
}
