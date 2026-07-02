import rt

struct Class_WC_Admin_Customize {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Customize) construct() {
	rt.call_function('add_filter', [
		rt.new_string('customize_nav_menu_available_item_types'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Customize', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_customize_nav_menu_item_types' },
		]),
	])
	rt.call_function('add_filter', [rt.new_string('customize_nav_menu_available_items'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Customize', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_customize_nav_menu_items' },
		]),
		rt.new_int(10), rt.new_int(4)])
}

fn (mut this Class_WC_Admin_Customize) register_customize_nav_menu_item_types(var_item_types rt.PhpVal) rt.PhpVal {
	mut var_item_types_mutated := var_item_types
	var_item_types_mutated.array_push(rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('WooCommerce Endpoints'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type_label', val: rt.call_function('__', [
			rt.new_string('WooCommerce Endpoint'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'woocommerce_nav' },
		rt.ArrayItem{ key: 'object', val: 'woocommerce_endpoint' },
	]))
	return var_item_types_mutated.clone()
}

fn (mut this Class_WC_Admin_Customize) register_customize_nav_menu_items(var_items rt.PhpVal, type string, object string, page i64) rt.PhpVal {
	mut var_items_mutated := var_items
	if rt.is_true(rt.new_bool('woocommerce_endpoint' != object)) {
		return var_items_mutated.clone()
	}
	if 0 < page {
		return var_items_mutated.clone()
	}
	mut var_endpoints := rt.call_function('wc_get_account_menu_items', []rt.PhpVal{})
	if var_endpoints.array_isset(rt.new_string('dashboard')) {
		var_endpoints.array_unset(rt.new_string('dashboard'))
	}
	var_endpoints.array_set('lost-password', rt.call_function('__', [
		rt.new_string('Lost password'),
		rt.new_string('woocommerce'),
	]))
	var_endpoints = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_custom_nav_menu_items'),
		var_endpoints.clone(),
	])
	mut iter_1 := var_endpoints.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_title := item_1.val
		mut var_endpoint := item_1.key
		var_items_mutated.array_push(rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_endpoint },
			rt.ArrayItem{ key: 'title', val: var_title },
			rt.ArrayItem{ key: 'type_label', val: rt.call_function('__', [
				rt.new_string('Custom Link'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url_raw', [
				rt.call_function('wc_get_account_endpoint_url', [
					var_endpoint.clone()]),
			]) },
		]))
	}
	return var_items_mutated.clone()
}

fn create_wc_admin_customize() &Class_WC_Admin_Customize {
	mut obj := &Class_WC_Admin_Customize{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn (mut this Class_WC_Admin_Customize) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_customize_nav_menu_item_types' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_customize_nav_menu_item_types(dispatch_arg_0)
		}
		'register_customize_nav_menu_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return this.register_customize_nav_menu_items(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Customize) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Customize) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_Customize'),
		rt.new_bool(false),
	])))))
	{
	}
	return rt.new_object('WC_Admin_Customize', []string{}, create_wc_admin_customize())
}
