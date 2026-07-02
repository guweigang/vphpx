import rt

pub fn Class_WC_Settings_Payment_Gateways.tab_name() string {
	return 'checkout'
}
pub fn Class_WC_Settings_Payment_Gateways.main_section_name() string {
	return 'main'
}
pub fn Class_WC_Settings_Payment_Gateways.offline_section_name() string {
	return 'offline'
}
pub fn Class_WC_Settings_Payment_Gateways.cod_section_name() string {
	return 'cod'
}
pub fn Class_WC_Settings_Payment_Gateways.bacs_section_name() string {
	return 'bacs'
}
pub fn Class_WC_Settings_Payment_Gateways.cheque_section_name() string {
	return 'cheque'
}
struct Class_WC_Settings_Payment_Gateways {
	rt.PhpObjectBase
pub mut:
		icon rt.PhpVal = rt.new_string('payment')
		reactified_sections_memo rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Settings_Payment_Gateways) construct() {
	this.dispatch_set_prop('id', Class_WC_Settings_Payment_Gateways.tab_name())
	this.dispatch_set_prop('label', rt.call_function('esc_html_x', [rt.new_string('Payments'), rt.new_string('Settings tab label'), rt.new_string('woocommerce')]))
	rt.call_function('add_filter', [rt.new_string('admin_body_class'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Payment_Gateways', ['WC_Settings_Page'], &this) }, rt.ArrayItem{ key: none, val: 'add_body_classes' }]), rt.new_int(30)])
	rt.call_function('add_action', [rt.new_string('admin_head'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Payment_Gateways', ['WC_Settings_Page'], &this) }, rt.ArrayItem{ key: none, val: 'hide_help_tabs' }])])
	rt.call_function('add_action', [rt.new_string('in_admin_header'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Payment_Gateways', ['WC_Settings_Page'], &this) }, rt.ArrayItem{ key: none, val: 'suppress_admin_notices' }]), rt.get_constant('PHP_INT_MAX')])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_features'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Payment_Gateways', ['WC_Settings_Page'], &this) }, rt.ArrayItem{ key: none, val: 'suppress_store_alerts' }]), rt.get_constant('PHP_INT_MAX')])
	this.Class_WC_Settings_Page.construct()
}

fn (mut this Class_WC_Settings_Payment_Gateways) should_render_react_section(var_section rt.PhpVal) bool {
	mut var_section_mutated := var_section
	return (rt.call_function('in_array', [rt.new_string(this.standardize_section_name(var_section_mutated.clone())), this.get_reactified_sections(), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_WC_Settings_Payment_Gateways) add_body_classes(var_classes rt.PhpVal) rt.PhpVal {
	mut var_current_tab := rt.new_null()
	mut var_current_section := rt.new_null()
	if !(var_classes.clone().is_string()) {
		return var_classes.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WC_Settings_Payment_Gateways.tab_name(), var_current_tab)))) {
		return var_classes.clone()
	}
	if !(this.should_render_react_section(var_current_section.clone())) {
		var_classes = rt.concat(var_classes, rt.new_string(' woocommerce-settings-payments-section_legacy'))
		var_classes = rt.concat(var_classes, rt.new_string(' woocommerce_page_wc-settings-checkout-section-' + (rt.call_function('esc_attr', [rt.new_string(this.standardize_section_name(var_current_section.clone()))])).str() + '_legacy'))
	}
	return var_classes.clone()
}

fn (mut this Class_WC_Settings_Payment_Gateways) output() {
	mut var_current_section := rt.new_null()
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_field_payment_gateways')])
	rt.call_function('ob_end_clean', []rt.PhpVal{})
	if var_current_section.clone().is_string() && this.should_render_react_section(var_current_section.clone()) {
		this.render_react_section(this.standardize_section_name(var_current_section.clone()))
	} else if var_current_section.clone().is_string() && !(!rt.is_true(var_current_section)) {
		mut var_payment_gateways := rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'payment_gateways')
		this.render_classic_gateway_settings_page(mut rt.cast_object_ptr[Class_array](var_payment_gateways), (var_current_section).str())
	} else {
		this.render_react_section(Class_WC_Settings_Payment_Gateways.main_section_name())
	}
	this.Class_WC_Settings_Page.output()
}

fn (mut this Class_WC_Settings_Payment_Gateways) get_settings_for_default_section() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'title' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: 'payment_gateways_options' }]) }])
}

fn (mut this Class_WC_Settings_Payment_Gateways) get_reactified_sections() rt.PhpVal {
	if !(this.reactified_sections_memo.is_null()) {
		return this.reactified_sections_memo
	}
	mut var_reactified_sections := [Class_WC_Settings_Payment_Gateways.main_section_name(), Class_WC_Settings_Payment_Gateways.offline_section_name()]
	mut var_optional_reactified_sections := rt.create_array([rt.ArrayItem{ key: none, val: Class_WC_Settings_Payment_Gateways.cod_section_name() }, rt.ArrayItem{ key: none, val: Class_WC_Settings_Payment_Gateways.bacs_section_name() }, rt.ArrayItem{ key: none, val: Class_WC_Settings_Payment_Gateways.cheque_section_name() }])
	var_optional_reactified_sections = rt.call_function('apply_filters', [rt.new_string('experimental_woocommerce_admin_payment_reactify_render_sections'), var_optional_reactified_sections.clone()])
	if !rt.is_true(var_optional_reactified_sections) || !(var_optional_reactified_sections.clone().is_array()) {
	var_optional_reactified_sections = rt.new_array()
	} else {
	var_optional_reactified_sections = rt.call_function('array_values', [rt.call_function('array_filter', [var_optional_reactified_sections.clone(), rt.new_string('is_string')])])
	}
	this.reactified_sections_memo = rt.call_function('array_unique', [rt.call_function('array_merge', [rt.create_array_from_list(var_reactified_sections), var_optional_reactified_sections.clone()])])
	return this.reactified_sections_memo
}

fn (mut this Class_WC_Settings_Payment_Gateways) standardize_section_name(var_section rt.PhpVal) string {
	mut var_section_mutated := var_section
	var_section_mutated = rt.new_string((var_section_mutated).str())
	if rt.is_true(rt.identical(rt.new_string(''), var_section_mutated)) {
		return Class_WC_Settings_Payment_Gateways.main_section_name()
	}
	return (var_section_mutated).str()
}

fn (mut this Class_WC_Settings_Payment_Gateways) render_react_section(section string) {
	mut section_mutated := section
	mut var_hide_save_button := rt.get_superglobal('hide_save_button')
	var_hide_save_button = rt.new_bool(true)
	print('<div id="experimental_wc_settings_payments_' + (rt.call_function('esc_attr', [rt.new_string(section_mutated).clone()])).str() + '"></div>')
}

fn (mut this Class_WC_Settings_Payment_Gateways) render_classic_gateway_settings_page(mut var_payment_gateways Class_array, current_section string) {
	mut var_payment_gateways_mutated := var_payment_gateways
	mut iter_1 := var_payment_gateways_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_gateway := item_1.val
		if rt.is_true(rt.call_function('in_array', [rt.new_string(current_section), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_gateway, 'id') }, rt.ArrayItem{ key: none, val: rt.call_function('sanitize_title', [rt.call_function('get_class', [var_gateway.clone()])]) }]), rt.new_bool(true)])) {
			if rt.get_superglobal('_GET').array_isset(rt.new_string('toggle_enabled')) {
				mut var_enabled := rt.call_method(var_gateway, 'get_option', [rt.new_string('enabled')])
				if rt.is_true(var_enabled) {
					rt.get_property(var_gateway, 'settings').array_set('enabled', if rt.is_true(rt.call_function('wc_string_to_bool', [var_enabled.clone()])) { 'no' } else { 'yes' })
				}
			}
			this.run_gateway_admin_options(var_gateway.clone())
			break
		}
	}
}

