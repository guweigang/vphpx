import rt

const global_const_ezsql_version = 'WP1.25'
const global_const_object = 'OBJECT'
const global_const_object = 'OBJECT'
const global_const_object_k = 'OBJECT_K'
const global_const_array_a = 'ARRAY_A'
const global_const_array_n = 'ARRAY_N'
struct Class_wpdb {
	rt.PhpObjectBase
pub mut:
		show_errors rt.PhpVal = rt.new_bool(false)
		suppress_errors rt.PhpVal = rt.new_bool(false)
		last_error rt.PhpVal = rt.new_string('')
		num_queries rt.PhpVal = rt.new_int(0)
		num_rows rt.PhpVal = rt.new_int(0)
		rows_affected rt.PhpVal = rt.new_int(0)
		insert_id rt.PhpVal = rt.new_int(0)
		last_query rt.PhpVal = rt.new_null()
		last_result rt.PhpVal = rt.new_null()
		result rt.PhpVal = rt.new_null()
		col_meta rt.PhpVal = rt.new_array()
		table_charset rt.PhpVal = rt.new_array()
		check_current_query bool
		checking_collation bool
		col_info rt.PhpVal = rt.new_null()
		queries rt.PhpVal = rt.new_null()
		reconnect_retries rt.PhpVal = rt.new_int(5)
		prefix rt.PhpVal = rt.new_string('')
		base_prefix rt.PhpVal = rt.new_null()
		ready bool
		blogid rt.PhpVal = rt.new_int(0)
		siteid rt.PhpVal = rt.new_int(0)
		tables rt.PhpVal = rt.new_array()
		old_tables rt.PhpVal = rt.new_array()
		global_tables rt.PhpVal = rt.new_array()
		ms_global_tables rt.PhpVal = rt.new_array()
		old_ms_global_tables rt.PhpVal = rt.new_array()
		comments rt.PhpVal = rt.new_null()
		commentmeta rt.PhpVal = rt.new_null()
		links rt.PhpVal = rt.new_null()
		options rt.PhpVal = rt.new_null()
		postmeta rt.PhpVal = rt.new_null()
		posts rt.PhpVal = rt.new_null()
		terms rt.PhpVal = rt.new_null()
		term_relationships rt.PhpVal = rt.new_null()
		term_taxonomy rt.PhpVal = rt.new_null()
		termmeta rt.PhpVal = rt.new_null()
		usermeta rt.PhpVal = rt.new_null()
		users rt.PhpVal = rt.new_null()
		blogs rt.PhpVal = rt.new_null()
		blogmeta rt.PhpVal = rt.new_null()
		registration_log rt.PhpVal = rt.new_null()
		signups rt.PhpVal = rt.new_null()
		site rt.PhpVal = rt.new_null()
		sitecategories rt.PhpVal = rt.new_null()
		sitemeta rt.PhpVal = rt.new_null()
		field_types rt.PhpVal = rt.new_array()
		charset rt.PhpVal = rt.new_null()
		collate rt.PhpVal = rt.new_null()
		dbuser rt.PhpVal = rt.new_null()
		dbpassword rt.PhpVal = rt.new_null()
		dbname rt.PhpVal = rt.new_null()
		dbhost rt.PhpVal = rt.new_null()
		dbh rt.PhpVal = rt.new_null()
		func_call string
		is_mysql bool
		incompatible_modes rt.PhpVal = rt.new_array()
		allow_unsafe_unquoted_parameters rt.PhpVal = rt.new_bool(true)
		use_mysqli rt.PhpVal = rt.new_bool(true)
		has_connected bool
		time_start rt.PhpVal = rt.new_null()
		error rt.PhpVal = rt.new_null()
}

fn (mut this Class_wpdb) construct(var_dbuser rt.PhpVal, var_dbpassword rt.PhpVal, var_dbname rt.PhpVal, var_dbhost rt.PhpVal) {
	if rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY')) {
		this.show_errors(false)
	}
	this.dbuser = var_dbuser.clone()
	this.dbpassword = var_dbpassword.clone()
	this.dbname = var_dbname.clone()
	this.dbhost = var_dbhost.clone()
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_SETUP_CONFIG')])) {
		return
	}
	this.db_connect(false)
}

fn (mut this Class_wpdb) magic_get(var_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('col_info'), var_name)) {
		this.load_col_info()
	}
	return rt.get_property(rt.new_object('wpdb', []string{}, &this), '{"nodeType":"Expr_Variable","line":788,"name":"name"}')
}

fn (mut this Class_wpdb) magic_set(var_name rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	mut var_protected_members := ['col_meta', 'table_charset', 'check_current_query', 'allow_unsafe_unquoted_parameters']
	if rt.is_true(rt.call_function('in_array', [var_name.clone(), rt.create_array_from_list(var_protected_members), rt.new_bool(true)])) {
		return
	}
	this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":809,"name":"name"}', var_value_mutated.clone())
}

fn (mut this Class_wpdb) magic_isset(var_name rt.PhpVal) rt.PhpVal {
	return rt.new_bool(!(rt.get_property(rt.new_object('wpdb', []string{}, &this), '{"nodeType":"Expr_Variable","line":821,"name":"name"}')).is_null())
}

fn (mut this Class_wpdb) magic_unset(var_name rt.PhpVal) {
	rt.get_property(rt.new_object('wpdb', []string{}, &this), '{"nodeType":"Expr_Variable","line":832,"name":"name"}') = rt.new_null()
}

fn (mut this Class_wpdb) init_charset() {
	mut var_charset := rt.new_string('')
	mut var_collate := rt.new_string('')
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('is_multisite')])) && rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_charset = rt.new_string('utf8')
		if rt.is_true(rt.call_function('defined', [rt.new_string('DB_COLLATE')])) && rt.is_true(rt.get_constant('DB_COLLATE')) {
		var_collate = rt.get_constant('DB_COLLATE')
		} else {
		var_collate = rt.new_string('utf8_general_ci')
		}
	} else if rt.is_true(rt.call_function('defined', [rt.new_string('DB_COLLATE')])) {
	var_collate = rt.get_constant('DB_COLLATE')
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('DB_CHARSET')])) {
	var_charset = rt.get_constant('DB_CHARSET')
	}
	mut var_charset_collate := this.determine_charset(var_charset.clone(), var_collate.clone())
	this.charset = var_charset_collate.array_get(rt.new_string('charset'))
	this.collate = var_charset_collate.array_get(rt.new_string('collate'))
}

fn (mut this Class_wpdb) determine_charset(var_charset rt.PhpVal, var_collate rt.PhpVal) rt.PhpVal {
	mut var_charset_mutated := var_charset
	mut var_collate_mutated := var_collate
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.dbh, 'mysqli')))))) || !rt.is_true(this.dbh) {
		return rt.call_function('compact', [rt.new_string('charset'), rt.new_string('collate')])
	}
	if rt.is_true(rt.identical(rt.new_string('utf8'), var_charset_mutated)) {
	var_charset_mutated = rt.new_string('utf8mb4')
	}
	if rt.is_true(rt.identical(rt.new_string('utf8mb4'), var_charset_mutated)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_collate_mutated)))) || rt.is_true(rt.identical(rt.new_string('utf8_general_ci'), var_collate_mutated)) {
		var_collate_mutated = rt.new_string('utf8mb4_unicode_ci')
		} else {
		var_collate_mutated = rt.call_function('str_replace', [rt.new_string('utf8_'), rt.new_string('utf8mb4_'), var_collate_mutated.clone()])
		}
	}
	if this.has_cap(rt.new_string('utf8mb4_520')) && rt.is_true(rt.identical(rt.new_string('utf8mb4_unicode_ci'), var_collate_mutated)) {
	var_collate_mutated = rt.new_string('utf8mb4_unicode_520_ci')
	}
	return rt.call_function('compact', [rt.new_string('charset'), rt.new_string('collate')])
}

fn (mut this Class_wpdb) set_charset(var_dbh rt.PhpVal, var_charset rt.PhpVal, var_collate rt.PhpVal) {
	mut var_dbh_mutated := var_dbh
	mut var_charset_mutated := var_charset
	mut var_collate_mutated := var_collate
	if !(!(var_charset_mutated).is_null()) {
	var_charset_mutated = this.charset
	}
	if !(!(var_collate_mutated).is_null()) {
	var_collate_mutated = this.collate
	}
	if this.has_cap(rt.new_string('collation')) && !(!rt.is_true(var_charset_mutated)) {
		mut var_set_charset_succeeded := rt.new_bool(true)
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('mysqli_set_charset')])) && this.has_cap(rt.new_string('set_charset')) {
		var_set_charset_succeeded = rt.call_function('mysqli_set_charset', [var_dbh_mutated.clone(), var_charset_mutated.clone()])
		}
		if rt.is_true(var_set_charset_succeeded) {
			mut var_query := rt.new_string(this.prepare(rt.new_string('SET NAMES %s'), var_charset_mutated.clone()))
			if !(!rt.is_true(var_collate_mutated)) {
				var_query = rt.concat(var_query, this.prepare(rt.new_string(' COLLATE %s'), var_collate_mutated.clone()))
			}
			rt.call_function('mysqli_query', [var_dbh_mutated.clone(), var_query.clone()])
		}
	}
}

fn (mut this Class_wpdb) set_sql_mode(var_modes rt.PhpVal) {
	mut var_modes_mutated := var_modes
	if !rt.is_true(var_modes_mutated) {
		mut var_res := rt.call_function('mysqli_query', [this.dbh, rt.new_string('SELECT @@SESSION.sql_mode')])
		if !rt.is_true(var_res) {
			return
		}
		mut var_modes_array := rt.call_function('mysqli_fetch_array', [var_res.clone()])
		if !rt.is_true(var_modes_array.array_get(rt.new_int(0))) {
			return
		}
	var_modes_mutated = rt.call_function('explode', [rt.new_string(','), var_modes_array.array_get(rt.new_int(0))])
	}
	var_modes_mutated = rt.call_function('array_change_key_case', [var_modes_mutated.clone(), rt.get_constant('CASE_UPPER')])
	mut var_incompatible_modes := rt.cast_array(rt.call_function('apply_filters', [rt.new_string('incompatible_sql_modes'), this.incompatible_modes]))
	mut iter_1 := var_modes_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_mode := item_1.val
		mut var_i := item_1.key
		if rt.is_true(rt.call_function('in_array', [var_mode.clone(), var_incompatible_modes.clone(), rt.new_bool(true)])) {
			var_modes_mutated.array_unset(var_i)
		}
	}
	mut var_modes_str := rt.call_function('implode', [rt.new_string(','), var_modes_mutated.clone()])
	rt.call_function('mysqli_query', [this.dbh, rt.new_string("SET SESSION sql_mode='${var_modes_str.to_string()}'")])
}

fn (mut this Class_wpdb) set_prefix(var_prefix rt.PhpVal, set_table_names bool) rt.PhpVal {
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('|[^a-z0-9_]|i'), var_prefix.clone()])) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_db_prefix'), rt.new_string('Invalid database prefix')))
	}
	mut var_old_prefix := if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.new_string('') } else { var_prefix }
	if !(this.base_prefix).is_null() {
	var_old_prefix = this.base_prefix
	}
	this.base_prefix = var_prefix.clone()
	if var_set_table_names {
		mut iter_2 := this.tables('global', false, 0).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_prefixed_table := item_2.val
			mut var_table := item_2.key
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":1014,"name":"table"}', var_prefixed_table.clone())
		}
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && !rt.is_true(this.blogid) {
			return var_old_prefix.clone()
		}
		this.prefix = this.get_blog_prefix(rt.new_null())
		mut iter_3 := this.tables('blog', false, 0).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_prefixed_table := item_3.val
			mut var_table := item_3.key
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":1024,"name":"table"}', var_prefixed_table.clone())
		}
		mut iter_4 := this.tables('old', false, 0).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_prefixed_table := item_4.val
			mut var_table := item_4.key
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":1028,"name":"table"}', var_prefixed_table.clone())
		}
	}
	return var_old_prefix.clone()
}

fn (mut this Class_wpdb) set_blog_id(var_blog_id rt.PhpVal, network_id i64) rt.PhpVal {
	mut var_blog_id_mutated := var_blog_id
	if !(network_id == 0) {
		this.siteid = rt.new_int(network_id)
	}
	mut var_old_blog_id := this.blogid
	this.blogid = var_blog_id_mutated.clone()
	this.prefix = this.get_blog_prefix(rt.new_null())
	mut iter_5 := this.tables('blog', false, 0).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_prefixed_table := item_5.val
		mut var_table := item_5.key
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":1054,"name":"table"}', var_prefixed_table.clone())
	}
	mut iter_6 := this.tables('old', false, 0).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_prefixed_table := item_6.val
		mut var_table := item_6.key
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":1058,"name":"table"}', var_prefixed_table.clone())
	}
	return var_old_blog_id.clone()
}

fn (mut this Class_wpdb) get_blog_prefix(var_blog_id rt.PhpVal) string {
	mut var_blog_id_mutated := var_blog_id
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		if rt.is_true(rt.identical(rt.new_null(), var_blog_id_mutated)) {
		var_blog_id_mutated = this.blogid
		}
		var_blog_id_mutated = rt.new_int((var_blog_id_mutated).to_i64())
		if rt.is_true(rt.call_function('defined', [rt.new_string('MULTISITE')])) && rt.is_true(rt.identical(rt.new_int(0), var_blog_id_mutated)) || rt.is_true(rt.identical(rt.new_int(1), var_blog_id_mutated)) {
			return (this.base_prefix).str()
		} else {
			return (this.base_prefix).str() + (var_blog_id_mutated).str() + '_'
		}
	} else {
		return (this.base_prefix).str()
	}
	return ''
}

