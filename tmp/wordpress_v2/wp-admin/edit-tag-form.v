import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_taxonomy := rt.new_null()
	mut var_tag := rt.new_null()
	mut var_tax := rt.new_null()
	mut var_tag_ID := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		fn () { print((rt.new_string('-1')).str()); exit(0) }()
	}
	if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
		rt.call_function('do_action_deprecated', [rt.new_string('edit_category_form_pre'), rt.create_array([rt.ArrayItem{ key: none, val: var_tag }]), rt.new_string('3.0.0'), rt.new_string('{$taxonomy}_pre_edit_form')])
	} else if rt.is_true(rt.identical(rt.new_string('link_category'), var_taxonomy)) {
		rt.call_function('do_action_deprecated', [rt.new_string('edit_link_category_form_pre'), rt.create_array([rt.ArrayItem{ key: none, val: var_tag }]), rt.new_string('3.0.0'), rt.new_string('{$taxonomy}_pre_edit_form')])
	} else {
		rt.call_function('do_action_deprecated', [rt.new_string('edit_tag_form_pre'), rt.create_array([rt.ArrayItem{ key: none, val: var_tag }]), rt.new_string('3.0.0'), rt.new_string('{$taxonomy}_pre_edit_form')])
	}
	mut var_wp_http_referer := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('wp_http_referer')))) { rt.call_function('sanitize_url', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('wp_http_referer'))]) } else { rt.new_string('') }
	var_wp_http_referer = rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'action' }, rt.ArrayItem{ key: none, val: 'message' }, rt.ArrayItem{ key: none, val: 'tag_ID' }]), var_wp_http_referer.clone()])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/edit-tag-messages.php', '4')
	rt.call_function('do_action', [rt.new_string("${var_taxonomy.to_string()}_pre_edit_form"), var_tag.clone(), var_taxonomy.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(rt.get_property(var_tax, 'labels'), 'edit_item'))
	// unsupported statement: Stmt_InlineHTML
	mut var_class := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('error')) { 'error' } else { 'success' }
	if rt.is_true(var_message) {
		mut var_message := rt.new_string('<p><strong>' + (var_message).str() + '</strong></p>')
		if rt.is_true(var_wp_http_referer) {
			var_message = rt.concat(var_message, rt.call_function('sprintf', [rt.new_string('<p><a href="%1$s">%2$s</a></p>'), rt.call_function('esc_url', [rt.call_function('wp_validate_redirect', [rt.call_function('sanitize_url', [var_wp_http_referer.clone()]), rt.call_function('admin_url', [rt.new_string('term.php?taxonomy=' + (var_taxonomy).str())])])]), rt.call_function('esc_html', [rt.get_property(rt.get_property(var_tax, 'labels'), 'back_to_items')])]))
		}
		rt.call_function('wp_admin_notice', [var_message.clone(), rt.create_array([rt.ArrayItem{ key: 'type', val: var_class }, rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string("${var_taxonomy.to_string()}_term_edit_form_tag")])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_tag_ID.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_taxonomy.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_original_referer_field', [rt.new_bool(true), rt.new_string('previous')])
	rt.call_function('wp_nonce_field', [rt.new_string('update-tag_' + (var_tag_ID).str())])
	rt.call_function('do_action', [rt.new_string("${var_taxonomy.to_string()}_term_edit_form_top"), var_tag.clone(), var_taxonomy.clone()])
	mut var_tag_name_value := rt.new_string('')
	if !(rt.get_property(var_tag, 'name')).is_null() {
	var_tag_name_value = rt.call_function('esc_attr', [rt.get_property(var_tag, 'name')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Name'), rt.new_string('term name')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tag_name_value)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(rt.get_property(var_tax, 'labels'), 'name_field_description'))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Slug')])
	// unsupported statement: Stmt_InlineHTML
	mut var_slug := if !(rt.get_property(var_tag, 'slug')).is_null() { rt.call_function('apply_filters', [rt.new_string('editable_slug'), rt.get_property(var_tag, 'slug'), var_tag.clone()]) } else { rt.new_string('') }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_slug.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(rt.get_property(var_tax, 'labels'), 'slug_field_description'))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy.clone()])) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.get_property(rt.get_property(var_tax, 'labels'), 'parent_item')]))
		// unsupported statement: Stmt_InlineHTML
		mut var_dropdown_args := rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: 0 }, rt.ArrayItem{ key: 'hide_if_empty', val: false }, rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'name', val: 'parent' }, rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'selected', val: rt.get_property(var_tag, 'parent') }, rt.ArrayItem{ key: 'exclude_tree', val: rt.get_property(var_tag, 'term_id') }, rt.ArrayItem{ key: 'hierarchical', val: true }, rt.ArrayItem{ key: 'show_option_none', val: rt.call_function('__', [rt.new_string('None')]) }, rt.ArrayItem{ key: 'aria_describedby', val: 'parent-description' }])
		var_dropdown_args = rt.call_function('apply_filters', [rt.new_string('taxonomy_parent_dropdown_args'), var_dropdown_args.clone(), var_taxonomy.clone(), rt.new_string('edit')])
		rt.call_function('wp_dropdown_categories', [var_dropdown_args.clone()])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Categories, unlike tags, can have a hierarchy. You might have a Jazz category, and under that have children categories for Bebop and Big Band. Totally optional.')])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.get_property(rt.get_property(var_tax, 'labels'), 'parent_field_description'))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Description')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(var_tag, 'description'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(rt.get_property(var_tax, 'labels'), 'desc_field_description'))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
		rt.call_function('do_action_deprecated', [rt.new_string('edit_category_form_fields'), rt.create_array([rt.ArrayItem{ key: none, val: var_tag }]), rt.new_string('3.0.0'), rt.new_string('{$taxonomy}_edit_form_fields')])
	} else if rt.is_true(rt.identical(rt.new_string('link_category'), var_taxonomy)) {
		rt.call_function('do_action_deprecated', [rt.new_string('edit_link_category_form_fields'), rt.create_array([rt.ArrayItem{ key: none, val: var_tag }]), rt.new_string('3.0.0'), rt.new_string('{$taxonomy}_edit_form_fields')])
	} else {
		rt.call_function('do_action_deprecated', [rt.new_string('edit_tag_form_fields'), rt.create_array([rt.ArrayItem{ key: none, val: var_tag }]), rt.new_string('3.0.0'), rt.new_string('{$taxonomy}_edit_form_fields')])
	}
	rt.call_function('do_action', [rt.new_string("${var_taxonomy.to_string()}_edit_form_fields"), var_tag.clone(), var_taxonomy.clone()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
		rt.call_function('do_action_deprecated', [rt.new_string('edit_category_form'), rt.create_array([rt.ArrayItem{ key: none, val: var_tag }]), rt.new_string('3.0.0'), rt.new_string('{$taxonomy}_add_form')])
	} else if rt.is_true(rt.identical(rt.new_string('link_category'), var_taxonomy)) {
		rt.call_function('do_action_deprecated', [rt.new_string('edit_link_category_form'), rt.create_array([rt.ArrayItem{ key: none, val: var_tag }]), rt.new_string('3.0.0'), rt.new_string('{$taxonomy}_add_form')])
	} else {
		rt.call_function('do_action_deprecated', [rt.new_string('edit_tag_form'), rt.create_array([rt.ArrayItem{ key: none, val: var_tag }]), rt.new_string('3.0.0'), rt.new_string('{$taxonomy}_edit_form')])
	}
	rt.call_function('do_action', [rt.new_string("${var_taxonomy.to_string()}_edit_form"), var_tag.clone(), var_taxonomy.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Update')]), rt.new_string('primary'), rt.new_null(), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_term'), rt.get_property(var_tag, 'term_id')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.call_function('wp_nonce_url', [rt.concat(rt.concat(rt.concat(rt.new_string('edit-tags.php?action=delete&taxonomy='), var_taxonomy), rt.new_string('&tag_ID=')), rt.get_property(var_tag, 'term_id')), rt.new_string('delete-tag_' + (rt.get_property(var_tag, 'term_id')).str())])])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Delete')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
	}
}
