import rt

struct Class_Automattic_WooCommerce_Internal_Orders_CouponsController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_CouponsController) add_coupon_discount_via_ajax() {
	rt.call_function('check_ajax_referer', [rt.new_string('order-item'),
		rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_shop_orders'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_response := rt.new_array()
	mut var_order :=
		this.add_coupon_discount(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_array](rt.get_superglobal('_POST')))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.include_file(@DIR + '/../../../includes/admin/meta-boxes/views/html-order-items.php', '1')
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_response.array_set('html', rt.call_function('ob_get_clean', []rt.PhpVal{}))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_notes := rt.call_function('wc_get_order_notes', [
		rt.create_array([
			rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) },
		]),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.include_file(@DIR + '/../../../includes/admin/meta-boxes/views/html-order-notes.php', '1')
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_response.array_set('notes_html', rt.call_function('ob_get_clean', []rt.PhpVal{}))
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
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) },
			]),
		])
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
	rt.call_function('wp_send_json_success', [var_response.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_CouponsController) add_coupon_discount(mut var_post_variables Class_Automattic_WooCommerce_Internal_Orders_array) rt.PhpVal {
	mut var_order_id := if var_post_variables.array_isset(rt.new_string('order_id')) { rt.call_function('absint', [
			var_post_variables.array_get(rt.new_string('order_id')),
		]) } else { rt.new_int(0) }
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	mut var_calculate_tax_args := rt.create_array([
		rt.ArrayItem{
			key: 'country'
			val: if var_post_variables.array_isset(rt.new_string('country')) { rt.call_function('wc_strtoupper', [
					rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							var_post_variables.array_get(rt.new_string('country')),
						]),
					]),
				]) } else { rt.new_string('') }
		},
		rt.ArrayItem{
			key: 'state'
			val: if var_post_variables.array_isset(rt.new_string('state')) { rt.call_function('wc_strtoupper', [
					rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							var_post_variables.array_get(rt.new_string('state')),
						]),
					]),
				]) } else { rt.new_string('') }
		},
		rt.ArrayItem{
			key: 'postcode'
			val: if var_post_variables.array_isset(rt.new_string('postcode')) { rt.call_function('wc_strtoupper', [
					rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							var_post_variables.array_get(rt.new_string('postcode')),
						]),
					]),
				]) } else { rt.new_string('') }
		},
		rt.ArrayItem{
			key: 'city'
			val: if var_post_variables.array_isset(rt.new_string('city')) { rt.call_function('wc_strtoupper', [
					rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [
							var_post_variables.array_get(rt.new_string('city')),
						]),
					]),
				]) } else { rt.new_string('') }
		},
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Invalid order'),
			rt.new_string('woocommerce'),
		]))))
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_0 := iife_temp_0.get_value_or_default(rt.new_object('Automattic_WooCommerce_Internal_Orders_array',
		[]string{}, var_post_variables), rt.new_string('coupon'))
	mut var_coupon := iife_result_0
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_1 := iife_temp_1.is_null_or_whitespace(var_coupon.clone())
	if rt.is_true(iife_result_1) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Invalid coupon'),
			rt.new_string('woocommerce'),
		]))))
	}
	mut var_user_id_arg := if var_post_variables.array_isset(rt.new_string('user_id')) { rt.call_function('absint', [
			var_post_variables.array_get(rt.new_string('user_id')),
		]) } else { rt.new_int(0) }
	mut var_user_email_arg := if var_post_variables.array_isset(rt.new_string('user_email')) { rt.call_function('sanitize_email', [
			rt.call_function('wp_unslash', [var_post_variables.array_get(rt.new_string('user_email'))]),
		]) } else { rt.new_string('') }
	if rt.is_true(var_user_id_arg) {
		rt.call_method(var_order, 'set_customer_id', [var_user_id_arg.clone()])
	}
	if rt.is_true(var_user_email_arg) {
		rt.call_method(var_order, 'set_billing_email', [var_user_email_arg.clone()])
	}
	rt.call_method(var_order, 'calculate_taxes', [var_calculate_tax_args.clone()])
	rt.call_method(var_order, 'calculate_totals', [rt.new_bool(false)])
	mut var_code := rt.call_function('wc_format_coupon_code', [
		rt.call_function('wp_unslash', [var_coupon.clone()]),
	])
	mut var_result := rt.call_method(var_order, 'apply_coupon', [
		var_code.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('html_entity_decode', [
			rt.call_function('wp_strip_all_tags', [
				rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}),
			]),
		]))))
	}
	rt.call_method(var_order, 'add_order_note', [
		rt.call_function('esc_html', [
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Coupon applied: "%s".'),
					rt.new_string('woocommerce')]),
				var_code.clone(),
			]),
		]),
		rt.new_int(0),
		rt.new_bool(true),
		rt.create_array([
			rt.ArrayItem{
				key: 'note_group'
				val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.order_update()
			},
		]),
	])
	return var_order.clone()
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orders_couponscontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Orders_CouponsController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_CouponsController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_CouponsController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_coupon_discount_via_ajax' {
			this.add_coupon_discount_via_ajax()
			return rt.new_null()
		}
		'add_coupon_discount' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.add_coupon_discount(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_CouponsController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_CouponsController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
