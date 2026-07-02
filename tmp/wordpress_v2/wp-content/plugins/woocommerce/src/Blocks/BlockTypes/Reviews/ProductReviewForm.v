import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewForm {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-review-form')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewForm) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	if rt.is_true(rt.call_function('post_password_required', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId')),
	]))
	{
		return ''
	}
	mut var_product := rt.call_function('wc_get_product', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_review_rating_verification_required'),
	]), rt.new_string('no')))))
	{
		mut var_is_user_logged_in := rt.call_function('is_user_logged_in', []rt.PhpVal{})
		mut var_product_has_reviews := rt.greater(rt.call_method(var_product, 'get_review_count',
			[]rt.PhpVal{}), rt.new_int(0))
		mut var_no_reviews_message := rt.new_string((if rt.is_true(var_product_has_reviews) {
			''
		} else {
				(rt.call_function('esc_html__', [rt.new_string('There are no reviews yet.'), rt.new_string('woocommerce')])).str() +
				' '
		}).str())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_user_logged_in)))) {
			mut var_account_page_url := rt.call_function('wc_get_page_permalink', [
				rt.new_string('myaccount'),
			])
			mut var_login_message := if rt.is_true(var_account_page_url) { rt.call_function('sprintf', [
					rt.call_function('esc_html__', [rt.new_string('%1$sLog in%2$s'),
						rt.new_string('woocommerce')]),
					rt.new_string(' <a href="' + (rt.call_function('esc_url', [var_account_page_url.clone()])).str() + '">'),
					rt.new_string('</a>'),
				]) } else { rt.new_string('') }
			return '<p class="woocommerce-verification-required">' + var_no_reviews_message.str() +
				(rt.call_function('esc_html__', [rt.new_string('Only logged in customers who have purchased this product may leave a review.'), rt.new_string('woocommerce')])).str() +
				var_login_message.str() + '</p>'
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_customer_bought_product', [
			rt.new_string(''),
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		])))))
		{
			return '<p class="woocommerce-verification-required">' + var_no_reviews_message.str() +
				(rt.call_function('esc_html__', [rt.new_string('Only customers who have purchased this product may leave a review.'), rt.new_string('woocommerce')])).str() +
				'</p>'
		}
	}
	mut var_interactivity_state := rt.new_array()
	mut var_interactivity_config := rt.create_array([
		rt.ArrayItem{ key: 'reviewRatingEnabled', val: rt.call_function('wc_review_ratings_enabled',
			[]rt.PhpVal{}) },
	])
	mut var_classes := rt.create_array([
		rt.ArrayItem{ key: none, val: 'comment-respond' },
	])
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
	mut var_commenter := rt.call_function('wp_get_current_commenter', []rt.PhpVal{})
	mut var_comment_form := rt.create_array([
		rt.ArrayItem{
			key: 'title_reply'
			val: if rt.is_true(rt.greater(rt.call_method(var_product, 'get_review_count', []rt.PhpVal{}), rt.new_int(0))) { rt.call_function('esc_html__', [
					rt.new_string('Add a review'),
					rt.new_string('woocommerce'),
				]) } else { rt.call_function('sprintf', [
					rt.call_function('esc_html__', [
						rt.new_string('Be the first to review &ldquo;%s&rdquo;'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('esc_html', [
						rt.call_function('get_the_title', [
							rt.get_property(var_block, 'context').array_get(rt.new_string('postId')),
						]),
					]),
				]) }
		},
		rt.ArrayItem{ key: 'title_reply_to', val: rt.call_function('esc_html__', [
			rt.new_string('Leave a Reply to %s'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{
			key: 'title_reply_before'
			val: '<span id="reply-title" class="comment-reply-title" role="heading" aria-level="3">'
		},
		rt.ArrayItem{ key: 'title_reply_after', val: '</span>' },
		rt.ArrayItem{ key: 'comment_notes_after', val: '' },
		rt.ArrayItem{ key: 'label_submit', val: rt.call_function('esc_html__', [
			rt.new_string('Submit'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'logged_in_as', val: '' },
		rt.ArrayItem{ key: 'comment_field', val: '' },
	])
	mut var_name_email_required := rt.new_bool((rt.call_function('get_option', [
		rt.new_string('require_name_email'),
		rt.new_int(1),
	])).to_bool())
	mut var_fields := rt.create_array([
		rt.ArrayItem{ key: 'author', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Name'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{
				key: 'value'
				val: var_commenter.array_get(rt.new_string('comment_author'))
			},
			rt.ArrayItem{ key: 'required', val: var_name_email_required },
			rt.ArrayItem{ key: 'autocomplete', val: 'name' },
		]) },
		rt.ArrayItem{ key: 'email', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Email'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'email' },
			rt.ArrayItem{
				key: 'value'
				val: var_commenter.array_get(rt.new_string('comment_author_email'))
			},
			rt.ArrayItem{ key: 'required', val: var_name_email_required },
			rt.ArrayItem{ key: 'autocomplete', val: 'email' },
		]) },
	])
	var_comment_form.array_set('fields', rt.new_array())
	mut iter_1 := var_fields.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		mut var_key := item_1.key
		mut var_field_html := rt.new_string('<p class="comment-form-' +
			(rt.call_function('esc_attr', [var_key.clone()])).str() + '">')
		var_field_html = rt.concat(var_field_html, rt.new_string('<label for="' +
			(rt.call_function('esc_attr', [var_key.clone()])).str() + '">' +
			(rt.call_function('esc_html', [var_field.array_get(rt.new_string('label'))])).str()))
		if rt.is_true(var_field.array_get(rt.new_string('required'))) {
			var_field_html = rt.concat(var_field_html,
				rt.new_string('&nbsp;<span class="required">*</span>'))
		}
		var_field_html = rt.concat(var_field_html, rt.new_string('</label><input id="' +
			(rt.call_function('esc_attr', [var_key.clone()])).str() + '" name="' +
			(rt.call_function('esc_attr', [var_key.clone()])).str() + '" type="' +
			(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('type'))])).str() +
			'" autocomplete="' +
			(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('autocomplete'))])).str() +
			'" value="' +
			(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('value'))])).str() +
			'" size="30" ' +
			if rt.is_true(var_field.array_get(rt.new_string('required'))) { 'required' } else { '' } +
			' /></p>'))
		var_comment_form.array_get_mut('fields').array_set(var_key, var_field_html.clone())
	}
	var_account_page_url = rt.call_function('wc_get_page_permalink', [
		rt.new_string('myaccount'),
	])
	if rt.is_true(var_account_page_url) {
		var_comment_form.array_set('must_log_in', '<p class="must-log-in">' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('You must be %1$slogged in%2$s to post a review.'), rt.new_string('woocommerce')]), rt.new_string('<a href="' + (rt.call_function('esc_url', [var_account_page_url.clone()])).str() +
			'">'), rt.new_string('</a>')])).str() + '</p>')
	}
	if rt.is_true(rt.call_function('wc_review_ratings_enabled', []rt.PhpVal{})) {
		var_interactivity_state.array_set('selectedStar', '')
		var_interactivity_state.array_set('hoveredStar', '0')
		var_interactivity_state.array_set('ratingError', '')
		var_interactivity_state.array_set('hasRatingError', false)
		var_interactivity_config.array_set('i18nRequiredRatingText', rt.call_function('esc_attr__', [
			rt.new_string('Please select a rating'),
			rt.new_string('woocommerce'),
		]))
		var_interactivity_config.array_set('reviewRatingRequired', rt.call_function('wc_review_ratings_required',
			[]rt.PhpVal{}))
		var_comment_form.array_set('comment_field',
			'<div class="comment-form-rating"><label for="rating-selector" id="comment-form-rating-label">' +
			(rt.call_function('esc_html__', [rt.new_string('Your rating'), rt.new_string('woocommerce')])).str() +
			if rt.is_true(rt.call_function('wc_review_ratings_required', []rt.PhpVal{})) { '&nbsp;<span class="required">*</span>' } else { '' } +
			'</label><select name="rating" id="rating-selector" data-wp-init="callbacks.hideRatingSelector" data-wp-bind--value="state.selectedStar" ' +
			if rt.is_true(rt.call_function('wc_review_ratings_required', []rt.PhpVal{})) { ' required' } else { '' } +
			'>\n\t\t\t\t<option value="">' +
			(rt.call_function('esc_html__', [rt.new_string('Rate&hellip;'), rt.new_string('woocommerce')])).str() +
			'</option>\n\t\t\t\t<option value="5">' +
			(rt.call_function('esc_html__', [rt.new_string('Perfect'), rt.new_string('woocommerce')])).str() +
			'</option>\n\t\t\t\t<option value="4">' +
			(rt.call_function('esc_html__', [rt.new_string('Good'), rt.new_string('woocommerce')])).str() +
			'</option>\n\t\t\t\t<option value="3">' +
			(rt.call_function('esc_html__', [rt.new_string('Average'), rt.new_string('woocommerce')])).str() +
			'</option>\n\t\t\t\t<option value="2">' +
			(rt.call_function('esc_html__', [rt.new_string('Not that bad'), rt.new_string('woocommerce')])).str() +
			'</option>\n\t\t\t\t<option value="1">' +
			(rt.call_function('esc_html__', [rt.new_string('Very poor'), rt.new_string('woocommerce')])).str() +
			'</option>\n\t\t\t</select>' +
			'<p role="radiogroup" aria-labelledby="comment-form-rating-label" class="stars-wrapper" data-wp-init="callbacks.showRatingStars" hidden data-wp-bind--aria-invalid="state.hasRatingError"' +
			if rt.is_true(rt.call_function('wc_review_ratings_required', []rt.PhpVal{})) { ' aria-required="true"' } else { '' } +
			' aria-describedby="rating-error">' +
			(this.render_stars()).str() + if rt.is_true(rt.call_function('wc_review_ratings_required', []rt.PhpVal{})) { '<small id="rating-error" data-wp-text="state.ratingError" class="rating-error" data-wp-bind--hidden="!state.hasRatingError" role="alert"></small>' } else { '' } +
			'</p></div>')
	}
	var_comment_form.array_get(rt.new_string('comment_field')) = rt.concat(var_comment_form.array_get(rt.new_string('comment_field')), rt.new_string(
		'<p class="comment-form-comment"><label for="comment">' +
		(rt.call_function('esc_html__', [rt.new_string('Your review'), rt.new_string('woocommerce')])).str() +
		'&nbsp;<span class="required">*</span></label><textarea id="comment" name="comment" cols="45" rows="8" required></textarea></p>'))
	rt.call_function('add_filter', [rt.new_string('comment_form_defaults'),
		rt.new_string('post_comments_form_block_form_defaults')])
	rt.call_function('ob_start', []rt.PhpVal{})
	print('<div id="review_form_wrapper" data-wp-interactive="woocommerce/product-reviews"><div id="review_form">')
	rt.call_function('comment_form', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_product_review_comment_form_args'),
			var_comment_form.clone(),
		]),
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId')),
	])
	print('</div></div>')
	mut var_form := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.call_function('remove_filter', [rt.new_string('comment_form_defaults'),
		rt.new_string('post_comments_form_block_form_defaults')])
	var_form = rt.call_function('str_replace', [rt.new_string('class="comment-respond"'),
		var_wrapper_attributes.clone(), var_form.clone()])
	mut var_p :=
		create_automattic_woocommerce_blocks_blocktypes_reviews_wp_html_tag_processor(var_form.clone())
	if rt.is_true(var_p.next_tag(rt.new_string('form'))) {
		var_p.set_attribute(rt.new_string('data-wp-on--submit'),
			rt.new_string('actions.handleSubmit'))
	}
	if !(!rt.is_true(var_interactivity_state)) {
		rt.call_function('wp_interactivity_state', [
			rt.new_string('woocommerce/product-reviews'),
			var_interactivity_state.clone(),
		])
	}
	if !(!rt.is_true(var_interactivity_config)) {
		rt.call_function('wp_interactivity_config', [
			rt.new_string('woocommerce/product-reviews'),
			var_interactivity_config.clone(),
		])
	}
	return (var_p.get_updated_html()).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewForm) render_stars() rt.PhpVal {
	rt.call_function('ob_start', []rt.PhpVal{})
	print('<span class="stars">')
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(6)))) { break
		 }
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%d of 5 star'),
					rt.new_string('%d of 5 stars'), var_i.clone(),
					rt.new_string('woocommerce')]),
				var_i.clone(),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_interactivity_data_wp_context', [
			rt.create_array([rt.ArrayItem{ key: 'starValue', val: var_i }]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.post_inc(var_i)
	}
	print('</span>')
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_reviews_productreviewform(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewForm {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewForm{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-review-form')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_reviews_wp_html_tag_processor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewForm) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'render_stars' {
			return this.render_stars()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewForm) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_ProductReviewForm) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Reviews_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
