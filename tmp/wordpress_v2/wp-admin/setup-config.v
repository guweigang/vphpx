import rt

const global_const_wp_installing = true
const global_const_wp_setup_config = true
mut var_step := rt.new_int(if rt.get_superglobal('_GET').array_isset(rt.new_string('step')) { rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('step'))).to_i64()) } else { -1 })
fn setup_config_display_header(var_body_classes_arg rt.PhpVal) {
	mut var_body_classes := var_body_classes_arg
	mut var_dir_attr := ''
	var_body_classes = rt.cast_array(var_body_classes)
	var_body_classes.array_push('wp-core-ui')
	var_body_classes.array_push('admin-color-modern')
	var_dir_attr = ''
	if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		var_body_classes.array_push('rtl')
	var_dir_attr = ' dir="rtl"'
	}
	rt.call_function('header', [rt.new_string('Content-Type: text/html; charset=utf-8')])
	// unsupported statement: Stmt_InlineHTML
	print(var_dir_attr)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('WordPress &rsaquo; Setup Configuration File')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_css', [rt.new_string('install'), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('implode', [rt.new_string(' '), var_body_classes.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('WordPress')])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Locale {
	rt.PhpObjectBase
}

fn create_wp_locale(_args ...rt.PhpVal) &Class_WP_Locale {
	mut obj := &Class_WP_Locale{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Locale) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Locale) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Locale) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	mut var_GLOBALS := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_match := rt.new_null()
	rt.call_function('error_reporting', [rt.new_int(0)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		rt.call_function('define', [rt.new_string('ABSPATH'), rt.new_string((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/')])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-settings.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/upgrade.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/translation-install.php', '4')
	rt.call_function('nocache_headers', []rt.PhpVal{})
	if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-config-sample.php')])) {
	mut var_config_file := rt.call_function('file', [rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-config-sample.php')])
	} else if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.call_function('dirname', [rt.get_constant('ABSPATH')])).str() + '/wp-config-sample.php')])) {
	var_config_file = rt.call_function('file', [rt.new_string((rt.call_function('dirname', [rt.get_constant('ABSPATH')])).str() + '/wp-config-sample.php')])
	} else {
		rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sorry, I need a %s file to work from. Please re-upload this file to your WordPress installation.')]), rt.new_string('<code>wp-config-sample.php</code>')])])
	}
	if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-config.php')])) {
		rt.call_function('wp_die', [rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The file %1$s already exists. If you need to reset any of the configuration items in this file, please delete it first. You may try <a href="%2$s">installing now</a>.')]), rt.new_string('<code>wp-config.php</code>'), rt.new_string('install.php')])).str() + '</p>'), rt.new_int(409)])
	}
	if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('ABSPATH')).str() + '../wp-config.php')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('ABSPATH')).str() + '../wp-settings.php')]))))) {
		rt.call_function('wp_die', [rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The file %1$s already exists one level above your WordPress installation. If you need to reset any of the configuration items in this file, please delete it first. You may try <a href="%2$s">installing now</a>.')]), rt.new_string('<code>wp-config.php</code>'), rt.new_string('install.php')])).str() + '</p>'), rt.new_int(409)])
	}
	mut var_language := rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('language')))) {
	var_language = rt.call_function('preg_replace', [rt.new_string('/[^a-zA-Z0-9_]/'), rt.new_string(''), rt.get_superglobal('_REQUEST').array_get(rt.new_string('language'))])
	} else if var_GLOBALS.array_isset(rt.new_string('wp_local_package')) {
	var_language = var_GLOBALS.array_get(rt.new_string('wp_local_package'))
	}
	mut switch_val_1 := var_step
	if rt.is_true(rt.equal(switch_val_1, -1)) {
		if rt.is_true(rt.call_function('wp_can_install_language_pack', []rt.PhpVal{})) && !rt.is_true(var_language) {
			mut var_languages := rt.call_function('wp_get_available_translations', []rt.PhpVal{})
			if rt.is_true(var_languages) {
				setup_config_display_header(rt.new_string('language-chooser'))
				print('<h1 class="screen-reader-text">Select a default language</h1>')
				print('<form id="setup" method="post" action="?step=0">')
				rt.call_function('wp_install_language_form', [var_languages.clone()])
				print('</form>')
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) {
		if !(!rt.is_true(var_language)) {
			mut var_loaded_language := rt.call_function('wp_download_language_pack', [var_language.clone()])
			if rt.is_true(var_loaded_language) {
				rt.call_function('load_default_textdomain', [var_loaded_language.clone()])
				var_GLOBALS.array_set('wp_locale', create_wp_locale())
			}
		}
		setup_config_display_header(rt.new_null())
		mut var_step_1 := 'setup-config.php?step=1'
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('noapi')) {
			var_step_1 = var_step_1 + '&amp;noapi'
		}
		if !(!rt.is_true(var_loaded_language)) {
			var_step_1 = var_step_1 + '&amp;language=' + (var_loaded_language).str()
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Before getting started')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Welcome to WordPress. Before getting started, you will need to know the following items.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Database name')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Database username')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Database password')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Database host')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Table prefix (if you want to run more than one WordPress in a single database)')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('This information is being used to create a %s file.')]), rt.new_string('<code>wp-config.php</code>')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('If for any reason this automatic file creation does not work, do not worry. All this does is fill in the database information to a configuration file. You may also simply open %1$s in a text editor, fill in your information, and save it as %2$s.')]), rt.new_string('<code>wp-config-sample.php</code>'), rt.new_string('<code>wp-config.php</code>')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('Need more help? <a href="%1$s">Read the support article on %2$s</a>.')]), rt.call_function('__', [rt.new_string('https://developer.wordpress.org/advanced-administration/wordpress/wp-config/')]), rt.new_string('<code>wp-config.php</code>')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('In all likelihood, these items were supplied to you by your web host. If you do not have this information, then you will need to contact them before you can continue. If you are ready&hellip;')])
		// unsupported statement: Stmt_InlineHTML
		print(var_step_1)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Let&#8217;s go!')])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		rt.call_function('load_default_textdomain', [var_language.clone()])
		var_GLOBALS.array_set('wp_locale', create_wp_locale())
		setup_config_display_header(rt.new_null())
		mut var_autofocus := if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) { '' } else { ' autofocus' }
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Set up your database connection')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Below you should enter your database connection details. If you are not sure about these, contact your host.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Database Name')])
		// unsupported statement: Stmt_InlineHTML
		print(var_autofocus)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('The name of the database you want to use with WordPress.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Username')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('htmlspecialchars', [rt.call_function('_x', [rt.new_string('username'), rt.new_string('example username')]), rt.get_constant('ENT_QUOTES')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Your database username.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Password')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('htmlspecialchars', [rt.call_function('_x', [rt.new_string('password'), rt.new_string('example password')]), rt.get_constant('ENT_QUOTES')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Show password')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Show')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Your database password.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Database Host')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('You should be able to get this info from your web host, if %s does not work.')]), rt.new_string('<code>localhost</code>')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Table Prefix')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('If you want to run multiple WordPress installations in a single database, change this.')])
		// unsupported statement: Stmt_InlineHTML
		if rt.get_superglobal('_GET').array_isset(rt.new_string('noapi')) {
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_language.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('htmlspecialchars', [rt.call_function('__', [rt.new_string('Submit')]), rt.get_constant('ENT_QUOTES')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_print_scripts', [rt.new_string('password-toggle')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
		rt.call_function('load_default_textdomain', [var_language.clone()])
		var_GLOBALS.array_set('wp_locale', create_wp_locale())
		mut var_dbname := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('dbname'))]).to_string().trim_space()
		mut var_uname := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('uname'))]).to_string().trim_space()
		mut var_pwd := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('pwd'))]).to_string().trim_space()
		mut var_dbhost := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('dbhost'))]).to_string().trim_space()
		mut var_prefix := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('prefix'))]).to_string().trim_space()
		var_step_1 = 'setup-config.php?step=1'
		mut var_install := 'install.php'
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('noapi')) {
			var_step_1 = var_step_1 + '&amp;noapi'
		}
		if !(!rt.is_true(var_language)) {
			var_step_1 = var_step_1 + '&amp;language=' + (var_language).str()
			var_install = var_install + '?language=' + (var_language).str()
		} else {
			var_install = var_install + '?language=en_US'
		}
		mut var_tryagain_link := rt.new_string('</p><p class="step"><a href="' + var_step_1 + '" onclick="javascript:history.go(-1);return false;" class="button button-large">' + (rt.call_function('__', [rt.new_string('Try Again')])).str() + '</a>')
		if var_prefix == '' {
			rt.call_function('wp_die', [rt.new_string((rt.call_function('__', [rt.new_string('<strong>Error:</strong> "Table Prefix" must not be empty.')])).str() + (var_tryagain_link).str())])
		}
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('|[^a-z0-9_]|i'), rt.new_string((var_prefix).str()).clone()])) {
			rt.call_function('wp_die', [rt.new_string((rt.call_function('__', [rt.new_string('<strong>Error:</strong> "Table Prefix" can only contain numbers, letters, and underscores.')])).str() + (var_tryagain_link).str())])
		}
		rt.call_function('define', [rt.new_string('DB_NAME'), rt.new_string((var_dbname).str()).clone()])
		rt.call_function('define', [rt.new_string('DB_USER'), rt.new_string((var_uname).str()).clone()])
		rt.call_function('define', [rt.new_string('DB_PASSWORD'), rt.new_string((var_pwd).str()).clone()])
		rt.call_function('define', [rt.new_string('DB_HOST'), rt.new_string((var_dbhost).str()).clone()])
		var_wpdb = rt.new_null()
		rt.call_function('require_wp_db', []rt.PhpVal{})
		rt.call_method(var_wpdb, 'db_connect', []rt.PhpVal{})
		if !(!rt.is_true(rt.get_property(var_wpdb, 'error'))) {
			rt.call_function('wp_die', [rt.new_string((rt.call_method(rt.get_property(var_wpdb, 'error'), 'get_error_message', []rt.PhpVal{})).str() + (var_tryagain_link).str())])
		}
		mut var_errors := rt.call_method(var_wpdb, 'suppress_errors', []rt.PhpVal{})
		rt.call_method(var_wpdb, 'query', [rt.new_string("SELECT ${var_prefix}")])
		rt.call_method(var_wpdb, 'suppress_errors', [var_errors.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_wpdb, 'last_error'))))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('<strong>Error:</strong> "Table Prefix" is invalid.')])])
		}
		mut var_chars := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_ []{}<>~`+=,.;:/?|'
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_max := var_chars.len - 1
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_i := 0
		for {
			if !(var_i < 8) { break }
			mut var_key := rt.new_string('')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			mut var_j := 0
			for {
				if !(var_j < 64) { break }
				var_key = rt.concat(var_key, rt.call_function('substr', [rt.new_string((var_chars).str()).clone(), rt.call_function('random_int', [rt.new_int(0), rt.new_int(var_max).clone()]), rt.new_int(1)]))
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				var_j += 1
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			var_secret_keys.array_push(var_key.clone())
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			var_i += 1
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_ex := var_e_1.clone()
			mut var_no_api := rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('noapi')))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_no_api)))) {
			mut var_secret_keys := rt.call_function('wp_remote_get', [rt.new_string('https://api.wordpress.org/secret-key/1.1/salt/')])
			}
			if rt.is_true(var_no_api) || rt.is_true(rt.call_function('is_wp_error', [var_secret_keys.clone()])) {
				var_secret_keys = rt.new_array()
				mut var_i := 0
				for {
					if !(var_i < 8) { break }
					var_secret_keys.array_push(rt.call_function('wp_generate_password', [rt.new_int(64), rt.new_bool(true), rt.new_bool(true)]))
					var_i += 1
				}
			} else {
				var_secret_keys = rt.call_function('explode', [rt.new_string('\n'), rt.call_function('wp_remote_retrieve_body', [var_secret_keys.clone()])])
				mut iter_1 := var_secret_keys.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_v := item_1.val
					mut var_k := item_1.key
					var_secret_keys.array_set(var_k, rt.call_function('substr', [var_v.clone(), rt.new_int(28), rt.new_int(64)]))
				}
			}
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
		mut var_key := rt.new_int(0)
		mut iter_2 := var_config_file.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_line := item_2.val
			mut var_line_num := item_2.key
			if rt.is_true(rt.call_function('str_starts_with', [var_line.clone(), rt.new_string('$table_prefix =')])) {
				var_config_file.array_set(var_line_num, '$table_prefix = \'' + (rt.call_function('addcslashes', [rt.new_string((var_prefix).str()).clone(), rt.new_string('\\\'')])).str() + '\';\r\n')
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^define\\(\\s*\'([A-Z_]+)\',([ ]+)/'), var_line.clone(), var_match.clone()]))))) {
				continue
			}
			mut var_constant := var_match.array_get(rt.new_int(1))
			mut var_padding := var_match.array_get(rt.new_int(2))
			mut switch_val_2 := var_constant
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('DB_NAME'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('DB_USER'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('DB_PASSWORD'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('DB_HOST'))) {
				var_config_file.array_set(var_line_num, 'define( \'' + (var_constant).str() + '\',' + (var_padding).str() + '\'' + (rt.call_function('addcslashes', [rt.call_function('constant', [var_constant.clone()]), rt.new_string('\\\'')])).str() + '\' );\r\n')
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('DB_CHARSET'))) {
				if rt.is_true(rt.identical(rt.new_string('utf8mb4'), rt.get_property(var_wpdb, 'charset'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_wpdb, 'charset'))))) {
					var_config_file.array_set(var_line_num, 'define( \'' + (var_constant).str() + '\',' + (var_padding).str() + '\'utf8mb4\' );\r\n')
				}
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('AUTH_KEY'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('SECURE_AUTH_KEY'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('LOGGED_IN_KEY'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('NONCE_KEY'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('AUTH_SALT'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('SECURE_AUTH_SALT'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('LOGGED_IN_SALT'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('NONCE_SALT'))) {
				var_config_file.array_set(var_line_num, 'define( \'' + (var_constant).str() + '\',' + (var_padding).str() + '\'' + (var_secret_keys.array_get(rt.post_inc(var_key))).str() + '\' );\r\n')
			}
		}
		var_line = rt.new_null()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [rt.get_constant('ABSPATH')]))))) {
			setup_config_display_header(rt.new_null())
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.call_function('__', [rt.new_string('Unable to write to %s file.')]), rt.new_string('<code>wp-config.php</code>')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.call_function('__', [rt.new_string('You can create the %s file manually and paste the following text into it.')]), rt.new_string('<code>wp-config.php</code>')])
			mut var_config_text := ''
			mut iter_3 := var_config_file.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_line := item_3.val
				var_config_text = var_config_text + (rt.call_function('htmlentities', [var_line.clone(), rt.get_constant('ENT_COMPAT'), rt.new_string('UTF-8')])).str()
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.call_function('__', [rt.new_string('Configuration rules for %s:')]), rt.new_string('<code>wp-config.php</code>')])
			// unsupported statement: Stmt_InlineHTML
			print(var_config_text)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('After you&#8217;ve done that, click &#8220;Run the installation&#8221;.')])
			// unsupported statement: Stmt_InlineHTML
			print(var_install)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Run the installation')])
			// unsupported statement: Stmt_InlineHTML
		} else {
			if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-config-sample.php')])) {
			mut var_path_to_wp_config := rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-config.php')
			} else {
			var_path_to_wp_config = rt.new_string((rt.call_function('dirname', [rt.get_constant('ABSPATH')])).str() + '/wp-config.php')
			}
			mut var_error_message := rt.new_string('')
			mut var_handle := rt.call_function('fopen', [var_path_to_wp_config.clone(), rt.new_string('w')])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_handle)))) {
				mut iter_4 := var_config_file.iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_line := item_4.val
					rt.call_function('fwrite', [var_handle.clone(), var_line.clone()])
				}
				rt.call_function('fclose', [var_handle.clone()])
			} else {
				mut var_wp_config_perms := rt.call_function('fileperms', [var_path_to_wp_config.clone()])
				if !(!rt.is_true(var_wp_config_perms)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [var_path_to_wp_config.clone()]))))) {
				var_error_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You need to make the file %1$s writable before you can save your changes. See <a href="%2$s">Changing File Permissions</a> for more information.')]), rt.new_string('<code>wp-config.php</code>'), rt.call_function('__', [rt.new_string('https://developer.wordpress.org/advanced-administration/server/file-permissions/')])])
				} else {
				var_error_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to write to %s file.')]), rt.new_string('<code>wp-config.php</code>')])
				}
			}
			rt.call_function('chmod', [var_path_to_wp_config.clone(), rt.new_int(438)])
			setup_config_display_header(rt.new_null())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_handle)))) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Successful database connection')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('All right, sparky! You&#8217;ve made it through this part of the installation. WordPress can now communicate with your database. If you are ready, time now to&hellip;')])
				// unsupported statement: Stmt_InlineHTML
				print(var_install)
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Run the installation')])
				// unsupported statement: Stmt_InlineHTML
			} else {
				rt.call_function('printf', [rt.new_string('<p>%s</p>'), var_error_message.clone()])
			}
		}
	}
	rt.call_function('wp_print_scripts', [rt.new_string('language-chooser')])
	// unsupported statement: Stmt_InlineHTML
}
