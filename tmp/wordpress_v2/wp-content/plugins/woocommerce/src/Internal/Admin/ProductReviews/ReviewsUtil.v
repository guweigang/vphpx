import rt

struct Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsUtil.modify_product_review_moderation_urls(var_message rt.PhpVal, var_comment_id rt.PhpVal) rt.PhpVal {
	mut var_message_mutated := var_message
	mut var_comment := rt.call_function('get_comment', [var_comment_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_post_type', [rt.get_property(var_comment, 'comment_post_ID')]), rt.new_string('product'))))) {
		return var_message_mutated.clone()
	}
	mut var_product_reviews_url := rt.call_function('admin_url', [
		rt.new_string('edit.php?post_type=product&page=product-reviews'),
	])
	var_message_mutated = rt.call_function('str_replace', [
		rt.call_function('admin_url', [
			rt.new_string('edit-comments.php?comment_status=moderated#wpbody-content'),
		]),
		rt.new_string(var_product_reviews_url.str() + '&comment_status=moderated'),
		var_message_mutated.clone(),
	])
	return var_message_mutated.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsUtil.comments_clauses_without_product_reviews(var_clauses rt.PhpVal, var_comment_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if !(!rt.is_true(rt.get_property(var_comment_query, 'query_vars').array_get(rt.new_string('post_type')))) {
		mut var_post_type :=
			rt.get_property(var_comment_query, 'query_vars').array_get(rt.new_string('post_type'))
		if !(var_post_type.clone().is_array()) {
			var_post_type = rt.call_function('explode', [rt.new_string(','),
				var_post_type.clone()])
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_string('product'),
			var_post_type.clone(), rt.new_bool(true)]))
		{
			return var_clauses.clone()
		}
	}
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'ID' },
		rt.ArrayItem{ key: none, val: 'parent' }, rt.ArrayItem{ key: none, val: 'parent__in' },
		rt.ArrayItem{ key: none, val: 'post_author__in' }, rt.ArrayItem{
			key: none
			val: 'post_author'
		}, rt.ArrayItem{ key: none, val: 'post_name' }, rt.ArrayItem{ key: none, val: 'type' },
		rt.ArrayItem{ key: none, val: 'type__in' }, rt.ArrayItem{ key: none, val: 'type__not_in' },
		rt.ArrayItem{ key: none, val: 'post_type__in' }, rt.ArrayItem{ key: none, val: 'comment__in' },
		rt.ArrayItem{ key: none, val: 'comment__not_in' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_arg := item_1.val
		if !(!rt.is_true(rt.get_property(var_comment_query, 'query_vars').array_get(var_arg))) {
			return var_clauses.clone()
		}
	}
	if !(!rt.is_true(rt.get_property(var_comment_query, 'query_vars').array_get(rt.new_string('post_id'))))
		&& rt.is_true(rt.greater(rt.call_function('absint', [rt.get_property(var_comment_query, 'query_vars').array_get(rt.new_string('post_id'))]), rt.new_int(0))) {
		if rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [
			rt.call_function('absint',
				[rt.get_property(var_comment_query, 'query_vars').array_get(rt.new_string('post_id'))]),
		])))
		{
			return var_clauses.clone()
		}
	}
	if !(!rt.is_true(rt.get_property(var_comment_query, 'query_vars').array_get(rt.new_string('post__in')))) {
		mut var_post_ids := rt.call_function('wp_parse_id_list', [
			rt.get_property(var_comment_query, 'query_vars').array_get(rt.new_string('post__in')),
		])
		rt.call_function('_prime_post_caches', [var_post_ids.clone(),
			rt.new_bool(false), rt.new_bool(false)])
		mut iter_2 := var_post_ids.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_post_id := item_2.val
			if rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [
				var_post_id.clone(),
			])))
			{
				return var_clauses.clone()
			}
		}
	}
	var_clauses.array_get(rt.new_string('join')) = rt.concat(var_clauses.array_get(rt.new_string('join')), rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb,
		'posts')),
		rt.new_string(' AS wp_posts_to_exclude_reviews ON comment_post_ID = wp_posts_to_exclude_reviews.ID ')))
	var_clauses.array_get(rt.new_string('where')) = rt.concat(var_clauses.array_get(rt.new_string('where')), rt.new_string(
		if rt.is_true(rt.new_string(var_clauses.array_get(rt.new_string('where')).to_string().trim_space())) { ' AND ' } else { '' } +
		" wp_posts_to_exclude_reviews.post_type NOT IN ('product') "))
	return var_clauses.clone()
}

fn create_automattic_woocommerce_internal_admin_productreviews_reviewsutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'modify_product_review_moderation_urls' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsUtil.modify_product_review_moderation_urls(dispatch_arg_0,
				dispatch_arg_1)
		}
		'comments_clauses_without_product_reviews' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsUtil.comments_clauses_without_product_reviews(dispatch_arg_0,
				dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
