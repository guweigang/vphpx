import rt

struct Class_Automattic_WooCommerce_Internal_Admin_SiteHealth {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_sitehealth() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_SiteHealth', 'instance',
		rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_Admin_SiteHealth.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_SiteHealth',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_SiteHealth', 'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_self',
			[]string{}, create_automattic_woocommerce_internal_admin_self()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_SiteHealth', 'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SiteHealth) construct() {
	rt.call_function('add_filter', [
		rt.new_string('site_status_should_suggest_persistent_object_cache'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_SiteHealth',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'should_suggest_persistent_object_cache' },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SiteHealth) should_suggest_persistent_object_cache(var_check rt.PhpVal) rt.PhpVal {
	mut var_check_mutated := var_check
	if rt.is_true(rt.identical(rt.new_bool(true), var_check_mutated)) {
		return var_check_mutated.clone()
	}
	mut var_thresholds := rt.create_array([rt.ArrayItem{ key: 'orders', val: 100 },
		rt.ArrayItem{ key: 'products', val: 100 }])
	mut iter_1 := var_thresholds.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_threshold := item_1.val
		mut var_key := item_1.key
		mut switch_val_1 := var_key
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('orders'))) {
			mut var_orders_query := create_automattic_woocommerce_internal_admin_wc_order_query(rt.create_array([
				rt.ArrayItem{ key: 'status', val: 'any' },
				rt.ArrayItem{ key: 'limit', val: 1 },
				rt.ArrayItem{ key: 'paginate', val: true },
				rt.ArrayItem{ key: 'return', val: 'ids' },
			]))
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			mut var_orders_results := var_orders_query.get_orders()
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			if rt.is_true(rt.greater_equal(rt.get_property(var_orders_results, 'total'),
				var_threshold))
			{
				var_check_mutated = rt.new_bool(true)
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('products'))) {
			mut var_products_query := create_automattic_woocommerce_internal_admin_wc_product_query(rt.create_array([
				rt.ArrayItem{ key: 'status', val: 'any' },
				rt.ArrayItem{ key: 'limit', val: 1 },
				rt.ArrayItem{ key: 'paginate', val: true },
				rt.ArrayItem{ key: 'return', val: 'ids' },
			]))
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			mut var_products_results := var_products_query.get_products()
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			if rt.is_true(rt.greater_equal(rt.get_property(var_products_results, 'total'),
				var_threshold))
			{
				var_check_mutated = rt.new_bool(true)
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Admin_Exception') {
			mut var_exception := var_e_1.clone()
			break
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
		if !(var_check_mutated.clone().is_null()) {
			break
		}
	}
	return var_check_mutated.clone()
}

struct Class_Automattic_WooCommerce_Internal_Admin_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_Order_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_Product_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_sitehealth() &Class_Automattic_WooCommerce_Internal_Admin_SiteHealth {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_SiteHealth{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_order_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_Order_Query {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_Order_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_product_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_Product_Query {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_Product_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SiteHealth) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_SiteHealth.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'should_suggest_persistent_object_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.should_suggest_persistent_object_cache(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_SiteHealth) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SiteHealth) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Order_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_Order_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Order_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Product_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_Product_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Product_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
