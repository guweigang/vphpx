import rt

pub fn init_wp_content_plugins_v_profiler_vhttpd_db_php() {
	// unsupported statement: Stmt_Declare
	rt.include_file(@DIR + '/v-profiler/vhttpd-db.php', '4')
}
