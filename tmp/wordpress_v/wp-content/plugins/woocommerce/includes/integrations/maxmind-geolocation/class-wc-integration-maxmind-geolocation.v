import rt

struct Class_WC_Integration_MaxMind_Geolocation {
	rt.PhpObjectBase
pub mut:
		database_service rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Integration_MaxMind_Geolocation) construct()  {
	this.dispatch_set_prop('id', rt.new_string('maxmind_geolocation'))
	this.dispatch_set_prop('method_title', rt.call_function('__', [rt.new_string('MaxMind Geolocation'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('method_description', rt.call_function('__', [rt.new_string('An integration for utilizing MaxMind to do Geolocation lookups. Please note that this integration will only do country lookups.'), rt.new_string('woocommerce')]))
	this.database_service = rt.call_function('apply_filters', [rt.new_string('woocommerce_maxmind_geolocation_database_service'), rt.new_null()])
	if rt.is_true(rt.identical(rt.new_null(), this.database_service)) {
		this.database_service = create_wc_integration_maxmind_database_service(this.get_database_prefix())
	}
	this.init_form_fields()
	this.init_settings()
	rt.call_function('add_action', ['woocommerce_update_options_integration_' + rt.get_property(rt.new_object('WC_Integration_MaxMind_Geolocation', ['WC_Integration'], &this), 'id'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Integration_MaxMind_Geolocation', ['WC_Integration'], &this) }, rt.ArrayItem{ key: none, val: 'process_admin_options' }])])
	rt.call_function('add_action', [rt.new_string('update_option_woocommerce_default_customer_address'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Integration_MaxMind_Geolocation', ['WC_Integration'], &this) }, rt.ArrayItem{ key: none, val: 'display_missing_license_key_notice' }]), rt.new_int(1000), rt.new_int(2)])
	mut var_bind_updater := rt.call_function('apply_filters_deprecated', [rt.new_string('woocommerce_geolocation_update_database_periodically'), rt.create_array([rt.ArrayItem{ key: none, val: true }]), rt.new_string('3.9.0'), rt.new_string('woocommerce_maxmind_geolocation_update_database_periodically')])
	var_bind_updater = rt.call_function('apply_filters', [rt.new_string('woocommerce_maxmind_geolocation_update_database_periodically'), var_bind_updater.dup()])
	if rt.is_true(var_bind_updater) {
		rt.call_function('add_action', [rt.new_string('woocommerce_geoip_updater'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Integration_MaxMind_Geolocation', ['WC_Integration'], &this) }, rt.ArrayItem{ key: none, val: 'update_database' }])])
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_geolocation'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Integration_MaxMind_Geolocation', ['WC_Integration'], &this) }, rt.ArrayItem{ key: none, val: 'get_geolocation' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WC_Integration_MaxMind_Geolocation) admin_options()  {
	this.Class_WC_Integration.admin_options()
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/views/html-admin-options.php', '1')
}

fn (mut this Class_WC_Integration_MaxMind_Geolocation) init_form_fields()  {
	this.dispatch_set_prop('form_fields', rt.create_array([rt.ArrayItem{ key: 'license_key', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('MaxMind License Key'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'password' }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The key that will be used when dealing with MaxMind Geolocation services. You can read how to generate one in <a href="%1$s">MaxMind Geolocation Integration documentation</a>.'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/document/maxmind-geolocation-integration/')]) }, rt.ArrayItem{ key: 'desc_tip', val: false }, rt.ArrayItem{ key: 'default', val: '' }]) }]))
}

fn (mut this Class_WC_Integration_MaxMind_Geolocation) get_database_service() rt.PhpVal {
	return this.database_service
}

fn (mut this Class_WC_Integration_MaxMind_Geolocation) validate_license_key_field(var_key rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	var_value_mutated = this.validate_password_field(var_key.dup(), var_value_mutated.dup())
	if !rt.is_true(var_value_mutated) {
		return var_value_mutated.dup()
	}
	mut var_tmp_database_path := rt.call_method(this.database_service, 'download_database', [var_value_mutated.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_tmp_database_path.dup()])) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Settings{}; return temp.add_error(arg_0) }(rt.call_method(var_tmp_database_path, 'get_error_message', []rt.PhpVal{}))
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_tmp_database_path, 'get_error_message', []rt.PhpVal{}))))
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Integration_MaxMind_Geolocation{}; temp.update_database(arg_0); return rt.new_null() }(var_tmp_database_path.dup())
	this.remove_missing_license_key_notice()
	return var_value_mutated.dup()
}

