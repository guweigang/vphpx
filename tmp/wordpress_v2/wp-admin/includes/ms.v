import rt

fn check_upload_size(var_file rt.PhpVal) rt.PhpVal {
	mut var_space_left := rt.new_null()
	mut var_file_size := rt.new_null()
	if rt.is_true(rt.call_function('get_site_option', [
		rt.new_string('upload_space_check_disabled'),
	]))
	{
		return var_file.clone()
	}
	if rt.is_true(rt.greater(var_file.array_get(rt.new_string('error')), rt.new_int(0))) {
		return var_file.clone()
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_IMPORTING')])) {
		return var_file.clone()
	}
	var_space_left = rt.call_function('get_upload_space_available', []rt.PhpVal{})
	var_file_size = rt.call_function('filesize', [
		var_file.array_get(rt.new_string('tmp_name')),
	])
	if rt.is_true(rt.less(var_space_left, var_file_size)) {
		var_file['error'] = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Not enough space to upload. %s KB needed.'),
			]),
			rt.call_function('number_format', [
				rt.div(rt.sub(var_file_size, var_space_left), rt.get_constant('KB_IN_BYTES')),
			]),
		])
	}
	if rt.is_true(rt.greater(var_file_size, rt.mul(rt.get_constant('KB_IN_BYTES'), rt.call_function('get_site_option', [
		rt.new_string('fileupload_maxk'),
		rt.new_int(1500),
	]))))
	{
		var_file['error'] = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('This file is too big. Files must be less than %s KB in size.'),
			]),
			rt.call_function('get_site_option', [
				rt.new_string('fileupload_maxk'),
				rt.new_int(1500),
			]),
		])
	}
	if rt.is_true(rt.new_bool(upload_is_user_over_quota(false))) {
		var_file['error'] = rt.call_function('__', [
			rt.new_string('You have used your space quota. Please delete files before uploading.'),
		])
	}
	if rt.is_true(rt.greater(var_file.array_get(rt.new_string('error')), rt.new_int(0)))
		&& !(rt.get_superglobal('_POST').array_isset(rt.new_string('html-upload')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))))) {
		rt.call_function('wp_die', [
			rt.new_string(
				(var_file.array_get(rt.new_string('error'))).str() + ' <a href="javascript:history.go(-1)">' + (rt.call_function('__', [rt.new_string('Back')])).str() +
				'</a>'),
		])
	}
	return var_file.clone()
}

fn wpmu_delete_blog(var_blog_id_arg rt.PhpVal, drop bool) {
	mut var_drop := drop
	mut var_blog_id := var_blog_id_arg
	mut var_switch := false
	mut var_blog := rt.new_null()
	mut var_current_network := rt.new_null()
	mut var_upload_path := ''
	mut var_users := rt.new_null()
	mut var_user_id := rt.new_null()
	var_blog_id = rt.new_int(var_blog_id.to_i64())
	var_switch = false
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_blog_id',
		[]rt.PhpVal{}), var_blog_id))))
	{
		var_switch = true
		rt.call_function('switch_to_blog', [var_blog_id.clone()])
	}
	var_blog = rt.call_function('get_site', [var_blog_id.clone()])
	var_current_network = rt.call_function('get_network', []rt.PhpVal{})
	if var_drop && rt.is_true(rt.new_bool(!(rt.is_true(var_blog)))) {
		var_drop = false
	}
	if var_drop && rt.is_true(rt.identical(rt.new_int(1), var_blog_id))
		|| rt.is_true(rt.call_function('is_main_site', [var_blog_id.clone()]))|| (rt.is_true(rt.identical(rt.get_property(var_blog, 'path'), rt.get_property(var_current_network, 'path')))
		&& rt.is_true(rt.identical(rt.get_property(var_blog, 'domain'), rt.get_property(var_current_network, 'domain')))) {
		var_drop = false
	}
	var_upload_path =
		rt.call_function('get_option', [rt.new_string('upload_path')]).to_string().trim_space()
	if var_drop
		&& rt.is_true(rt.call_function('get_site_option', [rt.new_string('ms_files_rewriting')]))
		&& var_upload_path == '' {
		var_drop = false
	}
	if var_drop {
		rt.call_function('wp_delete_site', [var_blog_id.clone()])
	} else {
		rt.call_function('do_action_deprecated', [rt.new_string('delete_blog'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_blog_id },
				rt.ArrayItem{ key: none, val: false }]),
			rt.new_string('5.1.0')])
		var_users = rt.call_function('get_users', [
			rt.create_array([rt.ArrayItem{ key: 'blog_id', val: var_blog_id },
				rt.ArrayItem{ key: 'fields', val: 'ids' }]),
		])
		if !(!rt.is_true(var_users)) {
			mut iter_1 := var_users.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_user_id_shadow := item_1.val
				rt.call_function('remove_user_from_blog', [var_user_id_shadow.clone(),
					var_blog_id.clone()])
			}
		}
		rt.call_function('update_blog_status', [var_blog_id.clone(),
			rt.new_string('deleted'), rt.new_int(1)])
		rt.call_function('do_action_deprecated', [rt.new_string('deleted_blog'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_blog_id },
				rt.ArrayItem{ key: none, val: false }]),
			rt.new_string('5.1.0')])
	}
	if var_switch {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
}

