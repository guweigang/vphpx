import rt

pub fn Class_WC_CLI_COM_Command.application_password_section_url() string {
	return 'https://woocommerce.com/my-account/#application-passwords'
}
struct Class_WC_CLI_COM_Command {
	rt.PhpObjectBase
}

fn Class_WC_CLI_COM_Command.register_commands() {
mut iife_temp_0 := Class_WP_CLI{}
mut iife_result_0 := iife_temp_0.add_command(rt.new_string('wc com extension list'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_CLI_COM_Command' }, rt.ArrayItem{ key: none, val: 'list_extensions' }]))
mut iife_temp_1 := Class_WP_CLI{}
mut iife_result_1 := iife_temp_1.add_command(rt.new_string('wc com disconnect'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_CLI_COM_Command' }, rt.ArrayItem{ key: none, val: 'disconnect' }]))
mut iife_temp_2 := Class_WP_CLI{}
mut iife_result_2 := iife_temp_2.add_command(rt.new_string('wc com connect'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_CLI_COM_Command' }, rt.ArrayItem{ key: none, val: 'connect' }]))
}

fn Class_WC_CLI_COM_Command.list_extensions(mut var_args Class_array, mut var_assoc_args Class_array) {
	mut iife_temp_3 := Class_WC_Helper{}
	mut iife_result_3 := iife_temp_3.get_subscriptions()
	mut var_data := iife_result_3
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		var_data = rt.new_array()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	var_data = rt.call_function('array_values', [var_data.clone()])
	mut var_formatter := create_wp_cli_formatter(var_assoc_args, rt.create_array([rt.ArrayItem{ key: none, val: 'product_slug' }, rt.ArrayItem{ key: none, val: 'product_name' }, rt.ArrayItem{ key: none, val: 'auto_renew' }, rt.ArrayItem{ key: none, val: 'expires_on' }, rt.ArrayItem{ key: none, val: 'expired' }, rt.ArrayItem{ key: none, val: 'sites_max' }, rt.ArrayItem{ key: none, val: 'sites_active' }, rt.ArrayItem{ key: none, val: 'maxed' }]))
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_product_slug := rt.new_string('')
		mut var_product_url_parts := rt.call_function('explode', [rt.new_string('/'), var_item.array_get(rt.new_string('product_url'))])
		if var_product_url_parts.clone().array_count() > 2 {
		var_product_slug = var_product_url_parts.array_get(rt.new_int(var_product_url_parts.clone().array_count() - 2))
		}
		return
		}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_product_slug := rt.new_string('')
		mut var_product_url_parts := rt.call_function('explode', [rt.new_string('/'), var_item.array_get(rt.new_string('product_url'))])
		if var_product_url_parts.clone().array_count() > 2 {
		var_product_slug = var_product_url_parts.array_get(rt.new_int(var_product_url_parts.clone().array_count() - 2))
		}
		return
		}
	var_data = rt.call_function('array_map', [rt.new_closure(closure_5_fn), var_data.clone()])
	var_formatter.display_items(var_data.clone())
}

fn Class_WC_CLI_COM_Command.disconnect(mut var_args Class_array, mut var_assoc_args Class_array) {
	mut iife_temp_6 := Class_WC_Helper{}
	mut iife_result_6 := iife_temp_6.is_site_connected()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_6)))) {
	mut iife_temp_7 := Class_WP_CLI{}
	mut iife_result_7 := iife_temp_7.error(rt.call_function('__', [rt.new_string('Your store is not connected to WooCommerce.com. Run `wp wc com connect` command.'), rt.new_string('woocommerce')]))
	}
mut iife_temp_8 := Class_WP_CLI{}
mut iife_result_8 := iife_temp_8.confirm(rt.call_function('__', [rt.new_string('Are you sure you want to disconnect your store from WooCommerce.com?'), rt.new_string('woocommerce')]), rt.new_object('array', []string{}, var_assoc_args))
mut iife_temp_9 := Class_WC_Helper{}
mut iife_result_9 := iife_temp_9.disconnect()
mut iife_temp_10 := Class_WP_CLI{}
mut iife_result_10 := iife_temp_10.success(rt.call_function('__', [rt.new_string('You have successfully disconnected your store from WooCommerce.com'), rt.new_string('woocommerce')]))
}

