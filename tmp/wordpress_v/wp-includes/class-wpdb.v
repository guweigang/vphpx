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

fn (mut this Class_wpdb) construct(var_dbuser rt.PhpVal, var_dbpassword rt.PhpVal, var_dbname rt.PhpVal, var_dbhost rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY')))) {
		this.show_errors(false)
	}
	this.dbuser = var_dbuser.dup()
	this.dbpassword = var_dbpassword.dup()
	this.dbname = var_dbname.dup()
	this.dbhost = var_dbhost.dup()
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

fn (mut this Class_wpdb) magic_set(var_name rt.PhpVal, var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	mut var_protected_members := ['col_meta', 'table_charset', 'check_current_query', 'allow_unsafe_unquoted_parameters']
	if rt.is_true(rt.call_function('in_array', [var_name.dup(), var_protected_members.dup(), rt.new_bool(true)])) {
		return rt.new_null()
	}
	this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":809,"name":"name"}', var_value_mutated.dup())
}

fn (mut this Class_wpdb) magic_isset(var_name rt.PhpVal) rt.PhpVal {
	return rt.new_bool(!(rt.get_property(rt.new_object('wpdb', []string{}, &this), '{"nodeType":"Expr_Variable","line":821,"name":"name"}')).is_null())
}

fn (mut this Class_wpdb) magic_unset(var_name rt.PhpVal)  {
	rt.get_property(rt.new_object('wpdb', []string{}, &this), '{"nodeType":"Expr_Variable","line":832,"name":"name"}') = rt.new_null()
}

fn (mut this Class_wpdb) init_charset()  {
	mut var_charset := rt.new_string(rt.new_string(''))
	mut var_collate := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_multisite')])) && rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))) {
		var_charset = rt.new_string(rt.new_string('utf8'))
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('DB_COLLATE')])) && rt.is_true(rt.get_constant('DB_COLLATE')))) {
			var_collate = rt.get_constant('DB_COLLATE')
		} else {
			var_collate = rt.new_string(rt.new_string('utf8_general_ci'))
		}
	} else if rt.is_true(rt.call_function('defined', [rt.new_string('DB_COLLATE')])) {
		var_collate = rt.get_constant('DB_COLLATE')
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('DB_CHARSET')])) {
		var_charset = rt.get_constant('DB_CHARSET')
	}
	mut var_charset_collate := this.determine_charset(var_charset.dup(), var_collate.dup())
	this.charset = var_charset_collate.array_get('charset')
	this.collate = var_charset_collate.array_get('collate')
}

fn (mut this Class_wpdb) determine_charset(var_charset rt.PhpVal, var_collate rt.PhpVal) rt.PhpVal {
	mut var_charset_mutated := var_charset
	mut var_collate_mutated := var_collate
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.dbh, 'mysqli')))))) || !rt.is_true(this.dbh))) {
		return rt.call_function('compact', [rt.new_string('charset'), rt.new_string('collate')])
	}
	if rt.is_true(rt.identical(rt.new_string('utf8'), var_charset_mutated)) {
		var_charset_mutated = rt.new_string(rt.new_string('utf8mb4'))
	}
	if rt.is_true(rt.identical(rt.new_string('utf8mb4'), var_charset_mutated)) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_collate_mutated)))) || rt.is_true(rt.identical(rt.new_string('utf8_general_ci'), var_collate_mutated)))) {
			var_collate_mutated = rt.new_string(rt.new_string('utf8mb4_unicode_ci'))
		} else {
			var_collate_mutated = rt.call_function('str_replace', [rt.new_string('utf8_'), rt.new_string('utf8mb4_'), var_collate_mutated.dup()])
		}
	}
	if rt.is_true(rt.new_bool(this.has_cap(rt.new_string('utf8mb4_520')) && rt.is_true(rt.identical(rt.new_string('utf8mb4_unicode_ci'), var_collate_mutated)))) {
		var_collate_mutated = rt.new_string(rt.new_string('utf8mb4_unicode_520_ci'))
	}
	return rt.call_function('compact', [rt.new_string('charset'), rt.new_string('collate')])
}

fn (mut this Class_wpdb) set_charset(var_dbh rt.PhpVal, var_charset rt.PhpVal, var_collate rt.PhpVal)  {
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
		mut var_set_charset_succeeded := rt.new_bool(rt.new_bool(true))
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('mysqli_set_charset')])) && this.has_cap(rt.new_string('set_charset')))) {
			var_set_charset_succeeded = rt.call_function('mysqli_set_charset', [var_dbh_mutated.dup(), var_charset_mutated.dup()])
		}
		if rt.is_true(var_set_charset_succeeded) {
			mut var_query := rt.new_string(this.prepare(rt.new_string('SET NAMES %s'), var_charset_mutated.dup()))
			if !(!rt.is_true(var_collate_mutated)) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			rt.call_function('mysqli_query', [var_dbh_mutated.dup(), var_query.dup()])
		}
	}
}