fn (mut this Class_wpdb) tables(scope string, prefix bool, blog_id i64) rt.PhpVal {
	mut blog_id_mutated := blog_id
	mut switch_val_1 := rt.new_string(scope)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('all'))) {
		mut var_tables := rt.call_function('array_merge', [this.global_tables, this.tables])
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_tables = rt.call_function('array_merge', [var_tables.clone(), this.ms_global_tables])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('blog'))) {
	var_tables = this.tables
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('global'))) {
		var_tables = this.global_tables
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_tables = rt.call_function('array_merge', [var_tables.clone(), this.ms_global_tables])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('ms_global'))) {
	var_tables = this.ms_global_tables
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('old'))) {
		var_tables = this.old_tables
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_tables = rt.call_function('array_merge', [var_tables.clone(), this.old_ms_global_tables])
		}
	} else {
		return rt.new_array()
	}
	if var_prefix {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(blog_id_mutated))))) {
		blog_id_mutated = (this.blogid).to_i64()
		}
		mut var_blog_prefix := rt.new_string(this.get_blog_prefix(rt.new_int(blog_id_mutated)))
		mut var_base_prefix := this.base_prefix
		mut var_global_tables := rt.call_function('array_merge', [this.global_tables, this.ms_global_tables])
		mut iter_7 := var_tables.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_table := item_7.val
			mut var_k := item_7.key
			if rt.is_true(rt.call_function('in_array', [var_table.clone(), var_global_tables.clone(), rt.new_bool(true)])) {
				var_tables.array_set(var_table, (var_base_prefix).str() + (var_table).str())
			} else {
				var_tables.array_set(var_table, (var_blog_prefix).str() + (var_table).str())
			}
			var_tables.array_unset(var_k)
		}
		if var_tables.array_isset(rt.new_string('users')) && rt.is_true(rt.call_function('defined', [rt.new_string('CUSTOM_USER_TABLE')])) {
			var_tables.array_set('users', rt.get_constant('CUSTOM_USER_TABLE'))
		}
		if var_tables.array_isset(rt.new_string('usermeta')) && rt.is_true(rt.call_function('defined', [rt.new_string('CUSTOM_USER_META_TABLE')])) {
			var_tables.array_set('usermeta', rt.get_constant('CUSTOM_USER_META_TABLE'))
		}
	}
	return var_tables.clone()
}

fn (mut this Class_wpdb) select(var_db rt.PhpVal, var_dbh rt.PhpVal) {
	mut var_dbh_mutated := var_dbh
	if rt.is_true(rt.new_bool(var_dbh_mutated.clone().is_null())) {
	var_dbh_mutated = this.dbh
	}
	mut var_success := rt.call_function('mysqli_select_db', [var_dbh_mutated.clone(), var_db.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_success)))) {
		this.ready = false
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('template_redirect')]))))) {
			rt.call_function('wp_load_translations_early', []rt.PhpVal{})
			mut var_message := rt.new_string('<h1>' + (rt.call_function('__', [rt.new_string('Cannot select database')])).str() + '</h1>\n')
			var_message = rt.concat(var_message, rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The database server could be connected to (which means your username and password is okay) but the %s database could not be selected.')]), rt.new_string('<code>' + (rt.call_function('htmlspecialchars', [var_db.clone(), rt.get_constant('ENT_QUOTES')])).str() + '</code>')])).str() + '</p>\n'))
			var_message = rt.concat(var_message, rt.new_string('<ul>\n'))
			var_message = rt.concat(var_message, rt.new_string('<li>' + (rt.call_function('__', [rt.new_string('Are you sure it exists?')])).str() + '</li>\n'))
			var_message = rt.concat(var_message, rt.new_string('<li>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Does the user %1$s have permission to use the %2$s database?')]), rt.new_string('<code>' + (rt.call_function('htmlspecialchars', [this.dbuser, rt.get_constant('ENT_QUOTES')])).str() + '</code>'), rt.new_string('<code>' + (rt.call_function('htmlspecialchars', [var_db.clone(), rt.get_constant('ENT_QUOTES')])).str() + '</code>')])).str() + '</li>\n'))
			var_message = rt.concat(var_message, rt.new_string('<li>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('On some systems the name of your database is prefixed with your username, so it would be like <code>username_%1$s</code>. Could that be the problem?')]), rt.call_function('htmlspecialchars', [var_db.clone(), rt.get_constant('ENT_QUOTES')])])).str() + '</li>\n'))
			var_message = rt.concat(var_message, rt.new_string('</ul>\n'))
			var_message = rt.concat(var_message, rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you do not know how to set up a database you should <strong>contact your host</strong>. If all else fails you may find help at the <a href="%s">WordPress support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])])).str() + '</p>\n'))
			this.bail(var_message.clone(), 'db_select_fail')
		}
	}
}

fn (mut this Class_wpdb) _weak_escape(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if rt.is_true(rt.identical(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(1))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('_deprecated_function')])) {
		rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('3.6.0'), rt.new_string('wpdb::prepare() or esc_sql()')])
	}
	return rt.call_function('addslashes', [var_data_mutated.clone()])
}

fn (mut this Class_wpdb) _real_escape(var_data rt.PhpVal) string {
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_data_mutated.clone()]))))) {
		return ''
	}
	if rt.is_true(this.dbh) {
	mut var_escaped := rt.call_function('mysqli_real_escape_string', [this.dbh, var_data_mutated.clone()])
	} else {
		mut var_class := rt.call_function('get_class', [rt.new_object('wpdb', []string{}, &this)])
		rt.call_function('wp_load_translations_early', []rt.PhpVal{})
		rt.call_function('_doing_it_wrong', [var_class.clone(), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s must set a database connection for use with escaping.')]), var_class.clone()]), rt.new_string('3.6.0')])
	var_escaped = rt.call_function('addslashes', [var_data_mutated.clone()])
	}
	return (this.add_placeholder_escape(var_escaped.clone())).str()
}

fn (mut this Class_wpdb) _escape(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(var_data_mutated.clone().is_array())) {
		mut iter_8 := var_data_mutated.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_v := item_8.val
			mut var_k := item_8.key
			if rt.is_true(rt.new_bool(var_v.clone().is_array())) {
				var_data_mutated.array_set(var_k, this._escape(var_v.clone()))
			} else {
				var_data_mutated.array_set(var_k, this._real_escape(var_v.clone()))
			}
		}
	} else {
	var_data_mutated = rt.new_string(this._real_escape(var_data_mutated.clone()))
	}
	return var_data_mutated.clone()
}

fn (mut this Class_wpdb) escape(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if rt.is_true(rt.identical(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(1))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('_deprecated_function')])) {
		rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('3.6.0'), rt.new_string('wpdb::prepare() or esc_sql()')])
	}
	if rt.is_true(rt.new_bool(var_data_mutated.clone().is_array())) {
		mut iter_9 := var_data_mutated.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_v := item_9.val
			mut var_k := item_9.key
			if rt.is_true(rt.new_bool(var_v.clone().is_array())) {
				var_data_mutated.array_set(var_k, this.escape(var_v.clone(), rt.new_string('recursive')))
			} else {
				var_data_mutated.array_set(var_k, this._weak_escape(var_v.clone(), rt.new_string('internal')))
			}
		}
	} else {
	var_data_mutated = this._weak_escape(var_data_mutated.clone(), rt.new_string('internal'))
	}
	return var_data_mutated.clone()
}

fn (mut this Class_wpdb) escape_by_ref(var_data rt.PhpVal) {
	mut var_data_mutated := var_data
	if !(var_data_mutated.clone().is_double()) {
	var_data_mutated = rt.new_string(this._real_escape(var_data_mutated.clone()))
	}
}

fn (mut this Class_wpdb) quote_identifier(var_identifier rt.PhpVal) string {
	return '`' + (this._escape_identifier_value(var_identifier.clone())).str() + '`'
}

fn (mut this Class_wpdb) _escape_identifier_value(var_identifier rt.PhpVal) rt.PhpVal {
	return rt.call_function('str_replace', [rt.new_string('`'), rt.new_string('``'), var_identifier.clone()])
}

fn (mut this Class_wpdb) prepare(var_query rt.PhpVal, var_args rt.PhpVal) string {
	mut var_query_mutated := var_query
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(var_query_mutated.clone().is_null())) {
		return ''
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_query_mutated.clone(), rt.new_string('%')]))) {
		rt.call_function('wp_load_translations_early', []rt.PhpVal{})
		rt.call_function('_doing_it_wrong', [rt.new_string('wpdb::prepare'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The query argument of %s must have a placeholder.')]), rt.new_string('wpdb::prepare()')]), rt.new_string('3.9.0')])
	}
	mut var_allowed_format := rt.new_string('(?:[1-9][0-9]*[$])?[-+0-9]*(?: |0|\'.)?[-+0-9]*(?:\\.[0-9]+)?')
	var_query_mutated = rt.call_function('str_replace', [rt.new_string('\'%s\''), rt.new_string('%s'), var_query_mutated.clone()])
	var_query_mutated = rt.call_function('str_replace', [rt.new_string('"%s"'), rt.new_string('%s'), var_query_mutated.clone()])
	var_query_mutated = rt.call_function('preg_replace', [rt.concat(rt.concat(rt.new_string('/%(?:%|$|(?!('), var_allowed_format), rt.new_string(')?[sdfFi]))/')), rt.new_string('%%\\1'), var_query_mutated.clone()])
	mut var_split_query := rt.call_function('preg_split', [rt.new_string("/(^|[^%]|(?:%%)+)(%(?:${var_allowed_format.to_string()})?[sdfFi])/"), var_query_mutated.clone(), rt.new_int(-1), rt.get_constant('PREG_SPLIT_DELIM_CAPTURE')])
	mut var_split_query_count := rt.new_int(var_split_query.clone().array_count())
	mut var_placeholder_count := rt.div(rt.sub(var_split_query_count, rt.new_int(1)), rt.new_int(3))
	mut var_passed_as_array := rt.new_bool(var_args_mutated.array_isset(rt.new_int(0)) && var_args_mutated.array_get(rt.new_int(0)).is_array() && 1 == var_args_mutated.clone().array_count())
	if rt.is_true(var_passed_as_array) {
	var_args_mutated = var_args_mutated.array_get(rt.new_int(0))
	}
	mut var_new_query := rt.new_string('')
	mut var_key := rt.new_int(2)
	mut var_arg_id := rt.new_int(0)
	mut var_arg_identifiers := rt.new_array()
	mut var_arg_strings := rt.new_array()
	for rt.is_true(rt.less(var_key, var_split_query_count)) {
		mut var_placeholder := var_split_query.array_get(var_key)
		mut var_format := rt.call_function('substr', [var_placeholder.clone(), rt.new_int(1), rt.new_int(-1)])
		mut var_type := rt.call_function('substr', [var_placeholder.clone(), rt.new_int(-1)])
		if rt.is_true(rt.identical(rt.new_string('f'), var_type)) && rt.is_true(rt.identical(rt.new_bool(true), this.allow_unsafe_unquoted_parameters)) && rt.is_true(rt.identical(rt.new_string('%'), rt.call_function('substr', [var_split_query.array_get(rt.sub(var_key, rt.new_int(1))), rt.new_int(-1), rt.new_int(1)]))) {
			mut var_s := rt.new_string((var_split_query.array_get(rt.sub(var_key, rt.new_int(2)))).str() + (var_split_query.array_get(rt.sub(var_key, rt.new_int(1)))).str())
			mut var_k := rt.new_int(1)
			mut var_l := rt.new_int(var_s.clone().to_string().len)
			for rt.is_true(rt.less_equal(var_k, var_l)) && rt.is_true(rt.identical(rt.new_string('%'), var_s.array_get(rt.sub(var_l, var_k)))) {
				rt.pre_inc(var_k)
			}
			var_placeholder = rt.new_string('%' + if rt.is_true(rt.mod_(var_k, rt.new_int(2))) { '%' } else { '' } + (var_format).str() + (var_type).str())
			rt.pre_dec(var_placeholder_count)
		} else {
			if rt.is_true(rt.identical(rt.new_string('f'), var_type)) {
			var_type = rt.new_string('F')
			var_placeholder = rt.new_string('%' + (var_format).str() + (var_type).str())
			}
			if rt.is_true(rt.identical(rt.new_string('i'), var_type)) {
				var_placeholder = rt.new_string('`%' + (var_format).str() + 's`')
				mut var_argnum_pos := rt.call_function('strpos', [var_format.clone(), rt.new_string('$')])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_argnum_pos)))) {
					var_arg_identifiers << rt.new_int((rt.call_function('substr', [var_format.clone(), rt.new_int(0), var_argnum_pos.clone()])).to_i64()) - 1
				} else {
					var_arg_identifiers << var_arg_id.clone()
				}
			} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('d'), var_type)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('F'), var_type)))) {
				var_argnum_pos = rt.call_function('strpos', [var_format.clone(), rt.new_string('$')])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_argnum_pos)))) {
					var_arg_strings << rt.new_int((rt.call_function('substr', [var_format.clone(), rt.new_int(0), var_argnum_pos.clone()])).to_i64()) - 1
				} else {
					var_arg_strings << var_arg_id.clone()
				}
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), this.allow_unsafe_unquoted_parameters)))) || (rt.is_true(rt.identical(rt.new_string(''), var_format)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('%'), rt.call_function('substr', [var_split_query.array_get(rt.sub(var_key, rt.new_int(1))), rt.new_int(-1), rt.new_int(1)])))))) {
				var_placeholder = rt.new_string('\'%' + (var_format).str() + 's\'')
				}
			}
		}
		var_new_query = rt.concat(var_new_query, rt.new_string((var_split_query.array_get(rt.sub(var_key, rt.new_int(2)))).str() + (var_split_query.array_get(rt.sub(var_key, rt.new_int(1)))).str() + (var_placeholder).str()))
		var_key = rt.add(var_key, rt.new_int(3))
		rt.pre_inc(var_arg_id)
	}
	var_query_mutated = rt.new_string((var_new_query).str() + (var_split_query.array_get(rt.sub(var_key, rt.new_int(2)))).str())
	mut var_dual_use := rt.call_function('array_intersect', [rt.create_array_from_list(var_arg_identifiers), rt.create_array_from_list(var_arg_strings)])
	if var_dual_use.clone().array_count() > 0 {
		rt.call_function('wp_load_translations_early', []rt.PhpVal{})
		mut var_used_placeholders := rt.new_array()
		var_key = rt.new_int(2)
		var_arg_id = rt.new_int(0)
		for rt.is_true(rt.less(var_key, var_split_query_count)) {
			var_placeholder = var_split_query.array_get(var_key)
			var_format = rt.call_function('substr', [var_placeholder.clone(), rt.new_int(1), rt.new_int(-1)])
			var_argnum_pos = rt.call_function('strpos', [var_format.clone(), rt.new_string('$')])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_argnum_pos)))) {
			mut var_arg_pos := rt.new_int((rt.call_function('substr', [var_format.clone(), rt.new_int(0), var_argnum_pos.clone()])).to_i64()) - 1
			} else {
			var_arg_pos = var_arg_id.clone()
			}
			var_used_placeholders.array_get_mut(var_arg_pos).array_push(var_placeholder.clone())
			var_key = rt.add(var_key, rt.new_int(3))
			rt.pre_inc(var_arg_id)
		}
		mut var_conflicts := rt.new_array()
		mut iter_10 := var_dual_use.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_arg_pos_shadow := item_10.val
			var_conflicts << rt.call_function('implode', [rt.new_string(' and '), var_used_placeholders.array_get(var_arg_pos_shadow)])
		}
		rt.call_function('_doing_it_wrong', [rt.new_string('wpdb::prepare'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Arguments cannot be prepared as both an Identifier and Value. Found the following conflicts: %s')]), rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_conflicts)])]), rt.new_string('6.2.0')])
		return ''
	}
	mut var_args_count := rt.new_int(var_args_mutated.clone().array_count())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_args_count, var_placeholder_count)))) {
		if rt.is_true(rt.identical(rt.new_int(1), var_placeholder_count)) && rt.is_true(var_passed_as_array) {
			rt.call_function('wp_load_translations_early', []rt.PhpVal{})
			rt.call_function('_doing_it_wrong', [rt.new_string('wpdb::prepare'), rt.call_function('__', [rt.new_string('The query only expected one placeholder, but an array of multiple placeholders was sent.')]), rt.new_string('4.9.0')])
			return ''
		} else {
			rt.call_function('wp_load_translations_early', []rt.PhpVal{})
			rt.call_function('_doing_it_wrong', [rt.new_string('wpdb::prepare'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The query does not contain the correct number of placeholders (%1$d) for the number of arguments passed (%2$d).')]), var_placeholder_count.clone(), var_args_count.clone()]), rt.new_string('4.8.3')])
			if rt.is_true(rt.less(var_args_count, var_placeholder_count)) {
				mut var_max_numbered_placeholder := rt.new_int(0)
				mut var_i := rt.new_int(2)
				var_l = var_split_query_count.clone()
				for {
					if !(rt.is_true(rt.less(var_i, var_l))) { break }
					mut var_argnum := rt.new_int((rt.call_function('substr', [var_split_query.array_get(var_i), rt.new_int(1)])).to_i64())
					if rt.is_true(rt.less(var_max_numbered_placeholder, var_argnum)) {
					var_max_numbered_placeholder = var_argnum.clone()
					}
					var_i = rt.add(var_i, rt.new_int(3))
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(var_max_numbered_placeholder)))) || rt.is_true(rt.less(var_args_count, var_max_numbered_placeholder)) {
					return ''
				}
			}
		}
	}
	mut var_args_escaped := rt.new_array()
	mut iter_11 := var_args_mutated.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_value := item_11.val
		mut var_i := item_11.key
		if rt.is_true(rt.call_function('in_array', [var_i.clone(), rt.create_array_from_list(var_arg_identifiers), rt.new_bool(true)])) {
			var_args_escaped << this._escape_identifier_value(var_value.clone())
		} else if var_value.clone().is_long() || var_value.clone().is_double() {
			var_args_escaped << var_value.clone()
		} else {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_value.clone()]))))) && !(var_value.clone().is_null()) {
				rt.call_function('wp_load_translations_early', []rt.PhpVal{})
				rt.call_function('_doing_it_wrong', [rt.new_string('wpdb::prepare'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unsupported value type (%s).')]), rt.call_function('gettype', [var_value.clone()])]), rt.new_string('4.8.2')])
			var_value = rt.new_string('')
			}
			var_args_escaped << this._real_escape(var_value.clone())
		}
	}
	mut var_query_mutated := rt.call_function('vsprintf', [var_query_mutated.clone(), rt.create_array_from_list(var_args_escaped)])
	return (this.add_placeholder_escape(var_query_mutated.clone())).str()
}

