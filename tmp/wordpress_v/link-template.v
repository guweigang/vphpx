module wp_includes

import rt
import crypto.md5

fn the_permalink(post i64) {
	mut var_post := post
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('apply_filters', [rt.new_string('the_permalink'),
			rt.new_bool(get_permalink(post, false)), rt.new_int(post)]),
	]))
}

fn user_trailingslashit(var_url_arg rt.PhpVal, type_of_url string) rt.PhpVal {
	mut var_type_of_url := type_of_url
	mut var_url := var_url_arg
	mut var_wp_rewrite := rt.new_null()
	if rt.is_true(rt.get_property(var_wp_rewrite, 'use_trailing_slashes')) {
		var_url = rt.call_function('trailingslashit', [var_url.clone()])
	} else {
		var_url = rt.call_function('untrailingslashit', [var_url.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('user_trailingslashit'),
		var_url.clone(), rt.new_string(type_of_url)])
}

fn permalink_anchor(mode string) {
	mut var_mode := mode
	mut var_post := rt.new_null()
	mut var_title := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	mut switch_val_1 := rt.new_string(mode.to_lower())
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('title'))) {
		var_title = rt.new_string(
			(rt.call_function('sanitize_title', [rt.get_property(var_post, 'post_title')])).str() +
			'-' + (rt.get_property(var_post, 'ID')).str())
		print('<a id="' + var_title.str() + '"></a>')
	} else {
		print('<a id="post-' + (rt.get_property(var_post, 'ID')).str() + '"></a>')
	}
}

fn wp_force_plain_post_permalink(var_post_arg rt.PhpVal, var_sample_arg rt.PhpVal) bool {
	mut var_post := var_post_arg
	mut var_sample := var_sample_arg
	mut var_post_status_obj := rt.new_null()
	mut var_post_type_obj := rt.new_null()
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_sample))
		&& rt.is_true(rt.new_bool(var_post.clone().is_object()))))
		&& !(rt.get_property(var_post, 'filter')).is_null()))
		&& rt.is_true(rt.identical(rt.new_string('sample'), rt.get_property(var_post, 'filter')))))
	{
		var_sample = rt.new_bool(true)
	} else {
		var_post = rt.call_function('get_post', [var_post.clone()])
		var_sample = if !var_sample.is_null() { var_sample } else { rt.new_bool(false) }
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return true
	}
	var_post_status_obj = rt.call_function('get_post_status_object', [
		rt.call_function('get_post_status', [var_post.clone()]),
	])
	var_post_type_obj = rt.call_function('get_post_type_object', [
		rt.call_function('get_post_type', [var_post.clone()]),
	])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_post_status_obj))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_obj))))))
	{
		return true
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_post_status_viewable', [var_post_status_obj.clone()]))
		|| rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_post_status_obj, 'private'))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_post, 'ID')]))))))
		|| rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_post_status_obj, 'protected'))
		&& rt.is_true(var_sample)))))
	{
		return false
	}
	return true
}

fn get_the_permalink(post i64, leavename bool) rt.PhpVal {
	mut var_post := post
	mut var_leavename := leavename
	return rt.new_bool(get_permalink(post, leavename))
}

fn get_permalink(post i64, leavename bool) bool {
	mut var_post := post
	mut var_leavename := leavename
	mut var_rewritecode := []rt.PhpVal{}
	mut var_sample := false
	mut var_permalink := rt.new_null()
	mut var_category := rt.new_null()
	mut var_cats := rt.new_null()
	mut var_category_object := rt.new_null()
	mut var_default_category := rt.new_null()
	mut var_author := rt.new_null()
	mut var_authordata := rt.new_null()
	mut var_date := rt.new_null()
	mut var_rewritereplace := []rt.PhpVal{}
	var_rewritecode = ['%year%', '%monthnum%', '%day%', '%hour%', '%minute%', '%second%', if var_leavename {
		''
	} else {
		'%postname%'
	}, '%post_id%', '%category%', '%author%', if var_leavename { '' } else { '%pagename%' }]
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.new_int(var_post).is_object()))
		&& !(rt.get_property(rt.new_int(var_post), 'filter')).is_null()))
		&& rt.is_true(rt.identical(rt.new_string('sample'), rt.get_property(rt.new_int(var_post), 'filter')))))
	{
		var_sample = true
	} else {
		var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
		var_sample = false
	}
	if !rt.is_true(rt.get_property(rt.new_int(var_post), 'ID')) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(rt.new_int(var_post),
		'post_type')))
	{
		return (get_page_link(var_post, leavename, var_sample)).to_bool()
	} else if rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(rt.new_int(var_post),
		'post_type')))
	{
		return (get_attachment_link(rt.new_int(var_post), leavename)).to_bool()
	} else if rt.is_true(rt.call_function('in_array', [
		rt.get_property(rt.new_int(var_post), 'post_type'),
		rt.call_function('get_post_types', [
			rt.create_array([rt.ArrayItem{ key: '_builtin', val: false }]),
		]),
		rt.new_bool(true),
	]))
	{
		return get_post_permalink(var_post, leavename, var_sample)
	}
	var_permalink = rt.call_function('get_option', [rt.new_string('permalink_structure')])
	var_permalink = rt.call_function('apply_filters', [rt.new_string('pre_post_link'),
		var_permalink.clone(), rt.new_int(var_post), rt.new_bool(leavename)])
	if rt.is_true(rt.new_bool(rt.is_true(var_permalink)
		&& !(wp_force_plain_post_permalink(var_post))))
	{
		var_category = rt.new_string('')
		if rt.is_true(rt.call_function('str_contains', [var_permalink.clone(),
			rt.new_string('%category%')]))
		{
			var_cats = rt.call_function('get_the_category', [
				rt.get_property(rt.new_int(var_post), 'ID'),
			])
			if rt.is_true(var_cats) {
				var_cats = rt.call_function('wp_list_sort', [
					var_cats.clone(), rt.create_array([
						rt.ArrayItem{ key: 'term_id', val: 'ASC' },
					])])
				var_category_object = rt.call_function('apply_filters', [
					rt.new_string('post_link_category'),
					var_cats.array_get(0),
					var_cats.clone(),
					rt.new_int(var_post),
				])
				var_category_object = rt.call_function('get_term', [
					var_category_object.clone(), rt.new_string('category')])
				var_category = rt.get_property(var_category_object, 'slug')
				if rt.is_true(rt.get_property(var_category_object, 'parent')) {
					var_category = rt.new_string(
						(rt.call_function('get_category_parents', [rt.get_property(var_category_object, 'parent'), rt.new_bool(false), rt.new_string('/'), rt.new_bool(true)])).str() +
						var_category.str())
				}
			}
			if !rt.is_true(var_category) {
				var_default_category = rt.call_function('get_term', [
					rt.call_function('get_option', [rt.new_string('default_category')]),
					rt.new_string('category'),
				])
				if rt.is_true(rt.new_bool(rt.is_true(var_default_category)
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_default_category.clone()])))))))
				{
					var_category = rt.get_property(var_default_category, 'slug')
				}
			}
		}
		var_author = rt.new_string('')
		if rt.is_true(rt.call_function('str_contains', [var_permalink.clone(),
			rt.new_string('%author%')]))
		{
			var_authordata = rt.call_function('get_userdata', [
				rt.get_property(rt.new_int(var_post), 'post_author'),
			])
			var_author = rt.get_property(var_authordata, 'user_nicename')
		}
		var_date = rt.call_function('explode', [rt.new_string(' '),
			rt.call_function('str_replace', [
				rt.create_array([rt.ArrayItem{ key: none, val: '-' },
					rt.ArrayItem{ key: none, val: ':' }]),
				rt.new_string(' '),
				rt.get_property(rt.new_int(var_post), 'post_date'),
			])])
		var_rewritereplace = [var_date.array_get(0), var_date.array_get(1),
			var_date.array_get(2), var_date.array_get(3), var_date.array_get(4),
			var_date.array_get(5), rt.get_property(rt.new_int(var_post), 'post_name'),
			rt.get_property(rt.new_int(var_post), 'ID'), var_category, var_author,
			rt.get_property(rt.new_int(var_post),
				'post_name')]
		var_permalink = home_url(rt.call_function('str_replace', [
			rt.create_array_from_list(var_rewritecode),
			rt.create_array_from_list(var_rewritereplace),
			var_permalink.clone(),
		]), rt.new_null())
		var_permalink = user_trailingslashit(var_permalink.clone(), 'single')
	} else {
		var_permalink = home_url('?p=' + (rt.get_property(rt.new_int(var_post), 'ID')).str(),
			rt.new_null())
	}
	return (rt.call_function('apply_filters', [rt.new_string('post_link'),
		var_permalink.clone(), rt.new_int(var_post), rt.new_bool(leavename)])).to_bool()
}

fn get_post_permalink(post i64, leavename bool, sample bool) bool {
	mut var_post := post
	mut var_leavename := leavename
	mut var_sample := sample
	mut var_wp_rewrite := rt.new_null()
	mut var_post_link := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_force_plain_link := false
	mut var_post_type := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	if !(var_post != 0) {
		return false
	}
	var_post_link = rt.call_method(var_wp_rewrite, 'get_extra_permastruct', [
		rt.get_property(rt.new_int(var_post), 'post_type'),
	])
	var_slug = rt.get_property(rt.new_int(var_post), 'post_name')
	var_force_plain_link = wp_force_plain_post_permalink(var_post)
	var_post_type = rt.call_function('get_post_type_object', [
		rt.get_property(rt.new_int(var_post), 'post_type'),
	])
	if rt.is_true(rt.get_property(var_post_type, 'hierarchical')) {
		var_slug = rt.call_function('get_page_uri', [rt.new_int(var_post)])
	}
	if !(!rt.is_true(var_post_link)) && !var_force_plain_link || var_sample {
		if !var_leavename {
			var_post_link = rt.call_function('str_replace', [
				rt.concat(rt.concat(rt.new_string('%'), rt.get_property(rt.new_int(var_post),
					'post_type')), rt.new_string('%')),
				var_slug.clone(),
				var_post_link.clone(),
			])
		}
		var_post_link = home_url(user_trailingslashit(var_post_link.clone(), ''), rt.new_null())
	} else {
		if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_post_type, 'query_var'))
			&& !(rt.get_property(rt.new_int(var_post), 'post_status')).is_null()
			&& !var_force_plain_link))
		{
			var_post_link = rt.call_function('add_query_arg', [
				rt.get_property(var_post_type, 'query_var'),
				var_slug.clone(),
				rt.new_string(''),
			])
		} else {
			var_post_link = rt.call_function('add_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: 'post_type', val: rt.get_property(rt.new_int(var_post),
						'post_type') },
					rt.ArrayItem{ key: 'p', val: rt.get_property(rt.new_int(var_post), 'ID') },
				]),
				rt.new_string(''),
			])
		}
		var_post_link = home_url(var_post_link.clone(), rt.new_null())
	}
	return (rt.call_function('apply_filters', [rt.new_string('post_type_link'),
		var_post_link.clone(), rt.new_int(var_post), rt.new_bool(leavename),
		rt.new_bool(sample)])).to_bool()
}

fn get_page_link(post i64, leavename bool, sample bool) rt.PhpVal {
	mut var_post := post
	mut var_leavename := leavename
	mut var_sample := sample
	mut var_link := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')])))
		&& rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('page_on_front')])).to_i64()), rt.get_property(rt.new_int(var_post), 'ID')))))
	{
		var_link = home_url('/', rt.new_null())
	} else {
		var_link = _get_page_link(var_post, leavename, sample)
	}
	return rt.call_function('apply_filters', [rt.new_string('page_link'),
		var_link.clone(), rt.get_property(rt.new_int(var_post), 'ID'),
		rt.new_bool(sample)])
}

fn _get_page_link(post i64, leavename bool, sample bool) rt.PhpVal {
	mut var_post := post
	mut var_leavename := leavename
	mut var_sample := sample
	mut var_wp_rewrite := rt.new_null()
	mut var_force_plain_link := false
	mut var_link := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	var_force_plain_link = wp_force_plain_post_permalink(var_post)
	var_link = rt.call_method(var_wp_rewrite, 'get_page_permastruct', []rt.PhpVal{})
	if !(!rt.is_true(var_link)) && !(rt.get_property(rt.new_int(var_post), 'post_status')).is_null()
		&& !var_force_plain_link || var_sample {
		if !var_leavename {
			var_link = rt.call_function('str_replace', [rt.new_string('%pagename%'),
				rt.call_function('get_page_uri', [rt.new_int(var_post)]),
				var_link.clone()])
		}
		var_link = home_url(var_link.clone(), rt.new_null())
		var_link = user_trailingslashit(var_link.clone(), 'page')
	} else {
		var_link = home_url('?page_id=' + (rt.get_property(rt.new_int(var_post), 'ID')).str(),
			rt.new_null())
	}
	return rt.call_function('apply_filters', [rt.new_string('_get_page_link'),
		var_link.clone(), rt.get_property(rt.new_int(var_post), 'ID')])
}

fn get_attachment_link(var_post_arg rt.PhpVal, leavename bool) rt.PhpVal {
	mut var_leavename := leavename
	mut var_post := var_post_arg
	mut var_wp_rewrite := rt.new_null()
	mut var_link := rt.new_null()
	mut var_force_plain_link := false
	mut var_parent_id := rt.new_null()
	mut var_parent := rt.new_null()
	mut var_parent_valid := false
	mut var_parentlink := rt.new_null()
	mut var_name := rt.new_null()
	var_link = rt.new_bool(false)
	var_post = rt.call_function('get_post', [var_post.clone()])
	var_force_plain_link = wp_force_plain_post_permalink(var_post.clone())
	var_parent_id = rt.get_property(var_post, 'post_parent')
	var_parent = if rt.is_true(var_parent_id) { rt.call_function('get_post', [
			var_parent_id.clone()]) } else { rt.new_bool(false) }
	var_parent_valid = true
	if rt.is_true(rt.new_bool(rt.is_true(var_parent_id)
		&& rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.get_property(var_post, 'post_parent'), rt.get_property(var_post, 'ID')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_parent))))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_type_viewable', [rt.call_function('get_post_type', [var_parent.clone()])])))))))))
	{
		var_parent_valid = false
	}
	if var_force_plain_link || !var_parent_valid {
		var_link = rt.new_bool(false)
	} else if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{}))
		&& rt.is_true(var_parent)))
	{
		if rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_parent, 'post_type'))) {
			var_parentlink = _get_page_link(rt.get_property(var_post, 'post_parent'), false, false)
		} else {
			var_parentlink = rt.new_bool(get_permalink(rt.get_property(var_post, 'post_parent'),
				false))
		}
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(rt.get_property(var_post, 'post_name').is_long()
			|| rt.get_property(var_post, 'post_name').is_double()))
			|| rt.is_true(rt.call_function('str_contains', [rt.call_function('get_option', [rt.new_string('permalink_structure')]), rt.new_string('%category%')]))))
		{
			var_name = rt.new_string('attachment/' + (rt.get_property(var_post, 'post_name')).str())
		} else {
			var_name = rt.get_property(var_post, 'post_name')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
			var_parentlink.clone(),
			rt.new_string('?'),
		])))))
		{
			var_link = user_trailingslashit(rt.new_string(
				(rt.call_function('trailingslashit', [var_parentlink.clone()])).str() + '%postname%'), '')
		}
		if !var_leavename {
			var_link = rt.call_function('str_replace', [rt.new_string('%postname%'),
				var_name.clone(), var_link.clone()])
		}
	} else if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{}))
		&& !var_leavename))
	{
		var_link = home_url(user_trailingslashit(rt.get_property(var_post, 'post_name'), ''),
			rt.new_null())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_link)))) {
		var_link = home_url('/?attachment_id=' + (rt.get_property(var_post, 'ID')).str(),
			rt.new_null())
	}
	return rt.call_function('apply_filters', [rt.new_string('attachment_link'),
		var_link.clone(), rt.get_property(var_post, 'ID')])
}

fn get_year_link(var_year_arg rt.PhpVal) rt.PhpVal {
	mut var_year := var_year_arg
	mut var_wp_rewrite := rt.new_null()
	mut var_yearlink := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_year)))) {
		var_year = rt.call_function('current_time', [rt.new_string('Y')])
	}
	var_yearlink = rt.call_method(var_wp_rewrite, 'get_year_permastruct', []rt.PhpVal{})
	if !(!rt.is_true(var_yearlink)) {
		var_yearlink = rt.call_function('str_replace', [rt.new_string('%year%'),
			var_year.clone(), var_yearlink.clone()])
		var_yearlink = home_url(user_trailingslashit(var_yearlink.clone(), 'year'), rt.new_null())
	} else {
		var_yearlink = home_url('?m=' + var_year.str(), rt.new_null())
	}
	return rt.call_function('apply_filters', [rt.new_string('year_link'),
		var_yearlink.clone(), var_year.clone()])
}

fn get_month_link(var_year_arg rt.PhpVal, var_month_arg rt.PhpVal) rt.PhpVal {
	mut var_year := var_year_arg
	mut var_month := var_month_arg
	mut var_wp_rewrite := rt.new_null()
	mut var_monthlink := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_year)))) {
		var_year = rt.call_function('current_time', [rt.new_string('Y')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_month)))) {
		var_month = rt.call_function('current_time', [rt.new_string('m')])
	}
	var_monthlink = rt.call_method(var_wp_rewrite, 'get_month_permastruct', []rt.PhpVal{})
	if !(!rt.is_true(var_monthlink)) {
		var_monthlink = rt.call_function('str_replace', [rt.new_string('%year%'),
			var_year.clone(), var_monthlink.clone()])
		var_monthlink = rt.call_function('str_replace', [rt.new_string('%monthnum%'),
			rt.call_function('zeroise', [rt.new_int(var_month.to_i64()),
				rt.new_int(2)]),
			var_monthlink.clone()])
		var_monthlink = home_url(user_trailingslashit(var_monthlink.clone(), 'month'),
			rt.new_null())
	} else {
		var_monthlink = home_url('?m=' + var_year.str() +
			(rt.call_function('zeroise', [var_month.clone(), rt.new_int(2)])).str(), rt.new_null())
	}
	return rt.call_function('apply_filters', [rt.new_string('month_link'),
		var_monthlink.clone(), var_year.clone(), var_month.clone()])
}

