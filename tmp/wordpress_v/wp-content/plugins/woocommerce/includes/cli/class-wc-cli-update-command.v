import rt

struct Class_WC_CLI_Update_Command {
	rt.PhpObjectBase
}

fn Class_WC_CLI_Update_Command.register_commands() {
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_static', [
		Class_WP_CLI.class(),
		rt.new_string('add_command'),
		rt.new_string('wc update'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WC_CLI_Update_Command' },
			rt.ArrayItem{ key: none, val: 'update' }]),
	])
}

fn Class_WC_CLI_Update_Command.update() {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'hide_errors', []rt.PhpVal{})
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-install.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-update-functions.php', '2')
	mut var_current_db_version := rt.call_function('get_option', [
		rt.new_string('woocommerce_db_version'),
	])
	mut var_update_count := rt.new_int(rt.new_int(0))
	mut var_callbacks := fn () rt.PhpVal {
		mut temp := Class_WC_Install{}
		return temp.get_db_update_callbacks()
	}()
	mut var_callbacks_to_run := []rt.PhpVal{}
	{
		mut iter_1 := var_callbacks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_update_callbacks := item_1.val
			mut var_version := item_1.key
			if rt.is_true(rt.call_function('version_compare', [
				var_current_db_version.dup(), var_version.dup(),
				rt.new_string('<')]))
			{
				{
					mut iter_2 := var_update_callbacks.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_update_callback := item_2.val
						var_callbacks_to_run << var_update_callback.dup()
					}
				}
			}
		}
	}
	if !rt.is_true(var_callbacks_to_run) {
		fn () rt.PhpVal {
			mut temp := Class_WC_Install{}
			return temp.update_db_version()
		}()
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_static', [
			Class_WP_CLI.class(),
			rt.new_string('success'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('No updates required. Database version is %s'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('get_option', [
					rt.new_string('woocommerce_db_version'),
				]),
			]),
		])
		return rt.new_null()
	}
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_static', [
		Class_WP_CLI.class(),
		rt.new_string('log'),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Found %1$d updates (%2$s)'),
				rt.new_string('woocommerce')]),
			rt.new_int(var_callbacks_to_run.len),
			rt.call_function('implode', [rt.new_string(', '),
				var_callbacks_to_run.dup()]),
		]),
	])
	mut var_progress := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [
		rt.new_string('WP_CLI\\Utils\\make_progress_bar'),
		rt.call_function('__', [rt.new_string('Updating database'),
			rt.new_string('woocommerce')]),
		rt.new_int(var_callbacks_to_run.len),
	])
	for var_update_callback in var_callbacks_to_run {
		rt.call_function('call_user_func', [var_update_callback.dup()])
		rt.post_inc(var_update_count)
		rt.call_method(var_progress, 'tick', []rt.PhpVal{})
	}
	fn () rt.PhpVal {
		mut temp := Class_WC_Install{}
		return temp.update_db_version()
	}()
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
	fn () rt.PhpVal {
		mut temp := Class_WC_Install{}
		return temp.remove_update_db_notice()
	}()
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_static', [
		Class_WP_CLI.class(),
		rt.new_string('success'),
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('%1$d update functions completed. Database version is %2$s'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('absint', [
				var_update_count.dup(),
			]),
			rt.call_function('get_option', [
				rt.new_string('woocommerce_db_version'),
			]),
		]),
	])
}

struct Class_WC_Install {
	rt.PhpObjectBase
}

fn create_wc_cli_update_command() &Class_WC_CLI_Update_Command {
	mut obj := &Class_WC_CLI_Update_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_install() &Class_WC_Install {
	mut obj := &Class_WC_Install{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_CLI_Update_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_commands' {
			Class_WC_CLI_Update_Command.register_commands()
			return rt.new_null()
		}
		'update' {
			Class_WC_CLI_Update_Command.update()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_CLI_Update_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_CLI_Update_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Install) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Install) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Install) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_cli_class_wc_cli_update_command_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