fn (mut this Class_wpdb) esc_like(var_text rt.PhpVal) rt.PhpVal {
	return rt.call_function('addcslashes', [var_text.clone(), rt.new_string('_%\\')])
}

fn (mut this Class_wpdb) print_error(str string) bool {
	mut var_EZSQL_ERROR := []rt.PhpVal{}
	mut str_mutated := str
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(str_mutated))))) {
	str_mutated = (rt.call_function('mysqli_error', [this.dbh])).str()
	}
	var_EZSQL_ERROR << rt.create_array([rt.ArrayItem{ key: 'query', val: this.last_query }, rt.ArrayItem{ key: 'error_str', val: str_mutated }])
	if rt.is_true(this.suppress_errors) {
		return false
	}
	mut var_caller := this.get_caller()
	if rt.is_true(var_caller) {
	mut var_error_str := rt.call_function('sprintf', [rt.new_string('WordPress database error %1$s for query %2$s made by %3$s'), rt.new_string(str_mutated).clone(), this.last_query, var_caller.clone()])
	} else {
	var_error_str = rt.call_function('sprintf', [rt.new_string('WordPress database error %1$s for query %2$s'), rt.new_string(str_mutated).clone(), this.last_query])
	}
	rt.call_function('error_log', [var_error_str.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.show_errors)))) {
		return false
	}
	rt.call_function('wp_load_translations_early', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut var_msg := rt.call_function('sprintf', [rt.new_string('%s [%s]\n%s\n'), rt.call_function('__', [rt.new_string('WordPress database error:')]), rt.new_string(str_mutated).clone(), this.last_query])
		if rt.is_true(rt.call_function('defined', [rt.new_string('ERRORLOGFILE')])) {
			rt.call_function('error_log', [var_msg.clone(), rt.new_int(3), rt.get_constant('ERRORLOGFILE')])
		}
		if rt.is_true(rt.call_function('defined', [rt.new_string('DIEONDBERROR')])) {
			rt.call_function('wp_die', [var_msg.clone()])
		}
	} else {
		str_mutated = (rt.call_function('htmlspecialchars', [rt.new_string(str_mutated).clone(), rt.get_constant('ENT_QUOTES')])).str()
		mut var_query := rt.call_function('htmlspecialchars', [this.last_query, rt.get_constant('ENT_QUOTES')])
		rt.call_function('printf', [rt.new_string('<div id="error"><p class="wpdberror"><strong>%s</strong> [%s]<br /><code>%s</code></p></div>'), rt.call_function('__', [rt.new_string('WordPress database error:')]), rt.new_string(str_mutated).clone(), var_query.clone()])
	}
	return false
}

fn (mut this Class_wpdb) show_errors(show bool) rt.PhpVal {
	mut show_mutated := show
	mut var_errors := this.show_errors
	this.show_errors = rt.new_bool(show_mutated).clone()
	return var_errors.clone()
}

fn (mut this Class_wpdb) hide_errors() rt.PhpVal {
	mut var_show := this.show_errors
	this.show_errors = rt.new_bool(false)
	return var_show.clone()
}

fn (mut this Class_wpdb) suppress_errors(suppress bool) rt.PhpVal {
	mut var_errors := this.suppress_errors
	this.suppress_errors = suppress
	return var_errors.clone()
}

fn (mut this Class_wpdb) flush() {
	this.last_result = rt.new_array()
	this.col_info = rt.new_null()
	this.last_query = rt.new_null()
	this.rows_affected = rt.new_int(0)
	this.num_rows = rt.new_int(0)
	this.last_error = rt.new_string('')
	if rt.is_true(rt.new_bool(rt.instance_of(this.result, 'mysqli_result'))) {
		rt.call_function('mysqli_free_result', [this.result])
		this.result = rt.new_null()
		if !rt.is_true(this.dbh) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.dbh, 'mysqli')))))) {
			return
		}
		for rt.is_true(rt.call_function('mysqli_more_results', [this.dbh])) {
			rt.call_function('mysqli_next_result', [this.dbh])
		}
	}
}

fn (mut this Class_wpdb) db_connect(allow_bail bool) bool {
	this.is_mysql = true
	mut var_client_flags := if rt.is_true(rt.call_function('defined', [rt.new_string('MYSQL_CLIENT_FLAGS')])) { rt.get_constant('MYSQL_CLIENT_FLAGS') } else { rt.new_int(0) }
	rt.call_function('mysqli_report', [rt.get_constant('MYSQLI_REPORT_OFF')])
	this.dbh = rt.call_function('mysqli_init', []rt.PhpVal{})
	mut var_host := this.dbhost
	mut var_port := rt.new_null()
	mut var_socket := rt.new_null()
	mut var_is_ipv6 := rt.new_bool(false)
	mut var_host_data := this.parse_db_host(this.dbhost)
	if rt.is_true(var_host_data) {
		mut list_tmp_1 := var_host_data
		var_host = (list_tmp_1).array_get(0)
		var_port = (list_tmp_1).array_get(1)
		var_socket = (list_tmp_1).array_get(2)
		var_is_ipv6 = (list_tmp_1).array_get(3)
	}
	if rt.is_true(var_is_ipv6) && rt.is_true(rt.call_function('extension_loaded', [rt.new_string('mysqlnd')])) {
	var_host = rt.new_string("[${var_host.to_string()}]")
	}
	if rt.is_true(rt.get_constant('WP_DEBUG')) {
		rt.call_function('mysqli_real_connect', [this.dbh, var_host.clone(), this.dbuser, this.dbpassword, rt.new_null(), var_port.clone(), var_socket.clone(), var_client_flags.clone()])
	} else {
		rt.call_function('mysqli_real_connect', [this.dbh, var_host.clone(), this.dbuser, this.dbpassword, rt.new_null(), var_port.clone(), var_socket.clone(), var_client_flags.clone()])
	}
	if rt.is_true(rt.get_property(this.dbh, 'connect_errno')) {
		this.dbh = rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.dbh)))) && var_allow_bail {
		rt.call_function('wp_load_translations_early', []rt.PhpVal{})
		if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/db-error.php')])) {
			rt.include_file((rt.get_constant('WP_CONTENT_DIR')).str() + '/db-error.php', '4')
			exit(0)
		}
		mut var_message := rt.new_string('<h1>' + (rt.call_function('__', [rt.new_string('Error establishing a database connection')])).str() + '</h1>\n')
		var_message = rt.concat(var_message, rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This either means that the username and password information in your %1$s file is incorrect or that contact with the database server at %2$s could not be established. This could mean your host&#8217;s database server is down.')]), rt.new_string('<code>wp-config.php</code>'), rt.new_string('<code>' + (rt.call_function('htmlspecialchars', [this.dbhost, rt.get_constant('ENT_QUOTES')])).str() + '</code>')])).str() + '</p>\n'))
		var_message = rt.concat(var_message, rt.new_string('<ul>\n'))
		var_message = rt.concat(var_message, rt.new_string('<li>' + (rt.call_function('__', [rt.new_string('Are you sure you have the correct username and password?')])).str() + '</li>\n'))
		var_message = rt.concat(var_message, rt.new_string('<li>' + (rt.call_function('__', [rt.new_string('Are you sure you have typed the correct hostname?')])).str() + '</li>\n'))
		var_message = rt.concat(var_message, rt.new_string('<li>' + (rt.call_function('__', [rt.new_string('Are you sure the database server is running?')])).str() + '</li>\n'))
		var_message = rt.concat(var_message, rt.new_string('</ul>\n'))
		var_message = rt.concat(var_message, rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you are unsure what these terms mean you should probably contact your host. If you still need help you can always visit the <a href="%s">WordPress support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])])).str() + '</p>\n'))
		this.bail(var_message.clone(), 'db_connect_fail')
		return false
	} else if rt.is_true(this.dbh) {
		if !(this.has_connected) {
			this.init_charset()
		}
		this.has_connected = true
		this.set_charset(this.dbh, rt.new_null(), rt.new_null())
		this.ready = true
		this.set_sql_mode(rt.new_null())
		this.select(this.dbname, this.dbh)
		return true
	}
	return false
}

fn (mut this Class_wpdb) parse_db_host(var_host rt.PhpVal) rt.PhpVal {
	mut var_host_mutated := var_host
	mut var_socket := rt.new_null()
	mut var_is_ipv6 := rt.new_bool(false)
	mut var_socket_pos := rt.call_function('strpos', [var_host_mutated.clone(), rt.new_string(':/')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_socket_pos)))) {
	var_socket = rt.call_function('substr', [var_host_mutated.clone(), rt.add(var_socket_pos, rt.new_int(1))])
	var_host_mutated = rt.call_function('substr', [var_host_mutated.clone(), rt.new_int(0), var_socket_pos.clone()])
	}
	if rt.is_true(rt.greater(rt.call_function('substr_count', [var_host_mutated.clone(), rt.new_string(':')]), rt.new_int(1))) {
	mut var_pattern := rt.new_string('#^(?:\\[)?(?P<host>[0-9a-fA-F:]+)(?:\\]:(?P<port>[\\d]+))?#')
	var_is_ipv6 = rt.new_bool(true)
	} else {
	var_pattern = rt.new_string('#^(?P<host>[^:/]*)(?::(?P<port>[\\d]+))?#')
	}
	mut var_matches := rt.new_array()
	mut var_result := rt.call_function('preg_match', [var_pattern.clone(), var_host_mutated.clone(), var_matches.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), var_result)))) {
		return rt.new_bool(false)
	}
	var_host_mutated = if !(!rt.is_true(var_matches.array_get(rt.new_string('host')))) { var_matches.array_get(rt.new_string('host')) } else { rt.new_string('') }
	mut var_port := if !(!rt.is_true(var_matches.array_get(rt.new_string('port')))) { rt.call_function('absint', [var_matches.array_get(rt.new_string('port'))]) } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: none, val: var_host_mutated }, rt.ArrayItem{ key: none, val: var_port }, rt.ArrayItem{ key: none, val: var_socket }, rt.ArrayItem{ key: none, val: var_is_ipv6 }])
}

