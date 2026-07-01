import rt

struct Class_Custom_Image_Header {
	rt.PhpObjectBase
pub mut:
		admin_header_callback rt.PhpVal = rt.new_null()
		admin_image_div_callback rt.PhpVal = rt.new_null()
		default_headers rt.PhpVal = rt.new_array()
		updated bool
}

fn (mut this Class_Custom_Image_Header) construct(var_admin_header_callback rt.PhpVal, admin_image_div_callback string)  {
	this.admin_header_callback = var_admin_header_callback.dup()
	this.admin_image_div_callback = rt.new_string(admin_image_div_callback).dup()
	rt.call_function('add_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'init' }])])
	rt.call_function('add_action', [rt.new_string('customize_save_after'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'customize_set_last_used' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_custom-header-crop'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'ajax_header_crop' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_custom-header-add'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'ajax_header_add' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_custom-header-remove'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'ajax_header_remove' }])])
}

fn (mut this Class_Custom_Image_Header) init()  {
	mut var_page := rt.call_function('add_theme_page', [rt.call_function('_x', [rt.new_string('Header'), rt.new_string('custom image header')]), rt.call_function('_x', [rt.new_string('Header'), rt.new_string('custom image header')]), rt.new_string('edit_theme_options'), rt.new_string('custom-header'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_page' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_page)))) {
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string("admin_print_scripts-${var_page.to_string()}"), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'js_includes' }])])
	rt.call_function('add_action', [rt.new_string("admin_print_styles-${var_page.to_string()}"), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'css_includes' }])])
	rt.call_function('add_action', [rt.new_string("admin_head-${var_page.to_string()}"), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'help' }])])
	rt.call_function('add_action', [rt.new_string("admin_head-${var_page.to_string()}"), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'take_action' }]), rt.new_int(50)])
	rt.call_function('add_action', [rt.new_string("admin_head-${var_page.to_string()}"), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Image_Header', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'js' }]), rt.new_int(50)])
	if rt.is_true(this.admin_header_callback) {
		rt.call_function('add_action', [rt.new_string("admin_head-${var_page.to_string()}"), this.admin_header_callback, rt.new_int(51)])
	}
}

fn (mut this Class_Custom_Image_Header) help()  {
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('This screen is used to customize the header section of your theme.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You can choose from the theme&#8217;s default header images, or use one of your own. You can also customize how your Site Title and Tagline are displayed.')])).str() + '<p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'set-header-image' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Header Image')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('You can set a custom image header for your site. Simply upload the image and crop it, and the new header will go live immediately. Alternatively, you can use an image that has already been uploaded to your Media Library by clicking the &#8220;Choose Image&#8221; button.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Some themes come with additional header images bundled. If you see multiple images displayed, select the one you would like and click the &#8220;Save Changes&#8221; button.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('If your theme has more than one default header image, or you have uploaded more than one custom header image, you have the option of having WordPress display a randomly different image on each page of your site. Click the &#8220;Random&#8221; radio button next to the Uploaded Images or Default Images section to enable this feature.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('If you do not want a header image to be displayed on your site at all, click the &#8220;Remove Header Image&#8221; button at the bottom of the Header Image section of this page. If you want to re-enable the header image later, you just have to select one of the other image options and click &#8220;Save Changes&#8221;.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'set-header-text' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Header Text')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('For most themes, the header text is your Site Title and Tagline, as defined in the <a href="%s">General Settings</a> section.')]), rt.call_function('admin_url', [rt.new_string('options-general.php')])])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('In the Header Text section of this page, you can choose whether to display this text or hide it. You can also choose a color for the text by clicking the Select Color button and either typing in a legitimate HTML hex value, e.g. &#8220;#ff0000&#8221; for red, or by choosing a color using the color picker.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Do not forget to click &#8220;Save Changes&#8221; when you are done!')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://codex.wordpress.org/Appearance_Header_Screen">Documentation on Custom Header</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
}

