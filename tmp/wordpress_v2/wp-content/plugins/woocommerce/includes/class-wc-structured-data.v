import rt

struct Class_WC_Structured_Data {
	rt.PhpObjectBase
pub mut:
	_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Structured_Data) construct() {
	rt.call_function('add_action', [rt.new_string('woocommerce_before_main_content'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Structured_Data', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'generate_website_data' },
		]),
		rt.new_int(30)])
	rt.call_function('add_action', [rt.new_string('woocommerce_breadcrumb'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Structured_Data', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'generate_breadcrumblist_data' },
		]),
		rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('woocommerce_single_product_summary'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Structured_Data', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'generate_product_data' },
		]),
		rt.new_int(60)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_order_details'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Structured_Data', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'generate_order_data' },
		]),
		rt.new_int(20), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_order_details'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Structured_Data', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_email_structured_data' },
		]),
		rt.new_int(30), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Structured_Data', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_structured_data' },
		]),
		rt.new_int(10)])
}

fn (mut this Class_WC_Structured_Data) set_data(var_data rt.PhpVal, reset bool) bool {
	mut var_data_mutated := var_data
	if !(var_data_mutated.array_isset(rt.new_string('@type')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^[a-zA-Z]{1,20}$|'), var_data_mutated.array_get(rt.new_string('@type'))]))))) {
		return false
	}
	if var_reset && !(this._data).is_null() {
		this._data = rt.new_null()
	}
	this._data.array_push(var_data_mutated.clone())
	return true
}

fn (mut this Class_WC_Structured_Data) get_data() rt.PhpVal {
	return this._data
}

fn (mut this Class_WC_Structured_Data) get_structured_data(var_types rt.PhpVal) rt.PhpVal {
	mut var_types_mutated := var_types
	mut var_data := rt.new_array()
	mut iter_1 := this.get_data().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		var_data.array_get_mut(var_value.array_get(rt.new_string('@type')).to_string().to_lower()).array_push(var_value.clone())
	}
	mut iter_2 := var_data.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_type := item_2.key
		var_data.array_set(var_type, if var_value.clone().array_count() > 1 { rt.create_array([
				rt.ArrayItem{ key: '@graph', val: var_value },
			]) } else { var_value.array_get(rt.new_int(0)) })
		var_data.array_set(var_type, rt.add(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_structured_data_context'),
			rt.create_array([rt.ArrayItem{ key: '@context', val: 'https://schema.org/' }]),
			var_data.clone(),
			var_type.clone(),
			var_value.clone(),
		]), var_data.array_get(var_type)))
	}
	var_data = if rt.is_true(var_types_mutated) { rt.call_function('array_values', [
			rt.call_function('array_intersect_key', [var_data.clone(),
				rt.call_function('array_flip', [var_types_mutated.clone()])]),
		]) } else { rt.call_function('array_values', [var_data.clone()]) }
	if !(!rt.is_true(var_data)) {
		if 1 < var_data.clone().array_count() {
			var_data = rt.add(rt.call_function('apply_filters', [
				rt.new_string('woocommerce_structured_data_context'),
				rt.create_array([
					rt.ArrayItem{ key: '@context', val: 'https://schema.org/' },
				]),
				var_data.clone(),
				rt.new_string(''),
				rt.new_string(''),
			]), rt.create_array([rt.ArrayItem{ key: '@graph', val: var_data }]))
		} else {
			var_data = var_data.array_get(rt.new_int(0))
		}
	}
	return var_data.clone()
}

fn (mut this Class_WC_Structured_Data) get_data_type_for_page() rt.PhpVal {
	mut var_types := rt.new_array()
	var_types.array_push(if rt.is_true(rt.call_function('is_shop', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_product_category', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_product', []rt.PhpVal{})) {
		'product'
	} else {
		''
	})
	var_types.array_push(if rt.is_true(rt.call_function('is_shop', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) {
		'website'
	} else {
		''
	})
	var_types.array_push(if rt.is_true(rt.call_function('is_product', []rt.PhpVal{})) {
		'review'
	} else {
		''
	})
	var_types.array_push('breadcrumblist')
	var_types.array_push('order')
	return rt.call_function('array_filter', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_structured_data_type_for_page'),
			var_types.clone(),
		]),
	])
}

fn (mut this Class_WC_Structured_Data) output_email_structured_data(var_order rt.PhpVal, sent_to_admin bool, plain_text bool) {
	if var_plain_text {
		return
	}
	print('<div style="display: none; font-size: 0; max-height: 0; line-height: 0; padding: 0; mso-hide: all;">')
	this.output_structured_data()
	print('</div>')
}

