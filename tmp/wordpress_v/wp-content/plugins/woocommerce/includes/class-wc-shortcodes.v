import rt

struct Class_WC_Shortcodes {
	rt.PhpObjectBase
}

fn Class_WC_Shortcodes.init()  {
	mut var_shortcodes := { 'product': @STRUCT + '::product', 'product_page': @STRUCT + '::product_page', 'product_category': @STRUCT + '::product_category', 'product_categories': @STRUCT + '::product_categories', 'add_to_cart': @STRUCT + '::product_add_to_cart', 'add_to_cart_url': @STRUCT + '::product_add_to_cart_url', 'products': @STRUCT + '::products', 'recent_products': @STRUCT + '::recent_products', 'sale_products': @STRUCT + '::sale_products', 'best_selling_products': @STRUCT + '::best_selling_products', 'top_rated_products': @STRUCT + '::top_rated_products', 'featured_products': @STRUCT + '::featured_products', 'product_attribute': @STRUCT + '::product_attribute', 'related_products': @STRUCT + '::related_products', 'shop_messages': @STRUCT + '::shop_messages', 'woocommerce_order_tracking': @STRUCT + '::order_tracking', 'woocommerce_cart': @STRUCT + '::cart', 'woocommerce_checkout': @STRUCT + '::checkout', 'woocommerce_my_account': @STRUCT + '::my_account' }
	for var_shortcode, var_function in var_shortcodes {
		rt.call_function('add_shortcode', [rt.call_function('apply_filters', [rt.new_string("${var_shortcode}_shortcode_tag"), rt.new_string(shortcode)]), rt.new_string(function)])
	}
	rt.call_function('add_shortcode', [rt.new_string('woocommerce_messages'), @STRUCT + '::shop_messages'])
}

fn Class_WC_Shortcodes.shortcode_wrapper(var_function rt.PhpVal, var_atts rt.PhpVal, var_wrapper rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.echo_val(if !rt.is_true(var_wrapper.array_get('before')) { '<div class="' + (rt.call_function('esc_attr', [var_wrapper.array_get('class')])).str() + '">' } else { var_wrapper.array_get('before') })
	rt.call_function('call_user_func', [var_function.dup(), var_atts_mutated.dup()])
	rt.echo_val(if !rt.is_true(var_wrapper.array_get('after')) { rt.new_string('</div>') } else { var_wrapper.array_get('after') })
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn Class_WC_Shortcodes.cart() rt.PhpVal {
	return if rt.is_true(rt.new_bool(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart').is_null())) { rt.new_string('') } else { Class_WC_Shortcodes.shortcode_wrapper(rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Shortcode_Cart' }, rt.ArrayItem{ key: none, val: 'output' }])) }
}

fn Class_WC_Shortcodes.checkout(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	return Class_WC_Shortcodes.shortcode_wrapper(rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Shortcode_Checkout' }, rt.ArrayItem{ key: none, val: 'output' }]), var_atts_mutated.dup())
}

fn Class_WC_Shortcodes.order_tracking(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	return Class_WC_Shortcodes.shortcode_wrapper(rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Shortcode_Order_Tracking' }, rt.ArrayItem{ key: none, val: 'output' }]), var_atts_mutated.dup())
}

fn Class_WC_Shortcodes.my_account(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	return Class_WC_Shortcodes.shortcode_wrapper(rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Shortcode_My_Account' }, rt.ArrayItem{ key: none, val: 'output' }]), var_atts_mutated.dup())
}

fn Class_WC_Shortcodes.product_category(var_atts rt.PhpVal) string {
	mut var_atts_mutated := var_atts
	if !rt.is_true(var_atts_mutated.array_get('category')) {
		return ''
	}
	var_atts_mutated = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'limit', val: '12' }, rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'orderby', val: 'menu_order title' }, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'category', val: '' }, rt.ArrayItem{ key: 'cat_operator', val: 'IN' }]), rt.cast_array(var_atts_mutated)])
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.dup(), rt.new_string('product_category'))
	return (var_shortcode.get_content()).str()
}

