import rt

struct Class_WC_Widget_Cart {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Widget_Cart) construct()  {
	this.dispatch_set_prop('widget_cssclass', rt.new_string('woocommerce widget_shopping_cart'))
	this.dispatch_set_prop('widget_description', rt.call_function('__', [rt.new_string('Display the customer shopping cart.'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('widget_id', rt.new_string('woocommerce_widget_cart'))
	this.dispatch_set_prop('widget_name', rt.call_function('__', [rt.new_string('Cart'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('settings', rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'std', val: rt.call_function('__', [rt.new_string('Cart'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Title'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'hide_if_empty', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'std', val: 0 }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Hide if cart is empty'), rt.new_string('woocommerce')]) }]) }]))
	if rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})) {
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-cart-fragments')])
	}
	this.Class_WC_Widget.construct()
}

fn (mut this Class_WC_Widget_Cart) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_widget_cart_is_hidden'), rt.new_bool(rt.is_true(rt.call_function('is_cart', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})))])) {
		return rt.new_null()
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-cart-fragments')])
	mut var_hide_if_empty := rt.new_int(if !rt.is_true(var_instance_mutated.array_get('hide_if_empty')) { rt.new_int(0) } else { rt.new_int(1) })
	if !(var_instance_mutated.array_isset(rt.new_string('title'))) {
		var_instance_mutated.array_set('title', rt.call_function('__', [rt.new_string('Cart'), rt.new_string('woocommerce')]))
	}
	this.widget_start(var_args.dup(), var_instance_mutated.dup())
	if rt.is_true(var_hide_if_empty) {
		print('<div class="hide_cart_widget_if_empty">')
	}
	print('<div class="widget_shopping_cart_content"></div>')
	if rt.is_true(var_hide_if_empty) {
		print('</div>')
	}
	this.widget_end(var_args.dup())
}

struct Class_WC_Widget {
	rt.PhpObjectBase
}

fn create_wc_widget_cart() &Class_WC_Widget_Cart {
	mut obj := &Class_WC_Widget_Cart{
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

fn (mut this Class_WC_Widget_Cart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WC_Widget_Cart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget_Cart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_widgets_class_wc_widget_cart_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
