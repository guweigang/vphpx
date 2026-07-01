import rt

pub fn Class_WC_Notes_Run_Db_Update.note_name() string {
	return 'wc-update-db-reminder'
}
struct Class_WC_Notes_Run_Db_Update {
	rt.PhpObjectBase
}

fn Class_WC_Notes_Run_Db_Update.maybe_update_notice(var_note rt.PhpVal) rt.PhpVal {
	mut var_note_mutated := var_note
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_note_mutated, 'Automattic_WooCommerce_Admin_Notes_Note')))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return var_note_mutated.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('update'), fn () rt.PhpVal { mut temp := Class_WC_Admin_Notices{}; return temp.get_notices() }(), rt.new_bool(true)]))))) {
		rt.call_method(var_note_mutated, 'set_status', [Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned()])
		rt.call_method(var_note_mutated, 'save', []rt.PhpVal{})
		return var_note_mutated.dup()
	}
	mut var_needs_db_update := fn () rt.PhpVal { mut temp := Class_WC_Install{}; return temp.needs_db_update() }()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_needs_db_update)))) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			Class_WC_Notes_Run_Db_Update.update_done_notice(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Notes_Note](var_note_mutated))
		}
	} else {
		mut var_next_scheduled_date := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'get_next', [rt.new_string('woocommerce_run_update_callback'), rt.new_null(), rt.new_string('woocommerce-db-updates')])
		if rt.is_true(var_next_scheduled_date) {
			Class_WC_Notes_Run_Db_Update.update_in_progress_notice(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Notes_Note](var_note_mutated))
		} else {
			Class_WC_Notes_Run_Db_Update.update_needed_notice(mut rt.cast_object_ptr[Class_?Note](var_note_mutated))
		}
	}
	return var_note_mutated.dup()
}

fn Class_WC_Notes_Run_Db_Update.get_current_notice() rt.PhpVal {
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('admin-note'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return rt.new_null()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [Class_WC_Notes_Run_Db_Update.note_name()])
	if !rt.is_true(var_note_ids) {
		return rt.new_null()
	}
	mut var_current_note_id := rt.call_function('array_shift', [var_note_ids.dup()])
	{
		mut iter_1 := var_note_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_note_id := item_1.val
			mut var_note := create_automattic_woocommerce_admin_notes_note(var_note_id.dup())
			rt.call_method(var_data_store, 'delete', [var_note.dup()])
		}
	}
	return create_automattic_woocommerce_admin_notes_note(var_current_note_id.dup())
}

fn Class_WC_Notes_Run_Db_Update.set_notice_actioned()  {
	mut var_note := Class_WC_Notes_Run_Db_Update.get_current_notice()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		return rt.new_null()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(var_note, 'set_status', [Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned()])
		rt.call_method(var_note, 'save', []rt.PhpVal{})
	}
}

fn Class_WC_Notes_Run_Db_Update.note_up_to_date(var_note rt.PhpVal, var_update_url rt.PhpVal, var_current_actions rt.PhpVal) bool {
	mut var_note_mutated := var_note
	mut var_update_url_mutated := var_update_url
	mut var_actions := rt.call_method(var_note_mutated, 'get_actions', []rt.PhpVal{})
	return rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_note_mutated, 'get_id', []rt.PhpVal{})) && var_current_actions.dup().array_count() == rt.call_function('array_intersect', [rt.call_function('wp_list_pluck', [var_actions.dup(), rt.new_string('name')]), var_current_actions.dup()]).array_count())) && rt.is_true(rt.call_function('in_array', [var_update_url_mutated.dup(), rt.call_function('wp_list_pluck', [var_actions.dup(), rt.new_string('query')]), rt.new_bool(true)]))
}

