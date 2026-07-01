import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_post_type := rt.new_null()
	mut var_post := rt.new_null()
	mut var_check_users := rt.new_null()
	mut var_is_IE := rt.new_null()
	mut var_title := rt.new_null()
	mut var_post_new_file := rt.new_null()
	mut var_active_post_lock := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_Global
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	rt.call_method(var_current_screen, 'is_block_editor', [rt.new_bool(false)])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_function('add_action', [rt.new_string('admin_footer'), rt.new_string('_admin_notice_post_locked')])
	} else {
		if rt.is_true(rt.greater(rt.call_function('get_user_count', []rt.PhpVal{}), rt.new_int(1))) {
			rt.call_function('add_action', [rt.new_string('admin_footer'), rt.new_string('_admin_notice_post_locked')])
		}
		var_check_users = rt.new_null()
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('post')])
	mut var__wp_editor_expand := false
	mut var__content_editor_dfw := false
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('post_type_supports', [var_post_type.dup(), rt.new_string('editor')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{}))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(var_is_IE) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/MSIE [5678]/'), rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT')]))))))))) {
		if rt.is_true(rt.call_function('apply_filters', [rt.new_string('wp_editor_expand'), rt.new_bool(true), var_post_type.dup()])) {
			rt.call_function('wp_enqueue_script', [rt.new_string('editor-expand')])
			var__content_editor_dfw = true
			var__wp_editor_expand = (rt.identical(rt.new_string('on'), rt.call_function('get_user_setting', [rt.new_string('editor_expand'), rt.new_string('on')]))).to_bool()
		}
	}
	if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
		rt.call_function('wp_enqueue_script', [rt.new_string('jquery-touch-punch')])
	}
	mut var_post_ID := if !(var_post_ID).is_null() { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	mut var_user_ID := if !(var_user_ID).is_null() { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	mut var_action := if !(var_action).is_null() { var_action } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Int, rt.get_property(var_post, 'ID'))) && !rt.is_true(rt.get_property(var_post, 'post_content')))) {
		rt.call_function('add_action', [rt.new_string('edit_form_after_title'), rt.new_string('_wp_posts_page_notice')])
		rt.call_function('remove_post_type_support', [var_post_type.dup(), rt.new_string('editor')])
	}
	mut var_thumbnail_support := rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), var_post_type.dup()])) && rt.is_true(rt.call_function('post_type_supports', [var_post_type.dup(), rt.new_string('thumbnail')]))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_thumbnail_support) && rt.is_true(rt.identical(rt.new_string('attachment'), var_post_type)))) && rt.is_true(rt.get_property(var_post, 'post_mime_type')))) {
		if rt.is_true(rt.call_function('wp_attachment_is', [rt.new_string('audio'), var_post.dup()])) {
			var_thumbnail_support = rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment:audio'), rt.new_string('thumbnail')])) || rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), rt.new_string('attachment:audio')]))
		} else if rt.is_true(rt.call_function('wp_attachment_is', [rt.new_string('video'), var_post.dup()])) {
			var_thumbnail_support = rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment:video'), rt.new_string('thumbnail')])) || rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), rt.new_string('attachment:video')]))
		}
	}
	if var_thumbnail_support {
		rt.call_function('add_thickbox', []rt.PhpVal{})
		rt.call_function('wp_enqueue_media', [rt.create_array([rt.ArrayItem{ key: 'post', val: rt.get_property(var_post, 'ID') }])])
	}
	rt.call_function('add_action', [rt.new_string('admin_footer'), rt.new_string('_local_storage_notice')])
	mut var_permalink := rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permalink)))) {
		var_permalink = rt.new_string(rt.new_string(''))
	}
	mut var_messages := rt.new_array()
	mut var_preview_post_link_html := rt.new_string(rt.new_string(''))
	mut var_scheduled_post_link_html := rt.new_string(rt.new_string(''))
	mut var_view_post_link_html := rt.new_string(rt.new_string(''))
	mut var_preview_page_link_html := rt.new_string(rt.new_string(''))
	mut var_scheduled_page_link_html := rt.new_string(rt.new_string(''))
	mut var_view_page_link_html := rt.new_string(rt.new_string(''))
	mut var_preview_url := rt.call_function('get_preview_post_link', [var_post.dup()])
	mut var_viewable := rt.call_function('is_post_type_viewable', [var_post_type_object.dup()])
	if rt.is_true(var_viewable) {
		var_preview_post_link_html = rt.call_function('sprintf', [rt.new_string(' <a target="_blank" href="%1$s">%2$s</a>'), rt.call_function('esc_url', [var_preview_url.dup()]), rt.call_function('__', [rt.new_string('Preview post')])])
		var_scheduled_post_link_html = rt.call_function('sprintf', [rt.new_string(' <a target="_blank" href="%1$s">%2$s</a>'), rt.call_function('esc_url', [var_permalink.dup()]), rt.call_function('__', [rt.new_string('Preview post')])])
		var_view_post_link_html = rt.call_function('sprintf', [rt.new_string(' <a href="%1$s">%2$s</a>'), rt.call_function('esc_url', [var_permalink.dup()]), rt.call_function('__', [rt.new_string('View post')])])
		var_preview_page_link_html = rt.call_function('sprintf', [rt.new_string(' <a target="_blank" href="%1$s">%2$s</a>'), rt.call_function('esc_url', [var_preview_url.dup()]), rt.call_function('__', [rt.new_string('Preview page')])])
		var_scheduled_page_link_html = rt.call_function('sprintf', [rt.new_string(' <a target="_blank" href="%1$s">%2$s</a>'), rt.call_function('esc_url', [var_permalink.dup()]), rt.call_function('__', [rt.new_string('Preview page')])])
		var_view_page_link_html = rt.call_function('sprintf', [rt.new_string(' <a href="%1$s">%2$s</a>'), rt.call_function('esc_url', [var_permalink.dup()]), rt.call_function('__', [rt.new_string('View page')])])
	}
	mut var_scheduled_date := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s at %2$s')]), rt.call_function('date_i18n', [rt.call_function('_x', [rt.new_string('M j, Y'), rt.new_string('publish box date format')]), rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])]), rt.call_function('date_i18n', [rt.call_function('_x', [rt.new_string('H:i'), rt.new_string('publish box time format')]), rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])])])
	var_messages.array_set('post', rt.create_array([rt.ArrayItem{ key: 0, val: '' }, rt.ArrayItem{ key: 1, val: (rt.call_function('__', [rt.new_string('Post updated.')])).str() + (var_view_post_link_html).str() }, rt.ArrayItem{ key: 2, val: rt.call_function('__', [rt.new_string('Custom field updated.')]) }, rt.ArrayItem{ key: 3, val: rt.call_function('__', [rt.new_string('Custom field deleted.')]) }, rt.ArrayItem{ key: 4, val: rt.call_function('__', [rt.new_string('Post updated.')]) }, rt.ArrayItem{ key: 5, val: if rt.get_superglobal('_GET').array_isset(rt.new_string('revision')) { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Post restored to revision from %s.')]), rt.call_function('wp_post_revision_title', [// unsupported expression: Expr_Cast_Int, rt.new_bool(false)])]) } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 6, val: (rt.call_function('__', [rt.new_string('Post published.')])).str() + (var_view_post_link_html).str() }, rt.ArrayItem{ key: 7, val: rt.call_function('__', [rt.new_string('Post saved.')]) }, rt.ArrayItem{ key: 8, val: (rt.call_function('__', [rt.new_string('Post submitted.')])).str() + (var_preview_post_link_html).str() }, rt.ArrayItem{ key: 9, val: (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Post scheduled for: %s.')]), '<strong>' + (var_scheduled_date).str() + '</strong>'])).str() + (var_scheduled_post_link_html).str() }, rt.ArrayItem{ key: 10, val: (rt.call_function('__', [rt.new_string('Post draft updated.')])).str() + (var_preview_post_link_html).str() }]))
	var_messages.array_set('page', rt.create_array([rt.ArrayItem{ key: 0, val: '' }, rt.ArrayItem{ key: 1, val: (rt.call_function('__', [rt.new_string('Page updated.')])).str() + (var_view_page_link_html).str() }, rt.ArrayItem{ key: 2, val: rt.call_function('__', [rt.new_string('Custom field updated.')]) }, rt.ArrayItem{ key: 3, val: rt.call_function('__', [rt.new_string('Custom field deleted.')]) }, rt.ArrayItem{ key: 4, val: rt.call_function('__', [rt.new_string('Page updated.')]) }, rt.ArrayItem{ key: 5, val: if rt.get_superglobal('_GET').array_isset(rt.new_string('revision')) { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Page restored to revision from %s.')]), rt.call_function('wp_post_revision_title', [// unsupported expression: Expr_Cast_Int, rt.new_bool(false)])]) } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 6, val: (rt.call_function('__', [rt.new_string('Page published.')])).str() + (var_view_page_link_html).str() }, rt.ArrayItem{ key: 7, val: rt.call_function('__', [rt.new_string('Page saved.')]) }, rt.ArrayItem{ key: 8, val: (rt.call_function('__', [rt.new_string('Page submitted.')])).str() + (var_preview_page_link_html).str() }, rt.ArrayItem{ key: 9, val: (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Page scheduled for: %s.')]), '<strong>' + (var_scheduled_date).str() + '</strong>'])).str() + (var_scheduled_page_link_html).str() }, rt.ArrayItem{ key: 10, val: (rt.call_function('__', [rt.new_string('Page draft updated.')])).str() + (var_preview_page_link_html).str() }]))
	var_messages.array_set('attachment', rt.call_function('array_fill', [rt.new_int(1), rt.new_int(10), rt.call_function('__', [rt.new_string('Media file updated.')])]))
	var_messages = rt.call_function('apply_filters', [rt.new_string('post_updated_messages'), var_messages.dup()])
	mut var_message := rt.new_bool(rt.new_bool(false))
	if rt.get_superglobal('_GET').array_isset(rt.new_string('message')) {
		rt.get_superglobal('_GET').array_set('message', rt.call_function('absint', [rt.get_superglobal('_GET').array_get('message')]))
		if var_messages.array_get(var_post_type).array_isset(rt.get_superglobal('_GET').array_get('message')) {
			var_message = var_messages.array_get(var_post_type).array_get(rt.get_superglobal('_GET').array_get('message'))
		} else if !(var_messages.array_isset(var_post_type)) && var_messages.array_get('post').array_isset(rt.get_superglobal('_GET').array_get('message')) {
			var_message = var_messages.array_get('post').array_get(rt.get_superglobal('_GET').array_get('message'))
		}
	}
	mut var_notice := rt.new_bool(rt.new_bool(false))
	mut var_form_extra := ''
	if rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post, 'post_status'))) {
		if rt.is_true(rt.identical(rt.new_string('edit'), var_action)) {
			rt.set_property(var_post, 'post_title', rt.new_string(''))
		}
		mut var_autosave := rt.new_bool(rt.new_bool(false))
		// unsupported expression: Expr_AssignOp_Concat
	} else {
		var_autosave = rt.call_function('wp_get_post_autosave', [rt.get_property(var_post, 'ID')])
	}
	mut var_form_action := 'editpost'
	mut var_nonce_action := rt.new_string('update-post_' + (rt.get_property(var_post, 'ID')).str())
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(rt.new_bool(rt.is_true(var_autosave) && rt.is_true(rt.greater(rt.call_function('mysql2date', [rt.new_string('U'), rt.get_property(var_autosave, 'post_modified_gmt'), rt.new_bool(false)]), rt.call_function('mysql2date', [rt.new_string('U'), rt.get_property(var_post, 'post_modified_gmt'), rt.new_bool(false)]))))) {
		{
			mut iter_1 := rt.call_function('_wp_post_revision_fields', [var_post.dup()]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var__autosave_field := item_1.val
				mut var_autosave_field := item_1.key
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_notice = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There is an autosave of this post that is more recent than the version below. <a href="%s">View the autosave</a>')]), rt.call_function('get_edit_post_link', [rt.get_property(var_autosave, 'ID')])])
					break
				}
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_notice)))) {
			rt.call_function('wp_delete_post_revision', [rt.get_property(var_autosave, 'ID')])
		}
		var_autosave_field = rt.new_null()
		var__autosave_field = rt.new_null()
	}
	mut var_post_type_object := rt.call_function('get_post_type_object', [var_post_type.dup()])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/meta-boxes.php', '4')
	rt.call_function('register_and_do_post_meta_boxes', [var_post.dup()])
	rt.call_function('add_screen_option', [rt.new_string('layout_columns'), rt.create_array([rt.ArrayItem{ key: 'max', val: 2 }, rt.ArrayItem{ key: 'default', val: 2 }])])
	if rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) {
		mut var_customize_display := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('The title field and the big Post Editing Area are fixed in place, but you can reposition all the other boxes using drag and drop. You can also minimize or expand them by clicking the title bar of each box. Use the Screen Options tab to unhide more boxes (Excerpt, Send Trackbacks, Custom Fields, Discussion, Slug, Author) or to choose a 1- or 2-column layout for this screen.')])).str() + '</p>')
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'customize-display' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Customizing This Display')]) }, rt.ArrayItem{ key: 'content', val: var_customize_display }])])
		mut var_title_and_editor := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('<strong>Title</strong> &mdash; Enter a title for your post. After you enter a title, you&#8217;ll see the permalink below, which you can edit.')])).str() + '</p>')
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'title-post-editor' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Title and Post Editor')]) }, rt.ArrayItem{ key: 'content', val: var_title_and_editor }])])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You can also create posts with the <a href="%s">Press This bookmarklet</a>.')]), rt.new_string('tools.php')])).str() + '</p>' + '<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/write-posts-classic-editor/">Documentation on Writing and Editing Posts</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	} else if rt.is_true(rt.identical(rt.new_string('page'), var_post_type)) {
		mut var_about_pages := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Pages are similar to posts in that they have a title, body text, and associated metadata, but they are different in that they are not part of the chronological blog stream, kind of like permanent posts. Pages are not categorized or tagged, but can have a hierarchy. You can nest pages under other pages by making one the &#8220;Parent&#8221; of the other, creating a group of pages.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Creating a Page is very similar to creating a Post, and the screens can be customized in the same way using drag and drop, the Screen Options tab, and expanding/collapsing boxes as you choose. This screen also has the distraction-free writing space, available in both the Visual and Code modes via the Fullscreen buttons. The Page editor mostly works the same as the Post editor, but there are some Page-specific features in the Page Attributes box.')])).str() + '</p>')
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'about-pages' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('About Pages')]) }, rt.ArrayItem{ key: 'content', val: var_about_pages }])])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/pages-add-new-screen/">Documentation on Adding New Pages</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/pages-screen/">Documentation on Editing Pages</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	} else if rt.is_true(rt.identical(rt.new_string('attachment'), var_post_type)) {
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('This screen allows you to edit fields for metadata in a file within the media library.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('For images only, you can click on Edit Image under the thumbnail to expand out an inline image editor with icons for cropping, rotating, or flipping the image as well as for undoing and redoing. The boxes on the right give you more options for scaling the image, for cropping it, and for cropping the thumbnail in a different way than you crop the original image. You can click on Help in those boxes to get more information.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Note that you crop the image by clicking on it (the Crop icon is already selected) and dragging the cropping frame to select the desired part. Then click Save to retain the cropping.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Remember to click Update to save metadata entered or changed.')])).str() + '</p>' }])])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/edit-media/">Documentation on Edit Media</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) || rt.is_true(rt.identical(rt.new_string('page'), var_post_type)))) {
		mut var_inserting_media := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('You can upload and insert media (images, audio, documents, etc.) by clicking the Add Media button. You can select from the images and files already uploaded to the Media Library, or upload new media to add to your page or post. To create an image gallery, select the images to add and click the &#8220;Create a new gallery&#8221; button.')])).str() + '</p>')
		// unsupported expression: Expr_AssignOp_Concat
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'inserting-media' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Inserting Media')]) }, rt.ArrayItem{ key: 'content', val: var_inserting_media }])])
	}
	if rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) {
		mut var_publish_box := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Several boxes on this screen contain settings for how your content will be published, including:')])).str() + '</p>')
		// unsupported expression: Expr_AssignOp_Concat
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-formats')])) && rt.is_true(rt.call_function('post_type_supports', [rt.new_string('post'), rt.new_string('post-formats')])))) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails')])) && rt.is_true(rt.call_function('post_type_supports', [rt.new_string('post'), rt.new_string('thumbnail')])))) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		// unsupported expression: Expr_AssignOp_Concat
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'publish-box' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Publish Settings')]) }, rt.ArrayItem{ key: 'content', val: var_publish_box }])])
		mut var_discussion_settings := rt.new_string('<p>' + (rt.call_function('__', [])).str() + '</p>')
		// unsupported expression: Expr_AssignOp_Concat
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }])])
	} else if rt.is_true(rt.identical(rt.new_string('page'), var_post_type)) {
		mut var_page_attributes := rt.new_string()
		
	}
	
}
