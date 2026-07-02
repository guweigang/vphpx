import rt

pub fn Class_WC_Settings_Page.type_title() string {
	return 'title'
}

pub fn Class_WC_Settings_Page.type_info() string {
	return 'info'
}

pub fn Class_WC_Settings_Page.type_sectionend() string {
	return 'sectionend'
}

pub fn Class_WC_Settings_Page.type_text() string {
	return 'text'
}

pub fn Class_WC_Settings_Page.type_password() string {
	return 'password'
}

pub fn Class_WC_Settings_Page.type_datetime() string {
	return 'datetime'
}

pub fn Class_WC_Settings_Page.type_datetime_local() string {
	return 'datetime-local'
}

pub fn Class_WC_Settings_Page.type_date() string {
	return 'date'
}

pub fn Class_WC_Settings_Page.type_month() string {
	return 'month'
}

pub fn Class_WC_Settings_Page.type_time() string {
	return 'time'
}

pub fn Class_WC_Settings_Page.type_week() string {
	return 'week'
}

pub fn Class_WC_Settings_Page.type_number() string {
	return 'number'
}

pub fn Class_WC_Settings_Page.type_email() string {
	return 'email'
}

pub fn Class_WC_Settings_Page.type_url() string {
	return 'url'
}

pub fn Class_WC_Settings_Page.type_tel() string {
	return 'tel'
}

pub fn Class_WC_Settings_Page.type_color() string {
	return 'color'
}

pub fn Class_WC_Settings_Page.type_textarea() string {
	return 'textarea'
}

pub fn Class_WC_Settings_Page.type_select() string {
	return 'select'
}

pub fn Class_WC_Settings_Page.type_multiselect() string {
	return 'multiselect'
}

pub fn Class_WC_Settings_Page.type_radio() string {
	return 'radio'
}

pub fn Class_WC_Settings_Page.type_checkbox() string {
	return 'checkbox'
}

pub fn Class_WC_Settings_Page.type_image_width() string {
	return 'image_width'
}

pub fn Class_WC_Settings_Page.type_single_select_page() string {
	return 'single_select_page'
}

pub fn Class_WC_Settings_Page.type_single_select_page_with_search() string {
	return 'single_select_page_with_search'
}

pub fn Class_WC_Settings_Page.type_single_select_country() string {
	return 'single_select_country'
}

pub fn Class_WC_Settings_Page.type_multi_select_countries() string {
	return 'multi_select_countries'
}

pub fn Class_WC_Settings_Page.type_relative_date_selector() string {
	return 'relative_date_selector'
}

pub fn Class_WC_Settings_Page.type_slotfill_placeholder() string {
	return 'slotfill_placeholder'
}

struct Class_WC_Settings_Page {
	rt.PhpObjectBase
pub mut:
	id            rt.PhpVal = rt.new_string('')
	icon          rt.PhpVal = rt.new_string('settings')
	types         rt.PhpVal = rt.new_array()
	label         rt.PhpVal = rt.new_string('')
	is_modern     rt.PhpVal = rt.new_bool(false)
	output_called bool
}

fn (mut this Class_WC_Settings_Page) construct() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_settings_tabs_array'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Page', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_settings_page' },
		]),
		rt.new_int(20)])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_sections_' + (this.id).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Page', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_sections' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_settings_' + (this.id).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Page', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_settings_save_' + (this.id).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Page', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'save' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_admin_field_add_settings_slot'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Page', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_settings_slot' },
		]),
	])
}

fn (mut this Class_WC_Settings_Page) get_id() rt.PhpVal {
	return this.id
}

fn (mut this Class_WC_Settings_Page) get_label() rt.PhpVal {
	return this.label
}

fn (mut this Class_WC_Settings_Page) add_settings_slot() {
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Settings_Page) add_settings_page(var_pages rt.PhpVal) rt.PhpVal {
	mut var_pages_mutated := var_pages
	var_pages_mutated.array_set(this.id, this.label)
	return var_pages_mutated.clone()
}

