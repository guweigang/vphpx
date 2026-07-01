module wp_includes

import rt

struct Class_WP_Admin_Bar {
	rt.PhpObjectBase
pub mut:
	nodes rt.PhpVal = rt.new_array()
	bound bool
	user  rt.PhpVal = rt.new_null()
	menu  rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Admin_Bar) initialize() {
	this.user = create_stdclass()
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		rt.set_property(this.user, 'blogs', rt.call_function('get_blogs_of_user', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
		]))
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			rt.set_property(this.user, 'active_blog', rt.call_function('get_active_blog_for_user', [
				rt.call_function('get_current_user_id', []rt.PhpVal{}),
			]))
			rt.set_property(this.user, 'domain', if !rt.is_true(rt.get_property(this.user, 'active_blog')) { rt.call_function('user_admin_url', []rt.PhpVal{}) } else { rt.call_function('trailingslashit', [
					rt.call_function('get_home_url', [
						rt.get_property(rt.get_property(this.user, 'active_blog'), 'blog_id'),
					]),
				]) })
			rt.set_property(this.user, 'account_domain', rt.get_property(this.user, 'domain'))
		} else {
			rt.set_property(this.user, 'active_blog', rt.get_property(this.user, 'blogs').array_get(rt.call_function('get_current_blog_id',
				[]rt.PhpVal{})))
			rt.set_property(this.user, 'domain', rt.call_function('trailingslashit', [
				rt.call_function('home_url', []rt.PhpVal{}),
			]))
			rt.set_property(this.user, 'account_domain', rt.get_property(this.user, 'domain'))
		}
	}
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_admin_bar_header')])
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.new_string('wp_admin_bar_header')])
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('admin-bar')]))
	{
		mut var_admin_bar_args := rt.call_function('get_theme_support', [
			rt.new_string('admin-bar'),
		])
		mut var_header_callback := var_admin_bar_args.array_get(0).array_get('callback')
	}
	if !rt.is_true(var_header_callback) {
		var_header_callback = rt.new_string('_admin_bar_bump_cb')
	}
	rt.call_function('add_action', [rt.new_string('wp_head'),
		var_header_callback.clone()])
	rt.call_function('wp_enqueue_script', [rt.new_string('admin-bar')])
	rt.call_function('wp_enqueue_style', [rt.new_string('admin-bar')])
	rt.call_function('do_action', [rt.new_string('admin_bar_init')])
}

fn (mut this Class_WP_Admin_Bar) add_menu(var_node rt.PhpVal) {
	mut var_node_mutated := var_node
	this.add_node(var_node_mutated.clone())
}

fn (mut this Class_WP_Admin_Bar) remove_menu(var_id rt.PhpVal) {
	mut var_id_mutated := var_id
	this.remove_node(var_id_mutated.clone())
}

