import rt

struct Class_WP_Customize_Media_Control {
	rt.PhpObjectBase
pub mut:
	prop_type     rt.PhpVal = rt.new_string('media')
	mime_type     rt.PhpVal = rt.new_string('')
	button_labels rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Customize_Media_Control) construct(var_manager rt.PhpVal, var_id rt.PhpVal, var_args rt.PhpVal) {
	this.Class_WP_Customize_Control.construct(var_manager.dup(), var_id.dup(), var_args.dup())
	this.button_labels = rt.call_function('wp_parse_args', [this.button_labels,
		this.get_default_button_labels()])
}

fn (mut this Class_WP_Customize_Media_Control) enqueue() {
	rt.call_function('wp_enqueue_media', []rt.PhpVal{})
}

fn (mut this Class_WP_Customize_Media_Control) to_json() {
	this.Class_WP_Customize_Control.to_json()
	rt.get_property(rt.new_object('WP_Customize_Media_Control', [
		'WP_Customize_Control',
	], &this), 'json').array_set('label', rt.call_function('html_entity_decode', [
		rt.get_property(rt.new_object('WP_Customize_Media_Control', [
			'WP_Customize_Control',
		], &this), 'label'),
		rt.get_constant('ENT_QUOTES'),
		rt.call_function('get_bloginfo', [
			rt.new_string('charset'),
		]),
	]))
	rt.get_property(rt.new_object('WP_Customize_Media_Control', [
		'WP_Customize_Control',
	], &this), 'json').array_set('mime_type', this.mime_type)
	rt.get_property(rt.new_object('WP_Customize_Media_Control', [
		'WP_Customize_Control',
	], &this), 'json').array_set('button_labels', this.button_labels)
	rt.get_property(rt.new_object('WP_Customize_Media_Control', [
		'WP_Customize_Control',
	], &this), 'json').array_set('canUpload', rt.call_function('current_user_can', [
		rt.new_string('upload_files'),
	]))
	mut var_value := this.value()
	if rt.is_true(rt.new_bool(rt.get_property(rt.new_object('WP_Customize_Media_Control', [
		'WP_Customize_Control',
	], &this), 'setting').is_object()))
	{
		if rt.is_true(rt.get_property(rt.get_property(rt.new_object('WP_Customize_Media_Control', [
			'WP_Customize_Control',
		], &this), 'setting'), 'default'))
		{
			mut var_ext := rt.call_function('wp_check_filetype', [
				rt.get_property(rt.get_property(rt.new_object('WP_Customize_Media_Control', [
					'WP_Customize_Control',
				], &this), 'setting'), 'default'),
			]).array_get('ext')
			mut var_ext_types := rt.call_function('wp_get_ext_types', []rt.PhpVal{})
			mut var_type := rt.new_string(if rt.is_true(rt.new_bool(
				var_ext_types.array_isset(rt.new_string('image'))
				&& rt.is_true(rt.call_function('in_array', [var_ext.dup(), var_ext_types.array_get('image'), rt.new_bool(true)]))))
			{
				rt.new_string('image')
			} else {
				rt.new_string('document')
			})
			mut var_default_attachment := {
				'id':    rt.new_int(1)
				'url':   rt.get_property(rt.get_property(rt.new_object('WP_Customize_Media_Control', [
					'WP_Customize_Control',
				], &this), 'setting'), 'default')
				'type':  var_type
				'icon':  rt.call_function('wp_mime_type_icon', [
					var_type.dup(), rt.new_string('.svg')])
				'title': rt.call_function('wp_basename', [
					rt.get_property(rt.get_property(rt.new_object('WP_Customize_Media_Control', [
						'WP_Customize_Control',
					], &this), 'setting'), 'default'),
				])
			}
			if rt.is_true(rt.identical(rt.new_string('image'), var_type)) {
				var_default_attachment['sizes'] = rt.create_array([
					rt.ArrayItem{ key: 'full', val: rt.create_array([
						rt.ArrayItem{ key: 'url', val: rt.get_property(rt.get_property(rt.new_object('WP_Customize_Media_Control', [
							'WP_Customize_Control',
						], &this), 'setting'), 'default') },
					]) },
				])
			}
			rt.get_property(rt.new_object('WP_Customize_Media_Control', [
				'WP_Customize_Control',
			], &this), 'json').array_set('defaultAttachment', var_default_attachment.dup())
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_value)
			&& rt.is_true(rt.get_property(rt.get_property(rt.new_object('WP_Customize_Media_Control', ['WP_Customize_Control'], &this), 'setting'), 'default'))))
			&& rt.is_true(rt.identical(var_value, rt.get_property(rt.get_property(rt.new_object('WP_Customize_Media_Control', ['WP_Customize_Control'], &this), 'setting'), 'default')))))
		{
			rt.get_property(rt.new_object('WP_Customize_Media_Control', [
				'WP_Customize_Control',
			], &this), 'json').array_set('attachment', rt.get_property(rt.new_object('WP_Customize_Media_Control', [
				'WP_Customize_Control',
			], &this), 'json').array_get('defaultAttachment'))
		} else if rt.is_true(var_value) {
			rt.get_property(rt.new_object('WP_Customize_Media_Control', [
				'WP_Customize_Control',
			], &this), 'json').array_set('attachment', rt.call_function('wp_prepare_attachment_for_js', [
				var_value.dup(),
			]))
		}
	}
}

