import rt

struct Class_WP_Customize_Nav_Menu_Item_Control {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('nav_menu_item')
	setting   rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Control) construct(var_manager rt.PhpVal, var_id rt.PhpVal, var_args rt.PhpVal) {
	this.Class_WP_Customize_Control.construct(var_manager.clone(), var_id.clone(), var_args.clone())
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Control) render_content() {
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Control) content_template() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('sub item')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('sub item')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Edit %1$s (%2$s, %3$d of %4$d)')]),
		rt.new_string('{{ data.title || data.original_title || wp.customize.Menus.data.l10n.untitled }}'),
		rt.new_string('{{ data.item_type_label }}'),
		rt.new_string(''),
		rt.new_string(''),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Edit %1$s (%2$s, sub-item %3$d of %4$d under %5$s)'),
		]),
		rt.new_string('{{ data.title || data.original_title || wp.customize.Menus.data.l10n.untitled }}'),
		rt.new_string('{{ data.item_type_label }}'),
		rt.new_string(''),
		rt.new_string(''),
		rt.new_string(''),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Edit %1$s (%2$s, sub-item %3$d of %4$d under %5$s, level %6$s)'),
		]),
		rt.new_string('{{ data.title || data.original_title || wp.customize.Menus.data.l10n.untitled }}'),
		rt.new_string('{{ data.item_type_label }}'),
		rt.new_string(''),
		rt.new_string(''),
		rt.new_string(''),
		rt.new_string('{{data.depth}}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Remove Menu Item: %1$s (%2$s)')]),
		rt.new_string('{{ data.title || data.original_title || wp.customize.Menus.data.l10n.untitled }}'),
		rt.new_string('{{ data.item_type_label }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Navigation Label')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Open link in a new tab')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Title Attribute')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('CSS Classes')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link Relationship (XFN)')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Description')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('The description will be displayed in the menu if the active theme supports it.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('wp_nav_menu_item_custom_fields_customize_template'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Original: %s')]),
		rt.new_string('<a class="original-link" href="{{ data.url }}">{{ data.original_title }}</a>')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Remove')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Control) json() rt.PhpVal {
	mut var_exported := this.Class_WP_Customize_Control.json()
	var_exported.array_set('menu_item_id', rt.get_property(this.setting, 'post_id'))
	return var_exported.clone()
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_nav_menu_item_control(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Customize_Nav_Menu_Item_Control {
	mut obj := &Class_WP_Customize_Nav_Menu_Item_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('nav_menu_item')
		setting:       rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wp_customize_control(_args ...rt.PhpVal) &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
		'json' {
			return this.json()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Nav_Menu_Item_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'setting' { return this.setting }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'setting' {
			this.setting = val
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