fn (mut this Class_WP_Admin_Bar) add_node(var_args rt.PhpVal) {
	mut var_new_parent := rt.new_null()
	mut var_version := rt.new_null()
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.greater_equal(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(3)))
		&& rt.is_true(rt.new_bool(var_args_mutated.clone().is_string()))))
	{
		var_args_mutated = rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: var_args_mutated }]),
			rt.call_function('func_get_arg', [rt.new_int(2)]),
		])
	}
	if rt.is_true(rt.new_bool(var_args_mutated.clone().is_object())) {
		var_args_mutated = rt.call_function('get_object_vars', [
			var_args_mutated.clone()])
	}
	if !rt.is_true(var_args_mutated.array_get('id')) {
		if !rt.is_true(var_args_mutated.array_get('title')) {
			return
		}
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [rt.new_string('The menu ID should not be empty.')]),
			rt.new_string('3.3.0')])
		var_args_mutated.array_set('id', rt.call_function('esc_attr', [
			rt.call_function('sanitize_title', [
				rt.new_string(var_args_mutated.array_get('title').to_string().trim_space()),
			]),
		]))
	}
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'id', val: false },
		rt.ArrayItem{ key: 'title', val: false }, rt.ArrayItem{ key: 'parent', val: false },
		rt.ArrayItem{ key: 'href', val: false }, rt.ArrayItem{ key: 'group', val: false },
		rt.ArrayItem{ key: 'meta', val: rt.new_array() }])
	mut var_maybe_defaults := this.get_node(var_args_mutated.array_get('id'))
	if rt.is_true(var_maybe_defaults) {
		var_defaults = rt.call_function('get_object_vars', [var_maybe_defaults.clone()])
	}
	if !(!rt.is_true(var_defaults.array_get('meta')))
		&& !(!rt.is_true(var_args_mutated.array_get('meta'))) {
		var_args_mutated.array_set('meta', rt.call_function('wp_parse_args', [
			var_args_mutated.array_get('meta'),
			var_defaults.array_get('meta'),
		]))
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		var_defaults.clone()])
	mut var_back_compat_parents := rt.create_array([
		rt.ArrayItem{ key: 'my-account-with-avatar', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'my-account' },
			rt.ArrayItem{ key: none, val: '3.3' },
		]) },
		rt.ArrayItem{ key: 'my-blogs', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'my-sites' },
			rt.ArrayItem{ key: none, val: '3.3' },
		]) },
	])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(var_args_mutated.array_get('parent').is_string()))
		&& var_back_compat_parents.array_isset(var_args_mutated.array_get('parent'))))
	{
		mut _list_tmp_ - 71922 :=
			var_back_compat_parents.array_get(var_args_mutated.array_get('parent'))
		rt.call_function('_deprecated_argument', [rt.new_string(@METHOD),
			var_version.clone(),
			rt.call_function('sprintf', [
				rt.new_string('Use <code>%s</code> as the parent for the <code>%s</code> admin bar node instead of <code>%s</code>.'),
				var_new_parent.clone(),
				var_args_mutated.array_get('id'),
				var_args_mutated.array_get('parent'),
			])])
		var_args_mutated.array_set('parent', var_new_parent.clone())
	}
	this._set_node(var_args_mutated.clone())
}

fn (mut this Class_WP_Admin_Bar) _set_node(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	this.nodes.array_set(var_args_mutated.array_get('id'), rt.array_to_object(var_args_mutated))
}

fn (mut this Class_WP_Admin_Bar) get_node(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	mut var_node := this._get_node(var_id_mutated.clone())
	if rt.is_true(var_node) {
		return var_node.dup()
	}
	return rt.new_null()
}

fn (mut this Class_WP_Admin_Bar) _get_node(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	if this.bound {
		return rt.new_null()
	}
	if !rt.is_true(var_id_mutated) {
		var_id_mutated = rt.new_string('root')
	}
	if this.nodes.array_isset(var_id_mutated) {
		return this.nodes.array_get(var_id_mutated)
	}
	return rt.new_null()
}

fn (mut this Class_WP_Admin_Bar) get_nodes() rt.PhpVal {
	mut var_nodes := this._get_nodes()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_nodes)))) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_nodes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_node := item_1.val
			var_node = var_node.dup()
		}
	}
	return var_nodes.clone()
}

fn (mut this Class_WP_Admin_Bar) _get_nodes() rt.PhpVal {
	if this.bound {
		return rt.new_null()
	}
	return this.nodes
}

fn (mut this Class_WP_Admin_Bar) add_group(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('group', true)
	this.add_node(var_args_mutated.clone())
}

fn (mut this Class_WP_Admin_Bar) remove_node(var_id rt.PhpVal) {
	mut var_id_mutated := var_id
	this._unset_node(var_id_mutated.clone())
}

fn (mut this Class_WP_Admin_Bar) _unset_node(var_id rt.PhpVal) {
	mut var_id_mutated := var_id
	this.nodes.array_unset(var_id_mutated)
}

fn (mut this Class_WP_Admin_Bar) render() {
	mut var_root := this._bind()
	if rt.is_true(var_root) {
		this._render(var_root.clone())
	}
}

