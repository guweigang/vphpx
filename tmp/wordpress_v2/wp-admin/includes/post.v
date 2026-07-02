import rt

fn _wp_translate_postdata(update bool, var_post_data rt.PhpVal) rt.PhpVal {
	mut var_update := update
	mut var_ptype := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_previous_status := rt.new_null()
	mut var_published_statuses := []rt.PhpVal{}
	mut var_timeunit := rt.new_null()
	mut var_aa := rt.new_null()
	mut var_mm := rt.new_null()
	mut var_jj := rt.new_null()
	mut var_hh := rt.new_null()
	mut var_mn := rt.new_null()
	mut var_ss := rt.new_null()
	mut var_valid_date := rt.new_null()
	mut var_previous_date := rt.new_null()
	mut var_category_object := rt.new_null()
	if !rt.is_true(var_post_data) {
		var_post_data = rt.get_superglobal('_POST')
	}
	if var_update {
		var_post_data.array_set('ID',
			rt.new_int((var_post_data.array_get(rt.new_string('post_ID'))).to_i64()))
	}
	var_ptype = rt.call_function('get_post_type_object', [
		var_post_data.array_get(rt.new_string('post_type')),
	])
	if var_update
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_data.array_get(rt.new_string('ID'))]))))) {
		if rt.is_true(rt.identical(rt.new_string('page'),
			var_post_data.array_get(rt.new_string('post_type'))))
		{
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('edit_others_pages'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit pages as this user.'),
			])))
		} else {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('edit_others_posts'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit posts as this user.'),
			])))
		}
	} else if !var_update
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_ptype, 'cap'), 'create_posts')]))))) {
		if rt.is_true(rt.identical(rt.new_string('page'),
			var_post_data.array_get(rt.new_string('post_type'))))
		{
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('edit_others_pages'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to create pages as this user.'),
			])))
		} else {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('edit_others_posts'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to create posts as this user.'),
			])))
		}
	}
	if var_post_data.array_isset(rt.new_string('content')) {
		var_post_data.array_set('post_content', var_post_data.array_get(rt.new_string('content')))
	}
	if var_post_data.array_isset(rt.new_string('excerpt')) {
		var_post_data.array_set('post_excerpt', var_post_data.array_get(rt.new_string('excerpt')))
	}
	if var_post_data.array_isset(rt.new_string('parent_id')) {
		var_post_data.array_set('post_parent',
			rt.new_int((var_post_data.array_get(rt.new_string('parent_id'))).to_i64()))
	}
	if var_post_data.array_isset(rt.new_string('trackback_url')) {
		var_post_data.array_set('to_ping', var_post_data.array_get(rt.new_string('trackback_url')))
	}
	var_post_data.array_set('user_ID', rt.call_function('get_current_user_id', []rt.PhpVal{}))
	if !(!rt.is_true(var_post_data.array_get(rt.new_string('post_author_override')))) {
		var_post_data.array_set('post_author',
			rt.new_int((var_post_data.array_get(rt.new_string('post_author_override'))).to_i64()))
	} else {
		if !(!rt.is_true(var_post_data.array_get(rt.new_string('post_author')))) {
			var_post_data.array_set('post_author',
				rt.new_int((var_post_data.array_get(rt.new_string('post_author'))).to_i64()))
		} else {
			var_post_data.array_set('post_author',
				rt.new_int((var_post_data.array_get(rt.new_string('user_ID'))).to_i64()))
		}
	}
	if var_post_data.array_isset(rt.new_string('user_ID'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_post_data.array_get(rt.new_string('post_author')), var_post_data.array_get(rt.new_string('user_ID'))))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_ptype, 'cap'), 'edit_others_posts')]))))) {
		if var_update {
			if rt.is_true(rt.identical(rt.new_string('page'),
				var_post_data.array_get(rt.new_string('post_type'))))
			{
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('edit_others_pages'), rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit pages as this user.'),
				])))
			} else {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('edit_others_posts'), rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit posts as this user.'),
				])))
			}
		} else {
			if rt.is_true(rt.identical(rt.new_string('page'),
				var_post_data.array_get(rt.new_string('post_type'))))
			{
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('edit_others_pages'), rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to create pages as this user.'),
				])))
			} else {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('edit_others_posts'), rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to create posts as this user.'),
				])))
			}
		}
	}
	if !(!rt.is_true(var_post_data.array_get(rt.new_string('post_status')))) {
		var_post_data.array_set('post_status', rt.call_function('sanitize_key', [
			var_post_data.array_get(rt.new_string('post_status')),
		]))
		if rt.is_true(rt.identical(rt.new_string('auto-draft'),
			var_post_data.array_get(rt.new_string('post_status'))))
		{
			var_post_data.array_set('post_status', 'draft')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post_status_object', [
			var_post_data.array_get(rt.new_string('post_status')),
		])))))
		{
			var_post_data.array_unset(rt.new_string('post_status'))
		}
	}
	if var_post_data.array_isset(rt.new_string('saveasdraft'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_post_data.array_get(rt.new_string('saveasdraft')))))) {
		var_post_data.array_set('post_status', 'draft')
	}
	if var_post_data.array_isset(rt.new_string('saveasprivate'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_post_data.array_get(rt.new_string('saveasprivate')))))) {
		var_post_data.array_set('post_status', 'private')
	}
	if var_post_data.array_isset(rt.new_string('publish'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_post_data.array_get(rt.new_string('publish'))))))
		&& !(var_post_data.array_isset(rt.new_string('post_status')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('private'), var_post_data.array_get(rt.new_string('post_status')))))) {
		var_post_data.array_set('post_status', 'publish')
	}
	if var_post_data.array_isset(rt.new_string('advanced'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_post_data.array_get(rt.new_string('advanced')))))) {
		var_post_data.array_set('post_status', 'draft')
	}
	if var_post_data.array_isset(rt.new_string('pending'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_post_data.array_get(rt.new_string('pending')))))) {
		var_post_data.array_set('post_status', 'pending')
	}
	var_post_id = if !(var_post_data.array_get(rt.new_string('ID'))).is_null() {
		var_post_data.array_get(rt.new_string('ID'))
	} else {
		rt.new_bool(false)
	}
	var_previous_status = if rt.is_true(var_post_id) { rt.call_function('get_post_field', [
			rt.new_string('post_status'),
			var_post_id.clone(),
		]) } else { rt.new_bool(false) }
	if var_post_data.array_isset(rt.new_string('post_status'))
		&& rt.is_true(rt.identical(rt.new_string('private'), var_post_data.array_get(rt.new_string('post_status'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_ptype, 'cap'), 'publish_posts')]))))) {
		var_post_data.array_set('post_status', if rt.is_true(var_previous_status) {
			var_previous_status
		} else {
			rt.new_string('pending')
		})
	}
	var_published_statuses = ['publish', 'future']
	if var_post_data.array_isset(rt.new_string('post_status'))
		&& rt.is_true(rt.call_function('in_array', [var_post_data.array_get(rt.new_string('post_status')), rt.create_array_from_list(var_published_statuses), rt.new_bool(true)]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_ptype, 'cap'), 'publish_posts')]))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_previous_status.clone(), rt.create_array_from_list(var_published_statuses), rt.new_bool(true)])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.clone()]))))) {
			var_post_data.array_set('post_status', 'pending')
		}
	}
	if !(var_post_data.array_isset(rt.new_string('post_status'))) {
		var_post_data.array_set('post_status', if rt.is_true(rt.identical(rt.new_string('auto-draft'),
			var_previous_status))
		{
			rt.new_string('draft')
		} else {
			var_previous_status
		})
	}
	if var_post_data.array_isset(rt.new_string('post_password'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_ptype, 'cap'), 'publish_posts')]))))) {
		var_post_data.array_unset(rt.new_string('post_password'))
	}
	if !(var_post_data.array_isset(rt.new_string('comment_status'))) {
		var_post_data.array_set('comment_status', 'closed')
	}
	if !(var_post_data.array_isset(rt.new_string('ping_status'))) {
		var_post_data.array_set('ping_status', 'closed')
	}
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'aa' },
		rt.ArrayItem{ key: none, val: 'mm' }, rt.ArrayItem{ key: none, val: 'jj' },
		rt.ArrayItem{ key: none, val: 'hh' }, rt.ArrayItem{ key: none, val: 'mn' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_timeunit_shadow := item_1.val
		if !(!rt.is_true(var_post_data.array_get(rt.new_string('hidden_' + var_timeunit_shadow.str()))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_post_data.array_get(rt.new_string('hidden_' + var_timeunit_shadow.str())), var_post_data.array_get(var_timeunit_shadow))))) {
			var_post_data.array_set('edit_date', '1')
			break
		}
	}
	if !(!rt.is_true(var_post_data.array_get(rt.new_string('edit_date')))) {
		var_aa = var_post_data.array_get(rt.new_string('aa'))
		var_mm = var_post_data.array_get(rt.new_string('mm'))
		var_jj = var_post_data.array_get(rt.new_string('jj'))
		var_hh = var_post_data.array_get(rt.new_string('hh'))
		var_mn = var_post_data.array_get(rt.new_string('mn'))
		var_ss = var_post_data.array_get(rt.new_string('ss'))
		var_aa = if rt.is_true(rt.less_equal(var_aa, rt.new_int(0))) { rt.call_function('gmdate', [
				rt.new_string('Y'),
			]) } else { var_aa }
		var_mm = if rt.is_true(rt.less_equal(var_mm, rt.new_int(0))) { rt.call_function('gmdate', [
				rt.new_string('n'),
			]) } else { var_mm }
		var_jj = if rt.is_true(rt.greater(var_jj, rt.new_int(31))) { rt.new_int(31) } else { var_jj }
		var_jj = if rt.is_true(rt.less_equal(var_jj, rt.new_int(0))) { rt.call_function('gmdate', [
				rt.new_string('j'),
			]) } else { var_jj }
		var_hh = if rt.is_true(rt.greater(var_hh, rt.new_int(23))) {
			rt.sub(var_hh, rt.new_int(24))
		} else {
			var_hh
		}
		var_mn = if rt.is_true(rt.greater(var_mn, rt.new_int(59))) {
			rt.sub(var_mn, rt.new_int(60))
		} else {
			var_mn
		}
		var_ss = if rt.is_true(rt.greater(var_ss, rt.new_int(59))) {
			rt.sub(var_ss, rt.new_int(60))
		} else {
			var_ss
		}
		var_post_data.array_set('post_date', rt.call_function('sprintf', [
			rt.new_string('%04d-%02d-%02d %02d:%02d:%02d'),
			var_aa.clone(),
			var_mm.clone(),
			var_jj.clone(),
			var_hh.clone(),
			var_mn.clone(),
			var_ss.clone(),
		]))
		var_valid_date = rt.call_function('wp_checkdate', [var_mm.clone(),
			var_jj.clone(), var_aa.clone(), var_post_data.array_get(rt.new_string('post_date'))])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_valid_date)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_date'), rt.call_function('__', [
				rt.new_string('Invalid date.'),
			])))
		}
		var_previous_date = if rt.is_true(var_post_id) { rt.call_function('get_post_field', [
				rt.new_string('post_date'),
				var_post_id.clone(),
			]) } else { rt.new_bool(false) }
		if rt.is_true(var_previous_date)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_previous_date, var_post_data.array_get(rt.new_string('post_date')))))) {
			var_post_data.array_set('edit_date', true)
			var_post_data.array_set('post_date_gmt', rt.call_function('get_gmt_from_date', [
				var_post_data.array_get(rt.new_string('post_date')),
			]))
		} else {
			var_post_data.array_set('edit_date', false)
			var_post_data.array_unset(rt.new_string('post_date'))
			var_post_data.array_unset(rt.new_string('post_date_gmt'))
		}
	}
	if var_post_data.array_isset(rt.new_string('post_category')) {
		var_category_object = rt.call_function('get_taxonomy', [
			rt.new_string('category'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(var_category_object, 'cap'), 'assign_terms'),
		])))))
		{
			var_post_data.array_unset(rt.new_string('post_category'))
		}
	}
	return var_post_data.clone()
}

fn _wp_get_allowed_postdata(var_post_data_arg rt.PhpVal) rt.PhpVal {
	mut var_post_data := var_post_data_arg
	if !rt.is_true(var_post_data) {
		var_post_data = rt.get_superglobal('_POST').clone()
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_post_data.clone()])) {
		return var_post_data.clone()
	}
	return rt.call_function('array_diff_key', [var_post_data.clone(),
		rt.call_function('array_flip', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'meta_input' },
				rt.ArrayItem{ key: none, val: 'file' }, rt.ArrayItem{ key: none, val: 'guid' }]),
		])])
}

