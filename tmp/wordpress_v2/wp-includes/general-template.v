import rt
import crypto.md5

fn get_header(var_name_arg rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_name := var_name_arg
	mut var_templates := []rt.PhpVal{}
	rt.call_function('do_action', [rt.new_string('get_header'), var_name.clone(), var_args.clone()])
	var_templates = []rt.PhpVal{}
	var_name = rt.new_string((var_name).str())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_name)))) {
		var_templates << "header-${var_name.to_string()}.php"
	}
	var_templates << 'header.php'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('locate_template', [rt.create_array_from_list(var_templates), rt.new_bool(true), rt.new_bool(true), var_args.clone()]))))) {
		return false
	}
	return false
}

fn get_footer(var_name_arg rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_name := var_name_arg
	mut var_templates := []rt.PhpVal{}
	rt.call_function('do_action', [rt.new_string('get_footer'), var_name.clone(), var_args.clone()])
	var_templates = []rt.PhpVal{}
	var_name = rt.new_string((var_name).str())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_name)))) {
		var_templates << "footer-${var_name.to_string()}.php"
	}
	var_templates << 'footer.php'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('locate_template', [rt.create_array_from_list(var_templates), rt.new_bool(true), rt.new_bool(true), var_args.clone()]))))) {
		return false
	}
	return false
}

fn get_sidebar(var_name_arg rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_name := var_name_arg
	mut var_templates := []rt.PhpVal{}
	rt.call_function('do_action', [rt.new_string('get_sidebar'), var_name.clone(), var_args.clone()])
	var_templates = []rt.PhpVal{}
	var_name = rt.new_string((var_name).str())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_name)))) {
		var_templates << "sidebar-${var_name.to_string()}.php"
	}
	var_templates << 'sidebar.php'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('locate_template', [rt.create_array_from_list(var_templates), rt.new_bool(true), rt.new_bool(true), var_args.clone()]))))) {
		return false
	}
	return false
}

fn get_template_part(var_slug rt.PhpVal, var_name_arg rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_name := var_name_arg
	mut var_templates := []rt.PhpVal{}
	rt.call_function('do_action', [rt.new_string("get_template_part_${var_slug.to_string()}"), var_slug.clone(), var_name.clone(), var_args.clone()])
	var_templates = []rt.PhpVal{}
	var_name = rt.new_string((var_name).str())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_name)))) {
		var_templates << "${var_slug.to_string()}-${var_name.to_string()}.php"
	}
	var_templates << "${var_slug.to_string()}.php"
	rt.call_function('do_action', [rt.new_string('get_template_part'), var_slug.clone(), var_name.clone(), rt.create_array_from_list(var_templates), var_args.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('locate_template', [rt.create_array_from_list(var_templates), rt.new_bool(true), rt.new_bool(false), var_args.clone()]))))) {
		return false
	}
	return false
}

fn get_search_form(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_echo := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_format := rt.new_null()
	mut var_search_form_template := rt.new_null()
	mut var_form := rt.new_null()
	mut var_aria_label := rt.new_null()
	mut var_result := rt.new_null()
	rt.call_function('do_action', [rt.new_string('pre_get_search_form'), var_args.clone()])
	var_echo = rt.new_bool(true)
	if !(var_args.clone().is_array()) {
	var_echo = rt.new_bool((var_args).to_bool())
	var_args = []rt.PhpVal{}
	}
	var_defaults = { 'echo': var_echo, 'aria_label': rt.new_string('') }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	var_args = rt.call_function('apply_filters', [rt.new_string('search_form_args'), var_args.clone()])
	var_args = rt.call_function('array_merge', [rt.create_array_from_native_map(var_defaults), var_args.clone()])
	var_format = rt.new_string((if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('html5'), rt.new_string('search-form')])) { 'html5' } else { 'xhtml' }).str())
	var_format = rt.call_function('apply_filters', [rt.new_string('search_form_format'), var_format.clone(), var_args.clone()])
	var_search_form_template = rt.call_function('locate_template', [rt.new_string('searchform.php')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_search_form_template)))) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.include_file((var_search_form_template).to_string(), '3')
	var_form = rt.call_function('ob_get_clean', []rt.PhpVal{})
	} else {
		if rt.is_true(var_args.array_get(rt.new_string('aria_label'))) {
		var_aria_label = rt.new_string('aria-label="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('aria_label'))])).str() + '" ')
		} else {
		var_aria_label = rt.new_string('')
		}
		if rt.is_true(rt.identical(rt.new_string('html5'), var_format)) {
		var_form = rt.new_string('<form role="search" ' + (var_aria_label).str() + 'method="get" class="search-form" action="' + (rt.call_function('esc_url', [rt.call_function('home_url', [rt.new_string('/')])])).str() + '">\n\t\t\t\t<label>\n\t\t\t\t\t<span class="screen-reader-text">' + (rt.call_function('_x', [rt.new_string('Search for:'), rt.new_string('label')])).str() + '</span>\n\t\t\t\t\t<input type="search" class="search-field" placeholder="' + (rt.call_function('esc_attr_x', [rt.new_string('Search &hellip;'), rt.new_string('placeholder')])).str() + '" value="' + (get_search_query(false)).str() + '" name="s" />\n\t\t\t\t</label>\n\t\t\t\t<input type="submit" class="search-submit" value="' + (rt.call_function('esc_attr_x', [rt.new_string('Search'), rt.new_string('submit button')])).str() + '" />\n\t\t\t</form>')
		} else {
		var_form = rt.new_string('<form role="search" ' + (var_aria_label).str() + 'method="get" id="searchform" class="searchform" action="' + (rt.call_function('esc_url', [rt.call_function('home_url', [rt.new_string('/')])])).str() + '">\n\t\t\t\t<div>\n\t\t\t\t\t<label class="screen-reader-text" for="s">' + (rt.call_function('_x', [rt.new_string('Search for:'), rt.new_string('label')])).str() + '</label>\n\t\t\t\t\t<input type="text" value="' + (get_search_query(false)).str() + '" name="s" id="s" />\n\t\t\t\t\t<input type="submit" id="searchsubmit" value="' + (rt.call_function('esc_attr_x', [rt.new_string('Search'), rt.new_string('submit button')])).str() + '" />\n\t\t\t\t</div>\n\t\t\t</form>')
		}
	}
	var_result = rt.call_function('apply_filters', [rt.new_string('get_search_form'), var_form.clone(), var_args.clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
	var_result = var_form.clone()
	}
	if rt.is_true(var_args.array_get(rt.new_string('echo'))) {
		rt.echo_val(var_result)
	} else {
		return var_result.clone()
	}
	return rt.new_null()
}

fn wp_loginout(redirect string, display bool) rt.PhpVal {
	mut var_redirect := redirect
	mut var_display := display
	mut var_link := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
	var_link = rt.new_string('<a href="' + (rt.call_function('esc_url', [wp_login_url(redirect, false)])).str() + '">' + (rt.call_function('__', [rt.new_string('Log in')])).str() + '</a>')
	} else {
	var_link = rt.new_string('<a href="' + (rt.call_function('esc_url', [wp_logout_url(redirect)])).str() + '">' + (rt.call_function('__', [rt.new_string('Log out')])).str() + '</a>')
	}
	if var_display {
		rt.echo_val(rt.call_function('apply_filters', [rt.new_string('loginout'), var_link.clone()]))
	} else {
		return rt.call_function('apply_filters', [rt.new_string('loginout'), var_link.clone()])
	}
	return rt.new_null()
}

fn wp_logout_url(redirect string) rt.PhpVal {
	mut var_redirect := redirect
	mut var_args := rt.new_null()
	mut var_logout_url := rt.new_null()
	var_args = []rt.PhpVal{}
	if !(redirect == '') {
		var_args.array_set('redirect_to', rt.call_function('urlencode', [rt.new_string(redirect)]))
	}
	var_logout_url = rt.call_function('add_query_arg', [var_args.clone(), rt.call_function('site_url', [rt.new_string('wp-login.php?action=logout'), rt.new_string('login')])])
	var_logout_url = rt.call_function('wp_nonce_url', [var_logout_url.clone(), rt.new_string('log-out')])
	return rt.call_function('apply_filters', [rt.new_string('logout_url'), var_logout_url.clone(), rt.new_string(redirect)])
}

fn wp_login_url(redirect string, force_reauth bool) rt.PhpVal {
	mut var_redirect := redirect
	mut var_force_reauth := force_reauth
	mut var_login_url := rt.new_null()
	var_login_url = rt.call_function('site_url', [rt.new_string('wp-login.php'), rt.new_string('login')])
	if !(redirect == '') {
	var_login_url = rt.call_function('add_query_arg', [rt.new_string('redirect_to'), rt.call_function('urlencode', [rt.new_string(redirect)]), var_login_url.clone()])
	}
	if var_force_reauth {
	var_login_url = rt.call_function('add_query_arg', [rt.new_string('reauth'), rt.new_string('1'), var_login_url.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('login_url'), var_login_url.clone(), rt.new_string(redirect), rt.new_bool(force_reauth)])
}

fn wp_registration_url() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('register_url'), rt.call_function('site_url', [rt.new_string('wp-login.php?action=register'), rt.new_string('login')])])
}

fn wp_login_form(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_login_form_top := rt.new_null()
	mut var_login_form_middle := rt.new_null()
	mut var_login_form_bottom := rt.new_null()
	mut var_direction_style := ''
	mut var_form := rt.new_null()
	var_defaults = { 'echo': rt.new_bool(true), 'redirect': if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) { 'https://' } else { 'http://' } + (rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))).str() + (rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).str(), 'form_id': rt.new_string('loginform'), 'label_username': rt.call_function('__', [rt.new_string('Username or Email Address')]), 'label_password': rt.call_function('__', [rt.new_string('Password')]), 'label_remember': rt.call_function('__', [rt.new_string('Remember Me')]), 'label_log_in': rt.call_function('__', [rt.new_string('Log In')]), 'id_username': rt.new_string('user_login'), 'id_password': rt.new_string('user_pass'), 'id_remember': rt.new_string('rememberme'), 'id_submit': rt.new_string('wp-submit'), 'remember': rt.new_bool(true), 'value_username': rt.new_string(''), 'value_remember': rt.new_bool(false), 'required_username': rt.new_bool(false), 'required_password': rt.new_bool(false) }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.call_function('apply_filters', [rt.new_string('login_form_defaults'), rt.create_array_from_native_map(var_defaults)])])
	var_login_form_top = rt.call_function('apply_filters', [rt.new_string('login_form_top'), rt.new_string(''), var_args.clone()])
	var_login_form_middle = rt.call_function('apply_filters', [rt.new_string('login_form_middle'), rt.new_string(''), var_args.clone()])
	var_login_form_bottom = rt.call_function('apply_filters', [rt.new_string('login_form_bottom'), rt.new_string(''), var_args.clone()])
	var_direction_style = if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { ' style="direction: ltr;"' } else { '' }
	var_form = rt.new_string((rt.call_function('sprintf', [rt.new_string('<form name="%1$s" id="%1$s" action="%2$s" method="post">'), rt.call_function('esc_attr', [var_args.array_get(rt.new_string('form_id'))]), rt.call_function('esc_url', [rt.call_function('site_url', [rt.new_string('wp-login.php'), rt.new_string('login_post')])])])).str() + (var_login_form_top).str() + (rt.call_function('sprintf', [rt.new_string('<p class="login-username">\n\t\t\t\t<label for="%1$s">%2$s</label>\n\t\t\t\t<input type="text" name="log" id="%1$s" autocomplete="username" class="input" value="%3$s" size="20"%4$s%5$s />\n\t\t\t</p>'), rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id_username'))]), rt.call_function('esc_html', [var_args.array_get(rt.new_string('label_username'))]), rt.call_function('esc_attr', [var_args.array_get(rt.new_string('value_username'))]), rt.new_string((if rt.is_true(var_args.array_get(rt.new_string('required_username'))) { ' required="required"' } else { '' }).str()), rt.new_string((var_direction_style).str()).clone()])).str() + (rt.call_function('sprintf', [rt.new_string('<p class="login-password">\n\t\t\t\t<label for="%1$s">%2$s</label>\n\t\t\t\t<input type="password" name="pwd" id="%1$s" autocomplete="current-password" spellcheck="false" class="input" value="" size="20"%3$s%4$s />\n\t\t\t</p>'), rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id_password'))]), rt.call_function('esc_html', [var_args.array_get(rt.new_string('label_password'))]), rt.new_string((if rt.is_true(var_args.array_get(rt.new_string('required_password'))) { ' required="required"' } else { '' }).str()), rt.new_string((var_direction_style).str()).clone()])).str() + (var_login_form_middle).str() + (if rt.is_true(var_args.array_get(rt.new_string('remember'))) { rt.call_function('sprintf', [rt.new_string('<p class="login-remember"><label><input name="rememberme" type="checkbox" id="%1$s" value="forever"%2$s /> %3$s</label></p>'), rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id_remember'))]), rt.new_string((if rt.is_true(var_args.array_get(rt.new_string('value_remember'))) { ' checked="checked"' } else { '' }).str()), rt.call_function('esc_html', [var_args.array_get(rt.new_string('label_remember'))])]) } else { rt.new_string('') }).str() + (rt.call_function('sprintf', [rt.new_string('<p class="login-submit">\n\t\t\t\t<input type="submit" name="wp-submit" id="%1$s" class="button button-primary" value="%2$s" />\n\t\t\t\t<input type="hidden" name="redirect_to" value="%3$s" />\n\t\t\t</p>'), rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id_submit'))]), rt.call_function('esc_attr', [var_args.array_get(rt.new_string('label_log_in'))]), rt.call_function('esc_url', [var_args.array_get(rt.new_string('redirect'))])])).str() + (var_login_form_bottom).str() + '</form>')
	if rt.is_true(var_args.array_get(rt.new_string('echo'))) {
		rt.echo_val(var_form)
	} else {
		return var_form.clone()
	}
	return rt.new_null()
}

fn wp_lostpassword_url(redirect string) rt.PhpVal {
	mut var_redirect := redirect
	mut var_args := rt.new_null()
	mut var_blog_details := rt.new_null()
	mut var_wp_login_path := rt.new_null()
	mut var_lostpassword_url := rt.new_null()
	var_args = rt.create_array([rt.ArrayItem{ key: 'action', val: 'lostpassword' }])
	if !(redirect == '') {
		var_args.array_set('redirect_to', rt.call_function('urlencode', [rt.new_string(redirect)]))
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
	var_blog_details = rt.call_function('get_site', []rt.PhpVal{})
	var_wp_login_path = rt.new_string((rt.get_property(var_blog_details, 'path')).str() + 'wp-login.php')
	} else {
	var_wp_login_path = rt.new_string('wp-login.php')
	}
	var_lostpassword_url = rt.call_function('add_query_arg', [var_args.clone(), rt.call_function('network_site_url', [var_wp_login_path.clone(), rt.new_string('login')])])
	return rt.call_function('apply_filters', [rt.new_string('lostpassword_url'), var_lostpassword_url.clone(), rt.new_string(redirect)])
}

fn wp_register(before string, after string, display bool) rt.PhpVal {
	mut var_before := before
	mut var_after := after
	mut var_display := display
	mut var_link := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		if rt.is_true(rt.call_function('get_option', [rt.new_string('users_can_register')])) {
		var_link = rt.new_string(before + '<a href="' + (rt.call_function('esc_url', [wp_registration_url()])).str() + '">' + (rt.call_function('__', [rt.new_string('Register')])).str() + '</a>' + after)
		} else {
		var_link = rt.new_string('')
		}
	} else if rt.is_true(rt.call_function('current_user_can', [rt.new_string('read')])) {
	var_link = rt.new_string(before + '<a href="' + (rt.call_function('admin_url', []rt.PhpVal{})).str() + '">' + (rt.call_function('__', [rt.new_string('Site Admin')])).str() + '</a>' + after)
	} else {
	var_link = rt.new_string('')
	}
	var_link = rt.call_function('apply_filters', [rt.new_string('register'), var_link.clone()])
	if var_display {
		rt.echo_val(var_link)
	} else {
		return var_link.clone()
	}
	return rt.new_null()
}

fn wp_meta() {
	rt.call_function('do_action', [rt.new_string('wp_meta')])
}

fn bloginfo(show string) {
	mut var_show := show
	rt.echo_val(get_bloginfo(show, 'display'))
}

fn get_bloginfo(show string, filter string) rt.PhpVal {
	mut var_show := show
	mut var_filter := filter
	mut var_wp_version := rt.new_null()
	mut var_output := rt.new_null()
	mut switch_val_1 := rt.new_string(show)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('home'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('siteurl'))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('2.2.0'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %1$s option is deprecated for the family of %2$s functions. Use the %3$s option instead.')]), rt.new_string('<code>' + show + '</code>'), rt.new_string('<code>bloginfo()</code>'), rt.new_string('<code>url</code>')])])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('url'))) {
	var_output = rt.call_function('home_url', []rt.PhpVal{})
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wpurl'))) {
	var_output = rt.call_function('site_url', []rt.PhpVal{})
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('description'))) {
	var_output = rt.call_function('get_option', [rt.new_string('blogdescription')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('rdf_url'))) {
	var_output = rt.call_function('get_feed_link', [rt.new_string('rdf')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('rss_url'))) {
	var_output = rt.call_function('get_feed_link', [rt.new_string('rss')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('rss2_url'))) {
	var_output = rt.call_function('get_feed_link', [rt.new_string('rss2')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('atom_url'))) {
	var_output = rt.call_function('get_feed_link', [rt.new_string('atom')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('comments_atom_url'))) {
	var_output = rt.call_function('get_feed_link', [rt.new_string('comments_atom')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('comments_rss2_url'))) {
	var_output = rt.call_function('get_feed_link', [rt.new_string('comments_rss2')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('pingback_url'))) {
	var_output = rt.call_function('site_url', [rt.new_string('xmlrpc.php')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('stylesheet_url'))) {
	var_output = rt.call_function('get_stylesheet_uri', []rt.PhpVal{})
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('stylesheet_directory'))) {
	var_output = rt.call_function('get_stylesheet_directory_uri', []rt.PhpVal{})
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('template_directory'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('template_url'))) {
	var_output = rt.call_function('get_template_directory_uri', []rt.PhpVal{})
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('admin_email'))) {
	var_output = rt.call_function('get_option', [rt.new_string('admin_email')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('charset'))) {
		var_output = rt.call_function('get_option', [rt.new_string('blog_charset')])
		if rt.is_true(rt.identical(rt.new_string(''), var_output)) {
		var_output = rt.new_string('UTF-8')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('html_type'))) {
	var_output = rt.call_function('get_option', [rt.new_string('html_type')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('version'))) {
	var_output = var_wp_version
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('language'))) {
		var_output = rt.call_function('__', [rt.new_string('html_lang_attribute')])
		if rt.is_true(rt.identical(rt.new_string('html_lang_attribute'), var_output)) || rt.is_true(rt.call_function('preg_match', [rt.new_string('/[^a-zA-Z0-9-]/'), var_output.clone()])) {
		var_output = rt.call_function('determine_locale', []rt.PhpVal{})
		var_output = rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), var_output.clone()])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('text_direction'))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('2.2.0'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %1$s option is deprecated for the family of %2$s functions. Use the %3$s function instead.')]), rt.new_string('<code>' + show + '</code>'), rt.new_string('<code>bloginfo()</code>'), rt.new_string('<code>is_rtl()</code>')])])
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('is_rtl')])) {
		var_output = rt.new_string((if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'rtl' } else { 'ltr' }).str())
		} else {
		var_output = rt.new_string('ltr')
		}
	} else {
	var_output = rt.call_function('get_option', [rt.new_string('blogname')])
	}
	if rt.is_true(rt.identical(rt.new_string('display'), rt.new_string(filter))) {
		if rt.is_true(rt.call_function('str_contains', [rt.new_string(show), rt.new_string('url')])) || rt.is_true(rt.call_function('str_contains', [rt.new_string(show), rt.new_string('directory')])) || rt.is_true(rt.call_function('str_contains', [rt.new_string(show), rt.new_string('home')])) {
		var_output = rt.call_function('apply_filters', [rt.new_string('bloginfo_url'), var_output.clone(), rt.new_string(show)])
		} else {
		var_output = rt.call_function('apply_filters', [rt.new_string('bloginfo'), var_output.clone(), rt.new_string(show)])
		}
	}
	return var_output.clone()
}

fn get_site_icon_url(size i64, url string, blog_id i64) rt.PhpVal {
	mut var_size := size
	mut var_url := url
	mut var_blog_id := blog_id
	mut var_switched_blog := false
	mut var_site_icon_id := rt.new_null()
	mut var_size_data := rt.new_null()
	var_switched_blog = false
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && !(blog_id == 0) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), blog_id)))) {
		rt.call_function('switch_to_blog', [rt.new_int(blog_id)])
	var_switched_blog = true
	}
	var_site_icon_id = rt.new_int((rt.call_function('get_option', [rt.new_string('site_icon')])).to_i64())
	if rt.is_true(var_site_icon_id) {
		if size >= 512 {
		var_size_data = rt.new_string('full')
		} else {
		var_size_data = rt.create_array([rt.ArrayItem{ key: none, val: size }, rt.ArrayItem{ key: none, val: size }])
		}
	var_url = (rt.call_function('wp_get_attachment_image_url', [var_site_icon_id.clone(), var_size_data.clone()])).str()
	}
	if var_switched_blog {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
	return rt.call_function('apply_filters', [rt.new_string('get_site_icon_url'), rt.new_string((var_url).str()), rt.new_int(size), rt.new_int(blog_id)])
}

