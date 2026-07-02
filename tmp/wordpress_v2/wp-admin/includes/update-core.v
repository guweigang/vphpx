import rt

var__new_bundled_files = {
	'plugins/akismet/':          '2.0'
	'themes/twentyten/':         '3.0'
	'themes/twentyeleven/':      '3.2'
	'themes/twentytwelve/':      '3.5'
	'themes/twentythirteen/':    '3.6'
	'themes/twentyfourteen/':    '3.8'
	'themes/twentyfifteen/':     '4.1'
	'themes/twentysixteen/':     '4.4'
	'themes/twentyseventeen/':   '4.7'
	'themes/twentynineteen/':    '5.0'
	'themes/twentytwenty/':      '5.3'
	'themes/twentytwentyone/':   '5.6'
	'themes/twentytwentytwo/':   '5.9'
	'themes/twentytwentythree/': '6.1'
	'themes/twentytwentyfour/':  '6.4'
	'themes/twentytwentyfive/':  '6.7'
}
fn update_core(var_from rt.PhpVal, var_to rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var__old_requests_files := rt.new_null()
	mut var__new_bundled_files := map[string]rt.PhpVal{}
	mut var_wpdb := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	mut var_wp_version := rt.new_null()
	mut var_required_php_version := rt.new_null()
	mut var_required_mysql_version := rt.new_null()
	mut var_required_php_extensions := rt.new_null()
	mut var_wp_local_package := rt.new_null()
	mut var_type := rt.new_null()
	mut var_filename := rt.new_null()
	mut var__old_files := rt.new_null()
	mut var_distro := rt.new_null()
	mut var_roots := []rt.PhpVal{}
	mut var_root := rt.new_null()
	mut var_versions_file := rt.new_null()
	mut var_php_version := rt.new_null()
	mut var_mysql_version := rt.new_null()
	mut var_old_wp_version := rt.new_null()
	mut var_development_build := rt.new_null()
	mut var_php_compat := rt.new_null()
	mut var_mysql_compat := rt.new_null()
	mut var_php_update_message := rt.new_null()
	mut var_annotation := rt.new_null()
	mut var_missing_extensions := rt.new_null()
	mut var_extension := rt.new_null()
	mut var_skip := []rt.PhpVal{}
	mut var_check_is_writable := rt.new_null()
	mut var_working_dir_local := rt.new_null()
	mut var_checksums := rt.new_null()
	mut var_checksum := rt.new_null()
	mut var_file := []rt.PhpVal{}
	mut var_files_writable := rt.new_null()
	mut var_files_not_writable := rt.new_null()
	mut var_file_not_writable := rt.new_null()
	mut var_relative_file_not_writable := rt.new_null()
	mut var_error_data := rt.new_null()
	mut var_maintenance_string := rt.new_null()
	mut var_maintenance_file := rt.new_null()
	mut var_result := rt.new_null()
	mut var_failed := []rt.PhpVal{}
	mut var_total_size := i64(0)
	mut var_available_space := rt.new_null()
	mut var_lang_dir := rt.new_null()
	mut var_wp_lang_dir := rt.new_null()
	mut var_introduced_version := rt.new_null()
	mut var_directory := false
	mut var_dest := rt.new_null()
	mut var__result := rt.new_null()
	mut var_old_file := rt.new_null()
	mut var_db_upgrade_url := rt.new_null()
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('set_time_limit')])) {
		rt.call_function('set_time_limit', [rt.new_int(300)])
	}
	var__old_files = rt.call_function('array_merge', [var__old_files.clone(),
		rt.call_function('array_values', [var__old_requests_files.clone()])])
	_preload_old_requests_classes_and_interfaces(var_to.clone())
	rt.call_function('apply_filters', [rt.new_string('update_feedback'),
		rt.call_function('__', [rt.new_string('Verifying the unpacked files&#8230;')])])
	var_distro = rt.new_string('')
	var_roots = ['/wordpress/', '/wordpress-mu/']
	for var_root_shadow in var_roots {
		if rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [rt.new_string(var_from.str() + (rt.new_string(var_root_shadow.str())).str() + 'readme.html')]))
			&& rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [rt.new_string(var_from.str() + (rt.new_string(var_root_shadow.str())).str() + 'wp-includes/version.php')])) {
			var_distro = rt.new_string(var_root_shadow.str())
			break
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_distro)))) {
		rt.call_method(var_wp_filesystem, 'delete', [var_from.clone(),
			rt.new_bool(true)])
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('insane_distro'), rt.call_function('__', [
			rt.new_string('The update could not be unpacked'),
		])))
	}
	var_versions_file = rt.new_string(
		(rt.call_function('trailingslashit', [rt.call_method(var_wp_filesystem, 'wp_content_dir', []rt.PhpVal{})])).str() +
		'upgrade/version-current.php')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'copy', [
		rt.new_string(var_from.str() + var_distro.str() + 'wp-includes/version.php'),
		var_versions_file.clone(),
	])))))
	{
		rt.call_method(var_wp_filesystem, 'delete', [var_from.clone(),
			rt.new_bool(true)])
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('copy_failed_for_version_file'), rt.call_function('__', [
			rt.new_string('The update cannot be installed because some files could not be copied. This is usually due to inconsistent file permissions.'),
		]), rt.new_string('wp-includes/version.php')))
	}
	rt.call_method(var_wp_filesystem, 'chmod', [var_versions_file.clone(),
		rt.get_constant('FS_CHMOD_FILE')])
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_opcache_invalidate'),
	]))
	{
		rt.call_function('wp_opcache_invalidate', [var_versions_file.clone()])
	}
	rt.include_file((rt.get_constant('WP_CONTENT_DIR')).str() + '/upgrade/version-current.php', '3')
	rt.call_method(var_wp_filesystem, 'delete', [var_versions_file.clone()])
	var_php_version = rt.get_constant('PHP_VERSION')
	var_mysql_version = rt.call_method(var_wpdb, 'db_version', []rt.PhpVal{})
	var_old_wp_version = var_GLOBALS.array_get(rt.new_string('wp_version'))
	var_development_build = rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		rt.new_string(var_old_wp_version.str() + var_wp_version.str()),
		rt.new_string('-'),
	]))))
	var_php_compat = rt.call_function('version_compare', [var_php_version.clone(),
		var_required_php_version.clone(), rt.new_string('>=')])
	if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/db.php')]))
		&& !rt.is_true(rt.get_property(var_wpdb, 'is_mysql')) {
		var_mysql_compat = rt.new_bool(true)
	} else {
		var_mysql_compat = rt.call_function('version_compare', [
			var_mysql_version.clone(), var_required_mysql_version.clone(),
			rt.new_string('>=')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_mysql_compat))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))) {
		rt.call_method(var_wp_filesystem, 'delete', [var_from.clone(),
			rt.new_bool(true)])
	}
	var_php_update_message = rt.new_string('')
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_get_update_php_url'),
	]))
	{
		var_php_update_message =
			rt.new_string('</p><p>' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')]), rt.call_function('esc_url', [rt.call_function('wp_get_update_php_url', []rt.PhpVal{})])])).str())
		if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wp_get_update_php_annotation'),
		]))
		{
			var_annotation = rt.call_function('wp_get_update_php_annotation', []rt.PhpVal{})
			if rt.is_true(var_annotation) {
				var_php_update_message = rt.concat(var_php_update_message, rt.new_string(
					'</p><p><em>' + var_annotation.str() + '</em>'))
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_mysql_compat))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('php_mysql_not_compatible'),
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The update cannot be installed because WordPress %1$s requires PHP version %2$s or higher and MySQL version %3$s or higher. You are running PHP version %4$s and MySQL version %5$s.')]), var_wp_version.clone(), var_required_php_version.clone(), var_required_mysql_version.clone(), var_php_version.clone(), var_mysql_version.clone()])).str() +
			var_php_update_message.str()))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_php_compat)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('php_not_compatible'),
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The update cannot be installed because WordPress %1$s requires PHP version %2$s or higher. You are running version %3$s.')]), var_wp_version.clone(), var_required_php_version.clone(), var_php_version.clone()])).str() +
			var_php_update_message.str()))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_mysql_compat)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('mysql_not_compatible'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The update cannot be installed because WordPress %1$s requires MySQL version %2$s or higher. You are running version %3$s.'),
			]),
			var_wp_version.clone(),
			var_required_mysql_version.clone(),
			var_mysql_version.clone(),
		])))
	}
	if !var_required_php_extensions.is_null() && var_required_php_extensions.clone().is_array() {
		var_missing_extensions = create_wp_error()
		mut iter_1 := var_required_php_extensions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_extension_shadow := item_1.val
			if rt.is_true(rt.call_function('extension_loaded', [
				var_extension_shadow.clone()]))
			{
				continue
			}
			var_missing_extensions.add(rt.new_string('php_not_compatible_${var_extension.to_string()}'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The update cannot be installed because WordPress %1$s requires the %2$s PHP extension.'),
				]),
				var_wp_version.clone(),
				var_extension_shadow.clone(),
			]))
		}
		if !(!rt.is_true(rt.get_property(var_missing_extensions, 'errors'))) {
			return mut var_missing_extensions
		}
	}
	rt.call_function('apply_filters', [rt.new_string('update_feedback'),
		rt.call_function('__', [
			rt.new_string('Preparing to install the latest version&#8230;'),
		])])
	var_skip = [rt.new_string('wp-content'), rt.new_string('wp-includes/version.php')]
	var_check_is_writable = rt.new_array()
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_core_checksums'),
	]))
	{
		var_working_dir_local = rt.new_string(
			(rt.get_constant('WP_CONTENT_DIR')).str() + '/upgrade/' + (rt.call_function('basename', [var_from.clone()])).str() +
			var_distro.str())
		var_checksums = rt.call_function('get_core_checksums', [
			var_wp_version.clone(), if !var_wp_local_package.is_null() {
				var_wp_local_package
			} else {
				rt.new_string('en_US')
			}])
		if var_checksums.clone().is_array() && var_checksums.array_isset(var_wp_version) {
			var_checksums = var_checksums.array_get(var_wp_version)
		}
		if rt.is_true(rt.new_bool(var_checksums.clone().is_array())) {
			mut iter_2 := var_checksums.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_checksum_shadow := item_2.val
				mut var_file_shadow := item_2.key
				if rt.is_true(rt.identical(rt.new_string('wp-content'), rt.call_function('substr', [
					var_file_shadow.clone(),
					rt.new_int(0),
					rt.new_int(10),
				])))
				{
					continue
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
					rt.new_string((rt.get_constant('ABSPATH')).str() + var_file_shadow.str()),
				])))))
				{
					continue
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
					rt.new_string(var_working_dir_local.str() + var_file_shadow.str()),
				])))))
				{
					continue
				}
				if rt.is_true(rt.identical(rt.new_string('.'), rt.call_function('dirname', [var_file_shadow.clone()])))
					&& rt.is_true(rt.call_function('in_array', [rt.call_function('pathinfo', [var_file_shadow.clone(), rt.get_constant('PATHINFO_EXTENSION')]), rt.create_array([rt.ArrayItem{
					key: none
					val: 'html'
				}, rt.ArrayItem{ key: none, val: 'txt' }]), rt.new_bool(true)])) {
					continue
				}
				if rt.is_true(rt.identical(rt.call_function('md5_file', [
					rt.new_string((rt.get_constant('ABSPATH')).str() + var_file_shadow.str()),
				]), var_checksum_shadow))
				{
					var_skip << var_file_shadow.clone()
				} else {
					var_check_is_writable.array_set(var_file_shadow,

						(rt.get_constant('ABSPATH')).str() + var_file_shadow.str())
				}
			}
		}
	}
	if rt.is_true(var_check_is_writable)
		&& rt.is_true(rt.identical(rt.new_string('direct'), rt.get_property(var_wp_filesystem, 'method'))) {
		var_files_writable = rt.call_function('array_filter', [
			var_check_is_writable.clone(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: var_wp_filesystem },
				rt.ArrayItem{ key: none, val: 'is_writable' },
			])])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_files_writable,
			var_check_is_writable))))
		{
			var_files_not_writable = rt.call_function('array_diff_key', [
				var_check_is_writable.clone(), var_files_writable.clone()])
			mut iter_3 := var_files_not_writable.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_file_not_writable_shadow := item_3.val
				mut var_relative_file_not_writable_shadow := item_3.key
				rt.call_method(var_wp_filesystem, 'chmod', [var_file_not_writable_shadow.clone(),
					rt.get_constant('FS_CHMOD_FILE')])
				if rt.is_true(rt.call_method(var_wp_filesystem, 'is_writable', [
					var_file_not_writable_shadow.clone(),
				]))
				{
					var_files_not_writable.array_unset(var_relative_file_not_writable_shadow)
				}
			}
			var_error_data = if rt.is_true(rt.call_function('version_compare', [
				var_old_wp_version.clone(),
				rt.new_string('3.7-beta2'),
				rt.new_string('>'),
			]))
			{ rt.func_array_keys(var_files_not_writable.clone()) } else { rt.new_string('') }
			if rt.is_true(var_files_not_writable) {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('files_not_writable'), rt.call_function('__', [
					rt.new_string('The update cannot be installed because your site is unable to copy some files. This is usually due to inconsistent file permissions.'),
				]), rt.call_function('implode', [rt.new_string(', '),
					var_error_data.clone()])))
			}
		}
	}
	rt.call_function('apply_filters', [rt.new_string('update_feedback'),
		rt.call_function('__', [rt.new_string('Enabling Maintenance mode&#8230;')])])
	var_maintenance_string = rt.new_string('<?php $upgrading = ' +
		(rt.call_function('time', []rt.PhpVal{})).str() + '; ?>')
	var_maintenance_file = rt.new_string(var_to.str() + '.maintenance')
	rt.call_method(var_wp_filesystem, 'delete', [var_maintenance_file.clone()])
	rt.call_method(var_wp_filesystem, 'put_contents', [var_maintenance_file.clone(),
		var_maintenance_string.clone(), rt.get_constant('FS_CHMOD_FILE')])
	rt.call_function('apply_filters', [rt.new_string('update_feedback'),
		rt.call_function('__', [rt.new_string('Copying the required files&#8230;')])])
	var_result = rt.call_function('copy_dir', [
		rt.new_string(var_from.str() + var_distro.str()),
		var_to.clone(),
		rt.create_array_from_list(var_skip),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		var_result = create_wp_error(rt.call_method(var_result, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_result,
			'get_error_message', []rt.PhpVal{}), rt.call_function('substr', [
			rt.call_method(var_result, 'get_error_data', []rt.PhpVal{}),
			rt.new_int(var_to.clone().to_string().len),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_result.clone()])))))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'copy', [
			rt.new_string(var_from.str() + var_distro.str() + 'wp-includes/version.php'),
			rt.new_string(var_to.str() + 'wp-includes/version.php'),
			rt.new_bool(true),
		])))))
		{
			rt.call_method(var_wp_filesystem, 'delete', [var_from.clone(),
				rt.new_bool(true)])
			var_result = create_wp_error(rt.new_string('copy_failed_for_version_file'), rt.call_function('__', [
				rt.new_string('The update cannot be installed because your site is unable to copy some files. This is usually due to inconsistent file permissions.'),
			]), rt.new_string('wp-includes/version.php'))
		}
		rt.call_method(var_wp_filesystem, 'chmod', [
			rt.new_string(var_to.str() + 'wp-includes/version.php'),
			rt.get_constant('FS_CHMOD_FILE'),
		])
		if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wp_opcache_invalidate'),
		]))
		{
			rt.call_function('wp_opcache_invalidate', [
				rt.new_string(var_to.str() + 'wp-includes/version.php'),
			])
		}
	}
	var_skip = [rt.new_string('wp-content')]
	var_failed = rt.new_array()
	if !var_checksums.is_null() && var_checksums.clone().is_array() {
		mut iter_4 := var_checksums.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_checksum_shadow := item_4.val
			mut var_file_shadow := item_4.key
			if rt.is_true(rt.identical(rt.new_string('wp-content'), rt.call_function('substr', [
				var_file_shadow.clone(),
				rt.new_int(0),
				rt.new_int(10),
			])))
			{
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
				rt.new_string(var_working_dir_local.str() + var_file_shadow.str()),
			])))))
			{
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('.'), rt.call_function('dirname', [var_file_shadow.clone()])))
				&& rt.is_true(rt.call_function('in_array', [rt.call_function('pathinfo', [var_file_shadow.clone(), rt.get_constant('PATHINFO_EXTENSION')]), rt.create_array([rt.ArrayItem{
				key: none
				val: 'html'
			}, rt.ArrayItem{ key: none, val: 'txt' }]), rt.new_bool(true)])) {
				var_skip << var_file_shadow.clone()
				continue
			}
			if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('ABSPATH')).str() + var_file_shadow.str())]))
				&& rt.is_true(rt.identical(rt.call_function('md5_file', [rt.new_string((rt.get_constant('ABSPATH')).str() + var_file_shadow.str())]), var_checksum_shadow)) {
				var_skip << var_file_shadow.clone()
			} else {
				var_failed << var_file_shadow.clone()
			}
		}
	}
	if !(!rt.is_true(var_failed)) {
		var_total_size = 0
		for var_file_shadow in var_failed {
			if rt.is_true(rt.call_function('file_exists', [
				rt.new_string(var_working_dir_local.str() + var_file_shadow.str()),
			]))
			{
				var_total_size = var_total_size +
					(rt.call_function('filesize', [rt.new_string(var_working_dir_local.str() +
					var_file_shadow.str())])).to_i64()
			}
		}
		var_available_space = if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('disk_free_space'),
		]))
		{
			rt.call_function('disk_free_space', [rt.get_constant('ABSPATH')])
		} else {
			rt.new_bool(false)
		}
		if rt.is_true(var_available_space)
			&& rt.is_true(rt.greater_equal(rt.new_int(var_total_size), var_available_space)) {
			var_result = create_wp_error(rt.new_string('disk_full'), rt.call_function('__', [
				rt.new_string('There is not enough free disk space to complete the update.'),
			]))
		} else {
			var_result = rt.call_function('copy_dir', [
				rt.new_string(var_from.str() + var_distro.str()),
				var_to.clone(),
				rt.create_array_from_list(var_skip),
			])
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				var_result = create_wp_error(
					(rt.call_method(var_result, 'get_error_code', []rt.PhpVal{})).str() + '_retry', rt.call_method(var_result,
					'get_error_message', []rt.PhpVal{}), rt.call_function('substr', [
					rt.call_method(var_result, 'get_error_data', []rt.PhpVal{}),
					rt.new_int(var_to.clone().to_string().len),
				]))
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])))))
		&& rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [rt.new_string(var_from.str() + var_distro.str() + 'wp-content/languages')])) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('WP_LANG_DIR'), (rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/languages'))))
			|| rt.is_true(rt.call_function('is_dir', [rt.get_constant('WP_LANG_DIR')])) {
			var_lang_dir = rt.get_constant('WP_LANG_DIR')
		} else {
			var_lang_dir = rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/languages')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_lang_dir.clone()])))))
			&& rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_lang_dir.clone(), rt.get_constant('ABSPATH')]))) {
			rt.call_method(var_wp_filesystem, 'mkdir', [
				rt.new_string(var_to.str() +(rt.call_function('str_replace', [rt.get_constant('ABSPATH'), rt.new_string(''), var_lang_dir.clone()])).str()),
				rt.get_constant('FS_CHMOD_DIR'),
			])
			rt.call_function('clearstatcache', []rt.PhpVal{})
		}
		if rt.is_true(rt.call_function('is_dir', [var_lang_dir.clone()])) {
			var_wp_lang_dir = rt.call_method(var_wp_filesystem, 'find_folder', [
				var_lang_dir.clone(),
			])
			if rt.is_true(var_wp_lang_dir) {
				var_result = rt.call_function('copy_dir', [
					rt.new_string(var_from.str() + var_distro.str() + 'wp-content/languages/'),
					var_wp_lang_dir.clone(),
				])
				if rt.is_true(rt.call_function('is_wp_error', [
					var_result.clone()]))
				{
					var_result = create_wp_error(
						(rt.call_method(var_result, 'get_error_code', []rt.PhpVal{})).str() +
						'_languages',
						rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}), rt.call_function('substr', [
						rt.call_method(var_result, 'get_error_data', []rt.PhpVal{}),
						rt.new_int(var_wp_lang_dir.clone().to_string().len),
					]))
				}
			}
		}
	}
	rt.call_function('apply_filters', [rt.new_string('update_feedback'),
		rt.call_function('__', [rt.new_string('Disabling Maintenance mode&#8230;')])])
	rt.call_method(var_wp_filesystem, 'delete', [var_maintenance_file.clone()])
	if rt.is_true(rt.identical(rt.new_string('3.5'), var_old_wp_version)) {
		if rt.is_true(rt.call_function('is_dir', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/themes/twentytwelve')]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/themes/twentytwelve/style.css')]))))) {
			rt.call_method(var_wp_filesystem, 'delete', [
				rt.new_string(
					(rt.call_method(var_wp_filesystem, 'wp_themes_dir', []rt.PhpVal{})).str() +
					'twentytwelve/'),
			])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('CORE_UPGRADE_SKIP_NEW_BUNDLED')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('CORE_UPGRADE_SKIP_NEW_BUNDLED'))))) {
		mut iter_5 := rt.cast_array(var__new_bundled_files).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_introduced_version_shadow := item_5.val
			mut var_file_shadow := item_5.key
			if rt.is_true(var_development_build)
				|| rt.is_true(rt.call_function('version_compare', [var_introduced_version_shadow.clone(), var_old_wp_version.clone(), rt.new_string('>')])) {
				var_directory = (rt.identical(rt.new_string('/'),
					var_file_shadow[var_file_shadow.clone().to_string().len - 1])).to_bool()
				mut list_tmp_1 := rt.call_function('explode', [
					rt.new_string('/'), var_file_shadow.clone(),
					rt.new_int(2)])
				var_type = list_tmp_1.array_get(0)
				var_filename = list_tmp_1.array_get(1)
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [
					rt.new_string(var_from.str() + var_distro.str() + 'wp-content/' +
						var_file_shadow.str()),
				])))))
				{
					continue
				}
				if rt.is_true(rt.identical(rt.new_string('plugins'), var_type)) {
					var_dest = rt.call_method(var_wp_filesystem, 'wp_plugins_dir', []rt.PhpVal{})
				} else if rt.is_true(rt.identical(rt.new_string('themes'), var_type)) {
					var_dest = rt.call_function('trailingslashit', [
						rt.call_method(var_wp_filesystem, 'wp_themes_dir', []rt.PhpVal{}),
					])
				} else {
					continue
				}
				if !var_directory {
					if rt.is_true(rt.new_bool(!(rt.is_true(var_development_build))))
						&& rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [rt.new_string(var_dest.str() + var_filename.str())])) {
						continue
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem,
						'copy', [
						rt.new_string(var_from.str() + var_distro.str() + 'wp-content/' +
							var_file_shadow.str()),
						rt.new_string(var_dest.str() + var_filename.str()),
						rt.get_constant('FS_CHMOD_FILE'),
					])))))
					{
						var_result = create_wp_error(rt.new_string('copy_failed_for_new_bundled_${var_type.to_string()}'), rt.call_function('__', [
							rt.new_string('Could not copy file.'),
						]), var_dest.str() + var_filename.str())
					}
				} else {
					if rt.is_true(rt.new_bool(!(rt.is_true(var_development_build))))
						&& rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [rt.new_string(var_dest.str() + var_filename.str())])) {
						continue
					}
					rt.call_method(var_wp_filesystem, 'mkdir', [
						rt.new_string(var_dest.str() + var_filename.str()),
						rt.get_constant('FS_CHMOD_DIR'),
					])
					var__result = rt.call_function('copy_dir', [
						rt.new_string(var_from.str() + var_distro.str() + 'wp-content/' +
							var_file_shadow.str()),
						rt.new_string(var_dest.str() + var_filename.str()),
					])
					if rt.is_true(rt.call_function('is_wp_error', [
						var__result.clone()]))
					{
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
							var_result.clone(),
						])))))
						{
							var_result = create_wp_error()
						}
						rt.call_method(var_result, 'add', [
							rt.new_string(
								(rt.call_method(var__result, 'get_error_code', []rt.PhpVal{})).str() +
								'_${var_type.to_string()}'),
							rt.call_method(var__result, 'get_error_message', []rt.PhpVal{}),
							rt.call_function('substr', [
								rt.call_method(var__result, 'get_error_data', []rt.PhpVal{}),
								rt.new_int(var_dest.clone().to_string().len),
							]),
						])
					}
				}
			}
		}
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.call_method(var_wp_filesystem, 'delete', [var_from.clone(),
			rt.new_bool(true)])
		return mut rt.cast_object_ptr[Class_WP_Error](var_result)
	}
	mut iter_6 := var__old_files.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_old_file_shadow := item_6.val
		var_old_file_shadow = rt.new_string(var_to.str() + var_old_file_shadow.str())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [
			var_old_file_shadow.clone(),
		])))))
		{
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'delete', [var_old_file_shadow.clone(), rt.new_bool(true)])))))
			&& rt.is_true(rt.call_method(var_wp_filesystem, 'is_file', [var_old_file_shadow.clone()])) {
			rt.call_method(var_wp_filesystem, 'put_contents', [
				var_old_file_shadow.clone(), rt.new_string('')])
		}
	}
	_upgrade_422_remove_genericons()
	_upgrade_440_force_deactivate_incompatible_plugins()
	_upgrade_core_deactivate_incompatible_plugins()
	rt.call_function('apply_filters', [rt.new_string('update_feedback'),
		rt.call_function('__', [rt.new_string('Upgrading database&#8230;')])])
	var_db_upgrade_url = rt.call_function('admin_url', [
		rt.new_string('upgrade.php?step=upgrade_db'),
	])
	rt.call_function('wp_remote_post', [var_db_upgrade_url.clone(),
		rt.create_array([rt.ArrayItem{ key: 'timeout', val: 60 }])])
	rt.call_function('wp_cache_flush', []rt.PhpVal{})
	rt.call_function('wp_cache_delete', [rt.new_string('alloptions'),
		rt.new_string('options')])
	rt.call_method(var_wp_filesystem, 'delete', [var_from.clone(),
		rt.new_bool(true)])
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('delete_site_transient'),
	]))
	{
		rt.call_function('delete_site_transient', [rt.new_string('update_core')])
	} else {
		rt.call_function('delete_option', [rt.new_string('update_core')])
	}
	rt.call_function('do_action', [rt.new_string('_core_updated_successfully'),
		var_wp_version.clone()])
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('delete_site_option'),
	]))
	{
		rt.call_function('delete_site_option', [rt.new_string('auto_core_update_failed')])
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_wp_version)
}

