import rt

fn check_comment(var_author rt.PhpVal, var_email rt.PhpVal, var_url rt.PhpVal, var_comment rt.PhpVal, var_user_ip rt.PhpVal, var_user_agent rt.PhpVal, var_comment_type rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_out := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(rt.new_string('1'), rt.call_function('get_option', [rt.new_string('comment_moderation')]))) {
		return false
	}
	var_comment = rt.call_function('apply_filters', [rt.new_string('comment_text'), var_comment.dup(), rt.new_null(), rt.new_array()])
	mut var_max_links := rt.call_function('get_option', [rt.new_string('comment_max_links')])
	if rt.is_true(var_max_links) {
		mut var_num_links := rt.call_function('preg_match_all', [rt.new_string('/<a [^>]*href/i'), var_comment.dup(), var_out.dup()])
		var_num_links = rt.call_function('apply_filters', [rt.new_string('comment_max_links_url'), var_num_links.dup(), var_url.dup(), var_comment.dup()])
		if rt.is_true(rt.greater_equal(var_num_links, var_max_links)) {
			return false
		}
	}
	mut var_mod_keys := rt.call_function('get_option', [rt.new_string('moderation_keys')]).to_string().trim_space()
	if !(var_mod_keys == '') {
		mut var_words := rt.call_function('explode', [rt.new_string('\n'), rt.new_string(var_mod_keys).dup()])
		{
			mut iter_1 := rt.cast_array(var_words).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_word := item_1.val
				var_word = rt.new_string(rt.new_string(var_word.dup().to_string().trim_space()))
				if !rt.is_true(var_word) {
					continue
				}
				var_word = rt.call_function('preg_quote', [var_word.dup(), rt.new_string('#')])
				mut var_pattern := "#${var_word.to_string()}#iu"
				if rt.is_true(rt.call_function('preg_match', [rt.new_string(var_pattern).dup(), var_author.dup()])) {
					return false
				}
				if rt.is_true(rt.call_function('preg_match', [rt.new_string(var_pattern).dup(), var_email.dup()])) {
					return false
				}
				if rt.is_true(rt.call_function('preg_match', [rt.new_string(var_pattern).dup(), var_url.dup()])) {
					return false
				}
				if rt.is_true(rt.call_function('preg_match', [rt.new_string(var_pattern).dup(), var_comment.dup()])) {
					return false
				}
				if rt.is_true(rt.call_function('preg_match', [rt.new_string(var_pattern).dup(), var_user_ip.dup()])) {
					return false
				}
				if rt.is_true(rt.call_function('preg_match', [rt.new_string(var_pattern).dup(), var_user_agent.dup()])) {
					return false
				}
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_string('1'), rt.call_function('get_option', [rt.new_string('comment_previously_approved')]))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			mut var_comment_user := rt.call_function('get_user_by', [rt.new_string('email'), rt.call_function('wp_unslash', [var_email.dup()])])
			if !(!rt.is_true(rt.get_property(var_comment_user, 'ID'))) {
				mut var_ok_to_comment := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT comment_approved\n\t\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string('\n\t\t\t\t\t\tWHERE user_id = %d\n\t\t\t\t\t\tAND comment_approved = \'1\'\n\t\t\t\t\t\tLIMIT 1')), rt.get_property(var_comment_user, 'ID')])])
			} else {
				var_ok_to_comment = rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT comment_approved\n\t\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string('\n\t\t\t\t\t\tWHERE comment_author = %s\n\t\t\t\t\t\tAND comment_author_email = %s\n\t\t\t\t\t\tAND comment_approved = \'1\'\n\t\t\t\t\t\tLIMIT 1')), var_author.dup(), var_email.dup()])])
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('1'), var_ok_to_comment)) && rt.is_true(rt.new_bool(var_mod_keys == '' || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_email.dup(), rt.new_string(var_mod_keys).dup()]))))))))) {
				return true
			} else {
				return false
			}
		} else {
			return false
		}
	}
	return true
}

