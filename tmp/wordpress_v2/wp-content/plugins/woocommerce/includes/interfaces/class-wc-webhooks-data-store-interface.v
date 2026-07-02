import rt

interface WC_Webhook_Data_Store_Interface {
	get_api_version_number(rt.PhpVal) rt.PhpVal
	get_webhooks_ids(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_api_version := rt.new_null()
	mut var_status := rt.new_null()
}
