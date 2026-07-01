import rt
import crypto.md5

struct Class_WC_Admin_Report {
	rt.PhpObjectBase
pub mut:
		transients_to_update rt.PhpVal = rt.new_array()
		cached_results rt.PhpVal = rt.new_array()
		chart_interval rt.PhpVal = rt.new_null()
		group_by_query rt.PhpVal = rt.new_null()
		barwidth rt.PhpVal = rt.new_null()
		chart_groupby rt.PhpVal = rt.new_null()
		start_date rt.PhpVal = rt.new_null()
		end_date rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Admin_Report) get_order_report_data(var_args rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_data := rt.new_null()
	mut var_where := rt.new_null()
	mut var_where_meta := rt.new_null()
	mut var_parent_order_status := rt.new_null()
	mut var_order_types := rt.new_null()
	mut var_filter_range := rt.new_null()
	mut var_group_by := rt.new_null()
	mut var_order_by := rt.new_null()
	mut var_limit := rt.new_null()
	mut var_debug := rt.new_null()
	mut var_nocache := rt.new_null()
	mut var_query_type := rt.new_null()
	mut var_args_mutated := var_args
	// unsupported statement: Stmt_Global
	mut var_default_args := { 'data': map[string]rt.PhpVal{}, 'where': map[string]rt.PhpVal{}, 'where_meta': map[string]rt.PhpVal{}, 'query_type': rt.new_string('get_row'), 'group_by': rt.new_string(''), 'order_by': rt.new_string(''), 'limit': rt.new_string(''), 'filter_range': rt.new_bool(false), 'nocache': rt.new_bool(false), 'debug': rt.new_bool(false), 'order_types': rt.call_function('wc_get_order_types', [rt.new_string('reports')]), 'order_status': map[string]rt.PhpVal{}, 'parent_order_status': rt.new_bool(false) }
	var_args_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_reports_get_order_report_data_args'), var_args_mutated.dup()])
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(), var_default_args.dup()])
	rt.call_function('extract', [var_args_mutated.dup()])
	if !rt.is_true(var_data) {
		return ''
	}
	mut var_order_status := rt.call_function('apply_filters', [rt.new_string('woocommerce_reports_order_statuses'), var_order_status.dup()])
	mut var_query := map[string]rt.PhpVal{}
	mut var_select := map[string]rt.PhpVal{}
	{
		mut iter_1 := var_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_raw_key := item_1.key
			mut var_key := rt.call_function('sanitize_key', [var_raw_key.dup()])
			mut var_distinct := rt.new_string(rt.new_string(''))
			if var_value.array_isset(rt.new_string('distinct')) {
				var_distinct = rt.new_string(rt.new_string('DISTINCT'))
			}
			mut switch_val_1 := var_value.array_get('type')
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('meta'))) {
				mut var_get_key := rt.new_string(rt.new_string("meta_${var_key.to_string()}.meta_value"))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('parent_meta'))) {
				var_get_key = rt.new_string(rt.new_string("parent_meta_${var_key.to_string()}.meta_value"))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('post_data'))) {
				var_get_key = rt.new_string(rt.new_string("posts.${var_key.to_string()}"))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('order_item_meta'))) {
				var_get_key = rt.new_string(rt.new_string("order_item_meta_${var_key.to_string()}.meta_value"))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('order_item'))) {
				var_get_key = rt.new_string(rt.new_string("order_items.${var_key.to_string()}"))
			}
			if !rt.is_true(var_get_key) {
				continue
			}
			if rt.is_true(var_value.array_get('function')) {
				mut var_get := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(var_value.array_get('function'), rt.new_string('(')), var_distinct), rt.new_string(' ')), var_get_key), rt.new_string(')')))
			} else {
				var_get = rt.new_string(rt.new_string("${var_distinct.to_string()} ${var_get_key.to_string()}"))
			}
			var_select << rt.concat(rt.concat(var_get, rt.new_string(' as ')), var_value.array_get('name'))
		}
	}
	var_query.array_set('select', 'SELECT ' + (rt.call_function('implode', [rt.new_string(','), var_select.dup()])).str())
	var_query.array_set('from', rt.concat(rt.concat(rt.new_string('FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS posts')))
	mut var_joins := map[string]rt.PhpVal{}
	{
		mut iter_1 := rt.add(var_data, var_where).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_raw_key := item_1.key
			mut var_join_type := if var_value.array_isset(rt.new_string('join_type')) { var_value.array_get('join_type') } else { rt.new_string('INNER') }
			mut var_type := if var_value.array_isset(rt.new_string('type')) { var_value.array_get('type') } else { rt.new_bool(false) }
			mut var_key := rt.call_function('sanitize_key', [var_raw_key.dup()])
			mut switch_val_2 := var_type
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('meta'))) {
				var_joins["meta_${var_key.to_string()}"] = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(var_join_type, rt.new_string(' JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS meta_')), var_key), rt.new_string(' ON ( posts.ID = meta_')), var_key), rt.new_string('.post_id AND meta_')), var_key), rt.new_string('.meta_key = \'')), var_raw_key), rt.new_string('\' )'))
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('parent_meta'))) {
				var_joins["parent_meta_${var_key.to_string()}"] = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(var_join_type, rt.new_string(' JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS parent_meta_')), var_key), rt.new_string(' ON (posts.post_parent = parent_meta_')), var_key), rt.new_string('.post_id) AND (parent_meta_')), var_key), rt.new_string('.meta_key = \'')), var_raw_key), rt.new_string('\')'))
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('order_item_meta'))) {
				var_joins['order_items'] = rt.concat(rt.concat(rt.concat(var_join_type, rt.new_string(' JOIN ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items AS order_items ON (posts.ID = order_items.order_id)'))
				if !(!rt.is_true(var_value.array_get('order_item_type'))) {
					// unsupported expression: Expr_AssignOp_Concat
				}
				var_joins["order_item_meta_${var_key.to_string()}"] = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(var_join_type, rt.new_string(' JOIN ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_itemmeta AS order_item_meta_')), var_key), rt.new_string(' ON ')) + "(order_items.order_item_id = order_item_meta_${var_key.to_string()}.order_item_id) " + " AND (order_item_meta_${var_key.to_string()}.meta_key = '${var_raw_key.to_string()}')"
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('order_item'))) {
				var_joins['order_items'] = rt.concat(rt.concat(rt.concat(var_join_type, rt.new_string(' JOIN ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items AS order_items ON posts.ID = order_items.order_id'))
			}
		}
	}
	if !(!rt.is_true(var_where_meta)) {
		{
			mut iter_1 := var_where_meta.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_array()))))) {
					continue
				}
				mut var_join_type := if var_value.array_isset(rt.new_string('join_type')) { var_value.array_get('join_type') } else { rt.new_string('INNER') }
				mut var_type := if var_value.array_isset(rt.new_string('type')) { var_value.array_get('type') } else { rt.new_bool(false) }
				mut var_key := rt.call_function('sanitize_key', [if rt.is_true(rt.new_bool(var_value.array_get('meta_key').is_array())) { (var_value.array_get('meta_key').array_get(0)).str() + '_array' } else { var_value.array_get('meta_key') }])
				if rt.is_true(rt.identical(rt.new_string('order_item_meta'), var_type)) {
					var_joins['order_items'] = rt.concat(rt.concat(rt.concat(var_join_type, rt.new_string(' JOIN ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items AS order_items ON posts.ID = order_items.order_id'))
					var_joins["order_item_meta_${var_key.to_string()}"] = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(var_join_type, rt.new_string(' JOIN ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_itemmeta AS order_item_meta_')), var_key), rt.new_string(' ON order_items.order_item_id = order_item_meta_')), var_key), rt.new_string('.order_item_id'))
				} else {
					var_joins["meta_${var_key.to_string()}"] = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(var_join_type, rt.new_string(' JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS meta_')), var_key), rt.new_string(' ON posts.ID = meta_')), var_key), rt.new_string('.post_id'))
				}
			}
		}
	}
	if !(!rt.is_true(var_parent_order_status)) {
		var_joins['parent'] = rt.concat(rt.concat(rt.new_string('LEFT JOIN '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS parent ON posts.post_parent = parent.ID'))
	}
	var_query.array_set('join', rt.call_function('implode', [rt.new_string(' '), var_joins.dup()]))
	var_query.array_set('where', '\n\t\t\tWHERE \tposts.post_type \tIN ( \'' + (rt.call_function('implode', [rt.new_string('\',\''), var_order_types.dup()])).str() + '\' )\n\t\t\t')
	if !(!rt.is_true(var_order_status)) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(!rt.is_true(var_parent_order_status)) {
		if !(!rt.is_true(var_order_status)) {
			// unsupported expression: Expr_AssignOp_Concat
		} else {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if rt.is_true(var_filter_range) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(!rt.is_true(var_where_meta)) {
		mut var_relation := if var_where_meta.array_isset(rt.new_string('relation')) { var_where_meta.array_get('relation') } else { rt.new_string('AND') }
		// unsupported expression: Expr_AssignOp_Concat
		{
			mut iter_1 := var_where_meta.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_index := item_1.key
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_array()))))) {
					continue
				}
				mut var_key := rt.call_function('sanitize_key', [if rt.is_true(rt.new_bool(var_value.array_get('meta_key').is_array())) { (var_value.array_get('meta_key').array_get(0)).str() + '_array' } else { var_value.array_get('meta_key') }])
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(var_value.array_get('operator').to_string().to_lower()), rt.new_string('in'))) || rt.is_true(rt.identical(rt.new_string(var_value.array_get('operator').to_string().to_lower()), rt.new_string('not in'))))) {
					if rt.is_true(rt.new_bool(!(!rt.is_true(var_value.array_get('meta_value'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.array_get('meta_value').is_array()))))))) {
						var_value.array_set('meta_value', rt.cast_array(var_value.array_get('meta_value')))
						// unsupported statement: Stmt_Nop
					}
					if !(!rt.is_true(var_value.array_get('meta_value'))) {
						mut var_formats := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_value.array_get('meta_value').array_count()), rt.new_string('%s')])])
						mut var_where_value := rt.new_string((var_value.array_get('operator')).str() + ' (' + (rt.call_method(var_wpdb, 'prepare', [var_formats.dup(), var_value.array_get('meta_value')])).str() + ')')
						// unsupported statement: Stmt_Nop
					}
				} else {
					var_where_value = rt.new_string((var_value.array_get('operator')).str() + ' ' + (rt.call_method(var_wpdb, 'prepare', [rt.new_string('%s'), var_value.array_get('meta_value')])).str())
				}
				if !(!rt.is_true(var_where_value)) {
					if rt.is_true(rt.greater(var_index, rt.new_int(0))) {
						// unsupported expression: Expr_AssignOp_Concat
					}
					if rt.is_true(rt.new_bool(var_value.array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.new_string('order_item_meta'), var_value.array_get('type'))))) {
						if rt.is_true(rt.new_bool(var_value.array_get('meta_key').is_array())) {
							// unsupported expression: Expr_AssignOp_Concat
						} else {
							// unsupported expression: Expr_AssignOp_Concat
						}
						// unsupported expression: Expr_AssignOp_Concat
					} else {
						if rt.is_true(rt.new_bool(var_value.array_get('meta_key').is_array())) {
							// unsupported expression: Expr_AssignOp_Concat
						} else {
							// unsupported expression: Expr_AssignOp_Concat
						}
						// unsupported expression: Expr_AssignOp_Concat
					}
				}
			}
		}
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(!rt.is_true(var_where)) {
		{
			mut iter_1 := var_where.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(var_value.array_get('operator').to_string().to_lower()), rt.new_string('in'))) || rt.is_true(rt.identical(rt.new_string(var_value.array_get('operator').to_string().to_lower()), rt.new_string('not in'))))) {
					if rt.is_true(rt.new_bool(!(!rt.is_true(var_value.array_get('value'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.array_get('value').is_array()))))))) {
						var_value.array_set('value', rt.cast_array(var_value.array_get('value')))
					}
					if !(!rt.is_true(var_value.array_get('value'))) {
						mut var_formats := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_value.array_get('value').array_count()), rt.new_string('%s')])])
						mut var_where_value := rt.new_string((var_value.array_get('operator')).str() + ' (' + (rt.call_method(var_wpdb, 'prepare', [var_formats.dup(), var_value.array_get('value')])).str() + ')')
						// unsupported statement: Stmt_Nop
					}
				} else {
					var_where_value = rt.new_string((var_value.array_get('operator')).str() + ' ' + (rt.call_method(var_wpdb, 'prepare', [rt.new_string('%s'), var_value.array_get('value')])).str())
				}
				if !(!rt.is_true(var_where_value)) {
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
		}
	}
	if rt.is_true(var_group_by) {
		var_query.array_set('group_by', "GROUP BY ${var_group_by.to_string()}")
	}
	if rt.is_true(var_order_by) {
		var_query.array_set('order_by', "ORDER BY ${var_order_by.to_string()}")
	}
	if rt.is_true(var_limit) {
		var_query.array_set('limit', "LIMIT ${var_limit.to_string()}")
	}
	var_query = rt.call_function('apply_filters', [rt.new_string('woocommerce_reports_get_order_report_query'), var_query.dup()])
	var_query = rt.call_function('implode', [rt.new_string(' '), var_query.dup()])
	if rt.is_true(var_debug) {
		print('<pre>')
		rt.call_function('wc_print_r', [var_query.dup()])
		print('</pre>')
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_debug) || rt.is_true(var_nocache))) {
		Class_WC_Admin_Report.enable_big_selects()
		mut var_result := rt.call_function('apply_filters', [rt.new_string('woocommerce_reports_get_order_report_data'), rt.call_method(var_wpdb, var_query_type, [var_query.dup()]), var_data.dup()])
	} else {
		mut var_query_hash := rt.new_string(rt.new_string(md5.hexhash((var_query_type).str() + (var_query).str())))
		var_result = this.get_cached_query(var_query_hash.dup())
		if rt.is_true(rt.identical(rt.new_null(), var_result)) {
			Class_WC_Admin_Report.enable_big_selects()
			var_result = 
		}
		this.set_cached_query(.dup(), .dup())
	}
	return (var_result).str()
}

