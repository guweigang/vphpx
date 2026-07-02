import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_onboarding_onboardingsetupwizard() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard',
		'instance', rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard',
			'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_static',
			[]string{}, create_automattic_woocommerce_internal_admin_onboarding_static()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard',
		'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) init() {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_slug := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_source := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		this.install_options_for_core_profiler_plugin_install(var_slug.clone(), var_source.clone())
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_plugins_install_before'),
		rt.new_closure(closure_1_fn), rt.new_int(10), rt.new_int(2)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_components_settings'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'component_settings' },
		]),
		rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_shared_settings'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'component_settings' },
		]),
		rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_preload_settings'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'preload_settings' },
		])])
	rt.call_function('add_filter', [rt.new_string('admin_body_class'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_loading_classes' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'do_admin_redirects' },
		])])
	rt.call_function('add_action', [rt.new_string('current_screen'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'redirect_to_profiler' },
		])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_show_admin_notice'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'remove_old_install_notice' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('admin_viewport_meta'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'set_viewport_meta_tag' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) is_running_from_async_action_scheduler() bool {
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('\\wc_is_running_from_async_action_scheduler'),
	]))
	{
		return (rt.call_function('wc_is_running_from_async_action_scheduler', []rt.PhpVal{})).to_bool()
	}
	return rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.identical(rt.new_string('as_async_request_queue_runner'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) do_admin_redirects() {
	if this.is_running_from_async_action_scheduler() {
		return
	}
	if rt.is_true(rt.call_function('get_transient', [rt.new_string('_wc_activation_redirect')]))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_enable_setup_wizard'), rt.new_bool(true)])) {
		mut var_do_redirect := rt.new_bool(true)
		mut var_current_page := if rt.get_superglobal('_GET').array_isset(rt.new_string('page')) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('page'))]),
			]) } else { rt.new_bool(false) }
		mut var_is_onboarding_path := rt.new_bool(
			!(rt.get_superglobal('_GET').array_isset(rt.new_string('path')))
			|| rt.is_true(rt.identical(rt.new_string('/setup-wizard'), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('page'))])]))))
		if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
			var_do_redirect = rt.new_bool(false)
		}
		if ((rt.is_true(rt.identical(rt.new_string('wc-admin'), var_current_page))
			&& rt.is_true(var_is_onboarding_path))
			|| rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_prevent_automatic_wizard_redirect'), rt.new_bool(false)])))
			|| rt.get_superglobal('_GET').array_isset(rt.new_string('activate-multi')) {
			rt.call_function('delete_transient', [
				rt.new_string('_wc_activation_redirect'),
			])
			var_do_redirect = rt.new_bool(false)
		}
		if rt.is_true(var_do_redirect) {
			rt.call_function('delete_transient', [
				rt.new_string('_wc_activation_redirect'),
			])
			rt.call_function('wp_safe_redirect', [
				rt.call_function('wc_admin_url', []rt.PhpVal{}),
			])
			exit(0)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) trigger_profile_completed_action(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	if var_old_value.array_isset(rt.new_string('completed'))
		&& rt.is_true(var_old_value.array_get(rt.new_string('completed'))) {
		return
	}
	if !(var_value.array_isset(rt.new_string('completed')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_value.array_get(rt.new_string('completed')))))) {
		return
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_onboarding_profile_completed'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) should_show() bool {
	if this.is_setup_wizard() {
		return true
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile{}
	mut iife_result_1 := iife_temp_1.needs_completion()
	return iife_result_1.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) redirect_to_profiler() {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile{}
	mut iife_result_2 := iife_temp_2.needs_completion()
	if !(this.is_homepage()) || rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2)))) {
		return
	}
	rt.call_function('wp_safe_redirect', [
		rt.call_function('wc_admin_url', [rt.new_string('&path=/setup-wizard')]),
	])
	exit(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) is_setup_wizard() bool {
	return rt.get_superglobal('_GET').array_isset(rt.new_string('page'))
		&& rt.is_true(rt.identical(rt.new_string('wc-admin'), rt.get_superglobal('_GET').array_get(rt.new_string('page'))))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('path'))
		&& rt.is_true(rt.identical(rt.new_string('/setup-wizard'), rt.get_superglobal('_GET').array_get(rt.new_string('path'))))
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) is_homepage() bool {
	return rt.get_superglobal('_GET').array_isset(rt.new_string('page'))
		&& rt.is_true(rt.identical(rt.new_string('wc-admin'), rt.get_superglobal('_GET').array_get(rt.new_string('page'))))
		&& !(rt.get_superglobal('_GET').array_isset(rt.new_string('path')))
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) is_woocommerce_page() bool {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_3 := iife_temp_3.get_instance()
	mut var_current_page := rt.call_method(iife_result_3, 'get_current_page', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_page))))
		|| !(var_current_page.array_isset(rt.new_string('path'))) {
		return false
	}
	return (rt.identical(rt.new_int(0), rt.call_function('strpos', [
		var_current_page.array_get(rt.new_string('path')),
		rt.new_string('wc-admin'),
	]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) component_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut var_profile := rt.cast_array(rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(),
		rt.new_array(),
	]))
	var_settings_mutated.array_set('onboarding', rt.create_array([
		rt.ArrayItem{ key: 'profile', val: var_profile },
	]))
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_4 := iife_temp_4.get_visible()
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_5 := iife_temp_5.get_visible()
	if (!(this.should_show())
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(iife_result_4.array_count()))))))
		|| !(this.is_woocommerce_page()) {
		return var_settings_mutated.clone()
	}
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/helper/class-wc-helper-options.php',
		'2')
	mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_Options{}
	mut iife_result_6 := iife_temp_6.get(rt.new_string('auth'))
	mut var_wccom_auth := iife_result_6
	var_profile.array_set('wccom_connected', if !rt.is_true(var_wccom_auth.array_get(rt.new_string('access_token'))) {
		false
	} else {
		true
	})
	var_settings_mutated.array_get_mut('onboarding').array_set('currencySymbols', rt.call_function('get_woocommerce_currency_symbols',
		[]rt.PhpVal{}))
	var_settings_mutated.array_get_mut('onboarding').array_set('euCountries', rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'countries'), 'get_european_union_countries', []rt.PhpVal{}))
	var_settings_mutated.array_get_mut('onboarding').array_set('localeInfo', rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/i18n/locale-info.php', '1'))
	var_settings_mutated.array_get_mut('onboarding').array_set('profile', var_profile.clone())
	if this.is_setup_wizard() {
		var_settings_mutated.array_get_mut('onboarding').array_set('pageCount', rt.new_int((rt.get_property(rt.call_function('wp_count_posts', [
			rt.new_string('page'),
		]), 'publish')).to_i64()))
		var_settings_mutated.array_get_mut('onboarding').array_set('postCount', rt.new_int((rt.get_property(rt.call_function('wp_count_posts', [
			rt.new_string('post'),
		]), 'publish')).to_i64()))
		var_settings_mutated.array_get_mut('onboarding').array_set('isBlockTheme', rt.call_function('wp_is_block_theme',
			[]rt.PhpVal{}))
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_onboarding_preloaded_data'),
		var_settings_mutated.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) preload_settings(var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	var_options_mutated.array_push('general')
	return var_options_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) add_loading_classes(var_classes rt.PhpVal) rt.PhpVal {
	if this.is_setup_wizard() {
		var_classes = rt.concat(var_classes, rt.new_string(' woocommerce-admin-full-screen'))
	}
	return var_classes.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) remove_old_install_notice(var_show rt.PhpVal, var_notice rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string('install'), var_notice)) {
		return false
	}
	return var_show.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) set_viewport_meta_tag(var_viewport_meta rt.PhpVal) string {
	if !(this.is_setup_wizard()) {
		return var_viewport_meta.str()
	}
	return 'width=device-width, initial-scale=1.0, maximum-scale=1.0'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) install_options_for_core_profiler_plugin_install(var_slug rt.PhpVal, var_source rt.PhpVal) rt.PhpVal {
	mut var_spec := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('core-profiler'), var_source)))) {
		return rt.new_null()
	}
	mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init{}
	mut iife_result_7 := iife_temp_7.get_specs()
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_spec := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.new_string('obw/core-profiler'), rt.get_property(var_spec, 'key'))
	}
	mut iife_temp_9 := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init{}
	mut iife_result_9 := iife_temp_9.get_specs()
	mut var_specs := rt.call_function('array_filter', [iife_result_7, rt.new_closure(closure_9_fn)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_specs)))) {
		return rt.new_null()
	}
	mut var_install_options := create_automattic_woocommerce_internal_admin_remotefreeextensions_processcoreprofilerplugininstalloptions(rt.get_property(rt.call_function('current', [
		var_specs.clone(),
	]), 'plugins'), var_slug.clone(), rt.call_function('wc_get_logger', []rt.PhpVal{}))
	var_install_options.process_install_options()
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_Options {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingsetupwizard(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingprofile(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasklists(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_wc_helper_options(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_Options {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_init(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_processcoreprofilerplugininstalloptions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard.instance()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'is_running_from_async_action_scheduler' {
			return rt.new_bool(this.is_running_from_async_action_scheduler())
		}
		'do_admin_redirects' {
			this.do_admin_redirects()
			return rt.new_null()
		}
		'trigger_profile_completed_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.trigger_profile_completed_action(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'should_show' {
			return rt.new_bool(this.should_show())
		}
		'redirect_to_profiler' {
			this.redirect_to_profiler()
			return rt.new_null()
		}
		'is_setup_wizard' {
			return rt.new_bool(this.is_setup_wizard())
		}
		'is_homepage' {
			return rt.new_bool(this.is_homepage())
		}
		'is_woocommerce_page' {
			return rt.new_bool(this.is_woocommerce_page())
		}
		'component_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.component_settings(dispatch_arg_0)
		}
		'preload_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.preload_settings(dispatch_arg_0)
		}
		'add_loading_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_loading_classes(dispatch_arg_0)
		}
		'remove_old_install_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.remove_old_install_notice(dispatch_arg_0, dispatch_arg_1))
		}
		'set_viewport_meta_tag' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.set_viewport_meta_tag(dispatch_arg_0))
		}
		'install_options_for_core_profiler_plugin_install' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.install_options_for_core_profiler_plugin_install(dispatch_arg_0,
				dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