fn (mut this Class_Custom_Image_Header) step() i64 {
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('step'))) {
		return 1
	}
	mut var_step := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.less(var_step, rt.new_int(1))) || rt.is_true(rt.less(rt.new_int(3), var_step)))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(2), var_step)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_REQUEST').array_get('_wpnonce-custom-header-upload'), rt.new_string('custom-header-upload')]))))))))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(3), var_step)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_REQUEST').array_get('_wpnonce'), rt.new_string('custom-header-crop-image')]))))))))) {
		return 1
	}
	return (var_step).to_i64()
}

fn (mut this Class_Custom_Image_Header) js_includes()  {
	mut var_step := rt.new_int(this.step())
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(1), var_step)) || rt.is_true(rt.identical(rt.new_int(3), var_step)))) {
		rt.call_function('wp_enqueue_media', []rt.PhpVal{})
		rt.call_function('wp_enqueue_script', [rt.new_string('custom-header')])
		if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('header-text')])) {
			rt.call_function('wp_enqueue_script', [rt.new_string('wp-color-picker')])
		}
	} else if rt.is_true(rt.identical(rt.new_int(2), var_step)) {
		rt.call_function('wp_enqueue_script', [rt.new_string('imgareaselect')])
	}
}

fn (mut this Class_Custom_Image_Header) css_includes()  {
	mut var_step := rt.new_int(this.step())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(1), var_step)) || rt.is_true(rt.identical(rt.new_int(3), var_step)))) && rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('header-text')])))) {
		rt.call_function('wp_enqueue_style', [rt.new_string('wp-color-picker')])
	} else if rt.is_true(rt.identical(rt.new_int(2), var_step)) {
		rt.call_function('wp_enqueue_style', [rt.new_string('imgareaselect')])
	}
}

fn (mut this Class_Custom_Image_Header) take_action()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))) {
		return rt.new_null()
	}
	if !rt.is_true(rt.get_superglobal('_POST')) {
		return rt.new_null()
	}
	this.updated = true
	if rt.get_superglobal('_POST').array_isset(rt.new_string('resetheader')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-header-options'), rt.new_string('_wpnonce-custom-header-options')])
		this.reset_header_image()
		return rt.new_null()
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('removeheader')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-header-options'), rt.new_string('_wpnonce-custom-header-options')])
		this.remove_header_image()
		return rt.new_null()
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('text-color')) && !(rt.get_superglobal('_POST').array_isset(rt.new_string('display-header-text'))) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-header-options'), rt.new_string('_wpnonce-custom-header-options')])
		rt.call_function('set_theme_mod', [rt.new_string('header_textcolor'), rt.new_string('blank')])
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('text-color')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-header-options'), rt.new_string('_wpnonce-custom-header-options')])
		rt.get_superglobal('_POST').array_set('text-color', rt.call_function('str_replace', [rt.new_string('#'), rt.new_string(''), rt.get_superglobal('_POST').array_get('text-color')]))
		mut var_color := rt.call_function('preg_replace', [rt.new_string('/[^0-9a-fA-F]/'), rt.new_string(''), rt.get_superglobal('_POST').array_get('text-color')])
		if var_color.dup().to_string().len == 6 || var_color.dup().to_string().len == 3 {
			rt.call_function('set_theme_mod', [rt.new_string('header_textcolor'), var_color.dup()])
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_color)))) {
			rt.call_function('set_theme_mod', [rt.new_string('header_textcolor'), rt.new_string('blank')])
		}
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('default-header')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-header-options'), rt.new_string('_wpnonce-custom-header-options')])
		this.set_header_image(rt.get_superglobal('_POST').array_get('default-header'))
		return rt.new_null()
	}
}

