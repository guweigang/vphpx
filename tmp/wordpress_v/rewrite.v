module wp_includes

import rt

const global_const_ep_none = 0
const global_const_ep_permalink = 1
const global_const_ep_attachment = 2
const global_const_ep_date = 4
const global_const_ep_year = 8
const global_const_ep_month = 16
const global_const_ep_day = 32
const global_const_ep_root = 64
const global_const_ep_comments = 128
const global_const_ep_search = 256
const global_const_ep_categories = 512
const global_const_ep_tags = 1024
const global_const_ep_authors = 2048
const global_const_ep_pages = 4096
const global_const_ep_all_archives = global_const_ep_date | global_const_ep_year | global_const_ep_month | global_const_ep_day | global_const_ep_categories | global_const_ep_tags | global_const_ep_authors
const global_const_ep_all = global_const_ep_permalink | global_const_ep_attachment | global_const_ep_root | global_const_ep_comments | global_const_ep_search | global_const_ep_pages | global_const_ep_all_archives

fn add_rewrite_rule(var_regex rt.PhpVal, var_query rt.PhpVal, after string) {
	mut var_after := after
	mut var_wp_rewrite := rt.new_null()
	rt.call_method(var_wp_rewrite, 'add_rule', [var_regex.clone(),
		var_query.clone(), rt.new_string(after)])
}

fn add_rewrite_tag(var_tag rt.PhpVal, var_regex rt.PhpVal, query string) {
	mut var_query := query
	mut var_wp_rewrite := rt.new_null()
	mut var_wp := rt.new_null()
	mut var_qv := ''
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.create_array_from_list(var_tag).to_string().len < 3
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('%'), var_tag.array_get(0)))))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('%'), var_tag.array_get(rt.create_array_from_list(var_tag).to_string().len - 1)))))))
	{
		return
	}
	if var_query == '' {
		var_qv = rt.create_array_from_list(var_tag).to_string().trim_space()
		rt.call_method(var_wp, 'add_query_var', [rt.new_string(var_qv.str()).clone()])
		var_query = var_qv + '='
	}
	rt.call_method(var_wp_rewrite, 'add_rewrite_tag', [
		rt.create_array_from_list(var_tag),
		var_regex.clone(),
		rt.new_string(var_query.str()),
	])
}

fn remove_rewrite_tag(var_tag rt.PhpVal) {
	mut var_wp_rewrite := rt.new_null()
	rt.call_method(var_wp_rewrite, 'remove_rewrite_tag', [
		rt.create_array_from_list(var_tag),
	])
}

fn add_permastruct(var_name rt.PhpVal, var_struct rt.PhpVal, var_args_arg rt.PhpVal) {
	mut var_args := var_args_arg
	mut var_wp_rewrite := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_args).is_array()))))) {
		var_args = {
			'with_front': var_args
		}
	}
	if rt.is_true(rt.identical(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(4))) {
		var_args.array_set('ep_mask', rt.call_function('func_get_arg', [
			rt.new_int(3)]))
	}
	rt.call_method(var_wp_rewrite, 'add_permastruct', [var_name.clone(),
		var_struct.clone(), rt.create_array_from_native_map(var_args)])
}

fn remove_permastruct(var_name rt.PhpVal) {
	mut var_wp_rewrite := rt.new_null()
	rt.call_method(var_wp_rewrite, 'remove_permastruct', [var_name.clone()])
}

fn add_feed(var_feedname rt.PhpVal, var_callback rt.PhpVal) rt.PhpVal {
	mut var_wp_rewrite := rt.new_null()
	mut var_hook := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_feedname.clone(), rt.get_property(var_wp_rewrite, 'feeds'),
		rt.new_bool(true)])))))
	{
		rt.get_property(var_wp_rewrite, 'feeds').array_push(var_feedname.clone())
	}
	var_hook = rt.new_string('do_feed_' + var_feedname.str())
	rt.call_function('remove_action', [var_hook.clone(), var_hook.clone()])
	rt.call_function('add_action', [var_hook.clone(), var_callback.clone(),
		rt.new_int(10), rt.new_int(2)])
	return var_hook.clone()
}

