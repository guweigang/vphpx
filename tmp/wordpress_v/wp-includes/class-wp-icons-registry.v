import rt

struct Class_WP_Icons_Registry {
	rt.PhpObjectBase
pub mut:
		registered_icons rt.PhpVal = rt.new_array()
		instance rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Icons_Registry) construct()  {
	mut var_icons_directory := rt.new_string(@DIR + '/images/icon-library/')
	mut var_manifest_path := rt.new_string(@DIR + '/assets/icon-library-manifest.php')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [var_manifest_path.dup()]))))) {
		rt.call_function('wp_trigger_error', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Core icon collection manifest is missing or unreadable.')])])
		return
	}
	mut var_collection := rt.include_file((var_manifest_path).to_string(), '1')
	if !rt.is_true(var_collection) {
		rt.call_function('wp_trigger_error', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Core icon collection manifest is empty or invalid.')])])
		return
	}
	{
		mut iter_1 := var_collection.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_icon_data := item_1.val
			mut var_icon_name := item_1.key
			if rt.is_true(rt.new_bool(!rt.is_true(var_icon_data.array_get('filePath')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_icon_data.array_get('filePath').is_string()))))))) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Core icon collection manifest must provide valid a "filePath" for each icon.')]), rt.new_string('7.0.0')])
				return
			}
			this.register(rt.new_string('core/' + (var_icon_name).str()), rt.create_array([rt.ArrayItem{ key: 'label', val: var_icon_data.array_get('label') }, rt.ArrayItem{ key: 'filePath', val: (var_icons_directory).str() + (var_icon_data.array_get('filePath')).str() }]))
		}
	}
}

fn (mut this Class_WP_Icons_Registry) register(var_icon_name rt.PhpVal, var_icon_properties rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(!(var_icon_name).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_icon_name.dup().is_string()))))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Icon name must be a string.')]), rt.new_string('7.0.0')])
		return false
	}
	mut var_allowed_keys := rt.call_function('array_fill_keys', [rt.create_array([rt.ArrayItem{ key: none, val: 'label' }, rt.ArrayItem{ key: none, val: 'content' }, rt.ArrayItem{ key: none, val: 'filePath' }]), rt.new_int(1)])
	{
		mut iter_1 := rt.func_array_keys(var_icon_properties.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_allowed_keys.dup().array_isset(var_key.dup())))))) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid icon property: "%s".')]), var_key.dup()]), rt.new_string('7.0.0')])
				return false
			}
		}
	}
	if rt.is_true(rt.new_bool(!(var_icon_properties.array_isset(rt.new_string('label'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_icon_properties.array_get('label').is_string()))))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Icon label must be a string.')]), rt.new_string('7.0.0')])
		return false
	}
	if !(var_icon_properties.array_isset(rt.new_string('content'))) && !(var_icon_properties.array_isset(rt.new_string('filePath'))) || var_icon_properties.array_isset(rt.new_string('content')) && var_icon_properties.array_isset(rt.new_string('filePath')) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Icons must provide either `content` or `filePath`.')]), rt.new_string('7.0.0')])
		return false
	}
	if var_icon_properties.array_isset(rt.new_string('content')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_icon_properties.array_get('content').is_string()))))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Icon content must be a string.')]), rt.new_string('7.0.0')])
			return false
		}
		mut var_sanitized_icon_content := this.sanitize_icon_content(var_icon_properties.array_get('content'))
		if !rt.is_true(var_sanitized_icon_content) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Icon content does not contain valid SVG markup.')]), rt.new_string('7.0.0')])
			return false
		}
	}
	mut var_icon := rt.call_function('array_merge', [var_icon_properties.dup(), rt.create_array([rt.ArrayItem{ key: 'name', val: var_icon_name }])])
	this.registered_icons.array_set(var_icon_name, var_icon.dup())
	return true
}

