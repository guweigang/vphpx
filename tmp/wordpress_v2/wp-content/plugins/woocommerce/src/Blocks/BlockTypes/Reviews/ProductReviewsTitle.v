import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsTitle {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-reviews-title')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsTitle) get_reviews_title(var_attributes rt.PhpVal, var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_show_product_title := rt.new_bool(
		!(!rt.is_true(var_attributes.array_get(rt.new_string('showProductTitle'))))
		&& rt.is_true(var_attributes.array_get(rt.new_string('showProductTitle'))))
	mut var_show_reviews_count := rt.new_bool(
		!(!rt.is_true(var_attributes.array_get(rt.new_string('showReviewsCount'))))
		&& rt.is_true(var_attributes.array_get(rt.new_string('showReviewsCount'))))
	mut var_reviews_count := rt.call_method(var_product_mutated, 'get_review_count', []rt.PhpVal{})
	if rt.is_true(var_show_reviews_count) && rt.is_true(var_show_product_title) {
		return if rt.is_true(rt.identical(rt.new_int(1), var_reviews_count)) { rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('One review for %s'),
					rt.new_string('woocommerce')]),
				rt.call_method(var_product_mutated, 'get_title', []rt.PhpVal{}),
			]) } else { rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%1$s review for %2$s'),
					rt.new_string('%1$s reviews for %2$s'), var_reviews_count.clone(),
					rt.new_string('woocommerce')]),
				rt.call_function('number_format_i18n', [var_reviews_count.clone()]),
				rt.call_method(var_product_mutated, 'get_title', []rt.PhpVal{}),
			]) }
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_show_reviews_count))))
		&& rt.is_true(var_show_product_title) {
		return if rt.is_true(rt.identical(rt.new_int(1), var_reviews_count)) { rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Review for %s'),
					rt.new_string('woocommerce')]),
				rt.call_method(var_product_mutated, 'get_title', []rt.PhpVal{}),
			]) } else { rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Reviews for %s'),
					rt.new_string('woocommerce')]),
				rt.call_method(var_product_mutated, 'get_title', []rt.PhpVal{}),
			]) }
	}
	if rt.is_true(var_show_reviews_count)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_show_product_title)))) {
		return if rt.is_true(rt.identical(rt.new_int(1), var_reviews_count)) { rt.call_function('__', [
				rt.new_string('One review'),
				rt.new_string('woocommerce'),
			]) } else { rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s review'),
					rt.new_string('%s reviews'), var_reviews_count.clone(),
					rt.new_string('woocommerce')]),
				rt.call_function('number_format_i18n', [var_reviews_count.clone()]),
			]) }
	}
	if rt.is_true(rt.identical(rt.new_int(1), var_reviews_count)) {
		return rt.call_function('__', [rt.new_string('Review'),
			rt.new_string('woocommerce')])
	}
	return rt.call_function('__', [rt.new_string('Reviews'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsTitle) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if rt.is_true(rt.call_function('post_password_required', []rt.PhpVal{})) {
		return ''
	}
	mut var_post_id := rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))
	mut var_product := rt.call_function('wc_get_product', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	mut var_align_class_name := rt.new_string((if !rt.is_true(var_attributes.array_get(rt.new_string('textAlign'))) {
		''
	} else {
		rt.concat(rt.new_string('has-text-align-'),
			var_attributes.array_get(rt.new_string('textAlign')))
	}).str())
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_align_class_name }]),
	])
	mut var_reviews_count := rt.call_method(var_product, 'get_review_count', []rt.PhpVal{})
	mut var_tag_name := rt.new_string('h2')
	if var_attributes.array_isset(rt.new_string('level')) {
		var_tag_name = rt.new_string('h' + (var_attributes.array_get(rt.new_string('level'))).str())
	}
	mut var_reviews_title := this.get_reviews_title(var_attributes.clone(), var_product.clone())
	return (rt.call_function('sprintf', [
		rt.new_string('<%1$s id="reviews" %2$s>%3$s</%1$s>'),
		var_tag_name.clone(),
		var_wrapper_attributes.clone(),
		var_reviews_title.clone(),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsTitle) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_reviews_productreviewstitle(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsTitle {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsTitle{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-reviews-title')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsTitle) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_reviews_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_reviews_title(dispatch_arg_0, dispatch_arg_1)
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsTitle) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewsTitle) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
