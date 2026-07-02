import rt

struct Class_WP_Widget_Media_Image {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Widget_Media_Image) construct() {
	this.Class_WP_Widget_Media.construct(rt.new_string('media_image'), rt.call_function('__', [
		rt.new_string('Image'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Displays an image.'),
		]) },
		rt.ArrayItem{ key: 'mime_type', val: 'image' },
	]))
	this.dispatch_set_prop('l10n', rt.call_function('array_merge', [
		rt.get_property(rt.new_object('WP_Widget_Media_Image', ['WP_Widget_Media'], &this), 'l10n'),
		rt.create_array([rt.ArrayItem{ key: 'no_media_selected', val: rt.call_function('__', [
			rt.new_string('No image selected'),
		]) }, rt.ArrayItem{ key: 'add_media', val: rt.call_function('_x', [
			rt.new_string('Add Image'),
			rt.new_string('label for button in the image widget'),
		]) }, rt.ArrayItem{ key: 'replace_media', val: rt.call_function('_x', [
			rt.new_string('Replace Image'),
			rt.new_string('label for button in the image widget; should preferably not be longer than ~13 characters long'),
		]) }, rt.ArrayItem{ key: 'edit_media', val: rt.call_function('_x', [
			rt.new_string('Edit Image'),
			rt.new_string('label for button in the image widget; should preferably not be longer than ~13 characters long'),
		]) }, rt.ArrayItem{ key: 'missing_attachment', val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('That image cannot be found. Check your <a href="%s">media library</a> and make sure it was not deleted.'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [rt.new_string('upload.php')]),
			]),
		]) }, rt.ArrayItem{ key: 'media_library_state_multi', val: rt.call_function('_n_noop', [
			rt.new_string('Image Widget (%d)'),
			rt.new_string('Image Widget (%d)'),
		]) }, rt.ArrayItem{ key: 'media_library_state_single', val: rt.call_function('__', [
			rt.new_string('Image Widget'),
		]) }]),
	]))
}

fn (mut this Class_WP_Widget_Media_Image) get_instance_schema() rt.PhpVal {
	return rt.call_function('array_merge', [
		rt.create_array([
			rt.ArrayItem{ key: 'size', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [
					rt.call_function('get_intermediate_image_sizes', []rt.PhpVal{}),
					rt.create_array([rt.ArrayItem{ key: none, val: 'full' },
						rt.ArrayItem{ key: none, val: 'custom' }]),
				]) },
				rt.ArrayItem{ key: 'default', val: 'medium' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Size'),
				]) },
			]) },
			rt.ArrayItem{ key: 'width', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'minimum', val: 0 },
				rt.ArrayItem{ key: 'default', val: 0 },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Width'),
				]) },
			]) },
			rt.ArrayItem{ key: 'height', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'minimum', val: 0 },
				rt.ArrayItem{ key: 'default', val: 0 },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Height'),
				]) },
			]) },
			rt.ArrayItem{ key: 'caption', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_kses_post' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Caption'),
				]) },
				rt.ArrayItem{ key: 'should_preview_update', val: false },
			]) },
			rt.ArrayItem{ key: 'alt', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Alternative Text'),
				]) },
			]) },
			rt.ArrayItem{ key: 'link_type', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'enum', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'none' },
					rt.ArrayItem{ key: none, val: 'file' },
					rt.ArrayItem{ key: none, val: 'post' },
					rt.ArrayItem{ key: none, val: 'custom' },
				]) },
				rt.ArrayItem{ key: 'default', val: 'custom' },
				rt.ArrayItem{ key: 'media_prop', val: 'link' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Link To'),
				]) },
				rt.ArrayItem{ key: 'should_preview_update', val: true },
			]) },
			rt.ArrayItem{ key: 'link_url', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'format', val: 'uri' },
				rt.ArrayItem{ key: 'media_prop', val: 'linkUrl' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('URL'),
				]) },
				rt.ArrayItem{ key: 'should_preview_update', val: true },
			]) },
			rt.ArrayItem{ key: 'image_classes', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Media_Image', [
						'WP_Widget_Media'], &this) },
					rt.ArrayItem{ key: none, val: 'sanitize_token_list' },
				]) },
				rt.ArrayItem{ key: 'media_prop', val: 'extraClasses' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Image CSS Class'),
				]) },
				rt.ArrayItem{ key: 'should_preview_update', val: false },
			]) },
			rt.ArrayItem{ key: 'link_classes', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Media_Image', [
						'WP_Widget_Media'], &this) },
					rt.ArrayItem{ key: none, val: 'sanitize_token_list' },
				]) },
				rt.ArrayItem{ key: 'media_prop', val: 'linkClassName' },
				rt.ArrayItem{ key: 'should_preview_update', val: false },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Link CSS Class'),
				]) },
			]) },
			rt.ArrayItem{ key: 'link_rel', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Media_Image', [
						'WP_Widget_Media'], &this) },
					rt.ArrayItem{ key: none, val: 'sanitize_token_list' },
				]) },
				rt.ArrayItem{ key: 'media_prop', val: 'linkRel' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Link Rel'),
				]) },
				rt.ArrayItem{ key: 'should_preview_update', val: false },
			]) },
			rt.ArrayItem{ key: 'link_target_blank', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'boolean' },
				rt.ArrayItem{ key: 'default', val: false },
				rt.ArrayItem{ key: 'media_prop', val: 'linkTargetBlank' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Open link in a new tab'),
				]) },
				rt.ArrayItem{ key: 'should_preview_update', val: false },
			]) },
			rt.ArrayItem{ key: 'image_title', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
				rt.ArrayItem{ key: 'media_prop', val: 'title' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Image Title Attribute'),
				]) },
				rt.ArrayItem{ key: 'should_preview_update', val: false },
			]) },
		]),
		this.Class_WP_Widget_Media.get_instance_schema(),
	])
}

