import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNext {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-reviews-pagination-next')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNext) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))) {
		return ''
	}
	mut var_comment_vars := rt.call_function('build_comment_query_vars_from_block', [
		var_block.clone(),
	])
	mut var_max_page := rt.get_property(create_automattic_woocommerce_blocks_blocktypes_reviews_wp_comment_query(var_comment_vars.clone()),
		'max_num_pages')
	mut var_default_label := rt.call_function('__', [rt.new_string('Newer Reviews'),
		rt.new_string('woocommerce')])
	mut var_label := if var_attributes.array_isset(rt.new_string('label'))
		&& !(!rt.is_true(var_attributes.array_get(rt.new_string('label')))) {
		var_attributes.array_get(rt.new_string('label'))
	} else {
		var_default_label
	}
	mut var_pagination_arrow := this.get_pagination_arrow(var_block.clone())
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return (rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})).str()
	}
	mut var_filter_link_attributes := rt.new_closure(closure_1_fn)
	rt.call_function('add_filter', [rt.new_string('next_comments_link_attributes'),
		var_filter_link_attributes.clone()])
	if rt.is_true(var_pagination_arrow) {
		var_label = rt.concat(var_label, var_pagination_arrow)
	}
	mut var_next_comments_link := rt.call_function('get_next_comments_link', [
		var_label.clone(), var_max_page.clone(), if !(var_comment_vars.array_get(rt.new_string('paged'))).is_null() {
			var_comment_vars.array_get(rt.new_string('paged'))
		} else {
			rt.new_null()
		}])
	rt.call_function('remove_filter', [rt.new_string('next_posts_link_attributes'),
		var_filter_link_attributes.clone()])
	if !(!var_next_comments_link.is_null()) {
		return ''
	}
	return var_next_comments_link.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNext) get_pagination_arrow(var_block rt.PhpVal) rt.PhpVal {
	mut var_arrow_map := rt.create_array([rt.ArrayItem{ key: 'none', val: '' },
		rt.ArrayItem{ key: 'arrow', val: '→' }, rt.ArrayItem{ key: 'chevron', val: '»' }])
	if !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('reviews/paginationArrow'))))
		&& !(!rt.is_true(var_arrow_map.array_get(rt.get_property(var_block, 'context').array_get(rt.new_string('reviews/paginationArrow'))))) {
		mut var_arrow_attribute :=
			rt.get_property(var_block, 'context').array_get(rt.new_string('reviews/paginationArrow'))
		mut var_arrow :=
			var_arrow_map.array_get(rt.get_property(var_block, 'context').array_get(rt.new_string('reviews/paginationArrow')))
		mut var_arrow_classes :=
			rt.new_string('wp-block-woocommerce-product-reviews-pagination-next-arrow is-arrow-${var_arrow_attribute.to_string()}')
		return rt.new_string("<span class='${var_arrow_classes.to_string()}' aria-hidden='true'>${var_arrow.to_string()}</span>")
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNext) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNext) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_Comment_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_reviews_productreviewspaginationnext(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNext {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNext{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-reviews-pagination-next')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_reviews_wp_comment_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_Comment_Query {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_Comment_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNext) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_pagination_arrow' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_pagination_arrow(dispatch_arg_0)
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNext) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsPaginationNext) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
