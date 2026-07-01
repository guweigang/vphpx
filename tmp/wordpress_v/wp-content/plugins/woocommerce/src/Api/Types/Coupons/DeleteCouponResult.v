import rt

struct Class_Automattic_WooCommerce_Api_Types_Coupons_DeleteCouponResult {
	rt.PhpObjectBase
pub mut:
	id      rt.PhpVal = rt.new_null()
	deleted rt.PhpVal = rt.new_null()
}

fn create_automattic_woocommerce_api_types_coupons_deletecouponresult() &Class_Automattic_WooCommerce_Api_Types_Coupons_DeleteCouponResult {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Coupons_DeleteCouponResult{
		PhpObjectBase: rt.PhpObjectBase{}
		id:            rt.new_null()
		deleted:       rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Coupons_DeleteCouponResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Coupons_DeleteCouponResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'deleted' { return this.deleted }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Coupons_DeleteCouponResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		'deleted' {
			this.deleted = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_api_types_coupons_deletecouponresult_php() {
	// unsupported statement: Stmt_Declare
}
