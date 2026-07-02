import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderItemSchema.identifier() string {
	return 'order-item'
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderItemSchema {
	rt.PhpObjectBase
pub mut:
	title                    rt.PhpVal = rt.new_string('order_item')
	cached_parent_attributes rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderItemSchema) get_item_response(var_order_item rt.PhpVal) rt.PhpVal {
	this.cached_parent_attributes = rt.new_null()
	mut var_order := rt.call_method(var_order_item, 'get_order', []rt.PhpVal{})
	mut var_product := rt.call_method(var_order_item, 'get_product', []rt.PhpVal{})
	mut var_product_properties := rt.create_array([
		rt.ArrayItem{ key: 'short_description', val: '' },
		rt.ArrayItem{ key: 'description', val: '' },
		rt.ArrayItem{ key: 'sku', val: '' },
		rt.ArrayItem{ key: 'permalink', val: '' },
		rt.ArrayItem{ key: 'catalog_visibility', val: 'hidden' },
		rt.ArrayItem{ key: 'prices', val: rt.create_array([
			rt.ArrayItem{ key: 'price', val: '' },
			rt.ArrayItem{ key: 'regular_price', val: '' },
			rt.ArrayItem{ key: 'sale_price', val: '' },
			rt.ArrayItem{ key: 'price_range', val: rt.new_null() },
			rt.ArrayItem{ key: 'currency_code', val: '' },
			rt.ArrayItem{ key: 'currency_symbol', val: '' },
			rt.ArrayItem{ key: 'currency_minor_unit', val: 2 },
			rt.ArrayItem{ key: 'currency_decimal_separator', val: '.' },
			rt.ArrayItem{ key: 'currency_thousand_separator', val: ',' },
			rt.ArrayItem{ key: 'currency_prefix', val: '' },
			rt.ArrayItem{ key: 'currency_suffix', val: '' },
			rt.ArrayItem{ key: 'raw_prices', val: rt.create_array([
				rt.ArrayItem{ key: 'precision', val: 6 },
				rt.ArrayItem{ key: 'price', val: '' },
				rt.ArrayItem{ key: 'regular_price', val: '' },
				rt.ArrayItem{ key: 'sale_price', val: '' },
			]) },
		]) },
		rt.ArrayItem{ key: 'sold_individually', val: false },
		rt.ArrayItem{ key: 'images', val: rt.new_array() },
		rt.ArrayItem{ key: 'variation', val: rt.new_array() },
	])
	if rt.is_true(rt.call_function('is_a', [var_product.clone(),
		rt.new_string('WC_Product')]))
	{
		var_product_properties.array_set('short_description', rt.call_method(var_product,
			'get_short_description', []rt.PhpVal{}))
		var_product_properties.array_set('description', rt.call_method(var_product,
			'get_description', []rt.PhpVal{}))
		var_product_properties.array_set('sku', rt.call_method(var_product, 'get_sku',
			[]rt.PhpVal{}))
		var_product_properties.array_set('permalink', rt.call_method(var_product, 'get_permalink',
			[]rt.PhpVal{}))
		var_product_properties.array_set('catalog_visibility', rt.call_method(var_product,
			'get_catalog_visibility', []rt.PhpVal{}))
		var_product_properties.array_set('prices', this.prepare_product_price_response(var_product.clone(), rt.call_function('get_option', [
			rt.new_string('woocommerce_tax_display_cart'),
		])))
		var_product_properties.array_set('sold_individually', rt.call_method(var_product,
			'is_sold_individually', []rt.PhpVal{}))
		var_product_properties.array_set('images', this.get_images(var_product.clone()))
		if rt.is_true(rt.new_bool(rt.instance_of(var_product,
			'Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product_Variation')))
		{
			var_product_properties.array_set('variation', this.get_variation_data_from_order_item(var_order_item.clone(),
				var_product.clone()))
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'key', val: rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'id', val: rt.call_method(var_order_item, 'get_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'quantity', val: rt.call_method(var_order_item, 'get_quantity',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'quantity_limits', val: rt.create_array([
			rt.ArrayItem{ key: 'minimum', val: rt.call_method(var_order_item, 'get_quantity',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'maximum', val: rt.call_method(var_order_item, 'get_quantity',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'multiple_of', val: 1 },
			rt.ArrayItem{ key: 'editable', val: false },
		]) },
		rt.ArrayItem{ key: 'name', val: rt.call_method(var_order_item, 'get_name', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'short_description', val: this.prepare_html_response(rt.call_function('wc_format_content', [
			rt.call_function('wp_kses_post', [
				var_product_properties.array_get(rt.new_string('short_description')),
			]),
		])) },
		rt.ArrayItem{ key: 'description', val: this.prepare_html_response(rt.call_function('wc_format_content', [
			rt.call_function('wp_kses_post', [
				var_product_properties.array_get(rt.new_string('description')),
			]),
		])) },
		rt.ArrayItem{
			key: 'sku'
			val: this.prepare_html_response(var_product_properties.array_get(rt.new_string('sku')))
		},
		rt.ArrayItem{ key: 'low_stock_remaining', val: rt.new_null() },
		rt.ArrayItem{ key: 'backorders_allowed', val: false },
		rt.ArrayItem{ key: 'show_backorder_badge', val: false },
		rt.ArrayItem{
			key: 'sold_individually'
			val: if !(var_product_properties.array_get(rt.new_string('sold_individually'))).is_null() {
				var_product_properties.array_get(rt.new_string('sold_individually'))
			} else {
				rt.new_bool(false)
			}
		},
		rt.ArrayItem{
			key: 'permalink'
			val: var_product_properties.array_get(rt.new_string('permalink'))
		},
		rt.ArrayItem{ key: 'images', val: var_product_properties.array_get(rt.new_string('images')) },
		rt.ArrayItem{
			key: 'variation'
			val: var_product_properties.array_get(rt.new_string('variation'))
		},
		rt.ArrayItem{ key: 'item_data', val: rt.call_method(var_order_item,
			'get_all_formatted_meta_data', []rt.PhpVal{}) },
		rt.ArrayItem{
			key: 'prices'
			val: rt.array_to_object(var_product_properties.array_get(rt.new_string('prices')))
		},
		rt.ArrayItem{
			key: 'totals'
			val: rt.array_to_object(this.prepare_currency_response(this.get_totals(var_order_item.clone())))
		},
		rt.ArrayItem{
			key: 'catalog_visibility'
			val: var_product_properties.array_get(rt.new_string('catalog_visibility'))
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderItemSchema) get_totals(var_order_item rt.PhpVal) rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'line_subtotal', val: this.prepare_money_response(rt.call_method(var_order_item,
			'get_subtotal', []rt.PhpVal{}),
			rt.call_function('wc_get_price_decimals', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'line_subtotal_tax', val: this.prepare_money_response(rt.call_method(var_order_item,
			'get_subtotal_tax', []rt.PhpVal{}), rt.call_function('wc_get_price_decimals',
			[]rt.PhpVal{})) },
		rt.ArrayItem{ key: 'line_total', val: this.prepare_money_response(rt.call_method(var_order_item,
			'get_total', []rt.PhpVal{}), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'line_total_tax', val: this.prepare_money_response(rt.call_method(var_order_item,
			'get_total_tax', []rt.PhpVal{}), rt.call_function('wc_get_price_decimals',
			[]rt.PhpVal{})) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderItemSchema) get_variation_data_from_order_item(var_order_item rt.PhpVal, var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_variation_data := rt.new_array()
	mut var_meta_data := rt.call_method(var_order_item, 'get_meta_data', []rt.PhpVal{})
	mut var_parent_attributes := this.get_parent_product_attributes(var_product_mutated.clone())
	mut iter_1 := var_meta_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_meta := item_1.val
		mut var_meta_key := rt.get_property(var_meta, 'key')
		mut var_meta_value := rt.get_property(var_meta, 'value')
		if !rt.is_true(var_meta_key)
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_meta_value.clone()])))))
			|| rt.is_true(rt.identical(rt.new_string(''), var_meta_value))
			|| rt.is_true(rt.identical(rt.call_function('strpos', [var_meta_key.clone(), rt.new_string('_')]), rt.new_int(0))) {
			continue
		}
		mut var_is_variation_attribute := rt.new_bool(false)
		mut var_normalized_key := var_meta_key.clone()
		if rt.is_true(rt.identical(rt.call_function('strpos', [
			var_meta_key.clone(), rt.new_string('attribute_')]), rt.new_int(0)))
		{
			var_normalized_key = rt.call_function('substr', [
				var_meta_key.clone(), rt.new_int('attribute_'.len)])
		}
		if rt.is_true(rt.identical(rt.call_function('strpos', [
			var_normalized_key.clone(), rt.new_string('pa_')]), rt.new_int(0)))
		{
			var_is_variation_attribute = rt.new_bool(true)
		} else {
			mut iter_2 := var_parent_attributes.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_attribute := item_2.val
				if rt.is_true(rt.identical(rt.new_string(rt.call_method(var_attribute, 'get_name',
					[]rt.PhpVal{}).to_string().to_lower()),
					rt.new_string(var_normalized_key.clone().to_string().to_lower())))
				{
					var_is_variation_attribute = rt.new_bool(true)
					break
				}
			}
		}
		if rt.is_true(var_is_variation_attribute) {
			var_variation_data.array_set(rt.call_function('wc_variation_attribute_name', [
				var_normalized_key.clone(),
			]), var_meta_value.clone())
		}
	}
	return this.format_variation_data(var_variation_data.clone(), var_product_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderItemSchema) get_parent_product_attributes(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.cached_parent_attributes)))) {
		return this.cached_parent_attributes
	}
	this.cached_parent_attributes = rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'get_parent_id',
		[]rt.PhpVal{})))))
	{
		return this.cached_parent_attributes
	}
	mut var_parent_product := rt.call_function('wc_get_product', [
		rt.call_method(var_product_mutated, 'get_parent_id', []rt.PhpVal{}),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_parent_product,
		'Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product'))))))
	{
		return this.cached_parent_attributes
	}
	this.cached_parent_attributes = rt.call_method(var_parent_product, 'get_attributes',
		[]rt.PhpVal{})
	return this.cached_parent_attributes
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_orderitemschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderItemSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderItemSchema{
		PhpObjectBase:            rt.PhpObjectBase{}
		title:                    rt.new_string('order_item')
		cached_parent_attributes: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_itemschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderItemSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		'get_totals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_totals(dispatch_arg_0)
		}
		'get_variation_data_from_order_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_variation_data_from_order_item(dispatch_arg_0, dispatch_arg_1)
		}
		'get_parent_product_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_parent_product_attributes(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderItemSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		'cached_parent_attributes' { return this.cached_parent_attributes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderItemSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' {
			this.title = val
			return true
		}
		'cached_parent_attributes' {
			this.cached_parent_attributes = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}
