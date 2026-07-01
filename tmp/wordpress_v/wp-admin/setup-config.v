import rt

const global_const_wp_installing = true
const global_const_wp_setup_config = true
fn setup_config_display_header(var_body_classes rt.PhpVal) {
	var_body_classes = rt.cast_array(var_body_classes)
	var_body_classes.array_push('wp-core-ui')
	var_body_classes.array_push('admin-color-modern')
	mut var_dir_attr := ''
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
	rt.echo_val(rt.call_function('implode', [rt.new_string(' '), var_body_classes.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('WordPress')])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Locale {
	rt.PhpObjectBase
}

fn create_wp_locale() &Class_WP_Locale {
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
		rt.call_function('define', [rt.new_string('ABSPATH'), (rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/'])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-settings.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/upgrade.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/translation-install.php', '4')
	rt.call_function('nocache_headers', []rt.PhpVal{})
	if rt.is_true(rt.call_function('file_exists', [(rt.get_constant('ABSPATH')).str() + 'wp-config-sample.php'])) {
		mut var_config_file := rt.call_function('file', [(rt.get_constant('ABSPATH')).str() + 'wp-config-sample.php'])
	} else if rt.is_true(rt.call_function('file_exists', [(rt.call_function('dirname', [rt.get_constant('ABSPATH')])).str() + '/wp-config-sample.php'])) {
		var_config_file = rt.call_function('file', [(rt.call_function('dirname', [rt.get_constant('ABSPATH')])).str() + '/wp-config-sample.php'])
	} else {
		rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sorry, I need a %s file to work from. Please re-upload this file to your WordPress installation.')]), rt.new_string('<code>wp-config-sample.php</code>')])])
	}
	if rt.is_true(rt.call_function('file_exists', [(rt.get_constant('ABSPATH')).str() + 'wp-config.php'])) {
		rt.call_function('wp_die', ['<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The file %1$s already exists. If you need to reset any of the configuration items in this file, please delete it first. You may try <a href="%2$s">installing now</a>.')]), rt.new_string('<code>wp-config.php</code>'), rt.new_string('install.php')])).str() + '</p>', rt.new_int(409)])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('file_exists', [(rt.get_constant('ABSPATH')).str() + '../wp-config.php'])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [(rt.get_constant('ABSPATH')).str() + '../wp-settings.php']))))))) {
		rt.call_function('wp_die', ['<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The file %1$s already exists one level above your WordPress installation. If you need to reset any of the configuration items in this file, please delete it first. You may try <a href="%2$s">installing now</a>.')]), rt.new_string('<code>wp-config.php</code>'), rt.new_string('install.php')])).str() + '</p>', rt.new_int(409)])
	}
	mut var_step := if rt.get_superglobal('_GET').array_isset(rt.new_string('step')) { // unsupported expression: Expr_Cast_Int } else { // unsupported expression: Expr_UnaryMinus }
	mut var_language := rt.new_string(rt.new_string(''))
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('language'))) {
		var_language = rt.call_function('preg_replace', [rt.new_string('/[^a-zA-Z0-9_]/'), rt.new_string(''), rt.get_superglobal('_REQUEST').array_get('language')])
	} else if var_GLOBALS.array_isset(rt.new_string('wp_local_package')) {
		var_language = var_GLOBALS.array_get('wp_local_package')
	}
	mut switch_val_1 := var_step
	if rt.is_true(rt.equal(switch_val_1, // unsupported expression: Expr_UnaryMinus)) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wp_can_install_language_pack', []rt.PhpVal{})) && !rt.is_true(var_language))) {
			mut var_languages := rt.call_function('wp_get_available_translations', []rt.PhpVal{})
			if rt.is_true(var_languages) {
				setup_config_display_header(rt.new_string('language-chooser'))
				print('<h1 class="screen-reader-text">Select a default language</h1>')
				print('<form id="setup" method="post" action="?step=0">')
				rt.call_function('wp_install_language_form', [var_languages.dup()])
				print('</form>')
				break
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) {
		if !(!rt.is_true(var_language)) {
			mut var_loaded_language := rt.call_function('wp_download_language_pack', [var_language.dup()])
			if rt.is_true(var_loaded_language) {
				rt.call_function('load_default_textdomain', [var_loaded_language.dup()])
				var_GLOBALS.array_set('wp_locale', create_wp_locale())
			}
		}
		setup_config_display_header(rt.new_null())
		mut var_step_1 := 'setup-config.php?step=1'
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('noapi')) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		if !(!rt.is_true(var_loaded_language)) {
			// unsupported expression: Expr_AssignOp_Concat
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
		rt.call_function('load_default_textdomain', [var_language.dup()])
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
		
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	}
}