fn (mut this Class_WP_Widget_Media_Image) render_media(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('array_merge', [
		rt.call_function('wp_list_pluck', [this.get_instance_schema(),
			rt.new_string('default')]),
		var_instance_mutated.clone(),
	])
	var_instance_mutated = rt.call_function('wp_parse_args', [
		var_instance_mutated.clone(), rt.create_array([
			rt.ArrayItem{ key: 'size', val: 'thumbnail' },
		])])
	mut var_attachment := rt.new_null()
	if rt.is_true(this.is_attachment_with_mime_type(var_instance_mutated.array_get(rt.new_string('attachment_id')), rt.get_property(rt.new_object('WP_Widget_Media_Image', [
		'WP_Widget_Media',
	], &this), 'widget_options').array_get(rt.new_string('mime_type'))))
	{
		var_attachment = rt.call_function('get_post', [
			var_instance_mutated.array_get(rt.new_string('attachment_id')),
		])
	}
	if rt.is_true(var_attachment) {
		mut var_caption := rt.new_string('')
		if !(var_instance_mutated.array_isset(rt.new_string('caption'))) {
			var_caption = rt.get_property(var_attachment, 'post_excerpt')
		} else if rt.is_true(rt.new_string(var_instance_mutated.array_get(rt.new_string('caption')).to_string().trim_space())) {
			var_caption = var_instance_mutated.array_get(rt.new_string('caption'))
		}
		mut var_image_attributes := {
			'class': rt.call_function('sprintf', [rt.new_string('image wp-image-%d %s'),
				rt.get_property(var_attachment, 'ID'), var_instance_mutated.array_get(rt.new_string('image_classes'))])
			'style': rt.new_string('max-width: 100%; height: auto;')
		}
		if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('image_title')))) {
			var_image_attributes['title'] =
				var_instance_mutated.array_get(rt.new_string('image_title'))
		}
		if rt.is_true(var_instance_mutated.array_get(rt.new_string('alt'))) {
			var_image_attributes['alt'] = var_instance_mutated.array_get(rt.new_string('alt'))
		}
		mut var_size := var_instance_mutated.array_get(rt.new_string('size'))
		if rt.is_true(rt.identical(rt.new_string('custom'), var_size))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_size.clone(), rt.call_function('array_merge', [rt.call_function('get_intermediate_image_sizes', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{
			key: none
			val: 'full'
		}])]), rt.new_bool(true)]))))) {
			var_size = rt.create_array([
				rt.ArrayItem{ key: none, val: var_instance_mutated.array_get(rt.new_string('width')) },
				rt.ArrayItem{
					key: none
					val: var_instance_mutated.array_get(rt.new_string('height'))
				},
			])
			mut var_width := var_instance_mutated.array_get(rt.new_string('width'))
		} else {
			mut var_caption_size := rt.call_function('_wp_get_image_size_from_meta', [
				var_instance_mutated.array_get(rt.new_string('size')),
				rt.call_function('wp_get_attachment_metadata', [
					rt.get_property(var_attachment, 'ID'),
				]),
			])
			var_width = if !rt.is_true(var_caption_size.array_get(rt.new_int(0))) {
				rt.new_int(0)
			} else {
				var_caption_size.array_get(rt.new_int(0))
			}
		}
		var_image_attributes['class'] = rt.concat(var_image_attributes['class'], rt.call_function('sprintf', [
			rt.new_string(' attachment-%1$s size-%1$s'),
			if var_size.clone().is_array() { rt.call_function('implode', [
					rt.new_string('x'),
					var_size.clone(),
				]) } else { var_size },
		]))
		mut var_image := rt.call_function('wp_get_attachment_image', [
			rt.get_property(var_attachment, 'ID'),
			var_size.clone(),
			rt.new_bool(false),
			rt.create_array_from_native_map(var_image_attributes),
		])
	} else {
		if !rt.is_true(var_instance_mutated.array_get(rt.new_string('url'))) {
			return
		}
		var_instance_mutated.array_set('size', 'custom')
		var_caption = var_instance_mutated.array_get(rt.new_string('caption'))
		var_width = var_instance_mutated.array_get(rt.new_string('width'))
		mut var_classes := rt.new_string('image ' +
			(var_instance_mutated.array_get(rt.new_string('image_classes'))).str())
		if rt.is_true(rt.identical(rt.new_int(0),
			var_instance_mutated.array_get(rt.new_string('width'))))
		{
			var_instance_mutated.array_set('width', '')
		}
		if rt.is_true(rt.identical(rt.new_int(0),
			var_instance_mutated.array_get(rt.new_string('height'))))
		{
			var_instance_mutated.array_set('height', '')
		}
		mut var_attr := rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes },
			rt.ArrayItem{ key: 'src', val: var_instance_mutated.array_get(rt.new_string('url')) },
			rt.ArrayItem{ key: 'alt', val: var_instance_mutated.array_get(rt.new_string('alt')) },
			rt.ArrayItem{ key: 'width', val: var_instance_mutated.array_get(rt.new_string('width')) },
			rt.ArrayItem{
				key: 'height'
				val: var_instance_mutated.array_get(rt.new_string('height'))
			}])
		mut var_loading_optimization_attr := rt.call_function('wp_get_loading_optimization_attributes', [
			rt.new_string('img'),
			var_attr.clone(),
			rt.new_string('widget_media_image'),
		])
		var_attr = rt.call_function('array_merge', [var_attr.clone(),
			var_loading_optimization_attr.clone()])
		var_attr = rt.call_function('array_map', [rt.new_string('esc_attr'),
			var_attr.clone()])
		var_image = rt.new_string('<img')
		mut iter_1 := var_attr.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_name := item_1.key
			var_image = rt.concat(var_image, rt.new_string(' ' + var_name.str() + '="' +
				var_value.str() + '"'))
		}
		var_image = rt.concat(var_image, rt.new_string(' />'))
	}
	mut var_url := rt.new_string('')
	if rt.is_true(rt.identical(rt.new_string('file'),
		var_instance_mutated.array_get(rt.new_string('link_type'))))
	{
		var_url = if rt.is_true(var_attachment) { rt.call_function('wp_get_attachment_url', [
				rt.get_property(var_attachment, 'ID'),
			]) } else { var_instance_mutated.array_get(rt.new_string('url')) }
	} else if rt.is_true(var_attachment)
		&& rt.is_true(rt.identical(rt.new_string('post'), var_instance_mutated.array_get(rt.new_string('link_type')))) {
		var_url = rt.call_function('get_attachment_link', [
			rt.get_property(var_attachment, 'ID'),
		])
	} else if
		rt.is_true(rt.identical(rt.new_string('custom'), var_instance_mutated.array_get(rt.new_string('link_type'))))
		&& !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('link_url')))) {
		var_url = var_instance_mutated.array_get(rt.new_string('link_url'))
	}
	if rt.is_true(var_url) {
		mut var_link := rt.call_function('sprintf', [rt.new_string('<a href="%s"'),
			rt.call_function('esc_url', [var_url.clone()])])
		if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('link_classes')))) {
			var_link = rt.concat(var_link, rt.call_function('sprintf', [
				rt.new_string(' class="%s"'),
				rt.call_function('esc_attr', [
					var_instance_mutated.array_get(rt.new_string('link_classes')),
				]),
			]))
		}
		if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('link_rel')))) {
			var_link = rt.concat(var_link, rt.call_function('sprintf', [
				rt.new_string(' rel="%s"'),
				rt.call_function('esc_attr',
					[var_instance_mutated.array_get(rt.new_string('link_rel'))]),
			]))
		}
		if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('link_target_blank')))) {
			var_link = rt.concat(var_link, rt.new_string(' target="_blank"'))
		}
		var_link = rt.concat(var_link, rt.new_string('>'))
		var_link = rt.concat(var_link, var_image)
		var_link = rt.concat(var_link, rt.new_string('</a>'))
		var_image = var_link.clone()
	}
	if rt.is_true(var_caption) {
		var_image = rt.call_function('img_caption_shortcode', [
			rt.create_array([rt.ArrayItem{ key: 'width', val: var_width },
				rt.ArrayItem{ key: 'caption', val: var_caption }]),
			var_image.clone(),
		])
	}
	rt.echo_val(var_image)
}