fn get_approved_comments(var_post_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return rt.new_array()
	}
	mut var_defaults := { 'status': rt.new_int(1), 'post_id': var_post_id, 'order': rt.new_string('ASC') }
	mut var_parsed_args := rt.call_function('wp_parse_args', [var_args.dup(), var_defaults.dup()])
	mut var_query := create_wp_comment_query()
	return var_query.query(var_parsed_args.dup())
}

fn get_comment(var_comment rt.PhpVal, var_output rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	if !rt.is_true(var_comment) && var_GLOBALS.array_isset(rt.new_string('comment')) {
		var_comment = var_GLOBALS.array_get('comment')
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_comment, 'WP_Comment'))) {
		mut var__comment := var_comment.dup()
	} else if rt.is_true(rt.new_bool(var_comment.dup().is_object())) {
		var__comment = create_wp_comment(var_comment.dup())
	} else {
		var__comment = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Comment{}; return temp.get_instance(arg_0) }(var_comment.dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var__comment)))) {
		return rt.new_null()
	}
	var__comment = rt.call_function('apply_filters', [rt.new_string('get_comment'), var__comment.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var__comment, 'WP_Comment')))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.get_constant('OBJECT'), var_output)) {
		return var__comment.dup()
	} else if rt.is_true(rt.identical(rt.get_constant('ARRAY_A'), var_output)) {
		return rt.call_method(var__comment, 'to_array', []rt.PhpVal{})
	} else if rt.is_true(rt.identical(rt.get_constant('ARRAY_N'), var_output)) {
		return rt.call_function('array_values', [rt.call_method(var__comment, 'to_array', []rt.PhpVal{})])
	}
	return var__comment.dup()
}

fn get_comments(args string) rt.PhpVal {
	mut var_query := create_wp_comment_query()
	return var_query.query(rt.new_string(args))
}

fn get_comment_statuses() rt.PhpVal {
	mut var_status := rt.create_array([rt.ArrayItem{ key: 'hold', val: rt.call_function('__', [rt.new_string('Unapproved')]) }, rt.ArrayItem{ key: 'approve', val: rt.call_function('_x', [rt.new_string('Approved'), rt.new_string('comment status')]) }, rt.ArrayItem{ key: 'spam', val: rt.call_function('_x', [rt.new_string('Spam'), rt.new_string('comment status')]) }, rt.ArrayItem{ key: 'trash', val: rt.call_function('_x', [rt.new_string('Trash'), rt.new_string('comment status')]) }])
	return var_status.dup()
}

fn get_default_comment_status(post_type string, comment_type string) rt.PhpVal {
	mut switch_val_1 := rt.new_string(comment_type)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('pingback'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('trackback'))) {
		mut var_supports := rt.new_string(rt.new_string('trackbacks'))
		mut var_option := rt.new_string(rt.new_string('ping'))
	} else {
		var_supports = rt.new_string(rt.new_string('comments'))
		var_option = rt.new_string(rt.new_string('comment'))
	}
	if rt.is_true(rt.identical(rt.new_string('page'), rt.new_string(post_type))) {
		mut var_status := rt.new_string(rt.new_string('closed'))
	} else if rt.is_true(rt.call_function('post_type_supports', [rt.new_string(post_type), var_supports.dup()])) {
		var_status = rt.call_function('get_option', [rt.new_string("default_${var_option.to_string()}_status")])
	} else {
		var_status = rt.new_string(rt.new_string('closed'))
	}
	return rt.call_function('apply_filters', [rt.new_string('get_default_comment_status'), var_status.dup(), rt.new_string(post_type), rt.new_string(comment_type)])
}

