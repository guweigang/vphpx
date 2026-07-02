import rt

struct Class_WP_Site_Health_Auto_Updates {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Site_Health_Auto_Updates) construct() {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'4')
}

fn (mut this Class_WP_Site_Health_Auto_Updates) run_tests() rt.PhpVal {
	mut var_tests := rt.create_array([
		rt.ArrayItem{ key: none, val: this.test_constants(rt.new_string('WP_AUTO_UPDATE_CORE'), rt.create_array([
			rt.ArrayItem{ key: none, val: true },
			rt.ArrayItem{ key: none, val: 'beta' },
			rt.ArrayItem{ key: none, val: 'rc' },
			rt.ArrayItem{ key: none, val: 'development' },
			rt.ArrayItem{ key: none, val: 'branch-development' },
			rt.ArrayItem{ key: none, val: 'minor' },
		])) },
		rt.ArrayItem{ key: none, val: this.test_wp_version_check_attached() },
		rt.ArrayItem{ key: none, val: this.test_filters_automatic_updater_disabled() },
		rt.ArrayItem{ key: none, val: this.test_wp_automatic_updates_disabled() },
		rt.ArrayItem{ key: none, val: this.test_if_failed_update() },
		rt.ArrayItem{ key: none, val: this.test_vcs_abspath() },
		rt.ArrayItem{ key: none, val: this.test_check_wp_filesystem_method() },
		rt.ArrayItem{ key: none, val: this.test_all_files_writable() },
		rt.ArrayItem{ key: none, val: this.test_accepts_dev_updates() },
		rt.ArrayItem{ key: none, val: this.test_accepts_minor_updates() },
	])
	var_tests = rt.call_function('array_filter', [var_tests.clone()])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_test := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_test = rt.array_to_object(var_test)
		if !rt.is_true(rt.get_property(var_test, 'severity')) {
			rt.set_property(var_test, 'severity', rt.new_string('warning'))
		}
		return var_test.clone()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_test := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_test = rt.array_to_object(var_test)
		if !rt.is_true(rt.get_property(var_test, 'severity')) {
			rt.set_property(var_test, 'severity', rt.new_string('warning'))
		}
		return var_test.clone()
	}
	var_tests = rt.call_function('array_map', [rt.new_closure(closure_1_fn),
		var_tests.clone()])
	return var_tests.clone()
}

fn (mut this Class_WP_Site_Health_Auto_Updates) test_constants(var_constant rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_acceptable_values := rt.cast_array(var_value)
	if rt.is_true(rt.call_function('defined', [var_constant.clone()]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_function('constant', [var_constant.clone()]), var_acceptable_values.clone(), rt.new_bool(true)]))))) {
		return rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The %1$s constant is defined as %2$s'),
				]),
				rt.new_string('<code>${var_constant.to_string()}</code>'),
				rt.new_string('<code>' +
					(rt.call_function('esc_html', [rt.call_function('var_export', [rt.call_function('constant', [var_constant.clone()]), rt.new_bool(true)])])).str() +
					'</code>'),
			]) },
			rt.ArrayItem{ key: 'severity', val: 'fail' },
		])
	}
	return rt.new_null()
}

fn (mut this Class_WP_Site_Health_Auto_Updates) test_wp_version_check_attached() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		|| (rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_filter', [rt.new_string('wp_version_check'), rt.new_string('wp_version_check')]))))) {
		return rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('A plugin has prevented updates by disabling %s.'),
				]),
				rt.new_string('<code>wp_version_check()</code>'),
			]) },
			rt.ArrayItem{ key: 'severity', val: 'fail' },
		])
	}
	return rt.new_null()
}

fn (mut this Class_WP_Site_Health_Auto_Updates) test_filters_automatic_updater_disabled() rt.PhpVal {
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('automatic_updater_disabled'),
		rt.new_bool(false),
	]))
	{
		return rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('The %s filter is enabled.')]),
				rt.new_string('<code>automatic_updater_disabled</code>'),
			]) },
			rt.ArrayItem{ key: 'severity', val: 'fail' },
		])
	}
	return rt.new_null()
}