fn _preload_old_requests_classes_and_interfaces(var_to rt.PhpVal) {
	mut var__old_requests_files := rt.new_null()
	mut var_wp_filesystem := rt.new_null()
	mut var_wp_version := rt.new_null()
	mut var_file := []rt.PhpVal{}
	mut var_name := rt.new_null()
	if rt.is_true(rt.call_function('version_compare', [var_wp_version.clone(),
		rt.new_string('4.6'), rt.new_string('<')]))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('REQUESTS_SILENCE_PSR0_DEPRECATIONS'),
	])))))
	{
		rt.call_function('define', [rt.new_string('REQUESTS_SILENCE_PSR0_DEPRECATIONS'),
			rt.new_bool(true)])
	}
	mut iter_7 := var__old_requests_files.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_file_shadow := item_7.val
		mut var_name_shadow := item_7.key
		if rt.is_true(rt.new_bool(var_name_shadow.clone().is_long())) {
			continue
		}
		if rt.is_true(rt.call_function('class_exists', [var_name_shadow.clone()]))
			|| rt.is_true(rt.call_function('interface_exists', [var_name_shadow.clone()])) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_file', [
			rt.new_string(var_to.str() + var_file_shadow.str()),
		])))))
		{
			continue
		}
		rt.include_file(var_to.str() + var_file_shadow.str(), '4')
	}
}