fn (mut this Class_WP_Admin_Bar) _bind() rt.PhpVal {
	if this.bound {
		return rt.new_null()
	}
	this.remove_node(rt.new_string('root'))
	this.add_node(rt.create_array([rt.ArrayItem{ key: 'id', val: 'root' },
		rt.ArrayItem{ key: 'group', val: false }]))
	{
		mut iter_1 := this._get_nodes().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_node := item_1.val
			rt.set_property(var_node, 'children', rt.new_array())
			rt.set_property(var_node, 'type', if rt.is_true(rt.get_property(var_node, 'group')) {
				'group'
			} else {
				'item'
			})
			rt.get_property(var_node, 'group') = rt.new_null()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_node, 'parent'))))) {
				rt.set_property(var_node, 'parent', rt.new_string('root'))
			}
		}
	}
	{
		mut iter_1 := this._get_nodes().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_node := item_1.val
			if rt.is_true(rt.identical(rt.new_string('root'), rt.get_property(var_node, 'id'))) {
				continue
			}
			mut var_parent := this._get_node(rt.get_property(var_node, 'parent'))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_parent)))) {
				continue
			}
			mut var_group_class := rt.new_string((if rt.is_true(rt.identical(rt.new_string('root'), rt.get_property(var_node,
				'parent')))
			{
				'ab-top-menu'
			} else {
				'ab-submenu'
			}).str())
			if rt.is_true(rt.identical(rt.new_string('group'), rt.get_property(var_node, 'type'))) {
				if !rt.is_true(rt.get_property(var_node, 'meta').array_get('class')) {
					rt.get_property(var_node, 'meta').array_set('class', var_group_class.clone())
				} else {
					rt.get_property(var_node, 'meta').array_get('class') = rt.concat(rt.get_property(var_node,
						'meta').array_get('class'), rt.new_string(' ' + var_group_class.str()))
				}
			}
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.identical(rt.new_string('item'), rt.get_property(var_parent, 'type')))
				&& rt.is_true(rt.identical(rt.new_string('item'), rt.get_property(var_node, 'type')))))
			{
				mut var_default_id := rt.new_string((rt.get_property(var_parent, 'id')).str() +
					'-default')
				mut var_default := this._get_node(var_default_id.clone())
				if rt.is_true(rt.new_bool(!(rt.is_true(var_default)))) {
					this._set_node(rt.create_array([
						rt.ArrayItem{ key: 'id', val: var_default_id },
						rt.ArrayItem{ key: 'parent', val: rt.get_property(var_parent, 'id') },
						rt.ArrayItem{ key: 'type', val: 'group' },
						rt.ArrayItem{ key: 'children', val: rt.new_array() },
						rt.ArrayItem{ key: 'meta', val: rt.create_array([
							rt.ArrayItem{ key: 'class', val: var_group_class },
						]) },
						rt.ArrayItem{ key: 'title', val: false },
						rt.ArrayItem{ key: 'href', val: false },
					]))
					var_default = this._get_node(var_default_id.clone())
					rt.get_property(var_parent, 'children').array_push(var_default.clone())
				}
				var_parent = var_default.clone()
			} else if rt.is_true(rt.new_bool(
				rt.is_true(rt.identical(rt.new_string('group'), rt.get_property(var_parent, 'type')))
				&& rt.is_true(rt.identical(rt.new_string('group'), rt.get_property(var_node, 'type')))))
			{
				mut var_container_id := rt.new_string((rt.get_property(var_parent, 'id')).str() +
					'-container')
				mut var_container := this._get_node(var_container_id.clone())
				if rt.is_true(rt.new_bool(!(rt.is_true(var_container)))) {
					this._set_node(rt.create_array([
						rt.ArrayItem{ key: 'id', val: var_container_id },
						rt.ArrayItem{ key: 'type', val: 'container' },
						rt.ArrayItem{ key: 'children', val: rt.create_array([
							rt.ArrayItem{ key: none, val: var_parent },
						]) },
						rt.ArrayItem{ key: 'parent', val: false },
						rt.ArrayItem{ key: 'title', val: false },
						rt.ArrayItem{ key: 'href', val: false },
						rt.ArrayItem{ key: 'meta', val: rt.new_array() },
					]))
					var_container = this._get_node(var_container_id.clone())
					mut var_grandparent := this._get_node(rt.get_property(var_parent, 'parent'))
					if rt.is_true(var_grandparent) {
						rt.set_property(var_container, 'parent', rt.get_property(var_grandparent,
							'id'))
						mut var_index := rt.call_function('array_search', [
							var_parent.clone(), rt.get_property(var_grandparent, 'children'),
							rt.new_bool(true)])
						if rt.is_true(rt.identical(rt.new_bool(false), var_index)) {
							rt.get_property(var_grandparent, 'children').array_push(var_container.clone())
						} else {
							rt.call_function('array_splice', [
								rt.get_property(var_grandparent, 'children'),
								var_index.clone(),
								rt.new_int(1),
								rt.create_array([
									rt.ArrayItem{ key: none, val: var_container },
								]),
							])
						}
					}
					rt.set_property(var_parent, 'parent', rt.get_property(var_container, 'id'))
				}
				var_parent = var_container.clone()
			}
			rt.set_property(var_node, 'parent', rt.get_property(var_parent, 'id'))
			rt.get_property(var_parent, 'children').array_push(var_node.clone())
		}
	}
	mut var_root := this._get_node(rt.new_string('root'))
	this.bound = true
	return var_root.clone()
}

