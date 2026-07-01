import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('erase_others_personal_data')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_users')])))))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to erase personal data on this site.'),
			]),
		])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Erase Personal Data')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('This screen is where you manage requests to erase personal data.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Privacy Laws around the world require businesses and online services to delete, anonymize, or forget the data they collect about an individual. The rights those laws enshrine are sometimes called the "Right to be Forgotten".')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('The tool associates data stored in WordPress with a supplied email address, including profile data and comments.')])).str() +
				'</p>' + '<p><strong>' +
				(rt.call_function('__', [rt.new_string('Note: As this tool only gathers data from WordPress and participating plugins, you may need to do more to comply with erasure requests. For example, you are also responsible for ensuring that data collected by or stored with the 3rd party services your organization uses gets deleted.')])).str() +
				'</strong></p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'default-data' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Default Data'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('WordPress collects (but <em>never</em> publishes) a limited amount of data from logged-in users but then deletes it or anonymizes it. That data can include:')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('<strong>Profile Information</strong> &mdash; user email address, username, display name, nickname, first name, last name, description/bio, and registration date.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('<strong>Community Events Location</strong> &mdash; The IP Address of the user which is used for the Upcoming Community Events shown in the dashboard widget.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('<strong>Session Tokens</strong> &mdash; User login information, IP Addresses, Expiration Date, User Agent (Browser/OS), and Last Login.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('<strong>Comments</strong> &mdash; WordPress does not delete comments. The software does anonymize (but, again, <em>never</em> publishes) the associated Email Address, IP Address, and User Agent (Browser/OS).')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<strong>Media</strong> &mdash; A list of URLs for all media file uploads made by the user.')])).str() +
				'</p>' }]),
	])
	mut var_privacy_policy_guide := rt.new_string('<p>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you are not sure, check the plugin documentation or contact the plugin author to see if the plugin collects data and if it supports the Data Eraser tool. This information may be available in the <a href="%s">Privacy Policy Guide</a>.')]), rt.call_function('admin_url', [rt.new_string('options-privacy.php?tab=policyguide')])])).str() +
		'</p>')
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'plugin-data' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Plugin Data'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('Many plugins may collect or store personal data either in the WordPress database or remotely. Any Erase Personal Data request should delete data from plugins as well.')])).str() +
				'</p>' + var_privacy_policy_guide.str() + '<p>' +
				(rt.call_function('__', [rt.new_string('If you are a plugin author, you can learn more about <a href="https://developer.wordpress.org/plugins/privacy/adding-the-personal-data-eraser-to-your-plugin/">how to add the Personal Data Eraser to a plugin</a>.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		'<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/tools-erase-personal-data-screen/">Documentation on Erase Personal Data</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>',
	])
	rt.call_function('_wp_personal_data_handle_actions', []rt.PhpVal{})
	rt.call_function('_wp_personal_data_cleanup_requests', []rt.PhpVal{})
	rt.call_function('wp_enqueue_script', [rt.new_string('privacy-tools')])
	rt.call_function('add_screen_option', [rt.new_string('per_page'),
		rt.create_array([rt.ArrayItem{ key: 'default', val: 20 },
			rt.ArrayItem{ key: 'option', val: 'remove_personal_data_requests_per_page' }])])
	mut var__list_table_args := {
		'plural':   'privacy_requests'
		'singular': 'privacy_request'
	}
	mut var_requests_table := rt.call_function('_get_list_table', [
		rt.new_string('WP_Privacy_Data_Removal_Requests_List_Table'),
		var__list_table_args.dup(),
	])
	rt.call_method(rt.get_property(var_requests_table, 'screen'), 'set_screen_reader_content', [
		rt.create_array([
			rt.ArrayItem{ key: 'heading_views', val: rt.call_function('__', [
				rt.new_string('Filter erase personal data list'),
			]) },
			rt.ArrayItem{ key: 'heading_pagination', val: rt.call_function('__', [
				rt.new_string('Erase personal data list navigation'),
			]) },
			rt.ArrayItem{ key: 'heading_list', val: rt.call_function('__', [
				rt.new_string('Erase personal data list'),
			]) },
		]),
	])
	rt.call_method(var_requests_table, 'process_bulk_action', []rt.PhpVal{})
	rt.call_method(var_requests_table, 'prepare_items', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Erase Personal Data')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('This tool helps site owners comply with local laws and regulations by deleting or anonymizing known data for a given user.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('settings_errors', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('erase-personal-data.php')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add Data Erasure Request')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Username or email address')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Confirmation email')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Send personal data erasure confirmation email.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [
		rt.call_function('__', [rt.new_string('Send Request')]),
		rt.new_string('secondary'),
		rt.new_string('submit'),
		rt.new_bool(false),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('personal-data-request')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_requests_table, 'views', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_requests_table, 'search_box', [
		rt.call_function('__', [rt.new_string('Search Requests')]),
		rt.new_string('requests'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('filter-status')) { rt.call_function('esc_attr', [
			rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('filter-status')]),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('orderby')) { rt.call_function('esc_attr', [
			rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('orderby')]),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('order')) { rt.call_function('esc_attr', [
			rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('order')]),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_requests_table, 'display', []rt.PhpVal{})
	rt.call_method(var_requests_table, 'embed_scripts', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
