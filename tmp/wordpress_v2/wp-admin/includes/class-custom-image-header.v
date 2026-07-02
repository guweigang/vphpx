import rt

struct Class_Custom_Image_Header {
	rt.PhpObjectBase
pub mut:
	admin_header_callback    rt.PhpVal = rt.new_null()
	admin_image_div_callback rt.PhpVal = rt.new_null()
	default_headers          rt.PhpVal = rt.new_array()
	updated                  bool
}

fn (mut this Class_Custom_Image_Header) construct(var_admin_header_callback rt.PhpVal, admin_image_div_callback string) {
	this.admin_header_callback = var_admin_header_callback.clone()
	this.admin_image_div_callback = rt.new_string(admin_image_div_callback)
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'init' },
		])])
	rt.call_function('add_action', [rt.new_string('customize_save_after'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'customize_set_last_used' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_custom-header-crop'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'ajax_header_crop' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_custom-header-add'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'ajax_header_add' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_custom-header-remove'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'ajax_header_remove' },
		])])
}

fn (mut this Class_Custom_Image_Header) init() {
	mut var_page := rt.call_function('add_theme_page', [
		rt.call_function('_x', [rt.new_string('Header'), rt.new_string('custom image header')]),
		rt.call_function('_x', [rt.new_string('Header'), rt.new_string('custom image header')]),
		rt.new_string('edit_theme_options'),
		rt.new_string('custom-header'),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header',
			[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_page' }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_page)))) {
		return
	}
	rt.call_function('add_action', [
		rt.new_string('admin_print_scripts-${var_page.to_string()}'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'js_includes' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('admin_print_styles-${var_page.to_string()}'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'css_includes' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('admin_head-${var_page.to_string()}'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'help' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_head-${var_page.to_string()}'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'take_action' },
		]),
		rt.new_int(50)])
	rt.call_function('add_action', [rt.new_string('admin_head-${var_page.to_string()}'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'js' },
		]),
		rt.new_int(50)])
	if rt.is_true(this.admin_header_callback) {
		rt.call_function('add_action', [
			rt.new_string('admin_head-${var_page.to_string()}'),
			this.admin_header_callback,
			rt.new_int(51),
		])
	}
}

fn (mut this Class_Custom_Image_Header) help() {
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('This screen is used to customize the header section of your theme.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('You can choose from the theme&#8217;s default header images, or use one of your own. You can also customize how your Site Title and Tagline are displayed.')])).str() +
				'<p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'set-header-image' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Header Image'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('You can set a custom image header for your site. Simply upload the image and crop it, and the new header will go live immediately. Alternatively, you can use an image that has already been uploaded to your Media Library by clicking the &#8220;Choose Image&#8221; button.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Some themes come with additional header images bundled. If you see multiple images displayed, select the one you would like and click the &#8220;Save Changes&#8221; button.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('If your theme has more than one default header image, or you have uploaded more than one custom header image, you have the option of having WordPress display a randomly different image on each page of your site. Click the &#8220;Random&#8221; radio button next to the Uploaded Images or Default Images section to enable this feature.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('If you do not want a header image to be displayed on your site at all, click the &#8220;Remove Header Image&#8221; button at the bottom of the Header Image section of this page. If you want to re-enable the header image later, you just have to select one of the other image options and click &#8220;Save Changes&#8221;.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'set-header-text' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Header Text'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('For most themes, the header text is your Site Title and Tagline, as defined in the <a href="%s">General Settings</a> section.')]), rt.call_function('admin_url', [rt.new_string('options-general.php')])])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('In the Header Text section of this page, you can choose whether to display this text or hide it. You can also choose a color for the text by clicking the Select Color button and either typing in a legitimate HTML hex value, e.g. &#8220;#ff0000&#8221; for red, or by choosing a color using the color picker.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Do not forget to click &#8220;Save Changes&#8221; when you are done!')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://codex.wordpress.org/Appearance_Header_Screen">Documentation on Custom Header</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
}

fn (mut this Class_Custom_Image_Header) step() i64 {
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('step'))) {
		return 1
	}
	mut var_step :=
		rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('step'))).to_i64())
	if (rt.is_true(rt.less(var_step, rt.new_int(1)))
		|| rt.is_true(rt.less(rt.new_int(3), var_step))
		|| (rt.is_true(rt.identical(rt.new_int(2), var_step))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce-custom-header-upload')), rt.new_string('custom-header-upload')])))))))
		|| (rt.is_true(rt.identical(rt.new_int(3), var_step))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')), rt.new_string('custom-header-crop-image')])))))) {
		return 1
	}
	return var_step.to_i64()
}

fn (mut this Class_Custom_Image_Header) js_includes() {
	mut var_step := rt.new_int(this.step())
	if rt.is_true(rt.identical(rt.new_int(1), var_step))
		|| rt.is_true(rt.identical(rt.new_int(3), var_step)) {
		rt.call_function('wp_enqueue_media', []rt.PhpVal{})
		rt.call_function('wp_enqueue_script', [rt.new_string('custom-header')])
		if rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('custom-header'),
			rt.new_string('header-text'),
		]))
		{
			rt.call_function('wp_enqueue_script', [rt.new_string('wp-color-picker')])
		}
	} else if rt.is_true(rt.identical(rt.new_int(2), var_step)) {
		rt.call_function('wp_enqueue_script', [rt.new_string('imgareaselect')])
	}
}

fn (mut this Class_Custom_Image_Header) css_includes() {
	mut var_step := rt.new_int(this.step())
	if rt.is_true(rt.identical(rt.new_int(1), var_step))
		|| rt.is_true(rt.identical(rt.new_int(3), var_step))
		&& rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('header-text')])) {
		rt.call_function('wp_enqueue_style', [rt.new_string('wp-color-picker')])
	} else if rt.is_true(rt.identical(rt.new_int(2), var_step)) {
		rt.call_function('wp_enqueue_style', [rt.new_string('imgareaselect')])
	}
}

fn (mut this Class_Custom_Image_Header) take_action() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		return
	}
	if !rt.is_true(rt.get_superglobal('_POST')) {
		return
	}
	this.updated = true
	if rt.get_superglobal('_POST').array_isset(rt.new_string('resetheader')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-header-options'),
			rt.new_string('_wpnonce-custom-header-options')])
		this.reset_header_image()
		return
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('removeheader')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-header-options'),
			rt.new_string('_wpnonce-custom-header-options')])
		this.remove_header_image()
		return
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('text-color'))
		&& !(rt.get_superglobal('_POST').array_isset(rt.new_string('display-header-text'))) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-header-options'),
			rt.new_string('_wpnonce-custom-header-options')])
		rt.call_function('set_theme_mod', [rt.new_string('header_textcolor'),
			rt.new_string('blank')])
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('text-color')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-header-options'),
			rt.new_string('_wpnonce-custom-header-options')])
		rt.get_superglobal('_POST').array_set('text-color', rt.call_function('str_replace', [
			rt.new_string('#'),
			rt.new_string(''),
			rt.get_superglobal('_POST').array_get(rt.new_string('text-color')),
		]))
		mut var_color := rt.call_function('preg_replace', [
			rt.new_string('/[^0-9a-fA-F]/'),
			rt.new_string(''),
			rt.get_superglobal('_POST').array_get(rt.new_string('text-color')),
		])
		if var_color.clone().to_string().len == 6 || var_color.clone().to_string().len == 3 {
			rt.call_function('set_theme_mod', [rt.new_string('header_textcolor'),
				var_color.clone()])
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_color)))) {
			rt.call_function('set_theme_mod', [rt.new_string('header_textcolor'),
				rt.new_string('blank')])
		}
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('default-header')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-header-options'),
			rt.new_string('_wpnonce-custom-header-options')])
		this.set_header_image(rt.get_superglobal('_POST').array_get(rt.new_string('default-header')))
		return
	}
}

