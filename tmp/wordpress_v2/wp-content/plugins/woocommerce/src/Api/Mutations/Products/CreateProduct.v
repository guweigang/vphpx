import rt

struct Class_Automattic_WooCommerce_Api_Mutations_Products_CreateProduct {
	rt.PhpObjectBase
pub mut:
	repository rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Products_CreateProduct) init(mut var_repository Class_Automattic_WooCommerce_Api_Utils_Products_ProductRepository) {
	this.repository = var_repository
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Products_CreateProduct) execute(mut var_input Class_Automattic_WooCommerce_Api_InputTypes_Products_CreateProductInput) rt.PhpVal {
	mut var_existing := create_automattic_woocommerce_api_mutations_products_wp_query(rt.create_array([
		rt.ArrayItem{ key: 'post_type', val: 'product' },
		rt.ArrayItem{ key: 'title', val: rt.get_property(var_input, 'name') },
		rt.ArrayItem{ key: 'post_status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'publish' },
			rt.ArrayItem{ key: none, val: 'draft' },
			rt.ArrayItem{ key: none, val: 'pending' },
			rt.ArrayItem{ key: none, val: 'private' },
		]) },
		rt.ArrayItem{ key: 'fields', val: 'ids' },
	]))
	if rt.is_true(rt.greater(rt.get_property(var_existing, 'found_posts'), rt.new_int(0))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_ApiException', []string{}, create_automattic_woocommerce_api_apiexception(rt.new_string('A product with this name already exists.'),
			rt.new_string('VALIDATION_ERROR'), rt.create_array([
			rt.ArrayItem{ key: 'field', val: 'name' },
		]), rt.new_int(422))))
	}
	mut var_wc_product := create_automattic_woocommerce_api_mutations_products_wc_product()
	var_wc_product.set_name(rt.get_property(var_input, 'name'))
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'slug' },
		rt.ArrayItem{ key: none, val: 'sku' }, rt.ArrayItem{ key: none, val: 'description' },
		rt.ArrayItem{ key: none, val: 'short_description' }, rt.ArrayItem{
			key: none
			val: 'manage_stock'
		}, rt.ArrayItem{ key: none, val: 'stock_quantity' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_input,
			'{"nodeType":"Expr_Variable","line":89,"name":"field"}')))))
		{
			rt.call_method(var_wc_product, 'set_${var_field.to_string()}', [
				rt.get_property(var_input, '{"nodeType":"Expr_Variable","line":90,"name":"field"}'),
			])
		}
	}
	mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'regular_price' },
		rt.ArrayItem{ key: none, val: 'sale_price' }]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_field := item_2.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_input,
			'{"nodeType":"Expr_Variable","line":95,"name":"field"}')))))
		{
			rt.call_method(var_wc_product, 'set_${var_field.to_string()}', [
				rt.new_string((rt.get_property(var_input,
					'{"nodeType":"Expr_Variable","line":96,"name":"field"}')).str()),
			])
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_input,
		'status')))))
	{
		var_wc_product.set_status(rt.get_property(rt.get_property(var_input, 'status'), 'value'))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_input,
		'dimensions')))))
	{
		mut iter_3 := rt.create_array([rt.ArrayItem{ key: none, val: 'length' },
			rt.ArrayItem{ key: none, val: 'width' }, rt.ArrayItem{ key: none, val: 'height' },
			rt.ArrayItem{ key: none, val: 'weight' }]).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_field := item_3.val
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(rt.get_property(var_input,
				'dimensions'), '{"nodeType":"Expr_Variable","line":106,"name":"field"}')))))
			{
				rt.call_method(var_wc_product, 'set_${var_field.to_string()}', [
					rt.new_string((rt.get_property(rt.get_property(var_input, 'dimensions'),
						'{"nodeType":"Expr_Variable","line":107,"name":"field"}')).str()),
				])
			}
		}
	}
	rt.call_method(this.repository, 'save', [var_wc_product])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper{}
	mut iife_result_0 := iife_temp_0.from_wc_product(rt.new_object('Automattic_WooCommerce_Api_Mutations_Products_WC_Product',
		[]string{}, var_wc_product))
	return iife_result_0
}

struct Class_Automattic_WooCommerce_Api_Mutations_Products_WP_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_ApiException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Mutations_Products_WC_Product {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_mutations_products_createproduct(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Mutations_Products_CreateProduct {
	mut obj := &Class_Automattic_WooCommerce_Api_Mutations_Products_CreateProduct{
		PhpObjectBase: rt.PhpObjectBase{}
		repository:    rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_api_mutations_products_wp_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Mutations_Products_WP_Query {
	mut obj := &Class_Automattic_WooCommerce_Api_Mutations_Products_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_apiexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_ApiException {
	mut obj := &Class_Automattic_WooCommerce_Api_ApiException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_mutations_products_wc_product(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Mutations_Products_WC_Product {
	mut obj := &Class_Automattic_WooCommerce_Api_Mutations_Products_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_utils_products_productmapper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper {
	mut obj := &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Products_CreateProduct) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Utils_Products_ProductRepository](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'execute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_InputTypes_Products_CreateProductInput](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.execute(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Mutations_Products_CreateProduct) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'repository' { return this.repository }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Products_CreateProduct) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'repository' {
			this.repository = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Products_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Mutations_Products_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Products_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Products_WC_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Mutations_Products_WC_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Mutations_Products_WC_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
