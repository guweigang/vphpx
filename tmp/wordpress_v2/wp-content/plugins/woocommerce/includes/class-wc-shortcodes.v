import rt

struct Class_WC_Shortcodes {
	rt.PhpObjectBase
}

fn Class_WC_Shortcodes.init() {
	mut var_shortcodes := {
		'product':                    @STRUCT + '::product'
		'product_page':               @STRUCT + '::product_page'
		'product_category':           @STRUCT + '::product_category'
		'product_categories':         @STRUCT + '::product_categories'
		'add_to_cart':                @STRUCT + '::product_add_to_cart'
		'add_to_cart_url':            @STRUCT + '::product_add_to_cart_url'
		'products':                   @STRUCT + '::products'
		'recent_products':            @STRUCT + '::recent_products'
		'sale_products':              @STRUCT + '::sale_products'
		'best_selling_products':      @STRUCT + '::best_selling_products'
		'top_rated_products':         @STRUCT + '::top_rated_products'
		'featured_products':          @STRUCT + '::featured_products'
		'product_attribute':          @STRUCT + '::product_attribute'
		'related_products':           @STRUCT + '::related_products'
		'shop_messages':              @STRUCT + '::shop_messages'
		'woocommerce_order_tracking': @STRUCT + '::order_tracking'
		'woocommerce_cart':           @STRUCT + '::cart'
		'woocommerce_checkout':       @STRUCT + '::checkout'
		'woocommerce_my_account':     @STRUCT + '::my_account'
	}
	for var_shortcode, var_function in var_shortcodes {
		rt.call_function('add_shortcode', [
			rt.call_function('apply_filters', [
				rt.new_string('${var_shortcode}_shortcode_tag'),
				rt.new_string(shortcode),
			]),
			rt.new_string(function),
		])
	}
	rt.call_function('add_shortcode', [rt.new_string('woocommerce_messages'),
		rt.new_string(@STRUCT + '::shop_messages')])
}

fn Class_WC_Shortcodes.shortcode_wrapper(var_function rt.PhpVal, var_atts rt.PhpVal, var_wrapper rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.echo_val(if !rt.is_true(var_wrapper.array_get(rt.new_string('before'))) {
		'<div class="' +
			(rt.call_function('esc_attr', [var_wrapper.array_get(rt.new_string('class'))])).str() +
			'">'
	} else {
		var_wrapper.array_get(rt.new_string('before'))
	})
	rt.call_function('call_user_func', [var_function.clone(),
		var_atts_mutated.clone()])
	rt.echo_val(if !rt.is_true(var_wrapper.array_get(rt.new_string('after'))) {
		rt.new_string('</div>')
	} else {
		var_wrapper.array_get(rt.new_string('after'))
	})
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn Class_WC_Shortcodes.cart() rt.PhpVal {
	return if rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart').is_null() { rt.new_string('') } else { Class_WC_Shortcodes.shortcode_wrapper(rt.create_array([
			rt.ArrayItem{ key: none, val: 'WC_Shortcode_Cart' },
			rt.ArrayItem{ key: none, val: 'output' },
		])) }
}

fn Class_WC_Shortcodes.checkout(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	return Class_WC_Shortcodes.shortcode_wrapper(rt.create_array([
		rt.ArrayItem{ key: none, val: 'WC_Shortcode_Checkout' },
		rt.ArrayItem{ key: none, val: 'output' },
	]), var_atts_mutated.clone())
}

fn Class_WC_Shortcodes.order_tracking(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	return Class_WC_Shortcodes.shortcode_wrapper(rt.create_array([
		rt.ArrayItem{ key: none, val: 'WC_Shortcode_Order_Tracking' },
		rt.ArrayItem{ key: none, val: 'output' },
	]), var_atts_mutated.clone())
}

fn Class_WC_Shortcodes.my_account(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	return Class_WC_Shortcodes.shortcode_wrapper(rt.create_array([
		rt.ArrayItem{ key: none, val: 'WC_Shortcode_My_Account' },
		rt.ArrayItem{ key: none, val: 'output' },
	]), var_atts_mutated.clone())
}

