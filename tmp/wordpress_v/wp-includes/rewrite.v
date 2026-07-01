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
	mut var_wp_rewrite := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wp_rewrite, 'add_rule', [var_regex.dup(), var_query.dup(), rt.new_string(after)])
}

fn add_rewrite_tag(var_tag rt.PhpVal, var_regex rt.PhpVal, query string) {
	mut var_wp_rewrite := rt.new_null()
	mut var_wp := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_tag.dup().to_string().len < 3 || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_Global
	if query == '' {
		mut var_qv := var_tag.dup().to_string().trim_space()
		rt.call_method(var_wp, 'add_query_var', [rt.new_string(var_qv).dup()])
		query = var_qv + '='
	}
	rt.call_method(var_wp_rewrite, 'add_rewrite_tag', [var_tag.dup(), var_regex.dup(), rt.new_string(query)])
}

fn remove_rewrite_tag(var_tag rt.PhpVal) {
	mut var_wp_rewrite := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wp_rewrite, 'remove_rewrite_tag', [var_tag.dup()])
}

fn add_permastruct(var_name rt.PhpVal, var_struct rt.PhpVal, var_args rt.PhpVal) {
	mut var_wp_rewrite := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.dup().is_array()))))) {
		var_args = { 'with_front': var_args }
	}
	if rt.is_true(rt.identical(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(4))) {
		var_args.array_set('ep_mask', rt.call_function('func_get_arg', [rt.new_int(3)]))
	}
	rt.call_method(var_wp_rewrite, 'add_permastruct', [var_name.dup(), var_struct.dup(), var_args.dup()])
}

fn remove_permastruct(var_name rt.PhpVal) {
	mut var_wp_rewrite := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wp_rewrite, 'remove_permastruct', [var_name.dup()])
}

fn add_feed(var_feedname rt.PhpVal, var_callback rt.PhpVal) rt.PhpVal {
	mut var_wp_rewrite := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_feedname.dup(), rt.get_property(var_wp_rewrite, 'feeds'), rt.new_bool(true)]))))) {
		rt.get_property(var_wp_rewrite, 'feeds').array_push(var_feedname.dup())
	}
	mut var_hook := rt.new_string('do_feed_' + (var_feedname).str())
	rt.call_function('remove_action', [var_hook.dup(), var_hook.dup()])
	rt.call_function('add_action', [var_hook.dup(), var_callback.dup(), rt.new_int(10), rt.new_int(2)])
	return var_hook.dup()
}

fn flush_rewrite_rules(hard bool) {
	mut var_wp_rewrite := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_wp_rewrite }, rt.ArrayItem{ key: none, val: 'flush_rules' }])])) {
		rt.call_method(var_wp_rewrite, 'flush_rules', [rt.new_bool(hard)])
	}
}

fn add_rewrite_endpoint(var_name rt.PhpVal, var_places rt.PhpVal, query_var bool) {
	mut var_wp_rewrite := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wp_rewrite, 'add_endpoint', [var_name.dup(), var_places.dup(), rt.new_bool(query_var)])
}

fn _wp_filter_taxonomy_base(var_base rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_base)) {
		var_base = rt.call_function('preg_replace', [rt.new_string('|^/index\\.php/|'), rt.new_string(''), var_base.dup()])
		var_base = rt.new_string(rt.new_string(var_base.dup().to_string().trim_space()))
	}
	return var_base.dup()
}

