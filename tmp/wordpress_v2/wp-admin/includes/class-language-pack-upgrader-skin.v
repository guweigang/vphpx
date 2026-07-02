import rt

struct Class_Language_Pack_Upgrader_Skin {
	rt.PhpObjectBase
pub mut:
	language_update        rt.PhpVal = rt.new_null()
	done_header            bool
	done_footer            bool
	display_footer_actions bool
}

fn (mut this Class_Language_Pack_Upgrader_Skin) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_defaults := {
		'url':                rt.new_string('')
		'nonce':              rt.new_string('')
		'title':              rt.call_function('__', [
			rt.new_string('Update Translations'),
		])
		'skip_header_footer': rt.new_bool(false)
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array_from_native_map(var_defaults)])
	if rt.is_true(var_args_mutated.array_get(rt.new_string('skip_header_footer'))) {
		this.done_header = true
		this.done_footer = true
		this.display_footer_actions = false
	}
	this.Class_WP_Upgrader_Skin.construct(var_args_mutated.clone())
}

fn (mut this Class_Language_Pack_Upgrader_Skin) before() {
	mut var_name := rt.call_method(rt.get_property(rt.new_object('Language_Pack_Upgrader_Skin', [
		'WP_Upgrader_Skin',
	], &this), 'upgrader'), 'get_name_for_update', [this.language_update])
	print('<div class="update-messages lp-show-latest">')
	rt.call_function('printf', [
		rt.new_string('<h2>' +
			(rt.call_function('__', [rt.new_string('Updating translations for %1$s (%2$s)&#8230;')])).str() + '</h2>'),
		var_name.clone(),
		rt.get_property(this.language_update, 'language'),
	])
}

fn (mut this Class_Language_Pack_Upgrader_Skin) error(var_errors rt.PhpVal) {
	print('<div class="lp-error">')
	this.Class_WP_Upgrader_Skin.error(var_errors.clone())
	print('</div>')
}

fn (mut this Class_Language_Pack_Upgrader_Skin) after() {
	print('</div>')
}

fn (mut this Class_Language_Pack_Upgrader_Skin) bulk_footer() {
	this.decrement_update_count(rt.new_string('translation'))
	mut var_update_actions := rt.create_array([
		rt.ArrayItem{ key: 'updates_page', val: rt.call_function('sprintf', [
			rt.new_string('<a href="%s" target="_parent">%s</a>'),
			rt.call_function('self_admin_url', [rt.new_string('update-core.php')]),
			rt.call_function('__', [rt.new_string('Go to WordPress Updates page')]),
		]) },
	])
	var_update_actions = rt.call_function('apply_filters', [
		rt.new_string('update_translations_complete_actions'),
		var_update_actions.clone(),
	])
	if rt.is_true(var_update_actions) && this.display_footer_actions {
		this.feedback(rt.call_function('implode', [rt.new_string(' | '),
			var_update_actions.clone()]))
	}
}

struct Class_WP_Upgrader_Skin {
	rt.PhpObjectBase
}

fn create_language_pack_upgrader_skin(arg_0 rt.PhpVal) &Class_Language_Pack_Upgrader_Skin {
	mut obj := &Class_Language_Pack_Upgrader_Skin{
		PhpObjectBase:          rt.PhpObjectBase{}
		language_update:        rt.new_null()
		done_header:            false
		done_footer:            false
		display_footer_actions: false
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_upgrader_skin(_args ...rt.PhpVal) &Class_WP_Upgrader_Skin {
	mut obj := &Class_WP_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Language_Pack_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'before' {
			this.before()
			return rt.new_null()
		}
		'error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.error(dispatch_arg_0)
			return rt.new_null()
		}
		'after' {
			this.after()
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

fn (this &Class_Language_Pack_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'language_update' { return this.language_update }
		'done_header' { return rt.new_bool(this.done_header) }
		'done_footer' { return rt.new_bool(this.done_footer) }
		'display_footer_actions' { return rt.new_bool(this.display_footer_actions) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Language_Pack_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'language_update' {
			this.language_update = val
			return true
		}
		'done_header' {
			this.done_header = val.to_bool()
			return true
		}
		'done_footer' {
			this.done_footer = val.to_bool()
			return true
		}
		'display_footer_actions' {
			this.display_footer_actions = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
