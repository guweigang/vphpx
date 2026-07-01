import rt

struct Class_WP_Widget_Media_Audio {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Widget_Media_Audio) construct() {
	this.Class_WP_Widget_Media.construct(rt.new_string('media_audio'), rt.call_function('__', [
		rt.new_string('Audio'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Displays an audio player.'),
		]) },
		rt.ArrayItem{ key: 'mime_type', val: 'audio' },
	]))
	this.dispatch_set_prop('l10n', rt.call_function('array_merge', [
		rt.get_property(rt.new_object('WP_Widget_Media_Audio', ['WP_Widget_Media'], &this), 'l10n'),
		rt.create_array([rt.ArrayItem{ key: 'no_media_selected', val: rt.call_function('__', [
			rt.new_string('No audio selected'),
		]) }, rt.ArrayItem{ key: 'add_media', val: rt.call_function('_x', [
			rt.new_string('Add Audio'),
			rt.new_string('label for button in the audio widget'),
		]) }, rt.ArrayItem{ key: 'replace_media', val: rt.call_function('_x', [
			rt.new_string('Replace Audio'),
			rt.new_string('label for button in the audio widget; should preferably not be longer than ~13 characters long'),
		]) }, rt.ArrayItem{ key: 'edit_media', val: rt.call_function('_x', [
			rt.new_string('Edit Audio'),
			rt.new_string('label for button in the audio widget; should preferably not be longer than ~13 characters long'),
		]) }, rt.ArrayItem{ key: 'missing_attachment', val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('That audio file cannot be found. Check your <a href="%s">media library</a> and make sure it was not deleted.'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [rt.new_string('upload.php')]),
			]),
		]) }, rt.ArrayItem{ key: 'media_library_state_multi', val: rt.call_function('_n_noop', [
			rt.new_string('Audio Widget (%d)'),
			rt.new_string('Audio Widget (%d)'),
		]) }, rt.ArrayItem{ key: 'media_library_state_single', val: rt.call_function('__', [
			rt.new_string('Audio Widget'),
		]) }, rt.ArrayItem{ key: 'unsupported_file_type', val: rt.call_function('__', [
			rt.new_string('Looks like this is not the correct kind of file. Please link to an audio file instead.'),
		]) }]),
	]))
}

fn (mut this Class_WP_Widget_Media_Audio) get_instance_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: 'preload', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'enum', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'none' },
				rt.ArrayItem{ key: none, val: 'auto' },
				rt.ArrayItem{ key: none, val: 'metadata' },
			]) },
			rt.ArrayItem{ key: 'default', val: 'none' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Preload'),
			]) },
		]) },
		rt.ArrayItem{ key: 'loop', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{ key: 'default', val: false },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Loop'),
			]) },
		]) },
	])
	{
		mut iter_1 := rt.call_function('wp_get_audio_extensions', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_audio_extension := item_1.val
			var_schema.array_set(var_audio_extension, rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'format', val: 'uri' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('URL to the %s audio source file'),
					]),
					var_audio_extension.dup(),
				]) },
			]))
		}
	}
	return rt.call_function('array_merge', [var_schema.dup(),
		this.Class_WP_Widget_Media.get_instance_schema()])
}

fn (mut this Class_WP_Widget_Media_Audio) render_media(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('array_merge', [
		rt.call_function('wp_list_pluck', [this.get_instance_schema(),
			rt.new_string('default')]),
		var_instance_mutated.dup(),
	])
	mut var_attachment := rt.new_null()
	if rt.is_true(this.is_attachment_with_mime_type(var_instance_mutated.array_get('attachment_id'), rt.get_property(rt.new_object('WP_Widget_Media_Audio', [
		'WP_Widget_Media',
	], &this), 'widget_options').array_get('mime_type')))
	{
		var_attachment = rt.call_function('get_post',
			[var_instance_mutated.array_get('attachment_id')])
	}
	if rt.is_true(var_attachment) {
		mut var_src := rt.call_function('wp_get_attachment_url', [
			rt.get_property(var_attachment, 'ID'),
		])
	} else {
		var_src = var_instance_mutated.array_get('url')
	}
	rt.echo_val(rt.call_function('wp_audio_shortcode', [
		rt.call_function('array_merge', [var_instance_mutated.dup(),
			rt.call_function('compact', [rt.new_string('src')])]),
	]))
}

fn (mut this Class_WP_Widget_Media_Audio) enqueue_preview_scripts() {
	if rt.is_true(rt.identical(rt.new_string('mediaelement'), rt.call_function('apply_filters', [
		rt.new_string('wp_audio_shortcode_library'),
		rt.new_string('mediaelement'),
	])))
	{
		rt.call_function('wp_enqueue_style', [rt.new_string('wp-mediaelement')])
		rt.call_function('wp_enqueue_script', [rt.new_string('wp-mediaelement')])
	}
}