fn Class_WC_Shortcodes.product_categories(var_atts rt.PhpVal) string {
	mut var_atts_mutated := var_atts
	if var_atts_mutated.array_isset(rt.new_string('number')) {
		var_atts_mutated.array_set('limit', var_atts_mutated.array_get('number'))
	}
	var_atts_mutated = rt.call_function('shortcode_atts', [rt.create_array([rt.ArrayItem{ key: 'limit', val: '-1' }, rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'hide_empty', val: 1 }, rt.ArrayItem{ key: 'parent', val: '' }, rt.ArrayItem{ key: 'ids', val: '' }]), var_atts_mutated.dup(), rt.new_string('product_categories')])
	mut var_ids := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_atts_mutated.array_get('ids')])])])
	mut var_hide_empty := rt.new_int(if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), var_atts_mutated.array_get('hide_empty'))) || rt.is_true(rt.identical(rt.new_string('true'), var_atts_mutated.array_get('hide_empty'))))) || rt.is_true(rt.identical(rt.new_int(1), var_atts_mutated.array_get('hide_empty'))))) || rt.is_true(rt.identical(rt.new_string('1'), var_atts_mutated.array_get('hide_empty'))))) { rt.new_int(1) } else { rt.new_int(0) })
	mut var_args := { 'orderby': var_atts_mutated.array_get('orderby'), 'order': var_atts_mutated.array_get('order'), 'hide_empty': var_hide_empty, 'include': var_ids, 'pad_counts': rt.new_bool(true), 'child_of': var_atts_mutated.array_get('parent') }
	mut var_product_categories := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_categories'), rt.call_function('get_terms', [rt.new_string('product_cat'), var_args.dup()])])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_product_categories = rt.call_function('wp_list_filter', [var_product_categories.dup(), rt.create_array([rt.ArrayItem{ key: 'parent', val: var_atts_mutated.array_get('parent') }])])
	}
	if rt.is_true(var_hide_empty) {
		{
			mut iter_1 := var_product_categories.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_category := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_category, 'count'))) {
					var_product_categories.array_unset(var_key)
				}
			}
		}
	}
	var_atts_mutated.array_set('limit', if rt.is_true(rt.identical(rt.new_string('-1'), var_atts_mutated.array_get('limit'))) { rt.new_null() } else { rt.new_int(var_atts_mutated.array_get('limit').to_i64()) })
	if rt.is_true(var_atts_mutated.array_get('limit')) {
		var_product_categories = rt.call_function('array_slice', [var_product_categories.dup(), rt.new_int(0), var_atts_mutated.array_get('limit')])
	}
	mut var_columns := rt.call_function('absint', [var_atts_mutated.array_get('columns')])
	rt.call_function('wc_set_loop_prop', [rt.new_string('columns'), var_columns.dup()])
	rt.call_function('wc_set_loop_prop', [rt.new_string('is_shortcode'), rt.new_bool(true)])
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.is_true(var_product_categories) {
		rt.call_function('woocommerce_product_loop_start', []rt.PhpVal{})
		{
			mut iter_1 := var_product_categories.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_category := item_1.val
				rt.call_function('wc_get_template', [rt.new_string('content-product_cat.php'), rt.create_array([rt.ArrayItem{ key: 'category', val: var_category }])])
			}
		}
		rt.call_function('woocommerce_product_loop_end', []rt.PhpVal{})
	}
	rt.call_function('wc_reset_loop', []rt.PhpVal{})
	return '<div class="woocommerce columns-' + (var_columns).str() + '">' + (rt.call_function('ob_get_clean', []rt.PhpVal{})).str() + '</div>'
}

fn Class_WC_Shortcodes.recent_products(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'limit', val: '12' }, rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'category', val: '' }, rt.ArrayItem{ key: 'cat_operator', val: 'IN' }]), rt.cast_array(var_atts_mutated)])
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.dup(), rt.new_string('recent_products'))
	return var_shortcode.get_content()
}

fn Class_WC_Shortcodes.products(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.cast_array(var_atts_mutated)
	mut var_type := rt.new_string(rt.new_string('products'))
	if rt.is_true(rt.new_bool(var_atts_mutated.array_isset(rt.new_string('on_sale')) && rt.is_true(rt.call_function('wc_string_to_bool', [var_atts_mutated.array_get('on_sale')])))) {
		var_type = rt.new_string(rt.new_string('sale_products'))
	} else if rt.is_true(rt.new_bool(var_atts_mutated.array_isset(rt.new_string('best_selling')) && rt.is_true(rt.call_function('wc_string_to_bool', [var_atts_mutated.array_get('best_selling')])))) {
		var_type = rt.new_string(rt.new_string('best_selling_products'))
	} else if rt.is_true(rt.new_bool(var_atts_mutated.array_isset(rt.new_string('top_rated')) && rt.is_true(rt.call_function('wc_string_to_bool', [var_atts_mutated.array_get('top_rated')])))) {
		var_type = rt.new_string(rt.new_string('top_rated_products'))
	}
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.dup(), var_type.dup())
	return var_shortcode.get_content()
}