fn (mut this Class_Custom_Image_Header) process_default_headers()  {
	mut var__wp_default_headers := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!(var__wp_default_headers).is_null()) {
		return rt.new_null()
	}
	if !(!rt.is_true(this.default_headers)) {
		return rt.new_null()
	}
	this.default_headers = var__wp_default_headers.dup()
	mut var_template_directory_uri := rt.call_function('get_template_directory_uri', []rt.PhpVal{})
	mut var_stylesheet_directory_uri := rt.call_function('get_stylesheet_directory_uri', []rt.PhpVal{})
	{
		mut iter_1 := rt.func_array_keys(this.default_headers).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_header := item_1.val
			this.default_headers.array_get_mut(var_header).array_set('url', rt.call_function('sprintf', [this.default_headers.array_get(var_header).array_get('url'), var_template_directory_uri.dup(), var_stylesheet_directory_uri.dup()]))
			this.default_headers.array_get_mut(var_header).array_set('thumbnail_url', rt.call_function('sprintf', [this.default_headers.array_get(var_header).array_get('thumbnail_url'), var_template_directory_uri.dup(), var_stylesheet_directory_uri.dup()]))
		}
	}
}

fn (mut this Class_Custom_Image_Header) show_header_selector(type string)  {
	mut type_mutated := type
	if rt.is_true(rt.identical(rt.new_string('default'), rt.new_string(type_mutated))) {
		mut var_headers := this.default_headers
	} else {
		var_headers = rt.call_function('get_uploaded_header_images', []rt.PhpVal{})
		type_mutated = 'uploaded'
	}
	if 1 < var_headers.dup().array_count() {
		print('<div class="random-header">')
		print('<label><input name="default-header" type="radio" value="random-' + type_mutated + '-image"' + (rt.call_function('checked', [rt.call_function('is_random_header_image', [rt.new_string(type_mutated).dup()]), rt.new_bool(true), rt.new_bool(false)])).str() + ' />')
		rt.call_function('_e', [rt.new_string('<strong>Random:</strong> Show a different image on each page.')])
		print('</label>')
		print('</div>')
	}
	print('<div class="available-headers">')
	{
		mut iter_1 := var_headers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_header := item_1.val
			mut var_header_key := item_1.key
			mut var_header_thumbnail := var_header.array_get('thumbnail_url')
			mut var_header_url := var_header.array_get('url')
			mut var_header_alt_text := if !rt.is_true(var_header.array_get('alt_text')) { rt.new_string('') } else { var_header.array_get('alt_text') }
			print('<div class="default-header">')
			print('<label><input name="default-header" type="radio" value="' + (rt.call_function('esc_attr', [var_header_key.dup()])).str() + '" ' + (rt.call_function('checked', [var_header_url.dup(), rt.call_function('get_theme_mod', [rt.new_string('header_image')]), rt.new_bool(false)])).str() + ' />')
			mut var_width := rt.new_string(rt.new_string(''))
			if !(!rt.is_true(var_header.array_get('attachment_id'))) {
				var_width = rt.new_string(rt.new_string(' width="230"'))
			}
			print('<img src="' + (rt.call_function('esc_url', [rt.call_function('set_url_scheme', [var_header_thumbnail.dup()])])).str() + '" alt="' + (rt.call_function('esc_attr', [var_header_alt_text.dup()])).str() + '"' + (var_width).str() + ' /></label>')
			print('</div>')
		}
	}
	print('<div class="clear"></div></div>')
}

fn (mut this Class_Custom_Image_Header) js()  {
	mut var_step := rt.new_int(this.step())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(1), var_step)) || rt.is_true(rt.identical(rt.new_int(3), var_step)))) && rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('header-text')])))) {
		this.js_1()
	} else if rt.is_true(rt.identical(rt.new_int(2), var_step)) {
		this.js_2()
	}
}

