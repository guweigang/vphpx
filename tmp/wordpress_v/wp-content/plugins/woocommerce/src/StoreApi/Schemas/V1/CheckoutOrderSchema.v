import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutOrderSchema.identifier() string {
	return 'checkout-order'
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutOrderSchema {
	rt.PhpObjectBase
pub mut:
	title rt.PhpVal = rt.new_string('checkout-order')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutOrderSchema) get_properties() rt.PhpVal {
	mut var_parent_properties :=
		this.Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema.get_properties()
	var_parent_properties.array_unset(rt.new_string('create_account'))
	return var_parent_properties.dup()
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_checkoutorderschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutOrderSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutOrderSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title:         rt.new_string('checkout-order')
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_checkoutschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutOrderSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_properties' {
			return this.get_properties()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutOrderSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutOrderSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' {
			this.title = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_schemas_v1_checkoutorderschema_php() {
}