fn Class_WC_Shortcodes.product_category(var_atts rt.PhpVal) string {
	mut var_atts_mutated := var_atts
	if !rt.is_true(var_atts_mutated.array_get(rt.new_string('category'))) {
		return ''
	}
	var_atts_mutated = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'limit', val: '12' },
			rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{
				key: 'orderby'
				val: 'menu_order title'
			}, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'category', val: '' },
			rt.ArrayItem{ key: 'cat_operator', val: 'IN' }]),
		rt.cast_array(var_atts_mutated),
	])
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.clone(),
		rt.new_string('product_category'))
	return (var_shortcode.get_content()).str()
}

fn Class_WC_Shortcodes.product_categories(var_atts rt.PhpVal) string {
	mut var_atts_mutated := var_atts
	if var_atts_mutated.array_isset(rt.new_string('number')) {
		var_atts_mutated.array_set('limit', var_atts_mutated.array_get(rt.new_string('number')))
	}
	var_atts_mutated = rt.call_function('shortcode_atts', [
		rt.create_array([rt.ArrayItem{ key: 'limit', val: '-1' },
			rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'order', val: 'ASC' },
			rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'hide_empty', val: 1 },
			rt.ArrayItem{ key: 'parent', val: '' }, rt.ArrayItem{ key: 'ids', val: '' }]),
		var_atts_mutated.clone(),
		rt.new_string('product_categories'),
	])
	mut var_ids := rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_string('trim'),
			rt.call_function('explode',
				[rt.new_string(','), var_atts_mutated.array_get(rt.new_string('ids'))])]),
	])
	mut var_hide_empty := rt.new_int(if
		rt.is_true(rt.identical(rt.new_bool(true), var_atts_mutated.array_get(rt.new_string('hide_empty'))))
		|| rt.is_true(rt.identical(rt.new_string('true'), var_atts_mutated.array_get(rt.new_string('hide_empty'))))
		|| rt.is_true(rt.identical(rt.new_int(1), var_atts_mutated.array_get(rt.new_string('hide_empty'))))
		|| rt.is_true(rt.identical(rt.new_string('1'), var_atts_mutated.array_get(rt.new_string('hide_empty')))) {
		1
	} else {
		0
	})
	mut var_args := {
		'orderby':    var_atts_mutated.array_get(rt.new_string('orderby'))
		'order':      var_atts_mutated.array_get(rt.new_string('order'))
		'hide_empty': var_hide_empty
		'include':    var_ids
		'pad_counts': rt.new_bool(true)
		'child_of':   var_atts_mutated.array_get(rt.new_string('parent'))
	}
	mut var_product_categories := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_categories'),
		rt.call_function('get_terms', [rt.new_string('product_cat'),
			rt.create_array_from_native_map(var_args)]),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		var_atts_mutated.array_get(rt.new_string('parent'))))))
	{
		var_product_categories = rt.call_function('wp_list_filter', [
			var_product_categories.clone(),
			rt.create_array([
				rt.ArrayItem{
					key: 'parent'
					val: var_atts_mutated.array_get(rt.new_string('parent'))
				},
			])])
	}
	if rt.is_true(var_hide_empty) {
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
	var_atts_mutated.array_set('limit', if rt.is_true(rt.identical(rt.new_string('-1'),
		var_atts_mutated.array_get(rt.new_string('limit'))))
	{
		rt.new_null()
	} else {
		rt.new_int(var_atts_mutated.array_get(rt.new_string('limit')).to_i64())
	})
	if rt.is_true(var_atts_mutated.array_get(rt.new_string('limit'))) {
		var_product_categories = rt.call_function('array_slice', [
			var_product_categories.clone(), rt.new_int(0), var_atts_mutated.array_get(rt.new_string('limit'))])
	}
	mut var_columns := rt.call_function('absint', [
		var_atts_mutated.array_get(rt.new_string('columns')),
	])
	rt.call_function('wc_set_loop_prop', [rt.new_string('columns'),
		var_columns.clone()])
	rt.call_function('wc_set_loop_prop', [rt.new_string('is_shortcode'),
		rt.new_bool(true)])
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.is_true(var_product_categories) {
		rt.call_function('woocommerce_product_loop_start', []rt.PhpVal{})
		mut iter_2 := var_product_categories.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_category := item_2.val
			rt.call_function('wc_get_template', [
				rt.new_string('content-product_cat.php'),
				rt.create_array([rt.ArrayItem{ key: 'category', val: var_category }]),
			])
		}
		rt.call_function('woocommerce_product_loop_end', []rt.PhpVal{})
	}
	rt.call_function('wc_reset_loop', []rt.PhpVal{})
	return '<div class="woocommerce columns-' + var_columns.str() + '">' +
		(rt.call_function('ob_get_clean', []rt.PhpVal{})).str() + '</div>'
}