fn (mut this Class_WP_Customize_Media_Control) render_content() {
}

fn (mut this Class_WP_Customize_Media_Control) content_template() {
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Media_Control) get_default_button_labels() {
	mut var_mime_type := if !(!rt.is_true(this.mime_type)) { rt.call_function('strtok', [
			rt.new_string(this.mime_type.to_string().trim_left(' \t\n\r')),
			rt.new_string('/'),
		]) } else { rt.new_string('default') }
	mut switch_val_1 := var_mime_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('video'))) {
		return rt.create_array([
			rt.ArrayItem{ key: 'select', val: rt.call_function('__', [
				rt.new_string('Select video'),
			]) },
			rt.ArrayItem{ key: 'change', val: rt.call_function('__', [
				rt.new_string('Change video'),
			]) },
			rt.ArrayItem{ key: 'default', val: rt.call_function('__', [
				rt.new_string('Default'),
			]) },
			rt.ArrayItem{ key: 'remove', val: rt.call_function('__', [
				rt.new_string('Remove'),
			]) },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('No video selected'),
			]) },
			rt.ArrayItem{ key: 'frame_title', val: rt.call_function('__', [
				rt.new_string('Select video'),
			]) },
			rt.ArrayItem{ key: 'frame_button', val: rt.call_function('__', [
				rt.new_string('Choose video'),
			]) },
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('audio'))) {
		return rt.create_array([
			rt.ArrayItem{ key: 'select', val: rt.call_function('__', [
				rt.new_string('Select audio'),
			]) },
			rt.ArrayItem{ key: 'change', val: rt.call_function('__', [
				rt.new_string('Change audio'),
			]) },
			rt.ArrayItem{ key: 'default', val: rt.call_function('__', [
				rt.new_string('Default'),
			]) },
			rt.ArrayItem{ key: 'remove', val: rt.call_function('__', [
				rt.new_string('Remove'),
			]) },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('No audio selected'),
			]) },
			rt.ArrayItem{ key: 'frame_title', val: rt.call_function('__', [
				rt.new_string('Select audio'),
			]) },
			rt.ArrayItem{ key: 'frame_button', val: rt.call_function('__', [
				rt.new_string('Choose audio'),
			]) },
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image'))) {
		return rt.create_array([
			rt.ArrayItem{ key: 'select', val: rt.call_function('__', [
				rt.new_string('Select image'),
			]) },
			rt.ArrayItem{ key: 'site_icon', val: rt.call_function('__', [
				rt.new_string('Select Site Icon'),
			]) },
			rt.ArrayItem{ key: 'change', val: rt.call_function('__', [
				rt.new_string('Change image'),
			]) },
			rt.ArrayItem{ key: 'default', val: rt.call_function('__', [
				rt.new_string('Default'),
			]) },
			rt.ArrayItem{ key: 'remove', val: rt.call_function('__', [
				rt.new_string('Remove'),
			]) },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('No image selected'),
			]) },
			rt.ArrayItem{ key: 'frame_title', val: rt.call_function('__', [
				rt.new_string('Select image'),
			]) },
			rt.ArrayItem{ key: 'frame_button', val: rt.call_function('__', [
				rt.new_string('Choose image'),
			]) },
		])
	} else {
		return rt.create_array([
			rt.ArrayItem{ key: 'select', val: rt.call_function('__', [
				rt.new_string('Select file'),
			]) },
			rt.ArrayItem{ key: 'change', val: rt.call_function('__', [
				rt.new_string('Change file'),
			]) },
			rt.ArrayItem{ key: 'default', val: rt.call_function('__', [
				rt.new_string('Default'),
			]) },
			rt.ArrayItem{ key: 'remove', val: rt.call_function('__', [
				rt.new_string('Remove'),
			]) },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('No file selected'),
			]) },
			rt.ArrayItem{ key: 'frame_title', val: rt.call_function('__', [
				rt.new_string('Select file'),
			]) },
			rt.ArrayItem{ key: 'frame_button', val: rt.call_function('__', [
				rt.new_string('Choose file'),
			]) },
		])
	}
	// unsupported statement: Stmt_Nop
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_media_control(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Customize_Media_Control {
	mut obj := &Class_WP_Customize_Media_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('media')
		mime_type:     rt.new_string('')
		button_labels: rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wp_customize_control() &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Media_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'enqueue' {
			this.enqueue()
			return rt.new_null()
		}
		'to_json' {
			this.to_json()
			return rt.new_null()
		}
		'render_content' {
			this.render_content()
			return rt.new_null()
		}
		'content_template' {
			this.content_template()
			return rt.new_null()
		}
		'get_default_button_labels' {
			this.get_default_button_labels()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Media_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'mime_type' { return this.mime_type }
		'button_labels' { return this.button_labels }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Media_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'mime_type' {
			this.mime_type = val
			return true
		}
		'button_labels' {
			this.button_labels = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Customize_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_customize_class_wp_customize_media_control_php() {
}