fn get_day_link(var_year_arg rt.PhpVal, var_month_arg rt.PhpVal, var_day_arg rt.PhpVal) rt.PhpVal {
	mut var_year := var_year_arg
	mut var_month := var_month_arg
	mut var_day := var_day_arg
	mut var_wp_rewrite := rt.new_null()
	mut var_daylink := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_year)))) {
		var_year = rt.call_function('current_time', [rt.new_string('Y')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_month)))) {
		var_month = rt.call_function('current_time', [rt.new_string('m')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_day)))) {
		var_day = rt.call_function('current_time', [rt.new_string('j')])
	}
	var_daylink = rt.call_method(var_wp_rewrite, 'get_day_permastruct', []rt.PhpVal{})
	if !(!rt.is_true(var_daylink)) {
		var_daylink = rt.call_function('str_replace', [rt.new_string('%year%'),
			var_year.clone(), var_daylink.clone()])
		var_daylink = rt.call_function('str_replace', [rt.new_string('%monthnum%'),
			rt.call_function('zeroise', [rt.new_int(var_month.to_i64()),
				rt.new_int(2)]),
			var_daylink.clone()])
		var_daylink = rt.call_function('str_replace', [rt.new_string('%day%'),
			rt.call_function('zeroise', [rt.new_int(var_day.to_i64()),
				rt.new_int(2)]),
			var_daylink.clone()])
		var_daylink = home_url(user_trailingslashit(var_daylink.clone(), 'day'), rt.new_null())
	} else {
		var_daylink = home_url('?m=' + var_year.str() +
			(rt.call_function('zeroise', [var_month.clone(), rt.new_int(2)])).str() +
			(rt.call_function('zeroise', [var_day.clone(), rt.new_int(2)])).str(), rt.new_null())
	}
	return rt.call_function('apply_filters', [rt.new_string('day_link'),
		var_daylink.clone(), var_year.clone(), var_month.clone(),
		var_day.clone()])
}

fn the_feed_link(var_anchor rt.PhpVal, feed string) {
	mut var_feed := feed
	mut var_link := rt.new_null()
	var_link = rt.new_string('<a href="' +
		(rt.call_function('esc_url', [get_feed_link(feed)])).str() + '">' + var_anchor.str() +
		'</a>')
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('the_feed_link'),
		var_link.clone(), rt.new_string(feed)]))
}

fn get_feed_link(feed string) rt.PhpVal {
	mut var_feed := feed
	mut var_wp_rewrite := rt.new_null()
	mut var_permalink := rt.new_null()
	mut var_output := rt.new_null()
	var_permalink = rt.call_method(var_wp_rewrite, 'get_feed_permastruct', []rt.PhpVal{})
	if rt.is_true(var_permalink) {
		if rt.is_true(rt.call_function('str_contains', [rt.new_string(var_feed.str()),
			rt.new_string('comments_')]))
		{
			var_feed = (rt.call_function('str_replace', [rt.new_string('comments_'),
				rt.new_string(''), rt.new_string(var_feed.str())])).str()
			var_permalink = rt.call_method(var_wp_rewrite, 'get_comment_feed_permastruct',
				[]rt.PhpVal{})
		}
		if rt.is_true(rt.identical(rt.call_function('get_default_feed', []rt.PhpVal{}),
			rt.new_string(var_feed.str())))
		{
			var_feed = ''
		}
		var_permalink = rt.call_function('str_replace', [rt.new_string('%feed%'),
			rt.new_string(var_feed.str()), var_permalink.clone()])
		var_permalink = rt.call_function('preg_replace', [rt.new_string('#/+#'),
			rt.new_string('/'), rt.new_string('/${var_permalink.to_string()}')])
		var_output = home_url(user_trailingslashit(var_permalink.clone(), 'feed'), rt.new_null())
	} else {
		if var_feed == '' {
			var_feed = (rt.call_function('get_default_feed', []rt.PhpVal{})).str()
		}
		if rt.is_true(rt.call_function('str_contains', [rt.new_string(var_feed.str()),
			rt.new_string('comments_')]))
		{
			var_feed = (rt.call_function('str_replace', [rt.new_string('comments_'),
				rt.new_string('comments-'), rt.new_string(var_feed.str())])).str()
		}
		var_output = home_url('?feed=${var_feed}', rt.new_null())
	}
	return rt.call_function('apply_filters', [rt.new_string('feed_link'),
		var_output.clone(), rt.new_string(var_feed.str())])
}

fn get_post_comments_feed_link(post_id i64, feed string) string {
	mut var_post_id := post_id
	mut var_feed := feed
	mut var_post := rt.new_null()
	mut var_unattached := false
	mut var_url := rt.new_null()
	var_post_id = (rt.call_function('absint', [rt.new_int(var_post_id)])).to_i64()
	if !(var_post_id != 0) {
		var_post_id = (rt.call_function('get_the_ID', []rt.PhpVal{})).to_i64()
	}
	if var_feed == '' {
		var_feed = (rt.call_function('get_default_feed', []rt.PhpVal{})).str()
	}
	var_post = rt.call_function('get_post', [rt.new_int(var_post_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))))) {
		return ''
	}
	var_unattached =
		rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_post, 'post_type')))
		&& 0 == rt.new_int((rt.get_property(var_post, 'post_parent')).to_i64())
	if rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])) {
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')])))
			&& rt.new_int((rt.call_function('get_option', [rt.new_string('page_on_front')])).to_i64()) == var_post_id))
		{
			var_url = _get_page_link(var_post_id, false, false)
		} else {
			var_url = rt.new_bool(get_permalink(var_post_id, false))
		}
		if var_unattached {
			var_url = home_url('/feed/', rt.new_null())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_default_feed',
				[]rt.PhpVal{}), rt.new_string(var_feed.str())))))
			{
				var_url = rt.concat(var_url, rt.new_string('${var_feed}/'))
			}
			var_url = rt.call_function('add_query_arg', [rt.new_string('attachment_id'),
				rt.new_int(var_post_id), var_url.clone()])
		} else {
			var_url = rt.new_string(
				(rt.call_function('trailingslashit', [var_url.clone()])).str() + 'feed')
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_default_feed',
				[]rt.PhpVal{}), rt.new_string(var_feed.str())))))
			{
				var_url = rt.concat(var_url, rt.new_string('/${var_feed}'))
			}
			var_url = user_trailingslashit(var_url.clone(), 'single_feed')
		}
	} else {
		if var_unattached {
			var_url = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'feed', val: var_feed },
					rt.ArrayItem{ key: 'attachment_id', val: var_post_id }]),
				home_url('/', rt.new_null()),
			])
		} else if rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_post,
			'post_type')))
		{
			var_url = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'feed', val: var_feed },
					rt.ArrayItem{ key: 'page_id', val: var_post_id }]),
				home_url('/', rt.new_null()),
			])
		} else {
			var_url = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'feed', val: var_feed },
					rt.ArrayItem{ key: 'p', val: var_post_id }]),
				home_url('/', rt.new_null()),
			])
		}
	}
	return (rt.call_function('apply_filters', [rt.new_string('post_comments_feed_link'),
		var_url.clone()])).str()
}

fn post_comments_feed_link(link_text string, post_id i64, feed string) {
	mut var_link_text := link_text
	mut var_post_id := post_id
	mut var_feed := feed
	mut var_url := ''
	mut var_link := rt.new_null()
	var_url = get_post_comments_feed_link(var_post_id, var_feed)
	if var_link_text == '' {
		var_link_text = (rt.call_function('__', [rt.new_string('Comments Feed')])).str()
	}
	var_link = rt.new_string('<a href="' +
		(rt.call_function('esc_url', [rt.new_string(var_url.str()).clone()])).str() + '">' +
		var_link_text + '</a>')
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('post_comments_feed_link_html'),
		var_link.clone(),
		rt.new_int(var_post_id),
		rt.new_string(var_feed.str()),
	]))
}

fn get_author_feed_link(var_author_id_arg rt.PhpVal, feed string) rt.PhpVal {
	mut var_feed := feed
	mut var_author_id := var_author_id_arg
	mut var_permalink_structure := rt.new_null()
	mut var_link := rt.new_null()
	mut var_feed_link := ''
	var_author_id = rt.new_int(var_author_id.to_i64())
	var_permalink_structure = rt.call_function('get_option', [
		rt.new_string('permalink_structure'),
	])
	if var_feed == '' {
		var_feed = (rt.call_function('get_default_feed', []rt.PhpVal{})).str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permalink_structure)))) {
		var_link = home_url('?feed=${var_feed}&amp;author=' + var_author_id.str(), rt.new_null())
	} else {
		var_link = rt.call_function('get_author_posts_url', [
			var_author_id.clone()])
		if rt.is_true(rt.identical(rt.call_function('get_default_feed', []rt.PhpVal{}),
			rt.new_string(var_feed.str())))
		{
			var_feed_link = 'feed'
		} else {
			var_feed_link = 'feed/${var_feed}'
		}
		var_link = rt.new_string((rt.call_function('trailingslashit', [var_link.clone()])).str() +
			(user_trailingslashit(rt.new_string(var_feed_link.str()).clone(), 'feed')).str())
	}
	var_link = rt.call_function('apply_filters', [rt.new_string('author_feed_link'),
		var_link.clone(), rt.new_string(var_feed.str())])
	return var_link.clone()
}

fn get_category_feed_link(var_cat rt.PhpVal, feed string) rt.PhpVal {
	mut var_feed := feed
	return rt.new_bool(get_term_feed_link(var_cat.clone(), 'category', var_feed))
}

fn get_term_feed_link(var_term_arg rt.PhpVal, taxonomy string, feed string) bool {
	mut var_taxonomy := taxonomy
	mut var_feed := feed
	mut var_term := var_term_arg
	mut var_permalink_structure := rt.new_null()
	mut var_link := rt.new_null()
	mut var_t := rt.new_null()
	mut var_feed_link := ''
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_term.clone().is_object()))))) {
		var_term = rt.new_int(var_term.to_i64())
	}
	var_term = rt.call_function('get_term', [var_term.clone(),
		rt.new_string(var_taxonomy.str())])
	if rt.is_true(rt.new_bool(!rt.is_true(var_term)
		|| rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))
	{
		return false
	}
	var_taxonomy = (rt.get_property(var_term, 'taxonomy')).str()
	if var_feed == '' {
		var_feed = (rt.call_function('get_default_feed', []rt.PhpVal{})).str()
	}
	var_permalink_structure = rt.call_function('get_option', [
		rt.new_string('permalink_structure'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permalink_structure)))) {
		if rt.is_true(rt.identical(rt.new_string('category'), rt.new_string(var_taxonomy.str()))) {
			var_link = home_url(rt.concat(rt.concat(rt.concat(rt.new_string('?feed='),
				rt.new_string(var_feed.str())), rt.new_string('&amp;cat=')), rt.get_property(var_term,
				'term_id')), rt.new_null())
		} else if rt.is_true(rt.identical(rt.new_string('post_tag'),
			rt.new_string(var_taxonomy.str())))
		{
			var_link = home_url(rt.concat(rt.concat(rt.concat(rt.new_string('?feed='),
				rt.new_string(var_feed.str())), rt.new_string('&amp;tag=')), rt.get_property(var_term,
				'slug')), rt.new_null())
		} else {
			var_t = rt.call_function('get_taxonomy', [
				rt.new_string(var_taxonomy.str()),
			])
			var_link = home_url(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('?feed='),
				rt.new_string(var_feed.str())), rt.new_string('&amp;')), rt.get_property(var_t,
				'query_var')), rt.new_string('=')), rt.get_property(var_term, 'slug')),
				rt.new_null())
		}
	} else {
		var_link = rt.call_function('get_term_link', [var_term.clone(),
			rt.get_property(var_term, 'taxonomy')])
		if rt.is_true(rt.identical(rt.call_function('get_default_feed', []rt.PhpVal{}),
			rt.new_string(var_feed.str())))
		{
			var_feed_link = 'feed'
		} else {
			var_feed_link = 'feed/${var_feed}'
		}
		var_link = rt.new_string((rt.call_function('trailingslashit', [var_link.clone()])).str() +
			(user_trailingslashit(rt.new_string(var_feed_link.str()).clone(), 'feed')).str())
	}
	if rt.is_true(rt.identical(rt.new_string('category'), rt.new_string(var_taxonomy.str()))) {
		var_link = rt.call_function('apply_filters', [
			rt.new_string('category_feed_link'),
			var_link.clone(),
			rt.new_string(var_feed.str()),
		])
	} else if rt.is_true(rt.identical(rt.new_string('post_tag'), rt.new_string(var_taxonomy.str()))) {
		var_link = rt.call_function('apply_filters', [rt.new_string('tag_feed_link'),
			var_link.clone(), rt.new_string(var_feed.str())])
	} else {
		var_link = rt.call_function('apply_filters', [
			rt.new_string('taxonomy_feed_link'),
			var_link.clone(),
			rt.new_string(var_feed.str()),
			rt.new_string(var_taxonomy.str()),
		])
	}
	return var_link.to_bool()
}

fn get_tag_feed_link(var_tag rt.PhpVal, feed string) bool {
	mut var_feed := feed
	return get_term_feed_link(var_tag.clone(), 'post_tag', var_feed)
}

fn get_edit_tag_link(var_tag rt.PhpVal, taxonomy string) rt.PhpVal {
	mut var_taxonomy := taxonomy
	return rt.call_function('apply_filters', [rt.new_string('get_edit_tag_link'),
		get_edit_term_link(var_tag.clone(), var_taxonomy, '')])
}

fn edit_tag_link(link string, before string, after string, var_tag rt.PhpVal) {
	mut var_link := link
	mut var_before := before
	mut var_after := after
	var_link = (edit_term_link(var_link, '', '', var_tag.clone(), false)).str()
	print(before +
		(rt.call_function('apply_filters', [rt.new_string('edit_tag_link'), rt.new_string(var_link.str())])).str() +
		after)
}

fn get_edit_term_link(var_term_arg rt.PhpVal, taxonomy string, object_type string) rt.PhpVal {
	mut var_taxonomy := taxonomy
	mut var_object_type := object_type
	mut var_term := var_term_arg
	mut var_tax := rt.new_null()
	mut var_term_id := rt.new_null()
	mut var_args := rt.new_null()
	mut var_location := rt.new_null()
	var_term = rt.call_function('get_term', [var_term.clone(),
		rt.new_string(var_taxonomy.str())])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_term))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))
	{
		return rt.new_null()
	}
	var_tax = rt.call_function('get_taxonomy', [rt.get_property(var_term, 'taxonomy')])
	var_term_id = rt.get_property(var_term, 'term_id')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_tax))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_term'), var_term_id.clone()])))))))
	{
		return rt.new_null()
	}
	var_args = rt.create_array([
		rt.ArrayItem{ key: 'taxonomy', val: rt.get_property(var_tax, 'name') },
		rt.ArrayItem{ key: 'tag_ID', val: var_term_id },
	])
	if var_object_type.len > 0 && var_object_type != '0' {
		var_args.array_set('post_type', object_type)
	} else if !(!rt.is_true(rt.get_property(var_tax, 'object_type'))) {
		var_args.array_set('post_type', rt.call_function('reset', [
			rt.get_property(var_tax, 'object_type'),
		]))
	}
	if rt.is_true(rt.get_property(var_tax, 'show_ui')) {
		var_location = rt.call_function('add_query_arg', [var_args.clone(),
			admin_url('term.php', '')])
	} else {
		var_location = rt.new_string('')
	}
	return rt.call_function('apply_filters', [rt.new_string('get_edit_term_link'),
		var_location.clone(), var_term_id.clone(), rt.new_string(var_taxonomy.str()),
		rt.new_string(object_type)])
}

fn edit_term_link(link string, before string, after string, var_term_arg rt.PhpVal, display bool) rt.PhpVal {
	mut var_link := link
	mut var_before := before
	mut var_after := after
	mut var_display := display
	mut var_term := var_term_arg
	if rt.is_true(rt.new_bool(var_term.clone().is_null())) {
		var_term = rt.call_function('get_queried_object', []rt.PhpVal{})
	} else {
		var_term = rt.call_function('get_term', [var_term.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_term'),
		rt.get_property(var_term, 'term_id'),
	])))))
	{
		return rt.new_null()
	}
	if var_link == '' {
		var_link = (rt.call_function('__', [rt.new_string('Edit This')])).str()
	}
	var_link = '<a href="' +
		(get_edit_term_link(rt.get_property(var_term, 'term_id'), rt.get_property(var_term, 'taxonomy'), '')).str() +
		'">' + var_link + '</a>'
	var_link = before +
		(rt.call_function('apply_filters', [rt.new_string('edit_term_link'), rt.new_string(var_link.str()), rt.get_property(var_term, 'term_id')])).str() +
		after
	if var_display {
		print(var_link)
	} else {
		return rt.new_string(var_link.str())
	}
	return rt.new_null()
}

