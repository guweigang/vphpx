import rt

struct Class_WP_Screen {
	rt.PhpObjectBase
pub mut:
	action                 rt.PhpVal = rt.new_null()
	base                   rt.PhpVal = rt.new_null()
	columns                rt.PhpVal = rt.new_int(0)
	id                     rt.PhpVal = rt.new_null()
	in_admin               rt.PhpVal = rt.new_null()
	is_network             rt.PhpVal = rt.new_null()
	is_user                rt.PhpVal = rt.new_null()
	parent_base            rt.PhpVal = rt.new_null()
	parent_file            rt.PhpVal = rt.new_null()
	post_type              rt.PhpVal = rt.new_null()
	taxonomy               rt.PhpVal = rt.new_null()
	_help_tabs             rt.PhpVal = rt.new_array()
	_help_sidebar          rt.PhpVal = rt.new_string('')
	_screen_reader_content rt.PhpVal = rt.new_array()
	_options               rt.PhpVal = rt.new_array()
	_show_screen_options   rt.PhpVal = rt.new_null()
	_screen_settings       rt.PhpVal = rt.new_null()
	is_block_editor        rt.PhpVal = rt.new_bool(false)
}

fn init_static_wp_screen() {
	rt.init_static_prop('WP_Screen', '_old_compat_help', rt.new_array())
	rt.init_static_prop('WP_Screen', '_registry', rt.new_array())
}