fn Class_WC_Notes_Run_Db_Update.update_needed_notice(mut var_note Class_?Note) rt.PhpVal {
	mut var_note_mutated := var_note
	if rt.is_true(rt.new_bool(var_note_mutated.dup().is_null())) {
		var_note_mutated = create_automattic_woocommerce_admin_notes_note()
	}
	mut var_update_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'do_update_woocommerce', val: 'true' }, rt.ArrayItem{ key: 'return_url', val: 'wc-admin-referer' }]), rt.call_function('admin_url', []rt.PhpVal{})])
	mut var_note_actions := [[rt.new_string('update-db_run'), rt.call_function('__', [rt.new_string('Update WooCommerce Database'), rt.new_string('woocommerce')]), var_update_url, rt.new_string('unactioned'), rt.new_bool(true), rt.new_string('wc_db_update'), rt.new_string('wc_db_update_nonce')], [rt.new_string('update-db_learn-more'), rt.call_function('__', [rt.new_string('Learn more about updates'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/document/how-to-update-woocommerce/'), rt.new_string('unactioned'), rt.new_bool(false)]]
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_note_mutated, 'get_is_deleted', []rt.PhpVal{}))))) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned(), rt.call_method(var_note_mutated, 'get_status', []rt.PhpVal{}))))) && rt.is_true(Class_WC_Notes_Run_Db_Update.note_up_to_date(rt.new_object('?Note', []string{}, var_note_mutated), var_update_url.dup(), rt.call_function('wp_list_pluck', [var_note_actions.dup(), rt.new_string('name')]))))) {
		return rt.new_object('?Note', []string{}, var_note_mutated)
	}
	rt.call_method(var_note_mutated, 'set_title', [rt.call_function('__', [rt.new_string('WooCommerce database update required'), rt.new_string('woocommerce')])])
	rt.call_method(var_note_mutated, 'set_content', [rt.concat(rt.call_function('__', [rt.new_string('WooCommerce has been updated! To keep things running smoothly, we have to update your database to the newest version.'), rt.new_string('woocommerce')]), rt.call_function('sprintf', [' ' + (rt.call_function('esc_html__', [rt.new_string('The database update process runs in the background and may take a little while, so please be patient. Advanced users can alternatively update via %1$sWP CLI%2$s.'), rt.new_string('woocommerce')])).str(), rt.new_string('<a href="https://developer.woocommerce.com/docs/wc-cli/wc-cli-examples/#upgrading-the-database-using-wp-cli">'), rt.new_string('</a>')]))])
	rt.call_method(var_note_mutated, 'set_type', [Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_update()])
	rt.call_method(var_note_mutated, 'set_name', [Class_WC_Notes_Run_Db_Update.note_name()])
	rt.call_method(var_note_mutated, 'set_content_data', [// unsupported expression: Expr_Cast_Object])
	rt.call_method(var_note_mutated, 'set_source', [rt.new_string('woocommerce-core')])
	rt.call_method(var_note_mutated, 'set_status', [Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned()])
	rt.call_method(var_note_mutated, 'set_is_deleted', [rt.new_bool(false)])
	rt.call_method(var_note_mutated, 'clear_actions', []rt.PhpVal{})
	for var_note_action in var_note_actions {
		rt.call_method(var_note_mutated, 'add_action', [rt.call_function('array_values', [var_note_action.dup()])])
		if var_note_action.array_isset(rt.new_string('nonce_action')) {
			rt.call_method(var_note_mutated, 'add_nonce_to_action', [var_note_action.array_get('name'), var_note_action.array_get('nonce_action'), var_note_action.array_get('nonce_name')])
		}
	}
	rt.call_method(var_note_mutated, 'save', []rt.PhpVal{})
	return rt.new_null()
}

fn Class_WC_Notes_Run_Db_Update.update_in_progress_notice(mut var_note Class_Automattic_WooCommerce_Admin_Notes_Note)  {
	mut var_note_mutated := var_note
	mut var_pending_actions_url := rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-status&tab=action-scheduler&s=woocommerce_run_update&status=pending')])
	mut var_cron_disabled := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('DISABLE_WP_CRON'))
	mut var_cron_cta := if rt.is_true(var_cron_disabled) { rt.call_function('__', [rt.new_string('You can manually run queued updates here.'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [rt.new_string('View progress →'), rt.new_string('woocommerce')]) }
	rt.call_method(var_note_mutated, 'set_title', [rt.call_function('__', [rt.new_string('WooCommerce database update in progress'), rt.new_string('woocommerce')])])
	rt.call_method(var_note_mutated, 'set_content', [rt.call_function('__', [rt.new_string('WooCommerce is updating the database in the background. The database update process may take a little while, so please be patient.'), rt.new_string('woocommerce')])])
	rt.call_method(var_note_mutated, 'set_is_deleted', [rt.new_bool(false)])
	rt.call_method(var_note_mutated, 'clear_actions', []rt.PhpVal{})
	rt.call_method(var_note_mutated, 'add_action', [rt.new_string('update-db_see-progress'), var_cron_cta.dup(), var_pending_actions_url.dup(), rt.new_string('unactioned'), rt.new_bool(false)])
	rt.call_method(var_note_mutated, 'save', []rt.PhpVal{})
}

fn Class_WC_Notes_Run_Db_Update.update_done_notice(mut var_note Class_Automattic_WooCommerce_Admin_Notes_Note)  {
	mut var_note_mutated := var_note
	mut var_hide_notices_url := rt.call_function('html_entity_decode', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'wc-hide-notice', val: 'update' }]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings')])])])
	mut var_note_actions := [[rt.new_string('update-db_done'), rt.call_function('__', [rt.new_string('Thanks!'), rt.new_string('woocommerce')]), var_hide_notices_url, rt.new_string('actioned'), rt.new_bool(true), rt.new_string('woocommerce_hide_notices_nonce'), rt.new_string('_wc_notice_nonce')]]
	if rt.is_true(Class_WC_Notes_Run_Db_Update.note_up_to_date(rt.new_object('Automattic_WooCommerce_Admin_Notes_Note', []string{}, var_note_mutated), var_hide_notices_url.dup(), rt.call_function('wp_list_pluck', [var_note_actions.dup(), rt.new_string('name')]))) {
		return rt.new_null()
	}
	rt.call_method(var_note_mutated, 'set_title', [rt.call_function('__', [rt.new_string('WooCommerce database update done'), rt.new_string('woocommerce')])])
	rt.call_method(var_note_mutated, 'set_content', [rt.call_function('__', [rt.new_string('WooCommerce database update complete. Thank you for updating to the latest version!'), rt.new_string('woocommerce')])])
	rt.call_method(var_note_mutated, 'set_is_deleted', [rt.new_bool(false)])
	rt.call_method(var_note_mutated, 'clear_actions', []rt.PhpVal{})
	for var_note_action in var_note_actions {
		rt.call_method(var_note_mutated, 'add_action', [rt.call_function('array_values', [var_note_action.dup()])])
		if var_note_action.array_isset(rt.new_string('nonce_action')) {
			rt.call_method(var_note_mutated, 'add_nonce_to_action', [var_note_action.array_get('name'), var_note_action.array_get('nonce_action'), var_note_action.array_get('nonce_name')])
		}
	}
	rt.call_method(var_note_mutated, 'save', []rt.PhpVal{})
}

fn Class_WC_Notes_Run_Db_Update.add_notice()  {
	mut var_note := Class_WC_Notes_Run_Db_Update.get_current_notice()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		var_note = create_automattic_woocommerce_admin_notes_note()
		rt.call_method(var_note, 'set_name', [Class_WC_Notes_Run_Db_Update.note_name()])
		rt.call_method(var_note, 'save', []rt.PhpVal{})
	}
	Class_WC_Notes_Run_Db_Update.maybe_update_notice(var_note.dup())
}

