import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Events {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
		note_classes_to_added_or_updated rt.PhpVal = rt.new_array()
		other_note_classes rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) construct()  {
}

fn Class_Automattic_WooCommerce_Internal_Admin_Events.instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) init()  {
	rt.call_function('add_action', [rt.new_string('wc_admin_daily'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Events', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'do_wc_admin_daily' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_note_from_db'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Events', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_note_from_db' }]), rt.new_int(10), rt.new_int(1)])
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WC_Notes_Refund_Returns{}; return temp.init() }()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) do_wc_admin_daily()  {
	this.possibly_add_notes()
	this.possibly_delete_notes()
	this.possibly_update_notes()
	this.possibly_refresh_data_source_pollers()
	if this.is_remote_inbox_notifications_enabled() {
		fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine{}; return temp.run() }()
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('core-profiler'))) {
		rt.call_method(create_automattic_woocommerce_internal_admin_schedulers_mailchimpscheduler(), 'run', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) get_note_from_db(var_note_from_db rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_note_from_db, 'Automattic_WooCommerce_Admin_Notes_Note')))))) || rt.is_true(rt.identical(rt.call_function('get_user_locale', []rt.PhpVal{}), rt.call_method(var_note_from_db, 'get_locale', []rt.PhpVal{}))))) {
		return var_note_from_db.dup()
	}
	mut var_note_classes := rt.call_function('array_merge', [// unsupported expression: Expr_StaticPropertyFetch, // unsupported expression: Expr_StaticPropertyFetch])
	{
		mut iter_1 := var_note_classes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_note_class := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string("${var_note_class.to_string()}::NOTE_NAME")])) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":165,"name":"note_class"}.note_name(), rt.call_method(var_note_from_db, 'get_name', []rt.PhpVal{}))))) {
				mut var_note_from_class := if rt.is_true(rt.call_function('method_exists', [var_note_class.dup(), rt.new_string('get_note')])) { fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":166,"name":"note_class"}{}; return temp.get_note() }() } else { rt.new_null() }
				if rt.is_true(rt.new_bool(rt.instance_of(var_note_from_class, 'Automattic_WooCommerce_Admin_Notes_Note'))) {
					mut var_note := // unsupported expression: Expr_Clone
					rt.call_method(var_note, 'set_title', [rt.call_method(var_note_from_class, 'get_title', []rt.PhpVal{})])
					rt.call_method(var_note, 'set_content', [rt.call_method(var_note_from_class, 'get_content', []rt.PhpVal{})])
					mut var_actions := rt.call_method(var_note_from_class, 'get_actions', []rt.PhpVal{})
					{
						mut iter_2 := var_actions.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_action := item_2.val
							mut var_matching_action := rt.call_method(var_note, 'get_action', [rt.get_property(var_action, 'name')])
							if rt.is_true(rt.new_bool(rt.is_true(var_matching_action) && rt.is_true(rt.get_property(var_matching_action, 'id')))) {
								rt.set_property(var_action, 'id', rt.get_property(var_matching_action, 'id'))
							}
						}
					}
					rt.call_method(var_note, 'set_actions', [var_actions.dup()])
					return var_note.dup()
				}
				break
			}
		}
	}
	return var_note_from_db.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) possibly_add_notes()  {
	{
		mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_note_class := item_1.val
			if rt.is_true(rt.call_function('method_exists', [var_note_class.dup(), rt.new_string('possibly_add_note')])) {
				fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":194,"name":"note_class"}{}; return temp.possibly_add_note() }()
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) possibly_delete_notes()  {
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater{}; return temp.delete_if_not_applicable() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsMoreInfoNeeded{}; return temp.delete_if_not_applicable() }()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) possibly_update_notes()  {
	{
		mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_note_class := item_1.val
			if rt.is_true(rt.call_function('method_exists', [var_note_class.dup(), rt.new_string('possibly_update_note')])) {
				fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":213,"name":"note_class"}{}; return temp.possibly_update_note() }()
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) is_remote_inbox_notifications_enabled() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('remote-inbox-notifications')))))) {
		return false
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) is_merchant_email_notifications_enabled() bool {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) possibly_refresh_data_source_pollers()  {
	mut var_completed_tasks := rt.call_function('get_option', [rt.new_string('woocommerce_task_list_tracked_completed_tasks'), rt.new_array()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('payments'), var_completed_tasks.dup(), rt.new_bool(true)]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('woocommerce-payments'), var_completed_tasks.dup(), rt.new_bool(true)]))))))) {
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller{}; return temp.get_instance() }(), 'get_specs_from_data_sources', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('store_details'), var_completed_tasks.dup(), rt.new_bool(true)]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('marketing'), var_completed_tasks.dup(), rt.new_bool(true)]))))))) {
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller{}; return temp.get_instance() }(), 'get_specs_from_data_sources', []rt.PhpVal{})
	}
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_Notes_Refund_Returns {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":166,"name":"note_class"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":194,"name":"note_class"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsMoreInfoNeeded {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":213,"name":"note_class"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_events() &Class_Automattic_WooCommerce_Internal_Admin_Events {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Events{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
		note_classes_to_added_or_updated: rt.new_array()
		other_note_classes: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_notes_refund_returns() &Class_Automattic_WooCommerce_Internal_Admin_WC_Notes_Refund_Returns {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_Notes_Refund_Returns{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remoteinboxnotifications_remoteinboxnotificationsengine() &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_mailchimpscheduler() &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_{"nodetype":"expr_variable","line":166,"name":"note_class"}() &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":166,"name":"note_class"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":166,"name":"note_class"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_{"nodetype":"expr_variable","line":194,"name":"note_class"}() &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":194,"name":"note_class"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":194,"name":"note_class"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_paymentsremindmelater() &Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_paymentsmoreinfoneeded() &Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsMoreInfoNeeded {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsMoreInfoNeeded{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_{"nodetype":"expr_variable","line":213,"name":"note_class"}() &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":213,"name":"note_class"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":213,"name":"note_class"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_paymentgatewaysuggestionsdatasourcepoller() &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_remotefreeextensionsdatasourcepoller() &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_Events.instance()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'do_wc_admin_daily' {
			this.do_wc_admin_daily()
			return rt.new_null()
		}
		'get_note_from_db' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_note_from_db(dispatch_arg_0)
		}
		'possibly_add_notes' {
			this.possibly_add_notes()
			return rt.new_null()
		}
		'possibly_delete_notes' {
			this.possibly_delete_notes()
			return rt.new_null()
		}
		'possibly_update_notes' {
			this.possibly_update_notes()
			return rt.new_null()
		}
		'is_remote_inbox_notifications_enabled' {
			return rt.new_bool(this.is_remote_inbox_notifications_enabled())
		}
		'is_merchant_email_notifications_enabled' {
			return rt.new_bool(this.is_merchant_email_notifications_enabled())
		}
		'possibly_refresh_data_source_pollers' {
			this.possibly_refresh_data_source_pollers()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Events) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'note_classes_to_added_or_updated' { return this.note_classes_to_added_or_updated }
		'other_note_classes' { return this.other_note_classes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		'note_classes_to_added_or_updated' { this.note_classes_to_added_or_updated = val; return true }
		'other_note_classes' { this.other_note_classes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Notes_Refund_Returns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_Notes_Refund_Returns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Notes_Refund_Returns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":166,"name":"note_class"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":166,"name":"note_class"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":166,"name":"note_class"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":194,"name":"note_class"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":194,"name":"note_class"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":194,"name":"note_class"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsMoreInfoNeeded) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsMoreInfoNeeded) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsMoreInfoNeeded) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":213,"name":"note_class"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":213,"name":"note_class"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":213,"name":"note_class"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_events_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
