import rt

struct Class_Automattic_WooCommerce_Api_Queries_Coupons_GetCoupon {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Coupons_GetCoupon) execute(mut var_id Class_Automattic_WooCommerce_Api_Queries_Coupons_?int, mut var_code Class_Automattic_WooCommerce_Api_Queries_Coupons_?string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.identical(rt.new_null(), var_id), rt.identical(rt.new_null(), var_code))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_Queries_Coupons_InvalidArgumentException', []string{}, create_automattic_woocommerce_api_queries_coupons_invalidargumentexception(rt.new_string('Exactly one of "id" or "code" must be provided.'))))
	}
	mut var_wc_coupon := create_automattic_woocommerce_api_queries_coupons_wc_coupon(if !(var_id).is_null() { var_id } else { var_code })
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wc_coupon.get_id())))) {
		return rt.new_null()
	}
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper{}; return temp.from_wc_coupon(arg_0) }(rt.new_object('Automattic_WooCommerce_Api_Queries_Coupons_WC_Coupon', []string{}, var_wc_coupon))
}

struct Class_Automattic_WooCommerce_Api_Queries_Coupons_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Queries_Coupons_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_queries_coupons_getcoupon() &Class_Automattic_WooCommerce_Api_Queries_Coupons_GetCoupon {
	mut obj := &Class_Automattic_WooCommerce_Api_Queries_Coupons_GetCoupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_queries_coupons_invalidargumentexception() &Class_Automattic_WooCommerce_Api_Queries_Coupons_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Api_Queries_Coupons_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_queries_coupons_wc_coupon() &Class_Automattic_WooCommerce_Api_Queries_Coupons_WC_Coupon {
	mut obj := &Class_Automattic_WooCommerce_Api_Queries_Coupons_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_utils_coupons_couponmapper() &Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper {
	mut obj := &Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Coupons_GetCoupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'execute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Queries_Coupons_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Queries_Coupons_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.execute(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Queries_Coupons_GetCoupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Coupons_GetCoupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Queries_Coupons_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Queries_Coupons_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Coupons_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Queries_Coupons_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Queries_Coupons_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Coupons_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_api_queries_coupons_getcoupon_php() {
	// unsupported statement: Stmt_Declare
}
