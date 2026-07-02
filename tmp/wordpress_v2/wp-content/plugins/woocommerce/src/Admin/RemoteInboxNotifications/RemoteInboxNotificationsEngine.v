import rt

pub fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.stored_state_option_name() string {
	return 'wc_remote_inbox_notifications_stored_state'
}

pub fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.wca_updated_option_name() string {
	return 'wc_remote_inbox_notifications_wca_updated'
}

struct Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.init() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'on_init' }]),
		rt.new_int(0), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'on_admin_init' }])])
	rt.call_function('add_action', [
		rt.new_string('update_option_' +(Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option()).str()),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'update_profile_option' }]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_run_on_woocommerce_admin_updated'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'run_on_woocommerce_admin_updated' }]),
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_next_hook := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
			'queue', []rt.PhpVal{}), 'get_next', [
			rt.new_string('woocommerce_run_on_woocommerce_admin_updated'),
			rt.new_array(),
			rt.new_string('woocommerce-remote-inbox-engine'),
		])
		if rt.is_true(rt.identical(rt.new_null(), var_next_hook)) {
			rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue',
				[]rt.PhpVal{}), 'schedule_single', [
				rt.call_function('time', []rt.PhpVal{}),
				rt.new_string('woocommerce_run_on_woocommerce_admin_updated'),
				rt.new_array(),
				rt.new_string('woocommerce-remote-inbox-engine'),
			])
		}
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_updated'),
		rt.new_closure(closure_1_fn)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_note_from_db'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'get_note_from_db' }]),
		rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_debug_tools'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_debug_tools' }])])
	rt.call_function('add_action', [
		rt.new_string('wp_ajax_woocommerce_json_inbox_notifications_search'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'ajax_action_inbox_notification_search' }]),
	])
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.update_profile_option(var_old_value rt.PhpVal, var_new_value rt.PhpVal) {
	if ((var_old_value.array_isset(rt.new_string('completed'))
		&& rt.is_true(var_old_value.array_get(rt.new_string('completed'))))
		|| !(var_new_value.array_isset(rt.new_string('completed'))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_new_value.array_get(rt.new_string('completed')))))) {
		return
	}
	Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.run()
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.on_admin_init() {
	rt.call_function('add_action', [rt.new_string('activated_plugin'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'run' }])])
	rt.call_function('add_action', [rt.new_string('deactivated_plugin'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'run_on_deactivated_plugin' }]),
		rt.new_int(10), rt.new_int(1)])
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts{}
	mut iife_result_1 := iife_temp_1.admin_init()
	Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.get_stored_state()
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.on_init() {
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts{}
	mut iife_result_2 := iife_temp_2.init()
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.run() {
	mut iife_temp_3 :=
		Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller{}
	mut iife_result_3 := iife_temp_3.get_instance()
	mut var_specs := rt.call_method(iife_result_3, 'get_specs_from_data_sources', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), var_specs))
		|| !(rt.call_function('is_countable', [var_specs.clone()]))
		|| var_specs.clone().array_count() == 0 {
		return
	}
	mut var_stored_state :=
		Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.get_stored_state()
	mut var_errors := rt.new_array()
	mut iter_1 := var_specs.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_spec := item_1.val
		mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner{}
		mut iife_result_4 := iife_temp_4.run_spec(var_spec.clone(), var_stored_state.clone())
		mut var_error := iife_result_4
		if !var_error.is_null() {
			var_errors.array_push(var_error.clone())
		}
	}
	if var_errors.clone().array_count() > 0 {
		mut iife_temp_5 :=
			Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine{}
		mut iife_result_5 := iife_temp_5.log_errors(var_errors.clone())
	}
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.run_on_woocommerce_admin_updated() {
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.wca_updated_option_name(),
		rt.new_bool(true),
		rt.new_bool(false),
	])
	Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.run()
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.wca_updated_option_name(),
		rt.new_bool(false),
		rt.new_bool(false),
	])
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.get_stored_state() rt.PhpVal {
	mut var_stored_state := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.stored_state_option_name(),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_stored_state))
		|| !(var_stored_state.clone().is_object()) {
		var_stored_state = create_automattic_woocommerce_admin_remoteinboxnotifications_stdclass()
		mut iife_temp_6 :=
			Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts{}
		mut iife_result_6 := iife_temp_6.init_stored_state(var_stored_state.clone())
		var_stored_state = iife_result_6
		rt.call_function('update_option', [
			Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.stored_state_option_name(),
			var_stored_state.clone(),
			rt.new_bool(false),
		])
	}
	return var_stored_state.clone()
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.run_on_deactivated_plugin(var_plugin rt.PhpVal) {
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider{}
	mut iife_result_7 := iife_temp_7.set_deactivated_plugin(var_plugin.clone())
	Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.run()
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.update_stored_state(var_stored_state rt.PhpVal) {
	mut var_stored_state_mutated := var_stored_state
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.stored_state_option_name(),
		var_stored_state_mutated.clone(),
		rt.new_bool(false),
	])
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.get_note_from_db(var_note_from_db rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_note_from_db, 'Automattic_WooCommerce_Admin_Notes_Note'))))))
		|| rt.is_true(rt.identical(rt.call_function('get_user_locale', []rt.PhpVal{}), rt.call_method(var_note_from_db, 'get_locale', []rt.PhpVal{}))) {
		return var_note_from_db.clone()
	}
	mut iife_temp_8 :=
		Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller{}
	mut iife_result_8 := iife_temp_8.get_instance()
	mut var_specs := rt.call_method(iife_result_8, 'get_specs_from_data_sources', []rt.PhpVal{})
	mut iter_2 := var_specs.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_spec := item_2.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_spec, 'slug'), rt.call_method(var_note_from_db,
			'get_name', []rt.PhpVal{})))))
		{
			continue
		}
		mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner{}
		mut iife_result_9 := iife_temp_9.get_locale(rt.get_property(var_spec, 'locales'),
			rt.new_bool(true))
		mut var_locale := iife_result_9
		if rt.is_true(rt.identical(rt.new_null(), var_locale)) {
			break
		}
		mut iife_temp_10 := Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner{}
		mut iife_result_10 := iife_temp_10.get_actions(var_spec.clone())
		mut var_localized_actions := iife_result_10
		mut iter_3 := var_localized_actions.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_localized_action := item_3.val
			mut var_action := rt.call_method(var_note_from_db, 'get_action', [
				rt.get_property(var_localized_action, 'name'),
			])
			if rt.is_true(var_action) {
				rt.set_property(var_localized_action, 'id', rt.get_property(var_action, 'id'))
			}
		}
		rt.call_method(var_note_from_db, 'set_title', [
			rt.get_property(var_locale, 'title'),
		])
		rt.call_method(var_note_from_db, 'set_content', [
			rt.get_property(var_locale, 'content'),
		])
		rt.call_method(var_note_from_db, 'set_actions', [var_localized_actions.clone()])
	}
	return var_note_from_db.clone()
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.add_debug_tools(var_tools rt.PhpVal) bool {
	mut var_tools_mutated := var_tools
	mut iife_temp_11 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_11 := iife_temp_11.is_enabled(rt.new_string('remote-inbox-notifications'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_11)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_show_marketplace_suggestions'),
		rt.new_string('yes'),
	]), rt.new_string('yes')))))
	{
		return false
	}
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut iife_temp_13 :=
			Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller{}
		mut iife_result_13 := iife_temp_13.get_instance()
		rt.call_method(iife_result_13, 'read_specs_from_data_sources', []rt.PhpVal{})
		Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.run()
		return (rt.call_function('__', [
			rt.new_string('Remote inbox notifications have been refreshed'),
			rt.new_string('woocommerce'),
		])).to_bool()
	}
	var_tools_mutated.array_set('refresh_remote_inbox_notifications', rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Refresh Remote Inbox Notifications'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
			rt.new_string('Refresh'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
			rt.new_string('This will refresh the remote inbox notifications'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_14_fn) },
	]))
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_function('check_ajax_referer', [rt.new_string('debug_action'),
			rt.new_string('_wpnonce')])
		if !(rt.get_superglobal('_GET').array_isset(rt.new_string('delete_inbox_notification_note_id'))) {
			return (rt.call_function('__', [
				rt.new_string('No inbox notification selected'),
				rt.new_string('woocommerce'),
			])).to_bool()
		}
		mut var_note_id := rt.call_function('wc_clean', [
			rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_GET').array_get(rt.new_string('delete_inbox_notification_note_id')),
				]),
			]),
		])
		mut iife_temp_15 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
		mut iife_result_15 := iife_temp_15.get_note(var_note_id.clone())
		mut var_note := iife_result_15
		if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
			return (rt.call_function('__', [
				rt.new_string('Inbox notification not found'),
				rt.new_string('woocommerce'),
			])).to_bool()
		}
		rt.call_method(var_note, 'delete', [rt.new_bool(true)])
		return (rt.call_function('__', [
			rt.new_string('Inbox notification has been deleted'),
			rt.new_string('woocommerce'),
		])).to_bool()
	}
	var_tools_mutated.array_set('delete_inbox_notification', rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Delete an Inbox Notification'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
			rt.new_string('Delete'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
			rt.new_string('This will delete an inbox notification by slug'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'selector', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Select an inbox notification to delete:'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'class', val: 'wc-product-search' },
			rt.ArrayItem{ key: 'search_action', val: 'woocommerce_json_inbox_notifications_search' },
			rt.ArrayItem{ key: 'name', val: 'delete_inbox_notification_note_id' },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('esc_attr__', [
				rt.new_string('Search for an inbox notification&hellip;'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_16_fn) },
	]))
	return var_tools_mutated.to_bool()
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.ajax_action_inbox_notification_search() {
	mut var_wpdb := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('search-products'),
		rt.new_string('security')])
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('term'))) {
		rt.call_function('wp_send_json', [rt.new_array()])
	}
	mut var_search := rt.call_function('wc_clean', [
		rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_GET').array_get(rt.new_string('term'))]),
		]),
	])
	mut var_results := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT note_id, name FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('wc_admin_notes WHERE name LIKE %s')),
			rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [var_search.clone()])).str() +
				'%'),
		]),
	])
	mut var_rows := rt.new_array()
	mut iter_4 := var_results.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_result := item_4.val
		var_rows.array_set(rt.get_property(var_result, 'note_id'), rt.get_property(var_result,
			'name'))
	}
	rt.call_function('wp_send_json', [var_rows.clone()])
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_stdClass {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remoteinboxnotifications_remoteinboxnotificationsengine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_remotespecsengine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_storedstatesetupforproducts(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remoteinboxnotifications_remoteinboxnotificationsdatasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remoteinboxnotifications_specrunner(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remoteinboxnotifications_stdclass(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_stdClass {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pluginsprovider_pluginsprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.init()
			return rt.new_null()
		}
		'update_profile_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.update_profile_option(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'on_admin_init' {
			Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.on_admin_init()
			return rt.new_null()
		}
		'on_init' {
			Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.on_init()
			return rt.new_null()
		}
		'run' {
			Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.run()
			return rt.new_null()
		}
		'run_on_woocommerce_admin_updated' {
			Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.run_on_woocommerce_admin_updated()
			return rt.new_null()
		}
		'get_stored_state' {
			return Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.get_stored_state()
		}
		'run_on_deactivated_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.run_on_deactivated_plugin(dispatch_arg_0)
			return rt.new_null()
		}
		'update_stored_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.update_stored_state(dispatch_arg_0)
			return rt.new_null()
		}
		'get_note_from_db' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.get_note_from_db(dispatch_arg_0)
		}
		'add_debug_tools' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.add_debug_tools(dispatch_arg_0))
		}
		'ajax_action_inbox_notification_search' {
			Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine.ajax_action_inbox_notification_search()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateSetupForProducts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
