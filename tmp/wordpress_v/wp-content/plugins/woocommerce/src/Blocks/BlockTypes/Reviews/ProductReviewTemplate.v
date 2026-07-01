import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewTemplate {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('product-review-template')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewTemplate) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewTemplate) block_product_review_template_render_comments(mut var_comments Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_array, mut var_block Class_WP_Block) string {
	mut var_comments_mutated := var_comments
	mut var_content := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_comments_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_comment := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_comment, 'WP_Comment')))))) {
				continue
			}
			mut var_comment_id := rt.get_property(var_comment, 'comment_ID')
			closure_1_fn := fn [var_comment_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_context := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_context.array_set('commentId', var_comment_id.dup())
	return (var_context).str()
	}
			mut var_filter_block_context := rt.new_closure(closure_1_fn)
			rt.call_function('add_filter', [rt.new_string('render_block_context'), var_filter_block_context.dup(), rt.new_int(1)])
			mut var_block_content := rt.call_method(create_wp_block(rt.get_property(var_block, 'parsed_block')), 'render', [rt.create_array([rt.ArrayItem{ key: 'dynamic', val: false }])])
			rt.call_function('remove_filter', [rt.new_string('render_block_context'), var_filter_block_context.dup(), rt.new_int(1)])
			mut var_children := rt.call_method(var_comment, 'get_children', []rt.PhpVal{})
			mut var_comment_classes := rt.call_function('comment_class', [rt.new_string(''), // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, rt.new_bool(false)])
			if !(!rt.is_true(var_children)) {
				mut var_inner_content := rt.new_string(this.block_product_review_template_render_comments(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_array](var_children), mut var_block))
				// unsupported expression: Expr_AssignOp_Concat
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return (var_content).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewTemplate) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_content_mutated := var_content
	if !rt.is_true(rt.get_property(var_block, 'context').array_get('postId')) {
		return ''
	}
	if rt.is_true(rt.call_function('post_password_required', [rt.get_property(var_block, 'context').array_get('postId')])) {
		return ''
	}
	mut var_comment_query := create_wp_comment_query(rt.call_function('build_comment_query_vars_from_block', [var_block.dup()]))
	mut var_comments := var_comment_query.get_comments()
	if var_comments.dup().array_count() == 0 {
		return ''
	}
	mut var_comment_order := rt.call_function('get_option', [rt.new_string('comment_order')])
	if rt.is_true(rt.identical(rt.new_string('desc'), var_comment_order)) {
		var_comments = rt.call_function('array_reverse', [var_comments.dup()])
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	return (rt.call_function('sprintf', [rt.new_string('<ol %1$s>%2$s</ol>'), var_wrapper_attributes.dup(), this.block_product_review_template_render_comments(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_array](var_comments), mut rt.cast_object_ptr[Class_WP_Block](var_block))])).str()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_WP_Block {
	rt.PhpObjectBase
}

struct Class_WP_Comment_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_reviews_productreviewtemplate() &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('product-review-template')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block() &Class_WP_Block {
	mut obj := &Class_WP_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_comment_query() &Class_WP_Comment_Query {
	mut obj := &Class_WP_Comment_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'block_product_review_template_render_comments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_Block](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.block_product_review_template_render_comments(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Comment_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Comment_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Comment_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_reviews_productreviewtemplate_php() {
	// unsupported statement: Stmt_Declare
}
