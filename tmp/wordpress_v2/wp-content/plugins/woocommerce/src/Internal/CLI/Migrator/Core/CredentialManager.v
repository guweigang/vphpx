import rt

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager) get_credentials(platform_slug string) rt.PhpVal {
	mut var_option_name := rt.new_string('wc_migrator_credentials_${var_platform_slug}')
	mut var_credentials_json := rt.call_function('get_option', [
		var_option_name.clone(), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_credentials_json)))) {
		return rt.new_null()
	}
	mut var_credentials := rt.call_function('json_decode', [var_credentials_json.clone(),
		rt.new_bool(true)])
	return if var_credentials.clone().is_array() { var_credentials } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager) has_credentials(platform_slug string) bool {
	mut var_credentials := this.get_credentials(platform_slug)
	return !(!rt.is_true(var_credentials))
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager) prompt_for_credentials(mut var_fields Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_credentials := rt.new_array()
	mut iter_1 := var_fields.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_prompt := item_1.val
		mut var_key := item_1.key
		var_credentials.array_set(var_key, this.readline(var_prompt.str() + ' '))
	}
	return var_credentials.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager) save_credentials(platform_slug string, mut var_credentials Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_credentials_mutated := var_credentials
	mut var_option_name := rt.new_string('wc_migrator_credentials_${var_platform_slug}')
	rt.call_function('update_option', [var_option_name.clone(),
		rt.call_function('wp_json_encode', [var_credentials_mutated])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager) delete_credentials(platform_slug string) {
	mut var_option_name := rt.new_string('wc_migrator_credentials_${var_platform_slug}')
	rt.call_function('delete_option', [var_option_name.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager) setup_credentials(platform_slug string, mut var_required_fields Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	if !rt.is_true(var_required_fields) {
		mut iife_temp_0 := Class_WP_CLI{}
		mut iife_result_0 :=
			iife_temp_0.error(rt.new_string('No credential fields specified for setup.'))
		return
	}
	mut iife_temp_1 := Class_WP_CLI{}
	mut iife_result_1 := iife_temp_1.log(rt.new_string('Configuring credentials for ' +
		(rt.call_function('ucfirst', [rt.new_string(platform_slug)])).str() + '...'))
	mut var_credentials := this.prompt_for_credentials(mut var_required_fields)
	this.save_credentials(platform_slug, mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_credentials))
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager) readline(prompt string) string {
	if rt.is_true(rt.call_function('method_exists', [rt.new_string('WP_CLI'),
		rt.new_string('readline')]))
	{
		mut iife_temp_2 := Class_WP_CLI{}
		mut iife_result_2 := iife_temp_2.readline(rt.new_string(prompt))
		return iife_result_2.str()
	}
	mut iife_temp_3 := Class_WP_CLI{}
	mut iife_result_3 := iife_temp_3.line(rt.new_string(prompt))
	return rt.call_function('fgets', [rt.get_constant('STDIN')]).to_string().trim_space()
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_cli_migrator_core_credentialmanager(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli(_args ...rt.PhpVal) &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_credentials' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_credentials(dispatch_arg_0)
		}
		'has_credentials' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_credentials(dispatch_arg_0))
		}
		'prompt_for_credentials' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.prompt_for_credentials(mut dispatch_arg_0)
		}
		'save_credentials' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.save_credentials(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'delete_credentials' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.delete_credentials(dispatch_arg_0)
			return rt.new_null()
		}
		'setup_credentials' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.setup_credentials(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'readline' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.readline(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
