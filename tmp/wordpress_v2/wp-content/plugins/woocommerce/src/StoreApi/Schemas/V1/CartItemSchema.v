import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema.identifier() string {
	return 'cart-item'
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema {
	rt.PhpObjectBase
pub mut:
	title rt.PhpVal = rt.new_string('cart_item')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema) get_item_response(var_cart_item rt.PhpVal) rt.PhpVal {
	mut var_product := if !(var_cart_item.array_get(rt.new_string('data'))).is_null() {
		var_cart_item.array_get(rt.new_string('data'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product'))))))
	{
		return rt.new_array()
	}
	mut var_product_permalink := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_item_permalink'),
		rt.call_method(var_product, 'get_permalink', []rt.PhpVal{}),
		var_cart_item.clone(),
		var_cart_item.array_get(rt.new_string('key')),
	])
	return rt.create_array([
		rt.ArrayItem{ key: 'key', val: var_cart_item.array_get(rt.new_string('key')) },
		rt.ArrayItem{ key: 'id', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'type', val: rt.call_method(var_product, 'get_type', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'quantity', val: rt.call_function('wc_stock_amount', [
			var_cart_item.array_get(rt.new_string('quantity')),
		]) },
		rt.ArrayItem{ key: 'quantity_limits', val: rt.array_to_object(rt.call_method(create_automattic_woocommerce_storeapi_utilities_quantitylimits(),
			'get_cart_item_quantity_limits', [
			var_cart_item.clone(),
		])) },
		rt.ArrayItem{ key: 'name', val: this.prepare_html_response(rt.call_method(var_product,
			'get_title', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'short_description', val: this.prepare_html_response(rt.call_function('wc_format_content', [
			rt.call_function('wp_kses_post', [
				rt.call_method(var_product, 'get_short_description', []rt.PhpVal{}),
			]),
		])) },
		rt.ArrayItem{ key: 'description', val: this.prepare_html_response(rt.call_function('wc_format_content', [
			rt.call_function('wp_kses_post', [
				rt.call_method(var_product, 'get_description', []rt.PhpVal{}),
			]),
		])) },
		rt.ArrayItem{ key: 'sku', val: this.prepare_html_response(rt.call_method(var_product,
			'get_sku', []rt.PhpVal{})) },
		rt.ArrayItem{
			key: 'low_stock_remaining'
			val: this.get_low_stock_remaining(var_product.clone())
		},
		rt.ArrayItem{ key: 'backorders_allowed', val: (rt.call_method(var_product,
			'backorders_allowed', []rt.PhpVal{})).to_bool() },
		rt.ArrayItem{
			key: 'show_backorder_badge'
			val:
				rt.is_true((rt.call_method(var_product, 'backorders_require_notification', []rt.PhpVal{})).to_bool())
				&& rt.is_true(rt.call_method(var_product, 'is_on_backorder', [var_cart_item.array_get(rt.new_string('quantity'))]))
		},
		rt.ArrayItem{ key: 'sold_individually', val: rt.call_method(var_product,
			'is_sold_individually', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'permalink', val: var_product_permalink },
		rt.ArrayItem{ key: 'images', val: this.get_cart_images(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](var_product), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_array](var_cart_item),
			(var_cart_item.array_get(rt.new_string('key'))).str()) },
		rt.ArrayItem{ key: 'variation', val: this.format_variation_data(var_cart_item.array_get(rt.new_string('variation')),
			var_product.clone()) },
		rt.ArrayItem{ key: 'item_data', val: this.get_item_data(var_cart_item.clone()) },
		rt.ArrayItem{ key: 'prices', val: rt.array_to_object(this.prepare_product_price_response(var_product.clone(), rt.call_function('get_option', [
			rt.new_string('woocommerce_tax_display_cart'),
		]))) },
		rt.ArrayItem{ key: 'totals', val: rt.array_to_object(this.prepare_currency_response(rt.create_array([
			rt.ArrayItem{ key: 'line_subtotal', val: this.prepare_money_response(var_cart_item.array_get(rt.new_string('line_subtotal')), rt.call_function('wc_get_price_decimals',
				[]rt.PhpVal{})) },
			rt.ArrayItem{ key: 'line_subtotal_tax', val: this.prepare_money_response(var_cart_item.array_get(rt.new_string('line_subtotal_tax')), rt.call_function('wc_get_price_decimals',
				[]rt.PhpVal{})) },
			rt.ArrayItem{ key: 'line_total', val: this.prepare_money_response(var_cart_item.array_get(rt.new_string('line_total')), rt.call_function('wc_get_price_decimals',
				[]rt.PhpVal{})) },
			rt.ArrayItem{ key: 'line_total_tax', val: this.prepare_money_response(var_cart_item.array_get(rt.new_string('line_tax')), rt.call_function('wc_get_price_decimals',
				[]rt.PhpVal{})) },
		]))) },
		rt.ArrayItem{ key: 'catalog_visibility', val: rt.call_method(var_product,
			'get_catalog_visibility', []rt.PhpVal{}) },
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema.extending_key()
			val: this.get_extended_data(Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema.identifier(),
				var_cart_item.clone())
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema) get_cart_images(mut var_product Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product, mut var_cart_item Class_Automattic_WooCommerce_StoreApi_Schemas_V1_array, cart_item_key string) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_product_images := this.get_images(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product',
		[]string{}, var_product_mutated))
	mut var_filtered_images := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_store_api_cart_item_images'),
		var_product_images.clone(),
		var_cart_item,
		rt.new_string(cart_item_key),
	])
	if !(var_filtered_images.clone().is_array()) || var_filtered_images.clone().array_count() == 0 {
		return var_product_images.clone()
	}
	mut var_valid_images := rt.new_array()
	mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
	mut iter_1 := var_filtered_images.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_image := item_1.val
		if !(!(rt.get_property(var_image, 'id')).is_null()) {
			rt.call_method(var_logger, 'warning', [
				rt.new_string('After passing through woocommerce_cart_item_images filter, one of the images did not have an id property.'),
			])
			continue
		}
		if !rt.is_true(rt.get_property(var_image, 'thumbnail'))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_parse_url', [rt.get_property(var_image, 'thumbnail'), rt.get_constant('PHP_URL_HOST')]))))) {
			rt.call_method(var_logger, 'warning', [
				rt.call_function('sprintf', [
					rt.new_string('After passing through woocommerce_cart_item_images filter, image with id %s did not have a valid thumbnail property.'),
					rt.get_property(var_image, 'id'),
				]),
			])
			continue
		}
		if !rt.is_true(rt.get_property(var_image, 'src'))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_parse_url', [rt.get_property(var_image, 'src'), rt.get_constant('PHP_URL_HOST')]))))) {
			rt.call_method(var_logger, 'warning', [
				rt.call_function('sprintf', [
					rt.new_string('After passing through woocommerce_cart_item_images filter, image with id %s did not have a valid src property.'),
					rt.get_property(var_image, 'id'),
				]),
			])
			continue
		}
		var_valid_images.array_push(var_image.clone())
	}
	if var_valid_images.clone().array_count() == 0 {
		return var_product_images.clone()
	}
	return var_valid_images.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema) get_item_data(var_cart_item rt.PhpVal) rt.PhpVal {
	mut var_item_data := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_item_data'),
		rt.new_array(),
		var_cart_item.clone(),
	])
	mut var_clean_item_data := rt.new_array()
	mut iter_2 := var_item_data.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_data := item_2.val
		mut iter_3 := var_data.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_data_value := item_3.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [
				var_data_value.clone(),
			])))))
			{
				continue
			}
		}
		var_clean_item_data.array_push(this.format_item_data_element(var_data.clone()))
	}
	return var_clean_item_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema) format_item_data_element(var_item_data_element rt.PhpVal) rt.PhpVal {
	mut var_item_data_element_mutated := var_item_data_element
	if rt.is_true(rt.new_bool(var_item_data_element_mutated.clone().array_isset(rt.new_string('__experimental_woocommerce_blocks_hidden')))) {
		var_item_data_element_mutated.array_set('hidden',
			var_item_data_element_mutated.array_get(rt.new_string('__experimental_woocommerce_blocks_hidden')))
	}
	return rt.call_function('array_map', [rt.new_string('wp_kses_post'),
		var_item_data_element_mutated.clone()])
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_cartitemschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title:         rt.new_string('cart_item')
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_itemschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_quantitylimits(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		'get_cart_images' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_cart_images(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'get_item_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_data(dispatch_arg_0)
		}
		'format_item_data_element' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_item_data_element(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartItemSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
