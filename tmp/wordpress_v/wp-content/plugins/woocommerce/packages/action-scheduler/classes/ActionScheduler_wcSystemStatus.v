import rt

struct Class_ActionScheduler_wcSystemStatus {
	rt.PhpObjectBase
pub mut:
	store rt.PhpVal = rt.new_null()
}

fn (mut this Class_ActionScheduler_wcSystemStatus) construct(var_store rt.PhpVal) {
	this.store = var_store.dup()
}

fn (mut this Class_ActionScheduler_wcSystemStatus) render() {
	mut var_action_counts := rt.call_method(this.store, 'action_counts', []rt.PhpVal{})
	mut var_status_labels := rt.call_method(this.store, 'get_status_labels', []rt.PhpVal{})
	mut var_oldest_and_newest :=
		this.get_oldest_and_newest(rt.func_array_keys(var_status_labels.dup()))
	this.get_template(var_status_labels.dup(), var_action_counts.dup(), var_oldest_and_newest.dup())
}

fn (mut this Class_ActionScheduler_wcSystemStatus) get_oldest_and_newest(var_status_keys rt.PhpVal) rt.PhpVal {
	mut var_oldest_and_newest := rt.new_array()
	{
		mut iter_1 := var_status_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_status := item_1.val
			var_oldest_and_newest.array_set(var_status, rt.create_array([
				rt.ArrayItem{ key: 'oldest', val: '&ndash;' },
				rt.ArrayItem{ key: 'newest', val: '&ndash;' },
			]))
			if rt.is_true(rt.identical(rt.new_string('in-progress'), var_status)) {
				continue
			}
			var_oldest_and_newest.array_get_mut(var_status).array_set('oldest', this.get_action_status_date(var_status.dup(),
				'oldest'))
			var_oldest_and_newest.array_get_mut(var_status).array_set('newest', this.get_action_status_date(var_status.dup(),
				'newest'))
		}
	}
	return var_oldest_and_newest.dup()
}

fn (mut this Class_ActionScheduler_wcSystemStatus) get_action_status_date(var_status rt.PhpVal, date_type string) rt.PhpVal {
	mut var_order := rt.new_string(if rt.is_true(rt.identical(rt.new_string('oldest'),
		rt.new_string(date_type)))
	{
		rt.new_string('ASC')
	} else {
		rt.new_string('DESC')
	})
	mut var_action := rt.call_method(this.store, 'query_actions', [
		rt.create_array([rt.ArrayItem{ key: 'status', val: var_status },
			rt.ArrayItem{ key: 'per_page', val: 1 }, rt.ArrayItem{ key: 'order', val: var_order }]),
	])
	if !(!rt.is_true(var_action)) {
		mut var_date_object := rt.call_method(this.store, 'get_date', [
			var_action.array_get(0)])
		mut var_action_date := rt.call_method(var_date_object, 'format', [
			rt.new_string('Y-m-d H:i:s O'),
		])
	} else {
		var_action_date = rt.new_string(rt.new_string('&ndash;'))
	}
	return var_action_date.dup()
}

fn (mut this Class_ActionScheduler_wcSystemStatus) get_template(var_status_labels rt.PhpVal, var_action_counts rt.PhpVal, var_oldest_and_newest rt.PhpVal) {
	mut var_status_labels_mutated := var_status_labels
	mut var_action_counts_mutated := var_action_counts
	mut var_oldest_and_newest_mutated := var_oldest_and_newest
	mut var_as_version := rt.call_method(fn () rt.PhpVal {
		mut temp := Class_ActionScheduler_Versions{}
		return temp.instance()
	}(), 'latest_version', []rt.PhpVal{})
	mut var_as_datastore := rt.call_function('get_class', [fn () rt.PhpVal {
		mut temp := Class_ActionScheduler_Store{}
		return temp.instance()
	}()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Action Scheduler'),
		rt.new_string('woocommerce')])
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('This section shows details of Action Scheduler.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Version:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_as_version.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Data store:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_as_datastore.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Action Status'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Count'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Oldest Scheduled Date'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Newest Scheduled Date'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_action_counts_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_count := item_1.val
			mut var_status := item_1.key
			rt.call_function('printf', [
				rt.new_string('<tr><td>%1$s</td><td>&nbsp;</td><td>%2$s<span style="display: none;">, Oldest: %3$s, Newest: %4$s</span></td><td>%3$s</td><td>%4$s</td></tr>'),
				rt.call_function('esc_html', [var_status_labels_mutated.array_get(var_status)]),
				rt.call_function('esc_html', [rt.call_function('number_format_i18n', [
					var_count.dup(),
				])]),
				rt.call_function('esc_html',
					[var_oldest_and_newest_mutated.array_get(var_status).array_get('oldest')]),
				rt.call_function('esc_html',
					[var_oldest_and_newest_mutated.array_get(var_status).array_get('newest')]),
			])
		}
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_ActionScheduler_wcSystemStatus) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) rt.PhpVal {
	mut switch_val_1 := var_name
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('print'))) {
		rt.call_function('_deprecated_function', [@STRUCT + '::print()', rt.new_string('2.2.4'),
			@STRUCT + '::render()'])
		return rt.call_function('call_user_func_array', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wcSystemStatus',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'render' },
			]),
			var_arguments.dup(),
		])
	}
	return rt.new_null()
}

struct Class_ActionScheduler_Versions {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_Store {
	rt.PhpObjectBase
}

fn create_actionscheduler_wcsystemstatus(arg_0 rt.PhpVal) &Class_ActionScheduler_wcSystemStatus {
	mut obj := &Class_ActionScheduler_wcSystemStatus{
		PhpObjectBase: rt.PhpObjectBase{}
		store:         rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_actionscheduler_versions() &Class_ActionScheduler_Versions {
	mut obj := &Class_ActionScheduler_Versions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_store() &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_wcSystemStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'render' {
			this.render()
			return rt.new_null()
		}
		'get_oldest_and_newest' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_oldest_and_newest(dispatch_arg_0)
		}
		'get_action_status_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_action_status_date(dispatch_arg_0, dispatch_arg_1)
		}
		'get_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.get_template(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'__call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.magic_call(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_wcSystemStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'store' { return this.store }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_wcSystemStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'store' {
			this.store = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_ActionScheduler_Versions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Versions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Versions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ActionScheduler_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_actionscheduler_wcsystemstatus_php() {
}