fn flush_rewrite_rules(hard bool) {
	mut var_hard := hard
	mut var_wp_rewrite := rt.new_null()
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_wp_rewrite },
			rt.ArrayItem{ key: none, val: 'flush_rules' }]),
	]))
	{
		rt.call_method(var_wp_rewrite, 'flush_rules', [rt.new_bool(hard)])
	}
}

fn add_rewrite_endpoint(var_name rt.PhpVal, var_places rt.PhpVal, query_var bool) {
	mut var_query_var := query_var
	mut var_wp_rewrite := rt.new_null()
	rt.call_method(var_wp_rewrite, 'add_endpoint', [var_name.clone(),
		var_places.clone(), rt.new_bool(query_var)])
}

fn _wp_filter_taxonomy_base(var_base_arg rt.PhpVal) rt.PhpVal {
	mut var_base := var_base_arg
	if !(!rt.is_true(var_base)) {
		var_base = rt.call_function('preg_replace', [rt.new_string('|^/index\\.php/|'),
			rt.new_string(''), var_base.clone()])
		var_base = rt.new_string(var_base.clone().to_string().trim_space())
	}
	return var_base.clone()
}

fn wp_resolve_numeric_slug_conflicts(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_permastructs := rt.new_null()
	mut var_postname_index := rt.new_null()
	mut var_compare := ''
	mut var_value := rt.new_null()
	mut var_post := rt.new_null()
	mut var_maybe_page := rt.new_null()
	mut var_post_page_count := rt.new_null()
	if !(var_query_vars.array_isset(rt.new_string('year')))
		&& !(var_query_vars.array_isset(rt.new_string('monthnum')))
		&& !(var_query_vars.array_isset(rt.new_string('day'))) {
		return var_query_vars.clone()
	}
	var_permastructs = rt.call_function('array_values', [
		rt.call_function('array_filter', [
			rt.call_function('explode', [rt.new_string('/'),
				rt.call_function('get_option', [rt.new_string('permalink_structure')])]),
		]),
	])
	var_postname_index = rt.call_function('array_search', [rt.new_string('%postname%'),
		var_permastructs.clone(), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_postname_index)) {
		return var_query_vars.clone()
	}
	var_compare = ''
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), var_postname_index))
		&& var_query_vars.array_isset(rt.new_string('year'))
		|| var_query_vars.array_isset(rt.new_string('monthnum'))))
	{
		var_compare = 'year'
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_postname_index)
		&& rt.is_true(rt.identical(rt.new_string('%year%'), var_permastructs.array_get(rt.sub(var_postname_index, rt.new_int(1)))))))
		&& var_query_vars.array_isset(rt.new_string('monthnum'))
		|| var_query_vars.array_isset(rt.new_string('day'))))
	{
		var_compare = 'monthnum'
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_postname_index)
		&& rt.is_true(rt.identical(rt.new_string('%monthnum%'), var_permastructs.array_get(rt.sub(var_postname_index, rt.new_int(1)))))))
		&& var_query_vars.array_isset(rt.new_string('day'))))
	{
		var_compare = 'day'
	}
	if !(var_compare.len > 0 && var_compare != '0') {
		return var_query_vars.clone()
	}
	var_value = rt.new_string('')
	if rt.is_true(rt.new_bool(var_query_vars.clone().array_isset(rt.new_string(var_compare.str()).clone()))) {
		var_value = var_query_vars.array_get(var_compare)
	}
	var_post = rt.call_function('get_page_by_path', [var_value.clone(),
		rt.get_constant('OBJECT'), rt.new_string('post')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))))) {
		return var_query_vars.clone()
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^([0-9]{4})\\-([0-9]{2})/'), rt.get_property(var_post, 'post_date'), var_matches.clone()]))
		&& var_query_vars.array_isset(rt.new_string('year'))))
		&& rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('monthnum'), rt.new_string(var_compare.str())))
		|| rt.is_true(rt.identical(rt.new_string('day'), rt.new_string(var_compare.str())))))))
	{
		if rt.is_true(rt.new_bool(rt.new_int((var_query_vars.array_get('year')).to_i64()) != rt.new_int((var_matches.array_get(1)).to_i64()))) {
			return var_query_vars.clone()
		}
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('day'), rt.new_string(var_compare.str())))
			&& var_query_vars.array_isset(rt.new_string('monthnum'))))
			&& rt.is_true(rt.new_bool(rt.new_int((var_query_vars.array_get('monthnum')).to_i64()) != rt.new_int((var_matches.array_get(2)).to_i64())))))
		{
			return var_query_vars.clone()
		}
	}
	var_maybe_page = rt.new_string('')
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('year'), rt.new_string(var_compare.str())))
		&& var_query_vars.array_isset(rt.new_string('monthnum'))))
	{
		var_maybe_page = var_query_vars.array_get('monthnum')
	} else if rt.is_true(rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('monthnum'), rt.new_string(var_compare.str())))
		&& var_query_vars.array_isset(rt.new_string('day'))))
	{
		var_maybe_page = var_query_vars.array_get('day')
	}
	var_maybe_page = rt.new_int(var_maybe_page.clone().to_string().trim_space().i64())
	var_post_page_count = rt.add(rt.call_function('substr_count', [
		rt.get_property(var_post, 'post_content'),
		rt.new_string('<!--nextpage-->'),
	]), rt.new_int(1))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(1), var_post_page_count))
		&& rt.is_true(var_maybe_page)))
	{
		return var_query_vars.clone()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_post_page_count, rt.new_int(1)))
		&& rt.is_true(rt.greater(var_maybe_page, var_post_page_count))))
	{
		return var_query_vars.clone()
	}
	var_query_vars.array_set('page', var_maybe_page.clone())
	var_query_vars.array_unset(rt.new_string('year'))
	var_query_vars.array_unset(rt.new_string('monthnum'))
	var_query_vars.array_unset(rt.new_string('day'))
	var_query_vars.array_set('name', rt.get_property(var_post, 'post_name'))
	return var_query_vars.clone()
}

