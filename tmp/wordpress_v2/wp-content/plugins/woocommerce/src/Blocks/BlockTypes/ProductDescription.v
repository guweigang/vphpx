import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-description')
}

fn init_static_automattic_woocommerce_blocks_blocktypes_productdescription() {
	rt.init_static_prop('Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription', 'seen_ids',
		rt.new_array())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	mut var_product_id := rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))
	if rt.get_static_prop('Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription', 'seen_ids').array_isset(var_product_id) {
		if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
			&& rt.is_true(rt.get_constant('WP_DEBUG'))
			&& rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG_DISPLAY')]))
			&& rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY')) {
			return (rt.call_function('__', [
				rt.new_string('[product description rendering halted]'),
				rt.new_string('woocommerce'),
			])).str()
		}
		return ''
	}
	rt.get_static_prop('Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription', 'seen_ids').array_set(var_product_id,
		true)
	mut var_product := rt.call_function('wc_get_product', [var_product_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		rt.get_static_prop('Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription',
			'seen_ids').array_unset(var_product_id)
		return ''
	}
	mut var_description := rt.call_method(var_product, 'get_description', []rt.PhpVal{})
	var_description = rt.call_function('apply_filters', [rt.new_string('the_content'),
		rt.call_function('str_replace', [rt.new_string(']]>'),
			rt.new_string(']]&gt;'), var_description.clone()])])
	if !rt.is_true(var_description) {
		rt.get_static_prop('Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription',
			'seen_ids').array_unset(var_product_id)
		return ''
	}
	rt.get_static_prop('Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription', 'seen_ids').array_unset(var_product_id)
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: 'wc-block-product-description' },
		]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.clone(), var_description.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productdescription(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-description')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductDescription) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
