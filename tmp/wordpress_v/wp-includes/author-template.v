module wp_includes

import rt

fn get_the_author(deprecated string) rt.PhpVal {
	mut var_deprecated := deprecated
	mut var_authordata := rt.new_null()
	if !(deprecated == '') {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.1.0')])
	}
	return rt.call_function('apply_filters', [rt.new_string('the_author'), if rt.is_true(rt.new_bool(var_authordata.clone().is_object())) {
		rt.get_property(var_authordata, 'display_name')
	} else {
		rt.new_string('')
	}])
}

fn the_author(deprecated string, deprecated_echo bool) rt.PhpVal {
	mut var_deprecated := deprecated
	mut var_deprecated_echo := deprecated_echo
	if !(deprecated == '') {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.1.0')])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true),
		rt.new_bool(deprecated_echo)))))
	{
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('1.5.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Use %s instead if you do not want the value echoed.'),
				]),
				rt.new_string('<code>get_the_author()</code>'),
			])])
	}
	if var_deprecated_echo {
		rt.echo_val(get_the_author(''))
	}
	return get_the_author('')
}

fn get_the_modified_author(var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_post := var_post_arg
	mut var_last_id := rt.new_null()
	mut var_last_user := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.new_null()
	}
	var_last_id = rt.call_function('get_post_meta', [rt.get_property(var_post, 'ID'),
		rt.new_string('_edit_last'), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_last_id)))) {
		return rt.new_null()
	}
	var_last_user = rt.call_function('get_userdata', [var_last_id.clone()])
	return rt.call_function('apply_filters', [rt.new_string('the_modified_author'), if rt.is_true(var_last_user) {
		rt.get_property(var_last_user, 'display_name')
	} else {
		rt.new_string('')
	}])
}

fn the_modified_author() {
	rt.echo_val(get_the_modified_author(rt.new_null()))
}

fn get_the_author_meta(field string, user_id bool) rt.PhpVal {
	mut var_field := field
	mut var_user_id := user_id
	mut var_original_user_id := false
	mut var_authordata := rt.new_null()
	mut var_value := rt.new_null()
	var_original_user_id = var_user_id
	if !var_user_id {
		var_user_id = (if !(rt.get_property(var_authordata, 'ID')).is_null() {
			rt.get_property(var_authordata, 'ID')
		} else {
			rt.new_int(0)
		}).to_bool()
	} else {
		var_authordata = rt.call_function('get_userdata', [rt.new_bool(var_user_id)])
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string(var_field.str()),
		rt.create_array([rt.ArrayItem{ key: none, val: 'login' },
			rt.ArrayItem{ key: none, val: 'pass' }, rt.ArrayItem{ key: none, val: 'nicename' },
			rt.ArrayItem{ key: none, val: 'email' }, rt.ArrayItem{ key: none, val: 'url' },
			rt.ArrayItem{ key: none, val: 'registered' }, rt.ArrayItem{
				key: none
				val: 'activation_key'
			}, rt.ArrayItem{ key: none, val: 'status' }]),
		rt.new_bool(true)]))
	{
		var_field = 'user_' + var_field
	}
	var_value = if !(rt.get_property(var_authordata,
		'{"nodeType":"Expr_Variable","line":181,"name":"field"}')).is_null() {
		rt.get_property(var_authordata, '{"nodeType":"Expr_Variable","line":181,"name":"field"}')
	} else {
		rt.new_string('')
	}
	return rt.call_function('apply_filters', [
		rt.new_string('get_the_author_${var_field}'),
		var_value.clone(),
		rt.new_bool(var_user_id),
		rt.new_bool(var_original_user_id).clone(),
	])
}

fn the_author_meta(field string, user_id bool) {
	mut var_field := field
	mut var_user_id := user_id
	mut var_author_meta := rt.new_null()
	var_author_meta = get_the_author_meta(var_field, var_user_id)
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('the_author_${var_field}'),
		var_author_meta.clone(),
		rt.new_bool(var_user_id),
	]))
}

