import rt

fn tinymce_include() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.1.0'), rt.new_string('wp_editor()')])
	wp_tiny_mce(false, false)
}

fn documentation_link() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.5.0')])
}

fn wp_shrink_dimensions(var_width rt.PhpVal, var_height rt.PhpVal, wmax i64, hmax i64) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('wp_constrain_dimensions()')])
	return rt.call_function('wp_constrain_dimensions', [var_width.dup(), var_height.dup(), rt.new_int(wmax), rt.new_int(hmax)])
}

fn get_udims(var_width rt.PhpVal, var_height rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.5.0'), rt.new_string('wp_constrain_dimensions()')])
	return rt.call_function('wp_constrain_dimensions', [var_width.dup(), var_height.dup(), rt.new_int(128), rt.new_int(96)])
}

fn dropdown_categories(default_category i64, category_parent i64, var_popular_ids rt.PhpVal) {
	mut var_post_ID := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.6.0'), rt.new_string('wp_category_checklist()')])
	// unsupported statement: Stmt_Global
	rt.call_function('wp_category_checklist', [var_post_ID.dup()])
}

fn dropdown_link_categories(default_link_category i64) {
	mut var_link_id := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.6.0'), rt.new_string('wp_link_category_checklist()')])
	// unsupported statement: Stmt_Global
	rt.call_function('wp_link_category_checklist', [var_link_id.dup()])
}

fn get_real_file_to_edit(var_file rt.PhpVal) string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.9.0')])
	return (rt.get_constant('WP_CONTENT_DIR')).str() + (var_file).str()
}

fn wp_dropdown_cats(current_cat i64, current_parent i64, category_parent i64, level i64, categories i64) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('wp_dropdown_categories()')])
	if !(var_categories != 0) {
		categories = (rt.call_function('get_categories', [rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: 0 }])])).to_i64()
	}
	if var_categories != 0 {
		{
			mut iter_1 := rt.new_int(categories).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_category := item_1.val
				if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) && rt.is_true(rt.equal(rt.new_int(category_parent), rt.get_property(var_category, 'parent'))))) {
					mut var_pad := rt.call_function('str_repeat', [rt.new_string('&#8211; '), rt.new_int(level)])
					rt.set_property(var_category, 'name', rt.call_function('esc_html', [rt.get_property(var_category, 'name')]))
					print(rt.concat(rt.concat(rt.new_string('\n\t<option value=\''), rt.get_property(var_category, 'term_id')), rt.new_string('\'')))
					if rt.is_true(rt.equal(rt.new_int(current_parent), rt.get_property(var_category, 'term_id'))) {
						print(' selected=\'selected\'')
					}
					print(rt.concat(rt.concat(rt.concat(rt.new_string('>'), var_pad), rt.get_property(var_category, 'name')), rt.new_string('</option>')))
					rt.new_bool(wp_dropdown_cats(current_cat, current_parent, rt.get_property(var_category, 'term_id'), level + 1, categories))
				}
			}
		}
	} else {
		return false
	}
	return false
}

fn add_option_update_handler(var_option_group rt.PhpVal, var_option_name rt.PhpVal, sanitize_callback string) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('register_setting()')])
	rt.call_function('register_setting', [var_option_group.dup(), var_option_name.dup(), rt.new_string(sanitize_callback)])
}

fn remove_option_update_handler(var_option_group rt.PhpVal, var_option_name rt.PhpVal, sanitize_callback string) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('unregister_setting()')])
	rt.call_function('unregister_setting', [var_option_group.dup(), var_option_name.dup(), rt.new_string(sanitize_callback)])
}

fn codepress_get_lang(var_filename rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0')])
}

fn codepress_footer_js() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0')])
}

fn use_codepress() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0')])
}

fn get_author_user_ids() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.1.0'), rt.new_string('get_users()')])
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		mut var_level_key := rt.new_string((rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'user_level')
	} else {
		var_level_key = rt.new_string((rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'capabilities')
	}
	return rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT user_id FROM '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string(' WHERE meta_key = %s AND meta_value != \'0\'')), var_level_key.dup()])])
}