fn Class_WP_Screen.get(hook_name string) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_string(hook_name), 'WP_Screen'))) {
		return rt.new_string(hook_name)
	}
	mut var_id := rt.new_string('')
	mut var_post_type := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_in_admin := rt.new_bool(false)
	mut var_action := rt.new_string('')
	mut var_is_block_editor := rt.new_bool(false)
	if var_hook_name.len > 0 && var_hook_name != '0' {
		var_id = rt.new_string(hook_name)
	} else if !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('hook_suffix')))) {
		var_id = var_GLOBALS.array_get(rt.new_string('hook_suffix'))
	}
	if var_hook_name.len > 0 && var_hook_name != '0'
		&& rt.is_true(rt.call_function('post_type_exists', [rt.new_string(hook_name)])) {
		var_post_type = var_id.clone()
		var_id = rt.new_string('post')
	} else {
		if rt.is_true(rt.call_function('str_ends_with', [var_id.clone(),
			rt.new_string('.php')]))
		{
			var_id = rt.call_function('substr', [var_id.clone(),
				rt.new_int(0), rt.new_int(-4)])
		}
		if rt.is_true(rt.call_function('in_array', [var_id.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'post-new' },
				rt.ArrayItem{ key: none, val: 'link-add' }, rt.ArrayItem{
					key: none
					val: 'media-new'
				}, rt.ArrayItem{ key: none, val: 'user-new' }]),
			rt.new_bool(true)]))
		{
			var_id = rt.call_function('substr', [var_id.clone(),
				rt.new_int(0), rt.new_int(-4)])
			var_action = rt.new_string('add')
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) && var_hook_name.len > 0
		&& var_hook_name != '0' {
		if rt.is_true(rt.call_function('str_ends_with', [var_id.clone(),
			rt.new_string('-network')]))
		{
			var_id = rt.call_function('substr', [var_id.clone(),
				rt.new_int(0), rt.new_int(-8)])
			var_in_admin = rt.new_string('network')
		} else if rt.is_true(rt.call_function('str_ends_with', [
			var_id.clone(), rt.new_string('-user')]))
		{
			var_id = rt.call_function('substr', [var_id.clone(),
				rt.new_int(0), rt.new_int(-5)])
			var_in_admin = rt.new_string('user')
		}
		var_id = rt.call_function('sanitize_key', [var_id.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('edit-comments'), var_id))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('edit-tags'), var_id))))
			&& rt.is_true(rt.call_function('str_starts_with', [var_id.clone(), rt.new_string('edit-')])) {
			mut var_maybe := rt.call_function('substr', [var_id.clone(),
				rt.new_int(5)])
			if rt.is_true(rt.call_function('taxonomy_exists', [
				var_maybe.clone()]))
			{
				var_id = rt.new_string('edit-tags')
				var_taxonomy = var_maybe.clone()
			} else if rt.is_true(rt.call_function('post_type_exists', [
				var_maybe.clone()]))
			{
				var_id = rt.new_string('edit')
				var_post_type = var_maybe.clone()
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_in_admin)))) {
			var_in_admin = rt.new_string('site')
		}
	} else {
		if rt.is_true(rt.call_function('defined', [rt.new_string('WP_NETWORK_ADMIN')]))
			&& rt.is_true(rt.get_constant('WP_NETWORK_ADMIN')) {
			var_in_admin = rt.new_string('network')
		} else if rt.is_true(rt.call_function('defined', [rt.new_string('WP_USER_ADMIN')]))
			&& rt.is_true(rt.get_constant('WP_USER_ADMIN')) {
			var_in_admin = rt.new_string('user')
		} else {
			var_in_admin = rt.new_string('site')
		}
	}
	if rt.is_true(rt.identical(rt.new_string('index'), var_id)) {
		var_id = rt.new_string('dashboard')
	} else if rt.is_true(rt.identical(rt.new_string('front'), var_id)) {
		var_in_admin = rt.new_bool(false)
	}
	mut var_base := var_id.clone()
	if !(var_hook_name.len > 0 && var_hook_name != '0') {
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_type')) {
			var_post_type = if rt.is_true(rt.call_function('post_type_exists', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_type')),
			]))
			{
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_type'))
			} else {
				rt.new_bool(false)
			}
		}
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('taxonomy')) {
			var_taxonomy = if rt.is_true(rt.call_function('taxonomy_exists', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('taxonomy')),
			]))
			{
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('taxonomy'))
			} else {
				rt.new_bool(false)
			}
		}
		mut switch_val_1 := var_base
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('post'))) {
			if rt.get_superglobal('_GET').array_isset(rt.new_string('post'))
				&& rt.get_superglobal('_POST').array_isset(rt.new_string('post_ID'))
				&& rt.is_true(rt.new_bool(rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('post'))).to_i64()) != rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_ID'))).to_i64()))) {
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('A post ID mismatch has been detected.'),
					]),
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to edit this item.'),
					]),
					rt.new_int(400),
				])
			} else if rt.get_superglobal('_GET').array_isset(rt.new_string('post')) {
				mut var_post_id :=
					rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('post'))).to_i64())
			} else if rt.get_superglobal('_POST').array_isset(rt.new_string('post_ID')) {
				var_post_id =
					rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_ID'))).to_i64())
			} else {
				var_post_id = rt.new_int(0)
			}
			if rt.is_true(var_post_id) {
				mut var_post := rt.call_function('get_post', [
					var_post_id.clone()])
				if rt.is_true(var_post) {
					var_post_type = rt.get_property(var_post, 'post_type')
					mut var_replace_editor := rt.call_function('apply_filters', [
						rt.new_string('replace_editor'),
						rt.new_bool(false),
						var_post.clone(),
					])
					if rt.is_true(rt.new_bool(!(rt.is_true(var_replace_editor)))) {
						var_is_block_editor = rt.call_function('use_block_editor_for_post', [
							var_post.clone(),
						])
					}
				}
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit-tags')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('term'))) {
			if rt.is_true(rt.identical(rt.new_null(), var_post_type))
				&& rt.is_true(rt.call_function('is_object_in_taxonomy', [rt.new_string('post'), if rt.is_true(var_taxonomy) { var_taxonomy } else { rt.new_string('post_tag') }])) {
				var_post_type = rt.new_string('post')
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('upload'))) {
			var_post_type = rt.new_string('attachment')
		}
	}
	mut switch_val_2 := var_base
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('post'))) {
		if rt.is_true(rt.identical(rt.new_null(), var_post_type)) {
			var_post_type = rt.new_string('post')
		}
		if !rt.is_true(var_post_id) {
			var_is_block_editor = rt.call_function('use_block_editor_for_post_type', [
				var_post_type.clone(),
			])
		}
		var_id = var_post_type.clone()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('edit'))) {
		if rt.is_true(rt.identical(rt.new_null(), var_post_type)) {
			var_post_type = rt.new_string('post')
		}
		var_id = rt.concat(var_id, rt.new_string('-' + var_post_type.str()))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('edit-tags')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('term'))) {
		if rt.is_true(rt.identical(rt.new_null(), var_taxonomy)) {
			var_taxonomy = rt.new_string('post_tag')
		}
		if rt.is_true(rt.identical(rt.new_null(), var_post_type)) {
			var_post_type = rt.new_string('post')
			if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_type'))
				&& rt.is_true(rt.call_function('post_type_exists', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_type'))])) {
				var_post_type = rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_type'))
			}
		}
		var_id = rt.new_string('edit-' + var_taxonomy.str())
	}
	if rt.is_true(rt.identical(rt.new_string('network'), var_in_admin)) {
		var_id = rt.concat(var_id, rt.new_string('-network'))
		var_base = rt.concat(var_base, rt.new_string('-network'))
	} else if rt.is_true(rt.identical(rt.new_string('user'), var_in_admin)) {
		var_id = rt.concat(var_id, rt.new_string('-user'))
		var_base = rt.concat(var_base, rt.new_string('-user'))
	}
	if rt.get_static_prop('WP_Screen', '_registry').array_isset(var_id) {
		mut var_screen := rt.get_static_prop('WP_Screen', '_registry').array_get(var_id)
		if rt.is_true(rt.identical(rt.call_function('get_current_screen', []rt.PhpVal{}),
			var_screen))
		{
			return var_screen.clone()
		}
	} else {
		var_screen = create_wp_screen()
		rt.set_property(var_screen, 'id', var_id.clone())
	}
	rt.set_property(var_screen, 'base', var_base.clone())
	rt.set_property(var_screen, 'action', var_action.clone())
	rt.set_property(var_screen, 'post_type', var_post_type.str())
	rt.set_property(var_screen, 'taxonomy', var_taxonomy.str())
	rt.set_property(var_screen, 'is_user', rt.identical(rt.new_string('user'), var_in_admin))
	rt.set_property(var_screen, 'is_network', rt.identical(rt.new_string('network'), var_in_admin))
	rt.set_property(var_screen, 'in_admin', var_in_admin.clone())
	rt.set_property(var_screen, 'is_block_editor', var_is_block_editor.clone())
	rt.get_static_prop('WP_Screen', '_registry').array_set(var_id, var_screen.clone())
	return var_screen.clone()
}

