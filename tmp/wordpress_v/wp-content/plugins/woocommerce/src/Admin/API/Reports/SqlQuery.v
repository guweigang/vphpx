import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	rt.PhpObjectBase
pub mut:
	sql_clauses rt.PhpVal = rt.new_array()
	sql_filters rt.PhpVal = rt.new_array()
	context     rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) construct(context string) {
	this.context = rt.new_string(context).dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) add_sql_clause(var_type rt.PhpVal, var_clause rt.PhpVal) {
	if this.sql_clauses.array_isset(var_type) && !(!rt.is_true(var_clause)) {
		this.sql_clauses.array_get_mut(var_type).array_push(var_clause.dup())
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) get_sql_clause(var_type rt.PhpVal, handling string) string {
	if !(this.sql_clauses.array_isset(var_type)) {
		return ''
	}
	if rt.is_true(rt.identical(rt.new_string('unfiltered'), rt.new_string(handling))) {
		return (rt.call_function('implode', [rt.new_string(' '),
			this.sql_clauses.array_get(var_type)])).str()
	}
	if this.sql_filters.array_isset(var_type) {
		mut var_clauses := rt.new_array()
		{
			mut iter_1 := this.sql_filters.array_get(var_type).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_subset := item_1.val
				var_clauses = rt.call_function('array_merge', [
					var_clauses.dup(), this.sql_clauses.array_get(var_subset)])
			}
		}
	} else {
		var_clauses = this.sql_clauses.array_get(var_type)
	}
	var_clauses = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_analytics_clauses_${var_type.to_string()}'),
		var_clauses.dup(),
		this.context,
	])
	var_clauses = rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.concat(rt.new_string('woocommerce_analytics_clauses_'), var_type),
			rt.new_string('_')), this.context),
		var_clauses.dup(),
	])
	return (rt.call_function('implode', [rt.new_string(' '), var_clauses.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) clear_sql_clause(var_types rt.PhpVal) {
	{
		mut iter_1 := rt.cast_array(var_types).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			if this.sql_clauses.array_isset(var_type) {
				this.sql_clauses.array_set(var_type, rt.new_array())
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) str_replace_clause(var_type rt.PhpVal, var_search rt.PhpVal, var_replace rt.PhpVal) {
	if this.sql_clauses.array_isset(var_type) {
		{
			mut iter_1 := this.sql_clauses.array_get(var_type).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_sql := item_1.val
				mut var_key := item_1.key
				this.sql_clauses.array_get_mut(var_type).array_set(var_key, rt.call_function('str_replace', [
					var_search.dup(),
					var_replace.dup(),
					var_sql.dup(),
				]))
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) get_query_statement() string {
	mut var_join := rt.new_string(this.get_sql_clause(rt.new_string('join'), 'filtered'))
	mut var_where := rt.new_string(this.get_sql_clause(rt.new_string('where'), 'filtered'))
	mut var_group_by := rt.new_string(this.get_sql_clause(rt.new_string('group_by'), 'filtered'))
	mut var_having := rt.new_string(this.get_sql_clause(rt.new_string('having'), 'filtered'))
	mut var_order_by := rt.new_string(this.get_sql_clause(rt.new_string('order_by'), 'filtered'))
	mut var_union := rt.new_string(this.get_sql_clause(rt.new_string('union'), 'filtered'))
	mut var_statement := rt.new_string(rt.new_string(''))
	// unsupported expression: Expr_AssignOp_Concat
	if !(!rt.is_true(var_group_by)) {
		// unsupported expression: Expr_AssignOp_Concat
		if !(!rt.is_true(var_having)) {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if !(!rt.is_true(var_union)) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(!rt.is_true(var_order_by)) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_statement.str() + this.get_sql_clause(rt.new_string('limit'), 'filtered')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) clear_all_clauses() {
	this.sql_clauses = rt.create_array([
		rt.ArrayItem{ key: 'select', val: rt.new_array() },
		rt.ArrayItem{ key: 'from', val: rt.new_array() },
		rt.ArrayItem{ key: 'left_join', val: rt.new_array() },
		rt.ArrayItem{ key: 'join', val: rt.new_array() },
		rt.ArrayItem{ key: 'right_join', val: rt.new_array() },
		rt.ArrayItem{ key: 'where', val: rt.new_array() },
		rt.ArrayItem{ key: 'where_time', val: rt.new_array() },
		rt.ArrayItem{ key: 'group_by', val: rt.new_array() },
		rt.ArrayItem{ key: 'having', val: rt.new_array() },
		rt.ArrayItem{ key: 'limit', val: rt.new_array() },
		rt.ArrayItem{ key: 'order_by', val: rt.new_array() },
		rt.ArrayItem{ key: 'union', val: rt.new_array() },
	])
}

fn create_automattic_woocommerce_admin_api_reports_sqlquery(context string) &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery{
		PhpObjectBase: rt.PhpObjectBase{}
		sql_clauses:   rt.new_array()
		sql_filters:   rt.new_array()
		context:       rt.new_null()
	}
	obj.construct(context)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'add_sql_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_sql_clause(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_sql_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_sql_clause(dispatch_arg_0, dispatch_arg_1))
		}
		'clear_sql_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.clear_sql_clause(dispatch_arg_0)
			return rt.new_null()
		}
		'str_replace_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.str_replace_clause(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_query_statement' {
			return rt.new_string(this.get_query_statement())
		}
		'clear_all_clauses' {
			this.clear_all_clauses()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'sql_clauses' { return this.sql_clauses }
		'sql_filters' { return this.sql_filters }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'sql_clauses' {
			this.sql_clauses = val
			return true
		}
		'sql_filters' {
			this.sql_filters = val
			return true
		}
		'context' {
			this.context = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_sqlquery_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