fn site_icon_url(size i64, url string, blog_id i64) {
	mut var_size := size
	mut var_url := url
	mut var_blog_id := blog_id
	rt.echo_val(rt.call_function('esc_url', [get_site_icon_url(size, var_url, blog_id)]))
}

fn has_site_icon(blog_id i64) bool {
	mut var_blog_id := blog_id
	return (get_site_icon_url(512, '', blog_id)).to_bool()
}

fn has_custom_logo(blog_id i64) rt.PhpVal {
	mut var_blog_id := blog_id
	mut var_switched_blog := false
	mut var_custom_logo_id := rt.new_null()
	mut var_is_image := rt.new_null()
	var_switched_blog = false
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && !(blog_id == 0) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), blog_id)))) {
		rt.call_function('switch_to_blog', [rt.new_int(blog_id)])
	var_switched_blog = true
	}
	var_custom_logo_id = rt.call_function('get_theme_mod', [rt.new_string('custom_logo')])
	var_is_image = if rt.is_true(var_custom_logo_id) { rt.call_function('wp_attachment_is_image', [var_custom_logo_id.clone()]) } else { rt.new_bool(false) }
	if var_switched_blog {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
	return var_is_image.clone()
}

fn get_custom_logo(blog_id i64) rt.PhpVal {
	mut var_blog_id := blog_id
	mut var_html := rt.new_null()
	mut var_switched_blog := false
	mut var_custom_logo_id := rt.new_null()
	mut var_custom_logo_attr := rt.new_null()
	mut var_unlink_homepage_logo := rt.new_null()
	mut var_image_alt := rt.new_null()
	mut var_image := rt.new_null()
	mut var_aria_current := ''
	var_html = rt.new_string('')
	var_switched_blog = false
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && !(blog_id == 0) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), blog_id)))) {
		rt.call_function('switch_to_blog', [rt.new_int(blog_id)])
	var_switched_blog = true
	}
	if rt.is_true(has_custom_logo(0)) {
		var_custom_logo_id = rt.call_function('get_theme_mod', [rt.new_string('custom_logo')])
		var_custom_logo_attr = rt.create_array([rt.ArrayItem{ key: 'class', val: 'custom-logo' }, rt.ArrayItem{ key: 'loading', val: false }])
		var_unlink_homepage_logo = rt.new_bool((rt.call_function('get_theme_support', [rt.new_string('custom-logo'), rt.new_string('unlink-homepage-logo')])).to_bool())
		if rt.is_true(var_unlink_homepage_logo) && rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_paged', []rt.PhpVal{}))))) {
			var_custom_logo_attr.array_set('alt', '')
		} else {
			var_image_alt = rt.call_function('get_post_meta', [var_custom_logo_id.clone(), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)])
			if !rt.is_true(var_image_alt) {
				var_custom_logo_attr.array_set('alt', get_bloginfo('name', 'display'))
			}
		}
		var_custom_logo_attr = rt.call_function('apply_filters', [rt.new_string('get_custom_logo_image_attributes'), var_custom_logo_attr.clone(), var_custom_logo_id.clone(), rt.new_int(blog_id)])
		var_image = rt.call_function('wp_get_attachment_image', [var_custom_logo_id.clone(), rt.new_string('full'), rt.new_bool(false), var_custom_logo_attr.clone()])
		if rt.is_true(var_image) {
			if rt.is_true(var_unlink_homepage_logo) && rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_paged', []rt.PhpVal{}))))) {
			var_html = rt.call_function('sprintf', [rt.new_string('<span class="custom-logo-link">%1$s</span>'), var_image.clone()])
			} else {
			var_aria_current = if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_paged', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) || (rt.is_true(rt.call_function('is_home', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('page_for_posts')])).to_i64()), rt.call_function('get_queried_object_id', []rt.PhpVal{})))))) { ' aria-current="page"' } else { '' }
			var_html = rt.call_function('sprintf', [rt.new_string('<a href="%1$s" class="custom-logo-link" rel="home"%2$s>%3$s</a>'), rt.call_function('esc_url', [rt.call_function('home_url', [rt.new_string('/')])]), rt.new_string((var_aria_current).str()).clone(), var_image.clone()])
			}
		}
	} else if rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})) {
	var_html = rt.call_function('sprintf', [rt.new_string('<a href="%1$s" class="custom-logo-link" style="display:none;"><img class="custom-logo" alt="" /></a>'), rt.call_function('esc_url', [rt.call_function('home_url', [rt.new_string('/')])])])
	}
	if var_switched_blog {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
	return rt.call_function('apply_filters', [rt.new_string('get_custom_logo'), var_html.clone(), rt.new_int(blog_id)])
}

fn the_custom_logo(blog_id i64) {
	mut var_blog_id := blog_id
	rt.echo_val(get_custom_logo(blog_id))
}

fn wp_get_document_title() rt.PhpVal {
	mut var_page := rt.new_null()
	mut var_paged := rt.new_null()
	mut var_title := rt.new_null()
	mut var_author := rt.new_null()
	mut var_sep := rt.new_null()
	var_title = rt.call_function('apply_filters', [rt.new_string('pre_get_document_title'), rt.new_string('')])
	if !(!rt.is_true(var_title)) {
		return var_title.clone()
	}
	var_title = rt.create_array([rt.ArrayItem{ key: 'title', val: '' }])
	if rt.is_true(rt.call_function('is_404', []rt.PhpVal{})) {
		var_title.array_set('title', rt.call_function('__', [rt.new_string('Page not found')]))
	} else if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
		var_title.array_set('title', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Search Results for &#8220;%s&#8221;')]), get_search_query(false)]))
	} else if rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) {
		var_title.array_set('title', get_bloginfo('name', 'display'))
	} else if rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{})) {
		var_title.array_set('title', post_type_archive_title('', false))
	} else if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
		var_title.array_set('title', single_term_title('', false))
	} else if rt.is_true(rt.call_function('is_home', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) {
		var_title.array_set('title', single_post_title('', false))
	} else if rt.is_true(rt.call_function('is_category', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_tag', []rt.PhpVal{})) {
		var_title.array_set('title', single_term_title('', false))
	} else if rt.is_true(rt.call_function('is_author', []rt.PhpVal{})) && rt.is_true(rt.call_function('get_queried_object', []rt.PhpVal{})) {
		var_author = rt.call_function('get_queried_object', []rt.PhpVal{})
		var_title.array_set('title', rt.get_property(var_author, 'display_name'))
	} else if rt.is_true(rt.call_function('is_year', []rt.PhpVal{})) {
		var_title.array_set('title', get_the_date(rt.call_function('_x', [rt.new_string('Y'), rt.new_string('yearly archives date format')])))
	} else if rt.is_true(rt.call_function('is_month', []rt.PhpVal{})) {
		var_title.array_set('title', get_the_date(rt.call_function('_x', [rt.new_string('F Y'), rt.new_string('monthly archives date format')])))
	} else if rt.is_true(rt.call_function('is_day', []rt.PhpVal{})) {
		var_title.array_set('title', get_the_date())
	}
	if rt.is_true(rt.greater_equal(var_paged, rt.new_int(2))) || rt.is_true(rt.greater_equal(var_page, rt.new_int(2))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_404', []rt.PhpVal{}))))) {
		var_title.array_set('page', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Page %s')]), rt.call_function('max', [var_paged.clone(), var_page.clone()])]))
	}
	if rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) {
		var_title.array_set('tagline', get_bloginfo('description', 'display'))
	} else {
		var_title.array_set('site', get_bloginfo('name', 'display'))
	}
	var_sep = rt.call_function('apply_filters', [rt.new_string('document_title_separator'), rt.new_string('-')])
	var_title = rt.call_function('apply_filters', [rt.new_string('document_title_parts'), var_title.clone()])
	var_title = rt.call_function('implode', [rt.new_string(" ${var_sep.to_string()} "), rt.call_function('array_filter', [var_title.clone()])])
	var_title = rt.call_function('apply_filters', [rt.new_string('document_title'), var_title.clone()])
	return var_title.clone()
}

fn _wp_render_title_tag() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('title-tag')]))))) {
		return
	}
	print('<title>' + (wp_get_document_title()).str() + '</title>' + '\n')
}

fn wp_title(sep string, display bool, seplocation string) rt.PhpVal {
	mut var_sep := sep
	mut var_display := display
	mut var_seplocation := seplocation
	mut var_wp_locale := rt.new_null()
	mut var_m := rt.new_null()
	mut var_year := rt.new_null()
	mut var_monthnum := rt.new_null()
	mut var_day := rt.new_null()
	mut var_search := rt.new_null()
	mut var_title := rt.new_null()
	mut var_t_sep := ''
	mut var_post_type := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_term := rt.new_null()
	mut var_tax := rt.new_null()
	mut var_author := rt.new_null()
	mut var_my_year := rt.new_null()
	mut var_my_month := rt.new_null()
	mut var_my_day := rt.new_null()
	mut var_prefix := ''
	mut var_title_array := rt.new_null()
	var_m = rt.call_function('get_query_var', [rt.new_string('m')])
	var_year = rt.call_function('get_query_var', [rt.new_string('year')])
	var_monthnum = rt.call_function('get_query_var', [rt.new_string('monthnum')])
	var_day = rt.call_function('get_query_var', [rt.new_string('day')])
	var_search = rt.call_function('get_query_var', [rt.new_string('s')])
	var_title = rt.new_string('')
	var_t_sep = '%WP_TITLE_SEP%'
	if (rt.is_true(rt.call_function('is_single', []rt.PhpVal{})) || (rt.is_true(rt.call_function('is_home', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{}))))))) || (rt.is_true(rt.call_function('is_page', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})))))) {
	var_title = single_post_title('', false)
	}
	if rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{})) {
		var_post_type = rt.call_function('get_query_var', [rt.new_string('post_type')])
		if rt.is_true(rt.new_bool(var_post_type.clone().is_array())) {
		var_post_type = rt.call_function('reset', [var_post_type.clone()])
		}
		var_post_type_object = rt.call_function('get_post_type_object', [var_post_type.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_type_object, 'has_archive'))))) {
		var_title = post_type_archive_title('', false)
		}
	}
	if rt.is_true(rt.call_function('is_category', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_tag', []rt.PhpVal{})) {
	var_title = single_term_title('', false)
	}
	if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
		var_term = rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(var_term) {
		var_tax = rt.call_function('get_taxonomy', [rt.get_property(var_term, 'taxonomy')])
		var_title = single_term_title((rt.get_property(rt.get_property(var_tax, 'labels'), 'name')).str() + var_t_sep, false)
		}
	}
	if rt.is_true(rt.call_function('is_author', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{}))))) {
		var_author = rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(var_author) {
		var_title = rt.get_property(var_author, 'display_name')
		}
	}
	if rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{})) && rt.is_true(rt.get_property(var_post_type_object, 'has_archive')) {
	var_title = post_type_archive_title('', false)
	}
	if rt.is_true(rt.call_function('is_archive', []rt.PhpVal{})) && !(!rt.is_true(var_m)) {
	var_my_year = rt.call_function('substr', [var_m.clone(), rt.new_int(0), rt.new_int(4)])
	var_my_month = rt.call_function('substr', [var_m.clone(), rt.new_int(4), rt.new_int(2)])
	var_my_day = rt.new_int((rt.call_function('substr', [var_m.clone(), rt.new_int(6), rt.new_int(2)])).to_i64())
	var_title = rt.new_string((var_my_year).str() + if rt.is_true(var_my_month) { var_t_sep + (rt.call_method(var_wp_locale, 'get_month', [var_my_month.clone()])).str() } else { '' } + if rt.is_true(var_my_day) { var_t_sep + (var_my_day).str() } else { '' })
	}
	if rt.is_true(rt.call_function('is_archive', []rt.PhpVal{})) && !(!rt.is_true(var_year)) {
		var_title = var_year.clone()
		if !(!rt.is_true(var_monthnum)) {
			var_title = rt.concat(var_title, rt.new_string(var_t_sep + (rt.call_method(var_wp_locale, 'get_month', [var_monthnum.clone()])).str()))
		}
		if !(!rt.is_true(var_day)) {
			var_title = rt.concat(var_title, rt.new_string(var_t_sep + (rt.call_function('zeroise', [var_day.clone(), rt.new_int(2)])).str()))
		}
	}
	if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
	var_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Search Results %1$s %2$s')]), rt.new_string((var_t_sep).str()).clone(), rt.call_function('strip_tags', [var_search.clone()])])
	}
	if rt.is_true(rt.call_function('is_404', []rt.PhpVal{})) {
	var_title = rt.call_function('__', [rt.new_string('Page not found')])
	}
	if !(var_title.clone().is_string()) {
	var_title = rt.new_string('')
	}
	var_prefix = ''
	var_title_array = []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_title)))) {
	var_prefix = " ${var_sep} "
	var_title_array = rt.call_function('explode', [rt.new_string((var_t_sep).str()).clone(), var_title.clone()])
	}
	var_title_array = rt.call_function('apply_filters', [rt.new_string('wp_title_parts'), var_title_array.clone()])
	if rt.is_true(rt.identical(rt.new_string('right'), rt.new_string(seplocation))) {
	var_title_array = rt.call_function('array_reverse', [var_title_array.clone()])
	var_title = rt.new_string((rt.call_function('implode', [rt.new_string(" ${var_sep} "), var_title_array.clone()])).str() + var_prefix)
	} else {
	var_title = rt.new_string((var_prefix + (rt.call_function('implode', [rt.new_string(" ${var_sep} "), var_title_array.clone()])).str()).str())
	}
	var_title = rt.call_function('apply_filters', [rt.new_string('wp_title'), var_title.clone(), rt.new_string(sep), rt.new_string(seplocation)])
	if var_display {
		rt.echo_val(var_title)
	} else {
		return var_title.clone()
	}
	return rt.new_null()
}

fn single_post_title(prefix string, display bool) rt.PhpVal {
	mut var_prefix := prefix
	mut var_display := display
	mut var__post := rt.new_null()
	mut var_title := rt.new_null()
	var__post = rt.call_function('get_queried_object', []rt.PhpVal{})
	if !(!(rt.get_property(var__post, 'post_title')).is_null()) {
		return rt.new_null()
	}
	var_title = rt.call_function('apply_filters', [rt.new_string('single_post_title'), rt.get_property(var__post, 'post_title'), var__post.clone()])
	if var_display {
		print(prefix + (var_title).str())
	} else {
		return rt.new_string(prefix + (var_title).str())
	}
	return rt.new_null()
}

fn post_type_archive_title(prefix string, display bool) rt.PhpVal {
	mut var_prefix := prefix
	mut var_display := display
	mut var_post_type := rt.new_null()
	mut var_post_type_obj := rt.new_null()
	mut var_title := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	var_post_type = rt.call_function('get_query_var', [rt.new_string('post_type')])
	if rt.is_true(rt.new_bool(var_post_type.clone().is_array())) {
	var_post_type = rt.call_function('reset', [var_post_type.clone()])
	}
	var_post_type_obj = rt.call_function('get_post_type_object', [var_post_type.clone()])
	var_title = rt.call_function('apply_filters', [rt.new_string('post_type_archive_title'), rt.get_property(rt.get_property(var_post_type_obj, 'labels'), 'name'), var_post_type.clone()])
	if var_display {
		print(prefix + (var_title).str())
	} else {
		return rt.new_string(prefix + (var_title).str())
	}
	return rt.new_null()
}

fn single_cat_title(prefix string, display bool) rt.PhpVal {
	mut var_prefix := prefix
	mut var_display := display
	return single_term_title(prefix, display)
}

fn single_tag_title(prefix string, display bool) rt.PhpVal {
	mut var_prefix := prefix
	mut var_display := display
	return single_term_title(prefix, display)
}

fn single_term_title(prefix string, display bool) rt.PhpVal {
	mut var_prefix := prefix
	mut var_display := display
	mut var_term := rt.new_null()
	mut var_term_name := rt.new_null()
	var_term = rt.call_function('get_queried_object', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_category', []rt.PhpVal{})) {
	var_term_name = rt.call_function('apply_filters', [rt.new_string('single_cat_title'), rt.get_property(var_term, 'name')])
	} else if rt.is_true(rt.call_function('is_tag', []rt.PhpVal{})) {
	var_term_name = rt.call_function('apply_filters', [rt.new_string('single_tag_title'), rt.get_property(var_term, 'name')])
	} else if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
	var_term_name = rt.call_function('apply_filters', [rt.new_string('single_term_title'), rt.get_property(var_term, 'name')])
	} else {
		return rt.new_null()
	}
	if !rt.is_true(var_term_name) {
		return rt.new_null()
	}
	if var_display {
		print(prefix + (var_term_name).str())
	} else {
		return rt.new_string(prefix + (var_term_name).str())
	}
	return rt.new_null()
}

fn single_month_title(prefix string, display bool) bool {
	mut var_prefix := prefix
	mut var_display := display
	mut var_wp_locale := rt.new_null()
	mut var_m := rt.new_null()
	mut var_year := rt.new_null()
	mut var_monthnum := rt.new_null()
	mut var_my_year := rt.new_null()
	mut var_my_month := rt.new_null()
	mut var_result := rt.new_null()
	var_m = rt.call_function('get_query_var', [rt.new_string('m')])
	var_year = rt.call_function('get_query_var', [rt.new_string('year')])
	var_monthnum = rt.call_function('get_query_var', [rt.new_string('monthnum')])
	if !(!rt.is_true(var_monthnum)) && !(!rt.is_true(var_year)) {
	var_my_year = var_year.clone()
	var_my_month = rt.call_method(var_wp_locale, 'get_month', [var_monthnum.clone()])
	} else if !(!rt.is_true(var_m)) {
	var_my_year = rt.call_function('substr', [var_m.clone(), rt.new_int(0), rt.new_int(4)])
	var_my_month = rt.call_method(var_wp_locale, 'get_month', [rt.call_function('substr', [var_m.clone(), rt.new_int(4), rt.new_int(2)])])
	}
	if !rt.is_true(var_my_month) {
		return false
	}
	var_result = rt.new_string(prefix + (var_my_month).str() + prefix + (var_my_year).str())
	if !(var_display) {
		return (var_result).to_bool()
	}
	rt.echo_val(var_result)
	return false
}

fn the_archive_title(before string, after string) {
	mut var_before := before
	mut var_after := after
	mut var_title := rt.new_null()
	var_title = get_the_archive_title()
	if !(!rt.is_true(var_title)) {
		print(before + (var_title).str() + after)
	}
}

