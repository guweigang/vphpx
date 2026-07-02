import rt

struct Class_WC_Settings_Products {
	rt.PhpObjectBase
pub mut:
	icon rt.PhpVal = rt.new_string('box')
}

fn (mut this Class_WC_Settings_Products) construct() {
	this.dispatch_set_prop('id', rt.new_string('products'))
	this.dispatch_set_prop('label', rt.call_function('__', [rt.new_string('Products'),
		rt.new_string('woocommerce')]))
	this.Class_WC_Settings_Page.construct()
}

fn (mut this Class_WC_Settings_Products) get_own_sections() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('General'),
			rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'inventory', val: rt.call_function('__', [
			rt.new_string('Inventory'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'downloadable', val: rt.call_function('__', [
			rt.new_string('Downloadable products'), rt.new_string('woocommerce')]) },
	])
}

fn (mut this Class_WC_Settings_Products) get_settings_for_default_section() rt.PhpVal {
	mut var_locale_info := rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/i18n/locale-info.php', '1')
	mut var_default_weight_unit :=
		var_locale_info.array_get(rt.new_string('US')).array_get(rt.new_string('weight_unit'))
	mut var_default_dimension_unit :=
		var_locale_info.array_get(rt.new_string('US')).array_get(rt.new_string('dimension_unit'))
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_0 := iife_temp_0.get_weight_unit_label(rt.new_string('kg'))
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_1 := iife_temp_1.get_weight_unit_label(rt.new_string('g'))
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_2 := iife_temp_2.get_weight_unit_label(rt.new_string('lbs'))
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_3 := iife_temp_3.get_weight_unit_label(rt.new_string('oz'))
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_4 := iife_temp_4.get_dimensions_unit_label(rt.new_string('m'))
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_5 := iife_temp_5.get_dimensions_unit_label(rt.new_string('cm'))
	mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_6 := iife_temp_6.get_dimensions_unit_label(rt.new_string('mm'))
	mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_7 := iife_temp_7.get_dimensions_unit_label(rt.new_string('in'))
	mut iife_temp_8 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_8 := iife_temp_8.get_dimensions_unit_label(rt.new_string('yd'))
	mut var_settings := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Shop pages'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'desc', val: '' },
			rt.ArrayItem{ key: 'id', val: 'catalog_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Shop page'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The base page can also be used in your <a href="%s">product permalinks</a>.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('admin_url', [
					rt.new_string('options-permalink.php'),
				]),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_shop_page_id' },
			rt.ArrayItem{ key: 'type', val: 'single_select_page' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select-nostd' },
			rt.ArrayItem{ key: 'css', val: 'min-width:300px;' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('This sets the base page of your shop - this is where your product archive will be.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Add to cart behaviour'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Redirect to the cart page after successful addition'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_cart_redirect_after_add' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Enable AJAX add to cart buttons on archives'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_enable_ajax_add_to_cart' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'end' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Placeholder image'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_placeholder_image' },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'class', val: '' },
			rt.ArrayItem{ key: 'css', val: '' },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('Enter attachment ID or URL to an image'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('This is the attachment ID, or image URL, used for placeholder images in the product catalog. Products with no image will use this.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'catalog_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Measurements'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'id', val: 'product_measurement_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Weight unit'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This controls what unit you will define weights in.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_weight_unit' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'css', val: 'min-width:300px;' },
			rt.ArrayItem{ key: 'default', val: var_default_weight_unit },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'kg', val: iife_result_0 },
				rt.ArrayItem{ key: 'g', val: iife_result_1 },
				rt.ArrayItem{ key: 'lbs', val: iife_result_2 },
				rt.ArrayItem{ key: 'oz', val: iife_result_3 },
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Dimensions unit'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This controls what unit you will define lengths in.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_dimension_unit' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'css', val: 'min-width:300px;' },
			rt.ArrayItem{ key: 'default', val: var_default_dimension_unit },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'm', val: iife_result_4 },
				rt.ArrayItem{ key: 'cm', val: iife_result_5 },
				rt.ArrayItem{ key: 'mm', val: iife_result_6 },
				rt.ArrayItem{ key: 'in', val: iife_result_7 },
				rt.ArrayItem{ key: 'yd', val: iife_result_8 },
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'product_measurement_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Reviews'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'desc', val: '' },
			rt.ArrayItem{ key: 'id', val: 'product_rating_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Enable reviews'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Enable product reviews'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_enable_reviews' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
			rt.ArrayItem{ key: 'show_if_checked', val: 'option' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Show "verified owner" label on customer reviews'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_review_rating_verification_label' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: '' },
			rt.ArrayItem{ key: 'show_if_checked', val: 'yes' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Reviews can only be left by "verified owners"'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_review_rating_verification_required' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'end' },
			rt.ArrayItem{ key: 'show_if_checked', val: 'yes' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Product ratings'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Enable star rating on reviews'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_enable_review_rating' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
			rt.ArrayItem{ key: 'show_if_checked', val: 'option' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Star ratings should be required, not optional'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_review_rating_required' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'end' },
			rt.ArrayItem{ key: 'show_if_checked', val: 'yes' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'product_rating_options' },
		]) },
	])
	var_settings = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_products_general_settings'),
		var_settings.clone(),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_settings'),
		var_settings.clone(),
	])
}

