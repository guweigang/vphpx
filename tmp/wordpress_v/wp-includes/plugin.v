module wp_includes

import rt

fn add_filter(var_hook_name rt.PhpVal, var_callback rt.PhpVal, priority i64, accepted_args i64) bool {
	mut var_priority := priority
	mut var_accepted_args := accepted_args
	mut var_wp_filter := rt.new_null()
	if !(var_wp_filter.array_isset(var_hook_name)) {
		var_wp_filter.array_set(var_hook_name, create_wp_hook())
	}
	rt.call_method(var_wp_filter.array_get(var_hook_name), 'add_filter', [
		var_hook_name.clone(), var_callback.clone(), rt.new_int(priority),
		rt.new_int(accepted_args)])
	return true
}

fn apply_filters(var_hook_name rt.PhpVal, var_value rt.PhpVal, var_args_origin ...rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_wp_filter := rt.new_null()
	mut var_wp_filters := rt.new_null()
	mut var_wp_current_filter := []rt.PhpVal{}
	mut var_all_args := rt.new_null()
	mut var_filtered := rt.new_null()
	if !(var_wp_filters.array_isset(var_hook_name)) {
		var_wp_filters.array_set(var_hook_name, 1)
	} else {
		rt.pre_inc(var_wp_filters.array_get(var_hook_name))
	}
	if var_wp_filter.array_isset(rt.new_string('all')) {
		var_wp_current_filter << var_hook_name.clone()
		var_all_args = rt.call_function('func_get_args', []rt.PhpVal{})
		_wp_call_all_hook(var_all_args.clone())
	}
	if !(var_wp_filter.array_isset(var_hook_name)) {
		if var_wp_filter.array_isset(rt.new_string('all')) {
			rt.call_function('array_pop', [
				rt.create_array_from_list(var_wp_current_filter),
			])
		}
		return var_value.clone()
	}
	if !(var_wp_filter.array_isset(rt.new_string('all'))) {
		var_wp_current_filter << var_hook_name.clone()
	}
	rt.call_function('array_unshift', [rt.create_array_from_list(var_args),
		var_value.clone()])
	var_filtered = rt.call_method(var_wp_filter.array_get(var_hook_name), 'apply_filters', [
		var_value.clone(),
		rt.create_array_from_list(var_args),
	])
	rt.call_function('array_pop', [rt.create_array_from_list(var_wp_current_filter)])
	return var_filtered.clone()
}

fn apply_filters_ref_array(var_hook_name rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_wp_filter := rt.new_null()
	mut var_wp_filters := rt.new_null()
	mut var_wp_current_filter := []rt.PhpVal{}
	mut var_all_args := rt.new_null()
	mut var_filtered := rt.new_null()
	if !(var_wp_filters.array_isset(var_hook_name)) {
		var_wp_filters.array_set(var_hook_name, 1)
	} else {
		rt.pre_inc(var_wp_filters.array_get(var_hook_name))
	}
	if var_wp_filter.array_isset(rt.new_string('all')) {
		var_wp_current_filter << var_hook_name.clone()
		var_all_args = rt.call_function('func_get_args', []rt.PhpVal{})
		_wp_call_all_hook(var_all_args.clone())
	}
	if !(var_wp_filter.array_isset(var_hook_name)) {
		if var_wp_filter.array_isset(rt.new_string('all')) {
			rt.call_function('array_pop', [
				rt.create_array_from_list(var_wp_current_filter),
			])
		}
		return var_args.array_get(0)
	}
	if !(var_wp_filter.array_isset(rt.new_string('all'))) {
		var_wp_current_filter << var_hook_name.clone()
	}
	var_filtered = rt.call_method(var_wp_filter.array_get(var_hook_name), 'apply_filters', [
		var_args.array_get(0),
		rt.create_array_from_list(var_args),
	])
	rt.call_function('array_pop', [rt.create_array_from_list(var_wp_current_filter)])
	return var_filtered.clone()
}

