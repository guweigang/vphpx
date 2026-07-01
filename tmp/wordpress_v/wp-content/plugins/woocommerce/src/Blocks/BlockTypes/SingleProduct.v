import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('single-product')
		product_id rt.PhpVal = rt.new_int(0)
		single_product_inner_blocks_names rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct) initialize()  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_filter', [rt.new_string('render_block_context'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'update_context' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('render_block_core/post-excerpt'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'restore_global_post' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('render_block_core/post-title'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'restore_global_post' }]), rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct) restore_global_post(var_block_content rt.PhpVal, var_parsed_block rt.PhpVal, var_block_instance rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.get_property(var_block_instance, 'context').array_isset(rt.new_string('singleProduct')) && rt.is_true(rt.get_property(var_block_instance, 'context').array_get('singleProduct')))) {
		rt.call_function('wp_reset_postdata', []rt.PhpVal{})
	}
	return var_block_content.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct) update_context(var_context rt.PhpVal, var_block rt.PhpVal, var_parent_block rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('woocommerce/single-product'), var_block.array_get('blockName'))) && var_block.array_get('attrs').array_isset(rt.new_string('productId')))) {
		this.product_id = var_block.array_get('attrs').array_get('productId')
		this.single_product_inner_blocks_names = rt.call_function('array_reverse', [this.extract_single_product_inner_block_names(var_block.dup(), rt.new_null())])
	}
	this.replace_post_for_single_product_inner_block(var_block.dup(), var_context_mutated.dup())
	return var_context_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct) extract_single_product_inner_block_names(var_block rt.PhpVal, var_result rt.PhpVal) rt.PhpVal {
	mut var_result_mutated := var_result
	if var_block.array_isset(rt.new_string('blockName')) {
		var_result_mutated.array_push(var_block.array_get('blockName'))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('woocommerce/product-template'), var_block.array_get('blockName'))) || rt.is_true(rt.identical(rt.new_string('core/post-template'), var_block.array_get('blockName'))))) {
		return var_result_mutated.dup()
	}
	if var_block.array_isset(rt.new_string('innerBlocks')) {
		{
			mut iter_1 := var_block.array_get('innerBlocks').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_inner_block := item_1.val
				this.extract_single_product_inner_block_names(var_inner_block.dup(), var_result_mutated.dup())
			}
		}
	}
	return var_result_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct) replace_post_for_single_product_inner_block(var_block rt.PhpVal, var_context rt.PhpVal)  {
	mut var_context_mutated := var_context
	if rt.is_true(this.single_product_inner_blocks_names) {
		mut var_block_index_reversed := rt.call_function('array_search', [var_block.array_get('blockName'), rt.call_function('array_reverse', [this.single_product_inner_blocks_names]), rt.new_bool(true)])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			mut var_block_index := rt.sub(rt.sub(rt.new_int(this.single_product_inner_blocks_names.array_count()), // unsupported expression: Expr_Cast_Int), rt.new_int(1))
			mut var_block_name := var_block.array_get('blockName')
			this.single_product_inner_blocks_names = rt.call_function('array_slice', [this.single_product_inner_blocks_names, rt.new_int(0), var_block_index.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('core/post-excerpt'), var_block_name)) || rt.is_true(rt.identical(rt.new_string('core/post-title'), var_block_name)))) {
				// unsupported statement: Stmt_Global
				mut var_post := rt.call_function('get_post', [this.product_id])
				if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_Blocks_BlockTypes_WP_Post'))) {
					rt.call_function('setup_postdata', [var_post.dup()])
				}
			}
			var_context_mutated.array_set('postId', this.product_id)
			var_context_mutated.array_set('singleProduct', true)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_product := rt.call_function('wc_get_product', [rt.get_property(var_block, 'context').array_get('postId')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_WC_Product')))))) {
		return ''
	}
	rt.call_function('wc_interactivity_api_load_product', [rt.new_string('I acknowledge that using experimental APIs means my theme or plugin will inevitably break in the next version of WooCommerce'), rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
	mut var_interactivity_context := rt.create_array([rt.ArrayItem{ key: 'productId', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'variationId', val: rt.new_null() }])
	mut var_html := create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(var_content.dup())
	if rt.is_true(var_html.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'div' }]))) {
		var_html.set_attribute(rt.new_string('data-wp-interactive'), this.get_full_block_name())
		var_html.set_attribute(rt.new_string('data-wp-context'), rt.new_string('woocommerce/products::' + (rt.call_function('wp_json_encode', [var_interactivity_context.dup(), rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')), rt.get_constant('JSON_HEX_AMP'))])).str()))
	}
	mut var_updated_html := var_html.get_updated_html()
	return (this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.render(var_attributes.dup(), var_updated_html.dup(), var_block.dup())).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_singleproduct() &Class_Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('single-product')
		product_id: rt.new_int(0)
		single_product_inner_blocks_names: rt.new_array()
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'restore_global_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.restore_global_post(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'update_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.update_context(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'extract_single_product_inner_block_names' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.extract_single_product_inner_block_names(dispatch_arg_0, dispatch_arg_1)
		}
		'replace_post_for_single_product_inner_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.replace_post_for_single_product_inner_block(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'product_id' { return this.product_id }
		'single_product_inner_blocks_names' { return this.single_product_inner_blocks_names }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_SingleProduct) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' { this.block_name = val; return true }
		'product_id' { this.product_id = val; return true }
		'single_product_inner_blocks_names' { this.single_product_inner_blocks_names = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_singleproduct_php() {
}