fn (mut this Class_Custom_Image_Header) process_default_headers() {
	mut var__wp_default_headers := rt.new_null()
	if !(!var__wp_default_headers.is_null()) {
		return
	}
	if !(!rt.is_true(this.default_headers)) {
		return
	}
	this.default_headers = var__wp_default_headers.clone()
	mut var_template_directory_uri := rt.call_function('get_template_directory_uri', []rt.PhpVal{})
	mut var_stylesheet_directory_uri := rt.call_function('get_stylesheet_directory_uri',
		[]rt.PhpVal{})
	mut iter_1 := rt.func_array_keys(this.default_headers).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_header := item_1.val
		this.default_headers.array_get_mut(var_header).array_set('url', rt.call_function('sprintf', [
			this.default_headers.array_get(var_header).array_get(rt.new_string('url')),
			var_template_directory_uri.clone(),
			var_stylesheet_directory_uri.clone(),
		]))
		this.default_headers.array_get_mut(var_header).array_set('thumbnail_url', rt.call_function('sprintf', [
			this.default_headers.array_get(var_header).array_get(rt.new_string('thumbnail_url')),
			var_template_directory_uri.clone(),
			var_stylesheet_directory_uri.clone(),
		]))
	}
}

fn (mut this Class_Custom_Image_Header) show_header_selector(type string) {
	mut type_mutated := type
	if rt.is_true(rt.identical(rt.new_string('default'), rt.new_string(type_mutated))) {
		mut var_headers := this.default_headers
	} else {
		var_headers = rt.call_function('get_uploaded_header_images', []rt.PhpVal{})
		type_mutated = 'uploaded'
	}
	if 1 < var_headers.clone().array_count() {
		print('<div class="random-header">')
		print('<label><input name="default-header" type="radio" value="random-' + type_mutated +
			'-image"' +
			(rt.call_function('checked', [rt.call_function('is_random_header_image', [rt.new_string(type_mutated).clone()]), rt.new_bool(true), rt.new_bool(false)])).str() +
			' />')
		rt.call_function('_e', [
			rt.new_string('<strong>Random:</strong> Show a different image on each page.'),
		])
		print('</label>')
		print('</div>')
	}
	print('<div class="available-headers">')
	mut iter_2 := var_headers.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_header := item_2.val
		mut var_header_key := item_2.key
		mut var_header_thumbnail := var_header.array_get(rt.new_string('thumbnail_url'))
		mut var_header_url := var_header.array_get(rt.new_string('url'))
		mut var_header_alt_text := if !rt.is_true(var_header.array_get(rt.new_string('alt_text'))) {
			rt.new_string('')
		} else {
			var_header.array_get(rt.new_string('alt_text'))
		}
		print('<div class="default-header">')
		print('<label><input name="default-header" type="radio" value="' +
			(rt.call_function('esc_attr', [var_header_key.clone()])).str() + '" ' +
			(rt.call_function('checked', [var_header_url.clone(), rt.call_function('get_theme_mod', [rt.new_string('header_image')]), rt.new_bool(false)])).str() +
			' />')
		mut var_width := rt.new_string('')
		if !(!rt.is_true(var_header.array_get(rt.new_string('attachment_id')))) {
			var_width = rt.new_string(' width="230"')
		}
		print('<img src="' +
			(rt.call_function('esc_url', [rt.call_function('set_url_scheme', [var_header_thumbnail.clone()])])).str() +
			'" alt="' + (rt.call_function('esc_attr', [var_header_alt_text.clone()])).str() + '"' +
			var_width.str() + ' /></label>')
		print('</div>')
	}
	print('<div class="clear"></div></div>')
}

fn (mut this Class_Custom_Image_Header) js() {
	mut var_step := rt.new_int(this.step())
	if rt.is_true(rt.identical(rt.new_int(1), var_step))
		|| rt.is_true(rt.identical(rt.new_int(3), var_step))
		&& rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('header-text')])) {
		this.js_1()
	} else if rt.is_true(rt.identical(rt.new_int(2), var_step)) {
		this.js_2()
	}
}