fn (mut this Class_wpdb) set_sql_mode(var_modes rt.PhpVal)  {
	mut var_modes_mutated := var_modes
	if !rt.is_true(var_modes_mutated) {
		mut var_res := rt.call_function('mysqli_query', [this.dbh, rt.new_string('SELECT @@SESSION.sql_mode')])
		if !rt.is_true(var_res) {
			return rt.new_null()
		}
		mut var_modes_array := rt.call_function('mysqli_fetch_array', [var_res.dup()])
		if !rt.is_true(var_modes_array.array_get(0)) {
			return rt.new_null()
		}
		var_modes_mutated = rt.call_function('explode', [rt.new_string(','), var_modes_array.array_get(0)])
	}
	var_modes_mutated = rt.call_function('array_change_key_case', [var_modes_mutated.dup(), rt.get_constant('CASE_UPPER')])
	mut var_incompatible_modes := rt.cast_array(rt.call_function('apply_filters', [rt.new_string('incompatible_sql_modes'), this.incompatible_modes]))
	{
		mut iter_1 := var_modes_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_mode := item_1.val
			mut var_i := item_1.key
			if rt.is_true(rt.call_function('in_array', [var_mode.dup(), var_incompatible_modes.dup(), rt.new_bool(true)])) {
				var_modes_mutated.array_unset(var_i)
			}
		}
	}
	mut var_modes_str := rt.call_function('implode', [rt.new_string(','), var_modes_mutated.dup()])
	rt.call_function('mysqli_query', [this.dbh, rt.new_string("SET SESSION sql_mode='${var_modes_str.to_string()}'")])
}

fn (mut this Class_wpdb) set_prefix(var_prefix rt.PhpVal, set_table_names bool) rt.PhpVal {
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('|[^a-z0-9_]|i'), var_prefix.dup()])) {
		return create_wp_error(rt.new_string('invalid_db_prefix'), rt.new_string('Invalid database prefix'))
	}
	mut var_old_prefix := if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.new_string('') } else { var_prefix }
	if !(this.base_prefix).is_null() {
		var_old_prefix = this.base_prefix
	}
	this.base_prefix = var_prefix.dup()
	if var_set_table_names {
		{
			mut iter_1 := this.tables('global', false, 0).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_prefixed_table := item_1.val
				mut var_table := item_1.key
				this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":1014,"name":"table"}', var_prefixed_table.dup())
			}
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && !rt.is_true(this.blogid))) {
			return var_old_prefix.dup()
		}
		this.prefix = this.get_blog_prefix(rt.new_null())
		{
			mut iter_1 := this.tables('blog', false, 0).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_prefixed_table := item_1.val
				mut var_table := item_1.key
				this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":1024,"name":"table"}', var_prefixed_table.dup())
			}
		}
		{
			mut iter_1 := this.tables('old', false, 0).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_prefixed_table := item_1.val
				mut var_table := item_1.key
				this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":1028,"name":"table"}', var_prefixed_table.dup())
			}
		}
	}
	return var_old_prefix.dup()
}

fn (mut this Class_wpdb) set_blog_id(var_blog_id rt.PhpVal, network_id i64) rt.PhpVal {
	mut var_blog_id_mutated := var_blog_id
	if !(network_id == 0) {
		this.siteid = rt.new_int(network_id).dup()
	}
	mut var_old_blog_id := this.blogid
	this.blogid = var_blog_id_mutated.dup()
	this.prefix = this.get_blog_prefix(rt.new_null())
	{
		mut iter_1 := this.tables('blog', false, 0).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_prefixed_table := item_1.val
			mut var_table := item_1.key
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":1054,"name":"table"}', var_prefixed_table.dup())
		}
	}
	{
		mut iter_1 := this.tables('old', false, 0).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_prefixed_table := item_1.val
			mut var_table := item_1.key
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":1058,"name":"table"}', var_prefixed_table.dup())
		}
	}
	return var_old_blog_id.dup()
}

