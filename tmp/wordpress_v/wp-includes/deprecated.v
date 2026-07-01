import rt

fn get_postdata(var_postid rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('1.5.1'), rt.new_string('get_post()')])
	mut var_post := rt.call_function('get_post', [var_postid.dup()])
	mut var_postdata := { 'ID': rt.get_property(var_post, 'ID'), 'Author_ID': rt.get_property(var_post, 'post_author'), 'Date': rt.get_property(var_post, 'post_date'), 'Content': rt.get_property(var_post, 'post_content'), 'Excerpt': rt.get_property(var_post, 'post_excerpt'), 'Title': rt.get_property(var_post, 'post_title'), 'Category': rt.get_property(var_post, 'post_category'), 'post_status': rt.get_property(var_post, 'post_status'), 'comment_status': rt.get_property(var_post, 'comment_status'), 'ping_status': rt.get_property(var_post, 'ping_status'), 'post_password': rt.get_property(var_post, 'post_password'), 'to_ping': rt.get_property(var_post, 'to_ping'), 'pinged': rt.get_property(var_post, 'pinged'), 'post_type': rt.get_property(var_post, 'post_type'), 'post_name': rt.get_property(var_post, 'post_name') }
	return var_postdata.dup()
}

fn start_wp() {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('1.5.0'), rt.call_function('__', [rt.new_string('new WordPress Loop')])])
	rt.call_method(var_wp_query, 'next_post', []rt.PhpVal{})
	rt.call_function('setup_postdata', [rt.call_function('get_post', []rt.PhpVal{})])
}

fn the_category_ID(display bool) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('0.71'), rt.new_string('get_the_category()')])
	mut var_categories := rt.call_function('get_the_category', []rt.PhpVal{})
	mut var_cat := rt.get_property(var_categories.array_get(0), 'term_id')
	if var_display {
		rt.echo_val(var_cat)
	}
	return var_cat.dup()
}

fn the_category_head(before string, after string) {
	// unsupported statement: Stmt_Global
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('0.71'), rt.new_string('get_the_category_by_ID()')])
	mut var_categories := rt.call_function('get_the_category', []rt.PhpVal{})
	mut var_currentcat := rt.get_property(var_categories.array_get(0), 'category_id')
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		print(var_before)
		rt.echo_val(rt.call_function('get_the_category_by_ID', [var_currentcat.dup()]))
		print(var_after)
		mut var_previouscat := var_currentcat.dup()
	}
}

fn previous_post(format string, previous string, title string, in_same_cat string, limitprev i64, excluded_categories string) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.0.0'), rt.new_string('previous_post_link()')])
	if rt.is_true(rt.new_bool(in_same_cat == '' || rt.is_true(rt.equal(rt.new_string('no'), rt.new_string(in_same_cat))))) {
		in_same_cat = false
	} else {
		in_same_cat = true
	}
	mut var_post := rt.call_function('get_previous_post', [rt.new_string(in_same_cat), rt.new_string(excluded_categories)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.new_null()
	}
	mut var_string := rt.new_string('<a href="' + (rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])).str() + '">' + previous)
	if rt.is_true(rt.equal(rt.new_string('yes'), rt.new_string(title))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	format = (rt.call_function('str_replace', [rt.new_string('%'), var_string.dup(), rt.new_string(format)])).str()
	print(var_format)
}

fn next_post(format string, next string, title string, in_same_cat string, limitnext i64, excluded_categories string) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.0.0'), rt.new_string('next_post_link()')])
	if rt.is_true(rt.new_bool(in_same_cat == '' || rt.is_true(rt.equal(rt.new_string('no'), rt.new_string(in_same_cat))))) {
		in_same_cat = false
	} else {
		in_same_cat = true
	}
	mut var_post := rt.call_function('get_next_post', [rt.new_string(in_same_cat), rt.new_string(excluded_categories)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.new_null()
	}
	mut var_string := rt.new_string('<a href="' + (rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])).str() + '">' + next)
	if rt.is_true(rt.equal(rt.new_string('yes'), rt.new_string(title))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	format = (rt.call_function('str_replace', [rt.new_string('%'), var_string.dup(), rt.new_string(format)])).str()
	print(var_format)
}

fn user_can_create_post(var_user_id rt.PhpVal, blog_id i64, category_id string) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	mut var_author_data := rt.call_function('get_userdata', [var_user_id.dup()])
	return rt.greater(rt.get_property(var_author_data, 'user_level'), rt.new_int(1))
}

fn user_can_create_draft(var_user_id rt.PhpVal, blog_id i64, category_id string) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	mut var_author_data := rt.call_function('get_userdata', [var_user_id.dup()])
	return rt.greater_equal(rt.get_property(var_author_data, 'user_level'), rt.new_int(1))
}