fn (mut this Class_wpdb) check_connection(allow_bail bool) bool {
	if !(!rt.is_true(this.dbh)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('mysqli_query', [this.dbh, rt.new_string('DO 1')]), rt.new_bool(false))))) {
		return true
	}
	mut var_error_reporting := rt.new_bool(false)
	if rt.is_true(rt.get_constant('WP_DEBUG')) {
		var_error_reporting = rt.call_function('error_reporting', []rt.PhpVal{})
		rt.call_function('error_reporting', [rt.bitwise_and(var_error_reporting, rt.bitwise_not(rt.get_constant('E_WARNING')))])
	}
	mut var_tries := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less_equal(var_tries, this.reconnect_retries))) { break }
		if rt.is_true(rt.identical(this.reconnect_retries, var_tries)) && rt.is_true(rt.get_constant('WP_DEBUG')) {
			rt.call_function('error_reporting', [var_error_reporting.clone()])
		}
		if this.db_connect(false) {
			if rt.is_true(var_error_reporting) {
				rt.call_function('error_reporting', [var_error_reporting.clone()])
			}
			return true
		}
		rt.call_function('sleep', [rt.new_int(1)])
		rt.post_inc(var_tries)
	}
	if rt.is_true(rt.call_function('did_action', [rt.new_string('template_redirect')])) {
		return false
	}
	if !(var_allow_bail) {
		return false
	}
	rt.call_function('wp_load_translations_early', []rt.PhpVal{})
	mut var_message := rt.new_string('<h1>' + (rt.call_function('__', [rt.new_string('Error reconnecting to the database')])).str() + '</h1>\n')
	var_message = rt.concat(var_message, rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This means that the contact with the database server at %s was lost. This could mean your host&#8217;s database server is down.')]), rt.new_string('<code>' + (rt.call_function('htmlspecialchars', [this.dbhost, rt.get_constant('ENT_QUOTES')])).str() + '</code>')])).str() + '</p>\n'))
	var_message = rt.concat(var_message, rt.new_string('<ul>\n'))
	var_message = rt.concat(var_message, rt.new_string('<li>' + (rt.call_function('__', [rt.new_string('Are you sure the database server is running?')])).str() + '</li>\n'))
	var_message = rt.concat(var_message, rt.new_string('<li>' + (rt.call_function('__', [rt.new_string('Are you sure the database server is not under particularly heavy load?')])).str() + '</li>\n'))
	var_message = rt.concat(var_message, rt.new_string('</ul>\n'))
	var_message = rt.concat(var_message, rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you are unsure what these terms mean you should probably contact your host. If you still need help you can always visit the <a href="%s">WordPress support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])])).str() + '</p>\n'))
	this.bail(var_message.clone(), 'db_connect_fail')
	rt.call_function('dead_db', []rt.PhpVal{})
	return false
}

fn (mut this Class_wpdb) query(var_query rt.PhpVal) bool {
	mut var_query_mutated := var_query
	if !(this.ready) {
		this.check_current_query = true
		return false
	}
	var_query_mutated = rt.call_function('apply_filters', [rt.new_string('query'), var_query_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_query_mutated)))) {
		this.insert_id = rt.new_int(0)
		return false
	}
	this.flush()
	this.func_call = rt.concat(rt.concat(rt.new_string('$db->query("'), var_query_mutated), rt.new_string('")'))
	if this.check_current_query && !(this.check_ascii(var_query_mutated.clone())) {
		mut var_stripped_query := this.strip_invalid_text_from_query(var_query_mutated.clone())
		this.flush()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_stripped_query, var_query_mutated)))) {
			this.insert_id = rt.new_int(0)
			this.last_query = var_query_mutated.clone()
			rt.call_function('wp_load_translations_early', []rt.PhpVal{})
			this.last_error = rt.call_function('__', [rt.new_string('WordPress database error: Could not perform query because it contains invalid data.')])
			return false
		}
	}
	this.check_current_query = true
	this.last_query = var_query_mutated.clone()
	this._do_query(var_query_mutated.clone())
	mut var_mysql_errno := rt.new_int(0)
	if rt.is_true(rt.new_bool(rt.instance_of(this.dbh, 'mysqli'))) {
	var_mysql_errno = rt.call_function('mysqli_errno', [this.dbh])
	} else {
	var_mysql_errno = rt.new_int(2006)
	}
	if !rt.is_true(this.dbh) || rt.is_true(rt.identical(rt.new_int(2006), var_mysql_errno)) {
		if this.check_connection(false) {
			this._do_query(var_query_mutated.clone())
		} else {
			this.insert_id = rt.new_int(0)
			return false
		}
	}
	if rt.is_true(rt.new_bool(rt.instance_of(this.dbh, 'mysqli'))) {
		this.last_error = rt.call_function('mysqli_error', [this.dbh])
	} else {
		this.last_error = rt.call_function('__', [rt.new_string('Unable to retrieve the error message from the database server')])
	}
	if rt.is_true(this.last_error) {
		if rt.is_true(this.insert_id) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*(insert|replace)\\s/i'), var_query_mutated.clone()])) {
			this.insert_id = rt.new_int(0)
		}
		this.print_error('')
		return false
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*(create|alter|truncate|drop)\\s/i'), var_query_mutated.clone()])) {
	mut var_return_val := this.result
	} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*(insert|delete|update|replace)\\s/i'), var_query_mutated.clone()])) {
		this.rows_affected = rt.call_function('mysqli_affected_rows', [this.dbh])
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*(insert|replace)\\s/i'), var_query_mutated.clone()])) {
			this.insert_id = rt.call_function('mysqli_insert_id', [this.dbh])
		}
	var_return_val = this.rows_affected
	} else {
		mut var_num_rows := rt.new_int(0)
		if rt.is_true(rt.new_bool(rt.instance_of(this.result, 'mysqli_result'))) {
			mut var_row := rt.call_function('mysqli_fetch_object', [this.result])
			for rt.is_true(var_row) {
				this.last_result.array_set(var_num_rows, var_row.clone())
				rt.pre_inc(var_num_rows)
			}
		}
		this.num_rows = var_num_rows.clone()
	var_return_val = var_num_rows.clone()
	}
	return (var_return_val).to_bool()
}

fn (mut this Class_wpdb) _do_query(var_query rt.PhpVal) {
	mut var_query_mutated := var_query
	if rt.is_true(rt.call_function('defined', [rt.new_string('SAVEQUERIES')])) && rt.is_true(rt.get_constant('SAVEQUERIES')) {
		this.timer_start()
	}
	if !(!rt.is_true(this.dbh)) {
		this.result = rt.call_function('mysqli_query', [this.dbh, var_query_mutated.clone()])
	}
	rt.pre_inc(this.num_queries)
	if rt.is_true(rt.call_function('defined', [rt.new_string('SAVEQUERIES')])) && rt.is_true(rt.get_constant('SAVEQUERIES')) {
		this.log_query(var_query_mutated.clone(), this.timer_stop(), this.get_caller(), this.time_start, rt.new_array())
	}
}

fn (mut this Class_wpdb) log_query(var_query rt.PhpVal, var_query_time rt.PhpVal, var_query_callstack rt.PhpVal, var_query_start rt.PhpVal, var_query_data rt.PhpVal) {
	mut var_query_mutated := var_query
	mut var_query_data_mutated := var_query_data
	var_query_data_mutated = rt.call_function('apply_filters', [rt.new_string('log_query_custom_data'), var_query_data_mutated.clone(), var_query_mutated.clone(), var_query_time.clone(), var_query_callstack.clone(), var_query_start.clone()])
	this.queries.array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_query_mutated }, rt.ArrayItem{ key: none, val: var_query_time }, rt.ArrayItem{ key: none, val: var_query_callstack }, rt.ArrayItem{ key: none, val: var_query_start }, rt.ArrayItem{ key: none, val: var_query_data_mutated }]))
}

fn (mut this Class_wpdb) placeholder_escape() rt.PhpVal {
	mut var_placeholder := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_placeholder)))) {
	mut var_salt := if rt.is_true(rt.call_function('defined', [rt.new_string('AUTH_SALT')])) && rt.is_true(rt.get_constant('AUTH_SALT')) { rt.get_constant('AUTH_SALT') } else { (rt.call_function('rand', []rt.PhpVal{})).str() }
	var_placeholder = rt.new_string('{' + (rt.call_function('hash_hmac', [rt.new_string('sha256'), rt.call_function('uniqid', [var_salt.clone(), rt.new_bool(true)]), var_salt.clone()])).str() + '}')
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('has_filter', [rt.new_string('query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('wpdb', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'remove_placeholder_escape' }])]))) {
		rt.call_function('add_filter', [rt.new_string('query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('wpdb', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'remove_placeholder_escape' }]), rt.new_int(0)])
	}
	return var_placeholder.clone()
}

fn (mut this Class_wpdb) add_placeholder_escape(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	return rt.call_function('str_replace', [rt.new_string('%'), this.placeholder_escape(), var_query_mutated.clone()])
}

fn (mut this Class_wpdb) remove_placeholder_escape(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	return rt.call_function('str_replace', [this.placeholder_escape(), rt.new_string('%'), var_query_mutated.clone()])
}

fn (mut this Class_wpdb) insert(var_table rt.PhpVal, var_data rt.PhpVal, var_format rt.PhpVal) rt.PhpVal {
	mut var_table_mutated := var_table
	mut var_data_mutated := var_data
	mut var_format_mutated := var_format
	return rt.new_bool(this._insert_replace_helper(var_table_mutated.clone(), var_data_mutated.clone(), var_format_mutated.clone(), 'INSERT'))
}

fn (mut this Class_wpdb) replace(var_table rt.PhpVal, var_data rt.PhpVal, var_format rt.PhpVal) rt.PhpVal {
	mut var_table_mutated := var_table
	mut var_data_mutated := var_data
	mut var_format_mutated := var_format
	return rt.new_bool(this._insert_replace_helper(var_table_mutated.clone(), var_data_mutated.clone(), var_format_mutated.clone(), 'REPLACE'))
}

fn (mut this Class_wpdb) _insert_replace_helper(var_table rt.PhpVal, var_data rt.PhpVal, var_format rt.PhpVal, type string) bool {
	mut var_table_mutated := var_table
	mut var_data_mutated := var_data
	mut var_format_mutated := var_format
	mut type_mutated := type
	this.insert_id = rt.new_int(0)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(type_mutated.to_upper()), rt.create_array([rt.ArrayItem{ key: none, val: 'REPLACE' }, rt.ArrayItem{ key: none, val: 'INSERT' }]), rt.new_bool(true)]))))) {
		return false
	}
	var_data_mutated = rt.new_bool(this.process_fields(var_table_mutated.clone(), var_data_mutated.clone(), var_format_mutated.clone()))
	if rt.is_true(rt.identical(rt.new_bool(false), var_data_mutated)) {
		return false
	}
	mut var_formats := rt.new_array()
	mut var_values := rt.new_array()
	mut iter_12 := var_data_mutated.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_value := item_12.val
		if rt.is_true(rt.new_bool(var_value.array_get(rt.new_string('value')).is_null())) {
			var_formats.array_push('NULL')
			continue
		}
		var_formats.array_push(var_value.array_get(rt.new_string('format')))
		var_values.array_push(var_value.array_get(rt.new_string('value')))
	}
	mut var_fields := rt.new_string('`' + (rt.call_function('implode', [rt.new_string('`, `'), rt.func_array_keys(var_data_mutated.clone())])).str() + '`')
	var_formats = rt.call_function('implode', [rt.new_string(', '), var_formats.clone()])
	mut var_sql := rt.new_string("${var_type.to_string()} INTO `${var_table.to_string()}` (${var_fields.to_string()}) VALUES (${var_formats.to_string()})")
	this.check_current_query = false
	return this.query(rt.new_string(this.prepare(var_sql.clone(), var_values.clone())))
}

fn (mut this Class_wpdb) update(var_table rt.PhpVal, var_data rt.PhpVal, var_where rt.PhpVal, var_format rt.PhpVal, var_where_format rt.PhpVal) bool {
	mut var_table_mutated := var_table
	mut var_data_mutated := var_data
	mut var_where_mutated := var_where
	mut var_format_mutated := var_format
	if !(var_data_mutated.clone().is_array()) || !(var_where_mutated.clone().is_array()) {
		return false
	}
	var_data_mutated = rt.new_bool(this.process_fields(var_table_mutated.clone(), var_data_mutated.clone(), var_format_mutated.clone()))
	if rt.is_true(rt.identical(rt.new_bool(false), var_data_mutated)) {
		return false
	}
	var_where_mutated = rt.new_bool(this.process_fields(var_table_mutated.clone(), var_where_mutated.clone(), var_where_format.clone()))
	if rt.is_true(rt.identical(rt.new_bool(false), var_where_mutated)) {
		return false
	}
	mut var_fields := rt.new_array()
	mut var_conditions := rt.new_array()
	mut var_values := rt.new_array()
	mut iter_13 := var_data_mutated.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_value := item_13.val
		mut var_field := item_13.key
		if rt.is_true(rt.new_bool(var_value.array_get(rt.new_string('value')).is_null())) {
			var_fields.array_push("`${var_field.to_string()}` = NULL")
			continue
		}
		var_fields.array_push("`${var_field.to_string()}` = " + (var_value.array_get(rt.new_string('format'))).str())
		var_values.array_push(var_value.array_get(rt.new_string('value')))
	}
	mut iter_14 := var_where_mutated.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_value := item_14.val
		mut var_field := item_14.key
		if rt.is_true(rt.new_bool(var_value.array_get(rt.new_string('value')).is_null())) {
			var_conditions.array_push("`${var_field.to_string()}` IS NULL")
			continue
		}
		var_conditions.array_push("`${var_field.to_string()}` = " + (var_value.array_get(rt.new_string('format'))).str())
		var_values.array_push(var_value.array_get(rt.new_string('value')))
	}
	var_fields = rt.call_function('implode', [rt.new_string(', '), var_fields.clone()])
	var_conditions = rt.call_function('implode', [rt.new_string(' AND '), var_conditions.clone()])
	mut var_sql := rt.new_string("UPDATE `${var_table.to_string()}` SET ${var_fields.to_string()} WHERE ${var_conditions.to_string()}")
	this.check_current_query = false
	return this.query(rt.new_string(this.prepare(var_sql.clone(), var_values.clone())))
}

