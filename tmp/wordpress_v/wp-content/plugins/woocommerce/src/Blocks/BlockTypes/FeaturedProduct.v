import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedProduct {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('featured-product')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedProduct) get_item(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_id := rt.call_function('absint', [if !(var_attributes.array_get('productId')).is_null() { var_attributes.array_get('productId') } else { rt.new_int(0) }])
	mut var_product := rt.call_function('wc_get_product', [var_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) || rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_product'), var_id.dup()]))))))))) {
		return rt.new_null()
	}
	return var_product.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedProduct) get_item_title(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	return rt.call_method(var_product_mutated, 'get_title', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedProduct) get_item_image(var_product rt.PhpVal, size string) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_image := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_method(var_product_mutated, 'get_image_id', []rt.PhpVal{})) {
		var_image = rt.call_function('wp_get_attachment_image_url', [rt.call_method(var_product_mutated, 'get_image_id', []rt.PhpVal{}), rt.new_string(size)])
	} else if rt.is_true(rt.call_method(var_product_mutated, 'get_parent_id', []rt.PhpVal{})) {
		mut var_parent_product := rt.call_function('wc_get_product', [rt.call_method(var_product_mutated, 'get_parent_id', []rt.PhpVal{})])
		if rt.is_true(var_parent_product) {
			var_image = rt.call_function('wp_get_attachment_image_url', [rt.call_method(var_parent_product, 'get_image_id', []rt.PhpVal{}), rt.new_string(size)])
		}
	}
	return var_image.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedProduct) render_attributes(var_product rt.PhpVal, var_attributes rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_output := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_attributes.dup().array_isset(rt.new_string('editMode')))) && rt.is_true(rt.new_bool(var_attributes.array_get('editMode').is_bool())))) {
		mut var_legacy_title := rt.call_function('sprintf', [rt.new_string('<h2 class="wc-block-featured-product__title">%s</h2>'), rt.call_function('wp_kses_post', [rt.call_method(var_product_mutated, 'get_title', []rt.PhpVal{})])])
		if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		// unsupported expression: Expr_AssignOp_Concat
		if rt.is_true(rt.new_bool(!(var_attributes.array_isset(rt.new_string('showDesc'))) || rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('showDesc')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
			mut var_desc_str := rt.call_function('sprintf', [rt.new_string('<div class="wc-block-featured-product__description">%s</div>'), rt.call_function('wc_format_content', [rt.call_function('wp_kses_post', [if rt.is_true(rt.call_method(var_product_mutated, 'get_short_description', []rt.PhpVal{})) { rt.call_method(var_product_mutated, 'get_short_description', []rt.PhpVal{}) } else { rt.call_function('wc_trim_string', [rt.call_method(var_product_mutated, 'get_description', []rt.PhpVal{}), rt.new_int(400)]) }])])])
			// unsupported expression: Expr_AssignOp_Concat
		}
		if rt.is_true(rt.new_bool(!(var_attributes.array_isset(rt.new_string('showPrice'))) || rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('showPrice')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
			mut var_price_str := rt.call_function('sprintf', [rt.new_string('<div class="wc-block-featured-product__price">%s</div>'), rt.call_function('wp_kses_post', [rt.call_method(var_product_mutated, 'get_price_html', []rt.PhpVal{})])])
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_output.dup()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_featuredproduct() &Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedProduct {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedProduct{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('featured-product')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_featureditem() &Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedProduct) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_item_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_title(dispatch_arg_0)
		}
		'get_item_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_item_image(dispatch_arg_0, dispatch_arg_1)
		}
		'render_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.render_attributes(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedProduct) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedProduct) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' { this.block_name = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_featuredproduct_php() {
	// unsupported statement: Stmt_Declare
}
