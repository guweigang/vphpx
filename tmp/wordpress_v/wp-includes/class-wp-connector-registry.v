import rt

struct Class_WP_Connector_Registry {
	rt.PhpObjectBase
pub mut:
	instance              rt.PhpVal = rt.new_null()
	registered_connectors rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Connector_Registry) register(id string, mut var_args Class_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^[a-z0-9_-]+$/'),
		rt.new_string(id),
	])))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [
				rt.new_string('Connector ID must contain only lowercase alphanumeric characters, hyphens, and underscores.'),
			]),
			rt.new_string('7.0.0')])
		return rt.new_null()
	}
	if this.is_registered(id) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Connector "%s" is already registered.'),
				]),
				rt.call_function('esc_html', [
					rt.new_string(id),
				]),
			]),
			rt.new_string('7.0.0')])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_args.array_get('name'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('name').is_string())))))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Connector "%s" requires a non-empty "name" string.'),
				]),
				rt.call_function('esc_html', [
					rt.new_string(id),
				]),
			]),
			rt.new_string('7.0.0')])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_args.array_get('type'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('type').is_string())))))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Connector "%s" requires a non-empty "type" string.'),
				]),
				rt.call_function('esc_html', [
					rt.new_string(id),
				]),
			]),
			rt.new_string('7.0.0')])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(var_args.array_isset(rt.new_string('authentication')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('authentication').is_array())))))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Connector "%s" requires an "authentication" array.'),
				]),
				rt.call_function('esc_html', [
					rt.new_string(id),
				]),
			]),
			rt.new_string('7.0.0')])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_args.array_get('authentication').array_get('method'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args.array_get('authentication').array_get('method'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'api_key'
	}, rt.ArrayItem{ key: none, val: 'none' }]), rt.new_bool(true)])))))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Connector "%s" authentication method must be "api_key" or "none".'),
				]),
				rt.call_function('esc_html', [
					rt.new_string(id),
				]),
			]),
			rt.new_string('7.0.0')])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('ai_provider'), var_args.array_get('type')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_supports_ai', []rt.PhpVal{})))))))
	{
		return rt.new_null()
	}
	mut var_connector := {
		'name':           var_args.array_get('name')
		'description':    if rt.is_true(rt.new_bool(
			var_args.array_isset(rt.new_string('description'))
			&& rt.is_true(rt.new_bool(var_args.array_get('description').is_string()))))
		{
			var_args.array_get('description')
		} else {
			rt.new_string('')
		}
		'type':           var_args.array_get('type')
		'authentication': {
			'method': var_args.array_get('authentication').array_get('method')
		}
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_args.array_get('logo_url')))
		&& rt.is_true(rt.new_bool(var_args.array_get('logo_url').is_string()))))
	{
		var_connector['logo_url'] = var_args.array_get('logo_url')
	}
	if rt.is_true(rt.identical(rt.new_string('api_key'),
		var_args.array_get('authentication').array_get('method')))
	{
		if rt.is_true(rt.new_bool(
			!(!rt.is_true(var_args.array_get('authentication').array_get('credentials_url')))
			&& rt.is_true(rt.new_bool(var_args.array_get('authentication').array_get('credentials_url').is_string()))))
		{
			var_connector.array_get_mut('authentication').array_set('credentials_url',
				var_args.array_get('authentication').array_get('credentials_url'))
		}
		if var_args.array_get('authentication').array_isset(rt.new_string('setting_name')) {
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('authentication').array_get('setting_name').is_string())))))
				|| rt.is_true(rt.identical(rt.new_string(''), var_args.array_get('authentication').array_get('setting_name')))))
			{
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Connector "%s" authentication setting_name must be a non-empty string.'),
						]),
						rt.call_function('esc_html', [
							rt.new_string(id),
						]),
					]),
					rt.new_string('7.0.0')])
				return rt.new_null()
			}
			var_connector.array_get_mut('authentication').array_set('setting_name',
				var_args.array_get('authentication').array_get('setting_name'))
		} else {
			var_connector.array_get_mut('authentication').array_set('setting_name', rt.call_function('str_replace', [
				rt.new_string('-'),
				rt.new_string('_'),
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('connectors_'),
					var_connector.array_get('type')), rt.new_string('_')), rt.new_string(id)),
					rt.new_string('_api_key')),
			]))
		}
		if var_args.array_get('authentication').array_isset(rt.new_string('constant_name')) {
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('authentication').array_get('constant_name').is_string())))))
				|| rt.is_true(rt.identical(rt.new_string(''), var_args.array_get('authentication').array_get('constant_name')))))
			{
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Connector "%s" authentication constant_name must be a non-empty string.'),
						]),
						rt.call_function('esc_html', [
							rt.new_string(id),
						]),
					]),
					rt.new_string('7.0.0')])
				return rt.new_null()
			}
			var_connector.array_get_mut('authentication').array_set('constant_name',
				var_args.array_get('authentication').array_get('constant_name'))
		}
		if var_args.array_get('authentication').array_isset(rt.new_string('env_var_name')) {
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('authentication').array_get('env_var_name').is_string())))))
				|| rt.is_true(rt.identical(rt.new_string(''), var_args.array_get('authentication').array_get('env_var_name')))))
			{
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Connector "%s" authentication env_var_name must be a non-empty string.'),
						]),
						rt.call_function('esc_html', [
							rt.new_string(id),
						]),
					]),
					rt.new_string('7.0.0')])
				return rt.new_null()
			}
			var_connector.array_get_mut('authentication').array_set('env_var_name',
				var_args.array_get('authentication').array_get('env_var_name'))
		}
	}
	var_connector['plugin'] = rt.new_array()
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_args.array_get('plugin')))
		&& rt.is_true(rt.new_bool(var_args.array_get('plugin').is_array()))))
	{
		if !(!rt.is_true(var_args.array_get('plugin').array_get('file'))) {
			var_connector.array_get_mut('plugin').array_set('file',
				var_args.array_get('plugin').array_get('file'))
		}
		if var_args.array_get('plugin').array_isset(rt.new_string('is_active')) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
				var_args.array_get('plugin').array_get('is_active'),
			])))))
			{
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Connector "%s" plugin is_active must be callable.'),
						]),
						rt.call_function('esc_html', [
							rt.new_string(id),
						]),
					]),
					rt.new_string('7.0.0')])
				return rt.new_null()
			}
			var_connector.array_get_mut('plugin').array_set('is_active',
				var_args.array_get('plugin').array_get('is_active'))
		}
	}
	if !(var_connector.array_get('plugin').array_isset(rt.new_string('is_active'))) {
		var_connector.array_get_mut('plugin').array_set('is_active', '__return_true')
	}
	this.registered_connectors.array_set(id, var_connector.dup())
	return var_connector.dup()
}