fn (mut this Class_WC_Settings_Page) add_settings_page_data(var_pages rt.PhpVal) rt.PhpVal {
	mut var_pages_mutated := var_pages
	mut var_current_section := rt.get_superglobal('current_section')
	mut var_saved_current_section := var_current_section.clone()
	mut var_sections := this.get_sections()
	mut var_sections_data := rt.new_array()
	mut iter_1 := var_sections.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_section_label := item_1.val
		mut var_section_id := item_1.key
		var_current_section = var_section_id.clone()
		mut var_section_settings_data := this.get_section_settings_data(var_section_id.clone(),
			var_sections.clone())
		mut var_normalized_section_id := if rt.is_true(rt.identical(rt.new_string(''),
			var_section_id))
		{
			rt.new_string('default')
		} else {
			var_section_id
		}
		var_sections_data.array_set(var_normalized_section_id, rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('html_entity_decode', [
				rt.call_function('esc_html', [var_section_label.clone()]),
			]) },
			rt.ArrayItem{ key: 'settings', val: var_section_settings_data },
		]))
	}
	var_current_section = var_saved_current_section.clone()
	var_pages_mutated.array_set(this.id, rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('html_entity_decode', [
			this.label,
		]) },
		rt.ArrayItem{ key: 'slug', val: this.id },
		rt.ArrayItem{ key: 'icon', val: this.icon },
		rt.ArrayItem{ key: 'sections', val: var_sections_data },
		rt.ArrayItem{ key: 'is_modern', val: this.is_modern },
	]))
	var_pages_mutated.array_get_mut(this.id).array_set('start', this.get_custom_view(rt.new_string(
		'woocommerce_before_settings_' + (this.id).str()), false))
	var_pages_mutated.array_get_mut(this.id).array_set('end', this.get_custom_view(rt.new_string(
		'woocommerce_after_settings_' + (this.id).str()), false))
	return var_pages_mutated.clone()
}

fn (mut this Class_WC_Settings_Page) get_section_settings_data(var_section_id rt.PhpVal, var_sections rt.PhpVal) rt.PhpVal {
	mut var_section_id_mutated := var_section_id
	mut var_sections_mutated := var_sections
	mut var_section_settings_data := rt.new_array()
	mut var_custom_view := this.get_custom_view(rt.new_string('woocommerce_settings_' +
		(this.id).str()), var_section_id_mutated.to_bool())
	if this.output_called {
		mut var_section_settings := if var_sections_mutated.clone().array_count() > 1 {
			this.get_settings_for_section(var_section_id_mutated.clone())
		} else {
			this.get_settings()
		}
		mut iter_2 := var_section_settings.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_section_setting := item_2.val
			if rt.is_true(rt.identical(rt.new_string('sectionend'), var_section_setting.array_get(rt.new_string('type'))))
				&& !(!rt.is_true(var_section_setting.array_get(rt.new_string('id')))) {
				var_section_settings_data.array_push(this.get_custom_view(rt.new_string(
					'woocommerce_settings_' +
					(var_section_setting.array_get(rt.new_string('id'))).str() + '_end'), false))
				var_section_settings_data.array_push(this.get_custom_view(rt.new_string(
					'woocommerce_settings_' +
					(var_section_setting.array_get(rt.new_string('id'))).str() + '_after'), false))
			}
			var_section_settings_data.array_push(this.populate_setting_value(var_section_setting.clone()))
			if rt.is_true(rt.identical(rt.new_string('title'), var_section_setting.array_get(rt.new_string('type'))))
				&& !(!rt.is_true(var_section_setting.array_get(rt.new_string('id')))) {
				var_section_settings_data.array_push(this.get_custom_view(rt.new_string(
					'woocommerce_settings_' +
					(var_section_setting.array_get(rt.new_string('id'))).str()), false))
			}
		}
	}
	if !(!rt.is_true(var_custom_view)) {
		var_section_settings_data.array_push(var_custom_view.clone())
	}
	this.output_called = false
	return var_section_settings_data.clone()
}

fn (mut this Class_WC_Settings_Page) populate_setting_value(var_section_setting rt.PhpVal) rt.PhpVal {
	mut var_section_setting_mutated := var_section_setting
	if var_section_setting_mutated.array_isset(rt.new_string('id')) {
		var_section_setting_mutated.array_set('value', if var_section_setting_mutated.array_isset(rt.new_string('default')) { rt.call_function('get_option', [
				var_section_setting_mutated.array_get(rt.new_string('id')),
				var_section_setting_mutated.array_get(rt.new_string('default')),
			]) } else { rt.call_function('get_option', [
				var_section_setting_mutated.array_get(rt.new_string('id')),
			]) })
	}
	mut var_type := var_section_setting_mutated.array_get(rt.new_string('type'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_type.clone(), this.types, rt.new_bool(true)])))))
	{
		var_section_setting_mutated = this.get_custom_type_field(rt.new_string(
			'woocommerce_admin_field_' + var_type.str()), var_section_setting_mutated.clone())
	}
	return var_section_setting_mutated.clone()
}

