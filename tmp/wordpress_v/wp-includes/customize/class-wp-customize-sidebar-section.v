import rt

struct Class_WP_Customize_Sidebar_Section {
	rt.PhpObjectBase
pub mut:
	prop_type  rt.PhpVal = rt.new_string('sidebar')
	sidebar_id rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Customize_Sidebar_Section) json() rt.PhpVal {
	mut var_json := this.Class_WP_Customize_Section.json()
	var_json.array_set('sidebarId', this.sidebar_id)
	return var_json.dup()
}

fn (mut this Class_WP_Customize_Sidebar_Section) active_callback() rt.PhpVal {
	return rt.call_method(rt.get_property(rt.get_property(rt.new_object('WP_Customize_Sidebar_Section', [
		'WP_Customize_Section',
	], &this), 'manager'), 'widgets'), 'is_sidebar_rendered', [this.sidebar_id])
}

struct Class_WP_Customize_Section {
	rt.PhpObjectBase
}

fn create_wp_customize_sidebar_section() &Class_WP_Customize_Sidebar_Section {
	mut obj := &Class_WP_Customize_Sidebar_Section{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('sidebar')
		sidebar_id:    rt.new_null()
	}
	return obj
}

fn create_wp_customize_section() &Class_WP_Customize_Section {
	mut obj := &Class_WP_Customize_Section{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Sidebar_Section) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'json' {
			return this.json()
		}
		'active_callback' {
			return this.active_callback()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Sidebar_Section) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'sidebar_id' { return this.sidebar_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Sidebar_Section) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'sidebar_id' {
			this.sidebar_id = val
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

pub fn init_wp_includes_customize_class_wp_customize_sidebar_section_php() {
}
