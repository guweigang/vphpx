import rt
import crypto.md5

mut var_wp_file_descriptions := rt.create_array([rt.ArrayItem{ key: 'functions.php', val: rt.call_function('__', [rt.new_string('Theme Functions')]) }, rt.ArrayItem{ key: 'header.php', val: rt.call_function('__', [rt.new_string('Theme Header')]) }, rt.ArrayItem{ key: 'footer.php', val: rt.call_function('__', [rt.new_string('Theme Footer')]) }, rt.ArrayItem{ key: 'sidebar.php', val: rt.call_function('__', [rt.new_string('Sidebar')]) }, rt.ArrayItem{ key: 'comments.php', val: rt.call_function('__', [rt.new_string('Comments')]) }, rt.ArrayItem{ key: 'searchform.php', val: rt.call_function('__', [rt.new_string('Search Form')]) }, rt.ArrayItem{ key: '404.php', val: rt.call_function('__', [rt.new_string('404 Template')]) }, rt.ArrayItem{ key: 'link.php', val: rt.call_function('__', [rt.new_string('Links Template')]) }, rt.ArrayItem{ key: 'theme.json', val: rt.call_function('__', [rt.new_string('Theme Styles & Block Settings')]) }, rt.ArrayItem{ key: 'index.php', val: rt.call_function('__', [rt.new_string('Main Index Template')]) }, rt.ArrayItem{ key: 'archive.php', val: rt.call_function('__', [rt.new_string('Archives')]) }, rt.ArrayItem{ key: 'author.php', val: rt.call_function('__', [rt.new_string('Author Template')]) }, rt.ArrayItem{ key: 'taxonomy.php', val: rt.call_function('__', [rt.new_string('Taxonomy Template')]) }, rt.ArrayItem{ key: 'category.php', val: rt.call_function('__', [rt.new_string('Category Template')]) }, rt.ArrayItem{ key: 'tag.php', val: rt.call_function('__', [rt.new_string('Tag Template')]) }, rt.ArrayItem{ key: 'home.php', val: rt.call_function('__', [rt.new_string('Posts Page')]) }, rt.ArrayItem{ key: 'search.php', val: rt.call_function('__', [rt.new_string('Search Results')]) }, rt.ArrayItem{ key: 'date.php', val: rt.call_function('__', [rt.new_string('Date Template')]) }, rt.ArrayItem{ key: 'singular.php', val: rt.call_function('__', [rt.new_string('Singular Template')]) }, rt.ArrayItem{ key: 'single.php', val: rt.call_function('__', [rt.new_string('Single Post')]) }, rt.ArrayItem{ key: 'page.php', val: rt.call_function('__', [rt.new_string('Single Page')]) }, rt.ArrayItem{ key: 'front-page.php', val: rt.call_function('__', [rt.new_string('Homepage')]) }, rt.ArrayItem{ key: 'privacy-policy.php', val: rt.call_function('__', [rt.new_string('Privacy Policy Page')]) }, rt.ArrayItem{ key: 'attachment.php', val: rt.call_function('__', [rt.new_string('Attachment Template')]) }, rt.ArrayItem{ key: 'image.php', val: rt.call_function('__', [rt.new_string('Image Attachment Template')]) }, rt.ArrayItem{ key: 'video.php', val: rt.call_function('__', [rt.new_string('Video Attachment Template')]) }, rt.ArrayItem{ key: 'audio.php', val: rt.call_function('__', [rt.new_string('Audio Attachment Template')]) }, rt.ArrayItem{ key: 'application.php', val: rt.call_function('__', [rt.new_string('Application Attachment Template')]) }, rt.ArrayItem{ key: 'embed.php', val: rt.call_function('__', [rt.new_string('Embed Template')]) }, rt.ArrayItem{ key: 'embed-404.php', val: rt.call_function('__', [rt.new_string('Embed 404 Template')]) }, rt.ArrayItem{ key: 'embed-content.php', val: rt.call_function('__', [rt.new_string('Embed Content Template')]) }, rt.ArrayItem{ key: 'header-embed.php', val: rt.call_function('__', [rt.new_string('Embed Header Template')]) }, rt.ArrayItem{ key: 'footer-embed.php', val: rt.call_function('__', [rt.new_string('Embed Footer Template')]) }, rt.ArrayItem{ key: 'style.css', val: rt.call_function('__', [rt.new_string('Stylesheet')]) }, rt.ArrayItem{ key: 'editor-style.css', val: rt.call_function('__', [rt.new_string('Visual Editor Stylesheet')]) }, rt.ArrayItem{ key: 'editor-style-rtl.css', val: rt.call_function('__', [rt.new_string('Visual Editor RTL Stylesheet')]) }, rt.ArrayItem{ key: 'rtl.css', val: rt.call_function('__', [rt.new_string('RTL Stylesheet')]) }, rt.ArrayItem{ key: 'my-hacks.php', val: rt.call_function('__', [rt.new_string('my-hacks.php (legacy hacks support)')]) }, rt.ArrayItem{ key: '.htaccess', val: rt.call_function('__', [rt.new_string('.htaccess (for rewrite rules )')]) }, rt.ArrayItem{ key: 'wp-layout.css', val: rt.call_function('__', [rt.new_string('Stylesheet')]) }, rt.ArrayItem{ key: 'wp-comments.php', val: rt.call_function('__', [rt.new_string('Comments Template')]) }, rt.ArrayItem{ key: 'wp-comments-popup.php', val: rt.call_function('__', [rt.new_string('Popup Comments Template')]) }, rt.ArrayItem{ key: 'comments-popup.php', val: rt.call_function('__', [rt.new_string('Popup Comments')]) }])
fn get_file_description(var_file rt.PhpVal) string {
	mut var_wp_file_descriptions := rt.new_null()
	mut var_allowed_files := rt.new_null()
	mut var_name := []rt.PhpVal{}
	mut var_dirname := rt.new_null()
	mut var_file_path := rt.new_null()
	mut var_template_data := rt.new_null()
	var_dirname = rt.call_function('pathinfo', [var_file.clone(), rt.get_constant('PATHINFO_DIRNAME')])
	var_file_path = var_allowed_files.array_get(var_file)
	if var_wp_file_descriptions.array_isset(rt.call_function('basename', [var_file.clone()])) && rt.is_true(rt.identical(rt.new_string('.'), var_dirname)) {
		return (var_wp_file_descriptions.array_get(rt.call_function('basename', [var_file.clone()]))).str()
	} else if rt.is_true(rt.call_function('file_exists', [var_file_path.clone()])) && rt.is_true(rt.call_function('is_file', [var_file_path.clone()])) {
		var_template_data = rt.call_function('implode', [rt.new_string(''), rt.call_function('file', [var_file_path.clone()])])
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('|Template Name:(.*)$|mi'), var_template_data.clone(), rt.create_array_from_list(var_name)])) {
			return (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s Page Template')]), rt.call_function('_cleanup_header_comment', [var_name[1]])])).str()
		}
	}
	return rt.call_function('basename', [var_file.clone()]).to_string().trim_space()
}

fn get_home_path() rt.PhpVal {
	mut var_home := rt.new_null()
	mut var_siteurl := rt.new_null()
	mut var_wp_path_rel_to_home := rt.new_null()
	mut var_pos := rt.new_null()
	mut var_home_path := rt.new_null()
	var_home = rt.call_function('set_url_scheme', [rt.call_function('get_option', [rt.new_string('home')]), rt.new_string('http')])
	var_siteurl = rt.call_function('set_url_scheme', [rt.call_function('get_option', [rt.new_string('siteurl')]), rt.new_string('http')])
	if !(!rt.is_true(var_home)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [var_home.clone(), var_siteurl.clone()]))))) {
	var_wp_path_rel_to_home = rt.call_function('str_ireplace', [var_home.clone(), rt.new_string(''), var_siteurl.clone()])
	var_pos = rt.call_function('strripos', [rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), rt.get_superglobal('_SERVER').array_get(rt.new_string('SCRIPT_FILENAME'))]), rt.call_function('trailingslashit', [var_wp_path_rel_to_home.clone()])])
	var_home_path = rt.call_function('substr', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SCRIPT_FILENAME')), rt.new_int(0), var_pos.clone()])
	var_home_path = rt.call_function('trailingslashit', [var_home_path.clone()])
	} else {
	var_home_path = rt.get_constant('ABSPATH')
	}
	return rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), var_home_path.clone()])
}

fn list_files(folder string, levels i64, var_exclusions rt.PhpVal, include_hidden bool) bool {
	mut var_folder := folder
	mut var_levels := levels
	mut var_include_hidden := include_hidden
	mut var_files := rt.new_null()
	mut var_dir := rt.new_null()
	mut var_file := rt.new_null()
	mut var_files2 := rt.new_null()
	if var_folder == '' {
		return false
	}
	var_folder = (rt.call_function('trailingslashit', [rt.new_string((var_folder).str())])).str()
	if !(var_levels != 0) {
		return false
	}
	var_files = rt.new_array()
	var_dir = rt.call_function('opendir', [rt.new_string((var_folder).str())])
	if rt.is_true(var_dir) {
		var_file = rt.call_function('readdir', [var_dir.clone()])
		for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_file, rt.new_bool(false))))) {
			if rt.is_true(rt.call_function('in_array', [var_file.clone(), rt.create_array([rt.ArrayItem{ key: none, val: '.' }, rt.ArrayItem{ key: none, val: '..' }]), rt.new_bool(true)])) {
				continue
			}
			if (!(var_include_hidden) && rt.is_true(rt.identical(rt.new_string('.'), var_file.array_get(rt.new_int(0))))) || rt.is_true(rt.call_function('in_array', [var_file.clone(), var_exclusions.clone(), rt.new_bool(true)])) {
				continue
			}
			if rt.is_true(rt.call_function('is_dir', [rt.new_string(var_folder + (var_file).str())])) {
				var_files2 = rt.new_bool(list_files(var_folder + (var_file).str(), levels - 1, rt.new_array(), include_hidden))
				if rt.is_true(var_files2) {
				var_files = rt.call_function('array_merge', [var_files.clone(), var_files2.clone()])
				} else {
					var_files.array_push(var_folder + (var_file).str() + '/')
				}
			} else {
				var_files.array_push(var_folder + (var_file).str())
			}
		}
		rt.call_function('closedir', [var_dir.clone()])
	}
	return (var_files).to_bool()
}

fn wp_get_plugin_file_editable_extensions(var_plugin rt.PhpVal) rt.PhpVal {
	mut var_default_types := []rt.PhpVal{}
	mut var_file_types := rt.new_null()
	var_default_types = ['bash', 'conf', 'css', 'diff', 'htm', 'html', 'http', 'inc', 'include', 'js', 'mjs', 'json', 'jsx', 'less', 'md', 'patch', 'php', 'php3', 'php4', 'php5', 'php7', 'phps', 'phtml', 'sass', 'scss', 'sh', 'sql', 'svg', 'text', 'txt', 'xml', 'yaml', 'yml']
	var_file_types = rt.cast_array(rt.call_function('apply_filters', [rt.new_string('editable_extensions'), rt.create_array_from_list(var_default_types), var_plugin.clone()]))
	return var_file_types.clone()
}

fn wp_get_theme_file_editable_extensions(var_theme rt.PhpVal) rt.PhpVal {
	mut var_default_types := []rt.PhpVal{}
	mut var_file_types := rt.new_null()
	var_default_types = ['bash', 'conf', 'css', 'diff', 'htm', 'html', 'http', 'inc', 'include', 'js', 'mjs', 'json', 'jsx', 'less', 'md', 'patch', 'php', 'php3', 'php4', 'php5', 'php7', 'phps', 'phtml', 'sass', 'scss', 'sh', 'sql', 'svg', 'text', 'txt', 'xml', 'yaml', 'yml']
	var_file_types = rt.call_function('apply_filters', [rt.new_string('wp_theme_editor_filetypes'), rt.create_array_from_list(var_default_types), var_theme.clone()])
	return rt.call_function('array_unique', [rt.call_function('array_merge', [var_file_types.clone(), rt.create_array_from_list(var_default_types)])])
}

fn wp_print_file_editor_templates() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Your PHP code changes were not applied due to an error on line %1$s of file %2$s. Please fix and try saving again.')]), rt.new_string('{{ data.line }}'), rt.new_string('{{ data.file }}')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('You need to make this file writable before you can save your changes. See <a href="%s">Changing File Permissions</a> for more information.')]), rt.call_function('__', [rt.new_string('https://developer.wordpress.org/advanced-administration/server/file-permissions/')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Update anyway, even though it might break your site?')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Dismiss')])
	// unsupported statement: Stmt_InlineHTML
}

