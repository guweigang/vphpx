import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttributeOptions {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('add-to-cart-with-options-variation-selector-attribute-options')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttributeOptions) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_content_mutated := var_content
	if !(
		rt.get_property(var_block, 'context').array_isset(rt.new_string('woocommerce/attributeName'))
		&& rt.get_property(var_block, 'context').array_isset(rt.new_string('woocommerce/attributeId'))
		&& rt.get_property(var_block, 'context').array_isset(rt.new_string('woocommerce/attributeTerms'))) {
		return ''
	}
	mut var_attribute_slug := rt.call_function('wc_variation_attribute_name', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('woocommerce/attributeName')),
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_0 := iife_temp_0.get_classes_and_styles_by_attributes(var_attributes.clone(),
		rt.new_array(), rt.create_array([rt.ArrayItem{ key: none, val: 'extra_classes' }]))
	mut var_classes_and_styles := iife_result_0
	mut var_option_style := if rt.is_true(rt.new_bool(var_attributes.clone().array_isset(rt.new_string('optionStyle')))) {
		var_attributes.array_get(rt.new_string('optionStyle'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_option_style))))
		&& rt.is_true(rt.new_bool(var_attributes.clone().array_isset(rt.new_string('style'))))
		&& rt.is_true(rt.identical(rt.new_string('dropdown'), var_attributes.array_get(rt.new_string('style')))) {
		var_option_style = rt.new_string('dropdown')
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{
				key: 'class'
				val: var_classes_and_styles.array_get(rt.new_string('classes'))
			},
			rt.ArrayItem{
				key: 'style'
				val: var_classes_and_styles.array_get(rt.new_string('styles'))
			},
		]),
	])
	if rt.is_true(rt.identical(rt.new_string('dropdown'), var_option_style)) {
		var_content_mutated = this.render_dropdown(var_attributes.clone(),
			var_content_mutated.clone(), var_block.clone())
	} else {
		var_content_mutated = this.render_pills(var_attributes.clone(),
			var_content_mutated.clone(), var_block.clone())
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %s>%s</div>'),
		var_wrapper_attributes.clone(), var_content_mutated.clone()])).str()
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttributeOptions.get_normalized_attributes(var_attributes rt.PhpVal, var_default_attributes rt.PhpVal) rt.PhpVal {
	mut var_normalized_attributes := rt.new_array()
	mut var_merged_attributes := rt.call_function('array_merge', [
		var_default_attributes.clone(), var_attributes.clone()])
	mut iter_1 := var_merged_attributes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		if rt.is_true(rt.new_bool(var_value.clone().is_null())) {
			continue
		}
		if var_value.clone().is_array() || var_value.clone().is_object() {
			var_value = rt.call_function('wp_json_encode', [var_value.clone(),
				rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')),
					rt.get_constant('JSON_HEX_AMP'))])
		}
		var_normalized_attributes.array_push(rt.call_function('sprintf', [
			rt.new_string('%s="%s"'),
			rt.call_function('esc_attr', [var_key.clone()]),
			rt.call_function('esc_attr', [var_value.clone()]),
		]))
	}
	return rt.call_function('implode', [rt.new_string(' '), var_normalized_attributes.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttributeOptions) get_default_selected_attribute(var_attribute_slug rt.PhpVal, var_attribute_terms rt.PhpVal) rt.PhpVal {
	mut var_attribute_slug_mutated := var_attribute_slug
	mut var_attribute_terms_mutated := var_attribute_terms
	if rt.get_superglobal('_GET').array_isset(var_attribute_slug_mutated) {
		mut var_raw := rt.call_function('wp_unslash', [
			rt.get_superglobal('_GET').array_get(var_attribute_slug_mutated),
		])
		if rt.is_true(rt.new_bool(var_raw.clone().is_string())) {
			mut var_attribute_slug_from_request := rt.call_function('sanitize_title', [
				var_raw.clone(),
			])
			mut iter_2 := var_attribute_terms_mutated.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_attribute_term := item_2.val
				if rt.is_true(rt.identical(rt.call_function('sanitize_title', [
					var_attribute_term.array_get(rt.new_string('value')),
				]), var_attribute_slug_from_request))
				{
					return var_attribute_term.array_get(rt.new_string('value'))
				}
			}
		}
	} else {
		mut iter_3 := var_attribute_terms_mutated.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_attribute_term := item_3.val
			if rt.is_true(var_attribute_term.array_get(rt.new_string('isSelected'))) {
				return var_attribute_term.array_get(rt.new_string('value'))
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttributeOptions) render_pills(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	mut var_attribute_id :=
		rt.get_property(var_block, 'context').array_get(rt.new_string('woocommerce/attributeId'))
	mut var_attribute_slug := rt.call_function('wc_variation_attribute_name', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('woocommerce/attributeName')),
	])
	mut var_attribute_terms :=
		rt.get_property(var_block, 'context').array_get(rt.new_string('woocommerce/attributeTerms'))
	mut var_autoselect := if !(var_attributes.array_get(rt.new_string('autoselect'))).is_null() {
		var_attributes.array_get(rt.new_string('autoselect'))
	} else {
		rt.new_bool(false)
	}
	mut var_disabled_attributes_action := if !(var_attributes.array_get(rt.new_string('disabledAttributesAction'))).is_null() {
		var_attributes.array_get(rt.new_string('disabledAttributesAction'))
	} else {
		rt.new_string('disable')
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := rt.call_function('wp_interactivity_get_context', []rt.PhpVal{})
		return rt.identical(var_context.array_get(rt.new_string('option')).array_get(rt.new_string('value')),
			var_context.array_get(rt.new_string('selectedValue')))
	}
	rt.call_function('wp_interactivity_state', [
		rt.new_string('woocommerce/add-to-cart-with-options'),
		rt.create_array([
			rt.ArrayItem{ key: 'isOptionSelected', val: rt.new_closure(closure_2_fn) },
		]),
	])
	mut var_pills := rt.new_string('')
	mut iter_4 := var_attribute_terms.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_attribute_term := item_4.val
		mut var_input := rt.call_function('sprintf', [
			rt.new_string('<input type="radio" %s/>'),
			this.get_normalized_attributes(rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: 'wc-block-add-to-cart-with-options-variation-selector-attribute-options__pill-input'
				},
				rt.ArrayItem{ key: 'name', val: var_attribute_slug },
				rt.ArrayItem{
					key: 'value'
					val: var_attribute_term.array_get(rt.new_string('value'))
				},
				rt.ArrayItem{ key: 'data-wp-bind--checked', val: 'state.isOptionSelected' },
				rt.ArrayItem{ key: 'data-wp-bind--disabled', val: 'state.isOptionDisabled' },
				rt.ArrayItem{
					key: 'data-wp-bind--hidden'
					val: if rt.is_true(rt.identical(rt.new_string('hide'),
						var_disabled_attributes_action))
					{
						rt.new_string('state.isOptionDisabled')
					} else {
						rt.new_null()
					}
				},
				rt.ArrayItem{ key: 'data-wp-on--click', val: 'actions.handlePillClick' },
				rt.ArrayItem{ key: 'data-wp-on--keydown', val: 'actions.handleKeyDown' },
				rt.ArrayItem{ key: 'data-wp-context', val: rt.create_array([
					rt.ArrayItem{ key: 'option', val: var_attribute_term },
				]) },
			]), rt.new_null()),
		])
		var_pills = rt.concat(var_pills, rt.new_string(
			'<label class="wc-block-add-to-cart-with-options-variation-selector-attribute-options__pill">' +
			var_input.str() +
			(rt.call_function('esc_html', [var_attribute_term.array_get(rt.new_string('label'))])).str() +
			'</label>'))
	}
	return rt.call_function('sprintf', [rt.new_string('<div %s>%s</div>'),
		this.get_normalized_attributes(rt.create_array([
			rt.ArrayItem{
				key: 'class'
				val: 'wc-block-add-to-cart-with-options-variation-selector-attribute-options__pills'
			},
			rt.ArrayItem{ key: 'role', val: 'radiogroup' },
			rt.ArrayItem{ key: 'id', val: var_attribute_id },
			rt.ArrayItem{ key: 'aria-labelledby', val: var_attribute_id.str() + '_label' },
			rt.ArrayItem{ key: 'data-wp-context', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.call_function('wc_attribute_label', [
					rt.get_property(var_block, 'context').array_get(rt.new_string('woocommerce/attributeName')),
				]) },
				rt.ArrayItem{ key: 'options', val: var_attribute_terms },
				rt.ArrayItem{ key: 'selectedValue', val: this.get_default_selected_attribute(var_attribute_slug.clone(),
					var_attribute_terms.clone()) },
				rt.ArrayItem{ key: 'focused', val: '' },
				rt.ArrayItem{ key: 'autoselect', val: var_autoselect },
			]) },
			rt.ArrayItem{ key: 'data-wp-init', val: 'callbacks.setDefaultSelectedAttribute' },
		]), rt.new_null()),
		var_pills.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttributeOptions) render_dropdown(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	mut var_attribute_id :=
		rt.get_property(var_block, 'context').array_get(rt.new_string('woocommerce/attributeId'))
	mut var_attribute_slug := rt.call_function('wc_variation_attribute_name', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('woocommerce/attributeName')),
	])
	mut var_attribute_terms :=
		rt.get_property(var_block, 'context').array_get(rt.new_string('woocommerce/attributeTerms'))
	mut var_default_option := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('esc_html__', [
			rt.new_string('Choose an option'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'value', val: '' },
		rt.ArrayItem{ key: 'isSelected', val: false },
	])
	var_attribute_terms = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_default_option }]),
		var_attribute_terms.clone(),
	])
	mut var_selected_attribute := this.get_default_selected_attribute(var_attribute_slug.clone(),
		var_attribute_terms.clone())
	mut var_autoselect := if !(var_attributes.array_get(rt.new_string('autoselect'))).is_null() {
		var_attributes.array_get(rt.new_string('autoselect'))
	} else {
		rt.new_bool(false)
	}
	mut var_disabled_attributes_action := if !(var_attributes.array_get(rt.new_string('disabledAttributesAction'))).is_null() {
		var_attributes.array_get(rt.new_string('disabledAttributesAction'))
	} else {
		rt.new_string('disable')
	}
	mut var_options := rt.new_string('')
	mut iter_5 := var_attribute_terms.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_attribute_term := item_5.val
		mut var_option_attributes := rt.create_array([
			rt.ArrayItem{ key: 'value', val: var_attribute_term.array_get(rt.new_string('value')) },
			rt.ArrayItem{ key: 'data-wp-bind--selected', val: 'state.isOptionSelected' },
			rt.ArrayItem{ key: 'data-wp-bind--disabled', val: 'state.isOptionDisabled' },
			rt.ArrayItem{
				key: 'data-wp-bind--hidden'
				val: if rt.is_true(rt.identical(rt.new_string('hide'),
					var_disabled_attributes_action))
				{
					rt.new_string('state.isOptionDisabled')
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{ key: 'data-wp-context', val: rt.create_array([
				rt.ArrayItem{ key: 'option', val: var_attribute_term },
			]) },
		])
		if rt.is_true(rt.identical(var_attribute_term.array_get(rt.new_string('value')),
			var_selected_attribute))
		{
			var_option_attributes.array_set('selected', 'selected')
		}
		var_options = rt.concat(var_options, rt.call_function('sprintf', [
			rt.new_string('<option %s>%s</option>'),
			this.get_normalized_attributes(var_option_attributes.clone(), rt.new_null()),
			rt.call_function('esc_html', [var_attribute_term.array_get(rt.new_string('label'))]),
		]))
	}
	return rt.call_function('sprintf', [rt.new_string('<select %s>%s</select>'),
		this.get_normalized_attributes(rt.create_array([
			rt.ArrayItem{
				key: 'class'
				val: 'wc-block-add-to-cart-with-options-variation-selector-attribute-options__dropdown'
			},
			rt.ArrayItem{ key: 'id', val: var_attribute_id },
			rt.ArrayItem{ key: 'data-wp-context', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.call_function('wc_attribute_label', [
					rt.get_property(var_block, 'context').array_get(rt.new_string('woocommerce/attributeName')),
				]) },
				rt.ArrayItem{ key: 'options', val: var_attribute_terms },
				rt.ArrayItem{ key: 'selectedValue', val: var_selected_attribute },
				rt.ArrayItem{ key: 'autoselect', val: var_autoselect },
			]) },
			rt.ArrayItem{ key: 'data-wp-init', val: 'callbacks.setDefaultSelectedAttribute' },
			rt.ArrayItem{ key: 'data-wp-on--change', val: 'actions.handleDropdownChange' },
			rt.ArrayItem{ key: 'name', val: var_attribute_slug },
		]), rt.new_null()),
		var_options.clone()])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_variationselectorattributeoptions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttributeOptions {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttributeOptions{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('add-to-cart-with-options-variation-selector-attribute-options')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttributeOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_normalized_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttributeOptions.get_normalized_attributes(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_default_selected_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_default_selected_attribute(dispatch_arg_0, dispatch_arg_1)
		}
		'render_pills' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render_pills(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'render_dropdown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render_dropdown(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttributeOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttributeOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
