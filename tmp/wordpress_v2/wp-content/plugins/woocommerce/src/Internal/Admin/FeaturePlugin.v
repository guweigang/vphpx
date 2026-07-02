import rt

struct Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin {
	rt.PhpObjectBase
pub mut:
	initialized bool
}

fn init_static_automattic_woocommerce_internal_admin_featureplugin() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_FeaturePlugin', 'instance',
		rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) construct() {
}

fn Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin.instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_FeaturePlugin',
		'instance')))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_FeaturePlugin', 'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_static',
			[]string{}, create_automattic_woocommerce_internal_admin_static()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_FeaturePlugin', 'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WC_ABSPATH'),
	])))))
	{
		return
	}
	if this.initialized {
		return
	}
	this.initialized = true
	this.define_constants()
	rt.include_file(
		(rt.get_constant('WC_ADMIN_ABSPATH')).str() + '/includes/react-admin/page-controller-functions.php',
		'4')
	rt.include_file(
		(rt.get_constant('WC_ADMIN_ABSPATH')).str() + '/src/Admin/Notes/DeprecatedNotes.php', '4')
	rt.include_file(
		(rt.get_constant('WC_ADMIN_ABSPATH')).str() + '/includes/react-admin/core-functions.php',
		'4')
	rt.include_file(
		(rt.get_constant('WC_ADMIN_ABSPATH')).str() + '/includes/react-admin/feature-config.php',
		'4')
	rt.include_file(
		(rt.get_constant('WC_ADMIN_ABSPATH')).str() + '/includes/react-admin/wc-admin-update-functions.php',
		'4')
	rt.include_file(
		(rt.get_constant('WC_ADMIN_ABSPATH')).str() + '/includes/react-admin/class-experimental-abtest.php',
		'4')
	if rt.is_true(rt.call_function('did_action', [rt.new_string('plugins_loaded')])) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin{}
		iife_temp_0.on_plugins_loaded()
		rt.new_null()
	} else {
		rt.call_function('add_action', [rt.new_string('plugins_loaded'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_FeaturePlugin',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'on_plugins_loaded' },
			]),
			rt.new_int(9)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) on_plugins_loaded() {
	this.hooks()
	this.includes()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) define_constants() {
	this.define(rt.new_string('WC_ADMIN_APP'), rt.new_string('wc-admin-app'))
	this.define(rt.new_string('WC_ADMIN_ABSPATH'), rt.get_constant('WC_ABSPATH'))
	this.define(rt.new_string('WC_ADMIN_DIST_JS_FOLDER'), rt.new_string('assets/client/admin/'))
	this.define(rt.new_string('WC_ADMIN_DIST_CSS_FOLDER'), rt.new_string('assets/client/admin/'))
	this.define(rt.new_string('WC_ADMIN_PLUGIN_FILE'), rt.get_constant('WC_PLUGIN_FILE'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WC_ADMIN_IMAGES_FOLDER_URL'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WC_ADMIN_IMAGES_FOLDER_URL'),
			rt.call_function('plugins_url', [rt.new_string('assets/images'),
				rt.get_constant('WC_PLUGIN_FILE')])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WC_ADMIN_VERSION_NUMBER'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WC_ADMIN_VERSION_NUMBER'),
			rt.new_string('3.3.0')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) includes() {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Events{}
	mut iife_result_1 := iife_temp_1.instance()
	rt.call_method(iife_result_1, 'init', []rt.PhpVal{})
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_2 := iife_temp_2.init()
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_PluginsInstaller{}
	mut iife_result_3 := iife_temp_3.init()
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_4 := iife_temp_4.init()
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_API_Init{}
	mut iife_result_5 := iife_temp_5.instance()
	mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_6 := iife_temp_6.is_enabled(rt.new_string('onboarding'))
	if rt.is_true(iife_result_6) {
		mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding{}
		mut iife_result_7 := iife_temp_7.init()
	}
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_8 := iife_temp_8.is_enabled(rt.new_string('analytics'))
	if rt.is_true(iife_result_8) {
		mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_ReportsSync{}
		mut iife_result_9 := iife_temp_9.init()
		mut iife_temp_10 := Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup{}
		mut iife_result_10 := iife_temp_10.instance()
		rt.call_method(iife_result_10, 'init', []rt.PhpVal{})
		mut iife_temp_11 := Class_Automattic_WooCommerce_Admin_ReportExporter{}
		mut iife_result_11 := iife_temp_11.init()
	}
	create_automattic_woocommerce_internal_admin_notes_woosubscriptionsnotes()
	create_automattic_woocommerce_internal_admin_notes_ordermilestones()
	create_automattic_woocommerce_internal_admin_notes_trackingoptin()
	create_automattic_woocommerce_internal_admin_notes_woocommercepayments()
	create_automattic_woocommerce_internal_admin_notes_installjpandwcsplugins()
	create_automattic_woocommerce_internal_admin_notes_sellingonlinecourses()
	create_automattic_woocommerce_internal_admin_notes_magentomigration()
	create_automattic_woocommerce_internal_admin_notes_scheduledupdatespromotion()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) hooks() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_features'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_FeaturePlugin',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'replace_supported_features' },
		]),
		rt.new_int(0)])
	mut iife_temp_12 := Class_Automattic_WooCommerce_Internal_Admin_Loader{}
	mut iife_result_12 := iife_temp_12.get_instance()
	mut iife_temp_13 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_13 := iife_temp_13.get_instance()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) replace_supported_features(var_features rt.PhpVal) rt.PhpVal {
	mut var_features_mutated := var_features
	mut var_feature_config := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_get_feature_config'),
		rt.call_function('wc_admin_get_feature_config', []rt.PhpVal{}),
	])
	var_features_mutated = rt.func_array_keys(rt.call_function('array_filter', [
		var_feature_config.clone(),
	]))
	return var_features_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) define(var_name rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		var_name.clone()])))))
	{
		rt.call_function('define', [var_name.clone(), var_value.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) magic_clone() {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) magic_wakeup() {
	exit(0)
}

struct Class_Automattic_WooCommerce_Internal_Admin_static {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Events {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsInstaller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Init {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_ReportsSync {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_ReportExporter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Loader {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_featureplugin() &Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin{
		PhpObjectBase: rt.PhpObjectBase{}
		initialized:   false
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_static {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_events(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Events {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Events{
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

fn create_automattic_woocommerce_admin_pluginsinstaller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsInstaller {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsInstaller{
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

fn create_automattic_woocommerce_admin_api_init(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboarding(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_reportssync(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_ReportsSync {
	mut obj := &Class_Automattic_WooCommerce_Admin_ReportsSync{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_categorylookup(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_reportexporter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_ReportExporter {
	mut obj := &Class_Automattic_WooCommerce_Admin_ReportExporter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_woosubscriptionsnotes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_ordermilestones(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_trackingoptin(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_woocommercepayments(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_installjpandwcsplugins(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_sellingonlinecourses(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_magentomigration(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_scheduledupdatespromotion(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_loader(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Loader {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Loader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin.instance()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'on_plugins_loaded' {
			this.on_plugins_loaded()
			return rt.new_null()
		}
		'define_constants' {
			this.define_constants()
			return rt.new_null()
		}
		'includes' {
			this.includes()
			return rt.new_null()
		}
		'hooks' {
			this.hooks()
			return rt.new_null()
		}
		'replace_supported_features' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.replace_supported_features(dispatch_arg_0)
		}
		'define' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.define(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'initialized' { return rt.new_bool(this.initialized) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_FeaturePlugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'initialized' {
			this.initialized = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Events) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Events) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstaller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsInstaller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstaller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportsSync) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_ReportsSync) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportsSync) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportExporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_ReportExporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportExporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_OrderMilestones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_TrackingOptIn) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooCommercePayments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_SellingOnlineCourses) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_MagentoMigration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_ScheduledUpdatesPromotion) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Loader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Loader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Loader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