fn wp_edit_theme_plugin_file(var_args rt.PhpVal) bool {
	mut var_matches := []rt.PhpVal{}
	mut var_file := rt.new_null()
	mut var_content := rt.new_null()
	mut var_plugin := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_real_file := rt.new_null()
	mut var_editable_extensions := rt.new_null()
	mut var_is_active := rt.new_null()
	mut var_stylesheet := rt.new_null()
	mut var_allowed_files := rt.new_null()
	mut var_type := rt.new_null()
	mut var_style_files := rt.new_null()
	mut var_extension := rt.new_null()
	mut var_previous_content := rt.new_null()
	mut var_f := rt.new_null()
	mut var_written := rt.new_null()
	mut var_scrape_key := ''
	mut var_transient := rt.new_null()
	mut var_scrape_nonce := rt.new_null()
	mut var_cookies := rt.new_null()
	mut var_scrape_params := map[string]rt.PhpVal{}
	mut var_headers := map[string]rt.PhpVal{}
	mut var_sslverify := rt.new_null()
	mut var_timeout := i64(0)
	mut var_needle_start := ''
	mut var_needle_end := ''
	mut var_url := rt.new_null()
	mut var_r := rt.new_null()
	mut var_body := rt.new_null()
	mut var_scrape_result_position := rt.new_null()
	mut var_loopback_request_failure := map[string]rt.PhpVal{}
	mut var_json_parse_failure := map[string]rt.PhpVal{}
	mut var_result := rt.new_null()
	mut var_error_output := rt.new_null()
	mut var_message := rt.new_null()
	if !rt.is_true(var_args.array_get(rt.new_string('file'))) {
		return (create_wp_error(rt.new_string('missing_file'))).to_bool()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_args.array_get(rt.new_string('file'))]))))) {
		return (create_wp_error(rt.new_string('bad_file'))).to_bool()
	}
	if !(var_args.array_isset(rt.new_string('newcontent'))) {
		return (create_wp_error(rt.new_string('missing_content'))).to_bool()
	}
	if !(var_args.array_isset(rt.new_string('nonce'))) {
		return (create_wp_error(rt.new_string('missing_nonce'))).to_bool()
	}
	var_file = var_args.array_get(rt.new_string('file'))
	var_content = var_args.array_get(rt.new_string('newcontent'))
	var_plugin = rt.new_null()
	var_theme = rt.new_null()
	var_real_file = rt.new_null()
	if !(!rt.is_true(var_args.array_get(rt.new_string('plugin')))) {
		var_plugin = var_args.array_get(rt.new_string('plugin'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_plugins')]))))) {
			return (create_wp_error(rt.new_string('unauthorized'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit plugins for this site.')]))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_args.array_get(rt.new_string('nonce')), rt.new_string('edit-plugin_' + (var_file).str())]))))) {
			return (create_wp_error(rt.new_string('nonce_failure'))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_function('get_plugins', []rt.PhpVal{}).array_isset(var_plugin.clone())))))) {
			return (create_wp_error(rt.new_string('invalid_plugin'))).to_bool()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_file.clone(), rt.call_function('get_plugin_files', [var_plugin.clone()])]))))) {
			return (create_wp_error(rt.new_string('bad_plugin_file_path'), rt.call_function('__', [rt.new_string('Sorry, that file cannot be edited.')]))).to_bool()
		}
	var_editable_extensions = wp_get_plugin_file_editable_extensions(var_plugin.clone())
	var_real_file = rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_file).str())
	var_is_active = rt.call_function('in_array', [var_plugin.clone(), rt.cast_array(rt.call_function('get_option', [rt.new_string('active_plugins'), rt.new_array()])), rt.new_bool(true)])
	} else if !(!rt.is_true(var_args.array_get(rt.new_string('theme')))) {
		var_stylesheet = var_args.array_get(rt.new_string('theme'))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_stylesheet.clone()]))))) {
			return (create_wp_error(rt.new_string('bad_theme_path'))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_themes')]))))) {
			return (create_wp_error(rt.new_string('unauthorized'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit templates for this site.')]))).to_bool()
		}
		var_theme = rt.call_function('wp_get_theme', [var_stylesheet.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{}))))) {
			return (create_wp_error(rt.new_string('non_existent_theme'), rt.call_function('__', [rt.new_string('The requested theme does not exist.')]))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_args.array_get(rt.new_string('nonce')), rt.new_string('edit-theme_' + (var_stylesheet).str() + '_' + (var_file).str())]))))) {
			return (create_wp_error(rt.new_string('nonce_failure'))).to_bool()
		}
		if rt.is_true(rt.call_method(var_theme, 'errors', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_string('theme_no_stylesheet'), rt.call_method(rt.call_method(var_theme, 'errors', []rt.PhpVal{}), 'get_error_code', []rt.PhpVal{}))) {
			return (create_wp_error(rt.new_string('theme_no_stylesheet'), (rt.call_function('__', [rt.new_string('The requested theme does not exist.')])).str() + ' ' + (rt.call_method(rt.call_method(var_theme, 'errors', []rt.PhpVal{}), 'get_error_message', []rt.PhpVal{})).str())).to_bool()
		}
		var_editable_extensions = wp_get_theme_file_editable_extensions(var_theme.clone())
		var_allowed_files = rt.new_array()
		mut iter_1 := var_editable_extensions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type_shadow := item_1.val
			mut switch_val_1 := var_type_shadow
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('php'))) {
			var_allowed_files = rt.call_function('array_merge', [var_allowed_files.clone(), rt.call_method(var_theme, 'get_files', [rt.new_string('php'), rt.new_int(-1)])])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('css'))) {
				var_style_files = rt.call_method(var_theme, 'get_files', [rt.new_string('css'), rt.new_int(-1)])
				var_allowed_files.array_set('style.css', var_style_files.array_get(rt.new_string('style.css')))
			var_allowed_files = rt.call_function('array_merge', [var_allowed_files.clone(), var_style_files.clone()])
			} else {
			var_allowed_files = rt.call_function('array_merge', [var_allowed_files.clone(), rt.call_method(var_theme, 'get_files', [var_type_shadow.clone(), rt.new_int(-1)])])
			}
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_file.clone(), rt.func_array_keys(var_allowed_files.clone())]))))) {
			return (create_wp_error(rt.new_string('disallowed_theme_file'), rt.call_function('__', [rt.new_string('Sorry, that file cannot be edited.')]))).to_bool()
		}
	var_real_file = rt.new_string((rt.call_method(var_theme, 'get_stylesheet_directory', []rt.PhpVal{})).str() + '/' + (var_file).str())
	var_is_active = rt.new_bool(rt.is_true(rt.identical(rt.call_function('get_stylesheet', []rt.PhpVal{}), var_stylesheet)) || rt.is_true(rt.identical(rt.call_function('get_template', []rt.PhpVal{}), var_stylesheet)))
	} else {
		return (create_wp_error(rt.new_string('missing_theme_or_plugin'))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [var_real_file.clone()]))))) {
		return (create_wp_error(rt.new_string('file_does_not_exist'), rt.call_function('__', [rt.new_string('File does not exist! Please double check the name and try again.')]))).to_bool()
	}
	var_extension = rt.new_null()
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\.([^.]+)$/'), var_real_file.clone(), rt.create_array_from_list(var_matches)])) {
		var_extension = rt.new_string(var_matches[1].to_string().to_lower())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_extension.clone(), var_editable_extensions.clone(), rt.new_bool(true)]))))) {
			return (create_wp_error(rt.new_string('illegal_file_type'), rt.call_function('__', [rt.new_string('Files of this type are not editable.')]))).to_bool()
		}
	}
	var_previous_content = rt.call_function('file_get_contents', [var_real_file.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [var_real_file.clone()]))))) {
		return (create_wp_error(rt.new_string('file_not_writable'))).to_bool()
	}
	var_f = rt.call_function('fopen', [var_real_file.clone(), rt.new_string('w+')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_f)) {
		return (create_wp_error(rt.new_string('file_not_writable'))).to_bool()
	}
	var_written = rt.call_function('fwrite', [var_f.clone(), var_content.clone()])
	rt.call_function('fclose', [var_f.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_written)) {
		return (create_wp_error(rt.new_string('unable_to_write'), rt.call_function('__', [rt.new_string('Unable to write to file.')]))).to_bool()
	}
	rt.new_bool(wp_opcache_invalidate(var_real_file.clone(), true))
	if rt.is_true(var_is_active) && rt.is_true(rt.identical(rt.new_string('php'), var_extension)) {
		var_scrape_key = md5.hexhash(rt.call_function('rand', []rt.PhpVal{}).to_string())
		var_transient = rt.new_string('scrape_key_' + var_scrape_key)
		var_scrape_nonce = rt.new_string((rt.call_function('rand', []rt.PhpVal{})).str())
		rt.call_function('set_transient', [var_transient.clone(), var_scrape_nonce.clone(), rt.new_int(60)])
		var_cookies = rt.call_function('wp_unslash', [rt.get_superglobal('_COOKIE').clone()])
		var_scrape_params = { 'wp_scrape_key': rt.new_string((var_scrape_key).str()), 'wp_scrape_nonce': var_scrape_nonce }
		var_headers = { 'Cache-Control': 'no-cache' }
		var_sslverify = rt.call_function('apply_filters', [rt.new_string('https_local_ssl_verify'), rt.new_bool(false)])
		if rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_USER')) && rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_PW')) {
			var_headers['Authorization'] = 'Basic ' + (rt.call_function('base64_encode', [rt.new_string((rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_USER'))])).str() + ':' + (rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_PW'))])).str())])).str()
		}
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('set_time_limit')])) {
			rt.call_function('set_time_limit', [rt.mul(rt.new_int(5), rt.get_constant('MINUTE_IN_SECONDS'))])
		}
		var_timeout = 100
		var_needle_start = "###### wp_scraping_result_start:${var_scrape_key} ######"
		var_needle_end = "###### wp_scraping_result_end:${var_scrape_key} ######"
		if rt.is_true(var_plugin) {
		var_url = rt.call_function('add_query_arg', [rt.call_function('compact', [rt.new_string('plugin'), rt.new_string('file')]), rt.call_function('admin_url', [rt.new_string('plugin-editor.php')])])
		} else if !(var_stylesheet).is_null() {
		var_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'theme', val: var_stylesheet }, rt.ArrayItem{ key: 'file', val: var_file }]), rt.call_function('admin_url', [rt.new_string('theme-editor.php')])])
		} else {
		var_url = rt.call_function('admin_url', []rt.PhpVal{})
		}
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('session_status')])) && rt.is_true(rt.identical(rt.get_constant('PHP_SESSION_ACTIVE'), rt.call_function('session_status', []rt.PhpVal{}))) {
			rt.call_function('session_write_close', []rt.PhpVal{})
		}
		var_url = rt.call_function('add_query_arg', [rt.create_array_from_native_map(var_scrape_params), var_url.clone()])
		var_r = rt.call_function('wp_remote_get', [var_url.clone(), rt.call_function('compact', [rt.new_string('cookies'), rt.new_string('headers'), rt.new_string('timeout'), rt.new_string('sslverify')])])
		var_body = rt.call_function('wp_remote_retrieve_body', [var_r.clone()])
		var_scrape_result_position = rt.call_function('strpos', [var_body.clone(), rt.new_string((var_needle_start).str()).clone()])
		var_loopback_request_failure = { 'code': rt.new_string('loopback_request_failed'), 'message': rt.call_function('__', [rt.new_string('Unable to communicate back with site to check for fatal errors, so the PHP change was reverted. You will need to upload your PHP file change by some other means, such as by using SFTP.')]) }
		var_json_parse_failure = { 'code': 'json_parse_error' }
		var_result = rt.new_null()
		if rt.is_true(rt.identical(rt.new_bool(false), var_scrape_result_position)) {
		var_result = var_loopback_request_failure.clone()
		} else {
			var_error_output = rt.call_function('substr', [var_body.clone(), rt.add(var_scrape_result_position, rt.new_int(var_needle_start.len))])
			var_error_output = rt.call_function('substr', [var_error_output.clone(), rt.new_int(0), rt.call_function('strpos', [var_error_output.clone(), rt.new_string((var_needle_end).str()).clone()])])
			var_result = rt.call_function('json_decode', [rt.new_string(var_error_output.clone().to_string().trim_space()), rt.new_bool(true)])
			if !rt.is_true(var_result) {
			var_result = var_json_parse_failure.clone()
			}
		}
		if rt.is_true(rt.identical(rt.new_bool(true), var_result)) {
			var_url = rt.call_function('home_url', [rt.new_string('/')])
			var_url = rt.call_function('add_query_arg', [rt.create_array_from_native_map(var_scrape_params), var_url.clone()])
			var_r = rt.call_function('wp_remote_get', [var_url.clone(), rt.call_function('compact', [rt.new_string('cookies'), rt.new_string('headers'), rt.new_string('timeout'), rt.new_string('sslverify')])])
			var_body = rt.call_function('wp_remote_retrieve_body', [var_r.clone()])
			var_scrape_result_position = rt.call_function('strpos', [var_body.clone(), rt.new_string((var_needle_start).str()).clone()])
			if rt.is_true(rt.identical(rt.new_bool(false), var_scrape_result_position)) {
			var_result = var_loopback_request_failure.clone()
			} else {
				var_error_output = rt.call_function('substr', [var_body.clone(), rt.add(var_scrape_result_position, rt.new_int(var_needle_start.len))])
				var_error_output = rt.call_function('substr', [var_error_output.clone(), rt.new_int(0), rt.call_function('strpos', [var_error_output.clone(), rt.new_string((var_needle_end).str()).clone()])])
				var_result = rt.call_function('json_decode', [rt.new_string(var_error_output.clone().to_string().trim_space()), rt.new_bool(true)])
				if !rt.is_true(var_result) {
				var_result = var_json_parse_failure.clone()
				}
			}
		}
		rt.call_function('delete_transient', [var_transient.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_result)))) {
			rt.call_function('file_put_contents', [var_real_file.clone(), var_previous_content.clone()])
			rt.new_bool(wp_opcache_invalidate(var_real_file.clone(), true))
			if !(var_result.array_isset(rt.new_string('message'))) {
			var_message = rt.call_function('__', [rt.new_string('An error occurred. Please try again later.')])
			} else {
				var_message = var_result.array_get(rt.new_string('message'))
				var_result.array_unset(rt.new_string('message'))
			}
			return (create_wp_error(rt.new_string('php_error'), var_message.clone(), var_result.clone())).to_bool()
		}
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_theme, 'WP_Theme'))) {
		rt.call_method(var_theme, 'cache_delete', []rt.PhpVal{})
	}
	return true
}

