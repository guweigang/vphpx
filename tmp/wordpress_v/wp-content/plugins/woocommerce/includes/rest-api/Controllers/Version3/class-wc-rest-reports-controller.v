import rt

struct Class_WC_REST_Reports_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
}

fn (mut this Class_WC_REST_Reports_Controller) get_reports() rt.PhpVal {
	mut var_reports := this.Class_WC_REST_Reports_V2_Controller.get_reports()
	var_reports.array_push(rt.create_array([rt.ArrayItem{ key: 'slug', val: 'orders/totals' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Orders totals.'), rt.new_string('woocommerce')]) }]))
	var_reports.array_push(rt.create_array([rt.ArrayItem{ key: 'slug', val: 'products/totals' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Products totals.'), rt.new_string('woocommerce')]) }]))
	var_reports.array_push(rt.create_array([rt.ArrayItem{ key: 'slug', val: 'customers/totals' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Customers totals.'), rt.new_string('woocommerce')]) }]))
	var_reports.array_push(rt.create_array([rt.ArrayItem{ key: 'slug', val: 'coupons/totals' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Coupons totals.'), rt.new_string('woocommerce')]) }]))
	var_reports.array_push(rt.create_array([rt.ArrayItem{ key: 'slug', val: 'reviews/totals' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Reviews totals.'), rt.new_string('woocommerce')]) }]))
	var_reports.array_push(rt.create_array([rt.ArrayItem{ key: 'slug', val: 'categories/totals' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Categories totals.'), rt.new_string('woocommerce')]) }]))
	var_reports.array_push(rt.create_array([rt.ArrayItem{ key: 'slug', val: 'tags/totals' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tags totals.'), rt.new_string('woocommerce')]) }]))
	var_reports.array_push(rt.create_array([rt.ArrayItem{ key: 'slug', val: 'attributes/totals' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Attributes totals.'), rt.new_string('woocommerce')]) }]))
	return var_reports.dup()
}

struct Class_WC_REST_Reports_V2_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_reports_controller() &Class_WC_REST_Reports_Controller {
	mut obj := &Class_WC_REST_Reports_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
	}
	return obj
}

fn create_wc_rest_reports_v2_controller() &Class_WC_REST_Reports_V2_Controller {
	mut obj := &Class_WC_REST_Reports_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Reports_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_reports' {
			return this.get_reports()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Reports_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Reports_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Reports_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Reports_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Reports_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_reports_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
