import rt

struct Class_WP_Screen {
	rt.PhpObjectBase
pub mut:
		action rt.PhpVal = rt.new_null()
		base rt.PhpVal = rt.new_null()
		columns rt.PhpVal = rt.new_int(0)
		id rt.PhpVal = rt.new_null()
		in_admin rt.PhpVal = rt.new_null()
		is_network rt.PhpVal = rt.new_null()
		is_user rt.PhpVal = rt.new_null()
		parent_base rt.PhpVal = rt.new_null()
		parent_file rt.PhpVal = rt.new_null()
		post_type rt.PhpVal = rt.new_null()
		taxonomy rt.PhpVal = rt.new_null()
		_help_tabs rt.PhpVal = rt.new_array()
		_help_sidebar rt.PhpVal = rt.new_string('')
		_screen_reader_content rt.PhpVal = rt.new_array()
		_old_compat_help rt.PhpVal = rt.new_array()
		_options rt.PhpVal = rt.new_array()
		_registry rt.PhpVal = rt.new_array()
		_show_screen_options rt.PhpVal = rt.new_null()
		_screen_settings rt.PhpVal = rt.new_null()
		is_block_editor rt.PhpVal = rt.new_bool(false)
}

fn Class_WP_Screen.get(hook_name string) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_string(hook_name), 'WP_Screen'))) {
		return rt.new_string(hook_name)
	}
	mut var_id := rt.new_string(rt.new_string(''))
	mut var_post_type := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_in_admin := rt.new_bool(rt.new_bool(false))
	mut var_action := rt.new_string(rt.new_string(''))
	mut var_is_block_editor := rt.new_bool(rt.new_bool(false))
	if var_hook_name.len > 0 && var_hook_name != '0' {
		var_id = rt.new_string(rt.new_string(hook_name))
	} else if !(!rt.is_true(var_GLOBALS.array_get('hook_suffix'))) {
		var_id = var_GLOBALS.array_get('hook_suffix')
	}
	if rt.is_true(rt.new_bool(var_hook_name.len > 0 && var_hook_name != '0' && rt.is_true(rt.call_function('post_type_exists', [rt.new_string(hook_name)])))) {
		var_post_type = var_id.dup()
		var_id = rt.new_string(rt.new_string('post'))
		// unsupported statement: Stmt_Nop
	} else {
		if rt.is_true(rt.call_function('str_ends_with', [var_id.dup(), rt.new_string('.php')])) {
			var_id = rt.call_function('substr', [var_id.dup(), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])
		}
		if rt.is_true(rt.call_function('in_array', [var_id.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'post-new' }, rt.ArrayItem{ key: none, val: 'link-add' }, rt.ArrayItem{ key: none, val: 'media-new' }, rt.ArrayItem{ key: none, val: 'user-new' }]), rt.new_bool(true)])) {
			var_id = rt.call_function('substr', [var_id.dup(), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])
			var_action = rt.new_string(rt.new_string('add'))
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) && var_hook_name.len > 0 && var_hook_name != '0')) {
		if rt.is_true(rt.call_function('str_ends_with', [var_id.dup(), rt.new_string('-network')])) {
			var_id = rt.call_function('substr', [var_id.dup(), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])
			var_in_admin = rt.new_string(rt.new_string('network'))
		} else if rt.is_true(rt.call_function('str_ends_with', [var_id.dup(), rt.new_string('-user')])) {
			var_id = rt.call_function('substr', [var_id.dup(), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])
			var_in_admin = rt.new_string(rt.new_string('user'))
		}
		var_id = rt.call_function('sanitize_key', [var_id.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.call_function('str_starts_with', [var_id.dup(), rt.new_string('edit-')])))) {
			mut var_maybe := rt.call_function('substr', [var_id.dup(), rt.new_int(5)])
			if rt.is_true(rt.call_function('taxonomy_exists', [var_maybe.dup()])) {
				var_id = rt.new_string(rt.new_string('edit-tags'))
				var_taxonomy = var_maybe.dup()
			} else if rt.is_true(rt.call_function('post_type_exists', [var_maybe.dup()])) {
				var_id = rt.new_string(rt.new_string('edit'))
				var_post_type = var_maybe.dup()
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_in_admin)))) {
			var_in_admin = rt.new_string(rt.new_string('site'))
		}
	} else {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_NETWORK_ADMIN')])) && rt.is_true(rt.get_constant('WP_NETWORK_ADMIN')))) {
			var_in_admin = rt.new_string(rt.new_string('network'))
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_USER_ADMIN')])) && rt.is_true(rt.get_constant('WP_USER_ADMIN')))) {
			var_in_admin = rt.new_string(rt.new_string('user'))
		} else {
			var_in_admin = rt.new_string(rt.new_string('site'))
		}
	}
	if rt.is_true(rt.identical(rt.new_string('index'), var_id)) {
		var_id = rt.new_string(rt.new_string('dashboard'))
	} else if rt.is_true(rt.identical(rt.new_string('front'), var_id)) {
		var_in_admin = rt.new_bool(rt.new_bool(false))
	}
	mut var_base := var_id.dup()
	if !(var_hook_name.len > 0 && var_hook_name != '0') {
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_type')) {
			var_post_type = if rt.is_true(rt.call_function('post_type_exists', [rt.get_superglobal('_REQUEST').array_get('post_type')])) { rt.get_superglobal('_REQUEST').array_get('post_type') } else { rt.new_bool(false) }
		}
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('taxonomy')) {
			var_taxonomy = if rt.is_true(rt.call_function('taxonomy_exists', [rt.get_superglobal('_REQUEST').array_get('taxonomy')])) { rt.get_superglobal('_REQUEST').array_get('taxonomy') } else { rt.new_bool(false) }
		}
		mut switch_val_1 := var_base
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('post'))) {
			if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('post')) && rt.get_superglobal('_POST').array_isset(rt.new_string('post_ID')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('A post ID mismatch has been detected.')]), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this item.')]), rt.new_int(400)])
			} else if rt.get_superglobal('_GET').array_isset(rt.new_string('post')) {
				mut var_post_id := // unsupported expression: Expr_Cast_Int
			} else if rt.get_superglobal('_POST').array_isset(rt.new_string('post_ID')) {
				var_post_id = // unsupported expression: Expr_Cast_Int
			} else {
				var_post_id = rt.new_int(rt.new_int(0))
			}
			if rt.is_true(var_post_id) {
				mut var_post := rt.call_function('get_post', [var_post_id.dup()])
				if rt.is_true(var_post) {
					var_post_type = rt.get_property(var_post, 'post_type')
					mut var_replace_editor := rt.call_function('apply_filters', [rt.new_string('replace_editor'), rt.new_bool(false), var_post.dup()])
					if rt.is_true(rt.new_bool(!(rt.is_true(var_replace_editor)))) {
						var_is_block_editor = rt.call_function('use_block_editor_for_post', [var_post.dup()])
					}
				}
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit-tags'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('term'))) {
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_post_type)) && rt.is_true(rt.call_function('is_object_in_taxonomy', [rt.new_string('post'), if rt.is_true(var_taxonomy) { var_taxonomy } else { rt.new_string('post_tag') }])))) {
				var_post_type = rt.new_string(rt.new_string('post'))
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('upload'))) {
			var_post_type = rt.new_string(rt.new_string('attachment'))
		}
	}
	mut switch_val_2 := var_base
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('post'))) {
		if rt.is_true(rt.identical(rt.new_null(), var_post_type)) {
			var_post_type = rt.new_string(rt.new_string('post'))
		}
		if !rt.is_true(var_post_id) {
			var_is_block_editor = rt.call_function('use_block_editor_for_post_type', [var_post_type.dup()])
		}
		var_id = var_post_type.dup()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('edit'))) {
		if rt.is_true(rt.identical(rt.new_null(), var_post_type)) {
			var_post_type = rt.new_string(rt.new_string('post'))
		}
		// unsupported expression: Expr_AssignOp_Concat
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('edit-tags'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('term'))) {
		if rt.is_true(rt.identical(rt.new_null(), var_taxonomy)) {
			var_taxonomy = rt.new_string(rt.new_string('post_tag'))
		}
		if rt.is_true(rt.identical(rt.new_null(), var_post_type)) {
			var_post_type = rt.new_string(rt.new_string('post'))
			if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_type')) && rt.is_true(rt.call_function('post_type_exists', [rt.get_superglobal('_REQUEST').array_get('post_type')])))) {
				var_post_type = rt.get_superglobal('_REQUEST').array_get('post_type')
			}
		}
		var_id = rt.new_string('edit-' + (var_taxonomy).str())
	}
	if rt.is_true(rt.identical(rt.new_string('network'), var_in_admin)) {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	} else if rt.is_true(rt.identical(rt.new_string('user'), var_in_admin)) {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	}
	if // unsupported expression: Expr_StaticPropertyFetch.array_isset(var_id) {
		mut var_screen := // unsupported expression: Expr_StaticPropertyFetch.array_get(var_id)
		if rt.is_true(rt.identical(rt.call_function('get_current_screen', []rt.PhpVal{}), var_screen)) {
			return var_screen.dup()
		}
	} else {
		var_screen = create_self()
		rt.set_property(var_screen, 'id', var_id.dup())
	}
	rt.set_property(var_screen, 'base', var_base.dup())
	rt.set_property(var_screen, 'action', var_action.dup())
	rt.set_property(var_screen, 'post_type', // unsupported expression: Expr_Cast_String)
	rt.set_property(var_screen, 'taxonomy', // unsupported expression: Expr_Cast_String)
	rt.set_property(var_screen, 'is_user', rt.identical(rt.new_string('user'), var_in_admin))
	rt.set_property(var_screen, 'is_network', rt.identical(rt.new_string('network'), var_in_admin))
	rt.set_property(var_screen, 'in_admin', var_in_admin.dup())
	rt.set_property(var_screen, 'is_block_editor', var_is_block_editor.dup())
	// unsupported expression: Expr_StaticPropertyFetch.array_set(var_id, var_screen.dup())
	return var_screen.dup()
}

fn (mut this Class_WP_Screen) set_current_screen()  {
	// unsupported statement: Stmt_Global
	mut var_current_screen := rt.new_object('WP_Screen', []string{}, &this).dup()
	mut var_typenow := this.post_type
	mut var_taxnow := this.taxonomy
	rt.call_function('do_action', [rt.new_string('current_screen'), var_current_screen.dup()])
}

fn (mut this Class_WP_Screen) construct()  {
}

fn (mut this Class_WP_Screen) in_admin(var_admin rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_admin) {
		return // unsupported expression: Expr_Cast_Bool
	}
	return rt.identical(var_admin, this.in_admin)
}

