import rt

struct Class_Custom_Background {
	rt.PhpObjectBase
pub mut:
		admin_header_callback rt.PhpVal = rt.new_null()
		admin_image_div_callback rt.PhpVal = rt.new_null()
		updated bool
}

fn (mut this Class_Custom_Background) construct(admin_header_callback string, admin_image_div_callback string)  {
	this.admin_header_callback = rt.new_string(admin_header_callback).dup()
	this.admin_image_div_callback = rt.new_string(admin_image_div_callback).dup()
	rt.call_function('add_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Background', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'init' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_custom-background-add'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Background', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'ajax_background_add' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_set-background-image'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Background', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'wp_set_background_image' }])])
}

fn (mut this Class_Custom_Background) init()  {
	mut var_page := rt.call_function('add_theme_page', [rt.call_function('_x', [rt.new_string('Background'), rt.new_string('custom background')]), rt.call_function('_x', [rt.new_string('Background'), rt.new_string('custom background')]), rt.new_string('edit_theme_options'), rt.new_string('custom-background'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Background', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_page' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_page)))) {
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string("load-${var_page.to_string()}"), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Background', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_load' }])])
	rt.call_function('add_action', [rt.new_string("load-${var_page.to_string()}"), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Background', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'take_action' }]), rt.new_int(49)])
	rt.call_function('add_action', [rt.new_string("load-${var_page.to_string()}"), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Custom_Background', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_upload' }]), rt.new_int(49)])
	if rt.is_true(this.admin_header_callback) {
		rt.call_function('add_action', [rt.new_string("admin_head-${var_page.to_string()}"), this.admin_header_callback, rt.new_int(51)])
	}
}

fn (mut this Class_Custom_Background) admin_load()  {
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('You can customize the look of your site without touching any of your theme&#8217;s code by using a custom background. Your background can be an image or a color.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('To use a background image, simply upload it or choose an image that has already been uploaded to your Media Library by clicking the &#8220;Choose Image&#8221; button. You can display a single instance of your image, or tile it to fill the screen. You can have your background fixed in place, so your site content moves on top of it, or you can have it scroll with your site.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You can also choose a background color by clicking the Select Color button and either typing in a legitimate HTML hex value, e.g. &#8220;#ff0000&#8221; for red, or by choosing a color using the color picker.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Do not forget to click on the Save Changes button when you are finished.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://codex.wordpress.org/Appearance_Background_Screen">Documentation on Custom Background</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	rt.call_function('wp_enqueue_media', []rt.PhpVal{})
	rt.call_function('wp_enqueue_script', [rt.new_string('custom-background')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-color-picker')])
}

fn (mut this Class_Custom_Background) take_action()  {
	if !rt.is_true(rt.get_superglobal('_POST')) {
		return rt.new_null()
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('reset-background')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-background-reset'), rt.new_string('_wpnonce-custom-background-reset')])
		rt.call_function('remove_theme_mod', [rt.new_string('background_image')])
		rt.call_function('remove_theme_mod', [rt.new_string('background_image_thumb')])
		this.updated = true
		return rt.new_null()
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('remove-background')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-background-remove'), rt.new_string('_wpnonce-custom-background-remove')])
		rt.call_function('set_theme_mod', [rt.new_string('background_image'), rt.new_string('')])
		rt.call_function('set_theme_mod', [rt.new_string('background_image_thumb'), rt.new_string('')])
		this.updated = true
		rt.call_function('wp_safe_redirect', [rt.get_superglobal('_POST').array_get('_wp_http_referer')])
		return rt.new_null()
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('background-preset')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-background')])
		if rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_POST').array_get('background-preset'), rt.create_array([rt.ArrayItem{ key: none, val: 'default' }, rt.ArrayItem{ key: none, val: 'fill' }, rt.ArrayItem{ key: none, val: 'fit' }, rt.ArrayItem{ key: none, val: 'repeat' }, rt.ArrayItem{ key: none, val: 'custom' }]), rt.new_bool(true)])) {
			mut var_preset := rt.get_superglobal('_POST').array_get('background-preset')
		} else {
			var_preset = rt.new_string(rt.new_string('default'))
		}
		rt.call_function('set_theme_mod', [rt.new_string('background_preset'), var_preset.dup()])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('background-position')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-background')])
		mut var_position := rt.call_function('explode', [rt.new_string(' '), rt.get_superglobal('_POST').array_get('background-position')])
		if rt.is_true(rt.call_function('in_array', [var_position.array_get(0), rt.create_array([rt.ArrayItem{ key: none, val: 'left' }, rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'right' }]), rt.new_bool(true)])) {
			mut var_position_x := var_position.array_get(0)
		} else {
			var_position_x = rt.new_string(rt.new_string('left'))
		}
		if rt.is_true(rt.call_function('in_array', [var_position.array_get(1), rt.create_array([rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'bottom' }]), rt.new_bool(true)])) {
			mut var_position_y := var_position.array_get(1)
		} else {
			var_position_y = rt.new_string(rt.new_string('top'))
		}
		rt.call_function('set_theme_mod', [rt.new_string('background_position_x'), var_position_x.dup()])
		rt.call_function('set_theme_mod', [rt.new_string('background_position_y'), var_position_y.dup()])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('background-size')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-background')])
		if rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_POST').array_get('background-size'), rt.create_array([rt.ArrayItem{ key: none, val: 'auto' }, rt.ArrayItem{ key: none, val: 'contain' }, rt.ArrayItem{ key: none, val: 'cover' }]), rt.new_bool(true)])) {
			mut var_size := rt.get_superglobal('_POST').array_get('background-size')
		} else {
			var_size = rt.new_string(rt.new_string('auto'))
		}
		rt.call_function('set_theme_mod', [rt.new_string('background_size'), var_size.dup()])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('background-repeat')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-background')])
		mut var_repeat := rt.get_superglobal('_POST').array_get('background-repeat')
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_repeat = rt.new_string(rt.new_string('repeat'))
		}
		rt.call_function('set_theme_mod', [rt.new_string('background_repeat'), var_repeat.dup()])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('background-attachment')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-background')])
		mut var_attachment := rt.get_superglobal('_POST').array_get('background-attachment')
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_attachment = rt.new_string(rt.new_string('scroll'))
		}
		rt.call_function('set_theme_mod', [rt.new_string('background_attachment'), var_attachment.dup()])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('background-color')) {
		rt.call_function('check_admin_referer', [rt.new_string('custom-background')])
		mut var_color := rt.call_function('preg_replace', [rt.new_string('/[^0-9a-fA-F]/'), rt.new_string(''), rt.get_superglobal('_POST').array_get('background-color')])
		if var_color.dup().to_string().len == 6 || var_color.dup().to_string().len == 3 {
			rt.call_function('set_theme_mod', [rt.new_string('background_color'), var_color.dup()])
		} else {
			rt.call_function('set_theme_mod', [rt.new_string('background_color'), rt.new_string('')])
		}
	}
	this.updated = true
}