fn (mut this Class_WP_Icons_Registry) sanitize_icon_content(var_icon_content rt.PhpVal) rt.PhpVal {
	mut var_allowed_tags := { 'svg': { 'class': rt.new_bool(true), 'xmlns': rt.new_bool(true), 'width': rt.new_bool(true), 'height': rt.new_bool(true), 'viewbox': rt.new_bool(true), 'aria-hidden': rt.new_bool(true), 'role': rt.new_bool(true), 'focusable': rt.new_bool(true) }, 'path': { 'fill': rt.new_bool(true), 'fill-rule': rt.new_bool(true), 'd': rt.new_bool(true), 'transform': rt.new_bool(true) }, 'polygon': { 'fill': rt.new_bool(true), 'fill-rule': rt.new_bool(true), 'points': rt.new_bool(true), 'transform': rt.new_bool(true), 'focusable': rt.new_bool(true) } }
	return rt.call_function('wp_kses', [var_icon_content.dup(), var_allowed_tags.dup()])
}

fn (mut this Class_WP_Icons_Registry) get_content(var_icon_name rt.PhpVal) rt.PhpVal {
	if !(this.registered_icons.array_get(var_icon_name).array_isset(rt.new_string('content'))) {
		mut var_content := rt.call_function('file_get_contents', [this.registered_icons.array_get(var_icon_name).array_get('filePath')])
		var_content = this.sanitize_icon_content(var_content.dup())
		if !rt.is_true(var_content) {
			rt.call_function('wp_trigger_error', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Icon content does not contain valid SVG markup.')])])
			return rt.new_null()
		}
		this.registered_icons.array_get_mut(var_icon_name).array_set('content', var_content.dup())
	}
	return this.registered_icons.array_get(var_icon_name).array_get('content')
}

fn (mut this Class_WP_Icons_Registry) get_registered_icon(var_icon_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_registered(var_icon_name.dup()))))) {
		return rt.new_null()
	}
	mut var_icon := this.registered_icons.array_get(var_icon_name)
	var_icon.array_set('content', if !(var_icon.array_get('content')).is_null() { var_icon.array_get('content') } else { this.get_content(var_icon_name.dup()) })
	return var_icon.dup()
}

fn (mut this Class_WP_Icons_Registry) get_registered_icons(search string) rt.PhpVal {
	mut var_icons := []rt.PhpVal{}
	{
		mut iter_1 := this.registered_icons.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_icon := item_1.val
			if rt.is_true(rt.new_bool(!(search == '') && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_icon.array_get('name'), rt.new_string(search)]))))) {
				continue
			}
			var_icon.array_set('content', if !(var_icon.array_get('content')).is_null() { var_icon.array_get('content') } else { this.get_content(var_icon.array_get('name')) })
			var_icons << var_icon.dup()
		}
	}
	return var_icons.dup()
}

fn (mut this Class_WP_Icons_Registry) is_registered(var_icon_name rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.registered_icons.array_isset(var_icon_name))
}

fn Class_WP_Icons_Registry.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn create_wp_icons_registry() &Class_WP_Icons_Registry {
	mut obj := &Class_WP_Icons_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
		registered_icons: rt.new_array()
		instance: rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_WP_Icons_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.register(dispatch_arg_0, dispatch_arg_1))
		}
		'sanitize_icon_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_icon_content(dispatch_arg_0)
		}
		'get_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_content(dispatch_arg_0)
		}
		'get_registered_icon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_registered_icon(dispatch_arg_0)
		}
		'get_registered_icons' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_registered_icons(dispatch_arg_0)
		}
		'is_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_registered(dispatch_arg_0)
		}
		'get_instance' {
			return Class_WP_Icons_Registry.get_instance()
		}
		else { return none }
	}
}

fn (this &Class_WP_Icons_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registered_icons' { return this.registered_icons }
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Icons_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registered_icons' { this.registered_icons = val; return true }
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_wp_icons_registry_php() {
}
