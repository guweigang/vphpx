import rt

fn post_submit_meta_box(var_post rt.PhpVal, var_args rt.PhpVal) {
	mut var_action := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_can_publish := rt.new_null()
	mut var_private_style := ''
	mut var_preview_link := rt.new_null()
	mut var_preview_button_text := rt.new_null()
	mut var_preview_button := rt.new_null()
	mut var_visibility := ''
	mut var_visibility_trans := rt.new_null()
	mut var_date_string := rt.new_null()
	mut var_date_format := rt.new_null()
	mut var_time_format := rt.new_null()
	mut var_stamp := rt.new_null()
	mut var_date := rt.new_null()
	mut var_message := rt.new_null()
	mut var_delete_text := rt.new_null()
	var_post_id = rt.new_int((rt.get_property(var_post, 'ID')).to_i64())
	var_post_type = rt.get_property(var_post, 'post_type')
	var_post_type_object = rt.call_function('get_post_type_object', [
		var_post_type.clone()])
	var_can_publish = rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'publish_posts'),
	])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [
		rt.new_string('Save')]),
		rt.new_string(''), rt.new_string('save')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.get_property(var_post, 'post_status'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'publish' },
			rt.ArrayItem{ key: none, val: 'future' }, rt.ArrayItem{ key: none, val: 'pending' }]),
		rt.new_bool(true),
	])))))
	{
		var_private_style = ''
		if rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(var_post,
			'post_status')))
		{
			var_private_style = 'style="display:none"'
		}
		// unsupported statement: Stmt_InlineHTML
		print(var_private_style)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Save Draft')])
		// unsupported statement: Stmt_InlineHTML
	} else if
		rt.is_true(rt.identical(rt.new_string('pending'), rt.get_property(var_post, 'post_status')))
		&& rt.is_true(var_can_publish) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Save as Pending')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_post_type_viewable', [
		var_post_type_object.clone()]))
	{
		// unsupported statement: Stmt_InlineHTML
		var_preview_link = rt.call_function('esc_url', [
			rt.call_function('get_preview_post_link', [var_post.clone()]),
		])
		if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post,
			'post_status')))
		{
			var_preview_button_text = rt.call_function('__', [
				rt.new_string('Preview Changes'),
			])
		} else {
			var_preview_button_text = rt.call_function('_x', [
				rt.new_string('Preview'), rt.new_string('verb')])
		}
		var_preview_button = rt.call_function('sprintf', [
			rt.new_string('%1$s<span class="screen-reader-text"> %2$s</span>'),
			var_preview_button_text.clone(),
			rt.call_function('__', [rt.new_string('(opens in a new tab)')]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_preview_link)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_post_id)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_preview_button)
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('do_action', [rt.new_string('post_submitbox_minor_actions'),
		var_post.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Status:')])
	// unsupported statement: Stmt_InlineHTML
	mut switch_val_1 := rt.get_property(var_post, 'post_status')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('private'))) {
		rt.call_function('_e', [rt.new_string('Privately Published')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('publish'))) {
		rt.call_function('_e', [rt.new_string('Published')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('future'))) {
		rt.call_function('_e', [rt.new_string('Scheduled')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('pending'))) {
		rt.call_function('_e', [rt.new_string('Pending Review')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('draft')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('auto-draft'))) {
		rt.call_function('_e', [rt.new_string('Draft')])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post, 'post_status')))
		|| rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(var_post, 'post_status')))
		|| rt.is_true(var_can_publish) {
		var_private_style = ''
		if rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(var_post,
			'post_status')))
		{
			var_private_style = 'style="display:none"'
		}
		// unsupported statement: Stmt_InlineHTML
		print(var_private_style)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Edit')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Edit status')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post,
			'post_status')))
		{
			rt.new_string('draft')
		} else {
			rt.get_property(var_post, 'post_status')
		}]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Set status')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post,
			'post_status')))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [rt.get_property(var_post, 'post_status'),
				rt.new_string('publish')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Published')])
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(var_post,
			'post_status')))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [rt.get_property(var_post, 'post_status'),
				rt.new_string('private')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Privately Published')])
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.identical(rt.new_string('future'), rt.get_property(var_post,
			'post_status')))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [rt.get_property(var_post, 'post_status'),
				rt.new_string('future')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Scheduled')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [rt.get_property(var_post, 'post_status'),
			rt.new_string('pending')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Pending Review')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post,
			'post_status')))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [rt.get_property(var_post, 'post_status'),
				rt.new_string('auto-draft')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Draft')])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [rt.get_property(var_post, 'post_status'),
				rt.new_string('draft')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Draft')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('OK')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Cancel')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Visibility:')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(var_post, 'post_status'))) {
		rt.set_property(var_post, 'post_password', rt.new_string(''))
		var_visibility = 'private'
		var_visibility_trans = rt.call_function('__', [rt.new_string('Private')])
	} else if !(!rt.is_true(rt.get_property(var_post, 'post_password'))) {
		var_visibility = 'password'
		var_visibility_trans = rt.call_function('__', [
			rt.new_string('Password protected'),
		])
	} else if rt.is_true(rt.identical(rt.new_string('post'), var_post_type))
		&& rt.is_true(rt.call_function('is_sticky', [var_post_id.clone()])) {
		var_visibility = 'public'
		var_visibility_trans = rt.call_function('__', [rt.new_string('Public, Sticky')])
	} else {
		var_visibility = 'public'
		var_visibility_trans = rt.call_function('__', [rt.new_string('Public')])
	}
	rt.echo_val(rt.call_function('esc_html', [var_visibility_trans.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_can_publish) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Edit')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Edit visibility')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.get_property(var_post, 'post_password'),
		]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [
				rt.call_function('is_sticky', [var_post_id.clone()]),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_visibility.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string(var_visibility.str()).clone(),
			rt.new_string('public')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Public')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('post'), var_post_type))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_others_posts')])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [
				rt.call_function('is_sticky', [var_post_id.clone()]),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Stick this post to the front page')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string(var_visibility.str()).clone(),
			rt.new_string('password')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Password protected')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Password:')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.get_property(var_post, 'post_password'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string(var_visibility.str()).clone(),
			rt.new_string('private')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Private')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('OK')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Cancel')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	var_date_string = rt.call_function('__', [rt.new_string('%1$s at %2$s')])
	var_date_format = rt.call_function('_x', [rt.new_string('M j, Y'),
		rt.new_string('publish box date format')])
	var_time_format = rt.call_function('_x', [rt.new_string('H:i'),
		rt.new_string('publish box time format')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_post_id)))) {
		if rt.is_true(rt.identical(rt.new_string('future'),
			rt.get_property(var_post, 'post_status')))
		{
			var_stamp = rt.call_function('__', [rt.new_string('Scheduled for: %s')])
		} else if
			rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post, 'post_status')))
			|| rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(var_post, 'post_status'))) {
			var_stamp = rt.call_function('__', [rt.new_string('Published on: %s')])
		} else if rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), rt.get_property(var_post,
			'post_date_gmt')))
		{
			var_stamp = rt.call_function('__', [
				rt.new_string('Publish <b>immediately</b>'),
			])
		} else if rt.is_true(rt.less(rt.call_function('time', []rt.PhpVal{}), rt.call_function('strtotime', [
			rt.new_string((rt.get_property(var_post, 'post_date_gmt')).str() + ' +0000'),
		])))
		{
			var_stamp = rt.call_function('__', [rt.new_string('Schedule for: %s')])
		} else {
			var_stamp = rt.call_function('__', [rt.new_string('Publish on: %s')])
		}
		var_date = rt.call_function('sprintf', [var_date_string.clone(),
			rt.call_function('date_i18n', [var_date_format.clone(),
				rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])]),
			rt.call_function('date_i18n', [var_time_format.clone(),
				rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])])])
	} else {
		var_stamp = rt.call_function('__', [rt.new_string('Publish <b>immediately</b>')])
		var_date = rt.call_function('sprintf', [var_date_string.clone(),
			rt.call_function('date_i18n', [var_date_format.clone(),
				rt.call_function('strtotime', [
					rt.call_function('current_time', [rt.new_string('mysql')]),
				])]),
			rt.call_function('date_i18n', [var_time_format.clone(),
				rt.call_function('strtotime', [
					rt.call_function('current_time', [rt.new_string('mysql')]),
				])])])
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('args')).array_get(rt.new_string('revisions_count')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Revisions: %s')]),
			rt.new_string('<b>' +
				(rt.call_function('number_format_i18n', [var_args.array_get(rt.new_string('args')).array_get(rt.new_string('revisions_count'))])).str() +
				'</b>'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('get_edit_post_link', [
				var_args.array_get(rt.new_string('args')).array_get(rt.new_string('revision_id')),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_ex', [rt.new_string('Browse'), rt.new_string('revisions')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Browse revisions')])
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(var_can_publish) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf',
			[var_stamp.clone(), rt.new_string('<b>' + var_date.str() + '</b>')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Edit')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Edit date and time')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Date and time')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('touch_time', [rt.identical(rt.new_string('edit'), var_action),
			rt.new_int(1)])
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.identical(rt.new_string('draft'), rt.get_property(var_post, 'post_status')))
		&& rt.is_true(rt.call_function('get_post_meta', [var_post_id.clone(), rt.new_string('_customize_changeset_uuid'), rt.new_bool(true)])) {
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('This draft comes from your <a href="%s">unpublished customization changes</a>. You can edit, but there is no need to publish now. It will be published automatically with those changes.'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [rt.new_string('changeset_uuid'),
					rt.call_function('rawurlencode', [
						rt.call_function('get_post_meta', [var_post_id.clone(),
							rt.new_string('_customize_changeset_uuid'),
							rt.new_bool(true)]),
					]),
					rt.call_function('admin_url', [
						rt.new_string('customize.php'),
					])]),
			]),
		])
		rt.call_function('wp_admin_notice', [var_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'notice-alt' },
					rt.ArrayItem{ key: none, val: 'inline' },
				]) }])])
	}
	rt.call_function('do_action', [rt.new_string('post_submitbox_misc_actions'),
		var_post.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('post_submitbox_start'),
		var_post.clone()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post'),
		var_post_id.clone()]))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) {
			var_delete_text = rt.call_function('__', [
				rt.new_string('Delete permanently'),
			])
		} else {
			var_delete_text = rt.call_function('__', [rt.new_string('Move to Trash')])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('get_delete_post_link', [
			var_post_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_delete_text)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_status'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'publish'
	}, rt.ArrayItem{ key: none, val: 'future' }, rt.ArrayItem{ key: none, val: 'private' }]), rt.new_bool(true)])))))
		|| rt.is_true(rt.identical(rt.new_int(0), var_post_id)) {
		if rt.is_true(var_can_publish) {
			if !(!rt.is_true(rt.get_property(var_post, 'post_date_gmt')))
				&& rt.is_true(rt.less(rt.call_function('time', []rt.PhpVal{}), rt.call_function('strtotime', [rt.new_string((rt.get_property(var_post, 'post_date_gmt')).str() + ' +0000')]))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Schedule'),
					rt.new_string('post action/button label')]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('submit_button', [
					rt.call_function('_x', [rt.new_string('Schedule'),
						rt.new_string('post action/button label')]),
					rt.new_string('primary large'),
					rt.new_string('publish'),
					rt.new_bool(false),
				])
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_attr_e', [rt.new_string('Publish')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('submit_button', [
					rt.call_function('__', [rt.new_string('Publish')]),
					rt.new_string('primary large'),
					rt.new_string('publish'),
					rt.new_bool(false),
				])
				// unsupported statement: Stmt_InlineHTML
			}
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Submit for Review')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('submit_button', [
				rt.call_function('__', [rt.new_string('Submit for Review')]),
				rt.new_string('primary large'),
				rt.new_string('publish'),
				rt.new_bool(false),
			])
			// unsupported statement: Stmt_InlineHTML
		}
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Update')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Update')]),
			rt.new_string('primary large'),
			rt.new_string('save'),
			rt.new_bool(false),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'publish' }]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn attachment_submit_meta_box(var_post rt.PhpVal) {
	mut var_uploaded_on := rt.new_null()
	mut var_show_confirmation := ''
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [
		rt.new_string('Save')]),
		rt.new_string(''), rt.new_string('save')])
	// unsupported statement: Stmt_InlineHTML
	var_uploaded_on = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%1$s at %2$s')]),
		rt.call_function('date_i18n', [
			rt.call_function('_x',
				[rt.new_string('M j, Y'), rt.new_string('publish box date format')]),
			rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')]),
		]),
		rt.call_function('date_i18n', [
			rt.call_function('_x', [rt.new_string('H:i'), rt.new_string('publish box time format')]),
			rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')]),
		]),
	])
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Uploaded on: %s')]),
		rt.new_string('<b>' + var_uploaded_on.str() + '</b>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('attachment_submitbox_misc_actions'),
		var_post.clone()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post'),
		rt.get_property(var_post, 'ID')]))
	{
		if rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))
			&& rt.is_true(rt.get_constant('MEDIA_TRASH')) {
			rt.call_function('printf', [
				rt.new_string('<a class="submitdelete deletion" href="%1$s">%2$s</a>'),
				rt.call_function('get_delete_post_link', [
					rt.get_property(var_post, 'ID'),
				]),
				rt.call_function('__', [
					rt.new_string('Move to Trash'),
				]),
			])
		} else {
			var_show_confirmation = if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('MEDIA_TRASH'))))) {
				" onclick='return showNotice.warn();'"
			} else {
				''
			}
			rt.call_function('printf', [
				rt.new_string('<a class="submitdelete deletion"%1$s href="%2$s">%3$s</a>'),
				rt.new_string(var_show_confirmation.str()).clone(),
				rt.call_function('get_delete_post_link', [
					rt.get_property(var_post, 'ID'),
					rt.new_string(''),
					rt.new_bool(true),
				]),
				rt.call_function('__', [
					rt.new_string('Delete permanently'),
				]),
			])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Update')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Update')])
	// unsupported statement: Stmt_InlineHTML
}