fn Class_WC_Shortcodes.recent_products(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'limit', val: '12' },
			rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'orderby', val: 'date' },
			rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'category', val: '' },
			rt.ArrayItem{ key: 'cat_operator', val: 'IN' }]),
		rt.cast_array(var_atts_mutated),
	])
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.clone(),
		rt.new_string('recent_products'))
	return var_shortcode.get_content()
}

fn Class_WC_Shortcodes.products(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.cast_array(var_atts_mutated)
	mut var_type := rt.new_string('products')
	if var_atts_mutated.array_isset(rt.new_string('on_sale'))
		&& rt.is_true(rt.call_function('wc_string_to_bool', [var_atts_mutated.array_get(rt.new_string('on_sale'))])) {
		var_type = rt.new_string('sale_products')
	} else if var_atts_mutated.array_isset(rt.new_string('best_selling'))
		&& rt.is_true(rt.call_function('wc_string_to_bool', [var_atts_mutated.array_get(rt.new_string('best_selling'))])) {
		var_type = rt.new_string('best_selling_products')
	} else if var_atts_mutated.array_isset(rt.new_string('top_rated'))
		&& rt.is_true(rt.call_function('wc_string_to_bool', [var_atts_mutated.array_get(rt.new_string('top_rated'))])) {
		var_type = rt.new_string('top_rated_products')
	}
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.clone(), var_type.clone())
	return var_shortcode.get_content()
}

fn Class_WC_Shortcodes.product(var_atts rt.PhpVal) string {
	mut var_atts_mutated := var_atts
	if !rt.is_true(var_atts_mutated) {
		return ''
	}
	var_atts_mutated.array_set('skus', if var_atts_mutated.array_isset(rt.new_string('sku')) {
		var_atts_mutated.array_get(rt.new_string('sku'))
	} else {
		rt.new_string('')
	})
	var_atts_mutated.array_set('ids', if var_atts_mutated.array_isset(rt.new_string('id')) {
		var_atts_mutated.array_get(rt.new_string('id'))
	} else {
		rt.new_string('')
	})
	var_atts_mutated.array_set('limit', '1')
	mut var_shortcode := create_wc_shortcode_products(rt.cast_array(var_atts_mutated),
		rt.new_string('product'))
	return (var_shortcode.get_content()).str()
}