fn (mut this Class_WP_Connector_Registry) unregister(id string) rt.PhpVal {
	if !(this.is_registered(id)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Connector "%s" not found.')]),
				rt.call_function('esc_html', [rt.new_string(id)]),
			]),
			rt.new_string('7.0.0')])
		return rt.new_null()
	}
	mut var_unregistered := this.registered_connectors.array_get(id)
	this.registered_connectors.array_unset(rt.new_string(id))
	return var_unregistered.dup()
}

fn (mut this Class_WP_Connector_Registry) get_all_registered() rt.PhpVal {
	return this.registered_connectors
}

fn (mut this Class_WP_Connector_Registry) is_registered(id string) bool {
	return (rt.new_bool(this.registered_connectors.array_isset(rt.new_string(id)))).to_bool()
}

fn (mut this Class_WP_Connector_Registry) get_registered(id string) rt.PhpVal {
	if !(this.is_registered(id)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Connector "%s" not found.')]),
				rt.call_function('esc_html', [rt.new_string(id)]),
			]),
			rt.new_string('7.0.0')])
		return rt.new_null()
	}
	return this.registered_connectors.array_get(id)
}

fn Class_WP_Connector_Registry.get_instance() rt.PhpVal {
	return
}

fn Class_WP_Connector_Registry.set_instance(mut var_registry Class_WP_Connector_Registry) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [
		rt.new_string('init'),
	])))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [
				rt.new_string('The connector registry instance must be set during the <code>init</code> action.'),
			]),
			rt.new_string('7.0.0')])
		return rt.new_null()
	}
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn create_wp_connector_registry() &Class_WP_Connector_Registry {
	mut obj := &Class_WP_Connector_Registry{
		PhpObjectBase:         rt.PhpObjectBase{}
		instance:              rt.new_null()
		registered_connectors: rt.new_array()
	}
	return obj
}

fn (mut this Class_WP_Connector_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.register(dispatch_arg_0, mut dispatch_arg_1)
		}
		'unregister' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.unregister(dispatch_arg_0)
		}
		'get_all_registered' {
			return this.get_all_registered()
		}
		'is_registered' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_registered(dispatch_arg_0))
		}
		'get_registered' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_registered(dispatch_arg_0)
		}
		'get_instance' {
			return Class_WP_Connector_Registry.get_instance()
		}
		'set_instance' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Connector_Registry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			Class_WP_Connector_Registry.set_instance(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Connector_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'registered_connectors' { return this.registered_connectors }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Connector_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' {
			this.instance = val
			return true
		}
		'registered_connectors' {
			this.registered_connectors = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_includes_class_wp_connector_registry_php() {
}