fn get_search_link(query string) rt.PhpVal {
	mut var_query := query
	mut var_wp_rewrite := rt.new_null()
	mut var_search := rt.new_null()
	mut var_permastruct := rt.new_null()
	mut var_link := rt.new_null()
	if query == '' {
		var_search = rt.call_function('get_search_query', [rt.new_bool(false)])
	} else {
		var_search = rt.call_function('stripslashes', [rt.new_string(query)])
	}
	var_permastruct = rt.call_method(var_wp_rewrite, 'get_search_permastruct', []rt.PhpVal{})
	if !rt.is_true(var_permastruct) {
		var_link = home_url('?s=' + (rt.call_function('urlencode', [var_search.clone()])).str(),
			rt.new_null())
	} else {
		var_search = rt.call_function('urlencode', [var_search.clone()])
		var_search = rt.call_function('str_replace', [rt.new_string('%2F'),
			rt.new_string('/'), var_search.clone()])
		var_link = rt.call_function('str_replace', [rt.new_string('%search%'),
			var_search.clone(), var_permastruct.clone()])
		var_link = home_url(user_trailingslashit(var_link.clone(), 'search'), rt.new_null())
	}
	return rt.call_function('apply_filters', [rt.new_string('search_link'),
		var_link.clone(), var_search.clone()])
}

fn get_search_feed_link(search_query string, feed string) rt.PhpVal {
	mut var_search_query := search_query
	mut var_feed := feed
	mut var_wp_rewrite := rt.new_null()
	mut var_link := rt.new_null()
	mut var_permastruct := rt.new_null()
	var_link = get_search_link(search_query)
	if var_feed == '' {
		var_feed = (rt.call_function('get_default_feed', []rt.PhpVal{})).str()
	}
	var_permastruct = rt.call_method(var_wp_rewrite, 'get_search_permastruct', []rt.PhpVal{})
	if !rt.is_true(var_permastruct) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('feed'),
			rt.new_string(var_feed.str()), var_link.clone()])
	} else {
		var_link = rt.call_function('trailingslashit', [var_link.clone()])
		var_link = rt.concat(var_link, rt.new_string('feed/${var_feed}/'))
	}
	return rt.call_function('apply_filters', [rt.new_string('search_feed_link'),
		var_link.clone(), rt.new_string(var_feed.str()), rt.new_string('posts')])
}

fn get_search_comments_feed_link(search_query string, feed string) rt.PhpVal {
	mut var_search_query := search_query
	mut var_feed := feed
	mut var_wp_rewrite := rt.new_null()
	mut var_link := rt.new_null()
	mut var_permastruct := rt.new_null()
	if var_feed == '' {
		var_feed = (rt.call_function('get_default_feed', []rt.PhpVal{})).str()
	}
	var_link = get_search_feed_link(search_query, var_feed)
	var_permastruct = rt.call_method(var_wp_rewrite, 'get_search_permastruct', []rt.PhpVal{})
	if !rt.is_true(var_permastruct) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('feed'),
			rt.new_string('comments-' + var_feed), var_link.clone()])
	} else {
		var_link = rt.call_function('add_query_arg', [rt.new_string('withcomments'),
			rt.new_int(1), var_link.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('search_feed_link'),
		var_link.clone(), rt.new_string(var_feed.str()), rt.new_string('comments')])
}

fn get_post_type_archive_link(var_post_type rt.PhpVal) bool {
	mut var_wp_rewrite := rt.new_null()
	mut var_post_type_obj := rt.new_null()
	mut var_show_on_front := rt.new_null()
	mut var_page_for_posts := rt.new_null()
	mut var_link := rt.new_null()
	mut var_struct := rt.new_null()
	var_post_type_obj = rt.call_function('get_post_type_object', [
		var_post_type.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_obj)))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) {
		var_show_on_front = rt.call_function('get_option', [
			rt.new_string('show_on_front'),
		])
		var_page_for_posts = rt.call_function('get_option', [
			rt.new_string('page_for_posts'),
		])
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.identical(rt.new_string('page'), var_show_on_front))
			&& rt.is_true(var_page_for_posts)))
		{
			var_link = rt.new_bool(get_permalink(var_page_for_posts.clone(), false))
		} else {
			var_link = get_home_url(rt.new_null(), '', rt.new_null())
		}
		return (rt.call_function('apply_filters', [
			rt.new_string('post_type_archive_link'),
			var_link.clone(),
			var_post_type.clone(),
		])).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_type_obj, 'has_archive'))))) {
		return false
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')]))
		&& rt.is_true(rt.new_bool(rt.get_property(var_post_type_obj, 'rewrite').is_array()))))
	{
		var_struct = if rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_post_type_obj,
			'has_archive')))
		{
			rt.get_property(var_post_type_obj, 'rewrite').array_get('slug')
		} else {
			rt.get_property(var_post_type_obj, 'has_archive')
		}
		if rt.is_true(rt.get_property(var_post_type_obj, 'rewrite').array_get('with_front')) {
			var_struct = rt.new_string((rt.get_property(var_wp_rewrite, 'front')).str() +
				var_struct.str())
		} else {
			var_struct = rt.new_string((rt.get_property(var_wp_rewrite, 'root')).str() +
				var_struct.str())
		}
		var_link = home_url(user_trailingslashit(var_struct.clone(), 'post_type_archive'),
			rt.new_null())
	} else {
		var_link = home_url('?post_type=' + var_post_type.str(), rt.new_null())
	}
	return (rt.call_function('apply_filters', [rt.new_string('post_type_archive_link'),
		var_link.clone(), var_post_type.clone()])).to_bool()
}

fn get_post_type_archive_feed_link(var_post_type rt.PhpVal, feed string) bool {
	mut var_feed := feed
	mut var_default_feed := rt.new_null()
	mut var_link := rt.new_null()
	mut var_post_type_obj := rt.new_null()
	var_default_feed = rt.call_function('get_default_feed', []rt.PhpVal{})
	if var_feed == '' {
		var_feed = var_default_feed.str()
	}
	var_link = rt.new_bool(get_post_type_archive_link(var_post_type.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_link)))) {
		return false
	}
	var_post_type_obj = rt.call_function('get_post_type_object', [
		var_post_type.clone()])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')]))
		&& rt.is_true(rt.new_bool(rt.get_property(var_post_type_obj, 'rewrite').is_array()))))
		&& rt.is_true(rt.get_property(var_post_type_obj, 'rewrite').array_get('feeds'))))
	{
		var_link = rt.call_function('trailingslashit', [var_link.clone()])
		var_link = rt.concat(var_link, rt.new_string('feed/'))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(var_feed.str()),
			var_default_feed))))
		{
			var_link = rt.concat(var_link, rt.new_string('${var_feed}/'))
		}
	} else {
		var_link = rt.call_function('add_query_arg', [rt.new_string('feed'),
			rt.new_string(var_feed.str()), var_link.clone()])
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('post_type_archive_feed_link'),
		var_link.clone(),
		rt.new_string(var_feed.str()),
	])).to_bool()
}

fn get_preview_post_link(var_post_arg rt.PhpVal, var_query_args rt.PhpVal, preview_link string) rt.PhpVal {
	mut var_preview_link := preview_link
	mut var_post := var_post_arg
	mut var_post_type_object := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.new_null()
	}
	var_post_type_object = rt.call_function('get_post_type_object', [
		rt.get_property(var_post, 'post_type'),
	])
	if rt.is_true(rt.call_function('is_post_type_viewable', [
		var_post_type_object.clone()]))
	{
		if !(var_preview_link.len > 0 && var_preview_link != '0') {
			var_preview_link = (set_url_scheme(rt.new_bool(get_permalink(var_post.clone(), false)),
				rt.new_null())).str()
		}
		var_query_args.array_set('preview', 'true')
		var_preview_link = (rt.call_function('add_query_arg', [
			rt.create_array_from_native_map(var_query_args),
			rt.new_string(var_preview_link.str()),
		])).str()
	}
	return rt.call_function('apply_filters', [rt.new_string('preview_post_link'),
		rt.new_string(var_preview_link.str()), var_post.clone()])
}

fn get_edit_post_link(post i64, context string) rt.PhpVal {
	mut var_post := post
	mut var_context := context
	mut var_action := ''
	mut var_post_type_object := rt.new_null()
	mut var_link := rt.new_null()
	mut var_slug := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	if !(var_post != 0) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('revision'), rt.get_property(rt.new_int(var_post),
		'post_type')))
	{
		var_action = ''
	} else if rt.is_true(rt.identical(rt.new_string('display'), rt.new_string(context))) {
		var_action = '&amp;action=edit'
	} else {
		var_action = '&action=edit'
	}
	var_post_type_object = rt.call_function('get_post_type_object', [
		rt.get_property(rt.new_int(var_post), 'post_type'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_object)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		rt.get_property(rt.new_int(var_post), 'ID'),
	])))))
	{
		return rt.new_null()
	}
	var_link = rt.new_string('')
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('wp_template'), rt.get_property(rt.new_int(var_post), 'post_type')))
		|| rt.is_true(rt.identical(rt.new_string('wp_template_part'), rt.get_property(rt.new_int(var_post), 'post_type')))))
	{
		var_slug = rt.call_function('urlencode', [
			rt.new_string((rt.call_function('get_stylesheet', []rt.PhpVal{})).str() + '//' +
				(rt.get_property(rt.new_int(var_post), 'post_name')).str()),
		])
		var_link = admin_url(rt.call_function('sprintf', [
			rt.get_property(var_post_type_object, '_edit_link'),
			rt.get_property(rt.new_int(var_post), 'post_type'),
			var_slug.clone(),
		]), '')
	} else if rt.is_true(rt.identical(rt.new_string('wp_navigation'), rt.get_property(rt.new_int(var_post),
		'post_type')))
	{
		var_link = admin_url(rt.call_function('sprintf', [
			rt.get_property(var_post_type_object, '_edit_link'),
			rt.new_string((rt.get_property(rt.new_int(var_post), 'ID')).str()),
		]), '')
	} else if rt.is_true(rt.get_property(var_post_type_object, '_edit_link')) {
		var_link = admin_url(rt.call_function('sprintf', [
			rt.new_string((rt.get_property(var_post_type_object, '_edit_link')).str() + var_action),
			rt.get_property(rt.new_int(var_post), 'ID'),
		]), '')
	}
	return rt.call_function('apply_filters', [rt.new_string('get_edit_post_link'),
		var_link.clone(), rt.get_property(rt.new_int(var_post), 'ID'),
		rt.new_string(context)])
}

fn edit_post_link(var_text_arg rt.PhpVal, before string, after string, post i64, css_class string) {
	mut var_before := before
	mut var_after := after
	mut var_post := post
	mut var_css_class := css_class
	mut var_text := var_text_arg
	mut var_url := rt.new_null()
	mut var_link := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	if !(var_post != 0) {
		return
	}
	var_url = get_edit_post_link(rt.get_property(rt.new_int(var_post), 'ID'), '')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_url)))) {
		return
	}
	if rt.is_true(rt.identical(rt.new_null(), var_text)) {
		var_text = rt.call_function('__', [rt.new_string('Edit This')])
	}
	var_link = rt.new_string('<a class="' +
		(rt.call_function('esc_attr', [rt.new_string(css_class)])).str() + '" href="' +
		(rt.call_function('esc_url', [var_url.clone()])).str() + '">' + var_text.str() + '</a>')
	print(before +
		(rt.call_function('apply_filters', [rt.new_string('edit_post_link'), var_link.clone(), rt.get_property(rt.new_int(var_post), 'ID'), var_text.clone()])).str() +
		after)
}

fn get_delete_post_link(post i64, deprecated string, force_delete bool) rt.PhpVal {
	mut var_post := post
	mut var_deprecated := deprecated
	mut var_force_delete := force_delete
	mut var_post_type_object := rt.new_null()
	mut var_action := ''
	mut var_delete_link := rt.new_null()
	if !(deprecated == '') {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.0.0')])
	}
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	if !(var_post != 0) {
		return rt.new_null()
	}
	var_post_type_object = rt.call_function('get_post_type_object', [
		rt.get_property(rt.new_int(var_post), 'post_type'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_object)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_post'),
		rt.get_property(rt.new_int(var_post), 'ID'),
	])))))
	{
		return rt.new_null()
	}
	var_action = if rt.is_true(rt.new_bool(var_force_delete
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS')))))))
	{
		'delete'
	} else {
		'trash'
	}
	var_delete_link = rt.call_function('add_query_arg', [rt.new_string('action'),
		rt.new_string(var_action.str()).clone(),
		admin_url(rt.call_function('sprintf', [
			rt.get_property(var_post_type_object, '_edit_link'),
			rt.get_property(rt.new_int(var_post), 'ID'),
		]), '')])
	return rt.call_function('apply_filters', [rt.new_string('get_delete_post_link'),
		rt.call_function('wp_nonce_url', [var_delete_link.clone(),
			rt.concat(rt.concat(rt.new_string(var_action.str()), rt.new_string('-post_')), rt.get_property(rt.new_int(var_post),
				'ID'))]),
		rt.get_property(rt.new_int(var_post), 'ID'), rt.new_bool(force_delete)])
}

fn get_edit_comment_link(comment_id i64, context string) rt.PhpVal {
	mut var_comment_id := comment_id
	mut var_context := context
	mut var_comment := rt.new_null()
	mut var_action := ''
	mut var_location := rt.new_null()
	var_comment = rt.call_function('get_comment', [rt.new_int(var_comment_id)])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_comment.clone().is_object())))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_comment'), rt.get_property(var_comment, 'comment_ID')])))))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('display'), rt.new_string(context))) {
		var_action = 'comment.php?action=editcomment&amp;c='
	} else {
		var_action = 'comment.php?action=editcomment&c='
	}
	var_location = rt.new_string((admin_url(var_action, '')).str() +
		(rt.get_property(var_comment, 'comment_ID')).str())
	var_comment_id = rt.new_int((rt.get_property(var_comment, 'comment_ID')).to_i64())
	return rt.call_function('apply_filters', [rt.new_string('get_edit_comment_link'),
		var_location.clone(), rt.new_int(var_comment_id), rt.new_string(context)])
}

fn edit_comment_link(var_text_arg rt.PhpVal, before string, after string) {
	mut var_before := before
	mut var_after := after
	mut var_text := var_text_arg
	mut var_comment := rt.new_null()
	mut var_link := rt.new_null()
	var_comment = rt.call_function('get_comment', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_comment'),
		rt.get_property(var_comment, 'comment_ID'),
	])))))
	{
		return
	}
	if rt.is_true(rt.identical(rt.new_null(), var_text)) {
		var_text = rt.call_function('__', [rt.new_string('Edit This')])
	}
	var_link = rt.new_string('<a class="comment-edit-link" href="' +
		(rt.call_function('esc_url', [get_edit_comment_link(var_comment.clone(), '')])).str() +
		'">' + var_text.str() + '</a>')
	print(before +
		(rt.call_function('apply_filters', [rt.new_string('edit_comment_link'), var_link.clone(), rt.get_property(var_comment, 'comment_ID'), var_text.clone()])).str() +
		after)
}

fn get_edit_bookmark_link(link i64) rt.PhpVal {
	mut var_link := link
	mut var_location := rt.new_null()
	var_link = (rt.call_function('get_bookmark', [rt.new_int(var_link)])).to_i64()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_links'),
	])))))
	{
		return rt.new_null()
	}
	var_location = rt.new_string((admin_url('link.php?action=edit&amp;link_id=', '')).str() +
		(rt.get_property(rt.new_int(var_link), 'link_id')).str())
	return rt.call_function('apply_filters', [rt.new_string('get_edit_bookmark_link'),
		var_location.clone(), rt.get_property(rt.new_int(var_link), 'link_id')])
}

fn edit_bookmark_link(link string, before string, after string, var_bookmark_arg rt.PhpVal) {
	mut var_link := link
	mut var_before := before
	mut var_after := after
	mut var_bookmark := var_bookmark_arg
	var_bookmark = rt.call_function('get_bookmark', [var_bookmark.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_links'),
	])))))
	{
		return
	}
	if var_link == '' {
		var_link = (rt.call_function('__', [rt.new_string('Edit This')])).str()
	}
	var_link = '<a href="' +
		(rt.call_function('esc_url', [get_edit_bookmark_link(var_bookmark.clone())])).str() + '">' +
		var_link + '</a>'
	print(before +
		(rt.call_function('apply_filters', [rt.new_string('edit_bookmark_link'), rt.new_string(var_link.str()), rt.get_property(var_bookmark, 'link_id')])).str() +
		after)
}

fn get_edit_user_link(var_user_id_arg rt.PhpVal) string {
	mut var_user_id := var_user_id_arg
	mut var_user := rt.new_null()
	mut var_link := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_user_id)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), var_user_id.clone()])))))))
	{
		return ''
	}
	var_user = rt.call_function('get_userdata', [var_user_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return ''
	}
	if rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.get_property(var_user,
		'ID')))
	{
		var_link = get_edit_profile_url(rt.get_property(var_user, 'ID'), '')
	} else {
		var_link = rt.call_function('add_query_arg', [rt.new_string('user_id'),
			rt.get_property(var_user, 'ID'), self_admin_url('user-edit.php', '')])
	}
	return (rt.call_function('apply_filters', [rt.new_string('get_edit_user_link'),
		var_link.clone(), rt.get_property(var_user, 'ID')])).str()
}

fn get_previous_post(in_same_term bool, excluded_terms string, taxonomy string) rt.PhpVal {
	mut var_in_same_term := in_same_term
	mut var_excluded_terms := excluded_terms
	mut var_taxonomy := taxonomy
	return get_adjacent_post(in_same_term, excluded_terms, true, var_taxonomy)
}

fn get_next_post(in_same_term bool, excluded_terms string, taxonomy string) rt.PhpVal {
	mut var_in_same_term := in_same_term
	mut var_excluded_terms := excluded_terms
	mut var_taxonomy := taxonomy
	return get_adjacent_post(in_same_term, excluded_terms, false, var_taxonomy)
}