fn get_editable_authors(var_user_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.1.0'), rt.new_string('get_users()')])
	// unsupported statement: Stmt_Global
	mut var_editable := get_editable_user_ids(var_user_id.dup(), false, '')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_editable)))) {
		return false
	} else {
		var_editable = rt.call_function('join', [rt.new_string(','), var_editable.dup()])
		mut var_authors := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'users')), rt.new_string(' WHERE ID IN (')), var_editable), rt.new_string(') ORDER BY display_name'))])
	}
	return (rt.call_function('apply_filters', [rt.new_string('get_editable_authors'), var_authors.dup()])).to_bool()
}

fn get_editable_user_ids(var_user_id rt.PhpVal, exclude_zeros bool, post_type string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.1.0'), rt.new_string('get_users()')])
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(mut var_user := rt.call_function('get_userdata', [var_user_id.dup()]))))) {
		return rt.new_array()
	}
	mut var_post_type_obj := rt.call_function('get_post_type_object', [rt.new_string(post_type)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'has_cap', [rt.get_property(rt.get_property(var_post_type_obj, 'cap'), 'edit_others_posts')]))))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_user, 'has_cap', [rt.get_property(rt.get_property(var_post_type_obj, 'cap'), 'edit_posts')])) || !(var_exclude_zeros))) {
			return rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_user, 'ID') }])
		} else {
			return rt.new_array()
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		mut var_level_key := rt.new_string((rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'user_level')
	} else {
		var_level_key = rt.new_string((rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'capabilities')
	}
	mut var_query := rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT user_id FROM '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string(' WHERE meta_key = %s')), var_level_key.dup()])
	if var_exclude_zeros {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return rt.call_method(var_wpdb, 'get_col', [var_query.dup()])
}

fn get_nonauthor_user_ids() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.1.0'), rt.new_string('get_users()')])
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		mut var_level_key := rt.new_string((rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'user_level')
	} else {
		var_level_key = rt.new_string((rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'capabilities')
	}
	return rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT user_id FROM '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string(' WHERE meta_key = %s AND meta_value = \'0\'')), var_level_key.dup()])])
}

struct Class_WP_User_Search {
	rt.PhpObjectBase
pub mut:
			results rt.PhpVal = rt.new_null()
			search_term rt.PhpVal = rt.new_null()
			page rt.PhpVal = rt.new_null()
			role rt.PhpVal = rt.new_null()
			raw_page rt.PhpVal = rt.new_null()
			users_per_page rt.PhpVal = rt.new_int(50)
			first_user rt.PhpVal = rt.new_null()
			last_user rt.PhpVal = rt.new_null()
			query_limit rt.PhpVal = rt.new_null()
			query_orderby string
			query_from string
			query_where string
			total_users_for_query rt.PhpVal = rt.new_int(0)
			too_many_total_users rt.PhpVal = rt.new_bool(false)
			search_errors rt.PhpVal = rt.new_null()
			paging_text rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_User_Search) construct(search_term string, page string, role string)  {
	mut page_mutated := page
	rt.call_function('_deprecated_class', [rt.new_string('WP_User_Search'), rt.new_string('3.1.0'), rt.new_string('WP_User_Query')])
	this.search_term = rt.call_function('wp_unslash', [rt.new_string(search_term)])
	this.raw_page = if rt.is_true(rt.equal(rt.new_string(''), rt.new_string(page_mutated))) { rt.new_bool(false) } else { // unsupported expression: Expr_Cast_Int }
	this.page = if rt.is_true(rt.equal(rt.new_string(''), rt.new_string(page_mutated))) { rt.new_int(1) } else { // unsupported expression: Expr_Cast_Int }
	this.role = rt.new_string(role).dup()
	this.prepare_query()
	this.query()
	this.do_paging()
}

fn (mut this Class_WP_User_Search) wp_user_search(search_term string, page string, role string)  {
	mut page_mutated := page
	rt.call_function('_deprecated_constructor', [rt.new_string('WP_User_Search'), rt.new_string('3.1.0'), rt.call_function('get_class', [rt.new_object('WP_User_Search', []string{}, &this)])])
	fn (arg_0 string, arg_1 string, arg_2 string) rt.PhpVal { mut temp := Class_WP_User_Search{}; temp.construct(arg_0, arg_1, arg_2); return rt.new_null() }(search_term, page_mutated, role)
}

fn (mut this Class_WP_User_Search) prepare_query()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	this.first_user = rt.mul(rt.sub(this.page, rt.new_int(1)), this.users_per_page)
	this.query_limit = rt.call_method(var_wpdb, 'prepare', [rt.new_string(' LIMIT %d, %d'), this.first_user, this.users_per_page])
	this.query_orderby = ' ORDER BY user_login'
	mut var_search_sql := rt.new_string(rt.new_string(''))
	if rt.is_true(this.search_term) {
		mut var_searches := rt.new_array()
		var_search_sql = rt.new_string(rt.new_string('AND ('))
		{
			mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'user_login' }, rt.ArrayItem{ key: none, val: 'user_nicename' }, rt.ArrayItem{ key: none, val: 'user_email' }, rt.ArrayItem{ key: none, val: 'user_url' }, rt.ArrayItem{ key: none, val: 'display_name' }]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_col := item_1.val
				 << 
			}
		}
		
	}
	
}