fn post_format_meta_box(var_post rt.PhpVal, var_box rt.PhpVal) {
	mut var_post_formats := rt.new_null()
	mut var_post_format := rt.new_null()
	mut var_format := rt.new_null()
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-formats')]))
		&& rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_post, 'post_type'), rt.new_string('post-formats')])) {
		var_post_formats = rt.call_function('get_theme_support', [
			rt.new_string('post-formats'),
		])
		if rt.is_true(rt.new_bool(var_post_formats.array_get(rt.new_int(0)).is_array())) {
			var_post_format = rt.call_function('get_post_format', [
				rt.get_property(var_post, 'ID'),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_post_format)))) {
				var_post_format = rt.new_string('0')
			}
			if rt.is_true(var_post_format)
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post_format.clone(), var_post_formats.array_get(rt.new_int(0)), rt.new_bool(true)]))))) {
				var_post_formats.array_get_mut(0).array_push(var_post_format.clone())
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Post Formats')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [var_post_format.clone(),
				rt.new_string('0')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('get_post_format_string', [
				rt.new_string('standard'),
			]))
			// unsupported statement: Stmt_InlineHTML
			mut iter_1 := var_post_formats.array_get(rt.new_int(0)).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_format_shadow := item_1.val
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_format_shadow.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_format_shadow.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('checked', [var_post_format.clone(),
					var_format_shadow.clone()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_format_shadow.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_format_shadow.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('get_post_format_string', [
						var_format_shadow.clone()]),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
}

fn post_tags_meta_box(var_post rt.PhpVal, var_box rt.PhpVal) {
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_args := rt.new_null()
	mut var_parsed_args := rt.new_null()
	mut var_tax_name := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_user_can_assign_terms := rt.new_null()
	mut var_comma := rt.new_null()
	mut var_terms_to_edit := rt.new_null()
	var_defaults = {
		'taxonomy': 'post_tag'
	}
	if !(var_box.array_isset(rt.new_string('args')))
		|| !(var_box.array_get(rt.new_string('args')).is_array()) {
		var_args = rt.new_array()
	} else {
		var_args = var_box.array_get(rt.new_string('args'))
	}
	var_parsed_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	var_tax_name = rt.call_function('esc_attr',
		[var_parsed_args.array_get(rt.new_string('taxonomy'))])
	var_taxonomy = rt.call_function('get_taxonomy', [
		var_parsed_args.array_get(rt.new_string('taxonomy')),
	])
	var_user_can_assign_terms = rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_taxonomy, 'cap'), 'assign_terms'),
	])
	var_comma = rt.call_function('_x', [rt.new_string(','), rt.new_string('tag delimiter')])
	var_terms_to_edit = rt.call_function('get_terms_to_edit', [
		rt.get_property(var_post, 'ID'),
		var_tax_name.clone(),
	])
	if !(var_terms_to_edit.clone().is_string()) {
		var_terms_to_edit = rt.new_string('')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'add_or_remove_items'))
	// unsupported statement: Stmt_InlineHTML
	print('tax_input[${var_tax_name.to_string()}]')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [rt.new_bool(!(rt.is_true(var_user_can_assign_terms)))])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('str_replace', [rt.new_string(','),
		rt.new_string(var_comma.str() + ' '), var_terms_to_edit.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_user_can_assign_terms) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'add_new_item'))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Add')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(rt.get_property(var_taxonomy, 'labels'),
			'separate_items_with_commas'))
		// unsupported statement: Stmt_InlineHTML
	} else if !rt.is_true(var_terms_to_edit) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'no_terms'))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_user_can_assign_terms) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(rt.get_property(var_taxonomy, 'labels'),
			'choose_from_most_used'))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn post_categories_meta_box(var_post rt.PhpVal, var_box rt.PhpVal) {
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_args := rt.new_null()
	mut var_parsed_args := rt.new_null()
	mut var_tax_name := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_popular_ids := rt.new_null()
	mut var_name := rt.new_null()
	mut var_parent_dropdown_args := rt.new_null()
	var_defaults = {
		'taxonomy': 'category'
	}
	if !(var_box.array_isset(rt.new_string('args')))
		|| !(var_box.array_get(rt.new_string('args')).is_array()) {
		var_args = rt.new_array()
	} else {
		var_args = var_box.array_get(rt.new_string('args'))
	}
	var_parsed_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	var_tax_name = rt.call_function('esc_attr',
		[var_parsed_args.array_get(rt.new_string('taxonomy'))])
	var_taxonomy = rt.call_function('get_taxonomy', [
		var_parsed_args.array_get(rt.new_string('taxonomy')),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'all_items'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'most_used'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	var_popular_ids = rt.call_function('wp_popular_terms_checklist', [
		var_tax_name.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	var_name = rt.new_string((if rt.is_true(rt.identical(rt.new_string('category'), var_tax_name)) {
		'post_category'
	} else {
		'tax_input[' + var_tax_name.str() + ']'
	}).str())
	print("<input type='hidden' name='${var_name.to_string()}[]' value='0' />")
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tax_name)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_terms_checklist', [rt.get_property(var_post, 'ID'),
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_tax_name },
			rt.ArrayItem{ key: 'popular_cats', val: var_popular_ids }])])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_taxonomy, 'cap'), 'edit_terms'),
	]))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('+ %s')]),
			rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'add_new_item')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'add_new_item'))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'new_item_name'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'parent_item_colon'))
		// unsupported statement: Stmt_InlineHTML
		var_parent_dropdown_args = rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: var_tax_name },
			rt.ArrayItem{ key: 'hide_empty', val: 0 },
			rt.ArrayItem{ key: 'name', val: 'new' + var_tax_name.str() + '_parent' },
			rt.ArrayItem{ key: 'orderby', val: 'name' },
			rt.ArrayItem{ key: 'hierarchical', val: 1 },
			rt.ArrayItem{ key: 'show_option_none', val: '&mdash; ' +
				(rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'parent_item')).str() +
				' &mdash;' },
		])
		var_parent_dropdown_args = rt.call_function('apply_filters', [
			rt.new_string('post_edit_category_parent_dropdown_args'),
			var_parent_dropdown_args.clone(),
		])
		rt.call_function('wp_dropdown_categories', [var_parent_dropdown_args.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'add_new_item'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('add-' + var_tax_name.str()),
			rt.new_string('_ajax_nonce-add-' + var_tax_name.str()),
			rt.new_bool(false)])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tax_name)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn post_excerpt_meta_box(var_post rt.PhpVal) {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Excerpt')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(var_post, 'post_excerpt'))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Excerpts are optional hand-crafted summaries of your content that can be used in your theme. <a href="%s">Learn more about manual excerpts</a>.'),
		]),
		rt.call_function('__', [
			rt.new_string('https://wordpress.org/documentation/article/what-is-an-excerpt-classic-editor/'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn post_trackback_meta_box(var_post rt.PhpVal) {
	mut var_form_trackback := rt.new_null()
	mut var_pings := rt.new_null()
	mut var_already_pinged := rt.new_null()
	mut var_pinged_url := rt.new_null()
	var_form_trackback = rt.new_string(
		'<input type="text" name="trackback_url" id="trackback_url" class="code" value="' +
		(rt.call_function('esc_attr', [rt.call_function('str_replace', [rt.new_string('\n'), rt.new_string(' '), rt.get_property(var_post, 'to_ping')])])).str() +
		'" aria-describedby="trackback-url-desc" />')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_post,
		'pinged')))))
	{
		var_pings = rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('Already pinged:')])).str() + '</p><ul>')
		var_already_pinged = rt.call_function('explode', [rt.new_string('\n'),
			rt.new_string(rt.get_property(var_post, 'pinged').to_string().trim_space())])
		mut iter_2 := var_already_pinged.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_pinged_url_shadow := item_2.val
			var_pings = rt.concat(var_pings, rt.new_string('\n\t<li>' +
				(rt.call_function('esc_html', [var_pinged_url_shadow.clone()])).str() + '</li>'))
		}
		var_pings = rt.concat(var_pings, rt.new_string('</ul>'))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Send trackbacks to:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_form_trackback)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Separate multiple URLs with spaces')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Trackbacks are a way to notify legacy blog systems that you&#8217;ve linked to them. If you link other WordPress sites, they&#8217;ll be notified automatically using <a href="%s">pingbacks</a>, no other action necessary.'),
		]),
		rt.call_function('__', [
			rt.new_string('https://wordpress.org/documentation/article/introduction-to-blogging/#comments'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_pings)) {
		rt.echo_val(var_pings)
	}
}

