import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.note_name() string {
	return 'wc-admin-woocommerce-payments'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.plugin_slug() string {
	return 'woocommerce-payments'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.plugin_file() string {
	return 'woocommerce-payments/woocommerce-payments.php'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments) construct() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'install_on_action' },
		])])
	rt.call_function('add_action', [
		rt.new_string('wc-admin-woocommerce-payments_add_note'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_note' },
		]),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.possibly_add_note() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments{}
	mut iife_result_0 := iife_temp_0.is_wc_admin_active_in_date_range(rt.new_string('week-1-4'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('US'), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{}))))) {
		return
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_1 := iife_temp_1.load_data_store()
	mut var_data_store := iife_result_1
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.note_name(),
	])
	if !(!rt.is_true(var_note_ids)) {
		mut var_note_id := rt.call_function('array_pop', [var_note_ids.clone()])
		mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
		mut iife_result_2 := iife_temp_2.get_note(var_note_id.clone())
		mut var_note := iife_result_2
		if rt.is_true(rt.identical(rt.new_bool(false), var_note)) {
			return
		}
		if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.is_installed())
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned(), rt.call_method(var_note, 'get_status', []rt.PhpVal{}))))) {
			rt.call_method(var_note, 'set_status', [
				Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned(),
			])
			rt.call_method(var_note, 'save', []rt.PhpVal{})
		}
		return
	}
	mut var_current_date := create_automattic_woocommerce_internal_admin_notes_datetime()
	mut var_publish_date :=
		create_automattic_woocommerce_internal_admin_notes_datetime(rt.new_string('2020-04-14'))
	if rt.is_true(rt.greater_equal(var_current_date, var_publish_date)) {
		var_note = Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.get_note()
		mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments{}
		mut iife_result_3 := iife_temp_3.can_be_added()
		if rt.is_true(iife_result_3) {
			rt.call_method(var_note, 'save', []rt.PhpVal{})
		}
		return
	} else {
		mut var_hook_name := rt.call_function('sprintf', [rt.new_string('%s_add_note'),
			Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.note_name()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(rt.call_function('WC',
			[]rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'get_next', [
			var_hook_name.clone()])))))
		{
			rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue',
				[]rt.PhpVal{}), 'schedule_single', [var_publish_date.gettimestamp(),
				var_hook_name.clone()])
		}
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.get_note() rt.PhpVal {
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	rt.call_method(var_note, 'set_title', [
		rt.call_function('__', [rt.new_string('Try the new way to get paid'),
			rt.new_string('woocommerce')]),
	])
	rt.call_method(var_note, 'set_content', [
		rt.new_string(
			(rt.call_function('__', [rt.new_string('Securely accept credit and debit cards on your site. Manage transactions without leaving your WordPress dashboard. Only with <strong>WooPayments</strong>.'), rt.new_string('woocommerce')])).str() +
			'<br><br>' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('By clicking "Get started", you agree to our %1$sTerms of Service%2$s'), rt.new_string('woocommerce')]), rt.new_string('<a href="https://wordpress.com/tos/" target="_blank">'), rt.new_string('</a>')])).str()),
	])
	rt.call_method(var_note, 'set_content_data', [rt.array_to_object(rt.new_array())])
	rt.call_method(var_note, 'set_type', [
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_marketing(),
	])
	rt.call_method(var_note, 'set_name', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.note_name(),
	])
	rt.call_method(var_note, 'set_source', [rt.new_string('woocommerce-admin')])
	rt.call_method(var_note, 'add_action', [rt.new_string('learn-more'),
		rt.call_function('__', [rt.new_string('Learn more'), rt.new_string('woocommerce')]),
		rt.new_string('https://woocommerce.com/payments/?utm_medium=product'),
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned()])
	rt.call_method(var_note, 'add_action', [rt.new_string('get-started'),
		rt.call_function('__', [rt.new_string('Get started'),
			rt.new_string('woocommerce')]),
		rt.call_function('wc_admin_url', [rt.new_string('&action=setup-woocommerce-payments')]),
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned(),
		rt.new_bool(true)])
	rt.call_method(var_note, 'add_nonce_to_action', [rt.new_string('get-started'),
		rt.new_string('setup-woocommerce-payments'), rt.new_string('')])
	if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.is_installed()) {
		rt.call_method(var_note, 'set_status', [
			Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned(),
		])
	}
	return var_note.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.is_installed() bool {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WC_Payments')])) {
		return true
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/plugin.php', '2')
	return (rt.identical(rt.new_int(0), rt.call_function('validate_plugin', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.plugin_file(),
	]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments) install_and_activate_wcpay() bool {
	mut var_install_request := rt.create_array([
		rt.ArrayItem{
			key: 'plugins'
			val: Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.plugin_slug()
		},
	])
	mut var_installer :=
		create_automattic_woocommerce_internal_admin_notes_automattic_woocommerce_admin_api_plugins()
	mut var_result := var_installer.install_plugins(var_install_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return false
	}
	rt.call_function('wc_admin_record_tracks_event', [
		rt.new_string('woocommerce_payments_install'),
		rt.create_array([rt.ArrayItem{ key: 'context', val: 'inbox' }]),
	])
	mut var_activate_request := rt.create_array([
		rt.ArrayItem{
			key: 'plugins'
			val: Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.plugin_slug()
		},
	])
	var_result = var_installer.activate_plugins(var_activate_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments) install_on_action() {
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('page')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wc-admin'), rt.get_superglobal('_GET').array_get(rt.new_string('page'))))))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('action')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('setup-woocommerce-payments'), rt.get_superglobal('_GET').array_get(rt.new_string('action')))))) {
		return
	}
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_4 := iife_temp_4.load_data_store()
	mut var_data_store := iife_result_4
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.note_name(),
	])
	if !rt.is_true(var_note_ids) {
		return
	}
	mut var_note_id := rt.call_function('array_pop', [var_note_ids.clone()])
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_5 := iife_temp_5.get_note(var_note_id.clone())
	mut var_note := iife_result_5
	if rt.is_true(rt.identical(rt.new_bool(false), var_note)) {
		return
	}
	mut var_action := rt.call_method(var_note, 'get_action', [
		rt.new_string('get-started'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_action))))
		|| (!(rt.get_property(var_action, 'nonce_action')).is_null()
		&& !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce'))]), rt.get_property(var_action, 'nonce_action')])))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_plugins'),
	])))))
	{
		return
	}
	this.install_and_activate_wcpay()
	mut var_connect_url := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'wcpay-connect', val: '1' },
			rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('wcpay-connect'),
			]) }]),
		rt.call_function('admin_url', []rt.PhpVal{}),
	])
	rt.call_function('wp_safe_redirect', [var_connect_url.clone()])
	exit(0)
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Admin_API_Plugins {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_woocommercepayments() &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_note(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_automattic_woocommerce_admin_api_plugins(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Admin_API_Plugins {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Admin_API_Plugins{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'possibly_add_note' {
			Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.possibly_add_note()
			return rt.new_null()
		}
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.get_note()
		}
		'is_installed' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments.is_installed())
		}
		'install_and_activate_wcpay' {
			return rt.new_bool(this.install_and_activate_wcpay())
		}
		'install_on_action' {
			this.install_on_action()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Admin_API_Plugins) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Admin_API_Plugins) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Admin_API_Plugins) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