fn wpmu_delete_user(var_id_arg rt.PhpVal) bool {
	mut var_id := var_id_arg
	mut var_wpdb := rt.new_null()
	mut var_user := rt.new_null()
	mut var__super_admins := rt.new_null()
	mut var_blogs := rt.new_null()
	mut var_blog := rt.new_null()
	mut var_post_ids := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_link_ids := rt.new_null()
	mut var_link_id := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_mid := rt.new_null()
	if !(var_id.clone().is_long() || var_id.clone().is_double()) {
		return false
	}
	var_id = rt.new_int(var_id.to_i64())
	var_user = create_wp_user(var_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))) {
		return false
	}
	var__super_admins = rt.call_function('get_super_admins', []rt.PhpVal{})
	if rt.is_true(rt.call_function('in_array', [rt.get_property(var_user, 'user_login'),
		var__super_admins.clone(), rt.new_bool(true)]))
	{
		return false
	}
	rt.call_function('do_action', [rt.new_string('wpmu_delete_user'),
		var_id.clone(), var_user.clone()])
	var_blogs = rt.call_function('get_blogs_of_user', [var_id.clone()])
	if !(!rt.is_true(var_blogs)) {
		mut iter_2 := var_blogs.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_blog_shadow := item_2.val
			rt.call_function('switch_to_blog', [
				rt.get_property(var_blog_shadow, 'userblog_id'),
			])
			rt.call_function('remove_user_from_blog', [var_id.clone(),
				rt.get_property(var_blog_shadow, 'userblog_id')])
			var_post_ids = rt.call_method(var_wpdb, 'get_col', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
						'posts')), rt.new_string(' WHERE post_author = %d')),
					var_id.clone(),
				]),
			])
			mut iter_3 := rt.cast_array(var_post_ids).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_post_id_shadow := item_3.val
				rt.call_function('wp_delete_post', [var_post_id_shadow.clone()])
			}
			var_link_ids = rt.call_method(var_wpdb, 'get_col', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('SELECT link_id FROM '), rt.get_property(var_wpdb,
						'links')), rt.new_string(' WHERE link_owner = %d')),
					var_id.clone(),
				]),
			])
			if rt.is_true(var_link_ids) {
				mut iter_4 := var_link_ids.iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_link_id_shadow := item_4.val
					rt.call_function('wp_delete_link', [var_link_id_shadow.clone()])
				}
			}
			rt.call_function('restore_current_blog', []rt.PhpVal{})
		}
	}
	var_meta = rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT umeta_id FROM '), rt.get_property(var_wpdb,
				'usermeta')), rt.new_string(' WHERE user_id = %d')),
			var_id.clone(),
		]),
	])
	mut iter_5 := var_meta.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_mid_shadow := item_5.val
		rt.call_function('delete_metadata_by_mid', [rt.new_string('user'),
			var_mid_shadow.clone()])
	}
	rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'users'),
		rt.create_array([rt.ArrayItem{ key: 'ID', val: var_id }])])
	rt.call_function('clean_user_cache', [var_user.clone()])
	rt.call_function('do_action', [rt.new_string('deleted_user'),
		var_id.clone(), rt.new_null(), var_user.clone()])
	return true
}

fn upload_is_user_over_quota(display_message bool) bool {
	mut var_display_message := display_message
	mut var_space_allowed := rt.new_null()
	mut var_space_used := rt.new_null()
	if rt.is_true(rt.call_function('get_site_option', [
		rt.new_string('upload_space_check_disabled'),
	]))
	{
		return false
	}
	var_space_allowed = rt.call_function('get_space_allowed', []rt.PhpVal{})
	if !(var_space_allowed.clone().is_long() || var_space_allowed.clone().is_double()) {
		var_space_allowed = rt.new_int(10)
	}
	var_space_used = rt.call_function('get_space_used', []rt.PhpVal{})
	if rt.is_true(rt.less(rt.sub(var_space_allowed, var_space_used), rt.new_int(0))) {
		if var_display_message {
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('Sorry, you have used your space allocation of %s. Please delete some files to upload more files.'),
				]),
				rt.call_function('size_format', [
					rt.mul(var_space_allowed, rt.get_constant('MB_IN_BYTES')),
				]),
			])
		}
		return true
	} else {
		return false
	}
	return false
}

fn display_space_usage() {
	mut var_space_allowed := rt.new_null()
	mut var_space_used := rt.new_null()
	mut var_percent_used := rt.new_null()
	mut var_space := rt.new_null()
	var_space_allowed = rt.call_function('get_space_allowed', []rt.PhpVal{})
	var_space_used = rt.call_function('get_space_used', []rt.PhpVal{})
	var_percent_used = rt.mul(rt.div(var_space_used, var_space_allowed), rt.new_int(100))
	var_space = rt.call_function('size_format', [
		rt.mul(var_space_allowed, rt.get_constant('MB_IN_BYTES')),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Used: %1$s%% of %2$s')]),
		rt.call_function('number_format', [var_percent_used.clone()]),
		var_space.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn fix_import_form_size(var_size rt.PhpVal) i64 {
	mut var_available := rt.new_null()
	if rt.is_true(rt.new_bool(upload_is_user_over_quota(false))) {
		return 0
	}
	var_available = rt.call_function('get_upload_space_available', []rt.PhpVal{})
	return (rt.call_function('min', [var_size.clone(), var_available.clone()])).to_i64()
}

fn upload_space_setting(var_id rt.PhpVal) {
	mut var_quota := rt.new_null()
	rt.call_function('switch_to_blog', [var_id.clone()])
	var_quota = rt.call_function('get_option', [rt.new_string('blog_upload_space')])
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_quota)))) {
		var_quota = rt.new_string('')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Site Upload Space Quota')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_quota.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Size in megabytes')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('MB (Leave blank for network default)')])
	// unsupported statement: Stmt_InlineHTML
}

