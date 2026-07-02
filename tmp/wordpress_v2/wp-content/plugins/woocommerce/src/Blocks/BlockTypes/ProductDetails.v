import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-details')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) initialize() {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	mut var_hooked_blocks := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_details_hooked_blocks'),
		rt.new_array(),
	])
	mut iter_1 := this.validate_hooked_blocks(var_hooked_blocks.clone()).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_block := item_1.val
		mut var_slug := item_1.key
		this.register_hooked_block(var_slug.clone(), var_block.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	if !rt.is_true(rt.get_property(var_block, 'parsed_block').array_get(rt.new_string('innerBlocks'))) {
		return this.render_legacy_block(var_attributes.clone(), var_content.clone(),
			var_block.clone())
	}
	mut var_parsed_block := rt.get_property(var_block, 'parsed_block')
	var_parsed_block = this.hide_empty_accordion_items(var_parsed_block.clone(), rt.get_property(var_block,
		'context'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_disable_compatibility_layer'),
		rt.new_bool(false),
	])))))
	{
		var_parsed_block = this.inject_compatible_tabs(var_parsed_block.clone())
	}
	closure_1_fn := fn [var_block] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_carry := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_parsed_inner_block := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_carry = rt.concat(var_carry, rt.call_method(create_wp_block(var_parsed_inner_block.clone(), rt.get_property(var_block,
			'context')), 'render', []rt.PhpVal{}))
		return var_carry.clone()
	}
	mut var_inner_content := rt.call_function('array_reduce', [
		var_parsed_block.array_get(rt.new_string('innerBlocks')),
		rt.new_closure(closure_1_fn),
		rt.new_string(''),
	])
	return rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{}),
		var_inner_content.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) inject_compatible_tabs(var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_parsed_block_mutated := var_parsed_block
	if !(this.has_accordion(var_parsed_block_mutated.clone())) {
		return var_parsed_block_mutated.clone()
	}
	mut var_product_tabs := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_tabs'),
		rt.new_array(),
	])
	mut var_default_tabs_callbacks := rt.create_array([
		rt.ArrayItem{ key: none, val: 'woocommerce_product_description_tab' },
		rt.ArrayItem{ key: none, val: 'woocommerce_product_additional_information_tab' },
		rt.ArrayItem{ key: none, val: 'comments_template' },
	])
	closure_2_fn := fn [var_default_tabs_callbacks] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_tab := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_tab.array_get(rt.new_string('callback')),
			var_default_tabs_callbacks.clone(),
			rt.new_bool(true),
		]))))
	}
	var_product_tabs = rt.call_function('array_filter', [var_product_tabs.clone(),
		rt.new_closure(closure_2_fn)])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.new_null()
	}
	rt.call_function('usort', [var_product_tabs.clone(), rt.new_closure(closure_3_fn)])
	mut var_accordion_blocks := rt.new_array()
	mut var_accordion_anchor_block :=
		this.get_accordion_anchor_block(var_parsed_block_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_accordion_anchor_block)))) {
		return var_parsed_block_mutated.clone()
	}
	mut iter_2 := var_product_tabs.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_tab := item_2.val
		mut var_key := item_2.key
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('call_user_func', [var_tab.array_get(rt.new_string('callback')),
			var_key.clone(), var_tab.clone()])
		mut var_tab_content := rt.call_function('ob_get_clean', []rt.PhpVal{})
		var_accordion_blocks.array_push(this.create_accordion_item_block(var_tab.array_get(rt.new_string('title')), rt.new_string(
			'<!-- wp:html -->' + var_tab_content.str() + '<!-- /wp:html -->'),
			var_accordion_anchor_block.clone()))
	}
	return this.inject_parsed_accordion_blocks(var_parsed_block_mutated.clone(),
		var_accordion_blocks.clone())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) create_accordion_item_block(var_title rt.PhpVal, var_content rt.PhpVal, var_anchor_block rt.PhpVal) rt.PhpVal {
	mut var_anchor_block_mutated := var_anchor_block
	if var_anchor_block_mutated.array_isset(rt.new_string('blockName'))
		&& rt.is_true(rt.identical(rt.new_string('core/accordion'), var_anchor_block_mutated.array_get(rt.new_string('blockName')))) {
		mut var_template :=
			rt.new_string('<!-- wp:accordion-item -->\n\t\t\t\t<div class="wp-block-accordion-item">\n\t\t\t\t\t<!-- wp:accordion-heading -->\n\t\t\t\t\t<h3 class="wp-block-accordion-heading">\n\t\t\t\t\t\t<button class="wp-block-accordion-heading__toggle">\n\t\t\t\t\t\t\t<span class="wp-block-accordion-heading__toggle-title">%1$s</span>\n\t\t\t\t\t\t\t<span class="wp-block-accordion-heading__toggle-icon" aria-hidden="true">+</span>\n\t\t\t\t\t\t</button>\n\t\t\t\t\t</h3>\n\t\t\t\t\t<!-- /wp:accordion-heading -->\n\n\t\t\t\t\t<!-- wp:accordion-panel -->\n\t\t\t\t\t<div class="wp-block-accordion-panel">\n\t\t\t\t\t\t%2$s\n\t\t\t\t\t</div>\n\t\t\t\t\t<!-- /wp:accordion-panel -->\n\t\t\t\t</div>\n\t\t\t\t<!-- /wp:accordion-item -->')
	} else {
		var_template =
			rt.new_string('<!-- wp:woocommerce/accordion-item -->\n\t\t\t\t<div class="wp-block-woocommerce-accordion-item"><!-- wp:woocommerce/accordion-header -->\n\t\t\t\t<h3 class="wp-block-woocommerce-accordion-header accordion-item__heading">\n\t\t\t\t<button class="accordion-item__toggle">\n\t\t\t\t<span>%1$s</span>\n\t\t\t\t<span class="accordion-item__toggle-icon has-icon-plus" style="width:1.2em;height:1.2em"><svg width="1.2em" height="1.2em" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path d="M11 12.5V17.5H12.5V12.5H17.5V11H12.5V6H11V11H6V12.5H11Z" fill="currentColor"></path></svg></span>\n\t\t\t\t</button>\n\t\t\t\t</h3>\n\t\t\t\t<!-- /wp:woocommerce/accordion-header -->\n\n\t\t\t\t<!-- wp:woocommerce/accordion-panel -->\n\t\t\t\t<div class="wp-block-woocommerce-accordion-panel"><div class="accordion-content__wrapper">\n\t\t\t\t%2$s\n\t\t\t\t</div></div>\n\t\t\t\t<!-- /wp:woocommerce/accordion-panel --></div>\n\t\t\t\t<!-- /wp:woocommerce/accordion-item -->')
	}
	return rt.call_function('parse_blocks', [
		rt.call_function('sprintf', [var_template.clone(), var_title.clone(),
			var_content.clone()]),
	]).array_get(rt.new_int(0))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) inject_parsed_accordion_blocks(var_parsed_block rt.PhpVal, var_accordion_blocks rt.PhpVal) rt.PhpVal {
	mut var_parsed_block_mutated := var_parsed_block
	mut var_accordion_blocks_mutated := var_accordion_blocks
	if rt.is_true(rt.identical(rt.new_string('core/accordion'), var_parsed_block_mutated.array_get(rt.new_string('blockName'))))
		|| rt.is_true(rt.identical(rt.new_string('woocommerce/accordion-group'), var_parsed_block_mutated.array_get(rt.new_string('blockName')))) {
		var_parsed_block_mutated.array_set('innerBlocks', rt.call_function('array_merge', [
			var_parsed_block_mutated.array_get(rt.new_string('innerBlocks')),
			var_accordion_blocks_mutated.clone(),
		]))
		var_parsed_block_mutated.array_set('innerBlocks', rt.call_function('array_values', [
			rt.call_function('array_filter',
				[var_parsed_block_mutated.array_get(rt.new_string('innerBlocks'))]),
		]))
		mut var_opening_tag := rt.call_function('reset', [
			var_parsed_block_mutated.array_get(rt.new_string('innerContent')),
		])
		mut var_closing_tag := rt.call_function('end', [
			var_parsed_block_mutated.array_get(rt.new_string('innerContent')),
		])
		var_parsed_block_mutated.array_set('innerContent', rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_opening_tag }]),
			rt.call_function('array_fill', [rt.new_int(0),
				rt.new_int(var_parsed_block_mutated.array_get(rt.new_string('innerBlocks')).array_count()),
				rt.new_null()]),
			rt.create_array([rt.ArrayItem{ key: none, val: var_closing_tag }]),
		]))
		return var_parsed_block_mutated.clone()
	}
	mut iter_3 := var_parsed_block_mutated.array_get(rt.new_string('innerBlocks')).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_inner_block := item_3.val
		mut var_key := item_3.key
		var_parsed_block_mutated.array_get_mut('innerBlocks').array_set(var_key, this.inject_parsed_accordion_blocks(var_inner_block.clone(),
			var_accordion_blocks_mutated.clone()))
	}
	return var_parsed_block_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) hide_empty_accordion_items(var_parsed_block rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_parsed_block_mutated := var_parsed_block
	if !(this.has_accordion(var_parsed_block_mutated.clone())) {
		return var_parsed_block_mutated.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('core/accordion'), var_parsed_block_mutated.array_get(rt.new_string('blockName'))))
		|| rt.is_true(rt.identical(rt.new_string('woocommerce/accordion-group'), var_parsed_block_mutated.array_get(rt.new_string('blockName')))) {
		mut iter_4 := var_parsed_block_mutated.array_get(rt.new_string('innerBlocks')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_inner_block := item_4.val
			mut var_key := item_4.key
			var_parsed_block_mutated.array_get_mut('innerBlocks').array_set(var_key, this.mark_accordion_item_hidden(var_inner_block.clone(),
				var_context.clone()))
		}
		var_parsed_block_mutated.array_set('innerBlocks', rt.call_function('array_values', [
			rt.call_function('array_filter',
				[var_parsed_block_mutated.array_get(rt.new_string('innerBlocks'))]),
		]))
		mut var_opening_tag := rt.call_function('reset', [
			var_parsed_block_mutated.array_get(rt.new_string('innerContent')),
		])
		mut var_closing_tag := rt.call_function('end', [
			var_parsed_block_mutated.array_get(rt.new_string('innerContent')),
		])
		var_parsed_block_mutated.array_set('innerContent', rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_opening_tag }]),
			rt.call_function('array_fill', [rt.new_int(0),
				rt.new_int(var_parsed_block_mutated.array_get(rt.new_string('innerBlocks')).array_count()),
				rt.new_null()]),
			rt.create_array([rt.ArrayItem{ key: none, val: var_closing_tag }]),
		]))
		return var_parsed_block_mutated.clone()
	}
	mut iter_5 := var_parsed_block_mutated.array_get(rt.new_string('innerBlocks')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_inner_block := item_5.val
		mut var_key := item_5.key
		var_parsed_block_mutated.array_get_mut('innerBlocks').array_set(var_key, this.hide_empty_accordion_items(var_inner_block.clone(),
			var_context.clone()))
	}
	return var_parsed_block_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) mark_accordion_item_hidden(var_item rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_content_block := rt.call_function('end', [
		var_item.array_get(rt.new_string('innerBlocks')),
	])
	mut var_rendered_content_block := rt.call_method(create_wp_block(var_content_block.clone(),
		var_context.clone()), 'render', []rt.PhpVal{})
	mut var_p := create_wp_html_tag_processor(var_rendered_content_block.clone())
	mut var_has_content := rt.new_bool(rt.is_true(var_p.next_tag(rt.new_string('img')))
		|| rt.is_true(var_p.next_tag(rt.new_string('iframe')))
		|| rt.is_true(var_p.next_tag(rt.new_string('video')))
		|| rt.is_true(var_p.next_tag(rt.new_string('meter')))
		|| !(!rt.is_true(rt.call_function('wp_strip_all_tags', [var_rendered_content_block.clone(), rt.new_bool(true)]))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_content)))) {
		return rt.new_array()
	}
	return var_item.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) has_accordion(var_parsed_block rt.PhpVal) bool {
	mut var_parsed_block_mutated := var_parsed_block
	if rt.is_true(rt.identical(rt.new_string('core/accordion'), var_parsed_block_mutated.array_get(rt.new_string('blockName'))))
		|| rt.is_true(rt.identical(rt.new_string('woocommerce/accordion-group'), var_parsed_block_mutated.array_get(rt.new_string('blockName')))) {
		return true
	}
	mut iter_6 := var_parsed_block_mutated.array_get(rt.new_string('innerBlocks')).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_inner_block := item_6.val
		if this.has_accordion(var_inner_block.clone()) {
			return true
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) get_accordion_anchor_block(var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_parsed_block_mutated := var_parsed_block
	if rt.is_true(rt.identical(rt.new_string('core/accordion'), var_parsed_block_mutated.array_get(rt.new_string('blockName'))))
		|| rt.is_true(rt.identical(rt.new_string('woocommerce/accordion-group'), var_parsed_block_mutated.array_get(rt.new_string('blockName')))) {
		return var_parsed_block_mutated.clone()
	}
	mut iter_7 := var_parsed_block_mutated.array_get(rt.new_string('innerBlocks')).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_inner_block := item_7.val
		mut var_anchor_block := this.get_accordion_anchor_block(var_inner_block.clone())
		if rt.is_true(var_anchor_block) {
			return var_anchor_block.clone()
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) validate_hooked_blocks(var_hooked_blocks rt.PhpVal) rt.PhpVal {
	mut var_hooked_blocks_mutated := var_hooked_blocks
	mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
	mut var_validated_hooked_blocks := rt.new_array()
	mut iter_8 := var_hooked_blocks_mutated.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_block := item_8.val
		mut var_invalid := rt.new_bool(!(var_block.clone().is_array())
			|| !(var_block.array_isset(rt.new_string('title')))
			|| !(var_block.array_isset(rt.new_string('content')))
			|| !(var_block.array_get(rt.new_string('title')).is_string())
			|| !(var_block.array_get(rt.new_string('content')).is_string()))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_invalid)))) {
			mut var_parsed_content := rt.call_function('parse_blocks', [
				var_block.array_get(rt.new_string('content')),
			])
			mut iter_9 := var_parsed_content.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_content_block := item_9.val
				if !(var_content_block.array_isset(rt.new_string('blockName'))) {
					var_invalid = rt.new_bool(true)
					break
				}
			}
		}
		if rt.is_true(var_invalid) {
			rt.call_method(var_logger, 'error', [
				rt.new_string('Invalid hooked block data. Expected array with `title` and `content` keys with string values. Content must be valid block markup.'),
				var_block.clone(),
			])
			continue
		}
		mut var_slug := rt.call_function('sanitize_title', [
			var_block.array_get(rt.new_string('title')),
		])
		if var_validated_hooked_blocks.array_isset(var_slug) {
			var_validated_hooked_blocks.array_set(var_slug, var_block.clone())
			continue
		}
		var_validated_hooked_blocks.array_set(var_slug, var_block.clone())
	}
	return var_validated_hooked_blocks.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) register_hooked_block(var_slug rt.PhpVal, var_block rt.PhpVal) {
	mut var_slug_mutated := var_slug
	closure_4_fn := fn [var_slug] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_hooked_block_types := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_relative_position := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_anchor_block_type := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		if rt.is_true(rt.identical(rt.new_string('core/accordion'), var_anchor_block_type))
			|| rt.is_true(rt.identical(rt.new_string('woocommerce/accordion-group'), var_anchor_block_type))
			&& rt.is_true(rt.identical(rt.new_string('last_child'), var_relative_position))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_slug_mutated.clone(), var_hooked_block_types.clone(), rt.new_bool(true)]))))) {
			var_hooked_block_types.array_push(var_slug_mutated.clone())
		}
		return
	}
	rt.call_function('add_filter', [rt.new_string('hooked_block_types'),
		rt.new_closure(closure_4_fn), rt.new_int(10), rt.new_int(3)])
	closure_5_fn := fn [var_block] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_parsed_hooked_block := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_hooked_block_type := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_relative_position := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var_parsed_anchor_block := if args.len > 3 { args[3].clone() } else { rt.new_null() }
		if ((var_parsed_hooked_block.clone().is_null()|| (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('core/accordion'), var_parsed_anchor_block.array_get(rt.new_string('blockName'))))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce/accordion-group'), var_parsed_anchor_block.array_get(rt.new_string('blockName'))))))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('last_child'), var_relative_position)))))
			|| !rt.is_true(var_parsed_anchor_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata')).array_get(rt.new_string('isDescendantOfProductDetails'))) {
			return
		}
		return
	}
	rt.call_function('add_filter', [
		rt.new_string('hooked_block_${var_slug.to_string()}'),
		rt.new_closure(closure_5_fn),
		rt.new_int(10),
		rt.new_int(4),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) enqueue_legacy_assets() {
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-single-product')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) render_legacy_block(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', [
		rt.new_string('product'),
	])))))
	{
		return var_content.clone()
	}
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_legacy_assets' },
		]),
		rt.new_int(20)])
	mut var_hide_tab_title := if var_attributes.array_isset(rt.new_string('hideTabTitle')) {
		var_attributes.array_get(rt.new_string('hideTabTitle'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(var_hide_tab_title) {
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_product_description_heading'),
			rt.new_string('__return_empty_string'),
		])
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_product_additional_information_heading'),
			rt.new_string('__return_empty_string'),
		])
		rt.call_function('add_filter', [rt.new_string('woocommerce_reviews_title'),
			rt.new_string('__return_empty_string')])
	}
	mut var_tabs := this.render_tabs()
	if rt.is_true(var_hide_tab_title) {
		rt.call_function('remove_filter', [
			rt.new_string('woocommerce_product_description_heading'),
			rt.new_string('__return_empty_string'),
		])
		rt.call_function('remove_filter', [
			rt.new_string('woocommerce_product_additional_information_heading'),
			rt.new_string('__return_empty_string'),
		])
		rt.call_function('remove_filter', [rt.new_string('woocommerce_reviews_title'),
			rt.new_string('__return_empty_string')])
		mut var_tabs_html := create_wp_html_tag_processor(var_tabs.clone())
		for rt.is_true(var_tabs_html.next_tag(rt.create_array([rt.ArrayItem, {
			key: 'class_name'
			val: 'wc-tab'
		}]))) {
			if rt.is_true(var_tabs_html.next_tag(rt.new_string('h2'))) {
				var_tabs_html.set_attribute(rt.new_string('hidden'), rt.new_string('true'))
			}
		}
		var_tabs = var_tabs_html.get_updated_html()
	}
	mut iife_temp_5 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_5 := iife_temp_5.get_classes_and_styles_by_attributes(var_attributes.clone())
	mut var_classes_and_styles := iife_result_5
	return rt.call_function('sprintf', [
		rt.new_string('<div class="wp-block-woocommerce-product-details %1$s">\n\t\t\t\t<div style="%2$s">\n\t\t\t\t\t%3$s\n\t\t\t\t</div>\n\t\t\t</div>'),
		rt.call_function('esc_attr', [var_classes_and_styles.array_get(rt.new_string('classes'))]),
		rt.call_function('esc_attr', [var_classes_and_styles.array_get(rt.new_string('styles'))]),
		var_tabs.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) render_tabs() rt.PhpVal {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('rewind_posts', []rt.PhpVal{})
	for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
		rt.call_function('the_post', []rt.PhpVal{})
		rt.call_function('woocommerce_output_product_data_tabs', []rt.PhpVal{})
	}
	mut var_tabs := rt.call_function('ob_get_clean', []rt.PhpVal{})
	return var_tabs.clone()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_WP_Block {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productdetails(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-details')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block(_args ...rt.PhpVal) &Class_WP_Block {
	mut obj := &Class_WP_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'inject_compatible_tabs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.inject_compatible_tabs(dispatch_arg_0)
		}
		'create_accordion_item_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.create_accordion_item_block(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'inject_parsed_accordion_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.inject_parsed_accordion_blocks(dispatch_arg_0, dispatch_arg_1)
		}
		'hide_empty_accordion_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.hide_empty_accordion_items(dispatch_arg_0, dispatch_arg_1)
		}
		'mark_accordion_item_hidden' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.mark_accordion_item_hidden(dispatch_arg_0, dispatch_arg_1)
		}
		'has_accordion' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_accordion(dispatch_arg_0))
		}
		'get_accordion_anchor_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_accordion_anchor_block(dispatch_arg_0)
		}
		'validate_hooked_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.validate_hooked_blocks(dispatch_arg_0)
		}
		'register_hooked_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.register_hooked_block(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'enqueue_legacy_assets' {
			this.enqueue_legacy_assets()
			return rt.new_null()
		}
		'render_legacy_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render_legacy_block(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'render_tabs' {
			return this.render_tabs()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDetails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
