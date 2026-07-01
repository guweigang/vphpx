import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductResultsCount {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-results-count')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductResultsCount) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductResultsCount) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	rt.call_function('ob_start', []rt.PhpVal{})
	print('<div>')
	rt.call_function('woocommerce_result_count', []rt.PhpVal{})
	print('</div>')
	mut var_product_results_count := rt.call_function('ob_get_clean', []rt.PhpVal{})
	mut var_p :=
		create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(var_product_results_count.dup())
	var_p.next_tag(rt.new_string('div'))
	mut var_parsed_style_attributes := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_classes_and_styles_by_attributes(arg_0)
	}(var_attributes.dup())
	mut var_classes := rt.call_function('array_merge', [
		rt.call_function('explode',
			[rt.new_string(' '), var_parsed_style_attributes.array_get('classes')]),
		rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce' },
			rt.ArrayItem{ key: none, val: 'wc-block-product-results-count' },
			rt.ArrayItem{ key: none, val: 'wp-block-woocommerce-product-results-count' }]),
	])
	var_p.set_attribute(rt.new_string('class'), rt.call_function('implode', [
		rt.new_string(' '),
		var_classes.dup(),
	]))
	var_p.set_attribute(rt.new_string('style'), var_parsed_style_attributes.array_get('styles'))
	var_p.set_attribute(rt.new_string('data-wp-interactive'), this.get_full_block_name())
	var_p.set_attribute(rt.new_string('data-wp-router-region'), rt.new_string(
		'wc-product-results-count-' +(if rt.get_property(var_block, 'context').array_isset(rt.new_string('queryId')) { rt.get_property(var_block, 'context').array_get('queryId') } else { rt.new_int(0) }).str()))
	return var_p.get_updated_html()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productresultscount() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductResultsCount {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductResultsCount{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-results-count')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor() &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductResultsCount) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductResultsCount) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductResultsCount) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productresultscount_php() {
}