fn (mut this Class_WP_Screen) is_block_editor(var_set rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.is_block_editor = // unsupported expression: Expr_Cast_Bool
	}
	return this.is_block_editor
}

fn Class_WP_Screen.add_old_compat_help(var_screen rt.PhpVal, var_help rt.PhpVal)  {
	mut var_screen_mutated := var_screen
	// unsupported expression: Expr_StaticPropertyFetch.array_set(rt.get_property(var_screen_mutated, 'id'), var_help.dup())
}

fn (mut this Class_WP_Screen) set_parentage(var_parent_file rt.PhpVal)  {
	this.parent_file = var_parent_file.dup()
	// unsupported assign target: Expr_List
	this.parent_base = rt.call_function('str_replace', [rt.new_string('.php'), rt.new_string(''), this.parent_base])
}

fn (mut this Class_WP_Screen) add_option(var_option rt.PhpVal, var_args rt.PhpVal)  {
	mut var_option_mutated := var_option
	mut var_args_mutated := var_args
	this._options.array_set(var_option_mutated, var_args_mutated.dup())
}

fn (mut this Class_WP_Screen) remove_option(var_option rt.PhpVal)  {
	mut var_option_mutated := var_option
	this._options.array_unset(var_option_mutated)
}

fn (mut this Class_WP_Screen) remove_options()  {
	this._options = rt.new_array()
}