fn (mut this Class_WC_Structured_Data) output_structured_data() {
	mut var_types := this.get_data_type_for_page()
	mut var_data := this.get_structured_data(var_types.clone())
	if rt.is_true(var_data) {
		print('<script type="application/ld+json">' +
			(rt.call_function('wc_esc_json', [rt.call_function('wp_json_encode', [var_data.clone(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]), rt.new_bool(true)])).str() +
			'</script>')
	}
}

fn (mut this Class_WC_Structured_Data) generate_product_data(var_product rt.PhpVal) {
	mut var_child_prices := []rt.PhpVal{}
	mut var_child_sale_prices := []rt.PhpVal{}
	mut var_product_mutated := var_product
	if !(var_product_mutated.clone().is_object()) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_product_mutated.clone(), rt.new_string('WC_Product')])))))
	{
		return
	}
	mut var_shop_name := rt.call_function('get_bloginfo', [rt.new_string('name')])
	mut var_shop_url := rt.call_function('home_url', []rt.PhpVal{})
	mut var_currency := rt.call_function('get_woocommerce_currency', []rt.PhpVal{})
	mut var_permalink := rt.call_function('get_permalink', [
		rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}),
	])
	mut var_image := rt.call_function('wp_get_attachment_url', [
		rt.call_method(var_product_mutated, 'get_image_id', []rt.PhpVal{}),
	])
	mut var_markup := {
		'@type':       rt.new_string('Product')
		'@id':         var_permalink.str() + '#product'
		'name':        rt.call_function('wp_kses_post', [
			rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{}),
		])
		'url':         var_permalink
		'description': rt.call_function('wp_strip_all_tags', [
			rt.call_function('do_shortcode', [if rt.is_true(rt.call_method(var_product_mutated,
				'get_short_description', []rt.PhpVal{}))
			{
				rt.call_method(var_product_mutated, 'get_short_description', []rt.PhpVal{})
			} else {
				rt.call_method(var_product_mutated, 'get_description', []rt.PhpVal{})
			}]),
		])
	}
	if rt.is_true(var_image) {
		var_markup['image'] = var_image.clone()
	}
	if rt.is_true(rt.call_method(var_product_mutated, 'get_sku', []rt.PhpVal{})) {
		var_markup['sku'] = rt.call_method(var_product_mutated, 'get_sku', []rt.PhpVal{})
	} else {
		var_markup['sku'] = rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
	}
	mut var_gtin := rt.new_string(this.prepare_gtin(rt.call_method(var_product_mutated,
		'get_global_unique_id', []rt.PhpVal{})))
	if this.is_valid_gtin(var_gtin.clone()) {
		var_markup['gtin'] = var_gtin.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_product_mutated,
		'get_price', []rt.PhpVal{})))))
	{
		mut var_price_valid_until := rt.call_function('gmdate', [
			rt.new_string('Y-12-31'),
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('YEAR_IN_SECONDS')),
		])
		if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [
			Class_Automattic_WooCommerce_Enums_ProductType.variable(),
		]))
		{
			mut var_lowest := rt.call_method(var_product_mutated, 'get_variation_price', [
				rt.new_string('min'),
				rt.new_bool(true),
			])
			mut var_highest := rt.call_method(var_product_mutated, 'get_variation_price', [
				rt.new_string('max'),
				rt.new_bool(true),
			])
			mut var_variation_prices := rt.call_method(var_product_mutated, 'get_variation_prices', [
				rt.new_bool(true),
			])
			if rt.is_true(rt.identical(var_lowest, var_highest)) {
				mut var_unit_price_spec := {
					'@type':         rt.new_string('UnitPriceSpecification')
					'price':         rt.call_function('wc_format_decimal', [
						var_lowest.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
					'priceCurrency': var_currency
					'validThrough':  var_price_valid_until
				}
				if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
					var_unit_price_spec['valueAddedTaxIncluded'] = rt.identical(rt.new_string('incl'), rt.call_function('get_option', [
						rt.new_string('woocommerce_tax_display_shop'),
					]))
				}
				mut var_markup_offer := {
					'@type':              rt.new_string('Offer')
					'priceSpecification': map[string]rt.PhpVal{}
				}
			} else {
				var_markup_offer = {
					'@type':      rt.new_string('AggregateOffer')
					'lowPrice':   rt.call_function('wc_format_decimal', [
						var_lowest.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
					'highPrice':  rt.call_function('wc_format_decimal', [
						var_highest.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
					'offerCount': rt.new_int(var_variation_prices.array_get(rt.new_string('price')).array_count())
				}
				if rt.is_true(rt.call_method(var_product_mutated, 'is_on_sale', []rt.PhpVal{})) {
					mut var_lowest_child_sale_price := rt.call_method(var_product_mutated,
						'get_variation_sale_price', [rt.new_string('min'),
						rt.new_bool(true)])
					mut iter_3 :=
						var_variation_prices.array_get(rt.new_string('sale_price')).iterator()
					for {
						item_3 := iter_3.next() or { break }
						mut var_variation_price := item_3.val
						mut var_variation_id := item_3.key
						if rt.is_true(rt.identical(var_variation_price, var_lowest_child_sale_price)) {
							break
						}
					}
					mut var_date_on_sale_to := if !var_variation_id.is_null() { rt.call_method(rt.call_function('wc_get_product', [
							var_variation_id.clone(),
						]), 'get_date_on_sale_to', []rt.PhpVal{}) } else { rt.new_null() }
					mut var_sale_price_valid_until := if rt.is_true(var_date_on_sale_to) { rt.call_function('gmdate', [
							rt.new_string('Y-m-d'),
							rt.call_method(var_date_on_sale_to, 'getTimestamp', []rt.PhpVal{}),
						]) } else { rt.new_null() }
					mut var_sale_unit_price_spec := {
						'@type':         rt.new_string('UnitPriceSpecification')
						'priceType':     rt.new_string('https://schema.org/SalePrice')
						'price':         rt.call_function('wc_format_decimal', [
							var_lowest_child_sale_price.clone(),
							rt.call_function('wc_get_price_decimals', []rt.PhpVal{}),
						])
						'priceCurrency': var_currency
						'validThrough':  if !var_sale_price_valid_until.is_null() {
							var_sale_price_valid_until
						} else {
							var_price_valid_until
						}
					}
					if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
						var_sale_unit_price_spec['valueAddedTaxIncluded'] = rt.identical(rt.new_string('incl'), rt.call_function('get_option', [
							rt.new_string('woocommerce_tax_display_shop'),
						]))
					}
					var_markup_offer['priceSpecification'] = rt.create_array([
						rt.ArrayItem{ key: none, val: var_sale_unit_price_spec },
					])
				}
			}
		} else if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [
			Class_Automattic_WooCommerce_Enums_ProductType.grouped(),
		]))
		{
			mut var_tax_display_mode := rt.call_function('get_option', [
				rt.new_string('woocommerce_tax_display_shop'),
			])
			mut var_child_ids := rt.call_method(var_product_mutated, 'get_children', []rt.PhpVal{})
			rt.call_function('_prime_post_caches', [var_child_ids.clone()])
			mut var_children := rt.call_function('array_filter', [
				rt.call_function('array_map', [rt.new_string('wc_get_product'),
					var_child_ids.clone()]),
				rt.new_string('wc_products_array_filter_visible_grouped'),
			])
			mut var_price_function := rt.new_string((if rt.is_true(rt.identical(rt.new_string('incl'),
				var_tax_display_mode))
			{
				'wc_get_price_including_tax'
			} else {
				'wc_get_price_excluding_tax'
			}).str())
			mut iter_4 := var_children.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_child := item_4.val
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_child,
					'get_regular_price', []rt.PhpVal{})))))
				{
					var_child_prices << rt.call_callable(var_price_function, [
						var_child.clone(),
						rt.create_array([
							rt.ArrayItem{ key: 'price', val: rt.call_method(var_child,
								'get_regular_price', []rt.PhpVal{}) },
						])])
				}
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_child,
					'get_sale_price', []rt.PhpVal{})))))
				{
					var_child_sale_prices << rt.call_callable(var_price_function, [
						var_child.clone(),
						rt.create_array([
							rt.ArrayItem{ key: 'price', val: rt.call_method(var_child,
								'get_sale_price', []rt.PhpVal{}) },
						]),
					])
				}
			}
			if !rt.is_true(var_child_prices) {
				mut var_min_price := rt.new_int(0)
			} else {
				var_min_price = rt.call_function('min', [
					rt.create_array_from_list(var_child_prices),
				])
			}
			if !rt.is_true(var_child_sale_prices) {
				mut var_min_sale_price := rt.new_int(0)
			} else {
				var_min_sale_price = rt.call_function('min', [
					rt.create_array_from_list(var_child_sale_prices),
				])
			}
			mut var_unit_price_specification := {
				'@type':         rt.new_string('UnitPriceSpecification')
				'price':         rt.call_function('wc_format_decimal', [
					var_min_price.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
				'priceCurrency': var_currency
				'validThrough':  var_price_valid_until
			}
			if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
				var_unit_price_specification['valueAddedTaxIncluded'] = rt.identical(rt.new_string('incl'),
					var_tax_display_mode)
			}
			if rt.is_true(rt.call_method(var_product_mutated, 'is_on_sale', []rt.PhpVal{}))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_min_price, var_min_sale_price)))) {
				var_unit_price_specification['priceType'] =
					rt.new_string('https://schema.org/ListPrice')
			}
			var_markup_offer = {
				'@type':              rt.new_string('Offer')
				'priceSpecification': map[string]rt.PhpVal{}
			}
			if rt.is_true(rt.call_method(var_product_mutated, 'is_on_sale', []rt.PhpVal{}))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_min_price, var_min_sale_price)))) {
				if rt.is_true(rt.call_method(var_product_mutated, 'get_date_on_sale_to',
					[]rt.PhpVal{}))
				{
					var_sale_price_valid_until = rt.call_function('gmdate', [
						rt.new_string('Y-m-d'),
						rt.call_method(rt.call_method(var_product_mutated, 'get_date_on_sale_to',
							[]rt.PhpVal{}), 'getTimestamp', []rt.PhpVal{}),
					])
				}
				mut var_grouped_sale_spec := {
					'@type':         rt.new_string('UnitPriceSpecification')
					'price':         rt.call_function('wc_format_decimal', [
						var_min_sale_price.clone(),
						rt.call_function('wc_get_price_decimals',
							[]rt.PhpVal{})])
					'priceCurrency': var_currency
					'validThrough':  if !var_sale_price_valid_until.is_null() {
						var_sale_price_valid_until
					} else {
						var_price_valid_until
					}
				}
				if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
					var_grouped_sale_spec['valueAddedTaxIncluded'] = rt.identical(rt.new_string('incl'),
						var_tax_display_mode)
				}
				rt.call_function('array_unshift', [var_markup_offer['priceSpecification'],
					rt.create_array_from_native_map(var_grouped_sale_spec)])
			}
		} else {
			var_tax_display_mode = rt.call_function('get_option', [
				rt.new_string('woocommerce_tax_display_shop'),
			])
			mut var_regular_price := if rt.is_true(rt.identical(rt.new_string('incl'),
				var_tax_display_mode))
			{
				rt.call_function('wc_get_price_including_tax', [
					var_product_mutated.clone(),
					rt.create_array([
						rt.ArrayItem{ key: 'price', val: rt.call_method(var_product_mutated,
							'get_regular_price', []rt.PhpVal{}) },
					])])
			} else {
				rt.call_function('wc_get_price_excluding_tax', [
					var_product_mutated.clone(),
					rt.create_array([
						rt.ArrayItem{ key: 'price', val: rt.call_method(var_product_mutated,
							'get_regular_price', []rt.PhpVal{}) },
					])])
			}
			var_unit_price_specification = {
				'@type':         rt.new_string('UnitPriceSpecification')
				'price':         rt.call_function('wc_format_decimal', [
					var_regular_price.clone(), rt.call_function('wc_get_price_decimals',
						[]rt.PhpVal{})])
				'priceCurrency': var_currency
				'validThrough':  var_price_valid_until
			}
			if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
				var_unit_price_specification['valueAddedTaxIncluded'] = rt.identical(rt.new_string('incl'),
					var_tax_display_mode)
			}
			if rt.is_true(rt.call_method(var_product_mutated, 'is_on_sale', []rt.PhpVal{})) {
				var_unit_price_specification['priceType'] =
					rt.new_string('https://schema.org/ListPrice')
			}
			var_markup_offer = {
				'@type':              rt.new_string('Offer')
				'priceSpecification': map[string]rt.PhpVal{}
			}
			if rt.is_true(rt.call_method(var_product_mutated, 'is_on_sale', []rt.PhpVal{})) {
				mut var_sale_price := if rt.is_true(rt.identical(rt.new_string('incl'), var_tax_display_mode)) { rt.call_function('wc_get_price_including_tax', [
						var_product_mutated.clone(),
						rt.create_array([
							rt.ArrayItem{
								key: 'price'
								val: rt.call_method(var_product_mutated, 'get_sale_price', []rt.PhpVal{})
							},
						]),
					]) } else { rt.call_function('wc_get_price_excluding_tax', [
						var_product_mutated.clone(),
						rt.create_array([
							rt.ArrayItem{
								key: 'price'
								val: rt.call_method(var_product_mutated, 'get_sale_price', []rt.PhpVal{})
							},
						]),
					]) }
				if rt.is_true(rt.call_method(var_product_mutated, 'get_date_on_sale_to',
					[]rt.PhpVal{}))
				{
					var_sale_price_valid_until = rt.call_function('gmdate', [
						rt.new_string('Y-m-d'),
						rt.call_method(rt.call_method(var_product_mutated, 'get_date_on_sale_to',
							[]rt.PhpVal{}), 'getTimestamp', []rt.PhpVal{}),
					])
				}
				mut var_simple_sale_spec := {
					'@type':         rt.new_string('UnitPriceSpecification')
					'price':         rt.call_function('wc_format_decimal', [
						var_sale_price.clone(), rt.call_function('wc_get_price_decimals',
							[]rt.PhpVal{})])
					'priceCurrency': var_currency
					'validThrough':  if !var_sale_price_valid_until.is_null() {
						var_sale_price_valid_until
					} else {
						var_price_valid_until
					}
				}
				if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
					var_simple_sale_spec['valueAddedTaxIncluded'] = rt.identical(rt.new_string('incl'),
						var_tax_display_mode)
				}
				rt.call_function('array_unshift', [var_markup_offer['priceSpecification'],
					rt.create_array_from_native_map(var_simple_sale_spec)])
			}
		}
		if rt.is_true(rt.call_method(var_product_mutated, 'is_in_stock', []rt.PhpVal{})) {
			mut var_stock_status_schema := rt.new_string((if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStockStatus.on_backorder(), rt.call_method(var_product_mutated,
				'get_stock_status', []rt.PhpVal{})))
			{
				'BackOrder'
			} else {
				'InStock'
			}).str())
		} else {
			var_stock_status_schema = rt.new_string('OutOfStock')
		}
		var_markup_offer = rt.add(var_markup_offer, rt.create_array([
			rt.ArrayItem{
				key: 'priceValidUntil'
				val: if !var_sale_price_valid_until.is_null() {
					var_sale_price_valid_until
				} else {
					var_price_valid_until
				}
			},
			rt.ArrayItem{ key: 'availability', val: 'https://schema.org/' +
				var_stock_status_schema.str() },
			rt.ArrayItem{ key: 'url', val: var_permalink },
			rt.ArrayItem{ key: 'seller', val: rt.create_array([
				rt.ArrayItem{ key: '@type', val: 'Organization' },
				rt.ArrayItem{ key: 'name', val: var_shop_name },
				rt.ArrayItem{ key: 'url', val: var_shop_url },
			]) },
		]))
		if !(!rt.is_true(var_markup_offer['price']))
			|| !(!rt.is_true(var_markup_offer['lowPrice']))
			|| !(!rt.is_true(var_markup_offer['highPrice']))
			&& !rt.is_true(var_markup_offer['priceCurrency']) {
			var_markup_offer['priceCurrency'] = var_currency.clone()
		}
		var_markup['offers'] = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('apply_filters', [
				rt.new_string('woocommerce_structured_data_product_offer'),
				rt.create_array_from_native_map(var_markup_offer),
				var_product_mutated.clone(),
			]) },
		])
	}
	if rt.is_true(rt.call_method(var_product_mutated, 'get_rating_count', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('wc_review_ratings_enabled', []rt.PhpVal{})) {
		var_markup['aggregateRating'] = rt.create_array([
			rt.ArrayItem{ key: '@type', val: 'AggregateRating' },
			rt.ArrayItem{ key: 'ratingValue', val: rt.call_method(var_product_mutated,
				'get_average_rating', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'reviewCount', val: rt.call_method(var_product_mutated,
				'get_review_count', []rt.PhpVal{}) },
		])
		mut var_comments := rt.call_function('get_comments', [
			rt.create_array([rt.ArrayItem{ key: 'number', val: 5 },
				rt.ArrayItem{ key: 'post_id', val: rt.call_method(var_product_mutated, 'get_id',
					[]rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: 'approve' },
				rt.ArrayItem{ key: 'post_status', val: 'publish' },
				rt.ArrayItem{ key: 'post_type', val: 'product' },
				rt.ArrayItem{ key: 'parent', val: 0 }, rt.ArrayItem{ key: 'meta_query', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'key', val: 'rating' },
						rt.ArrayItem{ key: 'type', val: 'NUMERIC' },
						rt.ArrayItem{ key: 'compare', val: '>' },
						rt.ArrayItem{ key: 'value', val: 0 },
					]) },
				]) }]),
		])
		if rt.is_true(var_comments) {
			var_markup['review'] = rt.new_array()
			mut iter_5 := var_comments.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_comment := item_5.val
				var_markup.array_get_mut('review').array_push(rt.create_array([
					rt.ArrayItem{ key: '@type', val: 'Review' },
					rt.ArrayItem{ key: 'reviewRating', val: rt.create_array([
						rt.ArrayItem{ key: '@type', val: 'Rating' },
						rt.ArrayItem{ key: 'bestRating', val: '5' },
						rt.ArrayItem{ key: 'ratingValue', val: rt.call_function('get_comment_meta', [
							rt.get_property(var_comment, 'comment_ID'),
							rt.new_string('rating'),
							rt.new_bool(true),
						]) },
						rt.ArrayItem{ key: 'worstRating', val: '1' },
					]) },
					rt.ArrayItem{ key: 'author', val: rt.create_array([
						rt.ArrayItem{ key: '@type', val: 'Person' },
						rt.ArrayItem{ key: 'name', val: rt.call_function('get_comment_author', [
							var_comment.clone(),
						]) },
					]) },
					rt.ArrayItem{ key: 'reviewBody', val: rt.call_function('get_comment_text', [
						var_comment.clone(),
					]) },
					rt.ArrayItem{ key: 'datePublished', val: rt.call_function('get_comment_date', [
						rt.new_string('c'),
						var_comment.clone(),
					]) },
				]))
			}
		}
	}
	if !rt.is_true(var_markup['aggregateRating']) && !rt.is_true(var_markup['offers'])
		&& !rt.is_true(var_markup['review']) {
		return
	}
	this.set_data(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_structured_data_product'),
		rt.create_array_from_native_map(var_markup),
		var_product_mutated.clone(),
	]), false)
}

