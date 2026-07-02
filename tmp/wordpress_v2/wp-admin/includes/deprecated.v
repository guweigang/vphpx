import rt

fn tinymce_include() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('wp_editor()')])
	wp_tiny_mce(false, false)
}

fn documentation_link() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.5.0')])
}

fn wp_shrink_dimensions(var_width rt.PhpVal, var_height rt.PhpVal, wmax i64, hmax i64) rt.PhpVal {
	mut var_wmax := wmax
	mut var_hmax := hmax
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('wp_constrain_dimensions()')])
	return rt.call_function('wp_constrain_dimensions', [var_width.clone(),
		var_height.clone(), rt.new_int(wmax), rt.new_int(hmax)])
}

fn get_udims(var_width rt.PhpVal, var_height rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.5.0'), rt.new_string('wp_constrain_dimensions()')])
	return rt.call_function('wp_constrain_dimensions', [var_width.clone(),
		var_height.clone(), rt.new_int(128), rt.new_int(96)])
}

fn dropdown_categories(default_category i64, category_parent i64, var_popular_ids rt.PhpVal) {
	mut var_default_category := default_category
	mut var_category_parent := category_parent
	mut var_post_ID := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.6.0'), rt.new_string('wp_category_checklist()')])
	rt.call_function('wp_category_checklist', [var_post_ID.clone()])
}

fn dropdown_link_categories(default_link_category i64) {
	mut var_default_link_category := default_link_category
	mut var_link_id := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.6.0'), rt.new_string('wp_link_category_checklist()')])
	rt.call_function('wp_link_category_checklist', [var_link_id.clone()])
}

fn get_real_file_to_edit(var_file rt.PhpVal) string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.9.0')])
	return (rt.get_constant('WP_CONTENT_DIR')).str() + var_file.str()
}

fn wp_dropdown_cats(current_cat i64, current_parent i64, category_parent i64, level i64, categories i64) bool {
	mut var_current_cat := current_cat
	mut var_current_parent := current_parent
	mut var_category_parent := category_parent
	mut var_level := level
	mut var_categories := categories
	mut var_category := rt.new_null()
	mut var_pad := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('wp_dropdown_categories()')])
	if !(var_categories != 0) {
		var_categories = (rt.call_function('get_categories', [
			rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: 0 }]),
		])).to_i64()
	}
	if var_categories != 0 {
		mut iter_1 := rt.new_int(var_categories).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category_shadow := item_1.val
			if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_int(current_cat), rt.get_property(var_category_shadow, 'term_id')))))
				&& rt.is_true(rt.equal(rt.new_int(category_parent), rt.get_property(var_category_shadow, 'parent'))) {
				var_pad = rt.call_function('str_repeat', [rt.new_string('&#8211; '),
					rt.new_int(level)])
				rt.set_property(var_category_shadow, 'name', rt.call_function('esc_html', [
					rt.get_property(var_category_shadow, 'name'),
				]))
				print(rt.concat(rt.concat(rt.new_string("\n\t<option value='"), rt.get_property(var_category_shadow,
					'term_id')), rt.new_string("'")))
				if rt.is_true(rt.equal(rt.new_int(current_parent), rt.get_property(var_category_shadow,
					'term_id')))
				{
					print(" selected='selected'")
				}
				print(rt.concat(rt.concat(rt.concat(rt.new_string('>'), var_pad), rt.get_property(var_category_shadow,
					'name')), rt.new_string('</option>')))
				rt.new_bool(wp_dropdown_cats(current_cat, current_parent, rt.get_property(var_category_shadow,
					'term_id'), level + 1, var_categories))
			}
		}
	} else {
		return false
	}
	return false
}

fn add_option_update_handler(var_option_group rt.PhpVal, var_option_name rt.PhpVal, sanitize_callback string) {
	mut var_sanitize_callback := sanitize_callback
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('register_setting()')])
	rt.call_function('register_setting', [var_option_group.clone(),
		var_option_name.clone(), rt.new_string(sanitize_callback)])
}

fn remove_option_update_handler(var_option_group rt.PhpVal, var_option_name rt.PhpVal, sanitize_callback string) {
	mut var_sanitize_callback := sanitize_callback
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('unregister_setting()')])
	rt.call_function('unregister_setting', [var_option_group.clone(),
		var_option_name.clone(), rt.new_string(sanitize_callback)])
}

fn codepress_get_lang(var_filename rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0')])
}

fn codepress_footer_js() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0')])
}

fn use_codepress() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0')])
}

fn get_author_user_ids() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_level_key := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.1.0'), rt.new_string('get_users()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_level_key = rt.new_string(
			(rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'user_level')
	} else {
		var_level_key = rt.new_string(
			(rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'capabilities')
	}
	return rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT user_id FROM '), rt.get_property(var_wpdb,
				'usermeta')), rt.new_string(" WHERE meta_key = %s AND meta_value != '0'")),
			var_level_key.clone(),
		]),
	])
}

