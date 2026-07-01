import rt

interface FeedInterface {
	start() rt.PhpVal
	add_entry(rt.PhpVal) rt.PhpVal
	end() rt.PhpVal
	get_file_path() rt.PhpVal
	get_file_url() rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_src_internal_productfeed_feed_feedinterface_php() {
	mut var_entry := rt.new_null()
	// unsupported statement: Stmt_Declare
}
