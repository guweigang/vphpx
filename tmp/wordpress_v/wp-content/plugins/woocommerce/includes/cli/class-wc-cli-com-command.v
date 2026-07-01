import rt

pub fn Class_WC_CLI_COM_Command.application_password_section_url() string {
	return 'https://woocommerce.com/my-account/#application-passwords'
}
struct Class_WC_CLI_COM_Command {
	rt.PhpObjectBase
}

fn Class_WC_CLI_COM_Command.register_commands()  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string('wc com extension list'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_CLI_COM_Command' }, rt.ArrayItem{ key: none, val: 'list_extensions' }]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string('wc com disconnect'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_CLI_COM_Command' }, rt.ArrayItem{ key: none, val: 'disconnect' }]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string('wc com connect'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_CLI_COM_Command' }, rt.ArrayItem{ key: none, val: 'connect' }]))
}

fn Class_WC_CLI_COM_Command.list_extensions(mut var_args Class_array, mut var_assoc_args Class_array)  {
	mut var_data := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_subscriptions() }()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		var_data = rt.new_array()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	var_data = rt.call_function('array_values', [var_data.dup()])
	mut var_formatter := create_wp_cli_formatter(var_assoc_args.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'product_slug' }, rt.ArrayItem{ key: none, val: 'product_name' }, rt.ArrayItem{ key: none, val: 'auto_renew' }, rt.ArrayItem{ key: none, val: 'expires_on' }, rt.ArrayItem{ key: none, val: 'expired' }, rt.ArrayItem{ key: none, val: 'sites_max' }, rt.ArrayItem{ key: none, val: 'sites_active' }, rt.ArrayItem{ key: none, val: 'maxed' }]))
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_product_slug := rt.new_string(rt.new_string(''))
	mut var_product_url_parts := rt.call_function('explode', [rt.new_string('/'), var_item.array_get('product_url')])
	if var_product_url_parts.dup().array_count() > 2 {
		var_product_slug = var_product_url_parts.array_get(var_product_url_parts.dup().array_count() - 2)
	}
	return rt.create_array([rt.ArrayItem{ key: 'product_slug', val: var_product_slug }, rt.ArrayItem{ key: 'product_name', val: rt.call_function('htmlspecialchars_decode', [var_item.array_get('product_name')]) }, rt.ArrayItem{ key: 'auto_renew', val: if rt.is_true(var_item.array_get('autorenew')) { 'On' } else { 'Off' } }, rt.ArrayItem{ key: 'expires_on', val: rt.call_function('gmdate', [rt.new_string('Y-m-d'), var_item.array_get('expires')]) }, rt.ArrayItem{ key: 'expired', val: if rt.is_true(var_item.array_get('expired')) { 'Yes' } else { 'No' } }, rt.ArrayItem{ key: 'sites_max', val: var_item.array_get('sites_max') }, rt.ArrayItem{ key: 'sites_active', val: var_item.array_get('sites_active') }, rt.ArrayItem{ key: 'maxed', val: if rt.is_true(var_item.array_get('maxed')) { 'Yes' } else { 'No' } }])
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_product_slug := rt.new_string(rt.new_string(''))
	mut var_product_url_parts := rt.call_function('explode', [rt.new_string('/'), var_item.array_get('product_url')])
	if var_product_url_parts.dup().array_count() > 2 {
		var_product_slug = var_product_url_parts.array_get(var_product_url_parts.dup().array_count() - 2)
	}
	return rt.create_array([rt.ArrayItem{ key: 'product_slug', val: var_product_slug }, rt.ArrayItem{ key: 'product_name', val: rt.call_function('htmlspecialchars_decode', [var_item.array_get('product_name')]) }, rt.ArrayItem{ key: 'auto_renew', val: if rt.is_true(var_item.array_get('autorenew')) { 'On' } else { 'Off' } }, rt.ArrayItem{ key: 'expires_on', val: rt.call_function('gmdate', [rt.new_string('Y-m-d'), var_item.array_get('expires')]) }, rt.ArrayItem{ key: 'expired', val: if rt.is_true(var_item.array_get('expired')) { 'Yes' } else { 'No' } }, rt.ArrayItem{ key: 'sites_max', val: var_item.array_get('sites_max') }, rt.ArrayItem{ key: 'sites_active', val: var_item.array_get('sites_active') }, rt.ArrayItem{ key: 'maxed', val: if rt.is_true(var_item.array_get('maxed')) { 'Yes' } else { 'No' } }])
	}
	var_data = rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_data.dup()])
	var_formatter.display_items(var_data.dup())
}

fn Class_WC_CLI_COM_Command.disconnect(mut var_args Class_array, mut var_assoc_args Class_array)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.is_site_connected() }())))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.call_function('__', [rt.new_string('Your store is not connected to WooCommerce.com. Run `wp wc com connect` command.'), rt.new_string('woocommerce')]))
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.confirm(arg_0, arg_1) }(rt.call_function('__', [rt.new_string('Are you sure you want to disconnect your store from WooCommerce.com?'), rt.new_string('woocommerce')]), rt.new_object('array', []string{}, var_assoc_args))
	fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.disconnect() }()
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.call_function('__', [rt.new_string('You have successfully disconnected your store from WooCommerce.com'), rt.new_string('woocommerce')]))
}

fn Class_WC_CLI_COM_Command.connect(mut var_args Class_array, mut var_assoc_args Class_array)  {
	mut var_password := rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args, rt.new_string('password')])
	mut var_force := rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args, rt.new_string('force'), rt.new_bool(false)])
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.is_site_connected() }()) {
		if rt.is_true(var_force) {
			fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.disconnect() }()
		} else {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.call_function('__', [rt.new_string('Your store is already connected.'), rt.new_string('woocommerce')]))
			return rt.new_null()
		}
	}
	if !rt.is_true(var_password) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.log(arg_0) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you don\'t have an application password (not your account password), generate a password from %s'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [Class_WC_CLI_COM_Command.application_password_section_url()])]))
		var_password = Class_WC_CLI_COM_Command.ask(rt.call_function('__', [rt.new_string('Connection password:'), rt.new_string('woocommerce')]))
	}
	var_password = rt.call_function('sanitize_text_field', [var_password.dup()])
	if !rt.is_true(var_password) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid password. Generate a new one from %s.'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [Class_WC_CLI_COM_Command.application_password_section_url()])]))
	}
	mut var_auth := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.connect_with_password(arg_0) }(var_password.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_auth.dup()])) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.call_method(var_auth, 'get_error_message', []rt.PhpVal{}))
	}
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.is_site_connected() }()) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.call_function('__', [rt.new_string('Store connected successfully.'), rt.new_string('woocommerce')]))
	}
}

fn Class_WC_CLI_COM_Command.ask(var_question rt.PhpVal) string {
	rt.call_function('fwrite', [rt.get_constant('STDOUT'), (var_question).str() + ' '])
	return rt.call_function('fgets', [rt.get_constant('STDIN')]).to_string().trim_space()
	// unsupported statement: Stmt_Nop
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

fn create_wc_cli_com_command() &Class_WC_CLI_COM_Command {
	mut obj := &Class_WC_CLI_COM_Command{
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

fn create_wc_helper() &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli_formatter() &Class_WP_CLI_Formatter {
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




pub fn init_wp_content_plugins_woocommerce_includes_cli_class_wc_cli_com_command_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