fn (mut this Class_WC_Structured_Data) generate_review_data(var_comment rt.PhpVal) {
	mut var_markup := rt.new_array()
	var_markup['@type'] = rt.new_string('Review')
	var_markup['@id'] = rt.call_function('get_comment_link', [
		rt.get_property(var_comment, 'comment_ID'),
	])
	var_markup['datePublished'] = rt.call_function('get_comment_date', [
		rt.new_string('c'),
		rt.get_property(var_comment, 'comment_ID'),
	])
	var_markup['description'] = rt.call_function('get_comment_text', [
		rt.get_property(var_comment, 'comment_ID'),
	])
	var_markup['itemReviewed'] = rt.create_array([
		rt.ArrayItem{ key: '@type', val: 'Product' },
		rt.ArrayItem{ key: 'name', val: rt.call_function('get_the_title', [
			rt.get_property(var_comment, 'comment_post_ID'),
		]) },
	])
	mut var_rating := rt.call_function('get_comment_meta', [
		rt.get_property(var_comment, 'comment_ID'),
		rt.new_string('rating'),
		rt.new_bool(true),
	])
	if rt.is_true(var_rating) {
		var_markup['reviewRating'] = rt.create_array([
			rt.ArrayItem{ key: '@type', val: 'Rating' },
			rt.ArrayItem{ key: 'bestRating', val: '5' },
			rt.ArrayItem{ key: 'ratingValue', val: var_rating },
			rt.ArrayItem{ key: 'worstRating', val: '1' },
		])
	} else if rt.is_true(rt.get_property(var_comment, 'comment_parent')) {
		return
	}
	var_markup['author'] = rt.create_array([rt.ArrayItem{ key: '@type', val: 'Person' },
		rt.ArrayItem{ key: 'name', val: rt.call_function('get_comment_author', [
			rt.get_property(var_comment, 'comment_ID'),
		]) }])
	this.set_data(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_structured_data_review'),
		rt.create_array_from_native_map(var_markup),
		var_comment.clone(),
	]), false)
}

