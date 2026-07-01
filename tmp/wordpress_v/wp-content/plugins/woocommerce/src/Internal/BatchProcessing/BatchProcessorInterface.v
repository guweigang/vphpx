import rt

interface BatchProcessorInterface {
	get_name() rt.PhpVal
	get_description() rt.PhpVal
	get_total_pending_count() rt.PhpVal
	get_next_batch_to_process(rt.PhpVal) rt.PhpVal
	process_batch(rt.PhpVal) rt.PhpVal
	get_default_batch_size() rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_src_internal_batchprocessing_batchprocessorinterface_php() {
	mut var_size := rt.new_null()
	mut var_batch := rt.new_null()
}
