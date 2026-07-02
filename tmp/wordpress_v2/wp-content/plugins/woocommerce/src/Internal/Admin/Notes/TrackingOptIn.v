import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn.note_name() string {
	return 'wc-admin-usage-tracking-opt-in'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn) construct() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_note_action_tracking-opt-in'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'opt_in_to_tracking' },
		]),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn.get_note() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_allow_tracking'),
		rt.new_string('no'),
	])))
	{
		return rt.new_null()
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn{}
	mut iife_result_0 := iife_temp_0.is_wc_admin_active_in_date_range(rt.new_string('week-1-4'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return rt.new_null()
	}
	mut var_content_format := rt.call_function('__', [
		rt.new_string('Gathering usage data allows us to improve WooCommerce. Your store will be considered as we evaluate new features, judge the quality of an update, or determine if an improvement makes sense. You can always visit the %1$sSettings%3$s and choose to stop sharing data. %2$sRead more%3$s about what data we collect.'),
		rt.new_string('woocommerce'),
	])
	mut var_note_content := rt.call_function('sprintf', [var_content_format.clone(),
		rt.new_string('<a href="' +
			(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=advanced&section=woocommerce_com')])])).str() +
			'" target="_blank">'),
		rt.new_string('<a href="https://woocommerce.com/usage-tracking?utm_medium=product" target="_blank">'),
		rt.new_string('</a>')])
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [
		rt.new_string('Help WooCommerce improve with usage tracking'),
		rt.new_string('woocommerce'),
	]))
	var_note.set_content(var_note_content.clone())
	var_note.set_content_data(rt.new_object('stdClass', []string{},
		rt.array_to_object(rt.new_array())))
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn.note_name())
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('tracking-opt-in'), rt.call_function('__', [
		rt.new_string('Activate usage tracking'),
		rt.new_string('woocommerce'),
	]), rt.new_bool(false),
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned(),
		rt.new_bool(true), rt.call_function('__', [
		rt.new_string('Usage tracking activated'),
		rt.new_string('woocommerce'),
	]))
	return mut var_note
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn) opt_in_to_tracking(var_note rt.PhpVal) {
	mut var_note_mutated := var_note
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn.note_name(),
		var_note_mutated.get_name()))
	{
		mut var_prev_value := rt.call_function('get_option', [
			rt.new_string('woocommerce_allow_tracking'),
			rt.new_string('no'),
		])
		rt.call_function('update_option', [rt.new_string('woocommerce_allow_tracking'),
			rt.new_string('yes')])
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Tracks')]))
			&& rt.is_true(rt.identical(rt.new_string('no'), var_prev_value)) {
			mut iife_temp_1 := Class_WC_Tracks{}
			mut iife_result_1 := iife_temp_1.track_woocommerce_allow_tracking_toggled(var_prev_value.clone(),
				rt.new_string('yes'), rt.new_string('usage_tracking_note'))
		}
		rt.call_function('wp_schedule_single_event', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(10)),
			rt.new_string('woocommerce_tracker_send_event'),
			rt.create_array([rt.ArrayItem{ key: none, val: true }]),
		])
	}
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_trackingoptin() &Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_notes_note(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks(_args ...rt.PhpVal) &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn.get_note()
		}
		'opt_in_to_tracking' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.opt_in_to_tracking(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
