import rt

fn map_meta_cap(var_cap_arg rt.PhpVal, var_user_id rt.PhpVal, var_args_origin ...rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_cap := var_cap_arg
	mut var_post_type_meta_caps := rt.new_null()
	mut var_caps := rt.new_null()
	mut var_message := rt.new_null()
	mut var_post := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_status := rt.new_null()
	mut var_status_obj := rt.new_null()
	mut var_object_type := rt.new_null()
	mut var_object_id := rt.new_null()
	mut var_object_subtype := rt.new_null()
	mut var_meta_key := rt.new_null()
	mut var_allowed := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_menu_perms := rt.new_null()
	mut var_term_id := rt.new_null()
	mut var_term := rt.new_null()
	mut var_tax := rt.new_null()
	mut var_taxo_cap := rt.new_null()
	mut var_block_editor_context := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_post_type_capabilities := rt.new_null()
	mut var_block_caps := rt.new_null()
	var_caps = rt.new_array()
	mut switch_val_1 := var_cap
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('remove_user'))) {
		if var_args.array_isset(rt.new_int(0))
			&& rt.is_true(rt.identical(var_user_id, rt.new_int((var_args.array_get(rt.new_int(0))).to_i64())))
			&& !(is_super_admin(var_user_id.clone())) {
			var_caps.array_push('do_not_allow')
		} else {
			var_caps.array_push('remove_users')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('promote_user')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('add_users'))) {
		var_caps.array_push('promote_users')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_user')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_users'))) {
		if rt.is_true(rt.less(var_user_id, rt.new_int(1))) {
			var_caps.array_push('do_not_allow')
		}
		if rt.is_true(rt.identical(rt.new_string('edit_user'), var_cap))
			&& var_args.array_isset(rt.new_int(0))
			&& rt.is_true(rt.identical(var_user_id, rt.new_int((var_args.array_get(rt.new_int(0))).to_i64()))) {
		}
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& (!(is_super_admin(var_user_id.clone()))
			&& rt.is_true(rt.identical(rt.new_string('edit_user'), var_cap))
			&& is_super_admin(var_args.array_get(rt.new_int(0))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(user_can(var_user_id.clone(), rt.new_string('manage_network_users')))))) {
			var_caps.array_push('do_not_allow')
		} else {
			var_caps.array_push('edit_users')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_post')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_page'))) {
		if !(var_args.array_isset(rt.new_int(0))) {
			if rt.is_true(rt.identical(rt.new_string('delete_post'), var_cap)) {
				var_message = rt.call_function('__', [
					rt.new_string('When checking for the %s capability, you must always check it against a specific post.'),
				])
			} else {
				var_message = rt.call_function('__', [
					rt.new_string('When checking for the %s capability, you must always check it against a specific page.'),
				])
			}
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [var_message.clone(),
					rt.new_string('<code>' + var_cap.str() + '</code>')]),
				rt.new_string('6.1.0')])
			var_caps.array_push('do_not_allow')
		}
		var_post = rt.call_function('get_post', [var_args.array_get(rt.new_int(0))])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			var_caps.array_push('do_not_allow')
		}
		if rt.is_true(rt.identical(rt.new_string('revision'),
			rt.get_property(var_post, 'post_type')))
		{
			var_caps.array_push('do_not_allow')
		}
		if rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('page_for_posts')])).to_i64()), rt.get_property(var_post, 'ID')))
			|| rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('page_on_front')])).to_i64()), rt.get_property(var_post, 'ID'))) {
			var_caps.array_push('manage_options')
		}
		var_post_type = rt.call_function('get_post_type_object', [
			rt.get_property(var_post, 'post_type'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) {
			var_message = rt.call_function('__', [
				rt.new_string('The post type %1$s is not registered, so it may not be reliable to check the capability %2$s against a post of that type.'),
			])
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [var_message.clone(),
					rt.new_string('<code>' + (rt.get_property(var_post, 'post_type')).str() +
						'</code>'),
					rt.new_string('<code>' + var_cap.str() + '</code>')]),
				rt.new_string('4.4.0')])
			var_caps.array_push('edit_others_posts')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_type, 'map_meta_cap'))))) {
			var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
				'{"nodeType":"Expr_Variable","line":140,"name":"cap"}'))
			if rt.is_true(rt.identical(rt.new_string('delete_post'), var_cap)) {
				var_cap = rt.get_property(rt.get_property(var_post_type, 'cap'),
					'{"nodeType":"Expr_Variable","line":143,"name":"cap"}')
			}
		}
		if rt.is_true(rt.get_property(var_post, 'post_author'))
			&& rt.is_true(rt.identical(var_user_id, rt.new_int((rt.get_property(var_post, 'post_author')).to_i64()))) {
			if rt.is_true(rt.call_function('in_array', [
				rt.get_property(var_post, 'post_status'),
				rt.create_array([rt.ArrayItem{ key: none, val: 'publish' },
					rt.ArrayItem{ key: none, val: 'future' }]),
				rt.new_bool(true),
			]))
			{
				var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
					'delete_published_posts'))
			} else if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post,
				'post_status')))
			{
				var_status = rt.call_function('get_post_meta', [
					rt.get_property(var_post, 'ID'),
					rt.new_string('_wp_trash_meta_status'),
					rt.new_bool(true),
				])
				if rt.is_true(rt.call_function('in_array', [var_status.clone(),
					rt.create_array([rt.ArrayItem{ key: none, val: 'publish' },
						rt.ArrayItem{ key: none, val: 'future' }]),
					rt.new_bool(true)]))
				{
					var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
						'delete_published_posts'))
				} else {
					var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
						'delete_posts'))
				}
			} else {
				var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
					'delete_posts'))
			}
		} else {
			var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
				'delete_others_posts'))
			if rt.is_true(rt.call_function('in_array', [
				rt.get_property(var_post, 'post_status'),
				rt.create_array([rt.ArrayItem{ key: none, val: 'publish' },
					rt.ArrayItem{ key: none, val: 'future' }]),
				rt.new_bool(true),
			]))
			{
				var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
					'delete_published_posts'))
			} else if rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(var_post,
				'post_status')))
			{
				var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
					'delete_private_posts'))
			}
		}
		if rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [
			rt.new_string('wp_page_for_privacy_policy'),
		])).to_i64()), rt.get_property(var_post, 'ID')))
		{
			var_caps = rt.call_function('array_merge', [var_caps.clone(),
				map_meta_cap(rt.new_string('manage_privacy_options'), var_user_id.clone())])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_post')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_page'))) {
		if !(var_args.array_isset(rt.new_int(0))) {
			if rt.is_true(rt.identical(rt.new_string('edit_post'), var_cap)) {
				var_message = rt.call_function('__', [
					rt.new_string('When checking for the %s capability, you must always check it against a specific post.'),
				])
			} else {
				var_message = rt.call_function('__', [
					rt.new_string('When checking for the %s capability, you must always check it against a specific page.'),
				])
			}
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [var_message.clone(),
					rt.new_string('<code>' + var_cap.str() + '</code>')]),
				rt.new_string('6.1.0')])
			var_caps.array_push('do_not_allow')
		}
		var_post = rt.call_function('get_post', [var_args.array_get(rt.new_int(0))])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			var_caps.array_push('do_not_allow')
		}
		if rt.is_true(rt.identical(rt.new_string('revision'),
			rt.get_property(var_post, 'post_type')))
		{
			var_post = rt.call_function('get_post', [
				rt.get_property(var_post, 'post_parent'),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
				var_caps.array_push('do_not_allow')
			}
		}
		var_post_type = rt.call_function('get_post_type_object', [
			rt.get_property(var_post, 'post_type'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) {
			var_message = rt.call_function('__', [
				rt.new_string('The post type %1$s is not registered, so it may not be reliable to check the capability %2$s against a post of that type.'),
			])
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [var_message.clone(),
					rt.new_string('<code>' + (rt.get_property(var_post, 'post_type')).str() +
						'</code>'),
					rt.new_string('<code>' + var_cap.str() + '</code>')]),
				rt.new_string('4.4.0')])
			var_caps.array_push('edit_others_posts')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_type, 'map_meta_cap'))))) {
			var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
				'{"nodeType":"Expr_Variable","line":243,"name":"cap"}'))
			if rt.is_true(rt.identical(rt.new_string('edit_post'), var_cap)) {
				var_cap = rt.get_property(rt.get_property(var_post_type, 'cap'),
					'{"nodeType":"Expr_Variable","line":246,"name":"cap"}')
			}
		}
		if rt.is_true(rt.get_property(var_post, 'post_author'))
			&& rt.is_true(rt.identical(var_user_id, rt.new_int((rt.get_property(var_post, 'post_author')).to_i64()))) {
			if rt.is_true(rt.call_function('in_array', [
				rt.get_property(var_post, 'post_status'),
				rt.create_array([rt.ArrayItem{ key: none, val: 'publish' },
					rt.ArrayItem{ key: none, val: 'future' }]),
				rt.new_bool(true),
			]))
			{
				var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
					'edit_published_posts'))
			} else if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post,
				'post_status')))
			{
				var_status = rt.call_function('get_post_meta', [
					rt.get_property(var_post, 'ID'),
					rt.new_string('_wp_trash_meta_status'),
					rt.new_bool(true),
				])
				if rt.is_true(rt.call_function('in_array', [var_status.clone(),
					rt.create_array([rt.ArrayItem{ key: none, val: 'publish' },
						rt.ArrayItem{ key: none, val: 'future' }]),
					rt.new_bool(true)]))
				{
					var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
						'edit_published_posts'))
				} else {
					var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
						'edit_posts'))
				}
			} else {
				var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
					'edit_posts'))
			}
		} else {
			var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
				'edit_others_posts'))
			if rt.is_true(rt.call_function('in_array', [
				rt.get_property(var_post, 'post_status'),
				rt.create_array([rt.ArrayItem{ key: none, val: 'publish' },
					rt.ArrayItem{ key: none, val: 'future' }]),
				rt.new_bool(true),
			]))
			{
				var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
					'edit_published_posts'))
			} else if rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(var_post,
				'post_status')))
			{
				var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
					'edit_private_posts'))
			}
		}
		if rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [
			rt.new_string('wp_page_for_privacy_policy'),
		])).to_i64()), rt.get_property(var_post, 'ID')))
		{
			var_caps = rt.call_function('array_merge', [var_caps.clone(),
				map_meta_cap(rt.new_string('manage_privacy_options'), var_user_id.clone())])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('read_post')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('read_page'))) {
		if !(var_args.array_isset(rt.new_int(0))) {
			if rt.is_true(rt.identical(rt.new_string('read_post'), var_cap)) {
				var_message = rt.call_function('__', [
					rt.new_string('When checking for the %s capability, you must always check it against a specific post.'),
				])
			} else {
				var_message = rt.call_function('__', [
					rt.new_string('When checking for the %s capability, you must always check it against a specific page.'),
				])
			}
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [var_message.clone(),
					rt.new_string('<code>' + var_cap.str() + '</code>')]),
				rt.new_string('6.1.0')])
			var_caps.array_push('do_not_allow')
		}
		var_post = rt.call_function('get_post', [var_args.array_get(rt.new_int(0))])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			var_caps.array_push('do_not_allow')
		}
		if rt.is_true(rt.identical(rt.new_string('revision'),
			rt.get_property(var_post, 'post_type')))
		{
			var_post = rt.call_function('get_post', [
				rt.get_property(var_post, 'post_parent'),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
				var_caps.array_push('do_not_allow')
			}
		}
		var_post_type = rt.call_function('get_post_type_object', [
			rt.get_property(var_post, 'post_type'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) {
			var_message = rt.call_function('__', [
				rt.new_string('The post type %1$s is not registered, so it may not be reliable to check the capability %2$s against a post of that type.'),
			])
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [var_message.clone(),
					rt.new_string('<code>' + (rt.get_property(var_post, 'post_type')).str() +
						'</code>'),
					rt.new_string('<code>' + var_cap.str() + '</code>')]),
				rt.new_string('4.4.0')])
			var_caps.array_push('edit_others_posts')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_type, 'map_meta_cap'))))) {
			var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
				'{"nodeType":"Expr_Variable","line":342,"name":"cap"}'))
			if rt.is_true(rt.identical(rt.new_string('read_post'), var_cap)) {
				var_cap = rt.get_property(rt.get_property(var_post_type, 'cap'),
					'{"nodeType":"Expr_Variable","line":345,"name":"cap"}')
			}
		}
		var_status_obj = rt.call_function('get_post_status_object', [
			rt.call_function('get_post_status', [var_post.clone()]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_status_obj)))) {
			var_message = rt.call_function('__', [
				rt.new_string('The post status %1$s is not registered, so it may not be reliable to check the capability %2$s against a post with that status.'),
			])
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [var_message.clone(),
					rt.new_string('<code>' +
						(rt.call_function('get_post_status', [var_post.clone()])).str() + '</code>'),
					rt.new_string('<code>' + var_cap.str() + '</code>')]),
				rt.new_string('5.4.0')])
			var_caps.array_push('edit_others_posts')
		}
		if rt.is_true(rt.get_property(var_status_obj, 'public')) {
			var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'), 'read'))
		}
		if rt.is_true(rt.get_property(var_post, 'post_author'))
			&& rt.is_true(rt.identical(var_user_id, rt.new_int((rt.get_property(var_post, 'post_author')).to_i64()))) {
			var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'), 'read'))
		} else if rt.is_true(rt.get_property(var_status_obj, 'private')) {
			var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'),
				'read_private_posts'))
		} else {
			var_caps = map_meta_cap(rt.new_string('edit_post'), var_user_id.clone(),
				rt.get_property(var_post, 'ID'))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('publish_post'))) {
		if !(var_args.array_isset(rt.new_int(0))) {
			var_message = rt.call_function('__', [
				rt.new_string('When checking for the %s capability, you must always check it against a specific post.'),
			])
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [var_message.clone(),
					rt.new_string('<code>' + var_cap.str() + '</code>')]),
				rt.new_string('6.1.0')])
			var_caps.array_push('do_not_allow')
		}
		var_post = rt.call_function('get_post', [var_args.array_get(rt.new_int(0))])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			var_caps.array_push('do_not_allow')
		}
		var_post_type = rt.call_function('get_post_type_object', [
			rt.get_property(var_post, 'post_type'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) {
			var_message = rt.call_function('__', [
				rt.new_string('The post type %1$s is not registered, so it may not be reliable to check the capability %2$s against a post of that type.'),
			])
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [var_message.clone(),
					rt.new_string('<code>' + (rt.get_property(var_post, 'post_type')).str() +
						'</code>'),
					rt.new_string('<code>' + var_cap.str() + '</code>')]),
				rt.new_string('4.4.0')])
			var_caps.array_push('edit_others_posts')
		}
		var_caps.array_push(rt.get_property(rt.get_property(var_post_type, 'cap'), 'publish_posts'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_post_meta')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_post_meta')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('add_post_meta')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_comment_meta')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_comment_meta')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('add_comment_meta')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_term_meta')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_term_meta')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('add_term_meta')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_user_meta')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_user_meta')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('add_user_meta'))) {
		var_object_type = rt.call_function('explode', [rt.new_string('_'),
			var_cap.clone()]).array_get(rt.new_int(1))
		if !(var_args.array_isset(rt.new_int(0))) {
			if rt.is_true(rt.identical(rt.new_string('post'), var_object_type)) {
				var_message = rt.call_function('__', [
					rt.new_string('When checking for the %s capability, you must always check it against a specific post.'),
				])
			} else if rt.is_true(rt.identical(rt.new_string('comment'), var_object_type)) {
				var_message = rt.call_function('__', [
					rt.new_string('When checking for the %s capability, you must always check it against a specific comment.'),
				])
			} else if rt.is_true(rt.identical(rt.new_string('term'), var_object_type)) {
				var_message = rt.call_function('__', [
					rt.new_string('When checking for the %s capability, you must always check it against a specific term.'),
				])
			} else {
				var_message = rt.call_function('__', [
					rt.new_string('When checking for the %s capability, you must always check it against a specific user.'),
				])
			}
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [var_message.clone(),
					rt.new_string('<code>' + var_cap.str() + '</code>')]),
				rt.new_string('6.1.0')])
			var_caps.array_push('do_not_allow')
		}
		var_object_id = rt.new_int((var_args.array_get(rt.new_int(0))).to_i64())
		var_object_subtype = rt.call_function('get_object_subtype', [
			var_object_type.clone(), var_object_id.clone()])
		if !rt.is_true(var_object_subtype) {
			var_caps.array_push('do_not_allow')
		}
		var_caps = map_meta_cap(rt.new_string('edit_${var_object_type.to_string()}'),
			var_user_id.clone(), var_object_id.clone())
		var_meta_key = if !(var_args.array_get(rt.new_int(1))).is_null() {
			var_args.array_get(rt.new_int(1))
		} else {
			rt.new_bool(false)
		}
		if rt.is_true(var_meta_key) {
			var_allowed = rt.new_bool(!(rt.is_true(rt.call_function('is_protected_meta', [
				var_meta_key.clone(),
				var_object_type.clone(),
			]))))
			if rt.is_true(rt.call_function('has_filter', [
				rt.new_string('auth_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}_for_${var_object_subtype.to_string()}'),
			]))
			{
				var_allowed = rt.call_function('apply_filters', [
					rt.new_string('auth_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}_for_${var_object_subtype.to_string()}'),
					var_allowed.clone(),
					var_meta_key.clone(),
					var_object_id.clone(),
					var_user_id.clone(),
					var_cap.clone(),
					var_caps.clone(),
				])
			} else {
				var_allowed = rt.call_function('apply_filters', [
					rt.new_string('auth_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}'),
					var_allowed.clone(),
					var_meta_key.clone(),
					var_object_id.clone(),
					var_user_id.clone(),
					var_cap.clone(),
					var_caps.clone(),
				])
			}
			var_allowed = rt.call_function('apply_filters_deprecated', [
				rt.new_string('auth_${var_object_type.to_string()}_${var_object_subtype.to_string()}_meta_${var_meta_key.to_string()}'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_allowed },
					rt.ArrayItem{ key: none, val: var_meta_key },
					rt.ArrayItem{ key: none, val: var_object_id },
					rt.ArrayItem{ key: none, val: var_user_id },
					rt.ArrayItem{ key: none, val: var_cap }, rt.ArrayItem{ key: none, val: var_caps }]),
				rt.new_string('4.9.8'),
				rt.new_string('auth_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}_for_${var_object_subtype.to_string()}'),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_allowed)))) {
				var_caps.array_push(var_cap.clone())
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_comment'))) {
		if !(var_args.array_isset(rt.new_int(0))) {
			var_message = rt.call_function('__', [
				rt.new_string('When checking for the %s capability, you must always check it against a specific comment.'),
			])
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [var_message.clone(),
					rt.new_string('<code>' + var_cap.str() + '</code>')]),
				rt.new_string('6.1.0')])
			var_caps.array_push('do_not_allow')
		}
		var_comment = rt.call_function('get_comment', [var_args.array_get(rt.new_int(0))])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
			var_caps.array_push('do_not_allow')
		}
		var_post = rt.call_function('get_post', [
			rt.get_property(var_comment, 'comment_post_ID'),
		])
		if rt.is_true(var_post) {
			var_caps = map_meta_cap(rt.new_string('edit_post'), var_user_id.clone(),
				rt.get_property(var_post, 'ID'))
		} else {
			var_caps = map_meta_cap(rt.new_string('edit_posts'), var_user_id.clone())
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('unfiltered_upload'))) {
		if rt.is_true(rt.call_function('defined', [rt.new_string('ALLOW_UNFILTERED_UPLOADS')]))
			&& rt.is_true(rt.get_constant('ALLOW_UNFILTERED_UPLOADS'))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
			|| is_super_admin(var_user_id.clone()) {
			var_caps.array_push(var_cap.clone())
		} else {
			var_caps.array_push('do_not_allow')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_css')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('unfiltered_html'))) {
		if rt.is_true(rt.call_function('defined', [rt.new_string('DISALLOW_UNFILTERED_HTML')]))
			&& rt.is_true(rt.get_constant('DISALLOW_UNFILTERED_HTML')) {
			var_caps.array_push('do_not_allow')
		} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& !(is_super_admin(var_user_id.clone())) {
			var_caps.array_push('do_not_allow')
		} else {
			var_caps.array_push('unfiltered_html')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_files')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_plugins')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_themes'))) {
		if rt.is_true(rt.call_function('defined', [rt.new_string('DISALLOW_FILE_EDIT')]))
			&& rt.is_true(rt.get_constant('DISALLOW_FILE_EDIT')) {
			var_caps.array_push('do_not_allow')
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_file_mod_allowed', [
			rt.new_string('capability_edit_themes'),
		])))))
		{
			var_caps.array_push('do_not_allow')
		} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& !(is_super_admin(var_user_id.clone())) {
			var_caps.array_push('do_not_allow')
		} else {
			var_caps.array_push(var_cap.clone())
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('update_plugins')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_plugins')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('install_plugins')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('upload_plugins')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('update_themes')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_themes')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('install_themes')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('upload_themes')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('update_core'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_file_mod_allowed', [
			rt.new_string('capability_update_core'),
		])))))
		{
			var_caps.array_push('do_not_allow')
		} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& !(is_super_admin(var_user_id.clone())) {
			var_caps.array_push('do_not_allow')
		} else if rt.is_true(rt.identical(rt.new_string('upload_themes'), var_cap)) {
			var_caps.array_push('install_themes')
		} else if rt.is_true(rt.identical(rt.new_string('upload_plugins'), var_cap)) {
			var_caps.array_push('install_plugins')
		} else {
			var_caps.array_push(var_cap.clone())
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('install_languages')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('update_languages'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_file_mod_allowed', [
			rt.new_string('can_install_language_pack'),
		])))))
		{
			var_caps.array_push('do_not_allow')
		} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& !(is_super_admin(var_user_id.clone())) {
			var_caps.array_push('do_not_allow')
		} else {
			var_caps.array_push('install_languages')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('activate_plugins')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('deactivate_plugins')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('activate_plugin')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('deactivate_plugin'))) {
		var_caps.array_push('activate_plugins')
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_menu_perms = rt.call_function('get_site_option', [
				rt.new_string('menu_items'),
				rt.new_array(),
			])
			if !rt.is_true(var_menu_perms.array_get(rt.new_string('plugins'))) {
				var_caps.array_push('manage_network_plugins')
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('resume_plugin'))) {
		var_caps.array_push('resume_plugins')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('resume_theme'))) {
		var_caps.array_push('resume_themes')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_user')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_users'))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& !(is_super_admin(var_user_id.clone())) {
			var_caps.array_push('do_not_allow')
		} else {
			var_caps.array_push('delete_users')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('create_users'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
			var_caps.array_push(var_cap.clone())
		} else if is_super_admin(var_user_id.clone())
			|| rt.is_true(rt.call_function('get_site_option', [rt.new_string('add_new_users')])) {
			var_caps.array_push(var_cap.clone())
		} else {
			var_caps.array_push('do_not_allow')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('manage_links'))) {
		if rt.is_true(rt.call_function('get_option', [
			rt.new_string('link_manager_enabled'),
		]))
		{
			var_caps.array_push(var_cap.clone())
		} else {
			var_caps.array_push('do_not_allow')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('customize'))) {
		var_caps.array_push('edit_theme_options')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_site'))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_caps.array_push('manage_options')
		} else {
			var_caps.array_push('do_not_allow')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_term')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_term')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('assign_term'))) {
		if !(var_args.array_isset(rt.new_int(0))) {
			var_message = rt.call_function('__', [
				rt.new_string('When checking for the %s capability, you must always check it against a specific term.'),
			])
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [var_message.clone(),
					rt.new_string('<code>' + var_cap.str() + '</code>')]),
				rt.new_string('6.1.0')])
			var_caps.array_push('do_not_allow')
		}
		var_term_id = rt.new_int((var_args.array_get(rt.new_int(0))).to_i64())
		var_term = rt.call_function('get_term', [var_term_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_term))))
			|| rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
			var_caps.array_push('do_not_allow')
		}
		var_tax = rt.call_function('get_taxonomy', [
			rt.get_property(var_term, 'taxonomy'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_tax)))) {
			var_caps.array_push('do_not_allow')
		}
		if rt.is_true(rt.identical(rt.new_string('delete_term'), var_cap))
			&& rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('default_' + (rt.get_property(var_term, 'taxonomy')).str())])).to_i64()), rt.get_property(var_term, 'term_id')))
			|| rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('default_term_' + (rt.get_property(var_term, 'taxonomy')).str())])).to_i64()), rt.get_property(var_term, 'term_id'))) {
			var_caps.array_push('do_not_allow')
		}
		var_taxo_cap = rt.new_string(var_cap.str() + 's')
		var_caps = map_meta_cap(rt.get_property(rt.get_property(var_tax, 'cap'),
			'{"nodeType":"Expr_Variable","line":748,"name":"taxo_cap"}'), var_user_id.clone(),
			var_term_id.clone())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('manage_post_tags')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_categories')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_post_tags')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_categories')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_post_tags'))) {
		var_caps.array_push('manage_categories')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('assign_categories')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('assign_post_tags'))) {
		var_caps.array_push('edit_posts')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('create_sites')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_sites')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('manage_network')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('manage_sites')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('manage_network_users')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('manage_network_plugins')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('manage_network_themes')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('manage_network_options')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('upgrade_network'))) {
		var_caps.array_push(var_cap.clone())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('setup_network'))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_caps.array_push('manage_network_options')
		} else {
			var_caps.array_push('manage_options')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('update_php'))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& !(is_super_admin(var_user_id.clone())) {
			var_caps.array_push('do_not_allow')
		} else {
			var_caps.array_push('update_core')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('update_https'))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& !(is_super_admin(var_user_id.clone())) {
			var_caps.array_push('do_not_allow')
		} else {
			var_caps.array_push('manage_options')
			var_caps.array_push('update_core')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('export_others_personal_data')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('erase_others_personal_data')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('manage_privacy_options'))) {
		var_caps.array_push(if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			'manage_network'
		} else {
			'manage_options'
		})
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('create_app_password')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('list_app_passwords')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('read_app_password')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_app_password')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_app_passwords')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_app_password'))) {
		var_caps = map_meta_cap(rt.new_string('edit_user'), var_user_id.clone(),
			var_args.array_get(rt.new_int(0)))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit_block_binding'))) {
		var_block_editor_context = var_args.array_get(rt.new_int(0))
		if !(rt.get_property(var_block_editor_context, 'post')).is_null() {
			var_object_id = rt.get_property(rt.get_property(var_block_editor_context, 'post'), 'ID')
		}
		if !(!var_object_id.is_null()) {
			if !(!(rt.get_property(var_block_editor_context, 'name')).is_null())
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('core/edit-site'), rt.get_property(var_block_editor_context, 'name'))))) {
				var_caps.array_push('do_not_allow')
			}
			var_caps = map_meta_cap(rt.new_string('edit_theme_options'), var_user_id.clone())
		}
		var_object_subtype = rt.call_function('get_object_subtype', [
			rt.new_string('post'),
			rt.new_int(var_object_id.to_i64()),
		])
		if !rt.is_true(var_object_subtype) {
			var_caps.array_push('do_not_allow')
		}
		var_post_type_object = rt.call_function('get_post_type_object', [
			var_object_subtype.clone()])
		if !(!(rt.get_property(var_post_type_object, 'capabilities')).is_null()) {
			rt.set_property(var_post_type_object, 'capabilities', rt.new_array())
		}
		var_post_type_capabilities = rt.call_function('get_post_type_capabilities', [
			var_post_type_object.clone(),
		])
		var_caps = map_meta_cap(rt.get_property(var_post_type_capabilities, 'edit_post'),
			var_user_id.clone(), var_object_id.clone())
	} else {
		if var_post_type_meta_caps.array_isset(var_cap) {
			return map_meta_cap(var_post_type_meta_caps.array_get(var_cap), var_user_id.clone(),
				var_args.clone())
		}
		var_block_caps = rt.create_array([rt.ArrayItem{ key: none, val: 'edit_blocks' },
			rt.ArrayItem{ key: none, val: 'edit_others_blocks' },
			rt.ArrayItem{ key: none, val: 'publish_blocks' },
			rt.ArrayItem{ key: none, val: 'read_private_blocks' },
			rt.ArrayItem{ key: none, val: 'delete_blocks' }, rt.ArrayItem{
				key: none
				val: 'delete_private_blocks'
			}, rt.ArrayItem{ key: none, val: 'delete_published_blocks' },
			rt.ArrayItem{ key: none, val: 'delete_others_blocks' },
			rt.ArrayItem{ key: none, val: 'edit_private_blocks' },
			rt.ArrayItem{ key: none, val: 'edit_published_blocks' }])
		if rt.is_true(rt.call_function('in_array', [var_cap.clone(),
			var_block_caps.clone(), rt.new_bool(true)]))
		{
			var_cap = rt.call_function('str_replace', [rt.new_string('_blocks'),
				rt.new_string('_posts'), var_cap.clone()])
		}
		var_caps.array_push(var_cap.clone())
	}
	return rt.call_function('apply_filters', [rt.new_string('map_meta_cap'),
		var_caps.clone(), var_cap.clone(), var_user_id.clone(),
		var_args.clone()])
}

