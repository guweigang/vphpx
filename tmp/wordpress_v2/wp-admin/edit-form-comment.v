import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_comment := rt.new_null()
	mut var_action := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [
		rt.new_string('update-comment_' + (rt.get_property(var_comment, 'comment_ID')).str()),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Edit Comment')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_comment, 'comment_ID')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(var_comment, 'comment_post_ID'),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('approved'), rt.call_function('wp_get_comment_status', [var_comment.clone()])))
		&& rt.is_true(rt.greater(rt.get_property(var_comment, 'comment_post_ID'), rt.new_int(0))) {
		mut var_comment_link := rt.call_function('get_comment_link', [
			var_comment.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_ex', [rt.new_string('Permalink:'),
			rt.new_string('comment')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_comment_link.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_comment_link.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Author')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Comment Author')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Name')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(var_comment, 'comment_author'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Email')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(var_comment, 'comment_author_email'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.get_property(var_comment, 'comment_author_url'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Comment')])
	// unsupported statement: Stmt_InlineHTML
	mut var_quicktags_settings := {
		'buttons': 'strong,em,link,block,del,ins,img,ul,ol,li,code,close'
	}
	rt.call_function('wp_editor', [rt.get_property(var_comment, 'comment_content'),
		rt.new_string('content'),
		rt.create_array([
			rt.ArrayItem{ key: 'media_buttons', val: false },
			rt.ArrayItem{ key: 'tinymce', val: false },
			rt.ArrayItem{ key: 'quicktags', val: var_quicktags_settings },
		])])
	rt.call_function('wp_nonce_field', [rt.new_string('closedpostboxes'),
		rt.new_string('closedpostboxesnonce'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Save')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Status:')])
	// unsupported statement: Stmt_InlineHTML
	mut switch_val_1 := rt.get_property(var_comment, 'comment_approved')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('1'))) {
		rt.call_function('_e', [rt.new_string('Approved')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('0'))) {
		rt.call_function('_e', [rt.new_string('Pending')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('spam'))) {
		rt.call_function('_e', [rt.new_string('Spam')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Comment status')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.get_property(var_comment, 'comment_approved'),
		rt.new_string('1')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Approved'), rt.new_string('comment status')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.get_property(var_comment, 'comment_approved'),
		rt.new_string('0')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Pending'), rt.new_string('comment status')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.get_property(var_comment, 'comment_approved'),
		rt.new_string('spam')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Spam'), rt.new_string('comment status')])
	// unsupported statement: Stmt_InlineHTML
	mut var_submitted := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%1$s at %2$s')]),
		rt.call_function('date_i18n', [
			rt.call_function('_x',
				[rt.new_string('M j, Y'), rt.new_string('publish box date format')]),
			rt.call_function('strtotime', [rt.get_property(var_comment, 'comment_date')]),
		]),
		rt.call_function('date_i18n', [
			rt.call_function('_x', [rt.new_string('H:i'), rt.new_string('publish box time format')]),
			rt.call_function('strtotime', [rt.get_property(var_comment, 'comment_date')]),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Submitted on: %s')]),
		rt.new_string('<b>' + var_submitted.str() + '</b>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Edit')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Edit date and time')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Date and time')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('touch_time', [
		rt.identical(rt.new_string('editcomment'), var_action),
		rt.new_int(0),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_post_id := rt.get_property(var_comment, 'comment_post_ID')
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'),
		var_post_id.clone()]))
	{
		mut var_post_link := rt.new_string("<a href='" +
			(rt.call_function('esc_url', [rt.call_function('get_edit_post_link', [var_post_id.clone()])])).str() +
			"'>")
		var_post_link = rt.concat(var_post_link, rt.new_string(
			(rt.call_function('esc_html', [rt.call_function('get_the_title', [var_post_id.clone()])])).str() +
			'</a>'))
	} else {
		var_post_link = rt.call_function('esc_html', [
			rt.call_function('get_the_title', [var_post_id.clone()]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('In response to: %s')]),
		rt.new_string('<b>' + var_post_link.str() + '</b>'),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.get_property(var_comment, 'comment_parent')) {
		mut var_parent := rt.call_function('get_comment', [
			rt.get_property(var_comment, 'comment_parent'),
		])
		if rt.is_true(var_parent) {
			mut var_parent_link := rt.call_function('esc_url', [
				rt.call_function('get_comment_link', [var_parent.clone()]),
			])
			mut var_name := rt.call_function('get_comment_author', [
				var_parent.clone()])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('In reply to: %s')]),
				rt.new_string('<b><a href="' + var_parent_link.str() + '">' + var_name.str() +
					'</a></b>'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('edit_comment_misc_actions'),
		rt.new_string(''),
		var_comment.clone(),
	]))
	// unsupported statement: Stmt_InlineHTML
	print("<a class='submitdelete deletion' href='" +
		(rt.call_function('wp_nonce_url', [rt.new_string('comment.php?action=' + if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) { 'deletecomment' } else { 'trashcomment' } +
		rt.concat(rt.concat(rt.new_string('&amp;c='), rt.get_property(var_comment, 'comment_ID')), rt.new_string('&amp;_wp_original_http_referer=')) +
		(rt.call_function('urlencode', [rt.call_function('wp_get_referer', []rt.PhpVal{})])).str()), rt.new_string('delete-comment_' + (rt.get_property(var_comment, 'comment_ID')).str())])).str() +
		"'>" +
		(if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) { rt.call_function('__', [rt.new_string('Delete Permanently')]) } else { rt.call_function('__', [rt.new_string('Move to Trash')]) }).str() +
		'</a>\n')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [
		rt.new_string('Update')]),
		rt.new_string('primary large'), rt.new_string('save'),
		rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('add_meta_boxes'),
		rt.new_string('comment'), var_comment.clone()])
	rt.call_function('do_action', [rt.new_string('add_meta_boxes_comment'),
		var_comment.clone()])
	rt.call_function('do_meta_boxes', [rt.new_null(), rt.new_string('normal'),
		var_comment.clone()])
	mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_comment, 'comment_ID')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(var_comment, 'comment_post_ID'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(var_referer) { rt.call_function('esc_url', [
			var_referer.clone()]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_original_referer_field', [rt.new_bool(true),
		rt.new_string('previous')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
	}
}