fn (mut this Class_WC_Settings_Payment_Gateways) run_gateway_admin_options(var_gateway rt.PhpVal) {
	rt.call_method(var_gateway, 'admin_options', []rt.PhpVal{})
}

fn (mut this Class_WC_Settings_Payment_Gateways) get_sections() rt.PhpVal {
	mut var_current_tab := rt.new_null()
	mut var_current_section := ''
	if rt.is_true(rt.identical(Class_WC_Settings_Payment_Gateways.tab_name(), var_current_tab)) && this.should_render_react_section(rt.new_string((var_current_section).str())) {
		return rt.new_array()
	}
	return this.Class_WC_Settings_Page.get_sections()
}

fn (mut this Class_WC_Settings_Payment_Gateways) save() {
	mut var_current_section := ''
	mut var_standardized_section := rt.new_string(this.standardize_section_name(rt.new_string((var_current_section).str())))
	mut iife_temp_0 := Class_WC_Payment_Gateways{}
	mut iife_result_0 := iife_temp_0.instance()
	mut var_wc_payment_gateways := iife_result_0
	this.save_settings_for_current_section()
	if rt.is_true(rt.identical(Class_WC_Settings_Payment_Gateways.main_section_name(), var_standardized_section)) {
		rt.call_method(var_wc_payment_gateways, 'process_admin_options', []rt.PhpVal{})
		rt.call_method(var_wc_payment_gateways, 'init', []rt.PhpVal{})
	} else {
		mut iter_2 := rt.call_method(var_wc_payment_gateways, 'payment_gateways', []rt.PhpVal{}).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_gateway := item_2.val
			if rt.is_true(rt.call_function('in_array', [var_standardized_section.clone(), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_gateway, 'id') }, rt.ArrayItem{ key: none, val: rt.call_function('sanitize_title', [rt.call_function('get_class', [var_gateway.clone()])]) }]), rt.new_bool(true)])) {
				rt.call_function('do_action', [rt.new_string('woocommerce_update_options_payment_gateways_' + (rt.get_property(var_gateway, 'id')).str())])
				rt.call_method(var_wc_payment_gateways, 'init', []rt.PhpVal{})
				break
			}
		}
		this.do_update_options_action()
	}
}

