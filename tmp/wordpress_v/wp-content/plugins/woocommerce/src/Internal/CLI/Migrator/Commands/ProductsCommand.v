import rt

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ProductsCommand {
	rt.PhpObjectBase
pub mut:
	credential_manager  rt.PhpVal = rt.new_null()
	platform_registry   rt.PhpVal = rt.new_null()
	products_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ProductsCommand) init(mut var_credential_manager Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager, mut var_platform_registry Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry, mut var_products_controller Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) {
	this.credential_manager = var_credential_manager.dup()
	this.platform_registry = var_platform_registry.dup()
	this.products_controller = var_products_controller.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ProductsCommand) magic_invoke(mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_array) {
	mut var_platform := rt.call_method(this.platform_registry, 'resolve_platform', [
		var_assoc_args,
	])
	mut var_platform_display_name := rt.call_method(this.platform_registry,
		'get_platform_display_name', [var_platform.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.credential_manager,
		'has_credentials', [var_platform.dup()])))))
	{
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WP_CLI{}
			return temp.log(arg_0)
		}(rt.new_string("Credentials for '${var_platform_display_name.to_string()}' not found. Let's set them up."))
		mut var_required_fields := rt.call_method(this.platform_registry,
			'get_platform_credential_fields', [var_platform.dup()])
		if !rt.is_true(var_required_fields) {
			fn (arg_0 rt.PhpVal) rt.PhpVal {
				mut temp := Class_WP_CLI{}
				return temp.error(arg_0)
			}(rt.new_string("The platform '${var_platform_display_name.to_string()}' does not have configured credential fields."))
			return rt.new_null()
		}
		rt.call_method(this.credential_manager, 'setup_credentials', [
			var_platform.dup(), var_required_fields.dup()])
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WP_CLI{}
			return temp.success(arg_0)
		}(rt.new_string('Credentials saved successfully. Please run the command again to begin the migration.'))
		return rt.new_null()
	}
	if var_assoc_args.array_isset(rt.new_string('count')) {
		this.handle_count_request(var_platform.str(), var_platform_display_name.str(), mut
			var_assoc_args)
		return rt.new_null()
	}
	rt.call_method(this.products_controller, 'migrate_products',
		[var_assoc_args, var_platform.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ProductsCommand) handle_count_request(platform string, platform_display_name string, mut var_assoc_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_array) {
	mut platform_mutated := platform
	mut platform_display_name_mutated := platform_display_name
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_CLI{}
		return temp.log(arg_0)
	}(rt.new_string('Fetching product count from ${var_platform_display_name.to_string()}...'))
	mut var_fetcher := rt.call_method(this.platform_registry, 'get_fetcher', [
		rt.new_string(platform_mutated).dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fetcher)))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WP_CLI{}
			return temp.error(arg_0)
		}(rt.new_string("Could not get fetcher for platform '${var_platform_display_name.to_string()}'"))
		return rt.new_null()
	}
	mut var_filter_args := rt.new_array()
	if var_assoc_args.array_isset(rt.new_string('status')) {
		var_filter_args.array_set('status', var_assoc_args.array_get('status'))
	}
	if var_assoc_args.array_isset(rt.new_string('product-type')) {
		var_filter_args.array_set('product_type', var_assoc_args.array_get('product-type'))
	}
	if var_assoc_args.array_isset(rt.new_string('vendor')) {
		var_filter_args.array_set('vendor', var_assoc_args.array_get('vendor'))
	}
	if var_assoc_args.array_isset(rt.new_string('ids')) {
		var_filter_args.array_set('ids', var_assoc_args.array_get('ids'))
	}
	mut var_count := rt.call_method(var_fetcher, 'fetch_total_count', [
		var_filter_args.dup()])
	if rt.is_true(rt.identical(rt.new_int(0), var_count)) {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WP_CLI{}
			return temp.log(arg_0)
		}(rt.new_string('No products found or unable to fetch count.'))
	} else {
		mut var_filters := rt.new_array()
		if var_assoc_args.array_isset(rt.new_string('status')) {
			var_filters.array_push(rt.concat(rt.concat(rt.new_string("status '"),
				var_assoc_args.array_get('status')), rt.new_string("'")))
		}
		if var_assoc_args.array_isset(rt.new_string('product-type')) {
			var_filters.array_push(rt.concat(rt.concat(rt.new_string("type '"),
				var_assoc_args.array_get('product-type')), rt.new_string("'")))
		}
		if var_assoc_args.array_isset(rt.new_string('vendor')) {
			var_filters.array_push(rt.concat(rt.concat(rt.new_string("vendor '"),
				var_assoc_args.array_get('vendor')), rt.new_string("'")))
		}
		if var_assoc_args.array_isset(rt.new_string('ids')) {
			var_filters.array_push(rt.concat(rt.concat(rt.new_string("IDs '"),
				var_assoc_args.array_get('ids')), rt.new_string("'")))
		}
		mut var_filter_description := rt.new_string(if !rt.is_true(var_filters) {
			rt.new_string('')
		} else {
			' with ' + (rt.call_function('implode', [rt.new_string(', '), var_filters.dup()])).str()
		})
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WP_CLI{}
			return temp.success(arg_0)
		}(rt.new_string('Found ${var_count.to_string()} products${var_filter_description.to_string()} on ${var_platform_display_name.to_string()}.'))
	}
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_cli_migrator_commands_productscommand() &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ProductsCommand {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ProductsCommand{
		PhpObjectBase:       rt.PhpObjectBase{}
		credential_manager:  rt.new_null()
		platform_registry:   rt.new_null()
		products_controller: rt.new_null()
	}
	return obj
}

fn create_wp_cli() &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ProductsCommand) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'__invoke' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.magic_invoke(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'handle_count_request' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.handle_count_request(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ProductsCommand) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'credential_manager' { return this.credential_manager }
		'platform_registry' { return this.platform_registry }
		'products_controller' { return this.products_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_ProductsCommand) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'credential_manager' {
			this.credential_manager = val
			return true
		}
		'platform_registry' {
			this.platform_registry = val
			return true
		}
		'products_controller' {
			this.products_controller = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

pub fn init_wp_content_plugins_woocommerce_src_internal_cli_migrator_commands_productscommand_php() {
	// unsupported statement: Stmt_Declare
}