fn (mut this Class_WC_Settings_Page) get_custom_view(var_action rt.PhpVal, section_id bool) rt.PhpVal {
	mut section_id_mutated := section_id
	mut var_current_section := rt.get_superglobal('current_section')
	if rt.is_true(rt.new_bool(section_id_mutated)) {
		mut var_saved_current_section := var_current_section.clone()
		var_current_section = rt.new_bool(section_id_mutated).clone()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('do_action', [var_action.clone()])
	mut var_html := rt.call_function('ob_get_contents', []rt.PhpVal{})
	rt.call_function('ob_end_clean', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(section_id_mutated)) {
		var_current_section = var_saved_current_section.clone()
	}
	mut var_content := rt.new_string(var_html.clone().to_string().trim_space())
	if !rt.is_true(var_content) {
		return rt.new_null()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_function('wp_unique_prefixed_id', [
			rt.new_string('settings_custom_view'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'custom' },
		rt.ArrayItem{ key: 'content', val: var_content },
	])
}

fn (mut this Class_WC_Settings_Page) get_custom_type_field(var_action rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_setting_mutated := var_setting
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('do_action', [var_action.clone(), var_setting_mutated.clone()])
	mut var_html := rt.call_function('ob_get_contents', []rt.PhpVal{})
	rt.call_function('ob_end_clean', []rt.PhpVal{})
	var_setting_mutated.array_set('content', var_html.clone().to_string().trim_space())
	var_setting_mutated.array_set('id', if var_setting_mutated.array_isset(rt.new_string('id')) { var_setting_mutated.array_get(rt.new_string('id')) } else { rt.call_function('wp_unique_prefixed_id', [
			rt.new_string('settings_custom_view'),
		]) })
	var_setting_mutated.array_set('type', 'custom')
	return var_setting_mutated.clone()
}

fn (mut this Class_WC_Settings_Page) get_settings() rt.PhpVal {
	mut var_section_id := if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('func_num_args', []rt.PhpVal{}))) { rt.new_string('') } else { rt.call_function('func_get_arg', [
			rt.new_int(0),
		]) }
	return this.get_settings_for_section(var_section_id.clone())
}

fn (mut this Class_WC_Settings_Page) get_settings_for_section(var_section_id rt.PhpVal) rt.PhpVal {
	mut var_section_id_mutated := var_section_id
	if rt.is_true(rt.identical(rt.new_string(''), var_section_id_mutated)) {
		mut var_method_name := rt.new_string('get_settings_for_default_section')
	} else {
		var_method_name = rt.new_string('get_settings_for_${var_section_id.to_string()}_section')
	}
	if rt.is_true(rt.call_function('method_exists', [
		rt.new_object('WC_Settings_Page', []string{}, &this),
		var_method_name.clone(),
	]))
	{
		mut var_settings := rt.call_method(rt.new_object('WC_Settings_Page', []string{}, &this),
			var_method_name, []rt.PhpVal{})
	} else {
		var_settings = this.get_settings_for_section_core(var_section_id_mutated.clone())
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_settings_' + (this.id).str()),
		var_settings.clone(),
		var_section_id_mutated.clone(),
	])
}

fn (mut this Class_WC_Settings_Page) get_settings_for_section_core(var_section_id rt.PhpVal) rt.PhpVal {
	mut var_section_id_mutated := var_section_id
	return rt.new_array()
}

fn (mut this Class_WC_Settings_Page) get_sections() rt.PhpVal {
	mut var_sections := this.get_own_sections()
	return rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_sections_' + (this.id).str()),
		var_sections.clone(),
	]))
}

fn (mut this Class_WC_Settings_Page) get_own_sections() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('General'),
			rt.new_string('woocommerce')]) },
	])
}

fn (mut this Class_WC_Settings_Page) output_sections() {
	mut var_current_section := rt.new_null()
	mut var_sections := this.get_sections()
	if !rt.is_true(var_sections) || 1 == var_sections.clone().array_count() {
		return
	}
	print('<ul class="subsubsub">')
	mut var_array_keys := rt.func_array_keys(var_sections.clone())
	mut iter_3 := var_sections.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_label := item_3.val
		mut var_id := item_3.key
		mut var_url := rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-settings&tab=' +(this.id).str() + '&section=' +
				(rt.call_function('sanitize_title', [var_id.clone()])).str()),
		])
		mut var_class := rt.new_string((if rt.is_true(rt.identical(var_current_section, var_id)) {
			'current'
		} else {
			''
		}).str())
		mut var_separator := rt.new_string((if rt.is_true(rt.identical(rt.call_function('end', [
			var_array_keys.clone(),
		]), var_id))
		{ '' } else { '|' }).str())
		mut var_text := rt.call_function('esc_html', [var_label.clone()])
		print("<li><a href='${var_url.to_string()}' class='${var_class.to_string()}'>${var_text.to_string()}</a> ${var_separator.to_string()} </li>")
	}
	print('</ul><br class="clear" />')
}