fn _redirect_to_about_wordpress(var_new_version rt.PhpVal) {
	mut var_wp_version := rt.new_null()
	mut var_pagenow := rt.new_null()
	mut var_action := rt.new_null()
	if rt.is_true(rt.call_function('version_compare', [var_wp_version.clone(),
		rt.new_string('3.4-RC1'), rt.new_string('>=')]))
	{
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('update-core.php'),
		var_pagenow))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('do-core-upgrade'), var_action))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('do-core-reinstall'), var_action)))) {
		return
	}
	rt.call_function('load_default_textdomain', []rt.PhpVal{})
	rt.call_function('show_message', [
		rt.call_function('__', [rt.new_string('WordPress updated successfully.')]),
	])
	rt.call_function('show_message', [
		rt.new_string('<span class="hide-if-no-js">' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Welcome to WordPress %1$s. You will be redirected to the About WordPress screen. If not, click <a href="%2$s">here</a>.')]), var_new_version.clone(), rt.new_string('about.php?updated')])).str() +
			'</span>'),
	])
	rt.call_function('show_message', [
		rt.new_string('<span class="hide-if-js">' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Welcome to WordPress %1$s. <a href="%2$s">Learn more</a>.')]), var_new_version.clone(), rt.new_string('about.php?updated')])).str() +
			'</span>'),
	])
	print('</div>')
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
	exit(0)
}