fn post_custom_meta_box(var_post rt.PhpVal) {
	mut var_metadata := rt.new_null()
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	// unsupported statement: Stmt_InlineHTML
	var_metadata = rt.call_function('has_meta', [rt.get_property(var_post, 'ID')])
	mut iter_3 := var_metadata.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value_shadow := item_3.val
		mut var_key_shadow := item_3.key
		if rt.is_true(rt.call_function('is_protected_meta', [var_metadata.array_get(var_key_shadow).array_get(rt.new_string('meta_key')), rt.new_string('post')]))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post_meta'), rt.get_property(var_post, 'ID'), var_metadata.array_get(var_key_shadow).array_get(rt.new_string('meta_key'))]))))) {
			var_metadata.array_unset(var_key_shadow)
		}
	}
	rt.call_function('list_meta', [var_metadata.clone()])
	rt.call_function('meta_form', [var_post.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Custom fields can be used to add extra metadata to a post that you can <a href="%s">use in your theme</a>.'),
		]),
		rt.call_function('__', [
			rt.new_string('https://wordpress.org/documentation/article/assign-custom-fields/'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn post_comment_status_meta_box(var_post rt.PhpVal) {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.get_property(var_post, 'comment_status'),
		rt.new_string('open')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Allow comments')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.get_property(var_post, 'ping_status'),
		rt.new_string('open')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Allow <a href="%s">trackbacks and pingbacks</a>'),
		]),
		rt.call_function('__', [
			rt.new_string('https://wordpress.org/documentation/article/introduction-to-blogging/#managing-comments'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('post_comment_status_meta_box-options'),
		var_post.clone()])
	// unsupported statement: Stmt_InlineHTML
}

fn post_comment_meta_box_thead(var_result rt.PhpVal) rt.PhpVal {
	var_result.delete('cb')
	var_result.delete('response')
	return var_result.clone()
}

fn post_comment_meta_box(var_post rt.PhpVal) {
	mut var_total := rt.new_null()
	mut var_wp_list_table := rt.new_null()
	mut var_hidden := rt.new_null()
	rt.call_function('wp_nonce_field', [rt.new_string('get-comments'),
		rt.new_string('add_comment_nonce'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(var_post, 'ID'))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Add Comment')])
	// unsupported statement: Stmt_InlineHTML
	var_total = rt.call_function('get_comments', [
		rt.create_array([
			rt.ArrayItem{ key: 'post_id', val: rt.get_property(var_post, 'ID') },
			rt.ArrayItem{ key: 'count', val: true },
			rt.ArrayItem{ key: 'orderby', val: 'none' },
		]),
	])
	var_wp_list_table = rt.call_function('_get_list_table', [
		rt.new_string('WP_Post_Comments_List_Table'),
	])
	rt.call_method(var_wp_list_table, 'display', [rt.new_bool(true)])
	if rt.is_true(rt.greater(rt.new_int(1), var_total)) {
		print('<p id="no-comments">' +
			(rt.call_function('__', [rt.new_string('No comments yet.')])).str() + '</p>')
	} else {
		var_hidden = rt.call_function('get_hidden_meta_boxes', [
			rt.call_function('get_current_screen', []rt.PhpVal{}),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.new_string('commentsdiv'),
			var_hidden.clone(),
			rt.new_bool(true),
		])))))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_total)
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_total)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Show comments')])
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('wp_comment_trashnotice', []rt.PhpVal{})
}