fn current_user_can(var_capability rt.PhpVal, var_args_origin ...rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array_from_list(var_args_origin)
	return user_can(rt.call_function('wp_get_current_user', []rt.PhpVal{}), var_capability.clone(),
		var_args.clone())
}

fn current_user_can_for_site(var_site_id rt.PhpVal, var_capability rt.PhpVal, var_args_origin ...rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_switched := rt.new_null()
	mut var_can := rt.new_null()
	var_switched = if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.call_function('switch_to_blog', [
			var_site_id.clone(),
		]) } else { rt.new_bool(false) }
	var_can = current_user_can(var_capability.clone(), var_args.clone())
	if rt.is_true(var_switched) {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
	return var_can.clone()
}

fn author_can(var_post_arg rt.PhpVal, var_capability rt.PhpVal, var_args_origin ...rt.PhpVal) bool {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_post := var_post_arg
	mut var_author := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	var_author = rt.call_function('get_userdata', [
		rt.get_property(var_post, 'post_author'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_author)))) {
		return false
	}
	return (rt.call_method(var_author, 'has_cap', [var_capability.clone(),
		var_args.clone()])).to_bool()
}

fn user_can(var_user_arg rt.PhpVal, var_capability rt.PhpVal, var_args_origin ...rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_user := var_user_arg
	if !(var_user.clone().is_object()) {
		var_user = rt.call_function('get_userdata', [var_user.clone()])
	}
	if !rt.is_true(var_user) {
		var_user = create_wp_user(rt.new_int(0))
		rt.call_method(var_user, 'init', [create_stdclass()])
	}
	return rt.call_method(var_user, 'has_cap', [var_capability.clone(),
		var_args.clone()])
}