fn (mut this Class_WP_Screen) set_current_screen() {
	mut var_current_screen := rt.get_superglobal('current_screen')
	mut var_taxnow := rt.get_superglobal('taxnow')
	mut var_typenow := rt.get_superglobal('typenow')
	var_current_screen = rt.new_object('WP_Screen', []string{}, &this)
	var_typenow = this.post_type
	var_taxnow = this.taxonomy
	rt.call_function('do_action', [rt.new_string('current_screen'),
		var_current_screen.clone()])
}

fn (mut this Class_WP_Screen) construct() {
}

fn (mut this Class_WP_Screen) in_admin(var_admin rt.PhpVal) bool {
	if !rt.is_true(var_admin) {
		return (this.in_admin).to_bool()
	}
	return (rt.identical(var_admin, this.in_admin)).to_bool()
}

fn (mut this Class_WP_Screen) is_block_editor(var_set rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_set)))) {
		this.is_block_editor = var_set.to_bool()
	}
	return this.is_block_editor
}

fn Class_WP_Screen.add_old_compat_help(var_screen rt.PhpVal, var_help rt.PhpVal) {
	mut var_screen_mutated := var_screen
	rt.get_static_prop('WP_Screen', '_old_compat_help').array_set(rt.get_property(var_screen_mutated,
		'id'), var_help.clone())
}

fn (mut this Class_WP_Screen) set_parentage(var_parent_file rt.PhpVal) {
	this.parent_file = var_parent_file.clone()
	mut list_tmp_1 := rt.call_function('explode', [rt.new_string('?'),
		var_parent_file.clone()])
	this.parent_base = rt.call_function('str_replace', [rt.new_string('.php'),
		rt.new_string(''), this.parent_base])
}

fn (mut this Class_WP_Screen) add_option(var_option rt.PhpVal, var_args rt.PhpVal) {
	mut var_option_mutated := var_option
	mut var_args_mutated := var_args
	this._options.array_set(var_option_mutated, var_args_mutated.clone())
}

fn (mut this Class_WP_Screen) remove_option(var_option rt.PhpVal) {
	mut var_option_mutated := var_option
	this._options.array_unset(var_option_mutated)
}

fn (mut this Class_WP_Screen) remove_options() {
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
		return if !(this._options.array_get(var_option_mutated).array_get(rt.new_bool(key))).is_null() {
			this._options.array_get(var_option_mutated).array_get(rt.new_bool(key))
		} else {
			rt.new_null()
		}
	}
	return this._options.array_get(var_option_mutated)
}

fn (mut this Class_WP_Screen) get_help_tabs() rt.PhpVal {
	mut var_help_tabs := this._help_tabs
	mut var_priorities := rt.new_array()
	mut iter_1 := var_help_tabs.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_help_tab := item_1.val
		if var_priorities.array_isset(var_help_tab.array_get(rt.new_string('priority'))) {
			var_priorities.array_get_mut(var_help_tab.array_get(rt.new_string('priority'))).array_push(var_help_tab.clone())
		} else {
			var_priorities.array_set(var_help_tab.array_get(rt.new_string('priority')), rt.create_array([
				rt.ArrayItem{ key: none, val: var_help_tab },
			]))
		}
	}
	rt.call_function('ksort', [var_priorities.clone()])
	mut var_sorted := rt.new_array()
	mut iter_2 := var_priorities.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_list := item_2.val
		mut iter_3 := var_list.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_tab := item_3.val
			var_sorted.array_set(var_tab.array_get(rt.new_string('id')), var_tab.clone())
		}
	}
	return var_sorted.clone()
}