fn refresh_user_details(var_id_arg rt.PhpVal) bool {
	mut var_id := var_id_arg
	mut var_user := rt.new_null()
	var_id = rt.new_int(var_id.to_i64())
	var_user = rt.call_function('get_userdata', [var_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return false
	}
	rt.call_function('clean_user_cache', [var_user.clone()])
	return var_id.to_bool()
}

fn format_code_lang(code string) rt.PhpVal {
	mut var_code := code
	mut var_lang_codes := rt.new_null()
	var_code = rt.call_function('substr', [rt.new_string(var_code.str()),
		rt.new_int(0), rt.new_int(2)]).to_string().to_lower()
	var_lang_codes = rt.create_array([rt.ArrayItem{ key: 'aa', val: 'Afar' },
		rt.ArrayItem{ key: 'ab', val: 'Abkhazian' }, rt.ArrayItem{ key: 'af', val: 'Afrikaans' },
		rt.ArrayItem{ key: 'ak', val: 'Akan' }, rt.ArrayItem{ key: 'sq', val: 'Albanian' },
		rt.ArrayItem{ key: 'am', val: 'Amharic' }, rt.ArrayItem{ key: 'ar', val: 'Arabic' },
		rt.ArrayItem{ key: 'an', val: 'Aragonese' }, rt.ArrayItem{ key: 'hy', val: 'Armenian' },
		rt.ArrayItem{ key: 'as', val: 'Assamese' }, rt.ArrayItem{ key: 'av', val: 'Avaric' },
		rt.ArrayItem{ key: 'ae', val: 'Avestan' }, rt.ArrayItem{ key: 'ay', val: 'Aymara' },
		rt.ArrayItem{ key: 'az', val: 'Azerbaijani' }, rt.ArrayItem{ key: 'ba', val: 'Bashkir' },
		rt.ArrayItem{ key: 'bm', val: 'Bambara' }, rt.ArrayItem{ key: 'eu', val: 'Basque' },
		rt.ArrayItem{ key: 'be', val: 'Belarusian' }, rt.ArrayItem{ key: 'bn', val: 'Bengali' },
		rt.ArrayItem{ key: 'bh', val: 'Bihari' }, rt.ArrayItem{ key: 'bi', val: 'Bislama' },
		rt.ArrayItem{ key: 'bs', val: 'Bosnian' }, rt.ArrayItem{ key: 'br', val: 'Breton' },
		rt.ArrayItem{ key: 'bg', val: 'Bulgarian' }, rt.ArrayItem{ key: 'my', val: 'Burmese' },
		rt.ArrayItem{ key: 'ca', val: 'Catalan; Valencian' },
		rt.ArrayItem{ key: 'ch', val: 'Chamorro' }, rt.ArrayItem{ key: 'ce', val: 'Chechen' },
		rt.ArrayItem{ key: 'zh', val: 'Chinese' }, rt.ArrayItem{
			key: 'cu'
			val: 'Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic'
		}, rt.ArrayItem{ key: 'cv', val: 'Chuvash' }, rt.ArrayItem{ key: 'kw', val: 'Cornish' },
		rt.ArrayItem{ key: 'co', val: 'Corsican' }, rt.ArrayItem{ key: 'cr', val: 'Cree' },
		rt.ArrayItem{ key: 'cs', val: 'Czech' }, rt.ArrayItem{ key: 'da', val: 'Danish' },
		rt.ArrayItem{ key: 'dv', val: 'Divehi; Dhivehi; Maldivian' },
		rt.ArrayItem{ key: 'nl', val: 'Dutch; Flemish' }, rt.ArrayItem{ key: 'dz', val: 'Dzongkha' },
		rt.ArrayItem{ key: 'en', val: 'English' }, rt.ArrayItem{ key: 'eo', val: 'Esperanto' },
		rt.ArrayItem{ key: 'et', val: 'Estonian' }, rt.ArrayItem{ key: 'ee', val: 'Ewe' },
		rt.ArrayItem{ key: 'fo', val: 'Faroese' }, rt.ArrayItem{ key: 'fj', val: 'Fijjian' },
		rt.ArrayItem{ key: 'fi', val: 'Finnish' }, rt.ArrayItem{ key: 'fr', val: 'French' },
		rt.ArrayItem{ key: 'fy', val: 'Western Frisian' }, rt.ArrayItem{ key: 'ff', val: 'Fulah' },
		rt.ArrayItem{ key: 'ka', val: 'Georgian' }, rt.ArrayItem{ key: 'de', val: 'German' },
		rt.ArrayItem{ key: 'gd', val: 'Gaelic; Scottish Gaelic' },
		rt.ArrayItem{ key: 'ga', val: 'Irish' }, rt.ArrayItem{ key: 'gl', val: 'Galician' },
		rt.ArrayItem{ key: 'gv', val: 'Manx' }, rt.ArrayItem{ key: 'el', val: 'Greek, Modern' },
		rt.ArrayItem{ key: 'gn', val: 'Guarani' }, rt.ArrayItem{ key: 'gu', val: 'Gujarati' },
		rt.ArrayItem{ key: 'ht', val: 'Haitian; Haitian Creole' },
		rt.ArrayItem{ key: 'ha', val: 'Hausa' }, rt.ArrayItem{ key: 'he', val: 'Hebrew' },
		rt.ArrayItem{ key: 'hz', val: 'Herero' }, rt.ArrayItem{ key: 'hi', val: 'Hindi' },
		rt.ArrayItem{ key: 'ho', val: 'Hiri Motu' }, rt.ArrayItem{ key: 'hu', val: 'Hungarian' },
		rt.ArrayItem{ key: 'ig', val: 'Igbo' }, rt.ArrayItem{ key: 'is', val: 'Icelandic' },
		rt.ArrayItem{ key: 'io', val: 'Ido' }, rt.ArrayItem{ key: 'ii', val: 'Sichuan Yi' },
		rt.ArrayItem{ key: 'iu', val: 'Inuktitut' }, rt.ArrayItem{ key: 'ie', val: 'Interlingue' },
		rt.ArrayItem{ key: 'ia', val: 'Interlingua (International Auxiliary Language Association)' },
		rt.ArrayItem{ key: 'id', val: 'Indonesian' }, rt.ArrayItem{ key: 'ik', val: 'Inupiaq' },
		rt.ArrayItem{ key: 'it', val: 'Italian' }, rt.ArrayItem{ key: 'jv', val: 'Javanese' },
		rt.ArrayItem{ key: 'ja', val: 'Japanese' }, rt.ArrayItem{
			key: 'kl'
			val: 'Kalaallisut; Greenlandic'
		}, rt.ArrayItem{ key: 'kn', val: 'Kannada' }, rt.ArrayItem{ key: 'ks', val: 'Kashmiri' },
		rt.ArrayItem{ key: 'kr', val: 'Kanuri' }, rt.ArrayItem{ key: 'kk', val: 'Kazakh' },
		rt.ArrayItem{ key: 'km', val: 'Central Khmer' }, rt.ArrayItem{
			key: 'ki'
			val: 'Kikuyu; Gikuyu'
		}, rt.ArrayItem{ key: 'rw', val: 'Kinyarwanda' }, rt.ArrayItem{
			key: 'ky'
			val: 'Kirghiz; Kyrgyz'
		}, rt.ArrayItem{ key: 'kv', val: 'Komi' }, rt.ArrayItem{ key: 'kg', val: 'Kongo' },
		rt.ArrayItem{ key: 'ko', val: 'Korean' }, rt.ArrayItem{ key: 'kj', val: 'Kuanyama; Kwanyama' },
		rt.ArrayItem{ key: 'ku', val: 'Kurdish' }, rt.ArrayItem{ key: 'lo', val: 'Lao' },
		rt.ArrayItem{ key: 'la', val: 'Latin' }, rt.ArrayItem{ key: 'lv', val: 'Latvian' },
		rt.ArrayItem{ key: 'li', val: 'Limburgan; Limburger; Limburgish' },
		rt.ArrayItem{ key: 'ln', val: 'Lingala' }, rt.ArrayItem{ key: 'lt', val: 'Lithuanian' },
		rt.ArrayItem{ key: 'lb', val: 'Luxembourgish; Letzeburgesch' },
		rt.ArrayItem{ key: 'lu', val: 'Luba-Katanga' }, rt.ArrayItem{ key: 'lg', val: 'Ganda' },
		rt.ArrayItem{ key: 'mk', val: 'Macedonian' }, rt.ArrayItem{ key: 'mh', val: 'Marshallese' },
		rt.ArrayItem{ key: 'ml', val: 'Malayalam' }, rt.ArrayItem{ key: 'mi', val: 'Maori' },
		rt.ArrayItem{ key: 'mr', val: 'Marathi' }, rt.ArrayItem{ key: 'ms', val: 'Malay' },
		rt.ArrayItem{ key: 'mg', val: 'Malagasy' }, rt.ArrayItem{ key: 'mt', val: 'Maltese' },
		rt.ArrayItem{ key: 'mo', val: 'Moldavian' }, rt.ArrayItem{ key: 'mn', val: 'Mongolian' },
		rt.ArrayItem{ key: 'na', val: 'Nauru' }, rt.ArrayItem{ key: 'nv', val: 'Navajo; Navaho' },
		rt.ArrayItem{ key: 'nr', val: 'Ndebele, South; South Ndebele' },
		rt.ArrayItem{ key: 'nd', val: 'Ndebele, North; North Ndebele' },
		rt.ArrayItem{ key: 'ng', val: 'Ndonga' }, rt.ArrayItem{ key: 'ne', val: 'Nepali' },
		rt.ArrayItem{ key: 'nn', val: 'Norwegian Nynorsk; Nynorsk, Norwegian' },
		rt.ArrayItem{ key: 'nb', val: 'Bokmål, Norwegian, Norwegian Bokmål' },
		rt.ArrayItem{ key: 'no', val: 'Norwegian' }, rt.ArrayItem{
			key: 'ny'
			val: 'Chichewa; Chewa; Nyanja'
		}, rt.ArrayItem{ key: 'oc', val: 'Occitan, Provençal' },
		rt.ArrayItem{ key: 'oj', val: 'Ojibwa' }, rt.ArrayItem{ key: 'or', val: 'Oriya' },
		rt.ArrayItem{ key: 'om', val: 'Oromo' }, rt.ArrayItem{ key: 'os', val: 'Ossetian; Ossetic' },
		rt.ArrayItem{ key: 'pa', val: 'Panjabi; Punjabi' }, rt.ArrayItem{ key: 'fa', val: 'Persian' },
		rt.ArrayItem{ key: 'pi', val: 'Pali' }, rt.ArrayItem{ key: 'pl', val: 'Polish' },
		rt.ArrayItem{ key: 'pt', val: 'Portuguese' }, rt.ArrayItem{ key: 'ps', val: 'Pushto' },
		rt.ArrayItem{ key: 'qu', val: 'Quechua' }, rt.ArrayItem{ key: 'rm', val: 'Romansh' },
		rt.ArrayItem{ key: 'ro', val: 'Romanian' }, rt.ArrayItem{ key: 'rn', val: 'Rundi' },
		rt.ArrayItem{ key: 'ru', val: 'Russian' }, rt.ArrayItem{ key: 'sg', val: 'Sango' },
		rt.ArrayItem{ key: 'sa', val: 'Sanskrit' }, rt.ArrayItem{ key: 'sr', val: 'Serbian' },
		rt.ArrayItem{ key: 'hr', val: 'Croatian' }, rt.ArrayItem{
			key: 'si'
			val: 'Sinhala; Sinhalese'
		}, rt.ArrayItem{ key: 'sk', val: 'Slovak' }, rt.ArrayItem{ key: 'sl', val: 'Slovenian' },
		rt.ArrayItem{ key: 'se', val: 'Northern Sami' }, rt.ArrayItem{ key: 'sm', val: 'Samoan' },
		rt.ArrayItem{ key: 'sn', val: 'Shona' }, rt.ArrayItem{ key: 'sd', val: 'Sindhi' },
		rt.ArrayItem{ key: 'so', val: 'Somali' }, rt.ArrayItem{ key: 'st', val: 'Sotho, Southern' },
		rt.ArrayItem{ key: 'es', val: 'Spanish; Castilian' },
		rt.ArrayItem{ key: 'sc', val: 'Sardinian' }, rt.ArrayItem{ key: 'ss', val: 'Swati' },
		rt.ArrayItem{ key: 'su', val: 'Sundanese' }, rt.ArrayItem{ key: 'sw', val: 'Swahili' },
		rt.ArrayItem{ key: 'sv', val: 'Swedish' }, rt.ArrayItem{ key: 'ty', val: 'Tahitian' },
		rt.ArrayItem{ key: 'ta', val: 'Tamil' }, rt.ArrayItem{ key: 'tt', val: 'Tatar' },
		rt.ArrayItem{ key: 'te', val: 'Telugu' }, rt.ArrayItem{ key: 'tg', val: 'Tajik' },
		rt.ArrayItem{ key: 'tl', val: 'Tagalog' }, rt.ArrayItem{ key: 'th', val: 'Thai' },
		rt.ArrayItem{ key: 'bo', val: 'Tibetan' }, rt.ArrayItem{ key: 'ti', val: 'Tigrinya' },
		rt.ArrayItem{ key: 'to', val: 'Tonga (Tonga Islands)' },
		rt.ArrayItem{ key: 'tn', val: 'Tswana' }, rt.ArrayItem{ key: 'ts', val: 'Tsonga' },
		rt.ArrayItem{ key: 'tk', val: 'Turkmen' }, rt.ArrayItem{ key: 'tr', val: 'Turkish' },
		rt.ArrayItem{ key: 'tw', val: 'Twi' }, rt.ArrayItem{ key: 'ug', val: 'Uighur; Uyghur' },
		rt.ArrayItem{ key: 'uk', val: 'Ukrainian' }, rt.ArrayItem{ key: 'ur', val: 'Urdu' },
		rt.ArrayItem{ key: 'uz', val: 'Uzbek' }, rt.ArrayItem{ key: 've', val: 'Venda' },
		rt.ArrayItem{ key: 'vi', val: 'Vietnamese' }, rt.ArrayItem{ key: 'vo', val: 'Volapük' },
		rt.ArrayItem{ key: 'cy', val: 'Welsh' }, rt.ArrayItem{ key: 'wa', val: 'Walloon' },
		rt.ArrayItem{ key: 'wo', val: 'Wolof' }, rt.ArrayItem{ key: 'xh', val: 'Xhosa' },
		rt.ArrayItem{ key: 'yi', val: 'Yiddish' }, rt.ArrayItem{ key: 'yo', val: 'Yoruba' },
		rt.ArrayItem{ key: 'za', val: 'Zhuang; Chuang' }, rt.ArrayItem{ key: 'zu', val: 'Zulu' }])
	var_lang_codes = rt.call_function('apply_filters', [rt.new_string('lang_codes'),
		var_lang_codes.clone(), rt.new_string(var_code.str())])
	return rt.call_function('strtr', [rt.new_string(var_code.str()),
		var_lang_codes.clone()])
}

fn _access_denied_splash() {
	mut var_blogs := rt.new_null()
	mut var_blog_name := rt.new_null()
	mut var_output := rt.new_null()
	mut var_blog := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))
		|| rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		return
	}
	var_blogs = rt.call_function('get_blogs_of_user', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
	])
	if rt.is_true(rt.call_function('wp_list_filter', [var_blogs.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'userblog_id', val: rt.call_function('get_current_blog_id',
				[]rt.PhpVal{}) },
		])]))
	{
		return
	}
	var_blog_name = rt.call_function('get_bloginfo', [rt.new_string('name')])
	if !rt.is_true(var_blogs) {
		rt.call_function('wp_die', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('You attempted to access the "%1$s" dashboard, but you do not currently have privileges on this site. If you believe you should be able to access the "%1$s" dashboard, please contact your network administrator.'),
				]),
				var_blog_name.clone(),
			]),
			rt.new_int(403),
		])
	}
	var_output = rt.new_string('<p>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You attempted to access the "%1$s" dashboard, but you do not currently have privileges on this site. If you believe you should be able to access the "%1$s" dashboard, please contact your network administrator.')]), var_blog_name.clone()])).str() +
		'</p>')
	var_output = rt.concat(var_output, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('If you reached this screen by accident and meant to visit one of your own sites, here are some shortcuts to help you find your way.')])).str() +
		'</p>'))
	var_output = rt.concat(var_output, rt.new_string('<h3>' +
		(rt.call_function('__', [rt.new_string('Your Sites')])).str() + '</h3>'))
	var_output = rt.concat(var_output, rt.new_string('<table>'))
	mut iter_6 := var_blogs.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_blog_shadow := item_6.val
		var_output = rt.concat(var_output, rt.new_string('<tr>'))
		var_output = rt.concat(var_output, rt.concat(rt.concat(rt.new_string('<td>'), rt.get_property(var_blog_shadow,
			'blogname')), rt.new_string('</td>')))
		var_output = rt.concat(var_output, rt.new_string('<td><a href="' +
			(rt.call_function('esc_url', [rt.call_function('get_admin_url', [rt.get_property(var_blog_shadow, 'userblog_id')])])).str() +
			'">' + (rt.call_function('__', [rt.new_string('Visit Dashboard')])).str() + '</a> | ' +
			'<a href="' +
			(rt.call_function('esc_url', [rt.call_function('get_home_url', [rt.get_property(var_blog_shadow, 'userblog_id')])])).str() +
			'">' + (rt.call_function('__', [rt.new_string('View Site')])).str() + '</a></td>'))
		var_output = rt.concat(var_output, rt.new_string('</tr>'))
	}
	var_output = rt.concat(var_output, rt.new_string('</table>'))
	rt.call_function('wp_die', [var_output.clone(), rt.new_int(403)])
}

