import rt

struct Class_Akismet_Compatible_Plugins {
	rt.PhpObjectBase
}

fn create_akismet_compatible_plugins(_args ...rt.PhpVal) &Class_Akismet_Compatible_Plugins {
	mut obj := &Class_Akismet_Compatible_Plugins{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet_Compatible_Plugins) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet_Compatible_Plugins) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Compatible_Plugins) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_bypass_cache := !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('akismet_refresh_compatible_plugins'))))
	mut iife_temp_0 := Class_Akismet_Compatible_Plugins{}
	mut iife_result_0 := iife_temp_0.get_installed_compatible_plugins(rt.new_bool(var_bypass_cache))
	mut var_compatible_plugins := iife_result_0
	if rt.is_true(rt.new_bool(var_compatible_plugins.clone().is_array())) {
		mut var_compatible_plugin_count := var_compatible_plugins.clone().array_count()
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Compatible plugins'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		print('<p>')
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('__', [
				rt.new_string('Akismet works with other plugins to keep spam away.'),
				rt.new_string('akismet'),
			]),
		]))
		print('</p>')
		print('<p>')
		if 0 == var_compatible_plugin_count {
			print('<a class="akismet-external-link" href="https://akismet.com/developers/plugins-and-libraries/?utm_source=akismet_plugin&amp;utm_campaign=plugin_static_link&amp;utm_medium=in_plugin&amp;utm_content=compatible_plugins">')
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('__', [rt.new_string('See supported integrations'),
					rt.new_string('akismet')]),
			]))
			print('</a>')
		} else {
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('_n', [
					rt.new_string("This plugin you've installed is compatible. Follow the documentation link to get started."),
					rt.new_string("These plugins you've installed are compatible. Follow the documentation links to get started."),
					rt.new_int(var_compatible_plugin_count).clone(),
					rt.new_string('akismet'),
				]),
			]))
		}
		print('</p>')
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_compatible_plugins)) {
			// unsupported statement: Stmt_InlineHTML
			mut iter_1 := var_compatible_plugins.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_compatible_plugin := item_1.val
				if !rt.is_true(var_compatible_plugin.array_get(rt.new_string('help_url'))) {
					continue
				}
				// unsupported statement: Stmt_InlineHTML
				if var_compatible_plugin.array_get(rt.new_string('logo')).to_string().len > 0 {
					// unsupported statement: Stmt_InlineHTML
					mut var_logo_alt := rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('%s logo'),
							rt.new_string('akismet')]),
						var_compatible_plugin.array_get(rt.new_string('name')),
					])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_url', [
						var_compatible_plugin.array_get(rt.new_string('logo')),
					]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						var_logo_alt.clone()]))
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					var_compatible_plugin.array_get(rt.new_string('name')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [
					var_compatible_plugin.array_get(rt.new_string('help_url')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('Documentation for %s'),
							rt.new_string('akismet')]),
						var_compatible_plugin.array_get(rt.new_string('name')),
					]),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('View documentation'),
					rt.new_string('akismet')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.greater(rt.new_int(var_compatible_plugin_count),
				Class_Akismet_Compatible_Plugins.default_visible_plugin_count()))
			{
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('Show all %d plugins'),
							rt.new_string('akismet')]),
						rt.new_int(var_compatible_plugin_count).clone(),
					]),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					rt.call_function('__', [rt.new_string('Show less'),
						rt.new_string('akismet')]),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('Show all %d plugins'),
							rt.new_string('akismet')]),
						rt.new_int(var_compatible_plugin_count).clone(),
					]),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
}
