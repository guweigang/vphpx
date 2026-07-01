import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('add-to-cart-with-options')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) get_template_part_path(var_product_type rt.PhpVal) string {
	mut var_product_type_mutated := var_product_type
	if rt.is_true(rt.call_function('in_array', [var_product_type_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.simple() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.external() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.variable() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.grouped() }]), rt.new_bool(true)])) {
		return (fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Package{}; return temp.get_path() }()).str() + 'templates/' + (Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.directory_names().array_get('TEMPLATE_PARTS')).str() + '/' + (var_product_type_mutated).str() + '-product-add-to-cart-with-options.html'
	}
	return (rt.call_function('apply_filters', ['__experimental_woocommerce_' + (var_product_type_mutated).str() + '_add_to_cart_with_options_block_template_part', rt.new_bool(false), var_product_type_mutated.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) get_product_type_for_add_to_cart_template(mut var_product Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product) string {
	mut var_product_mutated := var_product
	return (if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_method(var_product_mutated, 'get_type', []rt.PhpVal{}))) { Class_Automattic_WooCommerce_Enums_ProductType.simple() } else { rt.call_method(var_product_mutated, 'get_type', []rt.PhpVal{}) }).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) enqueue_assets(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal)  {
	mut var_product_id := if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_block.dup().is_object())) && rt.is_true(rt.call_function('property_exists', [var_block.dup(), rt.new_string('context')])))) && rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').is_array())))) && rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')))))) { rt.get_property(var_block, 'context').array_get('postId') } else { rt.new_null() }
	if !(var_product_id).is_null() {
		mut var_rendered_product := rt.call_function('wc_get_product', [var_product_id.dup()])
		if rt.is_true(rt.new_bool(rt.instance_of(var_rendered_product, 'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product'))) {
			mut var_product_type := rt.new_string(this.get_product_type_for_add_to_cart_template(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product](var_rendered_product)))
			mut var_template_part_path := rt.new_string(this.get_template_part_path(var_product_type.dup()))
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_template_part_path.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.call_function('file_exists', [var_template_part_path.dup()])))) {
				rt.call_function('wp_enqueue_script_module', [rt.new_string('woocommerce/add-to-cart-with-options')])
			}
		}
	}
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_assets(var_attributes.dup(), var_content.dup(), var_block.dup())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_array)  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_array', []string{}, var_attributes))
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('productTypes'), rt.call_function('wc_get_product_types', []rt.PhpVal{})])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('addToCartWithOptionsTemplatePartIds'), this.get_template_part_ids()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) get_template_part_ids() rt.PhpVal {
	mut var_product_types := rt.func_array_keys(rt.call_function('wc_get_product_types', []rt.PhpVal{}))
	mut var_current_theme := rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}), 'get_stylesheet', []rt.PhpVal{})
	mut var_template_part_ids := rt.new_array()
	{
		mut iter_1 := var_product_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_product_type := item_1.val
			mut var_slug := rt.new_string((var_product_type).str() + '-product-add-to-cart-with-options')
			mut var_theme_has_template := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.theme_has_template_part(arg_0) }(var_slug.dup())
			if rt.is_true(var_theme_has_template) {
				var_template_part_ids.array_set(var_product_type, "${var_current_theme.to_string()}//${var_slug.to_string()}")
			} else {
				var_template_part_ids.array_set(var_product_type, "woocommerce/woocommerce//${var_slug.to_string()}")
			}
		}
	}
	return var_template_part_ids.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) set_is_descendant_of_add_to_cart_with_options_context(var_context rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	if rt.is_true(rt.identical(rt.new_string('woocommerce/product-button'), var_block.array_get('blockName'))) {
		var_context_mutated.array_set('woocommerce/isDescendantOfAddToCartWithOptions', true)
	}
	return var_context_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) has_form_elements(var_html_content rt.PhpVal) bool {
	mut var_processor := create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_wp_html_tag_processor(var_html_content.dup())
	mut var_form_elements := rt.create_array([rt.ArrayItem{ key: none, val: 'INPUT' }, rt.ArrayItem{ key: none, val: 'TEXTAREA' }, rt.ArrayItem{ key: none, val: 'SELECT' }, rt.ArrayItem{ key: none, val: 'BUTTON' }, rt.ArrayItem{ key: none, val: 'FORM' }])
	for rt.is_true(var_processor.next_tag()) {
		if rt.is_true(rt.call_function('in_array', [var_processor.get_tag(), var_form_elements.dup(), rt.new_bool(true)])) {
			return true
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	// unsupported statement: Stmt_Global
	mut var_product_id := if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_block.dup().is_object())) && rt.is_true(rt.call_function('property_exists', [var_block.dup(), rt.new_string('context')])))) && rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').is_array())))) && rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')))))) { rt.get_property(var_block, 'context').array_get('postId') } else { rt.new_null() }
	if !(!(var_product_id).is_null()) {
		return ''
	}
	mut var_previous_product := var_product.dup()
	mut var_product := rt.call_function('wc_get_product', [var_product_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product')))))) {
		var_product = var_previous_product.dup()
		return ''
	}
	mut var_product_type := rt.new_string(this.get_product_type_for_add_to_cart_template(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product](var_product)))
	mut var_classes_and_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}; return temp.get_classes_and_styles_by_attributes(arg_0, arg_1, arg_2) }(var_attributes.dup(), rt.new_array(), rt.create_array([rt.ArrayItem{ key: none, val: 'extra_classes' }]))
	mut var_classes := rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: 'wp-block-add-to-cart-with-options wc-block-add-to-cart-with-options' }, rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [var_classes_and_styles.array_get('classes')]) }])])])
	mut var_template_part_path := rt.new_string(this.get_template_part_path(var_product_type.dup()))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_template_part_path.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.call_function('file_exists', [var_template_part_path.dup()])))) {
		mut var_slug := rt.new_string((var_product_type).str() + '-product-add-to-cart-with-options')
		mut var_template_part_contents := rt.new_string(rt.new_string(''))
		mut var_templates_from_db := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.get_block_templates_from_db(arg_0, arg_1) }(rt.create_array([rt.ArrayItem{ key: none, val: var_slug }]), rt.new_string('wp_template_part'))
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_countable', [var_templates_from_db.dup()])) && var_templates_from_db.dup().array_count() > 0)) {
			mut var_template_slug_to_load := rt.get_property(var_templates_from_db.array_get(0), 'theme')
		} else {
			mut var_theme_has_template_part := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.theme_has_template_part(arg_0) }(var_slug.dup())
			var_template_slug_to_load = if rt.is_true(var_theme_has_template_part) { rt.call_function('get_stylesheet', []rt.PhpVal{}) } else { Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.plugin_slug() }
		}
		mut var_template_part := rt.call_function('get_block_template', [(var_template_slug_to_load).str() + '//' + (var_slug).str(), rt.new_string('wp_template_part')])
		if rt.is_true(rt.new_bool(rt.is_true(var_template_part) && !(!rt.is_true(rt.get_property(var_template_part, 'content'))))) {
			var_template_part_contents = rt.get_property(var_template_part, 'content')
		}
		if rt.is_true(rt.identical(rt.new_string(''), var_template_part_contents)) {
			var_template_part_contents = rt.call_function('file_get_contents', [var_template_part_path.dup()])
			// unsupported statement: Stmt_Nop
		}
		mut var_default_quantity := rt.call_method(var_product, 'get_min_purchase_quantity', []rt.PhpVal{})
		var_product_id = rt.call_method(var_product, 'get_id', []rt.PhpVal{})
		closure_1_fn := fn [var_product_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_product := rt.call_function('wc_get_product', [var_product_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product'))) && rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.grouped()])) || rt.is_true(rt.call_method(var_product, 'has_options', []rt.PhpVal{})))))) {
		return false
	}
	return true
	}
		rt.call_function('wp_interactivity_state', [rt.new_string('woocommerce/add-to-cart-with-options'), rt.create_array([rt.ArrayItem{ key: 'isFormValid', val: rt.new_closure(closure_1_fn) }])])
		rt.call_function('wp_interactivity_config', [rt.new_string('woocommerce/add-to-cart-with-options'), rt.create_array([rt.ArrayItem{ key: 'errorMessages', val: rt.create_array([rt.ArrayItem{ key: 'invalidQuantities', val: rt.call_function('esc_html__', [rt.new_string('Please select a valid quantity to add to the cart.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'groupedProductAddToCartMissingItems', val: rt.call_function('esc_html__', [rt.new_string('Please select some products to add to the cart.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'variableProductMissingAttributes', val: rt.call_function('esc_html__', [rt.new_string('Please select product attributes before adding to cart.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'variableProductOutOfStock', val: rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('You cannot add &quot;%s&quot; to the cart because the product is out of stock.'), rt.new_string('woocommerce')]), rt.call_method(var_product, 'get_name', []rt.PhpVal{})]) }]) }])])
		rt.call_function('wc_interactivity_api_load_product', [rt.new_string('I acknowledge that using experimental APIs means my theme or plugin will inevitably break in the next version of WooCommerce'), rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
		mut var_context := rt.create_array([rt.ArrayItem{ key: 'quantity', val: rt.create_array([rt.ArrayItem{ key: rt.call_method(var_product, 'get_id', []rt.PhpVal{}), val: var_default_quantity }]) }, rt.ArrayItem{ key: 'validationErrors', val: rt.new_array() }])
		if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) {
			var_context.array_set('selectedAttributes', rt.new_array())
			mut var_variations := rt.call_function('wc_interactivity_api_load_variations', [rt.new_string('I acknowledge that using experimental APIs means my theme or plugin will inevitably break in the next version of WooCommerce'), rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
			{
				mut iter_1 := rt.func_array_keys(var_variations.dup()).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_variation_id := item_1.val
					var_context.array_get_mut('quantity').array_set(var_variation_id, var_default_quantity.dup())
				}
			}
		} else if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) {
			mut var_variation_attributes := rt.call_method(var_product, 'get_variation_attributes', []rt.PhpVal{})
			closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_value := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return (rt.create_array([rt.ArrayItem{ key: 'attribute', val: var_key }, rt.ArrayItem{ key: 'value', val: var_value }])).str()
	}
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_value := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return (rt.create_array([rt.ArrayItem{ key: 'attribute', val: var_key }, rt.ArrayItem{ key: 'value', val: var_value }])).str()
	}
			mut var_formatted_attributes := rt.call_function('array_map', [rt.new_closure(closure_2_fn), rt.func_array_keys(var_variation_attributes.dup()), var_variation_attributes.dup()])
			var_context.array_set('selectedAttributes', var_formatted_attributes.dup())
		} else if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.grouped()])) {
			mut var_child_products := rt.call_function('wc_interactivity_api_load_purchasable_child_products', [rt.new_string('I acknowledge that using experimental APIs means my theme or plugin will inevitably break in the next version of WooCommerce'), rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
			var_context.array_set('groupedProductIds', rt.func_array_keys(var_child_products.dup()))
			var_context.array_set('quantity', rt.call_function('array_fill_keys', [var_context.array_get('groupedProductIds'), rt.new_int(0)]))
			{
				mut iter_1 := var_child_products.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_child_product_data := item_1.val
					mut var_child_product_id := item_1.key
					mut var_default_child_quantity := if rt.get_superglobal('_POST').array_get('quantity').array_isset(var_child_product_id) { rt.call_function('wc_stock_amount', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('quantity').array_get(var_child_product_id)])])]) } else { rt.new_int(0) }
					var_context.array_get_mut('quantity').array_set(var_child_product_id, var_default_child_quantity.dup())
					if rt.is_true(var_child_product_data.array_get('sold_individually')) {
						var_context.array_get_mut('quantity').array_set(var_child_product_id, 0)
					}
				}
			}
		}
		mut var_hooks_before := rt.new_string(rt.new_string(''))
		mut var_hooks_after := rt.new_string(rt.new_string(''))
		mut var_is_disabled_compatibility_layer := rt.call_function('apply_filters', [rt.new_string('woocommerce_disable_compatibility_layer'), rt.new_bool(false)])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_disabled_compatibility_layer)))) && rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}; return temp.is_not_purchasable_product(arg_0) }(var_product.dup()))))))) {
			rt.call_function('ob_start', []rt.PhpVal{})
			rt.call_function('do_action', [rt.new_string('woocommerce_before_add_to_cart_form')])
			if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.simple(), var_product_type)) {
				rt.call_function('do_action', [rt.new_string('woocommerce_before_add_to_cart_quantity')])
				rt.call_function('do_action', [rt.new_string('woocommerce_before_add_to_cart_button')])
			} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.external(), var_product_type)) {
				rt.call_function('do_action', [rt.new_string('woocommerce_before_add_to_cart_button')])
			} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.grouped(), var_product_type)) {
				rt.call_function('do_action', [rt.new_string('woocommerce_before_add_to_cart_button')])
			} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variable(), var_product_type)) {
				rt.call_function('do_action', [rt.new_string('woocommerce_before_variations_form')])
				rt.call_function('do_action', [rt.new_string('woocommerce_after_variations_table')])
				rt.call_function('do_action', [rt.new_string('woocommerce_before_single_variation')])
				rt.call_function('remove_action', [, , ])
				
			}
			
		}
		
	} else {
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions) render_interactivity_notices_region(var_form_html rt.PhpVal) rt.PhpVal {
	mut var_form_html_mutated := var_form_html
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

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_addtocartwithoptions() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_AddToCartWithOptions{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('add-to-cart-with-options')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package() &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blocktemplateutils() &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_wp_html_tag_processor() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils() &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_utils() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_template_part_ids' {
			return this.get_template_part_ids()
		}
		'set_is_descendant_of_add_to_cart_with_options_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.set_is_descendant_of_add_to_cart_with_options_context(dispatch_arg_0, dispatch_arg_1)
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
		else { return none }
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
		'block_name' { this.block_name = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_addtocartwithoptions_addtocartwithoptions_php() {
	// unsupported statement: Stmt_Declare
}