fn wp_tempnam(filename string, dir string) rt.PhpVal {
	mut var_filename := filename
	mut var_dir := dir
	mut var_temp_filename := rt.new_null()
	mut var_characters_over_limit := i64(0)
	mut var_fp := rt.new_null()
	if var_dir == '' {
	var_dir = (rt.call_function('get_temp_dir', []rt.PhpVal{})).str()
	}
	if var_filename == '' || rt.is_true(rt.call_function('in_array', [rt.new_string((var_filename).str()), rt.create_array([rt.ArrayItem{ key: none, val: '.' }, rt.ArrayItem{ key: none, val: '/' }, rt.ArrayItem{ key: none, val: '\\' }]), rt.new_bool(true)])) {
	var_filename = (rt.call_function('uniqid', []rt.PhpVal{})).str()
	}
	var_temp_filename = rt.call_function('basename', [rt.new_string((var_filename).str())])
	var_temp_filename = rt.call_function('preg_replace', [rt.new_string('|\\.[^.]*$|'), rt.new_string(''), var_temp_filename.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_temp_filename)))) {
		return wp_tempnam(rt.call_function('dirname', [rt.new_string((var_filename).str())]), var_dir)
	}
	var_temp_filename = rt.concat(var_temp_filename, rt.new_string('-' + (rt.call_function('wp_generate_password', [rt.new_int(6), rt.new_bool(false)])).str()))
	var_temp_filename = rt.concat(var_temp_filename, rt.new_string('.tmp'))
	var_temp_filename = rt.call_function('wp_unique_filename', [rt.new_string((var_dir).str()), var_temp_filename.clone()])
	var_characters_over_limit = var_temp_filename.clone().to_string().len - 252
	if var_characters_over_limit > 0 {
		var_filename = (rt.call_function('substr', [rt.new_string((var_filename).str()), rt.new_int(0), rt.new_int(-var_characters_over_limit)])).str()
		return wp_tempnam(var_filename, var_dir)
	}
	var_temp_filename = rt.new_string((var_dir + (var_temp_filename).str()).str())
	var_fp = rt.call_function('fopen', [var_temp_filename.clone(), rt.new_string('x')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fp)))) && rt.is_true(rt.call_function('is_writable', [rt.new_string((var_dir).str())])) && rt.is_true(rt.call_function('file_exists', [var_temp_filename.clone()])) {
		return wp_tempnam(var_filename, var_dir)
	}
	if rt.is_true(var_fp) {
		rt.call_function('fclose', [var_fp.clone()])
	}
	return var_temp_filename.clone()
}

fn validate_file_to_edit(var_file rt.PhpVal, var_allowed_files rt.PhpVal) rt.PhpVal {
	mut var_code := rt.new_null()
	var_code = rt.call_function('validate_file', [var_file.clone(), var_allowed_files.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_code)))) {
		return var_file.clone()
	}
	mut switch_val_2 := var_code
	if rt.is_true(rt.equal(switch_val_2, rt.new_int(1))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, that file cannot be edited.')])])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(3))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, that file cannot be edited.')])])
	}
	return rt.new_null()
}

fn _wp_handle_upload(var_file_arg rt.PhpVal, var_overrides_arg rt.PhpVal, var_time rt.PhpVal, var_action rt.PhpVal) rt.PhpVal {
	mut var_file := var_file_arg
	mut var_overrides := var_overrides_arg
	mut var_upload_error_handler := rt.new_null()
	mut var_unique_filename_callback := rt.new_null()
	mut var_upload_error_strings := rt.new_null()
	mut var_test_form := rt.new_null()
	mut var_test_size := rt.new_null()
	mut var_test_type := rt.new_null()
	mut var_mimes := rt.new_null()
	mut var_test_uploaded_file := rt.new_null()
	mut var_test_file_size := rt.new_null()
	mut var_error_msg := rt.new_null()
	mut var_wp_filetype := rt.new_null()
	mut var_ext := rt.new_null()
	mut var_type := rt.new_null()
	mut var_proper_filename := rt.new_null()
	mut var_uploads := rt.new_null()
	mut var_filename := rt.new_null()
	mut var_new_file := rt.new_null()
	mut var_move_new_file := rt.new_null()
	mut var_error_path := rt.new_null()
	mut var_stat := rt.new_null()
	mut var_perms := rt.new_null()
	mut var_url := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_handle_upload_error')]))))) {
fn wp_handle_upload_error(var_file rt.PhpVal, var_message rt.PhpVal) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'error', val: var_message }])
}

fn wp_handle_upload(var_file rt.PhpVal, overrides bool, var_time rt.PhpVal) rt.PhpVal {
	mut var_overrides := overrides
	mut var_action := rt.new_null()
	var_action = if !(rt.new_bool(overrides).array_get(rt.new_string('action'))).is_null() { rt.new_bool(overrides).array_get(rt.new_string('action')) } else { rt.new_string('wp_handle_upload') }
	return _wp_handle_upload(var_file.clone(), rt.new_bool(overrides), var_time.clone(), var_action.clone())
}

fn wp_handle_sideload(var_file rt.PhpVal, overrides bool, var_time rt.PhpVal) rt.PhpVal {
	mut var_overrides := overrides
	mut var_action := rt.new_null()
	var_action = if !(rt.new_bool(overrides).array_get(rt.new_string('action'))).is_null() { rt.new_bool(overrides).array_get(rt.new_string('action')) } else { rt.new_string('wp_handle_sideload') }
	return _wp_handle_upload(var_file.clone(), rt.new_bool(overrides), var_time.clone(), var_action.clone())
}

fn download_url(var_url rt.PhpVal, timeout i64, signature_verification bool) rt.PhpVal {
	mut var_timeout := timeout
	mut var_signature_verification := signature_verification
	mut var_url_path := rt.new_null()
	mut var_url_filename := rt.new_null()
	mut var_tmpfname := rt.new_null()
	mut var_response := rt.new_null()
	mut var_response_code := rt.new_null()
	mut var_data := map[string]rt.PhpVal{}
	mut var_tmpf := rt.new_null()
	mut var_response_size := rt.new_null()
	mut var_content_disposition := rt.new_null()
	mut var_tmpfname_disposition := rt.new_null()
	mut var_mime_type := rt.new_null()
	mut var_valid_mime_types := rt.new_null()
	mut var_extensions := rt.new_null()
	mut var_new_image_name := rt.new_null()
	mut var_content_md5 := rt.new_null()
	mut var_md5_check := rt.new_null()
	mut var_signed_hostnames := rt.new_null()
	mut var_signature := rt.new_null()
	mut var_signature_url := rt.new_null()
	mut var_signature_request := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_url)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('http_no_url'), rt.call_function('__', [rt.new_string('No URL Provided.')])))
	}
	var_url_path = rt.call_function('parse_url', [var_url.clone(), rt.get_constant('PHP_URL_PATH')])
	var_url_filename = rt.new_string('')
	if var_url_path.clone().is_string() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_url_path)))) {
	var_url_filename = rt.call_function('basename', [var_url_path.clone()])
	}
	var_tmpfname = wp_tempnam(var_url_filename.clone(), '')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tmpfname)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('http_no_file'), rt.call_function('__', [rt.new_string('Could not create temporary file.')])))
	}
	var_response = rt.call_function('wp_safe_remote_get', [var_url.clone(), rt.create_array([rt.ArrayItem{ key: 'timeout', val: timeout }, rt.ArrayItem{ key: 'stream', val: true }, rt.ArrayItem{ key: 'filename', val: var_tmpfname }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.call_function('unlink', [var_tmpfname.clone()])
		return var_response.clone()
	}
	var_response_code = rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_response_code)))) {
		var_data = { 'code': var_response_code }
		var_tmpf = rt.call_function('fopen', [var_tmpfname.clone(), rt.new_string('rb')])
		if rt.is_true(var_tmpf) {
			var_response_size = rt.call_function('apply_filters', [rt.new_string('download_url_error_max_body_size'), rt.get_constant('KB_IN_BYTES')])
			var_data['body'] = rt.call_function('fread', [var_tmpf.clone(), var_response_size.clone()])
			rt.call_function('fclose', [var_tmpf.clone()])
		}
		rt.call_function('unlink', [var_tmpfname.clone()])
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('http_404'), rt.new_string(rt.call_function('wp_remote_retrieve_response_message', [var_response.clone()]).to_string().trim_space()), var_data.clone()))
	}
	var_content_disposition = rt.call_function('wp_remote_retrieve_header', [var_response.clone(), rt.new_string('Content-Disposition')])
	if rt.is_true(var_content_disposition) {
		var_content_disposition = rt.new_string(var_content_disposition.clone().to_string().to_lower())
		if rt.is_true(rt.call_function('str_starts_with', [var_content_disposition.clone(), rt.new_string('attachment; filename=')])) {
		var_tmpfname_disposition = rt.call_function('sanitize_file_name', [rt.call_function('substr', [var_content_disposition.clone(), rt.new_int(21)])])
		} else {
		var_tmpfname_disposition = rt.new_string('')
		}
		if rt.is_true(var_tmpfname_disposition) && var_tmpfname_disposition.clone().is_string() && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_tmpfname_disposition.clone()]))) {
			var_tmpfname_disposition = rt.new_string((rt.call_function('dirname', [var_tmpfname.clone()])).str() + '/' + (var_tmpfname_disposition).str())
			if rt.is_true(rt.call_function('rename', [var_tmpfname.clone(), var_tmpfname_disposition.clone()])) {
			var_tmpfname = var_tmpfname_disposition.clone()
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_tmpfname, var_tmpfname_disposition)))) && rt.is_true(rt.call_function('file_exists', [var_tmpfname_disposition.clone()])) {
				rt.call_function('unlink', [var_tmpfname_disposition.clone()])
			}
		}
	}
	var_mime_type = rt.call_function('wp_remote_retrieve_header', [var_response.clone(), rt.new_string('content-type')])
	if rt.is_true(var_mime_type) && rt.is_true(rt.identical(rt.new_string('tmp'), rt.call_function('pathinfo', [var_tmpfname.clone(), rt.get_constant('PATHINFO_EXTENSION')]))) {
		var_valid_mime_types = rt.call_function('array_flip', [rt.call_function('get_allowed_mime_types', []rt.PhpVal{})])
		if !(!rt.is_true(var_valid_mime_types.array_get(var_mime_type))) {
			var_extensions = rt.call_function('explode', [rt.new_string('|'), var_valid_mime_types.array_get(var_mime_type)])
			var_new_image_name = rt.new_string((rt.call_function('substr', [var_tmpfname.clone(), rt.new_int(0), rt.new_int(-4)])).str() + rt.concat(rt.new_string('.'), var_extensions.array_get(rt.new_int(0))))
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_new_image_name.clone()]))) {
				if rt.is_true(rt.call_function('rename', [var_tmpfname.clone(), var_new_image_name.clone()])) {
				var_tmpfname = var_new_image_name.clone()
				}
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_tmpfname, var_new_image_name)))) && rt.is_true(rt.call_function('file_exists', [var_new_image_name.clone()])) {
					rt.call_function('unlink', [var_new_image_name.clone()])
				}
			}
		}
	}
	var_content_md5 = rt.call_function('wp_remote_retrieve_header', [var_response.clone(), rt.new_string('Content-MD5')])
	if rt.is_true(var_content_md5) {
		var_md5_check = rt.new_bool(verify_file_md5(var_tmpfname.clone(), var_content_md5.clone()))
		if rt.is_true(rt.call_function('is_wp_error', [var_md5_check.clone()])) {
			rt.call_function('unlink', [var_tmpfname.clone()])
			return var_md5_check.clone()
		}
	}
	if var_signature_verification {
	var_signed_hostnames = rt.call_function('apply_filters', [rt.new_string('wp_signature_hosts'), rt.create_array([rt.ArrayItem{ key: none, val: 'wordpress.org' }, rt.ArrayItem{ key: none, val: 'downloads.wordpress.org' }, rt.ArrayItem{ key: none, val: 's.w.org' }])])
	var_signature_verification = (rt.call_function('in_array', [rt.call_function('parse_url', [var_url.clone(), rt.get_constant('PHP_URL_HOST')]), var_signed_hostnames.clone(), rt.new_bool(true)])).to_bool()
	}
	if var_signature_verification {
		var_signature = rt.call_function('wp_remote_retrieve_header', [var_response.clone(), rt.new_string('X-Content-Signature')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_signature)))) {
			var_signature_url = rt.new_bool(false)
			if var_url_path.clone().is_string() && rt.is_true(rt.call_function('str_ends_with', [var_url_path.clone(), rt.new_string('.zip')])) || rt.is_true(rt.call_function('str_ends_with', [var_url_path.clone(), rt.new_string('.tar.gz')])) {
			var_signature_url = rt.call_function('str_replace', [var_url_path.clone(), rt.new_string((var_url_path).str() + '.sig'), var_url.clone()])
			}
			var_signature_url = rt.call_function('apply_filters', [rt.new_string('wp_signature_url'), var_signature_url.clone(), var_url.clone()])
			if rt.is_true(var_signature_url) {
				var_signature_request = rt.call_function('wp_safe_remote_get', [var_signature_url.clone(), rt.create_array([rt.ArrayItem{ key: 'limit_response_size', val: rt.mul(rt.new_int(10), rt.get_constant('KB_IN_BYTES')) }])])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_signature_request.clone()]))))) && rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [var_signature_request.clone()]))) {
				var_signature = rt.call_function('explode', [rt.new_string('\n'), rt.call_function('wp_remote_retrieve_body', [var_signature_request.clone()])])
				}
			}
		}
	var_signature_verification = verify_file_signature(var_tmpfname.clone(), var_signature.clone(), var_url_filename.clone())
	}
	if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_signature_verification)])) {
		if rt.is_true(rt.call_function('apply_filters', [rt.new_string('wp_signature_softfail'), rt.new_bool(true), var_url.clone()])) {
			rt.call_method(rt.new_bool(var_signature_verification), 'add_data', [var_tmpfname.clone(), rt.new_string('softfail-filename')])
		} else {
			rt.call_function('unlink', [var_tmpfname.clone()])
		}
		return rt.new_bool(var_signature_verification)
	}
	return var_tmpfname.clone()
}

