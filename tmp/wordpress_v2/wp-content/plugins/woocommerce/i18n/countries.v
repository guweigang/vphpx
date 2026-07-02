import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	return rt.create_array([
		rt.ArrayItem{ key: 'AF', val: rt.call_function('__', [
			rt.new_string('Afghanistan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AX', val: rt.call_function('__', [
			rt.new_string('Åland Islands'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AL', val: rt.call_function('__', [
			rt.new_string('Albania'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'DZ', val: rt.call_function('__', [
			rt.new_string('Algeria'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AS', val: rt.call_function('__', [
			rt.new_string('American Samoa'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AD', val: rt.call_function('__', [
			rt.new_string('Andorra'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AO', val: rt.call_function('__', [
			rt.new_string('Angola'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AI', val: rt.call_function('__', [
			rt.new_string('Anguilla'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AQ', val: rt.call_function('__', [
			rt.new_string('Antarctica'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AG', val: rt.call_function('__', [
			rt.new_string('Antigua and Barbuda'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AR', val: rt.call_function('__', [
			rt.new_string('Argentina'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AM', val: rt.call_function('__', [
			rt.new_string('Armenia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AW', val: rt.call_function('__', [
			rt.new_string('Aruba'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AU', val: rt.call_function('__', [
			rt.new_string('Australia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AT', val: rt.call_function('__', [
			rt.new_string('Austria'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AZ', val: rt.call_function('__', [
			rt.new_string('Azerbaijan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BS', val: rt.call_function('__', [
			rt.new_string('Bahamas'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BH', val: rt.call_function('__', [
			rt.new_string('Bahrain'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BD', val: rt.call_function('__', [
			rt.new_string('Bangladesh'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BB', val: rt.call_function('__', [
			rt.new_string('Barbados'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BY', val: rt.call_function('__', [
			rt.new_string('Belarus'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BE', val: rt.call_function('__', [
			rt.new_string('Belgium'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PW', val: rt.call_function('__', [
			rt.new_string('Belau'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BZ', val: rt.call_function('__', [
			rt.new_string('Belize'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BJ', val: rt.call_function('__', [
			rt.new_string('Benin'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BM', val: rt.call_function('__', [
			rt.new_string('Bermuda'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BT', val: rt.call_function('__', [
			rt.new_string('Bhutan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BO', val: rt.call_function('__', [
			rt.new_string('Bolivia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BQ', val: rt.call_function('__', [
			rt.new_string('Bonaire, Saint Eustatius and Saba'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BA', val: rt.call_function('__', [
			rt.new_string('Bosnia and Herzegovina'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BW', val: rt.call_function('__', [
			rt.new_string('Botswana'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BV', val: rt.call_function('__', [
			rt.new_string('Bouvet Island'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BR', val: rt.call_function('__', [
			rt.new_string('Brazil'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'IO', val: rt.call_function('__', [
			rt.new_string('British Indian Ocean Territory'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BN', val: rt.call_function('__', [
			rt.new_string('Brunei'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BG', val: rt.call_function('__', [
			rt.new_string('Bulgaria'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BF', val: rt.call_function('__', [
			rt.new_string('Burkina Faso'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BI', val: rt.call_function('__', [
			rt.new_string('Burundi'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KH', val: rt.call_function('__', [
			rt.new_string('Cambodia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CM', val: rt.call_function('__', [
			rt.new_string('Cameroon'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CA', val: rt.call_function('__', [
			rt.new_string('Canada'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CV', val: rt.call_function('__', [
			rt.new_string('Cape Verde'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KY', val: rt.call_function('__', [
			rt.new_string('Cayman Islands'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CF', val: rt.call_function('__', [
			rt.new_string('Central African Republic'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TD', val: rt.call_function('__', [
			rt.new_string('Chad'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CL', val: rt.call_function('__', [
			rt.new_string('Chile'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CN', val: rt.call_function('__', [
			rt.new_string('China'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CX', val: rt.call_function('__', [
			rt.new_string('Christmas Island'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CC', val: rt.call_function('__', [
			rt.new_string('Cocos (Keeling) Islands'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CO', val: rt.call_function('__', [
			rt.new_string('Colombia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KM', val: rt.call_function('__', [
			rt.new_string('Comoros'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CG', val: rt.call_function('__', [
			rt.new_string('Congo (Brazzaville)'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CD', val: rt.call_function('__', [
			rt.new_string('Congo (Kinshasa)'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CK', val: rt.call_function('__', [
			rt.new_string('Cook Islands'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CR', val: rt.call_function('__', [
			rt.new_string('Costa Rica'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'HR', val: rt.call_function('__', [
			rt.new_string('Croatia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CU', val: rt.call_function('__', [
			rt.new_string('Cuba'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CW', val: rt.call_function('__', [
			rt.new_string('Cura&ccedil;ao'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CY', val: rt.call_function('__', [
			rt.new_string('Cyprus'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CZ', val: rt.call_function('__', [
			rt.new_string('Czech Republic'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'DK', val: rt.call_function('__', [
			rt.new_string('Denmark'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'DJ', val: rt.call_function('__', [
			rt.new_string('Djibouti'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'DM', val: rt.call_function('__', [
			rt.new_string('Dominica'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'DO', val: rt.call_function('__', [
			rt.new_string('Dominican Republic'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'EC', val: rt.call_function('__', [
			rt.new_string('Ecuador'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'EG', val: rt.call_function('__', [
			rt.new_string('Egypt'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SV', val: rt.call_function('__', [
			rt.new_string('El Salvador'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GQ', val: rt.call_function('__', [
			rt.new_string('Equatorial Guinea'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ER', val: rt.call_function('__', [
			rt.new_string('Eritrea'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'EE', val: rt.call_function('__', [
			rt.new_string('Estonia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ET', val: rt.call_function('__', [
			rt.new_string('Ethiopia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'FK', val: rt.call_function('__', [
			rt.new_string('Falkland Islands'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'FO', val: rt.call_function('__', [
			rt.new_string('Faroe Islands'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'FJ', val: rt.call_function('__', [
			rt.new_string('Fiji'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'FI', val: rt.call_function('__', [
			rt.new_string('Finland'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'FR', val: rt.call_function('__', [
			rt.new_string('France'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GF', val: rt.call_function('__', [
			rt.new_string('French Guiana'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PF', val: rt.call_function('__', [
			rt.new_string('French Polynesia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TF', val: rt.call_function('__', [
			rt.new_string('French Southern Territories'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GA', val: rt.call_function('__', [
			rt.new_string('Gabon'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GM', val: rt.call_function('__', [
			rt.new_string('Gambia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GE', val: rt.call_function('__', [
			rt.new_string('Georgia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'DE', val: rt.call_function('__', [
			rt.new_string('Germany'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GH', val: rt.call_function('__', [
			rt.new_string('Ghana'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GI', val: rt.call_function('__', [
			rt.new_string('Gibraltar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GR', val: rt.call_function('__', [
			rt.new_string('Greece'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GL', val: rt.call_function('__', [
			rt.new_string('Greenland'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GD', val: rt.call_function('__', [
			rt.new_string('Grenada'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GP', val: rt.call_function('__', [
			rt.new_string('Guadeloupe'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GU', val: rt.call_function('__', [
			rt.new_string('Guam'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GT', val: rt.call_function('__', [
			rt.new_string('Guatemala'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GG', val: rt.call_function('__', [
			rt.new_string('Guernsey'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GN', val: rt.call_function('__', [
			rt.new_string('Guinea'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GW', val: rt.call_function('__', [
			rt.new_string('Guinea-Bissau'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GY', val: rt.call_function('__', [
			rt.new_string('Guyana'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'HT', val: rt.call_function('__', [
			rt.new_string('Haiti'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'HM', val: rt.call_function('__', [
			rt.new_string('Heard Island and McDonald Islands'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'HN', val: rt.call_function('__', [
			rt.new_string('Honduras'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'HK', val: rt.call_function('__', [
			rt.new_string('Hong Kong'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'HU', val: rt.call_function('__', [
			rt.new_string('Hungary'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'IS', val: rt.call_function('__', [
			rt.new_string('Iceland'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'IN', val: rt.call_function('__', [
			rt.new_string('India'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ID', val: rt.call_function('__', [
			rt.new_string('Indonesia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'IR', val: rt.call_function('__', [
			rt.new_string('Iran'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'IQ', val: rt.call_function('__', [
			rt.new_string('Iraq'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'IE', val: rt.call_function('__', [
			rt.new_string('Ireland'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'IM', val: rt.call_function('__', [
			rt.new_string('Isle of Man'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'IL', val: rt.call_function('__', [
			rt.new_string('Israel'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'IT', val: rt.call_function('__', [
			rt.new_string('Italy'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CI', val: rt.call_function('__', [
			rt.new_string('Ivory Coast'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'JM', val: rt.call_function('__', [
			rt.new_string('Jamaica'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'JP', val: rt.call_function('__', [
			rt.new_string('Japan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'JE', val: rt.call_function('__', [
			rt.new_string('Jersey'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'JO', val: rt.call_function('__', [
			rt.new_string('Jordan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KZ', val: rt.call_function('__', [
			rt.new_string('Kazakhstan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KE', val: rt.call_function('__', [
			rt.new_string('Kenya'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KI', val: rt.call_function('__', [
			rt.new_string('Kiribati'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'XK', val: rt.call_function('__', [
			rt.new_string('Kosovo'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KW', val: rt.call_function('__', [
			rt.new_string('Kuwait'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KG', val: rt.call_function('__', [
			rt.new_string('Kyrgyzstan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LA', val: rt.call_function('__', [
			rt.new_string('Laos'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LV', val: rt.call_function('__', [
			rt.new_string('Latvia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LB', val: rt.call_function('__', [
			rt.new_string('Lebanon'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LS', val: rt.call_function('__', [
			rt.new_string('Lesotho'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LR', val: rt.call_function('__', [
			rt.new_string('Liberia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LY', val: rt.call_function('__', [
			rt.new_string('Libya'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LI', val: rt.call_function('__', [
			rt.new_string('Liechtenstein'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LT', val: rt.call_function('__', [
			rt.new_string('Lithuania'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LU', val: rt.call_function('__', [
			rt.new_string('Luxembourg'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MO', val: rt.call_function('__', [
			rt.new_string('Macao'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MK', val: rt.call_function('__', [
			rt.new_string('North Macedonia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MG', val: rt.call_function('__', [
			rt.new_string('Madagascar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MW', val: rt.call_function('__', [
			rt.new_string('Malawi'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MY', val: rt.call_function('__', [
			rt.new_string('Malaysia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MV', val: rt.call_function('__', [
			rt.new_string('Maldives'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ML', val: rt.call_function('__', [
			rt.new_string('Mali'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MT', val: rt.call_function('__', [
			rt.new_string('Malta'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MH', val: rt.call_function('__', [
			rt.new_string('Marshall Islands'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MQ', val: rt.call_function('__', [
			rt.new_string('Martinique'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MR', val: rt.call_function('__', [
			rt.new_string('Mauritania'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MU', val: rt.call_function('__', [
			rt.new_string('Mauritius'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'YT', val: rt.call_function('__', [
			rt.new_string('Mayotte'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MX', val: rt.call_function('__', [
			rt.new_string('Mexico'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'FM', val: rt.call_function('__', [
			rt.new_string('Micronesia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MD', val: rt.call_function('__', [
			rt.new_string('Moldova'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MC', val: rt.call_function('__', [
			rt.new_string('Monaco'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MN', val: rt.call_function('__', [
			rt.new_string('Mongolia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ME', val: rt.call_function('__', [
			rt.new_string('Montenegro'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MS', val: rt.call_function('__', [
			rt.new_string('Montserrat'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MA', val: rt.call_function('__', [
			rt.new_string('Morocco'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MZ', val: rt.call_function('__', [
			rt.new_string('Mozambique'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MM', val: rt.call_function('__', [
			rt.new_string('Myanmar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NA', val: rt.call_function('__', [
			rt.new_string('Namibia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NR', val: rt.call_function('__', [
			rt.new_string('Nauru'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NP', val: rt.call_function('__', [
			rt.new_string('Nepal'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NL', val: rt.call_function('__', [
			rt.new_string('Netherlands'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NC', val: rt.call_function('__', [
			rt.new_string('New Caledonia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NZ', val: rt.call_function('__', [
			rt.new_string('New Zealand'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NI', val: rt.call_function('__', [
			rt.new_string('Nicaragua'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NE', val: rt.call_function('__', [
			rt.new_string('Niger'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NG', val: rt.call_function('__', [
			rt.new_string('Nigeria'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NU', val: rt.call_function('__', [
			rt.new_string('Niue'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NF', val: rt.call_function('__', [
			rt.new_string('Norfolk Island'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MP', val: rt.call_function('__', [
			rt.new_string('Northern Mariana Islands'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KP', val: rt.call_function('__', [
			rt.new_string('North Korea'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'NO', val: rt.call_function('__', [
			rt.new_string('Norway'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'OM', val: rt.call_function('__', [
			rt.new_string('Oman'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PK', val: rt.call_function('__', [
			rt.new_string('Pakistan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PS', val: rt.call_function('__', [
			rt.new_string('Palestinian Territory'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PA', val: rt.call_function('__', [
			rt.new_string('Panama'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PG', val: rt.call_function('__', [
			rt.new_string('Papua New Guinea'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PY', val: rt.call_function('__', [
			rt.new_string('Paraguay'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PE', val: rt.call_function('__', [
			rt.new_string('Peru'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PH', val: rt.call_function('__', [
			rt.new_string('Philippines'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PN', val: rt.call_function('__', [
			rt.new_string('Pitcairn'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PL', val: rt.call_function('__', [
			rt.new_string('Poland'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PT', val: rt.call_function('__', [
			rt.new_string('Portugal'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PR', val: rt.call_function('__', [
			rt.new_string('Puerto Rico'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'QA', val: rt.call_function('__', [
			rt.new_string('Qatar'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'RE', val: rt.call_function('__', [
			rt.new_string('Reunion'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'RO', val: rt.call_function('__', [
			rt.new_string('Romania'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'RU', val: rt.call_function('__', [
			rt.new_string('Russia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'RW', val: rt.call_function('__', [
			rt.new_string('Rwanda'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'BL', val: rt.call_function('__', [
			rt.new_string('Saint Barth&eacute;lemy'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SH', val: rt.call_function('__', [
			rt.new_string('Saint Helena'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KN', val: rt.call_function('__', [
			rt.new_string('Saint Kitts and Nevis'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LC', val: rt.call_function('__', [
			rt.new_string('Saint Lucia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'MF', val: rt.call_function('__', [
			rt.new_string('Saint Martin (French part)'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SX', val: rt.call_function('__', [
			rt.new_string('Saint Martin (Dutch part)'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'PM', val: rt.call_function('__', [
			rt.new_string('Saint Pierre and Miquelon'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'VC', val: rt.call_function('__', [
			rt.new_string('Saint Vincent and the Grenadines'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SM', val: rt.call_function('__', [
			rt.new_string('San Marino'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ST', val: rt.call_function('__', [
			rt.new_string('S&atilde;o Tom&eacute; and Pr&iacute;ncipe'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SA', val: rt.call_function('__', [
			rt.new_string('Saudi Arabia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SN', val: rt.call_function('__', [
			rt.new_string('Senegal'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'RS', val: rt.call_function('__', [
			rt.new_string('Serbia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SC', val: rt.call_function('__', [
			rt.new_string('Seychelles'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SL', val: rt.call_function('__', [
			rt.new_string('Sierra Leone'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SG', val: rt.call_function('__', [
			rt.new_string('Singapore'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SK', val: rt.call_function('__', [
			rt.new_string('Slovakia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SI', val: rt.call_function('__', [
			rt.new_string('Slovenia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SB', val: rt.call_function('__', [
			rt.new_string('Solomon Islands'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SO', val: rt.call_function('__', [
			rt.new_string('Somalia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ZA', val: rt.call_function('__', [
			rt.new_string('South Africa'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GS', val: rt.call_function('__', [
			rt.new_string('South Georgia/Sandwich Islands'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'KR', val: rt.call_function('__', [
			rt.new_string('South Korea'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SS', val: rt.call_function('__', [
			rt.new_string('South Sudan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ES', val: rt.call_function('__', [
			rt.new_string('Spain'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'LK', val: rt.call_function('__', [
			rt.new_string('Sri Lanka'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SD', val: rt.call_function('__', [
			rt.new_string('Sudan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SR', val: rt.call_function('__', [
			rt.new_string('Suriname'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SJ', val: rt.call_function('__', [
			rt.new_string('Svalbard and Jan Mayen'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SZ', val: rt.call_function('__', [
			rt.new_string('Eswatini'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SE', val: rt.call_function('__', [
			rt.new_string('Sweden'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'CH', val: rt.call_function('__', [
			rt.new_string('Switzerland'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'SY', val: rt.call_function('__', [
			rt.new_string('Syria'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TW', val: rt.call_function('__', [
			rt.new_string('Taiwan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TJ', val: rt.call_function('__', [
			rt.new_string('Tajikistan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TZ', val: rt.call_function('__', [
			rt.new_string('Tanzania'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TH', val: rt.call_function('__', [
			rt.new_string('Thailand'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TL', val: rt.call_function('__', [
			rt.new_string('Timor-Leste'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TG', val: rt.call_function('__', [
			rt.new_string('Togo'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TK', val: rt.call_function('__', [
			rt.new_string('Tokelau'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TO', val: rt.call_function('__', [
			rt.new_string('Tonga'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TT', val: rt.call_function('__', [
			rt.new_string('Trinidad and Tobago'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TN', val: rt.call_function('__', [
			rt.new_string('Tunisia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TR', val: rt.call_function('__', [
			rt.new_string('Türkiye'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TM', val: rt.call_function('__', [
			rt.new_string('Turkmenistan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TC', val: rt.call_function('__', [
			rt.new_string('Turks and Caicos Islands'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'TV', val: rt.call_function('__', [
			rt.new_string('Tuvalu'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'UG', val: rt.call_function('__', [
			rt.new_string('Uganda'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'UA', val: rt.call_function('__', [
			rt.new_string('Ukraine'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'AE', val: rt.call_function('__', [
			rt.new_string('United Arab Emirates'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'GB', val: rt.call_function('__', [
			rt.new_string('United Kingdom (UK)'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'US', val: rt.call_function('__', [
			rt.new_string('United States (US)'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'UM', val: rt.call_function('__', [
			rt.new_string('United States (US) Minor Outlying Islands'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'UY', val: rt.call_function('__', [
			rt.new_string('Uruguay'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'UZ', val: rt.call_function('__', [
			rt.new_string('Uzbekistan'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'VU', val: rt.call_function('__', [
			rt.new_string('Vanuatu'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'VA', val: rt.call_function('__', [
			rt.new_string('Vatican'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'VE', val: rt.call_function('__', [
			rt.new_string('Venezuela'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'VN', val: rt.call_function('__', [
			rt.new_string('Vietnam'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'VG', val: rt.call_function('__', [
			rt.new_string('Virgin Islands (British)'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'VI', val: rt.call_function('__', [
			rt.new_string('Virgin Islands (US)'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'WF', val: rt.call_function('__', [
			rt.new_string('Wallis and Futuna'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'EH', val: rt.call_function('__', [
			rt.new_string('Western Sahara'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'WS', val: rt.call_function('__', [
			rt.new_string('Samoa'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'YE', val: rt.call_function('__', [
			rt.new_string('Yemen'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ZM', val: rt.call_function('__', [
			rt.new_string('Zambia'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'ZW', val: rt.call_function('__', [
			rt.new_string('Zimbabwe'),
			rt.new_string('woocommerce'),
		]) },
	])
}