fn (mut this Class_wpdb) delete(var_table rt.PhpVal, var_where rt.PhpVal, var_where_format rt.PhpVal) bool {
	mut var_table_mutated := var_table
	mut var_where_mutated := var_where
	if !(var_where_mutated.clone().is_array()) {
		return false
	}
	var_where_mutated = rt.new_bool(this.process_fields(var_table_mutated.clone(), var_where_mutated.clone(), var_where_format.clone()))
	if rt.is_true(rt.identical(rt.new_bool(false), var_where_mutated)) {
		return false
	}
	mut var_conditions := rt.new_array()
	mut var_values := rt.new_array()
	mut iter_15 := var_where_mutated.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_value := item_15.val
		mut var_field := item_15.key
		if rt.is_true(rt.new_bool(var_value.array_get(rt.new_string('value')).is_null())) {
			var_conditions.array_push("`${var_field.to_string()}` IS NULL")
			continue
		}
		var_conditions.array_push("`${var_field.to_string()}` = " + (var_value.array_get(rt.new_string('format'))).str())
		var_values.array_push(var_value.array_get(rt.new_string('value')))
	}
	var_conditions = rt.call_function('implode', [rt.new_string(' AND '), var_conditions.clone()])
	mut var_sql := rt.new_string("DELETE FROM `${var_table.to_string()}` WHERE ${var_conditions.to_string()}")
	this.check_current_query = false
	return this.query(rt.new_string(this.prepare(var_sql.clone(), var_values.clone())))
}

fn (mut this Class_wpdb) process_fields(var_table rt.PhpVal, var_data rt.PhpVal, var_format rt.PhpVal) bool {
	mut var_table_mutated := var_table
	mut var_data_mutated := var_data
	mut var_format_mutated := var_format
	var_data_mutated = this.process_field_formats(var_data_mutated.clone(), var_format_mutated.clone())
	if rt.is_true(rt.identical(rt.new_bool(false), var_data_mutated)) {
		return false
	}
	var_data_mutated = rt.new_bool(this.process_field_charsets(var_data_mutated.clone(), var_table_mutated.clone()))
	if rt.is_true(rt.identical(rt.new_bool(false), var_data_mutated)) {
		return false
	}
	var_data_mutated = rt.new_bool(this.process_field_lengths(var_data_mutated.clone(), var_table_mutated.clone()))
	if rt.is_true(rt.identical(rt.new_bool(false), var_data_mutated)) {
		return false
	}
	mut var_converted_data := this.strip_invalid_text(var_data_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_data_mutated, var_converted_data)))) {
		mut var_problem_fields := rt.new_array()
		mut iter_16 := var_data_mutated.iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_value := item_16.val
			mut var_field := item_16.key
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_value, var_converted_data.array_get(var_field))))) {
				var_problem_fields << var_field.clone()
			}
		}
		rt.call_function('wp_load_translations_early', []rt.PhpVal{})
		if 1 == var_problem_fields.len {
			this.last_error = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('WordPress database error: Processing the value for the following field failed: %s. The supplied value may be too long or contains invalid data.')]), rt.call_function('reset', [rt.create_array_from_list(var_problem_fields)])])
		} else {
			this.last_error = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('WordPress database error: Processing the values for the following fields failed: %s. The supplied values may be too long or contain invalid data.')]), rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_problem_fields)])])
		}
		return false
	}
	return (var_data_mutated).to_bool()
}

fn (mut this Class_wpdb) process_field_formats(var_data rt.PhpVal, var_format rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_format_mutated := var_format
	mut var_formats := rt.cast_array(var_format_mutated)
	mut var_original_formats := var_formats.clone()
	mut iter_17 := var_data_mutated.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_value := item_17.val
		mut var_field := item_17.key
		var_value = rt.create_array([rt.ArrayItem{ key: 'value', val: var_value }, rt.ArrayItem{ key: 'format', val: '%s' }])
		if !(!rt.is_true(var_format_mutated)) {
			var_value.array_set('format', rt.call_function('array_shift', [var_formats.clone()]))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_value.array_get(rt.new_string('format')))))) {
				var_value.array_set('format', rt.call_function('reset', [var_original_formats.clone()]))
			}
		} else if this.field_types.array_isset(var_field) {
			var_value.array_set('format', this.field_types.array_get(var_field))
		}
		var_data_mutated.array_set(var_field, var_value.clone())
	}
	return var_data_mutated.clone()
}

fn (mut this Class_wpdb) process_field_charsets(var_data rt.PhpVal, var_table rt.PhpVal) bool {
	mut var_data_mutated := var_data
	mut var_table_mutated := var_table
	mut iter_18 := var_data_mutated.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_value := item_18.val
		mut var_field := item_18.key
		if rt.is_true(rt.identical(rt.new_string('%d'), var_value.array_get(rt.new_string('format')))) || rt.is_true(rt.identical(rt.new_string('%f'), var_value.array_get(rt.new_string('format')))) {
			var_value.array_set('charset', false)
		} else {
			var_value.array_set('charset', this.get_col_charset(var_table_mutated.clone(), var_field.clone()))
			if rt.is_true(rt.call_function('is_wp_error', [var_value.array_get(rt.new_string('charset'))])) {
				return false
			}
		}
		var_data_mutated.array_set(var_field, var_value.clone())
	}
	return (var_data_mutated).to_bool()
}

fn (mut this Class_wpdb) process_field_lengths(var_data rt.PhpVal, var_table rt.PhpVal) bool {
	mut var_data_mutated := var_data
	mut var_table_mutated := var_table
	mut iter_19 := var_data_mutated.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_value := item_19.val
		mut var_field := item_19.key
		if rt.is_true(rt.identical(rt.new_string('%d'), var_value.array_get(rt.new_string('format')))) || rt.is_true(rt.identical(rt.new_string('%f'), var_value.array_get(rt.new_string('format')))) {
			var_value.array_set('length', false)
		} else {
			var_value.array_set('length', this.get_col_length(var_table_mutated.clone(), var_field.clone()))
			if rt.is_true(rt.call_function('is_wp_error', [var_value.array_get(rt.new_string('length'))])) {
				return false
			}
		}
		var_data_mutated.array_set(var_field, var_value.clone())
	}
	return (var_data_mutated).to_bool()
}

fn (mut this Class_wpdb) get_var(var_query rt.PhpVal, x i64, y i64) rt.PhpVal {
	mut var_query_mutated := var_query
	this.func_call = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('$db->get_var("'), var_query_mutated), rt.new_string('", ')), rt.new_int(x)), rt.new_string(', ')), rt.new_int(y)), rt.new_string(')'))
	if rt.is_true(var_query_mutated) {
		if this.check_current_query && this.check_safe_collation(var_query_mutated.clone()) {
			this.check_current_query = false
		}
		this.query(var_query_mutated.clone())
	}
	if !(!rt.is_true(this.last_result.array_get(rt.new_int(y)))) {
	mut var_values := rt.call_function('array_values', [rt.call_function('get_object_vars', [this.last_result.array_get(rt.new_int(y))])])
	}
	return if var_values.array_isset(rt.new_int(x)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_values.array_get(rt.new_int(x)))))) { var_values.array_get(rt.new_int(x)) } else { rt.new_null() }
}

fn (mut this Class_wpdb) get_row(var_query rt.PhpVal, var_output rt.PhpVal, y i64) rt.PhpVal {
	mut var_query_mutated := var_query
	this.func_call = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('$db->get_row("'), var_query_mutated), rt.new_string('",')), var_output), rt.new_string(',')), rt.new_int(y)), rt.new_string(')'))
	if rt.is_true(var_query_mutated) {
		if this.check_current_query && this.check_safe_collation(var_query_mutated.clone()) {
			this.check_current_query = false
		}
		this.query(var_query_mutated.clone())
	} else {
		return rt.new_null()
	}
	if !(this.last_result.array_isset(rt.new_int(y))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string(global_const_object), var_output)) {
		return if rt.is_true(this.last_result.array_get(rt.new_int(y))) { this.last_result.array_get(rt.new_int(y)) } else { rt.new_null() }
	} else if rt.is_true(rt.identical(rt.new_string(global_const_array_a), var_output)) {
		return if rt.is_true(this.last_result.array_get(rt.new_int(y))) { rt.call_function('get_object_vars', [this.last_result.array_get(rt.new_int(y))]) } else { rt.new_null() }
	} else if rt.is_true(rt.identical(rt.new_string(global_const_array_n), var_output)) {
		return if rt.is_true(this.last_result.array_get(rt.new_int(y))) { rt.call_function('array_values', [rt.call_function('get_object_vars', [this.last_result.array_get(rt.new_int(y))])]) } else { rt.new_null() }
	} else if rt.is_true(rt.identical(rt.new_string(global_const_object), rt.new_string(var_output.clone().to_string().to_upper()))) {
		return if rt.is_true(this.last_result.array_get(rt.new_int(y))) { this.last_result.array_get(rt.new_int(y)) } else { rt.new_null() }
	} else {
		this.print_error(' $db->get_row(string query, output type, int offset) -- Output type must be one of: OBJECT, ARRAY_A, ARRAY_N')
	}
	return rt.new_null()
}

fn (mut this Class_wpdb) get_col(var_query rt.PhpVal, x i64) rt.PhpVal {
	mut var_query_mutated := var_query
	if rt.is_true(var_query_mutated) {
		if this.check_current_query && this.check_safe_collation(var_query_mutated.clone()) {
			this.check_current_query = false
		}
		this.query(var_query_mutated.clone())
	}
	mut var_new_array := rt.new_array()
	if rt.is_true(this.last_result) {
		mut var_i := rt.new_int(0)
		mut var_j := rt.new_int(this.last_result.array_count())
		for {
			if !(rt.is_true(rt.less(var_i, var_j))) { break }
			var_new_array.array_set(var_i, this.get_var(rt.new_null(), x, (var_i).to_i64()))
			rt.post_inc(var_i)
		}
	}
	return var_new_array.clone()
}

fn (mut this Class_wpdb) get_results(var_query rt.PhpVal, var_output rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	this.func_call = rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('$db->get_results("'), var_query_mutated), rt.new_string('", ')), var_output), rt.new_string(')'))
	if rt.is_true(var_query_mutated) {
		if this.check_current_query && this.check_safe_collation(var_query_mutated.clone()) {
			this.check_current_query = false
		}
		this.query(var_query_mutated.clone())
	} else {
		return rt.new_null()
	}
	mut var_new_array := rt.new_array()
	if rt.is_true(rt.identical(rt.new_string(global_const_object), var_output)) {
		return this.last_result
	} else if rt.is_true(rt.identical(rt.new_string(global_const_object_k), var_output)) {
		if rt.is_true(this.last_result) {
			mut iter_20 := this.last_result.iterator()
			for {
				item_20 := iter_20.next() or { break }
				mut var_row := item_20.val
				mut var_var_by_ref := rt.call_function('get_object_vars', [var_row.clone()])
				mut var_key := rt.call_function('array_shift', [var_var_by_ref.clone()])
				if !(var_new_array.array_isset(var_key)) {
					var_new_array.array_set(var_key, var_row.clone())
				}
			}
		}
		return var_new_array.clone()
	} else if rt.is_true(rt.identical(rt.new_string(global_const_array_a), var_output)) || rt.is_true(rt.identical(rt.new_string(global_const_array_n), var_output)) {
		if rt.is_true(this.last_result) {
			if rt.is_true(rt.identical(rt.new_string(global_const_array_n), var_output)) {
				mut iter_21 := rt.cast_array(this.last_result).iterator()
				for {
					item_21 := iter_21.next() or { break }
					mut var_row := item_21.val
					var_new_array.array_push(rt.call_function('array_values', [rt.call_function('get_object_vars', [var_row.clone()])]))
				}
			} else {
				mut iter_22 := rt.cast_array(this.last_result).iterator()
				for {
					item_22 := iter_22.next() or { break }
					mut var_row := item_22.val
					var_new_array.array_push(rt.call_function('get_object_vars', [var_row.clone()]))
				}
			}
		}
		return var_new_array.clone()
	} else if rt.is_true(rt.identical(rt.new_string(var_output.clone().to_string().to_upper()), rt.new_string(global_const_object))) {
		return this.last_result
	}
	return rt.new_null()
}

