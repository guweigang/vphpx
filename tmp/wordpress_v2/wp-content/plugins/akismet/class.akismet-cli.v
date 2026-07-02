import rt

struct Class_Akismet_CLI {
	rt.PhpObjectBase
}

mut iife_temp_0 := Class_WP_CLI{}
mut iife_result_0 := iife_temp_0.add_command(rt.new_string('akismet'), rt.new_string('Akismet_CLI'))
fn (mut this Class_Akismet_CLI) check(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut iter_1 := var_args.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_comment_id := item_1.val
		if var_assoc_args.array_isset(rt.new_string('noaction')) {
		mut iife_temp_1 := Class_Akismet{}
		mut iife_result_1 := iife_temp_1.check_db_comment(var_comment_id.clone(), rt.new_string('wp-cli'))
		mut var_api_response := iife_result_1
		} else {
		mut iife_temp_2 := Class_Akismet{}
		mut iife_result_2 := iife_temp_2.recheck_comment(var_comment_id.clone(), rt.new_string('wp-cli'))
		var_api_response = iife_result_2
		}
		if rt.is_true(rt.identical(rt.new_string('true'), var_api_response)) {
		mut iife_temp_3 := Class_WP_CLI{}
		mut iife_result_3 := iife_temp_3.line(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Comment #%d is spam.'), rt.new_string('akismet')]), var_comment_id.clone()]))
		} else if rt.is_true(rt.identical(rt.new_string('false'), var_api_response)) {
		mut iife_temp_4 := Class_WP_CLI{}
		mut iife_result_4 := iife_temp_4.line(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Comment #%d is not spam.'), rt.new_string('akismet')]), var_comment_id.clone()]))
		} else if rt.is_true(rt.identical(rt.new_bool(false), var_api_response)) {
		mut iife_temp_5 := Class_WP_CLI{}
		mut iife_result_5 := iife_temp_5.error(rt.call_function('__', [rt.new_string('Failed to connect to Akismet.'), rt.new_string('akismet')]))
		} else if rt.is_true(rt.call_function('is_wp_error', [var_api_response.clone()])) {
		mut iife_temp_6 := Class_WP_CLI{}
		mut iife_result_6 := iife_temp_6.warning(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Comment #%d could not be checked.'), rt.new_string('akismet')]), var_comment_id.clone()]))
		}
	}
}

fn (mut this Class_Akismet_CLI) recheck_queue() {
	mut var_batch_size := rt.new_int(100)
	mut var_start := rt.new_int(0)
	mut var_total_counts := rt.new_array()
	for {
		mut iife_temp_7 := Class_Akismet_Admin{}
		mut iife_result_7 := iife_temp_7.recheck_queue_portion(var_start.clone(), var_batch_size.clone())
		mut var_result_counts := iife_result_7
		if rt.is_true(rt.greater(var_result_counts.array_get(rt.new_string('processed')), rt.new_int(0))) {
			mut iter_2 := var_result_counts.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_count := item_2.val
				mut var_key := item_2.key
				if !(var_total_counts.array_isset(var_key)) {
					var_total_counts.array_set(var_key, var_count.clone())
				} else {
					var_total_counts.array_get(var_key) = rt.add(var_total_counts.array_get(var_key), var_count)
				}
			}
			var_start = rt.add(var_start, var_batch_size)
			var_start = rt.sub(var_start, var_result_counts.array_get(rt.new_string('spam')))
		}
		if !(rt.is_true(rt.greater(var_result_counts.array_get(rt.new_string('processed')), rt.new_int(0)))) {
			break
		}
	}
	mut iife_temp_8 := Class_WP_CLI{}
	mut iife_result_8 := iife_temp_8.line(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Processed %d comment.'), rt.new_string('Processed %d comments.'), var_total_counts.array_get(rt.new_string('processed')), rt.new_string('akismet')]), rt.call_function('number_format', [var_total_counts.array_get(rt.new_string('processed'))])]))
	mut iife_temp_9 := Class_WP_CLI{}
	mut iife_result_9 := iife_temp_9.line(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%d comment moved to Spam.'), rt.new_string('%d comments moved to Spam.'), var_total_counts.array_get(rt.new_string('spam')), rt.new_string('akismet')]), rt.call_function('number_format', [var_total_counts.array_get(rt.new_string('spam'))])]))
	if rt.is_true(var_total_counts.array_get(rt.new_string('error'))) {
	mut iife_temp_10 := Class_WP_CLI{}
	mut iife_result_10 := iife_temp_10.line(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%d comment could not be checked.'), rt.new_string('%d comments could not be checked.'), var_total_counts.array_get(rt.new_string('error')), rt.new_string('akismet')]), rt.call_function('number_format', [var_total_counts.array_get(rt.new_string('error'))])]))
	}
}

fn (mut this Class_Akismet_CLI) stats(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut iife_temp_11 := Class_Akismet{}
	mut iife_result_11 := iife_temp_11.get_api_key()
	mut var_api_key := iife_result_11
	if !rt.is_true(var_api_key) {
	mut iife_temp_12 := Class_WP_CLI{}
	mut iife_result_12 := iife_temp_12.error(rt.call_function('__', [rt.new_string('API key must be set to fetch stats.'), rt.new_string('akismet')]))
	}
	mut switch_val_1 := var_args.array_get(rt.new_int(0))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('days'))) {
	mut var_interval := rt.new_string('60-days')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('months'))) {
	var_interval = rt.new_string('6-months')
	} else {
	var_interval = rt.new_string('all')
	}
	mut var_request_args := rt.create_array([rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [rt.new_string('home')]) }, rt.ArrayItem{ key: 'key', val: var_api_key }, rt.ArrayItem{ key: 'from', val: var_interval }])
	var_request_args = rt.call_function('apply_filters', [rt.new_string('akismet_request_args'), var_request_args.clone(), rt.new_string('get-stats')])
	mut iife_temp_13 := Class_Akismet{}
	mut iife_result_13 := iife_temp_13.build_query(var_request_args.clone())
	mut iife_temp_14 := Class_Akismet{}
	mut iife_result_14 := iife_temp_14.http_post(iife_result_13, rt.new_string('get-stats'))
	mut var_response := iife_result_14
	if !rt.is_true(var_response.array_get(rt.new_int(1))) {
	mut iife_temp_15 := Class_WP_CLI{}
	mut iife_result_15 := iife_temp_15.error(rt.call_function('__', [rt.new_string('Currently unable to fetch stats. Please try again.'), rt.new_string('akismet')]))
	}
	mut var_response_body := rt.call_function('json_decode', [var_response.array_get(rt.new_int(1)), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(var_response_body.clone().is_null())) {
	mut iife_temp_16 := Class_WP_CLI{}
	mut iife_result_16 := iife_temp_16.error(rt.call_function('__', [rt.new_string('Stats response could not be decoded.'), rt.new_string('akismet')]))
	}
	if var_assoc_args.array_isset(rt.new_string('summary')) {
		mut var_keys := ['spam', 'ham', 'missed_spam', 'false_positives', 'accuracy', 'time_saved']
		rt.call_function('WP_CLI\Utils\format_items', [var_assoc_args.array_get(rt.new_string('format')), rt.create_array([rt.ArrayItem{ key: none, val: var_response_body }]), rt.create_array_from_list(var_keys)])
	} else {
		mut var_stats := var_response_body.array_get(rt.new_string('breakdown'))
		rt.call_function('WP_CLI\Utils\format_items', [var_assoc_args.array_get(rt.new_string('format')), var_stats.clone(), rt.func_array_keys(rt.call_function('end', [var_stats.clone()]))])
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

fn create_akismet_cli(_args ...rt.PhpVal) &Class_Akismet_CLI {
	mut obj := &Class_Akismet_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli(_args ...rt.PhpVal) &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli_command(_args ...rt.PhpVal) &Class_WP_CLI_Command {
	mut obj := &Class_WP_CLI_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet(_args ...rt.PhpVal) &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet_admin(_args ...rt.PhpVal) &Class_Akismet_Admin {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
