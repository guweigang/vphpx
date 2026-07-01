import rt

struct Class_WP_Site_Health {
	rt.PhpObjectBase
}

struct Class_WP_Debug_Data {
	rt.PhpObjectBase
}

fn create_wp_site_health() &Class_WP_Site_Health {
	mut obj := &Class_WP_Site_Health{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_debug_data() &Class_WP_Debug_Data {
	mut obj := &Class_WP_Debug_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Site_Health) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Site_Health) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Site_Health) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Debug_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Debug_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Debug_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Debug_Data'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-debug-data.php', '4')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Site_Health'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-site-health.php', '4')
	}
	mut var_health_check_site_status := fn () rt.PhpVal {
		mut temp := Class_WP_Site_Health{}
		return temp.get_instance()
	}()
	rt.call_function('wp_admin_notice', [
		rt.call_function('__', [
			rt.new_string('The Site Health check requires JavaScript.'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'hide-if-js' },
			]) },
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	fn () rt.PhpVal {
		mut temp := Class_WP_Debug_Data{}
		return temp.check_for_updates()
	}()
	mut var_info := fn () rt.PhpVal {
		mut temp := Class_WP_Debug_Data{}
		return temp.debug_data()
	}()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Site Health Info')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('This page can show you every detail about the configuration of your WordPress website. For any improvements that could be made, see the <a href="%s">Site Health Status</a> page.'),
		]),
		rt.call_function('esc_url', [
			rt.call_function('admin_url', [rt.new_string('site-health.php')]),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('If you want to export a handy list of all the information on this page, you can use the button below to copy it to the clipboard. You can then paste it in a text file and save it to your device, or paste it in an email exchange with a support engineer or theme/plugin developer for example.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_Debug_Data{}
		return temp.format(arg_0, arg_1)
	}(var_info.dup(), rt.new_string('debug'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Copy site info to clipboard')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Copied!')])
	// unsupported statement: Stmt_InlineHTML
	mut var_sizes_fields := ['uploads_size', 'themes_size', 'plugins_size', 'fonts_size',
		'wordpress_size', 'database_size', 'total_size']
	{
		mut iter_1 := var_info.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_details := item_1.val
			mut var_section := item_1.key
			if !(var_details.array_isset(rt.new_string('fields')))
				|| !rt.is_true(var_details.array_get('fields')) {
				continue
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_section.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_section.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_details.array_get('label')]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(var_details.array_isset(rt.new_string('show_count'))
				&& rt.is_true(var_details.array_get('show_count'))))
			{
				rt.call_function('printf', [rt.new_string('(%s)'),
					rt.call_function('number_format_i18n', [
						rt.new_int(var_details.array_get('fields').array_count()),
					])])
			}
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.identical(rt.new_string('wp-paths-sizes'), var_section)) {
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_section.dup()]))
			// unsupported statement: Stmt_InlineHTML
			if var_details.array_isset(rt.new_string('description'))
				&& !(!rt.is_true(var_details.array_get('description'))) {
				rt.call_function('printf', [rt.new_string('<p>%s</p>'),
					var_details.array_get('description')])
			}
			// unsupported statement: Stmt_InlineHTML
			{
				mut iter_2 := var_details.array_get('fields').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_field := item_2.val
					mut var_field_name := item_2.key
					if rt.is_true(rt.new_bool(var_field.array_get('value').is_array())) {
						mut var_values := rt.new_string(rt.new_string('<ul>'))
						{
							mut iter_3 := var_field.array_get('value').iterator()
							for {
								item_3 := iter_3.next() or { break }
								mut var_value := item_3.val
								mut var_name := item_3.key
								// unsupported expression: Expr_AssignOp_Concat
							}
						}
						// unsupported expression: Expr_AssignOp_Concat
					} else {
						var_values = rt.call_function('esc_html', [
							var_field.array_get('value')])
					}
					if rt.is_true(rt.call_function('in_array', [
						var_field_name.dup(), var_sizes_fields.dup(),
						rt.new_bool(true)]))
					{
						rt.call_function('printf', [
							rt.new_string('<tr><th scope="row">%s</th><td class="%s">%s</td></tr>'),
							rt.call_function('esc_html', [var_field.array_get('label')]),
							rt.call_function('esc_attr', [var_field_name.dup()]),
							var_values.dup(),
						])
					} else {
						rt.call_function('printf', [
							rt.new_string('<tr><th scope="row">%s</th><td>%s</td></tr>'),
							rt.call_function('esc_html', [var_field.array_get('label')]),
							var_values.dup(),
						])
					}
				}
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
}