fn (mut this Class_wpdb) get_blog_prefix(var_blog_id rt.PhpVal) string {
	mut var_blog_id_mutated := var_blog_id
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		if rt.is_true(rt.identical(rt.new_null(), var_blog_id_mutated)) {
			var_blog_id_mutated = this.blogid
		}
		var_blog_id_mutated = // unsupported expression: Expr_Cast_Int
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('MULTISITE')])) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), var_blog_id_mutated)) || rt.is_true(rt.identical(rt.new_int(1), var_blog_id_mutated)))))) {
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
			var_tables = rt.call_function('array_merge', [var_tables.dup(), this.ms_global_tables])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('blog'))) {
		var_tables = this.tables
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('global'))) {
		var_tables = this.global_tables
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_tables = rt.call_function('array_merge', [var_tables.dup(), this.ms_global_tables])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('ms_global'))) {
		var_tables = this.ms_global_tables
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('old'))) {
		var_tables = this.old_tables
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_tables = rt.call_function('array_merge', [var_tables.dup(), this.old_ms_global_tables])
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
		{
			mut iter_1 := var_tables.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_table := item_1.val
				mut var_k := item_1.key
				if rt.is_true(rt.call_function('in_array', [.dup(), .dup(), ])) {
					
				} else {
				}
				.array_unset()
			}
		}
	}
	return .dup()
}

fn (mut this Class_wpdb) select(var_db rt.PhpVal, var_dbh rt.PhpVal)  {
	mut var_dbh_mutated := var_dbh
}

fn (mut this Class_wpdb) _weak_escape(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
}

fn (mut this Class_wpdb) _real_escape(var_data rt.PhpVal) string {
	mut var_data_mutated := var_data
}

fn (mut this Class_wpdb) _escape(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
}

fn (mut this Class_wpdb) escape(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
}

fn (mut this Class_wpdb) escape_by_ref(var_data rt.PhpVal)  {
	mut var_data_mutated := var_data
}

fn (mut this Class_wpdb) quote_identifier(var_identifier rt.PhpVal) string {
}

fn (mut this Class_wpdb) _escape_identifier_value(var_identifier rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_wpdb) prepare(var_query rt.PhpVal, var_args rt.PhpVal) string {
	mut var_query_mutated := var_query
	mut var_args_mutated := var_args
}

fn (mut this Class_wpdb) esc_like(var_text rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_wpdb) print_error(str string) bool {
	mut var_EZSQL_ERROR := []rt.PhpVal{}
	mut str_mutated := str
	return false
}

fn (mut this Class_wpdb) show_errors(show bool) rt.PhpVal {
	mut show_mutated := show
}

fn (mut this Class_wpdb) hide_errors() rt.PhpVal {
}

fn (mut this Class_wpdb) suppress_errors(suppress bool) rt.PhpVal {
}

fn (mut this Class_wpdb) flush()  {
}

fn (mut this Class_wpdb) db_connect(allow_bail bool) bool {
}

fn (mut this Class_wpdb) parse_db_host(var_host rt.PhpVal) rt.PhpVal {
	mut var_host_mutated := var_host
}

fn (mut this Class_wpdb) check_connection(allow_bail bool) bool {
	return false
}

fn (mut this Class_wpdb) query(var_query rt.PhpVal) bool {
	mut var_query_mutated := var_query
}

fn (mut this Class_wpdb) _do_query(var_query rt.PhpVal)  {
	mut var_query_mutated := var_query
}

fn (mut this Class_wpdb) log_query(var_query rt.PhpVal, var_query_time rt.PhpVal, var_query_callstack rt.PhpVal, var_query_start rt.PhpVal, var_query_data rt.PhpVal)  {
	mut var_query_mutated := var_query
	mut var_query_data_mutated := var_query_data
}

fn (mut this Class_wpdb) placeholder_escape() rt.PhpVal {
}

fn (mut this Class_wpdb) add_placeholder_escape(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
}

fn (mut this Class_wpdb) remove_placeholder_escape(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
}

fn (mut this Class_wpdb) insert(var_table rt.PhpVal, var_data rt.PhpVal, var_format rt.PhpVal) rt.PhpVal {
	mut var_table_mutated := var_table
	mut var_data_mutated := var_data
	mut var_format_mutated := var_format
}

fn (mut this Class_wpdb) replace(var_table rt.PhpVal, var_data rt.PhpVal, var_format rt.PhpVal) rt.PhpVal {
	mut var_table_mutated := var_table
	mut var_data_mutated := var_data
	mut var_format_mutated := var_format
}

fn (mut this Class_wpdb) _insert_replace_helper(var_table rt.PhpVal, var_data rt.PhpVal, var_format rt.PhpVal, type string) bool {
	mut var_table_mutated := var_table
	mut var_data_mutated := var_data
	mut var_format_mutated := var_format
	mut type_mutated := type
}

