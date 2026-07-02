import rt

struct Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners.get_all() rt.PhpVal {
	mut var_asset_base_url := rt.new_string(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
		'/assets/images/shipping_partners/')
	mut var_column_layout_features := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'icon', val: var_asset_base_url.str() + 'timer.svg' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Save time'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Automatically import order information to quickly print your labels.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'icon', val: var_asset_base_url.str() + 'discount.svg' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Save money'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Shop for the best shipping rates, and access pre-negotiated discounted rates.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'icon', val: var_asset_base_url.str() + 'star.svg' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Wow your shoppers'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Keep your customers informed with tracking notifications.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	])
	mut var_check_icon := rt.new_string(var_asset_base_url.str() + 'check.svg')
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-shipstation-integration' },
			rt.ArrayItem{ key: 'name', val: 'ShipStation' },
			rt.ArrayItem{ key: 'slug', val: 'woocommerce-shipstation-integration' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Powerful yet easy-to-use solution:'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'layout_column', val: rt.create_array([
				rt.ArrayItem{ key: 'image', val: var_asset_base_url.str() + 'shipstation-column.svg' },
				rt.ArrayItem{ key: 'features', val: var_column_layout_features },
			]) },
			rt.ArrayItem{ key: 'layout_row', val: rt.create_array([
				rt.ArrayItem{ key: 'image', val: var_asset_base_url.str() + 'shipstation-row.svg' },
				rt.ArrayItem{ key: 'features', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Discounted labels from top global carriers'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Sync all your selling channels in one place'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Advanced automated workflows and customs'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Instantly send tracking to your customers'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('30-day free trial'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{
				key: 'learn_more_link'
				val: 'https://wordpress.org/plugins/woocommerce-shipstation-integration/'
			},
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'US' },
					rt.ArrayItem{ key: none, val: 'AU' },
					rt.ArrayItem{ key: none, val: 'NZ' },
					rt.ArrayItem{ key: none, val: 'CA' },
					rt.ArrayItem{ key: none, val: 'GB' },
				])) },
			]) },
			rt.ArrayItem{ key: 'available_layouts', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'row' },
				rt.ArrayItem{ key: none, val: 'column' },
			]) },
			rt.ArrayItem{ key: 'countries_where_primary', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'NZ' },
				rt.ArrayItem{ key: none, val: 'CA' },
				rt.ArrayItem{ key: none, val: 'GB' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'skydropx-cotizador-y-envios' },
			rt.ArrayItem{ key: 'name', val: 'Skydropx' },
			rt.ArrayItem{ key: 'slug', val: 'skydropx-cotizador-y-envios' },
			rt.ArrayItem{ key: 'layout_column', val: rt.create_array([
				rt.ArrayItem{ key: 'image', val: var_asset_base_url.str() + 'skydropx-column.svg' },
				rt.ArrayItem{ key: 'features', val: var_column_layout_features },
			]) },
			rt.ArrayItem{ key: 'description', val: '' },
			rt.ArrayItem{
				key: 'learn_more_link'
				val: 'https://wordpress.org/plugins/skydropx-cotizador-y-envios/'
			},
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners.get_rules_for_countries(rt.new_array())
				},
			]) },
			rt.ArrayItem{ key: 'available_layouts', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'column' },
			]) },
			rt.ArrayItem{ key: 'countries_where_primary', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'envia' },
			rt.ArrayItem{ key: 'name', val: 'Envia' },
			rt.ArrayItem{ key: 'slug', val: '' },
			rt.ArrayItem{ key: 'description', val: '' },
			rt.ArrayItem{ key: 'layout_column', val: rt.create_array([
				rt.ArrayItem{ key: 'image', val: var_asset_base_url.str() + 'envia-column.svg' },
				rt.ArrayItem{ key: 'features', val: var_column_layout_features },
			]) },
			rt.ArrayItem{
				key: 'learn_more_link'
				val: 'https://woocommerce.com/products/envia-shipping-and-fulfillment/'
			},
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'MX' },
					rt.ArrayItem{ key: none, val: 'CO' },
					rt.ArrayItem{ key: none, val: 'CL' },
					rt.ArrayItem{ key: none, val: 'AR' },
					rt.ArrayItem{ key: none, val: 'PE' },
					rt.ArrayItem{ key: none, val: 'BR' },
					rt.ArrayItem{ key: none, val: 'UY' },
					rt.ArrayItem{ key: none, val: 'GT' },
				])) },
			]) },
			rt.ArrayItem{ key: 'available_layouts', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'column' },
			]) },
			rt.ArrayItem{ key: 'countries_where_primary', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'MX' },
				rt.ArrayItem{ key: none, val: 'CO' },
				rt.ArrayItem{ key: none, val: 'CL' },
				rt.ArrayItem{ key: none, val: 'AR' },
				rt.ArrayItem{ key: none, val: 'PE' },
				rt.ArrayItem{ key: none, val: 'BR' },
				rt.ArrayItem{ key: none, val: 'UY' },
				rt.ArrayItem{ key: none, val: 'GT' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'easyship-woocommerce-shipping-rates' },
			rt.ArrayItem{ key: 'name', val: 'Easyship' },
			rt.ArrayItem{ key: 'slug', val: 'easyship-woocommerce-shipping-rates' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Simplified shipping with: '),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'layout_column', val: rt.create_array([
				rt.ArrayItem{ key: 'image', val: var_asset_base_url.str() + 'easyship-column.svg' },
				rt.ArrayItem{ key: 'features', val: var_column_layout_features },
			]) },
			rt.ArrayItem{ key: 'layout_row', val: rt.create_array([
				rt.ArrayItem{ key: 'image', val: var_asset_base_url.str() + 'easyship-row.svg' },
				rt.ArrayItem{ key: 'features', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Highly discounted shipping rates'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Seamless order sync and label printing'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Branded tracking experience'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Built-in Tax & Duties paperwork'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Free Plan Available'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{
				key: 'learn_more_link'
				val: 'https://woocommerce.com/products/easyship-shipping-rates/'
			},
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'SG' },
					rt.ArrayItem{ key: none, val: 'HK' },
					rt.ArrayItem{ key: none, val: 'AU' },
					rt.ArrayItem{ key: none, val: 'NZ' },
				])) },
			]) },
			rt.ArrayItem{ key: 'available_layouts', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'row' },
				rt.ArrayItem{ key: none, val: 'column' },
			]) },
			rt.ArrayItem{ key: 'countries_where_primary', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'SG' },
				rt.ArrayItem{ key: none, val: 'HK' },
				rt.ArrayItem{ key: none, val: 'AU' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'packlink-pro-shipping' },
			rt.ArrayItem{ key: 'name', val: 'Packlink' },
			rt.ArrayItem{ key: 'slug', val: 'packlink-pro-shipping' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Optimize your full shipping process:'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'layout_column', val: rt.create_array([
				rt.ArrayItem{ key: 'image', val: var_asset_base_url.str() + 'packlink-column.svg' },
				rt.ArrayItem{ key: 'features', val: var_column_layout_features },
			]) },
			rt.ArrayItem{ key: 'layout_row', val: rt.create_array([
				rt.ArrayItem{ key: 'image', val: var_asset_base_url.str() + 'packlink-row.svg' },
				rt.ArrayItem{ key: 'features', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Automated, real-time order import'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Direct access to leading carriers'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Access competitive shipping prices'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Quickly bulk print labels'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Free shipping platform'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{
				key: 'learn_more_link'
				val: 'https://wordpress.org/plugins/packlink-pro-shipping/'
			},
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'FR' },
					rt.ArrayItem{ key: none, val: 'DE' },
					rt.ArrayItem{ key: none, val: 'ES' },
					rt.ArrayItem{ key: none, val: 'IT' },
					rt.ArrayItem{ key: none, val: 'NL' },
					rt.ArrayItem{ key: none, val: 'AT' },
					rt.ArrayItem{ key: none, val: 'BE' },
					rt.ArrayItem{ key: none, val: 'IE' },
					rt.ArrayItem{ key: none, val: 'PT' },
				])) },
			]) },
			rt.ArrayItem{ key: 'available_layouts', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'row' },
				rt.ArrayItem{ key: none, val: 'column' },
			]) },
			rt.ArrayItem{ key: 'countries_where_primary', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'FR' },
				rt.ArrayItem{ key: none, val: 'DE' },
				rt.ArrayItem{ key: none, val: 'ES' },
				rt.ArrayItem{ key: none, val: 'IT' },
				rt.ArrayItem{ key: none, val: 'NL' },
				rt.ArrayItem{ key: none, val: 'AT' },
				rt.ArrayItem{ key: none, val: 'BE' },
				rt.ArrayItem{ key: none, val: 'IE' },
				rt.ArrayItem{ key: none, val: 'PT' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-shipping' },
			rt.ArrayItem{ key: 'name', val: 'WooCommerce Shipping' },
			rt.ArrayItem{ key: 'slug', val: 'woocommerce-shipping' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Save time and money by printing your shipping labels right from your computer with WooCommerce Shipping. Try WooCommerce Shipping for free.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'layout_column', val: rt.create_array([
				rt.ArrayItem{ key: 'image', val: var_asset_base_url.str() + 'wcs-column.svg' },
				rt.ArrayItem{ key: 'features', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_asset_base_url.str() + 'printer.svg' },
						rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
							rt.new_string('Buy postage when you need it'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('No need to wonder where that stampbook went.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_asset_base_url.str() + 'paper.svg' },
						rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
							rt.new_string('Print at home'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Pick up an order, then just pay, print, package and post.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_asset_base_url.str() + 'discount.svg' },
						rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
							rt.new_string('Discounted rates'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Access discounted shipping rates with USPS, UPS, and DHL.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'layout_row', val: rt.create_array([
				rt.ArrayItem{ key: 'image', val: var_asset_base_url.str() + 'wcs-row.svg' },
				rt.ArrayItem{ key: 'image_label', val: rt.call_function('__', [
					rt.new_string('WooCommerce Shipping'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Save time and money by managing shipping right from your WooCommerce dashboard.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'features', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Instantly save on USPS, UPS, FedEx and DHL Express labels.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Access live rates across carriers to get the best prices for you and your customers.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Keep customers happy and informed every step of the way.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'icon', val: var_check_icon },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Free to install, with no markup or monthly fees.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'learn_more_link', val: 'https://woocommerce.com/products/shipping/' },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'US' },
				])) },
				rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'not' },
					rt.ArrayItem{ key: 'operand', val: rt.create_array([
						rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'plugins_activated' },
							rt.ArrayItem{ key: 'plugins', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'woocommerce-shipping' },
							]) },
						])) },
					]) },
				])) },
			]) },
			rt.ArrayItem{ key: 'available_layouts', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'row' },
				rt.ArrayItem{ key: none, val: 'column' },
			]) },
			rt.ArrayItem{ key: 'countries_where_primary', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'US' },
			]) },
		]) },
	])
}

fn Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners.get_rules_for_countries(var_countries rt.PhpVal) rt.PhpVal {
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'type', val: 'base_location_country' },
		rt.ArrayItem{ key: 'operation', val: 'in' },
		rt.ArrayItem{ key: 'value', val: var_countries },
	]))
}

fn create_automattic_woocommerce_admin_features_shippingpartnersuggestions_defaultshippingpartners(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_all' {
			return Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners.get_all()
		}
		'get_rules_for_countries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners.get_rules_for_countries(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
