import rt

struct Class_WP_Importer {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Importer) construct()  {
}

fn (mut this Class_WP_Importer) get_imported_posts(var_importer_name rt.PhpVal, var_blog_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_blog_id_mutated := var_blog_id
	// unsupported statement: Stmt_Global
	mut var_hashtable := rt.new_array()
	mut var_limit := rt.new_int(rt.new_int(100))
	mut var_offset := rt.new_int(rt.new_int(0))
	for {
		mut var_meta_key := rt.new_string((var_importer_name).str() + '_' + (var_blog_id_mutated).str() + '_permalink')
		mut var_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT post_id, meta_value FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = %s LIMIT %d,%d')), var_meta_key.dup(), var_offset.dup(), var_limit.dup()])])
		var_offset = rt.add(var_limit, var_offset)
		if !(!rt.is_true(var_results)) {
			{
				mut iter_1 := var_results.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_r := item_1.val
					var_hashtable.array_set(rt.get_property(var_r, 'meta_value'), // unsupported expression: Expr_Cast_Int)
				}
			}
		}
		if !(rt.is_true(rt.identical(rt.new_int(var_results.dup().array_count()), var_limit))) {
			break
		}
	}
	return var_hashtable.dup()
}

fn (mut this Class_WP_Importer) count_imported_posts(var_importer_name rt.PhpVal, var_blog_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_blog_id_mutated := var_blog_id
	// unsupported statement: Stmt_Global
	mut var_count := rt.new_int(rt.new_int(0))
	mut var_meta_key := rt.new_string((var_importer_name).str() + '_' + (var_blog_id_mutated).str() + '_permalink')
	mut var_result := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT COUNT( post_id ) AS cnt FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = %s')), var_meta_key.dup()])])
	if !(!rt.is_true(var_result)) {
		var_count = // unsupported expression: Expr_Cast_Int
	}
	return var_count.dup()
}

fn (mut this Class_WP_Importer) get_imported_comments(var_blog_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_comment_agent_blog_id := rt.new_null()
	mut var_blog_id_mutated := var_blog_id
	// unsupported statement: Stmt_Global
	mut var_hashtable := rt.new_array()
	mut var_limit := rt.new_int(rt.new_int(100))
	mut var_offset := rt.new_int(rt.new_int(0))
	for {
		mut var_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT comment_ID, comment_agent FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' LIMIT %d,%d')), var_offset.dup(), var_limit.dup()])])
		var_offset = rt.add(var_limit, var_offset)
		if !(!rt.is_true(var_results)) {
			{
				mut iter_1 := var_results.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_r := item_1.val
					// unsupported assign target: Expr_List
					mut var_source_comment_id := // unsupported expression: Expr_Cast_Int
					if rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int)) {
						var_hashtable.array_set(var_source_comment_id, // unsupported expression: Expr_Cast_Int)
					}
				}
			}
		}
		if !(rt.is_true(rt.identical(rt.new_int(var_results.dup().array_count()), var_limit))) {
			break
		}
	}
	return var_hashtable.dup()
}

fn (mut this Class_WP_Importer) set_blog(var_blog_id rt.PhpVal) rt.PhpVal {
	mut var_blog_id_mutated := var_blog_id
	if rt.is_true(rt.new_bool(var_blog_id_mutated.dup().is_long() || var_blog_id_mutated.dup().is_double())) {
		var_blog_id_mutated = // unsupported expression: Expr_Cast_Int
	} else {
		mut var_blog := rt.new_string('http://' + (rt.call_function('preg_replace', [rt.new_string('#^https?://#'), rt.new_string(''), var_blog_id_mutated.dup()])).str())
		mut var_parsed := rt.call_function('parse_url', [var_blog.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_parsed)))) || !rt.is_true(var_parsed.array_get('host')))) {
			rt.call_function('fwrite', [rt.get_constant('STDERR'), rt.new_string("Error: can not determine blog_id from ${var_blog_id.to_string()}\n")])
			// unsupported expression: Expr_Exit
		}
		if !rt.is_true(var_parsed.array_get('path')) {
			var_parsed.array_set('path', '/')
		}
		mut var_blogs := rt.call_function('get_sites', [rt.create_array([rt.ArrayItem{ key: 'domain', val: var_parsed.array_get('host') }, rt.ArrayItem{ key: 'number', val: 1 }, rt.ArrayItem{ key: 'path', val: var_parsed.array_get('path') }])])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_blogs)))) {
			rt.call_function('fwrite', [rt.get_constant('STDERR'), rt.new_string('Error: Could not find blog\n')])
			// unsupported expression: Expr_Exit
		}
		var_blog = rt.call_function('array_shift', [var_blogs.dup()])
		var_blog_id_mutated = // unsupported expression: Expr_Cast_Int
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('is_multisite')])) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			rt.call_function('switch_to_blog', [var_blog_id_mutated.dup()])
		}
	}
	return var_blog_id_mutated.dup()
}

