import rt

struct Class_Automattic_WooCommerce_Api_Mutations_Coupons_CreateCoupon {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Coupons_CreateCoupon) execute(mut var_input Class_Automattic_WooCommerce_Api_InputTypes_Coupons_CreateCouponInput) rt.PhpVal {
	mut var_wc_coupon := create_automattic_woocommerce_api_mutations_coupons_wc_coupon()
	var_wc_coupon.set_code(rt.get_property(var_input, 'code'))
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'amount' }, rt.ArrayItem{ key: none, val: 'date_expires' }, rt.ArrayItem{ key: none, val: 'individual_use' }, rt.ArrayItem{ key: none, val: 'product_ids' }, rt.ArrayItem{ key: none, val: 'excluded_product_ids' }, rt.ArrayItem{ key: none, val: 'usage_limit' }, rt.ArrayItem{ key: none, val: 'usage_limit_per_user' }, rt.ArrayItem{ key: none, val: 'limit_usage_to_x_items' }, rt.ArrayItem{ key: none, val: 'free_shipping' }, rt.ArrayItem{ key: none, val: 'product_categories' }, rt.ArrayItem{ key: none, val: 'excluded_product_categories' }, rt.ArrayItem{ key: none, val: 'exclude_sale_items' }, rt.ArrayItem{ key: none, val: 'minimum_amount' }, rt.ArrayItem{ key: none, val: 'maximum_amount' }, rt.ArrayItem{ key: none, val: 'email_restrictions' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				rt.call_method(var_wc_coupon, "set_${var_field.to_string()}", [rt.get_property(var_input, '{"nodeType":"Expr_Variable","line":34,"name":"field"}')])
			}
		}
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_wc_coupon.set_discount_type(rt.get_property(rt.get_property(var_input, 'discount_type'), 'value'))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_wc_coupon.set_status(rt.get_property(rt.get_property(var_input, 'status'), 'value'))
	}
	var_wc_coupon.save()
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper{}; return temp.from_wc_coupon(arg_0) }(rt.new_object('Automattic_WooCommerce_Api_Mutations_Coupons_WC_Coupon', []string{}, var_wc_coupon))
}

struct Class_Automattic_WooCommerce_Api_Mutations_Coupons_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_mutations_coupons_createcoupon() &Class_Automattic_WooCommerce_Api_Mutations_Coupons_CreateCoupon {
	mut obj := &Class_Automattic_WooCommerce_Api_Mutations_Coupons_CreateCoupon{
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

fn create_automattic_woocommerce_api_utils_coupons_couponmapper() &Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper {
	mut obj := &Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Coupons_CreateCoupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'execute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_InputTypes_Coupons_CreateCouponInput](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.execute(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Mutations_Coupons_CreateCoupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Coupons_CreateCoupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_api_mutations_coupons_createcoupon_php() {
	// unsupported statement: Stmt_Declare
}
