import rt



pub fn init_wp_content_plugins_v_profiler_uninstall_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_UNINSTALL_PLUGIN')]))))) {
		// unsupported expression: Expr_Exit
	}
	mut var_contentDir := if rt.is_true(rt.call_function('defined', [rt.new_string('WP_CONTENT_DIR')])) { rt.get_constant('WP_CONTENT_DIR') } else { (rt.get_constant('ABSPATH')).str() + 'wp-content' }
	if rt.is_true(rt.call_function('is_dir', [var_contentDir.dup()])) {
		mut var_dbFile := rt.new_string((var_contentDir).str() + '/db.php')
		if rt.is_true(rt.call_function('file_exists', [var_dbFile.dup()])) {
			mut var_dbContent := rt.call_function('file_get_contents', [var_dbFile.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('str_contains', [var_dbContent.dup(), rt.new_string('Wpdb')])))) {
				rt.call_function('unlink', [var_dbFile.dup()])
			}
		}
		mut var_ocFile := rt.new_string((var_contentDir).str() + '/object-cache.php')
		if rt.is_true(rt.call_function('file_exists', [var_ocFile.dup()])) {
			mut var_ocContent := rt.call_function('file_get_contents', [var_ocFile.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('str_contains', [var_ocContent.dup(), rt.new_string('ObjectCache')])))) {
				rt.call_function('unlink', [var_ocFile.dup()])
			}
		}
		mut var_modeFile := rt.new_string((var_contentDir).str() + '/.v-profiler-mode')
		if rt.is_true(rt.call_function('file_exists', [var_modeFile.dup()])) {
			rt.call_function('unlink', [var_modeFile.dup()])
		}
	}
}
