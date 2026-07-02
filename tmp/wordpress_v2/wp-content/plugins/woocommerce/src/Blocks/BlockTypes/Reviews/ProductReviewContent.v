import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewContent {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-review-content')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewContent) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('commentId'))) {
		return ''
	}
	mut var_comment := rt.call_function('get_comment', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('commentId')),
	])
	mut var_commenter := rt.call_function('wp_get_current_commenter', []rt.PhpVal{})
	mut var_show_pending_links := rt.new_bool(
		var_commenter.array_isset(rt.new_string('comment_author'))
		&& rt.is_true(var_commenter.array_get(rt.new_string('comment_author'))))
	if !rt.is_true(var_comment) {
		return ''
	}
	mut var_args := rt.new_array()
	mut var_comment_text := rt.call_function('get_comment_text', [
		var_comment.clone(), var_args.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment_text)))) {
		return ''
	}
	var_comment_text = rt.call_function('apply_filters', [rt.new_string('comment_text'),
		var_comment_text.clone(), var_comment.clone(), var_args.clone()])
	mut var_moderation_note := rt.new_string('')
	if rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_comment, 'comment_approved'))) {
		if rt.is_true(var_commenter.array_get(rt.new_string('comment_author_email'))) {
			var_moderation_note = rt.call_function('__', [
				rt.new_string('Your review is awaiting moderation.'),
				rt.new_string('woocommerce'),
			])
		} else {
			var_moderation_note = rt.call_function('__', [
				rt.new_string('Your review is awaiting moderation. This is a preview; your review will be visible after it has been approved.'),
				rt.new_string('woocommerce'),
			])
		}
		var_moderation_note = rt.new_string('<p><em class="review-awaiting-moderation">' +
			(rt.call_function('esc_html', [var_moderation_note.clone()])).str() + '</em></p>')
		if rt.is_true(rt.new_bool(!(rt.is_true(var_show_pending_links)))) {
			var_comment_text = rt.call_function('wp_kses', [var_comment_text.clone(),
				rt.new_array()])
		}
	}
	mut var_classes := rt.new_array()
	if var_attributes.array_isset(rt.new_string('textAlign')) {
		var_classes.array_push('has-text-align-' +
			(var_attributes.array_get(rt.new_string('textAlign'))).str())
	}
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		var_classes.array_push('has-link-color')
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				var_classes.clone(),
			]) },
		]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s%3$s</div>'),
		var_wrapper_attributes.clone(), var_moderation_note.clone(),
		var_comment_text.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewContent) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_reviews_productreviewcontent(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewContent {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewContent{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-review-content')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewContent) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewContent) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewContent) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