fn (mut this Class_WP_Site_Health_Auto_Updates) test_wp_automatic_updates_disabled() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Automatic_Updater'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-automatic-updater.php',
			'4')
	}
	mut var_auto_updates := create_wp_automatic_updater()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_auto_updates.is_disabled())))) {
		return rt.new_bool(false)
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('All automatic updates are disabled.'),
		]) },
		rt.ArrayItem{ key: 'severity', val: 'fail' },
	])
}

fn (mut this Class_WP_Site_Health_Auto_Updates) test_if_failed_update() rt.PhpVal {
	mut var_failed := rt.call_function('get_site_option', [
		rt.new_string('auto_core_update_failed'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_failed)))) {
		return rt.new_bool(false)
	}
	if !(!rt.is_true(var_failed.array_get(rt.new_string('critical')))) {
		mut var_description := rt.call_function('__', [
			rt.new_string('A previous automatic background update ended with a critical failure, so updates are now disabled.'),
		])
		var_description = rt.concat(var_description,
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('You would have received an email because of this.')])).str()))
		var_description = rt.concat(var_description,
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('When you\'ve been able to update using the "Update now" button on Dashboard > Updates, this error will be cleared for future update attempts.')])).str()))
		var_description = rt.concat(var_description, rt.new_string(' ' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The error code was %s.')]), rt.new_string('<code>' +
			(var_failed.array_get(rt.new_string('error_code'))).str() + '</code>')])).str()))
		return rt.create_array([rt.ArrayItem{ key: 'description', val: var_description },
			rt.ArrayItem{ key: 'severity', val: 'warning' }])
	}
	var_description = rt.call_function('__', [
		rt.new_string('A previous automatic background update could not occur.'),
	])
	if !rt.is_true(var_failed.array_get(rt.new_string('retry'))) {
		var_description = rt.concat(var_description,
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('You would have received an email because of this.')])).str()))
	}
	var_description = rt.concat(var_description,
		rt.new_string(' ' +(rt.call_function('__', [rt.new_string('Another attempt will be made with the next release.')])).str()))
	var_description = rt.concat(var_description, rt.new_string(' ' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The error code was %s.')]), rt.new_string('<code>' +
		(var_failed.array_get(rt.new_string('error_code'))).str() + '</code>')])).str()))
	return rt.create_array([rt.ArrayItem{ key: 'description', val: var_description },
		rt.ArrayItem{ key: 'severity', val: 'warning' }])
}

fn (mut this Class_WP_Site_Health_Auto_Updates) test_vcs_abspath() rt.PhpVal {
	mut var_context_dirs := [rt.get_constant('ABSPATH')]
	mut var_vcs_dirs := ['.svn', '.git', '.hg', '.bzr']
	mut var_check_dirs := rt.new_array()
	for var_context_dir in var_context_dirs {
		var_context_dir = rt.call_function('dirname', [var_context_dir.clone()])
		for {
			var_check_dirs.array_push(var_context_dir.clone())
			if rt.is_true(rt.identical(rt.call_function('dirname', [
				var_context_dir.clone()]), var_context_dir))
			{
				break
			}
			if !(rt.is_true(var_context_dir)) {
				break
			}
		}
	}
	var_check_dirs = rt.call_function('array_unique', [var_check_dirs.clone()])
	mut var_updater := create_wp_automatic_updater()
	mut var_checkout := rt.new_bool(false)
	for var_vcs_dir in var_vcs_dirs {
		mut iter_1 := var_check_dirs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_check_dir := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(var_updater.is_allowed_dir(var_check_dir.clone()))))) {
				continue
			}
			var_checkout = rt.call_function('is_dir', [
				rt.new_string(var_check_dir.clone().to_string().trim_right(' \t\n\r') +
					'/${var_vcs_dir}'),
			])
			if rt.is_true(var_checkout) {
				break
			}
		}
	}
	if rt.is_true(var_checkout)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('automatic_updates_is_vcs_checkout'), rt.new_bool(true), rt.get_constant('ABSPATH')]))))) {
		return rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The folder %1$s was detected as being under version control (%2$s), but the %3$s filter is allowing updates.'),
				]),
				rt.new_string('<code>' + var_check_dir.str() + '</code>'),
				rt.new_string('<code>${var_vcs_dir.to_string()}</code>'),
				rt.new_string('<code>automatic_updates_is_vcs_checkout</code>'),
			]) },
			rt.ArrayItem{ key: 'severity', val: 'info' },
		])
	}
	if rt.is_true(var_checkout) {
		return rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The folder %1$s was detected as being under version control (%2$s).'),
				]),
				rt.new_string('<code>' + var_check_dir.str() + '</code>'),
				rt.new_string('<code>${var_vcs_dir.to_string()}</code>'),
			]) },
			rt.ArrayItem{ key: 'severity', val: 'warning' },
		])
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('No version control systems were detected.'),
		]) },
		rt.ArrayItem{ key: 'severity', val: 'pass' },
	])
}