fn (mut this Class_wpdb) get_table_charset(var_table rt.PhpVal) string {
	mut var_type := rt.new_null()
	mut var_table_mutated := var_table
	mut var_tablekey := rt.new_string(var_table_mutated.clone().to_string().to_lower())
	mut var_charset := rt.call_function('apply_filters', [rt.new_string('pre_get_table_charset'), rt.new_null(), var_table_mutated.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_charset)))) {
		return (var_charset).str()
	}
	if this.table_charset.array_isset(var_tablekey) {
		return (this.table_charset.array_get(var_tablekey)).str()
	}
	mut var_charsets := rt.new_array()
	mut var_columns := rt.new_array()
	mut var_table_parts := rt.call_function('explode', [rt.new_string('.'), var_table_mutated.clone()])
	var_table_mutated = rt.new_string('`' + (rt.call_function('implode', [rt.new_string('`.`'), var_table_parts.clone()])).str() + '`')
	mut var_results := this.get_results(rt.new_string("SHOW FULL COLUMNS FROM ${var_table.to_string()}"), rt.new_null())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_results)))) {
		return (create_wp_error(rt.new_string('wpdb_get_table_charset_failure'), rt.call_function('__', [rt.new_string('Could not retrieve table charset.')]))).str()
	}
	mut iter_23 := var_results.iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_column := item_23.val
		var_columns[rt.get_property(var_column, 'Field').to_string().to_lower()] = var_column.clone()
	}
	this.col_meta.array_set(var_tablekey, var_columns.clone())
	for _, var_column in var_columns {
		if !(!rt.is_true(rt.get_property(var_column, 'Collation'))) {
			mut list_tmp_2 := rt.call_function('explode', [rt.new_string('_'), rt.get_property(var_column, 'Collation')])
			var_charset = (list_tmp_2).array_get(0)
			var_charsets[var_charset.clone().to_string().to_lower()] = true
		}
		mut list_tmp_3 := rt.call_function('explode', [rt.new_string('('), rt.get_property(var_column, 'Type')])
		var_type = (list_tmp_3).array_get(0)
		if rt.is_true(rt.call_function('in_array', [rt.new_string(var_type.clone().to_string().to_upper()), rt.create_array([rt.ArrayItem{ key: none, val: 'BINARY' }, rt.ArrayItem{ key: none, val: 'VARBINARY' }, rt.ArrayItem{ key: none, val: 'TINYBLOB' }, rt.ArrayItem{ key: none, val: 'MEDIUMBLOB' }, rt.ArrayItem{ key: none, val: 'BLOB' }, rt.ArrayItem{ key: none, val: 'LONGBLOB' }]), rt.new_bool(true)])) {
			this.table_charset.array_set(var_tablekey, 'binary')
			return 'binary'
		}
	}
	if var_charsets.array_isset(rt.new_string('utf8mb3')) {
		var_charsets['utf8'] = true
		var_charsets.delete('utf8mb3')
	}
	mut var_count := rt.new_int(var_charsets.len)
	if rt.is_true(rt.identical(rt.new_int(1), var_count)) {
	var_charset = rt.call_function('key', [rt.create_array_from_native_map(var_charsets)])
	} else if rt.is_true(rt.identical(rt.new_int(0), var_count)) {
	var_charset = rt.new_bool(false)
	} else {
		var_charsets.delete('latin1')
		var_count = rt.new_int(var_charsets.len)
		if rt.is_true(rt.identical(rt.new_int(1), var_count)) {
		var_charset = rt.call_function('key', [rt.create_array_from_native_map(var_charsets)])
		} else if rt.is_true(rt.identical(rt.new_int(2), var_count)) && var_charsets.array_isset(rt.new_string('utf8')) && var_charsets.array_isset(rt.new_string('utf8mb4')) {
		var_charset = rt.new_string('utf8')
		} else {
		var_charset = rt.new_string('ascii')
		}
	}
	this.table_charset.array_set(var_tablekey, var_charset.clone())
	return (var_charset).str()
}

fn (mut this Class_wpdb) get_col_charset(var_table rt.PhpVal, var_column rt.PhpVal) bool {
	mut var_table_mutated := var_table
	mut var_tablekey := rt.new_string(var_table_mutated.clone().to_string().to_lower())
	mut var_columnkey := rt.new_string(var_column.clone().to_string().to_lower())
	mut var_charset := rt.call_function('apply_filters', [rt.new_string('pre_get_col_charset'), rt.new_null(), var_table_mutated.clone(), var_column.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_charset)))) {
		return (var_charset).to_bool()
	}
	if !(this.is_mysql) {
		return false
	}
	if !rt.is_true(this.table_charset.array_get(var_tablekey)) {
		mut var_table_charset := rt.new_string(this.get_table_charset(var_table_mutated.clone()))
		if rt.is_true(rt.call_function('is_wp_error', [var_table_charset.clone()])) {
			return (var_table_charset).to_bool()
		}
	}
	if !rt.is_true(this.col_meta.array_get(var_tablekey)) {
		return (this.table_charset.array_get(var_tablekey)).to_bool()
	}
	if !rt.is_true(this.col_meta.array_get(var_tablekey).array_get(var_columnkey)) {
		return (this.table_charset.array_get(var_tablekey)).to_bool()
	}
	if !rt.is_true(rt.get_property(this.col_meta.array_get(var_tablekey).array_get(var_columnkey), 'Collation')) {
		return false
	}
	mut list_tmp_4 := rt.call_function('explode', [rt.new_string('_'), rt.get_property(this.col_meta.array_get(var_tablekey).array_get(var_columnkey), 'Collation')])
	var_charset = (list_tmp_4).array_get(0)
	return (var_charset).to_bool()
}

fn (mut this Class_wpdb) get_col_length(var_table rt.PhpVal, var_column rt.PhpVal) rt.PhpVal {
	mut var_table_mutated := var_table
	mut var_tablekey := rt.new_string(var_table_mutated.clone().to_string().to_lower())
	mut var_columnkey := rt.new_string(var_column.clone().to_string().to_lower())
	if !(this.is_mysql) {
		return rt.new_bool(false)
	}
	if !rt.is_true(this.col_meta.array_get(var_tablekey)) {
		mut var_table_charset := rt.new_string(this.get_table_charset(var_table_mutated.clone()))
		if rt.is_true(rt.call_function('is_wp_error', [var_table_charset.clone()])) {
			return var_table_charset.clone()
		}
	}
	if !rt.is_true(this.col_meta.array_get(var_tablekey).array_get(var_columnkey)) {
		return rt.new_bool(false)
	}
	mut var_typeinfo := rt.call_function('explode', [rt.new_string('('), rt.get_property(this.col_meta.array_get(var_tablekey).array_get(var_columnkey), 'Type')])
	mut var_type := rt.new_string(var_typeinfo.array_get(rt.new_int(0)).to_string().to_lower())
	if !(!rt.is_true(var_typeinfo.array_get(rt.new_int(1)))) {
	mut var_length := rt.new_string(var_typeinfo.array_get(rt.new_int(1)).to_string().trim_space())
	} else {
	var_length = rt.new_bool(false)
	}
	mut switch_val_2 := var_type
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('char'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('varchar'))) {
		return rt.create_array([rt.ArrayItem{ key: 'type', val: 'char' }, rt.ArrayItem{ key: 'length', val: rt.new_int((var_length).to_i64()) }])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('binary'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('varbinary'))) {
		return rt.create_array([rt.ArrayItem{ key: 'type', val: 'byte' }, rt.ArrayItem{ key: 'length', val: rt.new_int((var_length).to_i64()) }])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('tinyblob'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('tinytext'))) {
		return rt.create_array([rt.ArrayItem{ key: 'type', val: 'byte' }, rt.ArrayItem{ key: 'length', val: 255 }])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('blob'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('text'))) {
		return rt.create_array([rt.ArrayItem{ key: 'type', val: 'byte' }, rt.ArrayItem{ key: 'length', val: 65535 }])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mediumblob'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('mediumtext'))) {
		return rt.create_array([rt.ArrayItem{ key: 'type', val: 'byte' }, rt.ArrayItem{ key: 'length', val: 16777215 }])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('longblob'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('longtext'))) {
		return rt.create_array([rt.ArrayItem{ key: 'type', val: 'byte' }, rt.ArrayItem{ key: 'length', val: 4294967295 }])
	} else {
		return rt.new_bool(false)
	}
	return rt.new_null()
}

fn (mut this Class_wpdb) check_ascii(var_input_string rt.PhpVal) bool {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_check_encoding')])) {
		if rt.is_true(rt.call_function('mb_check_encoding', [var_input_string.clone(), rt.new_string('ASCII')])) {
			return true
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/[^\\x00-\\x7F]/'), var_input_string.clone()]))))) {
		return true
	}
	return false
}

fn (mut this Class_wpdb) check_safe_collation(var_query rt.PhpVal) bool {
	mut var_query_mutated := var_query
	if this.checking_collation {
		return true
	}
	var_query_mutated = rt.new_string(var_query_mutated.clone().to_string().trim_left(' \t\n\r'))
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(?:SHOW|DESCRIBE|DESC|EXPLAIN|CREATE)\\s/i'), var_query_mutated.clone()])) {
		return true
	}
	if this.check_ascii(var_query_mutated.clone()) {
		return true
	}
	mut var_table := rt.new_bool(this.get_table_from_query(var_query_mutated.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_table)))) {
		return false
	}
	this.checking_collation = true
	mut var_collation := rt.new_string(this.get_table_charset(var_table.clone()))
	this.checking_collation = false
	if rt.is_true(rt.identical(rt.new_bool(false), var_collation)) || rt.is_true(rt.identical(rt.new_string('latin1'), var_collation)) {
		return true
	}
	var_table = rt.new_string(var_table.clone().to_string().to_lower())
	if !rt.is_true(this.col_meta.array_get(var_table)) {
		return false
	}
	mut var_safe_collations := ['utf8_bin', 'utf8_general_ci', 'utf8mb3_bin', 'utf8mb3_general_ci', 'utf8mb4_bin', 'utf8mb4_general_ci']
	mut iter_24 := this.col_meta.array_get(var_table).iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_col := item_24.val
		if !rt.is_true(rt.get_property(var_col, 'Collation')) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_col, 'Collation'), rt.create_array_from_list(var_safe_collations), rt.new_bool(true)]))))) {
			return false
		}
	}
	return true
}

fn (mut this Class_wpdb) strip_invalid_text(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_db_check_string := rt.new_bool(false)
	mut iter_25 := var_data_mutated.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_value := item_25.val
		mut var_charset := var_value.array_get(rt.new_string('charset'))
		if rt.is_true(rt.new_bool(var_value.array_get(rt.new_string('length')).is_array())) {
		mut var_length := var_value.array_get(rt.new_string('length')).array_get(rt.new_string('length'))
		mut var_truncate_by_byte_length := rt.identical(rt.new_string('byte'), var_value.array_get(rt.new_string('length')).array_get(rt.new_string('type')))
		} else {
		var_length = rt.new_bool(false)
		var_truncate_by_byte_length = rt.new_bool(false)
		}
		if rt.is_true(rt.identical(rt.new_bool(false), var_charset)) {
			continue
		}
		if !(var_value.array_get(rt.new_string('value')).is_string()) {
			continue
		}
		mut var_needs_validation := rt.new_bool(true)
		if rt.is_true(rt.identical(rt.new_string('latin1'), var_charset)) || (!(var_value.array_isset(rt.new_string('ascii'))) && this.check_ascii(var_value.array_get(rt.new_string('value')))) {
		var_truncate_by_byte_length = rt.new_bool(true)
		var_needs_validation = rt.new_bool(false)
		}
		if rt.is_true(var_truncate_by_byte_length) {
			rt.call_function('mbstring_binary_safe_encoding', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_length)))) && rt.is_true(rt.greater(rt.new_int(var_value.array_get(rt.new_string('value')).to_string().len), var_length)) {
				var_value.array_set('value', rt.call_function('substr', [var_value.array_get(rt.new_string('value')), rt.new_int(0), var_length.clone()]))
			}
			rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(!(rt.is_true(var_needs_validation)))) {
				continue
			}
		}
		if rt.is_true(rt.identical(rt.new_string('utf8'), var_charset)) || rt.is_true(rt.identical(rt.new_string('utf8mb3'), var_charset)) || rt.is_true(rt.identical(rt.new_string('utf8mb4'), var_charset)) && rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_strlen')])) {
			mut var_regex := rt.new_string('/\n\t\t\t\t\t(\n\t\t\t\t\t\t(?: [\\x00-\\x7F]                  # single-byte sequences   0xxxxxxx\n\t\t\t\t\t\t|   [\\xC2-\\xDF][\\x80-\\xBF]       # double-byte sequences   110xxxxx 10xxxxxx\n\t\t\t\t\t\t|   \\xE0[\\xA0-\\xBF][\\x80-\\xBF]   # triple-byte sequences   1110xxxx 10xxxxxx * 2\n\t\t\t\t\t\t|   [\\xE1-\\xEC][\\x80-\\xBF]{2}\n\t\t\t\t\t\t|   \\xED[\\x80-\\x9F][\\x80-\\xBF]\n\t\t\t\t\t\t|   [\\xEE-\\xEF][\\x80-\\xBF]{2}')
			if rt.is_true(rt.identical(rt.new_string('utf8mb4'), var_charset)) {
				var_regex = rt.concat(var_regex, rt.new_string('\n\t\t\t\t\t\t|    \\xF0[\\x90-\\xBF][\\x80-\\xBF]{2} # four-byte sequences   11110xxx 10xxxxxx * 3\n\t\t\t\t\t\t|    [\\xF1-\\xF3][\\x80-\\xBF]{3}\n\t\t\t\t\t\t|    \\xF4[\\x80-\\x8F][\\x80-\\xBF]{2}\n\t\t\t\t\t'))
			}
			var_regex = rt.concat(var_regex, rt.new_string('){1,40}                          # ...one or more times\n\t\t\t\t\t)\n\t\t\t\t\t| .                                  # anything else\n\t\t\t\t\t/x'))
			var_value.array_set('value', rt.call_function('preg_replace', [var_regex.clone(), rt.new_string('$1'), var_value.array_get(rt.new_string('value'))]))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_length)))) && rt.is_true(rt.greater(rt.call_function('mb_strlen', [var_value.array_get(rt.new_string('value')), rt.new_string('UTF-8')]), var_length)) {
				var_value.array_set('value', rt.call_function('mb_substr', [var_value.array_get(rt.new_string('value')), rt.new_int(0), var_length.clone(), rt.new_string('UTF-8')]))
			}
			continue
		}
		var_value.array_set('db', true)
	var_db_check_string = rt.new_bool(true)
	}
	var_value = rt.new_null()
	if rt.is_true(var_db_check_string) {
		mut var_queries := rt.new_array()
		mut iter_26 := var_data_mutated.iterator()
		for {
			item_26 := iter_26.next() or { break }
			mut var_value := item_26.val
			mut var_col := item_26.key
			if !(!rt.is_true(var_value.array_get(rt.new_string('db')))) {
				if var_value.array_get(rt.new_string('length')).array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.new_string('byte'), var_value.array_get(rt.new_string('length')).array_get(rt.new_string('type')))) {
				mut var_charset := rt.new_string('binary')
				} else {
				var_charset = var_value.array_get(rt.new_string('charset'))
				}
				if rt.is_true(this.charset) {
				mut var_connection_charset := this.charset
				} else {
				var_connection_charset = rt.call_function('mysqli_character_set_name', [this.dbh])
				}
				if rt.is_true(rt.new_bool(var_value.array_get(rt.new_string('length')).is_array())) {
					mut var_length := rt.call_function('sprintf', [rt.new_string('%.0f'), var_value.array_get(rt.new_string('length')).array_get(rt.new_string('length'))])
					var_queries.array_set(var_col, this.prepare(rt.new_string("CONVERT( LEFT( CONVERT( %s USING ${var_charset.to_string()} ), ${var_length.to_string()} ) USING ${var_connection_charset.to_string()} )"), var_value.array_get(rt.new_string('value'))))
				} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('binary'), var_charset)))) {
					var_queries.array_set(var_col, this.prepare(rt.new_string("CONVERT( CONVERT( %s USING ${var_charset.to_string()} ) USING ${var_connection_charset.to_string()} )"), var_value.array_get(rt.new_string('value'))))
				}
				var_data_mutated.array_get(var_col).array_unset(rt.new_string('db'))
			}
		}
		mut var_sql := rt.new_array()
		mut iter_27 := var_queries.iterator()
		for {
			item_27 := iter_27.next() or { break }
			mut var_query := item_27.val
			mut var_column := item_27.key
			if rt.is_true(rt.new_bool(!(rt.is_true(var_query)))) {
				continue
			}
			var_sql.array_push((var_query).str() + " AS x_${var_column.to_string()}")
		}
		this.check_current_query = false
		mut var_row := this.get_row(rt.new_string('SELECT ' + (rt.call_function('implode', [rt.new_string(', '), var_sql.clone()])).str()), rt.new_string(global_const_array_a), 0)
		if rt.is_true(rt.new_bool(!(rt.is_true(var_row)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('wpdb_strip_invalid_text_failure'), rt.call_function('__', [rt.new_string('Could not strip invalid text.')])))
		}
		mut iter_28 := rt.func_array_keys(var_data_mutated.clone()).iterator()
		for {
			item_28 := iter_28.next() or { break }
			mut var_column := item_28.val
			if var_row.array_isset(rt.new_string("x_${var_column.to_string()}")) {
				var_data_mutated.array_get_mut(var_column).array_set('value', var_row.array_get(rt.new_string("x_${var_column.to_string()}")))
			}
		}
	}
	return var_data_mutated.clone()
}