fn (mut this Class_WP_Admin_Bar) _render(var_root rt.PhpVal) {
	mut var_root_mutated := var_root
	mut var_class := rt.new_string('nojq nojs')
	if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
		var_class = rt.concat(var_class, rt.new_string(' mobile'))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_class)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('wp_body_open')])))))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Skip to toolbar')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Toolbar')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := rt.get_property(var_root_mutated, 'children').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_group := item_1.val
			this._render_group(var_group.clone(), false)
		}
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Admin_Bar) _render_container(var_node rt.PhpVal) {
	mut var_node_mutated := var_node
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('container'), rt.get_property(var_node_mutated, 'type')))))
		|| !rt.is_true(rt.get_property(var_node_mutated, 'children'))))
	{
		return
	}
	print('<div id="' +
		(rt.call_function('esc_attr', [rt.new_string('wp-admin-bar-' + (rt.get_property(var_node_mutated, 'id')).str())])).str() +
		'" class="ab-group-container">')
	{
		mut iter_1 := rt.get_property(var_node_mutated, 'children').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_group := item_1.val
			this._render_group(var_group.clone(), false)
		}
	}
	print('</div>')
}

fn (mut this Class_WP_Admin_Bar) _render_group(var_node rt.PhpVal, menu_title bool) {
	mut var_node_mutated := var_node
	if rt.is_true(rt.identical(rt.new_string('container'),
		rt.get_property(var_node_mutated, 'type')))
	{
		this._render_container(var_node_mutated.clone())
		return
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('group'), rt.get_property(var_node_mutated, 'type')))))
		|| !rt.is_true(rt.get_property(var_node_mutated, 'children'))))
	{
		return
	}
	if !(!rt.is_true(rt.get_property(var_node_mutated, 'meta').array_get('class'))) {
		mut var_class := rt.new_string(' class="' +
			(rt.call_function('esc_attr', [rt.new_string(rt.get_property(var_node_mutated, 'meta').array_get('class').to_string().trim_space())])).str() +
			'"')
	} else {
		var_class = rt.new_string('')
	}
	if !menu_title {
		print("<ul role='menu' id='" +
			(rt.call_function('esc_attr', [rt.new_string('wp-admin-bar-' + (rt.get_property(var_node_mutated, 'id')).str())])).str() +
			"'${var_class.to_string()}>")
	} else {
		print("<ul role='menu' aria-label='" +
			(rt.call_function('esc_attr', [rt.new_bool(menu_title)])).str() + "' id='" +
			(rt.call_function('esc_attr', [rt.new_string('wp-admin-bar-' + (rt.get_property(var_node_mutated, 'id')).str())])).str() +
			"'${var_class.to_string()}>")
	}
	{
		mut iter_1 := rt.get_property(var_node_mutated, 'children').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			this._render_item(var_item.clone())
		}
	}
	print('</ul>')
}