fn Class_WC_CLI_COM_Command.connect(mut var_args Class_array, mut var_assoc_args Class_array) {
	mut var_password := rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args, rt.new_string('password')])
	mut var_force := rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args, rt.new_string('force'), rt.new_bool(false)])
	mut iife_temp_11 := Class_WC_Helper{}
	mut iife_result_11 := iife_temp_11.is_site_connected()
	if rt.is_true(iife_result_11) {
		if rt.is_true(var_force) {
		mut iife_temp_12 := Class_WC_Helper{}
		mut iife_result_12 := iife_temp_12.disconnect()
		} else {
			mut iife_temp_13 := Class_WP_CLI{}
			mut iife_result_13 := iife_temp_13.error(rt.call_function('__', [rt.new_string('Your store is already connected.'), rt.new_string('woocommerce')]))
			return
		}
	}
	if !rt.is_true(var_password) {
	mut iife_temp_14 := Class_WP_CLI{}
	mut iife_result_14 := iife_temp_14.log(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you don\'t have an application password (not your account password), generate a password from %s'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [rt.new_string(Class_WC_CLI_COM_Command.application_password_section_url())])]))
	var_password = Class_WC_CLI_COM_Command.ask(rt.call_function('__', [rt.new_string('Connection password:'), rt.new_string('woocommerce')]))
	}
	var_password = rt.call_function('sanitize_text_field', [var_password.clone()])
	if !rt.is_true(var_password) {
	mut iife_temp_15 := Class_WP_CLI{}
	mut iife_result_15 := iife_temp_15.error(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid password. Generate a new one from %s.'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [rt.new_string(Class_WC_CLI_COM_Command.application_password_section_url())])]))
	}
	mut iife_temp_16 := Class_WC_Helper{}
	mut iife_result_16 := iife_temp_16.connect_with_password(var_password.clone())
	mut var_auth := iife_result_16
	if rt.is_true(rt.call_function('is_wp_error', [var_auth.clone()])) {
	mut iife_temp_17 := Class_WP_CLI{}
	mut iife_result_17 := iife_temp_17.error(rt.call_method(var_auth, 'get_error_message', []rt.PhpVal{}))
	}
	mut iife_temp_18 := Class_WC_Helper{}
	mut iife_result_18 := iife_temp_18.is_site_connected()
	if rt.is_true(iife_result_18) {
	mut iife_temp_19 := Class_WP_CLI{}
	mut iife_result_19 := iife_temp_19.success(rt.call_function('__', [rt.new_string('Store connected successfully.'), rt.new_string('woocommerce')]))
	}
}

fn Class_WC_CLI_COM_Command.ask(var_question rt.PhpVal) string {
	rt.call_function('fwrite', [rt.get_constant('STDOUT'), rt.new_string((var_question).str() + ' ')])
	return rt.call_function('fgets', [rt.get_constant('STDIN')]).to_string().trim_space()
	return ''
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

struct Class_WP_CLI_Formatter {
	rt.PhpObjectBase
}

fn create_wc_cli_com_command(_args ...rt.PhpVal) &Class_WC_CLI_COM_Command {
	mut obj := &Class_WC_CLI_COM_Command{
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

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli_formatter(_args ...rt.PhpVal) &Class_WP_CLI_Formatter {
	mut obj := &Class_WP_CLI_Formatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_CLI_COM_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_commands' {
			Class_WC_CLI_COM_Command.register_commands()
			return rt.new_null()
		}
		'list_extensions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_WC_CLI_COM_Command.list_extensions(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'disconnect' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_WC_CLI_COM_Command.disconnect(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'connect' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_WC_CLI_COM_Command.connect(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'ask' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_CLI_COM_Command.ask(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WC_CLI_COM_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_CLI_COM_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_CLI_Formatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI_Formatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI_Formatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
}
