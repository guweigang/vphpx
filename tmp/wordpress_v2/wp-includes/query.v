import rt
import crypto.md5

fn get_query_var(query_var string, default_value string) rt.PhpVal {
	mut var_query_var := query_var
	mut var_default_value := default_value
	mut var_wp_query := rt.new_null()
	return rt.call_method(var_wp_query, 'get', [rt.new_string(query_var),
		rt.new_string(default_value)])
}

fn get_queried_object() rt.PhpVal {
	mut var_wp_query := rt.new_null()
	return rt.call_method(var_wp_query, 'get_queried_object', []rt.PhpVal{})
}

fn get_queried_object_id() rt.PhpVal {
	mut var_wp_query := rt.new_null()
	return rt.call_method(var_wp_query, 'get_queried_object_id', []rt.PhpVal{})
}

fn set_query_var(var_query_var rt.PhpVal, var_value rt.PhpVal) {
	mut var_wp_query := rt.new_null()
	rt.call_method(var_wp_query, 'set', [var_query_var.clone(),
		var_value.clone()])
}

fn query_posts(var_query rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	var_GLOBALS.array_set('wp_query', create_wp_query())
	return rt.call_method(var_GLOBALS.array_get(rt.new_string('wp_query')), 'query', [
		var_query.clone(),
	])
}

fn wp_reset_query() {
	mut var_GLOBALS := rt.new_null()
	var_GLOBALS.array_set('wp_query', var_GLOBALS.array_get(rt.new_string('wp_the_query')))
	wp_reset_postdata()
}

fn wp_reset_postdata() {
	mut var_wp_query := rt.new_null()
	if !var_wp_query.is_null() {
		rt.call_method(var_wp_query, 'reset_postdata', []rt.PhpVal{})
	}
}

fn is_archive() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_archive', []rt.PhpVal{})).to_bool()
}

fn is_post_type_archive(post_types string) bool {
	mut var_post_types := post_types
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_post_type_archive', [
		rt.new_string(post_types),
	])).to_bool()
}

fn is_attachment(attachment string) bool {
	mut var_attachment := attachment
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_attachment', [rt.new_string(attachment)])).to_bool()
}

fn is_author(author string) bool {
	mut var_author := author
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_author', [rt.new_string(author)])).to_bool()
}

fn is_category(category string) bool {
	mut var_category := category
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_category', [rt.new_string(category)])).to_bool()
}

fn is_tag(tag string) bool {
	mut var_tag := tag
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_tag', [rt.new_string(tag)])).to_bool()
}

fn is_tax(taxonomy string, term string) bool {
	mut var_taxonomy := taxonomy
	mut var_term := term
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_tax', [rt.new_string(taxonomy),
		rt.new_string(term)])).to_bool()
}

fn is_date() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_date', []rt.PhpVal{})).to_bool()
}

fn is_day() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_day', []rt.PhpVal{})).to_bool()
}

fn is_feed(feeds string) bool {
	mut var_feeds := feeds
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_feed', [rt.new_string(feeds)])).to_bool()
}

fn is_comment_feed() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_comment_feed', []rt.PhpVal{})).to_bool()
}

fn is_front_page() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_front_page', []rt.PhpVal{})).to_bool()
}

fn is_home() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_home', []rt.PhpVal{})).to_bool()
}

fn is_privacy_policy() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_privacy_policy', []rt.PhpVal{})).to_bool()
}

fn is_month() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_month', []rt.PhpVal{})).to_bool()
}

fn is_page(page string) bool {
	mut var_page := page
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_page', [rt.new_string(page)])).to_bool()
}

fn is_paged() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_paged', []rt.PhpVal{})).to_bool()
}

fn is_preview() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_preview', []rt.PhpVal{})).to_bool()
}

fn is_robots() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_robots', []rt.PhpVal{})).to_bool()
}

fn is_favicon() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_favicon', []rt.PhpVal{})).to_bool()
}

fn is_search() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_search', []rt.PhpVal{})).to_bool()
}

fn is_single(post string) bool {
	mut var_post := post
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_single', [rt.new_string(post)])).to_bool()
}

fn is_singular(post_types string) bool {
	mut var_post_types := post_types
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_singular', [rt.new_string(post_types)])).to_bool()
}

fn is_time() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_time', []rt.PhpVal{})).to_bool()
}

fn is_trackback() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_trackback', []rt.PhpVal{})).to_bool()
}

fn is_year() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_year', []rt.PhpVal{})).to_bool()
}

fn is_404() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_404', []rt.PhpVal{})).to_bool()
}

fn is_embed() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_embed', []rt.PhpVal{})).to_bool()
}