fn get_editable_authors(var_user_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_editable := rt.new_null()
	mut var_authors := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.1.0'), rt.new_string('get_users()')])
	var_editable = get_editable_user_ids(var_user_id.clone(), false, '')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_editable)))) {
		return false
	} else {
		var_editable = rt.call_function('join', [rt.new_string(','),
			var_editable.clone()])
		var_authors = rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
				'users')), rt.new_string(' WHERE ID IN (')), var_editable),
				rt.new_string(') ORDER BY display_name')),
		])
	}
	return (rt.call_function('apply_filters', [rt.new_string('get_editable_authors'),
		var_authors.clone()])).to_bool()
}

fn get_editable_user_ids(var_user_id rt.PhpVal, exclude_zeros bool, post_type string) rt.PhpVal {
	mut var_exclude_zeros := exclude_zeros
	mut var_post_type := post_type
	mut var_wpdb := rt.new_null()
	mut var_user := rt.new_null()
	mut var_post_type_obj := rt.new_null()
	mut var_level_key := rt.new_null()
	mut var_query := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.1.0'), rt.new_string('get_users()')])
	var_user = rt.call_function('get_userdata', [var_user_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return rt.new_array()
	}
	var_post_type_obj = rt.call_function('get_post_type_object', [
		rt.new_string(post_type),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'has_cap', [
		rt.get_property(rt.get_property(var_post_type_obj, 'cap'), 'edit_others_posts'),
	])))))
	{
		if rt.is_true(rt.call_method(var_user, 'has_cap', [rt.get_property(rt.get_property(var_post_type_obj, 'cap'), 'edit_posts')]))
			|| !var_exclude_zeros {
			return rt.create_array([
				rt.ArrayItem{ key: none, val: rt.get_property(var_user, 'ID') },
			])
		} else {
			return rt.new_array()
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_level_key = rt.new_string(
			(rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'user_level')
	} else {
		var_level_key = rt.new_string(
			(rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'capabilities')
	}
	var_query = rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.new_string('SELECT user_id FROM '), rt.get_property(var_wpdb,
			'usermeta')), rt.new_string(' WHERE meta_key = %s')),
		var_level_key.clone(),
	])
	if var_exclude_zeros {
		var_query = rt.concat(var_query, rt.new_string(" AND meta_value != '0'"))
	}
	return rt.call_method(var_wpdb, 'get_col', [var_query.clone()])
}

fn get_nonauthor_user_ids() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_level_key := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.1.0'), rt.new_string('get_users()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_level_key = rt.new_string(
			(rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'user_level')
	} else {
		var_level_key = rt.new_string(
			(rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'capabilities')
	}
	return rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT user_id FROM '), rt.get_property(var_wpdb,
				'usermeta')), rt.new_string(" WHERE meta_key = %s AND meta_value = '0'")),
			var_level_key.clone(),
		]),
	])
}

struct Class_WP_User_Search {
	rt.PhpObjectBase
pub mut:
	results               rt.PhpVal = rt.new_null()
	search_term           rt.PhpVal = rt.new_null()
	page                  rt.PhpVal = rt.new_null()
	role                  rt.PhpVal = rt.new_null()
	raw_page              rt.PhpVal = rt.new_null()
	users_per_page        rt.PhpVal = rt.new_int(50)
	first_user            rt.PhpVal = rt.new_null()
	last_user             rt.PhpVal = rt.new_null()
	query_limit           rt.PhpVal = rt.new_null()
	query_orderby         string
	query_from            string
	query_where           string
	total_users_for_query rt.PhpVal = rt.new_int(0)
	too_many_total_users  rt.PhpVal = rt.new_bool(false)
	search_errors         rt.PhpVal = rt.new_null()
	paging_text           rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_User_Search) construct(search_term string, page string, role string) {
	mut page_mutated := page
	rt.call_function('_deprecated_class', [rt.new_string('WP_User_Search'),
		rt.new_string('3.1.0'), rt.new_string('WP_User_Query')])
	this.search_term = rt.call_function('wp_unslash', [rt.new_string(search_term)])
	this.raw_page = if rt.is_true(rt.equal(rt.new_string(''), rt.new_string(page_mutated))) {
		rt.new_bool(false)
	} else {
		page_mutated.i64()
	}
	this.page = if rt.is_true(rt.equal(rt.new_string(''), rt.new_string(page_mutated))) {
		1
	} else {
		page_mutated.i64()
	}
	this.role = rt.new_string(role)
	this.prepare_query()
	this.query()
	this.do_paging()
}

fn (mut this Class_WP_User_Search) wp_user_search(search_term string, page string, role string) {
	mut page_mutated := page
	rt.call_function('_deprecated_constructor', [rt.new_string('WP_User_Search'),
		rt.new_string('3.1.0'),
		rt.call_function('get_class', [
			rt.new_object('WP_User_Search', []string{}, &this),
		])])
	mut iife_temp_0 := Class_WP_User_Search{}
	iife_temp_0.construct(search_term, page_mutated, role)
	rt.new_null()
}