fn (mut this Class_WP_Admin_Bar) _render_item(var_node rt.PhpVal) {
	mut var_node_mutated := var_node
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('item'), rt.get_property(var_node_mutated,
		'type')))))
	{
		return
	}
	mut var_is_parent := rt.new_bool(!(!rt.is_true(rt.get_property(var_node_mutated, 'children'))))
	mut var_has_link := rt.new_bool(!(!rt.is_true(rt.get_property(var_node_mutated, 'href'))))
	mut var_is_root_top_item := rt.identical(rt.new_string('root-default'), rt.get_property(var_node_mutated,
		'parent'))
	mut var_is_top_secondary_item := rt.identical(rt.new_string('top-secondary'), rt.get_property(var_node_mutated,
		'parent'))
	mut var_tabindex := if rt.is_true(rt.new_bool(
		rt.get_property(var_node_mutated, 'meta').array_isset(rt.new_string('tabindex'))
		&& rt.is_true(rt.new_bool(rt.get_property(var_node_mutated, 'meta').array_get('tabindex').is_long()
		|| rt.get_property(var_node_mutated, 'meta').array_get('tabindex').is_double()))))
	{
		rt.new_int((rt.get_property(var_node_mutated, 'meta').array_get('tabindex')).to_i64())
	} else {
		rt.new_string('')
	}
	mut var_aria_attributes := rt.new_string((if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		var_tabindex))))
	{
		' tabindex="' + var_tabindex.str() + '"'
	} else {
		''
	}).str())
	var_aria_attributes = rt.concat(var_aria_attributes, rt.new_string(' role="menuitem"'))
	mut var_menuclass := rt.new_string('')
	mut var_arrow := rt.new_string('')
	if rt.is_true(var_is_parent) {
		var_menuclass = rt.new_string('menupop ')
		var_aria_attributes = rt.concat(var_aria_attributes,
			rt.new_string(' aria-expanded="false"'))
	}
	if !(!rt.is_true(rt.get_property(var_node_mutated, 'meta').array_get('class'))) {
		var_menuclass = rt.concat(var_menuclass,
			rt.get_property(var_node_mutated, 'meta').array_get('class'))
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_root_top_item))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_top_secondary_item))))))
		&& rt.is_true(var_is_parent)))
	{
		var_arrow = rt.new_string('<span class="wp-admin-bar-arrow" aria-hidden="true"></span>')
	}
	if rt.is_true(var_menuclass) {
		var_menuclass = rt.new_string(' class="' +
			(rt.call_function('esc_attr', [rt.new_string(var_menuclass.clone().to_string().trim_space())])).str() +
			'"')
	}
	print("<li role='group' id='" +
		(rt.call_function('esc_attr', [rt.new_string('wp-admin-bar-' + (rt.get_property(var_node_mutated, 'id')).str())])).str() +
		"'${var_menuclass.to_string()}>")
	if rt.is_true(var_has_link) {
		mut var_attributes := ['onclick', 'target', 'title', 'rel', 'lang', 'dir']
		print("<a class='ab-item'${var_aria_attributes.to_string()} href='" +
			(rt.call_function('esc_url', [rt.get_property(var_node_mutated, 'href')])).str() + "'")
	} else {
		var_attributes = ['onclick', 'target', 'title', 'rel', 'lang', 'dir']
		print('<div class="ab-item ab-empty-item"' + var_aria_attributes.str())
	}
	for var_attribute in var_attributes {
		if !rt.is_true(rt.get_property(var_node_mutated, 'meta').array_get(attribute)) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('onclick'), rt.new_string(attribute))) {
			print(" ${var_attribute}='" +
				(rt.call_function('esc_js', [rt.get_property(var_node_mutated, 'meta').array_get(attribute)])).str() +
				"'")
		} else {
			print(" ${var_attribute}='" +
				(rt.call_function('esc_attr', [rt.get_property(var_node_mutated, 'meta').array_get(attribute)])).str() +
				"'")
		}
	}
	print(rt.concat(rt.concat(rt.new_string('>'), var_arrow), rt.get_property(var_node_mutated,
		'title')))
	if rt.is_true(var_has_link) {
		print('</a>')
	} else {
		print('</div>')
	}
	if rt.is_true(var_is_parent) {
		print('<div class="ab-sub-wrapper">')
		{
			mut iter_1 := rt.get_property(var_node_mutated, 'children').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_group := item_1.val
				if !rt.is_true(rt.get_property(var_node_mutated, 'meta').array_get('menu_title')) {
					this._render_group(var_group.clone(), false)
				} else {
					this._render_group(var_group.clone(),
						(rt.get_property(var_node_mutated, 'meta').array_get('menu_title')).to_bool())
				}
			}
		}
		print('</div>')
	}
	if !(!rt.is_true(rt.get_property(var_node_mutated, 'meta').array_get('html'))) {
		rt.echo_val(rt.get_property(var_node_mutated, 'meta').array_get('html'))
	}
	print('</li>')
}

