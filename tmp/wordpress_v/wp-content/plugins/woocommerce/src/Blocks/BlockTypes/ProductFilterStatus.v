import rt

pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus.stock_status_query_var() string {
	return 'filter_stock_status'
}
struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('product-filter-status')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus) initialize()  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_filter', [rt.new_string('woocommerce_blocks_product_filters_selected_items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'prepare_selected_filters' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus) prepare_selected_filters(var_items rt.PhpVal, var_params rt.PhpVal) rt.PhpVal {
	mut var_items_mutated := var_items
	mut var_status_options := rt.call_function('array_merge', [rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{}), rt.new_array()])
	if !rt.is_true(var_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus.stock_status_query_var())) {
		return var_items_mutated.dup()
	}
	closure_1_fn := fn [var_status_options] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_status := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(var_status_options.dup().array_isset(var_status.dup()))
	}
	mut var_active_statuses := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus.stock_status_query_var())])]), rt.new_closure(closure_1_fn)])
	if !rt.is_true(var_active_statuses) {
		return var_items_mutated.dup()
	}
	{
		mut iter_1 := var_active_statuses.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_status := item_1.val
			var_items_mutated.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'status' }, rt.ArrayItem{ key: 'value', val: var_status }, rt.ArrayItem{ key: 'activeLabel', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Status: %s'), rt.new_string('woocommerce')]), var_status_options.array_get(var_status)]) }]))
		}
	}
	return var_items_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus) enqueue_data(mut var_stock_statuses Class_Automattic_WooCommerce_Blocks_BlockTypes_array)  {
	mut var_stock_statuses_mutated := var_stock_statuses
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array', []string{}, var_stock_statuses_mutated))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('stockStatusOptions'), rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('hideOutOfStockItems'), rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})))) {
		return ''
	}
	mut var_stock_status_data := this.get_stock_status_counts(var_block.dup())
	mut var_stock_statuses := rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})
	mut var_filter_params := if !(rt.get_property(var_block, 'context').array_get('filterParams')).is_null() { rt.get_property(var_block, 'context').array_get('filterParams') } else { rt.new_array() }
	mut var_query := if !(var_filter_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus.stock_status_query_var())).is_null() { var_filter_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus.stock_status_query_var()) } else { rt.new_string('') }
	mut var_selected_stock_statuses := rt.call_function('array_filter', [rt.call_function('explode', [rt.new_string(','), var_query.dup()])])
	closure_3_fn := fn [var_stock_statuses, var_selected_stock_statuses] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_stock_statuses, var_selected_stock_statuses] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (rt.create_array([rt.ArrayItem{ key: 'label', val: var_stock_statuses.array_get(var_item.array_get('status')) }, rt.ArrayItem{ key: 'value', val: var_item.array_get('status') }, rt.ArrayItem{ key: 'selected', val: rt.call_function('in_array', [var_item.array_get('status'), var_selected_stock_statuses.dup(), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'count', val: var_item.array_get('count') }, rt.ArrayItem{ key: 'type', val: 'status' }])).str()
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (rt.create_array([rt.ArrayItem{ key: 'label', val: var_stock_statuses.array_get(var_item.array_get('status')) }, rt.ArrayItem{ key: 'value', val: var_item.array_get('status') }, rt.ArrayItem{ key: 'selected', val: rt.call_function('in_array', [var_item.array_get('status'), var_selected_stock_statuses.dup(), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'count', val: var_item.array_get('count') }, rt.ArrayItem{ key: 'type', val: 'status' }])).str()
	}
	mut var_filter_options := rt.call_function('array_map', [rt.new_closure(closure_2_fn), var_stock_status_data.dup()])
	mut var_filter_context := rt.create_array([rt.ArrayItem{ key: 'items', val: rt.call_function('array_values', [var_filter_options.dup()]) }, rt.ArrayItem{ key: 'showCounts', val: if !(var_attributes.array_get('showCounts')).is_null() { var_attributes.array_get('showCounts') } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 'groupLabel', val: rt.call_function('__', [rt.new_string('Status'), rt.new_string('woocommerce')]) }])
	mut var_wrapper_attributes := rt.create_array([rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/product-filters' }, rt.ArrayItem{ key: 'data-wp-key', val: rt.call_function('wp_unique_prefixed_id', [this.get_full_block_name()]) }, rt.ArrayItem{ key: 'data-wp-context', val: rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'activeLabelTemplate', val: rt.call_function('__', [rt.new_string('Status: {{label}}'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'filterType', val: 'status' }]), rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')), rt.get_constant('JSON_HEX_AMP'))]) }])
	if !rt.is_true(var_filter_options) {
		var_wrapper_attributes.array_set('hidden', true)
		var_wrapper_attributes.array_set('class', 'wc-block-product-filter--hidden')
	}
	closure_4_fn := fn [var_filter_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_parsed_block := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	// unsupported expression: Expr_AssignOp_Concat
	return (var_carry).str()
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'), rt.call_function('get_block_wrapper_attributes', [var_wrapper_attributes.dup()]), rt.call_function('array_reduce', [rt.get_property(var_block, 'parsed_block').array_get('innerBlocks'), rt.new_closure(closure_4_fn), rt.new_string('')])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus) get_stock_status_counts(var_block rt.PhpVal) rt.PhpVal {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('filterParams'))) {
		return rt.new_array()
	}
	mut var_query_vars := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{}; return temp.get_query_vars(arg_0, arg_1) }(var_block.dup(), rt.new_int(1))
	var_query_vars.array_unset(rt.new_string('filter_stock_status'))
	if rt.is_true(rt.new_bool(var_query_vars.array_isset(rt.new_string('taxonomy')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_query_vars.array_unset(rt.new_string('taxonomy'))
		var_query_vars.array_unset(rt.new_string('term'))
	}
	if !(!rt.is_true(var_query_vars.array_get('meta_query'))) {
		var_query_vars.array_set('meta_query', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{}; return temp.remove_query_array(arg_0, arg_1, arg_2) }(var_query_vars.array_get('meta_query'), rt.new_string('key'), rt.new_string('_stock_status')))
	}
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_counts := rt.call_method(rt.call_method(rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductFilters_FilterDataProvider.class()]), 'with', [rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses.class()])]), 'get_stock_status_counts', [var_query_vars.dup(), rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{}))])
	mut var_data := rt.new_array()
	{
		mut iter_1 := var_counts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_data.array_push(rt.create_array([rt.ArrayItem{ key: 'status', val: var_key }, rt.ArrayItem{ key: 'count', val: var_value.dup().to_i64() }]))
		}
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_stock_count := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.greater(var_stock_count.array_get('count'), rt.new_int(0))
	}
	return rt.call_function('array_filter', [var_data.dup(), rt.new_closure(closure_5_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus) get_block_type_editor_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productfilterstatus() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('product-filter-status')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_utils() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'prepare_selected_filters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_selected_filters(dispatch_arg_0, dispatch_arg_1)
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_stock_status_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_stock_status_counts(dispatch_arg_0)
		}
		'get_block_type_editor_style' {
			return this.get_block_type_editor_style()
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productfilterstatus_php() {
	// unsupported statement: Stmt_Declare
}
