import rt

struct Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper.from_wc_coupon(mut var_wc_coupon Class_Automattic_WooCommerce_Api_Utils_Coupons_WC_Coupon) rt.PhpVal {
	mut var_coupon := create_automattic_woocommerce_api_types_coupons_coupon()
	mut var_raw_discount_type := // unsupported expression: Expr_Cast_String
	mut var_raw_status := // unsupported expression: Expr_Cast_String
	rt.set_property(var_coupon, 'id', var_wc_coupon.get_id())
	rt.set_property(var_coupon, 'code', var_wc_coupon.get_code())
	rt.set_property(var_coupon, 'description', var_wc_coupon.get_description())
	rt.set_property(var_coupon, 'discount_type', if !(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Enums_Coupons_DiscountType{}; return temp.tryfrom(arg_0) }(var_raw_discount_type.dup())).is_null() { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Enums_Coupons_DiscountType{}; return temp.tryfrom(arg_0) }(var_raw_discount_type.dup()) } else { Class_Automattic_WooCommerce_Api_Enums_Coupons_DiscountType.other() })
	rt.set_property(var_coupon, 'raw_discount_type', var_raw_discount_type.dup())
	rt.set_property(var_coupon, 'amount', // unsupported expression: Expr_Cast_Double)
	rt.set_property(var_coupon, 'status', if rt.is_true(rt.identical(rt.new_string(''), var_raw_status)) { Class_Automattic_WooCommerce_Api_Enums_Coupons_CouponStatus.draft() } else { if !(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Enums_Coupons_CouponStatus{}; return temp.tryfrom(arg_0) }(var_raw_status.dup())).is_null() { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Enums_Coupons_CouponStatus{}; return temp.tryfrom(arg_0) }(var_raw_status.dup()) } else { Class_Automattic_WooCommerce_Api_Enums_Coupons_CouponStatus.other() } })
	rt.set_property(var_coupon, 'raw_status', var_raw_status.dup())
	rt.set_property(var_coupon, 'date_created', // unsupported expression: Expr_NullsafeMethodCall)
	rt.set_property(var_coupon, 'date_modified', // unsupported expression: Expr_NullsafeMethodCall)
	rt.set_property(var_coupon, 'date_expires', // unsupported expression: Expr_NullsafeMethodCall)
	rt.set_property(var_coupon, 'usage_count', var_wc_coupon.get_usage_count())
	rt.set_property(var_coupon, 'individual_use', var_wc_coupon.get_individual_use())
	rt.set_property(var_coupon, 'product_ids', var_wc_coupon.get_product_ids())
	rt.set_property(var_coupon, 'excluded_product_ids', var_wc_coupon.get_excluded_product_ids())
	rt.set_property(var_coupon, 'usage_limit', var_wc_coupon.get_usage_limit())
	rt.set_property(var_coupon, 'usage_limit_per_user', var_wc_coupon.get_usage_limit_per_user())
	rt.set_property(var_coupon, 'limit_usage_to_x_items', var_wc_coupon.get_limit_usage_to_x_items())
	rt.set_property(var_coupon, 'free_shipping', var_wc_coupon.get_free_shipping())
	rt.set_property(var_coupon, 'product_categories', var_wc_coupon.get_product_categories())
	rt.set_property(var_coupon, 'excluded_product_categories', var_wc_coupon.get_excluded_product_categories())
	rt.set_property(var_coupon, 'exclude_sale_items', var_wc_coupon.get_exclude_sale_items())
	rt.set_property(var_coupon, 'minimum_amount', // unsupported expression: Expr_Cast_Double)
	rt.set_property(var_coupon, 'maximum_amount', // unsupported expression: Expr_Cast_Double)
	rt.set_property(var_coupon, 'email_restrictions', var_wc_coupon.get_email_restrictions())
	rt.set_property(var_coupon, 'used_by', var_wc_coupon.get_used_by())
	return mut var_coupon
}

struct Class_Automattic_WooCommerce_Api_Types_Coupons_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Enums_Coupons_DiscountType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Enums_Coupons_CouponStatus {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_utils_coupons_couponmapper() &Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper {
	mut obj := &Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_types_coupons_coupon() &Class_Automattic_WooCommerce_Api_Types_Coupons_Coupon {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Coupons_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_enums_coupons_discounttype() &Class_Automattic_WooCommerce_Api_Enums_Coupons_DiscountType {
	mut obj := &Class_Automattic_WooCommerce_Api_Enums_Coupons_DiscountType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_enums_coupons_couponstatus() &Class_Automattic_WooCommerce_Api_Enums_Coupons_CouponStatus {
	mut obj := &Class_Automattic_WooCommerce_Api_Enums_Coupons_CouponStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'from_wc_coupon' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Coupons_WC_Coupon](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper.from_wc_coupon(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Types_Coupons_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Coupons_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Coupons_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Enums_Coupons_DiscountType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Enums_Coupons_DiscountType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Enums_Coupons_DiscountType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Enums_Coupons_CouponStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Enums_Coupons_CouponStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Enums_Coupons_CouponStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_api_utils_coupons_couponmapper_php() {
	// unsupported statement: Stmt_Declare
}