fn get_adjacent_post(in_same_term bool, excluded_terms string, previous bool, taxonomy string) rt.PhpVal {
	mut var_in_same_term := in_same_term
	mut var_excluded_terms := excluded_terms
	mut var_previous := previous
	mut var_taxonomy := taxonomy
	mut var_wpdb := rt.new_null()
	mut var_post := rt.new_null()
	mut var_current_post_date := rt.new_null()
	mut var_join := rt.new_null()
	mut var_where := rt.new_null()
	mut var_adjacent := ''
	mut var_term_array := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_post_type_cap := rt.new_null()
	mut var_read_private_cap := rt.new_null()
	mut var_private_states := rt.new_null()
	mut var_state := rt.new_null()
	mut var_comparison_operator := ''
	mut var_order := ''
	mut var_where_prepared := rt.new_null()
	mut var_sort := rt.new_null()
	mut var_query := ''
	mut var_key := ''
	mut var_last_changed := rt.new_null()
	mut var_cache_key := ''
	mut var_result := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_post))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [rt.new_string(var_taxonomy.str())])))))))
	{
		return rt.new_null()
	}
	var_current_post_date = rt.get_property(var_post, 'post_date')
	var_join = rt.new_string('')
	var_where = rt.new_string('')
	var_adjacent = if var_previous { 'previous' } else { 'next' }
	if rt.is_true(rt.new_bool(!(var_excluded_terms == '')
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.new_string(var_excluded_terms.str()).is_array())))))))
	{
		if rt.is_true(rt.call_function('str_contains', [
			rt.new_string(var_excluded_terms.str()),
			rt.new_string(' and '),
		]))
		{
			rt.call_function('_deprecated_argument', [rt.new_string(@FN),
				rt.new_string('3.3.0'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Use commas instead of %s to separate excluded terms.'),
					]),
					rt.new_string("'and'"),
				])])
			var_excluded_terms = (rt.call_function('explode', [
				rt.new_string(' and '), rt.new_string(var_excluded_terms.str())])).str()
		} else {
			var_excluded_terms = (rt.call_function('explode', [
				rt.new_string(','), rt.new_string(var_excluded_terms.str())])).str()
		}
		var_excluded_terms = (rt.call_function('array_map', [
			rt.new_string('intval'), rt.new_string(var_excluded_terms.str())])).str()
	}
	var_excluded_terms = (rt.call_function('apply_filters', [
		rt.new_string('get_${var_adjacent}_post_excluded_terms'),
		rt.new_string(var_excluded_terms.str()),
	])).str()
	if var_in_same_term || !(var_excluded_terms == '') {
		if var_in_same_term {
			var_join = rt.concat(var_join, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' INNER JOIN '), rt.get_property(var_wpdb,
				'term_relationships')), rt.new_string(' AS tr ON p.ID = tr.object_id INNER JOIN ')), rt.get_property(var_wpdb,
				'term_taxonomy')),
				rt.new_string(' AS tt ON tr.term_taxonomy_id = tt.term_taxonomy_id')))
			var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('AND tt.taxonomy = %s'),
				rt.new_string(var_taxonomy.str()),
			]))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_object_in_taxonomy', [
				rt.get_property(var_post, 'post_type'),
				rt.new_string(var_taxonomy.str()),
			])))))
			{
				return rt.new_string('')
			}
			var_term_array = rt.call_function('wp_get_object_terms', [
				rt.get_property(var_post, 'ID'),
				rt.new_string(var_taxonomy.str()),
				rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }]),
			])
			if rt.is_true(rt.call_function('is_wp_error', [var_term_array.clone()])) {
				return rt.new_string('')
			}
			var_term_array = rt.call_function('array_diff', [
				var_term_array.clone(), rt.cast_array(rt.new_string(var_excluded_terms.str()))])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_term_array)))) {
				return rt.new_string('')
			}
			var_term_array = rt.call_function('array_map', [rt.new_string('intval'),
				var_term_array.clone()])
			var_where = rt.concat(var_where, rt.new_string(
				' AND tt.term_id IN (' + (rt.call_function('implode', [rt.new_string(','), var_term_array.clone()])).str() +
				')'))
		}
		if !(var_excluded_terms == '') {
			var_where = rt.concat(var_where, rt.new_string(
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND p.ID NOT IN ( SELECT tr.object_id FROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' tr LEFT JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' tt ON (tr.term_taxonomy_id = tt.term_taxonomy_id) WHERE tt.term_id IN (')) + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('intval'), rt.new_string(var_excluded_terms.str())])])).str() +
				') )'))
		}
	}
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
		var_post_type_object = rt.call_function('get_post_type_object', [
			rt.get_property(var_post, 'post_type'),
		])
		if !rt.is_true(var_post_type_object) {
			var_post_type_cap = rt.get_property(var_post, 'post_type')
			var_read_private_cap = rt.new_string('read_private_' + var_post_type_cap.str() + 's')
		} else {
			var_read_private_cap = rt.get_property(rt.get_property(var_post_type_object, 'cap'),
				'read_private_posts')
		}
		var_private_states = rt.call_function('get_post_stati', [
			rt.create_array([rt.ArrayItem{ key: 'private', val: true }]),
		])
		var_where = rt.concat(var_where, rt.new_string(" AND ( p.post_status = 'publish'"))
		{
			mut iter_1 := var_private_states.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_state_shadow := item_1.val
				if rt.is_true(rt.call_function('current_user_can', [
					var_read_private_cap.clone()]))
				{
					var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [
						rt.new_string(' OR p.post_status = %s'),
						var_state_shadow.clone(),
					]))
				} else {
					var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [
						rt.new_string(' OR (p.post_author = %d AND p.post_status = %s)'),
						var_user_id.clone(),
						var_state_shadow.clone(),
					]))
				}
			}
		}
		var_where = rt.concat(var_where, rt.new_string(' )'))
	} else {
		var_where = rt.concat(var_where, rt.new_string(" AND p.post_status = 'publish'"))
	}
	var_comparison_operator = if var_previous { '<' } else { '>' }
	var_order = if var_previous { 'DESC' } else { 'ASC' }
	var_join = rt.call_function('apply_filters', [
		rt.new_string('get_${var_adjacent}_post_join'),
		var_join.clone(),
		rt.new_bool(in_same_term),
		rt.new_string(var_excluded_terms.str()),
		rt.new_string(var_taxonomy.str()),
		var_post.clone(),
	])
	var_where_prepared = rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('WHERE (p.post_date ${var_comparison_operator} %s OR (p.post_date = %s AND p.ID ${var_comparison_operator} %d)) AND p.post_type = %s ${var_where.to_string()}'),
		var_current_post_date.clone(),
		var_current_post_date.clone(),
		rt.get_property(var_post, 'ID'),
		rt.get_property(var_post, 'post_type'),
	])
	var_where = rt.call_function('apply_filters', [
		rt.new_string('get_${var_adjacent}_post_where'),
		var_where_prepared.clone(),
		rt.new_bool(in_same_term),
		rt.new_string(var_excluded_terms.str()),
		rt.new_string(var_taxonomy.str()),
		var_post.clone(),
	])
	var_sort = rt.call_function('apply_filters', [
		rt.new_string('get_${var_adjacent}_post_sort'),
		rt.new_string('ORDER BY p.post_date ${var_order}, p.ID ${var_order} LIMIT 1'),
		var_post.clone(),
		rt.new_string(var_order.str()).clone(),
	])
	var_query = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT p.ID FROM '), rt.get_property(var_wpdb,
		'posts')), rt.new_string(' AS p ')), var_join), rt.new_string(' ')), var_where),
		rt.new_string(' ')), var_sort)
	var_key = md5.hexhash(var_query)
	var_last_changed = rt.cast_array(rt.call_function('wp_cache_get_last_changed', [
		rt.new_string('posts'),
	]))
	if var_in_same_term || !(var_excluded_terms == '') {
		var_last_changed.array_push(rt.call_function('wp_cache_get_last_changed', [
			rt.new_string('terms'),
		]))
	}
	var_cache_key = 'adjacent_post:${var_key}'
	var_result = rt.call_function('wp_cache_get_salted', [rt.new_string(var_cache_key.str()).clone(),
		rt.new_string('post-queries'), var_last_changed.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_result)))) {
		if rt.is_true(var_result) {
			var_result = rt.call_function('get_post', [var_result.clone()])
		}
		return var_result.clone()
	}
	var_result = rt.call_method(var_wpdb, 'get_var', [rt.new_string(var_query.str()).clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
		var_result = rt.new_string('')
	}
	rt.call_function('wp_cache_set_salted', [rt.new_string(var_cache_key.str()).clone(),
		var_result.clone(), rt.new_string('post-queries'), var_last_changed.clone()])
	if rt.is_true(var_result) {
		var_result = rt.call_function('get_post', [var_result.clone()])
	}
	return var_result.clone()
}

fn get_adjacent_post_rel_link(title string, in_same_term bool, excluded_terms string, previous bool, taxonomy string) rt.PhpVal {
	mut var_title := title
	mut var_in_same_term := in_same_term
	mut var_excluded_terms := excluded_terms
	mut var_previous := previous
	mut var_taxonomy := taxonomy
	mut var_post := rt.new_null()
	mut var_post_title := rt.new_null()
	mut var_date := rt.new_null()
	mut var_link := ''
	mut var_adjacent := ''
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_previous
		&& rt.is_true(rt.call_function('is_attachment', []rt.PhpVal{})))) && rt.is_true(var_post)))
	{
		var_post = rt.call_function('get_post', [
			rt.get_property(var_post, 'post_parent'),
		])
	} else {
		var_post = get_adjacent_post(in_same_term, var_excluded_terms, previous, var_taxonomy)
	}
	if !rt.is_true(var_post) {
		return rt.new_null()
	}
	var_post_title = rt.call_function('the_title_attribute', [
		rt.create_array([rt.ArrayItem{ key: 'echo', val: false },
			rt.ArrayItem{ key: 'post', val: var_post }]),
	])
	if !rt.is_true(var_post_title) {
		var_post_title = if var_previous { rt.call_function('__', [
				rt.new_string('Previous Post'),
			]) } else { rt.call_function('__', [rt.new_string('Next Post')]) }
	}
	var_date = rt.call_function('mysql2date', [
		rt.call_function('get_option', [rt.new_string('date_format')]),
		rt.get_property(var_post, 'post_date'),
	])
	var_title = (rt.call_function('str_replace', [rt.new_string('%title'),
		var_post_title.clone(), rt.new_string(var_title.str())])).str()
	var_title = (rt.call_function('str_replace', [rt.new_string('%date'),
		var_date.clone(), rt.new_string(var_title.str())])).str()
	var_link = if var_previous { "<link rel='prev' title='" } else { "<link rel='next' title='" }
	var_link = var_link + (rt.call_function('esc_attr', [rt.new_string(var_title.str())])).str()
	var_link = var_link + "' href='" + get_permalink(var_post.clone()).str() + "' />\n"
	var_adjacent = if var_previous { 'previous' } else { 'next' }
	return rt.call_function('apply_filters', [
		rt.new_string('${var_adjacent}_post_rel_link'),
		rt.new_string(var_link.str()).clone(),
	])
}

fn adjacent_posts_rel_link(title string, in_same_term bool, excluded_terms string, taxonomy string) {
	mut var_title := title
	mut var_in_same_term := in_same_term
	mut var_excluded_terms := excluded_terms
	mut var_taxonomy := taxonomy
	rt.echo_val(get_adjacent_post_rel_link(var_title, in_same_term, var_excluded_terms, true,
		var_taxonomy))
	rt.echo_val(get_adjacent_post_rel_link(var_title, in_same_term, var_excluded_terms, false,
		var_taxonomy))
}

fn adjacent_posts_rel_link_wp_head() {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_single', []rt.PhpVal{})))))
		|| rt.is_true(rt.call_function('is_attachment', []rt.PhpVal{}))))
	{
		return
	}
	adjacent_posts_rel_link('', false, '', '')
}

fn next_post_rel_link(title string, in_same_term bool, excluded_terms string, taxonomy string) {
	mut var_title := title
	mut var_in_same_term := in_same_term
	mut var_excluded_terms := excluded_terms
	mut var_taxonomy := taxonomy
	rt.echo_val(get_adjacent_post_rel_link(var_title, in_same_term, var_excluded_terms, false,
		var_taxonomy))
}

fn prev_post_rel_link(title string, in_same_term bool, excluded_terms string, taxonomy string) {
	mut var_title := title
	mut var_in_same_term := in_same_term
	mut var_excluded_terms := excluded_terms
	mut var_taxonomy := taxonomy
	rt.echo_val(get_adjacent_post_rel_link(var_title, in_same_term, var_excluded_terms, true,
		var_taxonomy))
}

fn get_boundary_post(in_same_term bool, excluded_terms string, start bool, taxonomy string) rt.PhpVal {
	mut var_in_same_term := in_same_term
	mut var_excluded_terms := excluded_terms
	mut var_start := start
	mut var_taxonomy := taxonomy
	mut var_post := rt.new_null()
	mut var_query_args := map[string]rt.PhpVal{}
	mut var_term_array := rt.new_null()
	mut var_inverse_terms := []rt.PhpVal{}
	mut var_excluded_term := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_post))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_single', []rt.PhpVal{})))))))
		|| rt.is_true(rt.call_function('is_attachment', []rt.PhpVal{}))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [rt.new_string(var_taxonomy.str())])))))))
	{
		return rt.new_null()
	}
	var_query_args = {
		'posts_per_page':         rt.new_int(1)
		'order':                  if var_start { 'ASC' } else { 'DESC' }
		'update_post_term_cache': rt.new_bool(false)
		'update_post_meta_cache': rt.new_bool(false)
	}
	var_term_array = rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.new_string(var_excluded_terms.str()).is_array()))))) {
		if !(var_excluded_terms == '') {
			var_excluded_terms = (rt.call_function('explode', [
				rt.new_string(','), rt.new_string(var_excluded_terms.str())])).str()
		} else {
			var_excluded_terms = (rt.new_array()).str()
		}
	}
	if var_in_same_term || !(var_excluded_terms == '') {
		if var_in_same_term {
			var_term_array = rt.call_function('wp_get_object_terms', [
				rt.get_property(var_post, 'ID'),
				rt.new_string(var_taxonomy.str()),
				rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }]),
			])
		}
		if !(var_excluded_terms == '') {
			var_excluded_terms = (rt.call_function('array_map', [
				rt.new_string('intval'), rt.new_string(var_excluded_terms.str())])).str()
			var_excluded_terms = (rt.call_function('array_diff', [
				rt.new_string(var_excluded_terms.str()),
				var_term_array.clone(),
			])).str()
			var_inverse_terms = rt.new_array()
			{
				mut iter_1 := rt.new_string(var_excluded_terms.str()).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_excluded_term_shadow := item_1.val
					var_inverse_terms << rt.mul(var_excluded_term_shadow, -1)
				}
			}
			var_excluded_terms = var_inverse_terms.str()
		}
		var_query_args['tax_query'] = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
				rt.ArrayItem{ key: 'terms', val: rt.call_function('array_merge', [
					var_term_array.clone(),
					rt.new_string(var_excluded_terms.str()),
				]) },
			]) },
		])
	}
	return rt.call_function('get_posts', [
		rt.create_array_from_native_map(var_query_args),
	])
}

fn get_previous_post_link(format string, link string, in_same_term bool, excluded_terms string, taxonomy string) rt.PhpVal {
	mut var_format := format
	mut var_link := link
	mut var_in_same_term := in_same_term
	mut var_excluded_terms := excluded_terms
	mut var_taxonomy := taxonomy
	return get_adjacent_post_link(rt.new_string(format), rt.new_string(var_link.str()),
		in_same_term, var_excluded_terms, true, var_taxonomy)
}

fn previous_post_link(format string, link string, in_same_term bool, excluded_terms string, taxonomy string) {
	mut var_format := format
	mut var_link := link
	mut var_in_same_term := in_same_term
	mut var_excluded_terms := excluded_terms
	mut var_taxonomy := taxonomy
	rt.echo_val(get_previous_post_link(format, var_link, in_same_term, var_excluded_terms,
		var_taxonomy))
}

fn get_next_post_link(format string, link string, in_same_term bool, excluded_terms string, taxonomy string) rt.PhpVal {
	mut var_format := format
	mut var_link := link
	mut var_in_same_term := in_same_term
	mut var_excluded_terms := excluded_terms
	mut var_taxonomy := taxonomy
	return get_adjacent_post_link(rt.new_string(format), rt.new_string(var_link.str()),
		in_same_term, var_excluded_terms, false, var_taxonomy)
}

fn next_post_link(format string, link string, in_same_term bool, excluded_terms string, taxonomy string) {
	mut var_format := format
	mut var_link := link
	mut var_in_same_term := in_same_term
	mut var_excluded_terms := excluded_terms
	mut var_taxonomy := taxonomy
	rt.echo_val(get_next_post_link(format, var_link, in_same_term, var_excluded_terms, var_taxonomy))
}

