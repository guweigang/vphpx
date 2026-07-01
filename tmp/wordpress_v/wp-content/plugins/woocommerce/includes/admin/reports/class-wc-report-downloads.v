import rt

struct Class_WC_Report_Downloads {
	rt.PhpObjectBase
pub mut:
		max_items rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Report_Downloads) construct()  {
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'singular', val: 'download' }, rt.ArrayItem{ key: 'plural', val: 'downloads' }, rt.ArrayItem{ key: 'ajax', val: false }]))
}

fn (mut this Class_WC_Report_Downloads) display_tablenav(var_position rt.PhpVal)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.Class_WP_List_Table.display_tablenav(var_position.dup())
	}
}

fn (mut this Class_WC_Report_Downloads) output_report()  {
	this.prepare_items()
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('permission_id'))) {
		mut var_permission_id := rt.call_function('absint', [rt.get_superglobal('_GET').array_get('permission_id')])
		mut var_permission := rt.new_null()
		mut var_product := rt.new_null()
		var_permission = create_wc_customer_download(var_permission_id.dup())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_product = rt.call_function('wc_get_product', [rt.get_property(var_permission, 'product_id')])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.dup()
			rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Permission #%d not found.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_permission_id.dup()])])])
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	}
	print('<h1>' + (rt.call_function('esc_html__', [rt.new_string('Customer downloads'), rt.new_string('woocommerce')])).str())
	mut var_filters := this.get_filter_vars()
	mut var_filter_list := []rt.PhpVal{}
	mut var_filter_names := rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.call_function('__', [rt.new_string('Product'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'download_id', val: rt.call_function('__', [rt.new_string('File ID'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'permission_id', val: rt.call_function('__', [rt.new_string('Permission ID'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'order_id', val: rt.call_function('__', [rt.new_string('Order'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'user_id', val: rt.call_function('__', [rt.new_string('User'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'user_ip_address', val: rt.call_function('__', [rt.new_string('IP address'), rt.new_string('woocommerce')]) }])
	{
		mut iter_1 := var_filters.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(var_value.dup().is_null())) {
				continue
			}
			mut switch_val_1 := var_key
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('order_id'))) {
				mut var_order := rt.call_function('wc_get_order', [var_value.dup()])
				if rt.is_true(var_order) {
					mut var_display_value := rt.new_string(rt.concat(rt.call_function('_x', [rt.new_string('#'), rt.new_string('hash before order number'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})))
				} else {
					break
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('product_id'))) {
				var_product = rt.call_function('wc_get_product', [var_value.dup()])
				if rt.is_true(var_product) {
					var_display_value = rt.call_method(var_product, 'get_formatted_name', []rt.PhpVal{})
				} else {
					break
				}
			} else {
				var_display_value = var_value
			}
			var_filter_list << (var_filter_names.array_get(var_key)).str() + ' ' + (var_display_value).str() + ' <a href="' + (rt.call_function('esc_url', [rt.call_function('remove_query_arg', [var_key.dup()])])).str() + '" class="woocommerce-reports-remove-filter">&times;</a>'
		}
	}
	print('</h1>')
	print('<div id="active-filters" class="woocommerce-reports-wide"><h2>')
	print((rt.call_function('esc_html__', [rt.new_string('Active filters'), rt.new_string('woocommerce')])).str() + ': ')
	rt.echo_val(if rt.is_true(var_filter_list) { rt.call_function('wp_kses_post', [rt.call_function('implode', [rt.new_string(', '), var_filter_list.dup()])]) } else { rt.new_string('') })
	print('</h2></div>')
	print('<div id="poststuff" class="woocommerce-reports-wide">')
	this.display()
	print('</div>')
}

fn (mut this Class_WC_Report_Downloads) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal)  {
	mut var_permission := rt.new_null()
	mut var_product := rt.new_null()
	var_permission = create_wc_customer_download(rt.get_property(var_item, 'permission_id'))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_product = rt.call_function('wc_get_product', [rt.get_property(var_permission, 'product_id')])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.dup()
		return rt.new_null()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	mut switch_val_2 := var_column_name
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('timestamp'))) {
		rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_item, 'timestamp')]))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('product'))) {
		if !(!rt.is_true(var_product)) {
			rt.call_function('edit_post_link', [rt.call_function('esc_html', [rt.call_method(var_product, 'get_formatted_name', []rt.PhpVal{})]), rt.new_string(''), rt.new_string(''), rt.call_method(var_product, 'get_id', []rt.PhpVal{}), rt.new_string('view-link')])
			print('<div class="row-actions">')
			print('<a href="' + (rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('product_id'), rt.call_method(var_product, 'get_id', []rt.PhpVal{})])])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Filter by product'), rt.new_string('woocommerce')])).str() + '</a>')
			print('</div>')
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('file'))) {
		if !(!rt.is_true(var_permission)) && !(!rt.is_true(var_product)) {
			mut var_file := rt.call_method(var_product, 'get_file', [rt.call_method(var_permission, 'get_download_id', []rt.PhpVal{})])
			if rt.is_true(rt.identical(rt.new_bool(false), var_file)) {
				rt.echo_val(rt.call_function('esc_html__', [rt.new_string('File does not exist'), rt.new_string('woocommerce')]))
			} else {
				rt.echo_val(rt.call_function('esc_html', [(rt.call_method(var_file, 'get_name', []rt.PhpVal{})).str() + ' - ' + (rt.call_function('basename', [rt.call_method(var_file, 'get_file', []rt.PhpVal{})])).str()]))
				print('<div class="row-actions">')
				print('<a href="' + (rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('download_id'), rt.call_method(var_permission, 'get_download_id', []rt.PhpVal{})])])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Filter by file'), rt.new_string('woocommerce')])).str() + '</a>')
				print('</div>')
			}
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('order'))) {
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_permission)) && rt.is_true(mut var_order := rt.call_function('wc_get_order', [rt.get_property(var_permission, 'order_id')])))) {
			rt.call_function('edit_post_link', [rt.call_function('esc_html', [rt.concat(rt.call_function('_x', [rt.new_string('#'), rt.new_string('hash before order number'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}))]), rt.new_string(''), rt.new_string(''), rt.get_property(var_permission, 'order_id'), rt.new_string('view-link')])
			print('<div class="row-actions">')
			print('<a href="' + (rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('order_id'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})])])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Filter by order'), rt.new_string('woocommerce')])).str() + '</a>')
			print('</div>')
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('user'))) {
		if rt.is_true(rt.greater(rt.get_property(var_item, 'user_id'), rt.new_int(0))) {
			mut var_user := rt.call_function('get_user_by', [rt.new_string('id'), rt.get_property(var_item, 'user_id')])
			if !(!rt.is_true(var_user)) {
				print('<a href="' + (rt.call_function('esc_url', [rt.call_function('get_edit_user_link', [rt.get_property(var_item, 'user_id')])])).str() + '">' + (rt.call_function('esc_html', [rt.get_property(var_user, 'display_name')])).str() + '</a>')
				print('<div class="row-actions">')
				print('<a href="' + (rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('user_id'), rt.get_property(var_item, 'user_id')])])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Filter by user'), rt.new_string('woocommerce')])).str() + '</a>')
				print('</div>')
			}
		} else {
			rt.call_function('esc_html_e', [rt.new_string('Guest'), rt.new_string('woocommerce')])
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('user_ip_address'))) {
		rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_item, 'user_ip_address')]))
		print('<div class="row-actions">')
		print('<a href="' + (rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('user_ip_address'), rt.get_property(var_item, 'user_ip_address')])])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Filter by IP address'), rt.new_string('woocommerce')])).str() + '</a>')
		print('</div>')
	}
}