fn (mut this Class_WP_User_Search) prepare_query() {
	mut var_wpdb := rt.new_null()
	this.first_user = rt.mul(rt.sub(this.page, rt.new_int(1)), this.users_per_page)
	this.query_limit = rt.call_method(var_wpdb, 'prepare', [
		rt.new_string(' LIMIT %d, %d'),
		this.first_user,
		this.users_per_page,
	])
	this.query_orderby = ' ORDER BY user_login'
	mut var_search_sql := rt.new_string('')
	if rt.is_true(this.search_term) {
		mut var_searches := rt.new_array()
		var_search_sql = rt.new_string('AND (')
		mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'user_login' },
			rt.ArrayItem{ key: none, val: 'user_nicename' }, rt.ArrayItem{
				key: none
				val: 'user_email'
			}, rt.ArrayItem{ key: none, val: 'user_url' }, rt.ArrayItem{
				key: none
				val: 'display_name'
			}]).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_col := item_2.val
			var_searches << rt.call_method(var_wpdb, 'prepare', [
				rt.new_string(var_col.str() + ' LIKE %s'),
				rt.new_string('%' + (rt.call_function('like_escape', [this.search_term])).str() +
					'%'),
			])
		}
		var_search_sql = rt.concat(var_search_sql, rt.call_function('implode', [
			rt.new_string(' OR '),
			rt.create_array_from_list(var_searches),
		]))
		var_search_sql = rt.concat(var_search_sql, rt.new_string(')'))
	}
	this.query_from = rt.concat(rt.new_string(' FROM '), rt.get_property(var_wpdb, 'users'))
	this.query_where = ' WHERE 1=1 ${var_search_sql.to_string()}'
	if rt.is_true(this.role) {
		this.query_from = rt.concat(this.query_from, rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' INNER JOIN '), rt.get_property(var_wpdb,
			'usermeta')), rt.new_string(' ON ')), rt.get_property(var_wpdb, 'users')),
			rt.new_string('.ID = ')), rt.get_property(var_wpdb, 'usermeta')),
			rt.new_string('.user_id')))
		this.query_where = rt.concat(this.query_where, rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb,
				'usermeta')), rt.new_string(".meta_key = '")), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string("capabilities' AND ")), rt.get_property(var_wpdb, 'usermeta')),
				rt.new_string('.meta_value LIKE %s')),
			rt.new_string('%' + (this.role).str() + '%'),
		]))
	} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut var_level_key := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
			'capabilities')
		this.query_from = rt.concat(this.query_from, rt.concat(rt.new_string(', '), rt.get_property(var_wpdb,
			'usermeta')))
		this.query_where = rt.concat(this.query_where, rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb,
			'users')), rt.new_string('.ID = ')), rt.get_property(var_wpdb, 'usermeta')),
			rt.new_string(".user_id AND meta_key = '")), var_level_key), rt.new_string("'")))
	}
	rt.call_function('do_action_ref_array', [rt.new_string('pre_user_search'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_User_Search', []string{}, &this) },
		])])
}

fn (mut this Class_WP_User_Search) query() {
	mut var_wpdb := rt.new_null()
	this.results = rt.call_method(var_wpdb, 'get_col', [
		rt.new_string((
			rt.concat(rt.concat(rt.new_string('SELECT DISTINCT('), rt.get_property(var_wpdb, 'users')), rt.new_string('.ID)')) +
			this.query_from + this.query_where + this.query_orderby + (this.query_limit).str()).str()),
	])
	if rt.is_true(this.results) {
		this.total_users_for_query = rt.call_method(var_wpdb, 'get_var', [
			rt.new_string((
				rt.concat(rt.concat(rt.new_string('SELECT COUNT(DISTINCT('), rt.get_property(var_wpdb, 'users')), rt.new_string('.ID))')) +
				this.query_from + this.query_where).str()),
		])
	} else {
		this.search_errors = create_wp_error(rt.new_string('no_matching_users_found'), rt.call_function('__', [
			rt.new_string('No users found.'),
		]))
	}
}

fn (mut this Class_WP_User_Search) prepare_vars_for_template_usage() {
}

fn (mut this Class_WP_User_Search) do_paging() {
	if rt.is_true(rt.greater(this.total_users_for_query, this.users_per_page)) {
		mut var_args := rt.new_array()
		if !(!rt.is_true(this.search_term)) {
			var_args['usersearch'] = rt.call_function('urlencode', [this.search_term])
		}
		if !(!rt.is_true(this.role)) {
			var_args['role'] = rt.call_function('urlencode', [this.role])
		}
		this.paging_text = rt.call_function('paginate_links', [
			rt.create_array([
				rt.ArrayItem{ key: 'total', val: rt.call_function('ceil', [
					rt.div(this.total_users_for_query, this.users_per_page),
				]) },
				rt.ArrayItem{ key: 'current', val: this.page },
				rt.ArrayItem{ key: 'base', val: 'users.php?%_%' },
				rt.ArrayItem{ key: 'format', val: 'userspage=%#%' },
				rt.ArrayItem{ key: 'add_args', val: var_args },
			]),
		])
		if rt.is_true(this.paging_text) {
			this.paging_text = rt.call_function('sprintf', [
				rt.new_string('<span class="displaying-num">' +
					(rt.call_function('__', [rt.new_string('Displaying %1$s&#8211;%2$s of %3$s')])).str() +
					'</span>%s'),
				rt.call_function('number_format_i18n', [
					rt.add(rt.mul(rt.sub(this.page, rt.new_int(1)), this.users_per_page),
						rt.new_int(1)),
				]),
				rt.call_function('number_format_i18n', [
					rt.call_function('min', [rt.mul(this.page, this.users_per_page),
						this.total_users_for_query]),
				]),
				rt.call_function('number_format_i18n', [
					this.total_users_for_query,
				]),
				this.paging_text,
			])
		}
	}
}

