import rt

struct Class_WP_Customize_Header_Image_Control {
	rt.PhpObjectBase
pub mut:
	prop_type        rt.PhpVal = rt.new_string('header')
	uploaded_headers rt.PhpVal = rt.new_null()
	default_headers  rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Customize_Header_Image_Control) construct(var_manager rt.PhpVal) {
	this.Class_WP_Customize_Image_Control.construct(var_manager.clone(),
		rt.new_string('header_image'), rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Header Image'),
		]) },
		rt.ArrayItem{ key: 'settings', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'header_image' },
			rt.ArrayItem{ key: 'data', val: 'header_image_data' },
		]) },
		rt.ArrayItem{ key: 'section', val: 'header_image' },
		rt.ArrayItem{ key: 'removed', val: 'remove-header' },
		rt.ArrayItem{ key: 'get_url', val: 'get_header_image' },
	]))
}

fn (mut this Class_WP_Customize_Header_Image_Control) enqueue() {
	rt.call_function('wp_enqueue_media', []rt.PhpVal{})
	rt.call_function('wp_enqueue_script', [rt.new_string('customize-views')])
	this.prepare_control()
	rt.call_function('wp_localize_script', [rt.new_string('customize-views'),
		rt.new_string('_wpCustomizeHeader'),
		rt.create_array([
			rt.ArrayItem{ key: 'data', val: rt.create_array([
				rt.ArrayItem{ key: 'width', val: rt.call_function('absint', [
					rt.call_function('get_theme_support', [
						rt.new_string('custom-header'),
						rt.new_string('width'),
					]),
				]) },
				rt.ArrayItem{ key: 'height', val: rt.call_function('absint', [
					rt.call_function('get_theme_support', [
						rt.new_string('custom-header'),
						rt.new_string('height'),
					]),
				]) },
				rt.ArrayItem{ key: 'flex-width', val: rt.call_function('absint', [
					rt.call_function('get_theme_support', [
						rt.new_string('custom-header'),
						rt.new_string('flex-width'),
					]),
				]) },
				rt.ArrayItem{ key: 'flex-height', val: rt.call_function('absint', [
					rt.call_function('get_theme_support', [
						rt.new_string('custom-header'),
						rt.new_string('flex-height'),
					]),
				]) },
				rt.ArrayItem{ key: 'currentImgSrc', val: this.get_current_image_src() },
			]) },
			rt.ArrayItem{ key: 'nonces', val: rt.create_array([
				rt.ArrayItem{ key: 'add', val: rt.call_function('wp_create_nonce', [
					rt.new_string('header-add'),
				]) },
				rt.ArrayItem{ key: 'remove', val: rt.call_function('wp_create_nonce', [
					rt.new_string('header-remove'),
				]) },
			]) },
			rt.ArrayItem{ key: 'uploads', val: this.uploaded_headers },
			rt.ArrayItem{ key: 'defaults', val: this.default_headers },
		])])
	this.Class_WP_Customize_Image_Control.enqueue()
}

fn (mut this Class_WP_Customize_Header_Image_Control) prepare_control() {
	mut var_custom_image_header := rt.new_null()
	if !rt.is_true(var_custom_image_header) {
		return
	}
	rt.call_function('add_action', [
		rt.new_string('customize_controls_print_footer_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Header_Image_Control', [
				'WP_Customize_Image_Control',
			], &this) },
			rt.ArrayItem{ key: none, val: 'print_header_image_template' },
		]),
	])
	rt.call_method(var_custom_image_header, 'process_default_headers', []rt.PhpVal{})
	this.default_headers = rt.call_method(var_custom_image_header, 'get_default_header_images',
		[]rt.PhpVal{})
	this.uploaded_headers = rt.call_method(var_custom_image_header, 'get_uploaded_header_images',
		[]rt.PhpVal{})
}

