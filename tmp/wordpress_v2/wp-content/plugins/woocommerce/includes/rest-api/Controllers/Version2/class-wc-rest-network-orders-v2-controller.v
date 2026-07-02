import rt

struct Class_WC_REST_Network_Orders_V2_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v2')
}

fn (mut this Class_WC_REST_Network_Orders_V2_Controller) register_routes() {
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_function('register_rest_route', [this.namespace,
			rt.new_string('/' +
				(rt.get_property(rt.new_object('WC_REST_Network_Orders_V2_Controller', ['WC_REST_Orders_V2_Controller'], &this), 'rest_base')).str() +
				'/network'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
					rt.ArrayItem{ key: 'callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Network_Orders_V2_Controller', [
							'WC_REST_Orders_V2_Controller',
						], &this) },
						rt.ArrayItem{ key: none, val: 'network_orders' },
					]) },
					rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Network_Orders_V2_Controller', [
							'WC_REST_Orders_V2_Controller',
						], &this) },
						rt.ArrayItem{ key: none, val: 'network_orders_permissions_check' },
					]) },
					rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
				]) },
				rt.ArrayItem{ key: 'schema', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Network_Orders_V2_Controller', [
						'WC_REST_Orders_V2_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
				]) },
			])])
	}
}

fn (mut this Class_WC_REST_Network_Orders_V2_Controller) get_public_item_schema() rt.PhpVal {
	mut var_schema := this.Class_WC_REST_Orders_V2_Controller.get_public_item_schema()
	var_schema.array_get_mut('properties').array_set('blog', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Blog id of the record on the multisite.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_get_mut('properties').array_set('edit_url', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('URL to edit the order'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_get_mut('properties').array_get_mut('customer').array_push(rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Name of the customer for the order'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_get_mut('properties').array_get_mut('status_name').array_push(rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Order Status'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_get_mut('properties').array_get_mut('formatted_total').array_push(rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Order total formatted for locale'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	return var_schema.clone()
}

fn (mut this Class_WC_REST_Network_Orders_V2_Controller) network_orders_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_blog_id := rt.call_method(var_request, 'get_param', [
		rt.new_string('blog_id'),
	])
	var_blog_id = if !(!rt.is_true(var_blog_id)) {
		var_blog_id
	} else {
		rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	rt.call_function('switch_to_blog', [var_blog_id.clone()])
	mut var_permission := this.get_items_permissions_check(var_request.clone())
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	return var_permission.clone()
}

fn (mut this Class_WC_REST_Network_Orders_V2_Controller) network_orders(var_request rt.PhpVal) rt.PhpVal {
	mut var_blog_id := rt.call_method(var_request, 'get_param', [
		rt.new_string('blog_id'),
	])
	var_blog_id = if !(!rt.is_true(var_blog_id)) {
		var_blog_id
	} else {
		rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	mut var_active_plugins := rt.call_function('get_blog_option', [
		var_blog_id.clone(), rt.new_string('active_plugins'),
		rt.new_array()])
	mut var_network_active_plugins := rt.func_array_keys(rt.call_function('get_site_option', [
		rt.new_string('active_sitewide_plugins'),
		rt.new_array(),
	]))
	mut var_plugins := rt.call_function('array_merge', [var_active_plugins.clone(),
		var_network_active_plugins.clone()])
	mut var_wc_active := rt.new_bool(false)
	mut iter_1 := var_plugins.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_plugin := item_1.val
		if rt.is_true(rt.identical(rt.call_function('substr_compare', [
			var_plugin.clone(), rt.new_string('/woocommerce.php'),
			rt.new_int(var_plugin.clone().to_string().len - '/woocommerce.php'.len),
			rt.new_int('/woocommerce.php'.len)]), rt.new_int(0)))
		{
			var_wc_active = rt.new_bool(true)
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wc_active)))) {
		mut var_response := rt.call_function('rest_ensure_response', [
			rt.new_array()])
		return var_response.clone()
	}
	rt.call_function('switch_to_blog', [var_blog_id.clone()])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_rest_orders_prepare_object_query'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Network_Orders_V2_Controller', [
				'WC_REST_Orders_V2_Controller',
			], &this) },
			rt.ArrayItem{ key: none, val: 'network_orders_filter_args' },
		]),
	])
	mut var_items := this.get_items(var_request.clone())
	rt.call_function('remove_filter', [
		rt.new_string('woocommerce_rest_orders_prepare_object_query'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Network_Orders_V2_Controller', [
				'WC_REST_Orders_V2_Controller',
			], &this) },
			rt.ArrayItem{ key: none, val: 'network_orders_filter_args' },
		]),
	])
	mut iter_2 := rt.get_property(var_items, 'data').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_current_order := item_2.val
		mut var_order := rt.call_function('wc_get_order', [
			var_current_order.array_get(rt.new_string('id')),
		])
		var_current_order.array_set('blog', rt.call_function('get_blog_details', [
			rt.call_function('get_current_blog_id', []rt.PhpVal{}),
		]))
		var_current_order.array_set('edit_url', rt.call_function('get_admin_url', [
			var_blog_id.clone(),
			rt.new_string('post.php?post=' +
				(rt.call_function('absint', [rt.call_method(var_order, 'get_id', []rt.PhpVal{})])).str() +
				'&action=edit'),
		]))
		var_current_order.array_set('customer', rt.call_function('sprintf', [
			rt.call_function('_x', [rt.new_string('%1$s %2$s'),
				rt.new_string('full name'), rt.new_string('woocommerce')]),
			rt.call_method(var_order, 'get_billing_first_name', []rt.PhpVal{}),
			rt.call_method(var_order, 'get_billing_last_name', []rt.PhpVal{}),
		]).to_string().trim_space())
		var_current_order.array_set('status_name', rt.call_function('wc_get_order_status_name', [
			rt.call_method(var_order, 'get_status', []rt.PhpVal{}),
		]))
		var_current_order.array_set('formatted_total', rt.call_method(var_order,
			'get_formatted_order_total', []rt.PhpVal{}))
	}
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	return var_items.clone()
}

fn (mut this Class_WC_REST_Network_Orders_V2_Controller) network_orders_filter_args(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('post_status', rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.on_hold()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.processing()
		},
	]))
	return var_args_mutated.clone()
}

struct Class_WC_REST_Orders_V2_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_network_orders_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Network_Orders_V2_Controller {
	mut obj := &Class_WC_REST_Network_Orders_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v2')
	}
	return obj
}

fn create_wc_rest_orders_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Orders_V2_Controller {
	mut obj := &Class_WC_REST_Orders_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Network_Orders_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_public_item_schema' {
			return this.get_public_item_schema()
		}
		'network_orders_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.network_orders_permissions_check(dispatch_arg_0)
		}
		'network_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.network_orders(dispatch_arg_0)
		}
		'network_orders_filter_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.network_orders_filter_args(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Network_Orders_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Network_Orders_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Orders_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Orders_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Orders_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
