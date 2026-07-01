import rt

pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating.rating_filter_query_var() string {
	return 'rating_filter'
}
struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('product-filter-rating')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating) initialize()  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_filter', [rt.new_string('woocommerce_blocks_product_filters_selected_items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'prepare_selected_filters' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating) prepare_selected_filters(var_items rt.PhpVal, var_params rt.PhpVal) rt.PhpVal {
	mut var_items_mutated := var_items
	if !rt.is_true(var_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating.rating_filter_query_var())) {
		return var_items_mutated.dup()
	}
	mut var_active_ratings := rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('explode', [rt.new_string(','), var_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating.rating_filter_query_var())])])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_rating := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(rt.is_true(rt.greater(var_rating, rt.new_int(0))) && rt.is_true(rt.less(var_rating, rt.new_int(6))))
	}
	var_active_ratings = rt.call_function('array_filter', [var_active_ratings.dup(), rt.new_closure(closure_1_fn)])
	var_active_ratings = rt.call_function('array_unique', [var_active_ratings.dup()])
	if !rt.is_true(var_active_ratings) {
		return var_items_mutated.dup()
	}
	{
		mut iter_1 := var_active_ratings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_rating := item_1.val
			var_items_mutated.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'rating' }, rt.ArrayItem{ key: 'value', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'activeLabel', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Rating: Rated %d out of 5'), rt.new_string('woocommerce')]), var_rating.dup()]) }]))
		}
	}
	return var_items_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})))) {
		return ''
	}
	mut var_min_rating := if !(var_attributes.array_get('minRating')).is_null() { var_attributes.array_get('minRating') } else { rt.new_int(0) }
	mut var_rating_counts := this.get_rating_counts(var_block.dup())
	closure_2_fn := fn [var_min_rating] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_rating := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.bitwise_and(rt.greater_equal(var_rating.array_get('rating'), var_min_rating), rt.less(var_rating.array_get('rating'), rt.new_int(6)))
	}
	mut var_rating_counts_with_min := rt.call_function('array_filter', [var_rating_counts.dup(), rt.new_closure(closure_2_fn)])
	mut var_filter_params := if !(rt.get_property(var_block, 'context').array_get('filterParams')).is_null() { rt.get_property(var_block, 'context').array_get('filterParams') } else { rt.new_array() }
	mut var_rating_query := if !(var_filter_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating.rating_filter_query_var())).is_null() { var_filter_params.array_get(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating.rating_filter_query_var()) } else { rt.new_string('') }
	mut var_selected_rating := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('explode', [rt.new_string(','), var_rating_query.dup()])])])
	closure_4_fn := fn [var_selected_rating] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn [var_selected_rating] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_rating := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_aria_label := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Rated %1$d out of 5'), rt.new_string('woocommerce')]), var_rating.array_get('rating')])
	return (rt.create_array([rt.ArrayItem{ key: 'label', val: this.render_rating_label(// unsupported expression: Expr_Cast_Int) }, rt.ArrayItem{ key: 'ariaLabel', val: var_aria_label }, rt.ArrayItem{ key: 'value', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'selected', val: rt.call_function('in_array', [var_rating.array_get('rating'), var_selected_rating.dup(), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'count', val: var_rating.array_get('count') }, rt.ArrayItem{ key: 'type', val: 'rating' }])).str()
	}
	mut var_rating := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_aria_label := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Rated %1$d out of 5'), rt.new_string('woocommerce')]), var_rating.array_get('rating')])
	return (rt.create_array([rt.ArrayItem{ key: 'label', val: this.render_rating_label(// unsupported expression: Expr_Cast_Int) }, rt.ArrayItem{ key: 'ariaLabel', val: var_aria_label }, rt.ArrayItem{ key: 'value', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'selected', val: rt.call_function('in_array', [var_rating.array_get('rating'), var_selected_rating.dup(), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'count', val: var_rating.array_get('count') }, rt.ArrayItem{ key: 'type', val: 'rating' }])).str()
	}
	mut var_filter_options := rt.call_function('array_map', [rt.new_closure(closure_3_fn), var_rating_counts_with_min.dup()])
	mut var_filter_context := rt.create_array([rt.ArrayItem{ key: 'items', val: var_filter_options }, rt.ArrayItem{ key: 'showCounts', val: if !(var_attributes.array_get('showCounts')).is_null() { var_attributes.array_get('showCounts') } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 'groupLabel', val: rt.call_function('__', [rt.new_string('Rating'), rt.new_string('woocommerce')]) }])
	mut var_wrapper_attributes := rt.create_array([rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/product-filters' }, rt.ArrayItem{ key: 'data-wp-key', val: rt.call_function('wp_unique_prefixed_id', [this.get_full_block_name()]) }, rt.ArrayItem{ key: 'data-wp-context', val: rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'activeLabelTemplate', val: rt.call_function('__', [rt.new_string('Rating: {{label}}'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'filterType', val: 'rating' }]), rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')), rt.get_constant('JSON_HEX_AMP'))]) }])
	if !rt.is_true(var_filter_options) {
		var_wrapper_attributes.array_set('hidden', true)
		var_wrapper_attributes.array_set('class', 'wc-block-product-filter--hidden')
	}
	closure_5_fn := fn [var_filter_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_parsed_block := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	// unsupported expression: Expr_AssignOp_Concat
	return (var_carry).str()
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'), rt.call_function('get_block_wrapper_attributes', [var_wrapper_attributes.dup()]), rt.call_function('array_reduce', [rt.get_property(var_block, 'parsed_block').array_get('innerBlocks'), rt.new_closure(closure_5_fn), rt.new_string('')])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating) render_rating_label(var_rating rt.PhpVal) rt.PhpVal {
	mut var_view_box_width := rt.mul(var_rating, rt.new_int(24))
	mut var_rating_label := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Rated %1$d out of 5'), rt.new_string('woocommerce')]), var_rating.dup()])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_view_box_width.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_view_box_width.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_rating_label.dup()]))
	// unsupported statement: Stmt_InlineHTML
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, var_rating))) { break }
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.mul(var_i, rt.new_int(24))]))
			// unsupported statement: Stmt_InlineHTML
			rt.post_inc(var_i)
		}
	}
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating) get_rating_counts(var_block rt.PhpVal) rt.PhpVal {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('filterParams'))) {
		return rt.new_array()
	}
	mut var_query_vars := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{}; return temp.get_query_vars(arg_0, arg_1) }(var_block.dup(), rt.new_int(1))
	if !(!rt.is_true(var_query_vars.array_get('tax_query'))) {
		var_query_vars.array_set('tax_query', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{}; return temp.remove_query_array(arg_0, arg_1, arg_2) }(var_query_vars.array_get('tax_query'), rt.new_string('rating_filter'), rt.new_bool(true)))
	}
	if rt.is_true(rt.new_bool(var_query_vars.array_isset(rt.new_string('taxonomy')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_query_vars.array_unset(rt.new_string('taxonomy'))
		var_query_vars.array_unset(rt.new_string('term'))
	}
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_counts := rt.call_method(rt.call_method(rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductFilters_FilterDataProvider.class()]), 'with', [rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses.class()])]), 'get_rating_counts', [var_query_vars.dup()])
	mut var_data := rt.new_array()
	{
		mut iter_1 := var_counts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_data.array_push(rt.create_array([rt.ArrayItem{ key: 'rating', val: var_key }, rt.ArrayItem{ key: 'count', val: var_value.dup().to_i64() }]))
		}
	}
	return var_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating) get_block_type_editor_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productfilterrating() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('product-filter-rating')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'render_rating_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render_rating_label(dispatch_arg_0)
		}
		'get_rating_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_rating_counts(dispatch_arg_0)
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterRating) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productfilterrating_php() {
	// unsupported statement: Stmt_Declare
}