fn is_main_query() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.'),
			]),
			rt.new_string('6.1.0')])
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('pre_get_posts'), rt.call_function('current_filter',
		[]rt.PhpVal{})))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('In %1$s, use the %2$s method, not the %3$s function. See %4$s.'),
				]),
				rt.new_string('<code>pre_get_posts</code>'),
				rt.new_string('<code>WP_Query->is_main_query()</code>'),
				rt.new_string('<code>is_main_query()</code>'),
				rt.call_function('__', [
					rt.new_string('https://developer.wordpress.org/reference/functions/is_main_query/'),
				]),
			]),
			rt.new_string('3.7.0')])
	}
	return (rt.call_method(var_wp_query, 'is_main_query', []rt.PhpVal{})).to_bool()
}

fn have_posts() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		return false
	}
	return (rt.call_method(var_wp_query, 'have_posts', []rt.PhpVal{})).to_bool()
}

fn in_the_loop() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		return false
	}
	return (rt.get_property(var_wp_query, 'in_the_loop')).to_bool()
}

fn rewind_posts() {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		return
	}
	rt.call_method(var_wp_query, 'rewind_posts', []rt.PhpVal{})
}

fn the_post() {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		return
	}
	rt.call_method(var_wp_query, 'the_post', []rt.PhpVal{})
}

fn have_comments() bool {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		return false
	}
	return (rt.call_method(var_wp_query, 'have_comments', []rt.PhpVal{})).to_bool()
}

fn the_comment() {
	mut var_wp_query := rt.new_null()
	if !(!var_wp_query.is_null()) {
		return
	}
	rt.call_method(var_wp_query, 'the_comment', []rt.PhpVal{})
}

fn wp_old_slug_redirect() {
	mut var_post_type := rt.new_null()
	mut var_id := rt.new_null()
	mut var_link := rt.new_null()
	if is_404()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), get_query_var('name', ''))))) {
		if rt.is_true(get_query_var('post_type', '')) {
			var_post_type = get_query_var('post_type', '')
		} else if rt.is_true(get_query_var('attachment', '')) {
			var_post_type = rt.new_string('attachment')
		} else if rt.is_true(get_query_var('pagename', '')) {
			var_post_type = rt.new_string('page')
		} else {
			var_post_type = rt.new_string('post')
		}
		if rt.is_true(rt.new_bool(var_post_type.clone().is_array())) {
			if var_post_type.clone().array_count() > 1 {
				return
			}
			var_post_type = rt.call_function('reset', [var_post_type.clone()])
		}
		if rt.is_true(rt.call_function('is_post_type_hierarchical', [
			var_post_type.clone()]))
		{
			return
		}
		var_id = _find_post_by_old_slug(var_post_type.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
			var_id = _find_post_by_old_date(var_post_type.clone())
		}
		var_id = rt.call_function('apply_filters', [
			rt.new_string('old_slug_redirect_post_id'),
			var_id.clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
			return
		}
		var_link = rt.call_function('get_permalink', [var_id.clone()])
		if rt.is_true(rt.greater(get_query_var('paged', ''), rt.new_int(1))) {
			var_link = rt.call_function('user_trailingslashit', [
				rt.new_string((rt.call_function('trailingslashit', [var_link.clone()])).str() +
					'page/' + (get_query_var('paged', '')).str()),
			])
		} else if rt.is_true(rt.new_bool(is_embed())) {
			var_link = rt.call_function('user_trailingslashit', [
				rt.new_string((rt.call_function('trailingslashit', [var_link.clone()])).str() +
					'embed'),
			])
		}
		var_link = rt.call_function('apply_filters', [
			rt.new_string('old_slug_redirect_url'),
			var_link.clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_link)))) {
			return
		}
		rt.call_function('wp_redirect', [var_link.clone(), rt.new_int(301)])
		exit(0)
	}
}

fn _find_post_by_old_slug(var_post_type rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query := rt.new_null()
	mut var_key := ''
	mut var_last_changed := rt.new_null()
	mut var_cache_key := ''
	mut var_cache := rt.new_null()
	mut var_id := rt.new_null()
	var_query = rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT post_id FROM '), rt.get_property(var_wpdb,
			'postmeta')), rt.new_string(', ')), rt.get_property(var_wpdb, 'posts')),
			rt.new_string(" WHERE ID = post_id AND post_type = %s AND meta_key = '_wp_old_slug' AND meta_value = %s")),
		var_post_type.clone(),
		get_query_var('name', ''),
	])
	if rt.is_true(get_query_var('year', '')) {
		var_query = rt.concat(var_query, rt.call_method(var_wpdb, 'prepare', [
			rt.new_string(' AND YEAR(post_date) = %d'),
			get_query_var('year', ''),
		]))
	}
	if rt.is_true(get_query_var('monthnum', '')) {
		var_query = rt.concat(var_query, rt.call_method(var_wpdb, 'prepare', [
			rt.new_string(' AND MONTH(post_date) = %d'),
			get_query_var('monthnum', ''),
		]))
	}
	if rt.is_true(get_query_var('day', '')) {
		var_query = rt.concat(var_query, rt.call_method(var_wpdb, 'prepare', [
			rt.new_string(' AND DAYOFMONTH(post_date) = %d'),
			get_query_var('day', ''),
		]))
	}
	var_key = md5.hexhash(var_query.clone().to_string())
	var_last_changed = rt.call_function('wp_cache_get_last_changed', [
		rt.new_string('posts'),
	])
	var_cache_key = 'find_post_by_old_slug:${var_key}'
	var_cache = rt.call_function('wp_cache_get_salted', [rt.new_string(var_cache_key.str()).clone(),
		rt.new_string('post-queries'), var_last_changed.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cache)))) {
		var_id = var_cache.clone()
	} else {
		var_id = rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			var_query.clone()])).to_i64())
		rt.call_function('wp_cache_set_salted', [rt.new_string(var_cache_key.str()).clone(),
			var_id.clone(), rt.new_string('post-queries'), var_last_changed.clone()])
	}
	return var_id.clone()
}