fn (mut this Class_WP_User_Search) get_results() rt.PhpVal {
	return rt.cast_array(this.results)
}

fn (mut this Class_WP_User_Search) page_links() {
	rt.echo_val(this.paging_text)
}

fn (mut this Class_WP_User_Search) results_are_paged() bool {
	if rt.is_true(this.paging_text) {
		return true
	}
	return false
}

fn (mut this Class_WP_User_Search) is_search() bool {
	if rt.is_true(this.search_term) {
		return true
	}
	return false
}

fn get_others_unpublished_posts(var_user_id rt.PhpVal, type string) rt.PhpVal {
	mut var_type := type
	mut var_wpdb := rt.new_null()
	mut var_editable := rt.new_null()
	mut var_type_sql := ''
	mut var_dir := ''
	mut var_other_unpubs := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.1.0')])
	var_editable = get_editable_user_ids(var_user_id.clone(), false, '')
	if rt.is_true(rt.call_function('in_array', [rt.new_string(type),
		rt.create_array([rt.ArrayItem{ key: none, val: 'draft' },
			rt.ArrayItem{ key: none, val: 'pending' }])]))
	{
		var_type_sql = " post_status = '${var_type}' "
	} else {
		var_type_sql = " ( post_status = 'draft' OR post_status = 'pending' ) "
	}
	var_dir = if rt.is_true(rt.equal(rt.new_string('pending'), rt.new_string(type))) {
		'ASC'
	} else {
		'DESC'
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_editable)))) {
		var_other_unpubs = rt.new_string('')
	} else {
		var_editable = rt.call_function('join', [rt.new_string(','),
			var_editable.clone()])
		var_other_unpubs = rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID, post_title, post_author FROM '), rt.get_property(var_wpdb,
					'posts')), rt.new_string(" WHERE post_type = 'post' AND ")),
					rt.new_string(var_type_sql.str())), rt.new_string(' AND post_author IN (')),
					var_editable), rt.new_string(') AND post_author != %d ORDER BY post_modified ')),
					rt.new_string(var_dir.str())),
				var_user_id.clone(),
			]),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('get_others_drafts'),
		var_other_unpubs.clone()])
}

fn get_others_drafts(var_user_id rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.1.0')])
	return get_others_unpublished_posts(var_user_id.clone(), 'draft')
}

fn get_others_pending(var_user_id rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.1.0')])
	return get_others_unpublished_posts(var_user_id.clone(), 'pending')
}

fn wp_dashboard_quick_press_output() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.2.0'), rt.new_string('wp_dashboard_quick_press()')])
	rt.call_function('wp_dashboard_quick_press', []rt.PhpVal{})
}

fn wp_tiny_mce(teeny bool, settings bool) {
	mut var_teeny := teeny
	mut var_settings := settings
	mut var_num := rt.new_null()
	mut var_editor_id := rt.new_null()
	mut var_set := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('wp_editor()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('_WP_Editors'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-editor.php',
			'4')
	}
	var_editor_id = rt.new_string('content' + (rt.post_inc(var_num)).str())
	var_set = rt.create_array([rt.ArrayItem{ key: 'teeny', val: teeny },
		rt.ArrayItem{
			key: 'tinymce'
			val: if var_settings { settings } else { true }
		}, rt.ArrayItem{ key: 'quicktags', val: false }])
	mut iife_temp_1 := Class__WP_Editors{}
	mut iife_result_1 := iife_temp_1.parse_settings(var_editor_id.clone(), var_set.clone())
	var_set = iife_result_1
	mut iife_temp_2 := Class__WP_Editors{}
	mut iife_result_2 := iife_temp_2.editor_settings(var_editor_id.clone(), var_set.clone())
}

fn wp_preload_dialogs() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('wp_editor()')])
}

fn wp_print_editor_js() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('wp_editor()')])
}

fn wp_quicktags() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('wp_editor()')])
}

fn screen_layout(var_screen rt.PhpVal) string {
	mut var_current_screen := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('$current_screen->render_screen_layout()')])
	var_current_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_screen)))) {
		return ''
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_method(var_current_screen, 'render_screen_layout', []rt.PhpVal{})
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn screen_options(var_screen rt.PhpVal) string {
	mut var_current_screen := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('$current_screen->render_per_page_options()')])
	var_current_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_screen)))) {
		return ''
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_method(var_current_screen, 'render_per_page_options', []rt.PhpVal{})
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn screen_meta(var_screen rt.PhpVal) {
	mut var_current_screen := rt.new_null()
	var_current_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
	rt.call_method(var_current_screen, 'render_screen_meta', []rt.PhpVal{})
}

fn favorite_actions() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.2.0'), rt.new_string('WP_Admin_Bar')])
}

fn media_upload_image() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('wp_media_upload_handler()')])
	return rt.call_function('wp_media_upload_handler', []rt.PhpVal{})
}

