import rt

struct Class_WP_Application_Passwords_List_Table {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Application_Passwords_List_Table) get_columns() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Name')]) },
		rt.ArrayItem{ key: 'created', val: rt.call_function('__', [
			rt.new_string('Created')]) },
		rt.ArrayItem{ key: 'last_used', val: rt.call_function('__', [
			rt.new_string('Last Used')]) },
		rt.ArrayItem{ key: 'last_ip', val: rt.call_function('__', [
			rt.new_string('Last IP')]) },
		rt.ArrayItem{ key: 'revoke', val: rt.call_function('__', [
			rt.new_string('Revoke')]) },
	])
}

fn (mut this Class_WP_Application_Passwords_List_Table) prepare_items() {
	mut var_user_id := rt.new_null()
	mut iife_temp_0 := Class_WP_Application_Passwords{}
	mut iife_result_0 := iife_temp_0.get_user_application_passwords(var_user_id.clone())
	mut iife_temp_1 := Class_WP_Application_Passwords{}
	mut iife_result_1 := iife_temp_1.get_user_application_passwords(var_user_id.clone())
	this.dispatch_set_prop('items', rt.call_function('array_reverse', [iife_result_0]))
}

fn (mut this Class_WP_Application_Passwords_List_Table) column_name(var_item rt.PhpVal) {
	rt.echo_val(rt.call_function('esc_html', [var_item.array_get(rt.new_string('name'))]))
}

fn (mut this Class_WP_Application_Passwords_List_Table) column_created(var_item rt.PhpVal) {
	if !rt.is_true(var_item.array_get(rt.new_string('created'))) {
		print('&mdash;')
	} else {
		rt.echo_val(rt.call_function('date_i18n', [
			rt.call_function('__', [rt.new_string('F j, Y')]),
			var_item.array_get(rt.new_string('created')),
		]))
	}
}

fn (mut this Class_WP_Application_Passwords_List_Table) column_last_used(var_item rt.PhpVal) {
	if !rt.is_true(var_item.array_get(rt.new_string('last_used'))) {
		print('&mdash;')
	} else {
		rt.echo_val(rt.call_function('date_i18n', [
			rt.call_function('__', [rt.new_string('F j, Y')]),
			var_item.array_get(rt.new_string('last_used')),
		]))
	}
}

fn (mut this Class_WP_Application_Passwords_List_Table) column_last_ip(var_item rt.PhpVal) {
	if !rt.is_true(var_item.array_get(rt.new_string('last_ip'))) {
		print('&mdash;')
	} else {
		rt.echo_val(var_item.array_get(rt.new_string('last_ip')))
	}
}

fn (mut this Class_WP_Application_Passwords_List_Table) column_revoke(var_item rt.PhpVal) {
	mut var_name := rt.new_string('revoke-application-password-' +
		(var_item.array_get(rt.new_string('uuid'))).str())
	rt.call_function('printf', [
		rt.new_string('<button type="button" name="%1$s" id="%1$s" class="button delete" aria-label="%2$s">%3$s</button>'),
		rt.call_function('esc_attr', [var_name.clone()]),
		rt.call_function('esc_attr', [
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Revoke "%s"')]),
				var_item.array_get(rt.new_string('name')),
			]),
		]),
		rt.call_function('__', [
			rt.new_string('Revoke'),
		]),
	])
}