fn _find_post_by_old_date(var_post_type rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_date_query := ''
	mut var_id := rt.new_null()
	mut var_query := rt.new_null()
	mut var_key := ''
	mut var_last_changed := rt.new_null()
	mut var_cache_key := ''
	mut var_cache := rt.new_null()
	var_date_query = ''
	if rt.is_true(get_query_var('year', '')) {
		var_date_query = var_date_query +(rt.call_method(var_wpdb, 'prepare', [rt.new_string(' AND YEAR(pm_date.meta_value) = %d'), get_query_var('year', '')])).str()
	}
	if rt.is_true(get_query_var('monthnum', '')) {
		var_date_query = var_date_query +(rt.call_method(var_wpdb, 'prepare', [rt.new_string(' AND MONTH(pm_date.meta_value) = %d'), get_query_var('monthnum', '')])).str()
	}
	if rt.is_true(get_query_var('day', '')) {
		var_date_query = var_date_query +(rt.call_method(var_wpdb, 'prepare', [rt.new_string(' AND DAYOFMONTH(pm_date.meta_value) = %d'), get_query_var('day', '')])).str()
	}
	var_id = rt.new_int(0)
	if var_date_query.len > 0 && var_date_query != '0' {
		var_query = rt.call_method(var_wpdb, 'prepare', [
			rt.new_string((
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS pm_date, ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(" WHERE ID = post_id AND post_type = %s AND meta_key = '_wp_old_date' AND post_name = %s")) +
				var_date_query).str()),
			var_post_type.clone(),
			get_query_var('name', ''),
		])
		var_key = md5.hexhash(var_query.clone().to_string())
		var_last_changed = rt.call_function('wp_cache_get_last_changed', [
			rt.new_string('posts'),
		])
		var_cache_key = 'find_post_by_old_date:${var_key}'
		var_cache = rt.call_function('wp_cache_get_salted', [
			rt.new_string(var_cache_key.str()).clone(), rt.new_string('post-queries'),
			var_last_changed.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cache)))) {
			var_id = var_cache.clone()
		} else {
			var_id = rt.new_int((rt.call_method(var_wpdb, 'get_var', [
				var_query.clone()])).to_i64())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
				var_id = rt.new_int((rt.call_method(var_wpdb, 'get_var', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.new_string((
							rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(', ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS pm_slug, ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(" AS pm_date WHERE ID = pm_slug.post_id AND ID = pm_date.post_id AND post_type = %s AND pm_slug.meta_key = '_wp_old_slug' AND pm_slug.meta_value = %s AND pm_date.meta_key = '_wp_old_date'")) +
							var_date_query).str()),
						var_post_type.clone(),
						get_query_var('name', ''),
					]),
				])).to_i64())
			}
			rt.call_function('wp_cache_set_salted', [rt.new_string(var_cache_key.str()).clone(),
				var_id.clone(), rt.new_string('post-queries'),
				var_last_changed.clone()])
		}
	}
	return var_id.clone()
}

fn setup_postdata(var_post rt.PhpVal) bool {
	mut var_wp_query := rt.new_null()
	if !(!rt.is_true(var_wp_query))
		&& rt.is_true(rt.new_bool(rt.instance_of(var_wp_query, 'WP_Query'))) {
		return (rt.call_method(var_wp_query, 'setup_postdata', [
			var_post.clone()])).to_bool()
	}
	return false
}

fn generate_postdata(var_post rt.PhpVal) bool {
	mut var_wp_query := rt.new_null()
	if !(!rt.is_true(var_wp_query))
		&& rt.is_true(rt.new_bool(rt.instance_of(var_wp_query, 'WP_Query'))) {
		return (rt.call_method(var_wp_query, 'generate_postdata', [
			var_post.clone()])).to_bool()
	}
	return false
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