fn verify_file_md5(var_filename rt.PhpVal, var_expected_md5 rt.PhpVal) bool {
	mut var_expected_raw_md5 := rt.new_null()
	mut var_file_md5 := rt.new_null()
	if 32 == var_expected_md5.clone().to_string().len {
	var_expected_raw_md5 = rt.call_function('pack', [rt.new_string('H*'), var_expected_md5.clone()])
	} else if 24 == var_expected_md5.clone().to_string().len {
	var_expected_raw_md5 = rt.call_function('base64_decode', [var_expected_md5.clone()])
	} else {
		return false
	}
	var_file_md5 = rt.call_function('md5_file', [var_filename.clone(), rt.new_bool(true)])
	if rt.is_true(rt.identical(var_file_md5, var_expected_raw_md5)) {
		return true
	}
	return (create_wp_error(rt.new_string('md5_mismatch'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The checksum of the file (%1$s) does not match the expected checksum value (%2$s).')]), rt.call_function('bin2hex', [var_file_md5.clone()]), rt.call_function('bin2hex', [var_expected_raw_md5.clone()])]))).to_bool()
}

fn verify_file_signature(var_filename rt.PhpVal, var_signatures rt.PhpVal, filename_for_errors bool) bool {
	mut var_filename_for_errors := filename_for_errors
	mut var_sodium_compat_is_fast := rt.new_null()
	mut var_old_fastMult := rt.new_null()
	mut var_trusted_keys := rt.new_null()
	mut var_file_hash := rt.new_null()
	mut var_skipped_key := i64(0)
	mut var_skipped_signature := i64(0)
	mut var_signature := rt.new_null()
	mut var_signature_raw := rt.new_null()
	mut var_key := rt.new_null()
	mut var_key_raw := rt.new_null()
	if !(var_filename_for_errors) {
	var_filename_for_errors = (rt.call_function('wp_basename', [var_filename.clone()])).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('sodium_crypto_sign_verify_detached')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('sha384'), rt.call_function('array_map', [rt.new_string('strtolower'), rt.call_function('hash_algos', []rt.PhpVal{})]), rt.new_bool(true)]))))) {
		return (create_wp_error(rt.new_string('signature_verification_unsupported'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The authenticity of %s could not be verified as signature verification is unavailable on this system.')]), rt.new_string('<span class="code">' + (rt.call_function('esc_html', [rt.new_bool(var_filename_for_errors)])).str() + '</span>')]), if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('sodium_crypto_sign_verify_detached')]))))) { 'sodium_crypto_sign_verify_detached' } else { 'sha384' })).to_bool()
	}
	mut iife_temp_0 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_0 := iife_temp_0.polyfill_is_fast()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('sodium')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		var_sodium_compat_is_fast = rt.new_bool(false)
		if rt.is_true(rt.call_function('method_exists', [rt.new_string('ParagonIE_Sodium_Compat'), rt.new_string('runtime_speed_test')])) {
			var_old_fastMult = rt.get_static_prop('ParagonIE_Sodium_Compat', 'fastMult')
			rt.set_static_prop('ParagonIE_Sodium_Compat', 'fastMult', rt.new_bool(true))
			mut iife_temp_1 := Class_ParagonIE_Sodium_Compat{}
			mut iife_result_1 := iife_temp_1.runtime_speed_test(rt.new_int(100), rt.new_int(10))
			var_sodium_compat_is_fast = iife_result_1
			rt.set_static_prop('ParagonIE_Sodium_Compat', 'fastMult', var_old_fastMult.clone())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_sodium_compat_is_fast)))) {
			return (create_wp_error(rt.new_string('signature_verification_unsupported'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The authenticity of %s could not be verified as signature verification is unavailable on this system.')]), rt.new_string('<span class="code">' + (rt.call_function('esc_html', [rt.new_bool(var_filename_for_errors)])).str() + '</span>')]), rt.create_array([rt.ArrayItem{ key: 'php', val: rt.get_constant('PHP_VERSION') }, rt.ArrayItem{ key: 'sodium', val: if rt.is_true(rt.call_function('defined', [rt.new_string('SODIUM_LIBRARY_VERSION')])) { rt.get_constant('SODIUM_LIBRARY_VERSION') } else { if rt.is_true(rt.call_function('defined', [rt.new_string('ParagonIE_Sodium_Compat::VERSION_STRING')])) { Class_ParagonIE_Sodium_Compat.version_string() } else { rt.new_bool(false) } } }, rt.ArrayItem{ key: 'polyfill_is_fast', val: false }, rt.ArrayItem{ key: 'max_execution_time', val: rt.call_function('ini_get', [rt.new_string('max_execution_time')]) }]))).to_bool()
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_signatures)))) {
		return (create_wp_error(rt.new_string('signature_verification_no_signature'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The authenticity of %s could not be verified as no signature was found.')]), rt.new_string('<span class="code">' + (rt.call_function('esc_html', [rt.new_bool(var_filename_for_errors)])).str() + '</span>')]), rt.create_array([rt.ArrayItem{ key: 'filename', val: var_filename_for_errors }]))).to_bool()
	}
	var_trusted_keys = wp_trusted_keys()
	var_file_hash = rt.call_function('hash_file', [rt.new_string('sha384'), var_filename.clone(), rt.new_bool(true)])
	rt.call_function('mbstring_binary_safe_encoding', []rt.PhpVal{})
	var_skipped_key = 0
	var_skipped_signature = 0
	mut iter_2 := rt.cast_array(var_signatures).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_signature_shadow := item_2.val
		var_signature_raw = rt.call_function('base64_decode', [var_signature_shadow.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('SODIUM_CRYPTO_SIGN_BYTES'), rt.new_int(var_signature_raw.clone().to_string().len))))) {
			var_skipped_signature += 1
			continue
		}
		mut iter_3 := rt.cast_array(var_trusted_keys).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_key_shadow := item_3.val
			var_key_raw = rt.call_function('base64_decode', [var_key_shadow.clone()])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('SODIUM_CRYPTO_SIGN_PUBLICKEYBYTES'), rt.new_int(var_key_raw.clone().to_string().len))))) {
				var_skipped_key += 1
				continue
			}
			if rt.is_true(rt.call_function('sodium_crypto_sign_verify_detached', [var_signature_raw.clone(), var_file_hash.clone(), var_key_raw.clone()])) {
				rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
				return true
			}
		}
	}
	rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
	return (create_wp_error(rt.new_string('signature_verification_failed'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The authenticity of %s could not be verified.')]), rt.new_string('<span class="code">' + (rt.call_function('esc_html', [rt.new_bool(var_filename_for_errors)])).str() + '</span>')]), rt.create_array([rt.ArrayItem{ key: 'filename', val: var_filename_for_errors }, rt.ArrayItem{ key: 'keys', val: var_trusted_keys }, rt.ArrayItem{ key: 'signatures', val: var_signatures }, rt.ArrayItem{ key: 'hash', val: rt.call_function('bin2hex', [var_file_hash.clone()]) }, rt.ArrayItem{ key: 'skipped_key', val: var_skipped_key }, rt.ArrayItem{ key: 'skipped_sig', val: var_skipped_signature }, rt.ArrayItem{ key: 'php', val: rt.get_constant('PHP_VERSION') }, rt.ArrayItem{ key: 'sodium', val: if rt.is_true(rt.call_function('defined', [rt.new_string('SODIUM_LIBRARY_VERSION')])) { rt.get_constant('SODIUM_LIBRARY_VERSION') } else { if rt.is_true(rt.call_function('defined', [rt.new_string('ParagonIE_Sodium_Compat::VERSION_STRING')])) { Class_ParagonIE_Sodium_Compat.version_string() } else { rt.new_bool(false) } } }]))).to_bool()
}

fn wp_trusted_keys() rt.PhpVal {
	mut var_trusted_keys := rt.new_null()
	var_trusted_keys = rt.new_array()
	if rt.is_true(rt.less(rt.call_function('time', []rt.PhpVal{}), rt.new_int(1617235200))) {
		var_trusted_keys.array_push('fRPyrxb/MvVLbdsYi+OOEv4xc+Eqpsj+kkAS6gNOkI0=')
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_trusted_keys'), var_trusted_keys.clone()])
}

fn wp_zip_file_is_valid(var_file rt.PhpVal) bool {
	mut var_archive := rt.new_null()
	mut var_archive_is_valid := rt.new_null()
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ZipArchive'), rt.new_bool(false)])) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('unzip_file_use_ziparchive'), rt.new_bool(true)])) {
		var_archive = create_ziparchive()
		var_archive_is_valid = rt.call_method(var_archive, 'open', [var_file.clone(), Class_ZipArchive.checkcons()])
		if rt.is_true(rt.identical(rt.new_bool(true), var_archive_is_valid)) {
			rt.call_method(var_archive, 'close', []rt.PhpVal{})
			return true
		}
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-pclzip.php', '4')
	var_archive = create_pclzip(var_file.clone())
	var_archive_is_valid = rt.new_bool(rt.call_method(var_archive, 'properties', []rt.PhpVal{}).is_array())
	return (var_archive_is_valid).to_bool()
}

fn unzip_file(var_file rt.PhpVal, var_to_arg rt.PhpVal) rt.PhpVal {
	mut var_to := var_to_arg
	mut var_wp_filesystem := rt.new_null()
	mut var_needed_dirs := rt.new_null()
	mut var_path := rt.new_null()
	mut var_dir := rt.new_null()
	mut var_i := i64(0)
	mut var_result := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_filesystem)))) || !(var_wp_filesystem.clone().is_object()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('fs_unavailable'), rt.call_function('__', [rt.new_string('Could not access filesystem.')])))
	}
	rt.call_function('wp_raise_memory_limit', [rt.new_string('admin')])
	var_needed_dirs = rt.new_array()
	var_to = rt.call_function('trailingslashit', [var_to.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [var_to.clone()]))))) {
		var_path = rt.call_function('preg_split', [rt.new_string('![/\\\\]!'), rt.call_function('untrailingslashit', [var_to.clone()])])
		var_i = var_path.clone().array_count()
		for {
			if !(var_i >= 0) { break }
			if !rt.is_true(var_path.array_get(rt.new_int(var_i))) {
				continue
			}
			var_dir = rt.call_function('implode', [rt.new_string('/'), rt.call_function('array_slice', [var_path.clone(), rt.new_int(0), rt.new_int(var_i + 1)])])
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('!^[a-z]:$!i'), var_dir.clone()])) {
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [var_dir.clone()]))))) {
				var_needed_dirs.array_push(var_dir.clone())
			} else {
				break
			}
			var_i -= 1
		}
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ZipArchive'), rt.new_bool(false)])) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('unzip_file_use_ziparchive'), rt.new_bool(true)])) {
		var_result = _unzip_file_ziparchive(var_file.clone(), var_to.clone(), var_needed_dirs.clone())
		if rt.is_true(rt.identical(rt.new_bool(true), var_result)) {
			return var_result.clone()
		} else if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('incompatible_archive'), rt.call_method(var_result, 'get_error_code', []rt.PhpVal{}))))) {
				return var_result.clone()
			}
		}
	}
	return _unzip_file_pclzip(var_file.clone(), var_to.clone(), var_needed_dirs.clone())
}