fn post_slug_meta_box(var_post rt.PhpVal) {
	mut var_editable_slug := rt.new_null()
	var_editable_slug = rt.call_function('apply_filters', [
		rt.new_string('editable_slug'),
		rt.get_property(var_post, 'post_name'),
		var_post.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Slug')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_editable_slug.clone()]))
	// unsupported statement: Stmt_InlineHTML
}

fn post_author_meta_box(var_post rt.PhpVal) {
	mut var_user_ID := rt.new_null()
	mut var_post_type_object := rt.new_null()
	var_post_type_object = rt.call_function('get_post_type_object', [
		rt.get_property(var_post, 'post_type'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Author')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_dropdown_users', [
		rt.create_array([
			rt.ArrayItem{ key: 'capability', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.get_property(rt.get_property(var_post_type_object,
					'cap'), 'edit_posts') },
			]) },
			rt.ArrayItem{ key: 'name', val: 'post_author_override' },
			rt.ArrayItem{
				key: 'selected'
				val: if !rt.is_true(rt.get_property(var_post, 'ID')) {
					var_user_ID
				} else {
					rt.get_property(var_post, 'post_author')
				}
			},
			rt.ArrayItem{ key: 'include_selected', val: true },
			rt.ArrayItem{ key: 'show', val: 'display_name_with_login' },
		]),
	])
}

fn post_revisions_meta_box(var_post rt.PhpVal) {
	rt.call_function('wp_list_post_revisions', [var_post.clone()])
}

fn page_attributes_meta_box(var_post rt.PhpVal) {
	mut var_dropdown_args := rt.new_null()
	mut var_pages := rt.new_null()
	mut var_template := rt.new_null()
	mut var_default_title := rt.new_null()
	if rt.is_true(rt.call_function('is_post_type_hierarchical', [
		rt.get_property(var_post, 'post_type'),
	]))
	{
		var_dropdown_args = rt.create_array([
			rt.ArrayItem{ key: 'post_type', val: rt.get_property(var_post, 'post_type') },
			rt.ArrayItem{ key: 'exclude_tree', val: rt.get_property(var_post, 'ID') },
			rt.ArrayItem{ key: 'selected', val: rt.get_property(var_post, 'post_parent') },
			rt.ArrayItem{ key: 'name', val: 'parent_id' },
			rt.ArrayItem{ key: 'show_option_none', val: rt.call_function('__', [
				rt.new_string('(no parent)'),
			]) },
			rt.ArrayItem{ key: 'sort_column', val: 'menu_order, post_title' },
			rt.ArrayItem{ key: 'echo', val: 0 },
		])
		var_dropdown_args = rt.call_function('apply_filters', [
			rt.new_string('page_attributes_dropdown_pages_args'),
			var_dropdown_args.clone(),
			var_post.clone(),
		])
		var_pages = rt.call_function('wp_dropdown_pages', [var_dropdown_args.clone()])
		if !(!rt.is_true(var_pages)) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Parent')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_pages)
			// unsupported statement: Stmt_InlineHTML
		}
	}
	if rt.call_function('get_page_templates', [var_post.clone()]).array_count() > 0
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('page_for_posts')])).to_i64()), rt.get_property(var_post, 'ID'))))) {
		var_template = if !(!rt.is_true(rt.get_property(var_post, 'page_template'))) {
			rt.get_property(var_post, 'page_template')
		} else {
			rt.new_bool(false)
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Template')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('page_attributes_meta_box_template'),
			var_template.clone(),
			var_post.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
		var_default_title = rt.call_function('apply_filters', [
			rt.new_string('default_page_template_title'),
			rt.call_function('__', [rt.new_string('Default template')]),
			rt.new_string('meta-box'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_default_title.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('page_template_dropdown', [var_template.clone(),
			rt.get_property(var_post, 'post_type')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('post_type_supports', [
		rt.get_property(var_post, 'post_type'),
		rt.new_string('page-attributes'),
	]))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Order')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.get_property(var_post, 'menu_order'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('page_attributes_misc_attributes'),
			var_post.clone()])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_post, 'post_type')))
			&& rt.is_true(rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'get_help_tabs', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Need help? Use the Help tab above the screen title.'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
	}
}