fn (mut this Class_WP_Screen) get_help_tab(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	if !(this._help_tabs.array_isset(var_id_mutated)) {
		return rt.new_null()
	}
	return this._help_tabs.array_get(var_id_mutated)
}

fn (mut this Class_WP_Screen) add_help_tab(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_defaults := {
		'title':    rt.new_bool(false)
		'id':       rt.new_bool(false)
		'content':  rt.new_string('')
		'callback': rt.new_bool(false)
		'priority': rt.new_int(10)
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array_from_native_map(var_defaults)])
	var_args_mutated.array_set('id', rt.call_function('sanitize_html_class', [
		var_args_mutated.array_get(rt.new_string('id')),
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get(rt.new_string('id'))))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get(rt.new_string('title')))))) {
		return
	}
	this._help_tabs.array_set(var_args_mutated.array_get(rt.new_string('id')),
		var_args_mutated.clone())
}

fn (mut this Class_WP_Screen) remove_help_tab(var_id rt.PhpVal) {
	mut var_id_mutated := var_id
	this._help_tabs.array_unset(var_id_mutated)
}

fn (mut this Class_WP_Screen) remove_help_tabs() {
	this._help_tabs = rt.new_array()
}

fn (mut this Class_WP_Screen) get_help_sidebar() rt.PhpVal {
	return this._help_sidebar
}

fn (mut this Class_WP_Screen) set_help_sidebar(var_content rt.PhpVal) {
	mut var_content_mutated := var_content
	this._help_sidebar = var_content_mutated.clone()
}

fn (mut this Class_WP_Screen) get_columns() rt.PhpVal {
	return this.columns
}

fn (mut this Class_WP_Screen) get_screen_reader_content() rt.PhpVal {
	return this._screen_reader_content
}

fn (mut this Class_WP_Screen) get_screen_reader_text(var_key rt.PhpVal) rt.PhpVal {
	if !(this._screen_reader_content.array_isset(var_key)) {
		return rt.new_null()
	}
	return this._screen_reader_content.array_get(var_key)
}

