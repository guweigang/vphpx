import rt

struct Class_WP_Customize_Nav_Menu_Section {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('nav_menu')
}

fn (mut this Class_WP_Customize_Nav_Menu_Section) json() rt.PhpVal {
	mut var_exported := this.Class_WP_Customize_Section.json()
	var_exported.array_set('menu_id', rt.new_int((rt.call_function('preg_replace', [
		rt.new_string('/^nav_menu\\[(-?\\d+)\\]/'),
		rt.new_string('$1'),
		rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Section', [
			'WP_Customize_Section',
		], &this), 'id'),
	])).to_i64()))
	return var_exported.clone()
}

struct Class_WP_Customize_Section {
	rt.PhpObjectBase
}

fn create_wp_customize_nav_menu_section(_args ...rt.PhpVal) &Class_WP_Customize_Nav_Menu_Section {
	mut obj := &Class_WP_Customize_Nav_Menu_Section{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('nav_menu')
	}
	return obj
}

fn create_wp_customize_section(_args ...rt.PhpVal) &Class_WP_Customize_Section {
	mut obj := &Class_WP_Customize_Section{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Nav_Menu_Section) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'json' {
			return this.json()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Nav_Menu_Section) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Nav_Menu_Section) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