fn check_import_new_users(var_permission rt.PhpVal) rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('manage_network_users')])
}

fn mu_dropdown_languages(var_lang_files rt.PhpVal, current string) {
	mut var_current := current
	mut var_flag := false
	mut var_output := rt.new_null()
	mut var_val := rt.new_null()
	mut var_code_lang := rt.new_null()
	mut var_ae := rt.new_null()
	mut var_be := rt.new_null()
	mut var_translated := rt.new_null()
	var_flag = false
	var_output = rt.new_array()
	mut iter_7 := rt.cast_array(var_lang_files).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_val_shadow := item_7.val
		var_code_lang = rt.call_function('basename', [var_val_shadow.clone(),
			rt.new_string('.mo')])
		if rt.is_true(rt.identical(rt.new_string('en_US'), var_code_lang)) {
			var_flag = true
			var_ae = rt.call_function('__', [rt.new_string('American English')])
			var_output.array_set(var_ae, '<option value="' +
				(rt.call_function('esc_attr', [var_code_lang.clone()])).str() + '"' +
				(rt.call_function('selected', [rt.new_string(current), var_code_lang.clone(), rt.new_bool(false)])).str() +
				'> ' + var_ae.str() + '</option>')
		} else if rt.is_true(rt.identical(rt.new_string('en_GB'), var_code_lang)) {
			var_flag = true
			var_be = rt.call_function('__', [rt.new_string('British English')])
			var_output.array_set(var_be, '<option value="' +
				(rt.call_function('esc_attr', [var_code_lang.clone()])).str() + '"' +
				(rt.call_function('selected', [rt.new_string(current), var_code_lang.clone(), rt.new_bool(false)])).str() +
				'> ' + var_be.str() + '</option>')
		} else {
			var_translated = format_code_lang(var_code_lang.clone())
			var_output.array_set(var_translated, '<option value="' +
				(rt.call_function('esc_attr', [var_code_lang.clone()])).str() + '"' +
				(rt.call_function('selected', [rt.new_string(current), var_code_lang.clone(), rt.new_bool(false)])).str() +
				'> ' + (rt.call_function('esc_html', [var_translated.clone()])).str() + '</option>')
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_flag))) {
		var_output.array_push('<option value=""' +
			(rt.call_function('selected', [rt.new_string(current), rt.new_string(''), rt.new_bool(false)])).str() +
			'>' + (rt.call_function('__', [rt.new_string('English')])).str() + '</option>')
	}
	rt.call_function('uksort', [var_output.clone(), rt.new_string('strnatcasecmp')])
	var_output = rt.call_function('apply_filters', [
		rt.new_string('mu_dropdown_languages'),
		var_output.clone(),
		var_lang_files.clone(),
		rt.new_string(current),
	])
	rt.echo_val(rt.call_function('implode', [rt.new_string('\n\t'),
		var_output.clone()]))
}