fn get_the_author_link(use_title_attr bool) rt.PhpVal {
	mut var_use_title_attr := use_title_attr
	mut var_authordata := rt.new_null()
	mut var_author_url := rt.new_null()
	mut var_author_display_name := rt.new_null()
	mut var_author_title := rt.new_null()
	mut var_link := rt.new_null()
	if rt.is_true(get_the_author_meta('url', false)) {
		var_author_url = get_the_author_meta('url', false)
		var_author_display_name = get_the_author('')
		var_author_title = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Visit %s&#8217;s website')]),
			var_author_display_name.clone(),
		])
		var_link = rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s"%2$s rel="author external">%3$s</a>'),
			rt.call_function('esc_url', [var_author_url.clone()]),
			if var_use_title_attr {
				' title="' + (rt.call_function('esc_attr', [var_author_title.clone()])).str() + '"'
			} else {
				''
			},
			var_author_display_name.clone(),
		])
		return rt.call_function('apply_filters', [rt.new_string('the_author_link'),
			var_link.clone(), var_author_url.clone(), var_authordata.clone()])
	} else {
		return get_the_author('')
	}
	return rt.new_null()
}

fn the_author_link(use_title_attr bool) {
	mut var_use_title_attr := use_title_attr
	rt.echo_val(get_the_author_link(use_title_attr))
}

fn get_the_author_posts() i64 {
	mut var_post := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return 0
	}
	return rt.new_int((rt.call_function('count_user_posts', [
		rt.get_property(var_post, 'post_author'),
		rt.get_property(var_post, 'post_type'),
	])).to_i64())
}

fn the_author_posts() {
	print(get_the_author_posts().str())
}

fn get_the_author_posts_link() string {
	mut var_authordata := rt.new_null()
	mut var_author := rt.new_null()
	mut var_title := rt.new_null()
	mut var_link := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_authordata.clone().is_object()))))) {
		return ''
	}
	var_author = get_the_author('')
	var_title = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Posts by %s')]),
		var_author.clone(),
	])
	var_link = rt.call_function('sprintf', [
		rt.new_string('<a href="%1$s" rel="author">%2$s</a>'),
		rt.call_function('esc_url', [
			get_author_posts_url(rt.get_property(var_authordata, 'ID'), rt.get_property(var_authordata,
				'user_nicename')),
		]),
		var_author.clone(),
	])
	return (rt.call_function('apply_filters', [rt.new_string('the_author_posts_link'),
		var_link.clone(), var_author.clone(), var_title.clone()])).str()
}

fn the_author_posts_link(deprecated string) {
	mut var_deprecated := deprecated
	if !(deprecated == '') {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.1.0')])
	}
	print(get_the_author_posts_link())
}

fn get_author_posts_url(var_author_id_arg rt.PhpVal, author_nicename string) rt.PhpVal {
	mut var_author_nicename := author_nicename
	mut var_author_id := var_author_id_arg
	mut var_wp_rewrite := rt.new_null()
	mut var_link := rt.new_null()
	mut var_file := rt.new_null()
	mut var_user := rt.new_null()
	var_author_id = rt.new_int(var_author_id.to_i64())
	var_link = rt.call_method(var_wp_rewrite, 'get_author_permastruct', []rt.PhpVal{})
	if !rt.is_true(var_link) {
		var_file = rt.call_function('home_url', [rt.new_string('/')])
		var_link = rt.new_string(var_file.str() + '?author=' + var_author_id.str())
	} else {
		if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_author_nicename.str()))) {
			var_user = rt.call_function('get_userdata', [var_author_id.clone()])
			if !(!rt.is_true(rt.get_property(var_user, 'user_nicename'))) {
				var_author_nicename = (rt.get_property(var_user, 'user_nicename')).str()
			}
		}
		var_link = rt.call_function('str_replace', [rt.new_string('%author%'),
			rt.new_string(var_author_nicename.str()), var_link.clone()])
		var_link = rt.call_function('home_url', [
			rt.call_function('user_trailingslashit', [var_link.clone()]),
		])
	}
	var_link = rt.call_function('apply_filters', [rt.new_string('author_link'),
		var_link.clone(), var_author_id.clone(), rt.new_string(var_author_nicename.str())])
	return var_link.clone()
}

