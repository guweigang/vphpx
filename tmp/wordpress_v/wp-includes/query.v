import rt

fn get_query_var(query_var string, default_value string) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_query, 'get', [rt.new_string(query_var), rt.new_string(default_value)])
}

fn get_queried_object() rt.PhpVal {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_query, 'get_queried_object', []rt.PhpVal{})
}

fn get_queried_object_id() rt.PhpVal {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_query, 'get_queried_object_id', []rt.PhpVal{})
}

fn set_query_var(var_query_var rt.PhpVal, var_value rt.PhpVal) {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wp_query, 'set', [var_query_var.dup(), var_value.dup()])
}

fn query_posts(var_query rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	var_GLOBALS.array_set('wp_query', create_wp_query())
	return rt.call_method(var_GLOBALS.array_get('wp_query'), 'query', [var_query.dup()])
}

fn wp_reset_query() {
	mut var_GLOBALS := rt.new_null()
	var_GLOBALS.array_set('wp_query', var_GLOBALS.array_get('wp_the_query'))
	wp_reset_postdata()
}

fn wp_reset_postdata() {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(var_wp_query).is_null() {
		rt.call_method(var_wp_query, 'reset_postdata', []rt.PhpVal{})
	}
}

fn is_archive() bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_archive', []rt.PhpVal{})).to_bool()
}

fn is_post_type_archive(post_types string) bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_post_type_archive', [rt.new_string(post_types)])).to_bool()
}

fn is_attachment(attachment string) bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_attachment', [rt.new_string(attachment)])).to_bool()
}

fn is_author(author string) bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_author', [rt.new_string(author)])).to_bool()
}

fn is_category(category string) bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_category', [rt.new_string(category)])).to_bool()
}

fn is_tag(tag string) bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_tag', [rt.new_string(tag)])).to_bool()
}

fn is_tax(taxonomy string, term string) bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_tax', [rt.new_string(taxonomy), rt.new_string(term)])).to_bool()
}

fn is_date() bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_date', []rt.PhpVal{})).to_bool()
}

fn is_day() bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_day', []rt.PhpVal{})).to_bool()
}

fn is_feed(feeds string) bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_feed', [rt.new_string(feeds)])).to_bool()
}

fn is_comment_feed() bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_comment_feed', []rt.PhpVal{})).to_bool()
}

fn is_front_page() bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_front_page', []rt.PhpVal{})).to_bool()
}

fn is_home() bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_home', []rt.PhpVal{})).to_bool()
}

fn is_privacy_policy() bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_privacy_policy', []rt.PhpVal{})).to_bool()
}

fn is_month() bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Conditional query tags do not work before the query is run. Before then, they always return false.')]), rt.new_string('3.1.0')])
		return false
	}
	return (rt.call_method(var_wp_query, 'is_month', []rt.PhpVal{})).to_bool()
}

fn is_page(page string) bool {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var_wp_query).is_null()) {
		
	}
	return ().to_bool()
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_query_php() {
}
