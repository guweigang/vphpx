import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_UNINSTALL_PLUGIN'),
	])))))
	{
		exit(0)
	}
	mut var_contentDir := if rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_CONTENT_DIR'),
	]))
	{ rt.get_constant('WP_CONTENT_DIR') } else { (rt.get_constant('ABSPATH')).str() + 'wp-content' }
	if rt.is_true(rt.call_function('is_dir', [var_contentDir.clone()])) {
		mut var_dbFile := rt.new_string(var_contentDir.str() + '/db.php')
		if rt.is_true(rt.call_function('file_exists', [var_dbFile.clone()])) {
			mut var_dbContent := rt.call_function('file_get_contents', [
				var_dbFile.clone()])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_dbContent, rt.new_bool(false)))))
				&& rt.is_true(rt.call_function('str_contains', [var_dbContent.clone(), rt.new_string('Wpdb')])) {
				rt.call_function('unlink', [var_dbFile.clone()])
			}
		}
		mut var_ocFile := rt.new_string(var_contentDir.str() + '/object-cache.php')
		if rt.is_true(rt.call_function('file_exists', [var_ocFile.clone()])) {
			mut var_ocContent := rt.call_function('file_get_contents', [
				var_ocFile.clone()])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_ocContent, rt.new_bool(false)))))
				&& rt.is_true(rt.call_function('str_contains', [var_ocContent.clone(), rt.new_string('ObjectCache')])) {
				rt.call_function('unlink', [var_ocFile.clone()])
			}
		}
		mut var_modeFile := rt.new_string(var_contentDir.str() + '/.v-profiler-mode')
		if rt.is_true(rt.call_function('file_exists', [var_modeFile.clone()])) {
			rt.call_function('unlink', [var_modeFile.clone()])
		}
	}
}