fn Class_WC_Shortcodes.product_add_to_cart(var_atts rt.PhpVal) string {
	mut var_post := rt.new_null()
	mut var_atts_mutated := var_atts
	if !rt.is_true(var_atts_mutated) {
		return ''
	}
	var_atts_mutated = rt.call_function('shortcode_atts', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: '' }, rt.ArrayItem{ key: 'class', val: '' },
			rt.ArrayItem{ key: 'quantity', val: '1' }, rt.ArrayItem{ key: 'sku', val: '' },
			rt.ArrayItem{ key: 'style', val: 'border:4px solid #ccc; padding: 12px;' },
			rt.ArrayItem{ key: 'show_price', val: 'true' }]),
		var_atts_mutated.clone(),
		rt.new_string('product_add_to_cart'),
	])
	if !(!rt.is_true(var_atts_mutated.array_get(rt.new_string('id')))) {
		mut var_product_data := rt.call_function('get_post', [
			var_atts_mutated.array_get(rt.new_string('id')),
		])
	} else if !(!rt.is_true(var_atts_mutated.array_get(rt.new_string('sku')))) {
		mut var_product_id := rt.call_function('wc_get_product_id_by_sku', [
			var_atts_mutated.array_get(rt.new_string('sku')),
		])
		var_product_data = rt.call_function('get_post', [var_product_id.clone()])
	} else {
		return ''
	}
	mut var_product := if var_product_data.clone().is_object() && rt.is_true(rt.call_function('in_array', [rt.get_property(var_product_data, 'post_type'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'product'
	}, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)])) { rt.call_function('wc_setup_product_data', [
			var_product_data.clone(),
		]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	print('<p class="product woocommerce add_to_cart_inline ' +
		(rt.call_function('esc_attr', [var_atts_mutated.array_get(rt.new_string('class'))])).str() +
		'" style="' +
		(if !rt.is_true(var_atts_mutated.array_get(rt.new_string('style'))) { rt.new_string('') } else { rt.call_function('esc_attr', [var_atts_mutated.array_get(rt.new_string('style'))]) }).str() +
		'">')
	if rt.is_true(rt.call_function('wc_string_to_bool', [
		var_atts_mutated.array_get(rt.new_string('show_price')),
	]))
	{
		rt.echo_val(rt.call_method(var_product, 'get_price_html', []rt.PhpVal{}))
	}
	rt.call_function('woocommerce_template_loop_add_to_cart', [
		rt.create_array([
			rt.ArrayItem{
				key: 'quantity'
				val: var_atts_mutated.array_get(rt.new_string('quantity'))
			},
		]),
	])
	print('</p>')
	rt.call_function('wc_setup_product_data', [var_post.clone()])
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn Class_WC_Shortcodes.product_add_to_cart_url(var_atts rt.PhpVal) string {
	mut var_atts_mutated := var_atts
	if !rt.is_true(var_atts_mutated) {
		return ''
	}
	if var_atts_mutated.array_isset(rt.new_string('id')) {
		mut var_product_data := rt.call_function('get_post', [
			var_atts_mutated.array_get(rt.new_string('id')),
		])
	} else if var_atts_mutated.array_isset(rt.new_string('sku')) {
		mut var_product_id := rt.call_function('wc_get_product_id_by_sku', [
			var_atts_mutated.array_get(rt.new_string('sku')),
		])
		var_product_data = rt.call_function('get_post', [var_product_id.clone()])
	} else {
		return ''
	}
	mut var_product := if var_product_data.clone().is_object() && rt.is_true(rt.call_function('in_array', [rt.get_property(var_product_data, 'post_type'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'product'
	}, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)])) { rt.call_function('wc_setup_product_data', [
			var_product_data.clone(),
		]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	mut var__product := rt.call_function('wc_get_product', [var_product_data.clone()])
	return (rt.call_function('esc_url', [
		rt.call_method(var__product, 'add_to_cart_url', []rt.PhpVal{}),
	])).str()
}

fn Class_WC_Shortcodes.sale_products(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'limit', val: '12' },
			rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'orderby', val: 'title' },
			rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'category', val: '' },
			rt.ArrayItem{ key: 'cat_operator', val: 'IN' }]),
		rt.cast_array(var_atts_mutated),
	])
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.clone(),
		rt.new_string('sale_products'))
	return var_shortcode.get_content()
}

fn Class_WC_Shortcodes.best_selling_products(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'limit', val: '12' },
			rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'category', val: '' },
			rt.ArrayItem{ key: 'cat_operator', val: 'IN' }]),
		rt.cast_array(var_atts_mutated),
	])
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.clone(),
		rt.new_string('best_selling_products'))
	return var_shortcode.get_content()
}

fn Class_WC_Shortcodes.top_rated_products(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'limit', val: '12' },
			rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'orderby', val: 'title' },
			rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'category', val: '' },
			rt.ArrayItem{ key: 'cat_operator', val: 'IN' }]),
		rt.cast_array(var_atts_mutated),
	])
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.clone(),
		rt.new_string('top_rated_products'))
	return var_shortcode.get_content()
}

fn Class_WC_Shortcodes.featured_products(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'limit', val: '12' },
			rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'orderby', val: 'date' },
			rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'category', val: '' },
			rt.ArrayItem{ key: 'cat_operator', val: 'IN' }]),
		rt.cast_array(var_atts_mutated),
	])
	var_atts_mutated.array_set('visibility', 'featured')
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.clone(),
		rt.new_string('featured_products'))
	return var_shortcode.get_content()
}