fn get_adjacent_post_link(var_format rt.PhpVal, var_link rt.PhpVal, in_same_term bool, excluded_terms string, previous bool, taxonomy string) rt.PhpVal {
	mut var_in_same_term := in_same_term
	mut var_excluded_terms := excluded_terms
	mut var_previous := previous
	mut var_taxonomy := taxonomy
	mut var_post := rt.new_null()
	mut var_output := rt.new_null()
	mut var_title := rt.new_null()
	mut var_date := rt.new_null()
	mut var_rel := ''
	mut var_string := rt.new_null()
	mut var_inlink := rt.new_null()
	mut var_adjacent := ''
	if rt.is_true(rt.new_bool(var_previous
		&& rt.is_true(rt.call_function('is_attachment', []rt.PhpVal{}))))
	{
		var_post = rt.call_function('get_post', [
			rt.get_property(rt.call_function('get_post', []rt.PhpVal{}), 'post_parent'),
		])
	} else {
		var_post = get_adjacent_post(in_same_term, var_excluded_terms, previous, var_taxonomy)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		var_output = rt.new_string('')
	} else {
		var_title = rt.get_property(var_post, 'post_title')
		if !rt.is_true(rt.get_property(var_post, 'post_title')) {
			var_title = if var_previous { rt.call_function('__', [
					rt.new_string('Previous Post'),
				]) } else { rt.call_function('__', [rt.new_string('Next Post')]) }
		}
		var_title = rt.call_function('apply_filters', [rt.new_string('the_title'),
			var_title.clone(), rt.get_property(var_post, 'ID')])
		var_date = rt.call_function('mysql2date', [
			rt.call_function('get_option', [rt.new_string('date_format')]),
			rt.get_property(var_post, 'post_date'),
		])
		var_rel = if var_previous { 'prev' } else { 'next' }
		var_string = rt.new_string('<a href="' + get_permalink(var_post.clone()).str() + '" rel="' +
			var_rel + '">')
		var_inlink = rt.call_function('str_replace', [rt.new_string('%title'),
			var_title.clone(), var_link.clone()])
		var_inlink = rt.call_function('str_replace', [rt.new_string('%date'),
			var_date.clone(), var_inlink.clone()])
		var_inlink = rt.new_string(var_string.str() + var_inlink.str() + '</a>')
		var_output = rt.call_function('str_replace', [rt.new_string('%link'),
			var_inlink.clone(), var_format.clone()])
	}
	var_adjacent = if var_previous { 'previous' } else { 'next' }
	return rt.call_function('apply_filters', [rt.new_string('${var_adjacent}_post_link'),
		var_output.clone(), var_format.clone(), var_link.clone(),
		var_post.clone(), rt.new_string(var_adjacent.str()).clone()])
}

fn adjacent_post_link(var_format rt.PhpVal, var_link rt.PhpVal, in_same_term bool, excluded_terms string, previous bool, taxonomy string) {
	mut var_in_same_term := in_same_term
	mut var_excluded_terms := excluded_terms
	mut var_previous := previous
	mut var_taxonomy := taxonomy
	rt.echo_val(get_adjacent_post_link(var_format.clone(), var_link.clone(), in_same_term,
		var_excluded_terms, previous, var_taxonomy))
}

fn get_pagenum_link(pagenum i64, escape bool) rt.PhpVal {
	mut var_pagenum := pagenum
	mut var_escape := escape
	mut var_wp_rewrite := rt.new_null()
	mut var_qs_match := []rt.PhpVal{}
	mut var_request := rt.new_null()
	mut var_home_root := rt.new_null()
	mut var_base := rt.new_null()
	mut var_result := rt.new_null()
	mut var_qs_regex := ''
	mut var_parts := []rt.PhpVal{}
	mut var_query_string := rt.new_null()
	var_pagenum = var_pagenum
	var_request = rt.call_function('remove_query_arg', [rt.new_string('paged')])
	var_home_root = rt.call_function('parse_url', [home_url('', rt.new_null())])
	var_home_root = if !(var_home_root.array_get('path')).is_null() {
		var_home_root.array_get('path')
	} else {
		rt.new_string('')
	}
	var_home_root = rt.call_function('preg_quote', [var_home_root.clone(),
		rt.new_string('|')])
	var_request = rt.call_function('preg_replace', [
		rt.new_string('|^' + var_home_root.str() + '|i'),
		rt.new_string(''),
		var_request.clone(),
	])
	var_request = rt.call_function('preg_replace', [rt.new_string('|^/+|'),
		rt.new_string(''), var_request.clone()])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{})))))
		|| rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))
	{
		var_base = rt.call_function('trailingslashit', [
			rt.call_function('get_bloginfo', [rt.new_string('url')]),
		])
		if var_pagenum > 1 {
			var_result = rt.call_function('add_query_arg', [rt.new_string('paged'),
				rt.new_int(var_pagenum), rt.new_string(var_base.str() + var_request.str())])
		} else {
			var_result = rt.new_string(var_base.str() + var_request.str())
		}
	} else {
		var_qs_regex = '|\\?.*?$|'
		rt.call_function('preg_match', [rt.new_string(var_qs_regex.str()).clone(),
			var_request.clone(), rt.create_array_from_list(var_qs_match)])
		var_parts = rt.new_array()
		var_parts << rt.call_function('untrailingslashit', [
			rt.call_function('get_bloginfo', [rt.new_string('url')]),
		])
		if !(!rt.is_true(var_qs_match.array_get(0))) {
			var_query_string = var_qs_match.array_get(0)
			var_request = rt.call_function('preg_replace', [rt.new_string(var_qs_regex.str()).clone(),
				rt.new_string(''), var_request.clone()])
		} else {
			var_query_string = rt.new_string('')
		}
		var_request = rt.call_function('preg_replace', [
			rt.concat(rt.concat(rt.new_string('|'), rt.get_property(var_wp_rewrite,
				'pagination_base')), rt.new_string('/\\d+/?$|')),
			rt.new_string(''),
			var_request.clone(),
		])
		var_request = rt.call_function('preg_replace', [
			rt.new_string('|^' +
				(rt.call_function('preg_quote', [rt.get_property(var_wp_rewrite, 'index'), rt.new_string('|')])).str() +
				'|i'),
			rt.new_string(''),
			var_request.clone(),
		])
		var_request = rt.new_string(var_request.clone().to_string().trim_left(' \t\n\r'))
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.call_method(var_wp_rewrite, 'using_index_permalinks', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(var_pagenum > 1
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_request))))))))
		{
			var_parts << rt.get_property(var_wp_rewrite, 'index')
		}
		var_parts << rt.call_function('untrailingslashit', [var_request.clone()])
		if var_pagenum > 1 {
			var_parts << rt.get_property(var_wp_rewrite, 'pagination_base')
			var_parts << rt.new_int(var_pagenum)
		}
		var_result = user_trailingslashit(rt.call_function('implode', [
			rt.new_string('/'),
			rt.call_function('array_filter', [rt.create_array_from_list(var_parts)]),
		]), 'paged')
		if !(!rt.is_true(var_query_string)) {
			var_result = rt.concat(var_result, var_query_string)
		}
	}
	var_result = rt.call_function('apply_filters', [rt.new_string('get_pagenum_link'),
		var_result.clone(), rt.new_int(var_pagenum)])
	if var_escape {
		return rt.call_function('esc_url', [var_result.clone()])
	} else {
		return rt.call_function('sanitize_url', [var_result.clone()])
	}
	return rt.new_null()
}

fn get_next_posts_page_link(max_page i64) rt.PhpVal {
	mut var_max_page := max_page
	mut var_paged := i64(0)
	mut var_next_page := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_single', []rt.PhpVal{}))))) {
		if !(var_paged != 0) {
			var_paged = 1
		}
		var_next_page = rt.new_int(var_paged + 1)
		if rt.is_true(rt.new_bool(!(var_max_page != 0)
			|| rt.is_true(rt.greater_equal(rt.new_int(max_page), var_next_page))))
		{
			return get_pagenum_link(var_next_page.clone(), false)
		}
	}
	return rt.new_null()
}

fn next_posts(max_page i64, display bool) rt.PhpVal {
	mut var_max_page := max_page
	mut var_display := display
	mut var_link := rt.new_null()
	mut var_output := rt.new_null()
	var_link = get_next_posts_page_link(max_page)
	var_output = if rt.is_true(var_link) { rt.call_function('esc_url', [
			var_link.clone()]) } else { rt.new_string('') }
	if var_display {
		rt.echo_val(var_output)
	} else {
		return var_output.clone()
	}
	return rt.new_null()
}

fn get_next_posts_link(var_label_arg rt.PhpVal, max_page i64) rt.PhpVal {
	mut var_max_page := max_page
	mut var_label := var_label_arg
	mut var_wp_query := rt.new_null()
	mut var_paged := i64(0)
	mut var_next_page := rt.new_null()
	mut var_attr := rt.new_null()
	if !(var_max_page != 0) {
		var_max_page = (rt.get_property(var_wp_query, 'max_num_pages')).to_i64()
	}
	if !(var_paged != 0) {
		var_paged = 1
	}
	var_next_page = rt.new_int(var_paged + 1)
	if rt.is_true(rt.identical(rt.new_null(), var_label)) {
		var_label = rt.call_function('__', [rt.new_string('Next Page &raquo;')])
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_single', []rt.PhpVal{})))))
		&& rt.is_true(rt.less_equal(var_next_page, rt.new_int(var_max_page)))))
	{
		var_attr = rt.call_function('apply_filters', [
			rt.new_string('next_posts_link_attributes'),
			rt.new_string(''),
		])
		return rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" %2$s>%3$s</a>'),
			next_posts(var_max_page, false),
			var_attr.clone(),
			rt.call_function('preg_replace', [rt.new_string('/&([^#])(?![a-z]{1,8};)/i'),
				rt.new_string('&#038;$1'), var_label.clone()]),
		])
	}
	return rt.new_null()
}

fn next_posts_link(var_label rt.PhpVal, max_page i64) {
	mut var_max_page := max_page
	rt.echo_val(get_next_posts_link(var_label.clone(), var_max_page))
}

fn get_previous_posts_page_link() rt.PhpVal {
	mut var_paged := rt.new_null()
	mut var_previous_page := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_single', []rt.PhpVal{}))))) {
		var_previous_page = rt.new_int(var_paged.to_i64()) - 1
		if rt.is_true(rt.less(var_previous_page, rt.new_int(1))) {
			var_previous_page = rt.new_int(1)
		}
		return get_pagenum_link(var_previous_page.clone(), false)
	}
	return rt.new_null()
}

fn previous_posts(display bool) rt.PhpVal {
	mut var_display := display
	mut var_link := rt.new_null()
	mut var_output := rt.new_null()
	var_link = get_previous_posts_page_link()
	var_output = if rt.is_true(var_link) { rt.call_function('esc_url', [
			var_link.clone()]) } else { rt.new_string('') }
	if var_display {
		rt.echo_val(var_output)
	} else {
		return var_output.clone()
	}
	return rt.new_null()
}

fn get_previous_posts_link(var_label_arg rt.PhpVal) rt.PhpVal {
	mut var_label := var_label_arg
	mut var_paged := rt.new_null()
	mut var_attr := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_label)) {
		var_label = rt.call_function('__', [rt.new_string('&laquo; Previous Page')])
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_single', []rt.PhpVal{})))))
		&& rt.is_true(rt.greater(var_paged, rt.new_int(1)))))
	{
		var_attr = rt.call_function('apply_filters', [
			rt.new_string('previous_posts_link_attributes'),
			rt.new_string(''),
		])
		return rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" %2$s>%3$s</a>'),
			previous_posts(false),
			var_attr.clone(),
			rt.call_function('preg_replace', [rt.new_string('/&([^#])(?![a-z]{1,8};)/i'),
				rt.new_string('&#038;$1'), var_label.clone()]),
		])
	}
	return rt.new_null()
}

fn previous_posts_link(var_label rt.PhpVal) {
	rt.echo_val(get_previous_posts_link(var_label.clone()))
}

fn get_posts_nav_link(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_wp_query := rt.new_null()
	mut var_return := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_max_num_pages := rt.new_null()
	mut var_paged := rt.new_null()
	var_return = rt.new_string('')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))))) {
		var_defaults = {
			'sep':      rt.new_string(' &#8212; ')
			'prelabel': rt.call_function('__', [rt.new_string('&laquo; Previous Page')])
			'nxtlabel': rt.call_function('__', [rt.new_string('Next Page &raquo;')])
		}
		var_args = rt.call_function('wp_parse_args', [var_args.clone(),
			rt.create_array_from_native_map(var_defaults)])
		var_max_num_pages = rt.get_property(var_wp_query, 'max_num_pages')
		var_paged = rt.call_function('get_query_var', [rt.new_string('paged')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_paged, rt.new_int(2)))
			|| rt.is_true(rt.greater_equal(var_paged, var_max_num_pages))))
		{
			var_args.array_set('sep', '')
		}
		if rt.is_true(rt.greater(var_max_num_pages, rt.new_int(1))) {
			var_return = get_previous_posts_link(var_args.array_get('prelabel'))
			var_return = rt.concat(var_return, rt.call_function('preg_replace', [
				rt.new_string('/&([^#])(?![a-z]{1,8};)/i'),
				rt.new_string('&#038;$1'),
				var_args.array_get('sep'),
			]))
			var_return = rt.concat(var_return,
				get_next_posts_link(var_args.array_get('nxtlabel'), 0))
		}
	}
	return var_return.clone()
}

fn posts_nav_link(sep string, prelabel string, nxtlabel string) {
	mut var_sep := sep
	mut var_prelabel := prelabel
	mut var_nxtlabel := nxtlabel
	mut var_args := rt.new_null()
	var_args = rt.call_function('array_filter', [
		rt.call_function('compact', [rt.new_string('sep'), rt.new_string('prelabel'),
			rt.new_string('nxtlabel')]),
	])
	rt.echo_val(get_posts_nav_link(var_args.clone()))
}

fn get_the_post_navigation(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_navigation := rt.new_null()
	mut var_previous := rt.new_null()
	mut var_next := rt.new_null()
	if !(!rt.is_true(var_args.array_get('screen_reader_text')))
		&& !rt.is_true(var_args.array_get('aria_label')) {
		var_args.array_set('aria_label', var_args.array_get('screen_reader_text'))
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array([rt.ArrayItem{ key: 'prev_text', val: '%title' },
			rt.ArrayItem{ key: 'next_text', val: '%title' }, rt.ArrayItem{
				key: 'in_same_term'
				val: false
			}, rt.ArrayItem{ key: 'excluded_terms', val: '' },
			rt.ArrayItem{ key: 'taxonomy', val: 'category' },
			rt.ArrayItem{ key: 'screen_reader_text', val: rt.call_function('__', [
				rt.new_string('Post navigation'),
			]) }, rt.ArrayItem{ key: 'aria_label', val: rt.call_function('__', [
				rt.new_string('Posts'),
			]) }, rt.ArrayItem{ key: 'class', val: 'post-navigation' }])])
	var_navigation = rt.new_string('')
	var_previous = get_previous_post_link('<div class="nav-previous">%link</div>',
		var_args.array_get('prev_text'), var_args.array_get('in_same_term'),
		var_args.array_get('excluded_terms'), var_args.array_get('taxonomy'))
	var_next = get_next_post_link('<div class="nav-next">%link</div>',
		var_args.array_get('next_text'), var_args.array_get('in_same_term'),
		var_args.array_get('excluded_terms'), var_args.array_get('taxonomy'))
	if rt.is_true(rt.new_bool(rt.is_true(var_previous) || rt.is_true(var_next))) {
		var_navigation = _navigation_markup(rt.new_string(var_previous.str() + var_next.str()),
			var_args.array_get('class'), var_args.array_get('screen_reader_text'),
			var_args.array_get('aria_label'))
	}
	return var_navigation.clone()
}

fn the_post_navigation(var_args rt.PhpVal) {
	rt.echo_val(get_the_post_navigation(var_args.clone()))
}

fn get_the_posts_navigation(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_wp_query := rt.new_null()
	mut var_navigation := rt.new_null()
	mut var_next_link := rt.new_null()
	mut var_prev_link := rt.new_null()
	var_navigation = rt.new_string('')
	if rt.is_true(rt.greater(rt.get_property(var_wp_query, 'max_num_pages'), rt.new_int(1))) {
		if !(!rt.is_true(var_args.array_get('screen_reader_text')))
			&& !rt.is_true(var_args.array_get('aria_label')) {
			var_args.array_set('aria_label', var_args.array_get('screen_reader_text'))
		}
		var_args = rt.call_function('wp_parse_args', [var_args.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'prev_text', val: rt.call_function('__', [
					rt.new_string('Older posts'),
				]) },
				rt.ArrayItem{ key: 'next_text', val: rt.call_function('__', [
					rt.new_string('Newer posts'),
				]) },
				rt.ArrayItem{ key: 'screen_reader_text', val: rt.call_function('__', [
					rt.new_string('Posts navigation'),
				]) },
				rt.ArrayItem{ key: 'aria_label', val: rt.call_function('__', [
					rt.new_string('Posts'),
				]) },
				rt.ArrayItem{ key: 'class', val: 'posts-navigation' },
			])])
		var_next_link = get_previous_posts_link(var_args.array_get('next_text'))
		var_prev_link = get_next_posts_link(var_args.array_get('prev_text'), 0)
		if rt.is_true(var_prev_link) {
			var_navigation = rt.concat(var_navigation, rt.new_string('<div class="nav-previous">' +
				var_prev_link.str() + '</div>'))
		}
		if rt.is_true(var_next_link) {
			var_navigation = rt.concat(var_navigation, rt.new_string('<div class="nav-next">' +
				var_next_link.str() + '</div>'))
		}
		var_navigation = _navigation_markup(var_navigation.clone(), var_args.array_get('class'),
			var_args.array_get('screen_reader_text'), var_args.array_get('aria_label'))
	}
	return var_navigation.clone()
}

fn the_posts_navigation(var_args rt.PhpVal) {
	rt.echo_val(get_the_posts_navigation(var_args.clone()))
}