fn (mut this Class_WC_Structured_Data) generate_breadcrumblist_data(var_breadcrumbs rt.PhpVal) {
	mut var_crumbs := rt.call_method(var_breadcrumbs, 'get_breadcrumb', []rt.PhpVal{})
	if !rt.is_true(var_crumbs) || !(var_crumbs.clone().is_array()) {
		return
	}
	mut var_markup := rt.new_array()
	var_markup['@type'] = rt.new_string('BreadcrumbList')
	var_markup['itemListElement'] = rt.new_array()
	mut iter_6 := var_crumbs.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_crumb := item_6.val
		mut var_key := item_6.key
		var_markup.array_get_mut('itemListElement').array_set(var_key, rt.create_array([
			rt.ArrayItem{ key: '@type', val: 'ListItem' },
			rt.ArrayItem{ key: 'position', val: rt.add(var_key, rt.new_int(1)) },
			rt.ArrayItem{ key: 'item', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: var_crumb.array_get(rt.new_int(0)) },
			]) },
		]))
		if !(!rt.is_true(var_crumb.array_get(rt.new_int(1)))) {
			var_markup['itemListElement'].array_get(var_key).array_get(rt.new_string('item')) = rt.add(var_markup['itemListElement'].array_get(var_key).array_get(rt.new_string('item')), rt.create_array([
				rt.ArrayItem{ key: '@id', val: var_crumb.array_get(rt.new_int(1)) },
			]))
		} else if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_HOST'))
			&& rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) {
			mut var_current_url := rt.call_function('set_url_scheme', [
				rt.new_string('http://' +
					(rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))])).str() +(rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])).str()),
			])
			var_markup['itemListElement'].array_get(var_key).array_get(rt.new_string('item')) = rt.add(var_markup['itemListElement'].array_get(var_key).array_get(rt.new_string('item')), rt.create_array([
				rt.ArrayItem{ key: '@id', val: var_current_url },
			]))
		}
	}
	this.set_data(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_structured_data_breadcrumblist'),
		rt.create_array_from_native_map(var_markup),
		var_breadcrumbs.clone(),
	]), false)
}

