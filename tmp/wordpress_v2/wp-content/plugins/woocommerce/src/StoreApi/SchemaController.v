import rt

struct Class_Automattic_WooCommerce_StoreApi_SchemaController {
	rt.PhpObjectBase
pub mut:
	schemas rt.PhpVal = rt.new_array()
	extend  rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SchemaController) construct(mut var_extend Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) {
	this.extend = var_extend
	this.schemas = rt.create_array([
		rt.ArrayItem{ key: 'v1', val: rt.create_array([
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BatchSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BatchSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ErrorSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ErrorSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_TermSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_TermSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartCouponSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartCouponSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartFeeSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartFeeSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutOrderSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutOrderSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderItemSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderItemSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderCouponSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderCouponSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderFeeSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderFeeSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductAttributeSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductAttributeSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductCategorySchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductCategorySchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductBrandSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductBrandSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductCollectionDataSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductCollectionDataSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductReviewSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductReviewSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_PatternsSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_PatternsSchema.class()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema.identifier()
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema.class()
			},
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SchemaController) get(var_name rt.PhpVal, version i64) rt.PhpVal {
	mut var_schema := if !(this.schemas.array_get(rt.new_string('v${var_version.str()}')).array_get(var_name)).is_null() {
		this.schemas.array_get(rt.new_string('v${var_version.str()}')).array_get(var_name)
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_schema)))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exception', []string{},
			create_automattic_woocommerce_storeapi_exception(rt.new_string('${var_name.to_string()} v${var_version.str()} schema does not exist'))))
	}
	return rt.new_object('', []string{}, rt.create_object_dynamically(var_schema, [
		this.extend,
		rt.new_object('Automattic_WooCommerce_StoreApi_SchemaController', []string{}, &this),
	]))
}

struct Class_Automattic_WooCommerce_StoreApi_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemacontroller(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_SchemaController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_SchemaController{
		PhpObjectBase: rt.PhpObjectBase{}
		schemas:       rt.new_array()
		extend:        rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_storeapi_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Exception {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SchemaController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_SchemaController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schemas' { return this.schemas }
		'extend' { return this.extend }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SchemaController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schemas' {
			this.schemas = val
			return true
		}
		'extend' {
			this.extend = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_StoreApi_SchemaController', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_automattic_woocommerce_storeapi_schemacontroller(c_arg_0)
		return rt.new_object('Automattic_WooCommerce_StoreApi_SchemaController', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_StoreApi_Exception', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_storeapi_exception()
		return rt.new_object('Automattic_WooCommerce_StoreApi_Exception', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