fn get_the_posts_pagination(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_wp_query := rt.new_null()
	mut var_navigation := rt.new_null()
	mut var_links := rt.new_null()
	var_navigation = rt.new_string('')
	if rt.is_true(rt.greater(rt.get_property(var_wp_query, 'max_num_pages'), rt.new_int(1))) {
		if !(!rt.is_true(var_args.array_get('screen_reader_text')))
			&& !rt.is_true(var_args.array_get('aria_label')) {
			var_args.array_set('aria_label', var_args.array_get('screen_reader_text'))
		}
		var_args = rt.call_function('wp_parse_args', [var_args.clone(),
			rt.create_array([rt.ArrayItem{ key: 'mid_size', val: 1 },
				rt.ArrayItem{ key: 'prev_text', val: rt.call_function('_x', [
					rt.new_string('Previous'),
					rt.new_string('previous set of posts'),
				]) }, rt.ArrayItem{ key: 'next_text', val: rt.call_function('_x', [
					rt.new_string('Next'),
					rt.new_string('next set of posts'),
				]) }, rt.ArrayItem{ key: 'screen_reader_text', val: rt.call_function('__', [
					rt.new_string('Posts pagination'),
				]) }, rt.ArrayItem{ key: 'aria_label', val: rt.call_function('__', [
					rt.new_string('Posts pagination'),
				]) }, rt.ArrayItem{ key: 'class', val: 'pagination' }])])
		var_args = rt.call_function('apply_filters', [
			rt.new_string('the_posts_pagination_args'),
			var_args.clone(),
		])
		if rt.is_true(rt.new_bool(var_args.array_isset(rt.new_string('type'))
			&& rt.is_true(rt.identical(rt.new_string('array'), var_args.array_get('type')))))
		{
			var_args.array_set('type', 'plain')
		}
		var_links = rt.call_function('paginate_links', [var_args.clone()])
		if rt.is_true(var_links) {
			var_navigation = _navigation_markup(var_links.clone(), var_args.array_get('class'),
				var_args.array_get('screen_reader_text'), var_args.array_get('aria_label'))
		}
	}
	return var_navigation.clone()
}

fn the_posts_pagination(var_args rt.PhpVal) {
	rt.echo_val(get_the_posts_pagination(var_args.clone()))
}

fn _navigation_markup(var_links rt.PhpVal, css_class string, screen_reader_text string, aria_label string) rt.PhpVal {
	mut var_css_class := css_class
	mut var_screen_reader_text := screen_reader_text
	mut var_aria_label := aria_label
	mut var_template := rt.new_null()
	if var_screen_reader_text == '' {
		var_screen_reader_text = (rt.call_function('__', [
			rt.new_string('Posts navigation'),
		])).str()
	}
	if var_aria_label == '' {
		var_aria_label = var_screen_reader_text
	}
	var_template =
		rt.new_string('\n\t<nav class="navigation %1$s" aria-label="%4$s">\n\t\t<h2 class="screen-reader-text">%2$s</h2>\n\t\t<div class="nav-links">%3$s</div>\n\t</nav>')
	var_template = rt.call_function('apply_filters', [
		rt.new_string('navigation_markup_template'),
		var_template.clone(),
		rt.new_string(css_class),
	])
	return rt.call_function('sprintf', [var_template.clone(),
		rt.call_function('sanitize_html_class', [rt.new_string(css_class)]),
		rt.call_function('esc_html', [rt.new_string(var_screen_reader_text.str())]),
		var_links.clone(), rt.call_function('esc_attr', [rt.new_string(var_aria_label.str())])])
}

fn get_comments_pagenum_link(pagenum i64, max_page i64) rt.PhpVal {
	mut var_pagenum := pagenum
	mut var_max_page := max_page
	mut var_wp_rewrite := rt.new_null()
	mut var_result := rt.new_null()
	var_pagenum = var_pagenum
	var_max_page = var_max_page
	var_result = rt.new_bool(get_permalink(0, false))
	if rt.is_true(rt.identical(rt.new_string('newest'), rt.call_function('get_option', [
		rt.new_string('default_comments_page'),
	])))
	{
		if rt.is_true(rt.new_bool(var_pagenum != var_max_page)) {
			if rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{})) {
				var_result = user_trailingslashit(rt.new_string(
					(rt.call_function('trailingslashit', [var_result.clone()])).str() +
					(rt.get_property(var_wp_rewrite, 'comments_pagination_base')).str() + '-' +
					var_pagenum.str()), 'commentpaged')
			} else {
				var_result = rt.call_function('add_query_arg', [
					rt.new_string('cpage'), rt.new_int(var_pagenum),
					var_result.clone()])
			}
		}
	} else if var_pagenum > 1 {
		if rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{})) {
			var_result = user_trailingslashit(rt.new_string(
				(rt.call_function('trailingslashit', [var_result.clone()])).str() +
				(rt.get_property(var_wp_rewrite, 'comments_pagination_base')).str() + '-' +
				var_pagenum.str()), 'commentpaged')
		} else {
			var_result = rt.call_function('add_query_arg', [rt.new_string('cpage'),
				rt.new_int(var_pagenum), var_result.clone()])
		}
	}
	var_result = rt.concat(var_result, rt.new_string('#comments'))
	return rt.call_function('apply_filters', [rt.new_string('get_comments_pagenum_link'),
		var_result.clone()])
}

fn get_next_comments_link(label string, max_page i64, var_page_arg rt.PhpVal) rt.PhpVal {
	mut var_label := label
	mut var_max_page := max_page
	mut var_page := var_page_arg
	mut var_wp_query := rt.new_null()
	mut var_next_page := rt.new_null()
	mut var_attr := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(var_page.clone().is_null())) {
		var_page = rt.call_function('get_query_var', [rt.new_string('cpage')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_page)))) {
		var_page = rt.new_int(1)
	}
	var_next_page = rt.new_int(var_page.to_i64()) + 1
	if var_max_page == 0 {
		var_max_page = (rt.get_property(var_wp_query, 'max_num_comment_pages')).to_i64()
	}
	if var_max_page == 0 {
		var_max_page = (rt.call_function('get_comment_pages_count', []rt.PhpVal{})).to_i64()
	}
	if rt.is_true(rt.greater(var_next_page, rt.new_int(var_max_page))) {
		return rt.new_null()
	}
	if var_label == '' {
		var_label = (rt.call_function('__', [rt.new_string('Newer Comments &raquo;')])).str()
	}
	var_attr = rt.call_function('apply_filters', [
		rt.new_string('next_comments_link_attributes'),
		rt.new_string(''),
	])
	return rt.call_function('sprintf', [rt.new_string('<a href="%1$s" %2$s>%3$s</a>'),
		rt.call_function('esc_url', [
			get_comments_pagenum_link(var_next_page.clone(), var_max_page),
		]),
		var_attr.clone(),
		rt.call_function('preg_replace', [
			rt.new_string('/&([^#])(?![a-z]{1,8};)/i'),
			rt.new_string('&#038;$1'),
			rt.new_string(var_label.str()),
		])])
}

fn next_comments_link(label string, max_page i64) {
	mut var_label := label
	mut var_max_page := max_page
	rt.echo_val(get_next_comments_link(var_label, var_max_page, rt.new_null()))
}

fn get_previous_comments_link(label string, var_page_arg rt.PhpVal) rt.PhpVal {
	mut var_label := label
	mut var_page := var_page_arg
	mut var_previous_page := rt.new_null()
	mut var_attr := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(var_page.clone().is_null())) {
		var_page = rt.call_function('get_query_var', [rt.new_string('cpage')])
	}
	if rt.new_int(var_page.to_i64()) <= 1 {
		return rt.new_null()
	}
	var_previous_page = rt.new_int(var_page.to_i64()) - 1
	if var_label == '' {
		var_label = (rt.call_function('__', [rt.new_string('&laquo; Older Comments')])).str()
	}
	var_attr = rt.call_function('apply_filters', [
		rt.new_string('previous_comments_link_attributes'),
		rt.new_string(''),
	])
	return rt.call_function('sprintf', [rt.new_string('<a href="%1$s" %2$s>%3$s</a>'),
		rt.call_function('esc_url', [
			get_comments_pagenum_link(var_previous_page.clone(), 0),
		]),
		var_attr.clone(),
		rt.call_function('preg_replace', [
			rt.new_string('/&([^#])(?![a-z]{1,8};)/i'),
			rt.new_string('&#038;$1'),
			rt.new_string(var_label.str()),
		])])
}

fn previous_comments_link(label string) {
	mut var_label := label
	rt.echo_val(get_previous_comments_link(var_label, rt.new_null()))
}

fn paginate_comments_links(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_wp_rewrite := rt.new_null()
	mut var_page := rt.new_null()
	mut var_max_page := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_page_links := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	var_page = rt.call_function('get_query_var', [rt.new_string('cpage')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_page)))) {
		var_page = rt.new_int(1)
	}
	var_max_page = rt.call_function('get_comment_pages_count', []rt.PhpVal{})
	var_defaults = {
		'base':         rt.call_function('add_query_arg', [rt.new_string('cpage'),
			rt.new_string('%#%')])
		'format':       rt.new_string('')
		'total':        var_max_page
		'current':      var_page
		'echo':         rt.new_bool(true)
		'type':         rt.new_string('plain')
		'add_fragment': rt.new_string('#comments')
	}
	if rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{})) {
		var_defaults['base'] = user_trailingslashit(rt.new_string(
			(rt.call_function('trailingslashit', [rt.new_bool(get_permalink(0, false))])).str() +
			(rt.get_property(var_wp_rewrite, 'comments_pagination_base')).str() + '-%#%'),
			'commentpaged')
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	var_page_links = rt.call_function('paginate_links', [var_args.clone()])
	if rt.is_true(rt.new_bool(rt.is_true(var_args.array_get('echo'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('array'), var_args.array_get('type')))))))
	{
		rt.echo_val(var_page_links)
	} else {
		return var_page_links.clone()
	}
	return rt.new_null()
}

fn get_the_comments_navigation(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_navigation := rt.new_null()
	mut var_prev_link := rt.new_null()
	mut var_next_link := rt.new_null()
	var_navigation = rt.new_string('')
	if rt.is_true(rt.greater(rt.call_function('get_comment_pages_count', []rt.PhpVal{}),
		rt.new_int(1)))
	{
		if !(!rt.is_true(var_args.array_get('screen_reader_text')))
			&& !rt.is_true(var_args.array_get('aria_label')) {
			var_args.array_set('aria_label', var_args.array_get('screen_reader_text'))
		}
		var_args = rt.call_function('wp_parse_args', [var_args.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'prev_text', val: rt.call_function('__', [
					rt.new_string('Older comments'),
				]) },
				rt.ArrayItem{ key: 'next_text', val: rt.call_function('__', [
					rt.new_string('Newer comments'),
				]) },
				rt.ArrayItem{ key: 'screen_reader_text', val: rt.call_function('__', [
					rt.new_string('Comments navigation'),
				]) },
				rt.ArrayItem{ key: 'aria_label', val: rt.call_function('__', [
					rt.new_string('Comments'),
				]) },
				rt.ArrayItem{ key: 'class', val: 'comment-navigation' },
			])])
		var_prev_link = get_previous_comments_link(var_args.array_get('prev_text'), rt.new_null())
		var_next_link = get_next_comments_link(var_args.array_get('next_text'), 0, rt.new_null())
		if rt.is_true(var_prev_link) {
			var_navigation = rt.concat(var_navigation, rt.new_string('<div class="nav-previous">' +
				var_prev_link.str() + '</div>'))
		}
		if rt.is_true(var_next_link) {
			var_navigation = rt.concat(var_navigation, rt.new_string('<div class="nav-next">' +
				var_next_link.str() + '</div>'))
		}
		var_navigation = _navigation_markup(var_navigation.clone(), var_args.array_get('class'),
			var_args.array_get('screen_reader_text'), var_args.array_get('aria_label'))
	}
	return var_navigation.clone()
}

fn the_comments_navigation(var_args rt.PhpVal) {
	rt.echo_val(get_the_comments_navigation(var_args.clone()))
}

fn get_the_comments_pagination(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_navigation := rt.new_null()
	mut var_links := rt.new_null()
	var_navigation = rt.new_string('')
	if !(!rt.is_true(var_args.array_get('screen_reader_text')))
		&& !rt.is_true(var_args.array_get('aria_label')) {
		var_args.array_set('aria_label', var_args.array_get('screen_reader_text'))
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'screen_reader_text', val: rt.call_function('__', [
				rt.new_string('Comments pagination'),
			]) },
			rt.ArrayItem{ key: 'aria_label', val: rt.call_function('__', [
				rt.new_string('Comments pagination'),
			]) },
			rt.ArrayItem{ key: 'class', val: 'comments-pagination' },
		])])
	var_args.array_set('echo', false)
	if rt.is_true(rt.new_bool(var_args.array_isset(rt.new_string('type'))
		&& rt.is_true(rt.identical(rt.new_string('array'), var_args.array_get('type')))))
	{
		var_args.array_set('type', 'plain')
	}
	var_links = paginate_comments_links(var_args.clone())
	if rt.is_true(var_links) {
		var_navigation = _navigation_markup(var_links.clone(), var_args.array_get('class'),
			var_args.array_get('screen_reader_text'), var_args.array_get('aria_label'))
	}
	return var_navigation.clone()
}

fn the_comments_pagination(var_args rt.PhpVal) {
	rt.echo_val(get_the_comments_pagination(var_args.clone()))
}

fn home_url(path string, var_scheme rt.PhpVal) rt.PhpVal {
	mut var_path := path
	return get_home_url(rt.new_null(), path, var_scheme.clone())
}

fn get_home_url(var_blog_id rt.PhpVal, path string, var_scheme_arg rt.PhpVal) rt.PhpVal {
	mut var_path := path
	mut var_scheme := var_scheme_arg
	mut var_orig_scheme := rt.new_null()
	mut var_url := rt.new_null()
	var_orig_scheme = var_scheme.clone()
	if rt.is_true(rt.new_bool(!rt.is_true(var_blog_id)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))))
	{
		var_url = rt.call_function('get_option', [rt.new_string('home')])
	} else {
		rt.call_function('switch_to_blog', [var_blog_id.clone()])
		var_url = rt.call_function('get_option', [rt.new_string('home')])
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_scheme.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'http' },
			rt.ArrayItem{ key: none, val: 'https' }, rt.ArrayItem{ key: none, val: 'relative' }]),
		rt.new_bool(true)])))))
	{
		if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
			var_scheme = rt.new_string('https')
		} else {
			var_scheme = rt.call_function('parse_url', [var_url.clone(),
				rt.get_constant('PHP_URL_SCHEME')])
		}
	}
	var_url = set_url_scheme(var_url.clone(), var_scheme.clone())
	if rt.is_true(rt.new_bool(var_path.len > 0 && var_path != '0'
		&& rt.is_true(rt.new_bool(rt.new_string(path).is_string()))))
	{
		var_url = rt.concat(var_url, rt.new_string('/' + path.trim_left(' \t\n\r')))
	}
	return rt.call_function('apply_filters', [rt.new_string('home_url'),
		var_url.clone(), rt.new_string(path), var_orig_scheme.clone(),
		var_blog_id.clone()])
}

fn site_url(path string, var_scheme rt.PhpVal) rt.PhpVal {
	mut var_path := path
	return get_site_url(rt.new_null(), path, var_scheme.clone())
}

fn get_site_url(var_blog_id rt.PhpVal, path string, var_scheme rt.PhpVal) rt.PhpVal {
	mut var_path := path
	mut var_url := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(var_blog_id)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))))
	{
		var_url = rt.call_function('get_option', [rt.new_string('siteurl')])
	} else {
		rt.call_function('switch_to_blog', [var_blog_id.clone()])
		var_url = rt.call_function('get_option', [rt.new_string('siteurl')])
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
	var_url = set_url_scheme(var_url.clone(), var_scheme.clone())
	if rt.is_true(rt.new_bool(var_path.len > 0 && var_path != '0'
		&& rt.is_true(rt.new_bool(rt.new_string(path).is_string()))))
	{
		var_url = rt.concat(var_url, rt.new_string('/' + path.trim_left(' \t\n\r')))
	}
	return rt.call_function('apply_filters', [rt.new_string('site_url'),
		var_url.clone(), rt.new_string(path), var_scheme.clone(),
		var_blog_id.clone()])
}

fn admin_url(path string, scheme string) rt.PhpVal {
	mut var_path := path
	mut var_scheme := scheme
	return get_admin_url(rt.new_null(), path, scheme)
}

fn get_admin_url(var_blog_id rt.PhpVal, path string, scheme string) rt.PhpVal {
	mut var_path := path
	mut var_scheme := scheme
	mut var_url := rt.new_null()
	var_url = get_site_url(var_blog_id.clone(), 'wp-admin/', rt.new_string(scheme))
	if rt.is_true(rt.new_bool(var_path.len > 0 && var_path != '0'
		&& rt.is_true(rt.new_bool(rt.new_string(path).is_string()))))
	{
		var_url = rt.concat(var_url, rt.new_string(path.trim_left(' \t\n\r')))
	}
	return rt.call_function('apply_filters', [rt.new_string('admin_url'),
		var_url.clone(), rt.new_string(path), var_blog_id.clone(),
		rt.new_string(scheme)])
}

fn includes_url(path string, var_scheme rt.PhpVal) rt.PhpVal {
	mut var_path := path
	mut var_url := rt.new_null()
	var_url = site_url('/' + (rt.get_constant('WPINC')).str() + '/', var_scheme.clone())
	if rt.is_true(rt.new_bool(var_path.len > 0 && var_path != '0'
		&& rt.is_true(rt.new_bool(rt.new_string(path).is_string()))))
	{
		var_url = rt.concat(var_url, rt.new_string(path.trim_left(' \t\n\r')))
	}
	return rt.call_function('apply_filters', [rt.new_string('includes_url'),
		var_url.clone(), rt.new_string(path), var_scheme.clone()])
}