fn (mut this Class_Custom_Image_Header) js_1() {
	mut var_default_color := rt.new_string('')
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
		rt.new_string('default-text-color'),
	]))
	{
		var_default_color = rt.call_function('get_theme_support', [
			rt.new_string('custom-header'),
			rt.new_string('default-text-color'),
		])
		if rt.is_true(var_default_color)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_default_color.clone(), rt.new_string('#')]))))) {
			var_default_color = rt.new_string('#' + var_default_color.str())
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [var_default_color.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('display_header_text', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Custom_Image_Header) js_2() {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [
		rt.call_function('get_theme_support', [rt.new_string('custom-header'),
			rt.new_string('width')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [
		rt.call_function('get_theme_support', [rt.new_string('custom-header'),
			rt.new_string('height')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('flex-height')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('flex-width')]))))) {
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
		rt.new_string('flex-height'),
	])))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('get_theme_support', [
			rt.new_string('custom-header'),
			rt.new_string('height'),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
		rt.new_string('flex-width'),
	])))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('get_theme_support', [
			rt.new_string('custom-header'),
			rt.new_string('width'),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Custom_Image_Header) step_1() {
	this.process_default_headers()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Custom Header')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
		mut var_message := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('You can now manage and live-preview Custom Header in the <a href="%s">Customizer</a>.'),
			]),
			rt.call_function('admin_url', [
				rt.new_string('customize.php?autofocus[control]=header_image'),
			]),
		])
		rt.call_function('wp_admin_notice', [var_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'hide-if-no-customize' },
				]) }])])
	}
	if !(!(this.updated)) {
		mut var_updated_message := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Header updated. <a href="%s">Visit your site</a> to see how it looks.'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('home_url', [rt.new_string('/')]),
			]),
		])
		rt.call_function('wp_admin_notice', [var_updated_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'updated' },
				]) }])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Header Image')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('get_custom_header', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('display_header_text', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Preview'),
			rt.new_string('noun')]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(this.admin_image_div_callback) {
			rt.call_function('call_user_func', [this.admin_image_div_callback])
		} else {
			mut var_custom_header := rt.call_function('get_custom_header', []rt.PhpVal{})
			mut var_header_image := rt.call_function('get_header_image', []rt.PhpVal{})
			if rt.is_true(var_header_image) {
				mut var_header_image_style := rt.new_string('background-image:url(' +
					(rt.call_function('esc_url', [var_header_image.clone()])).str() + ');')
			} else {
				var_header_image_style = rt.new_string('')
			}
			if rt.is_true(rt.get_property(var_custom_header, 'width')) {
				var_header_image_style = rt.concat(var_header_image_style, rt.new_string(
					'max-width:' + (rt.get_property(var_custom_header, 'width')).str() + 'px;'))
			}
			if rt.is_true(rt.get_property(var_custom_header, 'height')) {
				var_header_image_style = rt.concat(var_header_image_style, rt.new_string(
					'height:' + (rt.get_property(var_custom_header, 'height')).str() + 'px;'))
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_header_image_style)
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_function('display_header_text', []rt.PhpVal{})) {
				mut var_style := rt.new_string(' style="color:#' +
					(rt.call_function('get_header_textcolor', []rt.PhpVal{})).str() + ';"')
			} else {
				var_style = rt.new_string(' style="display:none;"')
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_style)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('bloginfo', [rt.new_string('url')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('bloginfo', [rt.new_string('name')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_style)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('bloginfo', [rt.new_string('description')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_files')]))
		&& rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('uploads')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Select Image')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('You can select an image to be shown at the top of your site by uploading from your computer or choosing from your media library. After selecting an image you will be able to crop it.'),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('flex-height')])))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('flex-width')]))))) {
			rt.call_function('printf', [
				rt.new_string(
					(rt.call_function('__', [rt.new_string('Images of exactly <strong>%1$d &times; %2$d pixels</strong> will be used as-is.')])).str() +
					'<br />'),
				rt.call_function('get_theme_support', [
					rt.new_string('custom-header'),
					rt.new_string('width'),
				]),
				rt.call_function('get_theme_support', [
					rt.new_string('custom-header'),
					rt.new_string('height'),
				]),
			])
		} else if rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('custom-header'),
			rt.new_string('flex-height'),
		]))
		{
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [
				rt.new_string('custom-header'),
				rt.new_string('flex-width'),
			])))))
			{
				rt.call_function('printf', [
					rt.new_string(
						(rt.call_function('__', [rt.new_string('Images should be at least %s wide.')])).str() +
						' '),
					rt.call_function('sprintf', [
						rt.new_string('<strong>' +
							(rt.call_function('__', [rt.new_string('%d pixels')])).str() +
							'</strong>'),
						rt.call_function('get_theme_support', [
							rt.new_string('custom-header'),
							rt.new_string('width'),
						]),
					]),
				])
			}
		} else if rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('custom-header'),
			rt.new_string('flex-width'),
		]))
		{
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [
				rt.new_string('custom-header'),
				rt.new_string('flex-height'),
			])))))
			{
				rt.call_function('printf', [
					rt.new_string(
						(rt.call_function('__', [rt.new_string('Images should be at least %s tall.')])).str() +
						' '),
					rt.call_function('sprintf', [
						rt.new_string('<strong>' +
							(rt.call_function('__', [rt.new_string('%d pixels')])).str() +
							'</strong>'),
						rt.call_function('get_theme_support', [
							rt.new_string('custom-header'),
							rt.new_string('height'),
						]),
					]),
				])
			}
		}
		if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('flex-height')]))
			|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('flex-width')])) {
			if rt.is_true(rt.call_function('current_theme_supports', [
				rt.new_string('custom-header'),
				rt.new_string('width'),
			]))
			{
				rt.call_function('printf', [
					rt.new_string(
						(rt.call_function('__', [rt.new_string('Suggested width is %s.')])).str() +
						' '),
					rt.call_function('sprintf', [
						rt.new_string('<strong>' +
							(rt.call_function('__', [rt.new_string('%d pixels')])).str() +
							'</strong>'),
						rt.call_function('get_theme_support', [
							rt.new_string('custom-header'),
							rt.new_string('width'),
						]),
					]),
				])
			}
			if rt.is_true(rt.call_function('current_theme_supports', [
				rt.new_string('custom-header'),
				rt.new_string('height'),
			]))
			{
				rt.call_function('printf', [
					rt.new_string(
						(rt.call_function('__', [rt.new_string('Suggested height is %s.')])).str() +
						' '),
					rt.call_function('sprintf', [
						rt.new_string('<strong>' +
							(rt.call_function('__', [rt.new_string('%d pixels')])).str() +
							'</strong>'),
						rt.call_function('get_theme_support', [
							rt.new_string('custom-header'),
							rt.new_string('height'),
						]),
					]),
				])
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('add_query_arg', [rt.new_string('step'),
				rt.new_int(2)]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Choose an image from your computer:')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('custom-header-upload'),
			rt.new_string('_wpnonce-custom-header-upload')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.call_function('_x', [rt.new_string('Upload'), rt.new_string('verb')]),
			rt.new_string(''),
			rt.new_string('submit'),
			rt.new_bool(false),
		])
		// unsupported statement: Stmt_InlineHTML
		mut var_modal_update_href := rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'page', val: 'custom-header' },
				rt.ArrayItem{ key: 'step', val: 2 }, rt.ArrayItem{
					key: '_wpnonce-custom-header-upload'
					val: rt.call_function('wp_create_nonce', [
						rt.new_string('custom-header-upload'),
					])
				}]),
			rt.call_function('admin_url', [rt.new_string('themes.php')]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Or choose an image from your media library:'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_modal_update_href.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Choose a Custom Header')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Set as header')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Choose Image')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('add_query_arg', [rt.new_string('step'),
			rt.new_int(1)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.new_null(), rt.new_string('screen-reader-text'),
		rt.new_string('save-header-options'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('get_uploaded_header_images', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Uploaded Images')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('You can choose one of your previously uploaded headers, or show a random one.'),
		])
		// unsupported statement: Stmt_InlineHTML
		this.show_header_selector('uploaded')
		// unsupported statement: Stmt_InlineHTML
	}
	if !(!rt.is_true(this.default_headers)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Default Images')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('custom-header'),
			rt.new_string('uploads'),
		]))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('If you do not want to upload your own image, you can use one of these cool headers, or show a random one.'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('You can use one of these cool headers or show a random one on each page.'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		this.show_header_selector('default')
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.call_function('get_header_image', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Remove Image')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('This will remove the header image. You will not be able to restore any customizations.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Remove Header Image')]),
			rt.new_string(''),
			rt.new_string('removeheader'),
			rt.new_bool(false),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	mut var_default_image := rt.call_function('sprintf', [
		rt.call_function('get_theme_support', [rt.new_string('custom-header'),
			rt.new_string('default-image')]),
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
		rt.call_function('get_stylesheet_directory_uri', []rt.PhpVal{}),
	])
	if rt.is_true(var_default_image)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_header_image', []rt.PhpVal{}), var_default_image)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Reset Image')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('This will restore the original header image. You will not be able to restore any customizations.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Restore Original Header Image')]),
			rt.new_string(''),
			rt.new_string('resetheader'),
			rt.new_bool(false),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
		rt.new_string('header-text'),
	]))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Header Text')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Header Text')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [
			rt.call_function('display_header_text', []rt.PhpVal{}),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Show header text with your image.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Text Color')])
		// unsupported statement: Stmt_InlineHTML
		mut var_default_color := rt.new_string('')
		if rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('custom-header'),
			rt.new_string('default-text-color'),
		]))
		{
			var_default_color = rt.call_function('get_theme_support', [
				rt.new_string('custom-header'),
				rt.new_string('default-text-color'),
			])
			if rt.is_true(var_default_color)
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_default_color.clone(), rt.new_string('#')]))))) {
				var_default_color = rt.new_string('#' + var_default_color.str())
			}
		}
		mut var_default_color_attr := rt.new_string((if rt.is_true(var_default_color) {
			' data-default-color="' +
				(rt.call_function('esc_attr', [var_default_color.clone()])).str() + '"'
		} else {
			''
		}).str())
		mut var_header_textcolor := if rt.is_true(rt.call_function('display_header_text', []rt.PhpVal{})) { rt.call_function('get_header_textcolor', []rt.PhpVal{}) } else { rt.call_function('get_theme_support', [
				rt.new_string('custom-header'),
				rt.new_string('default-text-color'),
			]) }
		if rt.is_true(var_header_textcolor)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_header_textcolor.clone(), rt.new_string('#')]))))) {
			var_header_textcolor = rt.new_string('#' + var_header_textcolor.str())
		}
		print('<input type="text" name="text-color" id="text-color" value="' +
			(rt.call_function('esc_attr', [var_header_textcolor.clone()])).str() + '"' +
			var_default_color_attr.str() + ' />')
		if rt.is_true(var_default_color) {
			print(' <span class="description hide-if-js">' +
				(rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('Default: %s'), rt.new_string('color')]), rt.call_function('esc_html', [var_default_color.clone()])])).str() +
				'</span>')
		}
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('do_action', [rt.new_string('custom_header_options')])
	rt.call_function('wp_nonce_field', [rt.new_string('custom-header-options'),
		rt.new_string('_wpnonce-custom-header-options')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.new_null(), rt.new_string('primary'),
		rt.new_string('save-header-options')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Custom_Image_Header) step_2() rt.PhpVal {
	mut var_type := rt.new_null()
	mut var_attr := rt.new_null()
	rt.call_function('check_admin_referer', [rt.new_string('custom-header-upload'),
		rt.new_string('_wpnonce-custom-header-upload')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
		rt.new_string('uploads'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.new_string('<h1>' +
				(rt.call_function('__', [rt.new_string('An error occurred while processing your header image.')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('The active theme does not support uploading a custom header image. Please ensure your theme supports custom headers and try again.')])).str() +
				'</p>'),
			rt.new_int(403),
		])
	}
	if !rt.is_true(rt.get_superglobal('_POST'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('file')) {
		mut var_attachment_id := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('file')),
		])
		mut var_file := rt.call_function('get_attached_file', [
			var_attachment_id.clone(), rt.new_bool(true)])
		mut var_url := rt.call_function('wp_get_attachment_image_src', [
			var_attachment_id.clone(), rt.new_string('full')])
		var_url = var_url.array_get(rt.new_int(0))
	} else if !(rt.get_superglobal('_POST')).is_null() {
		mut var_data := this.step_2_manage_upload()
		var_attachment_id = var_data.array_get(rt.new_string('attachment_id'))
		var_file = var_data.array_get(rt.new_string('file'))
		var_url = var_data.array_get(rt.new_string('url'))
	}
	if rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
		mut list_tmp_1 := rt.call_function('wp_getimagesize', [
			var_file.clone()])
		mut var_width := list_tmp_1.array_get(0)
		mut var_height := list_tmp_1.array_get(1)
		var_type = list_tmp_1.array_get(2)
		var_attr = list_tmp_1.array_get(3)
	} else {
		var_data = rt.call_function('wp_get_attachment_metadata', [
			var_attachment_id.clone()])
		var_height = rt.new_int(if var_data.array_isset(rt.new_string('height')) {
			rt.new_int((var_data.array_get(rt.new_string('height'))).to_i64())
		} else {
			0
		})
		var_width = rt.new_int(if var_data.array_isset(rt.new_string('width')) {
			rt.new_int((var_data.array_get(rt.new_string('width'))).to_i64())
		} else {
			0
		})
		var_data = rt.new_null()
	}
	mut var_max_width := rt.new_int(0)
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
		rt.new_string('flex-width'),
	]))
	{
		var_max_width = rt.new_int(1500)
	}
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
		rt.new_string('max-width'),
	]))
	{
		var_max_width = rt.call_function('max', [var_max_width.clone(),
			rt.call_function('get_theme_support', [rt.new_string('custom-header'),
				rt.new_string('max-width')])])
	}
	var_max_width = rt.call_function('max', [var_max_width.clone(),
		rt.call_function('get_theme_support', [rt.new_string('custom-header'),
			rt.new_string('width')])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('flex-height')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('flex-width')])))))
		&& rt.is_true(rt.identical(rt.new_int((rt.call_function('get_theme_support', [rt.new_string('custom-header'), rt.new_string('width')])).to_i64()), var_width))
		&& rt.is_true(rt.identical(rt.new_int((rt.call_function('get_theme_support', [rt.new_string('custom-header'), rt.new_string('height')])).to_i64()), var_height)) {
		if rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
			rt.call_function('wp_update_attachment_metadata', [
				var_attachment_id.clone(),
				rt.call_function('wp_generate_attachment_metadata', [
					var_attachment_id.clone(),
					var_file.clone(),
				])])
		}
		this.set_header_image(rt.call_function('compact', [rt.new_string('url'),
			rt.new_string('attachment_id'), rt.new_string('width'),
			rt.new_string('height')]))
		var_file = rt.call_function('apply_filters', [
			rt.new_string('wp_create_file_in_uploads'),
			var_file.clone(),
			var_attachment_id.clone(),
		])
		this.finished()
		return rt.new_null()
	} else if rt.is_true(rt.greater(var_width, var_max_width)) {
		mut var_oitar := rt.div(var_width, var_max_width)
		mut var_image := rt.call_function('wp_crop_image', [var_attachment_id.clone(),
			rt.new_int(0), rt.new_int(0), var_width.clone(), var_height.clone(),
			var_max_width.clone(), rt.div(var_height, var_oitar),
			rt.new_bool(false),
			rt.call_function('str_replace', [
				rt.call_function('wp_basename', [var_file.clone()]),
				rt.new_string('midsize-' +
					(rt.call_function('wp_basename', [var_file.clone()])).str()),
				var_file.clone(),
			])])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_image))))
			|| rt.is_true(rt.call_function('is_wp_error', [var_image.clone()])) {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Image could not be processed. Please go back and try again.'),
				]),
				rt.call_function('__', [
					rt.new_string('Image Processing Error'),
				]),
			])
		}
		var_image = rt.call_function('apply_filters', [
			rt.new_string('wp_create_file_in_uploads'),
			var_image.clone(),
			var_attachment_id.clone(),
		])
		var_url = rt.call_function('str_replace', [
			rt.call_function('wp_basename', [var_url.clone()]),
			rt.call_function('wp_basename', [var_image.clone()]),
			var_url.clone(),
		])
		var_width = rt.div(var_width, var_oitar)
		var_height = rt.div(var_height, var_oitar)
	} else {
		var_oitar = rt.new_int(1)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Crop Header Image')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('add_query_arg', [rt.new_string('step'),
			rt.new_int(3)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Choose the part of the image you want to use as your header.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('You need JavaScript to choose a part of the image.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_width.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_height.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_width.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_height.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_attachment_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_oitar.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if !rt.is_true(rt.get_superglobal('_POST'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('file')) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('custom-header-crop-image')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [
		rt.call_function('__', [rt.new_string('Crop and Publish')]),
		rt.new_string('primary'),
		rt.new_string('submit'),
		rt.new_bool(false),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_int(1), var_oitar))
		&& rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('flex-height')]))
		|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('flex-width')])) {
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Skip Cropping, Publish Image as Is')]),
			rt.new_string(''),
			rt.new_string('skip-cropping'),
			rt.new_bool(false),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	return rt.new_null()
}