fn (mut this Class_WP_Screen) set_screen_reader_content(var_content rt.PhpVal) {
	mut var_content_mutated := var_content
	mut var_defaults := {
		'heading_views':      rt.call_function('__', [rt.new_string('Filter items list')])
		'heading_pagination': rt.call_function('__', [
			rt.new_string('Items list navigation'),
		])
		'heading_list':       rt.call_function('__', [rt.new_string('Items list')])
	}
	var_content_mutated = rt.call_function('wp_parse_args', [
		var_content_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	this._screen_reader_content = var_content_mutated.clone()
}

fn (mut this Class_WP_Screen) remove_screen_reader_content() {
	this._screen_reader_content = rt.new_array()
}

fn (mut this Class_WP_Screen) render_screen_meta() {
	mut var_GLOBALS := rt.new_null()
	rt.set_static_prop('WP_Screen', '_old_compat_help', rt.call_function('apply_filters_deprecated', [
		rt.new_string('contextual_help_list'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_static_prop('WP_Screen', '_old_compat_help') },
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Screen', []string{}, &this) },
		]),
		rt.new_string('3.3.0'),
		rt.new_string('get_current_screen()->add_help_tab(), get_current_screen()->remove_help_tab()'),
	]))
	mut var_old_help := if !(rt.get_static_prop('WP_Screen', '_old_compat_help').array_get(this.id)).is_null() {
		rt.get_static_prop('WP_Screen', '_old_compat_help').array_get(this.id)
	} else {
		rt.new_string('')
	}
	var_old_help = rt.call_function('apply_filters_deprecated', [
		rt.new_string('contextual_help'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_old_help },
			rt.ArrayItem{ key: none, val: this.id }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Screen',
				[]string{}, &this) }]),
		rt.new_string('3.3.0'),
		rt.new_string('get_current_screen()->add_help_tab(), get_current_screen()->remove_help_tab()'),
	])
	if !rt.is_true(var_old_help) && rt.is_true(rt.new_bool(!(rt.is_true(this.get_help_tabs())))) {
		mut var_default_help := rt.call_function('apply_filters_deprecated', [
			rt.new_string('default_contextual_help'),
			rt.create_array([rt.ArrayItem{ key: none, val: '' }]),
			rt.new_string('3.3.0'),
			rt.new_string('get_current_screen()->add_help_tab(), get_current_screen()->remove_help_tab()'),
		])
		if rt.is_true(var_default_help) {
			var_old_help = rt.new_string('<p>' + var_default_help.str() + '</p>')
		}
	}
	if rt.is_true(var_old_help) {
		this.add_help_tab(rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'old-contextual-help' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) },
			rt.ArrayItem{ key: 'content', val: var_old_help },
		]))
	}
	mut var_help_sidebar := this.get_help_sidebar()
	mut var_help_class := rt.new_string('hidden')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_help_sidebar)))) {
		var_help_class = rt.concat(var_help_class, rt.new_string(' no-sidebar'))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_help_class.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Contextual Help Tab')])
	// unsupported statement: Stmt_InlineHTML
	mut var_class := rt.new_string(' class="active"')
	mut iter_4 := this.get_help_tabs().iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_tab := item_4.val
		mut var_link_id := rt.new_string((rt.concat(rt.new_string('tab-link-'),
			var_tab.array_get(rt.new_string('id')))).str())
		mut var_panel_id := rt.new_string((rt.concat(rt.new_string('tab-panel-'),
			var_tab.array_get(rt.new_string('id')))).str())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_link_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_class)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.new_string('#${var_panel_id.to_string()}'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_panel_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_tab.array_get(rt.new_string('title'))]))
		// unsupported statement: Stmt_InlineHTML
		var_class = rt.new_string('')
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_help_sidebar) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_help_sidebar)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_classes := rt.new_string('help-tab-content active')
	mut iter_5 := this.get_help_tabs().iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_tab := item_5.val
		mut var_panel_id := rt.new_string((rt.concat(rt.new_string('tab-panel-'),
			var_tab.array_get(rt.new_string('id')))).str())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_panel_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_classes)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_tab.array_get(rt.new_string('content')))
		if !(!rt.is_true(var_tab.array_get(rt.new_string('callback')))) {
			rt.call_function('call_user_func_array', [
				var_tab.array_get(rt.new_string('callback')),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_Screen', []string{}, &this) },
					rt.ArrayItem{ key: none, val: var_tab },
				]),
			])
		}
		// unsupported statement: Stmt_InlineHTML
		var_classes = rt.new_string('help-tab-content')
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_columns := rt.call_function('apply_filters', [
		rt.new_string('screen_layout_columns'),
		rt.new_array(),
		this.id,
		rt.new_object('WP_Screen', []string{}, &this),
	])
	if !(!rt.is_true(var_columns)) && var_columns.array_isset(this.id) {
		this.add_option(rt.new_string('layout_columns'), rt.create_array([
			rt.ArrayItem{ key: 'max', val: var_columns.array_get(this.id) },
		]))
	}
	if rt.is_true(this.get_option(rt.new_string('layout_columns'), false)) {
		this.columns = rt.new_int((rt.call_function('get_user_option', [
			rt.concat(rt.new_string('screen_layout_'), this.id),
		])).to_i64())
		mut var_layout_columns := rt.new_int((this.get_option(rt.new_string('layout_columns'),
			'default')).to_i64())
		if rt.is_true(rt.new_bool(!(rt.is_true(this.columns)))) && rt.is_true(var_layout_columns) {
			this.columns = var_layout_columns.clone()
		}
	}
	var_GLOBALS.array_set('screen_layout_columns', this.columns)
	if rt.is_true(this.show_screen_options()) {
		this.render_screen_options(rt.new_null())
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_help_tabs()))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(this.show_screen_options())))) {
		return
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(this.show_screen_options()) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Screen Options')])
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(this.get_help_tabs()) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Help')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Screen) show_screen_options() rt.PhpVal {
	mut var_wp_meta_boxes := rt.new_null()
	if rt.is_true(rt.new_bool(this._show_screen_options.is_bool())) {
		return this._show_screen_options
	}
	mut var_columns := rt.call_function('get_column_headers', [
		rt.new_object('WP_Screen', []string{}, &this),
	])
	mut var_show_screen := rt.new_bool(!(!rt.is_true(var_wp_meta_boxes.array_get(this.id)))
		|| rt.is_true(var_columns) || rt.is_true(this.get_option(rt.new_string('per_page'), false)))
	this._screen_settings = rt.new_string('')
	if rt.is_true(rt.identical(rt.new_string('post'), this.base)) {
		mut var_expand := rt.new_string('<fieldset class="editor-expand hidden"><legend>' +
			(rt.call_function('__', [rt.new_string('Additional settings')])).str() +
			'</legend><label for="editor-expand-toggle">')
		var_expand = rt.concat(var_expand, rt.new_string(
			'<input type="checkbox" id="editor-expand-toggle"' +
			(rt.call_function('checked', [rt.call_function('get_user_setting', [rt.new_string('editor_expand'), rt.new_string('on')]), rt.new_string('on'), rt.new_bool(false)])).str() +
			' />'))
		var_expand = rt.concat(var_expand, rt.new_string(
			(rt.call_function('__', [rt.new_string('Enable full-height editor and distraction-free functionality.')])).str() +
			'</label></fieldset>'))
		this._screen_settings = var_expand.clone()
	}
	this._screen_settings = rt.call_function('apply_filters', [
		rt.new_string('screen_settings'),
		this._screen_settings,
		rt.new_object('WP_Screen', []string{}, &this),
	])
	if rt.is_true(this._screen_settings) || rt.is_true(this._options) {
		var_show_screen = rt.new_bool(true)
	}
	this._show_screen_options = rt.call_function('apply_filters', [
		rt.new_string('screen_options_show_screen'),
		var_show_screen.clone(),
		rt.new_object('WP_Screen', []string{}, &this),
	])
	return this._show_screen_options
}

