import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer {
	rt.PhpObjectBase
pub mut:
	render_state rt.PhpVal = rt.new_array()
	parsed_block rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) construct() {
	rt.call_function('add_filter', [
		rt.new_string('render_block_woocommerce/product-collection'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_rendering' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_html := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.render_state.array_set('has_results', !(!rt.is_true(var_html)))
		return
	}
	rt.call_function('add_filter', [
		rt.new_string('render_block_woocommerce/product-template'),
		rt.new_closure(closure_1_fn),
		rt.new_int(100),
		rt.new_int(1),
	])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_html := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.render_state.array_set('has_no_results_block', !(!rt.is_true(var_html)))
		return
	}
	rt.call_function('add_filter', [
		rt.new_string('render_block_woocommerce/product-collection-no-results'),
		rt.new_closure(closure_2_fn),
		rt.new_int(100),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [rt.new_string('render_block_core/query-pagination'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_navigation_link_directives' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('render_block_context'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'extend_context_for_inner_blocks' },
		]),
		rt.new_int(11), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) set_parsed_block(var_block rt.PhpVal) {
	this.parsed_block = var_block.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) handle_rendering(var_block_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_block_content_mutated := var_block_content
	if this.should_prevent_render() {
		return ''
	}
	this.reset_render_state()
	return (this.enhance_product_collection_with_interactivity(var_block_content_mutated.clone(),
		var_block.clone())).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) should_prevent_render() bool {
	return
		rt.is_true(rt.new_bool(!(rt.is_true(this.render_state.array_get(rt.new_string('has_results'))))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(this.render_state.array_get(rt.new_string('has_no_results_block'))))))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) reset_render_state() {
	this.render_state = rt.create_array([rt.ArrayItem{ key: 'has_results', val: false },
		rt.ArrayItem{ key: 'has_no_results_block', val: false }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) enhance_product_collection_with_interactivity(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_block_content_mutated := var_block_content
	mut var_is_product_collection_block := if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('query')).array_get(rt.new_string('isProductCollectionBlock'))).is_null() {
		var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('query')).array_get(rt.new_string('isProductCollectionBlock'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(var_is_product_collection_block) {
		rt.call_function('wp_enqueue_script_module', [
			rt.new_string('woocommerce/product-collection'),
		])
		mut var_collection := if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('collection'))).is_null() {
			var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('collection'))
		} else {
			rt.new_string('')
		}
		mut var_is_enhanced_pagination_enabled := rt.new_bool(!(rt.is_true(if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('forcePageReload'))).is_null() {
			var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('forcePageReload'))
		} else {
			rt.new_bool(false)
		})))
		mut var_context := rt.create_array([
			rt.ArrayItem{ key: 'notices', val: rt.new_array() },
			rt.ArrayItem{ key: 'hideNextPreviousButtons', val: false },
			rt.ArrayItem{ key: 'isDisabledPrevious', val: true },
			rt.ArrayItem{ key: 'isDisabledNext', val: false },
			rt.ArrayItem{ key: 'ariaLabelPrevious', val: rt.call_function('__', [
				rt.new_string('Previous products'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'ariaLabelNext', val: rt.call_function('__', [
				rt.new_string('Next products'),
				rt.new_string('woocommerce'),
			]) },
		])
		if rt.is_true(var_collection) {
			var_context.array_set('collection', var_collection.clone())
		}
		mut var_p := create_wp_html_tag_processor(var_block_content_mutated.clone())
		if rt.is_true(var_p.next_tag(rt.create_array([
			rt.ArrayItem{ key: 'class_name', val: 'wp-block-woocommerce-product-collection' },
		])))
		{
			var_p.set_attribute(rt.new_string('data-wp-interactive'),
				rt.new_string('woocommerce/product-collection'))
			var_p.set_attribute(rt.new_string('data-wp-init'), rt.new_string('callbacks.onRender'))
			var_p.set_attribute(rt.new_string('data-wp-context'), rt.call_function('wp_json_encode', [
				var_context.clone(),
				rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')),
					rt.get_constant('JSON_HEX_AMP')),
			]))
			if rt.is_true(var_is_enhanced_pagination_enabled) && !(this.parsed_block).is_null() {
				var_p.set_attribute(rt.new_string('data-wp-router-region'), rt.new_string(
					'wc-product-collection-' +(this.parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('queryId'))).str()))
			}
		}
		this.handle_block_dimensions(rt.new_object('WP_HTML_Tag_Processor', []string{}, var_p),
			var_block.clone())
		var_block_content_mutated = var_p.get_updated_html()
		var_block_content_mutated =
			this.add_store_notices_fallback(var_block_content_mutated.clone())
	}
	return var_block_content_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) add_store_notices_fallback(var_block_content rt.PhpVal) rt.PhpVal {
	mut var_block_content_mutated := var_block_content
	return rt.call_function('preg_replace', [rt.new_string('/(<div[^>]+>)/'),
		rt.new_string('$1' + (this.render_interactivity_notices_region()).str()),
		var_block_content_mutated.clone(), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) render_interactivity_notices_region() rt.PhpVal {
	rt.call_function('wp_interactivity_state', [
		rt.new_string('woocommerce/store-notices'),
		rt.create_array([rt.ArrayItem{ key: 'notices', val: rt.new_array() }]),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Dismiss this notice'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) get_list_styles(var_fixed_width rt.PhpVal) rt.PhpVal {
	mut var_style := rt.new_string('')
	if !var_fixed_width.is_null() && !(!rt.is_true(var_fixed_width)) {
		var_style = rt.concat(var_style, rt.call_function('sprintf', [
			rt.new_string('width:%s;'),
			rt.call_function('esc_attr', [var_fixed_width.clone()]),
		]))
		var_style = rt.concat(var_style, rt.new_string('margin: 0 auto;'))
	}
	return var_style.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) set_fixed_width_style(var_p rt.PhpVal, var_fixed_width rt.PhpVal) {
	mut var_p_mutated := var_p
	var_p_mutated.set_attribute(rt.new_string('style'),
		this.get_list_styles(var_fixed_width.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) handle_block_dimensions(var_p rt.PhpVal, var_block rt.PhpVal) {
	mut var_p_mutated := var_p
	if var_block.array_get(rt.new_string('attrs')).array_isset(rt.new_string('dimensions'))
		&& var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('dimensions')).array_isset(rt.new_string('widthType')) {
		if rt.is_true(rt.identical(rt.new_string('fixed'),
			var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('dimensions')).array_get(rt.new_string('widthType'))))
		{
			this.set_fixed_width_style(var_p_mutated.clone(),
				var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('dimensions')).array_get(rt.new_string('fixedWidth')))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) add_navigation_link_directives(var_block_content rt.PhpVal, var_block rt.PhpVal, var_instance rt.PhpVal) rt.PhpVal {
	mut var_block_content_mutated := var_block_content
	mut var_query_context := if !(rt.get_property(var_instance, 'context').array_get(rt.new_string('query'))).is_null() {
		rt.get_property(var_instance, 'context').array_get(rt.new_string('query'))
	} else {
		rt.new_array()
	}
	mut var_is_product_collection_block := if !(var_query_context.array_get(rt.new_string('isProductCollectionBlock'))).is_null() {
		var_query_context.array_get(rt.new_string('isProductCollectionBlock'))
	} else {
		rt.new_bool(false)
	}
	mut var_query_id := if !(rt.get_property(var_instance, 'context').array_get(rt.new_string('queryId'))).is_null() {
		rt.get_property(var_instance, 'context').array_get(rt.new_string('queryId'))
	} else {
		rt.new_null()
	}
	mut var_parsed_query_id := if !(this.parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('queryId'))).is_null() {
		this.parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('queryId'))
	} else {
		rt.new_null()
	}
	mut var_is_enhanced_pagination_enabled := rt.new_bool(!(rt.is_true(if !(this.parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('forcePageReload'))).is_null() {
		this.parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('forcePageReload'))
	} else {
		rt.new_bool(false)
	})))
	if rt.is_true(var_is_product_collection_block) && rt.is_true(var_is_enhanced_pagination_enabled)
		&& rt.is_true(rt.identical(var_query_id, var_parsed_query_id)) {
		mut var_p := create_wp_html_tag_processor(var_block_content_mutated.clone())
		var_p.next_tag(rt.create_array([
			rt.ArrayItem{ key: 'class_name', val: 'wp-block-query-pagination' },
		]))
		for rt.is_true(var_p.next_tag(rt.new_string('A'))) {
			if rt.is_true(var_p.has_class(rt.new_string('wp-block-query-pagination-next')))
				|| rt.is_true(var_p.has_class(rt.new_string('wp-block-query-pagination-previous'))) {
				var_p.set_attribute(rt.new_string('data-wp-on--click'),
					rt.new_string('woocommerce/product-collection::actions.navigate'))
				var_p.set_attribute(rt.new_string('data-wp-key'), rt.new_string((if rt.is_true(var_p.has_class(rt.new_string('wp-block-query-pagination-next'))) {
					'product-collection-pagination--next'
				} else {
					'product-collection-pagination--previous'
				}).str()))
				var_p.set_attribute(rt.new_string('data-wp-watch'),
					rt.new_string('woocommerce/product-collection::callbacks.prefetch'))
				var_p.set_attribute(rt.new_string('data-wp-on--mouseenter'),
					rt.new_string('woocommerce/product-collection::actions.prefetchOnHover'))
			} else if rt.is_true(var_p.has_class(rt.new_string('page-numbers'))) {
				var_p.set_attribute(rt.new_string('data-wp-on--click'),
					rt.new_string('woocommerce/product-collection::actions.navigate'))
				var_p.set_attribute(rt.new_string('data-wp-key'), rt.new_string(
					'product-collection-pagination-numbers--' +
					(var_p.get_attribute(rt.new_string('aria-label'))).str()))
			}
		}
		return var_p.get_updated_html()
	}
	return var_block_content_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) extend_context_for_inner_blocks(var_context rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})) {
		return var_context_mutated.clone()
	}
	var_context_mutated.array_set('iapi/provider', 'woocommerce/product-collection')
	if !(var_context_mutated.array_isset(rt.new_string('query')))
		|| !(var_context_mutated.array_get(rt.new_string('query')).array_isset(rt.new_string('isProductCollectionBlock')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_context_mutated.array_get(rt.new_string('query')).array_get(rt.new_string('isProductCollectionBlock')))))) {
		return var_context_mutated.clone()
	}
	mut var_is_in_single_product := rt.new_bool(
		var_context_mutated.array_isset(rt.new_string('singleProduct'))
		&& !(!rt.is_true(var_context_mutated.array_get(rt.new_string('postId')))))
	var_context_mutated.array_set('productCollectionLocation', if rt.is_true(var_is_in_single_product) { rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'product' },
			rt.ArrayItem{ key: 'sourceData', val: rt.create_array([
				rt.ArrayItem{ key: 'productId', val: rt.call_function('absint', [
					var_context_mutated.array_get(rt.new_string('postId')),
				]) },
			]) },
		]) } else { this.get_location_context() })
	return var_context_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) get_location_context() rt.PhpVal {
	mut var_location_context := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_location_context)) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{}
		mut iife_result_2 := iife_temp_2.parse_frontend_location_context()
		var_location_context = iife_result_2
	}
	return var_location_context.clone()
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_renderer() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
		render_state:  rt.new_array()
		parsed_block:  rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'set_parsed_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_parsed_block(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_rendering' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.handle_rendering(dispatch_arg_0, dispatch_arg_1))
		}
		'should_prevent_render' {
			return rt.new_bool(this.should_prevent_render())
		}
		'reset_render_state' {
			this.reset_render_state()
			return rt.new_null()
		}
		'enhance_product_collection_with_interactivity' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.enhance_product_collection_with_interactivity(dispatch_arg_0,
				dispatch_arg_1)
		}
		'add_store_notices_fallback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_store_notices_fallback(dispatch_arg_0)
		}
		'render_interactivity_notices_region' {
			return this.render_interactivity_notices_region()
		}
		'get_list_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_list_styles(dispatch_arg_0)
		}
		'set_fixed_width_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_fixed_width_style(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_block_dimensions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_block_dimensions(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_navigation_link_directives' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.add_navigation_link_directives(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'extend_context_for_inner_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.extend_context_for_inner_blocks(dispatch_arg_0)
		}
		'get_location_context' {
			return this.get_location_context()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'render_state' { return this.render_state }
		'parsed_block' { return this.parsed_block }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'render_state' {
			this.render_state = val
			return true
		}
		'parsed_block' {
			this.parsed_block = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