fn (mut this Class_Custom_Image_Header) js_1()  {
	mut var_default_color := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('default-text-color')])) {
		var_default_color = rt.call_function('get_theme_support', [rt.new_string('custom-header'), rt.new_string('default-text-color')])
		if rt.is_true(rt.new_bool(rt.is_true(var_default_color) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_default_color.dup(), rt.new_string('#')]))))))) {
			var_default_color = rt.new_string('#' + (var_default_color).str())
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [var_default_color.dup()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('display_header_text', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Custom_Image_Header) js_2()  {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [rt.call_function('get_theme_support', [rt.new_string('custom-header'), rt.new_string('width')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [rt.call_function('get_theme_support', [rt.new_string('custom-header'), rt.new_string('height')])]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [, ]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [, ]))))))) {
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [, ]))))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val()
	}
	if rt.is_true() {
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Custom_Image_Header) step_1()  {
}

fn (mut this Class_Custom_Image_Header) step_2() rt.PhpVal {
	mut var_type := rt.new_null()
	mut var_attr := rt.new_null()
	return rt.new_null()
}

fn (mut this Class_Custom_Image_Header) step_2_manage_upload() rt.PhpVal {
	mut var__FILES := rt.new_null()
}

fn (mut this Class_Custom_Image_Header) step_3() rt.PhpVal {
}

fn (mut this Class_Custom_Image_Header) finished()  {
}

fn (mut this Class_Custom_Image_Header) admin_page()  {
}

fn (mut this Class_Custom_Image_Header) attachment_fields_to_edit(var_form_fields rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Custom_Image_Header) filter_upload_tabs(var_tabs rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Custom_Image_Header) set_header_image(var_choice rt.PhpVal)  {
	mut var_choice_mutated := var_choice
}

fn (mut this Class_Custom_Image_Header) remove_header_image()  {
}

fn (mut this Class_Custom_Image_Header) reset_header_image()  {
}

fn (mut this Class_Custom_Image_Header) get_header_dimensions(var_dimensions rt.PhpVal) rt.PhpVal {
	mut var_dimensions_mutated := var_dimensions
}

fn (mut this Class_Custom_Image_Header) create_attachment_object(var_cropped rt.PhpVal, var_parent_attachment_id rt.PhpVal) rt.PhpVal {
	mut var_cropped_mutated := var_cropped
}

fn (mut this Class_Custom_Image_Header) insert_attachment(var_attachment rt.PhpVal, var_cropped rt.PhpVal) rt.PhpVal {
	mut var_attachment_mutated := var_attachment
	mut var_cropped_mutated := var_cropped
}

fn (mut this Class_Custom_Image_Header) ajax_header_crop()  {
}

fn (mut this Class_Custom_Image_Header) ajax_header_add()  {
}

fn (mut this Class_Custom_Image_Header) ajax_header_remove()  {
}

fn (mut this Class_Custom_Image_Header) customize_set_last_used(var_wp_customize rt.PhpVal)  {
}

fn (mut this Class_Custom_Image_Header) get_default_header_images() rt.PhpVal {
}

fn (mut this Class_Custom_Image_Header) get_uploaded_header_images() rt.PhpVal {
}

fn (mut this Class_Custom_Image_Header) get_previous_crop(var_attachment rt.PhpVal) bool {
	mut var_attachment_mutated := var_attachment
}

fn create_custom_image_header(admin_image_div_callback string, arg_1 rt.PhpVal) &Class_Custom_Image_Header {
	mut obj := &Class_Custom_Image_Header{
		PhpObjectBase: rt.PhpObjectBase{}
		admin_header_callback: rt.new_null()
		admin_image_div_callback: rt.new_null()
		default_headers: rt.new_array()
		updated: false
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
		else { return none }
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
		'admin_header_callback' { this.admin_header_callback = val; return true }
		'admin_image_div_callback' { this.admin_image_div_callback = val; return true }
		'default_headers' { this.default_headers = val; return true }
		'updated' { this.updated = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_admin_includes_class_custom_image_header_php() {
}