fn wp_resolve_numeric_slug_conflicts(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	if !(var_query_vars.array_isset(rt.new_string('year'))) && !(var_query_vars.array_isset(rt.new_string('monthnum'))) && !(var_query_vars.array_isset(rt.new_string('day'))) {
		return var_query_vars.dup()
	}
	mut var_permastructs := rt.call_function('array_values', [rt.call_function('array_filter', [rt.call_function('explode', [rt.new_string('/'), rt.call_function('get_option', [rt.new_string('permalink_structure')])])])])
	mut var_postname_index := rt.call_function('array_search', [rt.new_string('%postname%'), var_permastructs.dup(), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_postname_index)) {
		return var_query_vars.dup()
	}
	mut var_compare := ''
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), var_postname_index)) && var_query_vars.array_isset(rt.new_string('year')) || var_query_vars.array_isset(rt.new_string('monthnum')))) {
		var_compare = 'year'
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_postname_index) && rt.is_true(rt.identical(rt.new_string('%year%'), var_permastructs.array_get(rt.sub(var_postname_index, rt.new_int(1))))))) && var_query_vars.array_isset(rt.new_string('monthnum')) || var_query_vars.array_isset(rt.new_string('day')))) {
		var_compare = 'monthnum'
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_postname_index) && rt.is_true(rt.identical(rt.new_string('%monthnum%'), var_permastructs.array_get(rt.sub(var_postname_index, rt.new_int(1))))))) && var_query_vars.array_isset(rt.new_string('day')))) {
		var_compare = 'day'
	}
	if !(var_compare.len > 0 && var_compare != '0') {
		return var_query_vars.dup()
	}
	mut var_value := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(var_query_vars.dup().array_isset(rt.new_string(var_compare).dup()))) {
		var_value = var_query_vars.array_get(var_compare)
	}
	mut var_post := rt.call_function('get_page_by_path', [var_value.dup(), rt.get_constant('OBJECT'), rt.new_string('post')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))))) {
		return var_query_vars.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^([0-9]{4})\\-([0-9]{2})/'), rt.get_property(var_post, 'post_date'), var_matches.dup()])) && var_query_vars.array_isset(rt.new_string('year')))) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('monthnum'), rt.new_string(var_compare))) || rt.is_true(rt.identical(rt.new_string('day'), rt.new_string(var_compare))))))) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return var_query_vars.dup()
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('day'), rt.new_string(var_compare))) && var_query_vars.array_isset(rt.new_string('monthnum')))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return var_query_vars.dup()
		}
	}
	mut var_maybe_page := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('year'), rt.new_string(var_compare))) && var_query_vars.array_isset(rt.new_string('monthnum')))) {
		var_maybe_page = var_query_vars.array_get('monthnum')
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('monthnum'), rt.new_string(var_compare))) && var_query_vars.array_isset(rt.new_string('day')))) {
		var_maybe_page = var_query_vars.array_get('day')
	}
	var_maybe_page = // unsupported expression: Expr_Cast_Int
	mut var_post_page_count := rt.add(rt.call_function('substr_count', [rt.get_property(var_post, 'post_content'), rt.new_string('<!--nextpage-->')]), rt.new_int(1))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(1), var_post_page_count)) && rt.is_true(var_maybe_page))) {
		return var_query_vars.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_post_page_count, rt.new_int(1))) && rt.is_true(rt.greater(var_maybe_page, var_post_page_count)))) {
		return var_query_vars.dup()
	}
	var_query_vars.array_set('page', var_maybe_page.dup())
	var_query_vars.array_unset(rt.new_string('year'))
	var_query_vars.array_unset(rt.new_string('monthnum'))
	var_query_vars.array_unset(rt.new_string('day'))
	var_query_vars.array_set('name', rt.get_property(var_post, 'post_name'))
	return var_query_vars.dup()
}

fn url_to_postid(var_url rt.PhpVal) i64 {
	mut var_wp_rewrite := rt.new_null()
	mut var_values := []rt.PhpVal{}
	mut var_matches := rt.new_null()
	mut var_varmatch := []rt.PhpVal{}
	mut var_wp := rt.new_null()
	mut var_query_vars := rt.new_null()
	// unsupported statement: Stmt_Global
	var_url = rt.call_function('apply_filters', [rt.new_string('url_to_postid'), var_url.dup()])
	mut var_url_host := rt.call_function('parse_url', [var_url.dup(), rt.get_constant('PHP_URL_HOST')])
	if rt.is_true(rt.new_bool(var_url_host.dup().is_string())) {
		var_url_host = rt.call_function('str_replace', [rt.new_string('www.'), rt.new_string(''), var_url_host.dup()])
	} else {
		var_url_host = rt.new_string(rt.new_string(''))
	}
	mut var_home_url_host := rt.call_function('parse_url', [rt.call_function('home_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_HOST')])
	if rt.is_true(rt.new_bool(var_home_url_host.dup().is_string())) {
		var_home_url_host = rt.call_function('str_replace', [rt.new_string('www.'), rt.new_string(''), var_home_url_host.dup()])
	} else {
		var_home_url_host = rt.new_string(rt.new_string(''))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_url_host) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return 0
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#[?&](p|page_id|attachment_id)=(\\d+)#'), var_url.dup(), var_values.dup()])) {
		mut var_id := rt.call_function('absint', [var_values.array_get(2)])
		if rt.is_true(var_id) {
			return (var_id).to_i64()
		}
	}
	mut var_url_split := rt.call_function('explode', [rt.new_string('#'), var_url.dup()])
	var_url = var_url_split.array_get(0)
	var_url_split = rt.call_function('explode', [, .dup()])
	var_url = 
	
}



pub fn init_wp_includes_rewrite_php() {
}