fn (mut this Class_WP_Application_Passwords_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal) {
	rt.call_function('do_action', [
		rt.concat(rt.concat(rt.new_string('manage_'), rt.get_property(rt.get_property(rt.new_object('WP_Application_Passwords_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'id')), rt.new_string('_custom_column')),
		var_column_name.clone(),
		var_item.clone(),
	])
}

fn (mut this Class_WP_Application_Passwords_List_Table) display_tablenav(var_which rt.PhpVal) {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_which.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('bottom'), var_which)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Revoke all application passwords')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	this.bulk_actions(var_which.clone())
	// unsupported statement: Stmt_InlineHTML
	this.extra_tablenav(var_which.clone())
	this.pagination(var_which.clone())
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Application_Passwords_List_Table) single_row(var_item rt.PhpVal) {
	print('<tr data-uuid="' +
		(rt.call_function('esc_attr', [var_item.array_get(rt.new_string('uuid'))])).str() + '">')
	this.single_row_columns(var_item.clone())
	print('</tr>')
}

fn (mut this Class_WP_Application_Passwords_List_Table) get_default_primary_column_name() string {
	return 'name'
}

fn (mut this Class_WP_Application_Passwords_List_Table) print_js_template_row() {
	mut var_columns := rt.new_null()
	mut var_hidden := rt.new_null()
	mut var_primary := rt.new_null()
	mut list_tmp_1 := this.get_column_info()
	var_columns = list_tmp_1.array_get(0)
	var_hidden = list_tmp_1.array_get(1)
	var_primary = list_tmp_1.array_get(3)
	print('<tr data-uuid="{{ data.uuid }}">')
	mut iter_1 := var_columns.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_display_name := item_1.val
		mut var_column_name := item_1.key
		mut var_is_primary := rt.identical(var_primary, var_column_name)
		mut var_classes :=
			rt.new_string('${var_column_name.to_string()} column-${var_column_name.to_string()}')
		if rt.is_true(var_is_primary) {
			var_classes = rt.concat(var_classes, rt.new_string(' has-row-actions column-primary'))
		}
		if rt.is_true(rt.call_function('in_array', [var_column_name.clone(),
			var_hidden.clone(), rt.new_bool(true)]))
		{
			var_classes = rt.concat(var_classes, rt.new_string(' hidden'))
		}
		rt.call_function('printf', [rt.new_string('<td class="%s" data-colname="%s">'),
			rt.call_function('esc_attr', [var_classes.clone()]),
			rt.call_function('esc_attr', [
				rt.call_function('wp_strip_all_tags', [var_display_name.clone()]),
			])])
		mut switch_val_1 := var_column_name
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('name'))) {
			print('{{ data.name }}')
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('created'))) {
			print('<# print( wp.date.dateI18n( ' +
				(rt.call_function('wp_json_encode', [rt.call_function('__', [rt.new_string('F j, Y')])])).str() +
				', data.created ) ) #>')
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('last_used'))) {
			print('<# print( data.last_used !== null ? wp.date.dateI18n( ' +
				(rt.call_function('wp_json_encode', [rt.call_function('__', [rt.new_string('F j, Y')])])).str() +
				", data.last_used ) : '—' ) #>")
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('last_ip'))) {
			print("{{ data.last_ip || '—' }}")
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('revoke'))) {
			rt.call_function('printf', [
				rt.new_string('<button type="button" class="button delete" aria-label="%1$s">%2$s</button>'),
				rt.call_function('esc_attr', [
					rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('Revoke "%s"')]),
						rt.new_string('{{ data.name }}'),
					]),
				]),
				rt.call_function('esc_html__', [
					rt.new_string('Revoke'),
				]),
			])
		} else {
			rt.call_function('do_action', [
				rt.concat(rt.concat(rt.new_string('manage_'), rt.get_property(rt.get_property(rt.new_object('WP_Application_Passwords_List_Table', [
					'WP_List_Table',
				], &this), 'screen'), 'id')), rt.new_string('_custom_column_js_template')),
				var_column_name.clone(),
			])
		}
		if rt.is_true(var_is_primary) {
			print('<button type="button" class="toggle-row"><span class="screen-reader-text">' +
				(rt.call_function('__', [rt.new_string('Show more details')])).str() +
				'</span></button>')
		}
		print('</td>')
	}
	print('</tr>')
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_WP_Application_Passwords {
	rt.PhpObjectBase
}

fn create_wp_application_passwords_list_table(_args ...rt.PhpVal) &Class_WP_Application_Passwords_List_Table {
	mut obj := &Class_WP_Application_Passwords_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_list_table(_args ...rt.PhpVal) &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_application_passwords(_args ...rt.PhpVal) &Class_WP_Application_Passwords {
	mut obj := &Class_WP_Application_Passwords{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Application_Passwords_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_columns' {
			return this.get_columns()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'column_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_name(dispatch_arg_0)
			return rt.new_null()
		}
		'column_created' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_created(dispatch_arg_0)
			return rt.new_null()
		}
		'column_last_used' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_last_used(dispatch_arg_0)
			return rt.new_null()
		}
		'column_last_ip' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_last_ip(dispatch_arg_0)
			return rt.new_null()
		}
		'column_revoke' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_revoke(dispatch_arg_0)
			return rt.new_null()
		}
		'column_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.column_default(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'display_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.display_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'single_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.single_row(dispatch_arg_0)
			return rt.new_null()
		}
		'get_default_primary_column_name' {
			return rt.new_string(this.get_default_primary_column_name())
		}
		'print_js_template_row' {
			this.print_js_template_row()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Application_Passwords_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Application_Passwords_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_WP_Application_Passwords) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Application_Passwords) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Application_Passwords) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