fn media_upload_audio() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('wp_media_upload_handler()')])
	return rt.call_function('wp_media_upload_handler', []rt.PhpVal{})
}

fn media_upload_video() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('wp_media_upload_handler()')])
	return rt.call_function('wp_media_upload_handler', []rt.PhpVal{})
}

fn media_upload_file() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('wp_media_upload_handler()')])
	return rt.call_function('wp_media_upload_handler', []rt.PhpVal{})
}

fn type_url_form_image() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string("wp_media_insert_url_form('image')")])
	return rt.call_function('wp_media_insert_url_form', [rt.new_string('image')])
}

fn type_url_form_audio() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string("wp_media_insert_url_form('audio')")])
	return rt.call_function('wp_media_insert_url_form', [rt.new_string('audio')])
}

fn type_url_form_video() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string("wp_media_insert_url_form('video')")])
	return rt.call_function('wp_media_insert_url_form', [rt.new_string('video')])
}

fn type_url_form_file() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string("wp_media_insert_url_form('file')")])
	return rt.call_function('wp_media_insert_url_form', [rt.new_string('file')])
}

fn add_contextual_help(var_screen_arg rt.PhpVal, var_help rt.PhpVal) {
	mut var_screen := var_screen_arg
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('get_current_screen()->add_help_tab()')])
	if rt.is_true(rt.new_bool(var_screen.clone().is_string())) {
		var_screen = rt.call_function('convert_to_screen', [var_screen.clone()])
	}
	mut iife_temp_3 := Class_WP_Screen{}
	mut iife_result_3 := iife_temp_3.add_old_compat_help(var_screen.clone(), var_help.clone())
}

fn get_allowed_themes() rt.PhpVal {
	mut var_themes := rt.new_null()
	mut var_wp_themes := rt.new_null()
	mut var_theme := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string("wp_get_themes( array( 'allowed' => true ) )")])
	var_themes = rt.call_function('wp_get_themes', [
		rt.create_array([rt.ArrayItem{ key: 'allowed', val: true }]),
	])
	var_wp_themes = rt.new_array()
	mut iter_3 := var_themes.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_theme_shadow := item_3.val
		var_wp_themes.array_set(rt.call_method(var_theme_shadow, 'get', [
			rt.new_string('Name'),
		]), var_theme_shadow.clone())
	}
	return var_wp_themes.clone()
}

fn get_broken_themes() rt.PhpVal {
	mut var_themes := rt.new_null()
	mut var_broken := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_name := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string("wp_get_themes( array( 'errors' => true )")])
	var_themes = rt.call_function('wp_get_themes', [
		rt.create_array([rt.ArrayItem{ key: 'errors', val: true }]),
	])
	var_broken = rt.new_array()
	mut iter_4 := var_themes.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_theme_shadow := item_4.val
		var_name = rt.call_method(var_theme_shadow, 'get', [rt.new_string('Name')])
		var_broken.array_set(var_name, rt.create_array([
			rt.ArrayItem{ key: 'Name', val: var_name },
			rt.ArrayItem{ key: 'Title', val: var_name },
			rt.ArrayItem{ key: 'Description', val: rt.call_method(rt.call_method(var_theme_shadow,
				'errors', []rt.PhpVal{}), 'get_error_message', []rt.PhpVal{}) },
		]))
	}
	return var_broken.clone()
}

fn current_theme_info() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string('wp_get_theme()')])
	return rt.call_function('wp_get_theme', []rt.PhpVal{})
}

fn _insert_into_post_button(var_type rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.5.0')])
}

fn _media_button(var_title rt.PhpVal, var_icon rt.PhpVal, var_type rt.PhpVal, var_id rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.5.0')])
}

fn get_post_to_edit(var_id rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.5.0'), rt.new_string('get_post()')])
	return rt.call_function('get_post', [var_id.clone(), rt.get_constant('OBJECT'),
		rt.new_string('edit')])
}

fn get_default_page_to_edit() rt.PhpVal {
	mut var_page := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.5.0'), rt.new_string("get_default_post_to_edit( 'page' )")])
	var_page = rt.call_function('get_default_post_to_edit', []rt.PhpVal{})
	rt.set_property(var_page, 'post_type', rt.new_string('page'))
	return var_page.clone()
}

fn wp_create_thumbnail(var_file rt.PhpVal, var_max_side rt.PhpVal, deprecated string) rt.PhpVal {
	mut var_deprecated := deprecated
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.5.0'), rt.new_string('image_resize()')])
	return rt.call_function('apply_filters', [rt.new_string('wp_create_thumbnail'),
		rt.call_function('image_resize', [var_file.clone(), var_max_side.clone(),
			var_max_side.clone()])])
}

fn wp_nav_menu_locations_meta_box() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.6.0')])
}

fn wp_update_core(var_current rt.PhpVal, feedback string) rt.PhpVal {
	mut var_feedback := feedback
	mut var_upgrader := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.7.0'), rt.new_string('new Core_Upgrader();')])
	if !(feedback == '') {
		rt.call_function('add_filter', [rt.new_string('update_feedback'),
			rt.new_string(feedback)])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'3')
	var_upgrader = create_core_upgrader()
	return rt.call_method(var_upgrader, 'upgrade', [var_current.clone()])
}

