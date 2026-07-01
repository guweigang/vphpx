import rt

pub fn init_wp_content_mu_plugins_v_profiler_loader_php() {
	// unsupported statement: Stmt_Declare
	mut var_vProfilerEntry := rt.new_string(
		(rt.call_function('dirname', [rt.new_string(@DIR)])).str() +
		'/plugins/v-profiler/v-profiler.php')
	if rt.is_true(rt.call_function('file_exists', [var_vProfilerEntry.dup()])) {
		rt.include_file(var_vProfilerEntry.to_string(), '4')
	}
}
