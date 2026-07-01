import rt

struct Class_Automattic_WooCommerce_Internal_Orders_OrderStatusRestController {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v3')
	rest_base rt.PhpVal = rt.new_string('orders/statuses')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderStatusRestController) get_rest_api_namespace() string {
	return (this.namespace).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderStatusRestController) register_routes() {
	rt.call_function('register_rest_route', [this.get_rest_api_namespace(),
		'/' + (this.rest_base).str(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderStatusRestController', [
						'Automattic_WooCommerce_Internal_RestApiControllerBase',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: '__return_true' },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderStatusRestController', [
					'Automattic_WooCommerce_Internal_RestApiControllerBase',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_item_schema' },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderStatusRestController) get_items(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_statuses := rt.call_function('wc_get_order_statuses', []rt.PhpVal{})
	mut var_formatted_statuses := rt.new_array()
	{
		mut iter_1 := var_order_statuses.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_status_name := item_1.val
			mut var_status_slug := item_1.key
			mut var_slug := rt.call_function('str_replace', [
				rt.new_string('wc-'), rt.new_string(''), var_status_slug.dup()])
			var_formatted_statuses.array_push(rt.create_array([
				rt.ArrayItem{ key: 'slug', val: var_slug },
				rt.ArrayItem{ key: 'name', val: rt.call_function('wc_get_order_status_name', [
					var_slug.dup(),
				]) },
			]))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_formatted_statuses)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_not_found'), rt.call_function('__', [
			rt.new_string('Order statuses not found'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	return rt.call_function('rest_ensure_response', [var_formatted_statuses.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderStatusRestController) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'order_status' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'slug', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Order status slug.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Order status name.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	])
	return var_schema.dup()
}

struct Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orders_orderstatusrestcontroller() &Class_Automattic_WooCommerce_Internal_Orders_OrderStatusRestController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_OrderStatusRestController{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v3')
		rest_base:     rt.new_string('orders/statuses')
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapicontrollerbase() &Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApiControllerBase{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderStatusRestController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_rest_api_namespace' {
			return rt.new_string(this.get_rest_api_namespace())
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_items(mut dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_OrderStatusRestController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderStatusRestController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_orders_orderstatusrestcontroller_php() {
	// unsupported statement: Stmt_Declare
}
