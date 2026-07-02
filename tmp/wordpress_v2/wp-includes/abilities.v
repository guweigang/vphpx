import rt

fn wp_register_core_ability_categories() {
	rt.call_function('wp_register_ability_category', [rt.new_string('site'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Site'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Abilities that retrieve or modify site information and settings.'),
			]) },
		])])
	rt.call_function('wp_register_ability_category', [rt.new_string('user'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('User'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Abilities that retrieve or modify user information and settings.'),
			]) },
		])])
}

fn wp_register_core_abilities() {
	mut var_category_site := ''
	mut var_category_user := ''
	mut var_site_info_properties := map[string]rt.PhpVal{}
	mut var_site_info_fields := rt.new_null()
	var_category_site = 'site'
	var_category_user = 'user'
	var_site_info_properties = {
		'name':        {
			'type':        rt.new_string('string')
			'description': rt.call_function('__', [rt.new_string('The site title.')])
		}
		'description': {
			'type':        rt.new_string('string')
			'description': rt.call_function('__', [rt.new_string('The site tagline.')])
		}
		'url':         {
			'type':        rt.new_string('string')
			'description': rt.call_function('__', [rt.new_string('The site home URL.')])
		}
		'wpurl':       {
			'type':        rt.new_string('string')
			'description': rt.call_function('__', [
				rt.new_string('The WordPress installation URL.'),
			])
		}
		'admin_email': {
			'type':        rt.new_string('string')
			'description': rt.call_function('__', [
				rt.new_string('The site administrator email address.'),
			])
		}
		'charset':     {
			'type':        rt.new_string('string')
			'description': rt.call_function('__', [
				rt.new_string('The site character encoding.'),
			])
		}
		'language':    {
			'type':        rt.new_string('string')
			'description': rt.call_function('__', [
				rt.new_string('The site language locale code.'),
			])
		}
		'version':     {
			'type':        rt.new_string('string')
			'description': rt.call_function('__', [
				rt.new_string('The WordPress version.'),
			])
		}
	}
	var_site_info_fields =
		rt.func_array_keys(rt.create_array_from_native_map(var_site_info_properties))
	closure_1_fn := fn [var_site_info_fields] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_input := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_input = if var_input.clone().is_array() { var_input } else { rt.new_array() }
		mut var_requested_fields := if !(!rt.is_true(var_input.array_get(rt.new_string('fields')))) {
			var_input.array_get(rt.new_string('fields'))
		} else {
			var_site_info_fields
		}
		mut var_result := rt.new_array()
		mut iter_1 := var_requested_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			var_result.array_set(var_field, rt.call_function('get_bloginfo', [
				var_field.clone()]))
		}
		return
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_function('wp_register_ability', [rt.new_string('core/get-site-info'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Get Site Information'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Returns site information configured in WordPress. By default returns all fields, or optionally a filtered subset.'),
			]) },
			rt.ArrayItem{ key: 'category', val: var_category_site },
			rt.ArrayItem{ key: 'input_schema', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'fields', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'array' },
						rt.ArrayItem{ key: 'items', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'enum', val: var_site_info_fields },
						]) },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Optional: Limit response to specific fields. If omitted, all fields are returned.'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'additionalProperties', val: false },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
			]) },
			rt.ArrayItem{ key: 'output_schema', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: var_site_info_properties },
				rt.ArrayItem{ key: 'additionalProperties', val: false },
			]) },
			rt.ArrayItem{ key: 'execute_callback', val: rt.new_closure(closure_1_fn) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) },
			rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'annotations', val: rt.create_array([
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'destructive', val: false },
					rt.ArrayItem{ key: 'idempotent', val: true },
				]) },
				rt.ArrayItem{ key: 'show_in_rest', val: true },
			]) },
		])])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_current_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
		return
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_function('wp_register_ability', [rt.new_string('core/get-user-info'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Get User Information'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Returns basic profile details for the current authenticated user to support personalization, auditing, and access-aware behavior.'),
			]) },
			rt.ArrayItem{ key: 'category', val: var_category_user },
			rt.ArrayItem{ key: 'output_schema', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'required', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'id' },
					rt.ArrayItem{ key: none, val: 'display_name' },
					rt.ArrayItem{ key: none, val: 'user_nicename' },
					rt.ArrayItem{ key: none, val: 'user_login' },
					rt.ArrayItem{ key: none, val: 'roles' },
					rt.ArrayItem{ key: none, val: 'locale' },
				]) },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'integer' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The user ID.'),
						]) },
					]) },
					rt.ArrayItem{ key: 'display_name', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The display name of the user.'),
						]) },
					]) },
					rt.ArrayItem{ key: 'user_nicename', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The URL-friendly name for the user.'),
						]) },
					]) },
					rt.ArrayItem{ key: 'user_login', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The login username for the user.'),
						]) },
					]) },
					rt.ArrayItem{ key: 'roles', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'array' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The roles assigned to the user.'),
						]) },
						rt.ArrayItem{ key: 'items', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
						]) },
					]) },
					rt.ArrayItem{ key: 'locale', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The locale string for the user, such as en_US.'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'additionalProperties', val: false },
			]) },
			rt.ArrayItem{ key: 'execute_callback', val: rt.new_closure(closure_3_fn) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_4_fn) },
			rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'annotations', val: rt.create_array([
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'destructive', val: false },
					rt.ArrayItem{ key: 'idempotent', val: true },
				]) },
				rt.ArrayItem{ key: 'show_in_rest', val: false },
			]) },
		])])
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_wpdb := rt.new_null()
		mut var_env := rt.call_function('wp_get_environment_type', []rt.PhpVal{})
		mut var_php_version := rt.call_function('phpversion', []rt.PhpVal{})
		mut var_db_server_info := rt.new_string('')
		if rt.is_true(rt.call_function('method_exists', [var_wpdb.clone(),
			rt.new_string('db_server_info')]))
		{
			var_db_server_info = if !(rt.call_method(var_wpdb, 'db_server_info', []rt.PhpVal{})).is_null() {
				rt.call_method(var_wpdb, 'db_server_info', []rt.PhpVal{})
			} else {
				rt.new_string('')
			}
		}
		mut var_wp_version := rt.call_function('get_bloginfo', [
			rt.new_string('version')])
		return
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_function('wp_register_ability', [rt.new_string('core/get-environment-info'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Get Environment Info'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string("Returns core details about the site's runtime context for diagnostics and compatibility (environment, PHP runtime, database server info, WordPress version)."),
			]) },
			rt.ArrayItem{ key: 'category', val: var_category_site },
			rt.ArrayItem{ key: 'output_schema', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'required', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'environment' },
					rt.ArrayItem{ key: none, val: 'php_version' },
					rt.ArrayItem{ key: none, val: 'db_server_info' },
					rt.ArrayItem{ key: none, val: 'wp_version' },
				]) },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'environment', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string("The site's runtime environment classification (can be one of these: production, staging, development, local)."),
						]) },
						rt.ArrayItem{ key: 'enum', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'production' },
							rt.ArrayItem{ key: none, val: 'staging' },
							rt.ArrayItem{ key: none, val: 'development' },
							rt.ArrayItem{ key: none, val: 'local' },
						]) },
					]) },
					rt.ArrayItem{ key: 'php_version', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The PHP runtime version executing WordPress.'),
						]) },
					]) },
					rt.ArrayItem{ key: 'db_server_info', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The database server vendor and version string reported by the driver.'),
						]) },
					]) },
					rt.ArrayItem{ key: 'wp_version', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The WordPress core version running on this site.'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'additionalProperties', val: false },
			]) },
			rt.ArrayItem{ key: 'execute_callback', val: rt.new_closure(closure_5_fn) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_6_fn) },
			rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'annotations', val: rt.create_array([
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'destructive', val: false },
					rt.ArrayItem{ key: 'idempotent', val: true },
				]) },
				rt.ArrayItem{ key: 'show_in_rest', val: true },
			]) },
		])])
}

fn main() {
	defer {
		rt.shutdown()
	}
}