fn url_to_postid(var_url_arg rt.PhpVal) i64 {
	mut var_url := var_url_arg
	mut var_wp_rewrite := rt.new_null()
	mut var_values := []rt.PhpVal{}
	mut var_matches := rt.new_null()
	mut var_varmatch := []rt.PhpVal{}
	mut var_wp := rt.new_null()
	mut var_query_vars := rt.new_null()
	mut var_url_host := rt.new_null()
	mut var_home_url_host := rt.new_null()
	mut var_id := rt.new_null()
	mut var_url_split := rt.new_null()
	mut var_scheme := rt.new_null()
	mut var_page_on_front := rt.new_null()
	mut var_rewrite := rt.new_null()
	mut var_home_path := rt.new_null()
	mut var_request := rt.new_null()
	mut var_post_type_query_vars := rt.new_null()
	mut var_t := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_request_match := rt.new_null()
	mut var_query := rt.new_null()
	mut var_match := rt.new_null()
	mut var_page := rt.new_null()
	mut var_post_status_obj := rt.new_null()
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	var_url = rt.call_function('apply_filters', [rt.new_string('url_to_postid'),
		var_url.clone()])
	var_url_host = rt.call_function('parse_url', [var_url.clone(),
		rt.get_constant('PHP_URL_HOST')])
	if rt.is_true(rt.new_bool(var_url_host.clone().is_string())) {
		var_url_host = rt.call_function('str_replace', [rt.new_string('www.'),
			rt.new_string(''), var_url_host.clone()])
	} else {
		var_url_host = rt.new_string('')
	}
	var_home_url_host = rt.call_function('parse_url', [
		rt.call_function('home_url', []rt.PhpVal{}),
		rt.get_constant('PHP_URL_HOST'),
	])
	if rt.is_true(rt.new_bool(var_home_url_host.clone().is_string())) {
		var_home_url_host = rt.call_function('str_replace', [
			rt.new_string('www.'), rt.new_string(''), var_home_url_host.clone()])
	} else {
		var_home_url_host = rt.new_string('')
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_url_host)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_url_host, var_home_url_host))))))
	{
		return 0
	}
	if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('#[?&](p|page_id|attachment_id)=(\\d+)#'),
		var_url.clone(),
		rt.create_array_from_list(var_values),
	]))
	{
		var_id = rt.call_function('absint', [var_values.array_get(2)])
		if rt.is_true(var_id) {
			return var_id.to_i64()
		}
	}
	var_url_split = rt.call_function('explode', [rt.new_string('#'),
		var_url.clone()])
	var_url = var_url_split.array_get(0)
	var_url_split = rt.call_function('explode', [rt.new_string('?'),
		var_url.clone()])
	var_url = var_url_split.array_get(0)
	var_scheme = rt.call_function('parse_url', [
		rt.call_function('home_url', []rt.PhpVal{}),
		rt.get_constant('PHP_URL_SCHEME'),
	])
	var_url = rt.call_function('set_url_scheme', [var_url.clone(),
		var_scheme.clone()])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('str_contains', [rt.call_function('home_url', []rt.PhpVal{}), rt.new_string('://www.')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_url.clone(), rt.new_string('://www.')])))))))
	{
		var_url = rt.call_function('str_replace', [rt.new_string('://'),
			rt.new_string('://www.'), var_url.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		rt.call_function('home_url', []rt.PhpVal{}),
		rt.new_string('://www.'),
	])))))
	{
		var_url = rt.call_function('str_replace', [rt.new_string('://www.'),
			rt.new_string('://'), var_url.clone()])
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.identical(rt.new_string(var_url.clone().to_string().trim_space()), rt.call_function('home_url', []rt.PhpVal{})))
		&& rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')])))))
	{
		var_page_on_front = rt.call_function('get_option', [
			rt.new_string('page_on_front'),
		])
		if rt.is_true(rt.new_bool(rt.is_true(var_page_on_front)
			&& rt.is_true(rt.new_bool(rt.instance_of(rt.call_function('get_post', [var_page_on_front.clone()]), 'WP_Post')))))
		{
			return rt.new_int(var_page_on_front.to_i64())
		}
	}
	var_rewrite = rt.call_method(var_wp_rewrite, 'wp_rewrite_rules', []rt.PhpVal{})
	if !rt.is_true(var_rewrite) {
		return 0
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_rewrite, 'using_index_permalinks',
		[]rt.PhpVal{})))))
	{
		var_url = rt.call_function('str_replace', [
			rt.new_string((rt.get_property(var_wp_rewrite, 'index')).str() + '/'),
			rt.new_string(''),
			var_url.clone(),
		])
	}
	if rt.is_true(rt.call_function('str_contains', [
		rt.call_function('trailingslashit', [var_url.clone()]),
		rt.call_function('home_url', [rt.new_string('/')]),
	]))
	{
		var_url = rt.call_function('str_replace', [
			rt.call_function('home_url', []rt.PhpVal{}),
			rt.new_string(''),
			var_url.clone(),
		])
	} else {
		var_home_path = rt.call_function('parse_url', [
			rt.call_function('home_url', [rt.new_string('/')]),
		])
		var_home_path = if !(var_home_path.array_get('path')).is_null() {
			var_home_path.array_get('path')
		} else {
			rt.new_string('')
		}
		var_url = rt.call_function('preg_replace', [
			rt.call_function('sprintf', [rt.new_string('#^%s#'),
				rt.call_function('preg_quote', [var_home_path.clone()])]),
			rt.new_string(''),
			rt.call_function('trailingslashit', [var_url.clone()]),
		])
	}
	var_url = rt.new_string(var_url.clone().to_string().trim_space())
	var_request = var_url.clone()
	var_post_type_query_vars = rt.new_array()
	{
		mut iter_1 := rt.call_function('get_post_types', [rt.new_array(),
			rt.new_string('objects')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_t_shadow := item_1.val
			mut var_post_type_shadow := item_1.key
			if !(!rt.is_true(rt.get_property(var_t_shadow, 'query_var'))) {
				var_post_type_query_vars.array_set(rt.get_property(var_t_shadow, 'query_var'),
					var_post_type_shadow.clone())
			}
		}
	}
	var_request_match = var_request.clone()
	{
		mut iter_1 := rt.cast_array(var_rewrite).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_query_shadow := item_1.val
			mut var_match_shadow := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_url))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_url, var_request))))))
				&& rt.is_true(rt.call_function('str_starts_with', [var_match_shadow.clone(), var_url.clone()]))))
			{
				var_request_match = rt.new_string(var_url.str() + '/' + var_request.str())
			}
			if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('#^${var_match.to_string()}#'),
				var_request_match.clone(),
				var_matches.clone(),
			]))
			{
				if rt.is_true(rt.new_bool(
					rt.is_true(rt.get_property(var_wp_rewrite, 'use_verbose_page_rules'))
					&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/pagename=\\$matches\\[([0-9]+)\\]/'), var_query_shadow.clone(), rt.create_array_from_list(var_varmatch)]))))
				{
					var_page = rt.call_function('get_page_by_path', [
						var_matches.array_get(var_varmatch.array_get(1)),
					])
					if rt.is_true(rt.new_bool(!(rt.is_true(var_page)))) {
						continue
					}
					var_post_status_obj = rt.call_function('get_post_status_object', [
						rt.get_property(var_page, 'post_status'),
					])
					if rt.is_true(rt.new_bool(
						rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_status_obj, 'public')))))
						&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_status_obj, 'protected')))))))
						&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_status_obj, 'private')))))))
						&& rt.is_true(rt.get_property(var_post_status_obj, 'exclude_from_search'))))
					{
						continue
					}
				}
				var_query_shadow = rt.call_function('preg_replace', [
					rt.new_string('!^.+\\?!'),
					rt.new_string(''),
					var_query_shadow.clone(),
				])
				var_query_shadow = rt.call_function('addslashes', [
					fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
						mut temp := Class_WP_MatchesMapRegex{}
						return temp.apply(arg_0, arg_1)
					}(var_query_shadow.clone(), var_matches.clone())])
				rt.call_function('parse_str', [var_query_shadow.clone(),
					var_query_vars.clone()])
				var_query_shadow = rt.new_array()
				{
					mut iter_2 := rt.cast_array(var_query_vars).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_value_shadow := item_2.val
						mut var_key_shadow := item_2.key
						if rt.is_true(rt.call_function('in_array', [
							rt.new_string(var_key_shadow.str()),
							rt.get_property(var_wp, 'public_query_vars'),
							rt.new_bool(true),
						]))
						{
							var_query_shadow.array_set(var_key_shadow, var_value_shadow.clone())
							if var_post_type_query_vars.array_isset(var_key_shadow) {
								var_query_shadow.array_set('post_type',
									var_post_type_query_vars.array_get(var_key_shadow))
								var_query_shadow.array_set('name', var_value_shadow.clone())
							}
						}
					}
				}
				var_query_shadow = wp_resolve_numeric_slug_conflicts(var_query_shadow.clone())
				var_query_shadow = create_wp_query(var_query_shadow.clone())
				if rt.is_true(rt.new_bool(
					!(!rt.is_true(rt.get_property(var_query_shadow, 'posts')))
					&& rt.is_true(rt.get_property(var_query_shadow, 'is_singular'))))
				{
					return (rt.get_property(rt.get_property(var_query_shadow, 'post'), 'ID')).to_i64()
				} else {
					return 0
				}
			}
		}
	}
	return 0
}

struct Class_WP_MatchesMapRegex {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_matchesmapregex() &Class_WP_MatchesMapRegex {
	mut obj := &Class_WP_MatchesMapRegex{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_MatchesMapRegex) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_MatchesMapRegex) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_MatchesMapRegex) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

pub fn init_wp_includes_rewrite_php() {
}
