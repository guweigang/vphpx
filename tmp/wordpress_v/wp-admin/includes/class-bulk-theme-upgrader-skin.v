import rt

struct Class_Bulk_Theme_Upgrader_Skin {
	rt.PhpObjectBase
pub mut:
	theme_info rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Bulk_Theme_Upgrader_Skin) add_strings() {
	this.Class_Bulk_Upgrader_Skin.add_strings()
	rt.get_property(rt.get_property(rt.new_object('Bulk_Theme_Upgrader_Skin', [
		'Bulk_Upgrader_Skin',
	], &this), 'upgrader'), 'strings').array_set('skin_before_update_header', rt.call_function('__', [
		rt.new_string('Updating Theme %1$s (%2$d/%3$d)'),
	]))
}

fn (mut this Class_Bulk_Theme_Upgrader_Skin) before(title string) {
	this.Class_Bulk_Upgrader_Skin.before(rt.call_method(this.theme_info, 'display', [
		rt.new_string('Name'),
	]))
}

fn (mut this Class_Bulk_Theme_Upgrader_Skin) after(title string) {
	this.Class_Bulk_Upgrader_Skin.after(rt.call_method(this.theme_info, 'display', [
		rt.new_string('Name'),
	]))
	this.decrement_update_count(rt.new_string('theme'))
}

fn (mut this Class_Bulk_Theme_Upgrader_Skin) bulk_footer() {
	this.Class_Bulk_Upgrader_Skin.bulk_footer()
	mut var_update_actions := rt.create_array([
		rt.ArrayItem{ key: 'themes_page', val: rt.call_function('sprintf', [
			rt.new_string('<a href="%s" target="_parent">%s</a>'),
			rt.call_function('self_admin_url', [rt.new_string('themes.php')]),
			rt.call_function('__', [rt.new_string('Go to Themes page')]),
		]) },
		rt.ArrayItem{ key: 'updates_page', val: rt.call_function('sprintf', [
			rt.new_string('<a href="%s" target="_parent">%s</a>'),
			rt.call_function('self_admin_url', [rt.new_string('update-core.php')]),
			rt.call_function('__', [rt.new_string('Go to WordPress Updates page')]),
		]) },
	])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])))))))
	{
		var_update_actions.array_unset(rt.new_string('themes_page'))
	}
	var_update_actions = rt.call_function('apply_filters', [
		rt.new_string('update_bulk_theme_complete_actions'),
		var_update_actions.dup(),
		this.theme_info,
	])
	if !(!rt.is_true(var_update_actions)) {
		this.feedback(rt.call_function('implode', [rt.new_string(' | '),
			rt.cast_array(var_update_actions)]))
	}
}

struct Class_Bulk_Upgrader_Skin {
	rt.PhpObjectBase
}

fn create_bulk_theme_upgrader_skin() &Class_Bulk_Theme_Upgrader_Skin {
	mut obj := &Class_Bulk_Theme_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
		theme_info:    rt.new_bool(false)
	}
	return obj
}

fn create_bulk_upgrader_skin() &Class_Bulk_Upgrader_Skin {
	mut obj := &Class_Bulk_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Bulk_Theme_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_strings' {
			this.add_strings()
			return rt.new_null()
		}
		'before' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.before(dispatch_arg_0)
			return rt.new_null()
		}
		'after' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.after(dispatch_arg_0)
			return rt.new_null()
		}
		'bulk_footer' {
			this.bulk_footer()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Bulk_Theme_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'theme_info' { return this.theme_info }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Bulk_Theme_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'theme_info' {
			this.theme_info = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Bulk_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Bulk_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Bulk_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_admin_includes_class_bulk_theme_upgrader_skin_php() {
}