fn _upgrade_422_remove_genericons() {
	mut var_wp_theme_directories := rt.new_null()
	mut var_wp_filesystem := rt.new_null()
	mut var_affected_files := rt.new_null()
	mut var_directory := rt.new_null()
	mut var_affected_theme_files := rt.new_null()
	mut var_affected_plugin_files := rt.new_null()
	mut var_file := []rt.PhpVal{}
	mut var_gen_dir := rt.new_null()
	mut var_remote_file := rt.new_null()
	var_affected_files = rt.new_array()
	mut iter_8 := var_wp_theme_directories.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_directory_shadow := item_8.val
		var_affected_theme_files =
			_upgrade_422_find_genericons_files_in_folder(var_directory_shadow.clone())
		var_affected_files = rt.call_function('array_merge', [
			var_affected_files.clone(), var_affected_theme_files.clone()])
	}
	var_affected_plugin_files =
		_upgrade_422_find_genericons_files_in_folder(rt.get_constant('WP_PLUGIN_DIR'))
	var_affected_files = rt.call_function('array_merge', [var_affected_files.clone(),
		var_affected_plugin_files.clone()])
	mut iter_9 := var_affected_files.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_file_shadow := item_9.val
		var_gen_dir = rt.call_method(var_wp_filesystem, 'find_folder', [
			rt.call_function('trailingslashit', [
				rt.call_function('dirname', [var_file_shadow.clone()]),
			]),
		])
		if !rt.is_true(var_gen_dir) {
			continue
		}
		var_remote_file = rt.new_string(var_gen_dir.str() +
			(rt.call_function('basename', [var_file_shadow.clone()])).str())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [
			var_remote_file.clone(),
		])))))
		{
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'delete', [
			var_remote_file.clone(),
			rt.new_bool(false),
			rt.new_string('f'),
		])))))
		{
			rt.call_method(var_wp_filesystem, 'put_contents', [
				var_remote_file.clone(), rt.new_string('')])
		}
	}
}