fn (mut this Class_WP_User_Search) query()  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WP_User_Search) prepare_vars_for_template_usage()  {
}

fn (mut this Class_WP_User_Search) do_paging()  {
}

fn (mut this Class_WP_User_Search) get_results() rt.PhpVal {
}

fn (mut this Class_WP_User_Search) page_links()  {
}

fn (mut this Class_WP_User_Search) results_are_paged() bool {
}

fn (mut this Class_WP_User_Search) is_search() bool {
}

fn get_others_unpublished_posts(var_user_id rt.PhpVal, type string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn create_wp_privacy_data_export_requests_table() &Class_WP_Privacy_Data_Export_Requests_Table {
	mut obj := &Class_WP_Privacy_Data_Export_Requests_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_privacy_data_removal_requests_table() &Class_WP_Privacy_Data_Removal_Requests_Table {
	mut obj := &Class_WP_Privacy_Data_Removal_Requests_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user_search(search_term string, page string, role string) &Class_WP_User_Search {
	mut obj := &Class_WP_User_Search{
		PhpObjectBase: rt.PhpObjectBase{}
		results: rt.new_null()
		search_term: rt.new_null()
		page: rt.new_null()
		role: rt.new_null()
		raw_page: rt.new_null()
		users_per_page: rt.new_int(50)
		first_user: rt.new_null()
		last_user: rt.new_null()
		query_limit: rt.new_null()
		query_orderby: ''
		query_from: ''
		query_where: ''
		total_users_for_query: rt.new_int(0)
		too_many_total_users: rt.new_bool(false)
		search_errors: rt.new_null()
		paging_text: rt.new_null()
	}
	obj.construct(search_term, page, role)
	return obj
}

fn (mut this Class_WP_Privacy_Data_Export_Requests_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Privacy_Data_Export_Requests_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.Class_WP_Privacy_Data_Export_Requests_List_Table.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Privacy_Data_Export_Requests_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.Class_WP_Privacy_Data_Export_Requests_List_Table.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Privacy_Data_Removal_Requests_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Privacy_Data_Removal_Requests_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.Class_WP_Privacy_Data_Removal_Requests_List_Table.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Privacy_Data_Removal_Requests_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.Class_WP_Privacy_Data_Removal_Requests_List_Table.dispatch_set_prop(prop_name, val)
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
		else { return none }
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
		'results' { this.results = val; return true }
		'search_term' { this.search_term = val; return true }
		'page' { this.page = val; return true }
		'role' { this.role = val; return true }
		'raw_page' { this.raw_page = val; return true }
		'users_per_page' { this.users_per_page = val; return true }
		'first_user' { this.first_user = val; return true }
		'last_user' { this.last_user = val; return true }
		'query_limit' { this.query_limit = val; return true }
		'query_orderby' { this.query_orderby = (val).str(); return true }
		'query_from' { this.query_from = (val).str(); return true }
		'query_where' { this.query_where = (val).str(); return true }
		'total_users_for_query' { this.total_users_for_query = val; return true }
		'too_many_total_users' { this.too_many_total_users = val; return true }
		'search_errors' { this.search_errors = val; return true }
		'paging_text' { this.paging_text = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_admin_includes_deprecated_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_User_Search'), rt.new_bool(false)]))))) {
	}
}