fn (mut this Class_WC_Settings_Products) get_settings_for_inventory_section() rt.PhpVal {
	mut var_settings := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Inventory'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'desc', val: '' },
			rt.ArrayItem{ key: 'id', val: 'product_inventory_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Manage stock'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Enable stock management'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_manage_stock' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Hold stock (minutes)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Hold stock (for unpaid orders) for x minutes. When this limit is reached, the pending order will be cancelled. Leave blank to disable.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_hold_stock_minutes' },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'min', val: 0 },
				rt.ArrayItem{ key: 'step', val: 1 },
			]) },
			rt.ArrayItem{ key: 'css', val: 'width: 80px;' },
			rt.ArrayItem{ key: 'default', val: '60' },
			rt.ArrayItem{ key: 'autoload', val: false },
			rt.ArrayItem{ key: 'class', val: 'manage_stock_field' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Notifications'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Enable low stock notifications'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_notify_low_stock' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
			rt.ArrayItem{ key: 'autoload', val: false },
			rt.ArrayItem{ key: 'class', val: 'manage_stock_field' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Enable out of stock notifications'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_notify_no_stock' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'end' },
			rt.ArrayItem{ key: 'autoload', val: false },
			rt.ArrayItem{ key: 'class', val: 'manage_stock_field' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Notification recipient(s)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Enter recipients (comma separated) that will receive this notification.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_stock_email_recipient' },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'default', val: rt.call_function('get_option', [
				rt.new_string('admin_email'),
			]) },
			rt.ArrayItem{ key: 'css', val: 'width: 250px;' },
			rt.ArrayItem{ key: 'autoload', val: false },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'class', val: 'manage_stock_field' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Low stock threshold'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('When product stock reaches this amount you will be notified via email.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_notify_low_stock_amount' },
			rt.ArrayItem{ key: 'css', val: 'width:50px;' },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'min', val: 0 },
				rt.ArrayItem{ key: 'step', val: 1 },
			]) },
			rt.ArrayItem{ key: 'default', val: '2' },
			rt.ArrayItem{ key: 'autoload', val: false },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'class', val: 'manage_stock_field' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Out of stock threshold'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('When product stock reaches this amount the stock status will change to "out of stock" and you will be notified via email. This setting does not affect existing "in stock" products.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_notify_no_stock_amount' },
			rt.ArrayItem{ key: 'css', val: 'width:50px;' },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'min', val: 0 },
				rt.ArrayItem{ key: 'step', val: 1 },
			]) },
			rt.ArrayItem{ key: 'default', val: '0' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'class', val: 'manage_stock_field' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Out of stock visibility'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Hide out of stock items from the catalog'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_hide_out_of_stock_items' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Stock display format'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This controls how stock quantities are displayed on the frontend.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_stock_format' },
			rt.ArrayItem{ key: 'css', val: 'min-width:150px;' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: '', val: rt.call_function('__', [
					rt.new_string('Always show quantity remaining in stock e.g. "12 in stock"'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'low_amount', val: rt.call_function('__', [
					rt.new_string('Only show quantity remaining in stock when low e.g. "Only 2 left in stock"'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'no_amount', val: rt.call_function('__', [
					rt.new_string('Never show quantity remaining in stock'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'product_inventory_options' },
		]) },
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_inventory_settings'),
		var_settings.clone(),
	])
}

fn (mut this Class_WC_Settings_Products) get_settings_for_downloadable_section() rt.PhpVal {
	mut var_settings := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Downloadable products'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'id', val: 'digital_download_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('File download method'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Forcing downloads will keep URLs hidden, but some servers may serve large files unreliably. If supported, %1$s / %2$s can be used to serve downloads instead (server requires %3$s).'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('<code>X-Accel-Redirect</code>'),
				rt.new_string('<code>X-Sendfile</code>'),
				rt.new_string('<code>mod_xsendfile</code>'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_file_download_method' },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'css', val: 'min-width:300px;' },
			rt.ArrayItem{ key: 'default', val: 'force' },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string("If you are using X-Accel-Redirect download method along with NGINX server, make sure that you have applied settings as described in <a href='%s'>Digital/Downloadable Product Handling</a> guide."),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('https://woocommerce.com/document/digital-downloadable-product-handling#nginx-setting'),
			]) },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'force', val: rt.call_function('__', [
					rt.new_string('Force downloads'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'xsendfile', val: rt.call_function('__', [
					rt.new_string('X-Accel-Redirect/X-Sendfile'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{
					key: 'redirect'
					val: if rt.is_true(rt.call_function('apply_filters', [
						rt.new_string('woocommerce_redirect_only_method_is_secure'),
						rt.new_bool(false),
					]))
					{ rt.call_function('__', [
							rt.new_string('Redirect only'),
							rt.new_string('woocommerce'),
						]) } else { rt.call_function('__', [
							rt.new_string('Redirect only (Insecure)'),
							rt.new_string('woocommerce'),
						]) }
				},
			]) },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Allow using redirect mode (insecure) as a last resort'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_downloads_redirect_fallback_allowed' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('If the "Force Downloads" or "X-Accel-Redirect/X-Sendfile" download method is selected but does not work, the system will use the "Redirect" method as a last resort. <a href="%1$s">See this guide</a> for more details.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('https://woocommerce.com/document/digital-downloadable-product-handling/'),
			]) },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Access restriction'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Downloads require login'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_downloads_require_login' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('This setting does not apply to guest purchases.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Grant access to downloadable products after payment'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_downloads_grant_access_after_payment' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Enable this option to grant access to downloads when orders are "processing", rather than "completed".'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'end' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Open in browser'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Open downloadable files in the browser, instead of saving them to the device.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_downloads_deliver_inline' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'default', val: false },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Customers can still save the file to their device, but by default file will be opened instead of being downloaded (does not work with redirects).'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Filename'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Append a unique string to filename for security'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_downloads_add_hash_to_filename' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string("Not required if your download directory is protected. <a href='%s'>See this guide</a> for more details. Files already uploaded will not be affected."),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('https://woocommerce.com/document/digital-downloadable-product-handling#unique-string'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Count partial downloads'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Count downloads even if only part of a file is fetched.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_downloads_count_partial' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Repeat fetches made within a reasonable window of time (by default, 30 minutes) will not be counted twice. This is a generally reasonably way to enforce download limits in relation to ranged requests. %1$sLearn more.%2$s'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('<a href="https://woocommerce.com/document/digital-downloadable-product-handling/">'),
				rt.new_string('</a>'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'digital_download_options' },
		]) },
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_downloadable_products_settings'),
		var_settings.clone(),
	])
}