fn wp_list_authors(args string) string {
	mut var_args := args
	mut var_wpdb := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_return := ''
	mut var_query_args := rt.new_null()
	mut var_authors := rt.new_null()
	mut var_post_counts := rt.new_null()
	mut var_post_counts_query := rt.new_null()
	mut var_row := rt.new_null()
	mut var_author_id := rt.new_null()
	mut var_posts := rt.new_null()
	mut var_author := rt.new_null()
	mut var_name := rt.new_null()
	mut var_link := rt.new_null()
	mut var_alt := rt.new_null()
	var_defaults = {
		'orderby':       rt.new_string('name')
		'order':         rt.new_string('ASC')
		'number':        rt.new_string('')
		'optioncount':   rt.new_bool(false)
		'exclude_admin': rt.new_bool(true)
		'show_fullname': rt.new_bool(false)
		'hide_empty':    rt.new_bool(true)
		'feed':          rt.new_string('')
		'feed_image':    rt.new_string('')
		'feed_type':     rt.new_string('')
		'echo':          rt.new_bool(true)
		'style':         rt.new_string('list')
		'html':          rt.new_bool(true)
		'exclude':       rt.new_string('')
		'include':       rt.new_string('')
	}
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string(args),
		rt.create_array_from_native_map(var_defaults)])
	var_return = ''
	var_query_args = rt.call_function('wp_array_slice_assoc', [
		var_parsed_args.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'orderby' },
			rt.ArrayItem{ key: none, val: 'order' },
			rt.ArrayItem{ key: none, val: 'number' },
			rt.ArrayItem{ key: none, val: 'exclude' },
			rt.ArrayItem{ key: none, val: 'include' },
		])])
	var_query_args.array_set('fields', 'ids')
	var_query_args = rt.call_function('apply_filters', [
		rt.new_string('wp_list_authors_args'),
		var_query_args.clone(),
		var_parsed_args.clone(),
	])
	var_authors = rt.call_function('get_users', [var_query_args.clone()])
	var_post_counts = rt.call_function('apply_filters', [
		rt.new_string('pre_wp_list_authors_post_counts_query'),
		rt.new_bool(false),
		var_parsed_args.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_post_counts.clone().is_array()))))) {
		var_post_counts = rt.new_array()
		var_post_counts_query = rt.call_method(var_wpdb, 'get_results', [
			rt.new_string(
				rt.concat(rt.concat(rt.new_string('SELECT DISTINCT post_author, COUNT(ID) AS count\n\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\tWHERE ')) +
				(rt.call_function('get_private_posts_cap_sql', [rt.new_string('post')])).str() +
				'\n\t\t\tGROUP BY post_author'),
		])
		{
			mut iter_1 := rt.cast_array(var_post_counts_query).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_row_shadow := item_1.val
				var_post_counts.array_set(rt.get_property(var_row_shadow, 'post_author'), rt.get_property(var_row_shadow,
					'count'))
			}
		}
	}
	{
		mut iter_1 := var_authors.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_author_id_shadow := item_1.val
			var_posts = if !(var_post_counts.array_get(var_author_id_shadow)).is_null() {
				var_post_counts.array_get(var_author_id_shadow)
			} else {
				rt.new_int(0)
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_posts))))
				&& rt.is_true(var_parsed_args.array_get('hide_empty'))))
			{
				continue
			}
			var_author = rt.call_function('get_userdata', [var_author_id_shadow.clone()])
			if rt.is_true(rt.new_bool(rt.is_true(var_parsed_args.array_get('exclude_admin'))
				&& rt.is_true(rt.identical(rt.new_string('admin'), rt.get_property(var_author, 'display_name')))))
			{
				continue
			}
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(rt.is_true(var_parsed_args.array_get('show_fullname'))
				&& rt.is_true(rt.get_property(var_author, 'first_name'))))
				&& rt.is_true(rt.get_property(var_author, 'last_name'))))
			{
				var_name = rt.call_function('sprintf', [
					rt.call_function('_x', [rt.new_string('%1$s %2$s'),
						rt.new_string('Display name based on first name and last name')]),
					rt.get_property(var_author, 'first_name'),
					rt.get_property(var_author, 'last_name'),
				])
			} else {
				var_name = rt.get_property(var_author, 'display_name')
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get('html'))))) {
				var_return = var_return + var_name.str() + ', '
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('list'), var_parsed_args.array_get('style'))) {
				var_return = var_return + '<li>'
			}
			var_link = rt.call_function('sprintf', [
				rt.new_string('<a href="%1$s">%2$s</a>'),
				rt.call_function('esc_url', [
					get_author_posts_url(rt.get_property(var_author, 'ID'), rt.get_property(var_author,
						'user_nicename')),
				]),
				var_name.clone(),
			])
			if !(!rt.is_true(var_parsed_args.array_get('feed_image')))
				|| !(!rt.is_true(var_parsed_args.array_get('feed'))) {
				var_link = rt.concat(var_link, rt.new_string(' '))
				if !rt.is_true(var_parsed_args.array_get('feed_image')) {
					var_link = rt.concat(var_link, rt.new_string('('))
				}
				var_link = rt.concat(var_link, rt.new_string('<a href="' +
					(rt.call_function('get_author_feed_link', [rt.get_property(var_author, 'ID'), var_parsed_args.array_get('feed_type')])).str() +
					'"'))
				var_alt = rt.new_string('')
				if !(!rt.is_true(var_parsed_args.array_get('feed'))) {
					var_alt = rt.new_string(' alt="' +
						(rt.call_function('esc_attr', [var_parsed_args.array_get('feed')])).str() +
						'"')
					var_name = var_parsed_args.array_get('feed')
				}
				var_link = rt.concat(var_link, rt.new_string('>'))
				if !(!rt.is_true(var_parsed_args.array_get('feed_image'))) {
					var_link = rt.concat(var_link, rt.new_string('<img src="' +
						(rt.call_function('esc_url', [var_parsed_args.array_get('feed_image')])).str() +
						'" style="border: none;"' + var_alt.str() + ' />'))
				} else {
					var_link = rt.concat(var_link, var_name)
				}
				var_link = rt.concat(var_link, rt.new_string('</a>'))
				if !rt.is_true(var_parsed_args.array_get('feed_image')) {
					var_link = rt.concat(var_link, rt.new_string(')'))
				}
			}
			if rt.is_true(var_parsed_args.array_get('optioncount')) {
				var_link = rt.concat(var_link, rt.new_string(' (' + var_posts.str() + ')'))
			}
			var_return = var_return + var_link.str()
			var_return = var_return +
				if rt.is_true(rt.identical(rt.new_string('list'), var_parsed_args.array_get('style'))) { '</li>' } else { ', ' }
		}
	}
	var_return = var_return.trim_right(' \t\n\r')
	if rt.is_true(var_parsed_args.array_get('echo')) {
		print(var_return)
	} else {
		return var_return
	}
	return ''
}

fn is_multi_author() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_is_multi_author := rt.new_null()
	mut var_rows := rt.new_null()
	var_is_multi_author = rt.call_function('get_transient', [
		rt.new_string('is_multi_author'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_is_multi_author)) {
		var_rows = rt.cast_array(rt.call_method(var_wpdb, 'get_col', [
			rt.concat(rt.concat(rt.new_string('SELECT DISTINCT post_author FROM '), rt.get_property(var_wpdb,
				'posts')),
				rt.new_string(" WHERE post_type = 'post' AND post_status = 'publish' LIMIT 2")),
		]))
		var_is_multi_author = rt.new_int(if 1 < var_rows.clone().array_count() { 1 } else { 0 })
		rt.call_function('set_transient', [rt.new_string('is_multi_author'),
			var_is_multi_author.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('is_multi_author'),
		var_is_multi_author.to_bool()])
}

fn __clear_multi_author_cache() {
	rt.call_function('delete_transient', [rt.new_string('is_multi_author')])
}

pub fn init_wp_includes_author_template_php() {
}