fn get_the_archive_title() rt.PhpVal {
	mut var_title := rt.new_null()
	mut var_prefix := rt.new_null()
	mut var_queried_object := rt.new_null()
	mut var_tax := rt.new_null()
	mut var_original_title := rt.new_null()
	var_title = rt.call_function('__', [rt.new_string('Archives')])
	var_prefix = rt.new_string('')
	if rt.is_true(rt.call_function('is_category', []rt.PhpVal{})) {
	var_title = single_cat_title('', false)
	var_prefix = rt.call_function('_x', [rt.new_string('Category:'), rt.new_string('category archive title prefix')])
	} else if rt.is_true(rt.call_function('is_tag', []rt.PhpVal{})) {
	var_title = single_tag_title('', false)
	var_prefix = rt.call_function('_x', [rt.new_string('Tag:'), rt.new_string('tag archive title prefix')])
	} else if rt.is_true(rt.call_function('is_author', []rt.PhpVal{})) {
	var_title = rt.call_function('get_the_author', []rt.PhpVal{})
	var_prefix = rt.call_function('_x', [rt.new_string('Author:'), rt.new_string('author archive title prefix')])
	} else if rt.is_true(rt.call_function('is_year', []rt.PhpVal{})) {
	var_title = rt.new_bool(get_the_date(rt.call_function('_x', [rt.new_string('Y'), rt.new_string('yearly archives date format')]), rt.new_null()))
	var_prefix = rt.call_function('_x', [rt.new_string('Year:'), rt.new_string('date archive title prefix')])
	} else if rt.is_true(rt.call_function('is_month', []rt.PhpVal{})) {
	var_title = rt.new_bool(get_the_date(rt.call_function('_x', [rt.new_string('F Y'), rt.new_string('monthly archives date format')]), rt.new_null()))
	var_prefix = rt.call_function('_x', [rt.new_string('Month:'), rt.new_string('date archive title prefix')])
	} else if rt.is_true(rt.call_function('is_day', []rt.PhpVal{})) {
	var_title = rt.new_bool(get_the_date(rt.call_function('_x', [rt.new_string('F j, Y'), rt.new_string('daily archives date format')]), rt.new_null()))
	var_prefix = rt.call_function('_x', [rt.new_string('Day:'), rt.new_string('date archive title prefix')])
	} else if rt.is_true(rt.call_function('is_tax', [rt.new_string('post_format')])) {
		if rt.is_true(rt.call_function('is_tax', [rt.new_string('post_format'), rt.new_string('post-format-aside')])) {
		var_title = rt.call_function('_x', [rt.new_string('Asides'), rt.new_string('post format archive title')])
		} else if rt.is_true(rt.call_function('is_tax', [rt.new_string('post_format'), rt.new_string('post-format-gallery')])) {
		var_title = rt.call_function('_x', [rt.new_string('Galleries'), rt.new_string('post format archive title')])
		} else if rt.is_true(rt.call_function('is_tax', [rt.new_string('post_format'), rt.new_string('post-format-image')])) {
		var_title = rt.call_function('_x', [rt.new_string('Images'), rt.new_string('post format archive title')])
		} else if rt.is_true(rt.call_function('is_tax', [rt.new_string('post_format'), rt.new_string('post-format-video')])) {
		var_title = rt.call_function('_x', [rt.new_string('Videos'), rt.new_string('post format archive title')])
		} else if rt.is_true(rt.call_function('is_tax', [rt.new_string('post_format'), rt.new_string('post-format-quote')])) {
		var_title = rt.call_function('_x', [rt.new_string('Quotes'), rt.new_string('post format archive title')])
		} else if rt.is_true(rt.call_function('is_tax', [rt.new_string('post_format'), rt.new_string('post-format-link')])) {
		var_title = rt.call_function('_x', [rt.new_string('Links'), rt.new_string('post format archive title')])
		} else if rt.is_true(rt.call_function('is_tax', [rt.new_string('post_format'), rt.new_string('post-format-status')])) {
		var_title = rt.call_function('_x', [rt.new_string('Statuses'), rt.new_string('post format archive title')])
		} else if rt.is_true(rt.call_function('is_tax', [rt.new_string('post_format'), rt.new_string('post-format-audio')])) {
		var_title = rt.call_function('_x', [rt.new_string('Audio'), rt.new_string('post format archive title')])
		} else if rt.is_true(rt.call_function('is_tax', [rt.new_string('post_format'), rt.new_string('post-format-chat')])) {
		var_title = rt.call_function('_x', [rt.new_string('Chats'), rt.new_string('post format archive title')])
		}
	} else if rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{})) {
	var_title = post_type_archive_title('', false)
	var_prefix = rt.call_function('_x', [rt.new_string('Archives:'), rt.new_string('post type archive title prefix')])
	} else if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
		var_queried_object = rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(var_queried_object) {
		var_tax = rt.call_function('get_taxonomy', [rt.get_property(var_queried_object, 'taxonomy')])
		var_title = single_term_title('', false)
		var_prefix = rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('%s:'), rt.new_string('taxonomy term archive title prefix')]), rt.get_property(rt.get_property(var_tax, 'labels'), 'singular_name')])
		}
	}
	var_original_title = var_title.clone()
	var_prefix = rt.call_function('apply_filters', [rt.new_string('get_the_archive_title_prefix'), var_prefix.clone()])
	if rt.is_true(var_prefix) {
	var_title = rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('%1$s %2$s'), rt.new_string('archive title')]), var_prefix.clone(), rt.new_string('<span>' + (var_title).str() + '</span>')])
	}
	return rt.call_function('apply_filters', [rt.new_string('get_the_archive_title'), var_title.clone(), var_original_title.clone(), var_prefix.clone()])
}

fn the_archive_description(before string, after string) {
	mut var_before := before
	mut var_after := after
	mut var_description := rt.new_null()
	var_description = get_the_archive_description()
	if rt.is_true(var_description) {
		print(before + (var_description).str() + after)
	}
}

fn get_the_archive_description() rt.PhpVal {
	mut var_description := rt.new_null()
	if rt.is_true(rt.call_function('is_author', []rt.PhpVal{})) {
	var_description = rt.call_function('get_the_author_meta', [rt.new_string('description')])
	} else if rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{})) {
	var_description = get_the_post_type_description()
	} else {
	var_description = rt.call_function('term_description', []rt.PhpVal{})
	}
	return rt.call_function('apply_filters', [rt.new_string('get_the_archive_description'), var_description.clone()])
}

fn get_the_post_type_description() rt.PhpVal {
	mut var_post_type := rt.new_null()
	mut var_post_type_obj := rt.new_null()
	mut var_description := rt.new_null()
	var_post_type = rt.call_function('get_query_var', [rt.new_string('post_type')])
	if rt.is_true(rt.new_bool(var_post_type.clone().is_array())) {
	var_post_type = rt.call_function('reset', [var_post_type.clone()])
	}
	var_post_type_obj = rt.call_function('get_post_type_object', [var_post_type.clone()])
	var_description = if !(rt.get_property(var_post_type_obj, 'description')).is_null() { rt.get_property(var_post_type_obj, 'description') } else { rt.new_string('') }
	return rt.call_function('apply_filters', [rt.new_string('get_the_post_type_description'), var_description.clone(), var_post_type_obj.clone()])
}

fn get_archives_link(var_url_arg rt.PhpVal, var_text_arg rt.PhpVal, format string, before string, after string, selected bool) rt.PhpVal {
	mut var_format := format
	mut var_before := before
	mut var_after := after
	mut var_selected := selected
	mut var_url := var_url_arg
	mut var_text := var_text_arg
	mut var_aria_current := ''
	mut var_link_html := rt.new_null()
	mut var_selected_attr := ''
	var_text = rt.call_function('wptexturize', [var_text.clone()])
	var_url = rt.call_function('esc_url', [var_url.clone()])
	var_aria_current = if var_selected { ' aria-current="page"' } else { '' }
	if rt.is_true(rt.identical(rt.new_string('link'), rt.new_string(format))) {
	var_link_html = rt.new_string('\t<link rel=\'archives\' title=\'' + (rt.call_function('esc_attr', [var_text.clone()])).str() + "' href='${var_url.to_string()}' />\n")
	} else if rt.is_true(rt.identical(rt.new_string('option'), rt.new_string(format))) {
	var_selected_attr = if var_selected { ' selected=\'selected\'' } else { '' }
	var_link_html = rt.new_string("\t<option value='${var_url.to_string()}'${var_selected_attr}>${var_before} ${var_text.to_string()} ${var_after}</option>\n")
	} else if rt.is_true(rt.identical(rt.new_string('html'), rt.new_string(format))) {
	var_link_html = rt.new_string("\t<li>${var_before}<a href='${var_url.to_string()}'${var_aria_current}>${var_text.to_string()}</a>${var_after}</li>\n")
	} else {
	var_link_html = rt.new_string("\t${var_before}<a href='${var_url.to_string()}'${var_aria_current}>${var_text.to_string()}</a>${var_after}\n")
	}
	return rt.call_function('apply_filters', [rt.new_string('get_archives_link'), var_link_html.clone(), var_url.clone(), var_text.clone(), rt.new_string(format), rt.new_string(before), rt.new_string(after), rt.new_bool(selected)])
}

fn wp_get_archives(args string) string {
	mut var_args := args
	mut var_wpdb := rt.new_null()
	mut var_wp_locale := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_order := ''
	mut var_archive_week_separator := ''
	mut var_sql_where := rt.new_null()
	mut var_where := rt.new_null()
	mut var_join := rt.new_null()
	mut var_output := ''
	mut var_last_changed := rt.new_null()
	mut var_limit := rt.new_null()
	mut var_query := ''
	mut var_key := ''
	mut var_results := rt.new_null()
	mut var_after := rt.new_null()
	mut var_result := rt.new_null()
	mut var_url := rt.new_null()
	mut var_text := rt.new_null()
	mut var_selected := false
	mut var_date := rt.new_null()
	mut var_week := rt.new_null()
	mut var_arc_w_last := rt.new_null()
	mut var_arc_year := rt.new_null()
	mut var_arc_week := rt.new_null()
	mut var_arc_week_start := rt.new_null()
	mut var_arc_week_end := rt.new_null()
	mut var_orderby := ''
	var_defaults = { 'type': rt.new_string('monthly'), 'limit': rt.new_string(''), 'format': rt.new_string('html'), 'before': rt.new_string(''), 'after': rt.new_string(''), 'show_post_count': rt.new_bool(false), 'echo': rt.new_int(1), 'order': rt.new_string('DESC'), 'post_type': rt.new_string('post'), 'year': rt.call_function('get_query_var', [rt.new_string('year')]), 'monthnum': rt.call_function('get_query_var', [rt.new_string('monthnum')]), 'day': rt.call_function('get_query_var', [rt.new_string('day')]), 'w': rt.call_function('get_query_var', [rt.new_string('w')]) }
	var_args = (rt.call_function('apply_filters', [rt.new_string('wp_get_archives_args'), rt.new_string((var_args).str())])).str()
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string((var_args).str()), rt.create_array_from_native_map(var_defaults)])
	var_post_type_object = rt.call_function('get_post_type_object', [var_parsed_args.array_get(rt.new_string('post_type'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_type_viewable', [var_post_type_object.clone()]))))) {
		return ''
	}
	var_parsed_args.array_set('post_type', rt.get_property(var_post_type_object, 'name'))
	if rt.is_true(rt.identical(rt.new_string(''), var_parsed_args.array_get(rt.new_string('type')))) {
		var_parsed_args.array_set('type', 'monthly')
	}
	if !(!rt.is_true(var_parsed_args.array_get(rt.new_string('limit')))) {
		var_parsed_args.array_set('limit', rt.call_function('absint', [var_parsed_args.array_get(rt.new_string('limit'))]))
		var_parsed_args.array_set('limit', ' LIMIT ' + (var_parsed_args.array_get(rt.new_string('limit'))).str())
	}
	var_order = var_parsed_args.array_get(rt.new_string('order')).to_string().to_upper()
	if rt.is_true(rt.new_bool('ASC' != var_order)) {
	var_order = 'DESC'
	}
	var_archive_week_separator = '&#8211;'
	var_sql_where = rt.call_method(var_wpdb, 'prepare', [rt.new_string('WHERE post_type = %s AND post_status = \'publish\''), var_parsed_args.array_get(rt.new_string('post_type'))])
	var_where = rt.call_function('apply_filters', [rt.new_string('getarchives_where'), var_sql_where.clone(), var_parsed_args.clone()])
	var_join = rt.call_function('apply_filters', [rt.new_string('getarchives_join'), rt.new_string(''), var_parsed_args.clone()])
	var_output = ''
	var_last_changed = rt.call_function('wp_cache_get_last_changed', [rt.new_string('posts')])
	var_limit = var_parsed_args.array_get(rt.new_string('limit'))
	if rt.is_true(rt.identical(rt.new_string('monthly'), var_parsed_args.array_get(rt.new_string('type')))) {
		var_query = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT YEAR(post_date) AS `year`, MONTH(post_date) AS `month`, count(ID) as posts FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ')), var_join), rt.new_string(' ')), var_where), rt.new_string(' GROUP BY YEAR(post_date), MONTH(post_date) ORDER BY post_date ')), rt.new_string((var_order).str())), rt.new_string(' ')), var_limit)
		var_key = md5.hexhash(var_query)
		var_key = "wp_get_archives:${var_key}"
		var_results = rt.call_function('wp_cache_get_salted', [rt.new_string((var_key).str()).clone(), rt.new_string('post-queries'), var_last_changed.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_results)))) {
			var_results = rt.call_method(var_wpdb, 'get_results', [rt.new_string((var_query).str()).clone()])
			rt.call_function('wp_cache_set_salted', [rt.new_string((var_key).str()).clone(), var_results.clone(), rt.new_string('post-queries'), var_last_changed.clone()])
		}
		if rt.is_true(var_results) {
			var_after = var_parsed_args.array_get(rt.new_string('after'))
			mut iter_1 := rt.cast_array(var_results).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_result_shadow := item_1.val
				var_url = rt.call_function('get_month_link', [rt.get_property(var_result_shadow, 'year'), rt.get_property(var_result_shadow, 'month')])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), var_parsed_args.array_get(rt.new_string('post_type')))))) {
				var_url = rt.call_function('add_query_arg', [rt.new_string('post_type'), var_parsed_args.array_get(rt.new_string('post_type')), var_url.clone()])
				}
				var_text = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s %2$d')]), rt.call_method(var_wp_locale, 'get_month', [rt.get_property(var_result_shadow, 'month')]), rt.get_property(var_result_shadow, 'year')])
				if rt.is_true(var_parsed_args.array_get(rt.new_string('show_post_count'))) {
					var_parsed_args.array_set('after', '&nbsp;(' + (rt.get_property(var_result_shadow, 'posts')).str() + ')' + (var_after).str())
				}
				var_selected = rt.is_true(rt.call_function('is_archive', []rt.PhpVal{})) && rt.is_true(rt.identical((var_parsed_args.array_get(rt.new_string('year'))).str(), rt.get_property(var_result_shadow, 'year'))) && rt.is_true(rt.identical((var_parsed_args.array_get(rt.new_string('monthnum'))).str(), rt.get_property(var_result_shadow, 'month')))
				var_output = var_output + (get_archives_link(var_url.clone(), var_text.clone(), var_parsed_args.array_get(rt.new_string('format')), var_parsed_args.array_get(rt.new_string('before')), var_parsed_args.array_get(rt.new_string('after')), var_selected)).str()
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('yearly'), var_parsed_args.array_get(rt.new_string('type')))) {
		var_query = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT YEAR(post_date) AS `year`, count(ID) as posts FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ')), var_join), rt.new_string(' ')), var_where), rt.new_string(' GROUP BY YEAR(post_date) ORDER BY post_date ')), rt.new_string((var_order).str())), rt.new_string(' ')), var_limit)
		var_key = md5.hexhash(var_query)
		var_key = "wp_get_archives:${var_key}"
		var_results = rt.call_function('wp_cache_get_salted', [rt.new_string((var_key).str()).clone(), rt.new_string('post-queries'), var_last_changed.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_results)))) {
			var_results = rt.call_method(var_wpdb, 'get_results', [rt.new_string((var_query).str()).clone()])
			rt.call_function('wp_cache_set_salted', [rt.new_string((var_key).str()).clone(), var_results.clone(), rt.new_string('post-queries'), var_last_changed.clone()])
		}
		if rt.is_true(var_results) {
			var_after = var_parsed_args.array_get(rt.new_string('after'))
			mut iter_2 := rt.cast_array(var_results).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_result_shadow := item_2.val
				var_url = rt.call_function('get_year_link', [rt.get_property(var_result_shadow, 'year')])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), var_parsed_args.array_get(rt.new_string('post_type')))))) {
				var_url = rt.call_function('add_query_arg', [rt.new_string('post_type'), var_parsed_args.array_get(rt.new_string('post_type')), var_url.clone()])
				}
				var_text = rt.call_function('sprintf', [rt.new_string('%d'), rt.get_property(var_result_shadow, 'year')])
				if rt.is_true(var_parsed_args.array_get(rt.new_string('show_post_count'))) {
					var_parsed_args.array_set('after', '&nbsp;(' + (rt.get_property(var_result_shadow, 'posts')).str() + ')' + (var_after).str())
				}
				var_selected = rt.is_true(rt.call_function('is_archive', []rt.PhpVal{})) && rt.is_true(rt.identical((var_parsed_args.array_get(rt.new_string('year'))).str(), rt.get_property(var_result_shadow, 'year')))
				var_output = var_output + (get_archives_link(var_url.clone(), var_text.clone(), var_parsed_args.array_get(rt.new_string('format')), var_parsed_args.array_get(rt.new_string('before')), var_parsed_args.array_get(rt.new_string('after')), var_selected)).str()
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('daily'), var_parsed_args.array_get(rt.new_string('type')))) {
		var_query = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT YEAR(post_date) AS `year`, MONTH(post_date) AS `month`, DAYOFMONTH(post_date) AS `dayofmonth`, count(ID) as posts FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ')), var_join), rt.new_string(' ')), var_where), rt.new_string(' GROUP BY YEAR(post_date), MONTH(post_date), DAYOFMONTH(post_date) ORDER BY post_date ')), rt.new_string((var_order).str())), rt.new_string(' ')), var_limit)
		var_key = md5.hexhash(var_query)
		var_key = "wp_get_archives:${var_key}"
		var_results = rt.call_function('wp_cache_get_salted', [rt.new_string((var_key).str()).clone(), rt.new_string('post-queries'), var_last_changed.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_results)))) {
			var_results = rt.call_method(var_wpdb, 'get_results', [rt.new_string((var_query).str()).clone()])
			rt.call_function('wp_cache_set_salted', [rt.new_string((var_key).str()).clone(), var_results.clone(), rt.new_string('post-queries'), var_last_changed.clone()])
		}
		if rt.is_true(var_results) {
			var_after = var_parsed_args.array_get(rt.new_string('after'))
			mut iter_3 := rt.cast_array(var_results).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_result_shadow := item_3.val
				var_url = rt.call_function('get_day_link', [rt.get_property(var_result_shadow, 'year'), rt.get_property(var_result_shadow, 'month'), rt.get_property(var_result_shadow, 'dayofmonth')])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), var_parsed_args.array_get(rt.new_string('post_type')))))) {
				var_url = rt.call_function('add_query_arg', [rt.new_string('post_type'), var_parsed_args.array_get(rt.new_string('post_type')), var_url.clone()])
				}
				var_date = rt.call_function('sprintf', [rt.new_string('%1$d-%2$02d-%3$02d 00:00:00'), rt.get_property(var_result_shadow, 'year'), rt.get_property(var_result_shadow, 'month'), rt.get_property(var_result_shadow, 'dayofmonth')])
				var_text = rt.call_function('mysql2date', [rt.call_function('get_option', [rt.new_string('date_format')]), var_date.clone()])
				if rt.is_true(var_parsed_args.array_get(rt.new_string('show_post_count'))) {
					var_parsed_args.array_set('after', '&nbsp;(' + (rt.get_property(var_result_shadow, 'posts')).str() + ')' + (var_after).str())
				}
				var_selected = rt.is_true(rt.call_function('is_archive', []rt.PhpVal{})) && rt.is_true(rt.identical((var_parsed_args.array_get(rt.new_string('year'))).str(), rt.get_property(var_result_shadow, 'year'))) && rt.is_true(rt.identical((var_parsed_args.array_get(rt.new_string('monthnum'))).str(), rt.get_property(var_result_shadow, 'month'))) && rt.is_true(rt.identical((var_parsed_args.array_get(rt.new_string('day'))).str(), rt.get_property(var_result_shadow, 'dayofmonth')))
				var_output = var_output + (get_archives_link(var_url.clone(), var_text.clone(), var_parsed_args.array_get(rt.new_string('format')), var_parsed_args.array_get(rt.new_string('before')), var_parsed_args.array_get(rt.new_string('after')), var_selected)).str()
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('weekly'), var_parsed_args.array_get(rt.new_string('type')))) {
		var_week = rt.call_function('_wp_mysql_week', [rt.new_string('`post_date`')])
		var_query = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT '), var_week), rt.new_string(' AS `week`, YEAR( `post_date` ) AS `yr`, DATE_FORMAT( `post_date`, \'%Y-%m-%d\' ) AS `yyyymmdd`, count( `ID` ) AS `posts` FROM `')), rt.get_property(var_wpdb, 'posts')), rt.new_string('` ')), var_join), rt.new_string(' ')), var_where), rt.new_string(' GROUP BY ')), var_week), rt.new_string(', YEAR( `post_date` ) ORDER BY `post_date` ')), rt.new_string((var_order).str())), rt.new_string(' ')), var_limit)
		var_key = md5.hexhash(var_query)
		var_key = "wp_get_archives:${var_key}"
		var_results = rt.call_function('wp_cache_get_salted', [rt.new_string((var_key).str()).clone(), rt.new_string('post-queries'), var_last_changed.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_results)))) {
			var_results = rt.call_method(var_wpdb, 'get_results', [rt.new_string((var_query).str()).clone()])
			rt.call_function('wp_cache_set_salted', [rt.new_string((var_key).str()).clone(), var_results.clone(), rt.new_string('post-queries'), var_last_changed.clone()])
		}
		var_arc_w_last = rt.new_string('')
		if rt.is_true(var_results) {
			var_after = var_parsed_args.array_get(rt.new_string('after'))
			mut iter_4 := rt.cast_array(var_results).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_result_shadow := item_4.val
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_result_shadow, 'week'), var_arc_w_last)))) {
					var_arc_year = rt.get_property(var_result_shadow, 'yr')
					var_arc_w_last = rt.get_property(var_result_shadow, 'week')
					var_arc_week = rt.call_function('get_weekstartend', [rt.get_property(var_result_shadow, 'yyyymmdd'), rt.call_function('get_option', [rt.new_string('start_of_week')])])
					var_arc_week_start = rt.call_function('date_i18n', [rt.call_function('get_option', [rt.new_string('date_format')]), var_arc_week.array_get(rt.new_string('start'))])
					var_arc_week_end = rt.call_function('date_i18n', [rt.call_function('get_option', [rt.new_string('date_format')]), var_arc_week.array_get(rt.new_string('end'))])
					var_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'm', val: var_arc_year }, rt.ArrayItem{ key: 'w', val: rt.get_property(var_result_shadow, 'week') }]), rt.call_function('home_url', [rt.new_string('/')])])
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), var_parsed_args.array_get(rt.new_string('post_type')))))) {
					var_url = rt.call_function('add_query_arg', [rt.new_string('post_type'), var_parsed_args.array_get(rt.new_string('post_type')), var_url.clone()])
					}
					var_text = rt.new_string((var_arc_week_start).str() + var_archive_week_separator + (var_arc_week_end).str())
					if rt.is_true(var_parsed_args.array_get(rt.new_string('show_post_count'))) {
						var_parsed_args.array_set('after', '&nbsp;(' + (rt.get_property(var_result_shadow, 'posts')).str() + ')' + (var_after).str())
					}
					var_selected = rt.is_true(rt.call_function('is_archive', []rt.PhpVal{})) && rt.is_true(rt.identical((var_parsed_args.array_get(rt.new_string('year'))).str(), rt.get_property(var_result_shadow, 'yr'))) && rt.is_true(rt.identical((var_parsed_args.array_get(rt.new_string('w'))).str(), rt.get_property(var_result_shadow, 'week')))
					var_output = var_output + (get_archives_link(var_url.clone(), var_text.clone(), var_parsed_args.array_get(rt.new_string('format')), var_parsed_args.array_get(rt.new_string('before')), var_parsed_args.array_get(rt.new_string('after')), var_selected)).str()
				}
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('postbypost'), var_parsed_args.array_get(rt.new_string('type')))) || rt.is_true(rt.identical(rt.new_string('alpha'), var_parsed_args.array_get(rt.new_string('type')))) {
		var_orderby = if rt.is_true(rt.identical(rt.new_string('alpha'), var_parsed_args.array_get(rt.new_string('type')))) { 'post_title ASC ' } else { 'post_date DESC, ID DESC ' }
		var_query = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ')), var_join), rt.new_string(' ')), var_where), rt.new_string(' ORDER BY ')), rt.new_string((var_orderby).str())), rt.new_string(' ')), var_limit)
		var_key = md5.hexhash(var_query)
		var_key = "wp_get_archives:${var_key}"
		var_results = rt.call_function('wp_cache_get_salted', [rt.new_string((var_key).str()).clone(), rt.new_string('post-queries'), var_last_changed.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_results)))) {
			var_results = rt.call_method(var_wpdb, 'get_results', [rt.new_string((var_query).str()).clone()])
			rt.call_function('wp_cache_set_salted', [rt.new_string((var_key).str()).clone(), var_results.clone(), rt.new_string('post-queries'), var_last_changed.clone()])
		}
		if rt.is_true(var_results) {
			mut iter_5 := rt.cast_array(var_results).iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_result_shadow := item_5.val
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), rt.get_property(var_result_shadow, 'post_date'))))) {
					var_url = rt.call_function('get_permalink', [var_result_shadow.clone()])
					if rt.is_true(rt.get_property(var_result_shadow, 'post_title')) {
					var_text = rt.call_function('strip_tags', [rt.call_function('apply_filters', [rt.new_string('the_title'), rt.get_property(var_result_shadow, 'post_title'), rt.get_property(var_result_shadow, 'ID')])])
					} else {
					var_text = rt.get_property(var_result_shadow, 'ID')
					}
					var_selected = (rt.identical(rt.call_function('get_the_ID', []rt.PhpVal{}), rt.get_property(var_result_shadow, 'ID'))).to_bool()
					var_output = var_output + (get_archives_link(var_url.clone(), var_text.clone(), var_parsed_args.array_get(rt.new_string('format')), var_parsed_args.array_get(rt.new_string('before')), var_parsed_args.array_get(rt.new_string('after')), var_selected)).str()
				}
			}
		}
	}
	if rt.is_true(var_parsed_args.array_get(rt.new_string('echo'))) {
		print(var_output)
	} else {
		return var_output
	}
	return ''
}