fn site_admin_notice() bool {
	mut var_wp_db_version := rt.new_null()
	mut var_pagenow := rt.new_null()
	mut var_upgrade_network_message := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('upgrade_network'),
	])))))
	{
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('upgrade.php'), var_pagenow)) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.call_function('get_site_option', [
		rt.new_string('wpmu_upgrade_site'),
	])).to_i64()), var_wp_db_version))))
	{
		var_upgrade_network_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Thank you for Updating! Please visit the <a href="%s">Upgrade Network</a> page to update all your sites.'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('network_admin_url', [rt.new_string('upgrade.php')]),
			]),
		])
		rt.call_function('wp_admin_notice', [var_upgrade_network_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'update-nag' },
					rt.ArrayItem{ key: none, val: 'inline' },
				]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
	}
	return false
}

fn avoid_blog_page_permalink_collision(var_data rt.PhpVal, var_postarr rt.PhpVal) rt.PhpVal {
	mut var_post_name := rt.new_null()
	mut var_c := i64(0)
	if rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
		return var_data.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('page'),
		var_data.array_get(rt.new_string('post_type'))))))
	{
		return var_data.clone()
	}
	if !(var_data.array_isset(rt.new_string('post_name')))
		|| rt.is_true(rt.identical(rt.new_string(''), var_data.array_get(rt.new_string('post_name')))) {
		return var_data.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{}))))) {
		return var_data.clone()
	}
	if var_data.array_isset(rt.new_string('post_parent'))
		&& rt.is_true(var_data.array_get(rt.new_string('post_parent'))) {
		return var_data.clone()
	}
	var_post_name = var_data.array_get(rt.new_string('post_name'))
	var_c = 0
	for var_c < 10 && rt.is_true(rt.call_function('get_id_from_blogname', [var_post_name.clone()])) {
		var_post_name = rt.concat(var_post_name, rt.call_function('mt_rand', [
			rt.new_int(1),
			rt.new_int(10),
		]))
		var_c += 1
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_post_name,
		var_data.array_get(rt.new_string('post_name'))))))
	{
		var_data['post_name'] = var_post_name.clone()
	}
	return var_data.clone()
}

