import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSaleBadge {
	rt.PhpObjectBase
pub mut:
	block_name  rt.PhpVal = rt.new_string('product-sale-badge')
	api_version rt.PhpVal = rt.new_string('3')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSaleBadge) register_block_type_assets() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSaleBadge) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'query' },
		rt.ArrayItem{ key: none, val: 'queryId' }, rt.ArrayItem{ key: none, val: 'postId' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSaleBadge) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_post_id := if rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')) {
		rt.get_property(var_block, 'context').array_get('postId')
	} else {
		rt.new_string('')
	}
	mut var_product := rt.call_function('wc_get_product', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return rt.new_null()
	}
	mut var_is_on_sale := rt.call_method(var_product, 'is_on_sale', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_on_sale)))) {
		return rt.new_null()
	}
	mut var_classes_and_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_classes_and_styles_by_attributes(arg_0, arg_1, arg_2)
	}(var_attributes.dup(), rt.new_array(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'extra_classes' },
	]))
	mut var_classname := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_classes_by_attributes(arg_0, arg_1)
	}(var_attributes.dup(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'extra_classes' },
	]))
	mut var_align := if var_attributes.array_isset(rt.new_string('align')) {
		var_attributes.array_get('align')
	} else {
		rt.new_string('')
	}
	mut var_sale_text := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_sale_badge_text'),
		rt.call_function('__', [rt.new_string('Sale'), rt.new_string('woocommerce')]),
		var_product.dup(),
	])
	mut var_output := rt.new_string('<div class="wp-block-woocommerce-product-sale-badge ' +
		(rt.call_function('esc_attr', [var_classname.dup()])).str() + '">')
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	return var_output.dup()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productsalebadge() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSaleBadge {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSaleBadge{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-sale-badge')
		api_version:   rt.new_string('3')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils() &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSaleBadge) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_block_type_assets' {
			return this.register_block_type_assets()
		}
		'get_block_type_uses_context' {
			return this.get_block_type_uses_context()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSaleBadge) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'api_version' { return this.api_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSaleBadge) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		'api_version' {
			this.api_version = val
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productsalebadge_php() {
}
