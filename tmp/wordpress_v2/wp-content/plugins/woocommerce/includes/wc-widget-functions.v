import rt

fn wc_register_widgets() {
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Cart')])
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Layered_Nav_Filters')])
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Layered_Nav')])
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Price_Filter')])
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Product_Categories')])
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Product_Search')])
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Product_Tag_Cloud')])
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Products')])
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Recently_Viewed')])
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_enable_reviews'),
		rt.new_string('yes'),
	])))
	{
		rt.call_function('register_widget', [
			rt.new_string('WC_Widget_Top_Rated_Products'),
		])
		rt.call_function('register_widget', [rt.new_string('WC_Widget_Recent_Reviews')])
		rt.call_function('register_widget', [rt.new_string('WC_Widget_Rating_Filter')])
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/abstracts/abstract-wc-widget.php', '4')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/widgets/class-wc-widget-cart.php', '4')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/widgets/class-wc-widget-layered-nav-filters.php', '4')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/widgets/class-wc-widget-layered-nav.php', '4')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/widgets/class-wc-widget-price-filter.php', '4')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/widgets/class-wc-widget-product-categories.php', '4')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/widgets/class-wc-widget-product-search.php', '4')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/widgets/class-wc-widget-product-tag-cloud.php', '4')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/widgets/class-wc-widget-products.php', '4')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/widgets/class-wc-widget-rating-filter.php', '4')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/widgets/class-wc-widget-recent-reviews.php', '4')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/widgets/class-wc-widget-recently-viewed.php', '4')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/widgets/class-wc-widget-top-rated-products.php', '4')
	rt.call_function('add_action', [rt.new_string('widgets_init'),
		rt.new_string('wc_register_widgets')])
}
