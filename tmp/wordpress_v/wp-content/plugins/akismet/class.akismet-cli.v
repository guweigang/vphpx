import rt

struct Class_Akismet_CLI {
	rt.PhpObjectBase
}

fn (mut this Class_Akismet_CLI) check(var_args rt.PhpVal, var_assoc_args rt.PhpVal)  {
	{
		mut iter_1 := var_args.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_comment_id := item_1.val
			if var_assoc_args.array_isset(rt.new_string('noaction')) {
				mut var_api_response := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.check_db_comment(arg_0, arg_1) }(var_comment_id.dup(), rt.new_string('wp-cli'))
			} else {
				var_api_response = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.recheck_comment(arg_0, arg_1) }(var_comment_id.dup(), rt.new_string('wp-cli'))
			}
			if rt.is_true(rt.identical(rt.new_string('true'), var_api_response)) {
				fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Comment #%d is spam.'), rt.new_string('akismet')]), var_comment_id.dup()]))
			} else if rt.is_true(rt.identical(rt.new_string('false'), var_api_response)) {
				fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Comment #%d is not spam.'), rt.new_string('akismet')]), var_comment_id.dup()]))
			} else if rt.is_true(rt.identical(rt.new_bool(false), var_api_response)) {
				fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.call_function('__', [rt.new_string('Failed to connect to Akismet.'), rt.new_string('akismet')]))
			} else if rt.is_true(rt.call_function('is_wp_error', [var_api_response.dup()])) {
				fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.warning(arg_0) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Comment #%d could not be checked.'), rt.new_string('akismet')]), var_comment_id.dup()]))
			}
		}
	}
}

fn (mut this Class_Akismet_CLI) recheck_queue()  {
	mut var_batch_size := rt.new_int(rt.new_int(100))
	mut var_start := rt.new_int(rt.new_int(0))
	mut var_total_counts := rt.new_array()
	for {
		mut var_result_counts := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet_Admin{}; return temp.recheck_queue_portion(arg_0, arg_1) }(var_start.dup(), var_batch_size.dup())
		if rt.is_true(rt.greater(var_result_counts.array_get('processed'), rt.new_int(0))) {
			{
				mut iter_1 := var_result_counts.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_count := item_1.val
					mut var_key := item_1.key
					if !(var_total_counts.array_isset(var_key)) {
						var_total_counts.array_set(var_key, var_count.dup())
					} else {
						// unsupported expression: Expr_AssignOp_Plus
					}
				}
			}
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Minus
			// unsupported statement: Stmt_Nop
		}
		if !(rt.is_true(rt.greater(var_result_counts.array_get('processed'), rt.new_int(0)))) {
			break
		}
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Processed %d comment.'), rt.new_string('Processed %d comments.'), var_total_counts.array_get('processed'), rt.new_string('akismet')]), rt.call_function('number_format', [var_total_counts.array_get('processed')])]))
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%d comment moved to Spam.'), rt.new_string('%d comments moved to Spam.'), var_total_counts.array_get('spam'), rt.new_string('akismet')]), rt.call_function('number_format', [var_total_counts.array_get('spam')])]))
	if rt.is_true(var_total_counts.array_get('error')) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%d comment could not be checked.'), rt.new_string('%d comments could not be checked.'), var_total_counts.array_get('error'), rt.new_string('akismet')]), rt.call_function('number_format', [var_total_counts.array_get('error')])]))
	}
}

fn (mut this Class_Akismet_CLI) stats(var_args rt.PhpVal, var_assoc_args rt.PhpVal)  {
	mut var_api_key := fn () rt.PhpVal { mut temp := Class_Akismet{}; return temp.get_api_key() }()
	if !rt.is_true(var_api_key) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.call_function('__', [rt.new_string('API key must be set to fetch stats.'), rt.new_string('akismet')]))
	}
	mut switch_val_1 := var_args.array_get(0)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('days'))) {
		mut var_interval := rt.new_string(rt.new_string('60-days'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('months'))) {
		var_interval = rt.new_string(rt.new_string('6-months'))
	} else {
		var_interval = rt.new_string(rt.new_string('all'))
	}
	mut var_request_args := rt.create_array([rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [rt.new_string('home')]) }, rt.ArrayItem{ key: 'key', val: var_api_key }, rt.ArrayItem{ key: 'from', val: var_interval }])
	var_request_args = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_request_args.dup(), rt.new_string('get-stats')])
	mut var_response := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.http_post(arg_0, arg_1) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.build_query(arg_0) }(var_request_args.dup()), rt.new_string('get-stats'))
	if !rt.is_true(var_response.array_get(1)) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.call_function('__', [rt.new_string('Currently unable to fetch stats. Please try again.'), rt.new_string('akismet')]))
	}
	mut var_response_body := rt.call_function('json_decode', [var_response.array_get(1), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(var_response_body.dup().is_null())) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.call_function('__', [rt.new_string('Stats response could not be decoded.'), rt.new_string('akismet')]))
	}
	if var_assoc_args.array_isset(rt.new_string('summary')) {
		mut var_keys := ['spam', 'ham', 'missed_spam', 'false_positives', 'accuracy', 'time_saved']
		rt.call_function('WP_CLI\Utils\format_items', [var_assoc_args.array_get('format'), rt.create_array([rt.ArrayItem{ key: none, val: var_response_body }]), var_keys.dup()])
	} else {
		mut var_stats := var_response_body.array_get('breakdown')
		rt.call_function('WP_CLI\Utils\format_items', [var_assoc_args.array_get('format'), var_stats.dup(), rt.func_array_keys(rt.call_function('end', [var_stats.dup()]))])
	}
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_WP_CLI_Command {
	rt.PhpObjectBase
}

struct Class_Akismet {
	rt.PhpObjectBase
}

struct Class_Akismet_Admin {
	rt.PhpObjectBase
}

fn create_akismet_cli() &Class_Akismet_CLI {
	mut obj := &Class_Akismet_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli() &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli_command() &Class_WP_CLI_Command {
	mut obj := &Class_WP_CLI_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet() &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet_admin() &Class_Akismet_Admin {
	mut obj := &Class_Akismet_Admin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.check(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'recheck_queue' {
			this.recheck_queue()
			return rt.new_null()
		}
		'stats' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.stats(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Akismet_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_CLI_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Akismet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Akismet_Admin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet_Admin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Admin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_akismet_class_akismet_cli_php() {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string('akismet'), rt.new_string('Akismet_CLI'))
}