fn user_can_edit_post(var_user_id rt.PhpVal, var_post_id rt.PhpVal, blog_id i64) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	mut var_author_data := rt.call_function('get_userdata', [var_user_id.dup()])
	mut var_post := rt.call_function('get_post', [var_post_id.dup()])
	mut var_post_author_data := rt.call_function('get_userdata', [rt.get_property(var_post, 'post_author')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.equal(var_user_id, rt.get_property(var_post_author_data, 'ID'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.equal(rt.get_property(var_post, 'post_status'), rt.new_string('publish'))) && rt.is_true(rt.less(rt.get_property(var_author_data, 'user_level'), rt.new_int(2)))))))))) || rt.is_true(rt.greater(rt.get_property(var_author_data, 'user_level'), rt.get_property(var_post_author_data, 'user_level'))))) || rt.is_true(rt.greater_equal(rt.get_property(var_author_data, 'user_level'), rt.new_int(10))))) {
		return true
	} else {
		return false
	}
	return false
}

fn user_can_delete_post(var_user_id rt.PhpVal, var_post_id rt.PhpVal, blog_id i64) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	return user_can_edit_post(var_user_id.dup(), var_post_id.dup(), blog_id)
}

fn user_can_set_post_date(var_user_id rt.PhpVal, blog_id i64, category_id string) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	mut var_author_data := rt.call_function('get_userdata', [var_user_id.dup()])
	return rt.is_true(rt.greater(rt.get_property(var_author_data, 'user_level'), rt.new_int(4))) && rt.is_true(user_can_create_post(var_user_id.dup(), blog_id, category_id))
}

fn user_can_edit_post_date(var_user_id rt.PhpVal, var_post_id rt.PhpVal, blog_id i64) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	mut var_author_data := rt.call_function('get_userdata', [var_user_id.dup()])
	return rt.is_true(rt.greater(rt.get_property(var_author_data, 'user_level'), rt.new_int(4))) && user_can_edit_post(var_user_id.dup(), var_post_id.dup(), blog_id)
}

fn user_can_edit_post_comments(var_user_id rt.PhpVal, var_post_id rt.PhpVal, blog_id i64) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	return user_can_edit_post(var_user_id.dup(), var_post_id.dup(), blog_id)
}

fn user_can_delete_post_comments(var_user_id rt.PhpVal, var_post_id rt.PhpVal, blog_id i64) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	return user_can_edit_post_comments(var_user_id.dup(), var_post_id.dup(), blog_id)
}

fn user_can_edit_user(var_user_id rt.PhpVal, var_other_user rt.PhpVal) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.0.0'), rt.new_string('current_user_can()')])
	mut var_user := rt.call_function('get_userdata', [var_user_id.dup()])
	mut var_other := rt.call_function('get_userdata', [var_other_user.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.greater(rt.get_property(var_user, 'user_level'), rt.get_property(var_other, 'user_level'))) || rt.is_true(rt.greater(rt.get_property(var_user, 'user_level'), rt.new_int(8))))) || rt.is_true(rt.equal(rt.get_property(var_user, 'ID'), rt.get_property(var_other, 'ID'))))) {
		return true
	} else {
		return false
	}
	return false
}

fn get_linksbyname(cat_name string, before string, after string, between string, show_images bool, orderby string, show_description bool, show_rating bool, var_limit rt.PhpVal, show_updated i64) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.1.0'), rt.new_string('get_bookmarks()')])
	mut var_cat_id := // unsupported expression: Expr_UnaryMinus
	mut var_cat := rt.call_function('get_term_by', [rt.new_string('name'), rt.new_string(cat_name), rt.new_string('link_category')])
	if rt.is_true(var_cat) {
		var_cat_id = rt.get_property(var_cat, 'term_id')
	}
	rt.new_string(get_links(var_cat_id.dup(), before, after, between, show_images, orderby, show_description, show_rating, var_limit.dup(), show_updated, false))
}

fn wp_get_linksbyname(var_category rt.PhpVal, args string) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.1.0'), rt.new_string('wp_list_bookmarks()')])
	mut var_defaults := { 'after': rt.new_string('<br />'), 'before': rt.new_string(''), 'categorize': rt.new_int(0), 'category_after': rt.new_string(''), 'category_before': rt.new_string(''), 'category_name': var_category, 'show_description': rt.new_int(1), 'title_li': rt.new_string('') }
	mut var_parsed_args := rt.call_function('wp_parse_args', [rt.new_string(args), var_defaults.dup()])
	return rt.call_function('wp_list_bookmarks', [var_parsed_args.dup()])
}

fn get_linkobjectsbyname(cat_name string, orderby string, var_limit rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.1.0'), rt.new_string('get_bookmarks()')])
	mut var_cat_id := 
	
}