fn calendar_week_mod(var_num rt.PhpVal) rt.PhpVal {
	mut var_base := i64(0)
	var_base = 7
	return rt.sub(var_num, rt.mul(rt.new_int(var_base), rt.call_function('floor', [rt.div(var_num, rt.new_int(var_base))])))
}

fn get_calendar(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_wpdb := rt.new_null()
	mut var_m := rt.new_null()
	mut var_monthnum := rt.new_null()
	mut var_year := rt.new_null()
	mut var_wp_locale := rt.new_null()
	mut var_posts := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_original_args := rt.new_null()
	mut var_w := rt.new_null()
	mut var_cache_args := rt.new_null()
	mut var_key := ''
	mut var_cache := rt.new_null()
	mut var_output := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_gotsome := rt.new_null()
	mut var_week_begins := rt.new_null()
	mut var_thismonth := rt.new_null()
	mut var_thisyear := rt.new_null()
	mut var_d := rt.new_null()
	mut var_unixmonth := rt.new_null()
	mut var_last_day := rt.new_null()
	mut var_previous := rt.new_null()
	mut var_next := rt.new_null()
	mut var_calendar_caption := rt.new_null()
	mut var_calendar_output := rt.new_null()
	mut var_myweek := []rt.PhpVal{}
	mut var_wdcount := i64(0)
	mut var_wd := rt.new_null()
	mut var_day_name := rt.new_null()
	mut var_daywithpost := []rt.PhpVal{}
	mut var_dayswithposts := rt.new_null()
	mut var_daywith := []rt.PhpVal{}
	mut var_pad := rt.new_null()
	mut var_newrow := false
	mut var_daysinmonth := rt.new_null()
	mut var_date_format := rt.new_null()
	mut var_label := rt.new_null()
	mut var_day := i64(0)
	var_defaults = { 'initial': rt.new_bool(true), 'display': rt.new_bool(true), 'post_type': rt.new_string('post') }
	var_original_args = rt.call_function('func_get_args', []rt.PhpVal{})
	var_args = []rt.PhpVal{}
	if !(!rt.is_true(var_original_args)) {
		if !(var_original_args.array_get(rt.new_int(0)).is_array()) {
			if var_original_args.array_isset(rt.new_int(0)) && var_original_args.array_get(rt.new_int(0)).is_bool() {
				var_defaults['initial'] = var_original_args.array_get(rt.new_int(0))
			}
			if var_original_args.array_isset(rt.new_int(1)) && var_original_args.array_get(rt.new_int(1)).is_bool() {
				var_defaults['display'] = var_original_args.array_get(rt.new_int(1))
			}
		} else {
		var_args = var_original_args.array_get(rt.new_int(0))
		}
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('get_calendar_args'), rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_exists', [var_args.array_get(rt.new_string('post_type'))]))))) {
		var_args.array_set('post_type', 'post')
	}
	var_w = rt.new_int(0)
	if rt.get_superglobal('_GET').array_isset(rt.new_string('w')) {
	var_w = rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('w'))).to_i64())
	}
	var_cache_args = var_args.clone()
	var_cache_args.array_unset(rt.new_string('display'))
	var_cache_args.array_set('globals', rt.create_array([rt.ArrayItem{ key: 'm', val: var_m }, rt.ArrayItem{ key: 'monthnum', val: var_monthnum }, rt.ArrayItem{ key: 'year', val: var_year }, rt.ArrayItem{ key: 'week', val: var_w }]))
	rt.call_function('wp_recursive_ksort', [var_cache_args.clone()])
	var_key = md5.hexhash(rt.call_function('serialize', [var_cache_args.clone()]).to_string())
	var_cache = rt.call_function('wp_cache_get', [rt.new_string('get_calendar'), rt.new_string('calendar')])
	if rt.is_true(var_cache) && var_cache.clone().is_array() && var_cache.array_isset(rt.new_string((var_key).str())) {
		var_output = rt.call_function('apply_filters', [rt.new_string('get_calendar'), var_cache.array_get(rt.new_string((var_key).str())), var_args.clone()])
		if rt.is_true(var_args.array_get(rt.new_string('display'))) {
			rt.echo_val(var_output)
			return rt.new_null()
		}
		return var_output.clone()
	}
	if !(var_cache.clone().is_array()) {
	var_cache = []rt.PhpVal{}
	}
	var_post_type = var_args.array_get(rt.new_string('post_type'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_posts)))) {
		var_gotsome = rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT 1 as test\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\t\tWHERE post_type = %s\n\t\t\t\tAND post_status = \'publish\'\n\t\t\t\tLIMIT 1')), var_post_type.clone()])])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_gotsome)))) {
			var_cache.array_set(var_key, '')
			rt.call_function('wp_cache_set', [rt.new_string('get_calendar'), var_cache.clone(), rt.new_string('calendar')])
			return rt.new_null()
		}
	}
	var_week_begins = rt.new_int((rt.call_function('get_option', [rt.new_string('start_of_week')])).to_i64())
	if !(!rt.is_true(var_monthnum)) && !(!rt.is_true(var_year)) {
	var_thismonth = rt.new_int((var_monthnum).to_i64())
	var_thisyear = rt.new_int((var_year).to_i64())
	} else if !(!rt.is_true(var_w)) {
	var_thisyear = rt.new_int((rt.call_function('substr', [var_m.clone(), rt.new_int(0), rt.new_int(4)])).to_i64())
	var_d = rt.add(rt.mul(rt.sub(var_w, rt.new_int(1)), rt.new_int(7)), rt.new_int(6))
	var_thismonth = rt.new_int((rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('SELECT DATE_FORMAT((DATE_ADD(\'%d0101\', INTERVAL %d DAY) ), \'%%m\')'), var_thisyear.clone(), var_d.clone()])])).to_i64())
	} else if !(!rt.is_true(var_m)) {
		var_thisyear = rt.new_int((rt.call_function('substr', [var_m.clone(), rt.new_int(0), rt.new_int(4)])).to_i64())
		if var_m.clone().to_string().len < 6 {
		var_thismonth = rt.new_int(1)
		} else {
		var_thismonth = rt.new_int((rt.call_function('substr', [var_m.clone(), rt.new_int(4), rt.new_int(2)])).to_i64())
		}
	} else {
	var_thisyear = rt.new_int((rt.call_function('current_time', [rt.new_string('Y')])).to_i64())
	var_thismonth = rt.new_int((rt.call_function('current_time', [rt.new_string('m')])).to_i64())
	}
	var_unixmonth = rt.call_function('mktime', [rt.new_int(0), rt.new_int(0), rt.new_int(0), var_thismonth.clone(), rt.new_int(1), var_thisyear.clone()])
	var_last_day = rt.call_function('gmdate', [rt.new_string('t'), var_unixmonth.clone()])
	var_previous = rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT MONTH(post_date) AS month, YEAR(post_date) AS year\n\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\tWHERE post_date < \'%d-%d-01\'\n\t\t\tAND post_type = %s AND post_status = \'publish\'\n\t\t\tORDER BY post_date DESC\n\t\t\tLIMIT 1')), var_thisyear.clone(), rt.call_function('zeroise', [var_thismonth.clone(), rt.new_int(2)]), var_post_type.clone()])])
	var_next = rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT MONTH(post_date) AS month, YEAR(post_date) AS year\n\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\tWHERE post_date > \'%d-%d-%d 23:59:59\'\n\t\t\tAND post_type = %s AND post_status = \'publish\'\n\t\t\tORDER BY post_date ASC\n\t\t\tLIMIT 1')), var_thisyear.clone(), rt.call_function('zeroise', [var_thismonth.clone(), rt.new_int(2)]), var_last_day.clone(), var_post_type.clone()])])
	var_calendar_caption = rt.call_function('_x', [rt.new_string('%1$s %2$s'), rt.new_string('calendar caption')])
	var_calendar_output = rt.new_string('<table id="wp-calendar" class="wp-calendar-table">\n\t<caption>' + (rt.call_function('sprintf', [var_calendar_caption.clone(), rt.call_method(var_wp_locale, 'get_month', [var_thismonth.clone()]), rt.call_function('gmdate', [rt.new_string('Y'), var_unixmonth.clone()])])).str() + '</caption>\n\t<thead>\n\t<tr>')
	var_myweek = []rt.PhpVal{}
	var_wdcount = 0
	for {
		if !(var_wdcount <= 6) { break }
		var_myweek << rt.call_method(var_wp_locale, 'get_weekday', [rt.mod_(rt.add(rt.new_int(var_wdcount), var_week_begins), rt.new_int(7))])
		var_wdcount += 1
	}
	for var_wd_shadow in var_myweek {
		var_day_name = if rt.is_true(var_args.array_get(rt.new_string('initial'))) { rt.call_method(var_wp_locale, 'get_weekday_initial', [var_wd_shadow.clone()]) } else { rt.call_method(var_wp_locale, 'get_weekday_abbrev', [var_wd_shadow.clone()]) }
		var_wd_shadow = rt.call_function('esc_attr', [var_wd_shadow.clone()])
		var_calendar_output = rt.concat(var_calendar_output, rt.new_string("\n\t\t<th scope=\"col\" aria-label=\"${var_wd.to_string()}\">${var_day_name.to_string()}</th>"))
	}
	var_calendar_output = rt.concat(var_calendar_output, rt.new_string('\n\t</tr>\n\t</thead>\n\t<tbody>\n\t<tr>'))
	var_daywithpost = []rt.PhpVal{}
	var_dayswithposts = rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT DISTINCT DAYOFMONTH(post_date)\n\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_date >= \'%d-%d-01 00:00:00\'\n\t\t\tAND post_type = %s AND post_status = \'publish\'\n\t\t\tAND post_date <= \'%d-%d-%d 23:59:59\'')), var_thisyear.clone(), rt.call_function('zeroise', [var_thismonth.clone(), rt.new_int(2)]), var_post_type.clone(), var_thisyear.clone(), rt.call_function('zeroise', [var_thismonth.clone(), rt.new_int(2)]), var_last_day.clone()]), rt.get_constant('ARRAY_N')])
	if rt.is_true(var_dayswithposts) {
		mut iter_6 := rt.cast_array(var_dayswithposts).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_daywith_shadow := item_6.val
			var_daywithpost << rt.new_int((var_daywith_shadow[0]).to_i64())
		}
	}
	var_pad = calendar_week_mod(rt.sub(rt.new_int((rt.call_function('gmdate', [rt.new_string('w'), var_unixmonth.clone()])).to_i64()), var_week_begins))
	if rt.is_true(rt.greater(var_pad, rt.new_int(0))) {
		var_calendar_output = rt.concat(var_calendar_output, rt.new_string('\n\t\t' + '<td colspan="' + (rt.call_function('esc_attr', [var_pad.clone()])).str() + '" class="pad">&nbsp;</td>'))
	}
	var_newrow = false
	var_daysinmonth = rt.new_int((rt.call_function('gmdate', [rt.new_string('t'), var_unixmonth.clone()])).to_i64())
	var_day = 1
	for {
		if !(rt.is_true(rt.less_equal(rt.new_int(var_day), var_daysinmonth))) { break }
		if var_newrow {
			var_calendar_output = rt.concat(var_calendar_output, rt.new_string('\n\t</tr>\n\t<tr>\n\t\t'))
		}
		var_newrow = false
		if rt.new_int((rt.call_function('current_time', [rt.new_string('j')])).to_i64()) == var_day && rt.is_true(rt.identical(rt.new_int((rt.call_function('current_time', [rt.new_string('m')])).to_i64()), var_thismonth)) && rt.is_true(rt.identical(rt.new_int((rt.call_function('current_time', [rt.new_string('Y')])).to_i64()), var_thisyear)) {
			var_calendar_output = rt.concat(var_calendar_output, rt.new_string('<td id="today">'))
		} else {
			var_calendar_output = rt.concat(var_calendar_output, rt.new_string('<td>'))
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_int(var_day).clone(), rt.create_array_from_list(var_daywithpost), rt.new_bool(true)])) {
			var_date_format = rt.call_function('gmdate', [rt.call_function('_x', [rt.new_string('F j, Y'), rt.new_string('daily archives date format')]), rt.call_function('strtotime', [rt.new_string("${var_thisyear.to_string()}-${var_thismonth.to_string()}-${var_day.str()}")])])
			var_label = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Posts published on %s')]), var_date_format.clone()])
			var_calendar_output = rt.concat(var_calendar_output, rt.call_function('sprintf', [rt.new_string('<a href="%s" aria-label="%s">%s</a>'), rt.call_function('get_day_link', [var_thisyear.clone(), var_thismonth.clone(), rt.new_int(var_day).clone()]), rt.call_function('esc_attr', [var_label.clone()]), rt.new_int(var_day).clone()]))
		} else {
			var_calendar_output = rt.concat(var_calendar_output, rt.new_int(var_day))
		}
		var_calendar_output = rt.concat(var_calendar_output, rt.new_string('</td>'))
		if 6 == rt.new_int((calendar_week_mod(rt.sub(rt.new_int((rt.call_function('gmdate', [rt.new_string('w'), rt.call_function('mktime', [rt.new_int(0), rt.new_int(0), rt.new_int(0), var_thismonth.clone(), rt.new_int(var_day).clone(), var_thisyear.clone()])])).to_i64()), var_week_begins))).to_i64()) {
		var_newrow = true
		}
		var_day += 1
	}
	var_pad = rt.sub(rt.new_int(7), calendar_week_mod(rt.sub(rt.new_int((rt.call_function('gmdate', [rt.new_string('w'), rt.call_function('mktime', [rt.new_int(0), rt.new_int(0), rt.new_int(0), var_thismonth.clone(), rt.new_int(var_day).clone(), var_thisyear.clone()])])).to_i64()), var_week_begins)))
	if rt.is_true(rt.less(rt.new_int(0), var_pad)) && rt.is_true(rt.less(var_pad, rt.new_int(7))) {
		var_calendar_output = rt.concat(var_calendar_output, rt.new_string('\n\t\t' + '<td class="pad" colspan="' + (rt.call_function('esc_attr', [var_pad.clone()])).str() + '">&nbsp;</td>'))
	}
	var_calendar_output = rt.concat(var_calendar_output, rt.new_string('\n\t</tr>\n\t</tbody>'))
	var_calendar_output = rt.concat(var_calendar_output, rt.new_string('\n\t</table>'))
	var_calendar_output = rt.concat(var_calendar_output, rt.new_string('<nav aria-label="' + (rt.call_function('__', [rt.new_string('Previous and next months')])).str() + '" class="wp-calendar-nav">'))
	if rt.is_true(var_previous) {
		var_calendar_output = rt.concat(var_calendar_output, rt.new_string('\n\t\t' + (rt.call_function('sprintf', [rt.new_string('<span class="wp-calendar-nav-prev"><a href="%1$s">&laquo; %2$s</a></span>'), rt.call_function('get_month_link', [rt.get_property(var_previous, 'year'), rt.get_property(var_previous, 'month')]), rt.call_method(var_wp_locale, 'get_month_abbrev', [rt.call_method(var_wp_locale, 'get_month', [rt.get_property(var_previous, 'month')])])])).str()))
	} else {
		var_calendar_output = rt.concat(var_calendar_output, rt.new_string('\n\t\t' + '<span class="wp-calendar-nav-prev">&nbsp;</span>'))
	}
	var_calendar_output = rt.concat(var_calendar_output, rt.new_string('\n\t\t' + '<span class="pad">&nbsp;</span>'))
	if rt.is_true(var_next) {
		var_calendar_output = rt.concat(var_calendar_output, rt.new_string('\n\t\t' + (rt.call_function('sprintf', [rt.new_string('<span class="wp-calendar-nav-next"><a href="%1$s">%2$s &raquo;</a></span>'), rt.call_function('get_month_link', [rt.get_property(var_next, 'year'), rt.get_property(var_next, 'month')]), rt.call_method(var_wp_locale, 'get_month_abbrev', [rt.call_method(var_wp_locale, 'get_month', [rt.get_property(var_next, 'month')])])])).str()))
	} else {
		var_calendar_output = rt.concat(var_calendar_output, rt.new_string('\n\t\t' + '<span class="wp-calendar-nav-next">&nbsp;</span>'))
	}
	var_calendar_output = rt.concat(var_calendar_output, rt.new_string('\n\t</nav>'))
	var_cache.array_set(var_key, var_calendar_output.clone())
	rt.call_function('wp_cache_set', [rt.new_string('get_calendar'), var_cache.clone(), rt.new_string('calendar')])
	var_calendar_output = rt.call_function('apply_filters', [rt.new_string('get_calendar'), var_calendar_output.clone(), var_args.clone()])
	if rt.is_true(var_args.array_get(rt.new_string('display'))) {
		rt.echo_val(var_calendar_output)
		return rt.new_null()
	}
	return var_calendar_output.clone()
}

fn delete_get_calendar_cache() {
	rt.call_function('wp_cache_delete', [rt.new_string('get_calendar'), rt.new_string('calendar')])
}

fn allowed_tags() rt.PhpVal {
	mut var_allowedtags := rt.new_null()
	mut var_allowed := ''
	mut var_attributes := rt.new_null()
	mut var_tag := rt.new_null()
	mut var_limits := rt.new_null()
	mut var_attribute := rt.new_null()
	var_allowed = ''
	mut iter_7 := rt.cast_array(var_allowedtags).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_attributes_shadow := item_7.val
		mut var_tag_shadow := item_7.key
		var_allowed = var_allowed + '<' + (var_tag_shadow).str()
		if 0 < var_attributes_shadow.clone().array_count() {
			mut iter_8 := var_attributes_shadow.iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_limits_shadow := item_8.val
				mut var_attribute_shadow := item_8.key
				var_allowed = var_allowed + ' ' + (var_attribute_shadow).str() + '=""'
			}
		}
		var_allowed = var_allowed + '> '
	}
	return rt.call_function('htmlentities', [rt.new_string((var_allowed).str()).clone()])
}

