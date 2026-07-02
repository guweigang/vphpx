import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_link_id := rt.new_null()
	mut var_link := rt.new_null()
	mut var_title := rt.new_null()
	mut var_link_added := rt.new_null()
	mut var_cat_id := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	if !(!rt.is_true(var_link_id)) {
		mut var_heading := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('<a href="%s">Links</a> / Edit Link')]),
			rt.new_string('link-manager.php'),
		])
		mut var_submit_text := rt.call_function('__', [rt.new_string('Update Link')])
		mut var_form_name := 'editlink'
		mut var_nonce_action := rt.new_string('update-bookmark_' + var_link_id.str())
	} else {
		var_heading = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('<a href="%s">Links</a> / Add Link')]),
			rt.new_string('link-manager.php'),
		])
		var_submit_text = rt.call_function('__', [rt.new_string('Add Link')])
		var_form_name = 'addlink'
		var_nonce_action = rt.new_string('add-bookmark')
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/meta-boxes.php', '4')
	rt.call_function('add_meta_box', [rt.new_string('linksubmitdiv'),
		rt.call_function('__', [rt.new_string('Save')]), rt.new_string('link_submit_meta_box'),
		rt.new_null(), rt.new_string('side'), rt.new_string('core')])
	rt.call_function('add_meta_box', [rt.new_string('linkcategorydiv'),
		rt.call_function('__', [rt.new_string('Categories')]),
		rt.new_string('link_categories_meta_box'), rt.new_null(),
		rt.new_string('normal'), rt.new_string('core')])
	rt.call_function('add_meta_box', [rt.new_string('linktargetdiv'),
		rt.call_function('__', [rt.new_string('Target')]), rt.new_string('link_target_meta_box'),
		rt.new_null(), rt.new_string('normal'), rt.new_string('core')])
	rt.call_function('add_meta_box', [rt.new_string('linkxfndiv'),
		rt.call_function('__', [rt.new_string('Link Relationship (XFN)')]),
		rt.new_string('link_xfn_meta_box'), rt.new_null(), rt.new_string('normal'),
		rt.new_string('core')])
	rt.call_function('add_meta_box', [rt.new_string('linkadvanceddiv'),
		rt.call_function('__', [rt.new_string('Advanced')]), rt.new_string('link_advanced_meta_box'),
		rt.new_null(), rt.new_string('normal'), rt.new_string('core')])
	rt.call_function('do_action', [rt.new_string('add_meta_boxes'),
		rt.new_string('link'), var_link.clone()])
	rt.call_function('do_action', [rt.new_string('add_meta_boxes_link'),
		var_link.clone()])
	rt.call_function('do_action', [rt.new_string('do_meta_boxes'),
		rt.new_string('link'), rt.new_string('normal'), var_link.clone()])
	rt.call_function('do_action', [rt.new_string('do_meta_boxes'),
		rt.new_string('link'), rt.new_string('advanced'), var_link.clone()])
	rt.call_function('do_action', [rt.new_string('do_meta_boxes'),
		rt.new_string('link'), rt.new_string('side'), var_link.clone()])
	rt.call_function('add_screen_option', [rt.new_string('layout_columns'),
		rt.create_array([rt.ArrayItem{ key: 'max', val: 2 }, rt.ArrayItem{ key: 'default', val: 2 }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('You can add or edit links on this screen by entering information in each of the boxes. Only the link&#8217;s web address and name (the text you want to display on your site as the link) are required fields.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('The boxes for link name, web address, and description have fixed positions, while the others may be repositioned using drag and drop. You can also hide boxes you do not use in the Screen Options tab, or minimize boxes by clicking on the title bar of the box.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('XFN stands for <a href="https://gmpg.org/xfn/">XHTML Friends Network</a>, which is optional. WordPress allows the generation of XFN attributes to show how you are related to the authors/owners of the site to which you are linking.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://codex.wordpress.org/Links_Add_New_Screen">Documentation on Creating Links</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Add Link')]))
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_GET').array_isset(rt.new_string('added')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('Link added.')]),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'updated' },
				]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_form_name.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_form_name.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_link_added)) {
		rt.echo_val(var_link_added)
	}
	rt.call_function('wp_nonce_field', [var_nonce_action.clone()])
	rt.call_function('wp_nonce_field', [rt.new_string('closedpostboxes'),
		rt.new_string('closedpostboxesnonce'), rt.new_bool(false)])
	rt.call_function('wp_nonce_field', [rt.new_string('meta-box-order'),
		rt.new_string('meta-box-order-nonce'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_int(1), rt.call_method(rt.call_function('get_current_screen',
		[]rt.PhpVal{}), 'get_columns', []rt.PhpVal{})))
	{
		'1'
	} else {
		'2'
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Name'), rt.new_string('link name')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_link, 'link_name')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Example: Nifty blogging software')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Web Address')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.get_property(var_link, 'link_url')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Example: <code>https://wordpress.org/</code> &#8212; do not forget the <code>https://</code>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Description')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(rt.get_property(var_link, 'link_description')).is_null() { rt.call_function('esc_attr', [
			rt.get_property(var_link, 'link_description'),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('This will be shown when someone hovers over the link in the blogroll, or optionally below the link.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('submitlink_box')])
	mut var_side_meta_boxes := rt.call_function('do_meta_boxes', [
		rt.new_string('link'), rt.new_string('side'), var_link.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_meta_boxes', [rt.new_null(), rt.new_string('normal'),
		var_link.clone()])
	rt.call_function('do_meta_boxes', [rt.new_null(), rt.new_string('advanced'),
		var_link.clone()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_link_id) {
		// unsupported statement: Stmt_InlineHTML
		print(rt.new_int(var_link_id.to_i64()).str())
		// unsupported statement: Stmt_InlineHTML
		print(rt.new_int(var_cat_id.to_i64()).str())
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