fn _unzip_file_ziparchive(var_file rt.PhpVal, var_to rt.PhpVal, var_needed_dirs_arg rt.PhpVal) rt.PhpVal {
	mut var_needed_dirs := var_needed_dirs_arg
	mut var_wp_filesystem := rt.new_null()
	mut var_z := rt.new_null()
	mut var_zopen := rt.new_null()
	mut var_uncompressed_size := i64(0)
	mut var_info := rt.new_null()
	mut var_dirname := rt.new_null()
	mut var_i := i64(0)
	mut var_required_space := f64(0.0)
	mut var_available_space := rt.new_null()
	mut var_dir := rt.new_null()
	mut var_parent_folder := rt.new_null()
	mut var__dir := rt.new_null()
	mut var_pre := rt.new_null()
	mut var_contents := rt.new_null()
	mut var_result := rt.new_null()
	var_z = create_ziparchive()
	var_zopen = var_z.open(var_file.clone(), Class_ZIPARCHIVE.checkcons())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_zopen)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incompatible_archive'), rt.call_function('__', [rt.new_string('Incompatible Archive.')]), rt.create_array([rt.ArrayItem{ key: 'ziparchive_error', val: var_zopen }])))
	}
	var_uncompressed_size = 0
	var_i = 0
	for {
		if !(rt.is_true(rt.less(rt.new_int(var_i), rt.get_property(var_z, 'numFiles')))) { break }
		var_info = var_z.statindex(rt.new_int(var_i))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_info)))) {
			var_z.close()
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('stat_failed_ziparchive'), rt.call_function('__', [rt.new_string('Could not retrieve file from archive.')])))
		}
		if rt.is_true(rt.call_function('str_starts_with', [var_info.array_get(rt.new_string('name')), rt.new_string('__MACOSX/')])) {
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_info.array_get(rt.new_string('name'))]))))) {
			continue
		}
		var_uncompressed_size = var_uncompressed_size + (var_info.array_get(rt.new_string('size'))).to_i64()
		var_dirname = rt.call_function('dirname', [var_info.array_get(rt.new_string('name'))])
		if rt.is_true(rt.call_function('str_ends_with', [var_info.array_get(rt.new_string('name')), rt.new_string('/')])) {
			var_needed_dirs.array_push((var_to).str() + (rt.call_function('untrailingslashit', [var_info.array_get(rt.new_string('name'))])).str())
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('.'), var_dirname)))) {
			var_needed_dirs.array_push((var_to).str() + (rt.call_function('untrailingslashit', [var_dirname.clone()])).str())
		}
		var_i += 1
	}
	var_required_space = var_uncompressed_size * 2.1
	if rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{})) {
		var_available_space = if rt.is_true(rt.call_function('function_exists', [rt.new_string('disk_free_space')])) { rt.call_function('disk_free_space', [rt.get_constant('WP_CONTENT_DIR')]) } else { rt.new_bool(false) }
		if rt.is_true(var_available_space) && rt.is_true(rt.greater(rt.new_float(var_required_space), var_available_space)) {
			var_z.close()
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('disk_full_unzip_file'), rt.call_function('__', [rt.new_string('Could not copy files. You may have run out of disk space.')]), rt.call_function('compact', [rt.new_string('uncompressed_size'), rt.new_string('available_space')])))
		}
	}
	var_needed_dirs = rt.call_function('array_unique', [var_needed_dirs.clone()])
	mut iter_4 := var_needed_dirs.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_dir_shadow := item_4.val
		if rt.is_true(rt.identical(rt.call_function('untrailingslashit', [var_to.clone()]), var_dir_shadow)) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_dir_shadow.clone(), var_to.clone()]))))) {
			continue
		}
		var_parent_folder = rt.call_function('dirname', [var_dir_shadow.clone()])
		for !(!rt.is_true(var_parent_folder)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('untrailingslashit', [var_to.clone()]), var_parent_folder)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_parent_folder.clone(), var_needed_dirs.clone(), rt.new_bool(true)]))))) {
			var_needed_dirs.array_push(var_parent_folder.clone())
		var_parent_folder = rt.call_function('dirname', [var_parent_folder.clone()])
		}
	}
	rt.call_function('asort', [var_needed_dirs.clone()])
	mut iter_5 := var_needed_dirs.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var__dir_shadow := item_5.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'mkdir', [var__dir_shadow.clone(), rt.get_constant('FS_CHMOD_DIR')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [var__dir_shadow.clone()]))))) {
			var_z.close()
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('mkdir_failed_ziparchive'), rt.call_function('__', [rt.new_string('Could not create directory.')]), var__dir_shadow.clone()))
		}
	}
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_unzip_file'), rt.new_null(), var_file.clone(), var_to.clone(), var_needed_dirs.clone(), rt.new_float(var_required_space).clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		var_z.close()
		return var_pre.clone()
	}
	var_i = 0
	for {
		if !(rt.is_true(rt.less(rt.new_int(var_i), rt.get_property(var_z, 'numFiles')))) { break }
		var_info = var_z.statindex(rt.new_int(var_i))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_info)))) {
			var_z.close()
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('stat_failed_ziparchive'), rt.call_function('__', [rt.new_string('Could not retrieve file from archive.')])))
		}
		if rt.is_true(rt.call_function('str_ends_with', [var_info.array_get(rt.new_string('name')), rt.new_string('/')])) {
			continue
		}
		if rt.is_true(rt.call_function('str_starts_with', [var_info.array_get(rt.new_string('name')), rt.new_string('__MACOSX/')])) {
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_info.array_get(rt.new_string('name'))]))))) {
			continue
		}
		var_contents = var_z.getfromindex(rt.new_int(var_i))
		if rt.is_true(rt.identical(rt.new_bool(false), var_contents)) {
			var_z.close()
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('extract_failed_ziparchive'), rt.call_function('__', [rt.new_string('Could not extract file from archive.')]), var_info.array_get(rt.new_string('name'))))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'put_contents', [rt.new_string((var_to).str() + (var_info.array_get(rt.new_string('name'))).str()), var_contents.clone(), rt.get_constant('FS_CHMOD_FILE')]))))) {
			var_z.close()
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('copy_failed_ziparchive'), rt.call_function('__', [rt.new_string('Could not copy file.')]), var_info.array_get(rt.new_string('name'))))
		}
		var_i += 1
	}
	var_z.close()
	var_result = rt.call_function('apply_filters', [rt.new_string('unzip_file'), rt.new_bool(true), var_file.clone(), var_to.clone(), var_needed_dirs.clone(), rt.new_float(var_required_space).clone()])
	var_needed_dirs = rt.new_null()
	return var_result.clone()
}

fn _unzip_file_pclzip(var_file rt.PhpVal, var_to rt.PhpVal, var_needed_dirs_arg rt.PhpVal) rt.PhpVal {
	mut var_needed_dirs := var_needed_dirs_arg
	mut var_wp_filesystem := rt.new_null()
	mut var_archive := rt.new_null()
	mut var_archive_files := rt.new_null()
	mut var_uncompressed_size := i64(0)
	mut var_archive_file := map[string]rt.PhpVal{}
	mut var_required_space := f64(0.0)
	mut var_available_space := rt.new_null()
	mut var_dir := rt.new_null()
	mut var_parent_folder := rt.new_null()
	mut var__dir := rt.new_null()
	mut var_pre := rt.new_null()
	mut var_result := rt.new_null()
	rt.call_function('mbstring_binary_safe_encoding', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-pclzip.php', '4')
	var_archive = create_pclzip(var_file.clone())
	var_archive_files = rt.call_method(var_archive, 'extract', [rt.get_constant('PCLZIP_OPT_EXTRACT_AS_STRING')])
	rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
	if !(var_archive_files.clone().is_array()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incompatible_archive'), rt.call_function('__', [rt.new_string('Incompatible Archive.')]), rt.call_method(var_archive, 'errorInfo', [rt.new_bool(true)])))
	}
	if 0 == var_archive_files.clone().array_count() {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('empty_archive_pclzip'), rt.call_function('__', [rt.new_string('Empty archive.')])))
	}
	var_uncompressed_size = 0
	mut iter_6 := var_archive_files.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_archive_file_shadow := item_6.val
		if rt.is_true(rt.call_function('str_starts_with', [var_archive_file_shadow['filename'], rt.new_string('__MACOSX/')])) {
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_archive_file_shadow['filename']]))))) {
			continue
		}
		var_uncompressed_size = var_uncompressed_size + (var_archive_file_shadow['size']).to_i64()
		var_needed_dirs.array_push((var_to).str() + (rt.call_function('untrailingslashit', [if rt.is_true(var_archive_file_shadow['folder']) { var_archive_file_shadow['filename'] } else { rt.call_function('dirname', [var_archive_file_shadow['filename']]) }])).str())
	}
	var_required_space = var_uncompressed_size * 2.1
	if rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{})) {
		var_available_space = if rt.is_true(rt.call_function('function_exists', [rt.new_string('disk_free_space')])) { rt.call_function('disk_free_space', [rt.get_constant('WP_CONTENT_DIR')]) } else { rt.new_bool(false) }
		if rt.is_true(var_available_space) && rt.is_true(rt.greater(rt.new_float(var_required_space), var_available_space)) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('disk_full_unzip_file'), rt.call_function('__', [rt.new_string('Could not copy files. You may have run out of disk space.')]), rt.call_function('compact', [rt.new_string('uncompressed_size'), rt.new_string('available_space')])))
		}
	}
	var_needed_dirs = rt.call_function('array_unique', [var_needed_dirs.clone()])
	mut iter_7 := var_needed_dirs.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_dir_shadow := item_7.val
		if rt.is_true(rt.identical(rt.call_function('untrailingslashit', [var_to.clone()]), var_dir_shadow)) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_dir_shadow.clone(), var_to.clone()]))))) {
			continue
		}
		var_parent_folder = rt.call_function('dirname', [var_dir_shadow.clone()])
		for !(!rt.is_true(var_parent_folder)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('untrailingslashit', [var_to.clone()]), var_parent_folder)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_parent_folder.clone(), var_needed_dirs.clone(), rt.new_bool(true)]))))) {
			var_needed_dirs.array_push(var_parent_folder.clone())
		var_parent_folder = rt.call_function('dirname', [var_parent_folder.clone()])
		}
	}
	rt.call_function('asort', [var_needed_dirs.clone()])
	mut iter_8 := var_needed_dirs.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var__dir_shadow := item_8.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'mkdir', [var__dir_shadow.clone(), rt.get_constant('FS_CHMOD_DIR')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [var__dir_shadow.clone()]))))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('mkdir_failed_pclzip'), rt.call_function('__', [rt.new_string('Could not create directory.')]), var__dir_shadow.clone()))
		}
	}
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_unzip_file'), rt.new_null(), var_file.clone(), var_to.clone(), var_needed_dirs.clone(), rt.new_float(var_required_space).clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		return var_pre.clone()
	}
	mut iter_9 := var_archive_files.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_archive_file_shadow := item_9.val
		if rt.is_true(var_archive_file_shadow['folder']) {
			continue
		}
		if rt.is_true(rt.call_function('str_starts_with', [var_archive_file_shadow['filename'], rt.new_string('__MACOSX/')])) {
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_archive_file_shadow['filename']]))))) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'put_contents', [rt.new_string((var_to).str() + (var_archive_file_shadow['filename']).str()), var_archive_file_shadow['content'], rt.get_constant('FS_CHMOD_FILE')]))))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('copy_failed_pclzip'), rt.call_function('__', [rt.new_string('Could not copy file.')]), var_archive_file_shadow['filename']))
		}
	}
	var_result = rt.call_function('apply_filters', [rt.new_string('unzip_file'), rt.new_bool(true), var_file.clone(), var_to.clone(), var_needed_dirs.clone(), rt.new_float(var_required_space).clone()])
	var_needed_dirs = rt.new_null()
	return var_result.clone()
}

fn copy_dir(var_from_arg rt.PhpVal, var_to_arg rt.PhpVal, var_skip_list rt.PhpVal) bool {
	mut var_from := var_from_arg
	mut var_to := var_to_arg
	mut var_wp_filesystem := rt.new_null()
	mut var_dirlist := rt.new_null()
	mut var_fileinfo := map[string]rt.PhpVal{}
	mut var_filename := rt.new_null()
	mut var_sub_skip_list := []rt.PhpVal{}
	mut var_skip_item := rt.new_null()
	mut var_result := rt.new_null()
	var_dirlist = rt.call_method(var_wp_filesystem, 'dirlist', [var_from.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_dirlist)) {
		return (create_wp_error(rt.new_string('dirlist_failed_copy_dir'), rt.call_function('__', [rt.new_string('Directory listing failed.')]), rt.call_function('basename', [var_from.clone()]))).to_bool()
	}
	var_from = rt.call_function('trailingslashit', [var_from.clone()])
	var_to = rt.call_function('trailingslashit', [var_to.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [var_to.clone()]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'mkdir', [var_to.clone()]))))) {
		return (create_wp_error(rt.new_string('mkdir_destination_failed_copy_dir'), rt.call_function('__', [rt.new_string('Could not create the destination directory.')]), rt.call_function('basename', [var_to.clone()]))).to_bool()
	}
	mut iter_10 := rt.cast_array(var_dirlist).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_fileinfo_shadow := item_10.val
		mut var_filename_shadow := item_10.key
		if rt.is_true(rt.call_function('in_array', [var_filename_shadow.clone(), var_skip_list.clone(), rt.new_bool(true)])) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('f'), var_fileinfo_shadow['type'])) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'copy', [rt.new_string((var_from).str() + (var_filename_shadow).str()), rt.new_string((var_to).str() + (var_filename_shadow).str()), rt.new_bool(true), rt.get_constant('FS_CHMOD_FILE')]))))) {
				rt.call_method(var_wp_filesystem, 'chmod', [rt.new_string((var_to).str() + (var_filename_shadow).str()), rt.get_constant('FS_CHMOD_FILE')])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'copy', [rt.new_string((var_from).str() + (var_filename_shadow).str()), rt.new_string((var_to).str() + (var_filename_shadow).str()), rt.new_bool(true), rt.get_constant('FS_CHMOD_FILE')]))))) {
					return (create_wp_error(rt.new_string('copy_failed_copy_dir'), rt.call_function('__', [rt.new_string('Could not copy file.')]), (var_to).str() + (var_filename_shadow).str())).to_bool()
				}
			}
			rt.new_bool(wp_opcache_invalidate(rt.new_string((var_to).str() + (var_filename_shadow).str()), false))
		} else if rt.is_true(rt.identical(rt.new_string('d'), var_fileinfo_shadow['type'])) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [rt.new_string((var_to).str() + (var_filename_shadow).str())]))))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'mkdir', [rt.new_string((var_to).str() + (var_filename_shadow).str()), rt.get_constant('FS_CHMOD_DIR')]))))) {
					return (create_wp_error(rt.new_string('mkdir_failed_copy_dir'), rt.call_function('__', [rt.new_string('Could not create directory.')]), (var_to).str() + (var_filename_shadow).str())).to_bool()
				}
			}
			var_sub_skip_list = rt.new_array()
			mut iter_11 := var_skip_list.iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_skip_item_shadow := item_11.val
				if rt.is_true(rt.call_function('str_starts_with', [var_skip_item_shadow.clone(), rt.new_string((var_filename_shadow).str() + '/')])) {
					var_sub_skip_list << rt.call_function('preg_replace', [rt.new_string('!^' + (rt.call_function('preg_quote', [var_filename_shadow.clone(), rt.new_string('!')])).str() + '/!i'), rt.new_string(''), var_skip_item_shadow.clone()])
				}
			}
			var_result = rt.new_bool(copy_dir(rt.new_string((var_from).str() + (var_filename_shadow).str()), rt.new_string((var_to).str() + (var_filename_shadow).str()), rt.create_array_from_list(var_sub_skip_list)))
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				return (var_result).to_bool()
			}
		}
	}
	return true
}