fn (mut this Class_WC_Structured_Data) generate_website_data() {
	mut var_markup := rt.new_array()
	var_markup['@type'] = rt.new_string('WebSite')
	var_markup['name'] = rt.call_function('get_bloginfo', [rt.new_string('name')])
	var_markup['url'] = rt.call_function('home_url', []rt.PhpVal{})
	var_markup['potentialAction'] = rt.create_array([
		rt.ArrayItem{ key: '@type', val: 'SearchAction' },
		rt.ArrayItem{ key: 'target', val: rt.call_function('home_url', [
			rt.new_string('?s={search_term_string}&post_type=product'),
		]) },
		rt.ArrayItem{ key: 'query-input', val: 'required name=search_term_string' },
	])
	this.set_data(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_structured_data_website'),
		rt.create_array_from_native_map(var_markup),
	]), false)
}

fn (mut this Class_WC_Structured_Data) generate_order_data(var_order rt.PhpVal, sent_to_admin bool, plain_text bool) {
	if var_plain_text
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_order.clone(), rt.new_string('WC_Order')]))))) {
		return
	}
	mut var_shop_name := rt.call_function('get_bloginfo', [rt.new_string('name')])
	mut var_shop_url := rt.call_function('home_url', []rt.PhpVal{})
	mut var_order_url := if var_sent_to_admin {
		rt.call_method(var_order, 'get_edit_order_url', []rt.PhpVal{})
	} else {
		rt.call_method(var_order, 'get_view_order_url', []rt.PhpVal{})
	}
	mut var_order_statuses := rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Enums_OrderStatus.pending()
			val: 'https://schema.org/OrderPaymentDue'
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			val: 'https://schema.org/OrderProcessing'
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold()
			val: 'https://schema.org/OrderProblem'
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Enums_OrderStatus.completed()
			val: 'https://schema.org/OrderDelivered'
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Enums_OrderStatus.cancelled()
			val: 'https://schema.org/OrderCancelled'
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded()
			val: 'https://schema.org/OrderReturned'
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Enums_OrderStatus.failed()
			val: 'https://schema.org/OrderProblem'
		},
	])
	mut var_markup_offers := rt.new_array()
	mut iter_7 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_item := item_7.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_order_item_visible'),
			rt.new_bool(true),
			var_item.clone(),
		])))))
		{
			continue
		}
		mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
		mut var_product_exists := rt.new_bool(var_product.clone().is_object())
		mut var_is_visible := rt.new_bool(rt.is_true(var_product_exists)
			&& rt.is_true(rt.call_method(var_product, 'is_visible', []rt.PhpVal{})))
		var_markup_offers << rt.create_array([rt.ArrayItem{ key: '@type', val: 'Offer' },
			rt.ArrayItem{ key: 'price', val: rt.call_method(var_order, 'get_line_subtotal', [
				var_item.clone(),
			]) }, rt.ArrayItem{ key: 'priceCurrency', val: rt.call_method(var_order,
				'get_currency', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'priceSpecification', val: rt.create_array([
				rt.ArrayItem{ key: 'price', val: rt.call_method(var_order, 'get_line_subtotal', [
					var_item.clone(),
				]) },
				rt.ArrayItem{ key: 'priceCurrency', val: rt.call_method(var_order, 'get_currency',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'eligibleQuantity', val: rt.create_array([
					rt.ArrayItem{ key: '@type', val: 'QuantitativeValue' },
					rt.ArrayItem{ key: 'value', val: rt.call_function('apply_filters', [
						rt.new_string('woocommerce_email_order_item_quantity'),
						rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}),
						var_item.clone(),
					]) },
				]) },
			]) }, rt.ArrayItem{ key: 'itemOffered', val: rt.create_array([
				rt.ArrayItem{ key: '@type', val: 'Product' },
				rt.ArrayItem{ key: 'name', val: rt.call_function('wp_kses_post', [
					rt.call_function('apply_filters', [
						rt.new_string('woocommerce_order_item_name'),
						rt.call_method(var_item, 'get_name', []rt.PhpVal{}),
						var_item.clone(),
						var_is_visible.clone(),
					]),
				]) },
				rt.ArrayItem{
					key: 'sku'
					val: if rt.is_true(var_product_exists) {
						rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
					} else {
						rt.new_string('')
					}
				},
				rt.ArrayItem{
					key: 'image'
					val: if rt.is_true(var_product_exists) { rt.call_function('wp_get_attachment_image_url', [
							rt.call_method(var_product, 'get_image_id', []rt.PhpVal{}),
						]) } else { rt.new_string('') }
				},
				rt.ArrayItem{
					key: 'url'
					val: if rt.is_true(var_is_visible) { rt.call_function('get_permalink', [
							rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
						]) } else { rt.call_function('get_home_url', []rt.PhpVal{}) }
				},
			]) }, rt.ArrayItem{ key: 'seller', val: rt.create_array([
				rt.ArrayItem{ key: '@type', val: 'Organization' },
				rt.ArrayItem{ key: 'name', val: var_shop_name },
				rt.ArrayItem{ key: 'url', val: var_shop_url },
			]) }])
	}
	mut var_markup := rt.new_array()
	var_markup['@type'] = rt.new_string('Order')
	var_markup['url'] = var_order_url.clone()
	var_markup['orderStatus'] = if var_order_statuses.array_isset(rt.call_method(var_order,
		'get_status', []rt.PhpVal{}))
	{
		var_order_statuses.array_get(rt.call_method(var_order, 'get_status', []rt.PhpVal{}))
	} else {
		rt.new_string('')
	}
	var_markup['orderNumber'] = rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})
	var_markup['orderDate'] = rt.call_method(rt.call_method(var_order, 'get_date_created',
		[]rt.PhpVal{}), 'format', [rt.new_string('c')])
	var_markup['acceptedOffer'] = var_markup_offers.clone()
	var_markup['discount'] = rt.call_method(var_order, 'get_total_discount', []rt.PhpVal{})
	var_markup['discountCurrency'] = rt.call_method(var_order, 'get_currency', []rt.PhpVal{})
	var_markup['price'] = rt.call_method(var_order, 'get_total', []rt.PhpVal{})
	var_markup['priceCurrency'] = rt.call_method(var_order, 'get_currency', []rt.PhpVal{})
	var_markup['priceSpecification'] = rt.create_array([
		rt.ArrayItem{ key: 'price', val: rt.call_method(var_order, 'get_total', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'priceCurrency', val: rt.call_method(var_order, 'get_currency',
			[]rt.PhpVal{}) },
	])
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		var_markup.array_get_mut('priceSpecification').array_set('valueAddedTaxIncluded', rt.call_function('wc_prices_include_tax',
			[]rt.PhpVal{}))
	}
	var_markup['billingAddress'] = rt.create_array([
		rt.ArrayItem{ key: '@type', val: 'PostalAddress' },
		rt.ArrayItem{ key: 'name', val: rt.call_method(var_order,
			'get_formatted_billing_full_name', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'streetAddress', val: rt.call_method(var_order, 'get_billing_address_1',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'postalCode', val: rt.call_method(var_order, 'get_billing_postcode',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'addressLocality', val: rt.call_method(var_order, 'get_billing_city',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'addressRegion', val: rt.call_method(var_order, 'get_billing_state',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'addressCountry', val: rt.call_method(var_order, 'get_billing_country',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'email', val: rt.call_method(var_order, 'get_billing_email',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'telephone', val: rt.call_method(var_order, 'get_billing_phone',
			[]rt.PhpVal{}) },
	])
	var_markup['customer'] = rt.create_array([
		rt.ArrayItem{ key: '@type', val: 'Person' },
		rt.ArrayItem{ key: 'name', val: rt.call_method(var_order,
			'get_formatted_billing_full_name', []rt.PhpVal{}) },
	])
	var_markup['merchant'] = rt.create_array([
		rt.ArrayItem{ key: '@type', val: 'Organization' },
		rt.ArrayItem{ key: 'name', val: var_shop_name },
		rt.ArrayItem{ key: 'url', val: var_shop_url },
	])
	var_markup['potentialAction'] = rt.create_array([
		rt.ArrayItem{ key: '@type', val: 'ViewAction' },
		rt.ArrayItem{ key: 'name', val: 'View Order' },
		rt.ArrayItem{ key: 'url', val: var_order_url },
		rt.ArrayItem{ key: 'target', val: var_order_url },
	])
	this.set_data(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_structured_data_order'),
		rt.create_array_from_native_map(var_markup),
		rt.new_bool(sent_to_admin),
		var_order.clone(),
	]), true)
}

fn (mut this Class_WC_Structured_Data) is_valid_gtin(var_gtin rt.PhpVal) bool {
	mut var_gtin_mutated := var_gtin
	return var_gtin_mutated.clone().is_string()
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(\\d{8}|\\d{12,14})$/'), var_gtin_mutated.clone()]))
}

fn (mut this Class_WC_Structured_Data) prepare_gtin(var_gtin rt.PhpVal) string {
	mut var_gtin_mutated := var_gtin
	if rt.is_true(rt.new_bool(!(rt.is_true(var_gtin_mutated))))
		|| !(var_gtin_mutated.clone().is_string()) {
		return ''
	}
	return (rt.call_function('preg_replace', [rt.new_string('/[^0-9]/'),
		rt.new_string(''), var_gtin_mutated.clone()])).str()
}

fn create_wc_structured_data() &Class_WC_Structured_Data {
	mut obj := &Class_WC_Structured_Data{
		PhpObjectBase: rt.PhpObjectBase{}
		_data:         rt.new_array()
	}
	obj.construct()
	return obj
}

fn (mut this Class_WC_Structured_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'set_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.set_data(dispatch_arg_0, dispatch_arg_1))
		}
		'get_data' {
			return this.get_data()
		}
		'get_structured_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_structured_data(dispatch_arg_0)
		}
		'get_data_type_for_page' {
			return this.get_data_type_for_page()
		}
		'output_email_structured_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.output_email_structured_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'output_structured_data' {
			this.output_structured_data()
			return rt.new_null()
		}
		'generate_product_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.generate_product_data(dispatch_arg_0)
			return rt.new_null()
		}
		'generate_review_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.generate_review_data(dispatch_arg_0)
			return rt.new_null()
		}
		'generate_breadcrumblist_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.generate_breadcrumblist_data(dispatch_arg_0)
			return rt.new_null()
		}
		'generate_website_data' {
			this.generate_website_data()
			return rt.new_null()
		}
		'generate_order_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.generate_order_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'is_valid_gtin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_gtin(dispatch_arg_0))
		}
		'prepare_gtin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.prepare_gtin(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Structured_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'_data' { return this._data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Structured_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'_data' {
			this._data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
