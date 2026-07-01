import rt

struct Class_Automattic_WooCommerce_Api_Mutations_Products_UpdateProduct {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Products_UpdateProduct) execute(mut var_input Class_Automattic_WooCommerce_Api_InputTypes_Products_UpdateProductInput) rt.PhpVal {
	mut var_wc_product := rt.call_function('wc_get_product', [rt.get_property(var_input, 'id')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wc_product, 'Automattic_WooCommerce_Api_Mutations_Products_WC_Product')))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_ApiException', []string{}, create_automattic_woocommerce_api_apiexception(rt.new_string('Product not found.'), rt.new_string('NOT_FOUND'), rt.new_int(404))))
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'slug' }, rt.ArrayItem{ key: none, val: 'sku' }, rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'short_description' }, rt.ArrayItem{ key: none, val: 'manage_stock' }, rt.ArrayItem{ key: none, val: 'stock_quantity' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			if rt.is_true(var_input.was_provided(var_field.dup())) {
				rt.call_method(var_wc_product, "set_${var_field.to_string()}", [rt.get_property(var_input, '{"nodeType":"Expr_Variable","line":41,"name":"field"}')])
			}
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'regular_price' }, rt.ArrayItem{ key: none, val: 'sale_price' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			if rt.is_true(var_input.was_provided(var_field.dup())) {
				rt.call_method(var_wc_product, "set_${var_field.to_string()}", [if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { // unsupported expression: Expr_Cast_String } else { rt.new_string('') }])
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_input.was_provided(rt.new_string('status'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_method(var_wc_product, 'set_status', [rt.get_property(rt.get_property(var_input, 'status'), 'value')])
	}
	if rt.is_true(var_input.was_provided(rt.new_string('dimensions'))) {
		{
			mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'length' }, rt.ArrayItem{ key: none, val: 'width' }, rt.ArrayItem{ key: none, val: 'height' }, rt.ArrayItem{ key: none, val: 'weight' }]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_field := item_1.val
				if rt.is_true(rt.call_method(rt.get_property(var_input, 'dimensions'), 'was_provided', [var_field.dup()])) {
					rt.call_method(var_wc_product, "set_${var_field.to_string()}", [if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { // unsupported expression: Expr_Cast_String } else { rt.new_string('') }])
				}
			}
		}
	}
	rt.call_method(var_wc_product, 'save', []rt.PhpVal{})
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper{}; return temp.from_wc_product(arg_0) }(var_wc_product.dup())
}

struct Class_Automattic_WooCommerce_Api_ApiException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_mutations_products_updateproduct() &Class_Automattic_WooCommerce_Api_Mutations_Products_UpdateProduct {
	mut obj := &Class_Automattic_WooCommerce_Api_Mutations_Products_UpdateProduct{
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

fn create_automattic_woocommerce_api_utils_products_productmapper() &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper {
	mut obj := &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Products_UpdateProduct) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'execute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_InputTypes_Products_UpdateProductInput](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.execute(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Mutations_Products_UpdateProduct) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Products_UpdateProduct) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_api_mutations_products_updateproduct_php() {
	// unsupported statement: Stmt_Declare
}