fn the_date_xml() {
	rt.echo_val(rt.call_function('mysql2date', [rt.new_string('Y-m-d'), rt.get_property(rt.call_function('get_post', []rt.PhpVal{}), 'post_date'), rt.new_bool(false)]))
}

fn the_date(format string, before string, after string, display bool) rt.PhpVal {
	mut var_format := format
	mut var_before := before
	mut var_after := after
	mut var_display := display
	mut var_currentday := rt.new_null()
	mut var_the_date := rt.new_null()
	mut var_previousday := rt.new_null()
	var_the_date = rt.new_string('')
	if rt.is_true(rt.call_function('is_new_day', []rt.PhpVal{})) {
	var_the_date = rt.new_string(before + get_the_date(format).str() + after)
	var_previousday = var_currentday
	}
	var_the_date = rt.call_function('apply_filters', [rt.new_string('the_date'), var_the_date.clone(), rt.new_string(format), rt.new_string(before), rt.new_string(after)])
	if var_display {
		rt.echo_val(var_the_date)
	} else {
		return var_the_date.clone()
	}
	return rt.new_null()
}

fn get_the_date(format string, var_post_arg rt.PhpVal) bool {
	mut var_format := format
	mut var_post := var_post_arg
	mut var__format := rt.new_null()
	mut var_the_date := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	var__format = if !(format == '') { rt.new_string(format) } else { rt.call_function('get_option', [rt.new_string('date_format')]) }
	var_the_date = rt.new_bool(get_post_time(var__format.clone(), false, var_post.clone(), true))
	return (rt.call_function('apply_filters', [rt.new_string('get_the_date'), var_the_date.clone(), rt.new_string(format), var_post.clone()])).to_bool()
}

fn the_modified_date(format string, before string, after string, display bool) rt.PhpVal {
	mut var_format := format
	mut var_before := before
	mut var_after := after
	mut var_display := display
	mut var_the_modified_date := rt.new_null()
	var_the_modified_date = rt.new_string(before + (get_the_modified_date(format, rt.new_null())).str() + after)
	var_the_modified_date = rt.call_function('apply_filters', [rt.new_string('the_modified_date'), var_the_modified_date.clone(), rt.new_string(format), rt.new_string(before), rt.new_string(after)])
	if var_display {
		rt.echo_val(var_the_modified_date)
	} else {
		return var_the_modified_date.clone()
	}
	return rt.new_null()
}

fn get_the_modified_date(format string, var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_format := format
	mut var_post := var_post_arg
	mut var_the_time := rt.new_null()
	mut var__format := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
	var_the_time = rt.new_bool(false)
	} else {
	var__format = if !(format == '') { rt.new_string(format) } else { rt.call_function('get_option', [rt.new_string('date_format')]) }
	var_the_time = rt.new_bool(get_post_modified_time(var__format.clone(), false, var_post.clone(), true))
	}
	return rt.call_function('apply_filters', [rt.new_string('get_the_modified_date'), var_the_time.clone(), rt.new_string(format), var_post.clone()])
}

fn the_time(format string) {
	mut var_format := format
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('the_time'), rt.new_bool(get_the_time(format, rt.new_null())), rt.new_string(format)]))
}

fn get_the_time(format string, var_post_arg rt.PhpVal) bool {
	mut var_format := format
	mut var_post := var_post_arg
	mut var__format := rt.new_null()
	mut var_the_time := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	var__format = if !(format == '') { rt.new_string(format) } else { rt.call_function('get_option', [rt.new_string('time_format')]) }
	var_the_time = rt.new_bool(get_post_time(var__format.clone(), false, var_post.clone(), true))
	return (rt.call_function('apply_filters', [rt.new_string('get_the_time'), var_the_time.clone(), rt.new_string(format), var_post.clone()])).to_bool()
}

fn get_post_time(format string, gmt bool, var_post_arg rt.PhpVal, translate bool) bool {
	mut var_format := format
	mut var_gmt := gmt
	mut var_translate := translate
	mut var_post := var_post_arg
	mut var_source := ''
	mut var_datetime := rt.new_null()
	mut var_time := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	var_source = if var_gmt { 'gmt' } else { 'local' }
	var_datetime = rt.new_bool(get_post_datetime(var_post.clone(), 'date', var_source))
	if rt.is_true(rt.identical(rt.new_bool(false), var_datetime)) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('U'), rt.new_string(format))) || rt.is_true(rt.identical(rt.new_string('G'), rt.new_string(format))) {
		var_time = rt.call_method(var_datetime, 'getTimestamp', []rt.PhpVal{})
		if !(var_gmt) {
			var_time = rt.add(var_time, rt.call_method(var_datetime, 'getOffset', []rt.PhpVal{}))
		}
	} else if var_translate {
	var_time = rt.call_function('wp_date', [rt.new_string(format), rt.call_method(var_datetime, 'getTimestamp', []rt.PhpVal{}), if var_gmt { create_datetimezone(rt.new_string('UTC')) } else { rt.new_null() }])
	} else {
		if var_gmt {
		var_datetime = rt.call_method(var_datetime, 'setTimezone', [create_datetimezone(rt.new_string('UTC'))])
		}
	var_time = rt.call_method(var_datetime, 'format', [rt.new_string(format)])
	}
	return (rt.call_function('apply_filters', [rt.new_string('get_post_time'), var_time.clone(), rt.new_string(format), rt.new_bool(gmt)])).to_bool()
}

fn get_post_datetime(var_post_arg rt.PhpVal, field string, source string) bool {
	mut var_field := field
	mut var_source := source
	mut var_post := var_post_arg
	mut var_wp_timezone := rt.new_null()
	mut var_time := rt.new_null()
	mut var_timezone := rt.new_null()
	mut var_datetime := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	var_wp_timezone = rt.call_function('wp_timezone', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('gmt'), rt.new_string(source))) {
	var_time = if rt.is_true(rt.identical(rt.new_string('modified'), rt.new_string(field))) { rt.get_property(var_post, 'post_modified_gmt') } else { rt.get_property(var_post, 'post_date_gmt') }
	var_timezone = create_datetimezone(rt.new_string('UTC'))
	} else {
	var_time = if rt.is_true(rt.identical(rt.new_string('modified'), rt.new_string(field))) { rt.get_property(var_post, 'post_modified') } else { rt.get_property(var_post, 'post_date') }
	var_timezone = var_wp_timezone.clone()
	}
	if !rt.is_true(var_time) || rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), var_time)) {
		return false
	}
	var_datetime = rt.call_function('date_create_immutable_from_format', [rt.new_string('Y-m-d H:i:s'), var_time.clone(), var_timezone.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_datetime)) {
		return false
	}
	return (rt.call_method(var_datetime, 'setTimezone', [var_wp_timezone.clone()])).to_bool()
}

fn get_post_timestamp(var_post rt.PhpVal, field string) bool {
	mut var_field := field
	mut var_datetime := false
	var_datetime = get_post_datetime(var_post.clone(), field)
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_datetime))) {
		return false
	}
	return (rt.call_method(rt.new_bool(var_datetime), 'getTimestamp', []rt.PhpVal{})).to_bool()
}

fn the_modified_time(format string) {
	mut var_format := format
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('the_modified_time'), get_the_modified_time(format, rt.new_null()), rt.new_string(format)]))
}

fn get_the_modified_time(format string, var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_format := format
	mut var_post := var_post_arg
	mut var_the_time := rt.new_null()
	mut var__format := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
	var_the_time = rt.new_bool(false)
	} else {
	var__format = if !(format == '') { rt.new_string(format) } else { rt.call_function('get_option', [rt.new_string('time_format')]) }
	var_the_time = rt.new_bool(get_post_modified_time(var__format.clone(), false, var_post.clone(), true))
	}
	return rt.call_function('apply_filters', [rt.new_string('get_the_modified_time'), var_the_time.clone(), rt.new_string(format), var_post.clone()])
}

fn get_post_modified_time(format string, gmt bool, var_post_arg rt.PhpVal, translate bool) bool {
	mut var_format := format
	mut var_gmt := gmt
	mut var_translate := translate
	mut var_post := var_post_arg
	mut var_source := ''
	mut var_datetime := rt.new_null()
	mut var_time := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	var_source = if var_gmt { 'gmt' } else { 'local' }
	var_datetime = rt.new_bool(get_post_datetime(var_post.clone(), 'modified', var_source))
	if rt.is_true(rt.identical(rt.new_bool(false), var_datetime)) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('U'), rt.new_string(format))) || rt.is_true(rt.identical(rt.new_string('G'), rt.new_string(format))) {
		var_time = rt.call_method(var_datetime, 'getTimestamp', []rt.PhpVal{})
		if !(var_gmt) {
			var_time = rt.add(var_time, rt.call_method(var_datetime, 'getOffset', []rt.PhpVal{}))
		}
	} else if var_translate {
	var_time = rt.call_function('wp_date', [rt.new_string(format), rt.call_method(var_datetime, 'getTimestamp', []rt.PhpVal{}), if var_gmt { create_datetimezone(rt.new_string('UTC')) } else { rt.new_null() }])
	} else {
		if var_gmt {
		var_datetime = rt.call_method(var_datetime, 'setTimezone', [create_datetimezone(rt.new_string('UTC'))])
		}
	var_time = rt.call_method(var_datetime, 'format', [rt.new_string(format)])
	}
	return (rt.call_function('apply_filters', [rt.new_string('get_post_modified_time'), var_time.clone(), rt.new_string(format), rt.new_bool(gmt)])).to_bool()
}

fn the_weekday() {
	mut var_wp_locale := rt.new_null()
	mut var_post := rt.new_null()
	mut var_the_weekday := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return
	}
	var_the_weekday = rt.call_method(var_wp_locale, 'get_weekday', [rt.new_bool(get_post_time('w', false, var_post.clone(), false))])
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('the_weekday'), var_the_weekday.clone()]))
}

fn the_weekday_date(before string, after string) {
	mut var_before := before
	mut var_after := after
	mut var_wp_locale := rt.new_null()
	mut var_currentday := rt.new_null()
	mut var_post := rt.new_null()
	mut var_the_weekday_date := ''
	mut var_previousweekday := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return
	}
	var_the_weekday_date = ''
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_currentday, var_previousweekday)))) {
		var_the_weekday_date = var_the_weekday_date + before
		var_the_weekday_date = var_the_weekday_date + (rt.call_method(var_wp_locale, 'get_weekday', [rt.new_bool(get_post_time('w', false, var_post.clone(), false))])).str()
		var_the_weekday_date = var_the_weekday_date + after
	var_previousweekday = var_currentday
	}
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('the_weekday_date'), rt.new_string((var_the_weekday_date).str()).clone(), rt.new_string(before), rt.new_string(after)]))
}

fn wp_head() {
	rt.call_function('do_action', [rt.new_string('wp_head')])
}

fn wp_footer() {
	rt.call_function('do_action', [rt.new_string('wp_footer')])
}

fn wp_body_open() {
	rt.call_function('do_action', [rt.new_string('wp_body_open')])
}

fn feed_links(var_args_arg rt.PhpVal) {
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('automatic-feed-links')]))))) {
		return
	}
	var_defaults = { 'separator': rt.call_function('_x', [rt.new_string('&raquo;'), rt.new_string('feed link')]), 'feedtitle': rt.call_function('__', [rt.new_string('%1$s %2$s Feed')]), 'comstitle': rt.call_function('__', [rt.new_string('%1$s %2$s Comments Feed')]) }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	var_args = rt.call_function('apply_filters', [rt.new_string('feed_links_args'), var_args.clone()])
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('feed_links_show_posts_feed'), rt.new_bool(true)])) {
		rt.call_function('printf', [rt.new_string('<link rel="alternate" type="%s" title="%s" href="%s" />' + '\n'), rt.call_function('feed_content_type', []rt.PhpVal{}), rt.call_function('esc_attr', [rt.call_function('sprintf', [var_args.array_get(rt.new_string('feedtitle')), get_bloginfo('name', ''), var_args.array_get(rt.new_string('separator'))])]), rt.call_function('esc_url', [rt.call_function('get_feed_link', []rt.PhpVal{})])])
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('feed_links_show_comments_feed'), rt.new_bool(true)])) {
		rt.call_function('printf', [rt.new_string('<link rel="alternate" type="%s" title="%s" href="%s" />' + '\n'), rt.call_function('feed_content_type', []rt.PhpVal{}), rt.call_function('esc_attr', [rt.call_function('sprintf', [var_args.array_get(rt.new_string('comstitle')), get_bloginfo('name', ''), var_args.array_get(rt.new_string('separator'))])]), rt.call_function('esc_url', [rt.call_function('get_feed_link', [rt.new_string('comments_' + (rt.call_function('get_default_feed', []rt.PhpVal{})).str())])])])
	}
}

fn feed_links_extra(var_args_arg rt.PhpVal) {
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_queried_object := rt.new_null()
	mut var_post := rt.new_null()
	mut var_show_comments_feed := rt.new_null()
	mut var_show_post_comments_feed := rt.new_null()
	mut var_title := rt.new_null()
	mut var_feed_link := rt.new_null()
	mut var_href := rt.new_null()
	mut var_show_post_type_archive_feed := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_post_type_obj := rt.new_null()
	mut var_show_category_feed := rt.new_null()
	mut var_term := rt.new_null()
	mut var_show_tag_feed := rt.new_null()
	mut var_show_tax_feed := rt.new_null()
	mut var_tax := rt.new_null()
	mut var_show_author_feed := rt.new_null()
	mut var_author_id := rt.new_null()
	mut var_show_search_feed := rt.new_null()
	var_defaults = { 'separator': rt.call_function('_x', [rt.new_string('&raquo;'), rt.new_string('feed link')]), 'singletitle': rt.call_function('__', [rt.new_string('%1$s %2$s %3$s Comments Feed')]), 'cattitle': rt.call_function('__', [rt.new_string('%1$s %2$s %3$s Category Feed')]), 'tagtitle': rt.call_function('__', [rt.new_string('%1$s %2$s %3$s Tag Feed')]), 'taxtitle': rt.call_function('__', [rt.new_string('%1$s %2$s %3$s %4$s Feed')]), 'authortitle': rt.call_function('__', [rt.new_string('%1$s %2$s Posts by %3$s Feed')]), 'searchtitle': rt.call_function('__', [rt.new_string('%1$s %2$s Search Results for &#8220;%3$s&#8221; Feed')]), 'posttypetitle': rt.call_function('__', [rt.new_string('%1$s %2$s %3$s Feed')]) }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	var_args = rt.call_function('apply_filters', [rt.new_string('feed_links_extra_args'), var_args.clone()])
	var_queried_object = rt.call_function('get_queried_object', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) && rt.is_true(rt.new_bool(rt.instance_of(var_queried_object, 'WP_Post'))) {
		var_post = var_queried_object.clone()
		var_show_comments_feed = rt.call_function('apply_filters', [rt.new_string('feed_links_show_comments_feed'), rt.new_bool(true)])
		var_show_post_comments_feed = rt.call_function('apply_filters', [rt.new_string('feed_links_extra_show_post_comments_feed'), var_show_comments_feed.clone()])
		if rt.is_true(var_show_post_comments_feed) && rt.is_true(rt.call_function('comments_open', [var_post.clone()])) || rt.is_true(rt.call_function('pings_open', [var_post.clone()])) || rt.new_int((rt.get_property(var_post, 'comment_count')).to_i64()) > 0 {
			var_title = rt.call_function('sprintf', [var_args.array_get(rt.new_string('singletitle')), get_bloginfo('name', ''), var_args.array_get(rt.new_string('separator')), rt.call_function('the_title_attribute', [rt.create_array([rt.ArrayItem{ key: 'echo', val: false }, rt.ArrayItem{ key: 'post', val: var_post }])])])
			var_feed_link = rt.call_function('get_post_comments_feed_link', [rt.get_property(var_post, 'ID')])
			if rt.is_true(var_feed_link) {
			var_href = var_feed_link.clone()
			}
		}
	} else if rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{})) {
		var_show_post_type_archive_feed = rt.call_function('apply_filters', [rt.new_string('feed_links_extra_show_post_type_archive_feed'), rt.new_bool(true)])
		if rt.is_true(var_show_post_type_archive_feed) {
			var_post_type = rt.call_function('get_query_var', [rt.new_string('post_type')])
			if rt.is_true(rt.new_bool(var_post_type.clone().is_array())) {
			var_post_type = rt.call_function('reset', [var_post_type.clone()])
			}
		var_post_type_obj = rt.call_function('get_post_type_object', [var_post_type.clone()])
		var_title = rt.call_function('sprintf', [var_args.array_get(rt.new_string('posttypetitle')), get_bloginfo('name', ''), var_args.array_get(rt.new_string('separator')), rt.get_property(rt.get_property(var_post_type_obj, 'labels'), 'name')])
		var_href = rt.call_function('get_post_type_archive_feed_link', [rt.get_property(var_post_type_obj, 'name')])
		}
	} else if rt.is_true(rt.call_function('is_category', []rt.PhpVal{})) {
		var_show_category_feed = rt.call_function('apply_filters', [rt.new_string('feed_links_extra_show_category_feed'), rt.new_bool(true)])
		if rt.is_true(var_show_category_feed) {
			var_term = rt.call_function('get_queried_object', []rt.PhpVal{})
			if rt.is_true(var_term) {
			var_title = rt.call_function('sprintf', [var_args.array_get(rt.new_string('cattitle')), get_bloginfo('name', ''), var_args.array_get(rt.new_string('separator')), rt.get_property(var_term, 'name')])
			var_href = rt.call_function('get_category_feed_link', [rt.get_property(var_term, 'term_id')])
			}
		}
	} else if rt.is_true(rt.call_function('is_tag', []rt.PhpVal{})) {
		var_show_tag_feed = rt.call_function('apply_filters', [rt.new_string('feed_links_extra_show_tag_feed'), rt.new_bool(true)])
		if rt.is_true(var_show_tag_feed) {
			var_term = rt.call_function('get_queried_object', []rt.PhpVal{})
			if rt.is_true(var_term) {
			var_title = rt.call_function('sprintf', [var_args.array_get(rt.new_string('tagtitle')), get_bloginfo('name', ''), var_args.array_get(rt.new_string('separator')), rt.get_property(var_term, 'name')])
			var_href = rt.call_function('get_tag_feed_link', [rt.get_property(var_term, 'term_id')])
			}
		}
	} else if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
		var_show_tax_feed = rt.call_function('apply_filters', [rt.new_string('feed_links_extra_show_tax_feed'), rt.new_bool(true)])
		if rt.is_true(var_show_tax_feed) {
			var_term = rt.call_function('get_queried_object', []rt.PhpVal{})
			if rt.is_true(var_term) {
			var_tax = rt.call_function('get_taxonomy', [rt.get_property(var_term, 'taxonomy')])
			var_title = rt.call_function('sprintf', [var_args.array_get(rt.new_string('taxtitle')), get_bloginfo('name', ''), var_args.array_get(rt.new_string('separator')), rt.get_property(var_term, 'name'), rt.get_property(rt.get_property(var_tax, 'labels'), 'singular_name')])
			var_href = rt.call_function('get_term_feed_link', [rt.get_property(var_term, 'term_id'), rt.get_property(var_term, 'taxonomy')])
			}
		}
	} else if rt.is_true(rt.call_function('is_author', []rt.PhpVal{})) {
		var_show_author_feed = rt.call_function('apply_filters', [rt.new_string('feed_links_extra_show_author_feed'), rt.new_bool(true)])
		if rt.is_true(var_show_author_feed) {
		var_author_id = rt.new_int((rt.call_function('get_query_var', [rt.new_string('author')])).to_i64())
		var_title = rt.call_function('sprintf', [var_args.array_get(rt.new_string('authortitle')), get_bloginfo('name', ''), var_args.array_get(rt.new_string('separator')), rt.call_function('get_the_author_meta', [rt.new_string('display_name'), var_author_id.clone()])])
		var_href = rt.call_function('get_author_feed_link', [var_author_id.clone()])
		}
	} else if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
		var_show_search_feed = rt.call_function('apply_filters', [rt.new_string('feed_links_extra_show_search_feed'), rt.new_bool(true)])
		if rt.is_true(var_show_search_feed) {
		var_title = rt.call_function('sprintf', [var_args.array_get(rt.new_string('searchtitle')), get_bloginfo('name', ''), var_args.array_get(rt.new_string('separator')), get_search_query(false)])
		var_href = rt.call_function('get_search_feed_link', []rt.PhpVal{})
		}
	}
	if !(var_title).is_null() && !(var_href).is_null() {
		rt.call_function('printf', [rt.new_string('<link rel="alternate" type="%s" title="%s" href="%s" />' + '\n'), rt.call_function('feed_content_type', []rt.PhpVal{}), rt.call_function('esc_attr', [var_title.clone()]), rt.call_function('esc_url', [var_href.clone()])])
	}
}

