import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles.note_name() string {
	return 'wc-admin-remove-unsecured-report-files'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles.get_note() rt.PhpVal {
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	rt.call_method(var_note, 'set_title', [
		rt.call_function('__', [
			rt.new_string('Potentially unsecured files were found in your uploads directory'),
			rt.new_string('woocommerce'),
		]),
	])
	rt.call_method(var_note, 'set_content', [
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Files that may contain %1$sstore analytics%2$s reports were found in your uploads directory - we recommend assessing and deleting any such files.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('<a href="https://woocommerce.com/document/woocommerce-analytics/" target="_blank">'),
			rt.new_string('</a>'),
		]),
	])
	rt.call_method(var_note, 'set_content_data', [rt.array_to_object(rt.new_array())])
	rt.call_method(var_note, 'set_type', [
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_error(),
	])
	rt.call_method(var_note, 'set_name', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles.note_name(),
	])
	rt.call_method(var_note, 'set_source', [rt.new_string('woocommerce-admin')])
	rt.call_method(var_note, 'add_action', [rt.new_string('learn-more'),
		rt.call_function('__', [rt.new_string('Learn more'), rt.new_string('woocommerce')]),
		rt.new_string('https://developer.woocommerce.com/2021/09/22/important-security-patch-released-in-woocommerce/'),
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned(),
		rt.new_bool(true)])
	rt.call_method(var_note, 'add_action', [rt.new_string('dismiss'),
		rt.call_function('__', [rt.new_string('Dismiss'), rt.new_string('woocommerce')]),
		rt.call_function('wc_admin_url', []rt.PhpVal{}),
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned(),
		rt.new_bool(false)])
	return var_note.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles.possibly_add_note() {
	mut var_note :=
		Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles.get_note()
	if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles.note_exists()) {
		return
	}
	rt.call_method(var_note, 'save', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles.note_exists() bool {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('admin-note'))
	mut var_data_store := iife_result_0
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles.note_name(),
	])
	return !(!rt.is_true(var_note_ids))
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_unsecuredreportfiles(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles{
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

fn create_automattic_woocommerce_internal_admin_notes_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles.get_note()
		}
		'possibly_add_note' {
			Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles.possibly_add_note()
			return rt.new_null()
		}
		'note_exists' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles.note_exists())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		Class_Automattic_WooCommerce_Admin_Notes_Note.class(),
	])))))
	{
		rt.call_function('class_alias', [
			Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Admin_Note.class(),
			Class_Automattic_WooCommerce_Admin_Notes_Note.class(),
		])
	}
}