fn init_registry() {
	rt.register_func('get_postdata', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_postdata(arg_0)
	})
	rt.register_func('start_wp', fn(args []rt.PhpVal) rt.PhpVal {
		return start_wp()
	})
	rt.register_func('the_category_ID', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		return the_category_ID(arg_0)
	})
	rt.register_func('the_category_head', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return the_category_head(arg_0, arg_1)
	})
	rt.register_func('previous_post', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		return previous_post(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	})
	rt.register_func('next_post', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		return next_post(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	})
	rt.register_func('user_can_create_post', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return user_can_create_post(arg_0, arg_1, arg_2)
	})
	rt.register_func('user_can_create_draft', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return user_can_create_draft(arg_0, arg_1, arg_2)
	})
	rt.register_func('user_can_edit_post', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(user_can_edit_post(arg_0, arg_1, arg_2))
	})
	rt.register_func('user_can_delete_post', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(user_can_delete_post(arg_0, arg_1, arg_2))
	})
	rt.register_func('user_can_set_post_date', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return rt.new_bool(user_can_set_post_date(arg_0, arg_1, arg_2))
	})
	rt.register_func('user_can_edit_post_date', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(user_can_edit_post_date(arg_0, arg_1, arg_2))
	})
	rt.register_func('user_can_edit_post_comments', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(user_can_edit_post_comments(arg_0, arg_1, arg_2))
	})
	rt.register_func('user_can_delete_post_comments', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(user_can_delete_post_comments(arg_0, arg_1, arg_2))
	})
	rt.register_func('user_can_edit_user', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(user_can_edit_user(arg_0, arg_1))
	})
	rt.register_func('get_linksbyname', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_bool()
		arg_7 := (if args.len > 7 { args[7] } else { rt.new_null() }).to_bool()
		arg_8 := if args.len > 8 { args[8] } else { rt.new_null() }
		arg_9 := (if args.len > 9 { args[9] } else { rt.new_null() }).to_i64()
		return get_linksbyname(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8, arg_9)
	})
	rt.register_func('wp_get_linksbyname', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return wp_get_linksbyname(arg_0, arg_1)
	})
	rt.register_func('get_linkobjectsbyname', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return get_linkobjectsbyname(arg_0, arg_1, arg_2)
	})
	rt.register_func('get_linkobjects', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return get_linkobjects(arg_0, arg_1, arg_2)
	})
	rt.register_func('get_linksbyname_withrating', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_bool()
		arg_7 := if args.len > 7 { args[7] } else { rt.new_null() }
		arg_8 := (if args.len > 8 { args[8] } else { rt.new_null() }).to_i64()
		return get_linksbyname_withrating(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8)
	})
	rt.register_func('get_links_withrating', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_bool()
		arg_7 := if args.len > 7 { args[7] } else { rt.new_null() }
		arg_8 := (if args.len > 8 { args[8] } else { rt.new_null() }).to_i64()
		return get_links_withrating(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8)
	})
	rt.register_func('get_autotoggle', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		return rt.new_int(get_autotoggle(arg_0))
	})
	rt.register_func('list_cats', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_i64()
		arg_7 := (if args.len > 7 { args[7] } else { rt.new_null() }).to_i64()
		arg_8 := (if args.len > 8 { args[8] } else { rt.new_null() }).to_i64()
		arg_9 := (if args.len > 9 { args[9] } else { rt.new_null() }).to_i64()
		arg_10 := (if args.len > 10 { args[10] } else { rt.new_null() }).to_bool()
		arg_11 := (if args.len > 11 { args[11] } else { rt.new_null() }).to_i64()
		arg_12 := (if args.len > 12 { args[12] } else { rt.new_null() }).to_i64()
		arg_13 := (if args.len > 13 { args[13] } else { rt.new_null() }).to_i64()
		arg_14 := (if args.len > 14 { args[14] } else { rt.new_null() }).str()
		arg_15 := (if args.len > 15 { args[15] } else { rt.new_null() }).str()
		arg_16 := (if args.len > 16 { args[16] } else { rt.new_null() }).str()
		arg_17 := (if args.len > 17 { args[17] } else { rt.new_null() }).to_bool()
		return list_cats(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8, arg_9, arg_10, arg_11, arg_12, arg_13, arg_14, arg_15, arg_16, arg_17)
	})
	rt.register_func('wp_list_cats', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return wp_list_cats(arg_0)
	})
	rt.register_func('dropdown_cats', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_i64()
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_i64()
		arg_7 := (if args.len > 7 { args[7] } else { rt.new_null() }).to_bool()
		arg_8 := (if args.len > 8 { args[8] } else { rt.new_null() }).to_i64()
		arg_9 := (if args.len > 9 { args[9] } else { rt.new_null() }).to_i64()
		return dropdown_cats(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8, arg_9)
	})
	rt.register_func('list_authors', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		return list_authors(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	})
	rt.register_func('wp_get_post_cats', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		return wp_get_post_cats(arg_0, arg_1)
	})
	rt.register_func('wp_set_post_cats', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_set_post_cats(arg_0, arg_1, arg_2)
	})
	rt.register_func('get_archives', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
		return get_archives(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	})
	rt.register_func('get_author_link', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return get_author_link(arg_0, arg_1, arg_2)
	})
	rt.register_func('link_pages', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).str()
		return link_pages(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6)
	})
	rt.register_func('get_settings', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_settings(arg_0)
	})
	rt.register_func('permalink_link', fn(args []rt.PhpVal) rt.PhpVal {
		return permalink_link()
	})
	rt.register_func('permalink_single_rss', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return permalink_single_rss(arg_0)
	})
	rt.register_func('wp_get_links', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return wp_get_links(arg_0)
	})
	rt.register_func('get_links', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_bool()
		arg_7 := (if args.len > 7 { args[7] } else { rt.new_null() }).to_bool()
		arg_8 := if args.len > 8 { args[8] } else { rt.new_null() }
		arg_9 := (if args.len > 9 { args[9] } else { rt.new_null() }).to_i64()
		arg_10 := (if args.len > 10 { args[10] } else { rt.new_null() }).to_bool()
		return rt.new_string(get_links(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8, arg_9, arg_10))
	})
	rt.register_func('get_links_list', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return get_links_list(arg_0)
	})
	rt.register_func('links_popup_script', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
		return links_popup_script(arg_0, arg_1, arg_2, arg_3, arg_4)
	})
	rt.register_func('get_linkrating', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_linkrating(arg_0)
	})
	rt.register_func('get_linkcatname', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		return rt.new_string(get_linkcatname(arg_0))
	})
	rt.register_func('comments_rss_link', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return comments_rss_link(arg_0)
	})
	rt.register_func('get_category_rss_link', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		return get_category_rss_link(arg_0, arg_1)
	})
	rt.register_func('get_author_rss_link', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		return get_author_rss_link(arg_0, arg_1)
	})
	rt.register_func('comments_rss', fn(args []rt.PhpVal) rt.PhpVal {
		return comments_rss()
	})
	rt.register_func('create_user', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return create_user(arg_0, arg_1, arg_2)
	})
	rt.register_func('gzip_compression', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(gzip_compression())
	})
	rt.register_func('get_commentdata', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return get_commentdata(arg_0, arg_1, arg_2)
	})
	rt.register_func('get_catname', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_catname(arg_0)
	})
	rt.register_func('get_category_children', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return rt.new_string(get_category_children(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('get_all_category_ids', fn(args []rt.PhpVal) rt.PhpVal {
		return get_all_category_ids()
	})
	rt.register_func('get_the_author_description', fn(args []rt.PhpVal) rt.PhpVal {
		return get_the_author_description()
	})
	rt.register_func('the_author_description', fn(args []rt.PhpVal) rt.PhpVal {
		return the_author_description()
	})
	rt.register_func('get_the_author_login', fn(args []rt.PhpVal) rt.PhpVal {
		return get_the_author_login()
	})
	rt.register_func('the_author_login', fn(args []rt.PhpVal) rt.PhpVal {
		return the_author_login()
	})
	rt.register_func('get_the_author_firstname', fn(args []rt.PhpVal) rt.PhpVal {
		return get_the_author_firstname()
	})
	rt.register_func('the_author_firstname', fn(args []rt.PhpVal) rt.PhpVal {
		return the_author_firstname()
	})
	rt.register_func('get_the_author_lastname', fn(args []rt.PhpVal) rt.PhpVal {
		return get_the_author_lastname()
	})
	rt.register_func('the_author_lastname', fn(args []rt.PhpVal) rt.PhpVal {
		return the_author_lastname()
	})
	rt.register_func('get_the_author_nickname', fn(args []rt.PhpVal) rt.PhpVal {
		return get_the_author_nickname()
	})
	rt.register_func('the_author_nickname', fn(args []rt.PhpVal) rt.PhpVal {
		return the_author_nickname()
	})
	rt.register_func('get_the_author_email', fn(args []rt.PhpVal) rt.PhpVal {
		return get_the_author_email()
	})
	rt.register_func('the_author_email', fn(args []rt.PhpVal) rt.PhpVal {
		return the_author_email()
	})
	rt.register_func('get_the_author_icq', fn(args []rt.PhpVal) rt.PhpVal {
		return get_the_author_icq()
	})
	rt.register_func('the_author_icq', fn(args []rt.PhpVal) rt.PhpVal {
		return the_author_icq()
	})
	rt.register_func('get_the_author_yim', fn(args []rt.PhpVal) rt.PhpVal {
		return get_the_author_yim()
	})
	rt.register_func('the_author_yim', fn(args []rt.PhpVal) rt.PhpVal {
		return the_author_yim()
	})
	rt.register_func('get_the_author_msn', fn(args []rt.PhpVal) rt.PhpVal {
		return get_the_author_msn()
	})
	rt.register_func('the_author_msn', fn(args []rt.PhpVal) rt.PhpVal {
		return the_author_msn()
	})
	rt.register_func('get_the_author_aim', fn(args []rt.PhpVal) rt.PhpVal {
		return get_the_author_aim()
	})
	rt.register_func('the_author_aim', fn(args []rt.PhpVal) rt.PhpVal {
		return the_author_aim()
	})
	rt.register_func('get_author_name', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		return get_author_name(arg_0)
	})
	rt.register_func('get_the_author_url', fn(args []rt.PhpVal) rt.PhpVal {
		return get_the_author_url()
	})
	rt.register_func('the_author_url', fn(args []rt.PhpVal) rt.PhpVal {
		return the_author_url()
	})
	rt.register_func('get_the_author_ID', fn(args []rt.PhpVal) rt.PhpVal {
		return get_the_author_ID()
	})
	rt.register_func('the_author_ID', fn(args []rt.PhpVal) rt.PhpVal {
		return the_author_ID()
	})
	rt.register_func('the_content_rss', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
		return the_content_rss(arg_0, arg_1, arg_2, arg_3, arg_4)
	})
	rt.register_func('make_url_footnote', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return make_url_footnote(arg_0)
	})
	rt.register_func('_c', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return _c(arg_0, arg_1)
	})
	rt.register_func('translate_with_context', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return translate_with_context(arg_0, arg_1)
	})
	rt.register_func('_nc', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		return _nc(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('__ngettext', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return __ngettext(arg_0)
	})
	rt.register_func('__ngettext_noop', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return __ngettext_noop(arg_0)
	})
	rt.register_func('get_alloptions', fn(args []rt.PhpVal) rt.PhpVal {
		return get_alloptions()
	})
	rt.register_func('get_the_attachment_link', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return rt.new_string(get_the_attachment_link(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('get_attachment_icon_src', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return get_attachment_icon_src(arg_0, arg_1)
	})
	rt.register_func('get_attachment_icon', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return rt.new_bool(get_attachment_icon(arg_0, arg_1, arg_2))
	})
	rt.register_func('get_attachment_innerHTML', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return rt.new_bool(get_attachment_innerHTML(arg_0, arg_1, arg_2))
	})
	rt.register_func('get_link', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return get_link(arg_0, arg_1, arg_2)
	})
	rt.register_func('clean_url', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return clean_url(arg_0, arg_1, arg_2)
	})
	rt.register_func('js_escape', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return js_escape(arg_0)
	})
	rt.register_func('wp_specialchars', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return wp_specialchars(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('attribute_escape', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return attribute_escape(arg_0)
	})
	rt.register_func('register_sidebar_widget', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return register_sidebar_widget(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('unregister_sidebar_widget', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return unregister_sidebar_widget(arg_0)
	})
	rt.register_func('register_widget_control', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
		return register_widget_control(arg_0, arg_1, arg_2, arg_3, arg_4)
	})
	rt.register_func('unregister_widget_control', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return unregister_widget_control(arg_0)
	})
	rt.register_func('delete_usermeta', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return rt.new_bool(delete_usermeta(arg_0, arg_1, arg_2))
	})
	rt.register_func('get_usermeta', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return get_usermeta(arg_0, arg_1)
	})
	rt.register_func('update_usermeta', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(update_usermeta(arg_0, arg_1, arg_2))
	})
	rt.register_func('get_users_of_blog', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return get_users_of_blog(arg_0)
	})
	rt.register_func('automatic_feed_links', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		return automatic_feed_links(arg_0)
	})
	rt.register_func('get_profile', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return get_profile(arg_0, arg_1)
	})
	rt.register_func('get_usernumposts', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_usernumposts(arg_0)
	})
	rt.register_func('funky_javascript_callback', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(funky_javascript_callback(arg_0))
	})
	rt.register_func('funky_javascript_fix', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return funky_javascript_fix(arg_0)
	})
	rt.register_func('is_taxonomy', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return is_taxonomy(arg_0)
	})
	rt.register_func('is_term', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return is_term(arg_0, arg_1, arg_2)
	})
	rt.register_func('is_plugin_page', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(is_plugin_page())
	})
	rt.register_func('update_category_cache', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(update_category_cache())
	})
	rt.register_func('wp_timezone_supported', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(wp_timezone_supported())
	})
	rt.register_func('the_editor', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
		return the_editor(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	})
	rt.register_func('get_user_metavalues', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_user_metavalues(arg_0)
	})
	rt.register_func('sanitize_user_object', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return sanitize_user_object(arg_0, arg_1)
	})
	rt.register_func('get_boundary_post_rel_link', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return get_boundary_post_rel_link(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('start_post_rel_link', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return start_post_rel_link(arg_0, arg_1, arg_2)
	})
	rt.register_func('get_index_rel_link', fn(args []rt.PhpVal) rt.PhpVal {
		return get_index_rel_link()
	})
	rt.register_func('index_rel_link', fn(args []rt.PhpVal) rt.PhpVal {
		return index_rel_link()
	})
	rt.register_func('get_parent_post_rel_link', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return get_parent_post_rel_link(arg_0)
	})
	rt.register_func('parent_post_rel_link', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return parent_post_rel_link(arg_0)
	})
	rt.register_func('wp_admin_bar_dashboard_view_site_menu', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_admin_bar_dashboard_view_site_menu(arg_0)
	})
	rt.register_func('is_blog_user', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		return is_blog_user(arg_0)
	})
	rt.register_func('debug_fopen', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(debug_fopen(arg_0, arg_1))
	})
	rt.register_func('debug_fwrite', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return debug_fwrite(arg_0, arg_1)
	})
	rt.register_func('debug_fclose', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return debug_fclose(arg_0)
	})
	rt.register_func('get_themes', fn(args []rt.PhpVal) rt.PhpVal {
		return get_themes()
	})
	rt.register_func('get_theme', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_theme(arg_0)
	})
	rt.register_func('get_current_theme', fn(args []rt.PhpVal) rt.PhpVal {
		return get_current_theme()
	})
	rt.register_func('clean_pre', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return clean_pre(arg_0)
	})
	rt.register_func('add_custom_image_header', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return add_custom_image_header(arg_0, arg_1, arg_2)
	})
	rt.register_func('remove_custom_image_header', fn(args []rt.PhpVal) rt.PhpVal {
		return remove_custom_image_header()
	})
	rt.register_func('add_custom_background', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return add_custom_background(arg_0, arg_1, arg_2)
	})
	rt.register_func('remove_custom_background', fn(args []rt.PhpVal) rt.PhpVal {
		return remove_custom_background()
	})
	rt.register_func('get_theme_data', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return get_theme_data(arg_0)
	})
	rt.register_func('update_page_cache', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return update_page_cache(arg_0)
	})
	rt.register_func('clean_page_cache', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return clean_page_cache(arg_0)
	})
	rt.register_func('wp_explain_nonce', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_explain_nonce(arg_0)
	})
	rt.register_func('sticky_class', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return sticky_class(arg_0)
	})
	rt.register_func('_get_post_ancestors', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _get_post_ancestors(arg_0)
	})
	rt.register_func('wp_load_image', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_load_image(arg_0)
	})
	rt.register_func('image_resize', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
		arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
		arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_i64()
		return image_resize(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6)
	})
	rt.register_func('wp_get_single_post', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_get_single_post(arg_0, arg_1)
	})
	rt.register_func('user_pass_ok', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(user_pass_ok(arg_0, arg_1))
	})
	rt.register_func('_save_post_hook', fn(args []rt.PhpVal) rt.PhpVal {
		return _save_post_hook()
	})
	rt.register_func('gd_edit_image_support', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(gd_edit_image_support(arg_0))
	})
	rt.register_func('wp_convert_bytes_to_hr', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(wp_convert_bytes_to_hr(arg_0))
	})
	rt.register_func('_search_terms_tidy', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(_search_terms_tidy(arg_0))
	})
	rt.register_func('rich_edit_exists', fn(args []rt.PhpVal) rt.PhpVal {
		return rich_edit_exists()
	})
	rt.register_func('default_topic_count_text', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return default_topic_count_text(arg_0)
	})
	rt.register_func('format_to_post', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return format_to_post(arg_0)
	})
	rt.register_func('like_escape', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return like_escape(arg_0)
	})
	rt.register_func('url_is_accessable_via_ssl', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(url_is_accessable_via_ssl(arg_0))
	})
	rt.register_func('preview_theme', fn(args []rt.PhpVal) rt.PhpVal {
		return preview_theme()
	})
	rt.register_func('_preview_theme_template_filter', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_string(_preview_theme_template_filter())
	})
	rt.register_func('_preview_theme_stylesheet_filter', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_string(_preview_theme_stylesheet_filter())
	})
	rt.register_func('preview_theme_ob_filter', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return preview_theme_ob_filter(arg_0)
	})
	rt.register_func('preview_theme_ob_filter_callback', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(preview_theme_ob_filter_callback(arg_0))
	})
	rt.register_func('wp_richedit_pre', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_richedit_pre(arg_0)
	})
	rt.register_func('wp_htmledit_pre', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_htmledit_pre(arg_0)
	})
	rt.register_func('post_permalink', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		return post_permalink(arg_0)
	})
	rt.register_func('wp_get_http', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(wp_get_http(arg_0, arg_1, arg_2))
	})
	rt.register_func('force_ssl_login', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return force_ssl_login(arg_0)
	})
	rt.register_func('get_comments_popup_template', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_string(get_comments_popup_template())
	})
	rt.register_func('is_comments_popup', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(is_comments_popup())
	})
	rt.register_func('comments_popup_script', fn(args []rt.PhpVal) rt.PhpVal {
		return comments_popup_script()
	})
	rt.register_func('popuplinks', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return popuplinks(arg_0)
	})
	rt.register_func('wp_embed_handler_googlevideo', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return rt.new_string(wp_embed_handler_googlevideo(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('get_paged_template', fn(args []rt.PhpVal) rt.PhpVal {
		return get_paged_template()
	})
	rt.register_func('wp_kses_js_entities', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_kses_js_entities(arg_0)
	})
	rt.register_func('_usort_terms_by_ID', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_int(_usort_terms_by_ID(arg_0, arg_1))
	})
	rt.register_func('_usort_terms_by_name', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _usort_terms_by_name(arg_0, arg_1)
	})
	rt.register_func('_sort_nav_menu_items', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_int(_sort_nav_menu_items(arg_0, arg_1))
	})
	rt.register_func('get_shortcut_link', fn(args []rt.PhpVal) rt.PhpVal {
		return get_shortcut_link()
	})
	rt.register_func('wp_ajax_press_this_save_post', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_press_this_save_post()
	})
	rt.register_func('wp_ajax_press_this_add_category', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_press_this_add_category()
	})
	rt.register_func('wp_get_user_request_data', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_get_user_request_data(arg_0)
	})
	rt.register_func('wp_make_content_images_responsive', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_make_content_images_responsive(arg_0)
	})
	rt.register_func('wp_unregister_GLOBALS', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_unregister_GLOBALS()
	})
	rt.register_func('wp_blacklist_check', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
		arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
		return wp_blacklist_check(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	})
	rt.register_func('_wp_register_meta_args_whitelist', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _wp_register_meta_args_whitelist(arg_0, arg_1)
	})
	rt.register_func('add_option_whitelist', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return add_option_whitelist(arg_0, arg_1)
	})
	rt.register_func('remove_option_whitelist', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return remove_option_whitelist(arg_0, arg_1)
	})
	rt.register_func('wp_slash_strings_only', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_slash_strings_only(arg_0)
	})
	rt.register_func('addslashes_strings_only', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return addslashes_strings_only(arg_0)
	})
	rt.register_func('noindex', fn(args []rt.PhpVal) rt.PhpVal {
		return noindex()
	})
	rt.register_func('wp_no_robots', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_no_robots()
	})
	rt.register_func('wp_sensitive_page_meta', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_sensitive_page_meta()
	})
	rt.register_func('_excerpt_render_inner_columns_blocks', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _excerpt_render_inner_columns_blocks(arg_0, arg_1)
	})
	rt.register_func('wp_render_duotone_filter_preset', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_render_duotone_filter_preset(arg_0)
	})
	rt.register_func('wp_skip_border_serialization', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_skip_border_serialization(arg_0))
	})
	rt.register_func('wp_skip_dimensions_serialization', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_skip_dimensions_serialization(arg_0))
	})
	rt.register_func('wp_skip_spacing_serialization', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_skip_spacing_serialization(arg_0))
	})
	rt.register_func('wp_add_iframed_editor_assets_html', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_add_iframed_editor_assets_html()
	})
	rt.register_func('wp_get_attachment_thumb_file', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		return rt.new_bool(wp_get_attachment_thumb_file(arg_0))
	})
	rt.register_func('_get_path_to_translation', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return _get_path_to_translation(arg_0, arg_1)
	})
	rt.register_func('_get_path_to_translation_from_lang_dir', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(_get_path_to_translation_from_lang_dir(arg_0))
	})
	rt.register_func('_wp_multiple_block_styles', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _wp_multiple_block_styles(arg_0)
	})
	rt.register_func('wp_typography_get_css_variable_inline_style', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_typography_get_css_variable_inline_style(arg_0, arg_1, arg_2)
	})
	rt.register_func('global_terms_enabled', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(global_terms_enabled())
	})
	rt.register_func('_filter_query_attachment_filenames', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _filter_query_attachment_filenames(arg_0)
	})
	rt.register_func('get_page_by_title', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return get_page_by_title(arg_0, arg_1, arg_2)
	})
	rt.register_func('_resolve_home_block_template', fn(args []rt.PhpVal) rt.PhpVal {
		return _resolve_home_block_template()
	})
	rt.register_func('wlwmanifest_link', fn(args []rt.PhpVal) rt.PhpVal {
		return wlwmanifest_link()
	})
	rt.register_func('wp_queue_comments_for_comment_meta_lazyload', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_queue_comments_for_comment_meta_lazyload(arg_0)
	})
	rt.register_func('wp_get_loading_attr_default', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_get_loading_attr_default(arg_0)
	})
	rt.register_func('wp_img_tag_add_loading_attr', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_img_tag_add_loading_attr(arg_0, arg_1)
	})
	rt.register_func('wp_tinycolor_bound01', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		return rt.new_float(wp_tinycolor_bound01(arg_0, arg_1))
	})
	rt.register_func('_wp_tinycolor_bound_alpha', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_int(_wp_tinycolor_bound_alpha(arg_0))
	})
	rt.register_func('wp_tinycolor_rgb_to_rgb', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_tinycolor_rgb_to_rgb(arg_0)
	})
	rt.register_func('wp_tinycolor_hue_to_rgb', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_tinycolor_hue_to_rgb(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_tinycolor_hsl_to_rgb', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_tinycolor_hsl_to_rgb(arg_0)
	})
	rt.register_func('wp_tinycolor_string_to_rgb', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_tinycolor_string_to_rgb(arg_0)
	})
	rt.register_func('wp_get_duotone_filter_id', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_get_duotone_filter_id(arg_0)
	})
	rt.register_func('wp_get_duotone_filter_property', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_get_duotone_filter_property(arg_0)
	})
	rt.register_func('wp_get_duotone_filter_svg', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_get_duotone_filter_svg(arg_0)
	})
	rt.register_func('wp_register_duotone_support', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_register_duotone_support(arg_0)
	})
	rt.register_func('wp_render_duotone_support', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_render_duotone_support(arg_0, arg_1)
	})
	rt.register_func('wp_get_global_styles_svg_filters', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_get_global_styles_svg_filters()
	})
	rt.register_func('wp_global_styles_render_svg_filters', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_global_styles_render_svg_filters()
	})
	rt.register_func('block_core_navigation_submenu_build_css_colors', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return block_core_navigation_submenu_build_css_colors(arg_0, arg_1, arg_2)
	})
	rt.register_func('_wp_theme_json_webfonts_handler', fn(args []rt.PhpVal) rt.PhpVal {
		return _wp_theme_json_webfonts_handler()
	})
	rt.register_func('print_embed_styles', fn(args []rt.PhpVal) rt.PhpVal {
		return print_embed_styles()
	})
	rt.register_func('print_emoji_styles', fn(args []rt.PhpVal) rt.PhpVal {
		return print_emoji_styles()
	})
	rt.register_func('wp_admin_bar_header', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_admin_bar_header()
	})
	rt.register_func('_admin_bar_bump_cb', fn(args []rt.PhpVal) rt.PhpVal {
		return _admin_bar_bump_cb()
	})
	rt.register_func('wp_update_https_detection_errors', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_update_https_detection_errors()
	})
	rt.register_func('wp_img_tag_add_decoding_attr', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_img_tag_add_decoding_attr(arg_0, arg_1)
	})
	rt.register_func('_inject_theme_attribute_in_block_template_content', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(_inject_theme_attribute_in_block_template_content(arg_0))
	})
	rt.register_func('_remove_theme_attribute_in_block_template_content', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(_remove_theme_attribute_in_block_template_content(arg_0))
	})
	rt.register_func('the_block_template_skip_link', fn(args []rt.PhpVal) rt.PhpVal {
		return the_block_template_skip_link()
	})
	rt.register_func('block_core_query_ensure_interactivity_dependency', fn(args []rt.PhpVal) rt.PhpVal {
		return block_core_query_ensure_interactivity_dependency()
	})
	rt.register_func('block_core_file_ensure_interactivity_dependency', fn(args []rt.PhpVal) rt.PhpVal {
		return block_core_file_ensure_interactivity_dependency()
	})
	rt.register_func('block_core_image_ensure_interactivity_dependency', fn(args []rt.PhpVal) rt.PhpVal {
		return block_core_image_ensure_interactivity_dependency()
	})
	rt.register_func('wp_render_elements_support', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_render_elements_support(arg_0, arg_1)
	})
	rt.register_func('wp_interactivity_process_directives_of_interactive_blocks', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_interactivity_process_directives_of_interactive_blocks(arg_0)
	})
	rt.register_func('wp_get_global_styles_custom_css', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_string(wp_get_global_styles_custom_css())
	})
	rt.register_func('wp_enqueue_global_styles_custom_css', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_global_styles_custom_css()
	})
	rt.register_func('wp_create_block_style_variation_instance_name', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_string(wp_create_block_style_variation_instance_name(arg_0, arg_1))
	})
	rt.register_func('current_user_can_for_blog', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return current_user_can_for_blog(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_add_editor_classic_theme_styles', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_add_editor_classic_theme_styles(arg_0)
	})
	rt.register_func('wp_print_auto_sizes_contain_css_fix', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_print_auto_sizes_contain_css_fix()
	})
	rt.register_func('addslashes_gpc', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return addslashes_gpc(arg_0)
	})
	rt.register_func('wp_sanitize_script_attributes', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(wp_sanitize_script_attributes(arg_0))
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_deprecated_php() {
}
