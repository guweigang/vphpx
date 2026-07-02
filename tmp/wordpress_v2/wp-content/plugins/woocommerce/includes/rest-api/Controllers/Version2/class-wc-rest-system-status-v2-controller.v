import rt

struct Class_WC_REST_System_Status_V2_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v2')
	rest_base rt.PhpVal = rt.new_string('system_status')
}

fn Class_WC_REST_System_Status_V2_Controller.register_cache_clean() {
	rt.call_function('add_action', [rt.new_string('switch_theme'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'clean_theme_cache' }])])
	rt.call_function('add_action', [rt.new_string('activate_plugin'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'clean_plugin_cache' }])])
	rt.call_function('add_action', [rt.new_string('deactivate_plugin'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'clean_plugin_cache' }])])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_upgrader := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_extra := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!(rt.is_true(var_extra))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_extra.array_get(rt.new_string('type')))))) {
			return
		}
		if rt.is_true(rt.identical(rt.new_string('plugin'),
			var_extra.array_get(rt.new_string('type'))))
		{
			Class_WC_REST_System_Status_V2_Controller.clean_theme_cache()
			Class_WC_REST_System_Status_V2_Controller.clean_plugin_cache()
			return
		}
		if rt.is_true(rt.identical(rt.new_string('theme'),
			var_extra.array_get(rt.new_string('type'))))
		{
			Class_WC_REST_System_Status_V2_Controller.clean_theme_cache()
			return
		}
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
		rt.new_closure(closure_1_fn), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_V2_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('system_status'),
		rt.new_string('read'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot list resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_mappings := this.get_item_mappings_per_fields(var_fields.clone())
	mut var_response := this.prepare_item_for_response(var_mappings.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('system_status')
		'type':       rt.new_string('object')
		'properties': {
			'environment':        {
				'description': rt.call_function('__', [rt.new_string('Environment.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('object')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'properties':  {
					'home_url':                  {
						'description': rt.call_function('__', [
							rt.new_string('Home URL.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'format':      rt.new_string('uri')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'site_url':                  {
						'description': rt.call_function('__', [
							rt.new_string('Site URL.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'format':      rt.new_string('uri')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'store_id':                  {
						'description': rt.call_function('__', [
							rt.new_string('WooCommerce Store Identifier.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'version':                   {
						'description': rt.call_function('__', [
							rt.new_string('WooCommerce version.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'log_directory':             {
						'description': rt.call_function('__', [
							rt.new_string('Log directory.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'log_directory_writable':    {
						'description': rt.call_function('__', [
							rt.new_string('Is log directory writable?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'wp_version':                {
						'description': rt.call_function('__', [
							rt.new_string('WordPress version.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'wp_multisite':              {
						'description': rt.call_function('__', [
							rt.new_string('Is WordPress multisite?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'wp_memory_limit':           {
						'description': rt.call_function('__', [
							rt.new_string('WordPress memory limit.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('integer')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'wp_debug_mode':             {
						'description': rt.call_function('__', [
							rt.new_string('Is WordPress debug mode active?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'wp_cron':                   {
						'description': rt.call_function('__', [
							rt.new_string('Are WordPress cron jobs enabled?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'wp_environment_type':       {
						'description': rt.call_function('__', [
							rt.new_string('The WordPress environment type.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'language':                  {
						'description': rt.call_function('__', [
							rt.new_string('WordPress language.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'server_info':               {
						'description': rt.call_function('__', [
							rt.new_string('Server info.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'server_architecture':       {
						'description': rt.call_function('__', [
							rt.new_string('Server architecture.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'php_version':               {
						'description': rt.call_function('__', [
							rt.new_string('PHP version.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'php_post_max_size':         {
						'description': rt.call_function('__', [
							rt.new_string('PHP post max size.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('integer')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'php_max_execution_time':    {
						'description': rt.call_function('__', [
							rt.new_string('PHP max execution time.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('integer')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'php_max_input_vars':        {
						'description': rt.call_function('__', [
							rt.new_string('PHP max input vars.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('integer')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'curl_version':              {
						'description': rt.call_function('__', [
							rt.new_string('cURL version.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'suhosin_installed':         {
						'description': rt.call_function('__', [
							rt.new_string('Is SUHOSIN installed?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'max_upload_size':           {
						'description': rt.call_function('__', [
							rt.new_string('Max upload size.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('integer')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'mysql_version':             {
						'description': rt.call_function('__', [
							rt.new_string('MySQL version.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'mysql_version_string':      {
						'description': rt.call_function('__', [
							rt.new_string('MySQL version string.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'default_timezone':          {
						'description': rt.call_function('__', [
							rt.new_string('Default timezone.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'fsockopen_or_curl_enabled': {
						'description': rt.call_function('__', [
							rt.new_string('Is fsockopen/cURL enabled?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'soapclient_enabled':        {
						'description': rt.call_function('__', [
							rt.new_string('Is SoapClient class enabled?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'domdocument_enabled':       {
						'description': rt.call_function('__', [
							rt.new_string('Is DomDocument class enabled?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'gzip_enabled':              {
						'description': rt.call_function('__', [
							rt.new_string('Is GZip enabled?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'mbstring_enabled':          {
						'description': rt.call_function('__', [
							rt.new_string('Is mbstring enabled?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'remote_post_successful':    {
						'description': rt.call_function('__', [
							rt.new_string('Remote POST successful?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'remote_post_response':      {
						'description': rt.call_function('__', [
							rt.new_string('Remote POST response.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'remote_get_successful':     {
						'description': rt.call_function('__', [
							rt.new_string('Remote GET successful?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'remote_get_response':       {
						'description': rt.call_function('__', [
							rt.new_string('Remote GET response.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
				}
			}
			'database':           {
				'description': rt.call_function('__', [rt.new_string('Database.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('object')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'properties':  {
					'wc_database_version':    {
						'description': rt.call_function('__', [
							rt.new_string('WC database version.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'database_prefix':        {
						'description': rt.call_function('__', [
							rt.new_string('Database prefix.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'maxmind_geoip_database': {
						'description': rt.call_function('__', [
							rt.new_string('MaxMind GeoIP database.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'database_tables':        {
						'description': rt.call_function('__', [
							rt.new_string('Database tables.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('array')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
						'items':       {
							'type': rt.new_string('string')
						}
					}
				}
			}
			'active_plugins':     {
				'description': rt.call_function('__', [rt.new_string('Active plugins.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('array')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'items':       {
					'type':       rt.new_string('object')
					'properties': {
						'plugin':            {
							'description': rt.call_function('__', [
								rt.new_string('Plugin basename. The path to the main plugin file relative to the plugins directory.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
						}
						'name':              {
							'description': rt.call_function('__', [
								rt.new_string('Name of the plugin.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
						}
						'version':           {
							'description': rt.call_function('__', [
								rt.new_string('Current plugin version.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
						}
						'version_latest':    {
							'description': rt.call_function('__', [
								rt.new_string('Latest available plugin version.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
						}
						'url':               {
							'description': rt.call_function('__', [
								rt.new_string('Plugin URL.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
						}
						'author_name':       {
							'description': rt.call_function('__', [
								rt.new_string('Plugin author name.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
						}
						'author_url':        {
							'description': rt.call_function('__', [
								rt.new_string('Plugin author URL.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
						}
						'network_activated': {
							'description': rt.call_function('__', [
								rt.new_string('Whether the plugin can only be activated network-wide.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('boolean')
						}
					}
				}
			}
			'inactive_plugins':   {
				'description': rt.call_function('__', [
					rt.new_string('Inactive plugins.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('array')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'items':       {
					'type':       rt.new_string('object')
					'properties': {
						'plugin':            {
							'description': rt.call_function('__', [
								rt.new_string('Plugin basename. The path to the main plugin file relative to the plugins directory.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
						}
						'name':              {
							'description': rt.call_function('__', [
								rt.new_string('Name of the plugin.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
						}
						'version':           {
							'description': rt.call_function('__', [
								rt.new_string('Current plugin version.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
						}
						'version_latest':    {
							'description': rt.call_function('__', [
								rt.new_string('Latest available plugin version.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
						}
						'url':               {
							'description': rt.call_function('__', [
								rt.new_string('Plugin URL.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
						}
						'author_name':       {
							'description': rt.call_function('__', [
								rt.new_string('Plugin author name.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
						}
						'author_url':        {
							'description': rt.call_function('__', [
								rt.new_string('Plugin author URL.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
						}
						'network_activated': {
							'description': rt.call_function('__', [
								rt.new_string('Whether the plugin can only be activated network-wide.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('boolean')
						}
					}
				}
			}
			'dropins_mu_plugins': {
				'description': rt.call_function('__', [
					rt.new_string('Dropins & MU plugins.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('array')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'items':       {
					'type': rt.new_string('string')
				}
			}
			'theme':              {
				'description': rt.call_function('__', [rt.new_string('Theme.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('object')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'properties':  {
					'name':                    {
						'description': rt.call_function('__', [
							rt.new_string('Theme name.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'version':                 {
						'description': rt.call_function('__', [
							rt.new_string('Theme version.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'version_latest':          {
						'description': rt.call_function('__', [
							rt.new_string('Latest version of theme.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'author_url':              {
						'description': rt.call_function('__', [
							rt.new_string('Theme author URL.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'format':      rt.new_string('uri')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'is_child_theme':          {
						'description': rt.call_function('__', [
							rt.new_string('Is this theme a child theme?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'is_block_theme':          {
						'description': rt.call_function('__', [
							rt.new_string('Is this theme a block theme?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'has_woocommerce_support': {
						'description': rt.call_function('__', [
							rt.new_string('Does the theme declare WooCommerce support?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'has_woocommerce_file':    {
						'description': rt.call_function('__', [
							rt.new_string('Does the theme have a woocommerce.php file?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'has_outdated_templates':  {
						'description': rt.call_function('__', [
							rt.new_string('Does this theme have outdated templates?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'overrides':               {
						'description': rt.call_function('__', [
							rt.new_string('Template overrides.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('array')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
						'items':       {
							'type': rt.new_string('string')
						}
					}
					'parent_name':             {
						'description': rt.call_function('__', [
							rt.new_string('Parent theme name.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'parent_version':          {
						'description': rt.call_function('__', [
							rt.new_string('Parent theme version.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'parent_author_url':       {
						'description': rt.call_function('__', [
							rt.new_string('Parent theme author URL.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'format':      rt.new_string('uri')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
				}
			}
			'settings':           {
				'description': rt.call_function('__', [rt.new_string('Settings.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('object')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'properties':  {
					'api_enabled':                    {
						'description': rt.call_function('__', [
							rt.new_string('Legacy REST API enabled?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'force_ssl':                      {
						'description': rt.call_function('__', [
							rt.new_string('SSL forced?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'currency':                       {
						'description': rt.call_function('__', [
							rt.new_string('Currency.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'currency_symbol':                {
						'description': rt.call_function('__', [
							rt.new_string('Currency symbol.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'currency_position':              {
						'description': rt.call_function('__', [
							rt.new_string('Currency position.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'thousand_separator':             {
						'description': rt.call_function('__', [
							rt.new_string('Thousand separator.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'decimal_separator':              {
						'description': rt.call_function('__', [
							rt.new_string('Decimal separator.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'number_of_decimals':             {
						'description': rt.call_function('__', [
							rt.new_string('Number of decimals.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('integer')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'geolocation_enabled':            {
						'description': rt.call_function('__', [
							rt.new_string('Geolocation enabled?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'taxonomies':                     {
						'description': rt.call_function('__', [
							rt.new_string('Taxonomy terms for product/order statuses.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('array')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
						'items':       {
							'type': rt.new_string('string')
						}
					}
					'product_visibility_terms':       {
						'description': rt.call_function('__', [
							rt.new_string('Terms in the product visibility taxonomy.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('array')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
						'items':       {
							'type': rt.new_string('string')
						}
					}
					'wccom_connected':                {
						'description': rt.call_function('__', [
							rt.new_string('Is store connected to WooCommerce.com?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'enforce_approved_download_dirs': {
						'description': rt.call_function('__', [
							rt.new_string('Enforce approved download directories?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'HPOS_enabled':                   {
						'description': rt.call_function('__', [
							rt.new_string('Is HPOS enabled?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'order_datastore':                {
						'description': rt.call_function('__', [
							rt.new_string('Order datastore.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'HPOS_sync_enabled':              {
						'description': rt.call_function('__', [
							rt.new_string('Is HPOS sync enabled?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'enabled_features':               {
						'description': rt.call_function('__', [
							rt.new_string('Enabled features.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('array')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
				}
			}
			'security':           {
				'description': rt.call_function('__', [rt.new_string('Security.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('object')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'properties':  {
					'secure_connection': {
						'description': rt.call_function('__', [
							rt.new_string('Is the connection to your store secure?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'hide_errors':       {
						'description': rt.call_function('__', [
							rt.new_string('Hide errors from visitors?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
				}
			}
			'pages':              {
				'description': rt.call_function('__', [
					rt.new_string('WooCommerce pages.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('array')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'items':       {
					'type':       rt.new_string('object')
					'properties': {
						'page_name':          {
							'type': rt.new_string('string')
						}
						'page_id':            {
							'type': rt.new_string('string')
						}
						'page_set':           {
							'type': rt.new_string('boolean')
						}
						'page_exists':        {
							'type': rt.new_string('boolean')
						}
						'page_visible':       {
							'type': rt.new_string('boolean')
						}
						'shortcode':          {
							'type': rt.new_string('string')
						}
						'block':              {
							'type': rt.new_string('string')
						}
						'shortcode_required': {
							'type': rt.new_string('boolean')
						}
						'shortcode_present':  {
							'type': rt.new_string('boolean')
						}
						'block_present':      {
							'type': rt.new_string('boolean')
						}
						'block_required':     {
							'type': rt.new_string('boolean')
						}
					}
				}
			}
			'post_type_counts':   {
				'description': rt.call_function('__', [
					rt.new_string('Total post count.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('array')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'items':       {
					'type': rt.new_string('string')
				}
			}
			'logging':            {
				'description': rt.call_function('__', [rt.new_string('Logging.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('object')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'properties':  {
					'logging_enabled':       {
						'description': rt.call_function('__', [
							rt.new_string('Is logging enabled?'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('boolean')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'default_handler':       {
						'description': rt.call_function('__', [
							rt.new_string('The logging handler class.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'retention_period_days': {
						'description': rt.call_function('__', [
							rt.new_string('The number of days log entries are retained.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('integer')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'level_threshold':       {
						'description': rt.call_function('__', [
							rt.new_string('Minimum severity level.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'log_directory_size':    {
						'description': rt.call_function('__', [
							rt.new_string('The size of the log directory.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
				}
			}
		}
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_item_mappings() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'environment', val: this.get_environment_info_per_fields(rt.create_array([
			rt.ArrayItem{ key: none, val: 'environment' },
		])) },
		rt.ArrayItem{ key: 'database', val: this.get_database_info() },
		rt.ArrayItem{ key: 'active_plugins', val: this.get_active_plugins() },
		rt.ArrayItem{ key: 'inactive_plugins', val: this.get_inactive_plugins() },
		rt.ArrayItem{ key: 'dropins_mu_plugins', val: this.get_dropins_mu_plugins() },
		rt.ArrayItem{ key: 'theme', val: this.get_theme_info() },
		rt.ArrayItem{ key: 'settings', val: this.get_settings() },
		rt.ArrayItem{ key: 'security', val: this.get_security_info() },
		rt.ArrayItem{ key: 'pages', val: this.get_pages() },
		rt.ArrayItem{ key: 'post_type_counts', val: this.get_post_type_counts() },
		rt.ArrayItem{ key: 'logging', val: this.get_logging_info() },
	])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_item_mappings_per_fields(var_fields rt.PhpVal) rt.PhpVal {
	mut var_prop := rt.new_null()
	mut var_fields_mutated := var_fields
	mut var_items := rt.new_array()
	mut iter_1 := var_fields_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string('.'),
			var_field.clone(), rt.new_int(2)])
		var_prop = list_tmp_1.array_get(0)
		mut switch_val_1 := var_prop
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('environment'))) {
			var_items.array_set('environment',
				this.get_environment_info_per_fields(var_fields_mutated.clone()))
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
	return var_items.clone()
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_environment_info() rt.PhpVal {
	return this.get_environment_info_per_fields(rt.create_array([
		rt.ArrayItem{ key: none, val: 'environment' },
	]))
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) check_if_field_item_exists(var_section rt.PhpVal, var_items rt.PhpVal, var_fields rt.PhpVal) bool {
	mut var_items_mutated := var_items
	mut var_fields_mutated := var_fields
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_section.clone(), var_fields_mutated.clone(), rt.new_bool(true)])))))
	{
		return false
	}
	mut var_exclude := rt.new_array()
	mut iter_2 := var_fields_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_field := item_2.val
		mut var_values := rt.call_function('explode', [rt.new_string('.'),
			var_field.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_section, var_values.array_get(rt.new_int(0))))))
			|| !rt.is_true(var_values.array_get(rt.new_int(1))) {
			continue
		}
		var_exclude << var_values.array_get(rt.new_int(1))
	}
	return rt.new_bool(0 <= rt.call_function('array_intersect', [
		var_items_mutated.clone(), rt.create_array_from_list(var_exclude)]).array_count())
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_environment_info_per_fields(var_fields rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_fields_mutated := var_fields
	mut var_enable_remote_post := rt.new_bool(this.check_if_field_item_exists(rt.new_string('environment'), rt.create_array([
		rt.ArrayItem{ key: none, val: 'remote_post_successful' },
		rt.ArrayItem{ key: none, val: 'remote_post_response' },
	]), var_fields_mutated.clone()))
	mut var_enable_remote_get := rt.new_bool(this.check_if_field_item_exists(rt.new_string('environment'), rt.create_array([
		rt.ArrayItem{ key: none, val: 'remote_get_successful' },
		rt.ArrayItem{ key: none, val: 'remote_get_response' },
	]), var_fields_mutated.clone()))
	mut var_curl_version := rt.new_string('')
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('curl_version')])) {
		var_curl_version = rt.call_function('curl_version', []rt.PhpVal{})
		var_curl_version = rt.new_string(
			(var_curl_version.array_get(rt.new_string('version'))).str() + ', ' +
			(var_curl_version.array_get(rt.new_string('ssl_version'))).str())
	} else if rt.is_true(rt.call_function('extension_loaded', [
		rt.new_string('curl')]))
	{
		var_curl_version = rt.call_function('__', [
			rt.new_string('cURL installed but unable to retrieve version.'),
			rt.new_string('woocommerce'),
		])
	}
	mut var_wp_memory_limit := rt.call_function('wc_let_to_num', [
		rt.get_constant('WP_MEMORY_LIMIT'),
	])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('memory_get_usage')])) {
		var_wp_memory_limit = rt.call_function('max', [var_wp_memory_limit.clone(),
			rt.call_function('wc_let_to_num', [
				rt.call_function('ini_get', [rt.new_string('memory_limit')]),
			])])
	}
	mut var_post_response_successful := rt.new_null()
	mut var_post_response_code := rt.new_null()
	if rt.is_true(var_enable_remote_post) {
		var_post_response_code = rt.call_function('get_transient', [
			rt.new_string('woocommerce_test_remote_post'),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_post_response_code))
			|| rt.is_true(rt.call_function('is_wp_error', [var_post_response_code.clone()])) {
			mut var_response := rt.call_function('wp_safe_remote_post', [
				rt.new_string('https://www.paypal.com/cgi-bin/webscr'),
				rt.create_array([rt.ArrayItem{ key: 'timeout', val: 10 },
					rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' +
						(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() +
						'; ' + (rt.call_function('get_bloginfo', [rt.new_string('url')])).str() },
					rt.ArrayItem{ key: 'httpversion', val: '1.1' },
					rt.ArrayItem{ key: 'body', val: rt.create_array([
						rt.ArrayItem{ key: 'cmd', val: '_notify-validate' },
					]) }]),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
				var_response.clone(),
			])))))
			{
				var_post_response_code =
					var_response.array_get(rt.new_string('response')).array_get(rt.new_string('code'))
			}
			rt.call_function('set_transient', [
				rt.new_string('woocommerce_test_remote_post'),
				var_post_response_code.clone(),
				rt.get_constant('HOUR_IN_SECONDS'),
			])
		}
		var_post_response_successful = rt.new_bool(
			rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_post_response_code.clone()])))))
			&& rt.is_true(rt.greater_equal(var_post_response_code, rt.new_int(200)))
			&& rt.is_true(rt.less(var_post_response_code, rt.new_int(300))))
	}
	mut var_get_response_successful := rt.new_null()
	mut var_get_response_code := rt.new_null()
	if rt.is_true(var_enable_remote_get) {
		var_get_response_code = rt.call_function('get_transient', [
			rt.new_string('woocommerce_test_remote_get'),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_get_response_code))
			|| rt.is_true(rt.call_function('is_wp_error', [var_get_response_code.clone()])) {
			var_response = rt.call_function('wp_safe_remote_get', [
				rt.new_string(
					'https://woocommerce.com/wc-api/product-key-api?request=ping&network=' +
					if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { '1' } else { '0' }),
				rt.create_array([
					rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' +
						(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() +
						'; ' + (rt.call_function('get_bloginfo', [rt.new_string('url')])).str() },
				]),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
				var_response.clone(),
			])))))
			{
				var_get_response_code =
					var_response.array_get(rt.new_string('response')).array_get(rt.new_string('code'))
			}
			rt.call_function('set_transient', [
				rt.new_string('woocommerce_test_remote_get'),
				var_get_response_code.clone(),
				rt.get_constant('HOUR_IN_SECONDS'),
			])
		}
		var_get_response_successful = rt.new_bool(
			rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_get_response_code.clone()])))))
			&& rt.is_true(rt.greater_equal(var_get_response_code, rt.new_int(200)))
			&& rt.is_true(rt.less(var_get_response_code, rt.new_int(300))))
	}
	mut var_server_architecture := if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('php_uname'),
	]))
	{ rt.call_function('sprintf', [rt.new_string('%s %s %s'),
			rt.call_function('php_uname', [rt.new_string('s')]),
			rt.call_function('php_uname', [rt.new_string('r')]),
			rt.call_function('php_uname', [rt.new_string('m')])]) } else { rt.new_string('') }
	mut var_database_version := rt.call_function('wc_get_server_database_version', []rt.PhpVal{})
	mut iife_temp_1 := Class_LoggingUtil{}
	mut iife_result_1 := iife_temp_1.get_log_directory(rt.new_bool(false))
	mut var_log_directory := iife_result_1
	return rt.create_array([
		rt.ArrayItem{ key: 'home_url', val: rt.call_function('get_option', [
			rt.new_string('home'),
		]) },
		rt.ArrayItem{ key: 'site_url', val: rt.call_function('get_option', [
			rt.new_string('siteurl'),
		]) },
		rt.ArrayItem{ key: 'store_id', val: rt.call_function('get_option', [
			Class_WC_Install.store_id_option(),
			rt.new_null(),
		]) },
		rt.ArrayItem{ key: 'version', val: rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'version') },
		rt.ArrayItem{ key: 'log_directory', val: var_log_directory },
		rt.ArrayItem{ key: 'log_directory_writable', val: rt.call_function('wp_is_writable', [
			var_log_directory.clone(),
		]) },
		rt.ArrayItem{ key: 'wp_version', val: rt.call_function('get_bloginfo', [
			rt.new_string('version'),
		]) },
		rt.ArrayItem{ key: 'wp_multisite', val: rt.call_function('is_multisite', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'wp_memory_limit', val: var_wp_memory_limit },
		rt.ArrayItem{ key: 'wp_debug_mode', val:
			rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
			&& rt.is_true(rt.get_constant('WP_DEBUG')) },
		rt.ArrayItem{ key: 'wp_cron', val: !(
			rt.is_true(rt.call_function('defined', [rt.new_string('DISABLE_WP_CRON')]))
			&& rt.is_true(rt.get_constant('DISABLE_WP_CRON'))) },
		rt.ArrayItem{ key: 'wp_environment_type', val: rt.call_function('wp_get_environment_type',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'language', val: rt.call_function('get_locale', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'external_object_cache', val: rt.call_function('wp_using_ext_object_cache',
			[]rt.PhpVal{}) },
		rt.ArrayItem{
			key: 'server_info'
			val: if rt.get_superglobal('_SERVER').array_isset(rt.new_string('SERVER_SOFTWARE')) { rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')),
					]),
				]) } else { rt.new_string('') }
		},
		rt.ArrayItem{ key: 'server_architecture', val: var_server_architecture },
		rt.ArrayItem{ key: 'php_version', val: rt.call_function('phpversion', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'php_post_max_size', val: rt.call_function('wc_let_to_num', [
			rt.call_function('ini_get', [
				rt.new_string('post_max_size'),
			]),
		]) },
		rt.ArrayItem{ key: 'php_max_execution_time', val: rt.new_int((rt.call_function('ini_get', [
			rt.new_string('max_execution_time'),
		])).to_i64()) },
		rt.ArrayItem{ key: 'php_max_input_vars', val: rt.new_int((rt.call_function('ini_get', [
			rt.new_string('max_input_vars'),
		])).to_i64()) },
		rt.ArrayItem{ key: 'curl_version', val: var_curl_version },
		rt.ArrayItem{ key: 'suhosin_installed', val: rt.call_function('extension_loaded', [
			rt.new_string('suhosin'),
		]) },
		rt.ArrayItem{ key: 'max_upload_size', val: rt.call_function('wp_max_upload_size',
			[]rt.PhpVal{}) },
		rt.ArrayItem{
			key: 'mysql_version'
			val: var_database_version.array_get(rt.new_string('number'))
		},
		rt.ArrayItem{
			key: 'mysql_version_string'
			val: var_database_version.array_get(rt.new_string('string'))
		},
		rt.ArrayItem{ key: 'default_timezone', val: rt.call_function('date_default_timezone_get',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'fsockopen_or_curl_enabled', val:
			rt.is_true(rt.call_function('function_exists', [rt.new_string('fsockopen')]))
			|| rt.is_true(rt.call_function('function_exists', [rt.new_string('curl_init')])) },
		rt.ArrayItem{ key: 'soapclient_enabled', val: rt.call_function('class_exists', [
			rt.new_string('SoapClient'),
		]) },
		rt.ArrayItem{ key: 'domdocument_enabled', val: rt.call_function('class_exists', [
			rt.new_string('DOMDocument'),
		]) },
		rt.ArrayItem{ key: 'gzip_enabled', val: rt.call_function('is_callable', [
			rt.new_string('gzopen'),
		]) },
		rt.ArrayItem{ key: 'mbstring_enabled', val: rt.call_function('extension_loaded', [
			rt.new_string('mbstring'),
		]) },
		rt.ArrayItem{ key: 'remote_post_successful', val: var_post_response_successful },
		rt.ArrayItem{
			key: 'remote_post_response'
			val: if rt.is_true(rt.call_function('is_wp_error', [
				var_post_response_code.clone(),
			]))
			{
				rt.call_method(var_post_response_code, 'get_error_message', []rt.PhpVal{})
			} else {
				var_post_response_code
			}
		},
		rt.ArrayItem{ key: 'remote_get_successful', val: var_get_response_successful },
		rt.ArrayItem{
			key: 'remote_get_response'
			val: if rt.is_true(rt.call_function('is_wp_error', [
				var_get_response_code.clone(),
			]))
			{
				rt.call_method(var_get_response_code, 'get_error_message', []rt.PhpVal{})
			} else {
				var_get_response_code
			}
		},
	])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) add_db_table_prefix(var_table rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	return (rt.get_property(var_wpdb, 'prefix')).str() + var_table.str()
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_database_info() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_tables := rt.new_array()
	mut var_database_size := rt.new_array()
	if rt.is_true(rt.call_function('defined', [rt.new_string('DB_NAME')])) {
		mut var_database_table_information := rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string("SELECT\n\t\t\t\t\t    table_name AS 'name',\n\t\t\t\t\t\tengine AS 'engine',\n\t\t\t\t\t    round( ( data_length / 1024 / 1024 ), 2 ) 'data',\n\t\t\t\t\t    round( ( index_length / 1024 / 1024 ), 2 ) 'index'\n\t\t\t\t\tFROM information_schema.TABLES\n\t\t\t\t\tWHERE table_schema = %s\n\t\t\t\t\tORDER BY name ASC;"),
				rt.get_constant('DB_NAME'),
			]),
		])
		mut var_core_tables := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_database_tables'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_sessions' },
				rt.ArrayItem{ key: none, val: 'woocommerce_api_keys' },
				rt.ArrayItem{ key: none, val: 'woocommerce_attribute_taxonomies' },
				rt.ArrayItem{ key: none, val: 'woocommerce_downloadable_product_permissions' },
				rt.ArrayItem{ key: none, val: 'woocommerce_order_items' },
				rt.ArrayItem{ key: none, val: 'woocommerce_order_itemmeta' },
				rt.ArrayItem{ key: none, val: 'woocommerce_tax_rates' },
				rt.ArrayItem{ key: none, val: 'woocommerce_tax_rate_locations' },
				rt.ArrayItem{ key: none, val: 'woocommerce_shipping_zones' },
				rt.ArrayItem{ key: none, val: 'woocommerce_shipping_zone_locations' },
				rt.ArrayItem{ key: none, val: 'woocommerce_shipping_zone_methods' },
				rt.ArrayItem{ key: none, val: 'woocommerce_payment_tokens' },
				rt.ArrayItem{ key: none, val: 'woocommerce_payment_tokenmeta' },
				rt.ArrayItem{ key: none, val: 'woocommerce_log' }]),
		])
		var_core_tables = rt.call_function('array_map', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_V2_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'add_db_table_prefix' },
			]),
			var_core_tables.clone(),
		])
		var_tables = rt.create_array([
			rt.ArrayItem{ key: 'woocommerce', val: rt.call_function('array_fill_keys', [
				var_core_tables.clone(),
				rt.new_bool(false),
			]) },
			rt.ArrayItem{ key: 'other', val: rt.new_array() },
		])
		var_database_size = {
			'data':  0
			'index': 0
		}
		mut var_site_tables_prefix := rt.call_method(var_wpdb, 'get_blog_prefix', [
			rt.call_function('get_current_blog_id', []rt.PhpVal{}),
		])
		mut var_global_tables := rt.call_method(var_wpdb, 'tables', [
			rt.new_string('global'),
			rt.new_bool(true),
		])
		mut iter_3 := var_database_table_information.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_table := item_3.val
			if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [rt.get_property(var_table, 'name'), var_site_tables_prefix.clone()])))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_table, 'name'), var_global_tables.clone(), rt.new_bool(true)]))))) {
				continue
			}
			mut var_table_type := rt.new_string((if rt.is_true(rt.call_function('in_array', [
				rt.get_property(var_table, 'name'),
				var_core_tables.clone(),
				rt.new_bool(true),
			]))
			{ 'woocommerce' } else { 'other' }).str())
			var_tables.array_get_mut(var_table_type).array_set(rt.get_property(var_table, 'name'), rt.create_array([
				rt.ArrayItem{ key: 'data', val: rt.get_property(var_table, 'data') },
				rt.ArrayItem{ key: 'index', val: rt.get_property(var_table, 'index') },
				rt.ArrayItem{ key: 'engine', val: rt.get_property(var_table, 'engine') },
			]))
			rt.new_int(var_database_size['data']) = rt.add(rt.new_int(var_database_size['data']), rt.get_property(var_table,
				'data'))
			rt.new_int(var_database_size['index']) = rt.add(rt.new_int(var_database_size['index']), rt.get_property(var_table,
				'index'))
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'wc_database_version', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_db_version'),
		]) },
		rt.ArrayItem{ key: 'database_prefix', val: rt.get_property(var_wpdb, 'prefix') },
		rt.ArrayItem{ key: 'maxmind_geoip_database', val: '' },
		rt.ArrayItem{ key: 'database_tables', val: var_tables },
		rt.ArrayItem{ key: 'database_size', val: var_database_size },
	])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_post_type_counts() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_post_type_counts := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string("SELECT post_type AS 'type', count(1) AS 'count' FROM "), rt.get_property(var_wpdb,
			'posts')), rt.new_string(' GROUP BY post_type;')),
	])
	return if var_post_type_counts.clone().is_array() {
		var_post_type_counts
	} else {
		rt.new_array()
	}
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_active_plugins() rt.PhpVal {
	mut var_active_plugins_data := rt.call_function('get_transient', [
		rt.new_string('wc_system_status_active_plugins'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_active_plugins_data)) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
			rt.new_string('get_plugin_data'),
		])))))
		{
			return rt.new_array()
		}
		mut var_active_valid_plugins := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [Class_PluginUtil.class()]), 'get_all_active_valid_plugins',
			[]rt.PhpVal{})
		var_active_plugins_data = rt.new_array()
		mut iter_4 := var_active_valid_plugins.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_plugin := item_4.val
			mut var_data := rt.call_function('get_plugin_data', [
				rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin.str()),
			])
			var_active_plugins_data.array_push(this.format_plugin_data(var_plugin.clone(),
				var_data.clone()))
		}
		rt.call_function('set_transient', [
			rt.new_string('wc_system_status_active_plugins'),
			var_active_plugins_data.clone(),
			rt.get_constant('HOUR_IN_SECONDS'),
		])
	}
	return var_active_plugins_data.clone()
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_inactive_plugins() rt.PhpVal {
	mut var_plugins_data := rt.call_function('get_transient', [
		rt.new_string('wc_system_status_inactive_plugins'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_plugins_data)) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
			rt.new_string('get_plugins'),
		])))))
		{
			return rt.new_array()
		}
		mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
		mut var_active_plugins := rt.cast_array(rt.call_function('get_option', [
			rt.new_string('active_plugins'),
			rt.new_array(),
		]))
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			mut var_network_activated_plugins := rt.func_array_keys(rt.call_function('get_site_option', [
				rt.new_string('active_sitewide_plugins'),
				rt.new_array(),
			]))
			var_active_plugins = rt.call_function('array_merge', [
				var_active_plugins.clone(), var_network_activated_plugins.clone()])
		}
		var_plugins_data = rt.new_array()
		mut iter_5 := var_plugins.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_data := item_5.val
			mut var_plugin := item_5.key
			if rt.is_true(rt.call_function('in_array', [var_plugin.clone(),
				var_active_plugins.clone(), rt.new_bool(true)]))
			{
				continue
			}
			var_plugins_data.array_push(this.format_plugin_data(var_plugin.clone(),
				var_data.clone()))
		}
		rt.call_function('set_transient', [
			rt.new_string('wc_system_status_inactive_plugins'),
			var_plugins_data.clone(),
			rt.get_constant('HOUR_IN_SECONDS'),
		])
	}
	return var_plugins_data.clone()
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) format_plugin_data(var_plugin rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/update.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_plugin_updates'),
	])))))
	{
		return rt.new_array()
	}
	if !rt.is_true(rt.get_property(rt.new_object('WC_REST_System_Status_V2_Controller', [
		'WC_REST_Controller',
	], &this), 'available_updates')) {
		this.dispatch_set_prop('available_updates', rt.call_function('get_plugin_updates',
			[]rt.PhpVal{}))
	}
	mut var_version_latest := var_data_mutated.array_get(rt.new_string('Version'))
	if !(rt.get_property(rt.get_property(rt.get_property(rt.new_object('WC_REST_System_Status_V2_Controller', [
		'WC_REST_Controller',
	], &this), 'available_updates').array_get(var_plugin), 'update'), 'new_version')).is_null() {
		var_version_latest = rt.get_property(rt.get_property(rt.get_property(rt.new_object('WC_REST_System_Status_V2_Controller', [
			'WC_REST_Controller',
		], &this), 'available_updates').array_get(var_plugin), 'update'), 'new_version')
	}
	return rt.create_array([rt.ArrayItem{ key: 'plugin', val: var_plugin },
		rt.ArrayItem{ key: 'name', val: var_data_mutated.array_get(rt.new_string('Name')) },
		rt.ArrayItem{ key: 'version', val: var_data_mutated.array_get(rt.new_string('Version')) },
		rt.ArrayItem{ key: 'version_latest', val: var_version_latest },
		rt.ArrayItem{ key: 'url', val: var_data_mutated.array_get(rt.new_string('PluginURI')) },
		rt.ArrayItem{
			key: 'author_name'
			val: var_data_mutated.array_get(rt.new_string('AuthorName'))
		}, rt.ArrayItem{ key: 'author_url', val: rt.call_function('esc_url_raw', [
			var_data_mutated.array_get(rt.new_string('AuthorURI')),
		]) }, rt.ArrayItem{
			key: 'network_activated'
			val: var_data_mutated.array_get(rt.new_string('Network'))
		}])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_dropins_mu_plugins() rt.PhpVal {
	mut var_plugins := rt.call_function('get_transient', [
		rt.new_string('wc_system_status_dropins_mu_plugins'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_plugins)) {
		mut var_dropins := rt.call_function('get_dropins', []rt.PhpVal{})
		var_plugins = rt.create_array([
			rt.ArrayItem{ key: 'dropins', val: rt.new_array() },
			rt.ArrayItem{ key: 'mu_plugins', val: rt.new_array() },
		])
		mut iter_6 := var_dropins.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_dropin := item_6.val
			mut var_key := item_6.key
			var_plugins.array_get_mut('dropins').array_push(rt.create_array([
				rt.ArrayItem{ key: 'plugin', val: var_key },
				rt.ArrayItem{ key: 'name', val: var_dropin.array_get(rt.new_string('Name')) },
			]))
		}
		mut var_mu_plugins := rt.call_function('get_mu_plugins', []rt.PhpVal{})
		mut iter_7 := var_mu_plugins.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_mu_plugin := item_7.val
			mut var_plugin := item_7.key
			var_plugins.array_get_mut('mu_plugins').array_push(rt.create_array([
				rt.ArrayItem{ key: 'plugin', val: var_plugin },
				rt.ArrayItem{ key: 'name', val: var_mu_plugin.array_get(rt.new_string('Name')) },
				rt.ArrayItem{ key: 'version', val: var_mu_plugin.array_get(rt.new_string('Version')) },
				rt.ArrayItem{ key: 'url', val: var_mu_plugin.array_get(rt.new_string('PluginURI')) },
				rt.ArrayItem{
					key: 'author_name'
					val: var_mu_plugin.array_get(rt.new_string('AuthorName'))
				},
				rt.ArrayItem{ key: 'author_url', val: rt.call_function('esc_url_raw', [
					var_mu_plugin.array_get(rt.new_string('AuthorURI')),
				]) },
			]))
		}
		rt.call_function('set_transient', [
			rt.new_string('wc_system_status_dropins_mu_plugins'),
			var_plugins.clone(),
			rt.get_constant('HOUR_IN_SECONDS'),
		])
	}
	return var_plugins.clone()
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_theme_info() rt.PhpVal {
	mut var_theme_info := rt.call_function('get_transient', [
		rt.new_string('wc_system_status_theme_info'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_theme_info)) {
		mut var_active_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_child_theme', []rt.PhpVal{})) {
			mut var_parent_theme := rt.call_function('wp_get_theme', [
				rt.get_property(var_active_theme, 'template'),
			])
			mut iife_temp_2 := Class_WC_Admin_Status{}
			mut iife_result_2 := iife_temp_2.get_latest_theme_version(var_parent_theme.clone())
			mut var_parent_theme_info := {
				'parent_name':           rt.get_property(var_parent_theme, 'name')
				'parent_version':        rt.get_property(var_parent_theme, 'version')
				'parent_version_latest': iife_result_2
				'parent_author_url':     rt.get_property(var_parent_theme,
					'{"nodeType":"Scalar_String","line":1335,"value":"Author URI"}')
			}
		} else {
			var_parent_theme_info = {
				'parent_name':           rt.new_string('')
				'parent_version':        rt.new_string('')
				'parent_version_latest': rt.new_string('')
				'parent_author_url':     rt.new_string('')
			}
		}
		mut var_override_files := rt.new_array()
		mut var_outdated_templates := rt.new_bool(false)
		mut iife_temp_3 := Class_WC_Admin_Status{}
		mut iife_result_3 := iife_temp_3.scan_template_files(rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
			'/templates/'))
		mut var_scan_files := iife_result_3
		var_scan_files.array_push('content-product_cat.php')
		var_scan_files.array_push('taxonomy-product_cat.php')
		var_scan_files.array_push('taxonomy-product_tag.php')
		mut var_wc_templates_dir := rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
			'/templates/')
		mut iter_8 := var_scan_files.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_file := item_8.val
			mut var_located := rt.call_function('wc_locate_template', [
				var_file.clone(),
				rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
					'template_path', []rt.PhpVal{}),
				var_wc_templates_dir.clone()])
			var_located = rt.call_function('apply_filters', [
				rt.new_string('wc_get_template'),
				var_located.clone(),
				var_file.clone(),
				rt.new_array(),
				rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path',
					[]rt.PhpVal{}),
				var_wc_templates_dir.clone(),
			])
			mut var_override_file := rt.new_bool(false)
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_located.clone(), var_wc_templates_dir.clone()])))))
				&& rt.is_true(rt.call_function('file_exists', [var_located.clone()])) {
				var_override_file = var_located.clone()
			}
			if !(!rt.is_true(var_override_file)) {
				mut var_core_file := var_file
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_core_file.clone(), rt.new_string('-product_cat')])))))
					|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_core_file.clone(), rt.new_string('-product_tag')]))))) {
					var_core_file = rt.call_function('str_replace', [
						rt.new_string('_'), rt.new_string('-'),
						var_core_file.clone()])
				}
				mut iife_temp_4 := Class_WC_Admin_Status{}
				mut iife_result_4 := iife_temp_4.get_file_version(rt.new_string(
					(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
					'/templates/' + var_core_file.str()))
				mut var_core_version := iife_result_4
				mut iife_temp_5 := Class_WC_Admin_Status{}
				mut iife_result_5 := iife_temp_5.get_file_version(var_override_file.clone())
				mut var_override_version := iife_result_5
				if rt.is_true(var_core_version)
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_override_version))))
					&& rt.is_true(rt.call_function('version_compare', [var_override_version.clone(), var_core_version.clone(), rt.new_string('<')])) {
					if rt.is_true(rt.new_bool(!(rt.is_true(var_outdated_templates)))) {
						var_outdated_templates = rt.new_bool(true)
					}
				}
				var_override_files << rt.create_array([
					rt.ArrayItem{ key: 'file', val: rt.call_function('str_replace', [
						rt.get_constant('ABSPATH'),
						rt.new_string(''),
						var_override_file.clone(),
					]) },
					rt.ArrayItem{ key: 'version', val: var_override_version },
					rt.ArrayItem{ key: 'core_version', val: var_core_version },
				])
			}
		}
		mut iife_temp_6 := Class_WC_Admin_Status{}
		mut iife_result_6 := iife_temp_6.get_latest_theme_version(var_active_theme.clone())
		mut var_active_theme_info := {
			'name':                    rt.get_property(var_active_theme, 'name')
			'version':                 rt.get_property(var_active_theme, 'version')
			'version_latest':          iife_result_6
			'author_url':              rt.call_function('esc_url_raw', [
				rt.get_property(var_active_theme,
					'{"nodeType":"Scalar_String","line":1410,"value":"Author URI"}'),
			])
			'is_child_theme':          rt.call_function('is_child_theme', []rt.PhpVal{})
			'is_block_theme':          rt.call_function('wp_is_block_theme', []rt.PhpVal{})
			'has_woocommerce_support': rt.call_function('current_theme_supports', [
				rt.new_string('woocommerce'),
			])
			'has_woocommerce_file':    rt.new_bool(
				rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).str() + '/woocommerce.php')]))
				|| rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.call_function('get_template_directory', []rt.PhpVal{})).str() + '/woocommerce.php')])))
			'has_outdated_templates':  var_outdated_templates
			'overrides':               var_override_files
		}
		var_theme_info = rt.call_function('array_merge', [
			rt.create_array_from_native_map(var_active_theme_info),
			rt.create_array_from_native_map(var_parent_theme_info),
		])
		rt.call_function('set_transient', [rt.new_string('wc_system_status_theme_info'),
			var_theme_info.clone(), rt.get_constant('HOUR_IN_SECONDS')])
	}
	return var_theme_info.clone()
}

fn Class_WC_REST_System_Status_V2_Controller.clean_theme_cache() {
	rt.call_function('delete_transient', [rt.new_string('wc_system_status_theme_info')])
}

fn Class_WC_REST_System_Status_V2_Controller.clean_plugin_cache() {
	rt.call_function('delete_transient', [
		rt.new_string('wc_system_status_active_plugins'),
	])
	rt.call_function('delete_transient', [
		rt.new_string('wc_system_status_inactive_plugins'),
	])
	rt.call_function('delete_transient', [
		rt.new_string('wc_system_status_dropins_mu_plugins'),
	])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_settings() rt.PhpVal {
	mut var_term_response := rt.new_array()
	mut var_terms := rt.call_function('get_terms', [rt.new_string('product_type'),
		rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: 0 }])])
	mut iter_9 := var_terms.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_term := item_9.val
		var_term_response.array_set(rt.get_property(var_term, 'slug'), rt.get_property(var_term,
			'name').to_string().to_lower())
	}
	mut var_product_visibility_terms := rt.new_array()
	var_terms = rt.call_function('get_terms', [rt.new_string('product_visibility'),
		rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: 0 }])])
	mut iter_10 := var_terms.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_term := item_10.val
		var_product_visibility_terms.array_set(rt.get_property(var_term, 'slug'), rt.get_property(var_term,
			'name').to_string().to_lower())
	}
	mut var_enabled_features_slugs := rt.func_array_keys(rt.call_function('wp_list_filter', [
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
		]), 'get_features', [
			rt.new_bool(true),
			rt.new_bool(true),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'is_enabled', val: true },
		]),
	]))
	mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper{}
	mut iife_result_7 := iife_temp_7.is_connected()
	mut iife_temp_8 := Class_WC_Data_Store{}
	mut iife_result_8 := iife_temp_8.load(rt.new_string('order'))
	mut iife_temp_9 := Class_OrderUtil{}
	mut iife_result_9 := iife_temp_9.custom_orders_table_usage_is_enabled()
	return rt.create_array([
		rt.ArrayItem{ key: 'api_enabled', val: rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_api_enabled'),
		])) },
		rt.ArrayItem{ key: 'force_ssl', val: rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_force_ssl_checkout'),
		])) },
		rt.ArrayItem{ key: 'currency', val: rt.call_function('get_woocommerce_currency',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'currency_symbol', val: rt.call_function('get_woocommerce_currency_symbol',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'currency_position', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_currency_pos'),
		]) },
		rt.ArrayItem{ key: 'thousand_separator', val: rt.call_function('wc_get_price_thousand_separator',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'decimal_separator', val: rt.call_function('wc_get_price_decimal_separator',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'number_of_decimals', val: rt.call_function('wc_get_price_decimals',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'geolocation_enabled', val: rt.call_function('in_array', [
			rt.call_function('get_option', [
				rt.new_string('woocommerce_default_customer_address'),
			]),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation_ajax()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation()
				},
			]),
			rt.new_bool(true),
		]) },
		rt.ArrayItem{ key: 'taxonomies', val: var_term_response },
		rt.ArrayItem{ key: 'product_visibility_terms', val: var_product_visibility_terms },
		rt.ArrayItem{
			key: 'woocommerce_com_connected'
			val: if rt.is_true(iife_result_7) { 'yes' } else { 'no' }
		},
		rt.ArrayItem{
			key: 'enforce_approved_download_dirs'
			val: rt.identical(rt.call_method(rt.call_method(rt.call_function('wc_get_container',
				[]rt.PhpVal{}), 'get', [
				Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.class(),
			]), 'get_mode', []rt.PhpVal{}),
				Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.mode_enabled())
		},
		rt.ArrayItem{ key: 'order_datastore', val: rt.call_method(iife_result_8,
			'get_current_class_name', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'HPOS_enabled', val: iife_result_9 },
		rt.ArrayItem{ key: 'HPOS_sync_enabled', val: rt.call_method(rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class(),
		]), 'data_sync_is_enabled', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'enabled_features', val: var_enabled_features_slugs },
	])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_security_info() rt.PhpVal {
	mut var_check_page := rt.call_function('wc_get_page_permalink', [
		rt.new_string('shop'),
	])
	return rt.create_array([
		rt.ArrayItem{ key: 'secure_connection', val: rt.identical(rt.new_string('https'), rt.call_function('substr', [
			var_check_page.clone(),
			rt.new_int(0),
			rt.new_int(5),
		])) },
		rt.ArrayItem{ key: 'hide_errors', val:
			!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
			&& rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG_DISPLAY')]))
			&& rt.is_true(rt.get_constant('WP_DEBUG'))
			&& rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY')))
			|| 0 == rt.call_function('ini_get', [rt.new_string('display_errors')]).to_i64() },
	])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_pages() rt.PhpVal {
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_page := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(var_page) {
			mut var_shortcode := rt.call_function('apply_filters_deprecated', [
				rt.new_string('woocommerce_cart_shortcode_tag'),
				rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_cart' }]),
				rt.new_string('8.3.0'),
				rt.new_string('woocommerce_create_pages'),
			])
			if rt.is_true(rt.call_function('has_shortcode', [
				rt.get_property(var_page, 'post_content'),
				var_shortcode.clone(),
			]))
			{
				return var_shortcode.clone()
			}
		}
		return rt.new_string('')
	}
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_page := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(var_page) {
			if rt.is_true(rt.call_function('has_block', [
				rt.new_string('woocommerce/cart'),
				rt.get_property(var_page, 'post_content'),
			]))
			{
				return rt.new_string('woocommerce/cart')
			}
			mut iife_temp_12 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
			mut iife_result_12 := iife_temp_12.has_block_variation(rt.new_string('woocommerce/classic-shortcode'),
				rt.new_string('shortcode'), rt.new_string('cart'), rt.get_property(var_page,
				'post_content'))
			if rt.is_true(iife_result_12) {
				return rt.new_string('woocommerce/classic-shortcode')
			}
		}
		return rt.new_string('')
	}
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_page := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(var_page) {
			mut var_shortcode := rt.call_function('apply_filters_deprecated', [
				rt.new_string('woocommerce_checkout_shortcode_tag'),
				rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_checkout' }]),
				rt.new_string('8.3.0'),
				rt.new_string('woocommerce_create_pages'),
			])
			if rt.is_true(rt.call_function('has_shortcode', [
				rt.get_property(var_page, 'post_content'),
				var_shortcode.clone(),
			]))
			{
				return var_shortcode.clone()
			}
		}
		return rt.new_string('')
	}
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_page := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(var_page) {
			if rt.is_true(rt.call_function('has_block', [
				rt.new_string('woocommerce/checkout'),
				rt.get_property(var_page, 'post_content'),
			]))
			{
				return rt.new_string('woocommerce/checkout')
			}
			mut iife_temp_15 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
			mut iife_result_15 := iife_temp_15.has_block_variation(rt.new_string('woocommerce/classic-shortcode'),
				rt.new_string('shortcode'), rt.new_string('checkout'), rt.get_property(var_page,
				'post_content'))
			if rt.is_true(iife_result_15) {
				return rt.new_string('woocommerce/classic-shortcode')
			}
		}
		return rt.new_string('')
	}
	mut var_check_pages := rt.create_array([
		rt.ArrayItem{ key: rt.call_function('_x', [rt.new_string('Shop base'),
			rt.new_string('Page setting'), rt.new_string('woocommerce')]), val: rt.create_array([
			rt.ArrayItem{ key: 'option', val: 'woocommerce_shop_page_id' }]) },
		rt.ArrayItem{ key: rt.call_function('_x', [rt.new_string('Cart'),
			rt.new_string('Page setting'), rt.new_string('woocommerce')]), val: rt.create_array([
			rt.ArrayItem{ key: 'option', val: 'woocommerce_cart_page_id' },
			rt.ArrayItem{ key: 'shortcode', val: '[' +
				(rt.call_function('apply_filters_deprecated', [rt.new_string('woocommerce_cart_shortcode_tag'), rt.create_array([rt.ArrayItem{
				key: none
				val: 'woocommerce_cart'
			}]), rt.new_string('8.3.0'), rt.new_string('woocommerce_create_pages')])).str() +
				']' }, rt.ArrayItem{ key: 'block', val: 'woocommerce/cart' },
			rt.ArrayItem{ key: 'shortcode_callback', val: rt.new_closure(closure_11_fn) },
			rt.ArrayItem{ key: 'block_callback', val: rt.new_closure(closure_13_fn) }]) },
		rt.ArrayItem{ key: rt.call_function('_x', [rt.new_string('Checkout'),
			rt.new_string('Page setting'), rt.new_string('woocommerce')]), val: rt.create_array([
			rt.ArrayItem{ key: 'option', val: 'woocommerce_checkout_page_id' },
			rt.ArrayItem{ key: 'shortcode', val: '[' +
				(rt.call_function('apply_filters_deprecated', [rt.new_string('woocommerce_checkout_shortcode_tag'), rt.create_array([rt.ArrayItem{
				key: none
				val: 'woocommerce_checkout'
			}]), rt.new_string('8.3.0'), rt.new_string('woocommerce_create_pages')])).str() +
				']' }, rt.ArrayItem{ key: 'block', val: 'woocommerce/checkout' },
			rt.ArrayItem{ key: 'shortcode_callback', val: rt.new_closure(closure_14_fn) },
			rt.ArrayItem{ key: 'block_callback', val: rt.new_closure(closure_16_fn) }]) },
		rt.ArrayItem{ key: rt.call_function('_x', [rt.new_string('My account'),
			rt.new_string('Page setting'), rt.new_string('woocommerce')]), val: rt.create_array([
			rt.ArrayItem{ key: 'option', val: 'woocommerce_myaccount_page_id' },
			rt.ArrayItem{ key: 'shortcode', val: '[' +
				(rt.call_function('apply_filters', [rt.new_string('woocommerce_my_account_shortcode_tag'), rt.new_string('woocommerce_my_account')])).str() +
				']' }]) },
		rt.ArrayItem{ key: rt.call_function('_x', [rt.new_string('Terms and conditions'),
			rt.new_string('Page setting'), rt.new_string('woocommerce')]), val: rt.create_array([
			rt.ArrayItem{ key: 'option', val: 'woocommerce_terms_page_id' }]) },
	])
	mut var_pages_output := rt.new_array()
	mut iter_11 := var_check_pages.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_values := item_11.val
		mut var_page_name := item_11.key
		mut var_page_id := rt.call_function('get_option', [
			var_values.array_get(rt.new_string('option')),
		])
		mut var_page_set := rt.new_bool(false)
		mut var_page_exists := rt.new_bool(false)
		mut var_page_visible := rt.new_bool(false)
		mut var_shortcode_present := rt.new_bool(false)
		mut var_shortcode_required := rt.new_bool(false)
		mut var_block_present := rt.new_bool(false)
		mut var_block_required := rt.new_bool(false)
		mut var_page := rt.new_bool(false)
		mut var_block := rt.new_string('')
		mut var_shortcode := rt.new_string('')
		if rt.is_true(var_page_id) {
			var_page_set = rt.new_bool(true)
			var_page = rt.call_function('get_post', [var_page_id.clone()])
			if rt.is_true(var_page) {
				var_page_exists = rt.new_bool(true)
				if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_page,
					'post_status')))
				{
					var_page_visible = rt.new_bool(true)
				}
			}
		}
		if rt.is_true(var_page) && var_values.array_isset(rt.new_string('shortcode_callback'))
			&& var_values.array_isset(rt.new_string('shortcode')) {
			var_shortcode_required = rt.new_bool(true)
			mut var_result := rt.call_callable(var_values.array_get(rt.new_string('shortcode_callback')), [
				var_page.clone(),
			])
			var_shortcode = if rt.is_true(var_result) {
				var_result
			} else {
				var_values.array_get(rt.new_string('shortcode'))
			}
			var_shortcode_present = rt.new_bool(var_result.to_bool())
		} else if rt.is_true(var_page) && var_values.array_isset(rt.new_string('shortcode')) {
			var_shortcode = var_values.array_get(rt.new_string('shortcode'))
			var_shortcode_required = rt.new_bool(true)
			var_shortcode_present = rt.call_function('has_shortcode', [
				rt.get_property(var_page, 'post_content'),
				rt.new_string(var_shortcode.clone().to_string().trim_space()),
			])
		}
		if rt.is_true(var_page) && var_values.array_isset(rt.new_string('block_callback'))
			&& var_values.array_isset(rt.new_string('block')) {
			var_block_required = rt.new_bool(true)
			var_result = rt.call_callable(var_values.array_get(rt.new_string('block_callback')), [
				var_page.clone(),
			])
			var_block = if rt.is_true(var_result) {
				var_result
			} else {
				var_values.array_get(rt.new_string('block'))
			}
			var_block_present = rt.new_bool(var_result.to_bool())
		} else if rt.is_true(var_page) && var_values.array_isset(rt.new_string('block')) {
			var_block = var_values.array_get(rt.new_string('block'))
			var_block_required = rt.new_bool(true)
			var_block_present = rt.call_function('has_block', [
				var_block.clone(), rt.get_property(var_page, 'post_content')])
		}
		var_pages_output << rt.create_array([
			rt.ArrayItem{ key: 'page_name', val: var_page_name },
			rt.ArrayItem{ key: 'page_id', val: var_page_id },
			rt.ArrayItem{ key: 'page_set', val: var_page_set },
			rt.ArrayItem{ key: 'page_exists', val: var_page_exists },
			rt.ArrayItem{ key: 'page_visible', val: var_page_visible },
			rt.ArrayItem{ key: 'shortcode', val: var_shortcode },
			rt.ArrayItem{ key: 'block', val: var_block },
			rt.ArrayItem{ key: 'shortcode_required', val: var_shortcode_required },
			rt.ArrayItem{ key: 'shortcode_present', val: var_shortcode_present },
			rt.ArrayItem{ key: 'block_present', val: var_block_present },
			rt.ArrayItem{ key: 'block_required', val: var_block_required },
		])
	}
	return var_pages_output.clone()
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_logging_info() rt.PhpVal {
	mut iife_temp_16 := Class_LoggingUtil{}
	mut iife_result_16 := iife_temp_16.logging_is_enabled()
	mut iife_temp_17 := Class_LoggingUtil{}
	mut iife_result_17 := iife_temp_17.get_default_handler()
	mut iife_temp_18 := Class_LoggingUtil{}
	mut iife_result_18 := iife_temp_18.get_retention_period()
	mut iife_temp_19 := Class_LoggingUtil{}
	mut iife_result_19 := iife_temp_19.get_level_threshold()
	mut iife_temp_20 := Class_LoggingUtil{}
	mut iife_result_20 := iife_temp_20.get_level_threshold()
	mut iife_temp_21 := Class_WC_Log_Levels{}
	mut iife_result_21 :=
		iife_temp_21.get_level_label(rt.new_string(iife_result_20.to_string().to_lower()))
	mut iife_temp_22 := Class_LoggingUtil{}
	mut iife_result_22 := iife_temp_22.get_log_directory_size()
	mut iife_temp_23 := Class_LoggingUtil{}
	mut iife_result_23 := iife_temp_23.get_log_directory_size()
	return rt.create_array([rt.ArrayItem{ key: 'logging_enabled', val: iife_result_16 },
		rt.ArrayItem{ key: 'default_handler', val: iife_result_17 },
		rt.ArrayItem{ key: 'retention_period_days', val: iife_result_18 },
		rt.ArrayItem{ key: 'level_threshold', val: iife_result_21 },
		rt.ArrayItem{ key: 'log_directory_size', val: rt.call_function('size_format', [
			iife_result_22,
		]) }])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'view' },
		])) },
	])
}

fn (mut this Class_WC_REST_System_Status_V2_Controller) prepare_item_for_response(var_system_status rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := this.add_additional_fields_to_object(var_system_status.clone(),
		var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), rt.new_string('view'))
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_system_status'),
		var_response.clone(),
		var_system_status.clone(),
		var_request.clone(),
	])
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

struct Class_WC_Admin_Status {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

struct Class_WC_Log_Levels {
	rt.PhpObjectBase
}

fn create_wc_rest_system_status_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_System_Status_V2_Controller {
	mut obj := &Class_WC_REST_System_Status_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v2')
		rest_base:     rt.new_string('system_status')
	}
	return obj
}

fn create_wc_rest_controller(_args ...rt.PhpVal) &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_loggingutil(_args ...rt.PhpVal) &Class_LoggingUtil {
	mut obj := &Class_LoggingUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_status(_args ...rt.PhpVal) &Class_WC_Admin_Status {
	mut obj := &Class_WC_Admin_Status{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_wccom_connectionhelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_orderutil(_args ...rt.PhpVal) &Class_OrderUtil {
	mut obj := &Class_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_log_levels(_args ...rt.PhpVal) &Class_WC_Log_Levels {
	mut obj := &Class_WC_Log_Levels{
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
			return rt.new_bool(this.check_if_field_item_exists(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
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
		else {
			return none
		}
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
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WC_Admin_Status) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Status) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Status) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Log_Levels) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Log_Levels) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Log_Levels) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_GroupUse
}
