import rt

struct Class_WC_Widget_Product_Search {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Widget_Product_Search) construct() {
	this.dispatch_set_prop('widget_cssclass', rt.new_string('woocommerce widget_product_search'))
	this.dispatch_set_prop('widget_description', rt.call_function('__', [
		rt.new_string('A search form for your store.'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('widget_id', rt.new_string('woocommerce_product_search'))
	this.dispatch_set_prop('widget_name', rt.call_function('__', [
		rt.new_string('Product Search'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('settings', rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'std', val: '' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Title'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	]))
	this.Class_WC_Widget.construct()
}

fn (mut this Class_WC_Widget_Product_Search) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	this.widget_start(var_args.clone(), var_instance.clone())
	rt.call_function('get_product_search_form', []rt.PhpVal{})
	this.widget_end(var_args.clone())
}

struct Class_WC_Widget {
	rt.PhpObjectBase
}

fn create_wc_widget_product_search() &Class_WC_Widget_Product_Search {
	mut obj := &Class_WC_Widget_Product_Search{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_widget(_args ...rt.PhpVal) &Class_WC_Widget {
	mut obj := &Class_WC_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Widget_Product_Search) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else {
			return none
		}
	}
}

fn (this &Class_WC_Widget_Product_Search) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget_Product_Search) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