fn user_can_for_site(var_user_arg rt.PhpVal, var_site_id rt.PhpVal, var_capability rt.PhpVal, var_args_origin ...rt.PhpVal) bool {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_user := var_user_arg
	mut var_switched := rt.new_null()
	mut var_can := rt.new_null()
	if !(var_user.clone().is_object()) {
		var_user = rt.call_function('get_userdata', [var_user.clone()])
	}
	if !rt.is_true(var_user) {
		var_user = create_wp_user(rt.new_int(0))
		rt.call_method(var_user, 'init', [create_stdclass()])
	}
	if !(var_site_id.clone().is_long() || var_site_id.clone().is_double())
		|| rt.is_true(rt.less_equal(var_site_id, rt.new_int(0))) {
		return false
	}
	var_switched = if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.call_function('switch_to_blog', [
			var_site_id.clone(),
		]) } else { rt.new_bool(false) }
	var_can = user_can(rt.get_property(var_user, 'ID'), var_capability.clone(), var_args.clone())
	if rt.is_true(var_switched) {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
	return var_can.to_bool()
}

fn wp_roles() rt.PhpVal {
	mut var_wp_roles := rt.new_null()
	if !(!var_wp_roles.is_null()) {
		var_wp_roles = create_wp_roles()
	}
	return mut var_wp_roles
}