fn (mut this Class_WP_Site_Health_Auto_Updates) test_check_wp_filesystem_method() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('request_filesystem_credentials'),
	])))))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	}
	mut var_skin := create_automatic_upgrader_skin()
	mut var_success := var_skin.request_filesystem_credentials(rt.new_bool(false),
		rt.get_constant('ABSPATH'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_success)))) {
		mut var_description := rt.call_function('__', [
			rt.new_string('Your installation of WordPress prompts for FTP credentials to perform updates.'),
		])
		var_description = rt.concat(var_description,
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('(Your site is performing updates over FTP due to file ownership. Talk to your hosting company.)')])).str()))
		return rt.create_array([rt.ArrayItem{ key: 'description', val: var_description },
			rt.ArrayItem{ key: 'severity', val: 'fail' }])
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Your installation of WordPress does not require FTP credentials to perform updates.'),
		]) },
		rt.ArrayItem{ key: 'severity', val: 'pass' },
	])
}

fn (mut this Class_WP_Site_Health_Auto_Updates) test_all_files_writable() rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_wp_version := rt.new_null()
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/version.php', '3')
	mut var_skin := create_automatic_upgrader_skin()
	mut var_success := var_skin.request_filesystem_credentials(rt.new_bool(false),
		rt.get_constant('ABSPATH'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_success)))) {
		return rt.new_bool(false)
	}
	rt.call_function('WP_Filesystem', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('direct'), rt.get_property(var_wp_filesystem,
		'method')))))
	{
		return rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_core_checksums'),
	])))))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/update.php', '4')
	}
	mut var_checksums := rt.call_function('get_core_checksums', [
		var_wp_version.clone(), rt.new_string('en_US')])
	mut var_dev := rt.call_function('str_contains', [var_wp_version.clone(),
		rt.new_string('-')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_checksums)))) && rt.is_true(var_dev) {
		var_checksums = rt.call_function('get_core_checksums', [
			rt.new_float(var_wp_version.to_f64()) - 0.1,
			rt.new_string('en_US'),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_checksums)))) && rt.is_true(var_dev) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_checksums)))) {
		mut var_description := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string("Couldn't retrieve a list of the checksums for WordPress %s."),
			]),
			var_wp_version.clone(),
		])
		var_description = rt.concat(var_description,
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('This could mean that connections are failing to WordPress.org.')])).str()))
		return rt.create_array([rt.ArrayItem{ key: 'description', val: var_description },
			rt.ArrayItem{ key: 'severity', val: 'warning' }])
	}
	mut var_unwritable_files := rt.new_array()
	mut iter_2 := rt.func_array_keys(var_checksums.clone()).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_file := item_2.val
		if rt.is_true(rt.call_function('str_starts_with', [var_file.clone(),
			rt.new_string('wp-content')]))
		{
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
			rt.new_string((rt.get_constant('ABSPATH')).str() + var_file.str()),
		])))))
		{
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [
			rt.new_string((rt.get_constant('ABSPATH')).str() + var_file.str()),
		])))))
		{
			var_unwritable_files.array_push(var_file.clone())
		}
	}
	if rt.is_true(var_unwritable_files) {
		if var_unwritable_files.clone().array_count() > 20 {
			var_unwritable_files = rt.call_function('array_slice', [
				var_unwritable_files.clone(), rt.new_int(0), rt.new_int(20)])
			var_unwritable_files.array_push('...')
		}
		return rt.create_array([
			rt.ArrayItem{ key: 'description', val:
				(rt.call_function('__', [rt.new_string('Some files are not writable by WordPress:')])).str() +
				' <ul><li>' +
				(rt.call_function('implode', [rt.new_string('</li><li>'), var_unwritable_files.clone()])).str() +
				'</li></ul>' },
			rt.ArrayItem{ key: 'severity', val: 'fail' },
		])
	} else {
		return rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('All of your WordPress files are writable.'),
			]) },
			rt.ArrayItem{ key: 'severity', val: 'pass' },
		])
	}
	return rt.new_null()
}

