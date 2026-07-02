import rt

interface MarketingChannelInterface {
	get_slug() rt.PhpVal
	get_name() rt.PhpVal
	get_description() rt.PhpVal
	get_icon_url() rt.PhpVal
	is_setup_completed() rt.PhpVal
	get_setup_url() rt.PhpVal
	get_product_listings_status() rt.PhpVal
	get_errors_count() rt.PhpVal
	get_supported_campaign_types() rt.PhpVal
	get_campaigns() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