fn _upgrade_422_find_genericons_files_in_folder(var_directory_arg rt.PhpVal) rt.PhpVal {
	mut var_directory := var_directory_arg
	mut var_files := rt.new_null()
	mut var_dirs := rt.new_null()
	mut var_dir := rt.new_null()
	var_directory = rt.call_function('trailingslashit', [var_directory.clone()])
	var_files = rt.new_array()
	if rt.is_true(rt.call_function('file_exists', [rt.new_string('${var_directory.to_string()}example.html')]))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.call_function('file_get_contents', [rt.new_string('${var_directory.to_string()}example.html')]), rt.new_string('<title>Genericons</title>')]))))) {
		var_files.array_push('${var_directory.to_string()}example.html')
	}
	var_dirs = rt.call_function('glob', [rt.new_string(var_directory.str() + '*'),
		rt.get_constant('GLOB_ONLYDIR')])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_dir := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.new_bool(false), rt.call_function('strpos', [
			var_dir.clone(), rt.new_string('node_modules')]))
	}
	var_dirs = rt.call_function('array_filter', [var_dirs.clone(),
		rt.new_closure(closure_1_fn)])
	if rt.is_true(var_dirs) {
		mut iter_10 := var_dirs.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_dir_shadow := item_10.val
			var_files = rt.call_function('array_merge', [var_files.clone(),
				_upgrade_422_find_genericons_files_in_folder(var_dir_shadow.clone())])
		}
	}
	return var_files.clone()
}

fn _upgrade_440_force_deactivate_incompatible_plugins() {
	if rt.is_true(rt.call_function('defined', [rt.new_string('REST_API_VERSION')]))
		&& rt.is_true(rt.call_function('version_compare', [rt.get_constant('REST_API_VERSION'), rt.new_string('2.0-beta4'), rt.new_string('<=')])) {
		rt.call_function('deactivate_plugins', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'rest-api/plugin.php' }]),
			rt.new_bool(true),
		])
	}
}