fn edit_post(var_post_data_arg rt.PhpVal) rt.PhpVal {
	mut var_post_data := var_post_data_arg
	mut var_wpdb := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_post := rt.new_null()
	mut var_ptype := rt.new_null()
	mut var_revisions := rt.new_null()
	mut var_revision := rt.new_null()
	mut var_translated := rt.new_null()
	mut var_format_meta_urls := []rt.PhpVal{}
	mut var_format_meta_url := rt.new_null()
	mut var_keyed := rt.new_null()
	mut var_format_keys := []rt.PhpVal{}
	mut var_key := rt.new_null()
	mut var_id3data := rt.new_null()
	mut var_label := rt.new_null()
	mut var_value := map[string]rt.PhpVal{}
	mut var_meta := rt.new_null()
	mut var_image_alt := rt.new_null()
	mut var_attachment_data := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_tax_object := rt.new_null()
	mut var_success := rt.new_null()
	mut var_fields := []rt.PhpVal{}
	mut var_field := rt.new_null()
	if !rt.is_true(var_post_data) {
		var_post_data = rt.get_superglobal('_POST')
	}
	var_post_data.array_unset(rt.new_string('filter'))
	var_post_id = rt.new_int((var_post_data.array_get(rt.new_string('post_ID'))).to_i64())
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	var_post_data.array_set('post_type', rt.get_property(var_post, 'post_type'))
	var_post_data.array_set('post_mime_type', rt.get_property(var_post, 'post_mime_type'))
	if !(!rt.is_true(var_post_data.array_get(rt.new_string('post_status')))) {
		var_post_data.array_set('post_status', rt.call_function('sanitize_key', [
			var_post_data.array_get(rt.new_string('post_status')),
		]))
		if rt.is_true(rt.identical(rt.new_string('inherit'),
			var_post_data.array_get(rt.new_string('post_status'))))
		{
			var_post_data.array_unset(rt.new_string('post_status'))
		}
	}
	var_ptype = rt.call_function('get_post_type_object', [
		var_post_data.array_get(rt.new_string('post_type')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		if rt.is_true(rt.identical(rt.new_string('page'),
			var_post_data.array_get(rt.new_string('post_type'))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit this page.'),
				]),
			])
		} else {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit this post.'),
				]),
			])
		}
	}
	if rt.is_true(rt.call_function('post_type_supports', [
		rt.get_property(var_ptype, 'name'),
		rt.new_string('revisions'),
	]))
	{
		var_revisions = rt.call_function('wp_get_post_revisions', [
			var_post_id.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'order', val: 'ASC' },
				rt.ArrayItem{ key: 'posts_per_page', val: 1 },
			])])
		var_revision = rt.call_function('current', [var_revisions.clone()])
		if rt.is_true(var_revisions)
			&& rt.is_true(rt.less(rt.call_function('_wp_get_post_revision_version', [var_revision.clone()]), rt.new_int(1))) {
			rt.call_function('_wp_upgrade_revisions_of_post', [
				var_post.clone(), rt.call_function('wp_get_post_revisions', [
					var_post_id.clone()])])
		}
	}
	if var_post_data.array_isset(rt.new_string('visibility')) {
		mut switch_val_1 := var_post_data.array_get(rt.new_string('visibility'))
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('public'))) {
			var_post_data.array_set('post_password', '')
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('password'))) {
			var_post_data.array_unset(rt.new_string('sticky'))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('private'))) {
			var_post_data.array_set('post_status', 'private')
			var_post_data.array_set('post_password', '')
			var_post_data.array_unset(rt.new_string('sticky'))
		}
	}
	var_post_data = _wp_translate_postdata(true, var_post_data.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_post_data.clone()])) {
		rt.call_function('wp_die', [
			rt.call_method(var_post_data, 'get_error_message', []rt.PhpVal{}),
		])
	}
	var_translated = _wp_get_allowed_postdata(var_post_data.clone())
	if var_post_data.array_isset(rt.new_string('post_format')) {
		rt.call_function('set_post_format', [var_post_id.clone(),
			var_post_data.array_get(rt.new_string('post_format'))])
	}
	var_format_meta_urls = ['url', 'link_url', 'quote_source_url']
	for var_format_meta_url_shadow in var_format_meta_urls {
		var_keyed = rt.new_string('_format_' +
			(rt.new_string(var_format_meta_url_shadow.str())).str())
		if var_post_data.array_isset(var_keyed) {
			rt.call_function('update_post_meta', [var_post_id.clone(),
				var_keyed.clone(),
				rt.call_function('wp_slash', [
					rt.call_function('sanitize_url', [
						rt.call_function('wp_unslash', [var_post_data.array_get(var_keyed)]),
					]),
				])])
		}
	}
	var_format_keys = ['quote', 'quote_source_name', 'image', 'gallery', 'audio_embed', 'video_embed']
	for var_key_shadow in var_format_keys {
		var_keyed = rt.new_string('_format_' + (rt.new_string(var_key_shadow.str())).str())
		if var_post_data.array_isset(var_keyed) {
			if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('unfiltered_html'),
			]))
			{
				rt.call_function('update_post_meta', [var_post_id.clone(),
					var_keyed.clone(), var_post_data.array_get(var_keyed)])
			} else {
				rt.call_function('update_post_meta', [var_post_id.clone(),
					var_keyed.clone(),
					rt.call_function('wp_filter_post_kses', [
						var_post_data.array_get(var_keyed),
					])])
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_string('attachment'), var_post_data.array_get(rt.new_string('post_type'))))
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('#^(audio|video)/#'), var_post_data.array_get(rt.new_string('post_mime_type'))])) {
		var_id3data = rt.call_function('wp_get_attachment_metadata', [
			var_post_id.clone()])
		if !(var_id3data.clone().is_array()) {
			var_id3data = rt.new_array()
		}
		mut iter_2 := rt.call_function('wp_get_attachment_id3_keys', [
			var_post.clone(), rt.new_string('edit')]).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_label_shadow := item_2.val
			mut var_key_shadow := item_2.key
			if var_post_data.array_isset('id3_' + var_key_shadow.str()) {
				var_id3data.array_set(var_key_shadow, rt.call_function('sanitize_text_field', [
					rt.call_function('wp_unslash', [
						var_post_data.array_get(rt.new_string('id3_' + var_key_shadow.str())),
					]),
				]))
			}
		}
		rt.call_function('wp_update_attachment_metadata', [var_post_id.clone(),
			var_id3data.clone()])
	}
	if var_post_data.array_isset(rt.new_string('meta'))
		&& rt.is_true(var_post_data.array_get(rt.new_string('meta'))) {
		mut iter_3 := var_post_data.array_get(rt.new_string('meta')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_value_shadow := item_3.val
			mut var_key_shadow := item_3.key
			var_meta = get_post_meta_by_id(var_key_shadow.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_meta)))) {
				continue
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.get_property(var_meta,
				'post_id')).to_i64()), var_post_id))))
			{
				continue
			}
			if rt.is_true(rt.call_function('is_protected_meta', [rt.get_property(var_meta, 'meta_key'), rt.new_string('post')]))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post_meta'), var_post_id.clone(), rt.get_property(var_meta, 'meta_key')]))))) {
				continue
			}
			if rt.is_true(rt.call_function('is_protected_meta', [var_value_shadow['key'], rt.new_string('post')]))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post_meta'), var_post_id.clone(), var_value_shadow['key']]))))) {
				continue
			}
			update_meta(var_key_shadow.clone(), var_value_shadow['key'], var_value_shadow['value'])
		}
	}
	if var_post_data.array_isset(rt.new_string('deletemeta'))
		&& rt.is_true(var_post_data.array_get(rt.new_string('deletemeta'))) {
		mut iter_4 := var_post_data.array_get(rt.new_string('deletemeta')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_value_shadow := item_4.val
			mut var_key_shadow := item_4.key
			var_meta = get_post_meta_by_id(var_key_shadow.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_meta)))) {
				continue
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.get_property(var_meta,
				'post_id')).to_i64()), var_post_id))))
			{
				continue
			}
			if rt.is_true(rt.call_function('is_protected_meta', [rt.get_property(var_meta, 'meta_key'), rt.new_string('post')]))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post_meta'), var_post_id.clone(), rt.get_property(var_meta, 'meta_key')]))))) {
				continue
			}
			delete_meta(var_key_shadow.clone())
		}
	}
	if rt.is_true(rt.identical(rt.new_string('attachment'),
		var_post_data.array_get(rt.new_string('post_type'))))
	{
		if var_post_data.array_isset(rt.new_string('_wp_attachment_image_alt')) {
			var_image_alt = rt.call_function('wp_unslash', [
				var_post_data.array_get(rt.new_string('_wp_attachment_image_alt')),
			])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_post_meta', [
				var_post_id.clone(),
				rt.new_string('_wp_attachment_image_alt'),
				rt.new_bool(true),
			]), var_image_alt))))
			{
				var_image_alt = rt.call_function('wp_strip_all_tags', [
					var_image_alt.clone(), rt.new_bool(true)])
				rt.call_function('update_post_meta', [var_post_id.clone(),
					rt.new_string('_wp_attachment_image_alt'),
					rt.call_function('wp_slash', [var_image_alt.clone()])])
			}
		}
		var_attachment_data = if !(var_post_data.array_get(rt.new_string('attachments')).array_get(var_post_id)).is_null() {
			var_post_data.array_get(rt.new_string('attachments')).array_get(var_post_id)
		} else {
			rt.new_array()
		}
		var_translated = rt.call_function('apply_filters', [
			rt.new_string('attachment_fields_to_save'),
			var_translated.clone(),
			var_attachment_data.clone(),
		])
	}
	if var_post_data.array_isset(rt.new_string('tax_input')) {
		mut iter_5 := rt.cast_array(var_post_data.array_get(rt.new_string('tax_input'))).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_terms_shadow := item_5.val
			mut var_taxonomy_shadow := item_5.key
			var_tax_object = rt.call_function('get_taxonomy', [
				var_taxonomy_shadow.clone()])
			if rt.is_true(var_tax_object)
				&& !(rt.get_property(var_tax_object, 'meta_box_sanitize_cb')).is_null() {
				var_translated.array_get_mut('tax_input').array_set(var_taxonomy_shadow, rt.call_function('call_user_func_array', [
					rt.get_property(var_tax_object, 'meta_box_sanitize_cb'),
					rt.create_array([rt.ArrayItem{ key: none, val: var_taxonomy_shadow },
						rt.ArrayItem{ key: none, val: var_terms_shadow }]),
				]))
			}
		}
	}
	rt.new_bool(add_meta(var_post_id.clone()))
	rt.call_function('update_post_meta', [var_post_id.clone(),
		rt.new_string('_edit_last'), rt.call_function('get_current_user_id', []rt.PhpVal{})])
	var_success = rt.call_function('wp_update_post', [var_translated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_success))))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_wpdb
	}, rt.ArrayItem{ key: none, val: 'strip_invalid_text_for_column' }])]) {
		var_fields = ['post_title', 'post_content', 'post_excerpt']
		for var_field_shadow in var_fields {
			if var_translated.array_isset(rt.new_string(var_field_shadow.str())) {
				var_translated.array_set(rt.new_string(var_field_shadow.str()), rt.call_method(var_wpdb,
					'strip_invalid_text_for_column', [rt.get_property(var_wpdb, 'posts'),
					rt.new_string(var_field_shadow.str()).clone(),
					var_translated.array_get(rt.new_string(var_field_shadow.str()))]))
			}
		}
		rt.call_function('wp_update_post', [var_translated.clone()])
	}
	_fix_attachment_links(var_post_id.clone())
	wp_set_post_lock(var_post_id.clone())
	if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_ptype, 'cap'), 'edit_others_posts')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_ptype, 'cap'), 'publish_posts')])) {
		if !(!rt.is_true(var_post_data.array_get(rt.new_string('sticky')))) {
			rt.call_function('stick_post', [var_post_id.clone()])
		} else {
			rt.call_function('unstick_post', [var_post_id.clone()])
		}
	}
	return var_post_id.clone()
}