fn (mut this Class_WP_Screen) get_options() rt.PhpVal {
	return this._options
}

fn (mut this Class_WP_Screen) get_option(var_option rt.PhpVal, key bool) rt.PhpVal {
	mut var_option_mutated := var_option
	if !(this._options.array_isset(var_option_mutated)) {
		return rt.new_null()
	}
	if var_key {
		return if !(this._options.array_get(var_option_mutated).array_get(key)).is_null() { this._options.array_get(var_option_mutated).array_get(key) } else { rt.new_null() }
	}
	return this._options.array_get(var_option_mutated)
}

fn (mut this Class_WP_Screen) get_help_tabs() rt.PhpVal {
	mut var_help_tabs := this._help_tabs
	mut var_priorities := rt.new_array()
	{
		mut iter_1 := var_help_tabs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_help_tab := item_1.val
			if var_priorities.array_isset(var_help_tab.array_get('priority')) {
				.array_get_mut().array_push(.dup())
			} else {
				
			}
		}
	}
	
}

fn (mut this Class_WP_Screen) get_help_tab(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
}

fn (mut this Class_WP_Screen) add_help_tab(var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Screen) remove_help_tab(var_id rt.PhpVal)  {
	mut var_id_mutated := var_id
}

fn (mut this Class_WP_Screen) remove_help_tabs()  {
}

