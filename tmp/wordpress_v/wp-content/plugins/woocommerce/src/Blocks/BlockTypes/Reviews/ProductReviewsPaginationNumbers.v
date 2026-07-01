import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNumbers {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-reviews-pagination-numbers')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNumbers) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_content_mutated := var_content
	if !rt.is_true(rt.get_property(var_block, 'context').array_get('postId')) {
		return ''
	}
	mut var_comment_vars := rt.call_function('build_comment_query_vars_from_block', [
		var_block.dup(),
	])
	mut var_total := rt.get_property(create_automattic_woocommerce_blocks_blocktypes_reviews_wp_comment_query(var_comment_vars.dup()),
		'max_num_pages')
	mut var_current := if !(!rt.is_true(var_comment_vars.array_get('paged'))) {
		var_comment_vars.array_get('paged')
	} else {
		rt.new_null()
	}
	var_content_mutated = rt.call_function('paginate_comments_links', [
		rt.create_array([rt.ArrayItem{ key: 'total', val: var_total },
			rt.ArrayItem{ key: 'current', val: var_current },
			rt.ArrayItem{ key: 'prev_next', val: false }, rt.ArrayItem{ key: 'echo', val: false }]),
	])
	if !rt.is_true(var_content_mutated) {
		return ''
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.dup(), var_content_mutated.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNumbers) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNumbers) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_Comment_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_reviews_productreviewspaginationnumbers() &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNumbers {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNumbers{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-reviews-pagination-numbers')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_reviews_wp_comment_query() &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_Comment_Query {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_Comment_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNumbers) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNumbers) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNumbers) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_Comment_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_Comment_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_Comment_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_reviews_productreviewspaginationnumbers_php() {
	// unsupported statement: Stmt_Declare
}
