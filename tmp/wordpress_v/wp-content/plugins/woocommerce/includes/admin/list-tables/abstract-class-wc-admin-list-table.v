import rt

struct Class_WC_Admin_List_Table {
	rt.PhpObjectBase
pub mut:
	list_table_type rt.PhpVal = rt.new_string('')
	object          rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Admin_List_Table) construct() {
	if rt.is_true(this.list_table_type) {
		rt.call_function('add_action', [rt.new_string('manage_posts_extra_tablenav'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'maybe_render_blank_state' },
			])])
		rt.call_function('add_filter', [rt.new_string('view_mode_post_types'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'disable_view_mode' },
			])])
		rt.call_function('add_action', [rt.new_string('restrict_manage_posts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'restrict_manage_posts' },
			])])
		rt.call_function('add_filter', [rt.new_string('request'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'request_query' },
			])])
		rt.call_function('add_filter', [rt.new_string('post_row_actions'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'row_actions' },
			]),
			rt.new_int(100), rt.new_int(2)])
		rt.call_function('add_filter', [rt.new_string('default_hidden_columns'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'default_hidden_columns' },
			]),
			rt.new_int(10), rt.new_int(2)])
		rt.call_function('add_filter', [rt.new_string('list_table_primary_column'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'list_table_primary_column' },
			]),
			rt.new_int(10), rt.new_int(2)])
		rt.call_function('add_filter', [
			'manage_edit-' + (this.list_table_type).str() + '_sortable_columns',
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'define_sortable_columns' },
			]),
		])
		rt.call_function('add_filter', [
			'manage_' + (this.list_table_type).str() + '_posts_columns',
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'define_columns' },
			]),
		])
		rt.call_function('add_filter', [
			'bulk_actions-edit-' + (this.list_table_type).str(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'define_bulk_actions' },
			]),
		])
		rt.call_function('add_action', [
			'manage_' + (this.list_table_type).str() + '_posts_custom_column',
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'render_columns' },
			]),
			rt.new_int(10),
			rt.new_int(2),
		])
		rt.call_function('add_filter', [
			'handle_bulk_actions-edit-' + (this.list_table_type).str(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'handle_bulk_actions' },
			]),
			rt.new_int(10),
			rt.new_int(3),
		])
	}
}

fn (mut this Class_WC_Admin_List_Table) maybe_render_blank_state(var_which rt.PhpVal) {
	mut var_post_type := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_post_type, this.list_table_type))
		&& rt.is_true(rt.identical(rt.new_string('bottom'), var_which))))
	{
		mut var_counts := rt.cast_array(rt.call_function('wp_count_posts', [
			var_post_type.dup()]))
		var_counts.array_unset(rt.new_string('auto-draft'))
		mut var_count := rt.call_function('array_sum', [var_counts.dup()])
		if rt.is_true(rt.less(rt.new_int(0), var_count)) {
			return rt.new_null()
		}
		this.render_blank_state()
		print('<style type="text/css">#posts-filter .wp-list-table, #posts-filter .tablenav.top, .tablenav.bottom .actions, .wrap .subsubsub  { display: none; } #posts-filter .tablenav.bottom { height: auto; } </style>')
	}
}

fn (mut this Class_WC_Admin_List_Table) render_blank_state() {
}

fn (mut this Class_WC_Admin_List_Table) disable_view_mode(var_post_types rt.PhpVal) rt.PhpVal {
	var_post_types.array_unset(this.list_table_type)
	return var_post_types.dup()
}

fn (mut this Class_WC_Admin_List_Table) restrict_manage_posts() {
	mut var_typenow := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(this.list_table_type, var_typenow)) {
		this.render_filters()
	}
}

fn (mut this Class_WC_Admin_List_Table) request_query(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_typenow := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(this.list_table_type, var_typenow)) {
		return this.query_filters(var_query_vars.dup())
	}
	return var_query_vars.dup()
}

fn (mut this Class_WC_Admin_List_Table) render_filters() {
}

fn (mut this Class_WC_Admin_List_Table) query_filters(var_query_vars rt.PhpVal) rt.PhpVal {
	return var_query_vars.dup()
}

fn (mut this Class_WC_Admin_List_Table) row_actions(var_actions rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(this.list_table_type, rt.get_property(var_post, 'post_type'))) {
		return this.get_row_actions(var_actions.dup(), var_post.dup())
	}
	return var_actions.dup()
}

fn (mut this Class_WC_Admin_List_Table) get_row_actions(var_actions rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	return var_actions.dup()
}