fn content_url(path string) rt.PhpVal {
	mut var_path := path
	mut var_url := rt.new_null()
	var_url = set_url_scheme(rt.get_constant('WP_CONTENT_URL'), rt.new_null())
	if rt.is_true(rt.new_bool(var_path.len > 0 && var_path != '0'
		&& rt.is_true(rt.new_bool(rt.new_string(path).is_string()))))
	{
		var_url = rt.concat(var_url, rt.new_string('/' + path.trim_left(' \t\n\r')))
	}
	return rt.call_function('apply_filters', [rt.new_string('content_url'),
		var_url.clone(), rt.new_string(path)])
}

fn plugins_url(path string, plugin string) rt.PhpVal {
	mut var_path := path
	mut var_plugin := plugin
	mut var_mu_plugin_dir := rt.new_null()
	mut var_url := rt.new_null()
	mut var_folder := rt.new_null()
	var_path = (rt.call_function('wp_normalize_path', [rt.new_string(var_path.str())])).str()
	var_plugin = (rt.call_function('wp_normalize_path', [
		rt.new_string(var_plugin.str()),
	])).str()
	var_mu_plugin_dir = rt.call_function('wp_normalize_path', [
		rt.get_constant('WPMU_PLUGIN_DIR'),
	])
	if rt.is_true(rt.new_bool(!(var_plugin == '')
		&& rt.is_true(rt.call_function('str_starts_with', [rt.new_string(var_plugin.str()), var_mu_plugin_dir.clone()]))))
	{
		var_url = rt.get_constant('WPMU_PLUGIN_URL')
	} else {
		var_url = rt.get_constant('WP_PLUGIN_URL')
	}
	var_url = set_url_scheme(var_url.clone(), rt.new_null())
	if rt.is_true(rt.new_bool(!(var_plugin == '')
		&& rt.is_true(rt.new_bool(rt.new_string(var_plugin.str()).is_string()))))
	{
		var_folder = rt.call_function('dirname', [
			rt.call_function('plugin_basename', [rt.new_string(var_plugin.str())]),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('.'), var_folder)))) {
			var_url = rt.concat(var_url, rt.new_string('/' +
				var_folder.clone().to_string().trim_left(' \t\n\r')))
		}
	}
	if rt.is_true(rt.new_bool(var_path.len > 0 && var_path != '0'
		&& rt.is_true(rt.new_bool(rt.new_string(var_path.str()).is_string()))))
	{
		var_url = rt.concat(var_url, rt.new_string('/' + var_path.trim_left(' \t\n\r')))
	}
	return rt.call_function('apply_filters', [rt.new_string('plugins_url'),
		var_url.clone(), rt.new_string(var_path.str()), rt.new_string(var_plugin.str())])
}

fn network_site_url(path string, var_scheme rt.PhpVal) rt.PhpVal {
	mut var_path := path
	mut var_current_network := rt.new_null()
	mut var_url := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return site_url(var_path, var_scheme.clone())
	}
	var_current_network = rt.call_function('get_network', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('relative'), var_scheme)) {
		var_url = rt.get_property(var_current_network, 'path')
	} else {
		var_url = set_url_scheme(rt.new_string('http://' +
			(rt.get_property(var_current_network, 'domain')).str() +
			(rt.get_property(var_current_network, 'path')).str()), var_scheme.clone())
	}
	if rt.is_true(rt.new_bool(var_path.len > 0 && var_path != '0'
		&& rt.is_true(rt.new_bool(rt.new_string(var_path.str()).is_string()))))
	{
		var_url = rt.concat(var_url, rt.new_string(var_path.trim_left(' \t\n\r')))
	}
	return rt.call_function('apply_filters', [rt.new_string('network_site_url'),
		var_url.clone(), rt.new_string(var_path.str()), var_scheme.clone()])
}

fn network_home_url(path string, var_scheme_arg rt.PhpVal) rt.PhpVal {
	mut var_path := path
	mut var_scheme := var_scheme_arg
	mut var_current_network := rt.new_null()
	mut var_orig_scheme := rt.new_null()
	mut var_url := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return home_url(var_path, var_scheme.clone())
	}
	var_current_network = rt.call_function('get_network', []rt.PhpVal{})
	var_orig_scheme = var_scheme.clone()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_scheme.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'http' },
			rt.ArrayItem{ key: none, val: 'https' }, rt.ArrayItem{ key: none, val: 'relative' }]),
		rt.new_bool(true)])))))
	{
		var_scheme = rt.new_string((if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
			'https'
		} else {
			'http'
		}).str())
	}
	if rt.is_true(rt.identical(rt.new_string('relative'), var_scheme)) {
		var_url = rt.get_property(var_current_network, 'path')
	} else {
		var_url = set_url_scheme(rt.new_string('http://' +
			(rt.get_property(var_current_network, 'domain')).str() +
			(rt.get_property(var_current_network, 'path')).str()), var_scheme.clone())
	}
	if rt.is_true(rt.new_bool(var_path.len > 0 && var_path != '0'
		&& rt.is_true(rt.new_bool(rt.new_string(var_path.str()).is_string()))))
	{
		var_url = rt.concat(var_url, rt.new_string(var_path.trim_left(' \t\n\r')))
	}
	return rt.call_function('apply_filters', [rt.new_string('network_home_url'),
		var_url.clone(), rt.new_string(var_path.str()), var_orig_scheme.clone()])
}

fn network_admin_url(path string, scheme string) rt.PhpVal {
	mut var_path := path
	mut var_scheme := scheme
	mut var_url := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return admin_url(var_path, scheme)
	}
	var_url = network_site_url('wp-admin/network/', rt.new_string(scheme))
	if rt.is_true(rt.new_bool(var_path.len > 0 && var_path != '0'
		&& rt.is_true(rt.new_bool(rt.new_string(var_path.str()).is_string()))))
	{
		var_url = rt.concat(var_url, rt.new_string(var_path.trim_left(' \t\n\r')))
	}
	return rt.call_function('apply_filters', [rt.new_string('network_admin_url'),
		var_url.clone(), rt.new_string(var_path.str()), rt.new_string(scheme)])
}

fn user_admin_url(path string, scheme string) rt.PhpVal {
	mut var_path := path
	mut var_scheme := scheme
	mut var_url := rt.new_null()
	var_url = network_site_url('wp-admin/user/', rt.new_string(scheme))
	if rt.is_true(rt.new_bool(var_path.len > 0 && var_path != '0'
		&& rt.is_true(rt.new_bool(rt.new_string(var_path.str()).is_string()))))
	{
		var_url = rt.concat(var_url, rt.new_string(var_path.trim_left(' \t\n\r')))
	}
	return rt.call_function('apply_filters', [rt.new_string('user_admin_url'),
		var_url.clone(), rt.new_string(var_path.str()), rt.new_string(scheme)])
}

fn self_admin_url(path string, scheme string) rt.PhpVal {
	mut var_path := path
	mut var_scheme := scheme
	mut var_url := rt.new_null()
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		var_url = network_admin_url(var_path, scheme)
	} else if rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{})) {
		var_url = user_admin_url(var_path, scheme)
	} else {
		var_url = admin_url(var_path, scheme)
	}
	return rt.call_function('apply_filters', [rt.new_string('self_admin_url'),
		var_url.clone(), rt.new_string(var_path.str()), rt.new_string(scheme)])
}

fn set_url_scheme(var_url_arg rt.PhpVal, var_scheme_arg rt.PhpVal) rt.PhpVal {
	mut var_url := var_url_arg
	mut var_scheme := var_scheme_arg
	mut var_orig_scheme := rt.new_null()
	var_orig_scheme = var_scheme.clone()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_scheme)))) {
		var_scheme = rt.new_string((if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
			'https'
		} else {
			'http'
		}).str())
	} else if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('admin'), var_scheme))
		|| rt.is_true(rt.identical(rt.new_string('login'), var_scheme))))
		|| rt.is_true(rt.identical(rt.new_string('login_post'), var_scheme))))
		|| rt.is_true(rt.identical(rt.new_string('rpc'), var_scheme))))
	{
		var_scheme = rt.new_string((if rt.is_true(rt.new_bool(
			rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('force_ssl_admin', []rt.PhpVal{}))))
		{
			'https'
		} else {
			'http'
		}).str())
	} else if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('http'), var_scheme))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('https'), var_scheme))))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('relative'), var_scheme))))))
	{
		var_scheme = rt.new_string((if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
			'https'
		} else {
			'http'
		}).str())
	}
	var_url = rt.new_string(var_url.clone().to_string().trim_space())
	if rt.is_true(rt.call_function('str_starts_with', [var_url.clone(),
		rt.new_string('//')]))
	{
		var_url = rt.new_string('http:' + var_url.str())
	}
	if rt.is_true(rt.identical(rt.new_string('relative'), var_scheme)) {
		var_url = rt.new_string(rt.call_function('preg_replace', [
			rt.new_string('#^\\w+://[^/]*#'),
			rt.new_string(''),
			var_url.clone(),
		]).to_string().trim_left(' \t\n\r'))
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_url))))
			&& rt.is_true(rt.identical(rt.new_string('/'), var_url.array_get(0)))))
		{
			var_url = rt.new_string('/' + var_url.clone().to_string().trim_left(' \t\n\r'))
		}
	} else {
		var_url = rt.call_function('preg_replace', [rt.new_string('#^\\w+://#'),
			rt.new_string(var_scheme.str() + '://'), var_url.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('set_url_scheme'),
		var_url.clone(), var_scheme.clone(), var_orig_scheme.clone()])
}

fn get_dashboard_url(user_id i64, path string, scheme string) rt.PhpVal {
	mut var_user_id := user_id
	mut var_path := path
	mut var_scheme := scheme
	mut var_blogs := rt.new_null()
	mut var_url := rt.new_null()
	mut var_current_blog := rt.new_null()
	mut var_active := rt.new_null()
	var_user_id = (if var_user_id != 0 {
		var_user_id
	} else {
		rt.call_function('get_current_user_id', []rt.PhpVal{})
	}).to_i64()
	var_blogs = rt.call_function('get_blogs_of_user', [rt.new_int(var_user_id)])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('user_can', [rt.new_int(var_user_id), rt.new_string('manage_network')])))))))
		&& !rt.is_true(var_blogs)))
	{
		var_url = user_admin_url(var_path, scheme)
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_url = admin_url(var_path, scheme)
	} else {
		var_current_blog = rt.call_function('get_current_blog_id', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(var_current_blog)
			&& rt.is_true(rt.new_bool(rt.is_true(rt.call_function('user_can', [rt.new_int(var_user_id), rt.new_string('manage_network')]))
			|| rt.is_true(rt.call_function('in_array', [var_current_blog.clone(), rt.func_array_keys(var_blogs.clone()), rt.new_bool(true)]))))))
		{
			var_url = admin_url(var_path, scheme)
		} else {
			var_active = rt.call_function('get_active_blog_for_user', [
				rt.new_int(var_user_id),
			])
			if rt.is_true(var_active) {
				var_url = get_admin_url(rt.get_property(var_active, 'blog_id'), var_path, scheme)
			} else {
				var_url = user_admin_url(var_path, scheme)
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('user_dashboard_url'),
		var_url.clone(), rt.new_int(var_user_id), rt.new_string(var_path.str()),
		rt.new_string(scheme)])
}

fn get_edit_profile_url(user_id i64, scheme string) rt.PhpVal {
	mut var_user_id := user_id
	mut var_scheme := scheme
	mut var_url := rt.new_null()
	var_user_id = (if var_user_id != 0 {
		var_user_id
	} else {
		rt.call_function('get_current_user_id', []rt.PhpVal{})
	}).to_i64()
	if rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{})) {
		var_url = user_admin_url('profile.php', scheme)
	} else if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		var_url = network_admin_url('profile.php', scheme)
	} else {
		var_url = get_dashboard_url(var_user_id, 'profile.php', scheme)
	}
	return rt.call_function('apply_filters', [rt.new_string('edit_profile_url'),
		var_url.clone(), rt.new_int(var_user_id), rt.new_string(scheme)])
}

fn wp_get_canonical_url(var_post_arg rt.PhpVal) bool {
	mut var_post := var_post_arg
	mut var_canonical_url := rt.new_null()
	mut var_page := rt.new_null()
	mut var_cpage := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), rt.call_function('get_post_status', [
		var_post.clone(),
	])))))
	{
		return false
	}
	var_canonical_url = rt.new_bool(get_permalink(var_post.clone(), false))
	if rt.is_true(rt.identical(rt.call_function('get_queried_object_id', []rt.PhpVal{}), rt.get_property(var_post,
		'ID')))
	{
		var_page = rt.call_function('get_query_var', [rt.new_string('page'),
			rt.new_int(0)])
		if rt.is_true(rt.greater_equal(var_page, rt.new_int(2))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [
				rt.new_string('permalink_structure'),
			])))))
			{
				var_canonical_url = rt.call_function('add_query_arg', [
					rt.new_string('page'),
					var_page.clone(),
					var_canonical_url.clone(),
				])
			} else {
				var_canonical_url = rt.new_string(
					(rt.call_function('trailingslashit', [var_canonical_url.clone()])).str() +
					(user_trailingslashit(var_page.clone(), 'single_paged')).str())
			}
		}
		var_cpage = rt.call_function('get_query_var', [rt.new_string('cpage'),
			rt.new_int(0)])
		if rt.is_true(var_cpage) {
			var_canonical_url = get_comments_pagenum_link(var_cpage.clone(), 0)
		}
	}
	return (rt.call_function('apply_filters', [rt.new_string('get_canonical_url'),
		var_canonical_url.clone(), var_post.clone()])).to_bool()
}

fn rel_canonical() {
	mut var_id := rt.new_null()
	mut var_url := false
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))))) {
		return
	}
	var_id = rt.call_function('get_queried_object_id', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_int(0), var_id)) {
		return
	}
	var_url = wp_get_canonical_url(var_id.clone())
	if !(!var_url) {
		print('<link rel="canonical" href="' +
			(rt.call_function('esc_url', [rt.new_bool(var_url).clone()])).str() + '" />' + '\n')
	}
}

fn wp_get_shortlink(id i64, context string, allow_slugs bool) rt.PhpVal {
	mut var_id := id
	mut var_context := context
	mut var_allow_slugs := allow_slugs
	mut var_shortlink := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_post := rt.new_null()
	mut var_post_type := rt.new_null()
	var_shortlink = rt.call_function('apply_filters', [
		rt.new_string('pre_get_shortlink'),
		rt.new_bool(false),
		rt.new_int(id),
		rt.new_string(context),
		rt.new_bool(allow_slugs),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_shortlink)))) {
		return var_shortlink.clone()
	}
	var_post_id = rt.new_int(0)
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('query'), rt.new_string(context)))
		&& rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))))
	{
		var_post_id = rt.call_function('get_queried_object_id', []rt.PhpVal{})
		var_post = rt.call_function('get_post', [var_post_id.clone()])
	} else if rt.is_true(rt.identical(rt.new_string('post'), rt.new_string(context))) {
		var_post = rt.call_function('get_post', [rt.new_int(id)])
		if !(!rt.is_true(rt.get_property(var_post, 'ID'))) {
			var_post_id = rt.get_property(var_post, 'ID')
		}
	}
	var_shortlink = rt.new_string('')
	if !(!rt.is_true(var_post_id)) {
		var_post_type = rt.call_function('get_post_type_object', [
			rt.get_property(var_post, 'post_type'),
		])
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_post, 'post_type')))
			&& rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')])))))
			&& rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('page_on_front')])).to_i64()), rt.get_property(var_post, 'ID')))))
		{
			var_shortlink = home_url('/', rt.new_null())
		} else if rt.is_true(rt.new_bool(rt.is_true(var_post_type)
			&& rt.is_true(rt.get_property(var_post_type, 'public'))))
		{
			var_shortlink = home_url('?p=' + var_post_id.str(), rt.new_null())
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('get_shortlink'),
		var_shortlink.clone(), rt.new_int(id), rt.new_string(context),
		rt.new_bool(allow_slugs)])
}

fn wp_shortlink_wp_head() {
	mut var_shortlink := rt.new_null()
	var_shortlink = wp_get_shortlink(0, 'query', false)
	if !rt.is_true(var_shortlink) {
		return
	}
	print("<link rel='shortlink' href='" +
		(rt.call_function('esc_url', [var_shortlink.clone()])).str() + "' />\n")
}

fn wp_shortlink_header() {
	mut var_shortlink := rt.new_null()
	if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) {
		return
	}
	var_shortlink = wp_get_shortlink(0, 'query', false)
	if !rt.is_true(var_shortlink) {
		return
	}
	rt.call_function('header', [
		rt.new_string('Link: <' + var_shortlink.str() + '>; rel=shortlink'),
		rt.new_bool(false),
	])
}

fn the_shortlink(text string, title string, before string, after string) {
	mut var_text := text
	mut var_title := title
	mut var_before := before
	mut var_after := after
	mut var_post := rt.new_null()
	mut var_shortlink := rt.new_null()
	mut var_link := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if var_text == '' {
		var_text = (rt.call_function('__', [rt.new_string('This is the short link.')])).str()
	}
	var_shortlink = wp_get_shortlink(rt.get_property(var_post, 'ID'), '', false)
	if !(!rt.is_true(var_shortlink)) {
		var_link = rt.new_string('<a rel="shortlink" href="' +
			(rt.call_function('esc_url', [var_shortlink.clone()])).str() + '">' + var_text + '</a>')
		var_link = rt.call_function('apply_filters', [rt.new_string('the_shortlink'),
			var_link.clone(), var_shortlink.clone(), rt.new_string(var_text.str()),
			rt.new_string(var_title.str())])
		print(var_before)
		rt.echo_val(var_link)
		print(var_after)
	}
}