fn (mut this Class_Custom_Image_Header) step_2_manage_upload() rt.PhpVal {
	mut var__FILES := rt.new_null()
	mut var_overrides := {
		'test_form': false
	}
	mut var_uploaded_file := var__FILES.array_get(rt.new_string('import'))
	mut var_wp_filetype := rt.call_function('wp_check_filetype_and_ext', [
		var_uploaded_file.array_get(rt.new_string('tmp_name')),
		var_uploaded_file.array_get(rt.new_string('name')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_match_mime_types', [
		rt.new_string('image'),
		var_wp_filetype.array_get(rt.new_string('type')),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('The uploaded file is not a valid image. Please try again.'),
			]),
		])
	}
	mut var_file := rt.call_function('wp_handle_upload', [var_uploaded_file.clone(),
		rt.create_array_from_native_map(var_overrides)])
	if var_file.array_isset(rt.new_string('error')) {
		rt.call_function('wp_die', [var_file.array_get(rt.new_string('error')),
			rt.call_function('__', [rt.new_string('Image Upload Error')])])
	}
	mut var_url := var_file.array_get(rt.new_string('url'))
	mut var_type := var_file.array_get(rt.new_string('type'))
	var_file = var_file.array_get(rt.new_string('file'))
	mut var_filename := rt.call_function('wp_basename', [var_file.clone()])
	mut var_attachment := rt.create_array([
		rt.ArrayItem{ key: 'post_title', val: var_filename },
		rt.ArrayItem{ key: 'post_content', val: var_url },
		rt.ArrayItem{ key: 'post_mime_type', val: var_type },
		rt.ArrayItem{ key: 'guid', val: var_url },
		rt.ArrayItem{ key: 'context', val: 'custom-header' },
	])
	mut var_attachment_id := rt.call_function('wp_insert_attachment', [
		var_attachment.clone(), var_file.clone()])
	return rt.call_function('compact', [rt.new_string('attachment_id'),
		rt.new_string('file'), rt.new_string('filename'), rt.new_string('url'),
		rt.new_string('type')])
}