fn has_filter(var_hook_name rt.PhpVal, callback bool, priority bool) bool {
	mut var_callback := callback
	mut var_priority := priority
	mut var_wp_filter := rt.new_null()
	if !(var_wp_filter.array_isset(var_hook_name)) {
		return false
	}
	return (rt.call_method(var_wp_filter.array_get(var_hook_name), 'has_filter', [
		var_hook_name.clone(),
		rt.new_bool(callback),
		rt.new_bool(priority),
	])).to_bool()
}

fn remove_filter(var_hook_name rt.PhpVal, var_callback rt.PhpVal, priority i64) rt.PhpVal {
	mut var_priority := priority
	mut var_wp_filter := rt.new_null()
	mut var_r := rt.new_null()
	var_r = rt.new_bool(false)
	if var_wp_filter.array_isset(var_hook_name) {
		var_r = rt.call_method(var_wp_filter.array_get(var_hook_name), 'remove_filter', [
			var_hook_name.clone(),
			var_callback.clone(),
			rt.new_int(priority),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_wp_filter.array_get(var_hook_name),
			'callbacks')))))
		{
			var_wp_filter.array_unset(var_hook_name)
		}
	}
	return var_r.clone()
}

fn remove_all_filters(var_hook_name rt.PhpVal, priority bool) bool {
	mut var_priority := priority
	mut var_wp_filter := rt.new_null()
	if var_wp_filter.array_isset(var_hook_name) {
		rt.call_method(var_wp_filter.array_get(var_hook_name), 'remove_all_filters', [
			rt.new_bool(priority),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filter.array_get(var_hook_name),
			'has_filters', []rt.PhpVal{})))))
		{
			var_wp_filter.array_unset(var_hook_name)
		}
	}
	return true
}

fn current_filter() rt.PhpVal {
	mut var_wp_current_filter := []rt.PhpVal{}
	return rt.call_function('end', [rt.create_array_from_list(var_wp_current_filter)])
}

fn doing_filter(var_hook_name rt.PhpVal) bool {
	mut var_wp_current_filter := []rt.PhpVal{}
	if rt.is_true(rt.identical(rt.new_null(), var_hook_name)) {
		return !(!rt.is_true(var_wp_current_filter))
	}
	return (rt.call_function('in_array', [var_hook_name.clone(),
		rt.create_array_from_list(var_wp_current_filter), rt.new_bool(true)])).to_bool()
}

fn did_filter(var_hook_name rt.PhpVal) i64 {
	mut var_wp_filters := rt.new_null()
	if !(var_wp_filters.array_isset(var_hook_name)) {
		return 0
	}
	return (var_wp_filters.array_get(var_hook_name)).to_i64()
}

fn add_action(var_hook_name rt.PhpVal, var_callback rt.PhpVal, priority i64, accepted_args i64) bool {
	mut var_priority := priority
	mut var_accepted_args := accepted_args
	return add_filter(var_hook_name.clone(), var_callback.clone(), priority, accepted_args)
}

fn do_action(var_hook_name rt.PhpVal, var_arg_origin ...rt.PhpVal) {
	mut var_arg := rt.create_array_from_list(var_arg_origin)
	mut var_wp_filter := rt.new_null()
	mut var_wp_actions := rt.new_null()
	mut var_wp_current_filter := []rt.PhpVal{}
	mut var_all_args := rt.new_null()
	if !(var_wp_actions.array_isset(var_hook_name)) {
		var_wp_actions.array_set(var_hook_name, 1)
	} else {
		rt.pre_inc(var_wp_actions.array_get(var_hook_name))
	}
	if var_wp_filter.array_isset(rt.new_string('all')) {
		var_wp_current_filter << var_hook_name.clone()
		var_all_args = rt.call_function('func_get_args', []rt.PhpVal{})
		_wp_call_all_hook(var_all_args.clone())
	}
	if !(var_wp_filter.array_isset(var_hook_name)) {
		if var_wp_filter.array_isset(rt.new_string('all')) {
			rt.call_function('array_pop', [
				rt.create_array_from_list(var_wp_current_filter),
			])
		}
		return
	}
	if !(var_wp_filter.array_isset(rt.new_string('all'))) {
		var_wp_current_filter << var_hook_name.clone()
	}
	if !rt.is_true(var_arg) {
		var_arg << rt.new_string('')
	} else if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_arg.array_get(0).is_array()))
		&& 1 == var_arg.array_get(0).array_count()))
		&& var_arg.array_get(0).array_isset(rt.new_int(0))))
		&& rt.is_true(rt.new_bool(var_arg.array_get(0).array_get(0).is_object()))))
	{
		var_arg[0] = var_arg.array_get(0).array_get(0)
	}
	rt.call_method(var_wp_filter.array_get(var_hook_name), 'do_action', [
		rt.create_array_from_list(var_arg),
	])
	rt.call_function('array_pop', [rt.create_array_from_list(var_wp_current_filter)])
}

