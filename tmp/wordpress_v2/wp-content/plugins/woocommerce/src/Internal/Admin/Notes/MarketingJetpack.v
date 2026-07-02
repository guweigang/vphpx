import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.note_name() string {
	return 'wc-admin-marketing-jetpack-backup'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.backup_ids() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 2010 },
		rt.ArrayItem{ key: none, val: 2011 }, rt.ArrayItem{ key: none, val: 2012 },
		rt.ArrayItem{ key: none, val: 2013 }, rt.ArrayItem{ key: none, val: 2014 },
		rt.ArrayItem{ key: none, val: 2015 }, rt.ArrayItem{ key: none, val: 2100 },
		rt.ArrayItem{ key: none, val: 2101 }, rt.ArrayItem{ key: none, val: 2102 },
		rt.ArrayItem{ key: none, val: 2103 }, rt.ArrayItem{ key: none, val: 2005 },
		rt.ArrayItem{ key: none, val: 2006 }, rt.ArrayItem{ key: none, val: 2000 },
		rt.ArrayItem{ key: none, val: 2003 }, rt.ArrayItem{ key: none, val: 2001 },
		rt.ArrayItem{ key: none, val: 2004 }])
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.possibly_add_note() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_0 := iife_temp_0.get_installed_plugin_slugs()
	mut var_installed_plugins := iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string('jetpack'),
		var_installed_plugins.clone(),
		rt.new_bool(true),
	])))))
	{
		return
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Data_Store{}
	mut iife_result_1 := iife_temp_1.load(rt.new_string('admin-note'))
	mut var_data_store := iife_result_1
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.note_name(),
	])
	if !(!rt.is_true(var_note_ids)) {
		mut var_note_id := rt.call_function('array_pop', [var_note_ids.clone()])
		mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
		mut iife_result_2 := iife_temp_2.get_note(var_note_id.clone())
		mut var_note := iife_result_2
		if rt.is_true(rt.identical(rt.new_bool(false), var_note)) {
			return
		}
		if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.has_backups())
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned(), rt.call_method(var_note, 'get_status', []rt.PhpVal{}))))) {
			rt.call_method(var_note, 'set_status', [
				Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned(),
			])
			rt.call_method(var_note, 'save', []rt.PhpVal{})
		}
		return
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack{}
	mut iife_result_3 := iife_temp_3.is_wc_admin_active_in_date_range(rt.new_string('week-1-4'), rt.mul(rt.get_constant('DAY_IN_SECONDS'),
		rt.new_int(3)))
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack{}
	mut iife_result_4 := iife_temp_4.can_be_added()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_3))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(iife_result_4))))
		|| rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.has_backups()) {
		return
	}
	var_note = Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.get_note()
	rt.call_method(var_note, 'save', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.get_note() rt.PhpVal {
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	rt.call_method(var_note, 'set_title', [
		rt.call_function('__', [
			rt.new_string('Protect your WooCommerce Store with Jetpack Backup.'),
			rt.new_string('woocommerce'),
		]),
	])
	rt.call_method(var_note, 'set_content', [
		rt.call_function('__', [
			rt.new_string('Store downtime means lost sales. One-click restores get you back online quickly if something goes wrong.'),
			rt.new_string('woocommerce'),
		]),
	])
	rt.call_method(var_note, 'set_type', [
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_marketing(),
	])
	rt.call_method(var_note, 'set_name', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.note_name(),
	])
	rt.call_method(var_note, 'set_layout', [rt.new_string('thumbnail')])
	rt.call_method(var_note, 'set_image', [
		rt.new_string(
			(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/admin_notes/marketing-jetpack-2x.png'),
	])
	rt.call_method(var_note, 'set_content_data', [rt.array_to_object(rt.new_array())])
	rt.call_method(var_note, 'set_source', [rt.new_string('woocommerce-admin-notes')])
	rt.call_method(var_note, 'add_action', [rt.new_string('jetpack-backup-woocommerce'),
		rt.call_function('__', [rt.new_string('Get backups'),
			rt.new_string('woocommerce')]),
		rt.call_function('esc_url', [
			rt.new_string('https://jetpack.com/upgrade/backup-woocommerce/?utm_source=inbox&utm_medium=automattic_referred&utm_campaign=jp_backup_to_woo'),
		]),
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned()])
	return var_note.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.has_backups() bool {
	mut var_product_ids := rt.new_array()
	mut var_plan := rt.call_function('get_option', [rt.new_string('jetpack_active_plan')])
	if !(!rt.is_true(var_plan)) {
		var_product_ids.array_push(var_plan.array_get(rt.new_string('product_id')))
	}
	mut var_products := rt.call_function('get_option', [
		rt.new_string('jetpack_site_products'),
	])
	if !(!rt.is_true(var_products)) {
		mut iter_1 := var_products.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_product := item_1.val
			var_product_ids.array_push(var_product.array_get(rt.new_string('product_id')))
		}
	}
	return (rt.call_function('array_intersect', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.backup_ids(),
		var_product_ids.clone(),
	])).to_bool()
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_marketingjetpack(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pluginshelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
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

fn create_automattic_woocommerce_admin_notes_notes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'possibly_add_note' {
			Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.possibly_add_note()
			return rt.new_null()
		}
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.get_note()
		}
		'has_backups' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack.has_backups())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_MarketingJetpack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