fn (mut this Class_Custom_Image_Header) step_3() rt.PhpVal {
	rt.call_function('check_admin_referer', [rt.new_string('custom-header-crop-image')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
		rt.new_string('uploads'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.new_string('<h1>' +
				(rt.call_function('__', [rt.new_string('An error occurred while processing your header image.')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('The active theme does not support uploading a custom header image. Please ensure your theme supports custom headers and try again.')])).str() +
				'</p>'),
			rt.new_int(403),
		])
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('skip-cropping'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('flex-height')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('flex-width')]))))) {
		rt.call_function('wp_die', [
			rt.new_string('<h1>' +
				(rt.call_function('__', [rt.new_string('An error occurred while processing your header image.')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('The active theme does not support a flexible sized header image.')])).str() +
				'</p>'),
			rt.new_int(403),
		])
	}
	if rt.is_true(rt.greater(rt.get_superglobal('_POST').array_get(rt.new_string('oitar')),
		rt.new_int(1)))
	{
		rt.get_superglobal('_POST').array_set('x1', rt.mul(rt.get_superglobal('_POST').array_get(rt.new_string('x1')),
			rt.get_superglobal('_POST').array_get(rt.new_string('oitar'))))
		rt.get_superglobal('_POST').array_set('y1', rt.mul(rt.get_superglobal('_POST').array_get(rt.new_string('y1')),
			rt.get_superglobal('_POST').array_get(rt.new_string('oitar'))))
		rt.get_superglobal('_POST').array_set('width', rt.mul(rt.get_superglobal('_POST').array_get(rt.new_string('width')),
			rt.get_superglobal('_POST').array_get(rt.new_string('oitar'))))
		rt.get_superglobal('_POST').array_set('height', rt.mul(rt.get_superglobal('_POST').array_get(rt.new_string('height')),
			rt.get_superglobal('_POST').array_get(rt.new_string('oitar'))))
	}
	mut var_attachment_id := rt.call_function('absint', [
		rt.get_superglobal('_POST').array_get(rt.new_string('attachment_id')),
	])
	mut var_original := rt.call_function('get_attached_file', [
		var_attachment_id.clone()])
	mut var_dimensions := this.get_header_dimensions(rt.create_array([
		rt.ArrayItem{
			key: 'height'
			val: rt.get_superglobal('_POST').array_get(rt.new_string('height'))
		},
		rt.ArrayItem{
			key: 'width'
			val: rt.get_superglobal('_POST').array_get(rt.new_string('width'))
		},
	]))
	mut var_height := var_dimensions.array_get(rt.new_string('dst_height'))
	mut var_width := var_dimensions.array_get(rt.new_string('dst_width'))
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('skip-cropping'))) {
		mut var_cropped := rt.call_function('wp_crop_image', [
			var_attachment_id.clone(),
			rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('x1'))).to_i64()),
			rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('y1'))).to_i64()),
			rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('width'))).to_i64()),
			rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('height'))).to_i64()),
			var_width.clone(), var_height.clone()])
	} else if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('create-new-attachment')))) {
		var_cropped = rt.call_function('_copy_image_file', [var_attachment_id.clone()])
	} else {
		var_cropped = rt.call_function('get_attached_file', [
			var_attachment_id.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cropped))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_cropped.clone()])) {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Image could not be processed. Please go back and try again.'),
			]),
			rt.call_function('__', [
				rt.new_string('Image Processing Error'),
			]),
		])
	}
	var_cropped = rt.call_function('apply_filters', [
		rt.new_string('wp_create_file_in_uploads'),
		var_cropped.clone(),
		var_attachment_id.clone(),
	])
	mut var_attachment := rt.call_function('wp_copy_parent_attachment_properties', [
		var_cropped.clone(),
		var_attachment_id.clone(),
		rt.new_string('custom-header'),
	])
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('create-new-attachment')))) {
		var_attachment.array_unset(rt.new_string('ID'))
	}
	var_attachment_id = this.insert_attachment(var_attachment.clone(), var_cropped.clone())
	mut var_url := rt.call_function('wp_get_attachment_url', [
		var_attachment_id.clone()])
	this.set_header_image(rt.call_function('compact', [rt.new_string('url'),
		rt.new_string('attachment_id'), rt.new_string('width'),
		rt.new_string('height')]))
	mut var_medium := rt.call_function('str_replace', [
		rt.call_function('wp_basename', [var_original.clone()]),
		rt.new_string('midsize-' + (rt.call_function('wp_basename', [var_original.clone()])).str()),
		var_original.clone(),
	])
	if rt.is_true(rt.call_function('file_exists', [var_medium.clone()])) {
		rt.call_function('wp_delete_file', [var_medium.clone()])
	}
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('create-new-attachment')))
		&& !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('skip-cropping'))) {
		rt.call_function('wp_delete_file', [var_original.clone()])
	}
	this.finished()
	return rt.new_null()
}

fn (mut this Class_Custom_Image_Header) finished() {
	this.updated = true
	this.step_1()
}

fn (mut this Class_Custom_Image_Header) admin_page() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to customize headers.'),
			]),
		])
	}
	mut var_step := rt.new_int(this.step())
	if rt.is_true(rt.identical(rt.new_int(2), var_step)) {
		this.step_2()
	} else if rt.is_true(rt.identical(rt.new_int(3), var_step)) {
		this.step_3()
	} else {
		this.step_1()
	}
}

fn (mut this Class_Custom_Image_Header) attachment_fields_to_edit(var_form_fields rt.PhpVal) rt.PhpVal {
	return var_form_fields.clone()
}

