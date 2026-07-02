import rt

struct Class_WP_Customize_Nav_Menu_Control {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('nav_menu')
}

fn (mut this Class_WP_Customize_Nav_Menu_Control) render_content() {
}

fn (mut this Class_WP_Customize_Nav_Menu_Control) content_template() {
	mut var_add_items := rt.call_function('__', [rt.new_string('Add Items')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Time to add some links! Click &#8220;%s&#8221; to start putting pages, categories, and custom links in your menu. Add as many things as you would like.'),
		]),
		var_add_items.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Add or remove menu items')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_add_items)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Reorder menu items')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Reorder')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Done')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('When in reorder mode, additional controls to reorder menu items will be available in the items list above.'),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Nav_Menu_Control) json() rt.PhpVal {
	mut var_exported := this.Class_WP_Customize_Control.json()
	var_exported.array_set('menu_id', rt.get_property(rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Control', [
		'WP_Customize_Control',
	], &this), 'setting'), 'term_id'))
	return var_exported.clone()
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_nav_menu_control(_args ...rt.PhpVal) &Class_WP_Customize_Nav_Menu_Control {
	mut obj := &Class_WP_Customize_Nav_Menu_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('nav_menu')
	}
	return obj
}

fn create_wp_customize_control(_args ...rt.PhpVal) &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Nav_Menu_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			this.render_content()
			return rt.new_null()
		}
		'content_template' {
			this.content_template()
			return rt.new_null()
		}
		'json' {
			return this.json()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Nav_Menu_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Nav_Menu_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