fn (mut this Class_wpdb) strip_invalid_text_from_query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	mut var_trimmed_query := rt.new_string(var_query_mutated.clone().to_string().trim_left(' \t\n\r'))
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(?:SHOW|DESCRIBE|DESC|EXPLAIN|CREATE)\\s/i'), var_trimmed_query.clone()])) {
		return var_query_mutated.clone()
	}
	mut var_table := rt.new_bool(this.get_table_from_query(var_query_mutated.clone()))
	if rt.is_true(var_table) {
		mut var_charset := rt.new_string(this.get_table_charset(var_table.clone()))
		if rt.is_true(rt.call_function('is_wp_error', [var_charset.clone()])) {
			return var_charset.clone()
		}
		if rt.is_true(rt.identical(rt.new_string('binary'), var_charset)) {
			return var_query_mutated.clone()
		}
	} else {
	var_charset = this.charset
	}
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'value', val: var_query_mutated }, rt.ArrayItem{ key: 'charset', val: var_charset }, rt.ArrayItem{ key: 'ascii', val: false }, rt.ArrayItem{ key: 'length', val: false }])
	var_data = this.strip_invalid_text(rt.create_array([rt.ArrayItem{ key: none, val: var_data }]))
	if rt.is_true(rt.call_function('is_wp_error', [var_data.clone()])) {
		return var_data.clone()
	}
	return var_data.array_get(rt.new_int(0)).array_get(rt.new_string('value'))
}

fn (mut this Class_wpdb) strip_invalid_text_for_column(var_table rt.PhpVal, var_column rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_table_mutated := var_table
	mut var_value_mutated := var_value
	if !(var_value_mutated.clone().is_string()) {
		return var_value_mutated.clone()
	}
	mut var_charset := rt.new_bool(this.get_col_charset(var_table_mutated.clone(), var_column.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_charset)))) {
		return var_value_mutated.clone()
	} else if rt.is_true(rt.call_function('is_wp_error', [var_charset.clone()])) {
		return var_charset.clone()
	}
	mut var_data := rt.create_array([rt.ArrayItem{ key: var_column, val: rt.create_array([rt.ArrayItem{ key: 'value', val: var_value_mutated }, rt.ArrayItem{ key: 'charset', val: var_charset }, rt.ArrayItem{ key: 'length', val: this.get_col_length(var_table_mutated.clone(), var_column.clone()) }]) }])
	var_data = this.strip_invalid_text(var_data.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_data.clone()])) {
		return var_data.clone()
	}
	return var_data.array_get(var_column).array_get(rt.new_string('value'))
}

fn (mut this Class_wpdb) get_table_from_query(var_query rt.PhpVal) bool {
	mut var_maybe := []rt.PhpVal{}
	mut var_query_mutated := var_query
	var_query_mutated = rt.new_string(var_query_mutated.clone().to_string().trim_right(' \t\n\r'))
	var_query_mutated = rt.new_string(var_query_mutated.clone().to_string().trim_left(' \t\n\r'))
	var_query_mutated = rt.call_function('preg_replace', [rt.new_string('/\\((?!\\s*select)[^(]*?\\)/is'), rt.new_string('()'), var_query_mutated.clone()])
	var_query_mutated = rt.call_function('preg_replace', [rt.new_string('/^SET STATEMENT.+?\\sFOR\\s+/is'), rt.new_string(''), var_query_mutated.clone()])
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*(?:' + 'SELECT.*?\\s+FROM' + '|INSERT(?:\\s+LOW_PRIORITY|\\s+DELAYED|\\s+HIGH_PRIORITY)?(?:\\s+IGNORE)?(?:\\s+INTO)?' + '|REPLACE(?:\\s+LOW_PRIORITY|\\s+DELAYED)?(?:\\s+INTO)?' + '|UPDATE(?:\\s+LOW_PRIORITY)?(?:\\s+IGNORE)?' + '|DELETE(?:\\s+LOW_PRIORITY|\\s+QUICK|\\s+IGNORE)*(?:.+?FROM)?' + ')\\s+((?:[0-9a-zA-Z$_.`-]|[\\xC2-\\xDF][\\x80-\\xBF])+)/is'), var_query_mutated.clone(), rt.create_array_from_list(var_maybe)])) {
		return (rt.call_function('str_replace', [rt.new_string('`'), rt.new_string(''), var_maybe.array_get(rt.new_int(1))])).to_bool()
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*SHOW\\s+(?:TABLE\\s+STATUS|(?:FULL\\s+)?TABLES).+WHERE\\s+Name\\s*=\\s*("|\')((?:[0-9a-zA-Z$_.-]|[\\xC2-\\xDF][\\x80-\\xBF])+)\\1/is'), var_query_mutated.clone(), rt.create_array_from_list(var_maybe)])) {
		return (var_maybe.array_get(rt.new_int(2))).to_bool()
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*SHOW\\s+(?:TABLE\\s+STATUS|(?:FULL\\s+)?TABLES)\\s+(?:WHERE\\s+Name\\s+)?LIKE\\s*("|\')((?:[\\\\0-9a-zA-Z$_.-]|[\\xC2-\\xDF][\\x80-\\xBF])+)%?\\1/is'), var_query_mutated.clone(), rt.create_array_from_list(var_maybe)])) {
		return (rt.call_function('str_replace', [rt.new_string('\\_'), rt.new_string('_'), var_maybe.array_get(rt.new_int(2))])).to_bool()
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*(?:' + '(?:EXPLAIN\\s+(?:EXTENDED\\s+)?)?SELECT.*?\\s+FROM' + '|DESCRIBE|DESC|EXPLAIN|HANDLER' + '|(?:LOCK|UNLOCK)\\s+TABLE(?:S)?' + '|(?:RENAME|OPTIMIZE|BACKUP|RESTORE|CHECK|CHECKSUM|ANALYZE|REPAIR).*\\s+TABLE' + '|TRUNCATE(?:\\s+TABLE)?' + '|CREATE(?:\\s+TEMPORARY)?\\s+TABLE(?:\\s+IF\\s+NOT\\s+EXISTS)?' + '|ALTER(?:\\s+IGNORE)?\\s+TABLE' + '|DROP\\s+TABLE(?:\\s+IF\\s+EXISTS)?' + '|CREATE(?:\\s+\\w+)?\\s+INDEX.*\\s+ON' + '|DROP\\s+INDEX.*\\s+ON' + '|LOAD\\s+DATA.*INFILE.*INTO\\s+TABLE' + '|(?:GRANT|REVOKE).*ON\\s+TABLE' + '|SHOW\\s+(?:.*FROM|.*TABLE)' + ')\\s+\\(*\\s*((?:[0-9a-zA-Z$_.`-]|[\\xC2-\\xDF][\\x80-\\xBF])+)\\s*\\)*/is'), var_query_mutated.clone(), rt.create_array_from_list(var_maybe)])) {
		return (rt.call_function('str_replace', [rt.new_string('`'), rt.new_string(''), var_maybe.array_get(rt.new_int(1))])).to_bool()
	}
	return false
}

fn (mut this Class_wpdb) load_col_info() {
	if rt.is_true(this.col_info) {
		return
	}
	mut var_num_fields := rt.call_function('mysqli_num_fields', [this.result])
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_num_fields))) { break }
		this.col_info.array_set(var_i, rt.call_function('mysqli_fetch_field', [this.result]))
		rt.post_inc(var_i)
	}
}

fn (mut this Class_wpdb) get_col_info(info_type string, var_col_offset rt.PhpVal) rt.PhpVal {
	this.load_col_info()
	if rt.is_true(this.col_info) {
		if rt.is_true(rt.identical(-1, var_col_offset)) {
			mut var_i := rt.new_int(0)
			mut var_new_array := rt.new_array()
			mut iter_29 := rt.cast_array(this.col_info).iterator()
			for {
				item_29 := iter_29.next() or { break }
				mut var_col := item_29.val
				var_new_array.array_set(var_i, rt.get_property(var_col, '{"nodeType":"Expr_Variable","line":3897,"name":"info_type"}'))
				rt.pre_inc(var_i)
			}
			return var_new_array.clone()
		} else {
			return rt.get_property(this.col_info.array_get(var_col_offset), '{"nodeType":"Expr_Variable","line":3902,"name":"info_type"}')
		}
	}
	return rt.new_null()
}

fn (mut this Class_wpdb) timer_start() bool {
	this.time_start = rt.call_function('microtime', [rt.new_bool(true)])
	return true
}

fn (mut this Class_wpdb) timer_stop() rt.PhpVal {
	return rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), this.time_start)
}

fn (mut this Class_wpdb) bail(var_message rt.PhpVal, error_code string) bool {
	mut var_message_mutated := var_message
	if rt.is_true(this.show_errors) {
		mut var_error := rt.new_string('')
		if rt.is_true(rt.new_bool(rt.instance_of(this.dbh, 'mysqli'))) {
		var_error = rt.call_function('mysqli_error', [this.dbh])
		} else if rt.is_true(rt.call_function('mysqli_connect_errno', []rt.PhpVal{})) {
		var_error = rt.call_function('mysqli_connect_error', []rt.PhpVal{})
		}
		if rt.is_true(var_error) {
		var_message_mutated = rt.new_string('<p><code>' + (var_error).str() + '</code></p>\n' + (var_message_mutated).str())
		}
		rt.call_function('wp_die', [var_message_mutated.clone()])
	} else {
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_Error'), rt.new_bool(false)])) {
			this.error = create_wp_error(rt.new_string(error_code), var_message_mutated.clone())
		} else {
			this.error = var_message_mutated.clone()
		}
		return false
	}
	return false
}

fn (mut this Class_wpdb) close() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.dbh)))) {
		return false
	}
	mut var_closed := rt.call_function('mysqli_close', [this.dbh])
	if rt.is_true(var_closed) {
		this.dbh = rt.new_null()
		this.ready = false
		this.has_connected = false
	}
	return (var_closed).to_bool()
}

fn (mut this Class_wpdb) check_database_version() rt.PhpVal {
	mut var_required_mysql_version := rt.new_null()
	mut var_wp_version := rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	if rt.is_true(rt.call_function('version_compare', [this.db_version(), var_required_mysql_version.clone(), rt.new_string('<')])) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('database_version'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Error:</strong> WordPress %1$s requires MySQL %2$s or higher')]), var_wp_version.clone(), var_required_mysql_version.clone()])))
	}
	return rt.new_null()
}

fn (mut this Class_wpdb) supports_collation() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.5.0'), rt.new_string('wpdb::has_cap( \'collation\' )')])
	return rt.new_bool(this.has_cap(rt.new_string('collation')))
}

fn (mut this Class_wpdb) get_charset_collate() rt.PhpVal {
	mut var_charset_collate := rt.new_string('')
	if !(!rt.is_true(this.charset)) {
	var_charset_collate = rt.new_string((rt.concat(rt.new_string('DEFAULT CHARACTER SET '), this.charset)).str())
	}
	if !(!rt.is_true(this.collate)) {
		var_charset_collate = rt.concat(var_charset_collate, rt.concat(rt.new_string(' COLLATE '), this.collate))
	}
	return var_charset_collate.clone()
}

fn (mut this Class_wpdb) has_cap(var_db_cap rt.PhpVal) bool {
	mut var_db_version := this.db_version()
	mut var_db_server_info := this.db_server_info()
	if rt.is_true(rt.identical(rt.new_string('5.5.5'), var_db_version)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_db_server_info.clone(), rt.new_string('MariaDB')]))))) && rt.is_true(rt.less_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80015))) || (rt.is_true(rt.less_equal(rt.new_int(80100), rt.get_constant('PHP_VERSION_ID'))) && rt.is_true(rt.less_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80102)))) {
	var_db_server_info = rt.call_function('preg_replace', [rt.new_string('/^5\\.5\\.5-(.*)/'), rt.new_string('$1'), var_db_server_info.clone()])
	var_db_version = rt.call_function('preg_replace', [rt.new_string('/[^0-9.].*/'), rt.new_string(''), var_db_server_info.clone()])
	}
	mut switch_val_3 := rt.new_string(var_db_cap.clone().to_string().to_lower())
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('collation'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('group_concat'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('subqueries'))) {
		return (rt.call_function('version_compare', [var_db_version.clone(), rt.new_string('4.1'), rt.new_string('>=')])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('set_charset'))) {
		return (rt.call_function('version_compare', [var_db_version.clone(), rt.new_string('5.0.7'), rt.new_string('>=')])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('utf8mb4'))) {
		return true
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('utf8mb4_520'))) {
		return (rt.call_function('version_compare', [var_db_version.clone(), rt.new_string('5.6'), rt.new_string('>=')])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('identifier_placeholders'))) {
		return true
	}
	return false
}