fn link_submit_meta_box(var_link rt.PhpVal) {
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [
		rt.new_string('Save')]),
		rt.new_string(''), rt.new_string('save'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_property(var_link, 'link_id'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_link, 'link_url'))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Visit Link')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.get_property(var_link, 'link_visible'),
		rt.new_string('N')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Keep this link private')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('post_submitbox_start'),
		rt.new_null()])
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('action'))))
		&& rt.is_true(rt.identical(rt.new_string('edit'), rt.get_superglobal('_GET').array_get(rt.new_string('action'))))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_links')])) {
		rt.call_function('printf', [
			rt.new_string('<a class="submitdelete deletion" href="%s" onclick="return confirm( \'%s\' );">%s</a>'),
			rt.call_function('wp_nonce_url', [
				rt.concat(rt.new_string('link.php?action=delete&amp;link_id='), rt.get_property(var_link,
					'link_id')),
				rt.new_string('delete-bookmark_' + (rt.get_property(var_link, 'link_id')).str()),
			]),
			rt.call_function('esc_js', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string("You are about to delete this link '%s'\n  'Cancel' to stop, 'OK' to delete."),
					]),
					rt.get_property(var_link, 'link_name'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Delete'),
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_property(var_link, 'link_id'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Update Link')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Add Link')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('submitlink_box')])
	// unsupported statement: Stmt_InlineHTML
}

fn link_categories_meta_box(var_link rt.PhpVal) {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('All categories')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Most Used'), rt.new_string('categories')])
	// unsupported statement: Stmt_InlineHTML
	if !(rt.get_property(var_link, 'link_id')).is_null() {
		rt.call_function('wp_link_category_checklist', [
			rt.get_property(var_link, 'link_id'),
		])
	} else {
		rt.call_function('wp_link_category_checklist', []rt.PhpVal{})
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_popular_terms_checklist', [rt.new_string('link_category')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('+ Add Category')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('+ Add Category')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('New category name')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Add')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('add-link-category'),
		rt.new_string('_ajax_nonce'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
}

fn link_target_meta_box(var_link rt.PhpVal) {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Target')])
	// unsupported statement: Stmt_InlineHTML
	print(if !(rt.get_property(var_link, 'link_target')).is_null()
		&& rt.is_true(rt.identical(rt.new_string('_blank'), rt.get_property(var_link, 'link_target'))) {
		'checked="checked"'
	} else {
		''
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<code>_blank</code> &mdash; new window or tab.'),
	])
	// unsupported statement: Stmt_InlineHTML
	print(if !(rt.get_property(var_link, 'link_target')).is_null()
		&& rt.is_true(rt.identical(rt.new_string('_top'), rt.get_property(var_link, 'link_target'))) {
		'checked="checked"'
	} else {
		''
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<code>_top</code> &mdash; current window or tab, with no frames.'),
	])
	// unsupported statement: Stmt_InlineHTML
	print(if !(rt.get_property(var_link, 'link_target')).is_null()
		&& rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_link, 'link_target'))) {
		'checked="checked"'
	} else {
		''
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<code>_none</code> &mdash; same window or tab.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Choose the target frame for your link.')])
	// unsupported statement: Stmt_InlineHTML
}

