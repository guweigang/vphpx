import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary {
	rt.PhpObjectBase
pub mut:
	block_name  rt.PhpVal = rt.new_string('product-summary')
	api_version rt.PhpVal = rt.new_string('3')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary) register_block_type_assets() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'query' },
		rt.ArrayItem{ key: none, val: 'queryId' }, rt.ArrayItem{ key: none, val: 'postId' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary) get_source(var_product rt.PhpVal, var_show_description_if_empty rt.PhpVal) string {
	mut var_GLOBALS := rt.new_null()
	mut var_product_mutated := var_product
	mut var_show_description_if_empty_mutated := var_show_description_if_empty
	mut var_short_description := rt.call_method(var_product_mutated, 'get_short_description',
		[]rt.PhpVal{})
	if rt.is_true(var_short_description) {
		var_short_description = rt.call_function('wp_kses_post', [
			var_short_description.clone()])
		var_short_description = rt.call_method(var_GLOBALS.array_get(rt.new_string('wp_embed')),
			'run_shortcode', [var_short_description.clone()])
		var_short_description = rt.call_function('shortcode_unautop', [
			var_short_description.clone()])
		var_short_description = rt.call_function('do_shortcode', [
			var_short_description.clone()])
		return var_short_description.str()
	}
	mut var_description := rt.call_method(var_product_mutated, 'get_description', []rt.PhpVal{})
	if rt.is_true(var_show_description_if_empty_mutated) && rt.is_true(var_description) {
		var_description = rt.call_function('wp_kses_post', [var_description.clone()])
		var_description = rt.call_method(var_GLOBALS.array_get(rt.new_string('wp_embed')),
			'run_shortcode', [var_description.clone()])
		var_description = rt.call_function('shortcode_unautop', [
			var_description.clone()])
		var_description = rt.call_function('do_shortcode', [var_description.clone()])
		return var_description.str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary) create_anchor(var_product rt.PhpVal, var_link_text rt.PhpVal) string {
	mut var_product_mutated := var_product
	mut var_link_text_mutated := var_link_text
	mut var_href := rt.call_function('esc_url', [
		rt.call_method(var_product_mutated, 'get_permalink', []rt.PhpVal{}),
	])
	mut var_text := rt.call_function('wp_kses_post', [var_link_text_mutated.clone()])
	return '<a class="wp-block-woocommerce-product-summary__read_more" href="' + var_href.str() +
		'#tab-description">' + var_text.str() + '</a>'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary) get_first_paragraph(var_source rt.PhpVal) rt.PhpVal {
	mut var_source_mutated := var_source
	mut var_p_index := rt.call_function('strpos', [var_source_mutated.clone(),
		rt.new_string('</p>')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_p_index)) {
		return var_source_mutated.clone()
	}
	return rt.call_function('substr', [var_source_mutated.clone(),
		rt.new_int(0), rt.add(var_p_index, rt.new_int(4))])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary) count_text(var_text rt.PhpVal, var_count_type rt.PhpVal) i64 {
	mut var_text_mutated := var_text
	mut var_count_type_mutated := var_count_type
	mut switch_val_1 := var_count_type_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('characters_excluding_spaces'))) {
		return rt.call_function('preg_replace', [rt.new_string('/\\s+/'),
			rt.new_string(''), var_text_mutated.clone()]).to_string().len
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('characters_including_spaces'))) {
		return var_text_mutated.clone().to_string().len
	} else {
		return (rt.call_function('str_word_count', [
			rt.call_function('wp_strip_all_tags', [var_text_mutated.clone()]),
		])).to_i64()
	}
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary) trim_characters(var_text rt.PhpVal, var_max_length rt.PhpVal, var_count_type rt.PhpVal) rt.PhpVal {
	mut var_spaces := rt.new_null()
	mut var_text_mutated := var_text
	mut var_count_type_mutated := var_count_type
	mut var_pure_text := rt.call_function('wp_strip_all_tags', [
		var_text_mutated.clone()])
	mut var_trimmed := rt.call_function('mb_substr', [var_pure_text.clone(),
		rt.new_int(0), var_max_length.clone()])
	if rt.is_true(rt.identical(rt.new_string('characters_including_spaces'), var_count_type_mutated)) {
		return var_trimmed.clone()
	}
	rt.call_function('preg_match_all', [rt.new_string('/([\\s]+)/'),
		var_trimmed.clone(), var_spaces.clone()])
	mut var_space_count := rt.new_int(if !(!rt.is_true(var_spaces.array_get(rt.new_int(0)))) {
		var_spaces.array_get(rt.new_int(0)).array_count()
	} else {
		0
	})
	return rt.call_function('mb_substr', [var_pure_text.clone(),
		rt.new_int(0), rt.add(var_max_length, var_space_count)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary) generate_summary(var_source rt.PhpVal, var_max_length rt.PhpVal) string {
	mut var_source_mutated := var_source
	mut var_count_type := rt.call_function('wp_get_word_count_type', []rt.PhpVal{})
	mut var_source_with_paragraphs := rt.call_function('wpautop', [
		var_source_mutated.clone()])
	mut var_source_word_count := rt.new_int(this.count_text(var_source_with_paragraphs.clone(),
		var_count_type.clone()))
	if rt.is_true(rt.less_equal(var_source_word_count, var_max_length)) {
		return var_source_with_paragraphs.str()
	}
	mut var_first_paragraph := this.get_first_paragraph(var_source_with_paragraphs.clone())
	mut var_first_paragraph_word_count := rt.new_int(this.count_text(var_first_paragraph.clone(),
		var_count_type.clone()))
	if rt.is_true(rt.less_equal(var_first_paragraph_word_count, var_max_length)) {
		return var_first_paragraph.str()
	}
	if rt.is_true(rt.identical(rt.new_string('words'), var_count_type)) {
		return (rt.call_function('wpautop', [
			rt.call_function('wp_trim_words', [var_first_paragraph.clone(),
				var_max_length.clone()]),
		])).str()
	}
	return
		(this.trim_characters(var_first_paragraph.clone(), var_max_length.clone(), var_count_type.clone())).str() +
		'…'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_post_id := if !(rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))).is_null() {
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))
	} else {
		rt.new_string('')
	}
	mut var_product := rt.call_function('wc_get_product', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	mut var_show_description_if_empty := rt.new_bool(
		var_attributes.array_isset(rt.new_string('showDescriptionIfEmpty'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('showDescriptionIfEmpty'))))
	mut var_source := rt.new_string(this.get_source(var_product.clone(),
		var_show_description_if_empty.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_source)))) {
		return ''
	}
	mut var_summary_length := if var_attributes.array_isset(rt.new_string('summaryLength')) {
		var_attributes.array_get(rt.new_string('summaryLength'))
	} else {
		rt.new_bool(false)
	}
	mut var_link_text := if var_attributes.array_isset(rt.new_string('linkText')) {
		var_attributes.array_get(rt.new_string('linkText'))
	} else {
		rt.new_string('')
	}
	mut var_show_link := rt.new_bool(var_attributes.array_isset(rt.new_string('showLink'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('showLink'))))
	mut var_summary := if rt.is_true(var_summary_length) { this.generate_summary(var_source.clone(), var_summary_length.clone()) } else { rt.call_function('wpautop', [
			var_source.clone(),
		]) }
	mut var_final_summary := if rt.is_true(var_show_link) && rt.is_true(var_link_text) {
		var_summary.str() + this.create_anchor(var_product.clone(), var_link_text.clone())
	} else {
		var_summary
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_0 := iife_temp_0.get_classes_and_styles_by_attributes(var_attributes.clone())
	mut var_styles_and_classes := iife_result_0
	return (rt.call_function('sprintf', [
		rt.new_string('<div class="wp-block-woocommerce-product-summary"><div class="wc-block-components-product-summary %1$s" style="%2$s">\n\t\t\t\t%3$s\n\t\t\t</div></div>'),
		rt.call_function('esc_attr', [var_styles_and_classes.array_get(rt.new_string('classes'))]),
		rt.call_function('esc_attr', [if !(var_styles_and_classes.array_get(rt.new_string('styles'))).is_null() {
			var_styles_and_classes.array_get(rt.new_string('styles'))
		} else {
			rt.new_string('')
		}]),
		var_final_summary.clone(),
	])).str()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productsummary(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-summary')
		api_version:   rt.new_string('3')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_block_type_assets' {
			return this.register_block_type_assets()
		}
		'get_block_type_uses_context' {
			return this.get_block_type_uses_context()
		}
		'get_source' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.get_source(dispatch_arg_0, dispatch_arg_1))
		}
		'create_anchor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.create_anchor(dispatch_arg_0, dispatch_arg_1))
		}
		'get_first_paragraph' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_first_paragraph(dispatch_arg_0)
		}
		'count_text' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.count_text(dispatch_arg_0, dispatch_arg_1))
		}
		'trim_characters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.trim_characters(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'generate_summary' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.generate_summary(dispatch_arg_0, dispatch_arg_1))
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'api_version' { return this.api_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSummary) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		'api_version' {
			this.api_version = val
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