fn (mut this Class_WP_Screen) get_help_sidebar() rt.PhpVal {
}

fn (mut this Class_WP_Screen) set_help_sidebar(var_content rt.PhpVal)  {
	mut var_content_mutated := var_content
}

fn (mut this Class_WP_Screen) get_columns() rt.PhpVal {
}

fn (mut this Class_WP_Screen) get_screen_reader_content() rt.PhpVal {
}

fn (mut this Class_WP_Screen) get_screen_reader_text(var_key rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Screen) set_screen_reader_content(var_content rt.PhpVal)  {
	mut var_content_mutated := var_content
}

fn (mut this Class_WP_Screen) remove_screen_reader_content()  {
}

fn (mut this Class_WP_Screen) render_screen_meta()  {
	mut var_GLOBALS := rt.new_null()
}

fn (mut this Class_WP_Screen) show_screen_options() rt.PhpVal {
	mut var_wp_meta_boxes := rt.new_null()
}

fn (mut this Class_WP_Screen) render_screen_options(var_options rt.PhpVal)  {
	mut var_options_mutated := var_options
}

fn (mut this Class_WP_Screen) render_meta_boxes_preferences()  {
	mut var_wp_meta_boxes := rt.new_null()
}

fn (mut this Class_WP_Screen) render_list_table_columns_preferences()  {
}

fn (mut this Class_WP_Screen) render_screen_layout()  {
}

fn (mut this Class_WP_Screen) render_per_page_options()  {
}

fn (mut this Class_WP_Screen) render_view_mode()  {
}

fn (mut this Class_WP_Screen) render_screen_reader_content(key string, tag string)  {
}

struct Class_self {
	rt.PhpObjectBase
}

fn create_wp_screen() &Class_WP_Screen {
	mut obj := &Class_WP_Screen{
		PhpObjectBase: rt.PhpObjectBase{}
		action: rt.new_null()
		base: rt.new_null()
		columns: rt.new_int(0)
		id: rt.new_null()
		in_admin: rt.new_null()
		is_network: rt.new_null()
		is_user: rt.new_null()
		parent_base: rt.new_null()
		parent_file: rt.new_null()
		post_type: rt.new_null()
		taxonomy: rt.new_null()
		_help_tabs: rt.new_array()
		_help_sidebar: rt.new_string('')
		_screen_reader_content: rt.new_array()
		_old_compat_help: rt.new_array()
		_options: rt.new_array()
		_registry: rt.new_array()
		_show_screen_options: rt.new_null()
		_screen_settings: rt.new_null()
		is_block_editor: rt.new_bool(false)
	}
	obj.construct()
	return obj
}

