import rt

fn _get_list_table(var_class_name rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_GLOBALS := rt.new_null()
	mut var_core_classes := rt.create_array([
		rt.ArrayItem{ key: 'WP_Posts_List_Table', val: 'posts' },
		rt.ArrayItem{ key: 'WP_Media_List_Table', val: 'media' },
		rt.ArrayItem{ key: 'WP_Terms_List_Table', val: 'terms' },
		rt.ArrayItem{ key: 'WP_Users_List_Table', val: 'users' },
		rt.ArrayItem{ key: 'WP_Comments_List_Table', val: 'comments' },
		rt.ArrayItem{ key: 'WP_Post_Comments_List_Table', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'comments' },
			rt.ArrayItem{ key: none, val: 'post-comments' },
		]) },
		rt.ArrayItem{ key: 'WP_Links_List_Table', val: 'links' },
		rt.ArrayItem{ key: 'WP_Plugin_Install_List_Table', val: 'plugin-install' },
		rt.ArrayItem{ key: 'WP_Themes_List_Table', val: 'themes' },
		rt.ArrayItem{ key: 'WP_Theme_Install_List_Table', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'themes' },
			rt.ArrayItem{ key: none, val: 'theme-install' },
		]) },
		rt.ArrayItem{ key: 'WP_Plugins_List_Table', val: 'plugins' },
		rt.ArrayItem{ key: 'WP_Application_Passwords_List_Table', val: 'application-passwords' },
		rt.ArrayItem{ key: 'WP_MS_Sites_List_Table', val: 'ms-sites' },
		rt.ArrayItem{ key: 'WP_MS_Users_List_Table', val: 'ms-users' },
		rt.ArrayItem{ key: 'WP_MS_Themes_List_Table', val: 'ms-themes' },
		rt.ArrayItem{
			key: 'WP_Privacy_Data_Export_Requests_List_Table'
			val: 'privacy-data-export-requests'
		},
		rt.ArrayItem{
			key: 'WP_Privacy_Data_Removal_Requests_List_Table'
			val: 'privacy-data-removal-requests'
		},
	])
	if var_core_classes.array_isset(var_class_name) {
		{
			mut iter_1 := rt.cast_array(var_core_classes.array_get(var_class_name)).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_required := item_1.val
				rt.include_file(
					(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-' + var_required.str() +
					'-list-table.php', '4')
			}
		}
		if var_args.array_isset(rt.new_string('screen')) {
			var_args.array_set('screen', rt.call_function('convert_to_screen', [
				var_args.array_get('screen'),
			]))
		} else if var_GLOBALS.array_isset(rt.new_string('hook_suffix')) {
			var_args.array_set('screen', rt.call_function('get_current_screen', []rt.PhpVal{}))
		} else {
			var_args.array_set('screen', rt.new_null())
		}
		mut var_custom_class_name := rt.call_function('apply_filters', [
			rt.new_string('wp_list_table_class_name'),
			var_class_name.dup(),
			var_args.dup(),
		])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_custom_class_name.dup().is_string()))
			&& rt.is_true(rt.call_function('class_exists', [var_custom_class_name.dup()]))))
		{
			var_class_name = var_custom_class_name.dup()
		}
		return (rt.create_object_dynamically(var_class_name, [
			var_args.dup()])).to_bool()
	}
	return false
}

fn register_column_headers(var_screen rt.PhpVal, var_columns rt.PhpVal) {
	create__wp_list_table_compat(var_screen.dup(), var_columns.dup())
}

fn print_column_headers(var_screen rt.PhpVal, with_id bool) {
	mut var_wp_list_table := create__wp_list_table_compat(var_screen.dup())
	var_wp_list_table.print_column_headers(rt.new_bool(with_id))
}

struct Class__WP_List_Table_Compat {
	rt.PhpObjectBase
}

fn create__wp_list_table_compat() &Class__WP_List_Table_Compat {
	mut obj := &Class__WP_List_Table_Compat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class__WP_List_Table_Compat) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class__WP_List_Table_Compat) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class__WP_List_Table_Compat) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('_WP_List_Table_Compat', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create__wp_list_table_compat()
		return rt.new_object('_WP_List_Table_Compat', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

pub fn init_wp_admin_includes_list_table_php() {
}