fn (mut this Class_WP_Screen) render_screen_options(var_options rt.PhpVal) {
	mut var_options_mutated := var_options
	var_options_mutated = rt.call_function('wp_parse_args', [
		var_options_mutated.clone(), rt.create_array([
			rt.ArrayItem{ key: 'wrap', val: true },
		])])
	mut var_wrapper_start := rt.new_string('')
	mut var_wrapper_end := rt.new_string('')
	mut var_form_start := rt.new_string('')
	mut var_form_end := rt.new_string('')
	if rt.is_true(var_options_mutated.array_get(rt.new_string('wrap'))) {
		var_wrapper_start = rt.new_string(
			'<div id="screen-options-wrap" class="hidden" tabindex="-1" aria-label="' +
			(rt.call_function('esc_attr__', [rt.new_string('Screen Options Tab')])).str() + '">')
		var_wrapper_end = rt.new_string('</div>')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('widgets'), this.base)))) {
		var_form_start = rt.new_string("\n<form id='adv-settings' method='post'>\n")
		var_form_end = rt.new_string('\n' +
			(rt.call_function('wp_nonce_field', [rt.new_string('screen-options-nonce'), rt.new_string('screenoptionnonce'), rt.new_bool(false), rt.new_bool(false)])).str() +
			'\n</form>\n')
	}
	print(var_wrapper_start.str() + var_form_start.str())
	this.render_meta_boxes_preferences()
	this.render_list_table_columns_preferences()
	this.render_screen_layout()
	this.render_per_page_options()
	this.render_view_mode()
	rt.echo_val(this._screen_settings)
	mut var_show_button := rt.call_function('apply_filters', [
		rt.new_string('screen_options_show_submit'),
		rt.new_bool(false),
		rt.new_object('WP_Screen', []string{}, &this),
	])
	if rt.is_true(var_show_button) {
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Apply')]),
			rt.new_string('primary'),
			rt.new_string('screen-options-apply'),
			rt.new_bool(true),
		])
	}
	print(var_form_end.str() + var_wrapper_end.str())
}