fn bulk_edit_posts(var_post_data_arg rt.PhpVal) rt.PhpVal {
	mut var_post_data := var_post_data_arg
	mut var_wpdb := rt.new_null()
	mut var_ptype := rt.new_null()
	mut var_post_ids := rt.new_null()
	mut var_reset := []rt.PhpVal{}
	mut var_field := rt.new_null()
	mut var_new_cats := rt.new_null()
	mut var_tax_input := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_tax_name := rt.new_null()
	mut var_comma := rt.new_null()
	mut var_parent := rt.new_null()
	mut var_pages := rt.new_null()
	mut var_children := []rt.PhpVal{}
	mut var_page := rt.new_null()
	mut var_i := i64(0)
	mut var_updated := []rt.PhpVal{}
	mut var_skipped := []rt.PhpVal{}
	mut var_locked := rt.new_null()
	mut var_shared_post_data := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_post := rt.new_null()
	mut var_tax_names := rt.new_null()
	mut var_taxonomy_obj := rt.new_null()
	mut var_new_terms := rt.new_null()
	mut var_current_terms := rt.new_null()
	mut var_cats := rt.new_null()
	mut var_indeterminate_post_category := rt.new_null()
	mut var_indeterminate_cats := rt.new_null()
	mut var_determinate_cats := rt.new_null()
	if !rt.is_true(var_post_data) {
		var_post_data = rt.get_superglobal('_POST')
	}
	if var_post_data.array_isset(rt.new_string('post_type')) {
		var_ptype = rt.call_function('get_post_type_object', [
			var_post_data.array_get(rt.new_string('post_type')),
		])
	} else {
		var_ptype = rt.call_function('get_post_type_object', [
			rt.new_string('post')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_ptype, 'cap'), 'edit_posts'),
	])))))
	{
		if rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_ptype, 'name'))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit pages.'),
				]),
			])
		} else {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit posts.'),
				]),
			])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('-1'),
		var_post_data.array_get(rt.new_string('_status'))))
	{
		var_post_data.array_set('post_status', rt.new_null())
		var_post_data.array_unset(rt.new_string('post_status'))
	} else {
		var_post_data.array_set('post_status', var_post_data.array_get(rt.new_string('_status')))
	}
	var_post_data.array_unset(rt.new_string('_status'))
	if !(!rt.is_true(var_post_data.array_get(rt.new_string('post_status')))) {
		var_post_data.array_set('post_status', rt.call_function('sanitize_key', [
			var_post_data.array_get(rt.new_string('post_status')),
		]))
		if rt.is_true(rt.identical(rt.new_string('inherit'),
			var_post_data.array_get(rt.new_string('post_status'))))
		{
			var_post_data.array_unset(rt.new_string('post_status'))
		}
	}
	var_post_ids = rt.call_function('array_map', [rt.new_string('intval'),
		rt.cast_array(var_post_data.array_get(rt.new_string('post')))])
	var_reset = ['post_author', 'post_status', 'post_password', 'post_parent', 'page_template',
		'comment_status', 'ping_status', 'keep_private', 'tax_input', 'post_category', 'sticky',
		'post_format']
	for var_field_shadow in var_reset {
		if var_post_data.array_isset(rt.new_string(var_field_shadow.str()))
			&& rt.is_true(rt.identical(rt.new_string(''), var_post_data.array_get(rt.new_string(var_field_shadow.str()))))
			|| rt.is_true(rt.identical(rt.new_string('-1'), var_post_data.array_get(rt.new_string(var_field_shadow.str())))) {
			var_post_data.array_unset(rt.new_string(var_field_shadow.str()))
		}
	}
	if var_post_data.array_isset(rt.new_string('post_category')) {
		if var_post_data.array_get(rt.new_string('post_category')).is_array()
			&& !(!rt.is_true(var_post_data.array_get(rt.new_string('post_category')))) {
			var_new_cats = rt.call_function('array_map', [rt.new_string('absint'),
				var_post_data.array_get(rt.new_string('post_category'))])
		} else {
			var_post_data.array_unset(rt.new_string('post_category'))
		}
	}
	var_tax_input = rt.new_array()
	if var_post_data.array_isset(rt.new_string('tax_input')) {
		mut iter_6 := var_post_data.array_get(rt.new_string('tax_input')).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_terms_shadow := item_6.val
			mut var_tax_name_shadow := item_6.key
			if !rt.is_true(var_terms_shadow) {
				continue
			}
			if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
				var_tax_name_shadow.clone()]))
			{
				var_tax_input.array_set(var_tax_name_shadow, rt.call_function('array_map', [
					rt.new_string('absint'),
					var_terms_shadow.clone(),
				]))
			} else {
				var_comma = rt.call_function('_x', [rt.new_string(','),
					rt.new_string('tag delimiter')])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(','), var_comma)))) {
					var_terms_shadow = rt.call_function('str_replace', [
						var_comma.clone(), rt.new_string(','),
						var_terms_shadow.clone()])
				}
				var_tax_input.array_set(var_tax_name_shadow, rt.call_function('explode', [
					rt.new_string(','),
					rt.new_string(var_terms_shadow.clone().to_string().trim_space()),
				]))
			}
		}
	}
	if var_post_data.array_isset(rt.new_string('post_parent'))
		&& rt.is_true(rt.new_int((var_post_data.array_get(rt.new_string('post_parent'))).to_i64())) {
		var_parent = rt.new_int((var_post_data.array_get(rt.new_string('post_parent'))).to_i64())
		var_pages = rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.concat(rt.new_string('SELECT ID, post_parent FROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(" WHERE post_type = 'page'")),
		])
		var_children = rt.new_array()
		var_i = 0
		for {
			if !(var_i < 50 && rt.is_true(rt.greater(var_parent, rt.new_int(0)))) { break
			 }
			var_children << var_parent.clone()
			mut iter_7 := var_pages.iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_page_shadow := item_7.val
				if rt.is_true(rt.identical(rt.new_int((rt.get_property(var_page_shadow, 'ID')).to_i64()),
					var_parent))
				{
					var_parent =
						rt.new_int((rt.get_property(var_page_shadow, 'post_parent')).to_i64())
					break
				}
			}
			var_i += 1
		}
	}
	var_updated = rt.new_array()
	var_skipped = rt.new_array()
	var_locked = rt.new_array()
	var_shared_post_data = var_post_data.clone()
	mut iter_8 := var_post_ids.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_post_id_shadow := item_8.val
		var_post_data = var_shared_post_data.clone()
		var_post_type_object = rt.call_function('get_post_type_object', [
			rt.call_function('get_post_type', [var_post_id_shadow.clone()]),
		])
		if (!(!var_post_type_object.is_null()) || (!var_children.is_null()
			&& rt.is_true(rt.call_function('in_array', [var_post_id_shadow.clone(), rt.create_array_from_list(var_children), rt.new_bool(true)]))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id_shadow.clone()]))))) {
			var_skipped << var_post_id_shadow.clone()
			continue
		}
		if rt.is_true(rt.new_bool(wp_check_post_lock(var_post_id_shadow.clone()))) {
			var_locked.array_push(var_post_id_shadow.clone())
			continue
		}
		var_post = rt.call_function('get_post', [var_post_id_shadow.clone()])
		var_tax_names = rt.call_function('get_object_taxonomies', [
			var_post.clone()])
		mut iter_9 := var_tax_names.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_tax_name_shadow := item_9.val
			var_taxonomy_obj = rt.call_function('get_taxonomy', [
				var_tax_name_shadow.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_taxonomy_obj,
				'show_in_quick_edit')))))
			{
				continue
			}
			if var_tax_input.array_isset(var_tax_name_shadow)
				&& rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_taxonomy_obj, 'cap'), 'assign_terms')])) {
				var_new_terms = var_tax_input.array_get(var_tax_name_shadow)
			} else {
				var_new_terms = rt.new_array()
			}
			if rt.is_true(rt.get_property(var_taxonomy_obj, 'hierarchical')) {
				var_current_terms = rt.cast_array(rt.call_function('wp_get_object_terms', [
					var_post_id_shadow.clone(),
					var_tax_name_shadow.clone(),
					rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }]),
				]))
			} else {
				var_current_terms = rt.cast_array(rt.call_function('wp_get_object_terms', [
					var_post_id_shadow.clone(),
					var_tax_name_shadow.clone(),
					rt.create_array([rt.ArrayItem{ key: 'fields', val: 'names' }]),
				]))
			}
			var_post_data.array_get_mut('tax_input').array_set(var_tax_name_shadow, rt.call_function('array_merge', [
				var_current_terms.clone(),
				var_new_terms.clone(),
			]))
		}
		if !var_new_cats.is_null()
			&& rt.is_true(rt.call_function('in_array', [rt.new_string('category'), var_tax_names.clone(), rt.new_bool(true)])) {
			var_cats = rt.cast_array(rt.call_function('wp_get_post_categories', [
				var_post_id_shadow.clone(),
			]))
			if var_post_data.array_isset(rt.new_string('indeterminate_post_category'))
				&& var_post_data.array_get(rt.new_string('indeterminate_post_category')).is_array() {
				var_indeterminate_post_category =
					var_post_data.array_get(rt.new_string('indeterminate_post_category'))
			} else {
				var_indeterminate_post_category = rt.new_array()
			}
			var_indeterminate_cats = rt.call_function('array_intersect', [
				var_cats.clone(), var_indeterminate_post_category.clone()])
			var_determinate_cats = rt.call_function('array_diff', [
				var_new_cats.clone(), var_indeterminate_post_category.clone()])
			var_post_data.array_set('post_category', rt.call_function('array_unique', [
				rt.call_function('array_merge', [var_indeterminate_cats.clone(),
					var_determinate_cats.clone()]),
			]))
			var_post_data.array_get(rt.new_string('tax_input')).array_unset(rt.new_string('category'))
		}
		var_post_data.array_set('post_ID', var_post_id_shadow.clone())
		var_post_data.array_set('post_type', rt.get_property(var_post, 'post_type'))
		var_post_data.array_set('post_mime_type', rt.get_property(var_post, 'post_mime_type'))
		mut iter_10 := rt.create_array([rt.ArrayItem{ key: none, val: 'comment_status' },
			rt.ArrayItem{ key: none, val: 'ping_status' }, rt.ArrayItem{
				key: none
				val: 'post_author'
			}]).iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_field_shadow := item_10.val
			if !(var_post_data.array_isset(var_field_shadow)) {
				var_post_data.array_set(var_field_shadow, rt.get_property(var_post,
					'{"nodeType":"Expr_Variable","line":678,"name":"field"}'))
			}
		}
		var_post_data = _wp_translate_postdata(true, var_post_data.clone())
		if rt.is_true(rt.call_function('is_wp_error', [var_post_data.clone()])) {
			var_skipped << var_post_id_shadow.clone()
			continue
		}
		var_post_data = _wp_get_allowed_postdata(var_post_data.clone())
		if var_shared_post_data.array_isset(rt.new_string('post_format')) {
			rt.call_function('set_post_format', [var_post_id_shadow.clone(),
				var_shared_post_data.array_get(rt.new_string('post_format'))])
		}
		var_post_data.array_get(rt.new_string('tax_input')).array_unset(rt.new_string('post_format'))
		if rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_status'), rt.create_array([rt.ArrayItem{
			key: none
			val: 'future'
		}, rt.ArrayItem{ key: none, val: 'draft' }]), rt.new_bool(true)]))
			&& rt.is_true(rt.identical(rt.new_string('publish'), var_post_data.array_get(rt.new_string('post_status')))) {
			var_post_data.array_set('post_date', rt.call_function('current_time', [
				rt.new_string('mysql'),
			]))
			var_post_data.array_set('post_date_gmt', '')
		}
		var_post_id_shadow = rt.call_function('wp_update_post', [
			var_post_data.clone()])
		rt.call_function('update_post_meta', [var_post_id_shadow.clone(),
			rt.new_string('_edit_last'), rt.call_function('get_current_user_id', []rt.PhpVal{})])
		var_updated << var_post_id_shadow.clone()
		if var_post_data.array_isset(rt.new_string('sticky'))
			&& rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_ptype, 'cap'), 'edit_others_posts')])) {
			if rt.is_true(rt.identical(rt.new_string('sticky'),
				var_post_data.array_get(rt.new_string('sticky'))))
			{
				rt.call_function('stick_post', [var_post_id_shadow.clone()])
			} else {
				rt.call_function('unstick_post', [var_post_id_shadow.clone()])
			}
		}
	}
	rt.call_function('do_action', [rt.new_string('bulk_edit_posts'),
		rt.create_array_from_list(var_updated), var_shared_post_data.clone()])
	return rt.create_array([rt.ArrayItem{ key: 'updated', val: var_updated },
		rt.ArrayItem{ key: 'skipped', val: var_skipped }, rt.ArrayItem{
			key: 'locked'
			val: var_locked
		}])
}

fn get_default_post_to_edit(post_type string, create_in_db bool) rt.PhpVal {
	mut var_post_type := post_type
	mut var_create_in_db := create_in_db
	mut var_post_title := rt.new_null()
	mut var_post_content := rt.new_null()
	mut var_post_excerpt := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_post := rt.new_null()
	var_post_title = rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_title')))) {
		var_post_title = rt.call_function('esc_html', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_title'))]),
		])
	}
	var_post_content = rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('content')))) {
		var_post_content = rt.call_function('esc_html', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_REQUEST').array_get(rt.new_string('content'))]),
		])
	}
	var_post_excerpt = rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('excerpt')))) {
		var_post_excerpt = rt.call_function('esc_html', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_REQUEST').array_get(rt.new_string('excerpt'))]),
		])
	}
	if var_create_in_db {
		var_post_id = rt.call_function('wp_insert_post', [
			rt.create_array([
				rt.ArrayItem{
					key: 'post_title'
					val: if rt.is_true(rt.call_function('post_type_supports', [
						rt.new_string(post_type),
						rt.new_string('title'),
					]))
					{ rt.call_function('__', [
							rt.new_string('Auto Draft'),
						]) } else { rt.new_string('') }
				},
				rt.ArrayItem{ key: 'post_type', val: post_type },
				rt.ArrayItem{ key: 'post_status', val: 'auto-draft' },
			]),
			rt.new_bool(true),
			rt.new_bool(false),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()])) {
			rt.call_function('wp_die', [
				rt.call_method(var_post_id, 'get_error_message', []rt.PhpVal{}),
			])
		}
		var_post = rt.call_function('get_post', [var_post_id.clone()])
		if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-formats')]))
			&& rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_post, 'post_type'), rt.new_string('post-formats')]))
			&& rt.is_true(rt.call_function('get_option', [rt.new_string('default_post_format')])) {
			rt.call_function('set_post_format', [var_post.clone(),
				rt.call_function('get_option', [rt.new_string('default_post_format')])])
		}
		rt.call_function('wp_after_insert_post', [var_post.clone(),
			rt.new_bool(false), rt.new_null()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [
			rt.new_string('wp_scheduled_auto_draft_delete'),
		])))))
		{
			rt.call_function('wp_schedule_event', [
				rt.call_function('time', []rt.PhpVal{}),
				rt.new_string('daily'),
				rt.new_string('wp_scheduled_auto_draft_delete'),
			])
		}
	} else {
		var_post = create_stdclass()
		rt.set_property(var_post, 'ID', rt.new_int(0))
		rt.set_property(var_post, 'post_author', rt.new_string(''))
		rt.set_property(var_post, 'post_date', rt.new_string(''))
		rt.set_property(var_post, 'post_date_gmt', rt.new_string(''))
		rt.set_property(var_post, 'post_password', rt.new_string(''))
		rt.set_property(var_post, 'post_name', rt.new_string(''))
		rt.set_property(var_post, 'post_type', rt.new_string(post_type))
		rt.set_property(var_post, 'post_status', rt.new_string('draft'))
		rt.set_property(var_post, 'to_ping', rt.new_string(''))
		rt.set_property(var_post, 'pinged', rt.new_string(''))
		rt.set_property(var_post, 'comment_status', rt.call_function('get_default_comment_status', [
			rt.new_string(post_type),
		]))
		rt.set_property(var_post, 'ping_status', rt.call_function('get_default_comment_status', [
			rt.new_string(post_type),
			rt.new_string('pingback'),
		]))
		rt.set_property(var_post, 'post_pingback', rt.call_function('get_option', [
			rt.new_string('default_pingback_flag'),
		]))
		rt.set_property(var_post, 'post_category', rt.call_function('get_option', [
			rt.new_string('default_category'),
		]))
		rt.set_property(var_post, 'page_template', rt.new_string('default'))
		rt.set_property(var_post, 'post_parent', rt.new_int(0))
		rt.set_property(var_post, 'menu_order', rt.new_int(0))
		var_post = create_wp_post(var_post.clone())
	}
	rt.set_property(var_post, 'post_content', (rt.call_function('apply_filters', [
		rt.new_string('default_content'),
		var_post_content.clone(),
		var_post.clone(),
	])).str())
	rt.set_property(var_post, 'post_title', (rt.call_function('apply_filters', [
		rt.new_string('default_title'),
		var_post_title.clone(),
		var_post.clone(),
	])).str())
	rt.set_property(var_post, 'post_excerpt', (rt.call_function('apply_filters', [
		rt.new_string('default_excerpt'),
		var_post_excerpt.clone(),
		var_post.clone(),
	])).str())
	return var_post.clone()
}

