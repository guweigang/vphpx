import rt
import crypto.md5

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-filters')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'postId' },
		rt.ArrayItem{ key: none, val: 'query' }, rt.ArrayItem{ key: none, val: 'queryId' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	mut var_pagenow := rt.new_null()
	// unsupported statement: Stmt_Global
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes))
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState{}
		return temp.load_store_config(arg_0)
	}(rt.new_string('I acknowledge that using private APIs means my theme or plugin will inevitably break in the next version of WooCommerce'))
	mut var_is_product_archive := rt.new_bool(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_shop', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{}))))
		|| rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_search', []rt.PhpVal{}))
		&& rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', []rt.PhpVal{})))))))
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})))))
		&& rt.is_true(var_is_product_archive)))
	{
		rt.call_function('wp_interactivity_config', [rt.new_string('core/router'),
			rt.create_array([rt.ArrayItem{ key: 'clientNavigationDisabled', val: true }])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-settings')])
	mut var_query_id := if !(rt.get_property(var_block, 'context').array_get('queryId')).is_null() {
		rt.get_property(var_block, 'context').array_get('queryId')
	} else {
		rt.new_int(0)
	}
	mut var_filter_params := this.get_filter_params(var_query_id.dup())
	rt.call_function('wp_interactivity_config', [this.get_full_block_name(),
		rt.create_array([
			rt.ArrayItem{
				key: 'canonicalUrl'
				val: this.get_canonical_url_no_pagination(var_filter_params.dup())
			},
		])])
	mut var_active_filters := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_blocks_product_filters_selected_items'),
		rt.new_array(),
		var_filter_params.dup(),
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		return rt.call_function('strnatcmp', [var_a.array_get('activeLabel'),
			var_b.array_get('activeLabel')])
	}
	rt.call_function('usort', [var_active_filters.dup(), rt.new_closure(closure_1_fn)])
	mut var_block_context := rt.call_function('array_merge', [
		rt.get_property(var_block, 'context'),
		rt.create_array([rt.ArrayItem{ key: 'filterParams', val: var_filter_params },
			rt.ArrayItem{ key: 'activeFilters', val: var_active_filters }]),
	])
	closure_2_fn := fn [var_block_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_parsed_block := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		// unsupported expression: Expr_AssignOp_Concat
		return var_carry.dup()
	}
	mut var_inner_blocks := rt.call_function('array_reduce', [
		rt.get_property(var_block, 'parsed_block').array_get('innerBlocks'),
		rt.new_closure(closure_2_fn),
		rt.new_string(''),
	])
	mut var_interactivity_context := rt.create_array([
		rt.ArrayItem{ key: 'params', val: var_filter_params },
		rt.ArrayItem{ key: 'activeFilters', val: var_active_filters },
	])
	mut var_classes := rt.new_string(rt.new_string(''))
	mut var_styles := rt.new_string(rt.new_string(''))
	mut var_tags :=
		create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(var_content.dup())
	if rt.is_true(var_tags.next_tag(rt.create_array([
		rt.ArrayItem{ key: 'class_name', val: 'wc-block-product-filters' },
	])))
	{
		var_classes = var_tags.get_attribute(rt.new_string('class'))
		var_styles = var_tags.get_attribute(rt.new_string('style'))
	}
	mut var_wrapper_attributes := rt.create_array([
		rt.ArrayItem{ key: 'class', val: var_classes },
		rt.ArrayItem{ key: 'data-wp-interactive', val: this.get_full_block_name() },
		rt.ArrayItem{ key: 'data-wp-watch--scrolling', val: 'callbacks.scrollLimit' },
		rt.ArrayItem{ key: 'data-wp-on--keyup', val: 'actions.closeOverlayOnEscape' },
		rt.ArrayItem{ key: 'data-wp-context', val: rt.call_function('wp_json_encode', [
			var_interactivity_context.dup(),
			rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')),
				rt.get_constant('JSON_HEX_AMP')),
		]) },
		rt.ArrayItem{ key: 'data-wp-class--is-overlay-opened', val: 'context.isOverlayOpened' },
		rt.ArrayItem{ key: 'style', val: var_styles },
	])
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('productCollectionLocation'))) {
		var_wrapper_attributes.array_set('data-wp-router-region',
			this.generate_navigation_id(var_block.dup()))
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_block_wrapper_attributes', [
		var_wrapper_attributes.dup()]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	print(this.get_svg_icon('filter-icon-2'))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Filter products'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Product Filters'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Close'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	print(this.get_svg_icon('close'))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_inner_blocks)
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_full_block_name()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Apply'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters) get_svg_icon(name string) string {
	mut var_icons := rt.create_array([
		rt.ArrayItem{
			key: 'close'
			val: '<path d="M12 13.0607L15.7123 16.773L16.773 15.7123L13.0607 12L16.773 8.28772L15.7123 7.22706L12 10.9394L8.28771 7.22705L7.22705 8.28771L10.9394 12L7.22706 15.7123L8.28772 16.773L12 13.0607Z" fill="currentColor"/>'
		},
		rt.ArrayItem{
			key: 'filter-icon-2'
			val: '<path d="M10 17.5H14V16H10V17.5ZM6 6V7.5H18V6H6ZM8 12.5H16V11H8V12.5Z" fill="currentColor"/>'
		},
	])
	if !(var_icons.array_isset(rt.new_string(name))) {
		return ''
	}
	return (rt.call_function('sprintf', [
		rt.new_string('<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">%s</svg>'),
		var_icons.array_get(name),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters) generate_navigation_id(var_block rt.PhpVal) rt.PhpVal {
	return rt.call_function('sprintf', [rt.new_string('wc-product-filters-%s'),
		rt.new_string(md5.hexhash(rt.call_function('wp_json_encode', [
			rt.get_property(var_block, 'parsed_block').array_get('innerBlocks'),
		]).to_string()))])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters) get_filter_params(var_query_id rt.PhpVal) rt.PhpVal {
	mut var_url_query_params := rt.new_null()
	mut var_query_id_mutated := var_query_id
	mut var_request_uri := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_SERVER').array_get('REQUEST_URI'),
		]) } else { rt.new_string('') }
	mut var_parsed_url := rt.call_function('wp_parse_url', [
		rt.call_function('esc_url_raw', [var_request_uri.dup()]),
	])
	if !rt.is_true(var_parsed_url.array_get('query')) {
		return rt.new_array()
	}
	rt.call_function('parse_str', [var_parsed_url.array_get('query'),
		var_url_query_params.dup()])
	mut var_filter_param_keys := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_ProductFilters_Params.class(),
	]), 'get_param_keys', []rt.PhpVal{})
	closure_3_fn := fn [var_filter_param_keys] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return rt.call_function('in_array', [var_key.dup(), var_filter_param_keys.dup(),
			rt.new_bool(true)])
	}
	return rt.call_function('array_filter', [var_url_query_params.dup(),
		rt.new_closure(closure_3_fn), rt.get_constant('ARRAY_FILTER_USE_KEY')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters) get_block_type_editor_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters) get_canonical_url_no_pagination(var_filter_params rt.PhpVal) rt.PhpVal {
	mut var_filter_params_mutated := var_filter_params
	mut var_canonical_url_no_pagination := if rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) { rt.call_function('get_permalink', []rt.PhpVal{}) } else { rt.call_function('get_pagenum_link', [
			rt.new_int(1),
		]) }
	mut var_decoded_url := rt.call_function('html_entity_decode', [
		var_canonical_url_no_pagination.dup(), rt.get_constant('ENT_QUOTES'),
		rt.call_function('get_bloginfo', [rt.new_string('charset')])])
	mut var_parsed_url := rt.call_function('wp_parse_url', [var_decoded_url.dup()])
	if !rt.is_true(var_filter_params_mutated) || !rt.is_true(var_parsed_url.array_get('query')) {
		return var_decoded_url.dup()
	}
	{
		mut iter_1 := rt.func_array_keys(var_filter_params_mutated.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			var_parsed_url.array_set('query', rt.call_function('remove_query_arg', [
				var_key.dup(),
				var_parsed_url.array_get('query'),
			]))
		}
	}
	mut var_url := rt.new_string(rt.new_string(''))
	if var_parsed_url.array_isset(rt.new_string('scheme')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if var_parsed_url.array_isset(rt.new_string('host')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if var_parsed_url.array_isset(rt.new_string('port')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if var_parsed_url.array_isset(rt.new_string('path')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(!rt.is_true(var_parsed_url.array_get('query'))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if var_parsed_url.array_isset(rt.new_string('fragment')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_url.dup()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productfilters() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-filters')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blockssharedstate() &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_uses_context' {
			return this.get_block_type_uses_context()
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_svg_icon' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_svg_icon(dispatch_arg_0))
		}
		'generate_navigation_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.generate_navigation_id(dispatch_arg_0)
		}
		'get_filter_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_filter_params(dispatch_arg_0)
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
		'get_canonical_url_no_pagination' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_canonical_url_no_pagination(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilters) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productfilters_php() {
	// unsupported statement: Stmt_Declare
}
