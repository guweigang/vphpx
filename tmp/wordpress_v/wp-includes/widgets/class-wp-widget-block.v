import rt

struct Class_WP_Widget_Block {
	rt.PhpObjectBase
pub mut:
	default_instance rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Widget_Block) construct() {
	mut var_widget_ops := {
		'classname':                   rt.new_string('widget_block')
		'description':                 rt.call_function('__', [
			rt.new_string('A widget containing a block.'),
		])
		'customize_selective_refresh': rt.new_bool(true)
		'show_instance_in_rest':       rt.new_bool(true)
	}
	mut var_control_ops := {
		'width':  400
		'height': 350
	}
	this.Class_WP_Widget.construct(rt.new_string('block'), rt.call_function('__', [
		rt.new_string('Block'),
	]), var_widget_ops.dup(), var_control_ops.dup())
	rt.call_function('add_filter', [rt.new_string('is_wide_widget_in_customizer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Block', [
				'WP_Widget',
			], &this) },
			rt.ArrayItem{ key: none, val: 'set_is_wide_widget_in_customizer' },
		]),
		rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WP_Widget_Block) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('wp_parse_args', [
		var_instance_mutated.dup(), this.default_instance])
	rt.echo_val(rt.call_function('str_replace', [rt.new_string('widget_block'),
		this.get_dynamic_classname(var_instance_mutated.array_get('content')),
		var_args.array_get('before_widget')]))
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('widget_block_content'),
		var_instance_mutated.array_get('content'), var_instance_mutated.dup(),
		rt.new_object('WP_Widget_Block', ['WP_Widget'], &this)]))
	rt.echo_val(var_args.array_get('after_widget'))
}

fn (mut this Class_WP_Widget_Block) get_dynamic_classname(var_content rt.PhpVal) rt.PhpVal {
	mut var_blocks := rt.call_function('parse_blocks', [var_content.dup()])
	mut var_block_name := if var_blocks.array_isset(rt.new_int(0)) {
		var_blocks.array_get(0).array_get('blockName')
	} else {
		rt.new_null()
	}
	mut switch_val_1 := var_block_name
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/paragraph'))) {
		mut var_classname := rt.new_string(rt.new_string('widget_block widget_text'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/calendar'))) {
		var_classname = rt.new_string(rt.new_string('widget_block widget_calendar'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/search'))) {
		var_classname = rt.new_string(rt.new_string('widget_block widget_search'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/html'))) {
		var_classname = rt.new_string(rt.new_string('widget_block widget_custom_html'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/archives'))) {
		var_classname = rt.new_string(rt.new_string('widget_block widget_archive'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/latest-posts'))) {
		var_classname = rt.new_string(rt.new_string('widget_block widget_recent_entries'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/latest-comments'))) {
		var_classname = rt.new_string(rt.new_string('widget_block widget_recent_comments'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/tag-cloud'))) {
		var_classname = rt.new_string(rt.new_string('widget_block widget_tag_cloud'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/categories'))) {
		var_classname = rt.new_string(rt.new_string('widget_block widget_categories'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/audio'))) {
		var_classname = rt.new_string(rt.new_string('widget_block widget_media_audio'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/video'))) {
		var_classname = rt.new_string(rt.new_string('widget_block widget_media_video'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/image'))) {
		var_classname = rt.new_string(rt.new_string('widget_block widget_media_image'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/gallery'))) {
		var_classname = rt.new_string(rt.new_string('widget_block widget_media_gallery'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/rss'))) {
		var_classname = rt.new_string(rt.new_string('widget_block widget_rss'))
	} else {
		var_classname = rt.new_string(rt.new_string('widget_block'))
	}
	return rt.call_function('apply_filters', [
		rt.new_string('widget_block_dynamic_classname'),
		var_classname.dup(),
		var_block_name.dup(),
	])
}

fn (mut this Class_WP_Widget_Block) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_instance := rt.call_function('array_merge',
		[this.default_instance, var_old_instance.dup()])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('unfiltered_html')])) {
		var_instance.array_set('content', var_new_instance.array_get('content'))
	} else {
		var_instance.array_set('content', rt.call_function('wp_kses_post', [
			var_new_instance.array_get('content'),
		]))
	}
	return var_instance.dup()
}

fn (mut this Class_WP_Widget_Block) form(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('wp_parse_args', [
		rt.cast_array(var_instance_mutated),
		this.default_instance,
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('content')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Block HTML:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('content')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('content')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [var_instance_mutated.array_get('content')]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Widget_Block) set_is_wide_widget_in_customizer(var_is_wide rt.PhpVal, var_widget_id rt.PhpVal) bool {
	if rt.is_true(rt.call_function('str_starts_with', [var_widget_id.dup(),
		rt.new_string('block-')]))
	{
		return false
	}
	return var_is_wide.to_bool()
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wp_widget_block() &Class_WP_Widget_Block {
	mut obj := &Class_WP_Widget_Block{
		PhpObjectBase:    rt.PhpObjectBase{}
		default_instance: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wp_widget() &Class_WP_Widget {
	mut obj := &Class_WP_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Widget_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.widget(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_dynamic_classname' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_dynamic_classname(dispatch_arg_0)
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update(dispatch_arg_0, dispatch_arg_1)
		}
		'form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.form(dispatch_arg_0)
			return rt.new_null()
		}
		'set_is_wide_widget_in_customizer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.set_is_wide_widget_in_customizer(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Widget_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'default_instance' { return this.default_instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Widget_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'default_instance' {
			this.default_instance = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_widgets_class_wp_widget_block_php() {
}