fn move_dir(var_from rt.PhpVal, var_to rt.PhpVal, overwrite bool) bool {
	mut var_overwrite := overwrite
	mut var_wp_filesystem := rt.new_null()
	mut var_result := false
	if rt.is_true(rt.identical(rt.call_function('trailingslashit', [rt.new_string(var_from.clone().to_string().to_lower())]), rt.call_function('trailingslashit', [rt.new_string(var_to.clone().to_string().to_lower())]))) {
		return (create_wp_error(rt.new_string('source_destination_same_move_dir'), rt.call_function('__', [rt.new_string('The source and destination are the same.')]))).to_bool()
	}
	if rt.is_true(rt.call_method(var_wp_filesystem, 'exists', [var_to.clone()])) {
		if !(var_overwrite) {
			return (create_wp_error(rt.new_string('destination_already_exists_move_dir'), rt.call_function('__', [rt.new_string('The destination folder already exists.')]), var_to.clone())).to_bool()
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'delete', [var_to.clone(), rt.new_bool(true)]))))) {
			return (create_wp_error(rt.new_string('destination_not_deleted_move_dir'), rt.call_function('__', [rt.new_string('The destination directory already exists and could not be removed.')]))).to_bool()
		}
	}
	if rt.is_true(rt.call_method(var_wp_filesystem, 'move', [var_from.clone(), var_to.clone()])) {
		rt.call_function('usleep', [rt.new_int(200000)])
		wp_opcache_invalidate_directory(var_to.clone())
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_dir', [var_to.clone()]))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'mkdir', [var_to.clone(), rt.get_constant('FS_CHMOD_DIR')]))))) {
			return (create_wp_error(rt.new_string('mkdir_failed_move_dir'), rt.call_function('__', [rt.new_string('Could not create directory.')]), var_to.clone())).to_bool()
		}
	}
	var_result = copy_dir(var_from.clone(), var_to.clone(), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('basename', [var_to.clone()]) }]))
	if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(var_result))) {
		rt.call_method(var_wp_filesystem, 'delete', [var_from.clone(), rt.new_bool(true)])
	}
	return var_result
}

fn wp_filesystem(args bool, context bool, allow_relaxed_file_ownership bool) rt.PhpVal {
	mut var_args := args
	mut var_context := context
	mut var_allow_relaxed_file_ownership := allow_relaxed_file_ownership
	mut var_method := rt.new_null()
	mut var_abstraction_file := rt.new_null()
	mut var_wp_filesystem := rt.new_null()
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-filesystem-base.php', '4')
	var_method = get_filesystem_method(rt.new_bool(args), context, allow_relaxed_file_ownership)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_method)))) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string("WP_Filesystem_${var_method.to_string()}")]))))) {
		var_abstraction_file = rt.call_function('apply_filters', [rt.new_string('filesystem_method_file'), rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-filesystem-' + (var_method).str() + '.php'), var_method.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_abstraction_file.clone()]))))) {
			return rt.new_null()
		}
		rt.include_file((var_abstraction_file).to_string(), '4')
	}
	var_method = rt.new_string("WP_Filesystem_${var_method.to_string()}")
	var_wp_filesystem = rt.create_object_dynamically(var_method, [rt.new_bool(args)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('FS_CONNECT_TIMEOUT')]))))) {
		rt.call_function('define', [rt.new_string('FS_CONNECT_TIMEOUT'), rt.new_int(30)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('FS_TIMEOUT')]))))) {
		rt.call_function('define', [rt.new_string('FS_TIMEOUT'), rt.new_int(30)])
	}
	if rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem, 'errors')])) && rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'connect', []rt.PhpVal{}))))) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('FS_CHMOD_DIR')]))))) {
		rt.call_function('define', [rt.new_string('FS_CHMOD_DIR'), rt.bitwise_and(rt.call_function('fileperms', [rt.get_constant('ABSPATH')]), rt.new_int(511)) | 493])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('FS_CHMOD_FILE')]))))) {
		rt.call_function('define', [rt.new_string('FS_CHMOD_FILE'), rt.bitwise_and(rt.call_function('fileperms', [rt.new_string((rt.get_constant('ABSPATH')).str() + 'index.php')]), rt.new_int(511)) | 420])
	}
	return rt.new_bool(true)
}

fn get_filesystem_method(var_args rt.PhpVal, context string, allow_relaxed_file_ownership bool) rt.PhpVal {
	mut var_context := context
	mut var_allow_relaxed_file_ownership := allow_relaxed_file_ownership
	mut var_GLOBALS := rt.new_null()
	mut var_method := rt.new_null()
	mut var_temp_file_name := rt.new_null()
	mut var_temp_handle := rt.new_null()
	mut var_wp_file_owner := rt.new_null()
	mut var_temp_file_owner := rt.new_null()
	var_method = if rt.is_true(rt.call_function('defined', [rt.new_string('FS_METHOD')])) { rt.get_constant('FS_METHOD') } else { rt.new_bool(false) }
	if !(var_context.len > 0 && var_context != '0') {
	var_context = (rt.get_constant('WP_CONTENT_DIR')).str()
	}
	if rt.is_true(rt.identical(rt.get_constant('WP_LANG_DIR'), rt.new_string((var_context).str()))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [rt.new_string((var_context).str())]))))) {
	var_context = (rt.call_function('dirname', [rt.new_string((var_context).str())])).str()
	}
	var_context = (rt.call_function('trailingslashit', [rt.new_string((var_context).str())])).str()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_method)))) {
		var_temp_file_name = rt.new_string((var_context + 'temp-write-test-' + (rt.call_function('str_replace', [rt.new_string('.'), rt.new_string('-'), rt.call_function('uniqid', [rt.new_string(''), rt.new_bool(true)])])).str()).str())
		var_temp_handle = rt.call_function('fopen', [var_temp_file_name.clone(), rt.new_string('w')])
		if rt.is_true(var_temp_handle) {
			var_wp_file_owner = rt.new_bool(false)
			var_temp_file_owner = rt.new_bool(false)
			if rt.is_true(rt.call_function('function_exists', [rt.new_string('fileowner')])) {
			var_wp_file_owner = rt.call_function('fileowner', [rt.new_string(@FILE)])
			var_temp_file_owner = rt.call_function('fileowner', [var_temp_file_name.clone()])
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_wp_file_owner)))) && rt.is_true(rt.identical(var_wp_file_owner, var_temp_file_owner)) {
				var_method = rt.new_string('direct')
				var_GLOBALS.array_set('_wp_filesystem_direct_method', 'file_owner')
			} else if var_allow_relaxed_file_ownership {
				var_method = rt.new_string('direct')
				var_GLOBALS.array_set('_wp_filesystem_direct_method', 'relaxed_ownership')
			}
			rt.call_function('fclose', [var_temp_handle.clone()])
			rt.call_function('unlink', [var_temp_file_name.clone()])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_method)))) && var_args.array_isset(rt.new_string('connection_type')) && rt.is_true(rt.identical(rt.new_string('ssh'), var_args.array_get(rt.new_string('connection_type')))) && rt.is_true(rt.call_function('extension_loaded', [rt.new_string('ssh2')])) {
	var_method = rt.new_string('ssh2')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_method)))) && rt.is_true(rt.call_function('extension_loaded', [rt.new_string('ftp')])) {
	var_method = rt.new_string('ftpext')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_method)))) && rt.is_true(rt.call_function('extension_loaded', [rt.new_string('sockets')])) || rt.is_true(rt.call_function('function_exists', [rt.new_string('fsockopen')])) {
	var_method = rt.new_string('ftpsockets')
	}
	return rt.call_function('apply_filters', [rt.new_string('filesystem_method'), var_method.clone(), rt.create_array_from_native_map(var_args), rt.new_string((var_context).str()), rt.new_bool(allow_relaxed_file_ownership)])
}