fn post_exists(var_title rt.PhpVal, content string, date string, type string, status string) i64 {
	mut var_content := content
	mut var_date := date
	mut var_type := type
	mut var_status := status
	mut var_wpdb := rt.new_null()
	mut var_post_title := rt.new_null()
	mut var_post_content := rt.new_null()
	mut var_post_date := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_post_status := rt.new_null()
	mut var_query := ''
	mut var_args := []rt.PhpVal{}
	var_post_title = rt.call_function('wp_unslash', [
		rt.call_function('sanitize_post_field', [rt.new_string('post_title'),
			var_title.clone(), rt.new_int(0), rt.new_string('db')]),
	])
	var_post_content = rt.call_function('wp_unslash', [
		rt.call_function('sanitize_post_field', [rt.new_string('post_content'),
			rt.new_string(content), rt.new_int(0), rt.new_string('db')]),
	])
	var_post_date = rt.call_function('wp_unslash', [
		rt.call_function('sanitize_post_field', [rt.new_string('post_date'),
			rt.new_string(date), rt.new_int(0), rt.new_string('db')]),
	])
	var_post_type = rt.call_function('wp_unslash', [
		rt.call_function('sanitize_post_field', [rt.new_string('post_type'),
			rt.new_string(type), rt.new_int(0), rt.new_string('db')]),
	])
	var_post_status = rt.call_function('wp_unslash', [
		rt.call_function('sanitize_post_field', [rt.new_string('post_status'),
			rt.new_string(status), rt.new_int(0), rt.new_string('db')]),
	])
	var_query = rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
		'posts')), rt.new_string(' WHERE 1=1'))
	var_args = rt.new_array()
	if !(date == '') {
		var_query = var_query + ' AND post_date = %s'
		var_args << var_post_date.clone()
	}
	if !(!rt.is_true(var_title)) {
		var_query = var_query + ' AND post_title = %s'
		var_args << var_post_title.clone()
	}
	if !(content == '') {
		var_query = var_query + ' AND post_content = %s'
		var_args << var_post_content.clone()
	}
	if !(type == '') {
		var_query = var_query + ' AND post_type = %s'
		var_args << var_post_type.clone()
	}
	if !(status == '') {
		var_query = var_query + ' AND post_status = %s'
		var_args << var_post_status.clone()
	}
	if !(!rt.is_true(var_args)) {
		return rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [rt.new_string(var_query.str()).clone(),
				rt.create_array_from_list(var_args)]),
		])).to_i64())
	}
	return 0
}

fn wp_write_post() i64 {
	mut var_GLOBALS := rt.new_null()
	mut var_ptype := rt.new_null()
	mut var_translated := rt.new_null()
	mut var_post_id := rt.new_null()
	if rt.get_superglobal('_POST').array_isset(rt.new_string('post_type')) {
		var_ptype = rt.call_function('get_post_type_object', [
			rt.get_superglobal('_POST').array_get(rt.new_string('post_type')),
		])
	} else {
		var_ptype = rt.call_function('get_post_type_object', [
			rt.new_string('post')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_ptype, 'cap'), 'edit_posts'),
	])))))
	{
		if rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_ptype, 'name'))) {
			return (create_wp_error(rt.new_string('edit_pages'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to create pages on this site.'),
			]))).to_i64()
		} else {
			return (create_wp_error(rt.new_string('edit_posts'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to create posts or drafts on this site.'),
			]))).to_i64()
		}
	}
	rt.get_superglobal('_POST').array_set('post_mime_type', '')
	rt.get_superglobal('_POST').array_unset(rt.new_string('filter'))
	if rt.get_superglobal('_POST').array_isset(rt.new_string('post_ID')) {
		return (edit_post(rt.new_null())).to_i64()
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('visibility')) {
		mut switch_val_2 := rt.get_superglobal('_POST').array_get(rt.new_string('visibility'))
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('public'))) {
			rt.get_superglobal('_POST').array_set('post_password', '')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('password'))) {
			rt.get_superglobal('_POST').array_unset(rt.new_string('sticky'))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('private'))) {
			rt.get_superglobal('_POST').array_set('post_status', 'private')
			rt.get_superglobal('_POST').array_set('post_password', '')
			rt.get_superglobal('_POST').array_unset(rt.new_string('sticky'))
		}
	}
	var_translated = _wp_translate_postdata(false, rt.new_null())
	if rt.is_true(rt.call_function('is_wp_error', [var_translated.clone()])) {
		return var_translated.to_i64()
	}
	var_translated = _wp_get_allowed_postdata(var_translated.clone())
	var_post_id = rt.call_function('wp_insert_post', [var_translated.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()])) {
		return var_post_id.to_i64()
	}
	if !rt.is_true(var_post_id) {
		return 0
	}
	rt.new_bool(add_meta(var_post_id.clone()))
	rt.call_function('add_post_meta', [var_post_id.clone(), rt.new_string('_edit_last'),
		rt.get_property(var_GLOBALS.array_get(rt.new_string('current_user')), 'ID')])
	_fix_attachment_links(var_post_id.clone())
	wp_set_post_lock(var_post_id.clone())
	return var_post_id.to_i64()
}

fn write_post() i64 {
	mut var_result := i64(0)
	var_result = wp_write_post()
	if rt.is_true(rt.call_function('is_wp_error', [rt.new_int(var_result).clone()])) {
		rt.call_function('wp_die', [
			rt.call_method(rt.new_int(var_result), 'get_error_message', []rt.PhpVal{}),
		])
	} else {
		return var_result
	}
	return 0
}

fn add_meta(var_post_id_arg rt.PhpVal) bool {
	mut var_post_id := var_post_id_arg
	mut var_metakeyselect := rt.new_null()
	mut var_metakeyinput := rt.new_null()
	mut var_metavalue := rt.new_null()
	mut var_metakey := rt.new_null()
	var_post_id = rt.new_int(var_post_id.to_i64())
	var_metakeyselect = if rt.get_superglobal('_POST').array_isset(rt.new_string('metakeyselect')) { rt.call_function('wp_unslash', [
			rt.new_string(rt.get_superglobal('_POST').array_get(rt.new_string('metakeyselect')).to_string().trim_space()),
		]) } else { rt.new_string('') }
	var_metakeyinput = if rt.get_superglobal('_POST').array_isset(rt.new_string('metakeyinput')) { rt.call_function('wp_unslash', [
			rt.new_string(rt.get_superglobal('_POST').array_get(rt.new_string('metakeyinput')).to_string().trim_space()),
		]) } else { rt.new_string('') }
	var_metavalue = if !(rt.get_superglobal('_POST').array_get(rt.new_string('metavalue'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('metavalue'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(var_metavalue.clone().is_string())) {
		var_metavalue = rt.new_string(var_metavalue.clone().to_string().trim_space())
	}
	if (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('#NONE#'), var_metakeyselect))))
		&& !(!rt.is_true(var_metakeyselect))) || !(!rt.is_true(var_metakeyinput)) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('#NONE#'),
			var_metakeyselect))))
		{
			var_metakey = var_metakeyselect.clone()
		}
		if rt.is_true(var_metakeyinput) {
			var_metakey = var_metakeyinput.clone()
		}
		if rt.is_true(rt.call_function('is_protected_meta', [var_metakey.clone(), rt.new_string('post')]))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('add_post_meta'), var_post_id.clone(), var_metakey.clone()]))))) {
			return false
		}
		var_metakey = rt.call_function('wp_slash', [var_metakey.clone()])
		return (rt.call_function('add_post_meta', [var_post_id.clone(),
			var_metakey.clone(), var_metavalue.clone()])).to_bool()
	}
	return false
}

fn delete_meta(var_mid rt.PhpVal) rt.PhpVal {
	return rt.call_function('delete_metadata_by_mid', [rt.new_string('post'),
		var_mid.clone()])
}

fn get_meta_keys() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_keys := rt.new_null()
	var_keys = rt.call_method(var_wpdb, 'get_col', [
		rt.concat(rt.concat(rt.new_string('SELECT meta_key\n\t\tFROM '), rt.get_property(var_wpdb,
			'postmeta')), rt.new_string('\n\t\tGROUP BY meta_key\n\t\tORDER BY meta_key')),
	])
	return var_keys.clone()
}

fn get_post_meta_by_id(var_mid rt.PhpVal) rt.PhpVal {
	return rt.call_function('get_metadata_by_mid', [rt.new_string('post'),
		var_mid.clone()])
}

fn has_meta(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT meta_key, meta_value, meta_id, post_id\n\t\t\tFROM '), rt.get_property(var_wpdb,
				'postmeta')), rt.new_string(' WHERE post_id = %d\n\t\t\tORDER BY meta_key,meta_id')),
			var_post_id.clone(),
		]),
		rt.get_constant('ARRAY_A'),
	])
}

fn update_meta(var_meta_id rt.PhpVal, var_meta_key_arg rt.PhpVal, var_meta_value_arg rt.PhpVal) rt.PhpVal {
	mut var_meta_key := var_meta_key_arg
	mut var_meta_value := var_meta_value_arg
	var_meta_key = rt.call_function('wp_unslash', [var_meta_key.clone()])
	var_meta_value = rt.call_function('wp_unslash', [var_meta_value.clone()])
	return rt.call_function('update_metadata_by_mid', [rt.new_string('post'),
		var_meta_id.clone(), var_meta_value.clone(), var_meta_key.clone()])
}

fn _fix_attachment_links(var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_post := var_post_arg
	mut var_link_matches := []rt.PhpVal{}
	mut var_url_match := []rt.PhpVal{}
	mut var_rel_match := []rt.PhpVal{}
	mut var_content := rt.new_null()
	mut var_site_url := rt.new_null()
	mut var_replace := rt.new_null()
	mut var_value := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	mut var_quote := rt.new_null()
	mut var_url_id := rt.new_null()
	mut var_rel_id := rt.new_null()
	mut var_link := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone(),
		rt.get_constant('ARRAY_A')])
	var_content = var_post.array_get(rt.new_string('post_content'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post.array_get(rt.new_string('post_status')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'publish'
	}, rt.ArrayItem{ key: none, val: 'future' }, rt.ArrayItem{ key: none, val: 'private' }]), rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strpos', [var_content.clone(), rt.new_string('?attachment_id=')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match_all', [rt.new_string('/<a ([^>]+)>[\\s\\S]+?<\\/a>/'), var_content.clone(), rt.create_array_from_list(var_link_matches)]))))) {
		return rt.new_null()
	}
	var_site_url = rt.call_function('get_bloginfo', [rt.new_string('url')])
	var_site_url = rt.call_function('substr', [var_site_url.clone(),
		rt.new_int((rt.call_function('strpos', [var_site_url.clone(),
			rt.new_string('://')])).to_i64())])
	var_replace = rt.new_string('')
	mut iter_11 := var_link_matches[1].iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_value_shadow := item_11.val
		mut var_key_shadow := item_11.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strpos', [var_value_shadow.clone(), rt.new_string('?attachment_id=')])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strpos', [var_value_shadow.clone(), rt.new_string('wp-att-')])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/href=(["\'])[^"\']*\\?attachment_id=(\\d+)[^"\']*\\1/'), var_value_shadow.clone(), rt.create_array_from_list(var_url_match)])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/rel=["\'][^"\']*wp-att-(\\d+)/'), var_value_shadow.clone(), rt.create_array_from_list(var_rel_match)]))))) {
			continue
		}
		var_quote = var_url_match[1]
		var_url_id = rt.new_int((var_url_match[2]).to_i64())
		var_rel_id = rt.new_int((var_rel_match[1]).to_i64())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_url_id))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_rel_id))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_url_id, var_rel_id))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_url_match[0], var_site_url.clone()]))))) {
			continue
		}
		var_link = var_link_matches[0].array_get(var_key_shadow)
		var_replace = rt.call_function('str_replace', [var_url_match[0],
			rt.new_string('href=' + var_quote.str() +
				(rt.call_function('get_attachment_link', [var_url_id.clone()])).str() +
				var_quote.str()),
			var_link.clone()])
		var_content = rt.call_function('str_replace', [var_link.clone(),
			var_replace.clone(), var_content.clone()])
	}
	if rt.is_true(var_replace) {
		var_post.array_set('post_content', var_content.clone())
		var_post = rt.call_function('add_magic_quotes', [var_post.clone()])
		return rt.call_function('wp_update_post', [var_post.clone()])
	}
	return rt.new_null()
}

fn get_available_post_statuses(type string) rt.PhpVal {
	mut var_type := type
	mut var_statuses := rt.new_null()
	var_statuses = rt.call_function('wp_count_posts', [rt.new_string(type)])
	return rt.func_array_keys(rt.call_function('get_object_vars', [
		var_statuses.clone()]))
}