fn wp_update_plugin(var_plugin rt.PhpVal, feedback string) rt.PhpVal {
	mut var_feedback := feedback
	mut var_upgrader := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.7.0'), rt.new_string('new Plugin_Upgrader();')])
	if !(feedback == '') {
		rt.call_function('add_filter', [rt.new_string('update_feedback'),
			rt.new_string(feedback)])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'3')
	var_upgrader = create_plugin_upgrader()
	return rt.call_method(var_upgrader, 'upgrade', [var_plugin.clone()])
}

fn wp_update_theme(var_theme rt.PhpVal, feedback string) rt.PhpVal {
	mut var_feedback := feedback
	mut var_upgrader := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.7.0'), rt.new_string('new Theme_Upgrader();')])
	if !(feedback == '') {
		rt.call_function('add_filter', [rt.new_string('update_feedback'),
			rt.new_string(feedback)])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'3')
	var_upgrader = create_theme_upgrader()
	return rt.call_method(var_upgrader, 'upgrade', [var_theme.clone()])
}

fn the_attachment_links(id bool) {
	mut var_id := id
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.7.0')])
}

fn screen_icon() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.8.0')])
	print(get_screen_icon())
}

fn get_screen_icon() string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.8.0')])
	return '<!-- Screen icons are no longer used as of WordPress 3.8. -->'
}

fn wp_dashboard_incoming_links_output() {
}

fn wp_dashboard_secondary_output() {
}

fn wp_dashboard_incoming_links() {
}

fn wp_dashboard_incoming_links_control() {
}

fn wp_dashboard_plugins() {
}

fn wp_dashboard_primary_control() {
}

fn wp_dashboard_recent_comments_control() {
}

fn wp_dashboard_secondary() {
}

fn wp_dashboard_secondary_control() {
}

fn wp_dashboard_plugins_output(var_rss rt.PhpVal, var_args rt.PhpVal) {
	mut var_frag := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_popular := rt.new_null()
	mut var_plugin_slugs := rt.new_null()
	mut var_feed := rt.new_null()
	mut var_items := rt.new_null()
	mut var_item_key := rt.new_null()
	mut var_item := rt.new_null()
	mut var_link := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_plugin_slug := rt.new_null()
	mut var_raw_title := rt.new_null()
	mut var_ilink := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.8.0')])
	var_popular = rt.call_function('fetch_feed',
		[var_args.array_get(rt.new_string('url')).array_get(rt.new_string('popular'))])
	var_plugin_slugs = rt.call_function('get_transient', [rt.new_string('plugin_slugs')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_plugin_slugs)) {
		var_plugin_slugs = rt.func_array_keys(rt.call_function('get_plugins', []rt.PhpVal{}))
		rt.call_function('set_transient', [rt.new_string('plugin_slugs'),
			var_plugin_slugs.clone(), rt.get_constant('DAY_IN_SECONDS')])
	}
	print('<ul>')
	mut iter_5 := rt.create_array([rt.ArrayItem{ key: none, val: var_popular }]).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_feed_shadow := item_5.val
		if rt.is_true(rt.call_function('is_wp_error', [var_feed_shadow.clone()]))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_feed_shadow, 'get_item_quantity', []rt.PhpVal{}))))) {
			continue
		}
		var_items = rt.call_method(var_feed_shadow, 'get_items', [
			rt.new_int(0), rt.new_int(5)])
		for true {
			if 0 == var_items.clone().array_count() {
				continue
			}
			var_item_key = rt.call_function('array_rand', [var_items.clone()])
			var_item = var_items.array_get(var_item_key)
			mut list_tmp_1 := rt.call_function('explode', [rt.new_string('#'),
				rt.call_method(var_item, 'get_link', []rt.PhpVal{})])
			var_link = list_tmp_1.array_get(0)
			var_frag = list_tmp_1.array_get(1)
			var_link = rt.call_function('esc_url', [var_link.clone()])
			if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('|/([^/]+?)/?$|'),
				var_link.clone(),
				rt.create_array_from_list(var_matches),
			]))
			{
				var_slug = var_matches[1]
			} else {
				var_items.array_unset(var_item_key)
				continue
			}
			rt.call_function('reset', [var_plugin_slugs.clone()])
			mut iter_6 := var_plugin_slugs.iterator()
			for {
				item_6 := iter_6.next() or { break }
				mut var_plugin_slug_shadow := item_6.val
				if rt.is_true(rt.call_function('str_starts_with', [
					var_plugin_slug_shadow.clone(), var_slug.clone()]))
				{
					var_items.array_unset(var_item_key)
					continue
				}
			}
			break
		}
		var_item_key = rt.call_function('array_rand', [var_items.clone()])
		for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_item_key))))
			&& rt.is_true(rt.call_function('str_contains', [rt.call_method(var_items.array_get(var_item_key), 'get_description', []rt.PhpVal{}), rt.new_string('Plugin Name:')])) {
			var_items.array_unset(var_item_key)
		}
		if !(var_items.array_isset(var_item_key)) {
			continue
		}
		var_raw_title = rt.call_method(var_item, 'get_title', []rt.PhpVal{})
		var_ilink = rt.new_string(
			(rt.call_function('wp_nonce_url', [rt.new_string('plugin-install.php?tab=plugin-information&plugin=' + var_slug.str()), rt.new_string('install-plugin_' + var_slug.str())])).str() +
			'&amp;TB_iframe=true&amp;width=600&amp;height=800')
		print('<li class="dashboard-news-plugin"><span>' +
			(rt.call_function('__', [rt.new_string('Popular Plugin')])).str() + ':</span> ' +
			(rt.call_function('esc_html', [var_raw_title.clone()])).str() + '&nbsp;<a href="' +
			var_ilink.str() + '" class="thickbox open-plugin-details-modal" aria-label="' +
			(rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('Install %s'), rt.new_string('plugin')]), var_raw_title.clone()])])).str() +
			'">(' + (rt.call_function('__', [rt.new_string('Install')])).str() + ')</a></li>')
		rt.call_method(var_feed_shadow, '__destruct', []rt.PhpVal{})
		var_feed_shadow = rt.new_null()
	}
	print('</ul>')
}