fn (mut this Class_Custom_Background) admin_page()  {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Custom Background')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You can now manage and live-preview Custom Backgrounds in the <a href="%s">Customizer</a>.')]), rt.call_function('admin_url', [rt.new_string('customize.php?autofocus[control]=background_image')])])
		rt.call_function('wp_admin_notice', [var_message.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'hide-if-no-customize' }]) }])])
	}
	if !(!(this.updated)) {
		mut var_updated_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Background updated. <a href="%s">Visit your site</a> to see how it looks.')]), rt.call_function('esc_url', [rt.call_function('home_url', [rt.new_string('/')])])])
		rt.call_function('wp_admin_notice', [var_updated_message.dup(), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'updated' }]) }])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Background Image')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Preview'), rt.new_string('noun')]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(this.admin_image_div_callback) {
		rt.call_function('call_user_func', [this.admin_image_div_callback])
	} else {
		mut var_background_styles := rt.new_string(rt.new_string(''))
		mut var_bgcolor := rt.call_function('get_background_color', []rt.PhpVal{})
		if rt.is_true(var_bgcolor) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		mut var_background_image_thumb := rt.call_function('get_background_image', []rt.PhpVal{})
		if rt.is_true(var_background_image_thumb) {
			var_background_image_thumb = rt.call_function('esc_url', [rt.call_function('set_url_scheme', [rt.call_function('get_theme_mod', [rt.new_string('background_image_thumb'), rt.call_function('str_replace', [rt.new_string('%'), rt.new_string('%%'), var_background_image_thumb.dup()])])])])
			mut var_background_position_x := rt.call_function('get_theme_mod', [rt.new_string('background_position_x'), rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('default-position-x')])])
			mut var_background_position_y := rt.call_function('get_theme_mod', [rt.new_string('background_position_y'), rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('default-position-y')])])
			mut var_background_size := rt.call_function('get_theme_mod', [rt.new_string('background_size'), rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('default-size')])])
			mut var_background_repeat := rt.call_function('get_theme_mod', [rt.new_string('background_repeat'), rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('default-repeat')])])
			mut var_background_attachment := rt.call_function('get_theme_mod', [rt.new_string('background_attachment'), rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('default-attachment')])])
			// unsupported expression: Expr_AssignOp_Concat
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_background_styles)
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_background_image_thumb) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_background_image_thumb)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_background_image_thumb)
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('get_background_image', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Remove Image')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [, ])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Custom_Background) handle_upload()  {
	mut var__FILES := rt.new_null()
}

fn (mut this Class_Custom_Background) ajax_background_add()  {
}

fn (mut this Class_Custom_Background) attachment_fields_to_edit(var_form_fields rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Custom_Background) filter_upload_tabs(var_tabs rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Custom_Background) wp_set_background_image()  {
}

fn create_custom_background(admin_header_callback string, admin_image_div_callback string) &Class_Custom_Background {
	mut obj := &Class_Custom_Background{
		PhpObjectBase: rt.PhpObjectBase{}
		admin_header_callback: rt.new_null()
		admin_image_div_callback: rt.new_null()
		updated: false
	}
	obj.construct(admin_header_callback, admin_image_div_callback)
	return obj
}

fn (mut this Class_Custom_Background) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'admin_load' {
			this.admin_load()
			return rt.new_null()
		}
		'take_action' {
			this.take_action()
			return rt.new_null()
		}
		'admin_page' {
			this.admin_page()
			return rt.new_null()
		}
		'handle_upload' {
			this.handle_upload()
			return rt.new_null()
		}
		'ajax_background_add' {
			this.ajax_background_add()
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
		'wp_set_background_image' {
			this.wp_set_background_image()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Custom_Background) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'admin_header_callback' { return this.admin_header_callback }
		'admin_image_div_callback' { return this.admin_image_div_callback }
		'updated' { return rt.new_bool(this.updated) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Custom_Background) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'admin_header_callback' { this.admin_header_callback = val; return true }
		'admin_image_div_callback' { this.admin_image_div_callback = val; return true }
		'updated' { this.updated = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_admin_includes_class_custom_background_php() {
}
