import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPriceSlider {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-filter-price-slider')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPriceSlider) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))
		|| !rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('filterData')))
		|| !rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('filterData')).array_get(rt.new_string('price'))) {
		return ''
	}
	mut var_price_data :=
		rt.get_property(var_block, 'context').array_get(rt.new_string('filterData')).array_get(rt.new_string('price'))
	mut var_min_price := var_price_data.array_get(rt.new_string('minPrice'))
	mut var_max_price := var_price_data.array_get(rt.new_string('maxPrice'))
	mut var_min_range := var_price_data.array_get(rt.new_string('minRange'))
	mut var_max_range := var_price_data.array_get(rt.new_string('maxRange'))
	if rt.is_true(rt.identical(var_min_range, var_max_range)) {
		return ''
	}
	mut var_classes := rt.new_string('')
	mut var_style := rt.new_string('')
	mut var_tags :=
		create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(var_content.clone())
	if rt.is_true(var_tags.next_tag(rt.create_array([
		rt.ArrayItem{ key: 'class_name', val: 'wc-block-product-filter-price-slider' },
	])))
	{
		var_classes = var_tags.get_attribute(rt.new_string('class'))
		var_style = var_tags.get_attribute(rt.new_string('style'))
	}
	mut var_show_input_fields := if var_attributes.array_isset(rt.new_string('showInputFields')) {
		var_attributes.array_get(rt.new_string('showInputFields'))
	} else {
		rt.new_bool(false)
	}
	mut var_inline_input := if var_attributes.array_isset(rt.new_string('inlineInput')) {
		var_attributes.array_get(rt.new_string('inlineInput'))
	} else {
		rt.new_bool(false)
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/product-filters' },
			rt.ArrayItem{ key: 'data-wp-key', val: rt.call_function('wp_unique_prefixed_id', [
				this.get_full_block_name(),
			]) },
			rt.ArrayItem{ key: 'class', val: rt.call_function('esc_attr', [
				var_classes.clone(),
			]) },
			rt.ArrayItem{ key: 'style', val: rt.call_function('esc_attr', [
				var_style.clone(),
			]) },
		]),
	])
	mut var_content_class := rt.new_string('wc-block-product-filter-price-slider__content')
	if rt.is_true(var_inline_input) && rt.is_true(var_show_input_fields) {
		var_content_class = rt.concat(var_content_class,
			rt.new_string(' wc-block-product-filter-price-slider__content--inline'))
	}
	mut var___low := rt.div(rt.mul(rt.new_int(100), rt.sub(var_min_price, var_min_range)), rt.sub(var_max_range,
		var_min_range))
	mut var___high := rt.div(rt.mul(rt.new_int(100), rt.sub(var_max_price, var_min_range)), rt.sub(var_max_range,
		var_min_range))
	mut var_range_style :=
		rt.new_string('--low: ${var___low.to_string()}%; --high: ${var___high.to_string()}%')
	rt.call_function('wp_interactivity_state', [
		rt.new_string('woocommerce/product-filters'),
		rt.create_array([rt.ArrayItem{ key: 'rangeStyle', val: var_range_style }]),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_show_input_fields) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [
			rt.new_string('Filter products by minimum price'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_left_input := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_wrapper_attributes)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_content_class.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_inline_input) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_left_input)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_min_range.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_max_range.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Filter products by minimum price'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_min_range.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_max_range.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Filter products by maximum price'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(var_inline_input)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_left_input)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_show_input_fields) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [
			rt.new_string('Filter products by maximum price'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productfilterpriceslider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPriceSlider {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPriceSlider{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-filter-price-slider')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPriceSlider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPriceSlider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPriceSlider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