fn (mut this Class_WP_Site_Health_Auto_Updates) test_accepts_dev_updates() rt.PhpVal {
	mut var_wp_version := rt.new_null()
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/version.php', '3')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		var_wp_version.clone(), rt.new_string('-')])))))
	{
		return rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_AUTO_UPDATE_CORE')]))
		&& rt.is_true(rt.identical(rt.new_string('minor'), rt.get_constant('WP_AUTO_UPDATE_CORE')))
		|| rt.is_true(rt.identical(rt.new_bool(false), rt.get_constant('WP_AUTO_UPDATE_CORE'))) {
		return rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('WordPress development updates are blocked by the %s constant.'),
				]),
				rt.new_string('<code>WP_AUTO_UPDATE_CORE</code>'),
			]) },
			rt.ArrayItem{ key: 'severity', val: 'fail' },
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('allow_dev_auto_core_updates'),
		var_wp_version.clone(),
	])))))
	{
		return rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('WordPress development updates are blocked by the %s filter.'),
				]),
				rt.new_string('<code>allow_dev_auto_core_updates</code>'),
			]) },
			rt.ArrayItem{ key: 'severity', val: 'fail' },
		])
	}
	return rt.new_null()
}

fn (mut this Class_WP_Site_Health_Auto_Updates) test_accepts_minor_updates() rt.PhpVal {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_AUTO_UPDATE_CORE')]))
		&& rt.is_true(rt.identical(rt.new_bool(false), rt.get_constant('WP_AUTO_UPDATE_CORE'))) {
		return rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('WordPress security and maintenance releases are blocked by %s.'),
				]),
				rt.new_string("<code>define( 'WP_AUTO_UPDATE_CORE', false );</code>"),
			]) },
			rt.ArrayItem{ key: 'severity', val: 'fail' },
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('allow_minor_auto_core_updates'),
		rt.new_bool(true),
	])))))
	{
		return rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('WordPress security and maintenance releases are blocked by the %s filter.'),
				]),
				rt.new_string('<code>allow_minor_auto_core_updates</code>'),
			]) },
			rt.ArrayItem{ key: 'severity', val: 'fail' },
		])
	}
	return rt.new_null()
}

struct Class_WP_Automatic_Updater {
	rt.PhpObjectBase
}

struct Class_Automatic_Upgrader_Skin {
	rt.PhpObjectBase
}

fn create_wp_site_health_auto_updates() &Class_WP_Site_Health_Auto_Updates {
	mut obj := &Class_WP_Site_Health_Auto_Updates{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_automatic_updater(_args ...rt.PhpVal) &Class_WP_Automatic_Updater {
	mut obj := &Class_WP_Automatic_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automatic_upgrader_skin(_args ...rt.PhpVal) &Class_Automatic_Upgrader_Skin {
	mut obj := &Class_Automatic_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Site_Health_Auto_Updates) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'run_tests' {
			return this.run_tests()
		}
		'test_constants' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.test_constants(dispatch_arg_0, dispatch_arg_1)
		}
		'test_wp_version_check_attached' {
			return this.test_wp_version_check_attached()
		}
		'test_filters_automatic_updater_disabled' {
			return this.test_filters_automatic_updater_disabled()
		}
		'test_wp_automatic_updates_disabled' {
			return this.test_wp_automatic_updates_disabled()
		}
		'test_if_failed_update' {
			return this.test_if_failed_update()
		}
		'test_vcs_abspath' {
			return this.test_vcs_abspath()
		}
		'test_check_wp_filesystem_method' {
			return this.test_check_wp_filesystem_method()
		}
		'test_all_files_writable' {
			return this.test_all_files_writable()
		}
		'test_accepts_dev_updates' {
			return this.test_accepts_dev_updates()
		}
		'test_accepts_minor_updates' {
			return this.test_accepts_minor_updates()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Site_Health_Auto_Updates) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Site_Health_Auto_Updates) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Automatic_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Automatic_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Automatic_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automatic_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automatic_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automatic_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