fn wp_edit_posts_query(q bool) rt.PhpVal {
	mut var_q := q
	mut var_post_statuses := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_avail_post_stati := rt.new_null()
	mut var_post_status := rt.new_null()
	mut var_perm := ''
	mut var_orderby := rt.new_null()
	mut var_order := rt.new_null()
	mut var_per_page := ''
	mut var_posts_per_page := rt.new_null()
	mut var_query := rt.new_null()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_q))) {
		var_q = var__GET.to_bool()
	}
	rt.new_bool(var_q).array_set('m', if rt.new_bool(var_q).array_isset(rt.new_string('m')) {
		rt.new_int((rt.new_bool(var_q).array_get(rt.new_string('m'))).to_i64())
	} else {
		0
	})
	rt.new_bool(var_q).array_set('cat', if rt.new_bool(var_q).array_isset(rt.new_string('cat')) {
		rt.new_int((rt.new_bool(var_q).array_get(rt.new_string('cat'))).to_i64())
	} else {
		0
	})
	var_post_statuses = rt.call_function('get_post_stati', []rt.PhpVal{})
	if rt.new_bool(var_q).array_isset(rt.new_string('post_type'))
		&& rt.is_true(rt.call_function('in_array', [rt.new_bool(var_q).array_get(rt.new_string('post_type')), rt.call_function('get_post_types', []rt.PhpVal{}), rt.new_bool(true)])) {
		var_post_type = rt.new_bool(var_q).array_get(rt.new_string('post_type'))
	} else {
		var_post_type = rt.new_string('post')
	}
	var_avail_post_stati = get_available_post_statuses(var_post_type.clone())
	var_post_status = rt.new_string('')
	var_perm = ''
	if rt.new_bool(var_q).array_isset(rt.new_string('post_status'))
		&& rt.is_true(rt.call_function('in_array', [rt.new_bool(var_q).array_get(rt.new_string('post_status')), var_post_statuses.clone(), rt.new_bool(true)])) {
		var_post_status = rt.new_bool(var_q).array_get(rt.new_string('post_status'))
		var_perm = 'readable'
	}
	var_orderby = rt.new_string('')
	if rt.new_bool(var_q).array_isset(rt.new_string('orderby')) {
		var_orderby = rt.new_bool(var_q).array_get(rt.new_string('orderby'))
	} else if rt.new_bool(var_q).array_isset(rt.new_string('post_status'))
		&& rt.is_true(rt.call_function('in_array', [rt.new_bool(var_q).array_get(rt.new_string('post_status')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'pending'
	}, rt.ArrayItem{ key: none, val: 'draft' }]), rt.new_bool(true)])) {
		var_orderby = rt.new_string('modified')
	}
	var_order = rt.new_string('')
	if rt.new_bool(var_q).array_isset(rt.new_string('order')) {
		var_order = rt.new_bool(var_q).array_get(rt.new_string('order'))
	} else if rt.new_bool(var_q).array_isset(rt.new_string('post_status'))
		&& rt.is_true(rt.identical(rt.new_string('pending'), rt.new_bool(var_q).array_get(rt.new_string('post_status')))) {
		var_order = rt.new_string('ASC')
	}
	var_per_page = 'edit_${var_post_type.to_string()}_per_page'
	var_posts_per_page = rt.new_int((rt.call_function('get_user_option', [
		rt.new_string(var_per_page.str()).clone()])).to_i64())
	if !rt.is_true(var_posts_per_page) || rt.is_true(rt.less(var_posts_per_page, rt.new_int(1))) {
		var_posts_per_page = rt.new_int(20)
	}
	var_posts_per_page = rt.call_function('apply_filters', [
		rt.new_string('edit_${var_post_type.to_string()}_per_page'),
		var_posts_per_page.clone(),
	])
	var_posts_per_page = rt.call_function('apply_filters', [
		rt.new_string('edit_posts_per_page'),
		var_posts_per_page.clone(),
		var_post_type.clone(),
	])
	var_query = rt.call_function('compact', [rt.new_string('post_type'),
		rt.new_string('post_status'), rt.new_string('perm'), rt.new_string('order'),
		rt.new_string('orderby'), rt.new_string('posts_per_page')])
	if rt.is_true(rt.call_function('is_post_type_hierarchical', [var_post_type.clone()]))
		&& !rt.is_true(var_orderby) {
		var_query.array_set('orderby', 'menu_order title')
		var_query.array_set('order', 'asc')
		var_query.array_set('posts_per_page', -1)
		var_query.array_set('posts_per_archive_page', -1)
		var_query.array_set('fields', 'id=>parent')
	}
	if !(!rt.is_true(rt.new_bool(var_q).array_get(rt.new_string('show_sticky')))) {
		var_query.array_set('post__in', rt.cast_array(rt.call_function('get_option', [
			rt.new_string('sticky_posts'),
		])))
	}
	rt.call_function('wp', [var_query.clone()])
	return var_avail_post_stati.clone()
}

fn wp_edit_attachments_query_vars(q bool) rt.PhpVal {
	mut var_q := q
	mut var_post_type := rt.new_null()
	mut var_states := ''
	mut var_media_per_page := rt.new_null()
	mut var_post_mime_types := rt.new_null()
	mut var_type := rt.new_null()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_q))) {
		var_q = var__GET.to_bool()
	}
	rt.new_bool(var_q).array_set('m', if rt.new_bool(var_q).array_isset(rt.new_string('m')) {
		rt.new_int((rt.new_bool(var_q).array_get(rt.new_string('m'))).to_i64())
	} else {
		0
	})
	rt.new_bool(var_q).array_set('cat', if rt.new_bool(var_q).array_isset(rt.new_string('cat')) {
		rt.new_int((rt.new_bool(var_q).array_get(rt.new_string('cat'))).to_i64())
	} else {
		0
	})
	rt.new_bool(var_q).array_set('post_type', 'attachment')
	var_post_type = rt.call_function('get_post_type_object', [
		rt.new_string('attachment'),
	])
	var_states = 'inherit'
	if rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_post_type, 'cap'), 'read_private_posts'),
	]))
	{
		var_states = var_states + ',private'
	}
	rt.new_bool(var_q).array_set('post_status', if
		rt.new_bool(var_q).array_isset(rt.new_string('status'))
		&& rt.is_true(rt.identical(rt.new_string('trash'), rt.new_bool(var_q).array_get(rt.new_string('status')))) {
		'trash'
	} else {
		var_states
	})
	rt.new_bool(var_q).array_set('post_status', if
		rt.new_bool(var_q).array_isset(rt.new_string('attachment-filter'))
		&& rt.is_true(rt.identical(rt.new_string('trash'), rt.new_bool(var_q).array_get(rt.new_string('attachment-filter')))) {
		'trash'
	} else {
		var_states
	})
	var_media_per_page = rt.new_int((rt.call_function('get_user_option', [
		rt.new_string('upload_per_page'),
	])).to_i64())
	if !rt.is_true(var_media_per_page) || rt.is_true(rt.less(var_media_per_page, rt.new_int(1))) {
		var_media_per_page = rt.new_int(20)
	}
	rt.new_bool(var_q).array_set('posts_per_page', rt.call_function('apply_filters', [
		rt.new_string('upload_per_page'),
		var_media_per_page.clone(),
	]))
	var_post_mime_types = rt.call_function('get_post_mime_types', []rt.PhpVal{})
	if rt.new_bool(var_q).array_isset(rt.new_string('post_mime_type'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_intersect', [rt.cast_array(rt.new_bool(var_q).array_get(rt.new_string('post_mime_type'))), rt.func_array_keys(var_post_mime_types.clone())]))))) {
		rt.new_bool(var_q).array_unset(rt.new_string('post_mime_type'))
	}
	mut iter_12 := rt.func_array_keys(var_post_mime_types.clone()).iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_type_shadow := item_12.val
		if rt.new_bool(var_q).array_isset(rt.new_string('attachment-filter'))
			&& rt.is_true(rt.identical(rt.new_string('post_mime_type:${var_type.to_string()}'), rt.new_bool(var_q).array_get(rt.new_string('attachment-filter')))) {
			rt.new_bool(var_q).array_set('post_mime_type', var_type_shadow.clone())
			break
		}
	}
	if rt.new_bool(var_q).array_isset(rt.new_string('detached'))
		|| (rt.new_bool(var_q).array_isset(rt.new_string('attachment-filter'))
		&& rt.is_true(rt.identical(rt.new_string('detached'), rt.new_bool(var_q).array_get(rt.new_string('attachment-filter'))))) {
		rt.new_bool(var_q).array_set('post_parent', 0)
	}
	if rt.new_bool(var_q).array_isset(rt.new_string('mine'))
		|| (rt.new_bool(var_q).array_isset(rt.new_string('attachment-filter'))
		&& rt.is_true(rt.identical(rt.new_string('mine'), rt.new_bool(var_q).array_get(rt.new_string('attachment-filter'))))) {
		rt.new_bool(var_q).array_set('author', rt.call_function('get_current_user_id',
			[]rt.PhpVal{}))
	}
	if rt.new_bool(var_q).array_isset(rt.new_string('s')) {
		rt.call_function('add_filter', [
			rt.new_string('wp_allow_query_attachment_by_filename'),
			rt.new_string('__return_true'),
		])
	}
	return rt.new_bool(var_q)
}

fn wp_edit_attachments_query(q bool) rt.PhpVal {
	mut var_q := q
	mut var_post_mime_types := rt.new_null()
	mut var_avail_post_mime_types := rt.new_null()
	rt.call_function('wp', [wp_edit_attachments_query_vars(var_q)])
	var_post_mime_types = rt.call_function('get_post_mime_types', []rt.PhpVal{})
	var_avail_post_mime_types = rt.call_function('get_available_post_mime_types', [
		rt.new_string('attachment'),
	])
	return rt.create_array([rt.ArrayItem{ key: none, val: var_post_mime_types },
		rt.ArrayItem{ key: none, val: var_avail_post_mime_types }])
}

fn postbox_classes(var_box_id rt.PhpVal, var_screen_id rt.PhpVal) rt.PhpVal {
	mut var_classes := rt.new_null()
	mut var_closed := rt.new_null()
	if rt.get_superglobal('_GET').array_isset(rt.new_string('edit'))
		&& rt.is_true(rt.identical(rt.get_superglobal('_GET').array_get(rt.new_string('edit')), var_box_id)) {
		var_classes = rt.create_array([rt.ArrayItem{ key: none, val: '' }])
	} else if rt.is_true(rt.call_function('get_user_option', [
		rt.new_string('closedpostboxes_' + var_screen_id.str()),
	]))
	{
		var_closed = rt.call_function('get_user_option', [
			rt.new_string('closedpostboxes_' + var_screen_id.str()),
		])
		if !(var_closed.clone().is_array()) {
			var_classes = rt.create_array([rt.ArrayItem{ key: none, val: '' }])
		} else {
			var_classes = if rt.is_true(rt.call_function('in_array', [
				var_box_id.clone(), var_closed.clone(), rt.new_bool(true)]))
			{ rt.create_array([rt.ArrayItem{ key: none, val: 'closed' }]) } else { rt.create_array([
					rt.ArrayItem{ key: none, val: '' },
				]) }
		}
	} else {
		var_classes = rt.create_array([rt.ArrayItem{ key: none, val: '' }])
	}
	var_classes = rt.call_function('apply_filters', [
		rt.new_string('postbox_classes_${var_screen_id.to_string()}_${var_box_id.to_string()}'),
		var_classes.clone(),
	])
	return rt.call_function('implode', [rt.new_string(' '), var_classes.clone()])
}

fn get_sample_permalink(var_post_arg rt.PhpVal, var_title rt.PhpVal, var_name rt.PhpVal) rt.PhpVal {
	mut var_post := var_post_arg
	mut var_ptype := rt.new_null()
	mut var_original_status := rt.new_null()
	mut var_original_date := rt.new_null()
	mut var_original_name := rt.new_null()
	mut var_original_filter := rt.new_null()
	mut var_permalink := rt.new_null()
	mut var_uri := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: '' },
			rt.ArrayItem{ key: none, val: '' }])
	}
	var_ptype = rt.call_function('get_post_type_object', [
		rt.get_property(var_post, 'post_type'),
	])
	var_original_status = rt.get_property(var_post, 'post_status')
	var_original_date = rt.get_property(var_post, 'post_date')
	var_original_name = rt.get_property(var_post, 'post_name')
	var_original_filter = rt.get_property(var_post, 'filter')
	if rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_status'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'auto-draft' },
			rt.ArrayItem{ key: none, val: 'draft' }, rt.ArrayItem{ key: none, val: 'pending' },
			rt.ArrayItem{ key: none, val: 'future' }]),
		rt.new_bool(true)]))
	{
		rt.set_property(var_post, 'post_status', rt.new_string('publish'))
		rt.set_property(var_post, 'post_name', rt.call_function('sanitize_title', [if rt.is_true(rt.get_property(var_post,
			'post_name'))
		{
			rt.get_property(var_post, 'post_name')
		} else {
			rt.get_property(var_post, 'post_title')
		}, rt.get_property(var_post, 'ID')]))
	}
	if !(var_name.clone().is_null()) {
		rt.set_property(var_post, 'post_name', rt.call_function('sanitize_title', [if rt.is_true(var_name) {
			var_name
		} else {
			var_title
		}, rt.get_property(var_post, 'ID')]))
	}
	rt.set_property(var_post, 'post_name', rt.call_function('wp_unique_post_slug', [
		rt.get_property(var_post, 'post_name'),
		rt.get_property(var_post, 'ID'),
		rt.get_property(var_post, 'post_status'),
		rt.get_property(var_post, 'post_type'),
		rt.get_property(var_post, 'post_parent'),
	]))
	rt.set_property(var_post, 'filter', rt.new_string('sample'))
	var_permalink = rt.call_function('get_permalink', [var_post.clone(),
		rt.new_bool(true)])
	var_permalink = rt.call_function('str_replace', [
		rt.concat(rt.concat(rt.new_string('%'), rt.get_property(var_post, 'post_type')),
			rt.new_string('%')),
		rt.new_string('%pagename%'),
		var_permalink.clone(),
	])
	if rt.is_true(rt.get_property(var_ptype, 'hierarchical')) {
		var_uri = rt.call_function('get_page_uri', [var_post.clone()])
		if rt.is_true(var_uri) {
			var_uri = rt.call_function('untrailingslashit', [
				var_uri.clone()])
			var_uri = rt.call_function('strrev', [
				rt.call_function('stristr', [
					rt.call_function('strrev', [var_uri.clone()]),
					rt.new_string('/'),
				]),
			])
			var_uri = rt.call_function('untrailingslashit', [
				var_uri.clone()])
		}
		var_uri = rt.call_function('apply_filters', [rt.new_string('editable_slug'),
			var_uri.clone(), var_post.clone()])
		if !(!rt.is_true(var_uri)) {
			var_uri = rt.concat(var_uri, rt.new_string('/'))
		}
		var_permalink = rt.call_function('str_replace', [rt.new_string('%pagename%'),
			rt.new_string('${var_uri.to_string()}%pagename%'),
			var_permalink.clone()])
	}
	var_permalink = rt.create_array([rt.ArrayItem{ key: none, val: var_permalink },
		rt.ArrayItem{ key: none, val: rt.call_function('apply_filters', [
			rt.new_string('editable_slug'),
			rt.get_property(var_post, 'post_name'),
			var_post.clone(),
		]) }])
	rt.set_property(var_post, 'post_status', var_original_status.clone())
	rt.set_property(var_post, 'post_date', var_original_date.clone())
	rt.set_property(var_post, 'post_name', var_original_name.clone())
	rt.set_property(var_post, 'filter', var_original_filter.clone())
	return rt.call_function('apply_filters', [rt.new_string('get_sample_permalink'),
		var_permalink.clone(), rt.get_property(var_post, 'ID'),
		var_title.clone(), var_name.clone(), var_post.clone()])
}

