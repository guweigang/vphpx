import rt

struct Class_WP_Customize_New_Menu_Section {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('new_menu')
}

fn (mut this Class_WP_Customize_New_Menu_Section) construct(mut var_manager Class_WP_Customize_Manager, var_id rt.PhpVal, mut var_args Class_array) {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('4.9.0')])
	this.Class_WP_Customize_Section.construct(rt.new_object('WP_Customize_Manager', []string{},
		var_manager), var_id.clone(), rt.new_object('array', []string{}, var_args))
}

fn (mut this Class_WP_Customize_New_Menu_Section) render() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('4.9.0')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(rt.new_object('WP_Customize_New_Menu_Section', [
			'WP_Customize_Section',
		], &this), 'id'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.get_property(rt.new_object('WP_Customize_New_Menu_Section', [
			'WP_Customize_Section',
		], &this), 'title'),
	]))
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Customize_Section {
	rt.PhpObjectBase
}

fn create_wp_customize_new_menu_section(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Customize_New_Menu_Section {
	mut obj := &Class_WP_Customize_New_Menu_Section{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('new_menu')
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wp_customize_section(_args ...rt.PhpVal) &Class_WP_Customize_Section {
	mut obj := &Class_WP_Customize_Section{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_New_Menu_Section) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Customize_Manager](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'render' {
			this.render()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_New_Menu_Section) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_New_Menu_Section) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Customize_Section) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Section) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Section) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('4.9.0'),
	])
}