fn choose_primary_blog() {
	mut var_all_blogs := rt.new_null()
	mut var_primary_blog := rt.new_null()
	mut var_found := false
	mut var_blog := rt.new_null()
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Primary Site')])
	// unsupported statement: Stmt_InlineHTML
	var_all_blogs = rt.call_function('get_blogs_of_user', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
	])
	var_primary_blog = rt.new_int((rt.call_function('get_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('primary_blog'),
		rt.new_bool(true),
	])).to_i64())
	if var_all_blogs.clone().array_count() > 1 {
		var_found = false
		// unsupported statement: Stmt_InlineHTML
		mut iter_8 := rt.cast_array(var_all_blogs).iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_blog_shadow := item_8.val
			if rt.is_true(rt.identical(rt.get_property(var_blog_shadow, 'userblog_id'),
				var_primary_blog))
			{
				var_found = true
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.get_property(var_blog_shadow, 'userblog_id'))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [var_primary_blog.clone(),
				rt.get_property(var_blog_shadow, 'userblog_id')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('get_home_url', [
					rt.get_property(var_blog_shadow, 'userblog_id'),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if !var_found {
			var_blog = rt.call_function('reset', [var_all_blogs.clone()])
			rt.call_function('update_user_meta', [
				rt.call_function('get_current_user_id', []rt.PhpVal{}),
				rt.new_string('primary_blog'),
				rt.get_property(var_blog, 'userblog_id'),
			])
		}
	} else if 1 == var_all_blogs.clone().array_count() {
		var_blog = rt.call_function('reset', [var_all_blogs.clone()])
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('get_home_url', [rt.get_property(var_blog, 'userblog_id')]),
		]))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_blog, 'userblog_id'),
			var_primary_blog))))
		{
			rt.call_function('update_user_meta', [
				rt.call_function('get_current_user_id', []rt.PhpVal{}),
				rt.new_string('primary_blog'),
				rt.get_property(var_blog, 'userblog_id'),
			])
		}
	} else {
		rt.call_function('_e', [rt.new_string('Not available')])
	}
	// unsupported statement: Stmt_InlineHTML
}

fn can_edit_network(var_network_id rt.PhpVal) rt.PhpVal {
	mut var_result := false
	if rt.is_true(rt.identical(rt.call_function('get_current_network_id', []rt.PhpVal{}),
		rt.new_int(var_network_id.to_i64())))
	{
		var_result = true
	} else {
		var_result = false
	}
	return rt.call_function('apply_filters', [rt.new_string('can_edit_network'),
		rt.new_bool(var_result).clone(), var_network_id.clone()])
}

