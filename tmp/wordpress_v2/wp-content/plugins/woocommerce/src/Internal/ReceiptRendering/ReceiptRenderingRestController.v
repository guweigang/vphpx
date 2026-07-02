import rt

struct Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController) get_rest_api_namespace() string {
	return 'order-receipts'
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController) register_routes() {
	mut var_request := rt.new_null()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('create_order_receipt'))
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permission(var_request.clone(), rt.new_string('read_shop_order'), rt.call_method(var_request,
			'get_param', [rt.new_string('id')]))
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController', [
			'Automattic_WooCommerce_Internal_RestApiControllerBase',
		], &this), 'route_namespace'),
		rt.new_string('/orders/(?P<id>[\\d]+)/receipt'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_1_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_create_order_receipt() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_for_get_and_post_order_receipt() },
			]) },
		]),
	])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('get_order_receipt'))
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permission(var_request.clone(), rt.new_string('read_shop_order'), rt.call_method(var_request,
			'get_param', [rt.new_string('id')]))
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController', [
			'Automattic_WooCommerce_Internal_RestApiControllerBase',
		], &this), 'route_namespace'),
		rt.new_string('/orders/(?P<id>[\\d]+)/receipt'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_3_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_4_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_get_order_receipt() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_for_get_and_post_order_receipt() },
			]) },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController) get_order_receipt(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_order_id := var_request.get_param(rt.new_string('id'))
	mut var_filename := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.class(),
	]), 'get_existing_receipt', [var_order_id.clone()])
	return if var_filename.clone().is_null() {
		create_wp_error(rt.new_string('woocommerce_rest_not_found'), rt.call_function('__', [
			rt.new_string('Receipt not found'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	} else {
		this.get_response_for_file(var_filename.str())
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController) create_order_receipt(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_expiration_date := if !(var_request.get_param(rt.new_string('expiration_date'))).is_null() { var_request.get_param(rt.new_string('expiration_date')) } else { rt.call_function('gmdate', [
			rt.new_string('Y-m-d'),
			rt.call_function('strtotime', [
				rt.concat(rt.concat(rt.new_string('+'), var_request.get_param(rt.new_string('expiration_days'))), rt.new_string(' days')),
			]),
		]) }
	mut var_order_id := var_request.get_param(rt.new_string('id'))
	mut var_filename := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.class(),
	]), 'generate_receipt', [var_order_id.clone(), var_expiration_date.clone(),
		var_request.get_param(rt.new_string('force_new'))])
	return if var_filename.clone().is_null() {
		create_wp_error(rt.new_string('woocommerce_rest_not_found'), rt.call_function('__', [
			rt.new_string('Order not found'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	} else {
		this.get_response_for_file(var_filename.str())
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController) get_response_for_file(filename string) rt.PhpVal {
	mut filename_mutated := filename
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine{}
	mut iife_result_4 := iife_temp_4.get_expiration_date(rt.new_string(filename_mutated))
	mut var_expiration_date := iife_result_4
	mut var_public_url := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine.class(),
	]), 'get_public_url', [rt.new_string(filename_mutated).clone()])
	return rt.create_array([rt.ArrayItem{ key: 'receipt_url', val: var_public_url },
		rt.ArrayItem{ key: 'expiration_date', val: var_expiration_date }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController) get_args_for_get_order_receipt() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier of the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController) get_schema_for_get_and_post_order_receipt() rt.PhpVal {
	mut var_schema := this.get_base_schema()
	var_schema.array_set('properties', rt.create_array([
		rt.ArrayItem{ key: 'receipt_url', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Public url of the receipt.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'expiration_date', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Expiration date of the receipt, formatted as yyyy-mm-dd.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
	]))
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController) get_args_for_create_order_receipt() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier of the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'expiration_date', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Expiration date formatted as yyyy-mm-dd.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'default', val: rt.new_null() },
		]) },
		rt.ArrayItem{ key: 'expiration_days', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Number of days to be added to the current date to get the expiration date.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'default', val: 1 },
		]) },
		rt.ArrayItem{ key: 'force_new', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('True to force the creation of a new receipt even if one already exists and has not expired yet.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{ key: 'required', val: false },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'default', val: false },
		]) },
	])
}

struct Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_receiptrendering_receiptrenderingrestcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController {
	mut obj := &Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapicontrollerbase(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApiControllerBase{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_transientfiles_transientfilesengine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine {
	mut obj := &Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_rest_api_namespace' {
			return rt.new_string(this.get_rest_api_namespace())
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_order_receipt' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_order_receipt(mut dispatch_arg_0)
		}
		'create_order_receipt' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.create_order_receipt(mut dispatch_arg_0)
		}
		'get_response_for_file' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_response_for_file(dispatch_arg_0)
		}
		'get_args_for_get_order_receipt' {
			return this.get_args_for_get_order_receipt()
		}
		'get_schema_for_get_and_post_order_receipt' {
			return this.get_schema_for_get_and_post_order_receipt()
		}
		'get_args_for_create_order_receipt' {
			return this.get_args_for_create_order_receipt()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingRestController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
