import rt

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry {
	rt.PhpObjectBase
pub mut:
	platforms          rt.PhpVal = rt.new_array()
	credential_manager rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) construct() {
	this.load_platforms()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) init(mut var_credential_manager Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager) {
	this.credential_manager = var_credential_manager.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) load_platforms() {
	mut var_platforms := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_migrator_platforms'),
		rt.new_array(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_platforms.dup().is_array()))))) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_platforms.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_config := item_1.val
			mut var_platform_id := item_1.key
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_config.array_isset(rt.new_string('fetcher'))
				&& var_config.array_isset(rt.new_string('mapper'))
				&& rt.is_true(rt.new_bool(var_config.array_get('fetcher').is_string()))))
				&& !(!rt.is_true(var_config.array_get('fetcher')))))
				&& rt.is_true(rt.new_bool(var_config.array_get('mapper').is_string()))))
				&& !(!rt.is_true(var_config.array_get('mapper')))))
			{
				this.platforms.array_set(var_platform_id, var_config.dup())
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) get_platforms() rt.PhpVal {
	return this.platforms
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) get_platform(platform_id string) rt.PhpVal {
	return if !(this.platforms.array_get(platform_id)).is_null() {
		this.platforms.array_get(platform_id)
	} else {
		rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) get_fetcher(platform_id string) rt.PhpVal {
	mut var_platform := this.get_platform(platform_id)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_platform)))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [
			rt.call_function('esc_html__', [rt.new_string('Platform %s not found.'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_html', [rt.new_string(platform_id)]),
		]))))
	}
	mut var_fetcher_class := var_platform.array_get('fetcher')
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_fetcher_class.dup().is_string())))))
		|| !rt.is_true(var_fetcher_class)))
	{
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Invalid fetcher class for platform %s. Fetcher must be a non-empty string.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.new_string(platform_id),
			]),
		]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		var_fetcher_class.dup()])))))
	{
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Invalid fetcher class for platform %1$s. Class %2$s does not exist.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.new_string(platform_id),
			]),
			rt.call_function('esc_html', [
				var_fetcher_class.dup(),
			]),
		]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		Class_Automattic_WooCommerce_Internal_CLI_Migrator_Interfaces_PlatformFetcherInterface.class(),
		rt.call_function('class_implements', [var_fetcher_class.dup()]),
		rt.new_bool(true),
	])))))
	{
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Invalid fetcher class for platform %1$s. Class %2$s does not implement %3$s.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.new_string(platform_id),
			]),
			rt.call_function('esc_html', [
				var_fetcher_class.dup(),
			]),
			rt.call_function('esc_html', [
				Class_Automattic_WooCommerce_Internal_CLI_Migrator_Interfaces_PlatformFetcherInterface.class(),
			]),
		]))))
	}
	mut var_credentials := rt.call_method(this.credential_manager, 'get_credentials', [
		rt.new_string(platform_id),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_credentials.dup().is_array()))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [
			rt.new_string('No credentials found for platform "%s". Please configure credentials using: wp wc migrate setup'),
			rt.call_function('esc_html', [rt.new_string(platform_id)]),
		]))))
	}
	return rt.create_object_dynamically(var_fetcher_class, [var_credentials.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) get_mapper(platform_id string, mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_platform := this.get_platform(platform_id)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_platform)))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [
			rt.call_function('esc_html__', [rt.new_string('Platform %s not found.'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_html', [rt.new_string(platform_id)]),
		]))))
	}
	mut var_mapper_class := var_platform.array_get('mapper')
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_mapper_class.dup().is_string())))))
		|| !rt.is_true(var_mapper_class)))
	{
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Invalid mapper class for platform %s. Mapper must be a non-empty string.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.new_string(platform_id),
			]),
		]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		var_mapper_class.dup()])))))
	{
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Invalid mapper class for platform %1$s. Class %2$s does not exist.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.new_string(platform_id),
			]),
			rt.call_function('esc_html', [
				var_mapper_class.dup(),
			]),
		]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		Class_Automattic_WooCommerce_Internal_CLI_Migrator_Interfaces_PlatformMapperInterface.class(),
		rt.call_function('class_implements', [var_mapper_class.dup()]),
		rt.new_bool(true),
	])))))
	{
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Invalid mapper class for platform %1$s. Class %2$s does not implement %3$s.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.new_string(platform_id),
			]),
			rt.call_function('esc_html', [
				var_mapper_class.dup(),
			]),
			rt.call_function('esc_html', [
				Class_Automattic_WooCommerce_Internal_CLI_Migrator_Interfaces_PlatformMapperInterface.class(),
			]),
		]))))
	}
	if !(!rt.is_true(var_args)) {
		return rt.create_object_dynamically(var_mapper_class, [var_args])
	} else {
		mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
		return rt.call_method(var_container, 'get', [var_mapper_class.dup()])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) resolve_platform(mut var_assoc_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, default_platform string) string {
	mut var_platform := if !(var_assoc_args.array_get('platform')).is_null() {
		var_assoc_args.array_get('platform')
	} else {
		rt.new_null()
	}
	if !rt.is_true(var_platform) {
		var_platform = rt.new_string(rt.new_string(default_platform))
		mut var_platform_display_name :=
			rt.new_string(this.get_platform_display_name(var_platform.str()))
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WP_CLI{}
			return temp.log(arg_0)
		}(rt.new_string("Platform not specified, using default: '${var_platform_display_name.to_string()}'."))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_platform(var_platform.str()))))) {
		mut var_available_platforms := rt.func_array_keys(this.get_platforms())
		if !rt.is_true(var_available_platforms) {
			fn (arg_0 rt.PhpVal) rt.PhpVal {
				mut temp := Class_WP_CLI{}
				return temp.error(arg_0)
			}(rt.new_string('No platforms are currently registered. Please ensure platform plugins are installed and activated.'))
		} else {
			fn (arg_0 rt.PhpVal) rt.PhpVal {
				mut temp := Class_WP_CLI{}
				return temp.error(arg_0)
			}(rt.call_function('sprintf', [
				rt.new_string("Platform '%s' is not registered. Available platforms: %s"),
				var_platform.dup(),
				rt.call_function('implode', [rt.new_string(', '),
					var_available_platforms.dup()]),
			]))
		}
	}
	return var_platform.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) get_platform_credential_fields(platform_slug string) rt.PhpVal {
	mut var_platform := this.get_platform(platform_slug)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_platform.dup().is_array()))))) {
		return rt.new_array()
	}
	mut var_credentials := if !(var_platform.array_get('credentials')).is_null() {
		var_platform.array_get('credentials')
	} else {
		rt.new_array()
	}
	return if rt.is_true(rt.new_bool(var_credentials.dup().is_array())) {
		var_credentials
	} else {
		rt.new_array()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) get_platform_display_name(platform_slug string) string {
	mut var_platform := this.get_platform(platform_slug)
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_platform.dup().is_array()))
		&& var_platform.array_isset(rt.new_string('name'))))
	{
		return (var_platform.array_get('name')).str()
	}
	return (rt.call_function('ucfirst', [rt.new_string(platform_slug)])).str()
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_cli_migrator_core_platformregistry() &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry{
		PhpObjectBase:      rt.PhpObjectBase{}
		platforms:          rt.new_array()
		credential_manager: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli() &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'load_platforms' {
			this.load_platforms()
			return rt.new_null()
		}
		'get_platforms' {
			return this.get_platforms()
		}
		'get_platform' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_platform(dispatch_arg_0)
		}
		'get_fetcher' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_fetcher(dispatch_arg_0)
		}
		'get_mapper' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.get_mapper(dispatch_arg_0, mut dispatch_arg_1)
		}
		'resolve_platform' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.resolve_platform(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_platform_credential_fields' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_platform_credential_fields(dispatch_arg_0)
		}
		'get_platform_display_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_platform_display_name(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'platforms' { return this.platforms }
		'credential_manager' { return this.credential_manager }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'platforms' {
			this.platforms = val
			return true
		}
		'credential_manager' {
			this.credential_manager = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_cli_migrator_core_platformregistry()
		return rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry',
			[]string{}, obj)
	})
	rt.register_class_factory('InvalidArgumentException', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_invalidargumentexception()
		return rt.new_object('InvalidArgumentException', []string{}, obj)
	})
	rt.register_class_factory('WP_CLI', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_cli()
		return rt.new_object('WP_CLI', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

pub fn init_wp_content_plugins_woocommerce_src_internal_cli_migrator_core_platformregistry_php() {
	// unsupported statement: Stmt_Declare
}