fn request_filesystem_credentials(var_form_post rt.PhpVal, type string, error bool, context string, var_extra_fields_arg rt.PhpVal, allow_relaxed_file_ownership bool) bool {
	mut var_type := type
	mut var_error := error
	mut var_context := context
	mut var_allow_relaxed_file_ownership := allow_relaxed_file_ownership
	mut var_extra_fields := var_extra_fields_arg
	mut var_pagenow := rt.new_null()
	mut var_req_cred := rt.new_null()
	mut var_credentials := rt.new_null()
	mut var_submitted_form := rt.new_null()
	mut var_ftp_constants := map[string]rt.PhpVal{}
	mut var_constant := rt.new_null()
	mut var_key := rt.new_null()
	mut var_stored_credentials := rt.new_null()
	mut var_hostname := rt.new_null()
	mut var_username := rt.new_null()
	mut var_public_key := rt.new_null()
	mut var_private_key := rt.new_null()
	mut var_port := rt.new_null()
	mut var_connection_type := rt.new_null()
	mut var_error_string := rt.new_null()
	mut var_types := rt.new_null()
	mut var_heading_tag := ''
	mut var_label_user := rt.new_null()
	mut var_label_pass := rt.new_null()
	mut var_hostname_value := rt.new_null()
	mut var_password_value := ''
	mut var_disabled := rt.new_null()
	mut var_text := rt.new_null()
	mut var_name := []rt.PhpVal{}
	mut var_hidden_class := ''
	mut var_field := rt.new_null()
	var_req_cred = rt.call_function('apply_filters', [rt.new_string('request_filesystem_credentials'), rt.new_string(''), var_form_post.clone(), rt.new_string((var_type).str()), rt.new_bool(error), rt.new_string((var_context).str()), rt.create_array_from_list(var_extra_fields), rt.new_bool(allow_relaxed_file_ownership)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_req_cred)))) {
		return (var_req_cred).to_bool()
	}
	if var_type == '' {
	var_type = (get_filesystem_method(rt.new_array(), var_context, allow_relaxed_file_ownership)).str()
	}
	if rt.is_true(rt.identical(rt.new_string('direct'), rt.new_string((var_type).str()))) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.create_array_from_list(var_extra_fields).is_null())) {
	var_extra_fields = ['version', 'locale']
	}
	var_credentials = rt.call_function('get_option', [rt.new_string('ftp_credentials'), rt.create_array([rt.ArrayItem{ key: 'hostname', val: '' }, rt.ArrayItem{ key: 'username', val: '' }])])
	var_submitted_form = rt.call_function('wp_unslash', [rt.get_superglobal('_POST').clone()])
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('_fs_nonce'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_POST').array_get(rt.new_string('_fs_nonce')), rt.new_string('filesystem-credentials')]))))) {
		var_submitted_form.array_unset(rt.new_string('hostname'))
		var_submitted_form.array_unset(rt.new_string('username'))
		var_submitted_form.array_unset(rt.new_string('password'))
		var_submitted_form.array_unset(rt.new_string('public_key'))
		var_submitted_form.array_unset(rt.new_string('private_key'))
		var_submitted_form.array_unset(rt.new_string('connection_type'))
	}
	var_ftp_constants = { 'hostname': 'FTP_HOST', 'username': 'FTP_USER', 'password': 'FTP_PASS', 'public_key': 'FTP_PUBKEY', 'private_key': 'FTP_PRIKEY' }
	for var_key_shadow, var_constant_shadow in var_ftp_constants {
		if rt.is_true(rt.call_function('defined', [rt.new_string((var_constant_shadow).str()).clone()])) {
			var_credentials.array_set(rt.new_string((var_key_shadow).str()), rt.call_function('constant', [rt.new_string((var_constant_shadow).str()).clone()]))
		} else if !(!rt.is_true(var_submitted_form.array_get(rt.new_string((var_key_shadow).str())))) {
			var_credentials.array_set(rt.new_string((var_key_shadow).str()), var_submitted_form.array_get(rt.new_string((var_key_shadow).str())))
		} else if !(var_credentials.array_isset(rt.new_string((var_key_shadow).str()))) {
			var_credentials.array_set(rt.new_string((var_key_shadow).str()), '')
		}
	}
	var_credentials.array_set('hostname', rt.call_function('preg_replace', [rt.new_string('|\\w+://|'), rt.new_string(''), var_credentials.array_get(rt.new_string('hostname'))]))
	if rt.is_true(rt.call_function('strpos', [var_credentials.array_get(rt.new_string('hostname')), rt.new_string(':')])) {
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string(':'), var_credentials.array_get(rt.new_string('hostname')), rt.new_int(2)])
		var_credentials.array_get_mut('hostname') = (list_tmp_1).array_get(0)
		var_credentials.array_get_mut('port') = (list_tmp_1).array_get(1)
		if !(var_credentials.array_get(rt.new_string('port')).is_long() || var_credentials.array_get(rt.new_string('port')).is_double()) {
			var_credentials.array_unset(rt.new_string('port'))
		}
	} else {
		var_credentials.array_unset(rt.new_string('port'))
	}
	if (rt.is_true(rt.call_function('defined', [rt.new_string('FTP_SSH')])) && rt.is_true(rt.get_constant('FTP_SSH'))) || (rt.is_true(rt.call_function('defined', [rt.new_string('FS_METHOD')])) && rt.is_true(rt.identical(rt.new_string('ssh2'), rt.get_constant('FS_METHOD')))) {
		var_credentials.array_set('connection_type', 'ssh')
	} else if rt.is_true(rt.call_function('defined', [rt.new_string('FTP_SSL')])) && rt.is_true(rt.get_constant('FTP_SSL')) && rt.is_true(rt.identical(rt.new_string('ftpext'), rt.new_string((var_type).str()))) {
		var_credentials.array_set('connection_type', 'ftps')
	} else if !(!rt.is_true(var_submitted_form.array_get(rt.new_string('connection_type')))) {
		var_credentials.array_set('connection_type', var_submitted_form.array_get(rt.new_string('connection_type')))
	} else if !(var_credentials.array_isset(rt.new_string('connection_type'))) {
		var_credentials.array_set('connection_type', 'ftp')
	}
	if !(var_error) && (!(!rt.is_true(var_credentials.array_get(rt.new_string('hostname')))) && !(!rt.is_true(var_credentials.array_get(rt.new_string('username')))) && !(!rt.is_true(var_credentials.array_get(rt.new_string('password'))))) || (rt.is_true(rt.identical(rt.new_string('ssh'), var_credentials.array_get(rt.new_string('connection_type')))) && !(!rt.is_true(var_credentials.array_get(rt.new_string('public_key')))) && !(!rt.is_true(var_credentials.array_get(rt.new_string('private_key'))))) {
		var_stored_credentials = var_credentials.clone()
		if !(!rt.is_true(var_stored_credentials.array_get(rt.new_string('port')))) {
			var_stored_credentials.array_get(rt.new_string('hostname')) = rt.concat(var_stored_credentials.array_get(rt.new_string('hostname')), rt.new_string(':' + (var_stored_credentials.array_get(rt.new_string('port'))).str()))
		}
		var_stored_credentials.array_unset(rt.new_string('password'))
		var_stored_credentials.array_unset(rt.new_string('port'))
		var_stored_credentials.array_unset(rt.new_string('private_key'))
		var_stored_credentials.array_unset(rt.new_string('public_key'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
			rt.call_function('update_option', [rt.new_string('ftp_credentials'), var_stored_credentials.clone(), rt.new_bool(false)])
		}
		return (var_credentials).to_bool()
	}
	var_hostname = if !(var_credentials.array_get(rt.new_string('hostname'))).is_null() { var_credentials.array_get(rt.new_string('hostname')) } else { rt.new_string('') }
	var_username = if !(var_credentials.array_get(rt.new_string('username'))).is_null() { var_credentials.array_get(rt.new_string('username')) } else { rt.new_string('') }
	var_public_key = if !(var_credentials.array_get(rt.new_string('public_key'))).is_null() { var_credentials.array_get(rt.new_string('public_key')) } else { rt.new_string('') }
	var_private_key = if !(var_credentials.array_get(rt.new_string('private_key'))).is_null() { var_credentials.array_get(rt.new_string('private_key')) } else { rt.new_string('') }
	var_port = if !(var_credentials.array_get(rt.new_string('port'))).is_null() { var_credentials.array_get(rt.new_string('port')) } else { rt.new_string('') }
	var_connection_type = if !(var_credentials.array_get(rt.new_string('connection_type'))).is_null() { var_credentials.array_get(rt.new_string('connection_type')) } else { rt.new_string('') }
	if var_error {
		var_error_string = rt.call_function('__', [rt.new_string('<strong>Error:</strong> Could not connect to the server. Please verify the settings are correct.')])
		if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(error)])) {
		var_error_string = rt.call_function('esc_html', [rt.call_method(rt.new_bool(error), 'get_error_message', []rt.PhpVal{})])
		}
		rt.call_function('wp_admin_notice', [var_error_string.clone(), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }]) }])])
	}
	var_types = rt.new_array()
	if rt.is_true(rt.call_function('extension_loaded', [rt.new_string('ftp')])) || rt.is_true(rt.call_function('extension_loaded', [rt.new_string('sockets')])) || rt.is_true(rt.call_function('function_exists', [rt.new_string('fsockopen')])) {
		var_types.array_set('ftp', rt.call_function('__', [rt.new_string('FTP')]))
	}
	if rt.is_true(rt.call_function('extension_loaded', [rt.new_string('ftp')])) {
		var_types.array_set('ftps', rt.call_function('__', [rt.new_string('FTPS (SSL)')]))
	}
	if rt.is_true(rt.call_function('extension_loaded', [rt.new_string('ssh2')])) {
		var_types.array_set('ssh', rt.call_function('__', [rt.new_string('SSH2')]))
	}
	var_types = rt.call_function('apply_filters', [rt.new_string('fs_ftp_connection_types'), var_types.clone(), var_credentials.clone(), rt.new_string((var_type).str()), rt.new_bool(error), rt.new_string((var_context).str())])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_form_post.clone()]))
	// unsupported statement: Stmt_InlineHTML
	var_heading_tag = 'h2'
	if rt.is_true(rt.identical(rt.new_string('plugins.php'), var_pagenow)) || rt.is_true(rt.identical(rt.new_string('plugin-install.php'), var_pagenow)) {
	var_heading_tag = 'h1'
	}
	print("<${var_heading_tag} id='request-filesystem-credentials-title'>" + (rt.call_function('__', [rt.new_string('Connection Information')])).str() + "</${var_heading_tag}>")
	// unsupported statement: Stmt_InlineHTML
	var_label_user = rt.call_function('__', [rt.new_string('Username')])
	var_label_pass = rt.call_function('__', [rt.new_string('Password')])
	rt.call_function('_e', [rt.new_string('To perform the requested action, WordPress needs to access your web server.')])
	print(' ')
	if var_types.array_isset(rt.new_string('ftp')) || var_types.array_isset(rt.new_string('ftps')) {
		if var_types.array_isset(rt.new_string('ssh')) {
			rt.call_function('_e', [rt.new_string('Please enter your FTP or SSH credentials to proceed.')])
		var_label_user = rt.call_function('__', [rt.new_string('FTP/SSH Username')])
		var_label_pass = rt.call_function('__', [rt.new_string('FTP/SSH Password')])
		} else {
			rt.call_function('_e', [rt.new_string('Please enter your FTP credentials to proceed.')])
		var_label_user = rt.call_function('__', [rt.new_string('FTP Username')])
		var_label_pass = rt.call_function('__', [rt.new_string('FTP Password')])
		}
		print(' ')
	}
	rt.call_function('_e', [rt.new_string('If you do not remember your credentials, you should contact your web host.')])
	var_hostname_value = rt.call_function('esc_attr', [var_hostname.clone()])
	if !(!rt.is_true(var_port)) {
		var_hostname_value = rt.concat(var_hostname_value, rt.new_string(":${var_port.to_string()}"))
	}
	var_password_value = ''
	if rt.is_true(rt.call_function('defined', [rt.new_string('FTP_PASS')])) {
	var_password_value = '*****'
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Hostname')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('example: www.wordpress.org')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_hostname_value)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [rt.call_function('defined', [rt.new_string('FTP_HOST')])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_label_user)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_username.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [rt.call_function('defined', [rt.new_string('FTP_USER')])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_label_pass)
	// unsupported statement: Stmt_InlineHTML
	print(var_password_value)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [rt.call_function('defined', [rt.new_string('FTP_PASS')])])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('FTP_PASS')]))))) {
		rt.call_function('_e', [rt.new_string('This password will not be stored on the server.')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Connection Type')])
	// unsupported statement: Stmt_InlineHTML
	var_disabled = rt.call_function('disabled', [rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('FTP_SSL')])) && rt.is_true(rt.get_constant('FTP_SSL')) || rt.is_true(rt.call_function('defined', [rt.new_string('FTP_SSH')])) && rt.is_true(rt.get_constant('FTP_SSH'))), rt.new_bool(true), rt.new_bool(false)])
	mut iter_12 := var_types.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_text_shadow := item_12.val
		mut var_name_shadow := item_12.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_name_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_name_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_name_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [var_name_shadow.clone(), var_connection_type.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_disabled)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_text_shadow)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_types.array_isset(rt.new_string('ssh')) {
		var_hidden_class = ''
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('ssh'), var_connection_type)))) {
		var_hidden_class = ' class="hidden"'
		}
		// unsupported statement: Stmt_InlineHTML
		print(var_hidden_class)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Authentication Keys')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Public Key:')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_public_key.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('disabled', [rt.call_function('defined', [rt.new_string('FTP_PUBKEY')])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Private Key:')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_private_key.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('disabled', [rt.call_function('defined', [rt.new_string('FTP_PRIKEY')])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Enter the location on the server where the public and private keys are located. If a passphrase is needed, enter that in the password field above.')])
		// unsupported statement: Stmt_InlineHTML
	}
	mut iter_13 := rt.cast_array(var_extra_fields).iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_field_shadow := item_13.val
		if var_submitted_form.array_isset(var_field_shadow) {
			print('<input type="hidden" name="' + (rt.call_function('esc_attr', [var_field_shadow.clone()])).str() + '" value="' + (rt.call_function('esc_attr', [var_submitted_form.array_get(var_field_shadow)])).str() + '" />')
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('submit_button')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/template.php', '4')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('filesystem-credentials'), rt.new_string('_fs_nonce'), rt.new_bool(false), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Cancel')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Proceed')]), rt.new_string('primary'), rt.new_string('upgrade'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	return false
}

fn wp_print_request_filesystem_credentials_modal() {
	mut var_filesystem_method := rt.new_null()
	mut var_filesystem_credentials_are_stored := false
	mut var_request_filesystem_credentials := false
	var_filesystem_method = get_filesystem_method(rt.new_null(), '', false)
	rt.call_function('ob_start', []rt.PhpVal{})
	var_filesystem_credentials_are_stored = request_filesystem_credentials(rt.call_function('self_admin_url', []rt.PhpVal{}))
	rt.call_function('ob_end_clean', []rt.PhpVal{})
	var_request_filesystem_credentials = rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('direct'), var_filesystem_method)))) && !(var_filesystem_credentials_are_stored)
	if !(var_request_filesystem_credentials) {
		return
	}
	// unsupported statement: Stmt_InlineHTML
	rt.new_bool(request_filesystem_credentials(rt.call_function('site_url', []rt.PhpVal{}), '', false, '', rt.new_null(), false))
	// unsupported statement: Stmt_InlineHTML
}

fn wp_opcache_invalidate(var_filepath rt.PhpVal, force bool) bool {
	mut var_force := force
	mut var_can_invalidate := false
	if rt.is_true(rt.identical(rt.new_null(), rt.new_bool(var_can_invalidate))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('opcache_invalidate')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ini_get', [rt.new_string('opcache.restrict_api')]))))) || rt.is_true(rt.identical(rt.call_function('stripos', [rt.call_function('realpath', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SCRIPT_FILENAME'))]), rt.call_function('ini_get', [rt.new_string('opcache.restrict_api')])]), rt.new_int(0))) {
	var_can_invalidate = true
	}
	if !(var_can_invalidate) {
		return false
	}
	if rt.is_true(rt.new_bool('.php' != rt.call_function('substr', [var_filepath.clone(), rt.new_int(-4)]).to_string().to_lower())) {
		return false
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('wp_opcache_invalidate_file'), rt.new_bool(true), var_filepath.clone()])) {
		return (rt.call_function('opcache_invalidate', [var_filepath.clone(), rt.new_bool(force)])).to_bool()
	}
	return false
}

fn wp_opcache_invalidate_directory(var_dir rt.PhpVal) {
	mut var_wp_filesystem := rt.new_null()
	mut var_error_message := rt.new_null()
	mut var_dirlist := rt.new_null()
	mut var_invalidate_directory := rt.new_null()
	if !(var_dir.clone().is_string()) || rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_dir.clone().to_string().trim_space()))) {
		if rt.is_true(rt.get_constant('WP_DEBUG')) {
			var_error_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s expects a non-empty string.')]), rt.new_string('<code>wp_opcache_invalidate_directory()</code>')])
			rt.call_function('wp_trigger_error', [rt.new_string(''), var_error_message.clone()])
		}
		return
	}
	var_dirlist = rt.call_method(var_wp_filesystem, 'dirlist', [var_dir.clone(), rt.new_bool(false), rt.new_bool(true)])
	if !rt.is_true(var_dirlist) {
		return
	}
	closure_3_fn := fn [mut var_invalidate_directory] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_dirlist := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_path := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_path = rt.call_function('trailingslashit', [var_path.clone()])
		mut iter_14 := var_dirlist.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_details := item_14.val
			mut var_name := item_14.key
			if rt.is_true(rt.identical(rt.new_string('f'), var_details.array_get(rt.new_string('type')))) {
				rt.new_bool(wp_opcache_invalidate(rt.new_string((var_path).str() + (var_name).str()), true))
			} else if var_details.array_get(rt.new_string('files')).is_array() && !(!rt.is_true(var_details.array_get(rt.new_string('files')))) {
				rt.call_callable(var_invalidate_directory, [var_details.array_get(rt.new_string('files')), rt.new_string((var_path).str() + (var_name).str())])
			}
		}
		return rt.new_null()
		}
	var_invalidate_directory = rt.new_closure(closure_3_fn)
	rt.call_callable(var_invalidate_directory, [var_dirlist.clone(), var_dir.clone()])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Compat {
	rt.PhpObjectBase
}