fn get_lastcommentmodified(timezone string) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	timezone = timezone.to_lower()
	mut var_key := "lastcommentmodified:${var_timezone}"
	mut var_comment_modified_date := rt.call_function('wp_cache_get', [rt.new_string(var_key).dup(), rt.new_string('timeinfo')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (var_comment_modified_date).to_bool()
	}
	mut switch_val_2 := rt.new_string(timezone)
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('gmt'))) {
		var_comment_modified_date = rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SELECT comment_date_gmt FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE comment_approved = \'1\' ORDER BY comment_date_gmt DESC LIMIT 1'))])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('blog'))) {
		var_comment_modified_date = rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SELECT comment_date FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE comment_approved = \'1\' ORDER BY comment_date_gmt DESC LIMIT 1'))])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('server'))) {
		mut var_add_seconds_server := rt.call_function('gmdate', [rt.new_string('Z')])
		var_comment_modified_date = rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT DATE_ADD(comment_date_gmt, INTERVAL %s SECOND) FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE comment_approved = \'1\' ORDER BY comment_date_gmt DESC LIMIT 1')), var_add_seconds_server.dup()])])
	}
	if rt.is_true(var_comment_modified_date) {
		rt.call_function('wp_cache_set', [rt.new_string(var_key).dup(), var_comment_modified_date.dup(), rt.new_string('timeinfo')])
		return (var_comment_modified_date).to_bool()
	}
	return false
}

fn get_comment_count(post_id i64) rt.PhpVal {
	post_id = (// unsupported expression: Expr_Cast_Int).to_i64()
	mut var_comment_count := rt.create_array([rt.ArrayItem{ key: 'approved', val: 0 }, rt.ArrayItem{ key: 'awaiting_moderation', val: 0 }, rt.ArrayItem{ key: 'spam', val: 0 }, rt.ArrayItem{ key: 'trash', val: 0 }, rt.ArrayItem{ key: 'post-trashed', val: 0 }, rt.ArrayItem{ key: 'total_comments', val: 0 }, rt.ArrayItem{ key: 'all', val: 0 }])
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'count', val: true }, rt.ArrayItem{ key: 'update_comment_meta_cache', val: false }, rt.ArrayItem{ key: 'orderby', val: 'none' }])
	if post_id > 0 {
		var_args.array_set('post_id', post_id)
	}
	mut var_mapping := { 'approved': 'approve', 'awaiting_moderation': 'hold', 'spam': 'spam', 'trash': 'trash', 'post-trashed': 'post-trashed' }
	var_comment_count = rt.new_array()
	for var_key, var_value in var_mapping {
		var_comment_count.array_set(key, get_comments(rt.call_function('array_merge', [var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'status', val: value }])])))
	}
	var_comment_count.array_set('all', rt.add(var_comment_count.array_get('approved'), var_comment_count.array_get('awaiting_moderation')))
	var_comment_count.array_set('total_comments', rt.add(var_comment_count.array_get('all'), var_comment_count.array_get('spam')))
	return rt.call_function('array_map', [rt.new_string('intval'), var_comment_count.dup()])
}

fn add_comment_meta(var_comment_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, unique bool) rt.PhpVal {
	return rt.call_function('add_metadata', [rt.new_string('comment'), var_comment_id.dup(), var_meta_key.dup(), var_meta_value.dup(), rt.new_bool(unique)])
}

fn delete_comment_meta(var_comment_id rt.PhpVal, meta_key string, meta_value string) rt.PhpVal {
	return rt.call_function('delete_metadata', [rt.new_string('comment'), var_comment_id.dup(), rt.new_string(meta_key), rt.new_string(meta_value)])
}

fn get_comment_meta(var_comment_id rt.PhpVal, key string, single bool) rt.PhpVal {
	return rt.call_function('get_metadata', [rt.new_string('comment'), var_comment_id.dup(), rt.new_string(key), rt.new_bool(single)])
}

fn wp_lazyload_comment_meta(var_comment_ids rt.PhpVal) {
	if !rt.is_true(var_comment_ids) {
		return rt.new_null()
	}
	mut var_lazyloader := rt.call_function('wp_metadata_lazyloader', []rt.PhpVal{})
	rt.call_method(var_lazyloader, 'queue_objects', [rt.new_string('comment'), var_comment_ids.dup()])
}

fn update_comment_meta(var_comment_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, prev_value string) rt.PhpVal {
	return 
}

struct Class_WP_Comment_Query {
	rt.PhpObjectBase
}

struct Class_WP_Comment {
	rt.PhpObjectBase
}

fn create_wp_comment_query() &Class_WP_Comment_Query {
	mut obj := &Class_WP_Comment_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_comment() &Class_WP_Comment {
	mut obj := &Class_WP_Comment{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Comment_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Comment_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Comment_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Comment) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Comment) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Comment) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_comment_php() {
}