fn (mut this Class_Custom_Image_Header) filter_upload_tabs(var_tabs rt.PhpVal) rt.PhpVal {
	return var_tabs.clone()
}

fn (mut this Class_Custom_Image_Header) set_header_image(var_choice rt.PhpVal) {
	mut var_choice_mutated := var_choice
	if var_choice_mutated.clone().is_array() || var_choice_mutated.clone().is_object() {
		var_choice_mutated = rt.cast_array(var_choice_mutated)
		if !(var_choice_mutated.array_isset(rt.new_string('attachment_id')))
			|| !(var_choice_mutated.array_isset(rt.new_string('url'))) {
			return
		}
		var_choice_mutated.array_set('url', rt.call_function('sanitize_url', [
			var_choice_mutated.array_get(rt.new_string('url')),
		]))
		mut var_header_image_data := rt.array_to_object(rt.create_array([
			rt.ArrayItem{
				key: 'attachment_id'
				val: var_choice_mutated.array_get(rt.new_string('attachment_id'))
			},
			rt.ArrayItem{ key: 'url', val: var_choice_mutated.array_get(rt.new_string('url')) },
			rt.ArrayItem{
				key: 'thumbnail_url'
				val: var_choice_mutated.array_get(rt.new_string('url'))
			},
			rt.ArrayItem{ key: 'height', val: var_choice_mutated.array_get(rt.new_string('height')) },
			rt.ArrayItem{ key: 'width', val: var_choice_mutated.array_get(rt.new_string('width')) },
		]))
		rt.call_function('update_post_meta', [
			var_choice_mutated.array_get(rt.new_string('attachment_id')),
			rt.new_string('_wp_attachment_is_custom_header'),
			rt.call_function('get_stylesheet', []rt.PhpVal{}),
		])
		rt.call_function('set_theme_mod', [rt.new_string('header_image'),
			var_choice_mutated.array_get(rt.new_string('url'))])
		rt.call_function('set_theme_mod', [rt.new_string('header_image_data'),
			var_header_image_data.clone()])
		return
	}
	if rt.is_true(rt.call_function('in_array', [var_choice_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'remove-header' },
			rt.ArrayItem{ key: none, val: 'random-default-image' },
			rt.ArrayItem{ key: none, val: 'random-uploaded-image' }]),
		rt.new_bool(true)]))
	{
		rt.call_function('set_theme_mod', [rt.new_string('header_image'),
			var_choice_mutated.clone()])
		rt.call_function('remove_theme_mod', [rt.new_string('header_image_data')])
		return
	}
	mut var_uploaded := rt.call_function('get_uploaded_header_images', []rt.PhpVal{})
	if rt.is_true(var_uploaded) && var_uploaded.array_isset(var_choice_mutated) {
		var_header_image_data = var_uploaded.array_get(var_choice_mutated)
	} else {
		this.process_default_headers()
		if this.default_headers.array_isset(var_choice_mutated) {
			var_header_image_data = this.default_headers.array_get(var_choice_mutated)
		} else {
			return
		}
	}
	rt.call_function('set_theme_mod', [rt.new_string('header_image'),
		rt.call_function('sanitize_url', [var_header_image_data.array_get(rt.new_string('url'))])])
	rt.call_function('set_theme_mod', [rt.new_string('header_image_data'),
		var_header_image_data.clone()])
}

fn (mut this Class_Custom_Image_Header) remove_header_image() {
	this.set_header_image(rt.new_string('remove-header'))
}

fn (mut this Class_Custom_Image_Header) reset_header_image() {
	this.process_default_headers()
	mut var_default := rt.call_function('get_theme_support', [
		rt.new_string('custom-header'),
		rt.new_string('default-image'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_default)))) {
		this.remove_header_image()
		return
	}
	var_default = rt.call_function('sprintf', [var_default.clone(),
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
		rt.call_function('get_stylesheet_directory_uri', []rt.PhpVal{})])
	mut var_default_data := rt.new_array()
	mut iter_3 := this.default_headers.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_details := item_3.val
		mut var_header := item_3.key
		if rt.is_true(rt.identical(var_details.array_get(rt.new_string('url')), var_default)) {
			var_default_data = var_details
			break
		}
	}
	rt.call_function('set_theme_mod', [rt.new_string('header_image'),
		var_default.clone()])
	rt.call_function('set_theme_mod', [rt.new_string('header_image_data'),
		rt.array_to_object(var_default_data)])
}

fn (mut this Class_Custom_Image_Header) get_header_dimensions(var_dimensions rt.PhpVal) rt.PhpVal {
	mut var_dimensions_mutated := var_dimensions
	mut var_max_width := rt.new_int(0)
	mut var_width := rt.call_function('absint',
		[var_dimensions_mutated.array_get(rt.new_string('width'))])
	mut var_height := rt.call_function('absint',
		[var_dimensions_mutated.array_get(rt.new_string('height'))])
	mut var_theme_height := rt.call_function('get_theme_support', [
		rt.new_string('custom-header'),
		rt.new_string('height'),
	])
	mut var_theme_width := rt.call_function('get_theme_support', [
		rt.new_string('custom-header'),
		rt.new_string('width'),
	])
	mut var_has_flex_width := rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
		rt.new_string('flex-width'),
	])
	mut var_has_flex_height := rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
		rt.new_string('flex-height'),
	])
	mut var_has_max_width := rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
		rt.new_string('max-width'),
	])
	mut var_dst := {
		'dst_height': rt.new_null()
		'dst_width':  rt.new_null()
	}
	if rt.is_true(var_has_flex_width) {
		var_max_width = rt.new_int(1500)
	}
	if rt.is_true(var_has_max_width) {
		var_max_width = rt.call_function('max', [var_max_width.clone(),
			rt.call_function('get_theme_support', [rt.new_string('custom-header'),
				rt.new_string('max-width')])])
	}
	var_max_width = rt.call_function('max', [var_max_width.clone(),
		var_theme_width.clone()])
	if rt.is_true(var_has_flex_height) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_flex_width))))
		|| rt.is_true(rt.greater(var_width, var_max_width)) {
		var_dst['dst_height'] = rt.call_function('absint', [
			rt.mul(var_height, rt.div(var_max_width, var_width)),
		])
	} else if rt.is_true(var_has_flex_height) && rt.is_true(var_has_flex_width) {
		var_dst['dst_height'] = var_height.clone()
	} else {
		var_dst['dst_height'] = var_theme_height.clone()
	}
	if rt.is_true(var_has_flex_width) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_flex_height))))
		|| rt.is_true(rt.greater(var_width, var_max_width)) {
		var_dst['dst_width'] = rt.call_function('absint', [
			rt.mul(var_width, rt.div(var_max_width, var_width)),
		])
	} else if rt.is_true(var_has_flex_width) && rt.is_true(var_has_flex_height) {
		var_dst['dst_width'] = var_width.clone()
	} else {
		var_dst['dst_width'] = var_theme_width.clone()
	}
	return var_dst.clone()
}

