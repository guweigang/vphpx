import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('add-to-cart-with-options')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) get_template_part_path(var_product_type rt.PhpVal) string {
	mut var_product_type_mutated := var_product_type
	if rt.is_true(rt.call_function('in_array', [var_product_type_mutated.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.simple() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.external() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.variable() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.grouped() },
		]),
		rt.new_bool(true)]))
	{
		mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Package{}
		mut iife_result_0 := iife_temp_0.get_path()
		return iife_result_0.str() + 'templates/' +
			(Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.directory_names().array_get(rt.new_string('TEMPLATE_PARTS'))).str() + '/' + var_product_type_mutated.str() +
			'-product-add-to-cart-with-options.html'
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('__experimental_woocommerce_' + var_product_type_mutated.str() +
			'_add_to_cart_with_options_block_template_part'),
		rt.new_bool(false),
		var_product_type_mutated.clone(),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) get_product_type_for_add_to_cart_template(mut var_product Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product) string {
	mut var_product_mutated := var_product
	return (if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_method(var_product_mutated,
		'get_type', []rt.PhpVal{})))
	{
		Class_Automattic_WooCommerce_Enums_ProductType.simple()
	} else {
		rt.call_method(var_product_mutated, 'get_type', []rt.PhpVal{})
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) enqueue_assets(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) {
	mut var_product_id := if var_block.clone().is_object()
		&& rt.is_true(rt.call_function('property_exists', [var_block.clone(), rt.new_string('context')]))
		&& rt.get_property(var_block, 'context').is_array()
		&& rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')))) {
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))
	} else {
		rt.new_null()
	}
	if !var_product_id.is_null() {
		mut var_rendered_product := rt.call_function('wc_get_product', [
			var_product_id.clone()])
		if rt.is_true(rt.new_bool(rt.instance_of(var_rendered_product,
			'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product')))
		{
			mut var_product_type :=
				rt.new_string(this.get_product_type_for_add_to_cart_template(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product](var_rendered_product)))
			mut var_template_part_path :=
				rt.new_string(this.get_template_part_path(var_product_type.clone()))
			if var_template_part_path.clone().is_string()
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_template_part_path))))
				&& rt.is_true(rt.call_function('file_exists', [var_template_part_path.clone()])) {
				rt.call_function('wp_enqueue_script_module', [
					rt.new_string('woocommerce/add-to-cart-with-options'),
				])
			}
		}
	}
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_assets(var_attributes.clone(),
		var_content.clone(), var_block.clone())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_array) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_array',
		[]string{}, var_attributes))
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'add', [rt.new_string('productTypes'),
			rt.call_function('wc_get_product_types', []rt.PhpVal{})])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'add', [
			rt.new_string('addToCartWithOptionsTemplatePartIds'),
			this.get_template_part_ids(),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) get_template_part_ids() rt.PhpVal {
	mut var_product_types := rt.func_array_keys(rt.call_function('wc_get_product_types',
		[]rt.PhpVal{}))
	mut var_current_theme := rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}),
		'get_stylesheet', []rt.PhpVal{})
	mut var_template_part_ids := rt.new_array()
	mut iter_1 := var_product_types.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_product_type := item_1.val
		mut var_slug := rt.new_string(var_product_type.str() + '-product-add-to-cart-with-options')
		mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
		mut iife_result_1 := iife_temp_1.theme_has_template_part(var_slug.clone())
		mut var_theme_has_template := iife_result_1
		if rt.is_true(var_theme_has_template) {
			var_template_part_ids.array_set(var_product_type,
				'${var_current_theme.to_string()}//${var_slug.to_string()}')
		} else {
			var_template_part_ids.array_set(var_product_type,
				'woocommerce/woocommerce//${var_slug.to_string()}')
		}
	}
	return var_template_part_ids.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) set_is_descendant_of_add_to_cart_with_options_context(var_context rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	if rt.is_true(rt.identical(rt.new_string('woocommerce/product-button'),
		var_block.array_get(rt.new_string('blockName'))))
	{
		var_context_mutated.array_set('woocommerce/isDescendantOfAddToCartWithOptions', true)
	}
	return var_context_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) has_form_elements(var_html_content rt.PhpVal) bool {
	mut var_processor :=
		create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_wp_html_tag_processor(var_html_content.clone())
	mut var_form_elements := rt.create_array([rt.ArrayItem{ key: none, val: 'INPUT' },
		rt.ArrayItem{ key: none, val: 'TEXTAREA' }, rt.ArrayItem{ key: none, val: 'SELECT' },
		rt.ArrayItem{ key: none, val: 'BUTTON' }, rt.ArrayItem{ key: none, val: 'FORM' }])
	for rt.is_true(var_processor.next_tag()) {
		if rt.is_true(rt.call_function('in_array', [var_processor.get_tag(),
			var_form_elements.clone(), rt.new_bool(true)]))
		{
			return true
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_product := rt.get_superglobal('product')
	mut var_product_id := if var_block.clone().is_object()
		&& rt.is_true(rt.call_function('property_exists', [var_block.clone(), rt.new_string('context')]))
		&& rt.get_property(var_block, 'context').is_array()
		&& rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')))) {
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))
	} else {
		rt.new_null()
	}
	if !(!var_product_id.is_null()) {
		return ''
	}
	mut var_previous_product := var_product.clone()
	var_product = rt.call_function('wc_get_product', [var_product_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product'))))))
	{
		var_product = var_previous_product.clone()
		return ''
	}
	mut var_product_type :=
		rt.new_string(this.get_product_type_for_add_to_cart_template(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product](var_product)))
	mut iife_temp_2 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_2 := iife_temp_2.get_classes_and_styles_by_attributes(var_attributes.clone(),
		rt.new_array(), rt.create_array([rt.ArrayItem{ key: none, val: 'extra_classes' }]))
	mut var_classes_and_styles := iife_result_2
	mut var_classes := rt.call_function('implode', [rt.new_string(' '),
		rt.call_function('array_filter', [
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: 'wp-block-add-to-cart-with-options wc-block-add-to-cart-with-options'
				},
				rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [
					var_classes_and_styles.array_get(rt.new_string('classes')),
				]) },
			]),
		])])
	mut var_template_part_path :=
		rt.new_string(this.get_template_part_path(var_product_type.clone()))
	if var_template_part_path.clone().is_string()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_template_part_path))))
		&& rt.is_true(rt.call_function('file_exists', [var_template_part_path.clone()])) {
		mut var_slug := rt.new_string(var_product_type.str() + '-product-add-to-cart-with-options')
		mut var_template_part_contents := rt.new_string('')
		mut iife_temp_3 := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
		mut iife_result_3 := iife_temp_3.get_block_templates_from_db(rt.create_array([
			rt.ArrayItem{ key: none, val: var_slug },
		]), rt.new_string('wp_template_part'))
		mut var_templates_from_db := iife_result_3
		if rt.call_function('is_countable', [var_templates_from_db.clone()])
			&& var_templates_from_db.clone().array_count() > 0 {
			mut var_template_slug_to_load := rt.get_property(var_templates_from_db.array_get(rt.new_int(0)),
				'theme')
		} else {
			mut iife_temp_4 := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
			mut iife_result_4 := iife_temp_4.theme_has_template_part(var_slug.clone())
			mut var_theme_has_template_part := iife_result_4
			var_template_slug_to_load = if rt.is_true(var_theme_has_template_part) {
				rt.call_function('get_stylesheet', []rt.PhpVal{})
			} else {
				Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.plugin_slug()
			}
		}
		mut var_template_part := rt.call_function('get_block_template', [
			rt.new_string(var_template_slug_to_load.str() + '//' + var_slug.str()),
			rt.new_string('wp_template_part'),
		])
		if rt.is_true(var_template_part)
			&& !(!rt.is_true(rt.get_property(var_template_part, 'content'))) {
			var_template_part_contents = rt.get_property(var_template_part, 'content')
		}
		if rt.is_true(rt.identical(rt.new_string(''), var_template_part_contents)) {
			var_template_part_contents = rt.call_function('file_get_contents', [
				var_template_part_path.clone(),
			])
		}
		mut var_default_quantity := rt.call_method(var_product, 'get_min_purchase_quantity',
			[]rt.PhpVal{})
		var_product_id = rt.call_method(var_product, 'get_id', []rt.PhpVal{})
		closure_6_fn := fn [var_product_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := rt.call_function('wc_get_product', [
				var_product_id.clone()])
			if rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product')))
				&& rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.grouped()]))
				|| rt.is_true(rt.call_method(var_product, 'has_options', []rt.PhpVal{})) {
				return false
			}
			return true
		}
		rt.call_function('wp_interactivity_state', [
			rt.new_string('woocommerce/add-to-cart-with-options'),
			rt.create_array([
				rt.ArrayItem{ key: 'isFormValid', val: rt.new_closure(closure_6_fn) },
			]),
		])
		rt.call_function('wp_interactivity_config', [
			rt.new_string('woocommerce/add-to-cart-with-options'),
			rt.create_array([
				rt.ArrayItem{ key: 'errorMessages', val: rt.create_array([
					rt.ArrayItem{ key: 'invalidQuantities', val: rt.call_function('esc_html__', [
						rt.new_string('Please select a valid quantity to add to the cart.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'groupedProductAddToCartMissingItems', val: rt.call_function('esc_html__', [
						rt.new_string('Please select some products to add to the cart.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'variableProductMissingAttributes', val: rt.call_function('esc_html__', [
						rt.new_string('Please select product attributes before adding to cart.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'variableProductOutOfStock', val: rt.call_function('sprintf', [
						rt.call_function('esc_html__', [
							rt.new_string('You cannot add &quot;%s&quot; to the cart because the product is out of stock.'),
							rt.new_string('woocommerce'),
						]),
						rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
					]) },
				]) },
			]),
		])
		rt.call_function('wc_interactivity_api_load_product', [
			rt.new_string('I acknowledge that using experimental APIs means my theme or plugin will inevitably break in the next version of WooCommerce'),
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		])
		mut var_context := rt.create_array([
			rt.ArrayItem{ key: 'quantity', val: rt.create_array([
				rt.ArrayItem{
					key: rt.call_method(var_product, 'get_id', []rt.PhpVal{})
					val: var_default_quantity
				},
			]) },
			rt.ArrayItem{ key: 'validationErrors', val: rt.new_array() },
		])
		if rt.is_true(rt.call_method(var_product, 'is_type', [
			Class_Automattic_WooCommerce_Enums_ProductType.variable(),
		]))
		{
			var_context.array_set('selectedAttributes', rt.new_array())
			mut var_variations := rt.call_function('wc_interactivity_api_load_variations', [
				rt.new_string('I acknowledge that using experimental APIs means my theme or plugin will inevitably break in the next version of WooCommerce'),
				rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
			])
			mut iter_2 := rt.func_array_keys(var_variations.clone()).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_variation_id := item_2.val
				var_context.array_get_mut('quantity').array_set(var_variation_id,
					var_default_quantity.clone())
			}
		} else if rt.is_true(rt.call_method(var_product, 'is_type', [
			Class_Automattic_WooCommerce_Enums_ProductType.variation(),
		]))
		{
			mut var_variation_attributes := rt.call_method(var_product, 'get_variation_attributes',
				[]rt.PhpVal{})
			closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				mut var_value := if args.len > 1 { args[1].clone() } else { rt.new_null() }
				return (rt.create_array([rt.ArrayItem{ key: 'attribute', val: var_key },
					rt.ArrayItem{ key: 'value', val: var_value }])).str()
			}
			closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				mut var_value := if args.len > 1 { args[1].clone() } else { rt.new_null() }
				return (rt.create_array([rt.ArrayItem{ key: 'attribute', val: var_key },
					rt.ArrayItem{ key: 'value', val: var_value }])).str()
			}
			mut var_formatted_attributes := rt.call_function('array_map', [
				rt.new_closure(closure_7_fn),
				rt.func_array_keys(var_variation_attributes.clone()),
				var_variation_attributes.clone(),
			])
			var_context.array_set('selectedAttributes', var_formatted_attributes.clone())
		} else if rt.is_true(rt.call_method(var_product, 'is_type', [
			Class_Automattic_WooCommerce_Enums_ProductType.grouped(),
		]))
		{
			mut var_child_products := rt.call_function('wc_interactivity_api_load_purchasable_child_products', [
				rt.new_string('I acknowledge that using experimental APIs means my theme or plugin will inevitably break in the next version of WooCommerce'),
				rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
			])
			var_context.array_set('groupedProductIds',
				rt.func_array_keys(var_child_products.clone()))
			var_context.array_set('quantity', rt.call_function('array_fill_keys', [
				var_context.array_get(rt.new_string('groupedProductIds')),
				rt.new_int(0),
			]))
			mut iter_3 := var_child_products.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_child_product_data := item_3.val
				mut var_child_product_id := item_3.key
				mut var_default_child_quantity := if rt.get_superglobal('_POST').array_get(rt.new_string('quantity')).array_isset(var_child_product_id) { rt.call_function('wc_stock_amount', [
						rt.call_function('wc_clean', [
							rt.call_function('wp_unslash', [
								rt.get_superglobal('_POST').array_get(rt.new_string('quantity')).array_get(var_child_product_id),
							]),
						]),
					]) } else { rt.new_int(0) }
				var_context.array_get_mut('quantity').array_set(var_child_product_id,
					var_default_child_quantity.clone())
				if rt.is_true(var_child_product_data.array_get(rt.new_string('sold_individually'))) {
					var_context.array_get_mut('quantity').array_set(var_child_product_id, 0)
				}
			}
		}
		mut var_hooks_before := rt.new_string('')
		mut var_hooks_after := rt.new_string('')
		mut var_is_disabled_compatibility_layer := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_disable_compatibility_layer'),
			rt.new_bool(false),
		])
		mut iife_temp_8 :=
			Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		mut iife_result_8 := iife_temp_8.is_not_purchasable_product(var_product.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_disabled_compatibility_layer))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_8)))) {
			rt.call_function('ob_start', []rt.PhpVal{})
			rt.call_function('do_action', [
				rt.new_string('woocommerce_before_add_to_cart_form'),
			])
			if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.simple(),
				var_product_type))
			{
				rt.call_function('do_action', [
					rt.new_string('woocommerce_before_add_to_cart_quantity'),
				])
				rt.call_function('do_action', [
					rt.new_string('woocommerce_before_add_to_cart_button'),
				])
			} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.external(),
				var_product_type))
			{
				rt.call_function('do_action', [
					rt.new_string('woocommerce_before_add_to_cart_button'),
				])
			} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.grouped(),
				var_product_type))
			{
				rt.call_function('do_action', [
					rt.new_string('woocommerce_before_add_to_cart_button'),
				])
			} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variable(),
				var_product_type))
			{
				rt.call_function('do_action', [
					rt.new_string('woocommerce_before_variations_form'),
				])
				rt.call_function('do_action', [
					rt.new_string('woocommerce_after_variations_table'),
				])
				rt.call_function('do_action', [
					rt.new_string('woocommerce_before_single_variation'),
				])
				rt.call_function('remove_action', [
					rt.new_string('woocommerce_single_variation'),
					rt.new_string('woocommerce_single_variation'),
					rt.new_int(10),
				])
				rt.call_function('remove_action', [
					rt.new_string('woocommerce_single_variation'),
					rt.new_string('woocommerce_single_variation_add_to_cart_button'),
					rt.new_int(20),
				])
				rt.call_function('do_action', [
					rt.new_string('woocommerce_single_variation'),
				])
				if rt.is_true(rt.call_function('function_exists', [
					rt.new_string('woocommerce_single_variation'),
				]))
				{
					rt.call_function('add_action', [
						rt.new_string('woocommerce_single_variation'),
						rt.new_string('woocommerce_single_variation'),
						rt.new_int(10),
					])
				}
				if rt.is_true(rt.call_function('function_exists', [
					rt.new_string('woocommerce_single_variation_add_to_cart_button'),
				]))
				{
					rt.call_function('add_action', [
						rt.new_string('woocommerce_single_variation'),
						rt.new_string('woocommerce_single_variation_add_to_cart_button'),
						rt.new_int(20),
					])
				}
				rt.call_function('do_action', [
					rt.new_string('woocommerce_before_add_to_cart_button'),
				])
				rt.call_function('do_action', [
					rt.new_string('woocommerce_before_add_to_cart_quantity'),
				])
			}
			var_hooks_before = rt.call_function('ob_get_clean', []rt.PhpVal{})
			rt.call_function('ob_start', []rt.PhpVal{})
			if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.simple(),
				var_product_type))
			{
				rt.call_function('do_action', [
					rt.new_string('woocommerce_after_add_to_cart_quantity'),
				])
				rt.call_function('do_action', [
					rt.new_string('woocommerce_after_add_to_cart_button'),
				])
			} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.external(),
				var_product_type))
			{
				rt.call_function('do_action', [
					rt.new_string('woocommerce_after_add_to_cart_button'),
				])
			} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.grouped(),
				var_product_type))
			{
				rt.call_function('do_action', [
					rt.new_string('woocommerce_after_add_to_cart_button'),
				])
			} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variable(),
				var_product_type))
			{
				rt.call_function('do_action', [
					rt.new_string('woocommerce_after_add_to_cart_quantity'),
				])
				rt.call_function('do_action', [
					rt.new_string('woocommerce_after_add_to_cart_button'),
				])
				rt.call_function('do_action', [
					rt.new_string('woocommerce_after_single_variation'),
				])
				rt.call_function('do_action', [
					rt.new_string('woocommerce_after_variations_form'),
				])
			}
			rt.call_function('do_action', [
				rt.new_string('woocommerce_after_add_to_cart_form'),
			])
			var_hooks_after = rt.call_function('ob_get_clean', []rt.PhpVal{})
		}
		rt.call_function('add_filter', [rt.new_string('render_block_context'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions', [
					'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
				], &this) },
				rt.ArrayItem{
					key: none
					val: 'set_is_descendant_of_add_to_cart_with_options_context'
				},
			]),
			rt.new_int(10), rt.new_int(2)])
		mut var_template_part_blocks := rt.call_function('do_blocks', [
			var_template_part_contents.clone()])
		rt.call_function('remove_filter', [rt.new_string('render_block_context'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions', [
					'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
				], &this) },
				rt.ArrayItem{
					key: none
					val: 'set_is_descendant_of_add_to_cart_with_options_context'
				},
			])])
		mut var_wrapper_attributes := rt.create_array([
			rt.ArrayItem{ key: 'class', val: var_classes },
			rt.ArrayItem{ key: 'style', val: rt.call_function('esc_attr', [
				var_classes_and_styles.array_get(rt.new_string('styles')),
			]) },
			rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/add-to-cart-with-options' },
			rt.ArrayItem{ key: 'data-wp-class--is-invalid', val: '!state.isFormValid' },
		])
		mut var_context_directive := rt.call_function('wp_interactivity_data_wp_context', [
			var_context.clone(),
		])
		mut var_cart_redirect_after_add := rt.call_function('get_option', [
			rt.new_string('woocommerce_cart_redirect_after_add'),
		])
		mut var_form_attributes := rt.new_string('')
		mut var_legacy_mode := rt.new_bool(
			rt.is_true(rt.identical(rt.new_string('yes'), var_cart_redirect_after_add))
			|| this.has_form_elements(var_hooks_before.clone())
			|| this.has_form_elements(var_hooks_after.clone()))
		if rt.is_true(var_legacy_mode) {
			mut var_action_url := rt.call_function('home_url', [
				rt.call_function('add_query_arg', [rt.new_null(),
					rt.new_null()]),
			])
			var_form_attributes = rt.create_array([
				rt.ArrayItem{ key: 'action', val: rt.call_function('esc_url', [
					rt.call_function('apply_filters', [
						rt.new_string('woocommerce_add_to_cart_form_action'),
						var_action_url.clone(),
					]),
				]) },
				rt.ArrayItem{ key: 'method', val: 'post' },
				rt.ArrayItem{ key: 'enctype', val: 'multipart/form-data' },
				rt.ArrayItem{ key: 'class', val: 'cart' },
			])
		} else {
			var_form_attributes = rt.create_array([
				rt.ArrayItem{ key: 'data-wp-on--submit', val: 'actions.addToCart' },
			])
		}
		mut var_hidden_input := rt.new_string('')
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.simple(),
			var_product_type))
		{
			var_hidden_input = rt.new_string('<input type="hidden" name="add-to-cart" value="' +
				(rt.call_function('esc_attr', [var_product_id.clone()])).str() + '" />')
		} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.grouped(),
			var_product_type))
		{
			var_hidden_input = rt.new_string('<input type="hidden" name="add-to-cart" value="' +
				(rt.call_function('esc_attr', [var_product_id.clone()])).str() + '" />')
		} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variable(),
			var_product_type))
		{
			var_hidden_input = rt.new_string(
				'<div class="single_variation_wrap">\n\t\t\t\t\t<input type="hidden" name="add-to-cart" value="' +
				(rt.call_function('esc_attr', [var_product_id.clone()])).str() +
				'" />\n\t\t\t\t\t<input type="hidden" name="product_id" value="' +
				(rt.call_function('esc_attr', [var_product_id.clone()])).str() +
				'" />\n\t\t\t\t\t<input type="hidden"\n\t\t\t\t\t\tname="variation_id"\n\t\t\t\t\t\tdata-wp-bind--value="woocommerce/products::state.productVariationInContext.id"\n\t\t\t\t\t/>\n\t\t\t\t</div>')
		}
		mut var_form_html := rt.call_function('sprintf', [
			rt.new_string('<form %1$s %2$s>%3$s%4$s%5$s%6$s</form>'),
			rt.call_function('get_block_wrapper_attributes', [
				rt.call_function('array_merge', [var_wrapper_attributes.clone(),
					var_form_attributes.clone(),
					rt.create_array([
						rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
							rt.new_string(' '),
							rt.call_function('array_filter', [
								rt.create_array([
									rt.ArrayItem{
										key: none
										val: if var_wrapper_attributes.array_isset(rt.new_string('class')) {
											var_wrapper_attributes.array_get(rt.new_string('class'))
										} else {
											rt.new_string('')
										}
									},
									rt.ArrayItem{
										key: none
										val: if var_form_attributes.array_isset(rt.new_string('class')) {
											var_form_attributes.array_get(rt.new_string('class'))
										} else {
											rt.new_string('')
										}
									},
									rt.ArrayItem{ key: none, val: 'is-layout-flow' },
								]),
							]),
						]) },
					])]),
			]),
			var_context_directive.clone(),
			var_hooks_before.clone(),
			var_template_part_blocks.clone(),
			var_hooks_after.clone(),
			var_hidden_input.clone(),
		])
		rt.call_function('ob_start', []rt.PhpVal{})
		if rt.is_true(rt.call_function('in_array', [var_product_type.clone(),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_ProductType.simple()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_ProductType.external()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_ProductType.variable()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_ProductType.grouped()
				},
			]),
			rt.new_bool(true)]))
		{
			mut var_add_to_cart_fn := rt.new_string('woocommerce_' + var_product_type.str() +
				'_add_to_cart')
			rt.call_function('remove_action', [
				rt.new_string('woocommerce_' + var_product_type.str() + '_add_to_cart'),
				var_add_to_cart_fn.clone(),
				rt.new_int(30),
			])
			rt.call_function('do_action', [
				rt.new_string('woocommerce_' + var_product_type.str() + '_add_to_cart'),
			])
			rt.call_function('add_action', [
				rt.new_string('woocommerce_' + var_product_type.str() + '_add_to_cart'),
				var_add_to_cart_fn.clone(),
				rt.new_int(30),
			])
		}
		var_form_html = rt.new_string(var_form_html.str() +
			(rt.call_function('ob_get_clean', []rt.PhpVal{})).str())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_legacy_mode)))) {
			var_form_html = this.render_interactivity_notices_region(var_form_html.clone())
		}
	} else {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('do_action', [
			rt.new_string('woocommerce_' + var_product_type.str() + '_add_to_cart'),
		])
		var_wrapper_attributes = rt.create_array([
			rt.ArrayItem{ key: 'class', val: var_classes },
			rt.ArrayItem{ key: 'style', val: rt.call_function('esc_attr', [
				var_classes_and_styles.array_get(rt.new_string('styles')),
			]) },
		])
		var_form_html = rt.call_function('ob_get_clean', []rt.PhpVal{})
		mut iife_temp_9 :=
			Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		mut iife_result_9 := iife_temp_9.has_visible_quantity_input(var_form_html.clone())
		mut var_has_visible_quantity_input := if rt.is_true(var_form_html) {
			iife_result_9
		} else {
			rt.new_bool(false)
		}
		if rt.is_true(var_has_visible_quantity_input) {
			mut var_product_name := rt.call_method(var_product, 'get_name', []rt.PhpVal{})
			mut iife_temp_10 :=
				Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
			mut iife_result_10 := iife_temp_10.add_quantity_steppers(var_form_html.clone(),
				var_product_name.clone())
			var_form_html = iife_result_10
			mut iife_temp_11 :=
				Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
			mut iife_result_11 := iife_temp_11.add_quantity_stepper_classes(var_form_html.clone())
			var_form_html = iife_result_11
			var_wrapper_attributes.array_set('data-wp-interactive', 'woocommerce/add-to-cart-form')
			rt.call_function('wp_enqueue_script_module', [
				rt.new_string('woocommerce/add-to-cart-form'),
			])
		}
		var_form_html = rt.call_function('sprintf', [
			rt.new_string('<div %1$s>%2$s</div>'),
			rt.call_function('get_block_wrapper_attributes', [
				var_wrapper_attributes.clone()]),
			var_form_html.clone(),
		])
	}
	var_product = var_previous_product.clone()
	return var_form_html.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) render_interactivity_notices_region(var_form_html rt.PhpVal) rt.PhpVal {
	mut var_form_html_mutated := var_form_html
	mut var_context_directive := rt.call_function('wp_interactivity_data_wp_context', [
		rt.create_array([rt.ArrayItem{ key: 'notices', val: rt.new_array() }]),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_context_directive)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Dismiss this notice'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_form_html_mutated)
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_addtocartwithoptions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('add-to-cart-with-options')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blocktemplateutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_wp_html_tag_processor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_template_part_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_template_part_path(dispatch_arg_0))
		}
		'get_product_type_for_add_to_cart_template' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_product_type_for_add_to_cart_template(mut dispatch_arg_0))
		}
		'enqueue_assets' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.enqueue_assets(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_template_part_ids' {
			return this.get_template_part_ids()
		}
		'set_is_descendant_of_add_to_cart_with_options_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.set_is_descendant_of_add_to_cart_with_options_context(dispatch_arg_0,
				dispatch_arg_1)
		}
		'has_form_elements' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_form_elements(dispatch_arg_0))
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'render_interactivity_notices_region' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render_interactivity_notices_region(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