fn create_self() &Class_self {
	mut obj := &Class_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Screen) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WP_Screen.get(dispatch_arg_0)
		}
		'set_current_screen' {
			this.set_current_screen()
			return rt.new_null()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'in_admin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.in_admin(dispatch_arg_0)
		}
		'is_block_editor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_block_editor(dispatch_arg_0)
		}
		'add_old_compat_help' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WP_Screen.add_old_compat_help(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_parentage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_parentage(dispatch_arg_0)
			return rt.new_null()
		}
		'add_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_option(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'remove_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_option(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_options' {
			this.remove_options()
			return rt.new_null()
		}
		'get_options' {
			return this.get_options()
		}
		'get_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_option(dispatch_arg_0, dispatch_arg_1)
		}
		'get_help_tabs' {
			return this.get_help_tabs()
		}
		'get_help_tab' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_help_tab(dispatch_arg_0)
		}
		'add_help_tab' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_help_tab(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_help_tab' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_help_tab(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_help_tabs' {
			this.remove_help_tabs()
			return rt.new_null()
		}
		'get_help_sidebar' {
			return this.get_help_sidebar()
		}
		'set_help_sidebar' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_help_sidebar(dispatch_arg_0)
			return rt.new_null()
		}
		'get_columns' {
			return this.get_columns()
		}
		'get_screen_reader_content' {
			return this.get_screen_reader_content()
		}
		'get_screen_reader_text' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_screen_reader_text(dispatch_arg_0)
		}
		'set_screen_reader_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_screen_reader_content(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_screen_reader_content' {
			this.remove_screen_reader_content()
			return rt.new_null()
		}
		'render_screen_meta' {
			this.render_screen_meta()
			return rt.new_null()
		}
		'show_screen_options' {
			return this.show_screen_options()
		}
		'render_screen_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.render_screen_options(dispatch_arg_0)
			return rt.new_null()
		}
		'render_meta_boxes_preferences' {
			this.render_meta_boxes_preferences()
			return rt.new_null()
		}
		'render_list_table_columns_preferences' {
			this.render_list_table_columns_preferences()
			return rt.new_null()
		}
		'render_screen_layout' {
			this.render_screen_layout()
			return rt.new_null()
		}
		'render_per_page_options' {
			this.render_per_page_options()
			return rt.new_null()
		}
		'render_view_mode' {
			this.render_view_mode()
			return rt.new_null()
		}
		'render_screen_reader_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.render_screen_reader_content(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Screen) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'action' { return this.action }
		'base' { return this.base }
		'columns' { return this.columns }
		'id' { return this.id }
		'in_admin' { return this.in_admin }
		'is_network' { return this.is_network }
		'is_user' { return this.is_user }
		'parent_base' { return this.parent_base }
		'parent_file' { return this.parent_file }
		'post_type' { return this.post_type }
		'taxonomy' { return this.taxonomy }
		'_help_tabs' { return this._help_tabs }
		'_help_sidebar' { return this._help_sidebar }
		'_screen_reader_content' { return this._screen_reader_content }
		'_old_compat_help' { return this._old_compat_help }
		'_options' { return this._options }
		'_registry' { return this._registry }
		'_show_screen_options' { return this._show_screen_options }
		'_screen_settings' { return this._screen_settings }
		'is_block_editor' { return this.is_block_editor }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Screen) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'action' { this.action = val; return true }
		'base' { this.base = val; return true }
		'columns' { this.columns = val; return true }
		'id' { this.id = val; return true }
		'in_admin' { this.in_admin = val; return true }
		'is_network' { this.is_network = val; return true }
		'is_user' { this.is_user = val; return true }
		'parent_base' { this.parent_base = val; return true }
		'parent_file' { this.parent_file = val; return true }
		'post_type' { this.post_type = val; return true }
		'taxonomy' { this.taxonomy = val; return true }
		'_help_tabs' { this._help_tabs = val; return true }
		'_help_sidebar' { this._help_sidebar = val; return true }
		'_screen_reader_content' { this._screen_reader_content = val; return true }
		'_old_compat_help' { this._old_compat_help = val; return true }
		'_options' { this._options = val; return true }
		'_registry' { this._registry = val; return true }
		'_show_screen_options' { this._show_screen_options = val; return true }
		'_screen_settings' { this._screen_settings = val; return true }
		'is_block_editor' { this.is_block_editor = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_admin_includes_class_wp_screen_php() {
}