fn get_role(var_role rt.PhpVal) rt.PhpVal {
	return rt.call_method(wp_roles(), 'get_role', [var_role.clone()])
}

fn add_role(var_role rt.PhpVal, var_display_name rt.PhpVal, var_capabilities rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_role) {
		return rt.new_null()
	}
	return rt.call_method(wp_roles(), 'add_role', [var_role.clone(),
		var_display_name.clone(), var_capabilities.clone()])
}

fn remove_role(var_role rt.PhpVal) {
	rt.call_method(wp_roles(), 'remove_role', [var_role.clone()])
}

fn get_super_admins() rt.PhpVal {
	mut var_super_admins := rt.new_null()
	if !var_super_admins.is_null() {
		return var_super_admins.clone()
	} else {
		return rt.call_function('get_site_option', [rt.new_string('site_admins'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'admin' }])])
	}
	return rt.new_null()
}

fn is_super_admin(user_id bool) bool {
	mut var_user_id := user_id
	mut var_user := rt.new_null()
	mut var_super_admins := rt.new_null()
	if !var_user_id {
		var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	} else {
		var_user = rt.call_function('get_userdata', [rt.new_bool(user_id)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))) {
		return false
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_super_admins = get_super_admins()
		if var_super_admins.clone().is_array()
			&& rt.is_true(rt.call_function('in_array', [rt.get_property(var_user, 'user_login'), var_super_admins.clone(), rt.new_bool(true)])) {
			return true
		}
	} else if rt.is_true(rt.call_method(var_user, 'has_cap', [
		rt.new_string('delete_users'),
	]))
	{
		return true
	}
	return false
}