fn rsd_link() {
	rt.call_function('printf', [rt.new_string('<link rel="EditURI" type="application/rsd+xml" title="RSD" href="%s" />' + '\n'), rt.call_function('esc_url', [rt.call_function('site_url', [rt.new_string('xmlrpc.php?rsd'), rt.new_string('rpc')])])])
}

fn wp_strict_cross_origin_referrer() {
	// unsupported statement: Stmt_InlineHTML
}

fn wp_site_icon() {
	mut var_meta_tags := rt.new_null()
	mut var_icon_32 := rt.new_null()
	mut var_icon_192 := rt.new_null()
	mut var_icon_180 := rt.new_null()
	mut var_icon_270 := rt.new_null()
	mut var_meta_tag := rt.new_null()
	if !(has_site_icon()) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{}))))) {
		return
	}
	var_meta_tags = []rt.PhpVal{}
	var_icon_32 = get_site_icon_url(32, '', 0)
	if !rt.is_true(var_icon_32) && rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})) {
	var_icon_32 = rt.new_string('/favicon.ico')
	}
	if rt.is_true(var_icon_32) {
		var_meta_tags.array_push(rt.call_function('sprintf', [rt.new_string('<link rel="icon" href="%s" sizes="32x32" />'), rt.call_function('esc_url', [var_icon_32.clone()])]))
	}
	var_icon_192 = get_site_icon_url(192, '', 0)
	if rt.is_true(var_icon_192) {
		var_meta_tags.array_push(rt.call_function('sprintf', [rt.new_string('<link rel="icon" href="%s" sizes="192x192" />'), rt.call_function('esc_url', [var_icon_192.clone()])]))
	}
	var_icon_180 = get_site_icon_url(180, '', 0)
	if rt.is_true(var_icon_180) {
		var_meta_tags.array_push(rt.call_function('sprintf', [rt.new_string('<link rel="apple-touch-icon" href="%s" />'), rt.call_function('esc_url', [var_icon_180.clone()])]))
	}
	var_icon_270 = get_site_icon_url(270, '', 0)
	if rt.is_true(var_icon_270) {
		var_meta_tags.array_push(rt.call_function('sprintf', [rt.new_string('<meta name="msapplication-TileImage" content="%s" />'), rt.call_function('esc_url', [var_icon_270.clone()])]))
	}
	var_meta_tags = rt.call_function('apply_filters', [rt.new_string('site_icon_meta_tags'), var_meta_tags.clone()])
	var_meta_tags = rt.call_function('array_filter', [var_meta_tags.clone()])
	mut iter_9 := var_meta_tags.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_meta_tag_shadow := item_9.val
		print("${var_meta_tag.to_string()}\n")
	}
}

fn wp_resource_hints() {
	mut var_hints := map[string]rt.PhpVal{}
	mut var_urls := rt.new_null()
	mut var_relation_type := rt.new_null()
	mut var_unique_urls := rt.new_null()
	mut var_url := rt.new_null()
	mut var_key := rt.new_null()
	mut var_atts := rt.new_null()
	mut var_parsed := rt.new_null()
	mut var_html := ''
	mut var_value := rt.new_null()
	mut var_attr := rt.new_null()
	var_hints = { 'dns-prefetch': wp_dependencies_unique_hosts(), 'preconnect': []rt.PhpVal{}, 'prefetch': []rt.PhpVal{}, 'prerender': []rt.PhpVal{} }
	for var_relation_type_shadow, var_urls_shadow in var_hints {
		var_unique_urls = []rt.PhpVal{}
		var_urls_shadow = rt.call_function('apply_filters', [rt.new_string('wp_resource_hints'), var_urls_shadow.clone(), rt.new_string((var_relation_type_shadow).str()).clone()])
		mut iter_10 := var_urls_shadow.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_url_shadow := item_10.val
			mut var_key_shadow := item_10.key
			var_atts = []rt.PhpVal{}
			if rt.is_true(rt.new_bool(var_url_shadow.clone().is_array())) {
				if var_url_shadow.array_isset(rt.new_string('href')) {
				var_atts = var_url_shadow.clone()
				var_url_shadow = var_url_shadow.array_get(rt.new_string('href'))
				} else {
					continue
				}
			}
			var_url_shadow = rt.call_function('esc_url', [var_url_shadow.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'http' }, rt.ArrayItem{ key: none, val: 'https' }])])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_url_shadow)))) {
				continue
			}
			if var_unique_urls.array_isset(var_url_shadow) {
				continue
			}
			if rt.is_true(rt.call_function('in_array', [rt.new_string((var_relation_type_shadow).str()).clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'preconnect' }, rt.ArrayItem{ key: none, val: 'dns-prefetch' }]), rt.new_bool(true)])) {
				var_parsed = rt.call_function('wp_parse_url', [var_url_shadow.clone()])
				if !rt.is_true(var_parsed.array_get(rt.new_string('host'))) {
					continue
				}
				if rt.is_true(rt.identical(rt.new_string('preconnect'), rt.new_string((var_relation_type_shadow).str()))) && !(!rt.is_true(var_parsed.array_get(rt.new_string('scheme')))) {
				var_url_shadow = rt.new_string((var_parsed.array_get(rt.new_string('scheme'))).str() + '://' + (var_parsed.array_get(rt.new_string('host'))).str())
				} else {
				var_url_shadow = rt.new_string('//' + (var_parsed.array_get(rt.new_string('host'))).str())
				}
			}
			var_atts.array_set('rel', rt.new_string((var_relation_type_shadow).str()).clone())
			var_atts.array_set('href', var_url_shadow.clone())
			var_unique_urls.array_set(var_url_shadow, var_atts.clone())
		}
		mut iter_11 := var_unique_urls.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_atts_shadow := item_11.val
			var_html = ''
			mut iter_12 := var_atts_shadow.iterator()
			for {
				item_12 := iter_12.next() or { break }
				mut var_value_shadow := item_12.val
				mut var_attr_shadow := item_12.key
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_value_shadow.clone()]))))) || (rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_attr_shadow.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'as' }, rt.ArrayItem{ key: none, val: 'crossorigin' }, rt.ArrayItem{ key: none, val: 'href' }, rt.ArrayItem{ key: none, val: 'pr' }, rt.ArrayItem{ key: none, val: 'rel' }, rt.ArrayItem{ key: none, val: 'type' }]), rt.new_bool(true)]))))) && !(var_attr_shadow.clone().is_long() || var_attr_shadow.clone().is_double())) {
					continue
				}
				var_value_shadow = if rt.is_true(rt.identical(rt.new_string('href'), var_attr_shadow)) { rt.call_function('esc_url', [var_value_shadow.clone()]) } else { rt.call_function('esc_attr', [var_value_shadow.clone()]) }
				if !(var_attr_shadow.clone().is_string()) {
					var_html = var_html + " ${var_value.to_string()}"
				} else {
					var_html = var_html + " ${var_attr.to_string()}='${var_value.to_string()}'"
				}
			}
			var_html = var_html.trim_space()
			print("<link ${var_html} />\n")
		}
	}
}

fn wp_preload_resources() {
	mut var_preload_resources := rt.new_null()
	mut var_unique_resources := rt.new_null()
	mut var_resource := map[string]rt.PhpVal{}
	mut var_attributes := rt.new_null()
	mut var_href := rt.new_null()
	mut var_unique_resource := map[string]rt.PhpVal{}
	mut var_html := ''
	mut var_resource_value := rt.new_null()
	mut var_resource_key := rt.new_null()
	mut var_non_supported_attributes := []rt.PhpVal{}
	var_preload_resources = rt.call_function('apply_filters', [rt.new_string('wp_preload_resources'), []rt.PhpVal{}])
	if !(var_preload_resources.clone().is_array()) {
		return
	}
	var_unique_resources = []rt.PhpVal{}
	mut iter_13 := var_preload_resources.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_resource_shadow := item_13.val
		if !(var_resource_shadow.clone().is_array()) {
			continue
		}
		var_attributes = var_resource_shadow
		if var_resource_shadow.array_isset(rt.new_string('href')) {
			var_href = var_resource_shadow['href']
			if var_unique_resources.array_isset(var_href) {
				continue
			}
			var_unique_resources.array_set(var_href, var_attributes.clone())
		} else if rt.is_true(rt.identical(rt.new_string('image'), var_resource_shadow['as'])) && var_resource_shadow.array_isset(rt.new_string('imagesrcset')) || var_resource_shadow.array_isset(rt.new_string('imagesizes')) {
			if var_unique_resources.array_isset(var_resource_shadow['imagesrcset']) {
				continue
			}
			var_unique_resources.array_set(var_resource_shadow['imagesrcset'], var_attributes.clone())
		} else {
			continue
		}
	}
	mut iter_14 := var_unique_resources.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_unique_resource_shadow := item_14.val
		var_html = ''
		for var_resource_key_shadow, var_resource_value_shadow in var_unique_resource_shadow {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_resource_value_shadow.clone()]))))) {
				continue
			}
			var_non_supported_attributes = ['as', 'crossorigin', 'href', 'imagesrcset', 'imagesizes', 'type', 'media', 'fetchpriority']
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string((var_resource_key_shadow).str()).clone(), rt.create_array_from_list(var_non_supported_attributes), rt.new_bool(true)]))))) && !(rt.new_string((var_resource_key_shadow).str()).clone().is_long() || rt.new_string((var_resource_key_shadow).str()).clone().is_double()) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('imagesrcset'), rt.new_string((var_resource_key_shadow).str()))) && !(var_unique_resource_shadow.array_isset(rt.new_string('as'))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('image'), var_unique_resource_shadow['as'])))) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('imagesizes'), rt.new_string((var_resource_key_shadow).str()))) && !(var_unique_resource_shadow.array_isset(rt.new_string('as'))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('image'), var_unique_resource_shadow['as'])))) || !(var_unique_resource_shadow.array_isset(rt.new_string('imagesrcset'))) {
				continue
			}
			var_resource_value_shadow = if rt.is_true(rt.identical(rt.new_string('href'), rt.new_string((var_resource_key_shadow).str()))) { rt.call_function('esc_url', [var_resource_value_shadow.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'http' }, rt.ArrayItem{ key: none, val: 'https' }])]) } else { rt.call_function('esc_attr', [var_resource_value_shadow.clone()]) }
			if !(rt.new_string((var_resource_key_shadow).str()).clone().is_string()) {
				var_html = var_html + " ${var_resource_value.to_string()}"
			} else {
				var_html = var_html + " ${var_resource_key.to_string()}='${var_resource_value.to_string()}'"
			}
		}
		var_html = var_html.trim_space()
		rt.call_function('printf', [rt.new_string('<link rel=\'preload\' %s />\n'), rt.new_string((var_html).str()).clone()])
	}
}

fn wp_dependencies_unique_hosts() rt.PhpVal {
	mut var_wp_scripts := rt.new_null()
	mut var_wp_styles := rt.new_null()
	mut var_unique_hosts := []rt.PhpVal{}
	mut var_dependencies := rt.new_null()
	mut var_handle := rt.new_null()
	mut var_dependency := rt.new_null()
	mut var_parsed := rt.new_null()
	var_unique_hosts = []rt.PhpVal{}
	mut iter_15 := rt.create_array([rt.ArrayItem{ key: none, val: var_wp_scripts }, rt.ArrayItem{ key: none, val: var_wp_styles }]).iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_dependencies_shadow := item_15.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_dependencies_shadow, 'WP_Dependencies'))) && !(!rt.is_true(rt.get_property(var_dependencies_shadow, 'queue'))) {
			mut iter_16 := rt.get_property(var_dependencies_shadow, 'queue').iterator()
			for {
				item_16 := iter_16.next() or { break }
				mut var_handle_shadow := item_16.val
				if !(rt.get_property(var_dependencies_shadow, 'registered').array_isset(var_handle_shadow)) {
					continue
				}
				var_dependency = rt.get_property(var_dependencies_shadow, 'registered').array_get(var_handle_shadow)
				var_parsed = rt.call_function('wp_parse_url', [rt.get_property(var_dependency, 'src')])
				if !(!rt.is_true(var_parsed.array_get(rt.new_string('host')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_parsed.array_get(rt.new_string('host')), rt.create_array_from_list(var_unique_hosts), rt.new_bool(true)]))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parsed.array_get(rt.new_string('host')), rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_NAME')))))) {
					var_unique_hosts << var_parsed.array_get(rt.new_string('host'))
				}
			}
		}
	}
	return var_unique_hosts.clone()
}

fn user_can_richedit() rt.PhpVal {
	mut var_is_gecko := rt.new_null()
	mut var_is_opera := rt.new_null()
	mut var_is_safari := rt.new_null()
	mut var_is_chrome := rt.new_null()
	mut var_is_IE := rt.new_null()
	mut var_is_edge := rt.new_null()
	mut var_match := []rt.PhpVal{}
	mut var_wp_rich_edit := rt.new_null()
	if !(!(var_wp_rich_edit).is_null()) {
		var_wp_rich_edit = rt.new_bool(false)
		if rt.is_true(rt.identical(rt.new_string('true'), rt.call_function('get_user_option', [rt.new_string('rich_editing')]))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
			if rt.is_true(var_is_safari) {
			var_wp_rich_edit = rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{}))))) || rt.is_true(rt.call_function('preg_match', [rt.new_string('!AppleWebKit/(\\d+)!'), rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.create_array_from_list(var_match)])) && rt.new_int((var_match[1]).to_i64()) >= 534)
			} else if rt.is_true(var_is_IE) {
			var_wp_rich_edit = rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('Trident/7.0;')])
			} else if rt.is_true(var_is_gecko) || rt.is_true(var_is_chrome) || rt.is_true(var_is_edge) || (rt.is_true(var_is_opera) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})))))) {
			var_wp_rich_edit = rt.new_bool(true)
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('user_can_richedit'), var_wp_rich_edit.clone()])
}

fn wp_default_editor() rt.PhpVal {
	mut var_r := rt.new_null()
	mut var_ed := rt.new_null()
	var_r = rt.new_string((if rt.is_true(user_can_richedit()) { 'tinymce' } else { 'html' }).str())
	if rt.is_true(rt.call_function('wp_get_current_user', []rt.PhpVal{})) {
	var_ed = rt.call_function('get_user_setting', [rt.new_string('editor'), rt.new_string('tinymce')])
	var_r = if rt.is_true(rt.call_function('in_array', [var_ed.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'tinymce' }, rt.ArrayItem{ key: none, val: 'html' }, rt.ArrayItem{ key: none, val: 'test' }]), rt.new_bool(true)])) { var_ed } else { var_r }
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_default_editor'), var_r.clone()])
}

fn wp_editor(var_content rt.PhpVal, var_editor_id rt.PhpVal, var_settings rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('_WP_Editors'), rt.new_bool(false)]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-editor.php', '3')
	}
mut iife_temp_0 := Class__WP_Editors{}
mut iife_result_0 := iife_temp_0.editor(var_content.clone(), var_editor_id.clone(), var_settings.clone())
}

fn wp_enqueue_editor() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('_WP_Editors'), rt.new_bool(false)]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-editor.php', '3')
	}
mut iife_temp_1 := Class__WP_Editors{}
mut iife_result_1 := iife_temp_1.enqueue_default_editor()
}