fn (mut this Class_Custom_Image_Header) create_attachment_object(var_cropped rt.PhpVal, var_parent_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_cropped_mutated := var_cropped
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('6.5.0'), rt.new_string('wp_copy_parent_attachment_properties()')])
	mut var_parent := rt.call_function('get_post', [var_parent_attachment_id.clone()])
	mut var_parent_url := rt.call_function('wp_get_attachment_url', [
		rt.get_property(var_parent, 'ID'),
	])
	mut var_url := rt.call_function('str_replace', [
		rt.call_function('wp_basename', [var_parent_url.clone()]),
		rt.call_function('wp_basename', [var_cropped_mutated.clone()]),
		var_parent_url.clone(),
	])
	mut var_size := rt.call_function('wp_getimagesize', [var_cropped_mutated.clone()])
	mut var_image_type := if rt.is_true(var_size) {
		var_size.array_get(rt.new_string('mime'))
	} else {
		rt.new_string('image/jpeg')
	}
	mut var_attachment := rt.create_array([
		rt.ArrayItem{ key: 'ID', val: var_parent_attachment_id },
		rt.ArrayItem{ key: 'post_title', val: rt.call_function('wp_basename', [
			var_cropped_mutated.clone(),
		]) },
		rt.ArrayItem{ key: 'post_mime_type', val: var_image_type },
		rt.ArrayItem{ key: 'guid', val: var_url },
		rt.ArrayItem{ key: 'context', val: 'custom-header' },
		rt.ArrayItem{ key: 'post_parent', val: var_parent_attachment_id },
	])
	return var_attachment.clone()
}

fn (mut this Class_Custom_Image_Header) insert_attachment(var_attachment rt.PhpVal, var_cropped rt.PhpVal) rt.PhpVal {
	mut var_attachment_mutated := var_attachment
	mut var_cropped_mutated := var_cropped
	mut var_parent_id := if !(var_attachment_mutated.array_get(rt.new_string('post_parent'))).is_null() {
		var_attachment_mutated.array_get(rt.new_string('post_parent'))
	} else {
		rt.new_null()
	}
	var_attachment_mutated.array_unset(rt.new_string('post_parent'))
	mut var_attachment_id := rt.call_function('wp_insert_attachment', [
		var_attachment_mutated.clone(), var_cropped_mutated.clone()])
	mut var_metadata := rt.call_function('wp_generate_attachment_metadata', [
		var_attachment_id.clone(), var_cropped_mutated.clone()])
	if rt.is_true(var_parent_id) {
		var_metadata.array_set('attachment_parent', var_parent_id.clone())
	}
	var_metadata = rt.call_function('apply_filters', [
		rt.new_string('wp_header_image_attachment_metadata'),
		var_metadata.clone(),
	])
	rt.call_function('wp_update_attachment_metadata', [var_attachment_id.clone(),
		var_metadata.clone()])
	return var_attachment_id.clone()
}

fn (mut this Class_Custom_Image_Header) ajax_header_crop() {
	rt.call_function('check_ajax_referer', [
		rt.new_string('image_editor-' +
			(rt.get_superglobal('_POST').array_get(rt.new_string('id'))).str()),
		rt.new_string('nonce'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
		rt.new_string('uploads'),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	mut var_crop_details := rt.get_superglobal('_POST').array_get(rt.new_string('cropDetails'))
	mut var_dimensions := this.get_header_dimensions(rt.create_array([
		rt.ArrayItem{ key: 'height', val: var_crop_details.array_get(rt.new_string('height')) },
		rt.ArrayItem{ key: 'width', val: var_crop_details.array_get(rt.new_string('width')) },
	]))
	mut var_attachment_id := rt.call_function('absint', [
		rt.get_superglobal('_POST').array_get(rt.new_string('id')),
	])
	mut var_cropped := rt.call_function('wp_crop_image', [var_attachment_id.clone(),
		rt.new_int((var_crop_details.array_get(rt.new_string('x1'))).to_i64()),
		rt.new_int((var_crop_details.array_get(rt.new_string('y1'))).to_i64()),
		rt.new_int((var_crop_details.array_get(rt.new_string('width'))).to_i64()),
		rt.new_int((var_crop_details.array_get(rt.new_string('height'))).to_i64()),
		rt.new_int((var_dimensions.array_get(rt.new_string('dst_width'))).to_i64()),
		rt.new_int((var_dimensions.array_get(rt.new_string('dst_height'))).to_i64())])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cropped))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_cropped.clone()])) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Image could not be processed. Please go back and try again.'),
				]) },
			]),
		])
	}
	var_cropped = rt.call_function('apply_filters', [
		rt.new_string('wp_create_file_in_uploads'),
		var_cropped.clone(),
		var_attachment_id.clone(),
	])
	mut var_attachment := rt.call_function('wp_copy_parent_attachment_properties', [
		var_cropped.clone(),
		var_attachment_id.clone(),
		rt.new_string('custom-header'),
	])
	mut var_previous := rt.new_bool(this.get_previous_crop(var_attachment.clone()))
	if rt.is_true(var_previous) {
		var_attachment.array_set('ID', var_previous.clone())
	} else {
		var_attachment.array_unset(rt.new_string('ID'))
	}
	mut var_new_attachment_id := this.insert_attachment(var_attachment.clone(), var_cropped.clone())
	var_attachment.array_set('attachment_id', var_new_attachment_id.clone())
	var_attachment.array_set('url', rt.call_function('wp_get_attachment_url', [
		var_new_attachment_id.clone(),
	]))
	var_attachment.array_set('width', var_dimensions.array_get(rt.new_string('dst_width')))
	var_attachment.array_set('height', var_dimensions.array_get(rt.new_string('dst_height')))
	rt.call_function('wp_send_json_success', [var_attachment.clone()])
}

