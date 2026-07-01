import rt

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.wpcom_proxy_request_timeout() i64 {
	return 60
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_completed() string {
	return 'COMPLETED'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_approved() string {
	return 'APPROVED'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_captured() string {
	return 'CAPTURED'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_authorized() string {
	return 'AUTHORIZED'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_payer_action_required() string {
	return 'PAYER_ACTION_REQUIRED'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.voided() string {
	return 'VOIDED'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.intent_capture() string {
	return 'CAPTURE'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.intent_authorize() string {
	return 'AUTHORIZE'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_action_capture() string {
	return 'capture'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_action_authorize() string {
	return 'authorize'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.shipping_no_shipping() string {
	return 'NO_SHIPPING'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.shipping_get_from_file() string {
	return 'GET_FROM_FILE'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.shipping_set_provided_address() string {
	return 'SET_PROVIDED_ADDRESS'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.user_action_pay_now() string {
	return 'PAY_NOW'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_item_name_max_length() i64 {
	return 127
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_invoice_id_max_length() i64 {
	return 127
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_address_line_max_length() i64 {
	return 300
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_country_code_length() i64 {
	return 2
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_state_max_length() i64 {
	return 300
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_city_max_length() i64 {
	return 120
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_postal_code_max_length() i64 {
	return 60
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_locale_max_length() i64 {
	return 10
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_source_paypal() string {
	return 'paypal'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_source_venmo() string {
	return 'venmo'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_source_paylater() string {
	return 'paylater'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.supported_payment_sources() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_source_paypal()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_source_venmo()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_source_paylater()
		},
	])
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.fields_to_redact() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'given_name' },
		rt.ArrayItem{ key: none, val: 'surname' }, rt.ArrayItem{ key: none, val: 'full_name' },
		rt.ArrayItem{ key: none, val: 'address_line_1' }, rt.ArrayItem{
			key: none
			val: 'address_line_2'
		}, rt.ArrayItem{ key: none, val: 'admin_area_1' }, rt.ArrayItem{
			key: none
			val: 'admin_area_2'
		}, rt.ArrayItem{ key: none, val: 'postal_code' }, rt.ArrayItem{ key: none, val: 'phone' },
		rt.ArrayItem{ key: none, val: 'phone_number' }, rt.ArrayItem{
			key: none
			val: 'national_number'
		}])
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.supported_currencies() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'AUD' },
		rt.ArrayItem{ key: none, val: 'BRL' }, rt.ArrayItem{ key: none, val: 'CAD' },
		rt.ArrayItem{ key: none, val: 'CNY' }, rt.ArrayItem{ key: none, val: 'CZK' },
		rt.ArrayItem{ key: none, val: 'DKK' }, rt.ArrayItem{ key: none, val: 'EUR' },
		rt.ArrayItem{ key: none, val: 'HKD' }, rt.ArrayItem{ key: none, val: 'HUF' },
		rt.ArrayItem{ key: none, val: 'ILS' }, rt.ArrayItem{ key: none, val: 'JPY' },
		rt.ArrayItem{ key: none, val: 'MYR' }, rt.ArrayItem{ key: none, val: 'MXN' },
		rt.ArrayItem{ key: none, val: 'TWD' }, rt.ArrayItem{ key: none, val: 'NZD' },
		rt.ArrayItem{ key: none, val: 'NOK' }, rt.ArrayItem{ key: none, val: 'PHP' },
		rt.ArrayItem{ key: none, val: 'PLN' }, rt.ArrayItem{ key: none, val: 'GBP' },
		rt.ArrayItem{ key: none, val: 'SGD' }, rt.ArrayItem{ key: none, val: 'SEK' },
		rt.ArrayItem{ key: none, val: 'CHF' }, rt.ArrayItem{ key: none, val: 'THB' },
		rt.ArrayItem{ key: none, val: 'USD' }, rt.ArrayItem{ key: none, val: 'RUB' }])
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.supported_countries() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'AL', val: 'Albania' },
		rt.ArrayItem{ key: 'DZ', val: 'Algeria' }, rt.ArrayItem{ key: 'AD', val: 'Andorra' },
		rt.ArrayItem{ key: 'AO', val: 'Angola' }, rt.ArrayItem{ key: 'AI', val: 'Anguilla' },
		rt.ArrayItem{ key: 'AG', val: 'Antigua & Barbuda' }, rt.ArrayItem{
			key: 'AR'
			val: 'Argentina'
		}, rt.ArrayItem{ key: 'AM', val: 'Armenia' }, rt.ArrayItem{ key: 'AW', val: 'Aruba' },
		rt.ArrayItem{ key: 'AU', val: 'Australia' }, rt.ArrayItem{ key: 'AT', val: 'Austria' },
		rt.ArrayItem{ key: 'AZ', val: 'Azerbaijan' }, rt.ArrayItem{ key: 'BS', val: 'Bahamas' },
		rt.ArrayItem{ key: 'BH', val: 'Bahrain' }, rt.ArrayItem{ key: 'BB', val: 'Barbados' },
		rt.ArrayItem{ key: 'BY', val: 'Belarus' }, rt.ArrayItem{ key: 'BE', val: 'Belgium' },
		rt.ArrayItem{ key: 'BZ', val: 'Belize' }, rt.ArrayItem{ key: 'BJ', val: 'Benin' },
		rt.ArrayItem{ key: 'BM', val: 'Bermuda' }, rt.ArrayItem{ key: 'BT', val: 'Bhutan' },
		rt.ArrayItem{ key: 'BO', val: 'Bolivia' }, rt.ArrayItem{
			key: 'BA'
			val: 'Bosnia & Herzegovina'
		}, rt.ArrayItem{ key: 'BW', val: 'Botswana' }, rt.ArrayItem{ key: 'BR', val: 'Brazil' },
		rt.ArrayItem{ key: 'VG', val: 'British Virgin Islands' },
		rt.ArrayItem{ key: 'BN', val: 'Brunei' }, rt.ArrayItem{ key: 'BG', val: 'Bulgaria' },
		rt.ArrayItem{ key: 'BF', val: 'Burkina Faso' }, rt.ArrayItem{ key: 'BI', val: 'Burundi' },
		rt.ArrayItem{ key: 'KH', val: 'Cambodia' }, rt.ArrayItem{ key: 'CM', val: 'Cameroon' },
		rt.ArrayItem{ key: 'CA', val: 'Canada' }, rt.ArrayItem{ key: 'CV', val: 'Cape Verde' },
		rt.ArrayItem{ key: 'KY', val: 'Cayman Islands' }, rt.ArrayItem{ key: 'TD', val: 'Chad' },
		rt.ArrayItem{ key: 'CL', val: 'Chile' }, rt.ArrayItem{ key: 'CN', val: 'China' },
		rt.ArrayItem{ key: 'CO', val: 'Colombia' }, rt.ArrayItem{ key: 'KM', val: 'Comoros' },
		rt.ArrayItem{ key: 'CG', val: 'Congo - Brazzaville' },
		rt.ArrayItem{ key: 'CD', val: 'Congo - Kinshasa' }, rt.ArrayItem{
			key: 'CK'
			val: 'Cook Islands'
		}, rt.ArrayItem{ key: 'CR', val: 'Costa Rica' }, rt.ArrayItem{
			key: 'CI'
			val: "Côte d'Ivoire"
		}, rt.ArrayItem{ key: 'HR', val: 'Croatia' }, rt.ArrayItem{ key: 'CY', val: 'Cyprus' },
		rt.ArrayItem{ key: 'CZ', val: 'Czech Republic' }, rt.ArrayItem{ key: 'DK', val: 'Denmark' },
		rt.ArrayItem{ key: 'DJ', val: 'Djibouti' }, rt.ArrayItem{ key: 'DM', val: 'Dominica' },
		rt.ArrayItem{ key: 'DO', val: 'Dominican Republic' },
		rt.ArrayItem{ key: 'EC', val: 'Ecuador' }, rt.ArrayItem{ key: 'EG', val: 'Egypt' },
		rt.ArrayItem{ key: 'SV', val: 'El Salvador' }, rt.ArrayItem{ key: 'ER', val: 'Eritrea' },
		rt.ArrayItem{ key: 'EE', val: 'Estonia' }, rt.ArrayItem{ key: 'ET', val: 'Ethiopia' },
		rt.ArrayItem{ key: 'FK', val: 'Falkland Islands' }, rt.ArrayItem{
			key: 'FO'
			val: 'Faroe Islands'
		}, rt.ArrayItem{ key: 'FJ', val: 'Fiji' }, rt.ArrayItem{ key: 'FI', val: 'Finland' },
		rt.ArrayItem{ key: 'FR', val: 'France' }, rt.ArrayItem{ key: 'GF', val: 'French Guiana' },
		rt.ArrayItem{ key: 'PF', val: 'French Polynesia' }, rt.ArrayItem{ key: 'GA', val: 'Gabon' },
		rt.ArrayItem{ key: 'GM', val: 'Gambia' }, rt.ArrayItem{ key: 'GE', val: 'Georgia' },
		rt.ArrayItem{ key: 'DE', val: 'Germany' }, rt.ArrayItem{ key: 'GI', val: 'Gibraltar' },
		rt.ArrayItem{ key: 'GR', val: 'Greece' }, rt.ArrayItem{ key: 'GL', val: 'Greenland' },
		rt.ArrayItem{ key: 'GD', val: 'Grenada' }, rt.ArrayItem{ key: 'GP', val: 'Guadeloupe' },
		rt.ArrayItem{ key: 'GT', val: 'Guatemala' }, rt.ArrayItem{ key: 'GN', val: 'Guinea' },
		rt.ArrayItem{ key: 'GW', val: 'Guinea-Bissau' }, rt.ArrayItem{ key: 'GY', val: 'Guyana' },
		rt.ArrayItem{ key: 'HN', val: 'Honduras' }, rt.ArrayItem{
			key: 'HK'
			val: 'Hong Kong SAR China'
		}, rt.ArrayItem{ key: 'HU', val: 'Hungary' }, rt.ArrayItem{ key: 'IS', val: 'Iceland' },
		rt.ArrayItem{ key: 'IN', val: 'India' }, rt.ArrayItem{ key: 'ID', val: 'Indonesia' },
		rt.ArrayItem{ key: 'IE', val: 'Ireland' }, rt.ArrayItem{ key: 'IL', val: 'Israel' },
		rt.ArrayItem{ key: 'IT', val: 'Italy' }, rt.ArrayItem{ key: 'JM', val: 'Jamaica' },
		rt.ArrayItem{ key: 'JP', val: 'Japan' }, rt.ArrayItem{ key: 'JO', val: 'Jordan' },
		rt.ArrayItem{ key: 'KZ', val: 'Kazakhstan' }, rt.ArrayItem{ key: 'KE', val: 'Kenya' },
		rt.ArrayItem{ key: 'KI', val: 'Kiribati' }, rt.ArrayItem{ key: 'KW', val: 'Kuwait' },
		rt.ArrayItem{ key: 'KG', val: 'Kyrgyzstan' }, rt.ArrayItem{ key: 'LA', val: 'Laos' },
		rt.ArrayItem{ key: 'LV', val: 'Latvia' }, rt.ArrayItem{ key: 'LS', val: 'Lesotho' },
		rt.ArrayItem{ key: 'LI', val: 'Liechtenstein' }, rt.ArrayItem{ key: 'LT', val: 'Lithuania' },
		rt.ArrayItem{ key: 'LU', val: 'Luxembourg' }, rt.ArrayItem{ key: 'MK', val: 'Macedonia' },
		rt.ArrayItem{ key: 'MG', val: 'Madagascar' }, rt.ArrayItem{ key: 'MW', val: 'Malawi' },
		rt.ArrayItem{ key: 'MY', val: 'Malaysia' }, rt.ArrayItem{ key: 'MV', val: 'Maldives' },
		rt.ArrayItem{ key: 'ML', val: 'Mali' }, rt.ArrayItem{ key: 'MT', val: 'Malta' },
		rt.ArrayItem{ key: 'MH', val: 'Marshall Islands' }, rt.ArrayItem{
			key: 'MQ'
			val: 'Martinique'
		}, rt.ArrayItem{ key: 'MR', val: 'Mauritania' }, rt.ArrayItem{ key: 'MU', val: 'Mauritius' },
		rt.ArrayItem{ key: 'YT', val: 'Mayotte' }, rt.ArrayItem{ key: 'MX', val: 'Mexico' },
		rt.ArrayItem{ key: 'FM', val: 'Micronesia' }, rt.ArrayItem{ key: 'MD', val: 'Moldova' },
		rt.ArrayItem{ key: 'MC', val: 'Monaco' }, rt.ArrayItem{ key: 'MN', val: 'Mongolia' },
		rt.ArrayItem{ key: 'ME', val: 'Montenegro' }, rt.ArrayItem{ key: 'MS', val: 'Montserrat' },
		rt.ArrayItem{ key: 'MA', val: 'Morocco' }, rt.ArrayItem{ key: 'MZ', val: 'Mozambique' },
		rt.ArrayItem{ key: 'NA', val: 'Namibia' }, rt.ArrayItem{ key: 'NR', val: 'Nauru' },
		rt.ArrayItem{ key: 'NP', val: 'Nepal' }, rt.ArrayItem{ key: 'NL', val: 'Netherlands' },
		rt.ArrayItem{ key: 'NC', val: 'New Caledonia' }, rt.ArrayItem{ key: 'NZ', val: 'New Zealand' },
		rt.ArrayItem{ key: 'NI', val: 'Nicaragua' }, rt.ArrayItem{ key: 'NE', val: 'Niger' },
		rt.ArrayItem{ key: 'NG', val: 'Nigeria' }, rt.ArrayItem{ key: 'NU', val: 'Niue' },
		rt.ArrayItem{ key: 'NF', val: 'Norfolk Island' }, rt.ArrayItem{ key: 'NO', val: 'Norway' },
		rt.ArrayItem{ key: 'OM', val: 'Oman' }, rt.ArrayItem{ key: 'PW', val: 'Palau' },
		rt.ArrayItem{ key: 'PA', val: 'Panama' }, rt.ArrayItem{ key: 'PG', val: 'Papua New Guinea' },
		rt.ArrayItem{ key: 'PY', val: 'Paraguay' }, rt.ArrayItem{ key: 'PE', val: 'Peru' },
		rt.ArrayItem{ key: 'PH', val: 'Philippines' }, rt.ArrayItem{
			key: 'PN'
			val: 'Pitcairn Islands'
		}, rt.ArrayItem{ key: 'PL', val: 'Poland' }, rt.ArrayItem{ key: 'PT', val: 'Portugal' },
		rt.ArrayItem{ key: 'QA', val: 'Qatar' }, rt.ArrayItem{ key: 'RE', val: 'Réunion' },
		rt.ArrayItem{ key: 'RO', val: 'Romania' }, rt.ArrayItem{ key: 'RU', val: 'Russia' },
		rt.ArrayItem{ key: 'RW', val: 'Rwanda' }, rt.ArrayItem{ key: 'WS', val: 'Samoa' },
		rt.ArrayItem{ key: 'SM', val: 'San Marino' }, rt.ArrayItem{
			key: 'ST'
			val: 'São Tomé & Príncipe'
		}, rt.ArrayItem{ key: 'SA', val: 'Saudi Arabia' }, rt.ArrayItem{ key: 'SN', val: 'Senegal' },
		rt.ArrayItem{ key: 'RS', val: 'Serbia' }, rt.ArrayItem{ key: 'SC', val: 'Seychelles' },
		rt.ArrayItem{ key: 'SL', val: 'Sierra Leone' }, rt.ArrayItem{ key: 'SG', val: 'Singapore' },
		rt.ArrayItem{ key: 'SK', val: 'Slovakia' }, rt.ArrayItem{ key: 'SI', val: 'Slovenia' },
		rt.ArrayItem{ key: 'SB', val: 'Solomon Islands' }, rt.ArrayItem{ key: 'SO', val: 'Somalia' },
		rt.ArrayItem{ key: 'ZA', val: 'South Africa' }, rt.ArrayItem{ key: 'KR', val: 'South Korea' },
		rt.ArrayItem{ key: 'ES', val: 'Spain' }, rt.ArrayItem{ key: 'LK', val: 'Sri Lanka' },
		rt.ArrayItem{ key: 'SH', val: 'St. Helena' }, rt.ArrayItem{
			key: 'KN'
			val: 'St. Kitts & Nevis'
		}, rt.ArrayItem{ key: 'LC', val: 'St. Lucia' }, rt.ArrayItem{
			key: 'PM'
			val: 'St. Pierre & Miquelon'
		}, rt.ArrayItem{ key: 'VC', val: 'St. Vincent & Grenadines' },
		rt.ArrayItem{ key: 'SR', val: 'Suriname' }, rt.ArrayItem{
			key: 'SJ'
			val: 'Svalbard & Jan Mayen'
		}, rt.ArrayItem{ key: 'SZ', val: 'Swaziland' }, rt.ArrayItem{ key: 'SE', val: 'Sweden' },
		rt.ArrayItem{ key: 'CH', val: 'Switzerland' }, rt.ArrayItem{ key: 'TW', val: 'Taiwan' },
		rt.ArrayItem{ key: 'TJ', val: 'Tajikistan' }, rt.ArrayItem{ key: 'TZ', val: 'Tanzania' },
		rt.ArrayItem{ key: 'TH', val: 'Thailand' }, rt.ArrayItem{ key: 'TG', val: 'Togo' },
		rt.ArrayItem{ key: 'TO', val: 'Tonga' }, rt.ArrayItem{ key: 'TT', val: 'Trinidad & Tobago' },
		rt.ArrayItem{ key: 'TN', val: 'Tunisia' }, rt.ArrayItem{ key: 'TM', val: 'Turkmenistan' },
		rt.ArrayItem{ key: 'TC', val: 'Turks & Caicos Islands' },
		rt.ArrayItem{ key: 'TV', val: 'Tuvalu' }, rt.ArrayItem{ key: 'UG', val: 'Uganda' },
		rt.ArrayItem{ key: 'UA', val: 'Ukraine' }, rt.ArrayItem{
			key: 'AE'
			val: 'United Arab Emirates'
		}, rt.ArrayItem{ key: 'GB', val: 'United Kingdom' }, rt.ArrayItem{
			key: 'US'
			val: 'United States'
		}, rt.ArrayItem{ key: 'UY', val: 'Uruguay' }, rt.ArrayItem{ key: 'VU', val: 'Vanuatu' },
		rt.ArrayItem{ key: 'VA', val: 'Vatican City' }, rt.ArrayItem{ key: 'VE', val: 'Venezuela' },
		rt.ArrayItem{ key: 'VN', val: 'Vietnam' }, rt.ArrayItem{ key: 'WF', val: 'Wallis & Futuna' },
		rt.ArrayItem{ key: 'YE', val: 'Yemen' }, rt.ArrayItem{ key: 'ZM', val: 'Zambia' },
		rt.ArrayItem{ key: 'ZW', val: 'Zimbabwe' }])
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_issue_authorization_already_captured() string {
	return 'AUTHORIZATION_ALREADY_CAPTURED'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_issue_payee_account_locked_or_closed() string {
	return 'PAYEE_ACCOUNT_LOCKED_OR_CLOSED'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_issue_payee_account_restricted() string {
	return 'PAYEE_ACCOUNT_RESTRICTED'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_issue_duplicate_invoice_id() string {
	return 'DUPLICATE_INVOICE_ID'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status() string {
	return '_paypal_status'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_capture_id() string {
	return '_paypal_capture_id'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_authorization_id() string {
	return '_paypal_authorization_id'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_authorization_checked() string {
	return '_paypal_authorization_checked'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_order_id() string {
	return '_paypal_order_id'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_addresses_updated() string {
	return '_paypal_addresses_updated'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_payment_source() string {
	return '_paypal_payment_source'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_shipping_callback_token() string {
	return '_paypal_shipping_callback_token'
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Constants {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_gateways_paypal_constants() &Class_Automattic_WooCommerce_Gateways_PayPal_Constants {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_gateways_paypal_constants_php() {
	// unsupported statement: Stmt_Declare
}
