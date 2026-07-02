import rt

struct Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner.run_spec(var_spec rt.PhpVal, var_stored_state rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_0 := iife_temp_0.load_data_store()
	mut var_data_store := iife_result_0
	mut var_existing_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [
		rt.get_property(var_spec, 'slug'),
	])
	if !(rt.call_function('is_countable', [var_existing_note_ids.clone()]))
		|| var_existing_note_ids.clone().array_count() == 0 {
		mut var_note := create_automattic_woocommerce_admin_notes_note()
		rt.call_method(var_note, 'set_status', [
			Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_pending(),
		])
	} else {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
		mut iife_result_1 := iife_temp_1.get_note(var_existing_note_ids.array_get(rt.new_int(0)))
		var_note = iife_result_1
		if rt.is_true(rt.identical(var_note, rt.new_bool(false))) {
			return rt.new_null()
		}
	}
	mut var_previous_status := rt.call_method(var_note, 'get_status', []rt.PhpVal{})
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus{}
	mut iife_result_2 := iife_temp_2.evaluate(var_spec.clone(), var_previous_status.clone(),
		var_stored_state.clone(),
		create_automattic_woocommerce_admin_remotespecs_ruleprocessors_ruleevaluator())
	mut var_status := iife_result_2
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Admin_RemoteInboxNotifications_Throwable') {
		mut var_e := var_e_1.clone()
		return var_e.clone()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_previous_status, var_status)))) {
		rt.call_method(var_note, 'set_date_created', [
			rt.call_function('time', []rt.PhpVal{}),
		])
	}
	mut var_locale := Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner.get_locale(rt.get_property(var_spec,
		'locales'))
	if rt.is_true(rt.identical(var_locale, rt.new_null())) {
		return rt.new_null()
	}
	rt.call_method(var_note, 'set_title', [rt.get_property(var_locale, 'title')])
	rt.call_method(var_note, 'set_content', [rt.get_property(var_locale, 'content')])
	rt.call_method(var_note, 'set_content_data', [if !(rt.get_property(var_spec, 'content_data')).is_null() {
		rt.get_property(var_spec, 'content_data')
	} else {
		rt.array_to_object(rt.new_array())
	}])
	rt.call_method(var_note, 'set_status', [var_status.clone()])
	rt.call_method(var_note, 'set_type', [rt.get_property(var_spec, 'type')])
	rt.call_method(var_note, 'set_name', [rt.get_property(var_spec, 'slug')])
	if !(rt.get_property(var_spec, 'source')).is_null() {
		rt.call_method(var_note, 'set_source', [rt.get_property(var_spec, 'source')])
	}
	if !(rt.get_property(var_spec, 'layout')).is_null() {
		rt.call_method(var_note, 'set_layout', [rt.get_property(var_spec, 'layout')])
	}
	rt.call_method(var_note, 'set_actions', [
		Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner.get_actions(var_spec.clone()),
	])
	rt.call_method(var_note, 'save', []rt.PhpVal{})
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner.get_url(var_action rt.PhpVal) string {
	if !(!(rt.get_property(var_action, 'url')).is_null()) {
		return ''
	}
	if !(rt.get_property(var_action, 'url_is_admin_query')).is_null()
		&& rt.is_true(rt.get_property(var_action, 'url_is_admin_query')) {
		if rt.is_true(rt.identical(rt.call_function('strpos', [
			rt.get_property(var_action, 'url'),
			rt.new_string('&path'),
		]), rt.new_int(0)))
		{
			return (rt.call_function('wc_admin_url', [rt.get_property(var_action, 'url')])).str()
		}
		return (rt.call_function('admin_url', [rt.get_property(var_action, 'url')])).str()
	}
	return (rt.get_property(var_action, 'url')).str()
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner.get_locale(var_locales rt.PhpVal) rt.PhpVal {
	mut var_wp_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	closure_4_fn := fn [var_wp_locale] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_l := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(var_wp_locale, rt.get_property(var_l, 'locale'))
	}
	closure_5_fn := fn [var_wp_locale] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_l := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(var_wp_locale, rt.get_property(var_l, 'locale'))
	}
	mut var_matching_wp_locales := rt.call_function('array_values', [
		rt.call_function('array_filter', [var_locales.clone(),
			rt.new_closure(closure_4_fn)]),
	])
	if rt.is_true(rt.new_bool(var_matching_wp_locales.clone().array_count() != 0)) {
		return var_matching_wp_locales.array_get(rt.new_int(0))
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_l := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.get_property(var_l, 'locale'), rt.new_string('en_US'))
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_l := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.get_property(var_l, 'locale'), rt.new_string('en_US'))
	}
	mut var_en_us_locales := rt.call_function('array_values', [
		rt.call_function('array_filter', [var_locales.clone(),
			rt.new_closure(closure_6_fn)]),
	])
	if rt.is_true(rt.new_bool(var_en_us_locales.clone().array_count() != 0)) {
		return var_en_us_locales.array_get(rt.new_int(0))
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner.get_action_locale(var_action_locales rt.PhpVal) rt.PhpVal {
	mut var_wp_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	closure_8_fn := fn [var_wp_locale] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_l := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(var_wp_locale, rt.get_property(var_l, 'locale'))
	}
	closure_9_fn := fn [var_wp_locale] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_l := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(var_wp_locale, rt.get_property(var_l, 'locale'))
	}
	mut var_matching_wp_locales := rt.call_function('array_values', [
		rt.call_function('array_filter', [var_action_locales.clone(),
			rt.new_closure(closure_8_fn)]),
	])
	if rt.is_true(rt.new_bool(var_matching_wp_locales.clone().array_count() != 0)) {
		return var_matching_wp_locales.array_get(rt.new_int(0))
	}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_l := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.get_property(var_l, 'locale'), rt.new_string('en_US'))
	}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_l := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.get_property(var_l, 'locale'), rt.new_string('en_US'))
	}
	mut var_en_us_locales := rt.call_function('array_values', [
		rt.call_function('array_filter', [var_action_locales.clone(),
			rt.new_closure(closure_10_fn)]),
	])
	if rt.is_true(rt.new_bool(var_en_us_locales.clone().array_count() != 0)) {
		return var_en_us_locales.array_get(rt.new_int(0))
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner.get_actions(var_spec rt.PhpVal) rt.PhpVal {
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	mut var_actions := if !(rt.get_property(var_spec, 'actions')).is_null() {
		rt.get_property(var_spec, 'actions')
	} else {
		rt.new_array()
	}
	mut iter_1 := var_actions.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_action := item_1.val
		mut var_action_locale := Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner.get_action_locale(rt.get_property(var_action,
			'locales'))
		mut var_url :=
			Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner.get_url(var_action.clone())
		rt.call_method(var_note, 'add_action', [rt.get_property(var_action, 'name'), if
			rt.is_true(rt.identical(var_action_locale, rt.new_null()))
			|| !(!(rt.get_property(var_action_locale, 'label')).is_null()) {
			rt.new_string('')
		} else {
			rt.get_property(var_action_locale, 'label')
		}, var_url.clone(), rt.get_property(var_action, 'status')])
	}
	return rt.call_method(var_note, 'get_actions', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remoteinboxnotifications_specrunner(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner{
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

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_evaluateandgetstatus(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_ruleevaluator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'run_spec' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner.run_spec(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner.get_url(dispatch_arg_0))
		}
		'get_locale' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner.get_locale(dispatch_arg_0)
		}
		'get_action_locale' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner.get_action_locale(dispatch_arg_0)
		}
		'get_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner.get_actions(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