fn do_action_ref_array(var_hook_name rt.PhpVal, var_args rt.PhpVal) {
	mut var_wp_filter := rt.new_null()
	mut var_wp_actions := rt.new_null()
	mut var_wp_current_filter := []rt.PhpVal{}
	mut var_all_args := rt.new_null()
	if !(var_wp_actions.array_isset(var_hook_name)) {
		var_wp_actions.array_set(var_hook_name, 1)
	} else {
		rt.pre_inc(var_wp_actions.array_get(var_hook_name))
	}
	if var_wp_filter.array_isset(rt.new_string('all')) {
		var_wp_current_filter << var_hook_name.clone()
		var_all_args = rt.call_function('func_get_args', []rt.PhpVal{})
		_wp_call_all_hook(var_all_args.clone())
	}
	if !(var_wp_filter.array_isset(var_hook_name)) {
		if var_wp_filter.array_isset(rt.new_string('all')) {
			rt.call_function('array_pop', [
				rt.create_array_from_list(var_wp_current_filter),
			])
		}
		return
	}
	if !(var_wp_filter.array_isset(rt.new_string('all'))) {
		var_wp_current_filter << var_hook_name.clone()
	}
	rt.call_method(var_wp_filter.array_get(var_hook_name), 'do_action', [
		rt.create_array_from_list(var_args),
	])
	rt.call_function('array_pop', [rt.create_array_from_list(var_wp_current_filter)])
}

fn has_action(var_hook_name rt.PhpVal, callback bool, priority bool) bool {
	mut var_callback := callback
	mut var_priority := priority
	return has_filter(var_hook_name.clone(), callback, priority)
}

fn remove_action(var_hook_name rt.PhpVal, var_callback rt.PhpVal, priority i64) rt.PhpVal {
	mut var_priority := priority
	return remove_filter(var_hook_name.clone(), var_callback.clone(), priority)
}

fn remove_all_actions(var_hook_name rt.PhpVal, priority bool) bool {
	mut var_priority := priority
	return remove_all_filters(var_hook_name.clone(), priority)
}

fn current_action() rt.PhpVal {
	return current_filter()
}

fn doing_action(var_hook_name rt.PhpVal) bool {
	return doing_filter(var_hook_name.clone())
}

fn did_action(var_hook_name rt.PhpVal) i64 {
	mut var_wp_actions := rt.new_null()
	if !(var_wp_actions.array_isset(var_hook_name)) {
		return 0
	}
	return (var_wp_actions.array_get(var_hook_name)).to_i64()
}

fn apply_filters_deprecated(var_hook_name rt.PhpVal, var_args rt.PhpVal, var_version rt.PhpVal, replacement string, message string) rt.PhpVal {
	mut var_replacement := replacement
	mut var_message := message
	if !(has_filter(var_hook_name.clone())) {
		return var_args.array_get(0)
	}
	rt.call_function('_deprecated_hook', [var_hook_name.clone(),
		var_version.clone(), rt.new_string(replacement), rt.new_string(message)])
	return apply_filters_ref_array(var_hook_name.clone(), rt.create_array_from_list(var_args))
}