fn _thickbox_path_admin_subfolder() {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('includes_url', [
			rt.new_string('js/thickbox/loadingAnimation.gif'),
			rt.new_string('relative'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn confirm_delete_users(var_users rt.PhpVal) bool {
	mut var_current_user := rt.new_null()
	mut var_site_admins := rt.new_null()
	mut var_admin_out := rt.new_null()
	mut var_allusers := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_delete_user := rt.new_null()
	mut var_blogs := rt.new_null()
	mut var_details := rt.new_null()
	mut var_key := rt.new_null()
	mut var_blog_users := rt.new_null()
	mut var_user_site := rt.new_null()
	mut var_user_dropdown := rt.new_null()
	mut var_user_list := rt.new_null()
	mut var_user := rt.new_null()
	var_current_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if !(var_users.clone().is_array()) || !rt.is_true(var_users) {
		return false
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Users')])
	// unsupported statement: Stmt_InlineHTML
	if 1 == var_users.clone().array_count() {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('You have chosen to delete the user from all networks and sites.'),
		])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('You have chosen to delete the following users from all networks and sites.'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('ms-users-delete')])
	var_site_admins = rt.call_function('get_super_admins', []rt.PhpVal{})
	var_admin_out = rt.new_string('<option value="' +
		(rt.call_function('esc_attr', [rt.get_property(var_current_user, 'ID')])).str() + '">' +
		(rt.get_property(var_current_user, 'user_login')).str() + '</option>')
	// unsupported statement: Stmt_InlineHTML
	var_allusers = rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('allusers')))
	mut iter_9 := var_allusers.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_user_id_shadow := item_9.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_user_id_shadow))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0'), var_user_id_shadow)))) {
			var_delete_user = rt.call_function('get_userdata', [
				var_user_id_shadow.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('delete_user'),
				rt.get_property(var_delete_user, 'ID'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Warning! User %s cannot be deleted.'),
						]),
						rt.get_property(var_delete_user, 'user_login'),
					]),
				])
			}
			if rt.is_true(rt.call_function('in_array', [
				rt.get_property(var_delete_user, 'user_login'),
				var_site_admins.clone(),
				rt.new_bool(true),
			]))
			{
				rt.call_function('wp_die', [
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Warning! User cannot be deleted. The user %s is a network administrator.'),
						]),
						rt.new_string('<em>' +
							(rt.get_property(var_delete_user, 'user_login')).str() + '</em>'),
					]),
				])
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.get_property(var_delete_user, 'user_login'))
			// unsupported statement: Stmt_InlineHTML
			print('<input type="hidden" name="user[]" value="' +
				(rt.call_function('esc_attr', [var_user_id_shadow.clone()])).str() + '" />' + '\n')
			// unsupported statement: Stmt_InlineHTML
			var_blogs = rt.call_function('get_blogs_of_user', [
				var_user_id_shadow.clone(), rt.new_bool(true)])
			if !(!rt.is_true(var_blogs)) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('What should be done with content owned by %s?'),
					]),
					rt.new_string('<em>' + (rt.get_property(var_delete_user, 'user_login')).str() +
						'</em>'),
				])
				// unsupported statement: Stmt_InlineHTML
				mut iter_10 := rt.cast_array(var_blogs).iterator()
				for {
					item_10 := iter_10.next() or { break }
					mut var_details_shadow := item_10.val
					mut var_key_shadow := item_10.key
					var_blog_users = rt.call_function('get_users', [
						rt.create_array([
							rt.ArrayItem{ key: 'blog_id', val: rt.get_property(var_details_shadow,
								'userblog_id') },
							rt.ArrayItem{ key: 'fields', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'ID' },
								rt.ArrayItem{ key: none, val: 'user_login' },
							]) },
						]),
					])
					if var_blog_users.clone().is_array() && !(!rt.is_true(var_blog_users)) {
						var_user_site = rt.new_string("<a href='" +
							(rt.call_function('esc_url', [rt.call_function('get_home_url', [rt.get_property(var_details_shadow, 'userblog_id')])])).str() +
							rt.concat(rt.concat(rt.new_string("'>"), rt.get_property(var_details_shadow, 'blogname')), rt.new_string('</a>')))
						var_user_dropdown = rt.new_string(
							'<label for="reassign_user" class="screen-reader-text">' +
							(rt.call_function('__', [rt.new_string('Select a user')])).str() +
							'</label>')
						var_user_dropdown = rt.concat(var_user_dropdown,
							rt.new_string("<select name='blog[${var_user_id.to_string()}][${var_key.to_string()}]' id='reassign_user'>"))
						var_user_list = rt.new_string('')
						mut iter_11 := var_blog_users.iterator()
						for {
							item_11 := iter_11.next() or { break }
							mut var_user_shadow := item_11.val
							if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
								rt.new_int((rt.get_property(var_user_shadow, 'ID')).to_i64()),
								var_allusers.clone(),
								rt.new_bool(true),
							])))))
							{
								var_user_list = rt.concat(var_user_list, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("<option value='"),
									rt.get_property(var_user_shadow, 'ID')), rt.new_string("'>")), rt.get_property(var_user_shadow,
									'user_login')), rt.new_string('</option>')))
							}
						}
						if rt.is_true(rt.identical(rt.new_string(''), var_user_list)) {
							var_user_list = var_admin_out.clone()
						}
						var_user_dropdown = rt.concat(var_user_dropdown, var_user_list)
						var_user_dropdown = rt.concat(var_user_dropdown,
							rt.new_string('</select>\n'))
						// unsupported statement: Stmt_InlineHTML
						rt.call_function('printf', [
							rt.call_function('__', [rt.new_string('Site: %s')]),
							var_user_site.clone(),
						])
						// unsupported statement: Stmt_InlineHTML
						print((rt.get_property(var_details_shadow, 'userblog_id')).str() + '][' +
							(rt.get_property(var_delete_user, 'ID')).str())
						// unsupported statement: Stmt_InlineHTML
						rt.call_function('_e', [rt.new_string('Delete all content.')])
						// unsupported statement: Stmt_InlineHTML
						print((rt.get_property(var_details_shadow, 'userblog_id')).str() + '][' +
							(rt.get_property(var_delete_user, 'ID')).str())
						// unsupported statement: Stmt_InlineHTML
						rt.call_function('_e', [
							rt.new_string('Attribute all content to:'),
						])
						// unsupported statement: Stmt_InlineHTML
						rt.echo_val(var_user_dropdown)
						// unsupported statement: Stmt_InlineHTML
					}
				}
				print('</fieldset></td></tr>')
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [
					rt.new_string('User has no sites or content and will be deleted.'),
				])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('delete_user_form'),
		var_current_user.clone(), var_allusers.clone()])
	if 1 == var_users.clone().array_count() {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Once you hit &#8220;Confirm Deletion&#8221;, the user will be permanently removed.'),
		])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Once you hit &#8220;Confirm Deletion&#8221;, these users will be permanently removed.'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('submit_button', [
		rt.call_function('__', [rt.new_string('Confirm Deletion')]),
		rt.new_string('primary'),
	])
	// unsupported statement: Stmt_InlineHTML
	return true
}