fn (mut this Class_WC_Integration_MaxMind_Geolocation) update_database(var_new_database_path rt.PhpVal)  {
	mut var_wp_filesystem := rt.new_null()
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('WP_Filesystem', []rt.PhpVal{}))))) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.call_function('__', [rt.new_string('Failed to initialise WC_Filesystem API while trying to update the MaxMind Geolocation database.'), rt.new_string('woocommerce')])])
		return rt.new_null()
	}
	// unsupported statement: Stmt_Global
	mut var_target_database_path := rt.call_method(this.database_service, 'get_database_path', []rt.PhpVal{})
	if !rt.is_true(var_target_database_path) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [var_target_database_path.dup()])) {
		rt.call_method(var_wp_filesystem, 'delete', [var_target_database_path.dup()])
	}
	if !(var_new_database_path).is_null() {
		mut var_tmp_database_path := var_new_database_path
	} else {
		mut var_license_key := this.get_option(rt.new_string('license_key'))
		if !rt.is_true(var_license_key) {
			return rt.new_null()
		}
		var_tmp_database_path = rt.call_method(this.database_service, 'download_database', [var_license_key.dup()])
		if rt.is_true(rt.call_function('is_wp_error', [var_tmp_database_path.dup()])) {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'notice', [rt.call_method(var_tmp_database_path, 'get_error_message', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'source', val: 'maxmind-geolocation' }])])
			return rt.new_null()
		}
	}
	rt.call_method(var_wp_filesystem, 'move', [var_tmp_database_path.dup(), var_target_database_path.dup(), rt.new_bool(true)])
	rt.call_method(var_wp_filesystem, 'delete', [rt.call_function('dirname', [var_tmp_database_path.dup()])])
}

fn (mut this Class_WC_Integration_MaxMind_Geolocation) get_geolocation(var_data rt.PhpVal, var_ip_address rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_data.array_get('country'))) {
		return var_data.dup()
	}
	if !rt.is_true(var_ip_address) {
		return var_data.dup()
	}
	mut var_country_code := rt.call_method(this.database_service, 'get_iso_country_code_for_ip', [var_ip_address.dup()])
	return rt.create_array([rt.ArrayItem{ key: 'country', val: var_country_code }, rt.ArrayItem{ key: 'state', val: '' }, rt.ArrayItem{ key: 'city', val: '' }, rt.ArrayItem{ key: 'postcode', val: '' }])
}

fn (mut this Class_WC_Integration_MaxMind_Geolocation) get_database_prefix() rt.PhpVal {
	mut var_prefix := this.get_option(rt.new_string('database_prefix'))
	if !rt.is_true(var_prefix) {
		var_prefix = rt.call_function('wp_generate_password', [rt.new_int(32), rt.new_bool(false)])
		this.update_option(rt.new_string('database_prefix'), var_prefix.dup())
	}
	return var_prefix.dup()
}

fn (mut this Class_WC_Integration_MaxMind_Geolocation) add_missing_license_key_notice()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Notices')]))))) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/class-wc-admin-notices.php', '2')
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Notices{}; return temp.add_notice(arg_0) }(rt.new_string('maxmind_license_key'))
}

fn (mut this Class_WC_Integration_MaxMind_Geolocation) remove_missing_license_key_notice()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Notices')]))))) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/class-wc-admin-notices.php', '2')
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Notices{}; return temp.remove_notice(arg_0) }(rt.new_string('maxmind_license_key'))
}

fn (mut this Class_WC_Integration_MaxMind_Geolocation) display_missing_license_key_notice(var_old_value rt.PhpVal, var_new_value rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_maxmind_geolocation_display_notices'), rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_new_value.dup(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation_ajax() }]), rt.new_bool(true)]))))) {
		this.remove_missing_license_key_notice()
		return rt.new_null()
	}
	mut var_license_key := this.get_option(rt.new_string('license_key'))
	if !(!rt.is_true(var_license_key)) {
		return rt.new_null()
	}
	this.add_missing_license_key_notice()
}

struct Class_WC_Integration {
	rt.PhpObjectBase
}

struct Class_WC_Integration_MaxMind_Database_Service {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WC_Admin_Notices {
	rt.PhpObjectBase
}

fn create_wc_integration_maxmind_geolocation() &Class_WC_Integration_MaxMind_Geolocation {
	mut obj := &Class_WC_Integration_MaxMind_Geolocation{
		PhpObjectBase: rt.PhpObjectBase{}
		database_service: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_integration() &Class_WC_Integration {
	mut obj := &Class_WC_Integration{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_integration_maxmind_database_service() &Class_WC_Integration_MaxMind_Database_Service {
	mut obj := &Class_WC_Integration_MaxMind_Database_Service{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_settings() &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_admin_notices() &Class_WC_Admin_Notices {
	mut obj := &Class_WC_Admin_Notices{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Integration_MaxMind_Geolocation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'admin_options' {
			this.admin_options()
			return rt.new_null()
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'get_database_service' {
			return this.get_database_service()
		}
		'validate_license_key_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_license_key_field(dispatch_arg_0, dispatch_arg_1)
		}
		'update_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_database(dispatch_arg_0)
			return rt.new_null()
		}
		'get_geolocation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_geolocation(dispatch_arg_0, dispatch_arg_1)
		}
		'get_database_prefix' {
			return this.get_database_prefix()
		}
		'add_missing_license_key_notice' {
			this.add_missing_license_key_notice()
			return rt.new_null()
		}
		'remove_missing_license_key_notice' {
			this.remove_missing_license_key_notice()
			return rt.new_null()
		}
		'display_missing_license_key_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.display_missing_license_key_notice(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Integration_MaxMind_Geolocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'database_service' { return this.database_service }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Integration_MaxMind_Geolocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'database_service' { this.database_service = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Integration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Integration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Integration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Integration_MaxMind_Database_Service) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Integration_MaxMind_Database_Service) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Integration_MaxMind_Database_Service) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_includes_integrations_maxmind_geolocation_class_wc_integration_maxmind_geolocation_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.include_file(@DIR + '/class-wc-integration-maxmind-database-service.php', '4')
}
