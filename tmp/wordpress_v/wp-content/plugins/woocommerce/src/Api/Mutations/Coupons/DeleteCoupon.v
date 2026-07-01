import rt

struct Class_Automattic_WooCommerce_Api_Mutations_Coupons_DeleteCoupon {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Coupons_DeleteCoupon) execute(id i64, force bool) rt.PhpVal {
	mut var_wc_coupon :=
		create_automattic_woocommerce_api_mutations_coupons_wc_coupon(rt.new_int(id).dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wc_coupon.get_id())))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_ApiException', []string{}, create_automattic_woocommerce_api_apiexception(rt.new_string('Coupon not found.'),
			rt.new_string('NOT_FOUND'), rt.new_int(404))))
	}
	mut var_deleted := var_wc_coupon.delete(rt.new_bool(force))
	if rt.is_true(rt.new_bool(rt.instance_of(var_deleted,
		'Automattic_WooCommerce_Api_Mutations_Coupons_WP_Error')))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_ApiException', []string{}, create_automattic_woocommerce_api_apiexception(rt.call_method(var_deleted,
			'get_error_message', []rt.PhpVal{}), rt.new_string('INTERNAL_ERROR'), rt.new_int(500))))
	}
	mut var_result := create_automattic_woocommerce_api_types_coupons_deletecouponresult()
	rt.set_property(var_result, 'id', rt.new_int(id))
	rt.set_property(var_result, 'deleted', rt.identical(rt.new_bool(true), var_deleted))
	return mut var_result
}

struct Class_Automattic_WooCommerce_Api_Mutations_Coupons_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_ApiException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Types_Coupons_DeleteCouponResult {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_mutations_coupons_deletecoupon() &Class_Automattic_WooCommerce_Api_Mutations_Coupons_DeleteCoupon {
	mut obj := &Class_Automattic_WooCommerce_Api_Mutations_Coupons_DeleteCoupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_mutations_coupons_wc_coupon() &Class_Automattic_WooCommerce_Api_Mutations_Coupons_WC_Coupon {
	mut obj := &Class_Automattic_WooCommerce_Api_Mutations_Coupons_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_apiexception() &Class_Automattic_WooCommerce_Api_ApiException {
	mut obj := &Class_Automattic_WooCommerce_Api_ApiException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_coupons_deletecouponresult() &Class_Automattic_WooCommerce_Api_Types_Coupons_DeleteCouponResult {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Coupons_DeleteCouponResult{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Coupons_DeleteCoupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'execute' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.execute(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Mutations_Coupons_DeleteCoupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Coupons_DeleteCoupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Coupons_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Mutations_Coupons_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Coupons_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Api_ApiException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_ApiException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_ApiException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Coupons_DeleteCouponResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Coupons_DeleteCouponResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Coupons_DeleteCouponResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_api_mutations_coupons_deletecoupon_php() {
	// unsupported statement: Stmt_Declare
}
