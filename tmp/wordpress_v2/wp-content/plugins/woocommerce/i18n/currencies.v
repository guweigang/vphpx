import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	return rt.create_array([
		rt.ArrayItem{ key: 'AED', val: rt.call_function('__', [
			rt.new_string('United Arab Emirates dirham'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AFN', val: rt.call_function('__', [
			rt.new_string('Afghan afghani'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ALL', val: rt.call_function('__', [
			rt.new_string('Albanian lek'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AMD', val: rt.call_function('__', [
			rt.new_string('Armenian dram'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ANG', val: rt.call_function('__', [
			rt.new_string('Netherlands Antillean guilder'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AOA', val: rt.call_function('__', [
			rt.new_string('Angolan kwanza'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ARS', val: rt.call_function('__', [
			rt.new_string('Argentine peso'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AUD', val: rt.call_function('__', [
			rt.new_string('Australian dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AWG', val: rt.call_function('__', [
			rt.new_string('Aruban florin'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AZN', val: rt.call_function('__', [
			rt.new_string('Azerbaijani manat'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BAM', val: rt.call_function('__', [
			rt.new_string('Bosnia and Herzegovina convertible mark'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BBD', val: rt.call_function('__', [
			rt.new_string('Barbadian dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BDT', val: rt.call_function('__', [
			rt.new_string('Bangladeshi taka'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BGN', val: rt.call_function('__', [
			rt.new_string('Bulgarian lev'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BHD', val: rt.call_function('__', [
			rt.new_string('Bahraini dinar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BIF', val: rt.call_function('__', [
			rt.new_string('Burundian franc'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BMD', val: rt.call_function('__', [
			rt.new_string('Bermudian dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BND', val: rt.call_function('__', [
			rt.new_string('Brunei dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BOB', val: rt.call_function('__', [
			rt.new_string('Bolivian boliviano'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BRL', val: rt.call_function('__', [
			rt.new_string('Brazilian real'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BSD', val: rt.call_function('__', [
			rt.new_string('Bahamian dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BTC', val: rt.call_function('__', [
			rt.new_string('Bitcoin'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BTN', val: rt.call_function('__', [
			rt.new_string('Bhutanese ngultrum'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BWP', val: rt.call_function('__', [
			rt.new_string('Botswana pula'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BYR', val: rt.call_function('__', [
			rt.new_string('Belarusian ruble (old)'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BYN', val: rt.call_function('__', [
			rt.new_string('Belarusian ruble'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BZD', val: rt.call_function('__', [
			rt.new_string('Belize dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CAD', val: rt.call_function('__', [
			rt.new_string('Canadian dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CDF', val: rt.call_function('__', [
			rt.new_string('Congolese franc'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CHF', val: rt.call_function('__', [
			rt.new_string('Swiss franc'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CLP', val: rt.call_function('__', [
			rt.new_string('Chilean peso'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CNY', val: rt.call_function('__', [
			rt.new_string('Chinese yuan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'COP', val: rt.call_function('__', [
			rt.new_string('Colombian peso'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CRC', val: rt.call_function('__', [
			rt.new_string('Costa Rican col&oacute;n'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CUC', val: rt.call_function('__', [
			rt.new_string('Cuban convertible peso'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CUP', val: rt.call_function('__', [
			rt.new_string('Cuban peso'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CVE', val: rt.call_function('__', [
			rt.new_string('Cape Verdean escudo'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CZK', val: rt.call_function('__', [
			rt.new_string('Czech koruna'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'DJF', val: rt.call_function('__', [
			rt.new_string('Djiboutian franc'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'DKK', val: rt.call_function('__', [
			rt.new_string('Danish krone'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'DOP', val: rt.call_function('__', [
			rt.new_string('Dominican peso'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'DZD', val: rt.call_function('__', [
			rt.new_string('Algerian dinar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'EGP', val: rt.call_function('__', [
			rt.new_string('Egyptian pound'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ERN', val: rt.call_function('__', [
			rt.new_string('Eritrean nakfa'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ETB', val: rt.call_function('__', [
			rt.new_string('Ethiopian birr'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'EUR', val: rt.call_function('__', [
			rt.new_string('Euro'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'FJD', val: rt.call_function('__', [
			rt.new_string('Fijian dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'FKP', val: rt.call_function('__', [
			rt.new_string('Falkland Islands pound'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GBP', val: rt.call_function('__', [
			rt.new_string('Pound sterling'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GEL', val: rt.call_function('__', [
			rt.new_string('Georgian lari'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GGP', val: rt.call_function('__', [
			rt.new_string('Guernsey pound'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GHS', val: rt.call_function('__', [
			rt.new_string('Ghana cedi'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GIP', val: rt.call_function('__', [
			rt.new_string('Gibraltar pound'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GMD', val: rt.call_function('__', [
			rt.new_string('Gambian dalasi'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GNF', val: rt.call_function('__', [
			rt.new_string('Guinean franc'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GTQ', val: rt.call_function('__', [
			rt.new_string('Guatemalan quetzal'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GYD', val: rt.call_function('__', [
			rt.new_string('Guyanese dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'HKD', val: rt.call_function('__', [
			rt.new_string('Hong Kong dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'HNL', val: rt.call_function('__', [
			rt.new_string('Honduran lempira'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'HRK', val: rt.call_function('__', [
			rt.new_string('Croatian kuna'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'HTG', val: rt.call_function('__', [
			rt.new_string('Haitian gourde'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'HUF', val: rt.call_function('__', [
			rt.new_string('Hungarian forint'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'IDR', val: rt.call_function('__', [
			rt.new_string('Indonesian rupiah'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ILS', val: rt.call_function('__', [
			rt.new_string('Israeli new shekel'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'IMP', val: rt.call_function('__', [
			rt.new_string('Manx pound'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'INR', val: rt.call_function('__', [
			rt.new_string('Indian rupee'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'IQD', val: rt.call_function('__', [
			rt.new_string('Iraqi dinar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'IRR', val: rt.call_function('__', [
			rt.new_string('Iranian rial'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'IRT', val: rt.call_function('__', [
			rt.new_string('Iranian toman'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ISK', val: rt.call_function('__', [
			rt.new_string('Icelandic kr&oacute;na'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'JEP', val: rt.call_function('__', [
			rt.new_string('Jersey pound'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'JMD', val: rt.call_function('__', [
			rt.new_string('Jamaican dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'JOD', val: rt.call_function('__', [
			rt.new_string('Jordanian dinar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'JPY', val: rt.call_function('__', [
			rt.new_string('Japanese yen'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KES', val: rt.call_function('__', [
			rt.new_string('Kenyan shilling'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KGS', val: rt.call_function('__', [
			rt.new_string('Kyrgyzstani som'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KHR', val: rt.call_function('__', [
			rt.new_string('Cambodian riel'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KMF', val: rt.call_function('__', [
			rt.new_string('Comorian franc'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KPW', val: rt.call_function('__', [
			rt.new_string('North Korean won'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KRW', val: rt.call_function('__', [
			rt.new_string('South Korean won'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KWD', val: rt.call_function('__', [
			rt.new_string('Kuwaiti dinar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KYD', val: rt.call_function('__', [
			rt.new_string('Cayman Islands dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KZT', val: rt.call_function('__', [
			rt.new_string('Kazakhstani tenge'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LAK', val: rt.call_function('__', [
			rt.new_string('Lao kip'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LBP', val: rt.call_function('__', [
			rt.new_string('Lebanese pound'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LKR', val: rt.call_function('__', [
			rt.new_string('Sri Lankan rupee'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LRD', val: rt.call_function('__', [
			rt.new_string('Liberian dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LSL', val: rt.call_function('__', [
			rt.new_string('Lesotho loti'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LYD', val: rt.call_function('__', [
			rt.new_string('Libyan dinar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MAD', val: rt.call_function('__', [
			rt.new_string('Moroccan dirham'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MDL', val: rt.call_function('__', [
			rt.new_string('Moldovan leu'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MGA', val: rt.call_function('__', [
			rt.new_string('Malagasy ariary'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MKD', val: rt.call_function('__', [
			rt.new_string('Macedonian denar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MMK', val: rt.call_function('__', [
			rt.new_string('Burmese kyat'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MNT', val: rt.call_function('__', [
			rt.new_string('Mongolian t&ouml;gr&ouml;g'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MOP', val: rt.call_function('__', [
			rt.new_string('Macanese pataca'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MRU', val: rt.call_function('__', [
			rt.new_string('Mauritanian ouguiya'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MUR', val: rt.call_function('__', [
			rt.new_string('Mauritian rupee'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MVR', val: rt.call_function('__', [
			rt.new_string('Maldivian rufiyaa'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MWK', val: rt.call_function('__', [
			rt.new_string('Malawian kwacha'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MXN', val: rt.call_function('__', [
			rt.new_string('Mexican peso'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MYR', val: rt.call_function('__', [
			rt.new_string('Malaysian ringgit'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MZN', val: rt.call_function('__', [
			rt.new_string('Mozambican metical'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NAD', val: rt.call_function('__', [
			rt.new_string('Namibian dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NGN', val: rt.call_function('__', [
			rt.new_string('Nigerian naira'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NIO', val: rt.call_function('__', [
			rt.new_string('Nicaraguan c&oacute;rdoba'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NOK', val: rt.call_function('__', [
			rt.new_string('Norwegian krone'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NPR', val: rt.call_function('__', [
			rt.new_string('Nepalese rupee'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NZD', val: rt.call_function('__', [
			rt.new_string('New Zealand dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'OMR', val: rt.call_function('__', [
			rt.new_string('Omani rial'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PAB', val: rt.call_function('__', [
			rt.new_string('Panamanian balboa'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PEN', val: rt.call_function('__', [
			rt.new_string('Sol'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PGK', val: rt.call_function('__', [
			rt.new_string('Papua New Guinean kina'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PHP', val: rt.call_function('__', [
			rt.new_string('Philippine peso'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PKR', val: rt.call_function('__', [
			rt.new_string('Pakistani rupee'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PLN', val: rt.call_function('__', [
			rt.new_string('Polish z&#x142;oty'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PRB', val: rt.call_function('__', [
			rt.new_string('Transnistrian ruble'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PYG', val: rt.call_function('__', [
			rt.new_string('Paraguayan guaran&iacute;'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'QAR', val: rt.call_function('__', [
			rt.new_string('Qatari riyal'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'RON', val: rt.call_function('__', [
			rt.new_string('Romanian leu'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'RSD', val: rt.call_function('__', [
			rt.new_string('Serbian dinar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'RUB', val: rt.call_function('__', [
			rt.new_string('Russian ruble'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'RWF', val: rt.call_function('__', [
			rt.new_string('Rwandan franc'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SAR', val: rt.call_function('__', [
			rt.new_string('Saudi riyal'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SBD', val: rt.call_function('__', [
			rt.new_string('Solomon Islands dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SCR', val: rt.call_function('__', [
			rt.new_string('Seychellois rupee'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SDG', val: rt.call_function('__', [
			rt.new_string('Sudanese pound'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SEK', val: rt.call_function('__', [
			rt.new_string('Swedish krona'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SGD', val: rt.call_function('__', [
			rt.new_string('Singapore dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SHP', val: rt.call_function('__', [
			rt.new_string('Saint Helena pound'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SLL', val: rt.call_function('__', [
			rt.new_string('Sierra Leonean leone'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SOS', val: rt.call_function('__', [
			rt.new_string('Somali shilling'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SRD', val: rt.call_function('__', [
			rt.new_string('Surinamese dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SSP', val: rt.call_function('__', [
			rt.new_string('South Sudanese pound'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'STN', val: rt.call_function('__', [
			rt.new_string('S&atilde;o Tom&eacute; and Pr&iacute;ncipe dobra'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SYP', val: rt.call_function('__', [
			rt.new_string('Syrian pound'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SZL', val: rt.call_function('__', [
			rt.new_string('Swazi lilangeni'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'THB', val: rt.call_function('__', [
			rt.new_string('Thai baht'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TJS', val: rt.call_function('__', [
			rt.new_string('Tajikistani somoni'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TMT', val: rt.call_function('__', [
			rt.new_string('Turkmenistan manat'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TND', val: rt.call_function('__', [
			rt.new_string('Tunisian dinar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TOP', val: rt.call_function('__', [
			rt.new_string('Tongan pa&#x2bb;anga'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TRY', val: rt.call_function('__', [
			rt.new_string('Turkish lira'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TTD', val: rt.call_function('__', [
			rt.new_string('Trinidad and Tobago dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TWD', val: rt.call_function('__', [
			rt.new_string('New Taiwan dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TZS', val: rt.call_function('__', [
			rt.new_string('Tanzanian shilling'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'UAH', val: rt.call_function('__', [
			rt.new_string('Ukrainian hryvnia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'UGX', val: rt.call_function('__', [
			rt.new_string('Ugandan shilling'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'USD', val: rt.call_function('__', [
			rt.new_string('United States (US) dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'UYU', val: rt.call_function('__', [
			rt.new_string('Uruguayan peso'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'UZS', val: rt.call_function('__', [
			rt.new_string('Uzbekistani som'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'VEF', val: rt.call_function('__', [
			rt.new_string('Venezuelan bol&iacute;var (2008–2018)'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'VES', val: rt.call_function('__', [
			rt.new_string('Venezuelan bol&iacute;var'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'VND', val: rt.call_function('__', [
			rt.new_string('Vietnamese &#x111;&#x1ed3;ng'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'VUV', val: rt.call_function('__', [
			rt.new_string('Vanuatu vatu'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'WST', val: rt.call_function('__', [
			rt.new_string('Samoan t&#x101;l&#x101;'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'XAF', val: rt.call_function('__', [
			rt.new_string('Central African CFA franc'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'XCD', val: rt.call_function('__', [
			rt.new_string('East Caribbean dollar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'XOF', val: rt.call_function('__', [
			rt.new_string('West African CFA franc'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'XPF', val: rt.call_function('__', [
			rt.new_string('CFP franc'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'YER', val: rt.call_function('__', [
			rt.new_string('Yemeni rial'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ZAR', val: rt.call_function('__', [
			rt.new_string('South African rand'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ZMW', val: rt.call_function('__', [
			rt.new_string('Zambian kwacha'),
			rt.new_string('woocommerce'),
		]) },
	])
}