fn do_action_deprecated(var_hook_name rt.PhpVal, var_args rt.PhpVal, var_version rt.PhpVal, replacement string, message string) {
	mut var_replacement := replacement
	mut var_message := message
	if !(has_action(var_hook_name.clone())) {
		return
	}
	rt.call_function('_deprecated_hook', [var_hook_name.clone(),
		var_version.clone(), rt.new_string(replacement), rt.new_string(message)])
	do_action_ref_array(var_hook_name.clone(), rt.create_array_from_list(var_args))
}

fn plugin_basename(var_file_arg rt.PhpVal) rt.PhpVal {
	mut var_file := var_file_arg
	mut var_wp_plugin_paths := rt.new_null()
	mut var_realdir := rt.new_null()
	mut var_dir := rt.new_null()
	mut var_plugin_dir := rt.new_null()
	mut var_mu_plugin_dir := rt.new_null()
	var_file = rt.call_function('wp_normalize_path', [var_file.clone()])
	rt.call_function('arsort', [var_wp_plugin_paths.clone()])
	{
		mut iter_1 := var_wp_plugin_paths.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_realdir_shadow := item_1.val
			mut var_dir_shadow := item_1.key
			if rt.is_true(rt.call_function('str_starts_with', [
				var_file.clone(), var_realdir_shadow.clone()]))
			{
				var_file =
					rt.new_string(var_dir_shadow.str() +(rt.call_function('substr', [var_file.clone(), rt.new_int(var_realdir_shadow.clone().to_string().len)])).str())
			}
		}
	}
	var_plugin_dir = rt.call_function('wp_normalize_path', [
		rt.get_constant('WP_PLUGIN_DIR'),
	])
	var_mu_plugin_dir = rt.call_function('wp_normalize_path', [
		rt.get_constant('WPMU_PLUGIN_DIR'),
	])
	var_file = rt.call_function('preg_replace', [
		rt.new_string('#^' +
			(rt.call_function('preg_quote', [var_plugin_dir.clone(), rt.new_string('#')])).str() +
			'/|^' +
			(rt.call_function('preg_quote', [var_mu_plugin_dir.clone(), rt.new_string('#')])).str() +
			'/#'),
		rt.new_string(''),
		var_file.clone(),
	])
	var_file = rt.new_string(var_file.clone().to_string().trim_space())
	return var_file.clone()
}

fn wp_register_plugin_realpath(var_file rt.PhpVal) bool {
	mut var_wp_plugin_paths := rt.new_null()
	mut var_wp_plugin_path := rt.new_null()
	mut var_wpmu_plugin_path := rt.new_null()
	mut var_plugin_path := rt.new_null()
	mut var_plugin_realpath := rt.new_null()
	if !(!var_wp_plugin_path.is_null()) {
		var_wp_plugin_path = rt.call_function('wp_normalize_path', [
			rt.get_constant('WP_PLUGIN_DIR'),
		])
		var_wpmu_plugin_path = rt.call_function('wp_normalize_path', [
			rt.get_constant('WPMU_PLUGIN_DIR'),
		])
	}
	var_plugin_path = rt.call_function('wp_normalize_path', [
		rt.call_function('dirname', [var_file.clone()]),
	])
	var_plugin_realpath = rt.call_function('wp_normalize_path', [
		rt.call_function('dirname', [rt.call_function('realpath', [
			var_file.clone()])]),
	])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_plugin_path, var_wp_plugin_path))
		|| rt.is_true(rt.identical(var_plugin_path, var_wpmu_plugin_path))))
	{
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_plugin_path, var_plugin_realpath)))) {
		var_wp_plugin_paths.array_set(var_plugin_path, var_plugin_realpath.clone())
	}
	return true
}

fn plugin_dir_path(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('trailingslashit', [
		rt.call_function('dirname', [var_file.clone()]),
	])
}

fn plugin_dir_url(var_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('trailingslashit', [
		rt.call_function('plugins_url', [rt.new_string(''), var_file.clone()]),
	])
}

fn register_activation_hook(var_file_arg rt.PhpVal, var_callback rt.PhpVal) {
	mut var_file := var_file_arg
	var_file = plugin_basename(var_file.clone())
	rt.new_bool(add_action(rt.new_string('activate_' + var_file.str()), var_callback.clone(), 0, 0))
}

