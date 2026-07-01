import rt

struct Class_Akismet {
	rt.PhpObjectBase
}

struct Class_Akismet_Admin {
	rt.PhpObjectBase
}

fn create_akismet() &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet_admin() &Class_Akismet_Admin {
	mut obj := &Class_Akismet_Admin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Akismet_Admin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet_Admin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Admin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_akismet_views_config_php() {
	mut var_notices := rt.new_null()
	mut var_name := rt.new_null()
	mut var_stat_totals := rt.new_null()
	mut var_akismet_user := rt.new_null()
	mut var_kses_allow_link_href := {
		'a': {
			'href': rt.new_bool(true)
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('has_action', [rt.new_string('akismet_header')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('akismet_header')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Akismet{}
			return temp.view(arg_0)
		}(rt.new_string('logo'))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(fn () rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.get_api_key()
	}())
	{
		// unsupported statement: Stmt_InlineHTML
		fn () rt.PhpVal {
			mut temp := Class_Akismet_Admin{}
			return temp.display_status()
		}()
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_notices)) {
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_notices.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_notice := item_1.val
				// unsupported statement: Stmt_InlineHTML
				fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Akismet{}
					return temp.view(arg_0, arg_1)
				}(rt.new_string('notice'), rt.call_function('array_merge', [
					var_notice.dup(),
					rt.create_array([
						rt.ArrayItem{ key: 'parent_view', val: var_name },
					])]))
				// unsupported statement: Stmt_InlineHTML
			}
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_stat_totals.array_isset(rt.new_string('all'))
		&& var_stat_totals.array_isset(rt.new_string('6-months')) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Statistics'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('sprintf', [
				rt.new_string('https://tools.akismet.com/1.0/snapshot.php?blog=%s&token=%s&height=200&locale=%s&is_redecorated=1'),
				rt.call_function('rawurlencode', [
					rt.call_function('get_option', [rt.new_string('home')]),
				]),
				rt.call_function('rawurlencode', [
					fn () rt.PhpVal {
						mut temp := Class_Akismet{}
						return temp.get_access_token()
					}(),
				]),
				rt.call_function('get_user_locale', []rt.PhpVal{}),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			'snapshot-' + (rt.call_function('filemtime', [rt.new_string(@FILE)])).str(),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr__', [rt.new_string('Akismet stats'),
			rt.new_string('akismet')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Past six months'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('number_format', [
			rt.get_property(var_stat_totals.array_get('6-months'), 'spam'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('_n', [rt.new_string('Spam blocked'),
				rt.new_string('Spam blocked'),
				rt.get_property(var_stat_totals.array_get('6-months'),
					'spam'),
				rt.new_string('akismet')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('All time'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('number_format', [
			rt.get_property(var_stat_totals.array_get('all'), 'spam'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('_n', [rt.new_string('Spam blocked'),
				rt.new_string('Spam blocked'), rt.get_property(var_stat_totals.array_get('all'),
					'spam'),
				rt.new_string('akismet')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Accuracy'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.new_float(rt.get_property(var_stat_totals.array_get('all'), 'accuracy').to_f64()))
		// unsupported statement: Stmt_InlineHTML
		print(
			(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s missed spam'), rt.new_string('%s missed spam'), rt.get_property(var_stat_totals.array_get('all'), 'missed_spam'), rt.new_string('akismet')]), rt.call_function('number_format', [rt.get_property(var_stat_totals.array_get('all'), 'missed_spam')])])])).str() +
			', ')
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('sprintf', [
				rt.call_function('_n', [
					rt.new_string('%s false positive'),
					rt.new_string('%s false positives'),
					rt.get_property(var_stat_totals.array_get('all'), 'false_positives'),
					rt.new_string('akismet'),
				]),
				rt.call_function('number_format', [
					rt.get_property(var_stat_totals.array_get('all'), 'false_positives'),
				]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Akismet_Admin{}
			return temp.get_page_url(arg_0)
		}(rt.new_string('stats'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('View detailed stats'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('akismet_show_compatible_plugins'),
		rt.new_bool(true),
	]))
	{
		// unsupported statement: Stmt_InlineHTML
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Akismet{}
			return temp.view(arg_0)
		}(rt.new_string('compatible-plugins'))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_akismet_user) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Settings'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [fn () rt.PhpVal {
			mut temp := Class_Akismet_Admin{}
			return temp.get_page_url()
		}()]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal {
			mut temp := Class_Akismet{}
			return temp.predefined_api_key()
		}()))))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('API key'),
				rt.new_string('akismet')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('get_option', [rt.new_string('wordpress_api_key')]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				'regular-text code ' + (rt.get_property(var_akismet_user, 'status')).str(),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Copy API key'),
				rt.new_string('akismet')])
			// unsupported statement: Stmt_InlineHTML
			rt.include_file((rt.call_function('plugin_dir_path', [rt.new_string(@FILE)])).str() +
				'../_inc/img/copy.svg', '1')
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.get_superglobal('_GET').array_isset(rt.new_string('ssl_status')) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('SSL status'),
				rt.new_string('akismet')])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_http_supports', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
			])))))
			{
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Disabled.'),
					rt.new_string('akismet')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [
					rt.new_string('Your Web server cannot make SSL requests; contact your Web host and ask them to add support for SSL requests.'),
					rt.new_string('akismet'),
				])
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				mut var_ssl_disabled := rt.call_function('get_option', [
					rt.new_string('akismet_ssl_disabled'),
				])
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(var_ssl_disabled) {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [
						rt.new_string('Temporarily disabled.'),
						rt.new_string('akismet'),
					])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [
						rt.new_string('Akismet encountered a problem with a previous SSL request and disabled it temporarily. It will begin using SSL for requests again shortly.'),
						rt.new_string('akismet'),
					])
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [rt.new_string('Enabled.'),
						rt.new_string('akismet')])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