fn (mut this Class_WP_Screen) render_meta_boxes_preferences() {
	mut var_wp_meta_boxes := rt.new_null()
	if !(var_wp_meta_boxes.array_isset(this.id)) {
		return
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Screen elements')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Some screen elements can be shown or hidden by using the checkboxes.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Expand or collapse the elements by clicking on their headings, and arrange them by dragging their headings or by clicking on the up and down arrows.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('meta_box_prefs', [rt.new_object('WP_Screen', []string{}, &this)])
	if rt.is_true(rt.identical(rt.new_string('dashboard'), this.id))
		&& rt.is_true(rt.call_function('has_action', [rt.new_string('welcome_panel')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])) {
		if rt.get_superglobal('_GET').array_isset(rt.new_string('welcome')) {
			mut var_welcome_checked := rt.new_int(if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('welcome'))) {
				0
			} else {
				1
			})
			rt.call_function('update_user_meta', [
				rt.call_function('get_current_user_id', []rt.PhpVal{}),
				rt.new_string('show_welcome_panel'),
				var_welcome_checked.clone(),
			])
		} else {
			var_welcome_checked = rt.new_int((rt.call_function('get_user_meta', [
				rt.call_function('get_current_user_id', []rt.PhpVal{}),
				rt.new_string('show_welcome_panel'),
				rt.new_bool(true),
			])).to_i64())
			if rt.is_true(rt.identical(rt.new_int(2), var_welcome_checked))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(rt.call_function('wp_get_current_user', []rt.PhpVal{}), 'user_email'), rt.call_function('get_option', [rt.new_string('admin_email')]))))) {
				var_welcome_checked = rt.new_bool(false)
			}
		}
		print('<label for="wp_welcome_panel-hide">')
		print('<input type="checkbox" id="wp_welcome_panel-hide"' +
			(rt.call_function('checked', [rt.new_bool(var_welcome_checked.to_bool()), rt.new_bool(true), rt.new_bool(false)])).str() +
			' />')
		print(
			(rt.call_function('_x', [rt.new_string('Welcome'), rt.new_string('Welcome panel')])).str() +
			'</label>\n')
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Screen) render_list_table_columns_preferences() {
	mut var_columns := rt.call_function('get_column_headers', [
		rt.new_object('WP_Screen', []string{}, &this),
	])
	mut var_hidden := rt.call_function('get_hidden_columns', [
		rt.new_object('WP_Screen', []string{}, &this),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_columns)))) {
		return
	}
	mut var_legend := if !(!rt.is_true(var_columns.array_get(rt.new_string('_title')))) { var_columns.array_get(rt.new_string('_title')) } else { rt.call_function('__', [
			rt.new_string('Columns'),
		]) }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_legend)
	// unsupported statement: Stmt_InlineHTML
	mut var_special := ['_title', 'cb', 'comment', 'media', 'name', 'title', 'username', 'blogname']
	mut iter_6 := var_columns.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_title := item_6.val
		mut var_column := item_6.key
		if rt.is_true(rt.call_function('in_array', [var_column.clone(),
			rt.create_array_from_list(var_special), rt.new_bool(true)]))
		{
			continue
		}
		if !rt.is_true(var_title) {
			continue
		}
		var_title = rt.call_function('wp_strip_all_tags', [var_title.clone()])
		mut var_id := rt.new_string('${var_column.to_string()}-hide')
		print('<label>')
		print('<input class="hide-column-tog" name="' + var_id.str() + '" type="checkbox" id="' +
			var_id.str() + '" value="' + var_column.str() + '"' +
			(rt.call_function('checked', [rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_column.clone(), var_hidden.clone(), rt.new_bool(true)])))), rt.new_bool(true), rt.new_bool(false)])).str() +
			' />')
		print('${var_title.to_string()}</label>\n')
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Screen) render_screen_layout() {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_option(rt.new_string('layout_columns'), false))))) {
		return
	}
	mut var_screen_layout_columns := this.get_columns()
	mut var_num := this.get_option(rt.new_string('layout_columns'), 'max')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Layout')])
	// unsupported statement: Stmt_InlineHTML
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less_equal(var_i, var_num))) { break
		 }
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_i)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [var_screen_layout_columns.clone(),
			var_i.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('_n', [rt.new_string('%s column'),
				rt.new_string('%s columns'), var_i.clone()]),
			rt.call_function('number_format_i18n', [var_i.clone()]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.pre_inc(var_i)
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Screen) render_per_page_options() {
	if rt.is_true(rt.identical(rt.new_null(), this.get_option(rt.new_string('per_page'), false))) {
		return
	}
	mut var_per_page_label := this.get_option(rt.new_string('per_page'), 'label')
	if rt.is_true(rt.identical(rt.new_null(), var_per_page_label)) {
		var_per_page_label = rt.call_function('__', [
			rt.new_string('Number of items per page:'),
		])
	}
	mut var_option := this.get_option(rt.new_string('per_page'), 'option')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_option)))) {
		var_option = rt.call_function('str_replace', [rt.new_string('-'),
			rt.new_string('_'), rt.concat(this.id, rt.new_string('_per_page'))])
	}
	mut var_per_page := rt.new_int((rt.call_function('get_user_option', [
		var_option.clone()])).to_i64())
	if !rt.is_true(var_per_page) || rt.is_true(rt.less(var_per_page, rt.new_int(1))) {
		var_per_page = this.get_option(rt.new_string('per_page'), 'default')
		if rt.is_true(rt.new_bool(!(rt.is_true(var_per_page)))) {
			var_per_page = rt.new_int(20)
		}
	}
	if rt.is_true(rt.identical(rt.new_string('edit_comments_per_page'), var_option)) {
		mut var_comment_status := if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('comment_status'))).is_null() {
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('comment_status'))
		} else {
			rt.new_string('all')
		}
		var_per_page = rt.call_function('apply_filters', [
			rt.new_string('comments_per_page'),
			var_per_page.clone(),
			var_comment_status.clone(),
		])
	} else if rt.is_true(rt.identical(rt.new_string('categories_per_page'), var_option)) {
		var_per_page = rt.call_function('apply_filters', [
			rt.new_string('edit_categories_per_page'),
			var_per_page.clone(),
		])
	} else {
		var_per_page = rt.call_function('apply_filters', [
			rt.new_string('${var_option.to_string()}'),
			var_per_page.clone(),
		])
	}
	if !(this.post_type).is_null() {
		var_per_page = rt.call_function('apply_filters', [
			rt.new_string('edit_posts_per_page'),
			var_per_page.clone(),
			this.post_type,
		])
	}
	rt.call_function('add_filter', [rt.new_string('screen_options_show_submit'),
		rt.new_string('__return_true')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Pagination')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_per_page_label) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_option.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_per_page_label)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_option.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_per_page.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_option.clone()]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Screen) render_view_mode() {
	mut var_mode := rt.get_superglobal('mode')
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('edit'), rt.get_property(var_screen, 'base')))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('edit-comments'), rt.get_property(var_screen, 'base'))))) {
		return
	}
	mut var_view_mode_post_types := rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'show_ui', val: true }]),
	])
	var_view_mode_post_types = rt.call_function('apply_filters', [
		rt.new_string('view_mode_post_types'),
		var_view_mode_post_types.clone(),
	])
	if rt.is_true(rt.identical(rt.new_string('edit'), rt.get_property(var_screen, 'base')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [this.post_type, var_view_mode_post_types.clone(), rt.new_bool(true)]))))) {
		return
	}
	if !(!var_mode.is_null()) {
		var_mode = rt.call_function('get_user_setting', [
			rt.new_string('posts_list_mode'),
			rt.new_string('list'),
		])
	}
	rt.call_function('add_filter', [rt.new_string('screen_options_show_submit'),
		rt.new_string('__return_true')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('View mode')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('list'), var_mode.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Compact view')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('excerpt'), var_mode.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Extended view')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Screen) render_screen_reader_content(key string, tag string) {
	if !(this._screen_reader_content.array_isset(rt.new_string(key))) {
		return
	}
	print("<${var_tag} class='screen-reader-text'>" +
		(this._screen_reader_content.array_get(rt.new_string(key))).str() + '</${var_tag}>')
}

