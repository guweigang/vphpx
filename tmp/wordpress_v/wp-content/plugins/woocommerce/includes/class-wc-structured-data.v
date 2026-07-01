import rt

struct Class_WC_Structured_Data {
	rt.PhpObjectBase
pub mut:
		_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Structured_Data) construct()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_before_main_content'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Structured_Data', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'generate_website_data' }]), rt.new_int(30)])
	rt.call_function('add_action', [rt.new_string('woocommerce_breadcrumb'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Structured_Data', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'generate_breadcrumblist_data' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('woocommerce_single_product_summary'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Structured_Data', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'generate_product_data' }]), rt.new_int(60)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_order_details'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Structured_Data', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'generate_order_data' }]), rt.new_int(20), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_order_details'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Structured_Data', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'output_email_structured_data' }]), rt.new_int(30), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('wp_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Structured_Data', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'output_structured_data' }]), rt.new_int(10)])
}

fn (mut this Class_WC_Structured_Data) set_data(var_data rt.PhpVal, reset bool) bool {
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(!(var_data_mutated.array_isset(rt.new_string('@type'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^[a-zA-Z]{1,20}$|'), var_data_mutated.array_get('@type')]))))))) {
		return false
	}
	if var_reset && !(this._data).is_null() {
		this._data = rt.new_null()
	}
	this._data.array_push(var_data_mutated.dup())
	return true
}

fn (mut this Class_WC_Structured_Data) get_data() rt.PhpVal {
	return this._data
}

fn (mut this Class_WC_Structured_Data) get_structured_data(var_types rt.PhpVal) rt.PhpVal {
	mut var_types_mutated := var_types
	mut var_data := rt.new_array()
	{
		mut iter_1 := this.get_data().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			var_data.array_get_mut(var_value.array_get('@type').to_string().to_lower()).array_push(var_value.dup())
		}
	}
	{
		mut iter_1 := var_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_type := item_1.key
			var_data.array_set(var_type, if var_value.dup().array_count() > 1 { rt.create_array([rt.ArrayItem{ key: '@graph', val: var_value }]) } else { var_value.array_get(0) })
			var_data.array_set(var_type, rt.add(rt.call_function('apply_filters', [rt.new_string('woocommerce_structured_data_context'), rt.create_array([rt.ArrayItem{ key: '@context', val: 'https://schema.org/' }]), var_data.dup(), var_type.dup(), var_value.dup()]), var_data.array_get(var_type)))
		}
	}
	var_data = if rt.is_true(var_types_mutated) { rt.call_function('array_values', [rt.call_function('array_intersect_key', [var_data.dup(), rt.call_function('array_flip', [var_types_mutated.dup()])])]) } else { rt.call_function('array_values', [var_data.dup()]) }
	if !(!rt.is_true(var_data)) {
		if 1 < var_data.dup().array_count() {
			var_data = rt.add(rt.call_function('apply_filters', [rt.new_string('woocommerce_structured_data_context'), rt.create_array([rt.ArrayItem{ key: '@context', val: 'https://schema.org/' }]), var_data.dup(), rt.new_string(''), rt.new_string('')]), rt.create_array([rt.ArrayItem{ key: '@graph', val: var_data }]))
		} else {
			var_data = var_data.array_get(0)
		}
	}
	return var_data.dup()
}

fn (mut this Class_WC_Structured_Data) get_data_type_for_page() rt.PhpVal {
	mut var_types := rt.new_array()
	var_types.array_push(if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_shop', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_product_category', []rt.PhpVal{})))) || rt.is_true(rt.call_function('is_product', []rt.PhpVal{})))) { 'product' } else { '' })
	var_types.array_push(if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_shop', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})))) { 'website' } else { '' })
	var_types.array_push(if rt.is_true(rt.call_function('is_product', []rt.PhpVal{})) { 'review' } else { '' })
	var_types.array_push('breadcrumblist')
	var_types.array_push('order')
	return rt.call_function('array_filter', [rt.call_function('apply_filters', [rt.new_string('woocommerce_structured_data_type_for_page'), var_types.dup()])])
}

