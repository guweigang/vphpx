import rt

struct Class_WP_Post_Comments_List_Table {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Post_Comments_List_Table) get_column_info() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'author', val: rt.call_function('__', [
				rt.new_string('Author'),
			]) },
			rt.ArrayItem{ key: 'comment', val: rt.call_function('_x', [
				rt.new_string('Comment'),
				rt.new_string('column name'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.new_array() },
		rt.ArrayItem{ key: none, val: rt.new_array() },
		rt.ArrayItem{ key: none, val: 'comment' },
	])
}

fn (mut this Class_WP_Post_Comments_List_Table) get_table_classes() rt.PhpVal {
	mut var_classes := this.Class_WP_Comments_List_Table.get_table_classes()
	var_classes.array_push('wp-list-table')
	var_classes.array_push('comments-box')
	return var_classes.clone()
}

fn (mut this Class_WP_Post_Comments_List_Table) display(output_empty bool) {
	mut var_singular := rt.get_property(rt.new_object('WP_Post_Comments_List_Table', [
		'WP_Comments_List_Table',
	], &this), '_args').array_get(rt.new_string('singular'))
	rt.call_function('wp_nonce_field', [
		rt.new_string('fetch-list-' +(rt.call_function('get_class', [rt.new_object('WP_Post_Comments_List_Table', ['WP_Comments_List_Table'], &this)])).str()),
		rt.new_string('_ajax_fetch_list_nonce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
		this.get_table_classes()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_singular) {
		print(" data-wp-lists='list:${var_singular.to_string()}'")
	}
	// unsupported statement: Stmt_InlineHTML
	if !var_output_empty {
		this.display_rows_or_placeholder()
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Post_Comments_List_Table) get_per_page(comment_status bool) i64 {
	return 10
}

struct Class_WP_Comments_List_Table {
	rt.PhpObjectBase
}

fn create_wp_post_comments_list_table(_args ...rt.PhpVal) &Class_WP_Post_Comments_List_Table {
	mut obj := &Class_WP_Post_Comments_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_comments_list_table(_args ...rt.PhpVal) &Class_WP_Comments_List_Table {
	mut obj := &Class_WP_Comments_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Post_Comments_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_column_info' {
			return this.get_column_info()
		}
		'get_table_classes' {
			return this.get_table_classes()
		}
		'display' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.display(dispatch_arg_0)
			return rt.new_null()
		}
		'get_per_page' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.get_per_page(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Post_Comments_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Post_Comments_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Comments_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Comments_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Comments_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