fn get_avatar_url(var_id_or_email rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	var_args = get_avatar_data(var_id_or_email.clone(), var_args.clone())
	return var_args.array_get('url')
}

fn is_avatar_comment_type(var_comment_type rt.PhpVal) rt.PhpVal {
	mut var_allowed_comment_types := rt.new_null()
	var_allowed_comment_types = rt.call_function('apply_filters', [
		rt.new_string('get_avatar_comment_types'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'comment' },
			rt.ArrayItem{ key: none, val: 'note' }]),
	])
	return rt.call_function('in_array', [var_comment_type.clone(),
		rt.cast_array(var_allowed_comment_types), rt.new_bool(true)])
}

fn get_avatar_data(var_id_or_email_arg rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_id_or_email := var_id_or_email_arg
	mut var_args := var_args_arg
	mut var_email_hash := rt.new_null()
	mut var_user := rt.new_null()
	mut var_email := rt.new_null()
	mut var_url_args := map[string]rt.PhpVal{}
	mut var_name := rt.new_null()
	mut var_initials := rt.new_null()
	mut var_first := rt.new_null()
	mut var_last := rt.new_null()
	mut var_url := rt.new_null()
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array([rt.ArrayItem{ key: 'size', val: 96 },
			rt.ArrayItem{ key: 'height', val: rt.new_null() },
			rt.ArrayItem{ key: 'width', val: rt.new_null() },
			rt.ArrayItem{ key: 'default', val: rt.call_function('get_option', [
				rt.new_string('avatar_default'),
				rt.new_string('mystery'),
			]) }, rt.ArrayItem{ key: 'force_default', val: false },
			rt.ArrayItem{ key: 'rating', val: rt.call_function('get_option', [
				rt.new_string('avatar_rating'),
			]) }, rt.ArrayItem{ key: 'scheme', val: rt.new_null() },
			rt.ArrayItem{ key: 'processed_args', val: rt.new_null() },
			rt.ArrayItem{ key: 'extra_attr', val: '' }])])
	if rt.is_true(rt.new_bool(var_args.array_get('size').is_long()
		|| var_args.array_get('size').is_double()))
	{
		var_args.array_set('size', rt.call_function('absint', [
			var_args.array_get('size')]))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get('size'))))) {
			var_args.array_set('size', 96)
		}
	} else {
		var_args.array_set('size', 96)
	}
	if rt.is_true(rt.new_bool(var_args.array_get('height').is_long()
		|| var_args.array_get('height').is_double()))
	{
		var_args.array_set('height', rt.call_function('absint', [
			var_args.array_get('height')]))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get('height'))))) {
			var_args.array_set('height', var_args.array_get('size'))
		}
	} else {
		var_args.array_set('height', var_args.array_get('size'))
	}
	if rt.is_true(rt.new_bool(var_args.array_get('width').is_long()
		|| var_args.array_get('width').is_double()))
	{
		var_args.array_set('width', rt.call_function('absint', [
			var_args.array_get('width')]))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get('width'))))) {
			var_args.array_set('width', var_args.array_get('size'))
		}
	} else {
		var_args.array_set('width', var_args.array_get('size'))
	}
	if !rt.is_true(var_args.array_get('default')) {
		var_args.array_set('default', rt.call_function('get_option', [
			rt.new_string('avatar_default'),
			rt.new_string('mystery'),
		]))
	}
	mut switch_val_2 := var_args.array_get('default')
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('mm')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('mystery')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('mysteryman'))) {
		var_args.array_set('default', 'mm')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('gravatar_default'))) {
		var_args.array_set('default', false)
	}
	var_args.array_set('force_default', (var_args.array_get('force_default')).to_bool())
	var_args.array_set('rating', var_args.array_get('rating').to_string().to_lower())
	var_args.array_set('found_avatar', false)
	var_args = rt.call_function('apply_filters', [rt.new_string('pre_get_avatar_data'),
		var_args.clone(), var_id_or_email.clone()])
	if var_args.array_isset(rt.new_string('url')) {
		return rt.call_function('apply_filters', [rt.new_string('get_avatar_data'),
			var_args.clone(), var_id_or_email.clone()])
	}
	var_email_hash = rt.new_string('')
	var_user = rt.new_bool(false)
	var_email = rt.new_bool(false)
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_id_or_email.clone().is_object()))
		&& !(rt.get_property(var_id_or_email, 'comment_ID')).is_null()))
	{
		var_id_or_email = rt.call_function('get_comment', [var_id_or_email.clone()])
	}
	if rt.is_true(rt.new_bool(var_id_or_email.clone().is_long()
		|| var_id_or_email.clone().is_double()))
	{
		var_user = rt.call_function('get_user_by', [rt.new_string('id'),
			rt.call_function('absint', [var_id_or_email.clone()])])
	} else if rt.is_true(rt.new_bool(var_id_or_email.clone().is_string())) {
		if rt.is_true(rt.call_function('str_contains', [var_id_or_email.clone(),
			rt.new_string('@sha256.gravatar.com')]))
		{
			mut _list_tmp_ - 71592 := rt.call_function('explode', [
				rt.new_string('@'), var_id_or_email.clone()])
		} else if rt.is_true(rt.call_function('str_contains', [
			var_id_or_email.clone(), rt.new_string('@md5.gravatar.com')]))
		{
			mut _list_tmp_ - 71592 := rt.call_function('explode', [
				rt.new_string('@'), var_id_or_email.clone()])
		} else {
			var_email = var_id_or_email.clone()
		}
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_id_or_email, 'WP_User'))) {
		var_user = var_id_or_email.clone()
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_id_or_email, 'WP_Post'))) {
		var_user = rt.call_function('get_user_by', [rt.new_string('id'),
			rt.new_int((rt.get_property(var_id_or_email, 'post_author')).to_i64())])
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_id_or_email, 'WP_Comment'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(is_avatar_comment_type(rt.call_function('get_comment_type', [
			var_id_or_email.clone(),
		]))))))
		{
			var_args.array_set('url', false)
			return rt.call_function('apply_filters', [rt.new_string('get_avatar_data'),
				var_args.clone(), var_id_or_email.clone()])
		}
		if !(!rt.is_true(rt.get_property(var_id_or_email, 'user_id'))) {
			var_user = rt.call_function('get_user_by', [rt.new_string('id'),
				rt.new_int((rt.get_property(var_id_or_email, 'user_id')).to_i64())])
		}
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_user))))
			|| rt.is_true(rt.call_function('is_wp_error', [var_user.clone()]))))
			&& !(!rt.is_true(rt.get_property(var_id_or_email, 'comment_author_email')))))
		{
			var_email = rt.get_property(var_id_or_email, 'comment_author_email')
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_email_hash)))) {
		if rt.is_true(var_user) {
			var_email = rt.get_property(var_user, 'user_email')
		}
		if rt.is_true(var_email) {
			var_email_hash = rt.call_function('hash', [rt.new_string('sha256'),
				rt.new_string(var_email.clone().to_string().trim_space().to_lower())])
		}
	}
	if rt.is_true(var_email_hash) {
		var_args.array_set('found_avatar', true)
	}
	var_url_args = {
		's': var_args.array_get('size')
		'd': var_args.array_get('default')
		'f': if rt.is_true(var_args.array_get('force_default')) {
			rt.new_string('y')
		} else {
			rt.new_bool(false)
		}
		'r': var_args.array_get('rating')
	}
	if rt.is_true(rt.identical(rt.new_string('initials'), var_args.array_get('default'))) {
		var_name = rt.new_string('')
		if rt.is_true(var_user) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_user,
				'display_name')))))
			{
				var_name = rt.get_property(var_user, 'display_name')
			} else if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_user, 'first_name')))))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_user, 'last_name')))))))
			{
				var_name = rt.call_function('sprintf', [
					rt.call_function('_x', [rt.new_string('%1$s %2$s'),
						rt.new_string('Display name based on first name and last name')]),
					rt.get_property(var_user, 'first_name'),
					rt.get_property(var_user, 'last_name'),
				])
			} else {
				var_name = rt.get_property(var_user, 'user_login')
			}
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_id_or_email, 'WP_Comment'))) {
			var_name = rt.get_property(var_id_or_email, 'comment_author')
		} else if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(var_id_or_email.clone().is_string()))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_id_or_email.clone(), rt.new_string('@')])))))))
		{
			var_name = rt.call_function('str_replace', [
				rt.create_array([rt.ArrayItem{ key: none, val: '.' },
					rt.ArrayItem{ key: none, val: '_' }, rt.ArrayItem{ key: none, val: '-' }]),
				rt.new_string(' '),
				rt.call_function('substr', [var_id_or_email.clone(),
					rt.new_int(0),
					rt.call_function('strpos', [
						var_id_or_email.clone(), rt.new_string('@')])]),
			])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_name)))) {
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_name.clone(), rt.new_string(' ')])))))
				|| rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\p{Han}|\\p{Hiragana}|\\p{Katakana}|\\p{Hangul}/u'), var_name.clone()]))))
			{
				var_initials = rt.call_function('mb_substr', [
					var_name.clone(), rt.new_int(0),
					rt.call_function('min', [
						rt.new_int(2),
						rt.call_function('mb_strlen', [var_name.clone(),
							rt.new_string('UTF-8')]),
					]),
					rt.new_string('UTF-8')])
			} else {
				var_first = rt.call_function('mb_substr', [var_name.clone(),
					rt.new_int(0), rt.new_int(1), rt.new_string('UTF-8')])
				var_last = rt.call_function('mb_substr', [var_name.clone(),
					rt.add(rt.call_function('strrpos', [var_name.clone(),
						rt.new_string(' ')]), rt.new_int(1)),
					rt.new_int(1), rt.new_string('UTF-8')])
				var_initials = rt.new_string(var_first.str() + var_last.str())
			}
			var_url_args['initials'] = var_initials.clone()
		}
	}
	var_url = rt.new_string('https://secure.gravatar.com/avatar/' + var_email_hash.str())
	var_url = rt.call_function('add_query_arg', [
		rt.call_function('rawurlencode_deep', [
			rt.call_function('array_filter', [
				rt.create_array_from_native_map(var_url_args),
			]),
		]),
		var_url.clone(),
	])
	var_args.array_set('url', rt.call_function('apply_filters', [
		rt.new_string('get_avatar_url'),
		var_url.clone(),
		var_id_or_email.clone(),
		var_args.clone(),
	]))
	return rt.call_function('apply_filters', [rt.new_string('get_avatar_data'),
		var_args.clone(), var_id_or_email.clone()])
}

fn get_theme_file_uri(file string) rt.PhpVal {
	mut var_file := file
	mut var_stylesheet_directory := rt.new_null()
	mut var_url := rt.new_null()
	var_file = var_file.trim_left(' \t\n\r')
	var_stylesheet_directory = rt.call_function('get_stylesheet_directory', []rt.PhpVal{})
	if var_file == '' {
		var_url = rt.call_function('get_stylesheet_directory_uri', []rt.PhpVal{})
	} else if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_template_directory', []rt.PhpVal{}), var_stylesheet_directory))))
		&& rt.is_true(rt.call_function('file_exists', [rt.new_string(var_stylesheet_directory.str() + '/' + var_file)]))))
	{
		var_url = rt.new_string(
			(rt.call_function('get_stylesheet_directory_uri', []rt.PhpVal{})).str() + '/' + var_file)
	} else {
		var_url = rt.new_string(
			(rt.call_function('get_template_directory_uri', []rt.PhpVal{})).str() + '/' + var_file)
	}
	return rt.call_function('apply_filters', [rt.new_string('theme_file_uri'),
		var_url.clone(), rt.new_string(var_file.str())])
}

fn get_parent_theme_file_uri(file string) rt.PhpVal {
	mut var_file := file
	mut var_url := rt.new_null()
	var_file = var_file.trim_left(' \t\n\r')
	if var_file == '' {
		var_url = rt.call_function('get_template_directory_uri', []rt.PhpVal{})
	} else {
		var_url = rt.new_string(
			(rt.call_function('get_template_directory_uri', []rt.PhpVal{})).str() + '/' + var_file)
	}
	return rt.call_function('apply_filters', [rt.new_string('parent_theme_file_uri'),
		var_url.clone(), rt.new_string(var_file.str())])
}

fn get_theme_file_path(file string) rt.PhpVal {
	mut var_file := file
	mut var_stylesheet_directory := rt.new_null()
	mut var_template_directory := rt.new_null()
	mut var_path := rt.new_null()
	var_file = var_file.trim_left(' \t\n\r')
	var_stylesheet_directory = rt.call_function('get_stylesheet_directory', []rt.PhpVal{})
	var_template_directory = rt.call_function('get_template_directory', []rt.PhpVal{})
	if var_file == '' {
		var_path = var_stylesheet_directory.clone()
	} else if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_stylesheet_directory, var_template_directory))))
		&& rt.is_true(rt.call_function('file_exists', [rt.new_string(var_stylesheet_directory.str() + '/' + var_file)]))))
	{
		var_path = rt.new_string(var_stylesheet_directory.str() + '/' + var_file)
	} else {
		var_path = rt.new_string(var_template_directory.str() + '/' + var_file)
	}
	return rt.call_function('apply_filters', [rt.new_string('theme_file_path'),
		var_path.clone(), rt.new_string(var_file.str())])
}

fn get_parent_theme_file_path(file string) rt.PhpVal {
	mut var_file := file
	mut var_path := rt.new_null()
	var_file = var_file.trim_left(' \t\n\r')
	if var_file == '' {
		var_path = rt.call_function('get_template_directory', []rt.PhpVal{})
	} else {
		var_path = rt.new_string(
			(rt.call_function('get_template_directory', []rt.PhpVal{})).str() + '/' + var_file)
	}
	return rt.call_function('apply_filters', [rt.new_string('parent_theme_file_path'),
		var_path.clone(), rt.new_string(var_file.str())])
}

fn get_privacy_policy_url() rt.PhpVal {
	mut var_url := rt.new_null()
	mut var_policy_page_id := rt.new_null()
	var_url = rt.new_string('')
	var_policy_page_id = rt.new_int((rt.call_function('get_option', [
		rt.new_string('wp_page_for_privacy_policy'),
	])).to_i64())
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_policy_page_id))
		&& rt.is_true(rt.identical(rt.call_function('get_post_status', [var_policy_page_id.clone()]), rt.new_string('publish')))))
	{
		var_url = rt.new_string(get_permalink(var_policy_page_id.clone()).str())
	}
	return rt.call_function('apply_filters', [rt.new_string('privacy_policy_url'),
		var_url.clone(), var_policy_page_id.clone()])
}

fn the_privacy_policy_link(before string, after string) {
	mut var_before := before
	mut var_after := after
	print(get_the_privacy_policy_link(before, after))
}

fn get_the_privacy_policy_link(before string, after string) string {
	mut var_before := before
	mut var_after := after
	mut var_link := rt.new_null()
	mut var_privacy_policy_url := rt.new_null()
	mut var_policy_page_id := rt.new_null()
	mut var_page_title := rt.new_null()
	var_link = rt.new_string('')
	var_privacy_policy_url = get_privacy_policy_url()
	var_policy_page_id = rt.new_int((rt.call_function('get_option', [
		rt.new_string('wp_page_for_privacy_policy'),
	])).to_i64())
	var_page_title = if rt.is_true(var_policy_page_id) { rt.call_function('get_the_title', [
			var_policy_page_id.clone(),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(var_privacy_policy_url) && rt.is_true(var_page_title))) {
		var_link = rt.call_function('sprintf', [
			rt.new_string('<a class="privacy-policy-link" href="%s" rel="privacy-policy">%s</a>'),
			rt.call_function('esc_url', [var_privacy_policy_url.clone()]),
			rt.call_function('esc_html', [var_page_title.clone()]),
		])
	}
	var_link = rt.call_function('apply_filters', [
		rt.new_string('the_privacy_policy_link'),
		var_link.clone(),
		var_privacy_policy_url.clone(),
	])
	if rt.is_true(var_link) {
		return before + var_link.str() + after
	}
	return ''
}

fn wp_internal_hosts() rt.PhpVal {
	mut var_internal_hosts := rt.new_null()
	if !rt.is_true(var_internal_hosts) {
		var_internal_hosts = rt.call_function('apply_filters', [
			rt.new_string('wp_internal_hosts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('wp_parse_url', [
					home_url('', rt.new_null()),
					rt.get_constant('PHP_URL_HOST'),
				]) },
			]),
		])
		var_internal_hosts = rt.call_function('array_unique', [
			rt.call_function('array_map', [rt.new_string('strtolower'),
				rt.cast_array(var_internal_hosts)]),
		])
	}
	return var_internal_hosts.clone()
}

fn wp_is_internal_link(var_link_arg rt.PhpVal) bool {
	mut var_link := var_link_arg
	var_link = var_link.to_lower()
	if rt.is_true(rt.call_function('in_array', [
		rt.call_function('wp_parse_url', [rt.new_string(var_link.str()).clone(),
			rt.get_constant('PHP_URL_SCHEME')]),
		rt.call_function('wp_allowed_protocols', []rt.PhpVal{}),
		rt.new_bool(true),
	]))
	{
		return (rt.call_function('in_array', [
			rt.call_function('wp_parse_url', [rt.new_string(var_link.str()).clone(),
				rt.get_constant('PHP_URL_HOST')]),
			wp_internal_hosts(),
			rt.new_bool(true),
		])).to_bool()
	}
	return false
}

pub fn init_wp_includes_link_template_php() {
}