fn grant_super_admin(var_user_id rt.PhpVal) bool {
	mut var_GLOBALS := rt.new_null()
	mut var_super_admins := rt.new_null()
	mut var_user := rt.new_null()
	if var_GLOBALS.array_isset(rt.new_string('super_admins'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return false
	}
	rt.call_function('do_action', [rt.new_string('grant_super_admin'),
		var_user_id.clone()])
	var_super_admins = rt.call_function('get_site_option', [rt.new_string('site_admins'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'admin' }])])
	var_user = rt.call_function('get_userdata', [var_user_id.clone()])
	if rt.is_true(var_user)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_user, 'user_login'), var_super_admins.clone(), rt.new_bool(true)]))))) {
		var_super_admins.array_push(rt.get_property(var_user, 'user_login'))
		rt.call_function('update_site_option', [rt.new_string('site_admins'),
			var_super_admins.clone()])
		rt.call_function('do_action', [rt.new_string('granted_super_admin'),
			var_user_id.clone()])
		return true
	}
	return false
}

fn revoke_super_admin(var_user_id rt.PhpVal) bool {
	mut var_GLOBALS := rt.new_null()
	mut var_super_admins := rt.new_null()
	mut var_user := rt.new_null()
	mut var_key := rt.new_null()
	if var_GLOBALS.array_isset(rt.new_string('super_admins'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return false
	}
	rt.call_function('do_action', [rt.new_string('revoke_super_admin'),
		var_user_id.clone()])
	var_super_admins = rt.call_function('get_site_option', [rt.new_string('site_admins'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'admin' }])])
	var_user = rt.call_function('get_userdata', [var_user_id.clone()])
	if rt.is_true(var_user) {
		var_key = rt.call_function('array_search', [
			rt.get_property(var_user, 'user_login'),
			var_super_admins.clone(),
			rt.new_bool(true),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_key)))) {
			var_super_admins.array_unset(var_key)
			rt.call_function('update_site_option', [rt.new_string('site_admins'),
				var_super_admins.clone()])
			rt.call_function('do_action', [rt.new_string('revoked_super_admin'),
				var_user_id.clone()])
			return true
		}
	}
	return false
}

