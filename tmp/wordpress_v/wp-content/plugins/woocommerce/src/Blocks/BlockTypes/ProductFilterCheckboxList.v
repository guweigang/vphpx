import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterCheckboxList {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-filter-checkbox-list')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterCheckboxList) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !rt.is_true(rt.get_property(var_block, 'context').array_get('filterData')) {
		return ''
	}
	mut var_block_context := rt.get_property(var_block, 'context').array_get('filterData')
	mut var_items := if !(var_block_context.array_get('items')).is_null() {
		var_block_context.array_get('items')
	} else {
		rt.new_array()
	}
	mut var_show_counts := if !(var_block_context.array_get('showCounts')).is_null() {
		var_block_context.array_get('showCounts')
	} else {
		rt.new_bool(false)
	}
	mut var_classes := rt.new_string(rt.new_string(''))
	mut var_style := rt.new_string(rt.new_string(''))
	mut var_tags :=
		create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(var_content.dup())
	if rt.is_true(var_tags.next_tag(rt.create_array([
		rt.ArrayItem{ key: 'class_name', val: 'wc-block-product-filter-checkbox-list' },
	])))
	{
		var_classes = var_tags.get_attribute(rt.new_string('class'))
		var_style = var_tags.get_attribute(rt.new_string('style'))
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return (var_item.array_get('selected')).str()
	}
	mut var_checked_items := rt.call_function('array_filter', [
		var_items.dup(), rt.new_closure(closure_1_fn)])
	mut var_show_initially := rt.new_int(rt.new_int(15))
	mut var_remaining_initial_unchecked := if rt.is_true(rt.greater(rt.new_int(var_checked_items.dup().array_count()),
		var_show_initially))
	{
		rt.new_int(var_checked_items.dup().array_count())
	} else {
		rt.sub(var_show_initially, rt.new_int(var_checked_items.dup().array_count()))
	}
	mut var_count := rt.new_int(rt.new_int(0))
	mut var_wrapper_attributes := rt.create_array([
		rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/product-filters' },
		rt.ArrayItem{ key: 'data-wp-key', val: rt.call_function('wp_unique_prefixed_id', [
			this.get_full_block_name(),
		]) },
		rt.ArrayItem{ key: 'data-wp-context', val: '{}' },
		rt.ArrayItem{ key: 'class', val: rt.call_function('esc_attr', [
			var_classes.dup(),
		]) },
	])
	if !(!rt.is_true(var_style)) {
		var_wrapper_attributes.array_set('style',

			(rt.call_function('esc_attr', [var_style.dup()])).str() + ';')
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_block_wrapper_attributes', [
		var_wrapper_attributes.dup()]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_block_context.array_get('groupLabel'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_block_context.array_get('groupLabel')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			// unsupported statement: Stmt_InlineHTML
			mut var_item_id := rt.new_string(
				(var_item.array_get('type')).str() + '-' + (var_item.array_get('value')).str())
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_item_id.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(if var_item.array_isset(rt.new_string('depth')) { rt.call_function('esc_attr', [
					'has-depth-' + (var_item.array_get('depth')).str(),
				]) } else { rt.new_string('') })
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!(rt.is_true(var_item.array_get('selected'))))) {
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.greater_equal(var_count, var_remaining_initial_unchecked)) {
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
					rt.pre_inc(var_count)
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_item_id.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_item_id.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				this.get_aria_label(var_item.dup(), var_show_counts.dup()),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_item.array_get('value')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_interactivity_data_wp_context', [
				rt.create_array([rt.ArrayItem{ key: 'item', val: var_item }]),
			]))
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_item.array_get('label'))
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_show_counts) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_item.array_get('count')]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.greater(rt.new_int(var_items.dup().array_count()), var_show_initially)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Show more…'),
			rt.new_string('woocommerce')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterCheckboxList) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterCheckboxList) get_aria_label(var_item rt.PhpVal, var_show_counts rt.PhpVal) rt.PhpVal {
	mut var_show_counts_mutated := var_show_counts
	if rt.is_true(var_show_counts_mutated) {
		return rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%1$s (%2$d product)'),
				rt.new_string('%1$s (%2$d products)'), var_item.array_get('count'),
				rt.new_string('woocommerce')]),
			if !(var_item.array_get('ariaLabel')).is_null() {
				var_item.array_get('ariaLabel')
			} else {
				var_item.array_get('label')
			},
			var_item.array_get('count'),
		])
	}
	return if !(var_item.array_get('ariaLabel')).is_null() {
		var_item.array_get('ariaLabel')
	} else {
		var_item.array_get('label')
	}
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productfiltercheckboxlist() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterCheckboxList {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterCheckboxList{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-filter-checkbox-list')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterCheckboxList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		'get_aria_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_aria_label(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterCheckboxList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterCheckboxList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productfiltercheckboxlist_php() {
	// unsupported statement: Stmt_Declare
}
