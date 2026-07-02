import rt

fn _add_themes_utility_last() {
	rt.call_function('add_submenu_page', [
		rt.new_string((if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
			'tools.php'
		} else {
			'themes.php'
		}).str()),
		rt.call_function('__', [rt.new_string('Theme File Editor')]),
		rt.call_function('__', [rt.new_string('Theme File Editor')]),
		rt.new_string('edit_themes'),
		rt.new_string('theme-editor.php'),
	])
}

fn _add_plugin_file_editor_to_tools() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		return
	}
	rt.call_function('add_submenu_page', [rt.new_string('tools.php'),
		rt.call_function('__', [rt.new_string('Plugin File Editor')]),
		rt.call_function('__', [rt.new_string('Plugin File Editor')]),
		rt.new_string('edit_plugins'), rt.new_string('plugin-editor.php')])
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_menu := rt.new_null()
	mut var_submenu := map[string]rt.PhpVal{}
	mut var__wp_real_parent_file := map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	var_menu.array_set(2, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Dashboard')]) },
		rt.ArrayItem{ key: none, val: 'read' },
		rt.ArrayItem{ key: none, val: 'index.php' },
		rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'menu-top menu-top-first menu-icon-dashboard' },
		rt.ArrayItem{ key: none, val: 'menu-dashboard' },
		rt.ArrayItem{ key: none, val: 'dashicons-dashboard' },
	]))
	var_submenu.array_get_mut('index.php').array_set(0, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Home')]) },
		rt.ArrayItem{ key: none, val: 'read' },
		rt.ArrayItem{ key: none, val: 'index.php' },
	]))
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_submenu.array_get_mut('index.php').array_set(5, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('My Sites'),
			]) },
			rt.ArrayItem{ key: none, val: 'read' },
			rt.ArrayItem{ key: none, val: 'my-sites.php' },
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
		mut var_update_data := rt.call_function('wp_get_update_data', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
			mut var_capability := 'update_core'
		} else if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_plugins'),
		]))
		{
			var_capability = 'update_plugins'
		} else if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_themes'),
		]))
		{
			var_capability = 'update_themes'
		} else {
			var_capability = 'update_languages'
		}
		var_submenu.array_get_mut('index.php').array_set(10, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Updates %s'),
				]),
				rt.call_function('sprintf', [
					rt.new_string('<span class="update-plugins count-%s"><span class="update-count">%s</span></span>'),
					var_update_data.array_get(rt.new_string('counts')).array_get(rt.new_string('total')),
					rt.call_function('number_format_i18n', [
						var_update_data.array_get(rt.new_string('counts')).array_get(rt.new_string('total')),
					]),
				]),
			]) },
			rt.ArrayItem{ key: none, val: var_capability },
			rt.ArrayItem{ key: none, val: 'update-core.php' },
		]))
		var_capability = ''
	}
	var_menu.array_set(4, rt.create_array([rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'read' }, rt.ArrayItem{ key: none, val: 'separator1' },
		rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: 'wp-menu-separator' }]))
	var_menu.array_set(10, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Media')]) },
		rt.ArrayItem{ key: none, val: 'upload_files' },
		rt.ArrayItem{ key: none, val: 'upload.php' },
		rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'menu-top menu-icon-media' },
		rt.ArrayItem{ key: none, val: 'menu-media' },
		rt.ArrayItem{ key: none, val: 'dashicons-admin-media' },
	]))
	var_submenu.array_get_mut('upload.php').array_set(5, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('_x', [
			rt.new_string('Library'), rt.new_string('media library menu item')]) },
		rt.ArrayItem{ key: none, val: 'upload_files' },
		rt.ArrayItem{ key: none, val: 'upload.php' },
	]))
	var_submenu.array_get_mut('upload.php').array_set(10, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Add Media File'),
		]) },
		rt.ArrayItem{ key: none, val: 'upload_files' },
		rt.ArrayItem{ key: none, val: 'media-new.php' },
	]))
	mut var_submenu_index := 15
	mut iter_1 := rt.call_function('get_taxonomies_for_attachments', [
		rt.new_string('objects'),
	]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_taxonomy := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_taxonomy, 'show_ui')))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_taxonomy, 'show_in_menu'))))) {
			continue
		}
		var_submenu.array_get_mut('upload.php').array_set(rt.post_inc(rt.new_int(var_submenu_index)), rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [
				rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'menu_name'),
			]) },
			rt.ArrayItem{ key: none, val: rt.get_property(rt.get_property(var_taxonomy, 'cap'),
				'manage_terms') },
			rt.ArrayItem{ key: none, val: 'edit-tags.php?taxonomy=' +
				(rt.get_property(var_taxonomy, 'name')).str() + '&amp;post_type=attachment' },
		]))
	}
	var_taxonomy = rt.new_null()
	var_submenu_index = 0
	var_menu.array_set(15, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Links')]) },
		rt.ArrayItem{ key: none, val: 'manage_links' },
		rt.ArrayItem{ key: none, val: 'link-manager.php' },
		rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'menu-top menu-icon-links' },
		rt.ArrayItem{ key: none, val: 'menu-links' },
		rt.ArrayItem{ key: none, val: 'dashicons-admin-links' },
	]))
	var_submenu.array_get_mut('link-manager.php').array_set(5, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('_x', [
			rt.new_string('All Links'), rt.new_string('admin menu')]) },
		rt.ArrayItem{ key: none, val: 'manage_links' },
		rt.ArrayItem{ key: none, val: 'link-manager.php' },
	]))
	var_submenu.array_get_mut('link-manager.php').array_set(10, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Add Link')]) },
		rt.ArrayItem{ key: none, val: 'manage_links' },
		rt.ArrayItem{ key: none, val: 'link-add.php' },
	]))
	var_submenu.array_get_mut('link-manager.php').array_set(15, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Link Categories'),
		]) },
		rt.ArrayItem{ key: none, val: 'manage_categories' },
		rt.ArrayItem{ key: none, val: 'edit-tags.php?taxonomy=link_category' },
	]))
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		mut var_awaiting_moderation := rt.call_function('wp_count_comments', []rt.PhpVal{})
		var_awaiting_moderation = rt.get_property(var_awaiting_moderation, 'moderated')
		mut var_awaiting_moderation_i18n := rt.call_function('number_format_i18n', [
			var_awaiting_moderation.clone(),
		])
		mut var_awaiting_moderation_text := rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s Comment in moderation'),
				rt.new_string('%s Comments in moderation'), var_awaiting_moderation.clone()]),
			var_awaiting_moderation_i18n.clone(),
		])
		var_menu.array_set(25, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Comments %s')]),
				rt.new_string('<span class="awaiting-mod count-' +
					(rt.call_function('absint', [var_awaiting_moderation.clone()])).str() +
					'"><span class="pending-count" aria-hidden="true">' +
					var_awaiting_moderation_i18n.str() +
					'</span><span class="comments-in-moderation-text screen-reader-text">' +
					var_awaiting_moderation_text.str() + '</span></span>'),
			]) },
			rt.ArrayItem{ key: none, val: 'edit_posts' },
			rt.ArrayItem{ key: none, val: 'edit-comments.php' },
			rt.ArrayItem{ key: none, val: '' },
			rt.ArrayItem{ key: none, val: 'menu-top menu-icon-comments' },
			rt.ArrayItem{ key: none, val: 'menu-comments' },
			rt.ArrayItem{ key: none, val: 'dashicons-admin-comments' },
		]))
		var_awaiting_moderation = rt.new_null()
	}
	var_submenu.array_get_mut('edit-comments.php').array_set(0, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('All Comments'),
		]) },
		rt.ArrayItem{ key: none, val: 'edit_posts' },
		rt.ArrayItem{ key: none, val: 'edit-comments.php' },
	]))
	mut var__wp_last_object_menu := 25
	mut var_post_types := rt.cast_array(rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'show_ui', val: true },
			rt.ArrayItem{ key: '_builtin', val: false }, rt.ArrayItem{
				key: 'show_in_menu'
				val: true
			}]),
	]))
	mut var_builtin := ['post', 'page']
	mut iter_2 := rt.call_function('array_merge', [
		rt.create_array_from_list(var_builtin),
		var_post_types.clone(),
	]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_post_type := item_2.val
		mut var_post_type_obj := rt.call_function('get_post_type_object', [
			var_post_type.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_post_type_obj,
			'show_in_menu')))))
		{
			continue
		}
		mut var_post_type_menu_position := if rt.get_property(var_post_type_obj, 'menu_position').is_long() {
			rt.get_property(var_post_type_obj, 'menu_position')
		} else {
			rt.pre_inc(rt.new_int(var__wp_last_object_menu))
		}
		mut var_post_type_for_id := rt.call_function('sanitize_html_class', [
			var_post_type.clone()])
		mut var_menu_icon := rt.new_string('dashicons-admin-post')
		if rt.is_true(rt.new_bool(rt.get_property(var_post_type_obj, 'menu_icon').is_string())) {
			if rt.is_true(rt.identical(rt.new_string('none'), rt.get_property(var_post_type_obj, 'menu_icon')))
				|| rt.is_true(rt.identical(rt.new_string('div'), rt.get_property(var_post_type_obj, 'menu_icon')))
				|| rt.is_true(rt.call_function('str_starts_with', [rt.get_property(var_post_type_obj, 'menu_icon'), rt.new_string('data:image/svg+xml;base64,')]))
				|| rt.is_true(rt.call_function('str_starts_with', [rt.get_property(var_post_type_obj, 'menu_icon'), rt.new_string('dashicons-')])) {
				var_menu_icon = rt.get_property(var_post_type_obj, 'menu_icon')
			} else {
				var_menu_icon = rt.call_function('esc_url', [
					rt.get_property(var_post_type_obj, 'menu_icon'),
				])
			}
		} else if rt.is_true(rt.call_function('in_array', [var_post_type.clone(),
			rt.create_array_from_list(var_builtin), rt.new_bool(true)]))
		{
			var_menu_icon = rt.new_string('dashicons-admin-' + var_post_type.str())
		}
		mut var_menu_class := rt.new_string('menu-top menu-icon-' + var_post_type_for_id.str())
		if rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) {
			var_menu_class = rt.concat(var_menu_class, rt.new_string(' open-if-no-js'))
			mut var_post_type_file := 'edit.php'
			mut var_post_new_file := 'post-new.php'
			mut var_edit_tags_file := 'edit-tags.php?taxonomy=%s'
		} else {
			var_post_type_file = 'edit.php?post_type=${var_post_type.to_string()}'
			var_post_new_file = 'post-new.php?post_type=${var_post_type.to_string()}'
			var_edit_tags_file = 'edit-tags.php?taxonomy=%s&amp;post_type=${var_post_type.to_string()}'
		}
		if rt.is_true(rt.call_function('in_array', [var_post_type.clone(),
			rt.create_array_from_list(var_builtin), rt.new_bool(true)]))
		{
			mut var_post_type_menu_id := rt.new_string('menu-' + var_post_type_for_id.str() + 's')
		} else {
			var_post_type_menu_id = rt.new_string('menu-posts-' + var_post_type_for_id.str())
		}
		mut var_core_menu_positions := [59, 60, 65, 70, 75, 80, 85, 99]
		for var_menu.array_isset(var_post_type_menu_position)
			|| rt.is_true(rt.call_function('in_array', [var_post_type_menu_position.clone(), rt.create_array_from_list(var_core_menu_positions), rt.new_bool(true)])) {
			rt.pre_inc(var_post_type_menu_position)
		}
		var_menu.array_set(var_post_type_menu_position, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [
				rt.get_property(rt.get_property(var_post_type_obj, 'labels'), 'menu_name'),
			]) },
			rt.ArrayItem{ key: none, val: rt.get_property(rt.get_property(var_post_type_obj, 'cap'),
				'edit_posts') },
			rt.ArrayItem{ key: none, val: var_post_type_file },
			rt.ArrayItem{ key: none, val: '' },
			rt.ArrayItem{ key: none, val: var_menu_class },
			rt.ArrayItem{ key: none, val: var_post_type_menu_id },
			rt.ArrayItem{ key: none, val: var_menu_icon },
		]))
		var_submenu.array_get_mut(var_post_type_file).array_set(5, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.get_property(var_post_type_obj,
				'labels'), 'all_items') },
			rt.ArrayItem{ key: none, val: rt.get_property(rt.get_property(var_post_type_obj, 'cap'),
				'edit_posts') },
			rt.ArrayItem{ key: none, val: var_post_type_file },
		]))
		var_submenu.array_get_mut(var_post_type_file).array_set(10, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.get_property(var_post_type_obj,
				'labels'), 'add_new_item') },
			rt.ArrayItem{ key: none, val: rt.get_property(rt.get_property(var_post_type_obj, 'cap'),
				'create_posts') },
			rt.ArrayItem{ key: none, val: var_post_new_file },
		]))
		var_submenu_index = 15
		mut iter_3 := rt.call_function('get_taxonomies', [rt.new_array(),
			rt.new_string('objects')]).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_taxonomy := item_3.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_taxonomy, 'show_ui')))))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_taxonomy, 'show_in_menu')))))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post_type.clone(), rt.cast_array(rt.get_property(var_taxonomy, 'object_type')), rt.new_bool(true)]))))) {
				continue
			}
			var_submenu.array_get_mut(var_post_type_file).array_set(rt.post_inc(rt.new_int(var_submenu_index)), rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [
					rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'menu_name'),
				]) },
				rt.ArrayItem{ key: none, val: rt.get_property(rt.get_property(var_taxonomy, 'cap'),
					'manage_terms') },
				rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [
					rt.new_string(var_edit_tags_file.str()).clone(),
					rt.get_property(var_taxonomy, 'name'),
				]) },
			]))
		}
	}
	var_post_type = rt.new_null()
	var_post_type_obj = rt.new_null()
	var_post_type_for_id = rt.new_null()
	var_post_type_menu_position = rt.new_null()
	var_menu_icon = rt.new_null()
	var_submenu_index = 0
	var_taxonomy = rt.new_null()
	var_post_new_file = ''
	var_menu.array_set(59, rt.create_array([rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'read' }, rt.ArrayItem{ key: none, val: 'separator2' },
		rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: 'wp-menu-separator' }]))
	mut var_appearance_capability := if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('switch_themes'),
	]))
	{ 'switch_themes' } else { 'edit_theme_options' }
	var_menu.array_set(60, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Appearance'),
		]) },
		rt.ArrayItem{ key: none, val: var_appearance_capability },
		rt.ArrayItem{ key: none, val: 'themes.php' },
		rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'menu-top menu-icon-appearance' },
		rt.ArrayItem{ key: none, val: 'menu-appearance' },
		rt.ArrayItem{ key: none, val: 'dashicons-admin-appearance' },
	]))
	mut var_count := rt.new_string('')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')])) {
		if !(!var_update_data.is_null()) {
			var_update_data = rt.call_function('wp_get_update_data', []rt.PhpVal{})
		}
		var_count = rt.call_function('sprintf', [
			rt.new_string('<span class="update-plugins count-%s"><span class="theme-count">%s</span></span>'),
			var_update_data.array_get(rt.new_string('counts')).array_get(rt.new_string('themes')),
			rt.call_function('number_format_i18n', [
				var_update_data.array_get(rt.new_string('counts')).array_get(rt.new_string('themes')),
			]),
		])
	}
	var_submenu.array_get_mut('themes.php').array_set(5, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Themes %s')]),
			var_count.clone(),
		]) },
		rt.ArrayItem{ key: none, val: var_appearance_capability },
		rt.ArrayItem{ key: none, val: 'themes.php' },
	]))
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		var_submenu.array_get_mut('themes.php').array_set(6, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Editor'),
				rt.new_string('site editor menu item'),
			]) },
			rt.ArrayItem{ key: none, val: 'edit_theme_options' },
			rt.ArrayItem{ key: none, val: 'site-editor.php' },
		]))
	} else {
		mut var_supports_stylebook :=
			rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('editor-styles')]))
			|| rt.is_true(rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{}))
		if var_supports_stylebook {
			var_submenu.array_get_mut('themes.php').array_set(6, rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('_x', [
					rt.new_string('Design'),
					rt.new_string('design menu item'),
				]) },
				rt.ArrayItem{ key: none, val: 'edit_theme_options' },
				rt.ArrayItem{ key: none, val: 'site-editor.php' },
			]))
		} else {
			var_submenu.array_get_mut('themes.php').array_set(6, rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('_x', [
					rt.new_string('Patterns'),
					rt.new_string('patterns menu item'),
				]) },
				rt.ArrayItem{ key: none, val: 'edit_theme_options' },
				rt.ArrayItem{ key: none, val: 'site-editor.php?p=/pattern' },
			]))
		}
	}
	var_submenu.array_get_mut('themes.php').array_set(9, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Fonts')]) },
		rt.ArrayItem{ key: none, val: 'edit_theme_options' },
		rt.ArrayItem{ key: none, val: 'font-library.php' },
	]))
	mut var_customize_url := rt.call_function('add_query_arg', [
		rt.new_string('return'),
		rt.call_function('urlencode', [
			rt.call_function('remove_query_arg', [
				rt.call_function('wp_removable_query_args', []rt.PhpVal{}),
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
				]),
			]),
		]),
		rt.new_string('customize.php')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})))))
		|| rt.is_true(rt.call_function('has_action', [rt.new_string('customize_register')])) {
		var_submenu.array_get_mut('themes.php').array_set(7, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Customize'),
			]) },
			rt.ArrayItem{ key: none, val: 'customize' },
			rt.ArrayItem{ key: none, val: rt.call_function('esc_url', [
				var_customize_url.clone(),
			]) },
			rt.ArrayItem{ key: none, val: '' },
			rt.ArrayItem{ key: none, val: 'hide-if-no-customize' },
		]))
	}
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('menus')]))
		|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('widgets')])) {
		var_submenu.array_get_mut('themes.php').array_set(10, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Menus')]) },
			rt.ArrayItem{ key: none, val: 'edit_theme_options' },
			rt.ArrayItem{ key: none, val: 'nav-menus.php' },
		]))
	}
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
		mut var_customize_header_url := rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'autofocus', val: rt.create_array([
					rt.ArrayItem{ key: 'control', val: 'header_image' },
				]) },
			]),
			var_customize_url.clone(),
		])
		var_submenu.array_get_mut('themes.php').array_set(15, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Header'),
				rt.new_string('custom image header'),
			]) },
			rt.ArrayItem{ key: none, val: var_appearance_capability },
			rt.ArrayItem{ key: none, val: rt.call_function('esc_url', [
				var_customize_header_url.clone(),
			]) },
			rt.ArrayItem{ key: none, val: '' },
			rt.ArrayItem{ key: none, val: 'hide-if-no-customize' },
		]))
	}
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-background')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
		mut var_customize_background_url := rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'autofocus', val: rt.create_array([
					rt.ArrayItem{ key: 'control', val: 'background_image' },
				]) },
			]),
			var_customize_url.clone(),
		])
		var_submenu.array_get_mut('themes.php').array_set(20, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Background'),
				rt.new_string('custom background'),
			]) },
			rt.ArrayItem{ key: none, val: var_appearance_capability },
			rt.ArrayItem{ key: none, val: rt.call_function('esc_url', [
				var_customize_background_url.clone(),
			]) },
			rt.ArrayItem{ key: none, val: '' },
			rt.ArrayItem{ key: none, val: 'hide-if-no-customize' },
		]))
	}
	var_customize_url = rt.new_null()
	var_appearance_capability = ''
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		rt.call_function('add_action', [rt.new_string('admin_menu'),
			rt.new_string('_add_themes_utility_last'), rt.new_int(101)])
	}
	var_count = rt.new_string('')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')])) {
		if !(!var_update_data.is_null()) {
			var_update_data = rt.call_function('wp_get_update_data', []rt.PhpVal{})
		}
		var_count = rt.call_function('sprintf', [
			rt.new_string('<span class="update-plugins count-%s"><span class="plugin-count">%s</span></span>'),
			var_update_data.array_get(rt.new_string('counts')).array_get(rt.new_string('plugins')),
			rt.call_function('number_format_i18n', [
				var_update_data.array_get(rt.new_string('counts')).array_get(rt.new_string('plugins')),
			]),
		])
	}
	var_menu.array_set(65, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Plugins %s')]),
			var_count.clone(),
		]) },
		rt.ArrayItem{ key: none, val: 'activate_plugins' },
		rt.ArrayItem{ key: none, val: 'plugins.php' },
		rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'menu-top menu-icon-plugins' },
		rt.ArrayItem{ key: none, val: 'menu-plugins' },
		rt.ArrayItem{ key: none, val: 'dashicons-admin-plugins' },
	]))
	var_submenu.array_get_mut('plugins.php').array_set(5, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Installed Plugins'),
		]) },
		rt.ArrayItem{ key: none, val: 'activate_plugins' },
		rt.ArrayItem{ key: none, val: 'plugins.php' },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_submenu.array_get_mut('plugins.php').array_set(10, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Add Plugin'),
			]) },
			rt.ArrayItem{ key: none, val: 'install_plugins' },
			rt.ArrayItem{ key: none, val: 'plugin-install.php' },
		]))
		if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
			rt.call_function('add_action', [rt.new_string('admin_menu'),
				rt.new_string('_add_plugin_file_editor_to_tools'),
				rt.new_int(101)])
		} else {
			var_submenu.array_get_mut('plugins.php').array_set(15, rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Plugin File Editor'),
				]) },
				rt.ArrayItem{ key: none, val: 'edit_plugins' },
				rt.ArrayItem{ key: none, val: 'plugin-editor.php' },
			]))
		}
	}
	var_update_data = rt.new_null()
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')])) {
		var_menu.array_set(70, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Users')]) },
			rt.ArrayItem{ key: none, val: 'list_users' },
			rt.ArrayItem{ key: none, val: 'users.php' },
			rt.ArrayItem{ key: none, val: '' },
			rt.ArrayItem{ key: none, val: 'menu-top menu-icon-users' },
			rt.ArrayItem{ key: none, val: 'menu-users' },
			rt.ArrayItem{ key: none, val: 'dashicons-admin-users' },
		]))
	} else {
		var_menu.array_set(70, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Profile'),
			]) },
			rt.ArrayItem{ key: none, val: 'read' },
			rt.ArrayItem{ key: none, val: 'profile.php' },
			rt.ArrayItem{ key: none, val: '' },
			rt.ArrayItem{ key: none, val: 'menu-top menu-icon-users' },
			rt.ArrayItem{ key: none, val: 'menu-users' },
			rt.ArrayItem{ key: none, val: 'dashicons-admin-users' },
		]))
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')])) {
		var__wp_real_parent_file['profile.php'] = 'users.php'
		var_submenu.array_get_mut('users.php').array_set(5, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('All Users'),
			]) },
			rt.ArrayItem{ key: none, val: 'list_users' },
			rt.ArrayItem{ key: none, val: 'users.php' },
		]))
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('create_users'),
		]))
		{
			var_submenu.array_get_mut('users.php').array_set(10, rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Add User'),
				]) },
				rt.ArrayItem{ key: none, val: 'create_users' },
				rt.ArrayItem{ key: none, val: 'user-new.php' },
			]))
		} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_submenu.array_get_mut('users.php').array_set(10, rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Add User'),
				]) },
				rt.ArrayItem{ key: none, val: 'promote_users' },
				rt.ArrayItem{ key: none, val: 'user-new.php' },
			]))
		}
		var_submenu.array_get_mut('users.php').array_set(15, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Profile'),
			]) },
			rt.ArrayItem{ key: none, val: 'read' },
			rt.ArrayItem{ key: none, val: 'profile.php' },
		]))
	} else {
		var__wp_real_parent_file['users.php'] = 'profile.php'
		var_submenu.array_get_mut('profile.php').array_set(5, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Profile'),
			]) },
			rt.ArrayItem{ key: none, val: 'read' },
			rt.ArrayItem{ key: none, val: 'profile.php' },
		]))
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('create_users'),
		]))
		{
			var_submenu.array_get_mut('profile.php').array_set(10, rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Add User'),
				]) },
				rt.ArrayItem{ key: none, val: 'create_users' },
				rt.ArrayItem{ key: none, val: 'user-new.php' },
			]))
		} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_submenu.array_get_mut('profile.php').array_set(10, rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Add User'),
				]) },
				rt.ArrayItem{ key: none, val: 'promote_users' },
				rt.ArrayItem{ key: none, val: 'user-new.php' },
			]))
		}
	}
	mut var_site_health_count := rt.new_string('')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('view_site_health_checks')])) {
		mut var_get_issues := rt.call_function('get_transient', [
			rt.new_string('health-check-site-status-result'),
		])
		mut var_issue_counts := rt.new_array()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_get_issues)))) {
			var_issue_counts = rt.call_function('json_decode', [
				var_get_issues.clone(), rt.new_bool(true)])
		}
		if !(var_issue_counts.clone().is_array())
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_issue_counts)))) {
			var_issue_counts = rt.create_array([rt.ArrayItem{ key: 'good', val: 0 },
				rt.ArrayItem{ key: 'recommended', val: 0 }, rt.ArrayItem{ key: 'critical', val: 0 }])
		}
		var_site_health_count = rt.call_function('sprintf', [
			rt.new_string('<span class="menu-counter site-health-counter count-%s"><span class="count">%s</span></span>'),
			var_issue_counts.array_get(rt.new_string('critical')),
			rt.call_function('number_format_i18n', [
				var_issue_counts.array_get(rt.new_string('critical')),
			]),
		])
	}
	var_menu.array_set(75, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Tools')]) },
		rt.ArrayItem{ key: none, val: 'edit_posts' },
		rt.ArrayItem{ key: none, val: 'tools.php' },
		rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'menu-top menu-icon-tools' },
		rt.ArrayItem{ key: none, val: 'menu-tools' },
		rt.ArrayItem{ key: none, val: 'dashicons-admin-tools' },
	]))
	var_submenu.array_get_mut('tools.php').array_set(5, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Available Tools'),
		]) },
		rt.ArrayItem{ key: none, val: 'edit_posts' },
		rt.ArrayItem{ key: none, val: 'tools.php' },
	]))
	var_submenu.array_get_mut('tools.php').array_set(10, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Import')]) },
		rt.ArrayItem{ key: none, val: 'import' },
		rt.ArrayItem{ key: none, val: 'import.php' },
	]))
	var_submenu.array_get_mut('tools.php').array_set(15, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Export')]) },
		rt.ArrayItem{ key: none, val: 'export' },
		rt.ArrayItem{ key: none, val: 'export.php' },
	]))
	var_submenu.array_get_mut('tools.php').array_set(20, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Site Health %s')]),
			var_site_health_count.clone(),
		]) },
		rt.ArrayItem{ key: none, val: 'view_site_health_checks' },
		rt.ArrayItem{ key: none, val: 'site-health.php' },
	]))
	var_submenu.array_get_mut('tools.php').array_set(25, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Export Personal Data'),
		]) },
		rt.ArrayItem{ key: none, val: 'export_others_personal_data' },
		rt.ArrayItem{ key: none, val: 'export-personal-data.php' },
	]))
	var_submenu.array_get_mut('tools.php').array_set(30, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Erase Personal Data'),
		]) },
		rt.ArrayItem{ key: none, val: 'erase_others_personal_data' },
		rt.ArrayItem{ key: none, val: 'erase-personal-data.php' },
	]))
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(rt.call_function('get_site', []rt.PhpVal{}), 'deleted'))))) {
		var_submenu.array_get_mut('tools.php').array_set(35, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Delete Site'),
			]) },
			rt.ArrayItem{ key: none, val: 'delete_site' },
			rt.ArrayItem{ key: none, val: 'ms-delete-site.php' },
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('WP_ALLOW_MULTISITE')]))
		&& rt.is_true(rt.get_constant('WP_ALLOW_MULTISITE')) {
		var_submenu.array_get_mut('tools.php').array_set(50, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Network Setup'),
			]) },
			rt.ArrayItem{ key: none, val: 'setup_network' },
			rt.ArrayItem{ key: none, val: 'network.php' },
		]))
	}
	var_menu.array_set(80, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Settings')]) },
		rt.ArrayItem{ key: none, val: 'manage_options' },
		rt.ArrayItem{ key: none, val: 'options-general.php' },
		rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'menu-top menu-icon-settings' },
		rt.ArrayItem{ key: none, val: 'menu-settings' },
		rt.ArrayItem{ key: none, val: 'dashicons-admin-settings' },
	]))
	var_submenu.array_get_mut('options-general.php').array_set(10, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('_x', [
			rt.new_string('General'), rt.new_string('settings screen')]) },
		rt.ArrayItem{ key: none, val: 'manage_options' },
		rt.ArrayItem{ key: none, val: 'options-general.php' },
	]))
	var_submenu.array_get_mut('options-general.php').array_set(12, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Connectors'),
		]) },
		rt.ArrayItem{ key: none, val: 'manage_options' },
		rt.ArrayItem{ key: none, val: 'options-connectors.php' },
	]))
	var_submenu.array_get_mut('options-general.php').array_set(15, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Writing')]) },
		rt.ArrayItem{ key: none, val: 'manage_options' },
		rt.ArrayItem{ key: none, val: 'options-writing.php' },
	]))
	var_submenu.array_get_mut('options-general.php').array_set(20, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Reading')]) },
		rt.ArrayItem{ key: none, val: 'manage_options' },
		rt.ArrayItem{ key: none, val: 'options-reading.php' },
	]))
	var_submenu.array_get_mut('options-general.php').array_set(25, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Discussion'),
		]) },
		rt.ArrayItem{ key: none, val: 'manage_options' },
		rt.ArrayItem{ key: none, val: 'options-discussion.php' },
	]))
	var_submenu.array_get_mut('options-general.php').array_set(30, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Media')]) },
		rt.ArrayItem{ key: none, val: 'manage_options' },
		rt.ArrayItem{ key: none, val: 'options-media.php' },
	]))
	var_submenu.array_get_mut('options-general.php').array_set(40, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Permalinks'),
		]) },
		rt.ArrayItem{ key: none, val: 'manage_options' },
		rt.ArrayItem{ key: none, val: 'options-permalink.php' },
	]))
	var_submenu.array_get_mut('options-general.php').array_set(45, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Privacy')]) },
		rt.ArrayItem{ key: none, val: 'manage_privacy_options' },
		rt.ArrayItem{ key: none, val: 'options-privacy.php' },
	]))
	mut var__wp_last_utility_menu := 80
	var_menu.array_set(99, rt.create_array([rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'read' }, rt.ArrayItem{ key: none, val: 'separator-last' },
		rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: 'wp-menu-separator' }]))
	var__wp_real_parent_file['post.php'] = 'edit.php'
	var__wp_real_parent_file['post-new.php'] = 'edit.php'
	var__wp_real_parent_file['edit-pages.php'] = 'edit.php?post_type=page'
	var__wp_real_parent_file['page-new.php'] = 'edit.php?post_type=page'
	var__wp_real_parent_file['wpmu-admin.php'] = 'tools.php'
	var__wp_real_parent_file['ms-admin.php'] = 'tools.php'
	mut var_compat := {
		'index':           'dashboard'
		'edit':            'posts'
		'post':            'posts'
		'upload':          'media'
		'link-manager':    'links'
		'edit-pages':      'pages'
		'page':            'pages'
		'edit-comments':   'comments'
		'options-general': 'settings'
		'themes':          'appearance'
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/menu.php', '4')
}