fn Class_WC_Shortcodes.product_page(var_atts rt.PhpVal) string {
	mut var_atts_mutated := var_atts
	if !rt.is_true(var_atts_mutated) {
		return ''
	}
	if !(var_atts_mutated.array_isset(rt.new_string('id')))
		&& !(var_atts_mutated.array_isset(rt.new_string('sku'))) {
		return ''
	}
	mut var_product_id := if var_atts_mutated.array_isset(rt.new_string('id')) { rt.call_function('absint', [
			var_atts_mutated.array_get(rt.new_string('id')),
		]) } else { rt.new_int(0) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_id))))
		&& var_atts_mutated.array_isset(rt.new_string('sku')) {
		var_product_id = rt.call_function('wc_get_product_id_by_sku', [
			var_atts_mutated.array_get(rt.new_string('sku')),
		])
	}
	mut var_product_status := if !rt.is_true(var_atts_mutated.array_get(rt.new_string('status'))) {
		Class_Automattic_WooCommerce_Enums_ProductStatus.publish()
	} else {
		var_atts_mutated.array_get(rt.new_string('status'))
	}
	mut var_invalid_statuses := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shortcode_product_page_invalid_statuses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.trash() },
		]),
		var_product_id.clone(),
	])
	if rt.is_true(rt.call_function('in_array', [var_product_status.clone(),
		var_invalid_statuses.clone(), rt.new_bool(true)]))
	{
		return ''
	}
	mut var_force_rendering := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shortcode_product_page_force_rendering'),
		rt.new_null(),
		var_product_id.clone(),
	])
	if !var_force_rendering.is_null() && rt.is_true(rt.new_bool(!(rt.is_true(var_force_rendering)))) {
		return ''
	}
	mut var_args := {
		'posts_per_page':      rt.new_int(1)
		'post_type':           rt.new_string('product')
		'post_status':         var_product_status
		'ignore_sticky_posts': rt.new_int(1)
		'no_found_rows':       rt.new_int(1)
	}
	if var_atts_mutated.array_isset(rt.new_string('sku')) {
		var_args.array_get_mut('meta_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'key', val: '_sku' },
			rt.ArrayItem{ key: 'value', val: rt.call_function('sanitize_text_field', [
				var_atts_mutated.array_get(rt.new_string('sku')),
			]) },
			rt.ArrayItem{ key: 'compare', val: '=' },
		]))
		var_args['post_type'] = rt.create_array([
			rt.ArrayItem{ key: none, val: 'product' },
			rt.ArrayItem{ key: none, val: 'product_variation' },
		])
	}
	if var_atts_mutated.array_isset(rt.new_string('id')) {
		var_args['p'] = rt.call_function('absint',
			[var_atts_mutated.array_get(rt.new_string('id'))])
	}
	if var_atts_mutated.array_isset(rt.new_string('show_title'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_atts_mutated.array_get(rt.new_string('show_title')))))) {
		rt.call_function('remove_action', [
			rt.new_string('woocommerce_single_product_summary'),
			rt.new_string('woocommerce_template_single_title'),
			rt.new_int(5),
		])
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_add_to_cart_form_action'),
		rt.new_string('__return_empty_string')])
	mut var_single_product := create_wp_query(var_args.clone())
	if !(!var_force_rendering.is_null()) && rt.is_true(var_single_product.have_posts())
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), rt.get_property(rt.get_property(var_single_product, 'post'), 'post_status')))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_product'), rt.get_property(rt.get_property(var_single_product, 'post'), 'ID')]))))) {
		return ''
	}
	mut var_preselected_id := rt.new_string('0')
	if var_atts_mutated.array_isset(rt.new_string('sku'))
		&& rt.is_true(var_single_product.have_posts())
		&& rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(rt.get_property(var_single_product, 'post'), 'post_type'))) {
		mut var_variation := rt.call_function('wc_get_product_object', [
			Class_Automattic_WooCommerce_Enums_ProductType.variation(),
			rt.get_property(rt.get_property(var_single_product, 'post'), 'ID'),
		])
		mut var_attributes := rt.call_method(var_variation, 'get_attributes', []rt.PhpVal{})
		var_preselected_id = rt.get_property(rt.get_property(var_single_product, 'post'), 'ID')
		var_args = {
			'posts_per_page':      rt.new_int(1)
			'post_type':           rt.new_string('product')
			'post_status':         Class_Automattic_WooCommerce_Enums_ProductStatus.publish()
			'ignore_sticky_posts': rt.new_int(1)
			'no_found_rows':       rt.new_int(1)
			'p':                   rt.get_property(rt.get_property(var_single_product, 'post'),
				'post_parent')
		}
		var_single_product = create_wp_query(var_args.clone())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_preselected_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		mut iter_3 := var_attributes.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_value := item_3.val
			mut var_attr := item_3.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_attr.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_js', [var_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	rt.set_property(var_single_product, 'is_single', rt.new_bool(true))
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_wp_query := rt.get_superglobal('wp_query')
	mut var_previous_wp_query := var_wp_query.clone()
	var_wp_query = var_single_product
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-single-product')])
	for rt.is_true(var_single_product.have_posts()) {
		var_single_product.the_post()
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_preselected_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wc_get_template_part', [rt.new_string('content'),
			rt.new_string('single-product')])
		// unsupported statement: Stmt_InlineHTML
	}
	var_wp_query = var_previous_wp_query.clone()
	rt.call_function('wp_reset_postdata', []rt.PhpVal{})
	if var_atts_mutated.array_isset(rt.new_string('show_title'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_atts_mutated.array_get(rt.new_string('show_title')))))) {
		rt.call_function('add_action', [
			rt.new_string('woocommerce_single_product_summary'),
			rt.new_string('woocommerce_template_single_title'),
			rt.new_int(5),
		])
	}
	rt.call_function('remove_filter', [
		rt.new_string('woocommerce_add_to_cart_form_action'),
		rt.new_string('__return_empty_string'),
	])
	return '<div class="woocommerce">' + (rt.call_function('ob_get_clean', []rt.PhpVal{})).str() +
		'</div>'
}