fn Class_WC_Admin_Report.add_update_transients_hook()  {
	if rt.is_true() {
	}
}

fn Class_WC_Admin_Report.enable_big_selects()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Static
}

fn (mut this Class_WC_Admin_Report) get_cached_query(var_query_hash rt.PhpVal) rt.PhpVal {
	mut var_query_hash_mutated := var_query_hash
}

fn (mut this Class_WC_Admin_Report) set_cached_query(var_query_hash rt.PhpVal, var_data rt.PhpVal)  {
	mut var_query_hash_mutated := var_query_hash
	mut var_data_mutated := var_data
}

fn Class_WC_Admin_Report.maybe_update_transients()  {
}

fn (mut this Class_WC_Admin_Report) prepare_chart_data(var_data rt.PhpVal, var_date_key rt.PhpVal, var_data_key rt.PhpVal, var_interval rt.PhpVal, var_start_date rt.PhpVal, var_group_by rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_interval_mutated := var_interval
	return rt.new_null()
}

fn (mut this Class_WC_Admin_Report) get_sales_sparkline(id string, days i64, type string) rt.PhpVal {
	mut type_mutated := type
}

fn (mut this Class_WC_Admin_Report) sales_sparkline(id string, days i64, type string) string {
	mut type_mutated := type
}

