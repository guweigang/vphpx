import rt

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_SetupCommand {
	rt.PhpObjectBase
pub mut:
	credential_manager rt.PhpVal = rt.new_null()
	platform_registry  rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_SetupCommand) init(mut var_credential_manager Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager, mut var_platform_registry Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry) {
	this.credential_manager = var_credential_manager
	this.platform_registry = var_platform_registry
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_SetupCommand) magic_invoke(mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_array) {
	mut var_platform := rt.call_method(this.platform_registry, 'resolve_platform', [
		var_assoc_args,
	])
	mut var_platform_display_name := rt.call_method(this.platform_registry,
		'get_platform_display_name', [var_platform.clone()])
	mut var_required_fields := rt.call_method(this.platform_registry,
		'get_platform_credential_fields', [var_platform.clone()])
	if !rt.is_true(var_required_fields) {
		mut iife_temp_0 := Class_WP_CLI{}
		mut iife_result_0 :=
			iife_temp_0.error(rt.new_string("The platform '${var_platform_display_name.to_string()}' does not have configured credential fields."))
	}
	rt.call_method(this.credential_manager, 'setup_credentials', [
		var_platform.clone(), var_required_fields.clone()])
	mut iife_temp_1 := Class_WP_CLI{}
	mut iife_result_1 := iife_temp_1.success(rt.new_string('Credentials saved successfully.'))
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_cli_migrator_commands_setupcommand(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_SetupCommand {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_SetupCommand{
		PhpObjectBase:      rt.PhpObjectBase{}
		credential_manager: rt.new_null()
		platform_registry:  rt.new_null()
	}
	return obj
}

fn create_wp_cli(_args ...rt.PhpVal) &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_SetupCommand) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_SetupCommand) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'credential_manager' { return this.credential_manager }
		'platform_registry' { return this.platform_registry }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Commands_SetupCommand) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'credential_manager' {
			this.credential_manager = val
			return true
		}
		'platform_registry' {
			this.platform_registry = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}