fn (mut this Class_WC_Report_Downloads) get_columns() rt.PhpVal {
	mut var_columns := { 'timestamp': rt.call_function('__', [rt.new_string('Timestamp'), rt.new_string('woocommerce')]), 'product': rt.call_function('__', [rt.new_string('Product'), rt.new_string('woocommerce')]), 'file': rt.call_function('__', [rt.new_string('File'), rt.new_string('woocommerce')]), 'order': rt.call_function('__', [rt.new_string('Order'), rt.new_string('woocommerce')]), 'user': rt.call_function('__', [rt.new_string('User'), rt.new_string('woocommerce')]), 'user_ip_address': rt.call_function('__', [rt.new_string('IP address'), rt.new_string('woocommerce')]) }
	return var_columns.dup()
}

fn (mut this Class_WC_Report_Downloads) prepare_items()  {
	this.dispatch_set_prop('_column_headers', rt.create_array([rt.ArrayItem{ key: none, val: this.get_columns() }, rt.ArrayItem{ key: none, val: []rt.PhpVal{} }, rt.ArrayItem{ key: none, val: this.get_sortable_columns() }]))
	mut var_current_page := rt.call_function('absint', [this.get_pagenum()])
	mut var_per_page := rt.call_function('max', [rt.new_int(1), rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_downloads_report_downloads_per_page'), rt.new_int(20)])])
	this.get_items(var_current_page.dup(), var_per_page.dup())
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: this.max_items }, rt.ArrayItem{ key: 'per_page', val: var_per_page }, rt.ArrayItem{ key: 'total_pages', val: rt.call_function('ceil', [rt.div(this.max_items, var_per_page)]) }]))
}

