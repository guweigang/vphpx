import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderCouponSchema.identifier() string {
	return 'order-coupon'
}
struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderCouponSchema {
	rt.PhpObjectBase
pub mut:
		title rt.PhpVal = rt.new_string('order_coupon')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderCouponSchema) get_properties() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'code', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The coupons unique code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'discount_type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The discount type for the coupon (e.g. percentage or fixed amount)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'totals', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total amounts provided using the smallest unit of the currency.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.call_function('array_merge', [this.get_store_currency_properties(), rt.create_array([rt.ArrayItem{ key: 'total_discount', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total discount applied by this coupon.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total_discount_tax', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total tax removed due to discount applied by this coupon.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }])]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderCouponSchema) get_item_response(var_coupon rt.PhpVal) rt.PhpVal {
	mut var_coupon_object := create_automattic_woocommerce_storeapi_schemas_v1_wc_coupon(rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}))
	return rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'discount_type', val: if rt.is_true(var_coupon_object) { var_coupon_object.get_discount_type() } else { rt.new_string('') } }, rt.ArrayItem{ key: 'totals', val: // unsupported expression: Expr_Cast_Object }])
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Coupon {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_ordercouponschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderCouponSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderCouponSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title: rt.new_string('order_coupon')
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_wc_coupon() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Coupon {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderCouponSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_properties' {
			return this.get_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderCouponSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderCouponSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' { this.title = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_schemas_v1_ordercouponschema_php() {
}