fn (mut this Class_WP_Widget_Media_Image) enqueue_admin_scripts() {
	this.Class_WP_Widget_Media.enqueue_admin_scripts()
	mut var_handle := rt.new_string('media-image-widget')
	rt.call_function('wp_enqueue_script', [var_handle.clone()])
	mut var_exported_schema := rt.new_array()
	mut iter_2 := this.get_instance_schema().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_field_schema := item_2.val
		mut var_field := item_2.key
		var_exported_schema.array_set(var_field, rt.call_function('wp_array_slice_assoc', [
			var_field_schema.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'type' },
				rt.ArrayItem{ key: none, val: 'default' }, rt.ArrayItem{ key: none, val: 'enum' },
				rt.ArrayItem{ key: none, val: 'minimum' }, rt.ArrayItem{ key: none, val: 'format' },
				rt.ArrayItem{ key: none, val: 'media_prop' },
				rt.ArrayItem{ key: none, val: 'should_preview_update' }]),
		]))
	}
	rt.call_function('wp_add_inline_script', [var_handle.clone(),
		rt.call_function('sprintf', [
			rt.new_string('wp.mediaWidgets.modelConstructors[ %s ].prototype.schema = %s;'),
			rt.call_function('wp_json_encode', [
				rt.get_property(rt.new_object('WP_Widget_Media_Image', [
					'WP_Widget_Media',
				], &this), 'id_base'),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
			rt.call_function('wp_json_encode', [
				var_exported_schema.clone(),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
		])])
	rt.call_function('wp_add_inline_script', [var_handle.clone(),
		rt.call_function('sprintf', [
			rt.new_string('\n\t\t\t\t\twp.mediaWidgets.controlConstructors[ %1$s ].prototype.mime_type = %2$s;\n\t\t\t\t\twp.mediaWidgets.controlConstructors[ %1$s ].prototype.l10n = _.extend( {}, wp.mediaWidgets.controlConstructors[ %1$s ].prototype.l10n, %3$s );\n\t\t\t\t'),
			rt.call_function('wp_json_encode', [
				rt.get_property(rt.new_object('WP_Widget_Media_Image', [
					'WP_Widget_Media',
				], &this), 'id_base'),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
			rt.call_function('wp_json_encode', [
				rt.get_property(rt.new_object('WP_Widget_Media_Image', [
					'WP_Widget_Media',
				], &this), 'widget_options').array_get(rt.new_string('mime_type')),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
			rt.call_function('wp_json_encode', [
				rt.get_property(rt.new_object('WP_Widget_Media_Image', [
					'WP_Widget_Media',
				], &this), 'l10n'),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
		])])
}

fn (mut this Class_WP_Widget_Media_Image) render_control_template_scripts() {
	this.Class_WP_Widget_Media.render_control_template_scripts()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Link to:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_notice', [
		rt.get_property(rt.new_object('WP_Widget_Media_Image', ['WP_Widget_Media'], &this), 'l10n').array_get(rt.new_string('missing_attachment')),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'notice-alt' },
				rt.ArrayItem{ key: none, val: 'notice-missing-attachment' },
			]) }]),
	])
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
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The current image has no alternative text. The file name is: %s'),
			]),
			rt.new_string('{{ data.currentFilename }}'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Widget_Media {
	rt.PhpObjectBase
}

fn create_wp_widget_media_image() &Class_WP_Widget_Media_Image {
	mut obj := &Class_WP_Widget_Media_Image{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_widget_media(_args ...rt.PhpVal) &Class_WP_Widget_Media {
	mut obj := &Class_WP_Widget_Media{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Widget_Media_Image) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WP_Widget_Media_Image) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget_Media_Image) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