fn (mut this Class_Custom_Image_Header) ajax_header_add() {
	rt.call_function('check_ajax_referer', [rt.new_string('header-add'),
		rt.new_string('nonce')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	mut var_attachment_id := rt.call_function('absint', [
		rt.get_superglobal('_POST').array_get(rt.new_string('attachment_id')),
	])
	if rt.is_true(rt.less(var_attachment_id, rt.new_int(1))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	mut var_key := rt.new_string('_wp_attachment_custom_header_last_used_' +
		(rt.call_function('get_stylesheet', []rt.PhpVal{})).str())
	rt.call_function('update_post_meta', [var_attachment_id.clone(),
		var_key.clone(), rt.call_function('time', []rt.PhpVal{})])
	rt.call_function('update_post_meta', [var_attachment_id.clone(),
		rt.new_string('_wp_attachment_is_custom_header'),
		rt.call_function('get_stylesheet',
			[]rt.PhpVal{})])
	rt.call_function('wp_send_json_success', []rt.PhpVal{})
}

fn (mut this Class_Custom_Image_Header) ajax_header_remove() {
	rt.call_function('check_ajax_referer', [rt.new_string('header-remove'),
		rt.new_string('nonce')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	mut var_attachment_id := rt.call_function('absint', [
		rt.get_superglobal('_POST').array_get(rt.new_string('attachment_id')),
	])
	if rt.is_true(rt.less(var_attachment_id, rt.new_int(1))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	mut var_key := rt.new_string('_wp_attachment_custom_header_last_used_' +
		(rt.call_function('get_stylesheet', []rt.PhpVal{})).str())
	rt.call_function('delete_post_meta', [var_attachment_id.clone(),
		var_key.clone()])
	rt.call_function('delete_post_meta', [var_attachment_id.clone(),
		rt.new_string('_wp_attachment_is_custom_header'),
		rt.call_function('get_stylesheet',
			[]rt.PhpVal{})])
	rt.call_function('wp_send_json_success', []rt.PhpVal{})
}

fn (mut this Class_Custom_Image_Header) customize_set_last_used(var_wp_customize rt.PhpVal) {
	mut var_header_image_data_setting := rt.call_method(var_wp_customize, 'get_setting', [
		rt.new_string('header_image_data'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_header_image_data_setting)))) {
		return
	}
	mut var_data := rt.call_method(var_header_image_data_setting, 'post_value', []rt.PhpVal{})
	if !(var_data.array_isset(rt.new_string('attachment_id'))) {
		return
	}
	mut var_attachment_id := var_data.array_get(rt.new_string('attachment_id'))
	mut var_key := rt.new_string('_wp_attachment_custom_header_last_used_' +
		(rt.call_function('get_stylesheet', []rt.PhpVal{})).str())
	rt.call_function('update_post_meta', [var_attachment_id.clone(),
		var_key.clone(), rt.call_function('time', []rt.PhpVal{})])
}

fn (mut this Class_Custom_Image_Header) get_default_header_images() rt.PhpVal {
	this.process_default_headers()
	mut var_default := rt.call_function('get_theme_support', [
		rt.new_string('custom-header'),
		rt.new_string('default-image'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_default)))) {
		return this.default_headers
	}
	var_default = rt.call_function('sprintf', [var_default.clone(),
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
		rt.call_function('get_stylesheet_directory_uri', []rt.PhpVal{})])
	mut var_already_has_default := rt.new_bool(false)
	mut iter_4 := this.default_headers.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_header := item_4.val
		mut var_k := item_4.key
		if rt.is_true(rt.identical(var_header.array_get(rt.new_string('url')), var_default)) {
			var_already_has_default = rt.new_bool(true)
			break
		}
	}
	if rt.is_true(var_already_has_default) {
		return this.default_headers
	}
	mut var_header_images := rt.new_array()
	var_header_images.array_set('default', rt.create_array([
		rt.ArrayItem{ key: 'url', val: var_default },
		rt.ArrayItem{ key: 'thumbnail_url', val: var_default },
		rt.ArrayItem{ key: 'description', val: 'Default' },
	]))
	return rt.call_function('array_merge', [var_header_images.clone(), this.default_headers])
}

fn (mut this Class_Custom_Image_Header) get_uploaded_header_images() rt.PhpVal {
	mut var_header_images := rt.call_function('get_uploaded_header_images', []rt.PhpVal{})
	mut var_timestamp_key := rt.new_string('_wp_attachment_custom_header_last_used_' +
		(rt.call_function('get_stylesheet', []rt.PhpVal{})).str())
	mut var_alt_text_key := rt.new_string('_wp_attachment_image_alt')
	mut iter_5 := var_header_images.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_header_image := item_5.val
		mut var_header_meta := rt.call_function('get_post_meta', [
			var_header_image.array_get(rt.new_string('attachment_id')),
		])
		var_header_image.array_set('timestamp', if !(var_header_meta.array_get(var_timestamp_key)).is_null() {
			var_header_meta.array_get(var_timestamp_key)
		} else {
			rt.new_string('')
		})
		var_header_image.array_set('alt_text', if !(var_header_meta.array_get(var_alt_text_key)).is_null() {
			var_header_meta.array_get(var_alt_text_key)
		} else {
			rt.new_string('')
		})
	}
	return var_header_images.clone()
}

fn (mut this Class_Custom_Image_Header) get_previous_crop(var_attachment rt.PhpVal) bool {
	mut var_attachment_mutated := var_attachment
	mut var_header_images := this.get_uploaded_header_images()
	if !rt.is_true(var_header_images) {
		return false
	}
	mut var_previous := rt.new_bool(false)
	mut iter_6 := var_header_images.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_image := item_6.val
		if rt.is_true(rt.identical(var_image.array_get(rt.new_string('attachment_parent')),
			var_attachment_mutated.array_get(rt.new_string('post_parent'))))
		{
			var_previous = var_image.array_get(rt.new_string('attachment_id'))
			break
		}
	}
	return var_previous.to_bool()
}

fn create_custom_image_header(admin_image_div_callback string, arg_1 rt.PhpVal) &Class_Custom_Image_Header {
	mut obj := &Class_Custom_Image_Header{
		PhpObjectBase:            rt.PhpObjectBase{}
		admin_header_callback:    rt.new_null()
		admin_image_div_callback: rt.new_null()
		default_headers:          rt.new_array()
		updated:                  false
	}
	obj.construct(admin_image_div_callback, arg_1)
	return obj
}

fn (mut this Class_Custom_Image_Header) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'help' {
			this.help()
			return rt.new_null()
		}
		'step' {
			return rt.new_int(this.step())
		}
		'js_includes' {
			this.js_includes()
			return rt.new_null()
		}
		'css_includes' {
			this.css_includes()
			return rt.new_null()
		}
		'take_action' {
			this.take_action()
			return rt.new_null()
		}
		'process_default_headers' {
			this.process_default_headers()
			return rt.new_null()
		}
		'show_header_selector' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.show_header_selector(dispatch_arg_0)
			return rt.new_null()
		}
		'js' {
			this.js()
			return rt.new_null()
		}
		'js_1' {
			this.js_1()
			return rt.new_null()
		}
		'js_2' {
			this.js_2()
			return rt.new_null()
		}
		'step_1' {
			this.step_1()
			return rt.new_null()
		}
		'step_2' {
			return this.step_2()
		}
		'step_2_manage_upload' {
			return this.step_2_manage_upload()
		}
		'step_3' {
			return this.step_3()
		}
		'finished' {
			this.finished()
			return rt.new_null()
		}
		'admin_page' {
			this.admin_page()
			return rt.new_null()
		}
		'attachment_fields_to_edit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.attachment_fields_to_edit(dispatch_arg_0)
		}
		'filter_upload_tabs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_upload_tabs(dispatch_arg_0)
		}
		'set_header_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_header_image(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_header_image' {
			this.remove_header_image()
			return rt.new_null()
		}
		'reset_header_image' {
			this.reset_header_image()
			return rt.new_null()
		}
		'get_header_dimensions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_header_dimensions(dispatch_arg_0)
		}
		'create_attachment_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.create_attachment_object(dispatch_arg_0, dispatch_arg_1)
		}
		'insert_attachment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.insert_attachment(dispatch_arg_0, dispatch_arg_1)
		}
		'ajax_header_crop' {
			this.ajax_header_crop()
			return rt.new_null()
		}
		'ajax_header_add' {
			this.ajax_header_add()
			return rt.new_null()
		}
		'ajax_header_remove' {
			this.ajax_header_remove()
			return rt.new_null()
		}
		'customize_set_last_used' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.customize_set_last_used(dispatch_arg_0)
			return rt.new_null()
		}
		'get_default_header_images' {
			return this.get_default_header_images()
		}
		'get_uploaded_header_images' {
			return this.get_uploaded_header_images()
		}
		'get_previous_crop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_previous_crop(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Custom_Image_Header) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'admin_header_callback' { return this.admin_header_callback }
		'admin_image_div_callback' { return this.admin_image_div_callback }
		'default_headers' { return this.default_headers }
		'updated' { return rt.new_bool(this.updated) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Custom_Image_Header) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'admin_header_callback' {
			this.admin_header_callback = val
			return true
		}
		'admin_image_div_callback' {
			this.admin_image_div_callback = val
			return true
		}
		'default_headers' {
			this.default_headers = val
			return true
		}
		'updated' {
			this.updated = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