fn Class_WC_Shortcodes.product(var_atts rt.PhpVal) string {
	mut var_atts_mutated := var_atts
	if !rt.is_true(var_atts_mutated) {
		return ''
	}
	var_atts_mutated.array_set('skus', if var_atts_mutated.array_isset(rt.new_string('sku')) { var_atts_mutated.array_get('sku') } else { rt.new_string('') })
	var_atts_mutated.array_set('ids', if var_atts_mutated.array_isset(rt.new_string('id')) { var_atts_mutated.array_get('id') } else { rt.new_string('') })
	var_atts_mutated.array_set('limit', '1')
	mut var_shortcode := create_wc_shortcode_products(rt.cast_array(var_atts_mutated), rt.new_string('product'))
	return (var_shortcode.get_content()).str()
}

fn Class_WC_Shortcodes.product_add_to_cart(var_atts rt.PhpVal) string {
	mut var_post := rt.new_null()
	mut var_atts_mutated := var_atts
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_atts_mutated) {
		return ''
	}
	var_atts_mutated = rt.call_function('shortcode_atts', [rt.create_array([rt.ArrayItem{ key: 'id', val: '' }, rt.ArrayItem{ key: 'class', val: '' }, rt.ArrayItem{ key: 'quantity', val: '1' }, rt.ArrayItem{ key: 'sku', val: '' }, rt.ArrayItem{ key: 'style', val: 'border:4px solid #ccc; padding: 12px;' }, rt.ArrayItem{ key: 'show_price', val: 'true' }]), var_atts_mutated.dup(), rt.new_string('product_add_to_cart')])
	if !(!rt.is_true(var_atts_mutated.array_get('id'))) {
		mut var_product_data := rt.call_function('get_post', [var_atts_mutated.array_get('id')])
	} else if !(!rt.is_true(var_atts_mutated.array_get('sku'))) {
		mut var_product_id := rt.call_function('wc_get_product_id_by_sku', [var_atts_mutated.array_get('sku')])
		var_product_data = rt.call_function('get_post', [var_product_id.dup()])
	} else {
		return ''
	}
	mut var_product := if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_product_data.dup().is_object())) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_product_data, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)])))) { rt.call_function('wc_setup_product_data', [var_product_data.dup()]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	print('<p class="product woocommerce add_to_cart_inline ' + (rt.call_function('esc_attr', [var_atts_mutated.array_get('class')])).str() + '" style="' + (if !rt.is_true(var_atts_mutated.array_get('style')) { rt.new_string('') } else { rt.call_function('esc_attr', [var_atts_mutated.array_get('style')]) }).str() + '">')
	if rt.is_true(rt.call_function('wc_string_to_bool', [var_atts_mutated.array_get('show_price')])) {
		rt.echo_val(rt.call_method(var_product, 'get_price_html', []rt.PhpVal{}))
		// unsupported statement: Stmt_Nop
	}
	rt.call_function('woocommerce_template_loop_add_to_cart', [rt.create_array([rt.ArrayItem{ key: 'quantity', val: var_atts_mutated.array_get('quantity') }])])
	print('</p>')
	rt.call_function('wc_setup_product_data', [var_post.dup()])
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn Class_WC_Shortcodes.product_add_to_cart_url(var_atts rt.PhpVal) string {
	mut var_atts_mutated := var_atts
	if !rt.is_true(var_atts_mutated) {
		return ''
	}
	if var_atts_mutated.array_isset(rt.new_string('id')) {
		mut var_product_data := rt.call_function('get_post', [var_atts_mutated.array_get('id')])
	} else if var_atts_mutated.array_isset(rt.new_string('sku')) {
		mut var_product_id := rt.call_function('wc_get_product_id_by_sku', [var_atts_mutated.array_get('sku')])
		var_product_data = rt.call_function('get_post', [var_product_id.dup()])
	} else {
		return ''
	}
	mut var_product := if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_product_data.dup().is_object())) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_product_data, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)])))) { rt.call_function('wc_setup_product_data', [var_product_data.dup()]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	mut var__product := rt.call_function('wc_get_product', [var_product_data.dup()])
	return (rt.call_function('esc_url', [rt.call_method(var__product, 'add_to_cart_url', []rt.PhpVal{})])).str()
}

fn Class_WC_Shortcodes.sale_products(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'limit', val: '12' }, rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'orderby', val: 'title' }, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'category', val: '' }, rt.ArrayItem{ key: 'cat_operator', val: 'IN' }]), rt.cast_array(var_atts_mutated)])
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.dup(), rt.new_string('sale_products'))
	return var_shortcode.get_content()
}