fn network_settings_add_js() {
	// unsupported statement: Stmt_InlineHTML
}

fn network_edit_site_nav(var_args rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	mut var_links := rt.new_null()
	mut var_parsed_args := rt.new_null()
	mut var_screen_links := rt.new_null()
	mut var_link := map[string]rt.PhpVal{}
	mut var_link_id := rt.new_null()
	mut var_classes := []rt.PhpVal{}
	mut var_aria_current := ''
	mut var_esc_classes := rt.new_null()
	mut var_url := rt.new_null()
	var_links = rt.call_function('apply_filters', [
		rt.new_string('network_edit_site_nav_links'),
		rt.create_array([
			rt.ArrayItem{ key: 'site-info', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Info'),
				]) },
				rt.ArrayItem{ key: 'url', val: 'site-info.php' },
				rt.ArrayItem{ key: 'cap', val: 'manage_sites' },
			]) },
			rt.ArrayItem{ key: 'site-users', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Users'),
				]) },
				rt.ArrayItem{ key: 'url', val: 'site-users.php' },
				rt.ArrayItem{ key: 'cap', val: 'manage_sites' },
			]) },
			rt.ArrayItem{ key: 'site-themes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Themes'),
				]) },
				rt.ArrayItem{ key: 'url', val: 'site-themes.php' },
				rt.ArrayItem{ key: 'cap', val: 'manage_sites' },
			]) },
			rt.ArrayItem{ key: 'site-settings', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Settings'),
				]) },
				rt.ArrayItem{ key: 'url', val: 'site-settings.php' },
				rt.ArrayItem{ key: 'cap', val: 'manage_sites' },
			]) },
		]),
	])
	var_parsed_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array([
			rt.ArrayItem{
				key: 'blog_id'
				val: if rt.get_superglobal('_GET').array_isset(rt.new_string('blog_id')) {
					rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('blog_id'))).to_i64())
				} else {
					0
				}
			},
			rt.ArrayItem{ key: 'links', val: var_links },
			rt.ArrayItem{ key: 'selected', val: 'site-info' },
		])])
	var_screen_links = rt.new_array()
	mut iter_12 := var_parsed_args.array_get(rt.new_string('links')).iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_link_shadow := item_12.val
		mut var_link_id_shadow := item_12.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			var_link_shadow['cap'],
			var_parsed_args.array_get(rt.new_string('blog_id')),
		])))))
		{
			continue
		}
		var_classes = ['nav-tab']
		var_aria_current = ''
		if rt.is_true(rt.identical(var_parsed_args.array_get(rt.new_string('selected')), var_link_id_shadow))
			|| rt.is_true(rt.identical(var_link_shadow['url'], var_GLOBALS.array_get(rt.new_string('pagenow')))) {
			var_classes << 'nav-tab-active'
			var_aria_current = ' aria-current="page"'
		}
		var_esc_classes = rt.call_function('implode', [rt.new_string(' '),
			rt.create_array_from_list(var_classes)])
		var_url = rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: var_parsed_args.array_get(rt.new_string('blog_id')) },
			]),
			rt.call_function('network_admin_url', [
				var_link_shadow['url'],
			]),
		])
		var_screen_links.array_set(var_link_id_shadow, '<a href="' +
			(rt.call_function('esc_url', [var_url.clone()])).str() + '" id="' +
			(rt.call_function('esc_attr', [var_link_id_shadow.clone()])).str() + '" class="' +
			var_esc_classes.str() + '"' + var_aria_current + '>' +
			(rt.call_function('esc_html', [var_link_shadow['label']])).str() + '</a>')
	}
	print('<nav class="nav-tab-wrapper wp-clearfix" aria-label="' +
		(rt.call_function('esc_attr__', [rt.new_string('Secondary menu')])).str() + '">')
	rt.echo_val(rt.call_function('implode', [rt.new_string(''),
		var_screen_links.clone()]))
	print('</nav>')
}

fn get_site_screen_help_tab_args() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Overview'),
		]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
			(rt.call_function('__', [rt.new_string('The menu is for editing information specific to individual sites, particularly if the admin area of a site is unavailable.')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<strong>Info</strong> &mdash; The site URL is rarely edited as this can cause the site to not work properly. The Registered date and Last Updated date are displayed. Network admins can mark a site as archived, spam, deleted and mature, to remove from public listings or disable.')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<strong>Users</strong> &mdash; This displays the users associated with this site. You can also change their role, reset their password, or remove them from the site. Removing the user from the site does not remove the user from the network.')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Themes</strong> &mdash; This area shows themes that are not already enabled across the network. Enabling a theme in this menu makes it accessible to this site. It does not activate the theme, but allows it to show in the site&#8217;s Appearance menu. To enable a theme for the entire network, see the <a href="%s">Network Themes</a> screen.')]), rt.call_function('network_admin_url', [rt.new_string('themes.php')])])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<strong>Settings</strong> &mdash; This page shows a list of all settings associated with this site. Some are created by WordPress and others are created by plugins you activate. Note that some fields are grayed out and say Serialized Data. You cannot modify these values due to the way the setting is stored in the database.')])).str() +
			'</p>' }])
}

fn get_site_screen_help_sidebar_content() string {
	return '<p><strong>' +
		(rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' +
		'<p>' +
		(rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/advanced-administration/multisite/admin/#network-admin-sites-screen">Documentation on Site Management</a>')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forum/multisite/">Support forums</a>')])).str() +
		'</p>'
}

fn wp_ensure_editable_role(var_role rt.PhpVal) {
	mut var_roles := rt.new_null()
	var_roles = rt.call_function('get_editable_roles', []rt.PhpVal{})
	if !(var_roles.array_isset(var_role)) {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to give users that role.'),
			]),
			rt.new_int(403),
		])
	}
}

struct Class_WP_User {
	rt.PhpObjectBase
}

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