fn Class_WC_Notes_Run_Db_Update.show_reminder()  {
	mut var_needs_db_update := fn () rt.PhpVal { mut temp := Class_WC_Install{}; return temp.needs_db_update() }()
	mut var_note_id := Class_WC_Notes_Run_Db_Update.get_current_notice()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_needs_db_update)))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_note_id)))) {
			return rt.new_null()
		}
		mut var_note := create_automattic_woocommerce_admin_notes_note(var_note_id.dup())
		if rt.is_true(rt.identical(Class_{"nodeType":"Expr_Variable","line":324,"name":"note"}.e_wc_admin_note_actioned(), rt.call_method(var_note, 'get_status', []rt.PhpVal{}))) {
			return rt.new_null()
		} else {
			Class_WC_Notes_Run_Db_Update.update_done_notice(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Notes_Note](var_note))
			return rt.new_null()
		}
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_note_id)))) {
			Class_WC_Notes_Run_Db_Update.update_needed_notice()
			return rt.new_null()
		}
		var_note = create_automattic_woocommerce_admin_notes_note(var_note_id.dup())
		mut var_next_scheduled_date := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'get_next', [rt.new_string('woocommerce_run_update_callback'), rt.new_null(), rt.new_string('woocommerce-db-updates')])
		if rt.is_true(rt.new_bool(rt.is_true(var_next_scheduled_date) || !(!rt.is_true(rt.get_superglobal('_GET').array_get('do_update_woocommerce'))))) {
			Class_WC_Notes_Run_Db_Update.update_in_progress_notice(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Notes_Note](var_note))
		} else {
			Class_WC_Notes_Run_Db_Update.update_needed_notice(mut rt.cast_object_ptr[Class_?Note](var_note))
		}
	}
}

struct Class_WC_Admin_Notices {
	rt.PhpObjectBase
}

struct Class_WC_Install {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_notes_run_db_update() &Class_WC_Notes_Run_Db_Update {
	mut obj := &Class_WC_Notes_Run_Db_Update{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_notices() &Class_WC_Admin_Notices {
	mut obj := &Class_WC_Admin_Notices{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_install() &Class_WC_Install {
	mut obj := &Class_WC_Install{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_note() &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Notes_Run_Db_Update) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'maybe_update_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Notes_Run_Db_Update.maybe_update_notice(dispatch_arg_0)
		}
		'get_current_notice' {
			return Class_WC_Notes_Run_Db_Update.get_current_notice()
		}
		'set_notice_actioned' {
			Class_WC_Notes_Run_Db_Update.set_notice_actioned()
			return rt.new_null()
		}
		'note_up_to_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Notes_Run_Db_Update.note_up_to_date(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'update_needed_notice' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?Note](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WC_Notes_Run_Db_Update.update_needed_notice(mut dispatch_arg_0)
		}
		'update_in_progress_notice' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Notes_Note](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_WC_Notes_Run_Db_Update.update_in_progress_notice(mut dispatch_arg_0)
			return rt.new_null()
		}
		'update_done_notice' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Notes_Note](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_WC_Notes_Run_Db_Update.update_done_notice(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_notice' {
			Class_WC_Notes_Run_Db_Update.add_notice()
			return rt.new_null()
		}
		'show_reminder' {
			Class_WC_Notes_Run_Db_Update.show_reminder()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Notes_Run_Db_Update) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Notes_Run_Db_Update) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_Notices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Notices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Notices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Install) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Install) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Install) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_notes_class_wc_notes_run_db_update_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
