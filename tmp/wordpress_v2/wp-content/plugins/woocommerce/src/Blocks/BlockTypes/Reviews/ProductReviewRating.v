import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewRating {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-review-rating')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewRating) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewRating) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('commentId'))) {
		return ''
	}
	mut var_rating := rt.new_int(rt.call_function('get_comment_meta', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('commentId')),
		rt.new_string('rating'),
		rt.new_bool(true),
	]).to_i64())
	mut var_html := rt.new_string('')
	if rt.is_true(rt.less(rt.new_int(0), var_rating)) {
		mut var_label := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Rated %s out of 5'),
				rt.new_string('woocommerce')]),
			var_rating.clone(),
		])
		var_html = rt.call_function('sprintf', [
			rt.new_string('<div class="wc-block-product-review-rating__container">\n\t\t\t\t\t<div class="wc-block-product-review-rating__stars" role="img" aria-label="%1$s">\n\t\t\t\t\t\t%2$s\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t\t'),
			rt.call_function('esc_attr', [var_label.clone()]),
			rt.call_function('wc_get_star_rating_html', [var_rating.clone()]),
		])
	}
	return (rt.call_function('sprintf', [
		rt.new_string('<div %1$s>\n\t\t\t\t%2$s\n\t\t\t</div>'),
		rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{}),
		var_html.clone(),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewRating) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_reviews_productreviewrating(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewRating {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewRating{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-review-rating')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewRating) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_style' {
			return this.get_block_type_style()
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewRating) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewRating) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
