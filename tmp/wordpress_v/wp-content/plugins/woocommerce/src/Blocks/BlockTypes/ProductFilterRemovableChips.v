import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRemovableChips {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-filter-removable-chips')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRemovableChips) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !rt.is_true(rt.get_property(var_block, 'context').array_get('filterData')) {
		return ''
	}
	mut var_filter_items := if !(rt.get_property(var_block, 'context').array_get('filterData').array_get('items')).is_null() {
		rt.get_property(var_block, 'context').array_get('filterData').array_get('items')
	} else {
		rt.new_array()
	}
	mut var_style := rt.new_string(rt.new_string(''))
	mut var_tags :=
		create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(var_content.dup())
	if rt.is_true(var_tags.next_tag(rt.create_array([
		rt.ArrayItem{ key: 'class_name', val: 'wc-block-product-filter-removable-chips' },
	])))
	{
		mut var_classes := var_tags.get_attribute(rt.new_string('class'))
		var_style = var_tags.get_attribute(rt.new_string('style'))
	}
	mut var_wrapper_attributes := rt.create_array([
		rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/product-filters' },
		rt.ArrayItem{ key: 'data-wp-key', val: rt.call_function('wp_unique_prefixed_id', [
			this.get_full_block_name(),
		]) },
		rt.ArrayItem{ key: 'class', val: rt.call_function('esc_attr', [
			var_classes.dup(),
		]) },
		rt.ArrayItem{ key: 'style', val: rt.call_function('esc_attr', [
			var_style.dup(),
		]) },
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_block_wrapper_attributes', [
		var_wrapper_attributes.dup()]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_filter_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			mut var_remove_label := rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Remove filter: %s'),
					rt.new_string('woocommerce')]),
				var_item.array_get('activeLabel'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_item.array_get('activeLabel')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_remove_label.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_interactivity_data_wp_context', [
				rt.create_array([rt.ArrayItem{ key: 'item', val: var_item }]),
			]))
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_remove_label.dup()]))
			// unsupported statement: Stmt_InlineHTML
		}
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

fn create_automattic_woocommerce_blocks_blocktypes_productfilterremovablechips() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRemovableChips {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRemovableChips{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-filter-removable-chips')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRemovableChips) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRemovableChips) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRemovableChips) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productfilterremovablechips_php() {
	// unsupported statement: Stmt_Declare
}