fn xfn_check(xfn_relationship string, xfn_value string, deprecated string) {
	mut var_xfn_relationship := xfn_relationship
	mut var_xfn_value := xfn_value
	mut var_deprecated := deprecated
	mut var_link := rt.new_null()
	mut var_link_rel := rt.new_null()
	mut var_link_rels := rt.new_null()
	if !(deprecated == '') {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.5.0')])
	}
	var_link_rel = if !(rt.get_property(var_link, 'link_rel')).is_null() {
		rt.get_property(var_link, 'link_rel')
	} else {
		rt.new_string('')
	}
	var_link_rels = rt.call_function('preg_split', [rt.new_string('/\\s+/'),
		var_link_rel.clone()])
	if rt.is_true(rt.new_bool('' != xfn_value))
		&& rt.is_true(rt.call_function('in_array', [rt.new_string(xfn_value), var_link_rels.clone(), rt.new_bool(true)])) {
		print(' checked="checked"')
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(xfn_value))) {
		if rt.is_true(rt.identical(rt.new_string('family'), rt.new_string(xfn_relationship)))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_intersect', [var_link_rels.clone(), rt.create_array([rt.ArrayItem{
			key: none
			val: 'child'
		}, rt.ArrayItem{ key: none, val: 'parent' }, rt.ArrayItem{ key: none, val: 'sibling' }, rt.ArrayItem{
			key: none
			val: 'spouse'
		}, rt.ArrayItem{ key: none, val: 'kin' }])]))))) {
			print(' checked="checked"')
		}
		if rt.is_true(rt.identical(rt.new_string('friendship'), rt.new_string(xfn_relationship)))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_intersect', [var_link_rels.clone(), rt.create_array([rt.ArrayItem{
			key: none
			val: 'friend'
		}, rt.ArrayItem{ key: none, val: 'acquaintance' }, rt.ArrayItem{ key: none, val: 'contact' }])]))))) {
			print(' checked="checked"')
		}
		if rt.is_true(rt.identical(rt.new_string('geographical'), rt.new_string(xfn_relationship)))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_intersect', [var_link_rels.clone(), rt.create_array([rt.ArrayItem{
			key: none
			val: 'co-resident'
		}, rt.ArrayItem{ key: none, val: 'neighbor' }])]))))) {
			print(' checked="checked"')
		}
		if rt.is_true(rt.identical(rt.new_string('identity'), rt.new_string(xfn_relationship)))
			&& rt.is_true(rt.call_function('in_array', [rt.new_string('me'), var_link_rels.clone(), rt.new_bool(true)])) {
			print(' checked="checked"')
		}
	}
}