fn (mut this Class_WC_Settings_Page) output() {
	mut var_current_section := rt.new_null()
	this.output_called = true
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('settings'))
	if rt.is_true(iife_result_0) {
		return
	}
	mut var_settings := this.get_settings(var_current_section.clone())
	mut iife_temp_1 := Class_WC_Admin_Settings{}
	mut iife_result_1 := iife_temp_1.output_fields(var_settings.clone())
}

fn (mut this Class_WC_Settings_Page) save() {
	this.save_settings_for_current_section()
	this.do_update_options_action(rt.new_null())
}

fn (mut this Class_WC_Settings_Page) save_settings_for_current_section() {
	mut var_current_section := rt.new_null()
	mut var_settings := this.get_settings(var_current_section.clone())
	mut iife_temp_2 := Class_WC_Admin_Settings{}
	mut iife_result_2 := iife_temp_2.save_fields(var_settings.clone())
}

fn (mut this Class_WC_Settings_Page) do_update_options_action(var_section_id rt.PhpVal) {
	mut var_current_section := rt.new_null()
	mut var_section_id_mutated := var_section_id
	if rt.is_true(rt.new_bool(var_section_id_mutated.clone().is_null())) {
		var_section_id_mutated = var_current_section.clone()
	}
	if rt.is_true(var_section_id_mutated) {
		rt.call_function('do_action', [
			rt.new_string('woocommerce_update_options_' +
				(this.id).str() + '_' + var_section_id_mutated.str()),
		])
	}
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

fn create_wc_settings_page() &Class_WC_Settings_Page {
	mut obj := &Class_WC_Settings_Page{
		PhpObjectBase: rt.PhpObjectBase{}
		id:            rt.new_string('')
		icon:          rt.new_string('settings')
		types:         rt.new_array()
		label:         rt.new_string('')
		is_modern:     rt.new_bool(false)
		output_called: false
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_settings(_args ...rt.PhpVal) &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Settings_Page) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_id' {
			return this.get_id()
		}
		'get_label' {
			return this.get_label()
		}
		'add_settings_slot' {
			this.add_settings_slot()
			return rt.new_null()
		}
		'add_settings_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_settings_page(dispatch_arg_0)
		}
		'add_settings_page_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_settings_page_data(dispatch_arg_0)
		}
		'get_section_settings_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_section_settings_data(dispatch_arg_0, dispatch_arg_1)
		}
		'populate_setting_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.populate_setting_value(dispatch_arg_0)
		}
		'get_custom_view' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_custom_view(dispatch_arg_0, dispatch_arg_1)
		}
		'get_custom_type_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_custom_type_field(dispatch_arg_0, dispatch_arg_1)
		}
		'get_settings' {
			return this.get_settings()
		}
		'get_settings_for_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_settings_for_section(dispatch_arg_0)
		}
		'get_settings_for_section_core' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_settings_for_section_core(dispatch_arg_0)
		}
		'get_sections' {
			return this.get_sections()
		}
		'get_own_sections' {
			return this.get_own_sections()
		}
		'output_sections' {
			this.output_sections()
			return rt.new_null()
		}
		'output' {
			this.output()
			return rt.new_null()
		}
		'save' {
			this.save()
			return rt.new_null()
		}
		'save_settings_for_current_section' {
			this.save_settings_for_current_section()
			return rt.new_null()
		}
		'do_update_options_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.do_update_options_action(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Settings_Page) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'icon' { return this.icon }
		'types' { return this.types }
		'label' { return this.label }
		'is_modern' { return this.is_modern }
		'output_called' { return rt.new_bool(this.output_called) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Settings_Page) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		'icon' {
			this.icon = val
			return true
		}
		'types' {
			this.types = val
			return true
		}
		'label' {
			this.label = val
			return true
		}
		'is_modern' {
			this.is_modern = val
			return true
		}
		'output_called' {
			this.output_called = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Settings_Page'),
		rt.new_bool(false),
	])))))
	{
	}
}