fn (mut this Class_WP_Customize_Header_Image_Control) print_header_image_template() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Randomize uploaded headers')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Randomize suggested headers')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Set image')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Remove image')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Randomizing uploaded headers')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Randomizing suggested headers')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Header_Image_Control) get_current_image_src() rt.PhpVal {
	mut var_src := this.value()
	if !(rt.get_property(rt.new_object('WP_Customize_Header_Image_Control', [
		'WP_Customize_Image_Control',
	], &this), 'get_url')).is_null() {
		var_src = rt.call_function('call_user_func', [
			rt.get_property(rt.new_object('WP_Customize_Header_Image_Control', [
				'WP_Customize_Image_Control',
			], &this), 'get_url'),
			var_src.clone(),
		])
		return var_src.clone()
	}
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Header_Image_Control) render_content() {
	mut var_visibility := rt.new_string((if rt.is_true(this.get_current_image_src()) {
		''
	} else {
		' style="display:none" '
	}).str())
	mut var_width := rt.call_function('absint', [
		rt.call_function('get_theme_support', [rt.new_string('custom-header'),
			rt.new_string('width')]),
	])
	mut var_height := rt.call_function('absint', [
		rt.call_function('get_theme_support', [rt.new_string('custom-header'),
			rt.new_string('height')]),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
		rt.new_string('video'),
	]))
	{
		print('<span class="customize-control-title">' +
			(rt.get_property(rt.new_object('WP_Customize_Header_Image_Control', ['WP_Customize_Image_Control'], &this), 'label')).str() +
			'</span>')
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
		rt.new_string('video'),
	]))
	{
		rt.call_function('_e', [
			rt.new_string('Click &#8220;Add Image&#8221; to upload an image file from your computer. Your theme works best with an image that matches the size of your video &#8212; you&#8217;ll be able to crop your image once you upload it for a perfect fit.'),
		])
	} else if rt.is_true(var_width) && rt.is_true(var_height) {
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('Click &#8220;Add Image&#8221; to upload an image file from your computer. Your theme works best with an image with a header size of %s pixels &#8212; you&#8217;ll be able to crop your image once you upload it for a perfect fit.'),
			]),
			rt.call_function('sprintf', [
				rt.new_string('<strong>%s &times; %s</strong>'),
				var_width.clone(),
				var_height.clone(),
			]),
		])
	} else if rt.is_true(var_width) {
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('Click &#8220;Add Image&#8221; to upload an image file from your computer. Your theme works best with an image with a header width of %s pixels &#8212; you&#8217;ll be able to crop your image once you upload it for a perfect fit.'),
			]),
			rt.call_function('sprintf', [
				rt.new_string('<strong>%s</strong>'),
				var_width.clone(),
			]),
		])
	} else {
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('Click &#8220;Add Image&#8221; to upload an image file from your computer. Your theme works best with an image with a header height of %s pixels &#8212; you&#8217;ll be able to crop your image once you upload it for a perfect fit.'),
			]),
			rt.call_function('sprintf', [
				rt.new_string('<strong>%s</strong>'),
				var_height.clone(),
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Current header')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_files')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_visibility)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Hide header image')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Hide image')])
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.new_bool(!(rt.is_true(this.get_current_image_src())))) {
			''
		} else {
			'customize-header-image-not-selected'
		})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Add Header Image')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Add Image')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Previously uploaded'),
		rt.new_string('custom headers')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Suggested'), rt.new_string('custom headers')])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Customize_Image_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_header_image_control(arg_0 rt.PhpVal) &Class_WP_Customize_Header_Image_Control {
	mut obj := &Class_WP_Customize_Header_Image_Control{
		PhpObjectBase:    rt.PhpObjectBase{}
		prop_type:        rt.new_string('header')
		uploaded_headers: rt.new_null()
		default_headers:  rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_customize_image_control(_args ...rt.PhpVal) &Class_WP_Customize_Image_Control {
	mut obj := &Class_WP_Customize_Image_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Header_Image_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'enqueue' {
			this.enqueue()
			return rt.new_null()
		}
		'prepare_control' {
			this.prepare_control()
			return rt.new_null()
		}
		'print_header_image_template' {
			this.print_header_image_template()
			return rt.new_null()
		}
		'get_current_image_src' {
			return this.get_current_image_src()
		}
		'render_content' {
			this.render_content()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Header_Image_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'uploaded_headers' { return this.uploaded_headers }
		'default_headers' { return this.default_headers }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Header_Image_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'uploaded_headers' {
			this.uploaded_headers = val
			return true
		}
		'default_headers' {
			this.default_headers = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Customize_Image_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Image_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Image_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