fn (mut this Class_WC_Settings_Products) save() {
	this.save_settings_for_current_section()
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [
		rt.new_string('wc_recount_all_terms'),
		rt.new_bool(false),
	])
	this.do_update_options_action()
}

struct Class_WC_Settings_Page {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_I18nUtil {
	rt.PhpObjectBase
}

fn create_wc_settings_products() &Class_WC_Settings_Products {
	mut obj := &Class_WC_Settings_Products{
		PhpObjectBase: rt.PhpObjectBase{}
		icon:          rt.new_string('box')
	}
	obj.construct()
	return obj
}

fn create_wc_settings_page(_args ...rt.PhpVal) &Class_WC_Settings_Page {
	mut obj := &Class_WC_Settings_Page{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_i18nutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_I18nUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_I18nUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Settings_Products) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_own_sections' {
			return this.get_own_sections()
		}
		'get_settings_for_default_section' {
			return this.get_settings_for_default_section()
		}
		'get_settings_for_inventory_section' {
			return this.get_settings_for_inventory_section()
		}
		'get_settings_for_downloadable_section' {
			return this.get_settings_for_downloadable_section()
		}
		'save' {
			this.save()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Settings_Products) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'icon' { return this.icon }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Settings_Products) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'icon' {
			this.icon = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Settings_Page) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Settings_Page) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_Page) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Settings_Products'),
		rt.new_bool(false),
	]))
	{
		return rt.new_object('WC_Settings_Products', ['WC_Settings_Page'],
			create_wc_settings_products())
	}
	return rt.new_object('WC_Settings_Products', ['WC_Settings_Page'],
		create_wc_settings_products())
}
