import rt

fn post_submit_meta_box(var_post rt.PhpVal, var_args rt.PhpVal) {
	mut var_action := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_post_id := // unsupported expression: Expr_Cast_Int
	mut var_post_type := rt.get_property(var_post, 'post_type')
	mut var_post_type_object := rt.call_function('get_post_type_object', [var_post_type.dup()])
	mut var_can_publish := rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'publish_posts')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Save')]), rt.new_string(''), rt.new_string('save')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_status'), rt.create_array([rt.ArrayItem{ key: none, val: 'publish' }, rt.ArrayItem{ key: none, val: 'future' }, rt.ArrayItem{ key: none, val: 'pending' }]), rt.new_bool(true)]))))) {
		mut var_private_style := ''
		if rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(var_post, 'post_status'))) {
			var_private_style = 'style="display:none"'
		}
		// unsupported statement: Stmt_InlineHTML
		print(var_private_style)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Save Draft')])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('pending'), rt.get_property(var_post, 'post_status'))) && rt.is_true(var_can_publish))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Save as Pending')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_post_type_viewable', [var_post_type_object.dup()])) {
		// unsupported statement: Stmt_InlineHTML
		mut var_preview_link := rt.call_function('esc_url', [rt.call_function('get_preview_post_link', [var_post.dup()])])
		if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post, 'post_status'))) {
			mut var_preview_button_text := rt.call_function('__', [rt.new_string('Preview Changes')])
		} else {
			var_preview_button_text = rt.call_function('_x', [rt.new_string('Preview'), rt.new_string('verb')])
		}
		mut var_preview_button := rt.call_function('sprintf', [rt.new_string('%1$s<span class="screen-reader-text"> %2$s</span>'), var_preview_button_text.dup(), rt.call_function('__', [rt.new_string('(opens in a new tab)')])])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_preview_link)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_post_id)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_preview_button)
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('do_action', [rt.new_string('post_submitbox_minor_actions'), var_post.dup()])
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
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('draft'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('auto-draft'))) {
		rt.call_function('_e', [rt.new_string('Draft')])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post, 'post_status'))) || rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(var_post, 'post_status'))))) || rt.is_true(var_can_publish))) {
		var_private_style = ''
		if rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(var_post, 'post_status'))) {
			var_private_style = 'style="display:none"'
		}
		// unsupported statement: Stmt_InlineHTML
		print(var_private_style)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Edit')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Edit status')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post, 'post_status'))) { rt.new_string('draft') } else { rt.get_property(var_post, 'post_status') }]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Set status')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post, 'post_status'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [rt.get_property(var_post, 'post_status'), rt.new_string('publish')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Published')])
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(var_post, 'post_status'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [rt.get_property(var_post, 'post_status'), rt.new_string('private')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Privately Published')])
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.identical(rt.new_string('future'), rt.get_property(var_post, 'post_status'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [rt.get_property(var_post, 'post_status'), rt.new_string('future')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Scheduled')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [rt.get_property(var_post, 'post_status'), rt.new_string('pending')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Pending Review')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post, 'post_status'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [rt.get_property(var_post, 'post_status'), rt.new_string('auto-draft')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Draft')])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [rt.get_property(var_post, 'post_status'), rt.new_string('draft')])
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
		mut var_visibility := 
		
	} else if !(!rt.is_true()) {
	} else if rt.is_true() {
	} else {
	}
	rt.echo_val()
}



pub fn init_wp_admin_includes_meta_boxes_php() {
}