fn get_sample_permalink_html(var_post_arg rt.PhpVal, var_new_title rt.PhpVal, var_new_slug rt.PhpVal) string {
	mut var_post := var_post_arg
	mut var_permalink := rt.new_null()
	mut var_post_name := rt.new_null()
	mut var_view_link := rt.new_null()
	mut var_preview_target := ''
	mut var_return := rt.new_null()
	mut var_display_link := rt.new_null()
	mut var_post_name_abridged := rt.new_null()
	mut var_post_name_html := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return ''
	}
	mut list_tmp_1 := get_sample_permalink(rt.get_property(var_post, 'ID'), var_new_title.clone(),
		var_new_slug.clone())
	var_permalink = list_tmp_1.array_get(0)
	var_post_name = list_tmp_1.array_get(1)
	var_view_link = rt.new_bool(false)
	var_preview_target = ''
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'),
		rt.get_property(var_post, 'ID')]))
	{
		if rt.is_true(rt.identical(rt.new_string('draft'), rt.get_property(var_post, 'post_status')))
			|| !rt.is_true(rt.get_property(var_post, 'post_name')) {
			var_view_link = rt.call_function('get_preview_post_link', [
				var_post.clone()])
			var_preview_target = rt.concat(rt.concat(rt.new_string(" target='wp-preview-"),
				rt.get_property(var_post, 'ID')), rt.new_string("'"))
		} else {
			if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post, 'post_status')))
				|| rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_post, 'post_type'))) {
				var_view_link = rt.call_function('get_permalink', [
					var_post.clone()])
			} else {
				var_view_link = rt.call_function('str_replace', [
					rt.create_array([rt.ArrayItem{ key: none, val: '%pagename%' },
						rt.ArrayItem{ key: none, val: '%postname%' }]),
					rt.get_property(var_post, 'post_name'),
					var_permalink.clone(),
				])
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_permalink.clone(), rt.new_string('%postname%')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_permalink.clone(), rt.new_string('%pagename%')]))))) {
		var_return = rt.new_string('<strong>' +
			(rt.call_function('__', [rt.new_string('Permalink:')])).str() + '</strong>\n')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_view_link)))) {
			var_display_link = rt.call_function('urldecode', [
				var_view_link.clone()])
			var_return = rt.concat(var_return, rt.new_string('<a id="sample-permalink" href="' +
				(rt.call_function('esc_url', [var_view_link.clone()])).str() + '"' +
				var_preview_target + '>' +
				(rt.call_function('esc_html', [var_display_link.clone()])).str() + '</a>\n'))
		} else {
			var_return = rt.concat(var_return, rt.new_string('<span id="sample-permalink">' +
				var_permalink.str() + '</span>\n'))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])))))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))
			&& !(rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')])))
			&& rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('page_on_front')])).to_i64()), rt.get_property(var_post, 'ID')))) {
			var_return = rt.concat(var_return, rt.new_string(
				'<span id="change-permalinks"><a href="options-permalink.php" class="button button-small">' +
				(rt.call_function('__', [rt.new_string('Change Permalink Structure')])).str() +
				'</a></span>\n'))
		}
	} else {
		if rt.is_true(rt.greater(rt.call_function('mb_strlen', [
			var_post_name.clone()]), rt.new_int(34)))
		{
			var_post_name_abridged = rt.new_string(
				(rt.call_function('mb_substr', [var_post_name.clone(), rt.new_int(0), rt.new_int(16)])).str() +
				'&hellip;' +
				(rt.call_function('mb_substr', [var_post_name.clone(), rt.new_int(-16)])).str())
		} else {
			var_post_name_abridged = var_post_name
		}
		var_post_name_html = rt.new_string('<span id="editable-post-name">' +
			(rt.call_function('esc_html', [var_post_name_abridged.clone()])).str() + '</span>')
		var_display_link = rt.call_function('str_replace', [
			rt.create_array([rt.ArrayItem{ key: none, val: '%pagename%' },
				rt.ArrayItem{ key: none, val: '%postname%' }]),
			var_post_name_html.clone(),
			rt.call_function('esc_html', [rt.call_function('urldecode', [
				var_permalink.clone()])]),
		])
		var_return = rt.new_string('<strong>' +
			(rt.call_function('__', [rt.new_string('Permalink:')])).str() + '</strong>\n')
		var_return = rt.concat(var_return, rt.new_string('<span id="sample-permalink"><a href="' +
			(rt.call_function('esc_url', [var_view_link.clone()])).str() + '"' +
			var_preview_target + '>' + var_display_link.str() + '</a></span>\n'))
		var_return = rt.concat(var_return, rt.new_string('&lrm;'))
		var_return = rt.concat(var_return, rt.new_string(
			'<span id="edit-slug-buttons"><button type="button" class="edit-slug button button-small hide-if-no-js" aria-label="' +
			(rt.call_function('__', [rt.new_string('Edit permalink')])).str() + '">' +
			(rt.call_function('__', [rt.new_string('Edit')])).str() + '</button></span>\n'))
		var_return = rt.concat(var_return, rt.new_string('<span id="editable-post-name-full">' +
			(rt.call_function('esc_html', [var_post_name.clone()])).str() + '</span>\n'))
	}
	var_return = rt.call_function('apply_filters', [
		rt.new_string('get_sample_permalink_html'),
		var_return.clone(),
		rt.get_property(var_post, 'ID'),
		var_new_title.clone(),
		var_new_slug.clone(),
		var_post.clone(),
	])
	return var_return.str()
}

fn _wp_post_thumbnail_html(var_thumbnail_id rt.PhpVal, var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_post := var_post_arg
	mut var__wp_additional_image_sizes := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_set_thumbnail_link := ''
	mut var_upload_iframe_src := rt.new_null()
	mut var_content := rt.new_null()
	mut var_size := rt.new_null()
	mut var_thumbnail_html := rt.new_null()
	var__wp_additional_image_sizes = rt.call_function('wp_get_additional_image_sizes',
		[]rt.PhpVal{})
	var_post = rt.call_function('get_post', [var_post.clone()])
	var_post_type_object = rt.call_function('get_post_type_object', [
		rt.get_property(var_post, 'post_type'),
	])
	var_set_thumbnail_link = '<p class="hide-if-no-js"><a href="%s" id="set-post-thumbnail"%s class="thickbox" role="button" aria-haspopup="dialog" aria-controls="wp-media-modal">%s</a></p>'
	var_upload_iframe_src = rt.call_function('get_upload_iframe_src', [
		rt.new_string('image'),
		rt.get_property(var_post, 'ID'),
	])
	var_content = rt.call_function('sprintf', [rt.new_string(var_set_thumbnail_link.str()).clone(),
		rt.call_function('esc_url', [var_upload_iframe_src.clone()]),
		rt.new_string(''),
		rt.call_function('esc_html', [
			rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'set_featured_image'),
		])])
	if rt.is_true(var_thumbnail_id)
		&& rt.is_true(rt.call_function('get_post', [var_thumbnail_id.clone()])) {
		var_size = if var__wp_additional_image_sizes.array_isset(rt.new_string('post-thumbnail')) { rt.new_string('post-thumbnail') } else { rt.create_array([
				rt.ArrayItem{ key: none, val: 266 },
				rt.ArrayItem{ key: none, val: 266 },
			]) }
		var_size = rt.call_function('apply_filters', [
			rt.new_string('admin_post_thumbnail_size'),
			var_size.clone(),
			var_thumbnail_id.clone(),
			var_post.clone(),
		])
		var_thumbnail_html = rt.call_function('wp_get_attachment_image', [
			var_thumbnail_id.clone(), var_size.clone()])
		if !(!rt.is_true(var_thumbnail_html)) {
			var_content = rt.call_function('sprintf', [rt.new_string(var_set_thumbnail_link.str()).clone(),
				rt.call_function('esc_url', [var_upload_iframe_src.clone()]),
				rt.new_string(' aria-describedby="set-post-thumbnail-desc"'),
				var_thumbnail_html.clone()])
			var_content = rt.concat(var_content, rt.new_string(
				'<p class="hide-if-no-js howto" id="set-post-thumbnail-desc">' +
				(rt.call_function('__', [rt.new_string('Click the image to edit or update')])).str() +
				'</p>'))
			var_content = rt.concat(var_content, rt.new_string(
				'<p class="hide-if-no-js"><a href="#" id="remove-post-thumbnail" role="button">' +
				(rt.call_function('esc_html', [rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'remove_featured_image')])).str() +
				'</a></p>'))
		}
	}
	var_content = rt.concat(var_content, rt.new_string(
		'<input type="hidden" id="_thumbnail_id" name="_thumbnail_id" value="' +
		(rt.call_function('esc_attr', [if rt.is_true(var_thumbnail_id) { var_thumbnail_id } else { rt.new_string('-1') }])).str() +
		'" />'))
	return rt.call_function('apply_filters', [rt.new_string('admin_post_thumbnail_html'),
		var_content.clone(), rt.get_property(var_post, 'ID'),
		var_thumbnail_id.clone()])
}

fn wp_check_post_lock(var_post_arg rt.PhpVal) bool {
	mut var_post := var_post_arg
	mut var_lock := rt.new_null()
	mut var_time := rt.new_null()
	mut var_user := rt.new_null()
	mut var_time_window := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	var_lock = rt.call_function('get_post_meta', [rt.get_property(var_post, 'ID'),
		rt.new_string('_edit_lock'), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_lock)))) {
		return false
	}
	var_lock = rt.call_function('explode', [rt.new_string(':'),
		var_lock.clone()])
	var_time = var_lock.array_get(rt.new_int(0))
	var_user = rt.new_int(if var_lock.array_isset(rt.new_int(1)) { rt.new_int((var_lock.array_get(rt.new_int(1))).to_i64()) } else { rt.new_int((rt.call_function('get_post_meta', [
			rt.get_property(var_post, 'ID'),
			rt.new_string('_edit_last'),
			rt.new_bool(true),
		])).to_i64()) })
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_userdata', [
		var_user.clone()])))))
	{
		return false
	}
	var_time_window = rt.call_function('apply_filters', [
		rt.new_string('wp_check_post_lock_window'),
		rt.new_int(150),
	])
	if rt.is_true(var_time)
		&& rt.is_true(rt.greater(var_time, rt.sub(rt.call_function('time', []rt.PhpVal{}), var_time_window)))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), var_user)))) {
		return var_user.to_bool()
	}
	return false
}

fn wp_set_post_lock(var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_post := var_post_arg
	mut var_user_id := rt.new_null()
	mut var_now := rt.new_null()
	mut var_lock := ''
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.new_bool(false)
	}
	var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_int(0), var_user_id)) {
		return rt.new_bool(false)
	}
	var_now = rt.call_function('time', []rt.PhpVal{})
	var_lock = '${var_now.to_string()}:${var_user_id.to_string()}'
	rt.call_function('update_post_meta', [rt.get_property(var_post, 'ID'),
		rt.new_string('_edit_lock'), rt.new_string(var_lock.str()).clone()])
	return rt.create_array([rt.ArrayItem{ key: none, val: var_now },
		rt.ArrayItem{ key: none, val: var_user_id }])
}