fn (mut this Class_WP_Admin_Bar) recursive_render(var_id rt.PhpVal, var_node rt.PhpVal) {
	mut var_id_mutated := var_id
	mut var_node_mutated := var_node
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('3.3.0'), rt.new_string('WP_Admin_bar::render(), WP_Admin_Bar::_render_item()')])
	this._render_item(var_node_mutated.clone())
}

fn (mut this Class_WP_Admin_Bar) add_menus() {
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.new_string('wp_admin_bar_my_account_menu'), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.new_string('wp_admin_bar_my_account_item'), rt.new_int(9991)])
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.new_string('wp_admin_bar_recovery_mode_menu'), rt.new_int(9992)])
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.new_string('wp_admin_bar_search_menu'), rt.new_int(9999)])
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.new_string('wp_admin_bar_sidebar_toggle'), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.new_string('wp_admin_bar_wp_menu'), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.new_string('wp_admin_bar_my_sites_menu'), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.new_string('wp_admin_bar_site_menu'), rt.new_int(30)])
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.new_string('wp_admin_bar_edit_site_menu'), rt.new_int(40)])
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.new_string('wp_admin_bar_customize_menu'), rt.new_int(40)])
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.new_string('wp_admin_bar_updates_menu'), rt.new_int(50)])
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.new_string('wp_admin_bar_command_palette_menu'), rt.new_int(55)])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{})))))))
	{
		rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
			rt.new_string('wp_admin_bar_comments_menu'), rt.new_int(60)])
		rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
			rt.new_string('wp_admin_bar_new_content_menu'), rt.new_int(70)])
	}
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.new_string('wp_admin_bar_edit_menu'), rt.new_int(80)])
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.new_string('wp_admin_bar_add_secondary_groups'), rt.new_int(200)])
	rt.call_function('do_action', [rt.new_string('add_admin_bar_menus')])
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_admin_bar() &Class_WP_Admin_Bar {
	mut obj := &Class_WP_Admin_Bar{
		PhpObjectBase: rt.PhpObjectBase{}
		nodes:         rt.new_array()
		bound:         false
		user:          rt.new_null()
		menu:          rt.new_array()
	}
	return obj
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Admin_Bar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'add_menu' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_menu(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_menu' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_menu(dispatch_arg_0)
			return rt.new_null()
		}
		'add_node' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_node(dispatch_arg_0)
			return rt.new_null()
		}
		'_set_node' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._set_node(dispatch_arg_0)
			return rt.new_null()
		}
		'get_node' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_node(dispatch_arg_0)
		}
		'_get_node' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._get_node(dispatch_arg_0)
		}
		'get_nodes' {
			return this.get_nodes()
		}
		'_get_nodes' {
			return this._get_nodes()
		}
		'add_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_group(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_node' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_node(dispatch_arg_0)
			return rt.new_null()
		}
		'_unset_node' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._unset_node(dispatch_arg_0)
			return rt.new_null()
		}
		'render' {
			this.render()
			return rt.new_null()
		}
		'_bind' {
			return this._bind()
		}
		'_render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._render(dispatch_arg_0)
			return rt.new_null()
		}
		'_render_container' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._render_container(dispatch_arg_0)
			return rt.new_null()
		}
		'_render_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this._render_group(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'_render_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._render_item(dispatch_arg_0)
			return rt.new_null()
		}
		'recursive_render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.recursive_render(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_menus' {
			this.add_menus()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Admin_Bar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'nodes' { return this.nodes }
		'bound' { return rt.new_bool(this.bound) }
		'user' { return this.user }
		'menu' { return this.menu }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Admin_Bar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'nodes' {
			this.nodes = val
			return true
		}
		'bound' {
			this.bound = val.to_bool()
			return true
		}
		'user' {
			this.user = val
			return true
		}
		'menu' {
			this.menu = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_class_wp_admin_bar_php() {
}
