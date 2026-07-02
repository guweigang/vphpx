import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Events {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_events() {
		rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Events', 'instance', rt.new_null())
		rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Events', 'note_classes_to_added_or_updated', rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizeStoreWithBlocks.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_CustomizingProductCatalog.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_EditProductsOnTheMove.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_EmailImprovements.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_EUVATNumber.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_FirstProduct.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_LaunchChecklist.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_ManageOrdersOnTheGo.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_MigrateFromShopify.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_MobileApp.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_OnboardingPayments.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_OnlineClothingStore.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsMoreInfoNeeded.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_PerformanceOnMobile.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_PersonalizeStore.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_RealTimeOrderAlerts.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommerceSubscriptions.class() }]))
		rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Events', 'other_note_classes', rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles.class() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.class() }]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) construct() {
}

fn Class_Automattic_WooCommerce_Internal_Admin_Events.instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Events', 'instance'))) {
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_Events', 'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_static', []string{}, create_automattic_woocommerce_internal_admin_static()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Events', 'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) init() {
	rt.call_function('add_action', [rt.new_string('wc_admin_daily'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Events', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'do_wc_admin_daily' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_note_from_db'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Events', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_note_from_db' }]), rt.new_int(10), rt.new_int(1)])
mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_WC_Notes_Refund_Returns{}
mut iife_result_0 := iife_temp_0.init()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) do_wc_admin_daily() {
	this.possibly_add_notes()
	this.possibly_delete_notes()
	this.possibly_update_notes()
	this.possibly_refresh_data_source_pollers()
	if this.is_remote_inbox_notifications_enabled() {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine{}
	mut iife_result_1 := iife_temp_1.run()
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_2 := iife_temp_2.is_enabled(rt.new_string('core-profiler'))
	if rt.is_true(iife_result_2) {
		rt.call_method(create_automattic_woocommerce_internal_admin_schedulers_mailchimpscheduler(), 'run', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) get_note_from_db(var_note_from_db rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_note_from_db, 'Automattic_WooCommerce_Admin_Notes_Note')))))) || rt.is_true(rt.identical(rt.call_function('get_user_locale', []rt.PhpVal{}), rt.call_method(var_note_from_db, 'get_locale', []rt.PhpVal{}))) {
		return var_note_from_db.clone()
	}
	mut var_note_classes := rt.call_function('array_merge', [rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Events', 'note_classes_to_added_or_updated'), rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Events', 'other_note_classes')])
	mut iter_1 := var_note_classes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_note_class := item_1.val
		if rt.is_true(rt.call_function('defined', [rt.new_string("${var_note_class.to_string()}::NOTE_NAME")])) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":165,"name":"note_class"}.note_name(), rt.call_method(var_note_from_db, 'get_name', []rt.PhpVal{}))) {
			mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":166,"name":"note_class"}{}
			mut iife_result_3 := iife_temp_3.get_note()
			mut var_note_from_class := if rt.is_true(rt.call_function('method_exists', [var_note_class.clone(), rt.new_string('get_note')])) { iife_result_3 } else { rt.new_null() }
			if rt.is_true(rt.new_bool(rt.instance_of(var_note_from_class, 'Automattic_WooCommerce_Admin_Notes_Note'))) {
				mut var_note := var_note_from_db.dup()
				rt.call_method(var_note, 'set_title', [rt.call_method(var_note_from_class, 'get_title', []rt.PhpVal{})])
				rt.call_method(var_note, 'set_content', [rt.call_method(var_note_from_class, 'get_content', []rt.PhpVal{})])
				mut var_actions := rt.call_method(var_note_from_class, 'get_actions', []rt.PhpVal{})
				mut iter_2 := var_actions.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_action := item_2.val
					mut var_matching_action := rt.call_method(var_note, 'get_action', [rt.get_property(var_action, 'name')])
					if rt.is_true(var_matching_action) && rt.is_true(rt.get_property(var_matching_action, 'id')) {
						rt.set_property(var_action, 'id', rt.get_property(var_matching_action, 'id'))
					}
				}
				rt.call_method(var_note, 'set_actions', [var_actions.clone()])
				return var_note.clone()
			}
			break
		}
	}
	return var_note_from_db.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) possibly_add_notes() {
	mut iter_3 := rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Events', 'note_classes_to_added_or_updated').iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_note_class := item_3.val
		if rt.is_true(rt.call_function('method_exists', [var_note_class.clone(), rt.new_string('possibly_add_note')])) {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":194,"name":"note_class"}{}
		mut iife_result_4 := iife_temp_4.possibly_add_note()
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) possibly_delete_notes() {
mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater{}
mut iife_result_5 := iife_temp_5.delete_if_not_applicable()
mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsMoreInfoNeeded{}
mut iife_result_6 := iife_temp_6.delete_if_not_applicable()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) possibly_update_notes() {
	mut iter_4 := rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Events', 'note_classes_to_added_or_updated').iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_note_class := item_4.val
		if rt.is_true(rt.call_function('method_exists', [var_note_class.clone(), rt.new_string('possibly_update_note')])) {
		mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":213,"name":"note_class"}{}
		mut iife_result_7 := iife_temp_7.possibly_update_note()
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) is_remote_inbox_notifications_enabled() bool {
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_8 := iife_temp_8.is_enabled(rt.new_string('remote-inbox-notifications'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_8)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_show_marketplace_suggestions'), rt.new_string('yes')]), rt.new_string('yes'))))) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) is_merchant_email_notifications_enabled() bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_merchant_email_notifications'), rt.new_string('no')]), rt.new_string('yes'))))) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) possibly_refresh_data_source_pollers() {
	mut var_completed_tasks := rt.call_function('get_option', [rt.new_string('woocommerce_task_list_tracked_completed_tasks'), rt.new_array()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('payments'), var_completed_tasks.clone(), rt.new_bool(true)]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('woocommerce-payments'), var_completed_tasks.clone(), rt.new_bool(true)]))))) {
		mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller{}
		mut iife_result_9 := iife_temp_9.get_instance()
		rt.call_method(iife_result_9, 'get_specs_from_data_sources', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('store_details'), var_completed_tasks.clone(), rt.new_bool(true)]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('marketing'), var_completed_tasks.clone(), rt.new_bool(true)]))))) {
		mut iife_temp_10 := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller{}
		mut iife_result_10 := iife_temp_10.get_instance()
		rt.call_method(iife_result_10, 'get_specs_from_data_sources', []rt.PhpVal{})
	}
}

struct Class_Automattic_WooCommerce_Internal_Admin_static {
	rt.PhpObjectBase
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
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_static {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_notes_refund_returns(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_Notes_Refund_Returns {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_Notes_Refund_Returns{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remoteinboxnotifications_remoteinboxnotificationsengine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsEngine{
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

fn create_automattic_woocommerce_internal_admin_schedulers_mailchimpscheduler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_{"nodetype":"expr_variable","line":166,"name":"note_class"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":166,"name":"note_class"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":166,"name":"note_class"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_{"nodetype":"expr_variable","line":194,"name":"note_class"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":194,"name":"note_class"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":194,"name":"note_class"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_paymentsremindmelater(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsRemindMeLater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_paymentsmoreinfoneeded(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsMoreInfoNeeded {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_PaymentsMoreInfoNeeded{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_{"nodetype":"expr_variable","line":213,"name":"note_class"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":213,"name":"note_class"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_{"nodeType":"Expr_Variable","line":213,"name":"note_class"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_paymentgatewaysuggestionsdatasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_remotefreeextensionsdatasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller {
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
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
