import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_GivingFeedbackNotes.note_name() string {
	return 'wc-admin-store-notice-giving-feedback-2'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_GivingFeedbackNotes {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_GivingFeedbackNotes.get_note() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Notes_GivingFeedbackNotes{}
	mut iife_result_0 := iife_temp_0.is_wc_admin_active_in_date_range(rt.new_string('week-1-4'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return rt.new_null()
	}
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [
		rt.new_string("You're invited to share your experience"),
		rt.new_string('woocommerce'),
	]))
	var_note.set_content(rt.call_function('__', [
		rt.new_string("Now that you’ve chosen us as a partner, our goal is to make sure we're providing the right tools to meet your needs. We're looking forward to having your feedback on the store setup experience so we can improve it in the future."),
		rt.new_string('woocommerce'),
	]))
	var_note.set_content_data(rt.new_object('stdClass', []string{},
		rt.array_to_object(rt.new_array())))
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_GivingFeedbackNotes.note_name())
	var_note.set_source(rt.new_string('woocommerce-admin'))
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Survey{}
	mut iife_result_1 := iife_temp_1.get_url(rt.new_string('/store-setup-survey'))
	var_note.add_action(rt.new_string('share-feedback'), rt.call_function('__', [
		rt.new_string('Share feedback'),
		rt.new_string('woocommerce'),
	]), iife_result_1)
	return mut var_note
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Survey {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_givingfeedbacknotes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_GivingFeedbackNotes {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_GivingFeedbackNotes{
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

fn create_automattic_woocommerce_internal_admin_survey(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Survey {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Survey{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_GivingFeedbackNotes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_GivingFeedbackNotes.get_note()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_GivingFeedbackNotes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_GivingFeedbackNotes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Survey) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Survey) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Survey) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