fn (mut this Class_WC_Report_Downloads) no_items()  {
	rt.call_function('esc_html_e', [rt.new_string('No customer downloads found.'), rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Report_Downloads) get_filter_vars() rt.PhpVal {
	mut var_product_id := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('product_id'))) { rt.call_function('absint', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('product_id')])]) } else { rt.new_null() }
	mut var_download_id := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('download_id'))) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('download_id')])]) } else { rt.new_null() }
	mut var_permission_id := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('permission_id'))) { rt.call_function('absint', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('permission_id')])]) } else { rt.new_null() }
	mut var_order_id := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('order_id'))) { rt.call_function('absint', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('order_id')])]) } else { rt.new_null() }
	mut var_user_id := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('user_id'))) { rt.call_function('absint', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('user_id')])]) } else { rt.new_null() }
	mut var_user_ip_address := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('user_ip_address'))) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('user_ip_address')])]) } else { rt.new_null() }
	return // unsupported expression: Expr_Cast_Object
}

fn (mut this Class_WC_Report_Downloads) get_items(var_current_page rt.PhpVal, var_per_page rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_current_page_mutated := var_current_page
	mut var_per_page_mutated := var_per_page
	// unsupported statement: Stmt_Global
	this.max_items = rt.new_int(0)
	this.dispatch_set_prop('items', []rt.PhpVal{})
	mut var_filters := this.get_filter_vars()
	mut var_table := rt.new_string(rt.concat(rt.get_property(var_wpdb, 'prefix'), fn () rt.PhpVal { mut temp := Class_WC_Customer_Download_Log_Data_Store{}; return temp.get_table_name() }()))
	mut var_query_from := rt.new_string(rt.new_string(" FROM ${var_table.to_string()} as downloads "))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_filters, 'product_id').is_null()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_filters, 'download_id').is_null()))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_filters, 'order_id').is_null()))))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_filters, 'product_id').is_null()))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_filters, 'download_id').is_null()))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_filters, 'order_id').is_null()))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_filters, 'permission_id').is_null()))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_filters, 'user_id').is_null()))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(, 'user_ip_address').is_null()))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	var_query_from = rt.call_function('apply_filters', [, .dup()])
	mut var_query_order := 
	
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_WC_Customer_Download {
	rt.PhpObjectBase
}

struct Class_WC_Customer_Download_Log_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_report_downloads() &Class_WC_Report_Downloads {
	mut obj := &Class_WC_Report_Downloads{
		PhpObjectBase: rt.PhpObjectBase{}
		max_items: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_list_table() &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer_download() &Class_WC_Customer_Download {
	mut obj := &Class_WC_Customer_Download{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer_download_log_data_store() &Class_WC_Customer_Download_Log_Data_Store {
	mut obj := &Class_WC_Customer_Download_Log_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Report_Downloads) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'display_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.display_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'output_report' {
			this.output_report()
			return rt.new_null()
		}
		'column_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.column_default(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_columns' {
			return this.get_columns()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'get_filter_vars' {
			return this.get_filter_vars()
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.get_items(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Report_Downloads) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'max_items' { return this.max_items }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Report_Downloads) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'max_items' { this.max_items = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Customer_Download) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer_Download) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer_Download) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Customer_Download_Log_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer_Download_Log_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer_Download_Log_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_reports_class_wc_report_downloads_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_List_Table')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-list-table.php', '4')
	}
}