fn (mut this Class_WC_Structured_Data) output_email_structured_data(var_order rt.PhpVal, sent_to_admin bool, plain_text bool)  {
	if var_plain_text {
		return rt.new_null()
	}
	print('<div style="display: none; font-size: 0; max-height: 0; line-height: 0; padding: 0; mso-hide: all;">')
	this.output_structured_data()
	print('</div>')
}

fn (mut this Class_WC_Structured_Data) output_structured_data()  {
	mut var_types := this.get_data_type_for_page()
	mut var_data := this.get_structured_data(var_types.dup())
	if rt.is_true(var_data) {
		print('<script type="application/ld+json">' + (rt.call_function('wc_esc_json', [rt.call_function('wp_json_encode', [var_data.dup(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]), rt.new_bool(true)])).str() + '</script>')
		// unsupported statement: Stmt_Nop
	}
}

fn (mut this Class_WC_Structured_Data) generate_product_data(var_product rt.PhpVal)  {
	mut var_child_prices := []rt.PhpVal{}
	mut var_child_sale_prices := []rt.PhpVal{}
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_product_mutated.dup().is_object()))))) {
		// unsupported statement: Stmt_Global
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_product_mutated.dup(), rt.new_string('WC_Product')]))))) {
		return rt.new_null()
	}
	mut var_shop_name := rt.call_function('get_bloginfo', [rt.new_string('name')])
	mut var_shop_url := rt.call_function('home_url', []rt.PhpVal{})
	mut var_currency := rt.call_function('get_woocommerce_currency', []rt.PhpVal{})
	mut var_permalink := rt.call_function('get_permalink', [rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})])
	mut var_image := rt.call_function('wp_get_attachment_url', [rt.call_method(var_product_mutated, 'get_image_id', []rt.PhpVal{})])
	mut var_markup := { '@type': rt.new_string('Product'), '@id': (var_permalink).str() + '#product', 'name': rt.call_function('wp_kses_post', [rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{})]), 'url': var_permalink, 'description': rt.call_function('wp_strip_all_tags', [rt.call_function('do_shortcode', [if rt.is_true(rt.call_method(var_product_mutated, 'get_short_description', []rt.PhpVal{})) { rt.call_method(var_product_mutated, 'get_short_description', []rt.PhpVal{}) } else { rt.call_method(var_product_mutated, 'get_description', []rt.PhpVal{}) }])]) }
	if rt.is_true(var_image) {
		var_markup['image'] = var_image.dup()
	}
	if rt.is_true(rt.call_method(var_product_mutated, 'get_sku', []rt.PhpVal{})) {
		var_markup['sku'] = rt.call_method(var_product_mutated, 'get_sku', []rt.PhpVal{})
	} else {
		var_markup['sku'] = rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
	}
	mut var_gtin := rt.new_string(this.prepare_gtin(rt.call_method(var_product_mutated, 'get_global_unique_id', []rt.PhpVal{})))
	if this.is_valid_gtin(var_gtin.dup()) {
		var_markup['gtin'] = var_gtin.dup()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_price_valid_until := rt.call_function('gmdate', [rt.new_string('Y-12-31'), rt.add(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('YEAR_IN_SECONDS'))])
		if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) {
			mut var_lowest := rt.call_method(var_product_mutated, 'get_variation_price', [rt.new_string('min'), rt.new_bool(true)])
			mut var_highest := rt.call_method(var_product_mutated, 'get_variation_price', [rt.new_string('max'), rt.new_bool(true)])
			mut var_variation_prices := rt.call_method(var_product_mutated, 'get_variation_prices', [rt.new_bool(true)])
			if rt.is_true(rt.identical(var_lowest, var_highest)) {
				mut var_unit_price_spec := { '@type': rt.new_string('UnitPriceSpecification'), 'price': rt.call_function('wc_format_decimal', [var_lowest.dup(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]), 'priceCurrency': var_currency, 'validThrough': var_price_valid_until }
				if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
					var_unit_price_spec['valueAddedTaxIncluded'] = rt.identical(rt.new_string('incl'), rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_shop')]))
				}
				mut var_markup_offer := { '@type': rt.new_string('Offer'), 'priceSpecification': map[string]rt.PhpVal{} }
			} else {
				var_markup_offer = { '@type': rt.new_string('AggregateOffer'), 'lowPrice': rt.call_function('wc_format_decimal', [var_lowest.dup(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]), 'highPrice': rt.call_function('wc_format_decimal', [var_highest.dup(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]), 'offerCount': rt.new_int(var_variation_prices.array_get('price').array_count()) }
				if rt.is_true(rt.call_method(var_product_mutated, 'is_on_sale', []rt.PhpVal{})) {
					mut var_lowest_child_sale_price := rt.call_method(var_product_mutated, 'get_variation_sale_price', [rt.new_string('min'), rt.new_bool(true)])
					{
						mut iter_1 := var_variation_prices.array_get('sale_price').iterator()
						for {
							item_1 := iter_1.next() or { break }
							mut var_variation_price := item_1.val
							mut var_variation_id := item_1.key
							if rt.is_true(rt.identical(var_variation_price, var_lowest_child_sale_price)) {
								break
							}
						}
					}
					mut var_date_on_sale_to := if !(var_variation_id).is_null() { rt.call_method(rt.call_function('wc_get_product', [var_variation_id.dup()]), 'get_date_on_sale_to', []rt.PhpVal{}) } else { rt.new_null() }
					mut var_sale_price_valid_until := if rt.is_true(var_date_on_sale_to) { rt.call_function('gmdate', [rt.new_string('Y-m-d'), rt.call_method(var_date_on_sale_to, 'getTimestamp', []rt.PhpVal{})]) } else { rt.new_null() }
					mut var_sale_unit_price_spec := { '@type': rt.new_string('UnitPriceSpecification'), 'priceType': rt.new_string('https://schema.org/SalePrice'), 'price': rt.call_function('wc_format_decimal', [var_lowest_child_sale_price.dup(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]), 'priceCurrency': var_currency, 'validThrough': if !(var_sale_price_valid_until).is_null() { var_sale_price_valid_until } else { var_price_valid_until } }
					if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
						var_sale_unit_price_spec['valueAddedTaxIncluded'] = rt.identical(rt.new_string('incl'), rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_shop')]))
					}
					var_markup_offer['priceSpecification'] = rt.create_array([rt.ArrayItem{ key: none, val: var_sale_unit_price_spec }])
				}
			}
		} else if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.grouped()])) {
			mut var_tax_display_mode := rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_shop')])
			mut var_child_ids := rt.call_method(var_product_mutated, 'get_children', []rt.PhpVal{})
			rt.call_function('_prime_post_caches', [var_child_ids.dup()])
			mut var_children := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('wc_get_product'), var_child_ids.dup()]), rt.new_string('wc_products_array_filter_visible_grouped')])
			mut var_price_function := rt.new_string(if rt.is_true(rt.identical(rt.new_string('incl'), var_tax_display_mode)) { rt.new_string('wc_get_price_including_tax') } else { rt.new_string('wc_get_price_excluding_tax') })
			{
				mut iter_1 := var_children.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_child := item_1.val
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						var_child_prices << rt.call_callable(var_price_function, [var_child.dup(), rt.create_array([rt.ArrayItem{ key: 'price', val: rt.call_method(var_child, 'get_regular_price', []rt.PhpVal{}) }])])
					}
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						var_child_sale_prices << rt.call_callable(var_price_function, [var_child.dup(), rt.create_array([rt.ArrayItem{ key: 'price', val: rt.call_method(var_child, 'get_sale_price', []rt.PhpVal{}) }])])
					}
				}
			}
			if !rt.is_true(var_child_prices) {
				mut var_min_price := rt.new_int(rt.new_int(0))
			} else {
				var_min_price = rt.call_function('min', [var_child_prices.dup()])
			}
			if !rt.is_true(var_child_sale_prices) {
				mut var_min_sale_price := rt.new_int(rt.new_int(0))
			} else {
				var_min_sale_price = rt.call_function('min', [var_child_sale_prices.dup()])
			}
			mut var_unit_price_specification := { '@type': rt.new_string('UnitPriceSpecification'), 'price': rt.call_function('wc_format_decimal', [var_min_price.dup(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]), 'priceCurrency': var_currency, 'validThrough': var_price_valid_until }
			if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
				var_unit_price_specification['valueAddedTaxIncluded'] = rt.identical(rt.new_string('incl'), var_tax_display_mode)
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product_mutated, 'is_on_sale', []rt.PhpVal{})) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_unit_price_specification['priceType'] = rt.new_string('https://schema.org/ListPrice')
			}
			var_markup_offer = { '@type': rt.new_string('Offer'), 'priceSpecification': map[string]rt.PhpVal{} }
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product_mutated, 'is_on_sale', []rt.PhpVal{})) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				if rt.is_true(rt.call_method(var_product_mutated, 'get_date_on_sale_to', []rt.PhpVal{})) {
					var_sale_price_valid_until = rt.call_function('gmdate', [rt.new_string('Y-m-d'), rt.call_method(rt.call_method(var_product_mutated, 'get_date_on_sale_to', []rt.PhpVal{}), 'getTimestamp', []rt.PhpVal{})])
				}
				mut var_grouped_sale_spec := { '@type': rt.new_string('UnitPriceSpecification'), 'price': rt.call_function('wc_format_decimal', [var_min_sale_price.dup(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]), 'priceCurrency': var_currency, 'validThrough': if !(var_sale_price_valid_until).is_null() { var_sale_price_valid_until } else { var_price_valid_until } }
				if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
					var_grouped_sale_spec['valueAddedTaxIncluded'] = rt.identical(rt.new_string('incl'), var_tax_display_mode)
				}
				rt.call_function('array_unshift', [var_markup_offer.array_get('priceSpecification'), var_grouped_sale_spec.dup()])
			}
		} else {
			var_tax_display_mode = rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_shop')])
			mut var_regular_price := if rt.is_true(rt.identical(rt.new_string('incl'), var_tax_display_mode)) { rt.call_function('wc_get_price_including_tax', [var_product_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'price', val: rt.call_method(var_product_mutated, 'get_regular_price', []rt.PhpVal{}) }])]) } else { rt.call_function('wc_get_price_excluding_tax', [var_product_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'price', val: rt.call_method(var_product_mutated, 'get_regular_price', []rt.PhpVal{}) }])]) }
			var_unit_price_specification = { '@type': rt.new_string('UnitPriceSpecification'), 'price': rt.call_function('wc_format_decimal', [var_regular_price.dup(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]), 'priceCurrency': var_currency, 'validThrough': var_price_valid_until }
			if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
				var_unit_price_specification['valueAddedTaxIncluded'] = rt.identical(rt.new_string('incl'), var_tax_display_mode)
			}
			if rt.is_true(rt.call_method(var_product_mutated, 'is_on_sale', []rt.PhpVal{})) {
				var_unit_price_specification['priceType'] = rt.new_string('https://schema.org/ListPrice')
			}
			var_markup_offer = { : , :  }
			if rt.is_true(rt.call_method(, 'is_on_sale', []rt.PhpVal{})) {
				
			}
		}
		if rt.is_true(rt.call_method(, 'is_in_stock', []rt.PhpVal{})) {
			
		} else {
		}
		
	}
	if rt.is_true() {
	}
	if !rt.is_true() && !rt.is_true() && !rt.is_true() {
	}
	
}

fn (mut this Class_WC_Structured_Data) generate_review_data(var_comment rt.PhpVal)  {
}

fn (mut this Class_WC_Structured_Data) generate_breadcrumblist_data(var_breadcrumbs rt.PhpVal)  {
}

fn (mut this Class_WC_Structured_Data) generate_website_data()  {
}

fn (mut this Class_WC_Structured_Data) generate_order_data(var_order rt.PhpVal, sent_to_admin bool, plain_text bool)  {
}

fn (mut this Class_WC_Structured_Data) is_valid_gtin(var_gtin rt.PhpVal) bool {
	mut var_gtin_mutated := var_gtin
}

fn (mut this Class_WC_Structured_Data) prepare_gtin(var_gtin rt.PhpVal) string {
	mut var_gtin_mutated := var_gtin
}

fn create_wc_structured_data() &Class_WC_Structured_Data {
	mut obj := &Class_WC_Structured_Data{
		PhpObjectBase: rt.PhpObjectBase{}
		_data: rt.new_array()
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
		else { return none }
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
		'_data' { this._data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_structured_data_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