fn (mut this Class_WP_Widget_Media_Audio) enqueue_admin_scripts() {
	this.Class_WP_Widget_Media.enqueue_admin_scripts()
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-mediaelement')])
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-mediaelement')])
	mut var_handle := rt.new_string(rt.new_string('media-audio-widget'))
	rt.call_function('wp_enqueue_script', [var_handle.dup()])
	mut var_exported_schema := rt.new_array()
	{
		mut iter_1 := this.get_instance_schema().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field_schema := item_1.val
			mut var_field := item_1.key
			var_exported_schema.array_set(var_field, rt.call_function('wp_array_slice_assoc', [
				var_field_schema.dup(),
				rt.create_array([rt.ArrayItem{ key: none, val: 'type' },
					rt.ArrayItem{ key: none, val: 'default' },
					rt.ArrayItem{ key: none, val: 'enum' }, rt.ArrayItem{ key: none, val: 'minimum' },
					rt.ArrayItem{ key: none, val: 'format' },
					rt.ArrayItem{ key: none, val: 'media_prop' },
					rt.ArrayItem{ key: none, val: 'should_preview_update' }]),
			]))
		}
	}
	rt.call_function('wp_add_inline_script', [var_handle.dup(),
		rt.call_function('sprintf', [
			rt.new_string('wp.mediaWidgets.modelConstructors[ %s ].prototype.schema = %s;'),
			rt.call_function('wp_json_encode', [
				rt.get_property(rt.new_object('WP_Widget_Media_Audio', [
					'WP_Widget_Media',
				], &this), 'id_base'),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
			rt.call_function('wp_json_encode', [
				var_exported_schema.dup(),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
		])])
	rt.call_function('wp_add_inline_script', [var_handle.dup(),
		rt.call_function('sprintf', [
			rt.new_string('\n\t\t\t\t\twp.mediaWidgets.controlConstructors[ %1$s ].prototype.mime_type = %2$s;\n\t\t\t\t\twp.mediaWidgets.controlConstructors[ %1$s ].prototype.l10n = _.extend( {}, wp.mediaWidgets.controlConstructors[ %1$s ].prototype.l10n, %3$s );\n\t\t\t\t'),
			rt.call_function('wp_json_encode', [
				rt.get_property(rt.new_object('WP_Widget_Media_Audio', [
					'WP_Widget_Media',
				], &this), 'id_base'),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
			rt.call_function('wp_json_encode', [
				rt.get_property(rt.new_object('WP_Widget_Media_Audio', [
					'WP_Widget_Media',
				], &this), 'widget_options').array_get('mime_type'),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
			rt.call_function('wp_json_encode', [
				rt.get_property(rt.new_object('WP_Widget_Media_Audio', [
					'WP_Widget_Media',
				], &this), 'l10n'),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
		])])
}

fn (mut this Class_WP_Widget_Media_Audio) render_control_template_scripts() {
	this.Class_WP_Widget_Media.render_control_template_scripts()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_notice', [rt.get_property(rt.new_object('WP_Widget_Media_Audio', [
		'WP_Widget_Media',
	], &this), 'l10n').array_get('missing_attachment'),
		rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'notice-alt' },
				rt.ArrayItem{ key: none, val: 'notice-missing-attachment' },
			]) },
		])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_notice', [
		rt.call_function('__', [
			rt.new_string('Unable to preview media due to an unknown error.'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'notice-alt' },
			]) },
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_underscore_audio_template', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Widget_Media {
	rt.PhpObjectBase
}

fn create_wp_widget_media_audio() &Class_WP_Widget_Media_Audio {
	mut obj := &Class_WP_Widget_Media_Audio{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_widget_media() &Class_WP_Widget_Media {
	mut obj := &Class_WP_Widget_Media{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Widget_Media_Audio) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_instance_schema' {
			return this.get_instance_schema()
		}
		'render_media' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.render_media(dispatch_arg_0)
			return rt.new_null()
		}
		'enqueue_preview_scripts' {
			this.enqueue_preview_scripts()
			return rt.new_null()
		}
		'enqueue_admin_scripts' {
			this.enqueue_admin_scripts()
			return rt.new_null()
		}
		'render_control_template_scripts' {
			this.render_control_template_scripts()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Widget_Media_Audio) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget_Media_Audio) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Widget_Media) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Widget_Media) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget_Media) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_widgets_class_wp_widget_media_audio_php() {
}