fn (mut this Class_WC_Settings_Payment_Gateways) hide_help_tabs() {
	mut var_current_tab := rt.new_null()
	mut var_current_section := ''
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_screen, 'WP_Screen')))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), rt.get_property(var_screen, 'id'))))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WC_Settings_Payment_Gateways.tab_name(), var_current_tab)))) {
		return
	}
	if !(this.should_render_react_section(rt.new_string((var_current_section).str()))) {
		return
	}
	rt.call_method(var_screen, 'remove_help_tabs', []rt.PhpVal{})
}

fn (mut this Class_WC_Settings_Payment_Gateways) suppress_admin_notices() {
	mut var_wp_filter := map[string]rt.PhpVal{}
	mut var_current_tab := rt.new_null()
	mut var_current_section := ''
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_screen, 'WP_Screen')))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), rt.get_property(var_screen, 'id'))))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WC_Settings_Payment_Gateways.tab_name(), var_current_tab)))) {
		return
	}
	if !(this.should_render_react_section(rt.new_string((var_current_section).str()))) {
		return
	}
	rt.call_function('remove_all_actions', [rt.new_string('all_admin_notices')])
	mut var_wp_admin_notices_hook := if !(var_wp_filter.array_get(rt.new_string('admin_notices'))).is_null() { var_wp_filter.array_get(rt.new_string('admin_notices')) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_admin_notices_hook)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_admin_notices_hook, 'has_filters', []rt.PhpVal{}))))) {
		return
	}
	mut iife_temp_1 := Class_WC_Admin_Notices{}
	mut iife_result_1 := iife_temp_1.get_notices()
	mut var_wc_admin_notices := iife_result_1
	if !rt.is_true(var_wc_admin_notices) {
		rt.call_function('remove_all_actions', [rt.new_string('admin_notices')])
		return
	}
	mut iter_3 := rt.get_property(var_wp_admin_notices_hook, 'callbacks').iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_callbacks := item_3.val
		mut var_priority := item_3.key
		if !(var_callbacks.clone().is_array()) {
			continue
		}
		mut iter_4 := var_callbacks.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_callback := item_4.val
			if !(var_callback.clone().is_array()) {
				continue
			}
			if !(var_callback.array_get(rt.new_string('function')).is_array()) {
				rt.call_function('remove_action', [rt.new_string('admin_notices'), var_callback.array_get(rt.new_string('function')), var_priority.clone()])
				continue
			}
			mut var_class_or_object := if !(var_callback.array_get(rt.new_string('function')).array_get(rt.new_int(0))).is_null() { var_callback.array_get(rt.new_string('function')).array_get(rt.new_int(0)) } else { rt.new_null() }
			if (var_class_or_object.clone().is_string() && !(rt.is_true(rt.identical(Class_WC_Admin_Notices.class(), var_class_or_object)) || rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Loader.class(), var_class_or_object)))) || (var_class_or_object.clone().is_object() && !(rt.is_true(rt.new_bool(rt.instance_of(var_class_or_object, 'WC_Admin_Notices'))) || rt.is_true(rt.new_bool(rt.instance_of(var_class_or_object, 'Automattic_WooCommerce_Internal_Admin_Loader'))))) {
				rt.call_function('remove_action', [rt.new_string('admin_notices'), var_callback.array_get(rt.new_string('function')), var_priority.clone()])
			}
		}
	}
}

