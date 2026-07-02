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
		fn () { print((rt.new_string('-1')).str()); exit(0) }()
	}
	mut var_post_type_object := rt.get_superglobal('post_type_object')
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
	if rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('editor')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{}))))) && !(rt.is_true(var_is_IE) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/MSIE [5678]/'), rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT'))]))) {
		if rt.is_true(rt.call_function('apply_filters', [rt.new_string('wp_editor_expand'), rt.new_bool(true), var_post_type.clone()])) {
			rt.call_function('wp_enqueue_script', [rt.new_string('editor-expand')])
		var__content_editor_dfw = true
		var__wp_editor_expand = (rt.identical(rt.new_string('on'), rt.call_function('get_user_setting', [rt.new_string('editor_expand'), rt.new_string('on')]))).to_bool()
		}
	}
	if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
		rt.call_function('wp_enqueue_script', [rt.new_string('jquery-touch-punch')])
	}
	mut var_post_ID := rt.new_int(if !(var_post_ID).is_null() { rt.new_int((var_post_ID).to_i64()) } else { 0 })
	mut var_user_ID := rt.new_int(if !(var_user_ID).is_null() { rt.new_int((var_user_ID).to_i64()) } else { 0 })
	mut var_action := if !(var_action).is_null() { var_action } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('page_for_posts')])).to_i64()), rt.get_property(var_post, 'ID'))) && !rt.is_true(rt.get_property(var_post, 'post_content')) {
		rt.call_function('add_action', [rt.new_string('edit_form_after_title'), rt.new_string('_wp_posts_page_notice')])
		rt.call_function('remove_post_type_support', [var_post_type.clone(), rt.new_string('editor')])
	}
	mut var_thumbnail_support := rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), var_post_type.clone()])) && rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('thumbnail')]))
	if !(var_thumbnail_support) && rt.is_true(rt.identical(rt.new_string('attachment'), var_post_type)) && rt.is_true(rt.get_property(var_post, 'post_mime_type')) {
		if rt.is_true(rt.call_function('wp_attachment_is', [rt.new_string('audio'), var_post.clone()])) {
		var_thumbnail_support = rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment:audio'), rt.new_string('thumbnail')])) || rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails'), rt.new_string('attachment:audio')]))
		} else if rt.is_true(rt.call_function('wp_attachment_is', [rt.new_string('video'), var_post.clone()])) {
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
	var_permalink = rt.new_string('')
	}
	mut var_messages := rt.new_array()
	mut var_preview_post_link_html := rt.new_string('')
	mut var_scheduled_post_link_html := rt.new_string('')
	mut var_view_post_link_html := rt.new_string('')
	mut var_preview_page_link_html := rt.new_string('')
	mut var_scheduled_page_link_html := rt.new_string('')
	mut var_view_page_link_html := rt.new_string('')
	mut var_preview_url := rt.call_function('get_preview_post_link', [var_post.clone()])
	mut var_viewable := rt.call_function('is_post_type_viewable', [var_post_type_object.clone()])
	if rt.is_true(var_viewable) {
	var_preview_post_link_html = rt.call_function('sprintf', [rt.new_string(' <a target="_blank" href="%1$s">%2$s</a>'), rt.call_function('esc_url', [var_preview_url.clone()]), rt.call_function('__', [rt.new_string('Preview post')])])
	var_scheduled_post_link_html = rt.call_function('sprintf', [rt.new_string(' <a target="_blank" href="%1$s">%2$s</a>'), rt.call_function('esc_url', [var_permalink.clone()]), rt.call_function('__', [rt.new_string('Preview post')])])
	var_view_post_link_html = rt.call_function('sprintf', [rt.new_string(' <a href="%1$s">%2$s</a>'), rt.call_function('esc_url', [var_permalink.clone()]), rt.call_function('__', [rt.new_string('View post')])])
	var_preview_page_link_html = rt.call_function('sprintf', [rt.new_string(' <a target="_blank" href="%1$s">%2$s</a>'), rt.call_function('esc_url', [var_preview_url.clone()]), rt.call_function('__', [rt.new_string('Preview page')])])
	var_scheduled_page_link_html = rt.call_function('sprintf', [rt.new_string(' <a target="_blank" href="%1$s">%2$s</a>'), rt.call_function('esc_url', [var_permalink.clone()]), rt.call_function('__', [rt.new_string('Preview page')])])
	var_view_page_link_html = rt.call_function('sprintf', [rt.new_string(' <a href="%1$s">%2$s</a>'), rt.call_function('esc_url', [var_permalink.clone()]), rt.call_function('__', [rt.new_string('View page')])])
	}
	mut var_scheduled_date := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s at %2$s')]), rt.call_function('date_i18n', [rt.call_function('_x', [rt.new_string('M j, Y'), rt.new_string('publish box date format')]), rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])]), rt.call_function('date_i18n', [rt.call_function('_x', [rt.new_string('H:i'), rt.new_string('publish box time format')]), rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])])])
	var_messages.array_set('post', rt.create_array([rt.ArrayItem{ key: 0, val: '' }, rt.ArrayItem{ key: 1, val: (rt.call_function('__', [rt.new_string('Post updated.')])).str() + (var_view_post_link_html).str() }, rt.ArrayItem{ key: 2, val: rt.call_function('__', [rt.new_string('Custom field updated.')]) }, rt.ArrayItem{ key: 3, val: rt.call_function('__', [rt.new_string('Custom field deleted.')]) }, rt.ArrayItem{ key: 4, val: rt.call_function('__', [rt.new_string('Post updated.')]) }, rt.ArrayItem{ key: 5, val: if rt.get_superglobal('_GET').array_isset(rt.new_string('revision')) { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Post restored to revision from %s.')]), rt.call_function('wp_post_revision_title', [rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('revision'))).to_i64()), rt.new_bool(false)])]) } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 6, val: (rt.call_function('__', [rt.new_string('Post published.')])).str() + (var_view_post_link_html).str() }, rt.ArrayItem{ key: 7, val: rt.call_function('__', [rt.new_string('Post saved.')]) }, rt.ArrayItem{ key: 8, val: (rt.call_function('__', [rt.new_string('Post submitted.')])).str() + (var_preview_post_link_html).str() }, rt.ArrayItem{ key: 9, val: (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Post scheduled for: %s.')]), rt.new_string('<strong>' + (var_scheduled_date).str() + '</strong>')])).str() + (var_scheduled_post_link_html).str() }, rt.ArrayItem{ key: 10, val: (rt.call_function('__', [rt.new_string('Post draft updated.')])).str() + (var_preview_post_link_html).str() }]))
	var_messages.array_set('page', rt.create_array([rt.ArrayItem{ key: 0, val: '' }, rt.ArrayItem{ key: 1, val: (rt.call_function('__', [rt.new_string('Page updated.')])).str() + (var_view_page_link_html).str() }, rt.ArrayItem{ key: 2, val: rt.call_function('__', [rt.new_string('Custom field updated.')]) }, rt.ArrayItem{ key: 3, val: rt.call_function('__', [rt.new_string('Custom field deleted.')]) }, rt.ArrayItem{ key: 4, val: rt.call_function('__', [rt.new_string('Page updated.')]) }, rt.ArrayItem{ key: 5, val: if rt.get_superglobal('_GET').array_isset(rt.new_string('revision')) { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Page restored to revision from %s.')]), rt.call_function('wp_post_revision_title', [rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('revision'))).to_i64()), rt.new_bool(false)])]) } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 6, val: (rt.call_function('__', [rt.new_string('Page published.')])).str() + (var_view_page_link_html).str() }, rt.ArrayItem{ key: 7, val: rt.call_function('__', [rt.new_string('Page saved.')]) }, rt.ArrayItem{ key: 8, val: (rt.call_function('__', [rt.new_string('Page submitted.')])).str() + (var_preview_page_link_html).str() }, rt.ArrayItem{ key: 9, val: (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Page scheduled for: %s.')]), rt.new_string('<strong>' + (var_scheduled_date).str() + '</strong>')])).str() + (var_scheduled_page_link_html).str() }, rt.ArrayItem{ key: 10, val: (rt.call_function('__', [rt.new_string('Page draft updated.')])).str() + (var_preview_page_link_html).str() }]))
	var_messages.array_set('attachment', rt.call_function('array_fill', [rt.new_int(1), rt.new_int(10), rt.call_function('__', [rt.new_string('Media file updated.')])]))
	var_messages = rt.call_function('apply_filters', [rt.new_string('post_updated_messages'), var_messages.clone()])
	mut var_message := rt.new_bool(false)
	if rt.get_superglobal('_GET').array_isset(rt.new_string('message')) {
		rt.get_superglobal('_GET').array_set('message', rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('message'))]))
		if var_messages.array_get(var_post_type).array_isset(rt.get_superglobal('_GET').array_get(rt.new_string('message'))) {
		var_message = var_messages.array_get(var_post_type).array_get(rt.get_superglobal('_GET').array_get(rt.new_string('message')))
		} else if !(var_messages.array_isset(var_post_type)) && var_messages.array_get(rt.new_string('post')).array_isset(rt.get_superglobal('_GET').array_get(rt.new_string('message'))) {
		var_message = var_messages.array_get(rt.new_string('post')).array_get(rt.get_superglobal('_GET').array_get(rt.new_string('message')))
		}
	}
	mut var_notice := rt.new_bool(false)
	mut var_form_extra := ''
	if rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post, 'post_status'))) {
		if rt.is_true(rt.identical(rt.new_string('edit'), var_action)) {
			rt.set_property(var_post, 'post_title', rt.new_string(''))
		}
		mut var_autosave := rt.new_bool(false)
		var_form_extra = var_form_extra + '<input type=\'hidden\' id=\'auto_draft\' name=\'auto_draft\' value=\'1\' />'
	} else {
	var_autosave = rt.call_function('wp_get_post_autosave', [rt.get_property(var_post, 'ID')])
	}
	mut var_form_action := 'editpost'
	mut var_nonce_action := rt.new_string('update-post_' + (rt.get_property(var_post, 'ID')).str())
	var_form_extra = var_form_extra + '<input type=\'hidden\' id=\'post_ID\' name=\'post_ID\' value=\'' + (rt.call_function('esc_attr', [rt.get_property(var_post, 'ID')])).str() + '\' />'
	if rt.is_true(var_autosave) && rt.is_true(rt.greater(rt.call_function('mysql2date', [rt.new_string('U'), rt.get_property(var_autosave, 'post_modified_gmt'), rt.new_bool(false)]), rt.call_function('mysql2date', [rt.new_string('U'), rt.get_property(var_post, 'post_modified_gmt'), rt.new_bool(false)]))) {
		mut iter_1 := rt.call_function('_wp_post_revision_fields', [var_post.clone()]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var__autosave_field := item_1.val
			mut var_autosave_field := item_1.key
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('normalize_whitespace', [rt.get_property(var_autosave, '{"nodeType":"Expr_Variable","line":243,"name":"autosave_field"}')]), rt.call_function('normalize_whitespace', [rt.get_property(var_post, '{"nodeType":"Expr_Variable","line":243,"name":"autosave_field"}')]))))) {
				var_notice = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There is an autosave of this post that is more recent than the version below. <a href="%s">View the autosave</a>')]), rt.call_function('get_edit_post_link', [rt.get_property(var_autosave, 'ID')])])
				break
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_notice)))) {
			rt.call_function('wp_delete_post_revision', [rt.get_property(var_autosave, 'ID')])
		}
		var_autosave_field = rt.new_null()
		var__autosave_field = rt.new_null()
	}
	var_post_type_object = rt.call_function('get_post_type_object', [var_post_type.clone()])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/meta-boxes.php', '4')
	rt.call_function('register_and_do_post_meta_boxes', [var_post.clone()])
	rt.call_function('add_screen_option', [rt.new_string('layout_columns'), rt.create_array([rt.ArrayItem{ key: 'max', val: 2 }, rt.ArrayItem{ key: 'default', val: 2 }])])
	if rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) {
		mut var_customize_display := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('The title field and the big Post Editing Area are fixed in place, but you can reposition all the other boxes using drag and drop. You can also minimize or expand them by clicking the title bar of each box. Use the Screen Options tab to unhide more boxes (Excerpt, Send Trackbacks, Custom Fields, Discussion, Slug, Author) or to choose a 1- or 2-column layout for this screen.')])).str() + '</p>')
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'customize-display' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Customizing This Display')]) }, rt.ArrayItem{ key: 'content', val: var_customize_display }])])
		mut var_title_and_editor := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('<strong>Title</strong> &mdash; Enter a title for your post. After you enter a title, you&#8217;ll see the permalink below, which you can edit.')])).str() + '</p>')
		var_title_and_editor = rt.concat(var_title_and_editor, rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('<strong>Post editor</strong> &mdash; Enter the text for your post. There are two modes of editing: Visual and Code. Choose the mode by clicking on the appropriate tab.')])).str() + '</p>'))
		var_title_and_editor = rt.concat(var_title_and_editor, rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Visual mode gives you an editor that is similar to a word processor. Click the Toolbar Toggle button to get a second row of controls.')])).str() + '</p>'))
		var_title_and_editor = rt.concat(var_title_and_editor, rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('The Code mode allows you to enter HTML along with your post text. Note that &lt;p&gt; and &lt;br&gt; tags are converted to line breaks when switching to the Code editor to make it less cluttered. When you type, a single line break can be used instead of typing &lt;br&gt;, and two line breaks instead of paragraph tags. The line breaks are converted back to tags automatically.')])).str() + '</p>'))
		var_title_and_editor = rt.concat(var_title_and_editor, rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('You can insert media files by clicking the button above the post editor and following the directions. You can align or edit images using the inline formatting toolbar available in Visual mode.')])).str() + '</p>'))
		var_title_and_editor = rt.concat(var_title_and_editor, rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('You can enable distraction-free writing mode using the icon to the right. This feature is not available for old browsers or devices with small screens, and requires that the full-height editor be enabled in Screen Options.')])).str() + '</p>'))
		var_title_and_editor = rt.concat(var_title_and_editor, rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Keyboard users: When you are working in the visual editor, you can use %s to access the toolbar.')]), rt.new_string('<kbd>Alt + F10</kbd>')])).str() + '</p>'))
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'title-post-editor' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Title and Post Editor')]) }, rt.ArrayItem{ key: 'content', val: var_title_and_editor }])])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You can also create posts with the <a href="%s">Press This bookmarklet</a>.')]), rt.new_string('tools.php')])).str() + '</p>' + '<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/write-posts-classic-editor/">Documentation on Writing and Editing Posts</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>')])
	} else if rt.is_true(rt.identical(rt.new_string('page'), var_post_type)) {
		mut var_about_pages := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Pages are similar to posts in that they have a title, body text, and associated metadata, but they are different in that they are not part of the chronological blog stream, kind of like permanent posts. Pages are not categorized or tagged, but can have a hierarchy. You can nest pages under other pages by making one the &#8220;Parent&#8221; of the other, creating a group of pages.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Creating a Page is very similar to creating a Post, and the screens can be customized in the same way using drag and drop, the Screen Options tab, and expanding/collapsing boxes as you choose. This screen also has the distraction-free writing space, available in both the Visual and Code modes via the Fullscreen buttons. The Page editor mostly works the same as the Post editor, but there are some Page-specific features in the Page Attributes box.')])).str() + '</p>')
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'about-pages' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('About Pages')]) }, rt.ArrayItem{ key: 'content', val: var_about_pages }])])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [rt.new_string('<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/pages-add-new-screen/">Documentation on Adding New Pages</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/pages-screen/">Documentation on Editing Pages</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>')])
	} else if rt.is_true(rt.identical(rt.new_string('attachment'), var_post_type)) {
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('This screen allows you to edit fields for metadata in a file within the media library.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('For images only, you can click on Edit Image under the thumbnail to expand out an inline image editor with icons for cropping, rotating, or flipping the image as well as for undoing and redoing. The boxes on the right give you more options for scaling the image, for cropping it, and for cropping the thumbnail in a different way than you crop the original image. You can click on Help in those boxes to get more information.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Note that you crop the image by clicking on it (the Crop icon is already selected) and dragging the cropping frame to select the desired part. Then click Save to retain the cropping.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Remember to click Update to save metadata entered or changed.')])).str() + '</p>' }])])
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [rt.new_string('<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/edit-media/">Documentation on Edit Media</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>')])
	}
	if rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) || rt.is_true(rt.identical(rt.new_string('page'), var_post_type)) {
		mut var_inserting_media := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('You can upload and insert media (images, audio, documents, etc.) by clicking the Add Media button. You can select from the images and files already uploaded to the Media Library, or upload new media to add to your page or post. To create an image gallery, select the images to add and click the &#8220;Create a new gallery&#8221; button.')])).str() + '</p>')
		var_inserting_media = rt.concat(var_inserting_media, rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('You can also embed media from many popular websites including Twitter, YouTube, Flickr and others by pasting the media URL on its own line into the content of your post/page. <a href="https://wordpress.org/documentation/article/embeds/">Learn more about embeds</a>.')])).str() + '</p>'))
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'inserting-media' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Inserting Media')]) }, rt.ArrayItem{ key: 'content', val: var_inserting_media }])])
	}
	if rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) {
		mut var_publish_box := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Several boxes on this screen contain settings for how your content will be published, including:')])).str() + '</p>')
		var_publish_box = rt.concat(var_publish_box, rt.new_string('<ul><li>' + (rt.call_function('__', [rt.new_string('<strong>Publish</strong> &mdash; You can set the terms of publishing your post in the Publish box. For Status, Visibility, and Publish (immediately), click on the Edit link to reveal more options. Visibility includes options for password-protecting a post or making it stay at the top of your blog indefinitely (sticky). The Password protected option allows you to set an arbitrary password for each post. The Private option hides the post from everyone except editors and administrators. Publish (immediately) allows you to set a future or past date and time, so you can schedule a post to be published in the future or backdate a post.')])).str() + '</li>'))
		if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-formats')])) && rt.is_true(rt.call_function('post_type_supports', [rt.new_string('post'), rt.new_string('post-formats')])) {
			var_publish_box = rt.concat(var_publish_box, rt.new_string('<li>' + (rt.call_function('__', [rt.new_string('<strong>Format</strong> &mdash; Post Formats designate how your theme will display a specific post. For example, you could have a <em>standard</em> blog post with a title and paragraphs, or a short <em>aside</em> that omits the title and contains a short text blurb. Your theme could enable all or some of 10 possible formats. <a href="https://developer.wordpress.org/advanced-administration/wordpress/post-formats/#supported-formats">Learn more about each post format</a>.')])).str() + '</li>'))
		}
		if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails')])) && rt.is_true(rt.call_function('post_type_supports', [rt.new_string('post'), rt.new_string('thumbnail')])) {
			var_publish_box = rt.concat(var_publish_box, rt.new_string('<li>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>%s</strong> &mdash; This allows you to associate an image with your post without inserting it. This is usually useful only if your theme makes use of the image as a post thumbnail on the home page, a custom header, etc.')]), rt.call_function('esc_html', [rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'featured_image')])])).str() + '</li>'))
		}
		var_publish_box = rt.concat(var_publish_box, rt.new_string('</ul>'))
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'publish-box' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Publish Settings')]) }, rt.ArrayItem{ key: 'content', val: var_publish_box }])])
		mut var_discussion_settings := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('<strong>Send Trackbacks</strong> &mdash; Trackbacks are a way to notify legacy blog systems that you&#8217;ve linked to them. Enter the URL(s) you want to send trackbacks. If you link to other WordPress sites they&#8217;ll be notified automatically using pingbacks, and this field is unnecessary.')])).str() + '</p>')
		var_discussion_settings = rt.concat(var_discussion_settings, rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('<strong>Discussion</strong> &mdash; You can turn comments and pings on or off, and if there are comments on the post, you can see them here and moderate them.')])).str() + '</p>'))
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'discussion-settings' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Discussion Settings')]) }, rt.ArrayItem{ key: 'content', val: var_discussion_settings }])])
	} else if rt.is_true(rt.identical(rt.new_string('page'), var_post_type)) {
		mut var_page_attributes := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('<strong>Parent</strong> &mdash; You can arrange your pages in hierarchies. For example, you could have an &#8220;About&#8221; page that has &#8220;Life Story&#8221; and &#8220;My Dog&#8221; pages under it. There are no limits to how many levels you can nest pages.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<strong>Template</strong> &mdash; Some themes have custom templates you can use for certain pages that might have additional features or custom layouts. If so, you&#8217;ll see them in this dropdown menu.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<strong>Order</strong> &mdash; Pages are usually ordered alphabetically, but you can choose your own order by entering a number (1 for first, etc.) in this field.')])).str() + '</p>')
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'page-attributes' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Page Attributes')]) }, rt.ArrayItem{ key: 'content', val: var_page_attributes }])])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if !(var_post_new_file).is_null() && rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'create_posts')])) {
		print(' <a href="' + (rt.call_function('esc_url', [rt.call_function('admin_url', [var_post_new_file.clone()])])).str() + '" class="page-title-action">' + (rt.call_function('esc_html', [rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'add_new_item')])).str() + '</a>')
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_notice) {
		rt.call_function('wp_admin_notice', [rt.new_string('<p id="has-newer-autosave">' + (var_notice).str() + '</p>'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }, rt.ArrayItem{ key: 'id', val: 'notice' }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
	}
	if rt.is_true(var_message) {
		rt.call_function('wp_admin_notice', [var_message.clone(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' }, rt.ArrayItem{ key: 'dismissible', val: true }, rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'updated' }]) }])])
	}
	mut var_connection_lost_message := rt.call_function('sprintf', [rt.new_string('<span class="spinner"></span> %1$s <span class="hide-if-no-sessionstorage">%2$s</span>'), rt.call_function('__', [rt.new_string('<strong>Connection lost.</strong> Saving has been disabled until you are reconnected.')]), rt.call_function('__', [rt.new_string('This post is being backed up in your browser, just in case.')])])
	rt.call_function('wp_admin_notice', [var_connection_lost_message.clone(), rt.create_array([rt.ArrayItem{ key: 'id', val: 'lost-connection-notice' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }, rt.ArrayItem{ key: none, val: 'hidden' }]) }])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('post_edit_form_tag'), var_post.clone()])
	mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [var_nonce_action.clone()])
	// unsupported statement: Stmt_InlineHTML
	print(rt.new_int((var_user_ID).to_i64()).str())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string((var_form_action).str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string((var_form_action).str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_post, 'post_author')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_post_type.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_post, 'post_status')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(var_referer) { rt.call_function('esc_url', [var_referer.clone()]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_active_post_lock)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(':'), var_active_post_lock.clone()])]))
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('draft'), rt.call_function('get_post_status', [var_post.clone()]))))) {
		rt.call_function('wp_original_referer_field', [rt.new_bool(true), rt.new_string('previous')])
	}
	print(var_form_extra)
	rt.call_function('wp_nonce_field', [rt.new_string('meta-box-order'), rt.new_string('meta-box-order-nonce'), rt.new_bool(false)])
	rt.call_function('wp_nonce_field', [rt.new_string('closedpostboxes'), rt.new_string('closedpostboxesnonce'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('edit_form_top'), var_post.clone()])
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_int(1), rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'get_columns', []rt.PhpVal{}))) { '1' } else { '2' })
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('title')])) {
		// unsupported statement: Stmt_InlineHTML
		mut var_title_placeholder := rt.call_function('apply_filters', [rt.new_string('enter_title_here'), rt.call_function('__', [rt.new_string('Add title')]), var_post.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_title_placeholder)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_post, 'post_title')]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('editor')])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Skip to Editor')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('edit_form_before_permalink'), var_post.clone()])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_viewable) {
			mut var_sample_permalink_html := if rt.is_true(rt.get_property(var_post_type_object, 'public')) { rt.call_function('get_sample_permalink_html', [rt.get_property(var_post, 'ID')]) } else { rt.new_string('') }
			if rt.is_true(rt.call_function('has_filter', [rt.new_string('pre_get_shortlink')])) || rt.is_true(rt.call_function('has_filter', [rt.new_string('get_shortlink')])) {
				mut var_shortlink := rt.call_function('wp_get_shortlink', [rt.get_property(var_post, 'ID'), rt.new_string('post')])
				if !(!rt.is_true(var_shortlink)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_shortlink, var_permalink)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('home_url', [rt.new_string('?page_id=' + (rt.get_property(var_post, 'ID')).str())]), var_permalink)))) {
					var_sample_permalink_html = rt.concat(var_sample_permalink_html, rt.new_string('<input id="shortlink" type="hidden" value="' + (rt.call_function('esc_attr', [var_shortlink.clone()])).str() + '" />' + '<button type="button" class="button button-small" onclick="prompt(&#39;URL:&#39;, jQuery(\'#shortlink\').val());">' + (rt.call_function('__', [rt.new_string('Get Shortlink')])).str() + '</button>'))
				}
			}
			if rt.is_true(rt.get_property(var_post_type_object, 'public')) && !(rt.is_true(rt.identical(rt.new_string('pending'), rt.call_function('get_post_status', [var_post.clone()]))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'publish_posts')])))))) {
				mut var_has_sample_permalink := rt.is_true(var_sample_permalink_html) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post, 'post_status')))))
				// unsupported statement: Stmt_InlineHTML
				if var_has_sample_permalink {
					rt.echo_val(var_sample_permalink_html)
				}
				// unsupported statement: Stmt_InlineHTML
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('samplepermalink'), rt.new_string('samplepermalinknonce'), rt.new_bool(false)])
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('do_action', [rt.new_string('edit_form_after_title'), var_post.clone()])
	if rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('editor')])) {
		mut var__wp_editor_expand_class := ''
		if var__wp_editor_expand {
		var__wp_editor_expand_class = ' wp-editor-expand'
		}
		// unsupported statement: Stmt_InlineHTML
		print(var__wp_editor_expand_class)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_editor', [rt.get_property(var_post, 'post_content'), rt.new_string('content'), rt.create_array([rt.ArrayItem{ key: '_content_editor_dfw', val: var__content_editor_dfw }, rt.ArrayItem{ key: 'drag_drop_upload', val: true }, rt.ArrayItem{ key: 'editor_height', val: 300 }, rt.ArrayItem{ key: 'tinymce', val: rt.create_array([rt.ArrayItem{ key: 'resize', val: false }, rt.ArrayItem{ key: 'wp_autoresize_on', val: var__wp_editor_expand }, rt.ArrayItem{ key: 'add_unload_trigger', val: false }]) }])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('Word count: %s')]), rt.new_string('<span class="word-count">0</span>')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post, 'post_status'))))) {
			print('<span id="last-edit">')
			mut var_last_user := rt.call_function('get_userdata', [rt.call_function('get_post_meta', [rt.get_property(var_post, 'ID'), rt.new_string('_edit_last'), rt.new_bool(true)])])
			if rt.is_true(var_last_user) {
				rt.call_function('printf', [rt.call_function('__', [rt.new_string('Last edited by %1$s on %2$s at %3$s')]), rt.call_function('esc_html', [rt.get_property(var_last_user, 'display_name')]), rt.call_function('mysql2date', [rt.call_function('__', [rt.new_string('F j, Y')]), rt.get_property(var_post, 'post_modified')]), rt.call_function('mysql2date', [rt.call_function('__', [rt.new_string('g:i a')]), rt.get_property(var_post, 'post_modified')])])
			} else {
				rt.call_function('printf', [rt.call_function('__', [rt.new_string('Last edited on %1$s at %2$s')]), rt.call_function('mysql2date', [rt.call_function('__', [rt.new_string('F j, Y')]), rt.get_property(var_post, 'post_modified')]), rt.call_function('mysql2date', [rt.call_function('__', [rt.new_string('g:i a')]), rt.get_property(var_post, 'post_modified')])])
			}
			print('</span>')
		}
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('do_action', [rt.new_string('edit_form_after_editor'), var_post.clone()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('page'), var_post_type)) {
		rt.call_function('do_action', [rt.new_string('submitpage_box'), var_post.clone()])
	} else {
		rt.call_function('do_action', [rt.new_string('submitpost_box'), var_post.clone()])
	}
	rt.call_function('do_meta_boxes', [var_post_type.clone(), rt.new_string('side'), var_post.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_meta_boxes', [rt.new_null(), rt.new_string('normal'), var_post.clone()])
	if rt.is_true(rt.identical(rt.new_string('page'), var_post_type)) {
		rt.call_function('do_action', [rt.new_string('edit_page_form'), var_post.clone()])
	} else {
		rt.call_function('do_action', [rt.new_string('edit_form_advanced'), var_post.clone()])
	}
	rt.call_function('do_meta_boxes', [rt.new_null(), rt.new_string('advanced'), var_post.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('dbx_post_sidebar'), var_post.clone()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('comments')])) {
		rt.call_function('wp_comment_reply', []rt.PhpVal{})
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('title')])) && rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_post, 'post_title'))) {
		// unsupported statement: Stmt_InlineHTML
	}
}
