import rt

struct Class_WP_Customize_Background_Position_Control {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('background_position')
}

fn (mut this Class_WP_Customize_Background_Position_Control) render_content() {
}

fn (mut this Class_WP_Customize_Background_Position_Control) content_template() {
	mut var_options := [
		[
			[rt.call_function('__', [rt.new_string('Top Left')]),
				rt.new_string('dashicons dashicons-arrow-left-alt')],
			[rt.call_function('__', [rt.new_string('Top')]),
				rt.new_string('dashicons dashicons-arrow-up-alt')],
			[rt.call_function('__', [rt.new_string('Top Right')]),
				rt.new_string('dashicons dashicons-arrow-right-alt')],
		],
		[
			[rt.call_function('__', [rt.new_string('Left')]),
				rt.new_string('dashicons dashicons-arrow-left-alt')],
			[rt.call_function('__', [rt.new_string('Center')]),
				rt.new_string('background-position-center-icon')],
			[rt.call_function('__', [rt.new_string('Right')]),
				rt.new_string('dashicons dashicons-arrow-right-alt')],
		],
		[
			[rt.call_function('__', [rt.new_string('Bottom Left')]),
				rt.new_string('dashicons dashicons-arrow-left-alt')],
			[rt.call_function('__', [rt.new_string('Bottom')]),
				rt.new_string('dashicons dashicons-arrow-down-alt')],
			[rt.call_function('__', [rt.new_string('Bottom Right')]),
				rt.new_string('dashicons dashicons-arrow-right-alt')],
		],
	]
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Image Position')])
	// unsupported statement: Stmt_InlineHTML
	for var_group in var_options {
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := var_group.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_input := item_1.val
			mut var_value := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_input.array_get(rt.new_string('icon')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_input.array_get(rt.new_string('label')))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_background_position_control(_args ...rt.PhpVal) &Class_WP_Customize_Background_Position_Control {
	mut obj := &Class_WP_Customize_Background_Position_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('background_position')
	}
	return obj
}

fn create_wp_customize_control(_args ...rt.PhpVal) &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Background_Position_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			this.render_content()
			return rt.new_null()
		}
		'content_template' {
			this.content_template()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Background_Position_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Background_Position_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}
