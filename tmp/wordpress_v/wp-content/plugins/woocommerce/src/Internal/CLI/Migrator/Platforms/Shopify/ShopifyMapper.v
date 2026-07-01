import rt

pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper.weight_unit_map() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'GRAMS', val: 'g' }, rt.ArrayItem{ key: 'KILOGRAMS', val: 'kg' }, rt.ArrayItem{ key: 'POUNDS', val: 'lb' }, rt.ArrayItem{ key: 'OUNCES', val: 'oz' }])
}
pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper.weight_conversion_factors() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'kg', val: rt.create_array([rt.ArrayItem{ key: 'kg', val: 1 }, rt.ArrayItem{ key: 'g', val: 1000 }, rt.ArrayItem{ key: 'lb', val: 2.20462 }, rt.ArrayItem{ key: 'oz', val: 35.274 }]) }, rt.ArrayItem{ key: 'g', val: rt.create_array([rt.ArrayItem{ key: 'kg', val: 0.001 }, rt.ArrayItem{ key: 'g', val: 1 }, rt.ArrayItem{ key: 'lb', val: 0.00220462 }, rt.ArrayItem{ key: 'oz', val: 0.035274 }]) }, rt.ArrayItem{ key: 'lb', val: rt.create_array([rt.ArrayItem{ key: 'kg', val: 0.453592 }, rt.ArrayItem{ key: 'g', val: 453.592 }, rt.ArrayItem{ key: 'lb', val: 1 }, rt.ArrayItem{ key: 'oz', val: 16 }]) }, rt.ArrayItem{ key: 'oz', val: rt.create_array([rt.ArrayItem{ key: 'kg', val: 0.0283495 }, rt.ArrayItem{ key: 'g', val: 28.3495 }, rt.ArrayItem{ key: 'lb', val: 0.0625 }, rt.ArrayItem{ key: 'oz', val: 1 }]) }])
}
struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper {
	rt.PhpObjectBase
pub mut:
		fields_to_process rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) construct(mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array)  {
	this.fields_to_process = if !(var_args.array_get('fields')).is_null() { var_args.array_get('fields') } else { this.get_default_product_fields() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) map_product_data(mut var_shopify_product Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object) rt.PhpVal {
	mut var_is_variable := rt.new_bool(this.is_variable_product(mut var_shopify_product))
	mut var_wc_data := this.map_basic_product_fields(mut var_shopify_product, (var_is_variable).to_bool())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_variable)))) {
		mut var_simple_data := this.map_simple_product_data(mut var_shopify_product)
		var_wc_data = rt.call_function('array_merge', [var_wc_data.dup(), var_simple_data.dup()])
	}
	var_wc_data.array_set('images', this.map_product_images(mut var_shopify_product))
	var_wc_data.array_set('metafields', this.map_metafields(mut var_shopify_product))
	mut var_variable_data := this.map_variable_product_data(mut var_shopify_product, (var_is_variable).to_bool())
	var_wc_data = rt.call_function('array_merge', [var_wc_data.dup(), var_variable_data.dup()])
	return var_wc_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) is_variable_product(mut var_shopify_product Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object) bool {
	return !(rt.get_property(rt.get_property(var_shopify_product, 'variants'), 'edges')).is_null() && rt.get_property(rt.get_property(var_shopify_product, 'variants'), 'edges').array_count() > 1
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) get_woo_product_status(mut var_shopify_product Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object) string {
	mut var_woo_product_status := rt.new_string(rt.new_string('draft'))
	if rt.is_true(rt.identical(rt.new_string('ACTIVE'), rt.get_property(var_shopify_product, 'status'))) {
		var_woo_product_status = rt.new_string(rt.new_string('publish'))
	}
	return (var_woo_product_status).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) map_enhanced_status(mut var_shopify_product Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object) rt.PhpVal {
	mut var_status_data := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('property_exists', [var_shopify_product, rt.new_string('publishedAt')])) && rt.is_true(rt.get_property(var_shopify_product, 'publishedAt')))) {
		var_status_data.array_set('date_published_gmt', rt.get_property(var_shopify_product, 'publishedAt'))
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.call_function('property_exists', [var_shopify_product, rt.new_string('availableForSale')])) {
		var_status_data.array_set('available_for_sale', rt.get_property(var_shopify_product, 'availableForSale'))
		// unsupported statement: Stmt_Nop
	}
	return var_status_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) map_product_classification(mut var_shopify_product Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object) rt.PhpVal {
	mut var_classification := rt.new_array()
	mut var_product_type := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('property_exists', [var_shopify_product, rt.new_string('productType')])) && rt.is_true(rt.get_property(var_shopify_product, 'productType')))) {
		var_product_type = rt.get_property(var_shopify_product, 'productType')
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('property_exists', [var_shopify_product, rt.new_string('product_type')])) && rt.is_true(rt.get_property(var_shopify_product, 'product_type')))) {
		var_product_type = rt.get_property(var_shopify_product, 'product_type')
	}
	if rt.is_true(var_product_type) {
		var_classification.array_set('product_type', rt.create_array([rt.ArrayItem{ key: 'name', val: var_product_type }, rt.ArrayItem{ key: 'slug', val: rt.call_function('sanitize_title', [var_product_type.dup()]) }]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('property_exists', [var_shopify_product, rt.new_string('category')])) && rt.is_true(rt.new_bool(rt.get_property(var_shopify_product, 'category').is_object())))) {
		var_classification.array_set('standard_category', rt.create_array([rt.ArrayItem{ key: 'name', val: if !(rt.get_property(rt.get_property(var_shopify_product, 'category'), 'name')).is_null() { rt.get_property(rt.get_property(var_shopify_product, 'category'), 'name') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'slug', val: rt.call_function('sanitize_title', [if !(rt.get_property(rt.get_property(var_shopify_product, 'category'), 'name')).is_null() { rt.get_property(rt.get_property(var_shopify_product, 'category'), 'name') } else { rt.new_string('') }]) }]))
	}
	if rt.is_true(rt.call_function('property_exists', [var_shopify_product, rt.new_string('isGiftCard')])) {
		var_classification.array_set('is_gift_card', rt.get_property(var_shopify_product, 'isGiftCard'))
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.call_function('property_exists', [var_shopify_product, rt.new_string('is_gift_card')])) {
		var_classification.array_set('is_gift_card', rt.get_property(var_shopify_product, 'is_gift_card'))
	}
	if rt.is_true(rt.call_function('property_exists', [var_shopify_product, rt.new_string('requiresSellingPlan')])) {
		var_classification.array_set('requires_subscription', rt.get_property(var_shopify_product, 'requiresSellingPlan'))
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.call_function('property_exists', [var_shopify_product, rt.new_string('requires_selling_plan')])) {
		var_classification.array_set('requires_subscription', rt.get_property(var_shopify_product, 'requires_selling_plan'))
	}
	return var_classification.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) map_seo_fields(mut var_shopify_product Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object) rt.PhpVal {
	mut var_seo_data := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('property_exists', [var_shopify_product, rt.new_string('seo')])) && rt.is_true(rt.new_bool(rt.get_property(var_shopify_product, 'seo').is_object())))) {
		if !(!rt.is_true(rt.get_property(rt.get_property(var_shopify_product, 'seo'), 'title'))) {
			var_seo_data.array_set('global_title_tag', rt.get_property(rt.get_property(var_shopify_product, 'seo'), 'title'))
		}
		if !(!rt.is_true(rt.get_property(rt.get_property(var_shopify_product, 'seo'), 'description'))) {
			var_seo_data.array_set('global_description_tag', rt.get_property(rt.get_property(var_shopify_product, 'seo'), 'description'))
		}
	}
	return var_seo_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) get_mapped_categories(mut var_shopify_product Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object) rt.PhpVal {
	mut var_categories := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('property_exists', [var_shopify_product, rt.new_string('collections')]))))) || !rt.is_true(rt.get_property(rt.get_property(var_shopify_product, 'collections'), 'edges')))) {
		return var_categories.dup()
	}
	{
		mut iter_1 := rt.get_property(rt.get_property(var_shopify_product, 'collections'), 'edges').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_collection_edge := item_1.val
			mut var_collection_node := rt.get_property(var_collection_edge, 'node')
			var_categories.array_push(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('wc_clean', [rt.get_property(var_collection_node, 'title')]) }, rt.ArrayItem{ key: 'slug', val: rt.call_function('sanitize_title', [rt.get_property(var_collection_node, 'handle')]) }]))
		}
	}
	return var_categories.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) get_mapped_tags(mut var_shopify_product Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object) rt.PhpVal {
	mut var_tags := rt.new_array()
	if !rt.is_true(rt.get_property(var_shopify_product, 'tags')) {
		return var_tags.dup()
	}
	{
		mut iter_1 := rt.get_property(var_shopify_product, 'tags').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tag := item_1.val
			mut var_trimmed_tag := rt.new_string(rt.new_string(var_tag.dup().to_string().trim_space()))
			if !(!rt.is_true(var_trimmed_tag)) {
				var_tags.array_push(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('wc_clean', [var_trimmed_tag.dup()]) }, rt.ArrayItem{ key: 'slug', val: rt.call_function('sanitize_title', [var_trimmed_tag.dup()]) }]))
			}
		}
	}
	return var_tags.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) get_converted_weight(var_weight rt.PhpVal, var_weight_unit rt.PhpVal) f64 {
	mut var_weight_mutated := var_weight
	mut var_weight_unit_mutated := var_weight_unit
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_weight_mutated)) || rt.is_true(rt.identical(rt.new_null(), var_weight_unit_mutated)))) || rt.is_true(rt.less_equal(// unsupported expression: Expr_Cast_Double, rt.new_int(0))))) {
		return (rt.new_null()).to_f64()
	}
	mut var_shopify_unit_key := if !(Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper.weight_unit_map().array_get(var_weight_unit_mutated)).is_null() { Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper.weight_unit_map().array_get(var_weight_unit_mutated) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_shopify_unit_key)))) {
		return (// unsupported expression: Expr_Cast_Double).to_f64()
	}
	mut var_store_weight_unit := rt.call_function('get_option', [rt.new_string('woocommerce_weight_unit')])
	if rt.is_true(rt.identical(rt.new_string('lbs'), var_store_weight_unit)) {
		var_store_weight_unit = rt.new_string(rt.new_string('lb'))
	}
	if rt.is_true(rt.identical(var_shopify_unit_key, var_store_weight_unit)) {
		return (// unsupported expression: Expr_Cast_Double).to_f64()
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_weight')])) {
		mut var_converted := rt.call_function('wc_get_weight', [// unsupported expression: Expr_Cast_Double, var_store_weight_unit.dup(), var_shopify_unit_key.dup()])
		return (if rt.is_true(rt.new_bool(var_converted.dup().is_long() || var_converted.dup().is_double())) { // unsupported expression: Expr_Cast_Double } else { rt.new_null() }).to_f64()
	}
	if !(Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper.weight_conversion_factors().array_get(var_shopify_unit_key).array_isset(var_store_weight_unit)) {
		return (// unsupported expression: Expr_Cast_Double).to_f64()
	}
	return (rt.mul(// unsupported expression: Expr_Cast_Double, Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper.weight_conversion_factors().array_get(var_shopify_unit_key).array_get(var_store_weight_unit))).to_f64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) should_process(field_key string) bool {
	if !rt.is_true(this.fields_to_process) {
		return true
	}
	return (rt.call_function('in_array', [rt.new_string(field_key), this.fields_to_process, rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) map_basic_product_fields(mut var_shopify_product Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object, is_variable bool) rt.PhpVal {
	mut is_variable_mutated := is_variable
	mut var_basic_data := rt.new_array()
	var_basic_data.array_set('is_variable', is_variable_mutated)
	var_basic_data.array_set('original_product_id', if !(!rt.is_true(rt.get_property(var_shopify_product, 'id'))) { rt.call_function('basename', [rt.get_property(var_shopify_product, 'id')]) } else { rt.new_null() })
	var_basic_data.array_set('name', rt.call_function('wc_clean', [rt.get_property(var_shopify_product, 'title')]))
	var_basic_data.array_set('slug', rt.call_function('sanitize_title', [rt.get_property(var_shopify_product, 'handle')]))
	var_basic_data.array_set('description', rt.call_function('wp_kses_post', [if !(rt.get_property(var_shopify_product, 'descriptionHtml')).is_null() { rt.get_property(var_shopify_product, 'descriptionHtml') } else { rt.new_string('') }]))
	var_basic_data.array_set('short_description', rt.call_function('wp_kses_post', [if !(rt.get_property(var_shopify_product, 'descriptionPlainSummary')).is_null() { rt.get_property(var_shopify_product, 'descriptionPlainSummary') } else { rt.new_string('') }]))
	var_basic_data.array_set('status', this.get_woo_product_status(mut var_shopify_product))
	var_basic_data.array_set('date_created_gmt', rt.get_property(var_shopify_product, 'createdAt'))
	if rt.is_true(rt.call_function('property_exists', [var_shopify_product, rt.new_string('updatedAt')])) {
		var_basic_data.array_set('date_modified_gmt', rt.get_property(var_shopify_product, 'updatedAt'))
		// unsupported statement: Stmt_Nop
	}
	var_basic_data.array_set('catalog_visibility', 'visible')
	var_basic_data.array_set('original_url', rt.new_null())
	if rt.is_true(rt.call_function('property_exists', [var_shopify_product, rt.new_string('onlineStoreUrl')])) {
		if rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_shopify_product, 'onlineStoreUrl'))) {
			var_basic_data.array_set('catalog_visibility', 'hidden')
		} else {
			var_basic_data.array_set('original_url', rt.get_property(var_shopify_product, 'onlineStoreUrl'))
			// unsupported statement: Stmt_Nop
		}
	}
	mut var_enhanced_status := this.map_enhanced_status(mut var_shopify_product)
	var_basic_data = rt.call_function('array_merge', [var_basic_data.dup(), var_enhanced_status.dup()])
	var_basic_data.array_set('categories', this.get_mapped_categories(mut var_shopify_product))
	var_basic_data.array_set('tags', this.get_mapped_tags(mut var_shopify_product))
	mut var_classification := this.map_product_classification(mut var_shopify_product)
	var_basic_data = rt.call_function('array_merge', [var_basic_data.dup(), var_classification.dup()])
	mut var_brand_name := if !(rt.get_property(var_shopify_product, 'vendor')).is_null() { rt.get_property(var_shopify_product, 'vendor') } else { rt.new_null() }
	var_basic_data.array_set('brand', if rt.is_true(var_brand_name) { rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('wc_clean', [var_brand_name.dup()]) }, rt.ArrayItem{ key: 'slug', val: rt.call_function('sanitize_title', [var_brand_name.dup()]) }]) } else { rt.new_null() })
	return var_basic_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) map_simple_product_data(mut var_shopify_product Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object) rt.PhpVal {
	mut var_simple_data := rt.new_array()
	if !(!rt.is_true(rt.get_property(rt.get_property(var_shopify_product, 'variants'), 'edges'))) {
		mut var_variant_node := rt.get_property(rt.get_property(rt.get_property(, 'variants'), 'edges').array_get(0), 'node')
		if this.should_process('price') {
			if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_variant_node, 'compareAtPrice')) && rt.is_true(rt.greater(rt.get_property(, 'compareAtPrice'), rt.get_property(, 'price'))))) {
				var_simple_data.array_set('sale_price', rt.get_property(, 'price'))
				.array_set(, )
				// unsupported statement: Stmt_Nop
			} else {
			}
		}
		if this.should_process() {
			
		}
		if rt.is_true() {
		}
		if rt.is_true() {
		}
		if rt.is_true() {
		}
		if rt.is_true() {
		}
		
	} else {
	}
	return .dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) map_variable_product_data(mut var_shopify_product Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object, is_variable bool) rt.PhpVal {
	mut is_variable_mutated := is_variable
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) map_product_images(mut var_shopify_product Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) map_metafields(mut var_shopify_product Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) get_default_product_fields() rt.PhpVal {
}

fn create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_shopifymapper(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper{
		PhpObjectBase: rt.PhpObjectBase{}
		fields_to_process: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'map_product_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.map_product_data(mut dispatch_arg_0)
		}
		'is_variable_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_variable_product(mut dispatch_arg_0))
		}
		'get_woo_product_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_woo_product_status(mut dispatch_arg_0))
		}
		'map_enhanced_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.map_enhanced_status(mut dispatch_arg_0)
		}
		'map_product_classification' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.map_product_classification(mut dispatch_arg_0)
		}
		'map_seo_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.map_seo_fields(mut dispatch_arg_0)
		}
		'get_mapped_categories' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_mapped_categories(mut dispatch_arg_0)
		}
		'get_mapped_tags' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_mapped_tags(mut dispatch_arg_0)
		}
		'get_converted_weight' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_float(this.get_converted_weight(dispatch_arg_0, dispatch_arg_1))
		}
		'should_process' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.should_process(dispatch_arg_0))
		}
		'map_basic_product_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.map_basic_product_fields(mut dispatch_arg_0, dispatch_arg_1)
		}
		'map_simple_product_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.map_simple_product_data(mut dispatch_arg_0)
		}
		'map_variable_product_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.map_variable_product_data(mut dispatch_arg_0, dispatch_arg_1)
		}
		'map_product_images' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.map_product_images(mut dispatch_arg_0)
		}
		'map_metafields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_object](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.map_metafields(mut dispatch_arg_0)
		}
		'get_default_product_fields' {
			return this.get_default_product_fields()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fields_to_process' { return this.fields_to_process }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyMapper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fields_to_process' { this.fields_to_process = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_internal_cli_migrator_platforms_shopify_shopifymapper_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
