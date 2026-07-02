import rt

struct Class_WP_Internal_Pointers {
	rt.PhpObjectBase
}

fn Class_WP_Internal_Pointers.enqueue_scripts(var_hook_suffix rt.PhpVal) {
	mut var_registered_pointers := rt.new_array()
	if !rt.is_true(var_registered_pointers.array_get(var_hook_suffix)) {
		return
	}
	mut var_pointers := rt.cast_array(var_registered_pointers.array_get(var_hook_suffix))
	mut var_caps_required := rt.new_array()
	mut var_dismissed := rt.call_function('explode', [rt.new_string(','),
		rt.new_string((rt.call_function('get_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('dismissed_wp_pointers'),
			rt.new_bool(true),
		])).str())])
	mut var_got_pointers := rt.new_bool(false)
	mut iter_1 := rt.call_function('array_diff', [var_pointers.clone(),
		var_dismissed.clone()]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_pointer := item_1.val
		if var_caps_required.array_isset(var_pointer) {
			mut iter_2 := var_caps_required.array_get(var_pointer).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_cap := item_2.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
					var_cap.clone(),
				])))))
				{
					continue
				}
			}
		}
		rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Internal_Pointers' },
				rt.ArrayItem{ key: none, val: 'pointer_' + var_pointer.str() }])])
		var_got_pointers = rt.new_bool(true)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_got_pointers)))) {
		return
	}
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-pointer')])
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-pointer')])
}

fn Class_WP_Internal_Pointers.print_js(var_pointer_id rt.PhpVal, var_selector rt.PhpVal, var_args rt.PhpVal) {
	if !rt.is_true(var_pointer_id) || !rt.is_true(var_selector) || !rt.is_true(var_args)
		|| !rt.is_true(var_args.array_get(rt.new_string('content'))) {
		return
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [var_args.clone(),
		rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_pointer_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_selector)
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WP_Internal_Pointers.pointer_wp330_toolbar() {
}

fn Class_WP_Internal_Pointers.pointer_wp330_media_uploader() {
}

fn Class_WP_Internal_Pointers.pointer_wp330_saving_widgets() {
}

fn Class_WP_Internal_Pointers.pointer_wp340_customize_current_theme_link() {
}

fn Class_WP_Internal_Pointers.pointer_wp340_choose_image_from_library() {
}

fn Class_WP_Internal_Pointers.pointer_wp350_media() {
}

fn Class_WP_Internal_Pointers.pointer_wp360_revisions() {
}

fn Class_WP_Internal_Pointers.pointer_wp360_locks() {
}

fn Class_WP_Internal_Pointers.pointer_wp390_widgets() {
}

fn Class_WP_Internal_Pointers.pointer_wp410_dfw() {
}

fn Class_WP_Internal_Pointers.pointer_wp496_privacy() {
}

fn Class_WP_Internal_Pointers.dismiss_pointers_for_new_users(var_user_id rt.PhpVal) {
	rt.call_function('add_user_meta', [var_user_id.clone(), rt.new_string('dismissed_wp_pointers'),
		rt.new_string('')])
}

fn create_wp_internal_pointers(_args ...rt.PhpVal) &Class_WP_Internal_Pointers {
	mut obj := &Class_WP_Internal_Pointers{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Internal_Pointers) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'enqueue_scripts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_Internal_Pointers.enqueue_scripts(dispatch_arg_0)
			return rt.new_null()
		}
		'print_js' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WP_Internal_Pointers.print_js(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'pointer_wp330_toolbar' {
			Class_WP_Internal_Pointers.pointer_wp330_toolbar()
			return rt.new_null()
		}
		'pointer_wp330_media_uploader' {
			Class_WP_Internal_Pointers.pointer_wp330_media_uploader()
			return rt.new_null()
		}
		'pointer_wp330_saving_widgets' {
			Class_WP_Internal_Pointers.pointer_wp330_saving_widgets()
			return rt.new_null()
		}
		'pointer_wp340_customize_current_theme_link' {
			Class_WP_Internal_Pointers.pointer_wp340_customize_current_theme_link()
			return rt.new_null()
		}
		'pointer_wp340_choose_image_from_library' {
			Class_WP_Internal_Pointers.pointer_wp340_choose_image_from_library()
			return rt.new_null()
		}
		'pointer_wp350_media' {
			Class_WP_Internal_Pointers.pointer_wp350_media()
			return rt.new_null()
		}
		'pointer_wp360_revisions' {
			Class_WP_Internal_Pointers.pointer_wp360_revisions()
			return rt.new_null()
		}
		'pointer_wp360_locks' {
			Class_WP_Internal_Pointers.pointer_wp360_locks()
			return rt.new_null()
		}
		'pointer_wp390_widgets' {
			Class_WP_Internal_Pointers.pointer_wp390_widgets()
			return rt.new_null()
		}
		'pointer_wp410_dfw' {
			Class_WP_Internal_Pointers.pointer_wp410_dfw()
			return rt.new_null()
		}
		'pointer_wp496_privacy' {
			Class_WP_Internal_Pointers.pointer_wp496_privacy()
			return rt.new_null()
		}
		'dismiss_pointers_for_new_users' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_Internal_Pointers.dismiss_pointers_for_new_users(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Internal_Pointers) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Internal_Pointers) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
