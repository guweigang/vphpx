import rt

struct Class_WC_Settings_General {
	rt.PhpObjectBase
pub mut:
	icon rt.PhpVal = rt.new_string('cog')
}

fn (mut this Class_WC_Settings_General) construct() {
	this.dispatch_set_prop('id', rt.new_string('general'))
	this.dispatch_set_prop('label', rt.call_function('__', [rt.new_string('General'),
		rt.new_string('woocommerce')]))
	this.Class_WC_Settings_Page.construct()
}

fn (mut this Class_WC_Settings_General) get_settings_for_default_section() rt.PhpVal {
	mut var_currency_code_options := rt.call_function('get_woocommerce_currencies', []rt.PhpVal{})
	mut iter_1 := var_currency_code_options.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_name := item_1.val
		mut var_code := item_1.key
		var_currency_code_options.array_set(var_code, var_name.str() +
			' (' + (rt.call_function('get_woocommerce_currency_symbol', [var_code.clone()])).str() +
			') — ' + (rt.call_function('esc_html', [var_code.clone()])).str())
	}
	mut var_address_autocomplete_preferred_provider_setting := rt.new_array()
	mut var_address_autocomplete_setting_desc_tip := rt.call_function('__', [
		rt.new_string('Suggest full addresses to customers as they type.'),
		rt.new_string('woocommerce'),
	])
	mut var_address_provider_class := rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController.class(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_address_autocomplete_providers := rt.call_method(var_address_provider_class,
		'get_providers', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_address_autocomplete_available :=
		rt.new_bool(!(!rt.is_true(var_address_autocomplete_providers)))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_address_autocomplete_available)))) {
		var_address_autocomplete_setting_desc_tip = rt.concat(var_address_autocomplete_setting_desc_tip, rt.new_string(
			' ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Requires a plugin with predictive address search support (e.g. <a href="%s" target="_blank">WooPayments</a>).'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/products/woocommerce-payments/')])).str()))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_enable_address_autocomplete_setting := rt.create_array([
		rt.ArrayItem{ key: 'id', val: 'woocommerce_address_autocomplete_enabled' },
		rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
			rt.new_string('Enable predictive address search'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Address autocomplete'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'checkbox' },
		rt.ArrayItem{ key: 'disabled', val: !(rt.is_true(var_address_autocomplete_available)) },
		rt.ArrayItem{ key: 'desc_tip', val: var_address_autocomplete_setting_desc_tip },
		rt.ArrayItem{ key: 'default', val: 'no' },
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_address_autocomplete_available)))) {
		var_enable_address_autocomplete_setting.array_set('value', false)
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if var_address_autocomplete_providers.clone().array_count() > 1 {
		mut var_address_provider_options := rt.new_array()
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut iter_2 := var_address_autocomplete_providers.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_address_provider := item_2.val
			var_address_provider_options.array_set(rt.get_property(var_address_provider, 'id'), rt.call_function('sanitize_text_field', [
				rt.get_property(var_address_provider, 'name'),
			]))
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_address_autocomplete_preferred_provider_setting = rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce_address_autocomplete_provider' },
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Preferred address autocomplete provider'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{
				key: 'default'
				val: if !(rt.get_property(var_address_autocomplete_providers.array_get(rt.new_int(0)), 'id')).is_null() {
					rt.get_property(var_address_autocomplete_providers.array_get(rt.new_int(0)), 'id')
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{ key: 'options', val: var_address_provider_options },
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'log', [
			rt.new_string('error'),
			rt.new_string('Error getting address provider class: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
		])
		var_enable_address_autocomplete_setting = rt.new_array()
		var_address_autocomplete_preferred_provider_setting = rt.new_array()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	mut var_settings := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Store Address'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This is where your business is located. Tax rates and shipping rates will use this address.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'store_address' },
			rt.ArrayItem{ key: 'order', val: 10 },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Address line 1'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('The street address for your business location.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_store_address' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Address line 2'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('An additional, optional address line for your business location.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_store_address_2' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('City'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('The city in which your business is located.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_store_city' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Country / State'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('The country and state or province, if any, in which your business is located.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_default_country' },
			rt.ArrayItem{ key: 'default', val: 'US:CA' },
			rt.ArrayItem{ key: 'type', val: 'single_select_country' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Postcode / ZIP'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('The postal code, if any, in which your business is located.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_store_postcode' },
			rt.ArrayItem{ key: 'css', val: 'min-width:50px;' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'store_address' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('General options'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'desc', val: '' },
			rt.ArrayItem{ key: 'id', val: 'general_options' },
			rt.ArrayItem{ key: 'order', val: 20 },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Selling location(s)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This option lets you limit which countries you are willing to sell to.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_allowed_countries' },
			rt.ArrayItem{ key: 'default', val: 'all' },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'css', val: 'min-width: 350px;' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'all', val: rt.call_function('__', [
					rt.new_string('Sell to all countries'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'all_except', val: rt.call_function('__', [
					rt.new_string('Sell to all countries, except for&hellip;'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'specific', val: rt.call_function('__', [
					rt.new_string('Sell to specific countries'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Sell to all countries, except for&hellip;'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: '' },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_all_except_countries' },
			rt.ArrayItem{ key: 'css', val: 'min-width: 350px;' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'type', val: 'multi_select_countries' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Sell to specific countries'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: '' },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_specific_allowed_countries' },
			rt.ArrayItem{ key: 'css', val: 'min-width: 350px;' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'type', val: 'multi_select_countries' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Shipping location(s)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Choose which countries you want to ship to, or choose to ship to all locations you sell to.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_ship_to_countries' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: '', val: rt.call_function('__', [
					rt.new_string('Ship to all countries you sell to'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'all', val: rt.call_function('__', [
					rt.new_string('Ship to all countries'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'specific', val: rt.call_function('__', [
					rt.new_string('Ship to specific countries only'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'disabled', val: rt.call_function('__', [
					rt.new_string('Disable shipping &amp; shipping calculations'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Ship to specific countries'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: '' },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_specific_ship_to_countries' },
			rt.ArrayItem{ key: 'css', val: '' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'type', val: 'multi_select_countries' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Default customer location'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_default_customer_address' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('This option determines a customers default location. The MaxMind GeoLite Database will be periodically downloaded to your wp-content directory if using geolocation.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{
				key: 'default'
				val: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.base()
			},
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{
					key: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.no_default()
					val: rt.call_function('__', [
						rt.new_string('No location by default'),
						rt.new_string('woocommerce'),
					])
				},
				rt.ArrayItem{
					key: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.base()
					val: rt.call_function('__', [
						rt.new_string('Shop country/region'),
						rt.new_string('woocommerce'),
					])
				},
				rt.ArrayItem{
					key: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation()
					val: rt.call_function('__', [
						rt.new_string('Geolocate'),
						rt.new_string('woocommerce'),
					])
				},
				rt.ArrayItem{
					key: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation_ajax()
					val: rt.call_function('__', [
						rt.new_string('Geolocate (with page caching support)'),
						rt.new_string('woocommerce'),
					])
				},
			]) },
		]) },
		rt.ArrayItem{ key: none, val: var_enable_address_autocomplete_setting },
		rt.ArrayItem{ key: none, val: var_address_autocomplete_preferred_provider_setting },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'general_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Taxes and coupons'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Enable taxes and coupons and configure how they are calculated.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'taxes_and_coupons_options' },
			rt.ArrayItem{ key: 'order', val: 30 },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Enable taxes'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Enable tax rates and calculations'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_calc_taxes' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Rates will be configurable and taxes will be calculated during checkout.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Enable coupons'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Enable the use of coupon codes'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_enable_coupons' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
			rt.ArrayItem{ key: 'show_if_checked', val: 'option' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Coupons can be applied from the cart and checkout pages.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Calculate coupon discounts sequentially'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_calc_discounts_sequentially' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('When applying multiple coupons, apply the first coupon to the full price and the second coupon to the discounted price and so on.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'show_if_checked', val: 'yes' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'end' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'taxes_and_coupons_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Currency options'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('The following options affect how prices are displayed on the frontend.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'pricing_options' },
			rt.ArrayItem{ key: 'order', val: 40 },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Currency'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This controls what currency prices are listed at in the catalog and which currency gateways will take payments in.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_currency' },
			rt.ArrayItem{ key: 'default', val: 'USD' },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'options', val: var_currency_code_options },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Currency position'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This controls the position of the currency symbol.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_currency_pos' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'default', val: 'left' },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'left', val: rt.call_function('__', [
					rt.new_string('Left'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'right', val: rt.call_function('__', [
					rt.new_string('Right'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'left_space', val: rt.call_function('__', [
					rt.new_string('Left with space'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'right_space', val: rt.call_function('__', [
					rt.new_string('Right with space'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Thousand separator'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This sets the thousand separator of displayed prices.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_price_thousand_sep' },
			rt.ArrayItem{ key: 'css', val: 'width:50px;' },
			rt.ArrayItem{ key: 'default', val: ',' },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Decimal separator'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This sets the decimal separator of displayed prices.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_price_decimal_sep' },
			rt.ArrayItem{ key: 'css', val: 'width:50px;' },
			rt.ArrayItem{ key: 'default', val: '.' },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Number of decimals'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This sets the number of decimal points shown in displayed prices.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_price_num_decimals' },
			rt.ArrayItem{ key: 'css', val: 'width:50px;' },
			rt.ArrayItem{ key: 'default', val: '2' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'min', val: 0 },
				rt.ArrayItem{ key: 'step', val: 1 },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'pricing_options' },
		]) },
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_setting := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(!rt.is_true(var_setting)))
	}
	var_settings = rt.call_function('array_filter', [var_settings.clone(),
		rt.new_closure(closure_1_fn)])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_general_settings'),
		var_settings.clone(),
	])
}

fn (mut this Class_WC_Settings_General) color_picker(var_name rt.PhpVal, var_id rt.PhpVal, var_value rt.PhpVal, desc string) {
	print('<div class="color_box">' +
		(rt.call_function('wc_help_tip', [rt.new_string(desc)])).str() + '\n\t\t\t<input name="' +
		(rt.call_function('esc_attr', [var_id.clone()])).str() + '" id="' +
		(rt.call_function('esc_attr', [var_id.clone()])).str() + '" type="text" value="' +
		(rt.call_function('esc_attr', [var_value.clone()])).str() +
		'" class="colorpick" /> <div id="colorPickerDiv_' +
		(rt.call_function('esc_attr', [var_id.clone()])).str() +
		'" class="colorpickdiv"></div>\n\t\t</div>')
}

fn (mut this Class_WC_Settings_General) output() {
	this.Class_WC_Settings_Page.output()
	mut var_handle := rt.new_string('wc-admin-settings-general')
	rt.call_function('wp_register_script', [var_handle.clone(),
		rt.new_string(''), rt.new_array(), rt.get_constant('WC_VERSION'),
		rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }])])
	rt.call_function('wp_enqueue_script', [var_handle.clone()])
	rt.call_function('wp_add_inline_script', [var_handle.clone(),
		rt.new_string("\n\t\t\tconst preferredProviderInput = document.querySelector( '#woocommerce_address_autocomplete_provider' );\n\t\t\tconst autocompleteEnabledInput = document.querySelector( '#woocommerce_address_autocomplete_enabled' );\n\t\t\tlet preferredProviderRow = null;\n\t\t\tif ( preferredProviderInput ) {\n\t\t\t\tpreferredProviderRow = preferredProviderInput.closest( 'tr' );\n\t\t\t}\n\t\t\tif ( autocompleteEnabledInput && preferredProviderRow ) {\n\t\t\t\tif ( ! autocompleteEnabledInput.checked ) {\n\t\t\t\t\tpreferredProviderRow.style.display = 'none';\n\t\t\t\t}\n\t\t\t\tautocompleteEnabledInput.addEventListener( 'change', function( e ) {\n\t\t\t\t\tif ( e.target.checked ) {\n\t\t\t\t\t\tpreferredProviderRow.style.display = 'table-row';\n\t\t\t\t\t} else {\n\t\t\t\t\t\tpreferredProviderRow.style.display = 'none';\n\t\t\t\t\t}\n\t\t\t\t} );\n\t\t\t}\n\t\t\t")])
}

struct Class_WC_Settings_Page {
	rt.PhpObjectBase
}

fn create_wc_settings_general() &Class_WC_Settings_General {
	mut obj := &Class_WC_Settings_General{
		PhpObjectBase: rt.PhpObjectBase{}
		icon:          rt.new_string('cog')
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

fn (mut this Class_WC_Settings_General) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_settings_for_default_section' {
			return this.get_settings_for_default_section()
		}
		'color_picker' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.color_picker(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'output' {
			this.output()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Settings_General) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'icon' { return this.icon }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Settings_General) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('\\Automattic\\WooCommerce\\Enums\\DefaultCustomerAddress'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file((rt.call_function('dirname', [rt.get_constant('WC_PLUGIN_FILE')])).str() +
			'/src/Enums/DefaultCustomerAddress.php', '4')
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Settings_General'),
		rt.new_bool(false)]))
	{
		return rt.new_object('WC_Settings_General', ['WC_Settings_Page'],
			create_wc_settings_general())
	}
	return rt.new_object('WC_Settings_General', ['WC_Settings_Page'], create_wc_settings_general())
}
