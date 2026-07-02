import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttribute {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('add-to-cart-with-options-variation-selector-attribute')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttribute) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_product := rt.new_null()
	mut var_content_mutated := var_content
	var_content_mutated = rt.new_string('')
	mut var_product_attributes := rt.call_method(var_product, 'get_variation_attributes',
		[]rt.PhpVal{})
	mut iter_1 := var_product_attributes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_product_attribute_terms := item_1.val
		mut var_product_attribute_name := item_1.key
		var_content_mutated = rt.concat(var_content_mutated, this.get_product_row(var_product_attribute_name.clone(),
			var_product_attribute_terms.clone(), var_block.clone()))
	}
	return var_content_mutated.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttribute) get_product_row(var_attribute_name rt.PhpVal, var_product_attribute_terms rt.PhpVal, var_block rt.PhpVal) string {
	mut var_product := rt.new_null()
	mut var_attribute_terms := this.get_terms(var_attribute_name.clone(),
		var_product_attribute_terms.clone())
	mut var_product_variations := rt.call_method(var_product, 'get_available_variations', [
		rt.new_string('objects'),
	])
	closure_1_fn := fn [var_product_variations, var_attribute_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_term := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iter_2 := var_product_variations.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_variation := item_2.val
			mut var_attributes := rt.call_method(var_variation, 'get_variation_attributes',
				[]rt.PhpVal{})
			if rt.is_true(rt.identical(var_term.array_get(rt.new_string('value')), var_attributes.array_get(rt.call_function('wc_variation_attribute_name', [var_attribute_name.clone()]))))
				|| rt.is_true(rt.identical(rt.new_string(''), var_attributes.array_get(rt.call_function('wc_variation_attribute_name', [var_attribute_name.clone()])))) {
				return true
			}
		}
		return rt.new_null()
	}
	var_attribute_terms = rt.call_function('array_filter', [var_attribute_terms.clone(),
		rt.new_closure(closure_1_fn)])
	if !rt.is_true(var_attribute_terms) {
		return ''
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
	mut iife_result_1 := iife_temp_1.render_block_with_context(var_block.clone(), rt.create_array([
		rt.ArrayItem{ key: 'woocommerce/attributeId', val: 'wc_product_attribute_' +
			(rt.call_function('uniqid', []rt.PhpVal{})).str() },
		rt.ArrayItem{ key: 'woocommerce/attributeName', val: var_attribute_name },
		rt.ArrayItem{ key: 'woocommerce/attributeTerms', val: var_attribute_terms },
	]))
	mut var_block_content := iife_result_1
	return var_block_content.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttribute) get_terms(var_attribute_name rt.PhpVal, var_attribute_terms rt.PhpVal) rt.PhpVal {
	mut var_product := rt.new_null()
	mut var_attribute_terms_mutated := var_attribute_terms
	mut var_is_taxonomy := rt.call_function('taxonomy_exists', [
		var_attribute_name.clone()])
	mut var_selected_attribute := rt.call_method(var_product, 'get_variation_default_attribute', [
		var_attribute_name.clone(),
	])
	if rt.is_true(var_is_taxonomy) {
		closure_3_fn := fn [var_attribute_name, var_product, var_selected_attribute] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_term := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.create_array([
				rt.ArrayItem{ key: 'value', val: rt.get_property(var_term, 'slug') },
				rt.ArrayItem{ key: 'label', val: rt.call_function('apply_filters', [
					rt.new_string('woocommerce_variation_option_name'),
					rt.get_property(var_term, 'name'),
					var_term.clone(),
					var_attribute_name.clone(),
					var_product.clone(),
				]) },
				rt.ArrayItem{ key: 'isSelected', val: rt.identical(var_selected_attribute, rt.get_property(var_term,
					'slug')) },
			])
		}
		closure_4_fn := fn [var_attribute_name, var_product, var_selected_attribute] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_term := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.create_array([
				rt.ArrayItem{ key: 'value', val: rt.get_property(var_term, 'slug') },
				rt.ArrayItem{ key: 'label', val: rt.call_function('apply_filters', [
					rt.new_string('woocommerce_variation_option_name'),
					rt.get_property(var_term, 'name'),
					var_term.clone(),
					var_attribute_name.clone(),
					var_product.clone(),
				]) },
				rt.ArrayItem{ key: 'isSelected', val: rt.identical(var_selected_attribute, rt.get_property(var_term,
					'slug')) },
			])
		}
		mut var_items := rt.call_function('array_map', [rt.new_closure(closure_3_fn),
			rt.call_function('wc_get_product_terms', [
				rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
				var_attribute_name.clone(),
				rt.create_array([rt.ArrayItem{ key: 'fields', val: 'all' }]),
			])])
	} else {
		closure_5_fn := fn [var_attribute_name, var_product, var_selected_attribute] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_term := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.create_array([rt.ArrayItem{ key: 'value', val: var_term },
				rt.ArrayItem{ key: 'label', val: rt.call_function('apply_filters', [
					rt.new_string('woocommerce_variation_option_name'),
					var_term.clone(),
					rt.new_null(),
					var_attribute_name.clone(),
					var_product.clone(),
				]) }, rt.ArrayItem{ key: 'isSelected', val: rt.identical(var_selected_attribute,
					var_term) }])
		}
		closure_6_fn := fn [var_attribute_name, var_product, var_selected_attribute] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_term := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.create_array([rt.ArrayItem{ key: 'value', val: var_term },
				rt.ArrayItem{ key: 'label', val: rt.call_function('apply_filters', [
					rt.new_string('woocommerce_variation_option_name'),
					var_term.clone(),
					rt.new_null(),
					var_attribute_name.clone(),
					var_product.clone(),
				]) }, rt.ArrayItem{ key: 'isSelected', val: rt.identical(var_selected_attribute,
					var_term) }])
		}
		var_items = rt.call_function('array_map', [rt.new_closure(closure_5_fn),
			var_attribute_terms_mutated.clone()])
	}
	return var_items.clone()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_variationselectorattribute(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttribute {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttribute{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('add-to-cart-with-options-variation-selector-attribute')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_product_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.get_product_row(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'get_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_terms(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelectorAttribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