struct Class_ZipArchive {
	rt.PhpObjectBase
}

struct Class_PclZip {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_compat(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Compat {
	mut obj := &Class_ParagonIE_Sodium_Compat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ziparchive(_args ...rt.PhpVal) &Class_ZipArchive {
	mut obj := &Class_ZipArchive{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_pclzip(_args ...rt.PhpVal) &Class_PclZip {
	mut obj := &Class_PclZip{
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


fn (mut this Class_ParagonIE_Sodium_Compat) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Compat) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Compat) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ZipArchive) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ZipArchive) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ZipArchive) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_PclZip) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PclZip) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PclZip) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_func('get_file_description', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(get_file_description(arg_0))
	})
	rt.register_func('get_home_path', fn(args []rt.PhpVal) rt.PhpVal {
		return get_home_path()
	})
	rt.register_func('list_files', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return rt.new_bool(list_files(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('wp_get_plugin_file_editable_extensions', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_get_plugin_file_editable_extensions(arg_0)
	})
	rt.register_func('wp_get_theme_file_editable_extensions', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_get_theme_file_editable_extensions(arg_0)
	})
	rt.register_func('wp_print_file_editor_templates', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_print_file_editor_templates()
	})
	rt.register_func('wp_edit_theme_plugin_file', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_edit_theme_plugin_file(arg_0))
	})
	rt.register_func('wp_tempnam', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return wp_tempnam(arg_0, arg_1)
	})
	rt.register_func('validate_file_to_edit', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return validate_file_to_edit(arg_0, arg_1)
	})
	rt.register_func('_wp_handle_upload', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return _wp_handle_upload(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('wp_handle_upload_error', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_handle_upload_error(arg_0, arg_1)
	})
	rt.register_func('wp_handle_upload', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_handle_upload(arg_0, arg_1, arg_2)
	})
	rt.register_func('wp_handle_sideload', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wp_handle_sideload(arg_0, arg_1, arg_2)
	})
	rt.register_func('download_url', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return download_url(arg_0, arg_1, arg_2)
	})
	rt.register_func('verify_file_md5', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(verify_file_md5(arg_0, arg_1))
	})
	rt.register_func('verify_file_signature', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return rt.new_bool(verify_file_signature(arg_0, arg_1, arg_2))
	})
	rt.register_func('wp_trusted_keys', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_trusted_keys()
	})
	rt.register_func('wp_zip_file_is_valid', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wp_zip_file_is_valid(arg_0))
	})
	rt.register_func('unzip_file', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return unzip_file(arg_0, arg_1)
	})
	rt.register_func('_unzip_file_ziparchive', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return _unzip_file_ziparchive(arg_0, arg_1, arg_2)
	})
	rt.register_func('_unzip_file_pclzip', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return _unzip_file_pclzip(arg_0, arg_1, arg_2)
	})
	rt.register_func('copy_dir', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(copy_dir(arg_0, arg_1, arg_2))
	})
	rt.register_func('move_dir', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return rt.new_bool(move_dir(arg_0, arg_1, arg_2))
	})
	rt.register_func('WP_Filesystem', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return wp_filesystem(arg_0, arg_1, arg_2)
	})
	rt.register_func('get_filesystem_method', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return get_filesystem_method(arg_0, arg_1, arg_2)
	})
	rt.register_func('request_filesystem_credentials', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
		arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
		return rt.new_bool(request_filesystem_credentials(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5))
	})
	rt.register_func('wp_print_request_filesystem_credentials_modal', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_print_request_filesystem_credentials_modal()
	})
	rt.register_func('wp_opcache_invalidate', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return rt.new_bool(wp_opcache_invalidate(arg_0, arg_1))
	})
	rt.register_func('wp_opcache_invalidate_directory', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_opcache_invalidate_directory(arg_0)
	})
	rt.register_class_factory('WP_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
	rt.register_class_factory('ParagonIE_Sodium_Compat', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_paragonie_sodium_compat()
		return rt.new_object('ParagonIE_Sodium_Compat', []string{}, obj)
	})
	rt.register_class_factory('ZipArchive', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_ziparchive()
		return rt.new_object('ZipArchive', []string{}, obj)
	})
	rt.register_class_factory('PclZip', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_pclzip()
		return rt.new_object('PclZip', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	}
	var_file = rt.call_function('apply_filters', [rt.new_string("${var_action.to_string()}_prefilter"), var_file.clone()])
	var_overrides = rt.call_function('apply_filters', [rt.new_string("${var_action.to_string()}_overrides"), var_overrides.clone(), var_file.clone()])
	var_upload_error_handler = rt.new_string('wp_handle_upload_error')
	if var_overrides.array_isset(rt.new_string('upload_error_handler')) {
	var_upload_error_handler = var_overrides.array_get(rt.new_string('upload_error_handler'))
	}
	if var_file.array_isset(rt.new_string('error')) && !(var_file.array_get(rt.new_string('error')).is_long() || var_file.array_get(rt.new_string('error')).is_double()) && rt.is_true(var_file.array_get(rt.new_string('error'))) {
		return rt.call_function('call_user_func_array', [var_upload_error_handler.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_file }, rt.ArrayItem{ key: none, val: var_file.array_get(rt.new_string('error')) }])])
	}
	var_unique_filename_callback = rt.new_null()
	if var_overrides.array_isset(rt.new_string('unique_filename_callback')) {
	var_unique_filename_callback = var_overrides.array_get(rt.new_string('unique_filename_callback'))
	}
	if var_overrides.array_isset(rt.new_string('upload_error_strings')) {
	var_upload_error_strings = var_overrides.array_get(rt.new_string('upload_error_strings'))
	} else {
	var_upload_error_strings = rt.create_array([rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The uploaded file exceeds the %1$s directive in %2$s.')]), rt.new_string('upload_max_filesize'), rt.new_string('php.ini')]) }, rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The uploaded file exceeds the %s directive that was specified in the HTML form.')]), rt.new_string('MAX_FILE_SIZE')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('The uploaded file was only partially uploaded.')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('No file was uploaded.')]) }, rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Missing a temporary folder.')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Failed to write file to disk.')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('File upload stopped by extension.')]) }])
	}
	var_test_form = if !(var_overrides.array_get(rt.new_string('test_form'))).is_null() { var_overrides.array_get(rt.new_string('test_form')) } else { rt.new_bool(true) }
	var_test_size = if !(var_overrides.array_get(rt.new_string('test_size'))).is_null() { var_overrides.array_get(rt.new_string('test_size')) } else { rt.new_bool(true) }
	var_test_type = if !(var_overrides.array_get(rt.new_string('test_type'))).is_null() { var_overrides.array_get(rt.new_string('test_type')) } else { rt.new_bool(true) }
	var_mimes = if !(var_overrides.array_get(rt.new_string('mimes'))).is_null() { var_overrides.array_get(rt.new_string('mimes')) } else { rt.new_null() }
	if rt.is_true(var_test_form) && !(rt.get_superglobal('_POST').array_isset(rt.new_string('action'))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_superglobal('_POST').array_get(rt.new_string('action')), var_action)))) {
		return rt.call_function('call_user_func_array', [var_upload_error_handler.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_file }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Invalid form submission.')]) }])])
	}
	if var_file.array_isset(rt.new_string('error')) && rt.is_true(rt.greater(var_file.array_get(rt.new_string('error')), rt.new_int(0))) {
		return rt.call_function('call_user_func_array', [var_upload_error_handler.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_file }, rt.ArrayItem{ key: none, val: var_upload_error_strings.array_get(var_file.array_get(rt.new_string('error'))) }])])
	}
	var_test_uploaded_file = if rt.is_true(rt.identical(rt.new_string('wp_handle_upload'), var_action)) { rt.call_function('is_uploaded_file', [var_file.array_get(rt.new_string('tmp_name'))]) } else { rt.call_function('is_readable', [var_file.array_get(rt.new_string('tmp_name'))]) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_test_uploaded_file)))) {
		return rt.call_function('call_user_func_array', [var_upload_error_handler.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_file }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Specified file failed upload test.')]) }])])
	}
	var_test_file_size = if rt.is_true(rt.identical(rt.new_string('wp_handle_upload'), var_action)) { var_file.array_get(rt.new_string('size')) } else { rt.call_function('filesize', [var_file.array_get(rt.new_string('tmp_name'))]) }
	if rt.is_true(var_test_size) && rt.is_true(rt.new_bool(!(rt.is_true(rt.greater(var_test_file_size, rt.new_int(0)))))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_error_msg = rt.call_function('__', [rt.new_string('File is empty. Please upload something more substantial.')])
		} else {
		var_error_msg = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('File is empty. Please upload something more substantial. This error could also be caused by uploads being disabled in your %1$s file or by %2$s being defined as smaller than %3$s in %1$s.')]), rt.new_string('php.ini'), rt.new_string('post_max_size'), rt.new_string('upload_max_filesize')])
		}
		return rt.call_function('call_user_func_array', [var_upload_error_handler.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_file }, rt.ArrayItem{ key: none, val: var_error_msg }])])
	}
	if rt.is_true(var_test_type) {
		var_wp_filetype = rt.call_function('wp_check_filetype_and_ext', [var_file.array_get(rt.new_string('tmp_name')), var_file.array_get(rt.new_string('name')), var_mimes.clone()])
		var_ext = if !rt.is_true(var_wp_filetype.array_get(rt.new_string('ext'))) { rt.new_string('') } else { var_wp_filetype.array_get(rt.new_string('ext')) }
		var_type = if !rt.is_true(var_wp_filetype.array_get(rt.new_string('type'))) { rt.new_string('') } else { var_wp_filetype.array_get(rt.new_string('type')) }
		var_proper_filename = if !rt.is_true(var_wp_filetype.array_get(rt.new_string('proper_filename'))) { rt.new_string('') } else { var_wp_filetype.array_get(rt.new_string('proper_filename')) }
		if rt.is_true(var_proper_filename) {
			var_file.array_set('name', var_proper_filename.clone())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_type)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_ext)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('unfiltered_upload')]))))) {
			return rt.call_function('call_user_func_array', [var_upload_error_handler.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_file }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Sorry, you are not allowed to upload this file type.')]) }])])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_type)))) {
		var_type = var_file.array_get(rt.new_string('type'))
		}
	} else {
	var_type = rt.new_string('')
	}
	var_uploads = rt.call_function('wp_upload_dir', [var_time.clone()])
	if !(rt.is_true(var_uploads) && rt.is_true(rt.identical(rt.new_bool(false), var_uploads.array_get(rt.new_string('error'))))) {
		return rt.call_function('call_user_func_array', [var_upload_error_handler.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_file }, rt.ArrayItem{ key: none, val: var_uploads.array_get(rt.new_string('error')) }])])
	}
	var_filename = rt.call_function('wp_unique_filename', [var_uploads.array_get(rt.new_string('path')), var_file.array_get(rt.new_string('name')), var_unique_filename_callback.clone()])
	var_new_file = rt.new_string((var_uploads.array_get(rt.new_string('path'))).str() + "/${var_filename.to_string()}")
	var_move_new_file = rt.call_function('apply_filters', [rt.new_string('pre_move_uploaded_file'), rt.new_null(), var_file.clone(), var_new_file.clone(), var_type.clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_move_new_file)) {
		if rt.is_true(rt.identical(rt.new_string('wp_handle_upload'), var_action)) {
		var_move_new_file = rt.call_function('move_uploaded_file', [var_file.array_get(rt.new_string('tmp_name')), var_new_file.clone()])
		} else {
			var_move_new_file = rt.call_function('copy', [var_file.array_get(rt.new_string('tmp_name')), var_new_file.clone()])
			rt.call_function('unlink', [var_file.array_get(rt.new_string('tmp_name'))])
		}
		if rt.is_true(rt.identical(rt.new_bool(false), var_move_new_file)) {
			if rt.is_true(rt.call_function('str_starts_with', [var_uploads.array_get(rt.new_string('basedir')), rt.get_constant('ABSPATH')])) {
			var_error_path = rt.new_string((rt.call_function('str_replace', [rt.get_constant('ABSPATH'), rt.new_string(''), var_uploads.array_get(rt.new_string('basedir'))])).str() + (var_uploads.array_get(rt.new_string('subdir'))).str())
			} else {
			var_error_path = rt.new_string((rt.call_function('basename', [var_uploads.array_get(rt.new_string('basedir'))])).str() + (var_uploads.array_get(rt.new_string('subdir'))).str())
			}
			return rt.call_callable(var_upload_error_handler, [var_file.clone(), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The uploaded file could not be moved to %s.')]), var_error_path.clone()])])
		}
	}
	var_stat = rt.call_function('stat', [rt.call_function('dirname', [var_new_file.clone()])])
	var_perms = rt.new_int(rt.bitwise_and(var_stat.array_get(rt.new_string('mode')), rt.new_int(438)))
	rt.call_function('chmod', [var_new_file.clone(), var_perms.clone()])
	var_url = rt.new_string((var_uploads.array_get(rt.new_string('url'))).str() + "/${var_filename.to_string()}")
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_function('clean_dirsize_cache', [var_new_file.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_handle_upload'), rt.create_array([rt.ArrayItem{ key: 'file', val: var_new_file }, rt.ArrayItem{ key: 'url', val: var_url }, rt.ArrayItem{ key: 'type', val: var_type }]), rt.new_string((if rt.is_true(rt.identical(rt.new_string('wp_handle_sideload'), var_action)) { 'sideload' } else { 'upload' }).str())])
}

}
