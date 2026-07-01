import rt

pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice.min_price_query_var() string {
	return 'min_price'
}
pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice.max_price_query_var() string {
	return 'max_price'
}
struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('product-filter-price')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice) initialize()  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_filter', [rt.new_string('woocommerce_blocks_product_filters_selected_items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'prepare_selected_filters' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice) prepare_selected_filters(var_items rt.PhpVal, var_params rt.PhpVal) rt.PhpVal {
	mut var_items_mutated := var_items
	mut var_min_price := rt.new_int(rt.new_int(if !(var_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice.min_price_query_var())).is_null() { var_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice.min_price_query_var()) } else { rt.new_int(0) }.to_i64()))
	mut var_max_price := rt.new_int(rt.new_int(if !(var_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice.max_price_query_var())).is_null() { var_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice.max_price_query_var()) } else { rt.new_int(0) }.to_i64()))
	mut var_formatted_min_price := if rt.is_true(var_min_price) { rt.call_function('html_entity_decode', [rt.call_function('wp_strip_all_tags', [rt.call_function('wc_price', [var_min_price.dup(), rt.create_array([rt.ArrayItem{ key: 'decimals', val: 0 }])])])]) } else { rt.new_null() }
	mut var_formatted_max_price := if rt.is_true(var_max_price) { rt.call_function('html_entity_decode', [rt.call_function('wp_strip_all_tags', [rt.call_function('wc_price', [var_max_price.dup(), rt.create_array([rt.ArrayItem{ key: 'decimals', val: 0 }])])])]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_formatted_min_price)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_formatted_max_price)))))) {
		return var_items_mutated.dup()
	}
	mut var_item := rt.create_array([rt.ArrayItem{ key: 'type', val: 'price' }])
	if rt.is_true(rt.new_bool(rt.is_true(var_formatted_min_price) && rt.is_true(var_formatted_max_price))) {
		var_item.array_set('activeLabel', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Price: %1$s - %2$s'), rt.new_string('woocommerce')]), var_formatted_min_price.dup(), var_formatted_max_price.dup()]))
		var_item.array_set('value', "${var_min_price.to_string()}|${var_max_price.to_string()}")
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_formatted_min_price)))) {
		var_item.array_set('activeLabel', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Price: Up to %s'), rt.new_string('woocommerce')]), var_formatted_max_price.dup()]))
		var_item.array_set('value', "|${var_max_price.to_string()}")
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_formatted_max_price)))) {
		var_item.array_set('activeLabel', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Price: From %s'), rt.new_string('woocommerce')]), var_formatted_min_price.dup()]))
		var_item.array_set('value', "${var_min_price.to_string()}|")
	}
	var_items_mutated.array_push(var_item.dup())
	return var_items_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})))) {
		return ''
	}
	mut var_price_range := this.get_filtered_price(var_block.dup())
	mut var_min_range := if !(var_price_range.array_get('min_price')).is_null() { var_price_range.array_get('min_price') } else { rt.new_int(0) }
	mut var_max_range := if !(var_price_range.array_get('max_price')).is_null() { var_price_range.array_get('max_price') } else { rt.new_int(0) }
	mut var_filter_params := if !(rt.get_property(var_block, 'context').array_get('filterParams')).is_null() { rt.get_property(var_block, 'context').array_get('filterParams') } else { rt.new_array() }
	mut var_min_price := rt.new_int(rt.new_int(if !(var_filter_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice.min_price_query_var())).is_null() { var_filter_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice.min_price_query_var()) } else { var_min_range }.to_i64()))
	mut var_max_price := rt.new_int(rt.new_int(if !(var_filter_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice.max_price_query_var())).is_null() { var_filter_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice.max_price_query_var()) } else { var_max_range }.to_i64()))
	mut var_formatted_min_price := rt.call_function('html_entity_decode', [rt.call_function('wp_strip_all_tags', [rt.call_function('wc_price', [var_min_price.dup(), rt.create_array([rt.ArrayItem{ key: 'decimals', val: 0 }])])])])
	mut var_formatted_max_price := rt.call_function('html_entity_decode', [rt.call_function('wp_strip_all_tags', [rt.call_function('wc_price', [var_max_price.dup(), rt.create_array([rt.ArrayItem{ key: 'decimals', val: 0 }])])])])
	mut var_filter_context := rt.create_array([rt.ArrayItem{ key: 'price', val: rt.create_array([rt.ArrayItem{ key: 'minPrice', val: var_min_price }, rt.ArrayItem{ key: 'maxPrice', val: var_max_price }, rt.ArrayItem{ key: 'minRange', val: var_min_range }, rt.ArrayItem{ key: 'maxRange', val: var_max_range }]) }, rt.ArrayItem{ key: 'groupLabel', val: rt.call_function('__', [rt.new_string('Price'), rt.new_string('woocommerce')]) }])
	mut var_wrapper_attributes := rt.create_array([rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/product-filters' }, rt.ArrayItem{ key: 'data-wp-key', val: rt.call_function('wp_unique_prefixed_id', [this.get_full_block_name()]) }, rt.ArrayItem{ key: 'data-wp-context', val: rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'filterType', val: 'price' }, rt.ArrayItem{ key: 'minRange', val: var_min_range }, rt.ArrayItem{ key: 'maxRange', val: var_max_range }]), rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')), rt.get_constant('JSON_HEX_AMP'))]) }])
	rt.call_function('wp_interactivity_config', [rt.new_string('woocommerce/product-filters'), rt.create_array([rt.ArrayItem{ key: 'activePriceLabelTemplates', val: rt.create_array([rt.ArrayItem{ key: 'minAndMax', val: rt.call_function('__', [rt.new_string('Price: {{min}} - {{max}}'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'maxOnly', val: rt.call_function('__', [rt.new_string('Price: Up to {{max}}'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'minOnly', val: rt.call_function('__', [rt.new_string('Price: From {{min}}'), rt.new_string('woocommerce')]) }]) }])])
	rt.call_function('wp_interactivity_state', [rt.new_string('woocommerce/product-filters'), rt.create_array([rt.ArrayItem{ key: 'formattedMinPrice', val: var_formatted_min_price }, rt.ArrayItem{ key: 'formattedMaxPrice', val: var_formatted_max_price }, rt.ArrayItem{ key: 'minPrice', val: var_min_price }, rt.ArrayItem{ key: 'maxPrice', val: var_max_price }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_min_range, var_max_range)) || rt.is_true(rt.new_bool(!(rt.is_true(var_max_range)))))) {
		var_wrapper_attributes.array_set('hidden', true)
		var_wrapper_attributes.array_set('class', 'wc-block-product-filter--hidden')
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_parsed_block := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	// unsupported expression: Expr_AssignOp_Concat
	return (var_carry).str()
	}
		return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'), rt.call_function('get_block_wrapper_attributes', [var_wrapper_attributes.dup()]), rt.call_function('array_reduce', [rt.get_property(var_block, 'parsed_block').array_get('innerBlocks'), rt.new_closure(closure_1_fn), rt.new_string('')])])).str()
	}
	closure_2_fn := fn [var_filter_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_parsed_block := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	// unsupported expression: Expr_AssignOp_Concat
	return (var_carry).str()
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'), rt.call_function('get_block_wrapper_attributes', [var_wrapper_attributes.dup()]), rt.call_function('array_reduce', [rt.get_property(var_block, 'parsed_block').array_get('innerBlocks'), rt.new_closure(closure_2_fn), rt.new_string('')])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice) get_filtered_price(var_block rt.PhpVal) rt.PhpVal {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('filterParams'))) {
		return rt.new_array()
	}
	mut var_query_vars := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{}; return temp.get_query_vars(arg_0, arg_1) }(var_block.dup(), rt.new_int(1))
	var_query_vars.array_unset(rt.new_string('min_price'))
	var_query_vars.array_unset(rt.new_string('max_price'))
	if !(!rt.is_true(var_query_vars.array_get('meta_query'))) {
		var_query_vars.array_set('meta_query', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{}; return temp.remove_query_array(arg_0, arg_1, arg_2) }(var_query_vars.array_get('meta_query'), rt.new_string('key'), rt.new_string('_price')))
	}
	if rt.is_true(rt.new_bool(var_query_vars.array_isset(rt.new_string('taxonomy')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_query_vars.array_unset(rt.new_string('taxonomy'))
		var_query_vars.array_unset(rt.new_string('term'))
	}
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_price_results := rt.call_method(rt.call_method(rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductFilters_FilterDataProvider.class()]), 'with', [rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses.class()])]), 'get_filtered_price', [var_query_vars.dup()])
	return rt.create_array([rt.ArrayItem{ key: 'min_price', val: rt.call_function('floor', [rt.new_float(if !(var_price_results.array_get('min_price')).is_null() { var_price_results.array_get('min_price') } else { rt.new_int(0) }.to_f64())]).to_i64() }, rt.ArrayItem{ key: 'max_price', val: rt.call_function('ceil', [rt.new_float(if !(var_price_results.array_get('max_price')).is_null() { var_price_results.array_get('max_price') } else { rt.new_int(0) }.to_f64())]).to_i64() }])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productfilterprice() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('product-filter-price')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_filtered_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_filtered_price(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterPrice) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productfilterprice_php() {
	// unsupported statement: Stmt_Declare
}