fn link_xfn_meta_box(var_link rt.PhpVal) {
	mut var_identity_group_title := rt.new_null()
	mut var_friendship_group_title := rt.new_null()
	mut var_physical_group_title := rt.new_null()
	mut var_professional_group_title := rt.new_null()
	mut var_geographical_group_title := rt.new_null()
	mut var_family_group_title := rt.new_null()
	mut var_romantic_group_title := rt.new_null()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('rel:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(rt.get_property(var_link, 'link_rel')).is_null() { rt.call_function('esc_attr', [
			rt.get_property(var_link, 'link_rel'),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	var_identity_group_title = rt.call_function('__', [rt.new_string('identity')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_identity_group_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_identity_group_title)
	// unsupported statement: Stmt_InlineHTML
	xfn_check('identity', 'me', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('another web address of mine')])
	// unsupported statement: Stmt_InlineHTML
	var_friendship_group_title = rt.call_function('__', [rt.new_string('friendship')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_friendship_group_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_friendship_group_title)
	// unsupported statement: Stmt_InlineHTML
	xfn_check('friendship', 'contact', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('contact')])
	// unsupported statement: Stmt_InlineHTML
	xfn_check('friendship', 'acquaintance', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('acquaintance')])
	// unsupported statement: Stmt_InlineHTML
	xfn_check('friendship', 'friend', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('friend')])
	// unsupported statement: Stmt_InlineHTML
	xfn_check('friendship', '', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('none'), rt.new_string('Type of relation')])
	// unsupported statement: Stmt_InlineHTML
	var_physical_group_title = rt.call_function('__', [rt.new_string('physical')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_physical_group_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_physical_group_title)
	// unsupported statement: Stmt_InlineHTML
	xfn_check('physical', 'met', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('met')])
	// unsupported statement: Stmt_InlineHTML
	var_professional_group_title = rt.call_function('__', [rt.new_string('professional')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_professional_group_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_professional_group_title)
	// unsupported statement: Stmt_InlineHTML
	xfn_check('professional', 'co-worker', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('co-worker')])
	// unsupported statement: Stmt_InlineHTML
	xfn_check('professional', 'colleague', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('colleague')])
	// unsupported statement: Stmt_InlineHTML
	var_geographical_group_title = rt.call_function('__', [rt.new_string('geographical')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_geographical_group_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_geographical_group_title)
	// unsupported statement: Stmt_InlineHTML
	xfn_check('geographical', 'co-resident', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('co-resident')])
	// unsupported statement: Stmt_InlineHTML
	xfn_check('geographical', 'neighbor', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('neighbor')])
	// unsupported statement: Stmt_InlineHTML
	xfn_check('geographical', '', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('none'), rt.new_string('Type of relation')])
	// unsupported statement: Stmt_InlineHTML
	var_family_group_title = rt.call_function('__', [rt.new_string('family')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_family_group_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_family_group_title)
	// unsupported statement: Stmt_InlineHTML
	xfn_check('family', 'child', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('child')])
	// unsupported statement: Stmt_InlineHTML
	xfn_check('family', 'kin', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('kin')])
	// unsupported statement: Stmt_InlineHTML
	xfn_check('family', 'parent', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('parent')])
	// unsupported statement: Stmt_InlineHTML
	xfn_check('family', 'sibling', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('sibling')])
	// unsupported statement: Stmt_InlineHTML
	xfn_check('family', 'spouse', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('spouse')])
	// unsupported statement: Stmt_InlineHTML
	xfn_check('family', '', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('none'), rt.new_string('Type of relation')])
	// unsupported statement: Stmt_InlineHTML
	var_romantic_group_title = rt.call_function('__', [rt.new_string('romantic')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_romantic_group_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_romantic_group_title)
	// unsupported statement: Stmt_InlineHTML
	xfn_check('romantic', 'muse', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('muse')])
	// unsupported statement: Stmt_InlineHTML
	xfn_check('romantic', 'crush', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('crush')])
	// unsupported statement: Stmt_InlineHTML
	xfn_check('romantic', 'date', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('date')])
	// unsupported statement: Stmt_InlineHTML
	xfn_check('romantic', 'sweetheart', '')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('sweetheart')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('If the link is to a person, you can specify your relationship with them using the above form. If you would like to learn more about the idea check out <a href="https://gmpg.org/xfn/">XFN</a>.'),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn link_advanced_meta_box(var_link rt.PhpVal) {
	mut var_rating := i64(0)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Image Address')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(rt.get_property(var_link, 'link_image')).is_null() { rt.call_function('esc_attr', [
			rt.get_property(var_link, 'link_image'),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('RSS Address')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(rt.get_property(var_link, 'link_rss')).is_null() { rt.call_function('esc_attr', [
			rt.get_property(var_link, 'link_rss'),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex',
		[rt.new_string('Notes'), rt.new_string('Link manager notes field label')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(rt.get_property(var_link, 'link_notes')).is_null() {
		rt.get_property(var_link, 'link_notes')
	} else {
		rt.new_string('')
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Rating')])
	// unsupported statement: Stmt_InlineHTML
	var_rating = 0
	for {
		if !(var_rating <= 10) { break
		 }
		print('<option value="' + var_rating.str() + '"')
		if !(rt.get_property(var_link, 'link_rating')).is_null()
			&& rt.is_true(rt.identical(rt.get_property(var_link, 'link_rating'), rt.new_int(var_rating))) {
			print(' selected="selected"')
		}
		print('>' + var_rating.str() + '</option>')
		var_rating += 1
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('(Leave at 0 for no rating.)')])
	// unsupported statement: Stmt_InlineHTML
}

fn post_thumbnail_meta_box(var_post rt.PhpVal) {
	mut var_thumbnail_id := rt.new_null()
	var_thumbnail_id = rt.call_function('get_post_meta', [
		rt.get_property(var_post, 'ID'),
		rt.new_string('_thumbnail_id'),
		rt.new_bool(true),
	])
	rt.echo_val(rt.call_function('_wp_post_thumbnail_html', [
		var_thumbnail_id.clone(), rt.get_property(var_post, 'ID')]))
}

fn attachment_id3_data_meta_box(var_post rt.PhpVal) {
	mut var_meta := rt.new_null()
	mut var_label := rt.new_null()
	mut var_key := rt.new_null()
	mut var_value := rt.new_null()
	var_meta = rt.new_array()
	if !(!rt.is_true(rt.get_property(var_post, 'ID'))) {
		var_meta = rt.call_function('wp_get_attachment_metadata', [
			rt.get_property(var_post, 'ID'),
		])
	}
	mut iter_4 := rt.call_function('wp_get_attachment_id3_keys', [
		var_post.clone(), rt.new_string('edit')]).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_label_shadow := item_4.val
		mut var_key_shadow := item_4.key
		var_value = rt.new_string('')
		if !(!rt.is_true(var_meta.array_get(var_key_shadow))) {
			var_value = var_meta.array_get(var_key_shadow)
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_label_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_key_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_key_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_value.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
}

fn register_and_do_post_meta_boxes(var_post rt.PhpVal) {
	mut var_post_type := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_thumbnail_support := false
	mut var_publish_callback_args := map[string]rt.PhpVal{}
	mut var_revisions := rt.new_null()
	mut var_tax_name := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_label := rt.new_null()
	mut var_tax_meta_box_id := rt.new_null()
	mut var_statuses := rt.new_null()
	var_post_type = rt.get_property(var_post, 'post_type')
	var_post_type_object = rt.call_function('get_post_type_object', [
		var_post_type.clone()])
	var_thumbnail_support =
		rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), var_post_type.clone()]))
		&& rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('thumbnail')]))
	if !var_thumbnail_support
		&& rt.is_true(rt.identical(rt.new_string('attachment'), var_post_type))
		&& rt.is_true(rt.get_property(var_post, 'post_mime_type')) {
		if rt.is_true(rt.call_function('wp_attachment_is', [rt.new_string('audio'),
			var_post.clone()]))
		{
			var_thumbnail_support =
				rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment:audio'), rt.new_string('thumbnail')]))
				|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), rt.new_string('attachment:audio')]))
		} else if rt.is_true(rt.call_function('wp_attachment_is', [
			rt.new_string('video'),
			var_post.clone(),
		]))
		{
			var_thumbnail_support =
				rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment:video'), rt.new_string('thumbnail')]))
				|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), rt.new_string('attachment:video')]))
		}
	}
	var_publish_callback_args = {
		'__back_compat_meta_box': rt.new_bool(true)
	}
	if rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('revisions')]))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post, 'post_status'))))) {
		var_revisions = rt.call_function('wp_get_latest_revision_id_and_total_count', [
			rt.get_property(var_post, 'ID'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_revisions.clone()])))))
			&& rt.is_true(rt.greater(var_revisions.array_get(rt.new_string('count')), rt.new_int(1))) {
			var_publish_callback_args = {
				'revisions_count':        var_revisions.array_get(rt.new_string('count'))
				'revision_id':            var_revisions.array_get(rt.new_string('latest_id'))
				'__back_compat_meta_box': rt.new_bool(true)
			}
			rt.call_function('add_meta_box', [rt.new_string('revisionsdiv'),
				rt.call_function('__', [rt.new_string('Revisions')]),
				rt.new_string('post_revisions_meta_box'), rt.new_null(),
				rt.new_string('normal'), rt.new_string('core'),
				rt.create_array([rt.ArrayItem{ key: '__back_compat_meta_box', val: true }])])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('attachment'), var_post_type)) {
		rt.call_function('wp_enqueue_script', [rt.new_string('image-edit')])
		rt.call_function('wp_enqueue_style', [rt.new_string('imgareaselect')])
		rt.call_function('add_meta_box', [rt.new_string('submitdiv'),
			rt.call_function('__', [rt.new_string('Save')]), rt.new_string('attachment_submit_meta_box'),
			rt.new_null(), rt.new_string('side'), rt.new_string('core'),
			rt.create_array([rt.ArrayItem{ key: '__back_compat_meta_box', val: true }])])
		rt.call_function('add_action', [rt.new_string('edit_form_after_title'),
			rt.new_string('edit_form_image_editor')])
		if rt.is_true(rt.call_function('wp_attachment_is', [rt.new_string('audio'),
			var_post.clone()]))
		{
			rt.call_function('add_meta_box', [rt.new_string('attachment-id3'),
				rt.call_function('__', [rt.new_string('Metadata')]),
				rt.new_string('attachment_id3_data_meta_box'),
				rt.new_null(), rt.new_string('normal'), rt.new_string('core'),
				rt.create_array([rt.ArrayItem{ key: '__back_compat_meta_box', val: true }])])
		}
	} else {
		rt.call_function('add_meta_box', [rt.new_string('submitdiv'),
			rt.call_function('__', [rt.new_string('Publish')]),
			rt.new_string('post_submit_meta_box'), rt.new_null(),
			rt.new_string('side'), rt.new_string('core'),
			rt.create_array_from_native_map(var_publish_callback_args)])
	}
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-formats')]))
		&& rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('post-formats')])) {
		rt.call_function('add_meta_box', [rt.new_string('formatdiv'),
			rt.call_function('_x', [rt.new_string('Format'), rt.new_string('post format')]),
			rt.new_string('post_format_meta_box'), rt.new_null(),
			rt.new_string('side'), rt.new_string('core'),
			rt.create_array([
				rt.ArrayItem{ key: '__back_compat_meta_box', val: true }])])
	}
	mut iter_5 := rt.call_function('get_object_taxonomies', [
		var_post.clone()]).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_tax_name_shadow := item_5.val
		var_taxonomy = rt.call_function('get_taxonomy', [var_tax_name_shadow.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_taxonomy, 'show_ui')))))
			|| rt.is_true(rt.identical(rt.new_bool(false), rt.get_property(var_taxonomy, 'meta_box_cb'))) {
			continue
		}
		var_label = rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'name')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
			var_tax_name_shadow.clone(),
		])))))
		{
			var_tax_meta_box_id = rt.new_string('tagsdiv-' + var_tax_name_shadow.str())
		} else {
			var_tax_meta_box_id = rt.new_string(var_tax_name_shadow.str() + 'div')
		}
		rt.call_function('add_meta_box', [var_tax_meta_box_id.clone(),
			var_label.clone(), rt.get_property(var_taxonomy, 'meta_box_cb'),
			rt.new_null(), rt.new_string('side'), rt.new_string('core'),
			rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_tax_name_shadow },
				rt.ArrayItem{ key: '__back_compat_meta_box', val: true }])])
	}
	if rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('page-attributes')]))
		|| rt.call_function('get_page_templates', [var_post.clone()]).array_count() > 0 {
		rt.call_function('add_meta_box', [rt.new_string('pageparentdiv'),
			rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'attributes'),
			rt.new_string('page_attributes_meta_box'), rt.new_null(),
			rt.new_string('side'), rt.new_string('core'),
			rt.create_array([
				rt.ArrayItem{ key: '__back_compat_meta_box', val: true },
			])])
	}
	if var_thumbnail_support
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_files')])) {
		rt.call_function('add_meta_box', [rt.new_string('postimagediv'),
			rt.call_function('esc_html', [
				rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'featured_image'),
			]),
			rt.new_string('post_thumbnail_meta_box'), rt.new_null(),
			rt.new_string('side'), rt.new_string('low'),
			rt.create_array([
				rt.ArrayItem{ key: '__back_compat_meta_box', val: true },
			])])
	}
	if rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(),
		rt.new_string('excerpt')]))
	{
		rt.call_function('add_meta_box', [rt.new_string('postexcerpt'),
			rt.call_function('__', [rt.new_string('Excerpt')]),
			rt.new_string('post_excerpt_meta_box'), rt.new_null(),
			rt.new_string('normal'), rt.new_string('core'),
			rt.create_array([
				rt.ArrayItem{ key: '__back_compat_meta_box', val: true }])])
	}
	if rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(),
		rt.new_string('trackbacks')]))
	{
		rt.call_function('add_meta_box', [rt.new_string('trackbacksdiv'),
			rt.call_function('__', [rt.new_string('Send Trackbacks')]),
			rt.new_string('post_trackback_meta_box'), rt.new_null(),
			rt.new_string('normal'), rt.new_string('core'),
			rt.create_array([
				rt.ArrayItem{ key: '__back_compat_meta_box', val: true }])])
	}
	if rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(),
		rt.new_string('custom-fields')]))
	{
		rt.call_function('add_meta_box', [rt.new_string('postcustom'),
			rt.call_function('__', [rt.new_string('Custom Fields')]),
			rt.new_string('post_custom_meta_box'), rt.new_null(),
			rt.new_string('normal'), rt.new_string('core'),
			rt.create_array([
				rt.ArrayItem{ key: '__back_compat_meta_box', val: !(rt.is_true((rt.call_function('get_user_meta', [
					rt.call_function('get_current_user_id', []rt.PhpVal{}),
					rt.new_string('enable_custom_fields'),
					rt.new_bool(true),
				])).to_bool())) }, rt.ArrayItem{
					key: '__block_editor_compatible_meta_box'
					val: true
				}])])
	}
	rt.call_function('do_action_deprecated', [rt.new_string('dbx_post_advanced'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_post }]),
		rt.new_string('3.7.0'), rt.new_string('add_meta_boxes')])
	if rt.is_true(rt.call_function('comments_open', [var_post.clone()]))
		|| rt.is_true(rt.call_function('pings_open', [var_post.clone()]))
		|| rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('comments')])) {
		rt.call_function('add_meta_box', [rt.new_string('commentstatusdiv'),
			rt.call_function('__', [rt.new_string('Discussion')]),
			rt.new_string('post_comment_status_meta_box'), rt.new_null(),
			rt.new_string('normal'), rt.new_string('core'),
			rt.create_array([
				rt.ArrayItem{ key: '__back_compat_meta_box', val: true }])])
	}
	var_statuses = rt.call_function('get_post_stati', [
		rt.create_array([rt.ArrayItem{ key: 'public', val: true }]),
	])
	if !rt.is_true(var_statuses) {
		var_statuses = rt.create_array([rt.ArrayItem{ key: none, val: 'publish' }])
	}
	var_statuses.array_push('private')
	if rt.is_true(rt.call_function('in_array', [
		rt.call_function('get_post_status', [var_post.clone()]),
		var_statuses.clone(),
		rt.new_bool(true),
	]))
	{
		if rt.is_true(rt.call_function('comments_open', [var_post.clone()]))
			|| rt.is_true(rt.call_function('pings_open', [var_post.clone()]))
			|| rt.is_true(rt.greater(rt.get_property(var_post, 'comment_count'), rt.new_int(0)))
			|| rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('comments')])) {
			rt.call_function('add_meta_box', [rt.new_string('commentsdiv'),
				rt.call_function('__', [rt.new_string('Comments')]),
				rt.new_string('post_comment_meta_box'), rt.new_null(),
				rt.new_string('normal'), rt.new_string('core'),
				rt.create_array([rt.ArrayItem{ key: '__back_compat_meta_box', val: true }])])
		}
	}
	if !(
		rt.is_true(rt.identical(rt.new_string('pending'), rt.call_function('get_post_status', [var_post.clone()])))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'publish_posts')])))))) {
		rt.call_function('add_meta_box', [rt.new_string('slugdiv'),
			rt.call_function('__', [rt.new_string('Slug')]), rt.new_string('post_slug_meta_box'),
			rt.new_null(), rt.new_string('normal'), rt.new_string('core'),
			rt.create_array([rt.ArrayItem{ key: '__back_compat_meta_box', val: true }])])
	}
	if rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('author')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'edit_others_posts')])) {
		rt.call_function('add_meta_box', [rt.new_string('authordiv'),
			rt.call_function('__', [rt.new_string('Author')]),
			rt.new_string('post_author_meta_box'), rt.new_null(),
			rt.new_string('normal'), rt.new_string('core'),
			rt.create_array([
				rt.ArrayItem{ key: '__back_compat_meta_box', val: true }])])
	}
	rt.call_function('do_action', [rt.new_string('add_meta_boxes'),
		var_post_type.clone(), var_post.clone()])
	rt.call_function('do_action', [
		rt.new_string('add_meta_boxes_${var_post_type.to_string()}'),
		var_post.clone(),
	])
	rt.call_function('do_action', [rt.new_string('do_meta_boxes'),
		var_post_type.clone(), rt.new_string('normal'), var_post.clone()])
	rt.call_function('do_action', [rt.new_string('do_meta_boxes'),
		var_post_type.clone(), rt.new_string('advanced'), var_post.clone()])
	rt.call_function('do_action', [rt.new_string('do_meta_boxes'),
		var_post_type.clone(), rt.new_string('side'), var_post.clone()])
}

fn main() {
	defer {
		rt.shutdown()
	}
}