fn wp_enqueue_code_editor(var_args rt.PhpVal) bool {
	mut var_settings := rt.new_null()
	mut var_mode := rt.new_null()
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_string('false'), rt.get_property(rt.call_function('wp_get_current_user', []rt.PhpVal{}), 'syntax_highlighting'))) {
		return false
	}
	var_settings = wp_get_code_editor_settings(var_args.clone())
	if !rt.is_true(var_settings) || !rt.is_true(var_settings.array_get(rt.new_string('codemirror'))) {
		return false
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('code-editor')])
	rt.call_function('wp_enqueue_style', [rt.new_string('code-editor')])
	if var_settings.array_get(rt.new_string('codemirror')).array_isset(rt.new_string('mode')) {
		var_mode = var_settings.array_get(rt.new_string('codemirror')).array_get(rt.new_string('mode'))
		if rt.is_true(rt.new_bool(var_mode.clone().is_string())) {
		var_mode = rt.create_array([rt.ArrayItem{ key: 'name', val: var_mode }])
		}
		if !(!rt.is_true(var_settings.array_get(rt.new_string('codemirror')).array_get(rt.new_string('lint')))) {
			mut switch_val_2 := var_mode.array_get(rt.new_string('name'))
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('css'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('text/css'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('text/x-scss'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('text/x-less'))) {
				rt.call_function('wp_enqueue_script', [rt.new_string('csslint')])
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('htmlmixed'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('text/html'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('php'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('application/x-httpd-php'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('text/x-php'))) {
				rt.call_function('wp_enqueue_script', [rt.new_string('htmlhint')])
				rt.call_function('wp_enqueue_script', [rt.new_string('csslint')])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('unfiltered_html')]))))) {
					rt.call_function('wp_enqueue_script', [rt.new_string('htmlhint-kses')])
				}
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('javascript'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('application/ecmascript'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('application/json'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('application/javascript'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('application/ld+json'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('text/typescript'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('application/typescript'))) {
				rt.call_function('wp_enqueue_script', [rt.new_string('jsonlint')])
			}
		}
	}
	rt.call_function('wp_add_inline_script', [rt.new_string('code-editor'), rt.call_function('sprintf', [rt.new_string('jQuery.extend( wp.codeEditor.defaultSettings, %s );'), rt.call_function('wp_json_encode', [var_settings.clone(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])])])
	rt.call_function('do_action', [rt.new_string('wp_enqueue_code_editor'), var_settings.clone()])
	return (var_settings).to_bool()
}

fn wp_get_code_editor_settings(var_args rt.PhpVal) rt.PhpVal {
	mut var_settings := rt.new_null()
	mut var_type := rt.new_null()
	mut var_extension := ''
	mut var_mime := rt.new_null()
	mut var_exts := rt.new_null()
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	var_settings = rt.create_array([rt.ArrayItem{ key: 'codemirror', val: rt.create_array([rt.ArrayItem{ key: 'indentUnit', val: 4 }, rt.ArrayItem{ key: 'indentWithTabs', val: true }, rt.ArrayItem{ key: 'inputStyle', val: 'contenteditable' }, rt.ArrayItem{ key: 'lineNumbers', val: true }, rt.ArrayItem{ key: 'lineWrapping', val: true }, rt.ArrayItem{ key: 'styleActiveLine', val: true }, rt.ArrayItem{ key: 'continueComments', val: true }, rt.ArrayItem{ key: 'extraKeys', val: rt.create_array([rt.ArrayItem{ key: 'Ctrl-Space', val: 'autocomplete' }, rt.ArrayItem{ key: 'Ctrl-/', val: 'toggleComment' }, rt.ArrayItem{ key: 'Cmd-/', val: 'toggleComment' }, rt.ArrayItem{ key: 'Alt-F', val: 'findPersistent' }, rt.ArrayItem{ key: 'Ctrl-F', val: 'findPersistent' }, rt.ArrayItem{ key: 'Cmd-F', val: 'findPersistent' }]) }, rt.ArrayItem{ key: 'direction', val: 'ltr' }, rt.ArrayItem{ key: 'gutters', val: []rt.PhpVal{} }]) }, rt.ArrayItem{ key: 'csslint', val: rt.create_array([rt.ArrayItem{ key: 'errors', val: true }, rt.ArrayItem{ key: 'box-model', val: true }, rt.ArrayItem{ key: 'display-property-grouping', val: true }, rt.ArrayItem{ key: 'duplicate-properties', val: true }, rt.ArrayItem{ key: 'known-properties', val: true }, rt.ArrayItem{ key: 'outline-none', val: true }]) }, rt.ArrayItem{ key: 'jshint', val: rt.create_array([rt.ArrayItem{ key: 'esversion', val: 11 }, rt.ArrayItem{ key: 'module', val: rt.call_function('str_ends_with', [if !(var_args.array_get(rt.new_string('file'))).is_null() { var_args.array_get(rt.new_string('file')) } else { rt.new_string('') }, rt.new_string('.mjs')]) }, rt.ArrayItem{ key: 'espreeModuleUrl', val: rt.call_function('add_query_arg', [rt.new_string('ver'), rt.new_string('9.6.1'), rt.call_function('includes_url', [rt.new_string('js/codemirror/espree.min.js')])]) }, rt.ArrayItem{ key: 'boss', val: true }, rt.ArrayItem{ key: 'curly', val: true }, rt.ArrayItem{ key: 'eqeqeq', val: true }, rt.ArrayItem{ key: 'eqnull', val: true }, rt.ArrayItem{ key: 'expr', val: true }, rt.ArrayItem{ key: 'immed', val: true }, rt.ArrayItem{ key: 'noarg', val: true }, rt.ArrayItem{ key: 'nonbsp', val: true }, rt.ArrayItem{ key: 'quotmark', val: 'single' }, rt.ArrayItem{ key: 'undef', val: true }, rt.ArrayItem{ key: 'unused', val: true }, rt.ArrayItem{ key: 'browser', val: true }, rt.ArrayItem{ key: 'globals', val: rt.create_array([rt.ArrayItem{ key: '_', val: false }, rt.ArrayItem{ key: 'Backbone', val: false }, rt.ArrayItem{ key: 'jQuery', val: false }, rt.ArrayItem{ key: 'JSON', val: false }, rt.ArrayItem{ key: 'wp', val: false }, rt.ArrayItem{ key: 'export', val: false }, rt.ArrayItem{ key: 'module', val: false }, rt.ArrayItem{ key: 'require', val: false }, rt.ArrayItem{ key: 'WorkerGlobalScope', val: false }, rt.ArrayItem{ key: 'self', val: false }, rt.ArrayItem{ key: 'OffscreenCanvas', val: false }, rt.ArrayItem{ key: 'Promise', val: false }]) }]) }, rt.ArrayItem{ key: 'htmlhint', val: rt.create_array([rt.ArrayItem{ key: 'tagname-lowercase', val: true }, rt.ArrayItem{ key: 'attr-lowercase', val: true }, rt.ArrayItem{ key: 'attr-value-double-quotes', val: false }, rt.ArrayItem{ key: 'doctype-first', val: false }, rt.ArrayItem{ key: 'tag-pair', val: true }, rt.ArrayItem{ key: 'spec-char-escape', val: true }, rt.ArrayItem{ key: 'id-unique', val: true }, rt.ArrayItem{ key: 'src-not-empty', val: true }, rt.ArrayItem{ key: 'attr-no-duplication', val: true }, rt.ArrayItem{ key: 'alt-require', val: true }, rt.ArrayItem{ key: 'space-tab-mixed-disabled', val: 'tab' }, rt.ArrayItem{ key: 'attr-unsafe-chars', val: true }]) }])
	var_type = rt.new_string('')
	if var_args.array_isset(rt.new_string('type')) {
		var_type = var_args.array_get(rt.new_string('type'))
		if rt.is_true(rt.identical(rt.new_string('application/x-patch'), var_type)) || rt.is_true(rt.identical(rt.new_string('text/x-patch'), var_type)) {
		var_type = rt.new_string('text/x-diff')
		}
	} else if var_args.array_isset(rt.new_string('file')) && rt.is_true(rt.call_function('str_contains', [rt.call_function('basename', [var_args.array_get(rt.new_string('file'))]), rt.new_string('.')])) {
		var_extension = rt.call_function('pathinfo', [var_args.array_get(rt.new_string('file')), rt.get_constant('PATHINFO_EXTENSION')]).to_string().to_lower()
		mut iter_17 := rt.call_function('wp_get_mime_types', []rt.PhpVal{}).iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_mime_shadow := item_17.val
			mut var_exts_shadow := item_17.key
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('!^(' + (var_exts_shadow).str() + ')$!i'), rt.new_string((var_extension).str()).clone()])) {
				var_type = var_mime_shadow
				break
			}
		}
		if !rt.is_true(var_type) {
			mut switch_val_3 := rt.new_string((var_extension).str())
			if rt.is_true(rt.equal(switch_val_3, rt.new_string('conf'))) {
			var_type = rt.new_string('text/nginx')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('css'))) {
			var_type = rt.new_string('text/css')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('diff'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('patch'))) {
			var_type = rt.new_string('text/x-diff')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('html'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('htm'))) {
			var_type = rt.new_string('text/html')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('http'))) {
			var_type = rt.new_string('message/http')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('js'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('mjs'))) {
			var_type = rt.new_string('text/javascript')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('json'))) {
			var_type = rt.new_string('application/json')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('jsx'))) {
			var_type = rt.new_string('text/jsx')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('less'))) {
			var_type = rt.new_string('text/x-less')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('md'))) {
			var_type = rt.new_string('text/x-gfm')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('php'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('phtml'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('php3'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('php4'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('php5'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('php7'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('phps'))) {
			var_type = rt.new_string('application/x-httpd-php')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('scss'))) {
			var_type = rt.new_string('text/x-scss')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('sass'))) {
			var_type = rt.new_string('text/x-sass')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('sh'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('bash'))) {
			var_type = rt.new_string('text/x-sh')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('sql'))) {
			var_type = rt.new_string('text/x-sql')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('svg'))) {
			var_type = rt.new_string('application/svg+xml')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('xml'))) {
			var_type = rt.new_string('text/xml')
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('yml'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('yaml'))) {
			var_type = rt.new_string('text/x-yaml')
			} else {
			var_type = rt.new_string('text/plain')
			}
		}
	}
	if rt.is_true(rt.call_function('in_array', [var_type.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'text/css' }, rt.ArrayItem{ key: none, val: 'text/x-scss' }, rt.ArrayItem{ key: none, val: 'text/x-less' }, rt.ArrayItem{ key: none, val: 'text/x-sass' }]), rt.new_bool(true)])) {
		var_settings.array_set('codemirror', rt.call_function('array_merge', [var_settings.array_get(rt.new_string('codemirror')), rt.create_array([rt.ArrayItem{ key: 'mode', val: var_type }, rt.ArrayItem{ key: 'lint', val: false }, rt.ArrayItem{ key: 'autoCloseBrackets', val: true }, rt.ArrayItem{ key: 'matchBrackets', val: true }])]))
	} else if rt.is_true(rt.identical(rt.new_string('text/x-diff'), var_type)) {
		var_settings.array_set('codemirror', rt.call_function('array_merge', [var_settings.array_get(rt.new_string('codemirror')), rt.create_array([rt.ArrayItem{ key: 'mode', val: 'diff' }])]))
	} else if rt.is_true(rt.identical(rt.new_string('text/html'), var_type)) {
		var_settings.array_set('codemirror', rt.call_function('array_merge', [var_settings.array_get(rt.new_string('codemirror')), rt.create_array([rt.ArrayItem{ key: 'mode', val: 'htmlmixed' }, rt.ArrayItem{ key: 'lint', val: true }, rt.ArrayItem{ key: 'autoCloseBrackets', val: true }, rt.ArrayItem{ key: 'autoCloseTags', val: true }, rt.ArrayItem{ key: 'matchTags', val: rt.create_array([rt.ArrayItem{ key: 'bothTags', val: true }]) }])]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('unfiltered_html')]))))) {
			var_settings.array_get_mut('htmlhint').array_set('kses', rt.call_function('wp_kses_allowed_html', [rt.new_string('post')]))
		}
	} else if rt.is_true(rt.identical(rt.new_string('text/x-gfm'), var_type)) {
		var_settings.array_set('codemirror', rt.call_function('array_merge', [var_settings.array_get(rt.new_string('codemirror')), rt.create_array([rt.ArrayItem{ key: 'mode', val: 'gfm' }, rt.ArrayItem{ key: 'highlightFormatting', val: true }])]))
	} else if rt.is_true(rt.identical(rt.new_string('application/javascript'), var_type)) || rt.is_true(rt.identical(rt.new_string('text/javascript'), var_type)) {
		var_settings.array_set('codemirror', rt.call_function('array_merge', [var_settings.array_get(rt.new_string('codemirror')), rt.create_array([rt.ArrayItem{ key: 'mode', val: 'javascript' }, rt.ArrayItem{ key: 'lint', val: true }, rt.ArrayItem{ key: 'autoCloseBrackets', val: true }, rt.ArrayItem{ key: 'matchBrackets', val: true }])]))
	} else if rt.is_true(rt.call_function('str_contains', [var_type.clone(), rt.new_string('json')])) {
		var_settings.array_set('codemirror', rt.call_function('array_merge', [var_settings.array_get(rt.new_string('codemirror')), rt.create_array([rt.ArrayItem{ key: 'mode', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'javascript' }]) }, rt.ArrayItem{ key: 'lint', val: true }, rt.ArrayItem{ key: 'autoCloseBrackets', val: true }, rt.ArrayItem{ key: 'matchBrackets', val: true }])]))
		if rt.is_true(rt.identical(rt.new_string('application/ld+json'), var_type)) {
			var_settings.array_get_mut('codemirror').array_get_mut('mode').array_set('jsonld', true)
		} else {
			var_settings.array_get_mut('codemirror').array_get_mut('mode').array_set('json', true)
		}
	} else if rt.is_true(rt.call_function('str_contains', [var_type.clone(), rt.new_string('jsx')])) {
		var_settings.array_set('codemirror', rt.call_function('array_merge', [var_settings.array_get(rt.new_string('codemirror')), rt.create_array([rt.ArrayItem{ key: 'mode', val: 'jsx' }, rt.ArrayItem{ key: 'autoCloseBrackets', val: true }, rt.ArrayItem{ key: 'matchBrackets', val: true }])]))
	} else if rt.is_true(rt.identical(rt.new_string('text/x-markdown'), var_type)) {
		var_settings.array_set('codemirror', rt.call_function('array_merge', [var_settings.array_get(rt.new_string('codemirror')), rt.create_array([rt.ArrayItem{ key: 'mode', val: 'markdown' }, rt.ArrayItem{ key: 'highlightFormatting', val: true }])]))
	} else if rt.is_true(rt.identical(rt.new_string('text/nginx'), var_type)) {
		var_settings.array_set('codemirror', rt.call_function('array_merge', [var_settings.array_get(rt.new_string('codemirror')), rt.create_array([rt.ArrayItem{ key: 'mode', val: 'nginx' }])]))
	} else if rt.is_true(rt.identical(rt.new_string('application/x-httpd-php'), var_type)) {
		var_settings.array_set('codemirror', rt.call_function('array_merge', [var_settings.array_get(rt.new_string('codemirror')), rt.create_array([rt.ArrayItem{ key: 'mode', val: 'php' }, rt.ArrayItem{ key: 'autoCloseBrackets', val: true }, rt.ArrayItem{ key: 'autoCloseTags', val: true }, rt.ArrayItem{ key: 'matchBrackets', val: true }, rt.ArrayItem{ key: 'matchTags', val: rt.create_array([rt.ArrayItem{ key: 'bothTags', val: true }]) }])]))
	} else if rt.is_true(rt.identical(rt.new_string('text/x-sql'), var_type)) || rt.is_true(rt.identical(rt.new_string('text/x-mysql'), var_type)) {
		var_settings.array_set('codemirror', rt.call_function('array_merge', [var_settings.array_get(rt.new_string('codemirror')), rt.create_array([rt.ArrayItem{ key: 'mode', val: 'sql' }, rt.ArrayItem{ key: 'autoCloseBrackets', val: true }, rt.ArrayItem{ key: 'matchBrackets', val: true }])]))
	} else if rt.is_true(rt.call_function('str_contains', [var_type.clone(), rt.new_string('xml')])) {
		var_settings.array_set('codemirror', rt.call_function('array_merge', [var_settings.array_get(rt.new_string('codemirror')), rt.create_array([rt.ArrayItem{ key: 'mode', val: 'xml' }, rt.ArrayItem{ key: 'autoCloseBrackets', val: true }, rt.ArrayItem{ key: 'autoCloseTags', val: true }, rt.ArrayItem{ key: 'matchTags', val: rt.create_array([rt.ArrayItem{ key: 'bothTags', val: true }]) }])]))
	} else if rt.is_true(rt.identical(rt.new_string('text/x-yaml'), var_type)) {
		var_settings.array_set('codemirror', rt.call_function('array_merge', [var_settings.array_get(rt.new_string('codemirror')), rt.create_array([rt.ArrayItem{ key: 'mode', val: 'yaml' }])]))
	} else {
		var_settings.array_get_mut('codemirror').array_set('mode', var_type.clone())
	}
	if !(!rt.is_true(var_settings.array_get(rt.new_string('codemirror')).array_get(rt.new_string('lint')))) {
		var_settings.array_get_mut('codemirror').array_get_mut('gutters').array_push('CodeMirror-lint-markers')
	}
	mut iter_18 := rt.call_function('wp_array_slice_assoc', [var_args.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'codemirror' }, rt.ArrayItem{ key: none, val: 'csslint' }, rt.ArrayItem{ key: none, val: 'jshint' }, rt.ArrayItem{ key: none, val: 'htmlhint' }])]).iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_value_shadow := item_18.val
		mut var_key_shadow := item_18.key
		var_settings.array_set(var_key_shadow, rt.call_function('array_merge', [var_settings.array_get(var_key_shadow), var_value_shadow.clone()]))
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_code_editor_settings'), var_settings.clone(), var_args.clone()])
}

fn get_search_query(escaped bool) rt.PhpVal {
	mut var_escaped := escaped
	mut var_query := rt.new_null()
	var_query = rt.call_function('apply_filters', [rt.new_string('get_search_query'), rt.call_function('get_query_var', [rt.new_string('s')])])
	if var_escaped {
	var_query = rt.call_function('esc_attr', [var_query.clone()])
	}
	return var_query.clone()
}

fn the_search_query() {
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('apply_filters', [rt.new_string('the_search_query'), get_search_query(false)])]))
}

fn get_language_attributes(doctype string) rt.PhpVal {
	mut var_doctype := doctype
	mut var_attributes := rt.new_null()
	mut var_lang := rt.new_null()
	mut var_output := rt.new_null()
	var_attributes = []rt.PhpVal{}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('is_rtl')])) && rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		var_attributes.array_push('dir="rtl"')
	}
	var_lang = get_bloginfo('language', '')
	if rt.is_true(var_lang) {
		if rt.is_true(rt.identical(rt.new_string('text/html'), rt.call_function('get_option', [rt.new_string('html_type')]))) || rt.is_true(rt.identical(rt.new_string('html'), rt.new_string(doctype))) {
			var_attributes.array_push('lang="' + (rt.call_function('esc_attr', [var_lang.clone()])).str() + '"')
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('text/html'), rt.call_function('get_option', [rt.new_string('html_type')]))))) || rt.is_true(rt.identical(rt.new_string('xhtml'), rt.new_string(doctype))) {
			var_attributes.array_push('xml:lang="' + (rt.call_function('esc_attr', [var_lang.clone()])).str() + '"')
		}
	}
	var_output = rt.call_function('implode', [rt.new_string(' '), var_attributes.clone()])
	return rt.call_function('apply_filters', [rt.new_string('language_attributes'), var_output.clone(), rt.new_string(doctype)])
}

fn language_attributes(doctype string) {
	mut var_doctype := doctype
	rt.echo_val(get_language_attributes(doctype))
}

fn paginate_links(args string) rt.PhpVal {
	mut var_args := args
	mut var_wp_query := rt.new_null()
	mut var_wp_rewrite := rt.new_null()
	mut var_format_args := rt.new_null()
	mut var_url_query_args := rt.new_null()
	mut var_pagenum_link := rt.new_null()
	mut var_url_parts := rt.new_null()
	mut var_total := rt.new_null()
	mut var_current := rt.new_null()
	mut var_format := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_format_query := rt.new_null()
	mut var_format_arg_value := rt.new_null()
	mut var_format_arg := rt.new_null()
	mut var_end_size := rt.new_null()
	mut var_mid_size := rt.new_null()
	mut var_add_args := rt.new_null()
	mut var_r := rt.new_null()
	mut var_page_links := []rt.PhpVal{}
	mut var_dots := false
	mut var_link := rt.new_null()
	mut var_n := i64(0)
	var_pagenum_link = rt.call_function('html_entity_decode', [rt.call_function('get_pagenum_link', []rt.PhpVal{})])
	var_url_parts = rt.call_function('explode', [rt.new_string('?'), var_pagenum_link.clone()])
	var_total = if !(rt.get_property(var_wp_query, 'max_num_pages')).is_null() { rt.get_property(var_wp_query, 'max_num_pages') } else { rt.new_int(1) }
	var_current = rt.new_int(if rt.is_true(rt.call_function('get_query_var', [rt.new_string('paged')])) { rt.new_int((rt.call_function('get_query_var', [rt.new_string('paged')])).to_i64()) } else { 1 })
	if rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_wp_rewrite, 'use_trailing_slashes'))))) {
	var_pagenum_link = rt.call_function('untrailingslashit', [var_url_parts.array_get(rt.new_int(0))])
	} else {
	var_pagenum_link = rt.call_function('trailingslashit', [var_url_parts.array_get(rt.new_int(0))])
	}
	var_pagenum_link = rt.concat(var_pagenum_link, rt.new_string('%_%'))
	var_format = rt.new_string((if rt.is_true(rt.call_method(var_wp_rewrite, 'using_index_permalinks', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strpos', [var_pagenum_link.clone(), rt.new_string('index.php')]))))) { 'index.php/' } else { '' }).str())
	var_format = rt.concat(var_format, if rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{})) { rt.call_function('user_trailingslashit', [rt.new_string((rt.get_property(var_wp_rewrite, 'pagination_base')).str() + '/%#%'), rt.new_string('paged')]) } else { rt.new_string('?paged=%#%') })
	if rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_wp_rewrite, 'use_trailing_slashes'))))) {
	var_format = rt.new_string('/' + var_format.clone().to_string().trim_left(' \t\n\r'))
	}
	var_defaults = { 'base': var_pagenum_link, 'format': var_format, 'total': var_total, 'current': var_current, 'aria_current': rt.new_string('page'), 'show_all': rt.new_bool(false), 'prev_next': rt.new_bool(true), 'prev_text': rt.call_function('__', [rt.new_string('&laquo; Previous')]), 'next_text': rt.call_function('__', [rt.new_string('Next &raquo;')]), 'end_size': rt.new_int(1), 'mid_size': rt.new_int(2), 'type': rt.new_string('plain'), 'add_args': []rt.PhpVal{}, 'add_fragment': rt.new_string(''), 'before_page_number': rt.new_string(''), 'after_page_number': rt.new_string('') }
	var_args = (rt.call_function('wp_parse_args', [rt.new_string((var_args).str()), rt.create_array_from_native_map(var_defaults)])).str()
	if !(rt.new_string((var_args).str()).array_get(rt.new_string('add_args')).is_array()) {
		rt.new_string((var_args).str()).array_set('add_args', []rt.PhpVal{})
	}
	if var_url_parts.array_isset(rt.new_int(1)) {
		var_format = rt.call_function('explode', [rt.new_string('?'), rt.call_function('str_replace', [rt.new_string('%_%'), rt.new_string((var_args).str()).array_get(rt.new_string('format')), rt.new_string((var_args).str()).array_get(rt.new_string('base'))])])
		var_format_query = if !(var_format.array_get(rt.new_int(1))).is_null() { var_format.array_get(rt.new_int(1)) } else { rt.new_string('') }
		rt.call_function('wp_parse_str', [var_format_query.clone(), var_format_args.clone()])
		rt.call_function('wp_parse_str', [var_url_parts.array_get(rt.new_int(1)), var_url_query_args.clone()])
		mut iter_19 := var_format_args.iterator()
		for {
			item_19 := iter_19.next() or { break }
			mut var_format_arg_value_shadow := item_19.val
			mut var_format_arg_shadow := item_19.key
			var_url_query_args.array_unset(var_format_arg_shadow)
		}
		rt.new_string((var_args).str()).array_set('add_args', rt.call_function('array_merge', [rt.new_string((var_args).str()).array_get(rt.new_string('add_args')), rt.call_function('urlencode_deep', [var_url_query_args.clone()])]))
	}
	var_total = rt.new_int((rt.new_string((var_args).str()).array_get(rt.new_string('total'))).to_i64())
	if rt.is_true(rt.less(var_total, rt.new_int(2))) {
		return rt.new_null()
	}
	var_current = rt.new_int((rt.new_string((var_args).str()).array_get(rt.new_string('current'))).to_i64())
	var_end_size = rt.new_int((rt.new_string((var_args).str()).array_get(rt.new_string('end_size'))).to_i64())
	if rt.is_true(rt.less(var_end_size, rt.new_int(1))) {
	var_end_size = rt.new_int(1)
	}
	var_mid_size = rt.new_int((rt.new_string((var_args).str()).array_get(rt.new_string('mid_size'))).to_i64())
	if rt.is_true(rt.less(var_mid_size, rt.new_int(0))) {
	var_mid_size = rt.new_int(2)
	}
	var_add_args = rt.new_string((var_args).str()).array_get(rt.new_string('add_args'))
	var_r = rt.new_string('')
	var_page_links = []rt.PhpVal{}
	var_dots = false
	if rt.is_true(rt.new_string((var_args).str()).array_get(rt.new_string('prev_next'))) && rt.is_true(var_current) && rt.is_true(rt.less(rt.new_int(1), var_current)) {
		var_link = rt.call_function('str_replace', [rt.new_string('%_%'), if rt.is_true(rt.identical(rt.new_int(2), var_current)) { rt.new_string('') } else { rt.new_string((var_args).str()).array_get(rt.new_string('format')) }, rt.new_string((var_args).str()).array_get(rt.new_string('base'))])
		var_link = rt.call_function('str_replace', [rt.new_string('%#%'), rt.sub(var_current, rt.new_int(1)), var_link.clone()])
		if rt.is_true(var_add_args) {
		var_link = rt.call_function('add_query_arg', [var_add_args.clone(), var_link.clone()])
		}
		var_link = rt.concat(var_link, rt.new_string((var_args).str()).array_get(rt.new_string('add_fragment')))
		var_page_links << rt.call_function('sprintf', [rt.new_string('<a class="prev page-numbers" href="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('apply_filters', [rt.new_string('paginate_links'), var_link.clone()])]), rt.new_string((var_args).str()).array_get(rt.new_string('prev_text'))])
	}
	var_n = 1
	for {
		if !(rt.is_true(rt.less_equal(rt.new_int(var_n), var_total))) { break }
		if rt.is_true(rt.identical(rt.new_int(var_n), var_current)) {
			var_page_links << rt.call_function('sprintf', [rt.new_string('<span aria-current="%s" class="page-numbers current">%s</span>'), rt.call_function('esc_attr', [rt.new_string((var_args).str()).array_get(rt.new_string('aria_current'))]), rt.new_string((rt.new_string((var_args).str()).array_get(rt.new_string('before_page_number'))).str() + (rt.call_function('number_format_i18n', [rt.new_int(var_n).clone()])).str() + (rt.new_string((var_args).str()).array_get(rt.new_string('after_page_number'))).str())])
		var_dots = true
		} else {
			if rt.is_true(rt.new_string((var_args).str()).array_get(rt.new_string('show_all'))) || ((rt.is_true(rt.less_equal(rt.new_int(var_n), var_end_size)) || (rt.is_true(var_current) && rt.is_true(rt.greater_equal(rt.new_int(var_n), rt.sub(var_current, var_mid_size))) && rt.is_true(rt.less_equal(rt.new_int(var_n), rt.add(var_current, var_mid_size))))) || rt.is_true(rt.greater(rt.new_int(var_n), rt.sub(var_total, var_end_size)))) {
				var_link = rt.call_function('str_replace', [rt.new_string('%_%'), if 1 == var_n { rt.new_string('') } else { rt.new_string((var_args).str()).array_get(rt.new_string('format')) }, rt.new_string((var_args).str()).array_get(rt.new_string('base'))])
				var_link = rt.call_function('str_replace', [rt.new_string('%#%'), rt.new_int(var_n).clone(), var_link.clone()])
				if rt.is_true(var_add_args) {
				var_link = rt.call_function('add_query_arg', [var_add_args.clone(), var_link.clone()])
				}
				var_link = rt.concat(var_link, rt.new_string((var_args).str()).array_get(rt.new_string('add_fragment')))
				var_page_links << rt.call_function('sprintf', [rt.new_string('<a class="page-numbers" href="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('apply_filters', [rt.new_string('paginate_links'), var_link.clone()])]), rt.new_string((rt.new_string((var_args).str()).array_get(rt.new_string('before_page_number'))).str() + (rt.call_function('number_format_i18n', [rt.new_int(var_n).clone()])).str() + (rt.new_string((var_args).str()).array_get(rt.new_string('after_page_number'))).str())])
			var_dots = true
			} else if var_dots && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string((var_args).str()).array_get(rt.new_string('show_all')))))) {
				var_page_links << '<span class="page-numbers dots">' + (rt.call_function('__', [rt.new_string('&hellip;')])).str() + '</span>'
			var_dots = false
			}
		}
		var_n += 1
	}
	if rt.is_true(rt.new_string((var_args).str()).array_get(rt.new_string('prev_next'))) && rt.is_true(var_current) && rt.is_true(rt.less(var_current, var_total)) {
		var_link = rt.call_function('str_replace', [rt.new_string('%_%'), rt.new_string((var_args).str()).array_get(rt.new_string('format')), rt.new_string((var_args).str()).array_get(rt.new_string('base'))])
		var_link = rt.call_function('str_replace', [rt.new_string('%#%'), rt.add(var_current, rt.new_int(1)), var_link.clone()])
		if rt.is_true(var_add_args) {
		var_link = rt.call_function('add_query_arg', [var_add_args.clone(), var_link.clone()])
		}
		var_link = rt.concat(var_link, rt.new_string((var_args).str()).array_get(rt.new_string('add_fragment')))
		var_page_links << rt.call_function('sprintf', [rt.new_string('<a class="next page-numbers" href="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('apply_filters', [rt.new_string('paginate_links'), var_link.clone()])]), rt.new_string((var_args).str()).array_get(rt.new_string('next_text'))])
	}
	mut switch_val_4 := rt.new_string((var_args).str()).array_get(rt.new_string('type'))
	if rt.is_true(rt.equal(switch_val_4, rt.new_string('array'))) {
		return var_page_links.clone()
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('list'))) {
		var_r = rt.concat(var_r, rt.new_string('<ul class=\'page-numbers\'>\n\t<li>'))
		var_r = rt.concat(var_r, rt.call_function('implode', [rt.new_string('</li>\n\t<li>'), rt.create_array_from_list(var_page_links)]))
		var_r = rt.concat(var_r, rt.new_string('</li>\n</ul>\n'))
	} else {
	var_r = rt.call_function('implode', [rt.new_string('\n'), rt.create_array_from_list(var_page_links)])
	}
	var_r = rt.call_function('apply_filters', [rt.new_string('paginate_links_output'), var_r.clone(), rt.new_string((var_args).str())])
	return var_r.clone()
}

fn wp_admin_css_color(key string, var_name rt.PhpVal, var_url rt.PhpVal, var_colors rt.PhpVal, var_icons rt.PhpVal) {
	mut var_key := key
	mut var__wp_admin_css_colors := rt.new_null()
	if !(!(var__wp_admin_css_colors).is_null()) {
	var__wp_admin_css_colors = []rt.PhpVal{}
	}
	var__wp_admin_css_colors.array_set(key, rt.array_to_object(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'url', val: var_url }, rt.ArrayItem{ key: 'colors', val: var_colors }, rt.ArrayItem{ key: 'icon_colors', val: var_icons }])))
}