fn create_wp_screen() &Class_WP_Screen {
	mut obj := &Class_WP_Screen{
		PhpObjectBase:          rt.PhpObjectBase{}
		action:                 rt.new_null()
		base:                   rt.new_null()
		columns:                rt.new_int(0)
		id:                     rt.new_null()
		in_admin:               rt.new_null()
		is_network:             rt.new_null()
		is_user:                rt.new_null()
		parent_base:            rt.new_null()
		parent_file:            rt.new_null()
		post_type:              rt.new_null()
		taxonomy:               rt.new_null()
		_help_tabs:             rt.new_array()
		_help_sidebar:          rt.new_string('')
		_screen_reader_content: rt.new_array()
		_options:               rt.new_array()
		_show_screen_options:   rt.new_null()
		_screen_settings:       rt.new_null()
		is_block_editor:        rt.new_bool(false)
	}
	obj.construct()
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
			return rt.new_bool(this.in_admin(dispatch_arg_0))
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
		else {
			return none
		}
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
		'_options' { return this._options }
		'_show_screen_options' { return this._show_screen_options }
		'_screen_settings' { return this._screen_settings }
		'is_block_editor' { return this.is_block_editor }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Screen) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'action' {
			this.action = val
			return true
		}
		'base' {
			this.base = val
			return true
		}
		'columns' {
			this.columns = val
			return true
		}
		'id' {
			this.id = val
			return true
		}
		'in_admin' {
			this.in_admin = val
			return true
		}
		'is_network' {
			this.is_network = val
			return true
		}
		'is_user' {
			this.is_user = val
			return true
		}
		'parent_base' {
			this.parent_base = val
			return true
		}
		'parent_file' {
			this.parent_file = val
			return true
		}
		'post_type' {
			this.post_type = val
			return true
		}
		'taxonomy' {
			this.taxonomy = val
			return true
		}
		'_help_tabs' {
			this._help_tabs = val
			return true
		}
		'_help_sidebar' {
			this._help_sidebar = val
			return true
		}
		'_screen_reader_content' {
			this._screen_reader_content = val
			return true
		}
		'_options' {
			this._options = val
			return true
		}
		'_show_screen_options' {
			this._show_screen_options = val
			return true
		}
		'_screen_settings' {
			this._screen_settings = val
			return true
		}
		'is_block_editor' {
			this.is_block_editor = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
