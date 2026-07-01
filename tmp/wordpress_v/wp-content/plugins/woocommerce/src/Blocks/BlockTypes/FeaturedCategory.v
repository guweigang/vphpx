import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedCategory {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('featured-category')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedCategory) get_block_type_attributes() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem.get_block_type_attributes(), rt.create_array([rt.ArrayItem{ key: 'textColor', val: this.get_schema_string() }, rt.ArrayItem{ key: 'fontSize', val: this.get_schema_string() }, rt.ArrayItem{ key: 'lineHeight', val: this.get_schema_string() }, rt.ArrayItem{ key: 'style', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedCategory) get_item(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_id := rt.call_function('absint', [if !(var_attributes.array_get('categoryId')).is_null() { var_attributes.array_get('categoryId') } else { rt.new_int(0) }])
	mut var_category := rt.call_function('get_term', [var_id.dup(), rt.new_string('product_cat')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_category)))) || rt.is_true(rt.call_function('is_wp_error', [var_category.dup()])))) {
		return rt.new_null()
	}
	return var_category.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedCategory) get_item_title(var_category rt.PhpVal) rt.PhpVal {
	mut var_category_mutated := var_category
	return rt.get_property(var_category_mutated, 'name')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedCategory) get_item_image(var_category rt.PhpVal, size string) rt.PhpVal {
	mut var_category_mutated := var_category
	mut var_image := rt.new_string(rt.new_string(''))
	mut var_image_id := rt.call_function('get_term_meta', [rt.get_property(var_category_mutated, 'term_id'), rt.new_string('thumbnail_id'), rt.new_bool(true)])
	if rt.is_true(var_image_id) {
		var_image = rt.call_function('wp_get_attachment_image_url', [var_image_id.dup(), rt.new_string(size)])
	}
	return var_image.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedCategory) render_attributes(var_category rt.PhpVal, var_attributes rt.PhpVal) rt.PhpVal {
	mut var_category_mutated := var_category
	mut var_output := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_attributes.dup().array_isset(rt.new_string('editMode')))) && rt.is_true(rt.new_bool(var_attributes.array_get('editMode').is_bool())))) {
		mut var_legacy_title := rt.call_function('sprintf', [rt.new_string('<h2 class="wc-block-featured-category__title">%s</h2>'), rt.call_function('wp_kses_post', [rt.get_property(var_category_mutated, 'name')])])
		// unsupported expression: Expr_AssignOp_Concat
		if rt.is_true(rt.new_bool(!(var_attributes.array_isset(rt.new_string('showDesc'))) || rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('showDesc')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
			mut var_desc_str := rt.call_function('sprintf', [rt.new_string('<div class="wc-block-featured-category__description">%s</div>'), rt.call_function('wc_format_content', [rt.call_function('wp_kses_post', [rt.get_property(var_category_mutated, 'description')])])])
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_output.dup()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_featuredcategory() &Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedCategory {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedCategory{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('featured-category')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_featureditem() &Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedCategory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_attributes' {
			return this.get_block_type_attributes()
		}
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedCategory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedCategory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_featuredcategory_php() {
	// unsupported statement: Stmt_Declare
}