fn register_admin_color_schemes() {
	mut var_suffix := ''
	var_suffix = if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { '-rtl' } else { '' }
	var_suffix = var_suffix + if rt.is_true(rt.get_constant('SCRIPT_DEBUG')) { '' } else { '.min' }
	wp_admin_css_color('modern', rt.call_function('_x', [rt.new_string('Default'), rt.new_string('admin color scheme')]), rt.call_function('admin_url', [rt.new_string("css/colors/modern/colors${var_suffix}.css")]), rt.create_array([rt.ArrayItem{ key: none, val: '#1e1e1e' }, rt.ArrayItem{ key: none, val: '#3858e9' }, rt.ArrayItem{ key: none, val: '#7b90ff' }]), rt.create_array([rt.ArrayItem{ key: 'base', val: '#f3f1f1' }, rt.ArrayItem{ key: 'focus', val: '#fff' }, rt.ArrayItem{ key: 'current', val: '#fff' }]))
	wp_admin_css_color('fresh', rt.call_function('_x', [rt.new_string('Fresh'), rt.new_string('admin color scheme')]), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: none, val: '#1d2327' }, rt.ArrayItem{ key: none, val: '#2c3338' }, rt.ArrayItem{ key: none, val: '#2271b1' }, rt.ArrayItem{ key: none, val: '#72aee6' }]), rt.create_array([rt.ArrayItem{ key: 'base', val: '#a7aaad' }, rt.ArrayItem{ key: 'focus', val: '#72aee6' }, rt.ArrayItem{ key: 'current', val: '#fff' }]))
	wp_admin_css_color('light', rt.call_function('_x', [rt.new_string('Light'), rt.new_string('admin color scheme')]), rt.call_function('admin_url', [rt.new_string("css/colors/light/colors${var_suffix}.css")]), rt.create_array([rt.ArrayItem{ key: none, val: '#e5e5e5' }, rt.ArrayItem{ key: none, val: '#999' }, rt.ArrayItem{ key: none, val: '#d64e07' }, rt.ArrayItem{ key: none, val: '#04a4cc' }]), rt.create_array([rt.ArrayItem{ key: 'base', val: '#999' }, rt.ArrayItem{ key: 'focus', val: '#ccc' }, rt.ArrayItem{ key: 'current', val: '#ccc' }]))
	wp_admin_css_color('blue', rt.call_function('_x', [rt.new_string('Blue'), rt.new_string('admin color scheme')]), rt.call_function('admin_url', [rt.new_string("css/colors/blue/colors${var_suffix}.css")]), rt.create_array([rt.ArrayItem{ key: none, val: '#096484' }, rt.ArrayItem{ key: none, val: '#4796b3' }, rt.ArrayItem{ key: none, val: '#52accc' }, rt.ArrayItem{ key: none, val: '#74B6CE' }]), rt.create_array([rt.ArrayItem{ key: 'base', val: '#e5f8ff' }, rt.ArrayItem{ key: 'focus', val: '#fff' }, rt.ArrayItem{ key: 'current', val: '#fff' }]))
	wp_admin_css_color('midnight', rt.call_function('_x', [rt.new_string('Midnight'), rt.new_string('admin color scheme')]), rt.call_function('admin_url', [rt.new_string("css/colors/midnight/colors${var_suffix}.css")]), rt.create_array([rt.ArrayItem{ key: none, val: '#25282b' }, rt.ArrayItem{ key: none, val: '#363b3f' }, rt.ArrayItem{ key: none, val: '#69a8bb' }, rt.ArrayItem{ key: none, val: '#e14d43' }]), rt.create_array([rt.ArrayItem{ key: 'base', val: '#f1f2f3' }, rt.ArrayItem{ key: 'focus', val: '#fff' }, rt.ArrayItem{ key: 'current', val: '#fff' }]))
	wp_admin_css_color('sunrise', rt.call_function('_x', [rt.new_string('Sunrise'), rt.new_string('admin color scheme')]), rt.call_function('admin_url', [rt.new_string("css/colors/sunrise/colors${var_suffix}.css")]), rt.create_array([rt.ArrayItem{ key: none, val: '#b43c38' }, rt.ArrayItem{ key: none, val: '#cf4944' }, rt.ArrayItem{ key: none, val: '#dd823b' }, rt.ArrayItem{ key: none, val: '#ccaf0b' }]), rt.create_array([rt.ArrayItem{ key: 'base', val: '#f3f1f1' }, rt.ArrayItem{ key: 'focus', val: '#fff' }, rt.ArrayItem{ key: 'current', val: '#fff' }]))
	wp_admin_css_color('ectoplasm', rt.call_function('_x', [rt.new_string('Ectoplasm'), rt.new_string('admin color scheme')]), rt.call_function('admin_url', [rt.new_string("css/colors/ectoplasm/colors${var_suffix}.css")]), rt.create_array([rt.ArrayItem{ key: none, val: '#413256' }, rt.ArrayItem{ key: none, val: '#523f6d' }, rt.ArrayItem{ key: none, val: '#a3b745' }, rt.ArrayItem{ key: none, val: '#d46f15' }]), rt.create_array([rt.ArrayItem{ key: 'base', val: '#ece6f6' }, rt.ArrayItem{ key: 'focus', val: '#fff' }, rt.ArrayItem{ key: 'current', val: '#fff' }]))
	wp_admin_css_color('ocean', rt.call_function('_x', [rt.new_string('Ocean'), rt.new_string('admin color scheme')]), rt.call_function('admin_url', [rt.new_string("css/colors/ocean/colors${var_suffix}.css")]), rt.create_array([rt.ArrayItem{ key: none, val: '#627c83' }, rt.ArrayItem{ key: none, val: '#738e96' }, rt.ArrayItem{ key: none, val: '#9ebaa0' }, rt.ArrayItem{ key: none, val: '#aa9d88' }]), rt.create_array([rt.ArrayItem{ key: 'base', val: '#f2fcff' }, rt.ArrayItem{ key: 'focus', val: '#fff' }, rt.ArrayItem{ key: 'current', val: '#fff' }]))
	wp_admin_css_color('coffee', rt.call_function('_x', [rt.new_string('Coffee'), rt.new_string('admin color scheme')]), rt.call_function('admin_url', [rt.new_string("css/colors/coffee/colors${var_suffix}.css")]), rt.create_array([rt.ArrayItem{ key: none, val: '#46403c' }, rt.ArrayItem{ key: none, val: '#59524c' }, rt.ArrayItem{ key: none, val: '#c7a589' }, rt.ArrayItem{ key: none, val: '#9ea476' }]), rt.create_array([rt.ArrayItem{ key: 'base', val: '#f3f2f1' }, rt.ArrayItem{ key: 'focus', val: '#fff' }, rt.ArrayItem{ key: 'current', val: '#fff' }]))
}

fn wp_admin_css_uri(file string) rt.PhpVal {
	mut var_file := file
	mut var__file := rt.new_null()
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_INSTALLING')])) {
	var__file = rt.new_string("./${var_file}.css")
	} else {
	var__file = rt.call_function('admin_url', [rt.new_string("${var_file}.css")])
	}
	var__file = rt.call_function('add_query_arg', [rt.new_string('version'), get_bloginfo('version', ''), var__file.clone()])
	return rt.call_function('apply_filters', [rt.new_string('wp_admin_css_uri'), var__file.clone(), rt.new_string(file)])
}

fn wp_admin_css(file string, force_echo bool) {
	mut var_file := file
	mut var_force_echo := force_echo
	mut var_handle := rt.new_null()
	mut var_stylesheet_link := rt.new_null()
	mut var_rtl_stylesheet_link := rt.new_null()
	var_handle = if rt.is_true(rt.call_function('str_starts_with', [rt.new_string(file), rt.new_string('css/')])) { rt.call_function('substr', [rt.new_string(file), rt.new_int(4)]) } else { rt.new_string(file) }
	if rt.is_true(rt.call_method(rt.call_function('wp_styles', []rt.PhpVal{}), 'query', [var_handle.clone()])) {
		if var_force_echo || rt.is_true(rt.call_function('did_action', [rt.new_string('wp_print_styles')])) {
			rt.call_function('wp_print_styles', [var_handle.clone()])
		} else {
			rt.call_function('wp_enqueue_style', [var_handle.clone()])
		}
		return
	}
	var_stylesheet_link = rt.call_function('sprintf', [rt.new_string('<link rel=\'stylesheet\' href=\'%s\' />\n'), rt.call_function('esc_url', [wp_admin_css_uri(file)])])
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('wp_admin_css'), var_stylesheet_link.clone(), rt.new_string(file)]))
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('is_rtl')])) && rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		var_rtl_stylesheet_link = rt.call_function('sprintf', [rt.new_string('<link rel=\'stylesheet\' href=\'%s\' />\n'), rt.call_function('esc_url', [wp_admin_css_uri("${var_file}-rtl")])])
		rt.echo_val(rt.call_function('apply_filters', [rt.new_string('wp_admin_css'), var_rtl_stylesheet_link.clone(), rt.new_string("${var_file}-rtl")]))
	}
}

fn add_thickbox() {
	rt.call_function('wp_enqueue_script', [rt.new_string('thickbox')])
	rt.call_function('wp_enqueue_style', [rt.new_string('thickbox')])
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		rt.call_function('add_action', [rt.new_string('admin_head'), rt.new_string('_thickbox_path_admin_subfolder')])
	}
}

fn wp_generator() {
	the_generator(rt.call_function('apply_filters', [rt.new_string('wp_generator_type'), rt.new_string('xhtml')]))
}

fn the_generator(var_type rt.PhpVal) {
	print((rt.call_function('apply_filters', [rt.new_string('the_generator'), get_the_generator(var_type.clone()), var_type.clone()])).str() + '\n')
}

fn get_the_generator(type string) rt.PhpVal {
	mut var_type := type
	mut var_current_filter := rt.new_null()
	mut var_gen := rt.new_null()
	if var_type == '' {
		var_current_filter = rt.call_function('current_filter', []rt.PhpVal{})
		if !rt.is_true(var_current_filter) {
			return rt.new_null()
		}
		mut switch_val_5 := var_current_filter
		if rt.is_true(rt.equal(switch_val_5, rt.new_string('rss2_head'))) || rt.is_true(rt.equal(switch_val_5, rt.new_string('commentsrss2_head'))) {
		var_type = 'rss2'
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('rss_head'))) || rt.is_true(rt.equal(switch_val_5, rt.new_string('opml_head'))) {
		var_type = 'comment'
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('rdf_header'))) {
		var_type = 'rdf'
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('atom_head'))) || rt.is_true(rt.equal(switch_val_5, rt.new_string('comments_atom_head'))) || rt.is_true(rt.equal(switch_val_5, rt.new_string('app_head'))) {
		var_type = 'atom'
		}
	}
	mut switch_val_6 := rt.new_string((var_type).str())
	if rt.is_true(rt.equal(switch_val_6, rt.new_string('html'))) {
	var_gen = rt.new_string('<meta name="generator" content="WordPress ' + (rt.call_function('esc_attr', [get_bloginfo('version', '')])).str() + '">')
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('xhtml'))) {
	var_gen = rt.new_string('<meta name="generator" content="WordPress ' + (rt.call_function('esc_attr', [get_bloginfo('version', '')])).str() + '" />')
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('atom'))) {
	var_gen = rt.new_string('<generator uri="https://wordpress.org/" version="' + (rt.call_function('esc_attr', [rt.call_function('get_bloginfo_rss', [rt.new_string('version')])])).str() + '">WordPress</generator>')
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('rss2'))) {
	var_gen = rt.new_string('<generator>' + (rt.call_function('sanitize_url', [rt.new_string('https://wordpress.org/?v=' + (rt.call_function('get_bloginfo_rss', [rt.new_string('version')])).str())])).str() + '</generator>')
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('rdf'))) {
	var_gen = rt.new_string('<admin:generatorAgent rdf:resource="' + (rt.call_function('sanitize_url', [rt.new_string('https://wordpress.org/?v=' + (rt.call_function('get_bloginfo_rss', [rt.new_string('version')])).str())])).str() + '" />')
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('comment'))) {
	var_gen = rt.new_string('<!-- generator="WordPress/' + (rt.call_function('esc_attr', [get_bloginfo('version', '')])).str() + '" -->')
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('export'))) {
	var_gen = rt.new_string('<!-- generator="WordPress/' + (rt.call_function('esc_attr', [rt.call_function('get_bloginfo_rss', [rt.new_string('version')])])).str() + '" created="' + (rt.call_function('gmdate', [rt.new_string('Y-m-d H:i')])).str() + '" -->')
	}
	return rt.call_function('apply_filters', [rt.new_string("get_the_generator_${var_type}"), var_gen.clone(), rt.new_string((var_type).str())])
}

fn checked(var_checked rt.PhpVal, current bool, display bool) rt.PhpVal {
	mut var_current := current
	mut var_display := display
	return rt.new_string(__checked_selected_helper(var_checked.clone(), current, display, 'checked'))
}

fn selected(var_selected rt.PhpVal, current bool, display bool) rt.PhpVal {
	mut var_current := current
	mut var_display := display
	return rt.new_string(__checked_selected_helper(var_selected.clone(), current, display, 'selected'))
}

fn disabled(var_disabled rt.PhpVal, current bool, display bool) rt.PhpVal {
	mut var_current := current
	mut var_display := display
	return rt.new_string(__checked_selected_helper(var_disabled.clone(), current, display, 'disabled'))
}

fn wp_readonly(var_readonly_value rt.PhpVal, current bool, display bool) rt.PhpVal {
	mut var_current := current
	mut var_display := display
	return rt.new_string(__checked_selected_helper(var_readonly_value.clone(), current, display, 'readonly'))
}

fn __checked_selected_helper(var_helper rt.PhpVal, var_current rt.PhpVal, var_display rt.PhpVal, type string) string {
	mut var_type := type
	mut var_result := ''
	if rt.is_true(rt.identical((var_helper).str(), (var_current).str())) {
	var_result = " ${var_type}='${var_type}'"
	} else {
	var_result = ''
	}
	if rt.is_true(var_display) {
		print(var_result)
	}
	return var_result
}

fn wp_required_field_indicator() rt.PhpVal {
	mut var_glyph := rt.new_null()
	mut var_indicator := rt.new_null()
	var_glyph = rt.call_function('__', [rt.new_string('*')])
	var_indicator = rt.new_string('<span class="required">' + (rt.call_function('esc_html', [var_glyph.clone()])).str() + '</span>')
	return rt.call_function('apply_filters', [rt.new_string('wp_required_field_indicator'), var_indicator.clone()])
}

fn wp_required_field_message() rt.PhpVal {
	mut var_message := rt.new_null()
	var_message = rt.call_function('sprintf', [rt.new_string('<span class="required-field-message">%s</span>'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Required fields are marked %s')]), wp_required_field_indicator()])])
	return rt.call_function('apply_filters', [rt.new_string('wp_required_field_message'), var_message.clone()])
}

fn wp_heartbeat_settings(var_settings rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		var_settings.array_set('ajaxurl', rt.call_function('admin_url', [rt.new_string('admin-ajax.php'), rt.new_string('relative')]))
	}
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		var_settings.array_set('nonce', rt.call_function('wp_create_nonce', [rt.new_string('heartbeat-nonce')]))
	}
	return var_settings.clone()
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

struct Class__WP_Editors {
	rt.PhpObjectBase
}

fn create_datetimezone(_args ...rt.PhpVal) &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create__wp_editors(_args ...rt.PhpVal) &Class__WP_Editors {
	mut obj := &Class__WP_Editors{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class__WP_Editors) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class__WP_Editors) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class__WP_Editors) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80100))) {
		rt.include_file(@DIR + '/php-compat/readonly.php', '4')
	}
}
