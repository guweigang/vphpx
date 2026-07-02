import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses.note_name() string {
	return 'wc-admin-selling-online-courses'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses) construct() {
	rt.call_function('add_action', [
		rt.new_string('update_option_' +(Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option()).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'check_onboarding_profile' },
		]),
		rt.new_int(10),
		rt.new_int(3),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses.check_onboarding_profile(var_old_value rt.PhpVal, var_value rt.PhpVal, var_option rt.PhpVal) {
	if !(var_value.array_isset(rt.new_string('industry'))) {
		return
	}
	mut var_industry_slugs := rt.call_function('array_column', [
		var_value.array_get(rt.new_string('industry')),
		rt.new_string('slug'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string('education-and-learning'),
		var_industry_slugs.clone(),
		rt.new_bool(true),
	])))))
	{
		return
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses{}
	mut iife_result_0 := iife_temp_0.possibly_add_note()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses.get_note() rt.PhpVal {
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	var_note.set_title(rt.call_function('__', [
		rt.new_string('Do you want to sell online courses?'),
		rt.new_string('woocommerce'),
	]))
	var_note.set_content(rt.call_function('__', [
		rt.new_string('Online courses are a great solution for any business that can teach a new skill. Since courses don’t require physical product development or shipping, they’re affordable, fast to create, and can generate passive income for years to come. In this article, we provide you more information about selling courses using WooCommerce.'),
		rt.new_string('woocommerce'),
	]))
	var_note.set_content_data(rt.new_object('stdClass', []string{},
		rt.array_to_object(rt.new_array())))
	var_note.set_type(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_marketing())
	var_note.set_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses.note_name())
	var_note.set_source(rt.new_string('woocommerce-admin'))
	var_note.add_action(rt.new_string('learn-more'), rt.call_function('__', [
		rt.new_string('Learn more'),
		rt.new_string('woocommerce'),
	]),
		rt.new_string('https://woocommerce.com/posts/how-to-sell-online-courses-wordpress/?utm_source=inbox&utm_medium=product'),
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned())
	return mut var_note
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_sellingonlinecourses() &Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'check_onboarding_profile' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses.check_onboarding_profile(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses.get_note()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
