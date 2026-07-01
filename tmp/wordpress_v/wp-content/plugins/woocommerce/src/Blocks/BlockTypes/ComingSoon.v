import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ComingSoon {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('coming-soon')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ComingSoon) register_block_type_assets()  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.register_block_type_assets()
	this.register_chunk_translations(rt.create_array([rt.ArrayItem{ key: none, val: this.block_name }]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ComingSoon) initialize()  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_filter', [rt.new_string('enqueue_block_assets'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ComingSoon', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'enqueue_block_assets' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ComingSoon) enqueue_assets(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array, var_content rt.PhpVal, var_block rt.PhpVal)  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_assets(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array', []string{}, var_attributes), var_content.dup(), var_block.dup())
	if var_attributes.array_get('style').array_get('color').array_isset(rt.new_string('background')) {
		rt.call_function('wp_add_inline_style', [rt.new_string('wc-blocks-style'), ':root{--woocommerce-coming-soon-color: ' + (rt.call_function('esc_html', [var_attributes.array_get('style').array_get('color').array_get('background')])).str() + '}'])
	} else if var_attributes.array_isset(rt.new_string('color')) {
		rt.call_function('wp_add_inline_style', [rt.new_string('wc-blocks-style'), ':root{--woocommerce-coming-soon-color: ' + (rt.call_function('esc_html', [var_attributes.array_get('color')])).str() + '}'])
		rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce-coming-soon'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/css/coming-soon-entire-site-deprecated' + if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { '-rtl' } else { '' } + '.css', rt.new_array(), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ComingSoon) enqueue_block_assets()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_current_screen, 'Automattic_WooCommerce_Blocks_BlockTypes_WP_Screen'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_post_id := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('postId')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('postId')])]) } else { rt.new_null() }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	mut var_block_template := rt.call_function('get_block_template', [var_post_id.dup()])
	if rt.is_true(var_block_template) {
		mut var_parsed_blocks := rt.call_function('parse_blocks', [rt.get_property(var_block_template, 'content')])
		{
			mut iter_1 := var_parsed_blocks.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_block := item_1.val
				if rt.is_true(rt.new_bool(var_block.array_isset(rt.new_string('blockName')) && rt.is_true(rt.identical(rt.new_string('woocommerce/coming-soon'), var_block.array_get('blockName'))))) {
					if var_block.array_get('attrs').array_isset(rt.new_string('color')) && !(!rt.is_true(var_block.array_get('attrs').array_get('color'))) {
						rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce-coming-soon'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/css/coming-soon-entire-site-deprecated' + if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { '-rtl' } else { '' } + '.css', rt.new_array(), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))])
						break
					}
				}
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ComingSoon) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_comingsoon() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ComingSoon {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ComingSoon{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('coming-soon')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ComingSoon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_block_type_assets' {
			this.register_block_type_assets()
			return rt.new_null()
		}
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'enqueue_assets' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.enqueue_assets(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'enqueue_block_assets' {
			this.enqueue_block_assets()
			return rt.new_null()
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ComingSoon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ComingSoon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_comingsoon_php() {
}