fn (mut this Class_WC_Admin_Report) calculate_current_range(var_current_range rt.PhpVal)  {
}

fn (mut this Class_WC_Admin_Report) get_currency_tooltip() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Report) get_main_chart()  {
}

fn (mut this Class_WC_Admin_Report) get_chart_legend() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Report) get_chart_widgets() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Report) get_export_button()  {
}

fn (mut this Class_WC_Admin_Report) output_report()  {
}

fn (mut this Class_WC_Admin_Report) check_current_range_nonce(var_current_range rt.PhpVal)  {
}

fn create_wc_admin_report() &Class_WC_Admin_Report {
	mut obj := &Class_WC_Admin_Report{
		PhpObjectBase: rt.PhpObjectBase{}
		transients_to_update: rt.new_array()
		cached_results: rt.new_array()
		chart_interval: rt.new_null()
		group_by_query: rt.new_null()
		barwidth: rt.new_null()
		chart_groupby: rt.new_null()
		start_date: rt.new_null()
		end_date: rt.new_null()
	}
	return obj
}

fn (mut this Class_WC_Admin_Report) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_order_report_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_order_report_data(dispatch_arg_0))
		}
		'add_update_transients_hook' {
			Class_WC_Admin_Report.add_update_transients_hook()
			return rt.new_null()
		}
		'enable_big_selects' {
			Class_WC_Admin_Report.enable_big_selects()
			return rt.new_null()
		}
		'get_cached_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_cached_query(dispatch_arg_0)
		}
		'set_cached_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_cached_query(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'maybe_update_transients' {
			Class_WC_Admin_Report.maybe_update_transients()
			return rt.new_null()
		}
		'prepare_chart_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			return this.prepare_chart_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
		}
		'get_sales_sparkline' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_sales_sparkline(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'sales_sparkline' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(this.sales_sparkline(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'calculate_current_range' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.calculate_current_range(dispatch_arg_0)
			return rt.new_null()
		}
		'get_currency_tooltip' {
			return this.get_currency_tooltip()
		}
		'get_main_chart' {
			this.get_main_chart()
			return rt.new_null()
		}
		'get_chart_legend' {
			return this.get_chart_legend()
		}
		'get_chart_widgets' {
			return this.get_chart_widgets()
		}
		'get_export_button' {
			this.get_export_button()
			return rt.new_null()
		}
		'output_report' {
			this.output_report()
			return rt.new_null()
		}
		'check_current_range_nonce' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.check_current_range_nonce(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin_Report) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'transients_to_update' { return this.transients_to_update }
		'cached_results' { return this.cached_results }
		'chart_interval' { return this.chart_interval }
		'group_by_query' { return this.group_by_query }
		'barwidth' { return this.barwidth }
		'chart_groupby' { return this.chart_groupby }
		'start_date' { return this.start_date }
		'end_date' { return this.end_date }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_Report) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'transients_to_update' { this.transients_to_update = val; return true }
		'cached_results' { this.cached_results = val; return true }
		'chart_interval' { this.chart_interval = val; return true }
		'group_by_query' { this.group_by_query = val; return true }
		'barwidth' { this.barwidth = val; return true }
		'chart_groupby' { this.chart_groupby = val; return true }
		'start_date' { this.start_date = val; return true }
		'end_date' { this.end_date = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_admin_reports_class_wc_admin_report_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