fn _relocate_children(var_old_ID rt.PhpVal, var_new_ID rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.9.0')])
}

fn add_object_page(var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug rt.PhpVal, callback string, icon_url string) rt.PhpVal {
	mut var_callback := callback
	mut var_icon_url := icon_url
	mut var__wp_last_object_menu := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.5.0'), rt.new_string('add_menu_page()')])
	rt.post_inc(var__wp_last_object_menu)
	return rt.call_function('add_menu_page', [var_page_title.clone(),
		var_menu_title.clone(), var_capability.clone(), var_menu_slug.clone(),
		rt.new_string(callback), rt.new_string(icon_url), var__wp_last_object_menu.clone()])
}

fn add_utility_page(var_page_title rt.PhpVal, var_menu_title rt.PhpVal, var_capability rt.PhpVal, var_menu_slug rt.PhpVal, callback string, icon_url string) rt.PhpVal {
	mut var_callback := callback
	mut var_icon_url := icon_url
	mut var__wp_last_utility_menu := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.5.0'), rt.new_string('add_menu_page()')])
	rt.post_inc(var__wp_last_utility_menu)
	return rt.call_function('add_menu_page', [var_page_title.clone(),
		var_menu_title.clone(), var_capability.clone(), var_menu_slug.clone(),
		rt.new_string(callback), rt.new_string(icon_url), var__wp_last_utility_menu.clone()])
}

fn post_form_autocomplete_off() {
	mut var_is_safari := rt.new_null()
	mut var_is_chrome := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.6.0')])
	if rt.is_true(var_is_safari) || rt.is_true(var_is_chrome) {
		print(' autocomplete="off"')
	}
}

fn options_permalink_add_js() {
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Privacy_Data_Export_Requests_Table {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Privacy_Data_Export_Requests_Table) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT),
		rt.new_string('5.3.0'), rt.new_string('WP_Privacy_Data_Export_Requests_List_Table')])
	if !(var_args_mutated.array_isset(rt.new_string('screen')))
		|| rt.is_true(rt.identical(var_args_mutated.array_get(rt.new_string('screen')), rt.new_string('export_personal_data'))) {
		var_args_mutated.array_set('screen', 'export-personal-data')
	}
	this.Class_WP_Privacy_Data_Export_Requests_List_Table.construct(var_args_mutated.clone())
}

struct Class_WP_Privacy_Data_Removal_Requests_Table {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Privacy_Data_Removal_Requests_Table) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT),
		rt.new_string('5.3.0'), rt.new_string('WP_Privacy_Data_Removal_Requests_List_Table')])
	if !(var_args_mutated.array_isset(rt.new_string('screen')))
		|| rt.is_true(rt.identical(var_args_mutated.array_get(rt.new_string('screen')), rt.new_string('remove_personal_data'))) {
		var_args_mutated.array_set('screen', 'erase-personal-data')
	}
	this.Class_WP_Privacy_Data_Removal_Requests_List_Table.construct(var_args_mutated.clone())
}

fn _wp_privacy_requests_screen_options() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.3.0')])
}