fn _admin_notice_post_locked() {
	mut var_post := rt.new_null()
	mut var_user := rt.new_null()
	mut var_user_id := false
	mut var_locked := false
	mut var_sendback := rt.new_null()
	mut var_sendback_text := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_hidden := ''
	mut var_query_args := map[string]rt.PhpVal{}
	mut var_nonce := rt.new_null()
	mut var_preview_link := rt.new_null()
	mut var_override := rt.new_null()
	mut var_tab_last := ''
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return
	}
	var_user = rt.new_null()
	var_user_id = wp_check_post_lock(rt.get_property(var_post, 'ID'))
	if var_user_id {
		var_user = rt.call_function('get_userdata', [rt.new_bool(var_user_id).clone()])
	}
	if rt.is_true(var_user) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('show_post_locked_dialog'),
			rt.new_bool(true),
			var_post.clone(),
			var_user.clone(),
		])))))
		{
			return
		}
		var_locked = true
	} else {
		var_locked = false
	}
	var_sendback = rt.call_function('wp_get_referer', []rt.PhpVal{})
	var_sendback_text = rt.call_function('__', [rt.new_string('Go back')])
	if !var_locked || rt.is_true(rt.new_bool(!(rt.is_true(var_sendback))))
		|| rt.is_true(rt.call_function('str_contains', [var_sendback.clone(), rt.new_string('post.php')]))
		|| rt.is_true(rt.call_function('str_contains', [var_sendback.clone(), rt.new_string('post-new.php')])) {
		var_sendback = rt.call_function('admin_url', [rt.new_string('edit.php')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_post,
			'post_type')))))
		{
			var_sendback = rt.call_function('add_query_arg', [
				rt.new_string('post_type'), rt.get_property(var_post, 'post_type'),
				var_sendback.clone()])
		}
		var_post_type_object = rt.call_function('get_post_type_object', [
			rt.get_property(var_post, 'post_type'),
		])
		if rt.is_true(var_post_type_object) {
			var_sendback_text = rt.get_property(rt.get_property(var_post_type_object, 'labels'),
				'all_items')
		}
	}
	var_hidden = if var_locked { '' } else { ' hidden' }
	// unsupported statement: Stmt_InlineHTML
	print(var_hidden)
	// unsupported statement: Stmt_InlineHTML
	if var_locked {
		var_query_args = rt.new_array()
		if rt.is_true(rt.get_property(rt.call_function('get_post_type_object', [
			rt.get_property(var_post, 'post_type'),
		]), 'public'))
		{
			if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post, 'post_status')))
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_user, 'ID'), rt.new_int((rt.get_property(var_post, 'post_author')).to_i64()))))) {
				var_nonce = rt.call_function('wp_create_nonce', [
					rt.new_string('post_preview_' + (rt.get_property(var_post, 'ID')).str()),
				])
				var_query_args['preview_id'] = rt.get_property(var_post, 'ID')
				var_query_args['preview_nonce'] = var_nonce.clone()
			}
		}
		var_preview_link = rt.call_function('get_preview_post_link', [
			rt.get_property(var_post, 'ID'),
			rt.create_array_from_native_map(var_query_args),
		])
		var_override = rt.call_function('apply_filters', [
			rt.new_string('override_post_lock'),
			rt.new_bool(true),
			var_post.clone(),
			var_user.clone(),
		])
		var_tab_last = if rt.is_true(var_override) { '' } else { ' wp-tab-last' }
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('get_avatar', [rt.get_property(var_user, 'ID'),
			rt.new_int(64)]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_override) {
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('%s is currently editing this post. Do you want to take over?'),
				]),
				rt.call_function('esc_html', [
					rt.get_property(var_user, 'display_name'),
				]),
			])
		} else {
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('%s is currently editing this post.'),
				]),
				rt.call_function('esc_html', [
					rt.get_property(var_user, 'display_name'),
				]),
			])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('post_locked_dialog'),
			var_post.clone(), var_user.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_sendback.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_sendback_text)
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_preview_link) {
			// unsupported statement: Stmt_InlineHTML
			print(var_tab_last)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [var_preview_link.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Preview'),
				rt.new_string('verb')]))
			// unsupported statement: Stmt_InlineHTML
		}
		if rt.is_true(var_override) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [rt.new_string('get-post-lock'),
					rt.new_string('1'),
					rt.call_function('wp_nonce_url', [
						rt.call_function('get_edit_post_link', [
							rt.get_property(var_post, 'ID'),
							rt.new_string('url'),
						]),
						rt.new_string('lock-post_' + (rt.get_property(var_post, 'ID')).str()),
					])]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Take over')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', [rt.new_string('images/spinner-2x.gif')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Saving revision&hellip;')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Your latest changes were saved as a revision.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('post_lock_lost_dialog'),
			var_post.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_sendback.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_sendback_text)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn wp_create_post_autosave(var_post_data_arg rt.PhpVal) i64 {
	mut var_post_data := var_post_data_arg
	mut var_post_id := rt.new_null()
	mut var_post_author := rt.new_null()
	mut var_old_autosave := rt.new_null()
	mut var_new_autosave := rt.new_null()
	mut var_post := rt.new_null()
	mut var_autosave_is_different := false
	mut var_field := rt.new_null()
	mut var_revision := rt.new_null()
	if rt.is_true(rt.new_bool(var_post_data.clone().is_long() || var_post_data.clone().is_double())) {
		var_post_id = var_post_data.clone()
		var_post_data = rt.get_superglobal('_POST').clone()
	} else {
		var_post_id = rt.new_int((var_post_data.array_get(rt.new_string('post_ID'))).to_i64())
	}
	var_post_data = _wp_translate_postdata(true, var_post_data.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_post_data.clone()])) {
		return var_post_data.to_i64()
	}
	var_post_data = _wp_get_allowed_postdata(var_post_data.clone())
	var_post_author = rt.call_function('get_current_user_id', []rt.PhpVal{})
	var_old_autosave = rt.call_function('wp_get_post_autosave', [
		var_post_id.clone(), var_post_author.clone()])
	if rt.is_true(var_old_autosave) {
		var_new_autosave = rt.call_function('_wp_post_revision_data', [
			var_post_data.clone(), rt.new_bool(true)])
		var_new_autosave.array_set('ID', rt.get_property(var_old_autosave, 'ID'))
		var_new_autosave.array_set('post_author', var_post_author.clone())
		var_post = rt.call_function('get_post', [var_post_id.clone()])
		var_autosave_is_different = false
		mut iter_13 := rt.call_function('array_intersect', [
			rt.func_array_keys(var_new_autosave.clone()),
			rt.func_array_keys(rt.call_function('_wp_post_revision_fields', [
				var_post.clone()])),
		]).iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_field_shadow := item_13.val
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('normalize_whitespace', [
				var_new_autosave.array_get(var_field_shadow),
			]), rt.call_function('normalize_whitespace', [
				rt.get_property(var_post, '{"nodeType":"Expr_Variable","line":1985,"name":"field"}'),
			])))))
			{
				var_autosave_is_different = true
				break
			}
		}
		if !var_autosave_is_different {
			rt.call_function('wp_delete_post_revision', [
				rt.get_property(var_old_autosave, 'ID'),
			])
			return 0
		}
		rt.call_function('do_action', [rt.new_string('wp_creating_autosave'),
			var_new_autosave.clone(), rt.new_bool(true)])
		return (rt.call_function('wp_update_post', [var_new_autosave.clone()])).to_i64()
	}
	var_post_data = rt.call_function('wp_unslash', [var_post_data.clone()])
	var_revision = rt.call_function('_wp_put_post_revision', [
		var_post_data.clone(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_revision.clone()])))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_revision)))) {
		rt.call_function('do_action', [rt.new_string('wp_creating_autosave'),
			rt.call_function('get_post', [var_revision.clone(),
				rt.get_constant('ARRAY_A')]),
			rt.new_bool(false)])
	}
	return var_revision.to_i64()
}

fn wp_autosave_post_revisioned_meta_fields(var_new_autosave rt.PhpVal) {
	mut var_posted_data := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_meta_key := rt.new_null()
	var_posted_data = if !(rt.get_superglobal('_POST').array_get(rt.new_string('data')).array_get(rt.new_string('wp_autosave'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('data')).array_get(rt.new_string('wp_autosave'))
	} else {
		rt.get_superglobal('_POST')
	}
	var_post_type = rt.call_function('get_post_type', [
		var_new_autosave.array_get(rt.new_string('post_parent')),
	])
	mut iter_14 := rt.call_function('wp_post_revision_meta_keys', [
		var_post_type.clone()]).iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_meta_key_shadow := item_14.val
		if var_posted_data.array_isset(var_meta_key_shadow)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_post_meta', [var_new_autosave.array_get(rt.new_string('ID')), var_meta_key_shadow.clone(), rt.new_bool(true)]), rt.call_function('wp_unslash', [var_posted_data.array_get(var_meta_key_shadow)]))))) {
			rt.call_function('delete_metadata', [rt.new_string('post'),
				var_new_autosave.array_get(rt.new_string('ID')),
				var_meta_key_shadow.clone()])
			if !(!rt.is_true(var_posted_data.array_get(var_meta_key_shadow))) {
				rt.call_function('add_metadata', [rt.new_string('post'),
					var_new_autosave.array_get(rt.new_string('ID')),
					var_meta_key_shadow.clone(), var_posted_data.array_get(var_meta_key_shadow)])
			}
		}
	}
}

fn post_preview() rt.PhpVal {
	mut var_post_id := rt.new_null()
	mut var_post := rt.new_null()
	mut var_is_autosave := false
	mut var_saved_post_id := rt.new_null()
	mut var_query_args := map[string]rt.PhpVal{}
	var_post_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_ID'))).to_i64())
	rt.get_superglobal('_POST').array_set('ID', var_post_id.clone())
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit this post.'),
			]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		rt.get_property(var_post, 'ID'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit this post.'),
			]),
		])
	}
	var_is_autosave = false
	if !(wp_check_post_lock(rt.get_property(var_post, 'ID')))
		&& rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_int((rt.get_property(var_post, 'post_author')).to_i64())))
		&& rt.is_true(rt.identical(rt.new_string('draft'), rt.get_property(var_post, 'post_status')))
		|| rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post, 'post_status'))) {
		var_saved_post_id = edit_post(rt.new_null())
	} else {
		var_is_autosave = true
		if rt.get_superglobal('_POST').array_isset(rt.new_string('post_status'))
			&& rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_superglobal('_POST').array_get(rt.new_string('post_status')))) {
			rt.get_superglobal('_POST').array_set('post_status', 'draft')
		}
		var_saved_post_id = rt.new_int(wp_create_post_autosave(rt.get_property(var_post, 'ID')))
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_saved_post_id.clone()])) {
		rt.call_function('wp_die', [
			rt.call_method(var_saved_post_id, 'get_error_message', []rt.PhpVal{}),
		])
	}
	var_query_args = rt.new_array()
	if var_is_autosave && rt.is_true(var_saved_post_id) {
		var_query_args['preview_id'] = rt.get_property(var_post, 'ID')
		var_query_args['preview_nonce'] = rt.call_function('wp_create_nonce', [
			rt.new_string('post_preview_' + (rt.get_property(var_post, 'ID')).str()),
		])
		if rt.get_superglobal('_POST').array_isset(rt.new_string('post_format')) {
			var_query_args['post_format'] = if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('post_format'))) { rt.new_string('standard') } else { rt.call_function('sanitize_key', [
					rt.get_superglobal('_POST').array_get(rt.new_string('post_format')),
				]) }
		}
		if rt.get_superglobal('_POST').array_isset(rt.new_string('_thumbnail_id')) {
			var_query_args['_thumbnail_id'] = if rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('_thumbnail_id'))).to_i64()) <= 0 {
				rt.new_string('-1')
			} else {
				rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('_thumbnail_id'))).to_i64())
			}
		}
	}
	return rt.call_function('get_preview_post_link', [var_post.clone(),
		rt.create_array_from_native_map(var_query_args)])
}

fn wp_autosave(var_post_data rt.PhpVal) i64 {
	mut var_post_id := rt.new_null()
	mut var_post := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('DOING_AUTOSAVE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('DOING_AUTOSAVE'),
			rt.new_bool(true)])
	}
	var_post_id = rt.new_int((var_post_data.array_get(rt.new_string('post_id'))).to_i64())
	var_post_data.array_set('ID', var_post_id.clone())
	var_post_data.array_set('post_ID', var_post_id.clone())
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wp_verify_nonce', [
		var_post_data.array_get(rt.new_string('_wpnonce')),
		rt.new_string('update-post_' + var_post_id.str()),
	])))
	{
		return (create_wp_error(rt.new_string('invalid_nonce'), rt.call_function('__', [
			rt.new_string('Error while saving.'),
		]))).to_i64()
	}
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		rt.get_property(var_post, 'ID'),
	])))))
	{
		return (create_wp_error(rt.new_string('edit_posts'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this item.'),
		]))).to_i64()
	}
	if rt.is_true(rt.identical(rt.new_string('auto-draft'),
		rt.get_property(var_post, 'post_status')))
	{
		var_post_data.array_set('post_status', 'draft')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('page'), var_post_data.array_get(rt.new_string('post_type'))))))
		&& !(!rt.is_true(var_post_data.array_get(rt.new_string('catslist')))) {
		var_post_data.array_set('post_category', rt.call_function('explode', [
			rt.new_string(','),
			var_post_data.array_get(rt.new_string('catslist')),
		]))
	}
	if !(wp_check_post_lock(rt.get_property(var_post, 'ID')))
		&& rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_int((rt.get_property(var_post, 'post_author')).to_i64())))
		&& rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post, 'post_status')))
		|| rt.is_true(rt.identical(rt.new_string('draft'), rt.get_property(var_post, 'post_status'))) {
		return (edit_post(rt.call_function('wp_slash', [var_post_data.clone()]))).to_i64()
	} else {
		return wp_create_post_autosave(rt.call_function('wp_slash', [
			var_post_data.clone()]))
	}
	return 0
}

fn redirect_post(post_id i64) {
	mut var_post_id := post_id
	mut var_status := rt.new_null()
	mut var_message := rt.new_null()
	mut var_location := rt.new_null()
	if rt.get_superglobal('_POST').array_isset(rt.new_string('save'))
		|| rt.get_superglobal('_POST').array_isset(rt.new_string('publish')) {
		var_status = rt.call_function('get_post_status', [rt.new_int(post_id)])
		mut switch_val_3 := var_status
		if rt.is_true(rt.equal(switch_val_3, rt.new_string('pending'))) {
			var_message = rt.new_int(8)
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('future'))) {
			var_message = rt.new_int(9)
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('draft'))) {
			var_message = rt.new_int(10)
		} else {
			var_message = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('publish')) {
				6
			} else {
				1
			})
		}
		var_location = rt.call_function('add_query_arg', [rt.new_string('message'),
			var_message.clone(),
			rt.call_function('get_edit_post_link', [
				rt.new_int(post_id),
				rt.new_string('url'),
			])])
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('addmeta'))
		&& rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('addmeta'))) {
		var_location = rt.call_function('add_query_arg', [rt.new_string('message'),
			rt.new_int(2), rt.call_function('wp_get_referer', []rt.PhpVal{})])
		var_location = rt.call_function('explode', [rt.new_string('#'),
			var_location.clone()])
		var_location = rt.new_string((var_location.array_get(rt.new_int(0))).str() + '#postcustom')
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('deletemeta'))
		&& rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('deletemeta'))) {
		var_location = rt.call_function('add_query_arg', [rt.new_string('message'),
			rt.new_int(3), rt.call_function('wp_get_referer', []rt.PhpVal{})])
		var_location = rt.call_function('explode', [rt.new_string('#'),
			var_location.clone()])
		var_location = rt.new_string((var_location.array_get(rt.new_int(0))).str() + '#postcustom')
	} else {
		var_location = rt.call_function('add_query_arg', [rt.new_string('message'),
			rt.new_int(4),
			rt.call_function('get_edit_post_link', [
				rt.new_int(post_id), rt.new_string('url')])])
	}
	rt.call_function('wp_redirect', [
		rt.call_function('apply_filters', [rt.new_string('redirect_post_location'),
			var_location.clone(), rt.new_int(post_id)]),
	])
	exit(0)
}

fn taxonomy_meta_box_sanitize_cb_checkboxes(var_taxonomy rt.PhpVal, var_terms rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_map', [rt.new_string('intval'),
		var_terms.clone()])
}

fn taxonomy_meta_box_sanitize_cb_input(var_taxonomy rt.PhpVal, var_terms_arg rt.PhpVal) rt.PhpVal {
	mut var_terms := var_terms_arg
	mut var_comma := rt.new_null()
	mut var_clean_terms := []rt.PhpVal{}
	mut var_term := rt.new_null()
	mut var__term := rt.new_null()
	if !(var_terms.clone().is_array()) {
		var_comma = rt.call_function('_x', [rt.new_string(','),
			rt.new_string('tag delimiter')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(','), var_comma)))) {
			var_terms = rt.call_function('str_replace', [var_comma.clone(),
				rt.new_string(','), var_terms.clone()])
		}
		var_terms = rt.call_function('explode', [rt.new_string(','),
			rt.new_string(var_terms.clone().to_string().trim_space())])
	}
	var_clean_terms = rt.new_array()
	mut iter_15 := var_terms.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_term_shadow := item_15.val
		if !rt.is_true(var_term_shadow) {
			continue
		}
		var__term = rt.call_function('get_terms', [
			rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
				rt.ArrayItem{ key: 'name', val: var_term_shadow },
				rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{
					key: 'hide_empty'
					val: false
				}]),
		])
		if !(!rt.is_true(var__term)) {
			var_clean_terms << rt.new_int((var__term.array_get(rt.new_int(0))).to_i64())
		} else {
			var_clean_terms << var_term_shadow.clone()
		}
	}
	return var_clean_terms.clone()
}

