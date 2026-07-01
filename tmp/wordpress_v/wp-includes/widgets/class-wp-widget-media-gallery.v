import rt

struct Class_WP_Widget_Media_Gallery {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Widget_Media_Gallery) construct()  {
	this.Class_WP_Widget_Media.construct(rt.new_string('media_gallery'), rt.call_function('__', [rt.new_string('Gallery')]), rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays an image gallery.')]) }, rt.ArrayItem{ key: 'mime_type', val: 'image' }]))
	this.dispatch_set_prop('l10n', rt.call_function('array_merge', [rt.get_property(rt.new_object('WP_Widget_Media_Gallery', ['WP_Widget_Media'], &this), 'l10n'), rt.create_array([rt.ArrayItem{ key: 'no_media_selected', val: rt.call_function('__', [rt.new_string('No images selected')]) }, rt.ArrayItem{ key: 'add_media', val: rt.call_function('_x', [rt.new_string('Add Images'), rt.new_string('label for button in the gallery widget; should not be longer than ~13 characters long')]) }, rt.ArrayItem{ key: 'replace_media', val: '' }, rt.ArrayItem{ key: 'edit_media', val: rt.call_function('_x', [rt.new_string('Edit Gallery'), rt.new_string('label for button in the gallery widget; should not be longer than ~13 characters long')]) }])]))
}

fn (mut this Class_WP_Widget_Media_Gallery) get_instance_schema() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Title for the widget')]) }, rt.ArrayItem{ key: 'should_preview_update', val: false }]) }, rt.ArrayItem{ key: 'ids', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }]) }, rt.ArrayItem{ key: 'columns', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 3 }, rt.ArrayItem{ key: 'minimum', val: 1 }, rt.ArrayItem{ key: 'maximum', val: 9 }]) }, rt.ArrayItem{ key: 'size', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [rt.call_function('get_intermediate_image_sizes', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: 'full' }, rt.ArrayItem{ key: none, val: 'custom' }])]) }, rt.ArrayItem{ key: 'default', val: 'thumbnail' }]) }, rt.ArrayItem{ key: 'link_type', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'file' }, rt.ArrayItem{ key: none, val: 'none' }]) }, rt.ArrayItem{ key: 'default', val: 'post' }, rt.ArrayItem{ key: 'media_prop', val: 'link' }, rt.ArrayItem{ key: 'should_preview_update', val: false }]) }, rt.ArrayItem{ key: 'orderby_random', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'media_prop', val: '_orderbyRandom' }, rt.ArrayItem{ key: 'should_preview_update', val: false }]) }])
	var_schema = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('widget_'), rt.get_property(rt.new_object('WP_Widget_Media_Gallery', ['WP_Widget_Media'], &this), 'id_base')), rt.new_string('_instance_schema')), var_schema.dup(), rt.new_object('WP_Widget_Media_Gallery', ['WP_Widget_Media'], &this)])
	return var_schema.dup()
}

fn (mut this Class_WP_Widget_Media_Gallery) render_media(var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('array_merge', [rt.call_function('wp_list_pluck', [this.get_instance_schema(), rt.new_string('default')]), var_instance_mutated.dup()])
	mut var_shortcode_atts := rt.call_function('array_merge', [var_instance_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'link', val: var_instance_mutated.array_get('link_type') }])])
	if rt.is_true(var_instance_mutated.array_get('orderby_random')) {
		var_shortcode_atts.array_set('orderby', 'rand')
	}
	rt.echo_val(rt.call_function('gallery_shortcode', [var_shortcode_atts.dup()]))
}

fn (mut this Class_WP_Widget_Media_Gallery) enqueue_admin_scripts()  {
	this.Class_WP_Widget_Media.enqueue_admin_scripts()
	mut var_handle := rt.new_string(rt.new_string('media-gallery-widget'))
	rt.call_function('wp_enqueue_script', [var_handle.dup()])
	mut var_exported_schema := rt.new_array()
	{
		mut iter_1 := this.get_instance_schema().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field_schema := item_1.val
			mut var_field := item_1.key
			var_exported_schema.array_set(var_field, rt.call_function('wp_array_slice_assoc', [var_field_schema.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'type' }, rt.ArrayItem{ key: none, val: 'default' }, rt.ArrayItem{ key: none, val: 'enum' }, rt.ArrayItem{ key: none, val: 'minimum' }, rt.ArrayItem{ key: none, val: 'format' }, rt.ArrayItem{ key: none, val: 'media_prop' }, rt.ArrayItem{ key: none, val: 'should_preview_update' }, rt.ArrayItem{ key: none, val: 'items' }])]))
		}
	}
	rt.call_function('wp_add_inline_script', [var_handle.dup(), rt.call_function('sprintf', [rt.new_string('wp.mediaWidgets.modelConstructors[ %s ].prototype.schema = %s;'), rt.call_function('wp_json_encode', [rt.get_property(rt.new_object('WP_Widget_Media_Gallery', ['WP_Widget_Media'], &this), 'id_base'), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]), rt.call_function('wp_json_encode', [var_exported_schema.dup(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])])])
	rt.call_function('wp_add_inline_script', [var_handle.dup(), rt.call_function('sprintf', [rt.new_string('\n\t\t\t\t\twp.mediaWidgets.controlConstructors[ %1$s ].prototype.mime_type = %2$s;\n\t\t\t\t\t_.extend( wp.mediaWidgets.controlConstructors[ %1$s ].prototype.l10n, %3$s );\n\t\t\t\t'), rt.call_function('wp_json_encode', [rt.get_property(rt.new_object('WP_Widget_Media_Gallery', ['WP_Widget_Media'], &this), 'id_base'), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]), rt.call_function('wp_json_encode', [rt.get_property(rt.new_object('WP_Widget_Media_Gallery', ['WP_Widget_Media'], &this), 'widget_options').array_get('mime_type'), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]), rt.call_function('wp_json_encode', [rt.get_property(rt.new_object('WP_Widget_Media_Gallery', ['WP_Widget_Media'], &this), 'l10n'), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])])])
}

fn (mut this Class_WP_Widget_Media_Gallery) render_control_template_scripts()  {
	this.Class_WP_Widget_Media.render_control_template_scripts()
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The current image has no alternative text. The file name is: %s')]), rt.new_string('{{ attachment.filename }}')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Additional images added to this gallery: %s')]), rt.new_string('{{ data.ids.length - 5 }}')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.get_property(rt.new_object('WP_Widget_Media_Gallery', ['WP_Widget_Media'], &this), 'l10n').array_get('add_media')]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Widget_Media_Gallery) has_content(var_instance rt.PhpVal) bool {
	mut var_instance_mutated := var_instance
	if !(!rt.is_true(var_instance_mutated.array_get('ids'))) {
		mut var_attachments := rt.call_function('wp_parse_id_list', [var_instance_mutated.array_get('ids')])
		rt.call_function('_prime_post_caches', [var_attachments.dup(), rt.new_bool(false), rt.new_bool(false)])
		{
			mut iter_1 := var_attachments.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attachment := item_1.val
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					return false
				}
			}
		}
		return true
	}
	return false
}

struct Class_WP_Widget_Media {
	rt.PhpObjectBase
}

fn create_wp_widget_media_gallery() &Class_WP_Widget_Media_Gallery {
	mut obj := &Class_WP_Widget_Media_Gallery{
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

fn (mut this Class_WP_Widget_Media_Gallery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'has_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_content(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_Widget_Media_Gallery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget_Media_Gallery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_widgets_class_wp_widget_media_gallery_php() {
}