fn (mut this Class_WP_Importer) set_user(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_user_id_mutated := var_user_id
	if rt.is_true(rt.new_bool(var_user_id_mutated.dup().is_long() || var_user_id_mutated.dup().is_double())) {
		var_user_id_mutated = // unsupported expression: Expr_Cast_Int
	} else {
		var_user_id_mutated = // unsupported expression: Expr_Cast_Int
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_user_id_mutated)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_set_current_user', [var_user_id_mutated.dup()]))))))) {
		rt.call_function('fwrite', [rt.get_constant('STDERR'), rt.new_string('Error: can not find user\n')])
		// unsupported expression: Expr_Exit
	}
	return var_user_id_mutated.dup()
}

fn (mut this Class_WP_Importer) cmpr_strlen(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	return var_b.dup().to_string().len - var_a.dup().to_string().len
}

fn (mut this Class_WP_Importer) get_page(var_url rt.PhpVal, username string, password string, head bool) rt.PhpVal {
	rt.call_function('add_filter', [rt.new_string('http_request_timeout'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Importer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'bump_request_timeout' }])])
	mut var_headers := rt.new_array()
	mut var_args := rt.new_array()
	if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(head))) {
		var_args.array_set('method', 'HEAD')
	}
	if !(username == '') && !(password == '') {
		var_headers['Authorization'] = 'Basic ' + (rt.call_function('base64_encode', [rt.new_string("${var_username}:${var_password}")])).str()
	}
	var_args.array_set('headers', var_headers.dup())
	return rt.call_function('wp_safe_remote_request', [var_url.dup(), var_args.dup()])
}

fn (mut this Class_WP_Importer) bump_request_timeout(var_val rt.PhpVal) i64 {
	return 60
}

fn (mut this Class_WP_Importer) is_user_over_quota() bool {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('upload_is_user_over_quota')])) {
		if rt.is_true(rt.call_function('upload_is_user_over_quota', []rt.PhpVal{})) {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Importer) min_whitespace(var_text rt.PhpVal) rt.PhpVal {
	return rt.call_function('preg_replace', [rt.new_string('|[\\r\\n\\t ]+|'), rt.new_string(' '), var_text.dup()])
}

fn (mut this Class_WP_Importer) stop_the_insanity()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.set_property(var_wpdb, 'queries', rt.new_array())
	mut var_wp_actions := rt.new_array()
}

fn get_cli_args(var_param rt.PhpVal, required bool) rt.PhpVal {
	mut var_match := []rt.PhpVal{}
	mut var_args := rt.get_superglobal('_SERVER').array_get('argv')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.dup().is_array()))))) {
		var_args = rt.new_array()
	}
	mut var_out := rt.new_array()
	mut var_last_arg := rt.new_null()
	mut var_return := rt.new_null()
	mut var_il := var_args.dup().array_count()
	{
		mut var_i := 1
		rt.new_int(var_il)
		for {
			if !(var_i < var_il) { break }
			if rt.is_true(// unsupported expression: Expr_Cast_Bool) {
				mut var_parts := rt.call_function('explode', [rt.new_string('='), var_match.array_get(1)])
				mut var_key := rt.call_function('preg_replace', [rt.new_string('/[^a-z0-9]+/'), rt.new_string(''), var_parts.array_get(0)])
				var_out.array_set(var_key, if !(var_parts.array_get(1)).is_null() { var_parts.array_get(1) } else { rt.new_bool(true) })
				var_last_arg = var_key.dup()
			} else if rt.is_true(// unsupported expression: Expr_Cast_Bool) {
				{
					mut var_j := 0
					mut var_jl := var_match.array_get(1).to_string().len
					for {
						if !(var_j < var_jl) { break }
						var_key = var_match.array_get(1).array_get(var_j)
						var_out.array_set(var_key, true)
						var_j += 1
					}
				}
				mut var_last_arg := var_key.dup()
			} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_out.array_set(var_last_arg, var_args.array_get(var_i))
			}
			var_i += 1
		}
	}
	if var_out.array_isset(var_param) {
		mut var_return := var_out.array_get(var_param)
	}
	if !(var_out.array_isset(var_param)) && var_required {
		print("\"${var_param.to_string()}\" parameter is required but was not specified\n")
		// unsupported expression: Expr_Exit
	}
	return var_return.dup()
}

fn create_wp_importer() &Class_WP_Importer {
	mut obj := &Class_WP_Importer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn (mut this Class_WP_Importer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_imported_posts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_imported_posts(dispatch_arg_0, dispatch_arg_1)
		}
		'count_imported_posts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.count_imported_posts(dispatch_arg_0, dispatch_arg_1)
		}
		'get_imported_comments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_imported_comments(dispatch_arg_0)
		}
		'set_blog' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_blog(dispatch_arg_0)
		}
		'set_user' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_user(dispatch_arg_0)
		}
		'cmpr_strlen' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.cmpr_strlen(dispatch_arg_0, dispatch_arg_1))
		}
		'get_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.get_page(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'bump_request_timeout' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.bump_request_timeout(dispatch_arg_0))
		}
		'is_user_over_quota' {
			return rt.new_bool(this.is_user_over_quota())
		}
		'min_whitespace' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.min_whitespace(dispatch_arg_0)
		}
		'stop_the_insanity' {
			this.stop_the_insanity()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Importer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Importer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_admin_includes_class_wp_importer_php() {
}