fn Class_WC_Shortcodes.best_selling_products(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'limit', val: '12' }, rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'category', val: '' }, rt.ArrayItem{ key: 'cat_operator', val: 'IN' }]), rt.cast_array(var_atts_mutated)])
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.dup(), rt.new_string('best_selling_products'))
	return var_shortcode.get_content()
}

fn Class_WC_Shortcodes.top_rated_products(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'limit', val: '12' }, rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'orderby', val: 'title' }, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'category', val: '' }, rt.ArrayItem{ key: 'cat_operator', val: 'IN' }]), rt.cast_array(var_atts_mutated)])
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.dup(), rt.new_string('top_rated_products'))
	return var_shortcode.get_content()
}

fn Class_WC_Shortcodes.featured_products(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'limit', val: '12' }, rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'category', val: '' }, rt.ArrayItem{ key: 'cat_operator', val: 'IN' }]), rt.cast_array(var_atts_mutated)])
	var_atts_mutated.array_set('visibility', 'featured')
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.dup(), rt.new_string('featured_products'))
	return var_shortcode.get_content()
}

fn Class_WC_Shortcodes.product_page(var_atts rt.PhpVal) string {
	mut var_atts_mutated := var_atts
	if !rt.is_true(var_atts_mutated) {
		return ''
	}
	if !(var_atts_mutated.array_isset(rt.new_string('id'))) && !(var_atts_mutated.array_isset(rt.new_string('sku'))) {
		return 
	}
	
}

fn Class_WC_Shortcodes.shop_messages() string {
}

fn Class_WC_Shortcodes.order_by_rating_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn Class_WC_Shortcodes.product_attribute(var_atts rt.PhpVal) string {
	mut var_atts_mutated := var_atts
}

fn Class_WC_Shortcodes.related_products(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
}

struct Class_WC_Shortcode_Products {
	rt.PhpObjectBase
}

fn create_wc_shortcodes() &Class_WC_Shortcodes {
	mut obj := &Class_WC_Shortcodes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shortcode_products() &Class_WC_Shortcode_Products {
	mut obj := &Class_WC_Shortcode_Products{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Shortcodes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Shortcodes.init()
			return rt.new_null()
		}
		'shortcode_wrapper' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_Shortcodes.shortcode_wrapper(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'cart' {
			return Class_WC_Shortcodes.cart()
		}
		'checkout' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcodes.checkout(dispatch_arg_0)
		}
		'order_tracking' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcodes.order_tracking(dispatch_arg_0)
		}
		'my_account' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcodes.my_account(dispatch_arg_0)
		}
		'product_category' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Shortcodes.product_category(dispatch_arg_0))
		}
		'product_categories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Shortcodes.product_categories(dispatch_arg_0))
		}
		'recent_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcodes.recent_products(dispatch_arg_0)
		}
		'products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcodes.products(dispatch_arg_0)
		}
		'product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Shortcodes.product(dispatch_arg_0))
		}
		'product_add_to_cart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Shortcodes.product_add_to_cart(dispatch_arg_0))
		}
		'product_add_to_cart_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Shortcodes.product_add_to_cart_url(dispatch_arg_0))
		}
		'sale_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcodes.sale_products(dispatch_arg_0)
		}
		'best_selling_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcodes.best_selling_products(dispatch_arg_0)
		}
		'top_rated_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcodes.top_rated_products(dispatch_arg_0)
		}
		'featured_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcodes.featured_products(dispatch_arg_0)
		}
		'product_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Shortcodes.product_page(dispatch_arg_0))
		}
		'shop_messages' {
			return rt.new_string(Class_WC_Shortcodes.shop_messages())
		}
		'order_by_rating_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcodes.order_by_rating_post_clauses(dispatch_arg_0)
		}
		'product_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Shortcodes.product_attribute(dispatch_arg_0))
		}
		'related_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcodes.related_products(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Shortcodes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcodes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Shortcode_Products) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shortcode_Products) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcode_Products) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_shortcodes_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
