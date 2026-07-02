import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_product := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('comments_open', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_count := rt.call_method(var_product, 'get_review_count', []rt.PhpVal{})
	if rt.is_true(var_count)
		&& rt.is_true(rt.call_function('wc_review_ratings_enabled', []rt.PhpVal{})) {
		mut var_reviews_title := rt.call_function('sprintf', [
			rt.call_function('esc_html', [
				rt.call_function('_n', [rt.new_string('%1$s review for %2$s'),
					rt.new_string('%1$s reviews for %2$s'), var_count.clone(),
					rt.new_string('woocommerce')]),
			]),
			rt.call_function('esc_html', [
				var_count.clone(),
			]),
			rt.new_string('<span>' + (rt.call_function('get_the_title', []rt.PhpVal{})).str() +
				'</span>'),
		])
		rt.echo_val(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_reviews_title'),
			var_reviews_title.clone(),
			var_count.clone(),
			var_product.clone(),
		]))
	} else {
		rt.call_function('esc_html_e', [rt.new_string('Reviews'),
			rt.new_string('woocommerce')])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('have_comments', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_list_comments', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_product_review_list_args'),
				rt.create_array([
					rt.ArrayItem{ key: 'callback', val: 'woocommerce_comments' },
				]),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.greater(rt.call_function('get_comment_pages_count', []rt.PhpVal{}), rt.new_int(1)))
			&& rt.is_true(rt.call_function('get_option', [rt.new_string('page_comments')])) {
			print('<nav class="woocommerce-pagination">')
			rt.call_function('paginate_comments_links', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_comment_pagination_args'),
					rt.create_array([
						rt.ArrayItem{
							key: 'prev_text'
							val: if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
								'&rarr;'
							} else {
								'&larr;'
							}
						},
						rt.ArrayItem{
							key: 'next_text'
							val: if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
								'&larr;'
							} else {
								'&rarr;'
							}
						},
						rt.ArrayItem{ key: 'type', val: 'list' },
					]),
				]),
			])
			print('</nav>')
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('There are no reviews yet.'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_review_rating_verification_required')]), rt.new_string('no')))
		|| rt.is_true(rt.call_function('wc_customer_bought_product', [rt.new_string(''), rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.call_method(var_product, 'get_id', []rt.PhpVal{})])) {
		// unsupported statement: Stmt_InlineHTML
		mut var_commenter := rt.call_function('wp_get_current_commenter', []rt.PhpVal{})
		mut var_comment_form := {
			'title_reply':         if rt.is_true(rt.call_function('have_comments', []rt.PhpVal{})) { rt.call_function('esc_html__', [
					rt.new_string('Add a review'),
					rt.new_string('woocommerce'),
				]) } else { rt.call_function('sprintf', [
					rt.call_function('esc_html__', [
						rt.new_string('Be the first to review &ldquo;%s&rdquo;'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('get_the_title', []rt.PhpVal{}),
				]) }
			'title_reply_to':      rt.call_function('esc_html__', [
				rt.new_string('Leave a Reply to %s'),
				rt.new_string('woocommerce'),
			])
			'title_reply_before':  rt.new_string('<span id="reply-title" class="comment-reply-title" role="heading" aria-level="3">')
			'title_reply_after':   rt.new_string('</span>')
			'comment_notes_after': rt.new_string('')
			'label_submit':        rt.call_function('esc_html__', [
				rt.new_string('Submit'),
				rt.new_string('woocommerce'),
			])
			'logged_in_as':        rt.new_string('')
			'comment_field':       rt.new_string('')
		}
		mut var_name_email_required := rt.new_bool((rt.call_function('get_option', [
			rt.new_string('require_name_email'),
			rt.new_int(1),
		])).to_bool())
		mut var_fields := {
			'author': {
				'label':        rt.call_function('__', [rt.new_string('Name'),
					rt.new_string('woocommerce')])
				'type':         rt.new_string('text')
				'value':        var_commenter.array_get(rt.new_string('comment_author'))
				'required':     var_name_email_required
				'autocomplete': rt.new_string('name')
			}
			'email':  {
				'label':        rt.call_function('__', [rt.new_string('Email'),
					rt.new_string('woocommerce')])
				'type':         rt.new_string('email')
				'value':        var_commenter.array_get(rt.new_string('comment_author_email'))
				'required':     var_name_email_required
				'autocomplete': rt.new_string('email')
			}
		}
		var_comment_form['fields'] = rt.new_array()
		for var_key, var_field in var_fields {
			mut var_field_html := rt.new_string('<p class="comment-form-' +
				(rt.call_function('esc_attr', [rt.new_string(key)])).str() + '">')
			var_field_html = rt.concat(var_field_html, rt.new_string('<label for="' +
				(rt.call_function('esc_attr', [rt.new_string(key)])).str() + '">' +
				(rt.call_function('esc_html', [var_field.array_get(rt.new_string('label'))])).str()))
			if rt.is_true(var_field.array_get(rt.new_string('required'))) {
				var_field_html = rt.concat(var_field_html,
					rt.new_string('&nbsp;<span class="required">*</span>'))
			}
			var_field_html = rt.concat(var_field_html, rt.new_string('</label><input id="' +
				(rt.call_function('esc_attr', [rt.new_string(key)])).str() + '" name="' +
				(rt.call_function('esc_attr', [rt.new_string(key)])).str() + '" type="' +
				(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('type'))])).str() +
				'" autocomplete="' +
				(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('autocomplete'))])).str() +
				'" value="' +
				(rt.call_function('esc_attr', [var_field.array_get(rt.new_string('value'))])).str() +
				'" size="30" ' +
				if rt.is_true(var_field.array_get(rt.new_string('required'))) { 'required' } else { '' } +
				' /></p>'))
			var_comment_form.array_get_mut('fields').array_set(key, var_field_html.clone())
		}
		mut var_account_page_url := rt.call_function('wc_get_page_permalink', [
			rt.new_string('myaccount'),
		])
		if rt.is_true(var_account_page_url) {
			var_comment_form['must_log_in'] = '<p class="must-log-in">' +
				(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('You must be %1$slogged in%2$s to post a review.'), rt.new_string('woocommerce')]), rt.new_string('<a href="' + (rt.call_function('esc_url', [var_account_page_url.clone()])).str() +
				'">'), rt.new_string('</a>')])).str() + '</p>'
		}
		if rt.is_true(rt.call_function('wc_review_ratings_enabled', []rt.PhpVal{})) {
			var_comment_form['comment_field'] =
				'<div class="comment-form-rating"><label for="rating" id="comment-form-rating-label">' +
				(rt.call_function('esc_html__', [rt.new_string('Your rating'), rt.new_string('woocommerce')])).str() +
				if rt.is_true(rt.call_function('wc_review_ratings_required', []rt.PhpVal{})) { '&nbsp;<span class="required">*</span>' } else { '' } +
				'</label><select name="rating" id="rating" required>\n\t\t\t\t\t\t<option value="">' +
				(rt.call_function('esc_html__', [rt.new_string('Rate&hellip;'), rt.new_string('woocommerce')])).str() +
				'</option>\n\t\t\t\t\t\t<option value="5">' +
				(rt.call_function('esc_html__', [rt.new_string('Perfect'), rt.new_string('woocommerce')])).str() +
				'</option>\n\t\t\t\t\t\t<option value="4">' +
				(rt.call_function('esc_html__', [rt.new_string('Good'), rt.new_string('woocommerce')])).str() +
				'</option>\n\t\t\t\t\t\t<option value="3">' +
				(rt.call_function('esc_html__', [rt.new_string('Average'), rt.new_string('woocommerce')])).str() +
				'</option>\n\t\t\t\t\t\t<option value="2">' +
				(rt.call_function('esc_html__', [rt.new_string('Not that bad'), rt.new_string('woocommerce')])).str() +
				'</option>\n\t\t\t\t\t\t<option value="1">' +
				(rt.call_function('esc_html__', [rt.new_string('Very poor'), rt.new_string('woocommerce')])).str() +
				'</option>\n\t\t\t\t\t</select></div>'
		}
		var_comment_form['comment_field'] = rt.concat(var_comment_form['comment_field'], rt.new_string(
			'<p class="comment-form-comment"><label for="comment">' +
			(rt.call_function('esc_html__', [rt.new_string('Your review'), rt.new_string('woocommerce')])).str() +
			'&nbsp;<span class="required">*</span></label><textarea id="comment" name="comment" cols="45" rows="8" required></textarea></p>'))
		rt.call_function('comment_form', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_product_review_comment_form_args'),
				rt.create_array_from_native_map(var_comment_form),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Only logged in customers who have purchased this product may leave a review.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