fn image_attachment_fields_to_save(var_post rt.PhpVal, var_attachment rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.0.0')])
	return var_post.clone()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class__WP_Editors {
	rt.PhpObjectBase
}

struct Class_WP_Screen {
	rt.PhpObjectBase
}

struct Class_Core_Upgrader {
	rt.PhpObjectBase
}

struct Class_Plugin_Upgrader {
	rt.PhpObjectBase
}

struct Class_Theme_Upgrader {
	rt.PhpObjectBase
}

struct Class_WP_Privacy_Data_Export_Requests_List_Table {
	rt.PhpObjectBase
}

struct Class_WP_Privacy_Data_Removal_Requests_List_Table {
	rt.PhpObjectBase
}

fn create_wp_privacy_data_export_requests_table(arg_0 rt.PhpVal) &Class_WP_Privacy_Data_Export_Requests_Table {
	mut obj := &Class_WP_Privacy_Data_Export_Requests_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_privacy_data_removal_requests_table(arg_0 rt.PhpVal) &Class_WP_Privacy_Data_Removal_Requests_Table {
	mut obj := &Class_WP_Privacy_Data_Removal_Requests_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_user_search(search_term string, page string, role string) &Class_WP_User_Search {
	mut obj := &Class_WP_User_Search{
		PhpObjectBase:         rt.PhpObjectBase{}
		results:               rt.new_null()
		search_term:           rt.new_null()
		page:                  rt.new_null()
		role:                  rt.new_null()
		raw_page:              rt.new_null()
		users_per_page:        rt.new_int(50)
		first_user:            rt.new_null()
		last_user:             rt.new_null()
		query_limit:           rt.new_null()
		query_orderby:         ''
		query_from:            ''
		query_where:           ''
		total_users_for_query: rt.new_int(0)
		too_many_total_users:  rt.new_bool(false)
		search_errors:         rt.new_null()
		paging_text:           rt.new_null()
	}
	obj.construct(search_term, page, role)
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create__wp_editors(_args ...rt.PhpVal) &Class__WP_Editors {
	mut obj := &Class__WP_Editors{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_screen(_args ...rt.PhpVal) &Class_WP_Screen {
	mut obj := &Class_WP_Screen{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_core_upgrader(_args ...rt.PhpVal) &Class_Core_Upgrader {
	mut obj := &Class_Core_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_plugin_upgrader(_args ...rt.PhpVal) &Class_Plugin_Upgrader {
	mut obj := &Class_Plugin_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_theme_upgrader(_args ...rt.PhpVal) &Class_Theme_Upgrader {
	mut obj := &Class_Theme_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_privacy_data_export_requests_list_table(_args ...rt.PhpVal) &Class_WP_Privacy_Data_Export_Requests_List_Table {
	mut obj := &Class_WP_Privacy_Data_Export_Requests_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_privacy_data_removal_requests_list_table(_args ...rt.PhpVal) &Class_WP_Privacy_Data_Removal_Requests_List_Table {
	mut obj := &Class_WP_Privacy_Data_Removal_Requests_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Privacy_Data_Export_Requests_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Privacy_Data_Export_Requests_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Privacy_Data_Export_Requests_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Privacy_Data_Removal_Requests_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Privacy_Data_Removal_Requests_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Privacy_Data_Removal_Requests_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_User_Search) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'WP_User_Search' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.wp_user_search(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'prepare_query' {
			this.prepare_query()
			return rt.new_null()
		}
		'query' {
			this.query()
			return rt.new_null()
		}
		'prepare_vars_for_template_usage' {
			this.prepare_vars_for_template_usage()
			return rt.new_null()
		}
		'do_paging' {
			this.do_paging()
			return rt.new_null()
		}
		'get_results' {
			return this.get_results()
		}
		'page_links' {
			this.page_links()
			return rt.new_null()
		}
		'results_are_paged' {
			return rt.new_bool(this.results_are_paged())
		}
		'is_search' {
			return rt.new_bool(this.is_search())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_User_Search) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'results' { return this.results }
		'search_term' { return this.search_term }
		'page' { return this.page }
		'role' { return this.role }
		'raw_page' { return this.raw_page }
		'users_per_page' { return this.users_per_page }
		'first_user' { return this.first_user }
		'last_user' { return this.last_user }
		'query_limit' { return this.query_limit }
		'query_orderby' { return rt.new_string(this.query_orderby) }
		'query_from' { return rt.new_string(this.query_from) }
		'query_where' { return rt.new_string(this.query_where) }
		'total_users_for_query' { return this.total_users_for_query }
		'too_many_total_users' { return this.too_many_total_users }
		'search_errors' { return this.search_errors }
		'paging_text' { return this.paging_text }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_User_Search) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'results' {
			this.results = val
			return true
		}
		'search_term' {
			this.search_term = val
			return true
		}
		'page' {
			this.page = val
			return true
		}
		'role' {
			this.role = val
			return true
		}
		'raw_page' {
			this.raw_page = val
			return true
		}
		'users_per_page' {
			this.users_per_page = val
			return true
		}
		'first_user' {
			this.first_user = val
			return true
		}
		'last_user' {
			this.last_user = val
			return true
		}
		'query_limit' {
			this.query_limit = val
			return true
		}
		'query_orderby' {
			this.query_orderby = val.str()
			return true
		}
		'query_from' {
			this.query_from = val.str()
			return true
		}
		'query_where' {
			this.query_where = val.str()
			return true
		}
		'total_users_for_query' {
			this.total_users_for_query = val
			return true
		}
		'too_many_total_users' {
			this.too_many_total_users = val
			return true
		}
		'search_errors' {
			this.search_errors = val
			return true
		}
		'paging_text' {
			this.paging_text = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class__WP_Editors) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class__WP_Editors) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class__WP_Editors) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Screen) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Screen) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Screen) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Core_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Core_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Core_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Plugin_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Plugin_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Plugin_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Theme_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Theme_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Theme_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Privacy_Data_Export_Requests_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Privacy_Data_Export_Requests_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Privacy_Data_Export_Requests_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Privacy_Data_Removal_Requests_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Privacy_Data_Removal_Requests_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Privacy_Data_Removal_Requests_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_User_Search'),
		rt.new_bool(false),
	])))))
	{
	}
}