fn (mut this Class_wpdb) get_caller() rt.PhpVal {
	return rt.call_function('wp_debug_backtrace_summary', [rt.new_string(@STRUCT)])
}

fn (mut this Class_wpdb) db_version() rt.PhpVal {
	return rt.call_function('preg_replace', [rt.new_string('/[^0-9.].*/'), rt.new_string(''), this.db_server_info()])
}

fn (mut this Class_wpdb) db_server_info() rt.PhpVal {
	return rt.call_function('mysqli_get_server_info', [this.dbh])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wpdb(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_wpdb {
	mut obj := &Class_wpdb{
		PhpObjectBase: rt.PhpObjectBase{}
		show_errors: rt.new_bool(false)
		suppress_errors: rt.new_bool(false)
		last_error: rt.new_string('')
		num_queries: rt.new_int(0)
		num_rows: rt.new_int(0)
		rows_affected: rt.new_int(0)
		insert_id: rt.new_int(0)
		last_query: rt.new_null()
		last_result: rt.new_null()
		result: rt.new_null()
		col_meta: rt.new_array()
		table_charset: rt.new_array()
		check_current_query: false
		checking_collation: false
		col_info: rt.new_null()
		queries: rt.new_null()
		reconnect_retries: rt.new_int(5)
		prefix: rt.new_string('')
		base_prefix: rt.new_null()
		ready: false
		blogid: rt.new_int(0)
		siteid: rt.new_int(0)
		tables: rt.new_array()
		old_tables: rt.new_array()
		global_tables: rt.new_array()
		ms_global_tables: rt.new_array()
		old_ms_global_tables: rt.new_array()
		comments: rt.new_null()
		commentmeta: rt.new_null()
		links: rt.new_null()
		options: rt.new_null()
		postmeta: rt.new_null()
		posts: rt.new_null()
		terms: rt.new_null()
		term_relationships: rt.new_null()
		term_taxonomy: rt.new_null()
		termmeta: rt.new_null()
		usermeta: rt.new_null()
		users: rt.new_null()
		blogs: rt.new_null()
		blogmeta: rt.new_null()
		registration_log: rt.new_null()
		signups: rt.new_null()
		site: rt.new_null()
		sitecategories: rt.new_null()
		sitemeta: rt.new_null()
		field_types: rt.new_array()
		charset: rt.new_null()
		collate: rt.new_null()
		dbuser: rt.new_null()
		dbpassword: rt.new_null()
		dbname: rt.new_null()
		dbhost: rt.new_null()
		dbh: rt.new_null()
		func_call: ''
		is_mysql: false
		incompatible_modes: rt.new_array()
		allow_unsafe_unquoted_parameters: rt.new_bool(true)
		use_mysqli: rt.new_bool(true)
		has_connected: false
		time_start: rt.new_null()
		error: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_wpdb) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_isset(dispatch_arg_0)
		}
		'__unset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.magic_unset(dispatch_arg_0)
			return rt.new_null()
		}
		'init_charset' {
			this.init_charset()
			return rt.new_null()
		}
		'determine_charset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.determine_charset(dispatch_arg_0, dispatch_arg_1)
		}
		'set_charset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.set_charset(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'set_sql_mode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_sql_mode(dispatch_arg_0)
			return rt.new_null()
		}
		'set_prefix' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.set_prefix(dispatch_arg_0, dispatch_arg_1)
		}
		'set_blog_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.set_blog_id(dispatch_arg_0, dispatch_arg_1)
		}
		'get_blog_prefix' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_blog_prefix(dispatch_arg_0))
		}
		'tables' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.tables(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'select' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.select(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'_weak_escape' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._weak_escape(dispatch_arg_0)
		}
		'_real_escape' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this._real_escape(dispatch_arg_0))
		}
		'_escape' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._escape(dispatch_arg_0)
		}
		'escape' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.escape(dispatch_arg_0)
		}
		'escape_by_ref' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.escape_by_ref(dispatch_arg_0)
			return rt.new_null()
		}
		'quote_identifier' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.quote_identifier(dispatch_arg_0))
		}
		'_escape_identifier_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._escape_identifier_value(dispatch_arg_0)
		}
		'prepare' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.prepare(dispatch_arg_0, dispatch_arg_1))
		}
		'esc_like' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.esc_like(dispatch_arg_0)
		}
		'print_error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.print_error(dispatch_arg_0))
		}
		'show_errors' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.show_errors(dispatch_arg_0)
		}
		'hide_errors' {
			return this.hide_errors()
		}
		'suppress_errors' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.suppress_errors(dispatch_arg_0)
		}
		'flush' {
			this.flush()
			return rt.new_null()
		}
		'db_connect' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.db_connect(dispatch_arg_0))
		}
		'parse_db_host' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_db_host(dispatch_arg_0)
		}
		'check_connection' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.check_connection(dispatch_arg_0))
		}
		'query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.query(dispatch_arg_0))
		}
		'_do_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._do_query(dispatch_arg_0)
			return rt.new_null()
		}
		'log_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			this.log_query(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'placeholder_escape' {
			return this.placeholder_escape()
		}
		'add_placeholder_escape' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_placeholder_escape(dispatch_arg_0)
		}
		'remove_placeholder_escape' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_placeholder_escape(dispatch_arg_0)
		}
		'insert' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.insert(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'replace' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.replace(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'_insert_replace_helper' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_bool(this._insert_replace_helper(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(this.update(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.delete(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'process_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.process_fields(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'process_field_formats' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.process_field_formats(dispatch_arg_0, dispatch_arg_1)
		}
		'process_field_charsets' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.process_field_charsets(dispatch_arg_0, dispatch_arg_1))
		}
		'process_field_lengths' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.process_field_lengths(dispatch_arg_0, dispatch_arg_1))
		}
		'get_var' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.get_var(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.get_row(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_col' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_col(dispatch_arg_0, dispatch_arg_1)
		}
		'get_results' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_results(dispatch_arg_0, dispatch_arg_1)
		}
		'get_table_charset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_table_charset(dispatch_arg_0))
		}
		'get_col_charset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.get_col_charset(dispatch_arg_0, dispatch_arg_1))
		}
		'get_col_length' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_col_length(dispatch_arg_0, dispatch_arg_1)
		}
		'check_ascii' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_ascii(dispatch_arg_0))
		}
		'check_safe_collation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_safe_collation(dispatch_arg_0))
		}
		'strip_invalid_text' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.strip_invalid_text(dispatch_arg_0)
		}
		'strip_invalid_text_from_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.strip_invalid_text_from_query(dispatch_arg_0)
		}
		'strip_invalid_text_for_column' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.strip_invalid_text_for_column(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_table_from_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_table_from_query(dispatch_arg_0))
		}
		'load_col_info' {
			this.load_col_info()
			return rt.new_null()
		}
		'get_col_info' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_col_info(dispatch_arg_0, dispatch_arg_1)
		}
		'timer_start' {
			return rt.new_bool(this.timer_start())
		}
		'timer_stop' {
			return this.timer_stop()
		}
		'bail' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.bail(dispatch_arg_0, dispatch_arg_1))
		}
		'close' {
			return rt.new_bool(this.close())
		}
		'check_database_version' {
			return this.check_database_version()
		}
		'supports_collation' {
			return this.supports_collation()
		}
		'get_charset_collate' {
			return this.get_charset_collate()
		}
		'has_cap' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_cap(dispatch_arg_0))
		}
		'get_caller' {
			return this.get_caller()
		}
		'db_version' {
			return this.db_version()
		}
		'db_server_info' {
			return this.db_server_info()
		}
		else { return none }
	}
}

fn (this &Class_wpdb) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'show_errors' { return this.show_errors }
		'suppress_errors' { return this.suppress_errors }
		'last_error' { return this.last_error }
		'num_queries' { return this.num_queries }
		'num_rows' { return this.num_rows }
		'rows_affected' { return this.rows_affected }
		'insert_id' { return this.insert_id }
		'last_query' { return this.last_query }
		'last_result' { return this.last_result }
		'result' { return this.result }
		'col_meta' { return this.col_meta }
		'table_charset' { return this.table_charset }
		'check_current_query' { return rt.new_bool(this.check_current_query) }
		'checking_collation' { return rt.new_bool(this.checking_collation) }
		'col_info' { return this.col_info }
		'queries' { return this.queries }
		'reconnect_retries' { return this.reconnect_retries }
		'prefix' { return this.prefix }
		'base_prefix' { return this.base_prefix }
		'ready' { return rt.new_bool(this.ready) }
		'blogid' { return this.blogid }
		'siteid' { return this.siteid }
		'tables' { return this.tables }
		'old_tables' { return this.old_tables }
		'global_tables' { return this.global_tables }
		'ms_global_tables' { return this.ms_global_tables }
		'old_ms_global_tables' { return this.old_ms_global_tables }
		'comments' { return this.comments }
		'commentmeta' { return this.commentmeta }
		'links' { return this.links }
		'options' { return this.options }
		'postmeta' { return this.postmeta }
		'posts' { return this.posts }
		'terms' { return this.terms }
		'term_relationships' { return this.term_relationships }
		'term_taxonomy' { return this.term_taxonomy }
		'termmeta' { return this.termmeta }
		'usermeta' { return this.usermeta }
		'users' { return this.users }
		'blogs' { return this.blogs }
		'blogmeta' { return this.blogmeta }
		'registration_log' { return this.registration_log }
		'signups' { return this.signups }
		'site' { return this.site }
		'sitecategories' { return this.sitecategories }
		'sitemeta' { return this.sitemeta }
		'field_types' { return this.field_types }
		'charset' { return this.charset }
		'collate' { return this.collate }
		'dbuser' { return this.dbuser }
		'dbpassword' { return this.dbpassword }
		'dbname' { return this.dbname }
		'dbhost' { return this.dbhost }
		'dbh' { return this.dbh }
		'func_call' { return rt.new_string(this.func_call) }
		'is_mysql' { return rt.new_bool(this.is_mysql) }
		'incompatible_modes' { return this.incompatible_modes }
		'allow_unsafe_unquoted_parameters' { return this.allow_unsafe_unquoted_parameters }
		'use_mysqli' { return this.use_mysqli }
		'has_connected' { return rt.new_bool(this.has_connected) }
		'time_start' { return this.time_start }
		'error' { return this.error }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_wpdb) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'show_errors' { this.show_errors = val; return true }
		'suppress_errors' { this.suppress_errors = val; return true }
		'last_error' { this.last_error = val; return true }
		'num_queries' { this.num_queries = val; return true }
		'num_rows' { this.num_rows = val; return true }
		'rows_affected' { this.rows_affected = val; return true }
		'insert_id' { this.insert_id = val; return true }
		'last_query' { this.last_query = val; return true }
		'last_result' { this.last_result = val; return true }
		'result' { this.result = val; return true }
		'col_meta' { this.col_meta = val; return true }
		'table_charset' { this.table_charset = val; return true }
		'check_current_query' { this.check_current_query = (val).to_bool(); return true }
		'checking_collation' { this.checking_collation = (val).to_bool(); return true }
		'col_info' { this.col_info = val; return true }
		'queries' { this.queries = val; return true }
		'reconnect_retries' { this.reconnect_retries = val; return true }
		'prefix' { this.prefix = val; return true }
		'base_prefix' { this.base_prefix = val; return true }
		'ready' { this.ready = (val).to_bool(); return true }
		'blogid' { this.blogid = val; return true }
		'siteid' { this.siteid = val; return true }
		'tables' { this.tables = val; return true }
		'old_tables' { this.old_tables = val; return true }
		'global_tables' { this.global_tables = val; return true }
		'ms_global_tables' { this.ms_global_tables = val; return true }
		'old_ms_global_tables' { this.old_ms_global_tables = val; return true }
		'comments' { this.comments = val; return true }
		'commentmeta' { this.commentmeta = val; return true }
		'links' { this.links = val; return true }
		'options' { this.options = val; return true }
		'postmeta' { this.postmeta = val; return true }
		'posts' { this.posts = val; return true }
		'terms' { this.terms = val; return true }
		'term_relationships' { this.term_relationships = val; return true }
		'term_taxonomy' { this.term_taxonomy = val; return true }
		'termmeta' { this.termmeta = val; return true }
		'usermeta' { this.usermeta = val; return true }
		'users' { this.users = val; return true }
		'blogs' { this.blogs = val; return true }
		'blogmeta' { this.blogmeta = val; return true }
		'registration_log' { this.registration_log = val; return true }
		'signups' { this.signups = val; return true }
		'site' { this.site = val; return true }
		'sitecategories' { this.sitecategories = val; return true }
		'sitemeta' { this.sitemeta = val; return true }
		'field_types' { this.field_types = val; return true }
		'charset' { this.charset = val; return true }
		'collate' { this.collate = val; return true }
		'dbuser' { this.dbuser = val; return true }
		'dbpassword' { this.dbpassword = val; return true }
		'dbname' { this.dbname = val; return true }
		'dbhost' { this.dbhost = val; return true }
		'dbh' { this.dbh = val; return true }
		'func_call' { this.func_call = (val).str(); return true }
		'is_mysql' { this.is_mysql = (val).to_bool(); return true }
		'incompatible_modes' { this.incompatible_modes = val; return true }
		'allow_unsafe_unquoted_parameters' { this.allow_unsafe_unquoted_parameters = val; return true }
		'use_mysqli' { this.use_mysqli = val; return true }
		'has_connected' { this.has_connected = (val).to_bool(); return true }
		'time_start' { this.time_start = val; return true }
		'error' { this.error = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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



fn main() {
	defer {
		rt.shutdown()
	}

}
