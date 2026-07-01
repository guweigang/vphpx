import rt

struct Class_WC_Widget_Recently_Viewed {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Widget_Recently_Viewed) construct()  {
	this.dispatch_set_prop('widget_cssclass', rt.new_string('woocommerce widget_recently_viewed_products'))
	this.dispatch_set_prop('widget_description', rt.call_function('__', [rt.new_string('Display a list of a customer\'s recently viewed products.'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('widget_id', rt.new_string('woocommerce_recently_viewed_products'))
	this.dispatch_set_prop('widget_name', rt.call_function('__', [rt.new_string('Recently Viewed Products list'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('settings', rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'std', val: rt.call_function('__', [rt.new_string('Recently Viewed Products'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Title'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'number', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'step', val: 1 }, rt.ArrayItem{ key: 'min', val: 1 }, rt.ArrayItem{ key: 'max', val: 15 }, rt.ArrayItem{ key: 'std', val: 10 }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Number of products to show'), rt.new_string('woocommerce')]) }]) }]))
	this.Class_WC_Widget.construct()
}

fn (mut this Class_WC_Widget_Recently_Viewed) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	mut var_viewed_products := if !(!rt.is_true(rt.get_superglobal('_COOKIE').array_get('woocommerce_recently_viewed'))) { rt.cast_array(rt.call_function('explode', [rt.new_string('|'), rt.call_function('wp_unslash', [rt.get_superglobal('_COOKIE').array_get('woocommerce_recently_viewed')])])) } else { rt.new_array() }
	var_viewed_products = rt.call_function('array_reverse', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('absint'), var_viewed_products.dup()])])])
	if !rt.is_true(var_viewed_products) {
		return rt.new_null()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_number := if !(!rt.is_true(var_instance.array_get('number'))) { rt.call_function('absint', [var_instance.array_get('number')]) } else { rt.get_property(rt.new_object('WC_Widget_Recently_Viewed', ['WC_Widget'], &this), 'settings').array_get('number').array_get('std') }
	mut var_query_args := { 'posts_per_page': var_number, 'no_found_rows': rt.new_int(1), 'post_status': rt.new_string('publish'), 'post_type': rt.new_string('product'), 'post__in': var_viewed_products, 'orderby': rt.new_string('post__in') }
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))) {
		var_query_args['tax_query'] = rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'terms', val: Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock() }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }]) }])
		// unsupported statement: Stmt_Nop
	}
	mut var_r := create_wp_query(rt.call_function('apply_filters', [rt.new_string('woocommerce_recently_viewed_products_widget_query_args'), var_query_args.dup()]))
	if rt.is_true(var_r.have_posts()) {
		this.widget_start(var_args.dup(), var_instance.dup())
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_before_widget_product_list'), rt.new_string('<ul class="product_list_widget">')])]))
		mut var_template_args := { 'widget_id': if var_args.array_isset(rt.new_string('widget_id')) { var_args.array_get('widget_id') } else { rt.get_property(rt.new_object('WC_Widget_Recently_Viewed', ['WC_Widget'], &this), 'widget_id') } }
		for rt.is_true(var_r.have_posts()) {
			var_r.the_post()
			rt.call_function('wc_get_template', [rt.new_string('content-widget-product.php'), var_template_args.dup()])
		}
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_after_widget_product_list'), rt.new_string('</ul>')])]))
		this.widget_end(var_args.dup())
	}
	rt.call_function('wp_reset_postdata', []rt.PhpVal{})
	mut var_content := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.echo_val(var_content)
	// unsupported statement: Stmt_Nop
}

struct Class_WC_Widget {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wc_widget_recently_viewed() &Class_WC_Widget_Recently_Viewed {
	mut obj := &Class_WC_Widget_Recently_Viewed{
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

fn (mut this Class_WC_Widget_Recently_Viewed) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
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

fn (this &Class_WC_Widget_Recently_Viewed) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget_Recently_Viewed) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_widgets_class_wc_widget_recently_viewed_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
