import rt

fn wp_image_editor(var_post_id rt.PhpVal, msg bool) {
	mut var_nonce := rt.call_function('wp_create_nonce', [rt.new_string("image_editor-${var_post_id.to_string()}")])
	mut var_meta := rt.call_function('wp_get_attachment_metadata', [var_post_id.dup()])
	mut var_thumb := rt.call_function('image_get_intermediate_size', [var_post_id.dup(), rt.new_string('thumbnail')])
	mut var_sub_sizes := var_meta.array_isset(rt.new_string('sizes')) && rt.is_true(rt.new_bool(var_meta.array_get('sizes').is_array()))
	mut var_note := ''
	if var_meta.array_isset(rt.new_string('width')) && var_meta.array_isset(rt.new_string('height')) {
		mut var_big := rt.call_function('max', [var_meta.array_get('width'), var_meta.array_get('height')])
	} else {
		// unsupported expression: Expr_Exit
	}
	mut var_sizer := if rt.is_true(rt.greater(var_big, rt.new_int(600))) { rt.div(rt.new_int(600), var_big) } else { rt.new_int(1) }
	mut var_backup_sizes := rt.call_function('get_post_meta', [var_post_id.dup(), rt.new_string('_wp_attachment_backup_sizes'), rt.new_bool(true)])
	mut var_can_restore := rt.new_bool(rt.new_bool(false))
	if !(!rt.is_true(var_backup_sizes)) && var_backup_sizes.array_isset(rt.new_string('full-orig')) && var_meta.array_isset(rt.new_string('file')) {
		var_can_restore = // unsupported expression: Expr_BinaryOp_NotIdentical
	}
	if var_msg {
		if !(rt.get_property(rt.new_bool(msg), 'error')).is_null() {
			var_note = rt.concat(rt.concat(rt.new_string('<div class=\'notice notice-error\' role=\'alert\'><p>'), rt.get_property(rt.new_bool(msg), 'error')), rt.new_string('</p></div>'))
		} else if !(rt.get_property(rt.new_bool(msg), 'msg')).is_null() {
			var_note = rt.concat(rt.concat(rt.new_string('<div class=\'notice notice-success\' role=\'alert\'><p>'), rt.get_property(rt.new_bool(msg), 'msg')), rt.new_string('</p></div>'))
		}
	}
	mut var_edit_thumbnails_separately := // unsupported expression: Expr_Cast_Bool
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	print(var_note)
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Crop')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Scale'), rt.new_string('verb')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Image Rotation')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wp_image_editor_supports', [rt.create_array([rt.ArrayItem{ key: 'mime_type', val: rt.call_function('get_post_mime_type', [var_post_id.dup()]) }, rt.ArrayItem{ key: 'methods', val: rt.create_array([rt.ArrayItem{ key: none, val: 'rotate' }]) }])])) {
		mut var_note_no_rotate := rt.new_string(rt.new_string(''))
		// unsupported statement: Stmt_InlineHTML
		print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Rotate 90&deg; left')])
		// unsupported statement: Stmt_InlineHTML
		print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Rotate 90&deg; right')])
		// unsupported statement: Stmt_InlineHTML
		print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Rotate 180&deg;')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		var_note_no_rotate = rt.new_string('<p class="note-no-rotate"><em>' + (rt.call_function('__', [rt.new_string('Image rotation is not supported by your web host.')])).str() + '</em></p>')
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Flip vertical')])
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Flip horizontal')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_note_no_rotate)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Undo')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Redo')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Cancel Editing')])
	// unsupported statement: Stmt_InlineHTML
	print("${var_post_id.to_string()}, '${var_nonce.to_string()}'")
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Save Edits')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_nonce)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_sizer)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(var_meta.array_get('width')).is_null() { var_meta.array_get('width') } else { rt.new_int(0) })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(var_meta.array_get('height')).is_null() { var_meta.array_get('height') } else { rt.new_int(0) })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val()
}



pub fn init_wp_admin_includes_image_edit_php() {
}