fn Class_WC_Shortcodes.shop_messages() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_print_notices'),
	])))))
	{
		return ''
	}
	return '<div class="woocommerce">' +
		(rt.call_function('wc_print_notices', [rt.new_bool(true)])).str() + '</div>'
}

fn Class_WC_Shortcodes.order_by_rating_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut iife_temp_0 := Class_WC_Shortcode_Products{}
	mut iife_result_0 := iife_temp_0.order_by_rating_post_clauses(var_args_mutated.clone())
	return iife_result_0
}

fn Class_WC_Shortcodes.product_attribute(var_atts rt.PhpVal) string {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'limit', val: '12' },
			rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'orderby', val: 'title' },
			rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'attribute', val: '' },
			rt.ArrayItem{ key: 'terms', val: '' }]),
		rt.cast_array(var_atts_mutated),
	])
	if !rt.is_true(var_atts_mutated.array_get(rt.new_string('attribute'))) {
		return ''
	}
	mut var_shortcode := create_wc_shortcode_products(var_atts_mutated.clone(),
		rt.new_string('product_attribute'))
	return (var_shortcode.get_content()).str()
}

fn Class_WC_Shortcodes.related_products(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	if var_atts_mutated.array_isset(rt.new_string('per_page')) {
		var_atts_mutated.array_set('limit', var_atts_mutated.array_get(rt.new_string('per_page')))
	}
	var_atts_mutated = rt.call_function('shortcode_atts', [
		rt.create_array([rt.ArrayItem{ key: 'limit', val: '4' },
			rt.ArrayItem{ key: 'columns', val: '4' }, rt.ArrayItem{ key: 'orderby', val: 'rand' }]),
		var_atts_mutated.clone(),
		rt.new_string('related_products'),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	var_atts_mutated.array_set('posts_per_page', rt.call_function('absint', [
		var_atts_mutated.array_get(rt.new_string('limit')),
	]))
	rt.call_function('woocommerce_related_products', [var_atts_mutated.clone()])
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

struct Class_WC_Shortcode_Products {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wc_shortcodes(_args ...rt.PhpVal) &Class_WC_Shortcodes {
	mut obj := &Class_WC_Shortcodes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shortcode_products(_args ...rt.PhpVal) &Class_WC_Shortcode_Products {
	mut obj := &Class_WC_Shortcode_Products{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
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
			return Class_WC_Shortcodes.shortcode_wrapper(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
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
		else {
			return none
		}
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

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
