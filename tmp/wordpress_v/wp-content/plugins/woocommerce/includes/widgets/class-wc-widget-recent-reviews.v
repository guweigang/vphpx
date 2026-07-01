import rt

struct Class_WC_Widget_Recent_Reviews {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Widget_Recent_Reviews) construct()  {
	this.dispatch_set_prop('widget_cssclass', rt.new_string('woocommerce widget_recent_reviews'))
	this.dispatch_set_prop('widget_description', rt.call_function('__', [rt.new_string('Display a list of recent reviews from your store.'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('widget_id', rt.new_string('woocommerce_recent_reviews'))
	this.dispatch_set_prop('widget_name', rt.call_function('__', [rt.new_string('Recent Product Reviews'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('settings', rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'std', val: rt.call_function('__', [rt.new_string('Recent reviews'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Title'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'number', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'step', val: 1 }, rt.ArrayItem{ key: 'min', val: 1 }, rt.ArrayItem{ key: 'max', val: '' }, rt.ArrayItem{ key: 'std', val: 10 }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Number of reviews to show'), rt.new_string('woocommerce')]) }]) }]))
	this.Class_WC_Widget.construct()
}

fn (mut this Class_WC_Widget_Recent_Reviews) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	// unsupported statement: Stmt_Global
	if rt.is_true(this.get_cached_widget(var_args.dup())) {
		return rt.new_null()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_number := if !(!rt.is_true(var_instance.array_get('number'))) { rt.call_function('absint', [var_instance.array_get('number')]) } else { rt.get_property(rt.new_object('WC_Widget_Recent_Reviews', ['WC_Widget'], &this), 'settings').array_get('number').array_get('std') }
	mut var_comments := rt.call_function('get_comments', [rt.create_array([rt.ArrayItem{ key: 'number', val: var_number }, rt.ArrayItem{ key: 'status', val: 'approve' }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'parent', val: 0 }, rt.ArrayItem{ key: 'update_comment_post_cache', val: true }])])
	if rt.is_true(var_comments) {
		this.widget_start(var_args.dup(), var_instance.dup())
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_before_widget_product_review_list'), rt.new_string('<ul class="product_list_widget">')])]))
		{
			mut iter_1 := rt.cast_array(var_comments).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_comment := item_1.val
				rt.call_function('wc_get_template', [rt.new_string('content-widget-reviews.php'), rt.create_array([rt.ArrayItem{ key: 'comment', val: var_comment }, rt.ArrayItem{ key: 'product', val: rt.call_function('wc_get_product', [rt.get_property(var_comment, 'comment_post_ID')]) }])])
			}
		}
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_after_widget_product_review_list'), rt.new_string('</ul>')])]))
		this.widget_end(var_args.dup())
	}
	mut var_content := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.echo_val(var_content)
	this.cache_widget(var_args.dup(), var_content.dup())
}

struct Class_WC_Widget {
	rt.PhpObjectBase
}

fn create_wc_widget_recent_reviews() &Class_WC_Widget_Recent_Reviews {
	mut obj := &Class_WC_Widget_Recent_Reviews{
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

fn (mut this Class_WC_Widget_Recent_Reviews) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WC_Widget_Recent_Reviews) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget_Recent_Reviews) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_widgets_class_wc_widget_recent_reviews_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
