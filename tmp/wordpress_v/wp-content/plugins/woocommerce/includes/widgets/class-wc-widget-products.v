import rt

struct Class_WC_Widget_Products {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Widget_Products) construct()  {
	this.dispatch_set_prop('widget_cssclass', rt.new_string('woocommerce widget_products'))
	this.dispatch_set_prop('widget_description', rt.call_function('__', [rt.new_string('A list of your store\'s products.'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('widget_id', rt.new_string('woocommerce_products'))
	this.dispatch_set_prop('widget_name', rt.call_function('__', [rt.new_string('Products list'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('settings', rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'std', val: rt.call_function('__', [rt.new_string('Products'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Title'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'number', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'step', val: 1 }, rt.ArrayItem{ key: 'min', val: 1 }, rt.ArrayItem{ key: 'max', val: '' }, rt.ArrayItem{ key: 'std', val: 5 }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Number of products to show'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'show', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'std', val: '' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Show'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('All products'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'featured', val: rt.call_function('__', [rt.new_string('Featured products'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'onsale', val: rt.call_function('__', [rt.new_string('On-sale products'), rt.new_string('woocommerce')]) }]) }]) }, rt.ArrayItem{ key: 'orderby', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'std', val: 'date' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Order by'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'menu_order', val: rt.call_function('__', [rt.new_string('Menu order'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'date', val: rt.call_function('__', [rt.new_string('Date'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'price', val: rt.call_function('__', [rt.new_string('Price'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'rand', val: rt.call_function('__', [rt.new_string('Random'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'sales', val: rt.call_function('__', [rt.new_string('Sales'), rt.new_string('woocommerce')]) }]) }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'std', val: 'desc' }, rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Order'), rt.new_string('Sorting order'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'asc', val: rt.call_function('__', [rt.new_string('ASC'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('DESC'), rt.new_string('woocommerce')]) }]) }]) }, rt.ArrayItem{ key: 'hide_free', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'std', val: 0 }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Hide free products'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'show_hidden', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'std', val: 0 }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Show hidden products'), rt.new_string('woocommerce')]) }]) }]))
	this.Class_WC_Widget.construct()
}

fn (mut this Class_WC_Widget_Products) get_products(var_args rt.PhpVal, var_instance rt.PhpVal) rt.PhpVal {
	mut var_number := if !(!rt.is_true(var_instance.array_get('number'))) { rt.call_function('absint', [var_instance.array_get('number')]) } else { rt.get_property(rt.new_object('WC_Widget_Products', ['WC_Widget'], &this), 'settings').array_get('number').array_get('std') }
	mut var_show := if !(!rt.is_true(var_instance.array_get('show'))) { rt.call_function('sanitize_title', [var_instance.array_get('show')]) } else { rt.get_property(rt.new_object('WC_Widget_Products', ['WC_Widget'], &this), 'settings').array_get('show').array_get('std') }
	mut var_orderby := if !(!rt.is_true(var_instance.array_get('orderby'))) { rt.call_function('sanitize_title', [var_instance.array_get('orderby')]) } else { rt.get_property(rt.new_object('WC_Widget_Products', ['WC_Widget'], &this), 'settings').array_get('orderby').array_get('std') }
	mut var_order := if !(!rt.is_true(var_instance.array_get('order'))) { rt.call_function('sanitize_title', [var_instance.array_get('order')]) } else { rt.get_property(rt.new_object('WC_Widget_Products', ['WC_Widget'], &this), 'settings').array_get('order').array_get('std') }
	mut var_product_visibility_term_ids := rt.call_function('wc_get_product_visibility_term_ids', []rt.PhpVal{})
	mut var_query_args := { 'posts_per_page': var_number, 'post_status': rt.new_string('publish'), 'post_type': rt.new_string('product'), 'no_found_rows': rt.new_int(1), 'order': var_order, 'meta_query': map[string]rt.PhpVal{}, 'tax_query': { 'relation': rt.new_string('AND') } }
	if !rt.is_true(var_instance.array_get('show_hidden')) {
		var_query_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' }, rt.ArrayItem{ key: 'terms', val: if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) { var_product_visibility_term_ids.array_get('exclude-from-search') } else { var_product_visibility_term_ids.array_get('exclude-from-catalog') } }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }]))
		var_query_args['post_parent'] = rt.new_int(0)
	}
	if !(!rt.is_true(var_instance.array_get('hide_free'))) {
		var_query_args.array_get_mut('meta_query').array_push(rt.create_array([rt.ArrayItem{ key: 'key', val: '_price' }, rt.ArrayItem{ key: 'value', val: 0 }, rt.ArrayItem{ key: 'compare', val: '>' }, rt.ArrayItem{ key: 'type', val: 'DECIMAL' }]))
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))) {
		var_query_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' }, rt.ArrayItem{ key: 'terms', val: var_product_visibility_term_ids.array_get(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock()) }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }]) }]))
		// unsupported statement: Stmt_Nop
	}
	mut switch_val_1 := var_show
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('featured'))) {
		var_query_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' }, rt.ArrayItem{ key: 'terms', val: var_product_visibility_term_ids.array_get('featured') }]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('onsale'))) {
		mut var_product_ids_on_sale := rt.call_function('wc_get_product_ids_on_sale', []rt.PhpVal{})
		var_product_ids_on_sale.array_push(0)
		var_query_args['post__in'] = var_product_ids_on_sale.dup()
	}
	mut switch_val_2 := var_orderby
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('menu_order'))) {
		var_query_args['orderby'] = rt.new_string('menu_order')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('price'))) {
		var_query_args['meta_key'] = rt.new_string('_price')
		var_query_args['orderby'] = rt.new_string('meta_value_num')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('rand'))) {
		var_query_args['orderby'] = rt.new_string('rand')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('sales'))) {
		var_query_args['meta_key'] = rt.new_string('total_sales')
		var_query_args['orderby'] = rt.new_string('meta_value_num')
	} else {
		var_query_args['orderby'] = rt.new_string('date')
	}
	return create_wp_query(rt.call_function('apply_filters', [rt.new_string('woocommerce_products_widget_query_args'), var_query_args.dup()]))
}

fn (mut this Class_WC_Widget_Products) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	if rt.is_true(this.get_cached_widget(var_args.dup())) {
		return rt.new_null()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wc_set_loop_prop', [rt.new_string('name'), rt.new_string('widget')])
	mut var_products := this.get_products(var_args.dup(), var_instance.dup())
	if rt.is_true(rt.new_bool(rt.is_true(var_products) && rt.is_true(rt.call_method(var_products, 'have_posts', []rt.PhpVal{})))) {
		this.widget_start(var_args.dup(), var_instance.dup())
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_before_widget_product_list'), rt.new_string('<ul class="product_list_widget">')])]))
		mut var_template_args := { 'widget_id': if var_args.array_isset(rt.new_string('widget_id')) { var_args.array_get('widget_id') } else { rt.get_property(rt.new_object('WC_Widget_Products', ['WC_Widget'], &this), 'widget_id') }, 'show_rating': rt.new_bool(true) }
		for rt.is_true(rt.call_method(var_products, 'have_posts', []rt.PhpVal{})) {
			rt.call_method(var_products, 'the_post', []rt.PhpVal{})
			rt.call_function('wc_get_template', [rt.new_string('content-widget-product.php'), var_template_args.dup()])
		}
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_after_widget_product_list'), rt.new_string('</ul>')])]))
		this.widget_end(var_args.dup())
	}
	rt.call_function('wp_reset_postdata', []rt.PhpVal{})
	rt.echo_val(this.cache_widget(var_args.dup(), rt.call_function('ob_get_clean', []rt.PhpVal{})))
	// unsupported statement: Stmt_Nop
}

struct Class_WC_Widget {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wc_widget_products() &Class_WC_Widget_Products {
	mut obj := &Class_WC_Widget_Products{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_widget() &Class_WC_Widget {
	mut obj := &Class_WC_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Widget_Products) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_products(dispatch_arg_0, dispatch_arg_1)
		}
		'widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.widget(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Widget_Products) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget_Products) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_widgets_class_wc_widget_products_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