fn _upgrade_core_deactivate_incompatible_plugins() {
	mut var_deactivated_gutenberg := map[string]rt.PhpVal{}
	mut var_deactivated_plugins := rt.new_null()
	if rt.is_true(rt.call_function('defined', [rt.new_string('GUTENBERG_VERSION')]))
		&& rt.is_true(rt.call_function('version_compare', [rt.get_constant('GUTENBERG_VERSION'), rt.new_string('17.6'), rt.new_string('<')])) {
		var_deactivated_gutenberg['gutenberg'] = rt.create_array([
			rt.ArrayItem{ key: 'plugin_name', val: 'Gutenberg' },
			rt.ArrayItem{ key: 'version_deactivated', val: rt.get_constant('GUTENBERG_VERSION') },
			rt.ArrayItem{ key: 'version_compatible', val: '17.6' },
		])
		if rt.is_true(rt.call_function('is_plugin_active_for_network', [
			rt.new_string('gutenberg/gutenberg.php'),
		]))
		{
			var_deactivated_plugins = rt.call_function('get_site_option', [
				rt.new_string('wp_force_deactivated_plugins'),
				rt.new_array(),
			])
			var_deactivated_plugins = rt.call_function('array_merge', [
				var_deactivated_plugins.clone(),
				rt.create_array_from_native_map(var_deactivated_gutenberg)])
			rt.call_function('update_site_option', [
				rt.new_string('wp_force_deactivated_plugins'),
				var_deactivated_plugins.clone(),
			])
		} else {
			var_deactivated_plugins = rt.call_function('get_option', [
				rt.new_string('wp_force_deactivated_plugins'),
				rt.new_array(),
			])
			var_deactivated_plugins = rt.call_function('array_merge', [
				var_deactivated_plugins.clone(),
				rt.create_array_from_native_map(var_deactivated_gutenberg)])
			rt.call_function('update_option', [
				rt.new_string('wp_force_deactivated_plugins'),
				var_deactivated_plugins.clone(),
				rt.new_bool(false),
			])
		}
		rt.call_function('deactivate_plugins', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'gutenberg/gutenberg.php' }]),
			rt.new_bool(true),
		])
	}
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var__old_files := rt.get_superglobal('_old_files')
	var__old_files = rt.create_array([
		rt.ArrayItem{ key: none, val: 'wp-admin/import-b2.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/import-blogger.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/import-greymatter.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/import-livejournal.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/import-mt.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/import-rss.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/import-textpattern.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/quicktags.js' },
		rt.ArrayItem{ key: none, val: 'wp-images/fade-butt.png' },
		rt.ArrayItem{ key: none, val: 'wp-images/get-firefox.png' },
		rt.ArrayItem{ key: none, val: 'wp-images/header-shadow.png' },
		rt.ArrayItem{ key: none, val: 'wp-images/smilies' },
		rt.ArrayItem{ key: none, val: 'wp-images/wp-small.png' },
		rt.ArrayItem{ key: none, val: 'wp-images/wpminilogo.png' },
		rt.ArrayItem{ key: none, val: 'wp.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/edit-form-ajax-cat.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/execute-pings.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/inline-uploading.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/link-categories.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/list-manipulation.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/list-manipulation.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/comment-functions.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/feed-functions.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/functions-compat.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/functions-formatting.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/functions-post.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dbx-key.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/links.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/pluggable-functions.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/template-functions-author.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/template-functions-category.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/template-functions-general.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/template-functions-links.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/template-functions-post.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/wp-l10n.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/cat-js.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/autosave-js.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/list-manipulation-js.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/wp-ajax-js.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/admin-db.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/cat.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/categories.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/custom-fields.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/dbx-admin-key.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/edit-comments.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/install-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/install.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/upgrade-schema.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/upload-functions.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/upload-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/upload.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/upload.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/users.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/widgets-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/widgets.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/xfn.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/license.html' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/upload.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/box-bg-left.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/box-bg-right.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/box-bg.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/box-butt-left.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/box-butt-right.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/box-butt.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/box-head-left.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/box-head-right.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/box-head.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/heading-bg.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/login-bkg-bottom.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/login-bkg-tile.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/notice.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/toggle.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/includes/upload.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/dbx-admin-key.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/link-cat.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/profile-update.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/templates.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dbx.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/fat.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/list-manipulation.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/langs/en.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/directionality/images' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/directionality/langs' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/paste/images' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/paste/jscripts' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/paste/langs' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wordpress/images' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wordpress/langs' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wordpress/wordpress.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wphelp' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/tiny_mce_gzip.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/bookmarklet.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/jquery.dimensions.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wordpress/popups.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/wp-ajax.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/press-this-ie-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/press-this-ie.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/upload-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/edit-form.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/comment-pill.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/comment-stalk-classic.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/comment-stalk-fresh.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/comment-stalk-rtl.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/del.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/gear.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/media-button-gallery.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/media-buttons.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/postbox-bg.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/tab.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/tail.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/forms.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/upload.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/link-import.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/audio.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/css.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/default.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/doc.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/exe.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/html.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/js.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/pdf.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/swf.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/tar.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/text.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/video.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/zip.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/tiny_mce_config.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/tiny_mce_ext.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/users.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/swfupload/swfupload_f9.swf' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/autosave' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/paste/css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/utils/mclayer.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/wordpress.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/page.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/page.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/set-post-thumbnail-handler.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/set-post-thumbnail-handler.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/slug.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/slug.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/gettext.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wordpress/js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/streams.php' },
		rt.ArrayItem{ key: none, val: 'README.txt' },
		rt.ArrayItem{ key: none, val: 'htaccess.dist' },
		rt.ArrayItem{ key: none, val: 'index-install.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/mu-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/mu.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/site-admin.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/includes/mu.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/wpmu-admin.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/wpmu-blogs.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/wpmu-edit.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/wpmu-options.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/wpmu-themes.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/wpmu-upgrade-site.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/wpmu-users.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/wordpress-mu.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/wpmu-default-filters.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/wpmu-functions.php' },
		rt.ArrayItem{ key: none, val: 'wpmu-settings.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/categories.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/edit-category-form.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/edit-page-form.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/edit-pages.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/admin-header-footer.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/browse-happy.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/ico-add.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/ico-close.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/ico-edit.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/ico-viewpage.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/fav-top.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/screen-options-left.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/wp-logo-vs.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/wp-logo.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/import' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/wp-gears.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/wp-gears.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/options-misc.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/page-new.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/page.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/update-links.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/wp-admin.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/wp-admin.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/codepress' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/autocomplete.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/autocomplete.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/interface.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/edit-attachment-rows.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/edit-link-categories.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/edit-link-category-form.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/edit-post-rows.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/button-grad-active-vs.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/button-grad-vs.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/fav-arrow-vs-rtl.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/fav-arrow-vs.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/fav-top-vs.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/list-vs.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/screen-options-right-up.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/screen-options-right.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/visit-site-button-grad-vs.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/visit-site-button-grad.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/link-category.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/sidebar.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/classes.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/blank.htm' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/media/img' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/safari' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/logo-login.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/star.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/list-table.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/list-table.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/default-embeds.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/colors-classic-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/colors-classic-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/colors-fresh-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/colors-fresh-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/dashboard-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/dashboard.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/global-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/global-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/global.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/global.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/install-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/login-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/login.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/ms.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/ms.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/nav-menu-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/nav-menu-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/nav-menu.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/nav-menu.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/plugin-install-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/plugin-install-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/plugin-install.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/plugin-install.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/press-this-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/press-this.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/theme-editor-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/theme-editor-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/theme-editor.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/theme-editor.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/theme-install-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/theme-install-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/theme-install.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/theme-install.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/widgets-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/widgets.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/includes/internal-linking.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/admin-bar-sprite-rtl.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui.button.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui.core.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui.dialog.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui.draggable.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui.droppable.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui.mouse.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui.position.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui.resizable.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui.selectable.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui.sortable.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui.tabs.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui.widget.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/l10n.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/l10n.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wplink/css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wplink/img' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wplink/js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/gray-star.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/logo-login.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/star.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/index-extra.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/network/index-extra.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/user/index-extra.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/editor-buttons.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/editor-buttons.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/paste/blank.htm' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wordpress/css' },
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/tinymce/plugins/wordpress/editor_plugin.dev.js'
		},
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/tinymce/plugins/wpdialogs/editor_plugin.dev.js'
		},
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/tinymce/plugins/wpeditimage/editor_plugin.dev.js'
		},
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/tinymce/plugins/wpgallery/editor_plugin.dev.js'
		},
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wplink/editor_plugin.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/gears-manifest.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/includes/manifest.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/archive-link.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/blue-grad.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/button-grad-active.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/button-grad.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/ed-bg-vs.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/ed-bg.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/fade-butt.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/fav-arrow-rtl.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/fav-arrow.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/fav-vs.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/fav.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/gray-grad.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/loading-publish.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/logo-ghost.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/logo.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/menu-arrow-frame-rtl.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/menu-arrow-frame.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/menu-arrows.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/menu-bits-rtl-vs.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/menu-bits-rtl.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/menu-bits-vs.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/menu-bits.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/menu-dark-rtl-vs.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/menu-dark-rtl.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/menu-dark-vs.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/menu-dark.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/required.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/screen-options-toggle-vs.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/screen-options-toggle.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/toggle-arrow-rtl.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/toggle-arrow.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/upload-classic.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/upload-fresh.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/white-grad-active.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/white-grad.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/widgets-arrow-vs.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/widgets-arrow.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/wpspin_dark.gif' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/upload.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/prototype.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/scriptaculous' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/wp-admin-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/wp-admin.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/media-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/media.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/colors-classic.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/customize-controls-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/customize-controls.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/ie-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/ie.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/install.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/colors-fresh.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/customize-base.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/json2.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/comment-reply.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/customize-preview.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/wplink.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tw-sack.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/wp-list-revisions.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/autosave.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/admin-bar.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/quicktags.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/wp-ajax-response.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/wp-pointer.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/hoverIntent.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/colorpicker.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/wp-lists.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/customize-loader.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/jquery.table-hotkeys.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/jquery.color.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/jquery.color.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/jquery.hotkeys.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/jquery.form.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/suggest.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/xfn.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/set-post-thumbnail.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/comment.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/theme.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/cat.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/password-strength-meter.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/user-profile.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/theme-preview.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/post.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/media-upload.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/word-count.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/plugin-install.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/edit-comments.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/media-gallery.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/custom-fields.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/custom-background.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/common.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/inline-edit-tax.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/gallery.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/utils.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/widgets.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/wp-fullscreen.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/nav-menu.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/dashboard.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/link.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/user-suggest.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/postbox.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/tags.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/image-edit.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/media.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/customize-controls.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/inline-edit-post.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/categories.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/editor.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/plupload/handlers.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/plupload/wp-plupload.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/swfupload/handlers.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jcrop/jquery.Jcrop.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jcrop/jquery.Jcrop.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jcrop/jquery.Jcrop.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/imgareaselect/jquery.imgareaselect.dev.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/wp-pointer.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/editor.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/jquery-ui-dialog.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/admin-bar-rtl.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/admin-bar.dev.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.effects.clip.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.effects.scale.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.effects.blind.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.effects.core.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.effects.shake.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.effects.fade.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.effects.explode.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.effects.slide.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.effects.drop.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.effects.highlight.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.effects.bounce.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.effects.pulsate.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.effects.transfer.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.effects.fold.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/utils.js' },
		rt.ArrayItem{ key: none, val: 'wp-app.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/class-wp-atom-server.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/swfupload/swfupload-all.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/revisions-js.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/screenshots' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/categories.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/categories.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/custom-fields.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/custom-fields.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/cat.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/cat.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/thickbox/tb-close-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/thickbox/tb-close.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/wpmini-blue-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/wpmini-blue.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/colors-fresh.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/colors-classic.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/colors-fresh.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/colors-classic.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/about.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/about.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/arrows-dark-vs-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/wp-logo-vs.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/arrows-dark-vs.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/wp-logo.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/arrows-pr.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/arrows-dark.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/press-this.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/press-this-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/arrows-vs-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/welcome-icons.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/wp-logo-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/stars-rtl-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/arrows-dark-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/arrows-pr-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/menu-shadow-rtl.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/arrows-vs.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/about-search-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/bubble_bg-rtl-2x.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/wp-badge-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/wordpress-logo-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/bubble_bg-rtl.gif' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/wp-badge.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/menu-shadow.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/about-globe-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/welcome-icons-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/stars-rtl.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/wp-logo-vs-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/about-updates-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/colors.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/colors.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/colors-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/colors-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/lock-2x.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/lock.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/theme-preview.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/theme-install.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/theme-install.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/theme-preview.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/plupload/plupload.html4.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/plupload/plupload.html5.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/plupload/changelog.txt' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/plupload/plupload.silverlight.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/plupload/plupload.flash.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/spellchecker' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/inlinepopups' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/media/js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/media/css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wordpress/img' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wpdialogs/js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wpeditimage/img' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wpeditimage/js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wpeditimage/css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wpgallery/img' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/paste/js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/themes/advanced' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/tiny_mce.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/mark_loaded_src.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/wp-tinymce-schema.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/media/editor_plugin.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/media/editor_plugin_src.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/media/media.htm' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wpview/editor_plugin_src.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wpview/editor_plugin.js' },
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/tinymce/plugins/directionality/editor_plugin.js'
		},
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/tinymce/plugins/directionality/editor_plugin_src.js'
		},
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wordpress/editor_plugin.js' },
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/tinymce/plugins/wordpress/editor_plugin_src.js'
		},
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/tinymce/plugins/wpdialogs/editor_plugin_src.js'
		},
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wpdialogs/editor_plugin.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wpeditimage/editimage.html' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wpeditimage/editor_plugin.js' },
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/tinymce/plugins/wpeditimage/editor_plugin_src.js'
		},
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/tinymce/plugins/fullscreen/editor_plugin_src.js'
		},
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/fullscreen/fullscreen.htm' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/fullscreen/editor_plugin.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wplink/editor_plugin_src.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wplink/editor_plugin.js' },
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/tinymce/plugins/wpgallery/editor_plugin_src.js'
		},
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wpgallery/editor_plugin.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/tabfocus/editor_plugin.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/tabfocus/editor_plugin_src.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/paste/editor_plugin.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/paste/pasteword.htm' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/paste/editor_plugin_src.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/paste/pastetext.htm' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/langs/wp-langs.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.accordion.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.autocomplete.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.button.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.core.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.datepicker.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.dialog.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.draggable.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.droppable.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.effect-blind.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.effect-bounce.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.effect-clip.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.effect-drop.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.effect-explode.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.effect-fade.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.effect-fold.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.effect-highlight.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.effect-pulsate.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.effect-scale.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.effect-shake.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.effect-slide.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.effect-transfer.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.effect.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.menu.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.mouse.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.position.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.progressbar.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.resizable.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.selectable.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.slider.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.sortable.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.spinner.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.tabs.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.tooltip.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/jquery.ui.widget.min.js' },
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/tinymce/skins/wordpress/images/dashicon-no-alt.png'
		},
		rt.ArrayItem{ key: none, val: 'wp-admin/js/wp-fullscreen.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/wp-fullscreen.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/wp-mce-help.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wpfullscreen' },
		rt.ArrayItem{ key: none, val: 'wp-includes/theme-compat/comments-popup.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/includes/class-wp-automatic-upgrader.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/wpembed' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/plugins/media/moxieplayer.swf' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/skins/lightgray/fonts/readme.md' },
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/tinymce/skins/lightgray/fonts/tinymce-small.json'
		},
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/skins/lightgray/fonts/tinymce.json' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/skins/lightgray/skin.ie7.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/press-this-editor-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/press-this-editor-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/press-this-editor.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/press-this-editor.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/press-this-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/press-this-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/press-this.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/press-this.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/includes/class-wp-press-this.php' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/bookmarklet.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/bookmarklet.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/press-this.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/press-this.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/background.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/bigplay.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/bigplay.svg' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/controls.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/controls.svg' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/flashmediaelement.swf' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/froogaloop.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/jumpforward.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/loading.gif' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/silverlightmediaelement.xap' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/skipback.png' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/plupload/plupload.flash.swf' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/plupload/plupload.full.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/plupload/plupload.silverlight.xap' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/swfupload/plugins' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/swfupload/swfupload.swf' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/lang' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/mediaelement-flash-audio-ogg.swf' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/mediaelement-flash-audio.swf' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/mediaelement-flash-video-hls.swf' },
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/mediaelement/mediaelement-flash-video-mdash.swf'
		},
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/mediaelement-flash-video.swf' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/renderers/dailymotion.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/renderers/dailymotion.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/renderers/facebook.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/renderers/facebook.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/renderers/soundcloud.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/renderers/soundcloud.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/renderers/twitch.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/mediaelement/renderers/twitch.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/codemirror/jshint.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/tinymce/wp-tinymce.js.gz' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/wp-a11y.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/wp-a11y.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/wp-fullscreen-stub.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/js/wp-fullscreen-stub.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/ie.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/ie.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/ie-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/css/ie-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/position.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/jquery/ui/widget.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/classic/block.json' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/freedoms.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/privacy.png' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/about-badge.svg' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/about-color-palette.svg' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/about-color-palette-vert.svg' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/about-header-brushes.svg' },
		rt.ArrayItem{ key: none, val: 'wp-includes/block-patterns/large-header.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/block-patterns/heading-paragraph.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/block-patterns/quote.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/block-patterns/text-three-columns-buttons.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/block-patterns/two-buttons.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/block-patterns/two-images.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/block-patterns/three-buttons.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/block-patterns/text-two-columns-with-images.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/block-patterns/text-two-columns.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/block-patterns/large-header-button.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/subhead' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/dist/editor/editor-styles.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/dist/editor/editor-styles.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/dist/editor/editor-styles-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/dist/editor/editor-styles-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/heading/editor.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/heading/editor.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/heading/editor-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/heading/editor-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/query-title/editor.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/query-title/editor.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/query-title/editor-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/query-title/editor-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/post-comments.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/post-comments' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/comments-query-loop' },
		rt.ArrayItem{ key: none, val: 'wp-includes/images/wlw' },
		rt.ArrayItem{ key: none, val: 'wp-includes/wlwmanifest.xml' },
		rt.ArrayItem{ key: none, val: 'wp-includes/random_compat' },
		rt.ArrayItem{ key: none, val: 'wp-includes/navigation-fallback.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/navigation/view-modal.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/navigation/view-modal.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/ID3/license.commercial.txt' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/query/style-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/query/style.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/query/style-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/query/style.css' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/about-header-privacy.svg' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/about-header-about.svg' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/about-header-credits.svg' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/about-header-freedoms.svg' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/about-header-contribute.svg' },
		rt.ArrayItem{ key: none, val: 'wp-admin/images/about-header-background.svg' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/block/editor.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/block/editor.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/block/editor-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/block/editor-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/interactivity-router.asset.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/interactivity-router.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/interactivity-router.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/interactivity-router.min.asset.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/interactivity.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/interactivity.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/vendor/react-dom.min.js.LICENSE.txt' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/vendor/react.min.js.LICENSE.txt' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/vendor/wp-polyfill-importmap.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/vendor/wp-polyfill-importmap.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/sodium_compat/src/Core/Base64/Common.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Author.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Cache.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Caption.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Category.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Copyright.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Core.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Credit.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Enclosure.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Exception.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/File.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/gzdecode.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/IRI.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Item.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Locator.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Misc.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Parser.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Rating.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Registry.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Restriction.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Sanitize.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Source.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Cache/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Content/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Decode/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/HTTP/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Net/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/Parse/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/XML/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/post-content/editor.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/post-content/editor.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/post-content/editor-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/post-content/editor-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/post-template/editor.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/post-template/editor.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/post-template/editor-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/post-template/editor-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/fields.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/fields.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/src/Decode' },
		rt.ArrayItem{ key: none, val: 'wp-includes/SimplePie/src/Core.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/assets/script-loader-packages.min.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/assets/script-loader-react-refresh-entry.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/assets/script-loader-react-refresh-entry.min.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/assets/script-loader-react-refresh-runtime.php' },
		rt.ArrayItem{
			key: none
			val: 'wp-includes/assets/script-loader-react-refresh-runtime.min.php'
		},
		rt.ArrayItem{ key: none, val: 'wp-includes/assets/script-modules-packages.min.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/archives/editor.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/archives/editor.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/archives/editor-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/archives/editor-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/file/view.asset.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/file/view.min.asset.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/file/view.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/file/view.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/image/view.asset.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/image/view.min.asset.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/image/view.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/image/view.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/navigation/view.asset.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/navigation/view.min.asset.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/navigation/view.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/navigation/view.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/navigation/view-modal.asset.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/navigation/view-modal.min.asset.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/query/view.asset.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/query/view.min.asset.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/query/view.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/query/view.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/search/view.asset.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/search/view.min.asset.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/search/view.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/search/view.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/tag-cloud/editor.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/tag-cloud/editor.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/tag-cloud/editor-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/blocks/tag-cloud/editor-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/dist/admin-ui/style.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/dist/admin-ui/style.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/dist/admin-ui/style-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/dist/admin-ui/style-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/dist/admin-ui/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/dist/edit-site/posts.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/dist/edit-site/posts.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/dist/edit-site/posts-rtl.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/css/dist/edit-site/posts-rtl.min.css' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/admin-ui.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/admin-ui.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/latex-to-mathml.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/latex-to-mathml.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/views.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/views.min.js' },
		rt.ArrayItem{ key: none, val: 'wp-includes/js/dist/script-modules/interactivity/debug.js' },
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/dist/script-modules/interactivity/debug.min.js'
		},
		rt.ArrayItem{
			key: none
			val: 'wp-includes/js/dist/vendor/react-jsx-runtime.min.js.LICENSE.txt'
		},
	])
	mut var__old_requests_files := rt.get_superglobal('_old_requests_files')
	var__old_requests_files = rt.create_array([
		rt.ArrayItem{ key: 'Requests_Auth', val: 'wp-includes/Requests/Auth.php' },
		rt.ArrayItem{ key: 'Requests_Hooker', val: 'wp-includes/Requests/Hooker.php' },
		rt.ArrayItem{ key: 'Requests_Proxy', val: 'wp-includes/Requests/Proxy.php' },
		rt.ArrayItem{ key: 'Requests_Transport', val: 'wp-includes/Requests/Transport.php' },
		rt.ArrayItem{ key: 'Requests_Auth_Basic', val: 'wp-includes/Requests/Auth/Basic.php' },
		rt.ArrayItem{ key: 'Requests_Cookie_Jar', val: 'wp-includes/Requests/Cookie/Jar.php' },
		rt.ArrayItem{ key: 'Requests_Exception_HTTP', val: 'wp-includes/Requests/Exception/HTTP.php' },
		rt.ArrayItem{
			key: 'Requests_Exception_Transport'
			val: 'wp-includes/Requests/Exception/Transport.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_304'
			val: 'wp-includes/Requests/Exception/HTTP/304.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_305'
			val: 'wp-includes/Requests/Exception/HTTP/305.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_306'
			val: 'wp-includes/Requests/Exception/HTTP/306.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_400'
			val: 'wp-includes/Requests/Exception/HTTP/400.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_401'
			val: 'wp-includes/Requests/Exception/HTTP/401.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_402'
			val: 'wp-includes/Requests/Exception/HTTP/402.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_403'
			val: 'wp-includes/Requests/Exception/HTTP/403.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_404'
			val: 'wp-includes/Requests/Exception/HTTP/404.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_405'
			val: 'wp-includes/Requests/Exception/HTTP/405.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_406'
			val: 'wp-includes/Requests/Exception/HTTP/406.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_407'
			val: 'wp-includes/Requests/Exception/HTTP/407.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_408'
			val: 'wp-includes/Requests/Exception/HTTP/408.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_409'
			val: 'wp-includes/Requests/Exception/HTTP/409.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_410'
			val: 'wp-includes/Requests/Exception/HTTP/410.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_411'
			val: 'wp-includes/Requests/Exception/HTTP/411.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_412'
			val: 'wp-includes/Requests/Exception/HTTP/412.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_413'
			val: 'wp-includes/Requests/Exception/HTTP/413.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_414'
			val: 'wp-includes/Requests/Exception/HTTP/414.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_415'
			val: 'wp-includes/Requests/Exception/HTTP/415.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_416'
			val: 'wp-includes/Requests/Exception/HTTP/416.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_417'
			val: 'wp-includes/Requests/Exception/HTTP/417.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_418'
			val: 'wp-includes/Requests/Exception/HTTP/418.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_428'
			val: 'wp-includes/Requests/Exception/HTTP/428.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_429'
			val: 'wp-includes/Requests/Exception/HTTP/429.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_431'
			val: 'wp-includes/Requests/Exception/HTTP/431.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_500'
			val: 'wp-includes/Requests/Exception/HTTP/500.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_501'
			val: 'wp-includes/Requests/Exception/HTTP/501.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_502'
			val: 'wp-includes/Requests/Exception/HTTP/502.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_503'
			val: 'wp-includes/Requests/Exception/HTTP/503.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_504'
			val: 'wp-includes/Requests/Exception/HTTP/504.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_505'
			val: 'wp-includes/Requests/Exception/HTTP/505.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_511'
			val: 'wp-includes/Requests/Exception/HTTP/511.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_HTTP_Unknown'
			val: 'wp-includes/Requests/Exception/HTTP/Unknown.php'
		},
		rt.ArrayItem{
			key: 'Requests_Exception_Transport_cURL'
			val: 'wp-includes/Requests/Exception/Transport/cURL.php'
		},
		rt.ArrayItem{ key: 'Requests_Proxy_HTTP', val: 'wp-includes/Requests/Proxy/HTTP.php' },
		rt.ArrayItem{
			key: 'Requests_Response_Headers'
			val: 'wp-includes/Requests/Response/Headers.php'
		},
		rt.ArrayItem{ key: 'Requests_Transport_cURL', val: 'wp-includes/Requests/Transport/cURL.php' },
		rt.ArrayItem{
			key: 'Requests_Transport_fsockopen'
			val: 'wp-includes/Requests/Transport/fsockopen.php'
		},
		rt.ArrayItem{
			key: 'Requests_Utility_CaseInsensitiveDictionary'
			val: 'wp-includes/Requests/Utility/CaseInsensitiveDictionary.php'
		},
		rt.ArrayItem{
			key: 'Requests_Utility_FilteredIterator'
			val: 'wp-includes/Requests/Utility/FilteredIterator.php'
		},
		rt.ArrayItem{ key: 'Requests_Cookie', val: 'wp-includes/Requests/Cookie.php' },
		rt.ArrayItem{ key: 'Requests_Exception', val: 'wp-includes/Requests/Exception.php' },
		rt.ArrayItem{ key: 'Requests_Hooks', val: 'wp-includes/Requests/Hooks.php' },
		rt.ArrayItem{ key: 'Requests_IDNAEncoder', val: 'wp-includes/Requests/IDNAEncoder.php' },
		rt.ArrayItem{ key: 'Requests_IPv6', val: 'wp-includes/Requests/IPv6.php' },
		rt.ArrayItem{ key: 'Requests_IRI', val: 'wp-includes/Requests/IRI.php' },
		rt.ArrayItem{ key: 'Requests_Response', val: 'wp-includes/Requests/Response.php' },
		rt.ArrayItem{ key: 'Requests_SSL', val: 'wp-includes/Requests/SSL.php' },
		rt.ArrayItem{ key: 'Requests_Session', val: 'wp-includes/Requests/Session.php' },
		rt.ArrayItem{ key: none, val: 'wp-includes/Requests/Auth/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/Requests/Cookie/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/Requests/Exception/HTTP/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/Requests/Exception/Transport/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/Requests/Exception/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/Requests/Proxy/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/Requests/Response/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/Requests/Transport/' },
		rt.ArrayItem{ key: none, val: 'wp-includes/Requests/Utility/' },
	])
	mut var__new_bundled_files := rt.get_superglobal('_new_bundled_files')
}