fn wp_maybe_grant_install_languages_cap(var_allcaps rt.PhpVal) rt.PhpVal {
	if !(!(var_allcaps['update_core'])) || !(!(var_allcaps['install_plugins']))
		|| !(!(var_allcaps['install_themes'])) {
		var_allcaps['install_languages'] = true
	}
	return var_allcaps.clone()
}

fn wp_maybe_grant_resume_extensions_caps(var_allcaps rt.PhpVal) rt.PhpVal {
	if !(!(var_allcaps['activate_plugins'])) {
		var_allcaps['resume_plugins'] = true
	}
	if !(!(var_allcaps['switch_themes'])) {
		var_allcaps['resume_themes'] = true
	}
	return var_allcaps.clone()
}

fn wp_maybe_grant_site_health_caps(var_allcaps rt.PhpVal, var_caps rt.PhpVal, var_args rt.PhpVal, var_user rt.PhpVal) rt.PhpVal {
	if !(!(var_allcaps['install_plugins']))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		|| is_super_admin(rt.get_property(var_user, 'ID')) {
		var_allcaps['view_site_health_checks'] = true
	}
	return var_allcaps.clone()
}

struct Class_WP_User {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Roles {
	rt.PhpObjectBase
}

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
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

fn create_wp_roles(_args ...rt.PhpVal) &Class_WP_Roles {
	mut obj := &Class_WP_Roles{
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

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Roles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Roles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Roles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.new_null()
	rt.call_function('_x', [rt.new_string('Administrator'), rt.new_string('User role')])
	rt.call_function('_x', [rt.new_string('Editor'), rt.new_string('User role')])
	rt.call_function('_x', [rt.new_string('Author'), rt.new_string('User role')])
	rt.call_function('_x', [rt.new_string('Contributor'), rt.new_string('User role')])
	rt.call_function('_x', [rt.new_string('Subscriber'), rt.new_string('User role')])
}
