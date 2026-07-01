import rt

struct Class_WC_REST_System_Status_V2_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v2')
		rest_base rt.PhpVal = rt.new_string('system_status')
}

fn Class_WC_REST_System_Status_V2_Controller.register_cache_clean()  {
	rt.call_function('add_action', [rt.new_string('switch_theme'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'clean_theme_cache' }])])
	rt.call_function('add_action', [rt.new_string('activate_plugin'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'clean_plugin_cache' }])])
	rt.call_function('add_action', [rt.new_string('deactivate_plugin'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'clean_plugin_cache' }])])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_upgrader := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_extra := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_extra)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_extra.array_get('type'))))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('plugin'), var_extra.array_get('type'))) {
		Class_WC_REST_System_Status_V2_Controller.clean_theme_cache()
		Class_WC_REST_System_Status_V2_Controller.clean_plugin_cache()
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('theme'), var_extra.array_get('type'))) {
		Class_WC_REST_System_Status_V2_Controller.clean_theme_cache()
		return rt.new_null()
	}
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'), rt.new_closure(closure_1_fn), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('system_status'), rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_fields := this.get_fields_for_response(var_request.dup())
	mut var_mappings := this.get_item_mappings_per_fields(var_fields.dup())
	mut var_response := this.prepare_item_for_response(var_mappings.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('system_status'), 'type': rt.new_string('object'), 'properties': { 'environment': { 'description': rt.call_function('__', [rt.new_string('Environment.'), rt.new_string('woocommerce')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'properties': { 'home_url': { 'description': rt.call_function('__', [rt.new_string('Home URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'format': rt.new_string('uri'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'site_url': { 'description': rt.call_function('__', [rt.new_string('Site URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'format': rt.new_string('uri'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'store_id': { 'description': rt.call_function('__', [rt.new_string('WooCommerce Store Identifier.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'version': { 'description': rt.call_function('__', [rt.new_string('WooCommerce version.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'log_directory': { 'description': rt.call_function('__', [rt.new_string('Log directory.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'log_directory_writable': { 'description': rt.call_function('__', [rt.new_string('Is log directory writable?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'wp_version': { 'description': rt.call_function('__', [rt.new_string('WordPress version.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'wp_multisite': { 'description': rt.call_function('__', [rt.new_string('Is WordPress multisite?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'wp_memory_limit': { 'description': rt.call_function('__', [rt.new_string('WordPress memory limit.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'wp_debug_mode': { 'description': rt.call_function('__', [rt.new_string('Is WordPress debug mode active?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'wp_cron': { 'description': rt.call_function('__', [rt.new_string('Are WordPress cron jobs enabled?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'wp_environment_type': { 'description': rt.call_function('__', [rt.new_string('The WordPress environment type.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'language': { 'description': rt.call_function('__', [rt.new_string('WordPress language.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'server_info': { 'description': rt.call_function('__', [rt.new_string('Server info.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'server_architecture': { 'description': rt.call_function('__', [rt.new_string('Server architecture.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'php_version': { 'description': rt.call_function('__', [rt.new_string('PHP version.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'php_post_max_size': { 'description': rt.call_function('__', [rt.new_string('PHP post max size.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'php_max_execution_time': { 'description': rt.call_function('__', [rt.new_string('PHP max execution time.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'php_max_input_vars': { 'description': rt.call_function('__', [rt.new_string('PHP max input vars.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'curl_version': { 'description': rt.call_function('__', [rt.new_string('cURL version.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'suhosin_installed': { 'description': rt.call_function('__', [rt.new_string('Is SUHOSIN installed?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'max_upload_size': { 'description': rt.call_function('__', [rt.new_string('Max upload size.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'mysql_version': { 'description': rt.call_function('__', [rt.new_string('MySQL version.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'mysql_version_string': { 'description': rt.call_function('__', [rt.new_string('MySQL version string.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'default_timezone': { 'description': rt.call_function('__', [rt.new_string('Default timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'fsockopen_or_curl_enabled': { 'description': rt.call_function('__', [rt.new_string('Is fsockopen/cURL enabled?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'soapclient_enabled': { 'description': rt.call_function('__', [rt.new_string('Is SoapClient class enabled?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'domdocument_enabled': { 'description': rt.call_function('__', [rt.new_string('Is DomDocument class enabled?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'gzip_enabled': { 'description': rt.call_function('__', [rt.new_string('Is GZip enabled?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'mbstring_enabled': { 'description': rt.call_function('__', [rt.new_string('Is mbstring enabled?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'remote_post_successful': { 'description': rt.call_function('__', [rt.new_string('Remote POST successful?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'remote_post_response': { 'description': rt.call_function('__', [rt.new_string('Remote POST response.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'remote_get_successful': { 'description': rt.call_function('__', [rt.new_string('Remote GET successful?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'remote_get_response': { 'description': rt.call_function('__', [rt.new_string('Remote GET response.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } }, 'database': { 'description': rt.call_function('__', [rt.new_string('Database.'), rt.new_string('woocommerce')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'properties': { 'wc_database_version': { 'description': rt.call_function('__', [rt.new_string('WC database version.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'database_prefix': { 'description': rt.call_function('__', [rt.new_string('Database prefix.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'maxmind_geoip_database': { 'description': rt.call_function('__', [rt.new_string('MaxMind GeoIP database.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'database_tables': { 'description': rt.call_function('__', [rt.new_string('Database tables.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('string') } } } }, 'active_plugins': { 'description': rt.call_function('__', [rt.new_string('Active plugins.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('object'), 'properties': { 'plugin': { 'description': rt.call_function('__', [rt.new_string('Plugin basename. The path to the main plugin file relative to the plugins directory.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string') }, 'name': { 'description': rt.call_function('__', [rt.new_string('Name of the plugin.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string') }, 'version': { 'description': rt.call_function('__', [rt.new_string('Current plugin version.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string') }, 'version_latest': { 'description': rt.call_function('__', [rt.new_string('Latest available plugin version.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string') }, 'url': { 'description': rt.call_function('__', [rt.new_string('Plugin URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string') }, 'author_name': { 'description': rt.call_function('__', [rt.new_string('Plugin author name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string') }, 'author_url': { 'description': rt.call_function('__', [rt.new_string('Plugin author URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string') }, 'network_activated': { 'description': rt.call_function('__', [rt.new_string('Whether the plugin can only be activated network-wide.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean') } } } }, 'inactive_plugins': { 'description': rt.call_function('__', [rt.new_string('Inactive plugins.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('object'), 'properties': { 'plugin': { 'description': rt.call_function('__', [rt.new_string('Plugin basename. The path to the main plugin file relative to the plugins directory.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string') }, 'name': { 'description': rt.call_function('__', [rt.new_string('Name of the plugin.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string') }, 'version': { 'description': rt.call_function('__', [rt.new_string('Current plugin version.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string') }, 'version_latest': { 'description': rt.call_function('__', [rt.new_string('Latest available plugin version.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string') }, 'url': { 'description': rt.call_function('__', [rt.new_string('Plugin URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string') }, 'author_name': { 'description': rt.call_function('__', [rt.new_string('Plugin author name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string') }, 'author_url': { 'description': rt.call_function('__', [rt.new_string('Plugin author URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string') }, 'network_activated': { 'description': rt.call_function('__', [rt.new_string('Whether the plugin can only be activated network-wide.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean') } } } }, 'dropins_mu_plugins': { 'description': rt.call_function('__', [rt.new_string('Dropins & MU plugins.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('string') } }, 'theme': { 'description': rt.call_function('__', [rt.new_string('Theme.'), rt.new_string('woocommerce')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'properties': { 'name': { 'description': rt.call_function('__', [rt.new_string('Theme name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'version': { 'description': rt.call_function('__', [rt.new_string('Theme version.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'version_latest': { 'description': rt.call_function('__', [rt.new_string('Latest version of theme.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'author_url': { 'description': rt.call_function('__', [rt.new_string('Theme author URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'format': rt.new_string('uri'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'is_child_theme': { 'description': rt.call_function('__', [rt.new_string('Is this theme a child theme?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'is_block_theme': { 'description': rt.call_function('__', [rt.new_string('Is this theme a block theme?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'has_woocommerce_support': { 'description': rt.call_function('__', [rt.new_string('Does the theme declare WooCommerce support?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'has_woocommerce_file': { 'description': rt.call_function('__', [rt.new_string('Does the theme have a woocommerce.php file?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'has_outdated_templates': { 'description': rt.call_function('__', [rt.new_string('Does this theme have outdated templates?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'overrides': { 'description': rt.call_function('__', [rt.new_string('Template overrides.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('string') } }, 'parent_name': { 'description': rt.call_function('__', [rt.new_string('Parent theme name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'parent_version': { 'description': rt.call_function('__', [rt.new_string('Parent theme version.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'parent_author_url': { 'description': rt.call_function('__', [rt.new_string('Parent theme author URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'format': rt.new_string('uri'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } }, 'settings': { 'description': rt.call_function('__', [rt.new_string('Settings.'), rt.new_string('woocommerce')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'properties': { 'api_enabled': { 'description': rt.call_function('__', [rt.new_string('Legacy REST API enabled?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'force_ssl': { 'description': rt.call_function('__', [rt.new_string('SSL forced?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'currency': { 'description': rt.call_function('__', [rt.new_string('Currency.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'currency_symbol': { 'description': rt.call_function('__', [rt.new_string('Currency symbol.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'currency_position': { 'description': rt.call_function('__', [rt.new_string('Currency position.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'thousand_separator': { 'description': rt.call_function('__', [rt.new_string('Thousand separator.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'decimal_separator': { 'description': rt.call_function('__', [rt.new_string('Decimal separator.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'number_of_decimals': { 'description': rt.call_function('__', [rt.new_string('Number of decimals.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'geolocation_enabled': { 'description': rt.call_function('__', [rt.new_string('Geolocation enabled?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'taxonomies': { 'description': rt.call_function('__', [rt.new_string('Taxonomy terms for product/order statuses.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('string') } }, 'product_visibility_terms': { 'description': rt.call_function('__', [rt.new_string('Terms in the product visibility taxonomy.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('string') } }, 'wccom_connected': { 'description': rt.call_function('__', [rt.new_string('Is store connected to WooCommerce.com?'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'enforce_approved_download_dirs': { 'description': rt.call_function('__', [rt.new_string('Enforce approved download directories?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'HPOS_enabled': { 'description': rt.call_function('__', [rt.new_string('Is HPOS enabled?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'order_datastore': { 'description': rt.call_function('__', [rt.new_string('Order datastore.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'HPOS_sync_enabled': { 'description': rt.call_function('__', [rt.new_string('Is HPOS sync enabled?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'enabled_features': { 'description': rt.call_function('__', [rt.new_string('Enabled features.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } }, 'security': { 'description': rt.call_function('__', [rt.new_string('Security.'), rt.new_string('woocommerce')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'properties': { 'secure_connection': { 'description': rt.call_function('__', [rt.new_string('Is the connection to your store secure?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'hide_errors': { 'description': rt.call_function('__', [rt.new_string('Hide errors from visitors?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } }, 'pages': { 'description': rt.call_function('__', [rt.new_string('WooCommerce pages.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('object'), 'properties': { 'page_name': { 'type': rt.new_string('string') }, 'page_id': { 'type': rt.new_string('string') }, 'page_set': { 'type': rt.new_string('boolean') }, 'page_exists': { 'type': rt.new_string('boolean') }, 'page_visible': { 'type': rt.new_string('boolean') }, 'shortcode': { 'type': rt.new_string('string') }, 'block': { 'type': rt.new_string('string') }, 'shortcode_required': { 'type': rt.new_string('boolean') }, 'shortcode_present': { 'type': rt.new_string('boolean') }, 'block_present': { 'type': rt.new_string('boolean') }, 'block_required': { 'type': rt.new_string('boolean') } } } }, 'post_type_counts': { 'description': rt.call_function('__', [rt.new_string('Total post count.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('string') } }, 'logging': { 'description': rt.call_function('__', [rt.new_string('Logging.'), rt.new_string('woocommerce')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'properties': { 'logging_enabled': { 'description': rt.call_function('__', [rt.new_string('Is logging enabled?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'default_handler': { 'description': rt.call_function('__', [rt.new_string('The logging handler class.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'retention_period_days': { 'description': rt.call_function('__', [rt.new_string('The number of days log entries are retained.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'level_threshold': { 'description': rt.call_function('__', [rt.new_string('Minimum severity level.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'log_directory_size': { 'description': rt.call_function('__', [rt.new_string('The size of the log directory.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } } } }
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_item_mappings() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'environment', val: this.get_environment_info_per_fields(rt.create_array([rt.ArrayItem{ key: none, val: 'environment' }])) }, rt.ArrayItem{ key: 'database', val: this.get_database_info() }, rt.ArrayItem{ key: 'active_plugins', val: this.get_active_plugins() }, rt.ArrayItem{ key: 'inactive_plugins', val: this.get_inactive_plugins() }, rt.ArrayItem{ key: 'dropins_mu_plugins', val: this.get_dropins_mu_plugins() }, rt.ArrayItem{ key: 'theme', val: this.get_theme_info() }, rt.ArrayItem{ key: 'settings', val: this.get_settings() }, rt.ArrayItem{ key: 'security', val: this.get_security_info() }, rt.ArrayItem{ key: 'pages', val: this.get_pages() }, rt.ArrayItem{ key: 'post_type_counts', val: this.get_post_type_counts() }, rt.ArrayItem{ key: 'logging', val: this.get_logging_info() }])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_item_mappings_per_fields(var_fields rt.PhpVal) rt.PhpVal {
	mut var_prop := rt.new_null()
	mut var_fields_mutated := var_fields
	mut var_items := rt.new_array()
	{
		mut iter_1 := var_fields_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			// unsupported assign target: Expr_List
			mut switch_val_1 := var_prop
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('environment'))) {
				var_items.array_set('environment', this.get_environment_info_per_fields(var_fields_mutated.dup()))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('database'))) {
				var_items.array_set('database', this.get_database_info())
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('active_plugins'))) {
				var_items.array_set('active_plugins', this.get_active_plugins())
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('inactive_plugins'))) {
				var_items.array_set('inactive_plugins', this.get_inactive_plugins())
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('dropins_mu_plugins'))) {
				var_items.array_set('dropins_mu_plugins', this.get_dropins_mu_plugins())
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('theme'))) {
				var_items.array_set('theme', this.get_theme_info())
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('settings'))) {
				var_items.array_set('settings', this.get_settings())
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('security'))) {
				var_items.array_set('security', this.get_security_info())
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('pages'))) {
				var_items.array_set('pages', this.get_pages())
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('post_type_counts'))) {
				var_items.array_set('post_type_counts', this.get_post_type_counts())
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('logging'))) {
				var_items.array_set('logging', this.get_logging_info())
			}
		}
	}
	return var_items.dup()
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_environment_info() rt.PhpVal {
	return this.get_environment_info_per_fields(rt.create_array([rt.ArrayItem{ key: none, val: 'environment' }]))
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) check_if_field_item_exists(var_section rt.PhpVal, var_items rt.PhpVal, var_fields rt.PhpVal) bool {
	mut var_items_mutated := var_items
	mut var_fields_mutated := var_fields
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_section.dup(), var_fields_mutated.dup(), rt.new_bool(true)]))))) {
		return false
	}
	mut var_exclude := rt.new_array()
	{
		mut iter_1 := var_fields_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_values := rt.call_function('explode', [rt.new_string('.'), var_field.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || !rt.is_true(var_values.array_get(1)))) {
				continue
			}
			var_exclude << var_values.array_get(1)
		}
	}
	return rt.new_bool(0 <= rt.call_function('array_intersect', [var_items_mutated.dup(), var_exclude.dup()]).array_count())
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_environment_info_per_fields(var_fields rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_fields_mutated := var_fields
	// unsupported statement: Stmt_Global
	mut var_enable_remote_post := rt.new_bool(this.check_if_field_item_exists(rt.new_string('environment'), rt.create_array([rt.ArrayItem{ key: none, val: 'remote_post_successful' }, rt.ArrayItem{ key: none, val: 'remote_post_response' }]), var_fields_mutated.dup()))
	mut var_enable_remote_get := rt.new_bool(this.check_if_field_item_exists(rt.new_string('environment'), rt.create_array([rt.ArrayItem{ key: none, val: 'remote_get_successful' }, rt.ArrayItem{ key: none, val: 'remote_get_response' }]), var_fields_mutated.dup()))
	mut var_curl_version := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('curl_version')])) {
		var_curl_version = rt.call_function('curl_version', []rt.PhpVal{})
		var_curl_version = rt.new_string((var_curl_version.array_get('version')).str() + ', ' + (var_curl_version.array_get('ssl_version')).str())
	} else if rt.is_true(rt.call_function('extension_loaded', [rt.new_string('curl')])) {
		var_curl_version = rt.call_function('__', [rt.new_string('cURL installed but unable to retrieve version.'), rt.new_string('woocommerce')])
	}
	mut var_wp_memory_limit := rt.call_function('wc_let_to_num', [rt.get_constant('WP_MEMORY_LIMIT')])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('memory_get_usage')])) {
		var_wp_memory_limit = rt.call_function('max', [var_wp_memory_limit.dup(), rt.call_function('wc_let_to_num', [rt.call_function('ini_get', [rt.new_string('memory_limit')])])])
		// unsupported statement: Stmt_Nop
	}
	mut var_post_response_successful := rt.new_null()
	mut var_post_response_code := rt.new_null()
	if rt.is_true(var_enable_remote_post) {
		var_post_response_code = rt.call_function('get_transient', [rt.new_string('woocommerce_test_remote_post')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_post_response_code)) || rt.is_true(rt.call_function('is_wp_error', [var_post_response_code.dup()])))) {
			mut var_response := rt.call_function('wp_safe_remote_post', [rt.new_string('https://www.paypal.com/cgi-bin/webscr'), rt.create_array([rt.ArrayItem{ key: 'timeout', val: 10 }, rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' + (rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() + '; ' + (rt.call_function('get_bloginfo', [rt.new_string('url')])).str() }, rt.ArrayItem{ key: 'httpversion', val: '1.1' }, rt.ArrayItem{ key: 'body', val: rt.create_array([rt.ArrayItem{ key: 'cmd', val: '_notify-validate' }]) }])])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()]))))) {
				var_post_response_code = var_response.array_get('response').array_get('code')
			}
			rt.call_function('set_transient', [rt.new_string('woocommerce_test_remote_post'), var_post_response_code.dup(), rt.get_constant('HOUR_IN_SECONDS')])
		}
		var_post_response_successful = rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_post_response_code.dup()]))))) && rt.is_true(rt.greater_equal(var_post_response_code, rt.new_int(200))))) && rt.is_true(rt.less(var_post_response_code, rt.new_int(300)))))
	}
	mut var_get_response_successful := rt.new_null()
	mut var_get_response_code := rt.new_null()
	if rt.is_true(var_enable_remote_get) {
		var_get_response_code = rt.call_function('get_transient', [rt.new_string('woocommerce_test_remote_get')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_get_response_code)) || rt.is_true(rt.call_function('is_wp_error', [var_get_response_code.dup()])))) {
			var_response = rt.call_function('wp_safe_remote_get', ['https://woocommerce.com/wc-api/product-key-api?request=ping&network=' + if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { '1' } else { '0' }, rt.create_array([rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' + (rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() + '; ' + (rt.call_function('get_bloginfo', [rt.new_string('url')])).str() }])])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()]))))) {
				var_get_response_code = var_response.array_get('response').array_get('code')
			}
			rt.call_function('set_transient', [rt.new_string('woocommerce_test_remote_get'), var_get_response_code.dup(), rt.get_constant('HOUR_IN_SECONDS')])
		}
		var_get_response_successful = rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_get_response_code.dup()]))))) && rt.is_true(rt.greater_equal(var_get_response_code, rt.new_int(200))))) && rt.is_true(rt.less(var_get_response_code, rt.new_int(300)))))
	}
	mut var_server_architecture := if rt.is_true(rt.call_function('function_exists', [rt.new_string('php_uname')])) { rt.call_function('sprintf', [rt.new_string('%s %s %s'), rt.call_function('php_uname', [rt.new_string('s')]), rt.call_function('php_uname', [rt.new_string('r')]), rt.call_function('php_uname', [rt.new_string('m')])]) } else { rt.new_string('') }
	mut var_database_version := rt.call_function('wc_get_server_database_version', []rt.PhpVal{})
	mut var_log_directory := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_LoggingUtil{}; return temp.get_log_directory(arg_0) }(rt.new_bool(false))
	return rt.create_array([rt.ArrayItem{ key: 'home_url', val: rt.call_function('get_option', [rt.new_string('home')]) }, rt.ArrayItem{ key: 'site_url', val: rt.call_function('get_option', [rt.new_string('siteurl')]) }, rt.ArrayItem{ key: 'store_id', val: rt.call_function('get_option', [Class_WC_Install.store_id_option(), rt.new_null()]) }, rt.ArrayItem{ key: 'version', val: rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version') }, rt.ArrayItem{ key: 'log_directory', val: var_log_directory }, rt.ArrayItem{ key: 'log_directory_writable', val: rt.call_function('wp_is_writable', [var_log_directory.dup()]) }, rt.ArrayItem{ key: 'wp_version', val: rt.call_function('get_bloginfo', [rt.new_string('version')]) }, rt.ArrayItem{ key: 'wp_multisite', val: rt.call_function('is_multisite', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'wp_memory_limit', val: var_wp_memory_limit }, rt.ArrayItem{ key: 'wp_debug_mode', val: rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')])) && rt.is_true(rt.get_constant('WP_DEBUG')) }, rt.ArrayItem{ key: 'wp_cron', val: !(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('DISABLE_WP_CRON')])) && rt.is_true(rt.get_constant('DISABLE_WP_CRON'))))) }, rt.ArrayItem{ key: 'wp_environment_type', val: rt.call_function('wp_get_environment_type', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'language', val: rt.call_function('get_locale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'external_object_cache', val: rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'server_info', val: if rt.get_superglobal('_SERVER').array_isset(rt.new_string('SERVER_SOFTWARE')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE')])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'server_architecture', val: var_server_architecture }, rt.ArrayItem{ key: 'php_version', val: rt.call_function('phpversion', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'php_post_max_size', val: rt.call_function('wc_let_to_num', [rt.call_function('ini_get', [rt.new_string('post_max_size')])]) }, rt.ArrayItem{ key: 'php_max_execution_time', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'php_max_input_vars', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'curl_version', val: var_curl_version }, rt.ArrayItem{ key: 'suhosin_installed', val: rt.call_function('extension_loaded', [rt.new_string('suhosin')]) }, rt.ArrayItem{ key: 'max_upload_size', val: rt.call_function('wp_max_upload_size', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'mysql_version', val: var_database_version.array_get('number') }, rt.ArrayItem{ key: 'mysql_version_string', val: var_database_version.array_get('string') }, rt.ArrayItem{ key: 'default_timezone', val: rt.call_function('date_default_timezone_get', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'fsockopen_or_curl_enabled', val: rt.is_true(rt.call_function('function_exists', [rt.new_string('fsockopen')])) || rt.is_true(rt.call_function('function_exists', [rt.new_string('curl_init')])) }, rt.ArrayItem{ key: 'soapclient_enabled', val: rt.call_function('class_exists', [rt.new_string('SoapClient')]) }, rt.ArrayItem{ key: 'domdocument_enabled', val: rt.call_function('class_exists', [rt.new_string('DOMDocument')]) }, rt.ArrayItem{ key: 'gzip_enabled', val: rt.call_function('is_callable', [rt.new_string('gzopen')]) }, rt.ArrayItem{ key: 'mbstring_enabled', val: rt.call_function('extension_loaded', [rt.new_string('mbstring')]) }, rt.ArrayItem{ key: 'remote_post_successful', val: var_post_response_successful }, rt.ArrayItem{ key: 'remote_post_response', val: if rt.is_true(rt.call_function('is_wp_error', [var_post_response_code.dup()])) { rt.call_method(var_post_response_code, 'get_error_message', []rt.PhpVal{}) } else { var_post_response_code } }, rt.ArrayItem{ key: 'remote_get_successful', val: var_get_response_successful }, rt.ArrayItem{ key: 'remote_get_response', val: if rt.is_true(rt.call_function('is_wp_error', [var_get_response_code.dup()])) { rt.call_method(var_get_response_code, 'get_error_message', []rt.PhpVal{}) } else { var_get_response_code } }])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) add_db_table_prefix(var_table rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return (rt.get_property(var_wpdb, 'prefix')).str() + (var_table).str()
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_database_info() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_tables := rt.new_array()
	mut var_database_size := rt.new_array()
	if rt.is_true(rt.call_function('defined', [rt.new_string('DB_NAME')])) {
		mut var_database_table_information := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('SELECT\n\t\t\t\t\t    table_name AS \'name\',\n\t\t\t\t\t\tengine AS \'engine\',\n\t\t\t\t\t    round( ( data_length / 1024 / 1024 ), 2 ) \'data\',\n\t\t\t\t\t    round( ( index_length / 1024 / 1024 ), 2 ) \'index\'\n\t\t\t\t\tFROM information_schema.TABLES\n\t\t\t\t\tWHERE table_schema = %s\n\t\t\t\t\tORDER BY name ASC;'), rt.get_constant('DB_NAME')])])
		mut var_core_tables := rt.call_function('apply_filters', [rt.new_string('woocommerce_database_tables'), rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_sessions' }, rt.ArrayItem{ key: none, val: 'woocommerce_api_keys' }, rt.ArrayItem{ key: none, val: 'woocommerce_attribute_taxonomies' }, rt.ArrayItem{ key: none, val: 'woocommerce_downloadable_product_permissions' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_items' }, rt.ArrayItem{ key: none, val: 'woocommerce_order_itemmeta' }, rt.ArrayItem{ key: none, val: 'woocommerce_tax_rates' }, rt.ArrayItem{ key: none, val: 'woocommerce_tax_rate_locations' }, rt.ArrayItem{ key: none, val: 'woocommerce_shipping_zones' }, rt.ArrayItem{ key: none, val: 'woocommerce_shipping_zone_locations' }, rt.ArrayItem{ key: none, val: 'woocommerce_shipping_zone_methods' }, rt.ArrayItem{ key: none, val: 'woocommerce_payment_tokens' }, rt.ArrayItem{ key: none, val: 'woocommerce_payment_tokenmeta' }, rt.ArrayItem{ key: none, val: 'woocommerce_log' }])])
		var_core_tables = rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'add_db_table_prefix' }]), var_core_tables.dup()])
		var_tables = rt.create_array([rt.ArrayItem{ key: 'woocommerce', val: rt.call_function('array_fill_keys', [var_core_tables.dup(), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'other', val: rt.new_array() }])
		var_database_size = { 'data': 0, 'index': 0 }
		mut var_site_tables_prefix := rt.call_method(var_wpdb, 'get_blog_prefix', [rt.call_function('get_current_blog_id', []rt.PhpVal{})])
		mut var_global_tables := rt.call_method(var_wpdb, 'tables', [rt.new_string('global'), rt.new_bool(true)])
		{
			mut iter_1 := var_database_table_information.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_table := item_1.val
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(, 'name'), var_global_tables.dup(), rt.new_bool(true)]))))))) {
					continue
				}
				mut var_table_type := rt.new_string(if rt.is_true(rt.call_function('in_array', [, .dup(), ])) { rt.new_string('woocommerce') } else { rt.new_string('other') })
				var_tables.array_get_mut(var_table_type).array_set(rt.get_property(, 'name'), rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }]))
				// unsupported expression: Expr_AssignOp_Plus
				
			}
		}
	}
	return 
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_post_type_counts() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_active_plugins() rt.PhpVal {
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_inactive_plugins() rt.PhpVal {
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) format_plugin_data(var_plugin rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_dropins_mu_plugins() rt.PhpVal {
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_theme_info() rt.PhpVal {
}

fn Class_WC_REST_System_Status_V2_Controller.clean_theme_cache()  {
}

fn Class_WC_REST_System_Status_V2_Controller.clean_plugin_cache()  {
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_settings() rt.PhpVal {
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_security_info() rt.PhpVal {
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_pages() rt.PhpVal {
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_logging_info() rt.PhpVal {
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) prepare_item_for_response(var_system_status rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_LoggingUtil {
	rt.PhpObjectBase
}

fn create_wc_rest_system_status_v2_controller() &Class_WC_REST_System_Status_V2_Controller {
	mut obj := &Class_WC_REST_System_Status_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v2')
		rest_base: rt.new_string('system_status')
	}
	return obj
}

fn create_wc_rest_controller() &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_loggingutil() &Class_LoggingUtil {
	mut obj := &Class_LoggingUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_cache_clean' {
			Class_WC_REST_System_Status_V2_Controller.register_cache_clean()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_item_mappings' {
			return this.get_item_mappings()
		}
		'get_item_mappings_per_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_mappings_per_fields(dispatch_arg_0)
		}
		'get_environment_info' {
			return this.get_environment_info()
		}
		'check_if_field_item_exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.check_if_field_item_exists(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_environment_info_per_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_environment_info_per_fields(dispatch_arg_0)
		}
		'add_db_table_prefix' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.add_db_table_prefix(dispatch_arg_0))
		}
		'get_database_info' {
			return this.get_database_info()
		}
		'get_post_type_counts' {
			return this.get_post_type_counts()
		}
		'get_active_plugins' {
			return this.get_active_plugins()
		}
		'get_inactive_plugins' {
			return this.get_inactive_plugins()
		}
		'format_plugin_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.format_plugin_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_dropins_mu_plugins' {
			return this.get_dropins_mu_plugins()
		}
		'get_theme_info' {
			return this.get_theme_info()
		}
		'clean_theme_cache' {
			Class_WC_REST_System_Status_V2_Controller.clean_theme_cache()
			return rt.new_null()
		}
		'clean_plugin_cache' {
			Class_WC_REST_System_Status_V2_Controller.clean_plugin_cache()
			return rt.new_null()
		}
		'get_settings' {
			return this.get_settings()
		}
		'get_security_info' {
			return this.get_security_info()
		}
		'get_pages' {
			return this.get_pages()
		}
		'get_logging_info' {
			return this.get_logging_info()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_System_Status_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_LoggingUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_LoggingUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_LoggingUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version2_class_wc_rest_system_status_v2_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_GroupUse
}