fn (mut this Class_WC_Admin_List_Table) default_hidden_columns(var_hidden rt.PhpVal, var_screen rt.PhpVal) rt.PhpVal {
	mut var_hidden_mutated := var_hidden
	if rt.is_true(rt.new_bool(!(rt.get_property(var_screen, 'id')).is_null()
		&& rt.is_true(rt.identical('edit-' + (this.list_table_type).str(), rt.get_property(var_screen, 'id')))))
	{
		var_hidden_mutated = rt.call_function('array_merge', [
			var_hidden_mutated.dup(), this.define_hidden_columns()])
	}
	return var_hidden_mutated.dup()
}

fn (mut this Class_WC_Admin_List_Table) list_table_primary_column(var_default rt.PhpVal, var_screen_id rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.identical('edit-' + (this.list_table_type).str(), var_screen_id))
		&& rt.is_true(this.get_primary_column())))
	{
		return rt.new_string(this.get_primary_column())
	}
	return var_default.dup()
}

fn (mut this Class_WC_Admin_List_Table) get_primary_column() string {
	return ''
}

fn (mut this Class_WC_Admin_List_Table) define_hidden_columns() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WC_Admin_List_Table) define_sortable_columns(var_columns rt.PhpVal) rt.PhpVal {
	return var_columns.dup()
}

fn (mut this Class_WC_Admin_List_Table) define_columns(var_columns rt.PhpVal) rt.PhpVal {
	return var_columns.dup()
}

fn (mut this Class_WC_Admin_List_Table) define_bulk_actions(var_actions rt.PhpVal) rt.PhpVal {
	return var_actions.dup()
}

fn (mut this Class_WC_Admin_List_Table) prepare_row_data(var_post_id rt.PhpVal) {
}

fn (mut this Class_WC_Admin_List_Table) render_columns(var_column rt.PhpVal, var_post_id rt.PhpVal) {
	this.prepare_row_data(var_post_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(this.object)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_List_Table', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'render_' + var_column.str() + '_column' },
		]),
	]))
	{
		rt.call_method(rt.new_object('WC_Admin_List_Table', []string{}, &this),
			'render_${var_column.to_string()}_column', []rt.PhpVal{})
	}
}

fn (mut this Class_WC_Admin_List_Table) handle_bulk_actions(var_redirect_to rt.PhpVal, var_action rt.PhpVal, var_ids rt.PhpVal) rt.PhpVal {
	return rt.call_function('esc_url_raw', [var_redirect_to.dup()])
}

fn create_wc_admin_list_table() &Class_WC_Admin_List_Table {
	mut obj := &Class_WC_Admin_List_Table{
		PhpObjectBase:   rt.PhpObjectBase{}
		list_table_type: rt.new_string('')
		object:          rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_WC_Admin_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'maybe_render_blank_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.maybe_render_blank_state(dispatch_arg_0)
			return rt.new_null()
		}
		'render_blank_state' {
			this.render_blank_state()
			return rt.new_null()
		}
		'disable_view_mode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.disable_view_mode(dispatch_arg_0)
		}
		'restrict_manage_posts' {
			this.restrict_manage_posts()
			return rt.new_null()
		}
		'request_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.request_query(dispatch_arg_0)
		}
		'render_filters' {
			this.render_filters()
			return rt.new_null()
		}
		'query_filters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.query_filters(dispatch_arg_0)
		}
		'row_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.row_actions(dispatch_arg_0, dispatch_arg_1)
		}
		'get_row_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_row_actions(dispatch_arg_0, dispatch_arg_1)
		}
		'default_hidden_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.default_hidden_columns(dispatch_arg_0, dispatch_arg_1)
		}
		'list_table_primary_column' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.list_table_primary_column(dispatch_arg_0, dispatch_arg_1)
		}
		'get_primary_column' {
			return rt.new_string(this.get_primary_column())
		}
		'define_hidden_columns' {
			return this.define_hidden_columns()
		}
		'define_sortable_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.define_sortable_columns(dispatch_arg_0)
		}
		'define_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.define_columns(dispatch_arg_0)
		}
		'define_bulk_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.define_bulk_actions(dispatch_arg_0)
		}
		'prepare_row_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.prepare_row_data(dispatch_arg_0)
			return rt.new_null()
		}
		'render_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.render_columns(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_bulk_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.handle_bulk_actions(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'list_table_type' { return this.list_table_type }
		'object' { return this.object }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'list_table_type' {
			this.list_table_type = val
			return true
		}
		'object' {
			this.object = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn init_registry() {
}

fn init() {
	init_registry()
}

pub fn init_wp_content_plugins_woocommerce_includes_admin_list_tables_abstract_class_wc_admin_list_table_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_List_Table'),
		rt.new_bool(false)]))
	{
		return rt.new_null()
	}
}