fn (mut this Class_WC_Settings_Payment_Gateways) suppress_store_alerts(var_features rt.PhpVal) rt.PhpVal {
	mut var_current_tab := rt.new_null()
	mut var_current_section := ''
	mut var_feature_name := rt.new_string('store-alerts')
	if var_features.clone().is_array() && rt.is_true(rt.call_function('in_array', [var_feature_name.clone(), var_features.clone(), rt.new_bool(true)])) && rt.is_true(rt.identical(Class_WC_Settings_Payment_Gateways.tab_name(), var_current_tab)) && this.should_render_react_section(rt.new_string((var_current_section).str())) {
		var_features.array_unset(rt.call_function('array_search', [var_feature_name.clone(), var_features.clone(), rt.new_bool(true)]))
	}
	return var_features.clone()
}

struct Class_WC_Settings_Page {
	rt.PhpObjectBase
}

struct Class_WC_Payment_Gateways {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Notices {
	rt.PhpObjectBase
}

fn create_wc_settings_payment_gateways() &Class_WC_Settings_Payment_Gateways {
	mut obj := &Class_WC_Settings_Payment_Gateways{
		PhpObjectBase: rt.PhpObjectBase{}
		icon: rt.new_string('payment')
		reactified_sections_memo: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_settings_page(_args ...rt.PhpVal) &Class_WC_Settings_Page {
	mut obj := &Class_WC_Settings_Page{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_payment_gateways(_args ...rt.PhpVal) &Class_WC_Payment_Gateways {
	mut obj := &Class_WC_Payment_Gateways{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_notices(_args ...rt.PhpVal) &Class_WC_Admin_Notices {
	mut obj := &Class_WC_Admin_Notices{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Settings_Payment_Gateways) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'should_render_react_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.should_render_react_section(dispatch_arg_0))
		}
		'add_body_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_body_classes(dispatch_arg_0)
		}
		'output' {
			this.output()
			return rt.new_null()
		}
		'get_settings_for_default_section' {
			return this.get_settings_for_default_section()
		}
		'get_reactified_sections' {
			return this.get_reactified_sections()
		}
		'standardize_section_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.standardize_section_name(dispatch_arg_0))
		}
		'render_react_section' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.render_react_section(dispatch_arg_0)
			return rt.new_null()
		}
		'render_classic_gateway_settings_page' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.render_classic_gateway_settings_page(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'run_gateway_admin_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.run_gateway_admin_options(dispatch_arg_0)
			return rt.new_null()
		}
		'get_sections' {
			return this.get_sections()
		}
		'save' {
			this.save()
			return rt.new_null()
		}
		'hide_help_tabs' {
			this.hide_help_tabs()
			return rt.new_null()
		}
		'suppress_admin_notices' {
			this.suppress_admin_notices()
			return rt.new_null()
		}
		'suppress_store_alerts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.suppress_store_alerts(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Settings_Payment_Gateways) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'icon' { return this.icon }
		'reactified_sections_memo' { return this.reactified_sections_memo }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Settings_Payment_Gateways) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'icon' { this.icon = val; return true }
		'reactified_sections_memo' { this.reactified_sections_memo = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Settings_Page) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Settings_Page) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_Page) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Payment_Gateways) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Payment_Gateways) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Gateways) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Settings_Payment_Gateways'), rt.new_bool(false)])) {
		return rt.new_object('WC_Settings_Payment_Gateways', ['WC_Settings_Page'], create_wc_settings_payment_gateways())
	}
	return rt.new_object('WC_Settings_Payment_Gateways', ['WC_Settings_Page'], create_wc_settings_payment_gateways())
}
