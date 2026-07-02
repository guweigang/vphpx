import rt

struct Class_Automattic_WooCommerce_Admin_API_Customers {
	rt.PhpObjectBase
pub mut:
	rest_base rt.PhpVal = rt.new_string('customers')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Customers) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Customers', [
			'Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Customers', [
						'Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Customers', [
						'Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Customers', [
					'Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Customers', [
			'Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique ID for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Customers', [
						'Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Customers', [
						'Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Customers', [
					'Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Customers) prepare_reports_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args :=
		this.Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller.prepare_reports_query(var_request.clone())
	var_args.array_set('customers', var_request.array_get(rt.new_string('include')))
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Customers) get_collection_params() rt.PhpVal {
	mut var_params :=
		this.Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller.get_collection_params()
	var_params.array_set('include', var_params.array_get(rt.new_string('customers')))
	var_params.array_unset(rt.new_string('customers'))
	return var_params.clone()
}

struct Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_customers(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Customers {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Customers{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base:     rt.new_string('customers')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_automattic_woocommerce_admin_api_reports_customers_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Customers) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'prepare_reports_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_reports_query(dispatch_arg_0)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Customers) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Customers) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Admin_API_Reports_Customers_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
