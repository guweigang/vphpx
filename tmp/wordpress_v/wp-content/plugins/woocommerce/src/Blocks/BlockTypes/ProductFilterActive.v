import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterActive {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-filter-active')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterActive) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('activeFilters'))) {
		return var_content.dup()
	}
	mut var_active_filters := rt.get_property(var_block, 'context').array_get('activeFilters')
	mut var_filter_context := rt.create_array([
		rt.ArrayItem{ key: 'items', val: var_active_filters },
	])
	mut var_wrapper_attributes := rt.create_array([
		rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/product-filters' },
		rt.ArrayItem{ key: 'data-wp-key', val: rt.call_function('wp_unique_prefixed_id', [
			this.get_full_block_name(),
		]) },
		rt.ArrayItem{ key: 'data-wp-context', val: rt.call_function('wp_json_encode', [
			rt.create_array([rt.ArrayItem{ key: 'filterType', val: 'active' }]),
			rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')),
				rt.get_constant('JSON_HEX_AMP')),
		]) },
		rt.ArrayItem{ key: 'data-wp-bind--hidden', val: '!state.hasActiveFilters' },
		rt.ArrayItem{
			key: 'data-wp-class--wc-block-product-filter--hidden'
			val: '!state.hasActiveFilters'
		},
	])
	rt.call_function('wp_interactivity_state', [
		rt.new_string('woocommerce/product-filters'),
		rt.create_array([
			rt.ArrayItem{ key: 'hasActiveFilters', val: !(!rt.is_true(var_active_filters)) },
		]),
	])
	rt.call_function('wp_interactivity_config', [
		rt.new_string('woocommerce/product-filters'),
		rt.create_array([
			rt.ArrayItem{ key: 'removeLabelTemplate', val: rt.call_function('__', [
				rt.new_string('Remove filter: {{label}}'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
	closure_1_fn := fn [var_filter_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_parsed_block := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		// unsupported expression: Expr_AssignOp_Concat
		return var_carry.dup()
	}
	return rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		rt.call_function('get_block_wrapper_attributes', [var_wrapper_attributes.dup()]),
		rt.call_function('array_reduce', [rt.get_property(var_block, 'parsed_block').array_get('innerBlocks'),
			rt.new_closure(closure_1_fn), rt.new_string('')])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterActive) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterActive) get_block_type_editor_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterActive) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productfilteractive() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterActive {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterActive{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-filter-active')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterActive) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		'get_block_type_editor_style' {
			return this.get_block_type_editor_style()
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterActive) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterActive) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productfilteractive_php() {
	// unsupported statement: Stmt_Declare
}