fn get_block_editor_server_block_settings() rt.PhpVal {
	mut var_block_registry := rt.new_null()
	mut var_blocks := rt.new_null()
	mut var_fields_to_pick := map[string]rt.PhpVal{}
	mut var_block_type := rt.new_null()
	mut var_block_name := rt.new_null()
	mut var_key := rt.new_null()
	mut var_field := rt.new_null()
	mut iife_temp_0 := Class_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_block_registry = iife_result_0
	var_blocks = rt.new_array()
	var_fields_to_pick = {
		'api_version':      'apiVersion'
		'title':            'title'
		'description':      'description'
		'icon':             'icon'
		'attributes':       'attributes'
		'provides_context': 'providesContext'
		'uses_context':     'usesContext'
		'block_hooks':      'blockHooks'
		'selectors':        'selectors'
		'supports':         'supports'
		'category':         'category'
		'styles':           'styles'
		'textdomain':       'textdomain'
		'parent':           'parent'
		'ancestor':         'ancestor'
		'keywords':         'keywords'
		'example':          'example'
		'variations':       'variations'
		'allowed_blocks':   'allowedBlocks'
	}
	mut iter_16 :=
		rt.call_method(var_block_registry, 'get_all_registered', []rt.PhpVal{}).iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_block_type_shadow := item_16.val
		mut var_block_name_shadow := item_16.key
		for var_field_shadow, var_key_shadow in var_fields_to_pick {
			if !(!(rt.get_property(var_block_type_shadow,
				'{"nodeType":"Expr_Variable","line":2338,"name":"field"}')).is_null()) {
				continue
			}
			if !(var_blocks.array_isset(var_block_name_shadow)) {
				var_blocks.array_set(var_block_name_shadow, rt.new_array())
			}
			var_blocks.array_get_mut(var_block_name_shadow).array_set(rt.new_string(var_key_shadow.str()), rt.get_property(var_block_type_shadow,
				'{"nodeType":"Expr_Variable","line":2346,"name":"field"}'))
		}
	}
	return var_blocks.clone()
}

fn the_block_editor_meta_boxes() {
	mut var_post := rt.new_null()
	mut var_current_screen := rt.new_null()
	mut var__original_meta_boxes := rt.new_null()
	mut var_wp_meta_boxes := rt.new_null()
	mut var_locations := []rt.PhpVal{}
	mut var_priorities := []rt.PhpVal{}
	mut var_location := rt.new_null()
	mut var_meta_boxes_per_location := rt.new_null()
	mut var_priority := rt.new_null()
	mut var_meta_boxes := rt.new_null()
	mut var_meta_box := map[string]rt.PhpVal{}
	mut var_script := rt.new_null()
	mut var_enable_custom_fields := rt.new_null()
	var__original_meta_boxes = var_wp_meta_boxes.clone()
	var_wp_meta_boxes = rt.call_function('apply_filters', [
		rt.new_string('filter_block_editor_meta_boxes'),
		var_wp_meta_boxes.clone(),
	])
	var_locations = ['side', 'normal', 'advanced']
	var_priorities = ['high', 'sorted', 'core', 'default', 'low']
	// unsupported statement: Stmt_InlineHTML
	the_block_editor_meta_box_post_form_hidden_fields(var_post.clone())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('post.php')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('toggle-custom-fields'),
		rt.new_string('toggle-custom-fields-nonce')])
	// unsupported statement: Stmt_InlineHTML
	for var_location_shadow in var_locations {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_location_shadow.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_meta_boxes', [var_current_screen.clone(),
			rt.new_string(var_location_shadow.str()).clone(),
			var_post.clone()])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	var_meta_boxes_per_location = rt.new_array()
	for var_location_shadow in var_locations {
		var_meta_boxes_per_location.array_set(rt.new_string(var_location_shadow.str()),
			rt.new_array())
		if !(var_wp_meta_boxes.array_get(rt.get_property(var_current_screen, 'id')).array_isset(rt.new_string(var_location_shadow.str()))) {
			continue
		}
		for var_priority_shadow in var_priorities {
			if !(var_wp_meta_boxes.array_get(rt.get_property(var_current_screen, 'id')).array_get(rt.new_string(var_location_shadow.str())).array_isset(rt.new_string(var_priority_shadow.str()))) {
				continue
			}
			var_meta_boxes =
				rt.cast_array(var_wp_meta_boxes.array_get(rt.get_property(var_current_screen, 'id')).array_get(rt.new_string(var_location_shadow.str())).array_get(rt.new_string(var_priority_shadow.str())))
			mut iter_17 := var_meta_boxes.iterator()
			for {
				item_17 := iter_17.next() or { break }
				mut var_meta_box_shadow := item_17.val
				if rt.is_true(rt.identical(rt.new_bool(false), var_meta_box_shadow))
					|| rt.is_true(rt.new_bool(!(rt.is_true(var_meta_box_shadow['title'])))) {
					continue
				}
				if var_meta_box_shadow['args'].array_isset(rt.new_string('__back_compat_meta_box'))
					&& rt.is_true(var_meta_box_shadow['args'].array_get(rt.new_string('__back_compat_meta_box'))) {
					continue
				}
				var_meta_boxes_per_location.array_get_mut(rt.new_string(var_location_shadow.str())).array_push(rt.create_array([
					rt.ArrayItem{ key: 'id', val: var_meta_box_shadow['id'] },
					rt.ArrayItem{ key: 'title', val: var_meta_box_shadow['title'] },
				]))
			}
		}
	}
	var_script = rt.new_string(
		"window._wpLoadBlockEditor.then( function() {\n\t\twp.data.dispatch( 'core/edit-post' ).setAvailableMetaBoxesPerLocation( " +
		(rt.call_function('wp_json_encode', [var_meta_boxes_per_location.clone(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str() +
		' );\n\t} );')
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-edit-post'),
		var_script.clone()])
	if rt.is_true(rt.call_function('wp_script_is', [rt.new_string('wp-edit-post'),
		rt.new_string('done')]))
	{
		rt.call_function('printf', [rt.new_string('<script>\n%s\n</script>\n'),
			rt.new_string(var_script.clone().to_string().trim_space())])
	}
	var_enable_custom_fields = rt.new_bool((rt.call_function('get_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('enable_custom_fields'),
		rt.new_bool(true),
	])).to_bool())
	if rt.is_true(var_enable_custom_fields) {
		var_script = rt.new_string((rt.concat(rt.concat(rt.new_string("( function( $ ) {\n\t\t\tif ( $('#postcustom').length ) {\n\t\t\t\t$( '#the-list' ).wpList( {\n\t\t\t\t\taddBefore: function( s ) {\n\t\t\t\t\t\ts.data += '&post_id="),
			rt.get_property(var_post, 'ID')),
			rt.new_string("';\n\t\t\t\t\t\treturn s;\n\t\t\t\t\t},\n\t\t\t\t\taddAfter: function() {\n\t\t\t\t\t\t$('table#list-table').show();\n\t\t\t\t\t}\n\t\t\t\t});\n\t\t\t}\n\t\t} )( jQuery );"))).str())
		rt.call_function('wp_enqueue_script', [rt.new_string('wp-lists')])
		rt.call_function('wp_add_inline_script', [rt.new_string('wp-lists'),
			var_script.clone()])
	}
	var_script =
		rt.new_string("( function( $ ) {\n\t\tvar check, timeout;\n\n\t\tfunction schedule() {\n\t\t\tcheck = false;\n\t\t\twindow.clearTimeout( timeout );\n\t\t\ttimeout = window.setTimeout( function() { check = true; }, 300000 );\n\t\t}\n\n\t\t$( document ).on( 'heartbeat-send.wp-refresh-nonces', function( e, data ) {\n\t\t\tvar post_id, $authCheck = $( '#wp-auth-check-wrap' );\n\n\t\t\tif ( check || ( $authCheck.length && ! $authCheck.hasClass( 'hidden' ) ) ) {\n\t\t\t\tif ( ( post_id = $( '#post_ID' ).val() ) && $( '#_wpnonce' ).val() ) {\n\t\t\t\t\tdata['wp-refresh-metabox-loader-nonces'] = {\n\t\t\t\t\t\tpost_id: post_id\n\t\t\t\t\t};\n\t\t\t\t}\n\t\t\t}\n\t\t}).on( 'heartbeat-tick.wp-refresh-nonces', function( e, data ) {\n\t\t\tvar nonces = data['wp-refresh-metabox-loader-nonces'];\n\n\t\t\tif ( nonces ) {\n\t\t\t\tif ( nonces.replace ) {\n\t\t\t\t\tif ( nonces.replace.metabox_loader_nonce && window._wpMetaBoxUrl && wp.url ) {\n\t\t\t\t\t\twindow._wpMetaBoxUrl= wp.url.addQueryArgs( window._wpMetaBoxUrl, { 'meta-box-loader-nonce': nonces.replace.metabox_loader_nonce } );\n\t\t\t\t\t}\n\n\t\t\t\t\tif ( nonces.replace._wpnonce ) {\n\t\t\t\t\t\t$( '#_wpnonce' ).val( nonces.replace._wpnonce );\n\t\t\t\t\t}\n\t\t\t\t}\n\t\t\t}\n\t\t}).ready( function() {\n\t\t\tschedule();\n\t\t});\n\t} )( jQuery );")
	rt.call_function('wp_add_inline_script', [rt.new_string('heartbeat'),
		var_script.clone()])
	var_wp_meta_boxes = var__original_meta_boxes.clone()
}

fn the_block_editor_meta_box_post_form_hidden_fields(var_post rt.PhpVal) {
	mut var_form_extra := ''
	mut var_form_action := ''
	mut var_nonce_action := rt.new_null()
	mut var_referer := rt.new_null()
	mut var_current_user := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_classic_output := rt.new_null()
	mut var_classic_elements := rt.new_null()
	mut var_element := rt.new_null()
	var_form_extra = ''
	if rt.is_true(rt.identical(rt.new_string('auto-draft'),
		rt.get_property(var_post, 'post_status')))
	{
		var_form_extra = var_form_extra +
			"<input type='hidden' id='auto_draft' name='auto_draft' value='1' />"
	}
	var_form_action = 'editpost'
	var_nonce_action = rt.new_string('update-post_' + (rt.get_property(var_post, 'ID')).str())
	var_form_extra = var_form_extra + "<input type='hidden' id='post_ID' name='post_ID' value='" +
		(rt.call_function('esc_attr', [rt.get_property(var_post, 'ID')])).str() + "' />"
	var_referer = rt.call_function('wp_get_referer', []rt.PhpVal{})
	var_current_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	var_user_id = rt.get_property(var_current_user, 'ID')
	rt.call_function('wp_nonce_field', [var_nonce_action.clone()])
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('edit_form_after_title'),
		var_post.clone()])
	rt.call_function('do_action', [rt.new_string('edit_form_advanced'),
		var_post.clone()])
	var_classic_output = rt.call_function('ob_get_clean', []rt.PhpVal{})
	var_classic_elements = rt.call_function('wp_html_split', [
		var_classic_output.clone()])
	mut iter_18 := var_classic_elements.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_element_shadow := item_18.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
			var_element_shadow.clone(),
			rt.new_string('<input '),
		])))))
		{
			continue
		}
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/\\stype=[\'"]hidden[\'"]\\s/'),
			var_element_shadow.clone(),
		]))
		{
			rt.echo_val(var_element_shadow)
		}
	}
	// unsupported statement: Stmt_InlineHTML
	print(rt.new_int(var_user_id.to_i64()).str())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_form_action.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_form_action.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_post, 'post_type')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_post, 'post_status')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(var_referer) { rt.call_function('esc_url', [
			var_referer.clone()]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('draft'), rt.call_function('get_post_status', [
		var_post.clone(),
	])))))
	{
		rt.call_function('wp_original_referer_field', [rt.new_bool(true),
			rt.new_string('previous')])
	}
	print(var_form_extra)
	rt.call_function('wp_nonce_field', [rt.new_string('meta-box-order'),
		rt.new_string('meta-box-order-nonce'), rt.new_bool(false)])
	rt.call_function('wp_nonce_field', [rt.new_string('closedpostboxes'),
		rt.new_string('closedpostboxesnonce'), rt.new_bool(false)])
	rt.call_function('wp_nonce_field', [rt.new_string('samplepermalink'),
		rt.new_string('samplepermalinknonce'), rt.new_bool(false)])
	rt.call_function('do_action', [rt.new_string('block_editor_meta_box_hidden_fields'),
		var_post.clone()])
}

fn _disable_block_editor_for_navigation_post_type(var_value rt.PhpVal, var_post_type rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string('wp_navigation'), var_post_type)) {
		return false
	}
	return var_value.to_bool()
}

fn _disable_content_editor_for_navigation_post_type(var_post rt.PhpVal) {
	mut var_post_type := rt.new_null()
	var_post_type = rt.call_function('get_post_type', [var_post.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wp_navigation'),
		var_post_type))))
	{
		return
	}
	rt.call_function('remove_post_type_support', [var_post_type.clone(),
		rt.new_string('editor')])
}

fn _enable_content_editor_for_navigation_post_type(var_post rt.PhpVal) {
	mut var_post_type := rt.new_null()
	var_post_type = rt.call_function('get_post_type', [var_post.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wp_navigation'),
		var_post_type))))
	{
		return
	}
	rt.call_function('add_post_type_support', [var_post_type.clone(),
		rt.new_string('editor')])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Post {
	rt.PhpObjectBase
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_post(_args ...rt.PhpVal) &Class_WP_Post {
	mut obj := &Class_WP_Post{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Post) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Post) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Post) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
