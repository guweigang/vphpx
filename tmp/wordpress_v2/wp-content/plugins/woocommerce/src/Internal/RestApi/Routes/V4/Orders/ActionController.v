import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_ActionController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_ActionController) get_endpoint_args_for_actions() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'payment_complete', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Marks the order as paid. Updates the order status and reduces line item stock if necessary.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{ key: 'default', val: false },
		]) },
		rt.ArrayItem{ key: 'reset_download_permissions', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Resets any download permissions linked to the order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{ key: 'default', val: false },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_ActionController) run_actions(mut var_order Class_WC_Order, mut var_request Class_WP_REST_Request) {
	mut var_valid_actions := rt.func_array_keys(this.get_endpoint_args_for_actions())
	mut iter_1 := var_valid_actions.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_action := item_1.val
		mut var_callback := rt.new_string('action_' + var_action.str())
		mut var_param := var_request.get_param(var_action.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_param))))
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_ActionController', []string{}, &this)
		}, rt.ArrayItem{ key: none, val: var_callback }])]) {
			mut var_result := rt.call_function('call_user_func', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_ActionController',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: var_callback },
				]),
				var_param.clone(),
				var_order,
				var_request,
			])
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_action'), rt.call_function('esc_html', [
					rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}),
				]))))
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_ActionController) action_reset_download_permissions(var_action_value rt.PhpVal, mut var_order Class_WC_Order, mut var_request Class_WP_REST_Request) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_action_value)))) {
		return false
	}
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('customer-download'))
	mut var_data_store := iife_result_0
	if rt.is_true(var_data_store) {
		rt.call_method(var_data_store, 'delete_by_order_id', [
			var_order.get_id()])
	}
	rt.call_function('wc_downloadable_product_permissions', [
		var_order.get_id(), rt.new_bool(true)])
	mut var_user_agent := rt.call_function('esc_html', [
		var_request.get_header(rt.new_string('User-Agent')),
	])
	var_order.add_order_note(rt.call_function('esc_html__', [
		rt.new_string('Download permissions were reset manually.'),
		rt.new_string('woocommerce'),
	]), rt.new_bool(false), rt.new_bool(true), rt.create_array([
		rt.ArrayItem{
			key: 'user_agent'
			val: if rt.is_true(var_user_agent) { var_user_agent } else { rt.new_string('REST API') }
		},
		rt.ArrayItem{ key: 'note_title', val: rt.call_function('__', [
			rt.new_string('Download permissions'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{
			key: 'note_group'
			val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.order_update()
		},
	]))
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_ActionController) action_payment_complete(var_action_value rt.PhpVal, mut var_order Class_WC_Order, mut var_request Class_WP_REST_Request) bool {
	if rt.is_true(var_action_value) {
		mut var_result := var_order.payment_complete(if !(var_request.array_get(rt.new_string('transaction_id'))).is_null() {
			var_request.array_get(rt.new_string('transaction_id'))
		} else {
			rt.new_string('')
		})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
			return (create_wp_error(rt.new_string('woocommerce_rest_payment_complete_failed'), rt.call_function('__', [
				rt.new_string('Could not mark the order as paid.'),
				rt.new_string('woocommerce'),
			]))).to_bool()
		}
	}
	return true
}

struct Class_WC_REST_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_actioncontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_ActionController {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_ActionController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_exception(_args ...rt.PhpVal) &Class_WC_REST_Exception {
	mut obj := &Class_WC_REST_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_WC_Data_Store{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_ActionController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_endpoint_args_for_actions' {
			return this.get_endpoint_args_for_actions()
		}
		'run_actions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.run_actions(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'action_reset_download_permissions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.action_reset_download_permissions(dispatch_arg_0, mut
				dispatch_arg_1, mut dispatch_arg_2))
		}
		'action_payment_complete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.action_payment_complete(dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_ActionController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_ActionController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_REST_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