fn (mut this Class_wpdb) update(var_table rt.PhpVal, var_data rt.PhpVal, var_where rt.PhpVal, var_format rt.PhpVal, var_where_format rt.PhpVal) bool {
	mut var_table_mutated := var_table
	mut var_data_mutated := var_data
	mut var_where_mutated := var_where
	mut var_format_mutated := var_format
}

fn (mut this Class_wpdb) delete(var_table rt.PhpVal, var_where rt.PhpVal, var_where_format rt.PhpVal) bool {
	mut var_table_mutated := var_table
	mut var_where_mutated := var_where
}

fn (mut this Class_wpdb) process_fields(var_table rt.PhpVal, var_data rt.PhpVal, var_format rt.PhpVal) bool {
	mut var_table_mutated := var_table
	mut var_data_mutated := var_data
	mut var_format_mutated := var_format
}

fn (mut this Class_wpdb) process_field_formats(var_data rt.PhpVal, var_format rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_format_mutated := var_format
}

fn (mut this Class_wpdb) process_field_charsets(var_data rt.PhpVal, var_table rt.PhpVal) bool {
	mut var_data_mutated := var_data
	mut var_table_mutated := var_table
}

fn (mut this Class_wpdb) process_field_lengths(var_data rt.PhpVal, var_table rt.PhpVal) bool {
	mut var_data_mutated := var_data
	mut var_table_mutated := var_table
}

fn (mut this Class_wpdb) get_var(var_query rt.PhpVal, x i64, y i64) rt.PhpVal {
	mut var_query_mutated := var_query
}

fn (mut this Class_wpdb) get_row(var_query rt.PhpVal, var_output rt.PhpVal, y i64) rt.PhpVal {
	mut var_query_mutated := var_query
	return rt.new_null()
}

fn (mut this Class_wpdb) get_col(var_query rt.PhpVal, x i64) rt.PhpVal {
	mut var_query_mutated := var_query
}

fn (mut this Class_wpdb) get_results(var_query rt.PhpVal, var_output rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
}

fn (mut this Class_wpdb) get_table_charset(var_table rt.PhpVal) string {
	mut var_type := rt.new_null()
	mut var_table_mutated := var_table
}

fn (mut this Class_wpdb) get_col_charset(var_table rt.PhpVal, var_column rt.PhpVal) bool {
	mut var_table_mutated := var_table
}

fn (mut this Class_wpdb) get_col_length(var_table rt.PhpVal, var_column rt.PhpVal) bool {
	mut var_table_mutated := var_table
	return false
}

fn (mut this Class_wpdb) check_ascii(var_input_string rt.PhpVal) bool {
}

fn (mut this Class_wpdb) check_safe_collation(var_query rt.PhpVal) bool {
	mut var_query_mutated := var_query
}

fn (mut this Class_wpdb) strip_invalid_text(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
}

fn (mut this Class_wpdb) strip_invalid_text_from_query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
}

fn (mut this Class_wpdb) strip_invalid_text_for_column(var_table rt.PhpVal, var_column rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_table_mutated := var_table
	mut var_value_mutated := var_value
}

fn (mut this Class_wpdb) get_table_from_query(var_query rt.PhpVal) bool {
	mut var_maybe := []rt.PhpVal{}
	mut var_query_mutated := var_query
}

fn (mut this Class_wpdb) load_col_info()  {
}

fn (mut this Class_wpdb) get_col_info(info_type string, var_col_offset rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_wpdb) timer_start() bool {
}

fn (mut this Class_wpdb) timer_stop() rt.PhpVal {
}

fn (mut this Class_wpdb) bail(var_message rt.PhpVal, error_code string) bool {
	mut var_message_mutated := var_message
	return false
}

fn (mut this Class_wpdb) close() bool {
}

fn (mut this Class_wpdb) check_database_version() rt.PhpVal {
	mut var_required_mysql_version := rt.new_null()
	return rt.new_null()
}

fn (mut this Class_wpdb) supports_collation() rt.PhpVal {
}

fn (mut this Class_wpdb) get_charset_collate() rt.PhpVal {
}

fn (mut this Class_wpdb) has_cap(var_db_cap rt.PhpVal) bool {
}

fn (mut this Class_wpdb) get_caller() rt.PhpVal {
}

fn (mut this Class_wpdb) db_version() rt.PhpVal {
}

fn (mut this Class_wpdb) db_server_info() rt.PhpVal {
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

fn create_wp_error() &Class_WP_Error {
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
			return rt.new_bool(this.get_col_length(dispatch_arg_0, dispatch_arg_1))
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




pub fn init_wp_includes_class_wpdb_php() {
}