fn register_deactivation_hook(var_file_arg rt.PhpVal, var_callback rt.PhpVal) {
	mut var_file := var_file_arg
	var_file = plugin_basename(var_file.clone())
	rt.new_bool(add_action(rt.new_string('deactivate_' + var_file.str()), var_callback.clone(), 0,
		0))
}

fn register_uninstall_hook(var_file rt.PhpVal, var_callback rt.PhpVal) {
	mut var_uninstallable_plugins := rt.new_null()
	mut var_plugin_basename := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_callback.clone().is_array()))
		&& rt.is_true(rt.new_bool(var_callback.array_get(0).is_object()))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Only a static class method or function can be used in an uninstall hook.'),
			]),
			rt.new_string('3.1.0')])
		return
	}
	var_uninstallable_plugins = rt.cast_array(rt.call_function('get_option', [
		rt.new_string('uninstall_plugins'),
	]))
	var_plugin_basename = plugin_basename(var_file.clone())
	if rt.is_true(rt.new_bool(!(var_uninstallable_plugins.array_isset(var_plugin_basename))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_uninstallable_plugins.array_get(var_plugin_basename), var_callback))))))
	{
		var_uninstallable_plugins.array_set(var_plugin_basename, var_callback.clone())
		rt.call_function('update_option', [rt.new_string('uninstall_plugins'),
			var_uninstallable_plugins.clone()])
	}
}

fn _wp_call_all_hook(var_args rt.PhpVal) {
	mut var_wp_filter := rt.new_null()
	rt.call_method(var_wp_filter.array_get('all'), 'do_all_hook', [
		rt.create_array_from_list(var_args),
	])
}

fn _wp_filter_build_unique_id(var_hook_name rt.PhpVal, var_callback_arg rt.PhpVal, var_priority rt.PhpVal) rt.PhpVal {
	mut var_callback := var_callback_arg
	if rt.is_true(rt.new_bool(var_callback.clone().is_string())) {
		return var_callback.clone()
	}
	if rt.is_true(rt.new_bool(var_callback.clone().is_object())) {
		var_callback = rt.create_array([rt.ArrayItem{ key: none, val: var_callback },
			rt.ArrayItem{ key: none, val: '' }])
	} else {
		var_callback = rt.cast_array(var_callback)
	}
	if rt.is_true(rt.new_bool(var_callback.array_get(0).is_object())) {
		return rt.new_string(
			(rt.call_function('spl_object_hash', [var_callback.array_get(0)])).str() +
			(var_callback.array_get(1)).str())
	} else if rt.is_true(rt.new_bool(var_callback.array_get(0).is_string())) {
		return rt.new_string(
			(var_callback.array_get(0)).str() + '::' + (var_callback.array_get(1)).str())
	}
	return rt.new_null()
}

struct Class_WP_Hook {
	rt.PhpObjectBase
}

fn create_wp_hook() &Class_WP_Hook {
	mut obj := &Class_WP_Hook{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Hook) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Hook) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Hook) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_plugin_php() {
	rt.include_file(@DIR + '/class-wp-hook.php', '3')
	mut var_wp_filter := rt.get_superglobal('wp_filter')
	mut var_wp_actions := rt.get_superglobal('wp_actions')
	mut var_wp_filters := rt.get_superglobal('wp_filters')
	mut var_wp_current_filter := rt.get_superglobal('wp_current_filter')
	if rt.is_true(var_wp_filter) {
		var_wp_filter = fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WP_Hook{}
			return temp.build_preinitialized_hooks(arg_0)
		}(var_wp_filter.clone())
	} else {
		var_wp_filter = rt.new_array()
	}
	if !(!var_wp_actions.is_null()) {
		var_wp_actions = rt.new_array()
	}
	if !(!var_wp_filters.is_null()) {
		var_wp_filters = rt.new_array()
	}
	if !(!var_wp_current_filter.is_null()) {
		var_wp_current_filter = rt.new_array()
	}
}
