import rt

struct Class_WC_Admin {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin) construct()  {
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'includes' }])])
	rt.call_function('add_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'init_page_controller' }]), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'conditional_includes' }])])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'buffer' }]), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'preview_emails' }])])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'prevent_admin_access' }])])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_redirects' }])])
	rt.call_function('add_action', [rt.new_string('admin_footer'), rt.new_string('wc_print_js'), rt.new_int(25)])
	rt.call_function('add_filter', [rt.new_string('admin_footer_text'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_footer_text' }]), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('update_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_footer_version' }]), rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('action_scheduler_post_type_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'disable_webhook_post_export' }])])
	rt.call_function('add_filter', [rt.new_string('admin_body_class'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'include_admin_body_class' }]), rt.new_int(9999)])
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('page')) && rt.is_true(rt.identical(rt.new_string('wc-addons'), rt.get_superglobal('_GET').array_get('page'))))) {
		rt.call_function('add_filter', [rt.new_string('admin_body_class'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Admin_Addons' }, rt.ArrayItem{ key: none, val: 'filter_admin_body_classes' }])])
	}
}

fn (mut this Class_WC_Admin) buffer()  {
	rt.call_function('ob_start', []rt.PhpVal{})
}

fn (mut this Class_WC_Admin) includes()  {
	rt.include_file(@DIR + '/wc-admin-functions.php', '2')
	rt.include_file(@DIR + '/wc-meta-box-functions.php', '2')
	rt.include_file(@DIR + '/class-wc-admin-post-types.php', '2')
	rt.include_file(@DIR + '/class-wc-admin-taxonomies.php', '2')
	rt.include_file(@DIR + '/class-wc-admin-menus.php', '2')
	rt.include_file(@DIR + '/class-wc-admin-customize.php', '2')
	rt.include_file(@DIR + '/class-wc-admin-notices.php', '2')
	rt.include_file(@DIR + '/class-wc-admin-assets.php', '2')
	rt.include_file(@DIR + '/class-wc-admin-api-keys.php', '2')
	rt.include_file(@DIR + '/class-wc-admin-webhooks.php', '2')
	rt.include_file(@DIR + '/class-wc-admin-pointers.php', '2')
	rt.include_file(@DIR + '/class-wc-admin-importers.php', '2')
	rt.include_file(@DIR + '/class-wc-admin-exporters.php', '2')
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_enable_admin_help_tab'), rt.new_bool(true)])) {
		rt.include_file(@DIR + '/class-wc-admin-help.php', '2')
	}
	rt.include_file(@DIR + '/helper/class-wc-helper.php', '2')
	rt.include_file(@DIR + '/marketplace-suggestions/class-wc-marketplace-suggestions.php', '2')
	rt.include_file(@DIR + '/marketplace-suggestions/class-wc-marketplace-updater.php', '2')
}

fn (mut this Class_WC_Admin) init_page_controller()  {
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.get_instance() }()
}

fn (mut this Class_WC_Admin) conditional_includes()  {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_screen)))) {
		return rt.new_null()
	}
	mut switch_val_1 := rt.get_property(var_screen, 'id')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('dashboard'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('dashboard-network'))) {
		rt.include_file(@DIR + '/class-wc-admin-dashboard-setup.php', '1')
		rt.include_file(@DIR + '/class-wc-admin-dashboard.php', '1')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('options-permalink'))) {
		rt.include_file(@DIR + '/class-wc-admin-permalink-settings.php', '1')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('plugins'))) {
		rt.include_file(@DIR + '/plugin-updates/class-wc-plugins-screen-updates.php', '1')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('update-core'))) {
		rt.include_file(@DIR + '/plugin-updates/class-wc-updates-screen-updates.php', '1')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('users'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('user'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('profile'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('user-edit'))) {
		rt.include_file(@DIR + '/class-wc-admin-profile.php', '1')
	}
}

fn (mut this Class_WC_Admin) admin_redirects()  {
	if rt.is_true(rt.call_function('wc_is_running_from_async_action_scheduler', []rt.PhpVal{})) {
		return rt.new_null()
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('wc-install-plugin-redirect'))) {
		mut var_plugin_slug := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('wc-install-plugin-redirect')])])
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])) && rt.is_true(rt.call_function('in_array', [var_plugin_slug.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce-gateway-stripe' }]), rt.new_bool(true)])))) {
			mut var_nonce := rt.call_function('wp_create_nonce', ['install-plugin_' + (var_plugin_slug).str()])
			mut var_url := rt.call_function('self_admin_url', ['update.php?action=install-plugin&plugin=' + (var_plugin_slug).str() + '&_wpnonce=' + (var_nonce).str()])
		} else {
			var_url = rt.call_function('admin_url', ['plugin-install.php?tab=search&type=term&s=' + (var_plugin_slug).str()])
		}
		rt.call_function('wp_safe_redirect', [var_url.dup()])
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_WC_Admin) prevent_admin_access()  {
	mut var_prevent_access := rt.new_bool(rt.new_bool(false))
	mut var_exempted_paths := ['admin-post.php', 'admin-ajax.php']
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_disable_admin_bar'), rt.new_bool(true)])) && rt.get_superglobal('_SERVER').array_isset(rt.new_string('SCRIPT_FILENAME')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_function('basename', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('SCRIPT_FILENAME')])])]), var_exempted_paths.dup(), rt.new_bool(true)]))))))) {
		mut var_has_cap := rt.new_bool(rt.new_bool(false))
		mut var_access_caps := ['edit_posts', 'manage_woocommerce', 'view_admin_dashboard']
		for var_access_cap in var_access_caps {
			if rt.is_true(rt.call_function('current_user_can', [rt.new_string(access_cap)])) {
				var_has_cap = rt.new_bool(rt.new_bool(true))
				break
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_has_cap)))) {
			var_prevent_access = rt.new_bool(rt.new_bool(true))
		}
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_prevent_admin_access'), var_prevent_access.dup()])) {
		rt.call_function('wp_safe_redirect', [rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])
		// unsupported expression: Expr_Exit
	}
}

fn (mut this Class_WC_Admin) preview_emails()  {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('preview_woocommerce_mail')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('_wpnonce')) && rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('_wpnonce')])]), rt.new_string('preview-mail')]))))))) {
			// unsupported expression: Expr_Exit
		}
		mut var_email_preview := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.class()])
		if rt.get_superglobal('_GET').array_isset(rt.new_string('type')) {
			mut var_type_param := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('type')])])
			rt.call_method(var_email_preview, 'set_email_type', [var_type_param.dup()])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'InvalidArgumentException') {
				mut var_e := var_e_1.dup()
				rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('Invalid email type.'), rt.new_string('woocommerce')]), rt.new_int(400)])
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')])) && rt.is_true(rt.get_constant('WP_DEBUG')))) {
			mut var_message := rt.call_method(var_email_preview, 'render', []rt.PhpVal{})
			var_message = rt.call_method(var_email_preview, 'ensure_links_open_in_new_tab', [var_message.dup()])
		} else {
			rt.call_function('ob_start', []rt.PhpVal{})
			var_message = rt.call_method(var_email_preview, 'render', []rt.PhpVal{})
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			var_message = rt.call_method(var_email_preview, 'ensure_links_open_in_new_tab', [var_message.dup()])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			unsafe { goto end_label_2 }

catch_label_2:
			mut var_e_2 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_2, 'Throwable') {
				mut var_e := var_e_2.dup()
				rt.call_function('ob_end_clean', []rt.PhpVal{})
				rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('There was an error rendering the email preview. This doesn\'t affect actual email delivery. Please contact the extension author for assistance.'), rt.new_string('woocommerce')]), rt.new_int(404)])
				unsafe { goto end_label_2 }
			}
			else {
				rt.throw_exception(var_e_2)
				unsafe { goto end_label_2 }
			}

end_label_2:
			rt.call_function('ob_end_clean', []rt.PhpVal{})
		}
		rt.echo_val(var_message)
		// unsupported expression: Expr_Exit
	}
}

fn (mut this Class_WC_Admin) admin_footer_text(var_footer_text rt.PhpVal) string {
	mut var_footer_text_mutated := var_footer_text
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_screen_ids')]))))))) {
		return (var_footer_text_mutated).str()
	}
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_wc_pages := rt.call_function('array_merge', [rt.call_function('wc_get_screen_ids', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_page_wc-admin' }])])
	var_wc_pages = rt.call_function('array_diff', [var_wc_pages.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'profile' }, rt.ArrayItem{ key: none, val: 'user-edit' }])])
	if rt.is_true(rt.new_bool(!(rt.get_property(var_current_screen, 'id')).is_null() && rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_display_admin_footer_text'), rt.call_function('in_array', [rt.get_property(var_current_screen, 'id'), var_wc_pages.dup(), rt.new_bool(true)])])))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_admin_footer_text_rated')]))))) {
			var_footer_text_mutated = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you like %1$s please leave us a %2$s rating. A huge thanks in advance!'), rt.new_string('woocommerce')]), rt.call_function('sprintf', [rt.new_string('<strong>%s</strong>'), rt.call_function('esc_html__', [rt.new_string('WooCommerce'), rt.new_string('woocommerce')])]), '<a href="https://wordpress.org/support/plugin/woocommerce/reviews?rate=5#new-post" target="_blank" class="wc-rating-link" aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('five star'), rt.new_string('woocommerce')])).str() + '" data-rated="' + (rt.call_function('esc_attr__', [rt.new_string('Thanks :)'), rt.new_string('woocommerce')])).str() + '">&#9733;&#9733;&#9733;&#9733;&#9733;</a>'])
			mut var_script := rt.new_string('\n\t\t            (function() {\n\t\t                \'use strict\';\n\t\t                var ratingLink = document.querySelector(\'a.wc-rating-link\');\n\t\t                if (ratingLink) {\n\t\t                    ratingLink.addEventListener(\'click\', function(e) {\n\t\t                        var link = e.currentTarget;\n\t\t                        var formData = new FormData();\n\t\t                        formData.append(\'action\', \'woocommerce_rated\');\n\t\t                        \n\t\t                        fetch(\'' + (rt.call_function('esc_js', [rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'ajax_url', []rt.PhpVal{})])).str() + '\', {\n\t\t                            method: \'POST\',\n\t\t                            body: formData,\n\t\t                            credentials: \'same-origin\'\n\t\t                        });\n\t\t                        \n\t\t                        var parent = link.parentElement;\n\t\t                        if (parent) {\n\t\t                            parent.textContent = link.getAttribute(\'data-rated\');\n\t\t                        }\n\t\t                    });\n\t\t                }\n\t\t            })();\n\t\t            ')
			mut var_handle := rt.new_string(rt.new_string('wc-admin-footer-rating'))
			rt.call_function('wp_register_script', [var_handle.dup(), rt.new_string(''), rt.new_array(), rt.get_constant('WC_VERSION'), rt.new_bool(true)])
			rt.call_function('wp_enqueue_script', [var_handle.dup()])
			rt.call_function('wp_add_inline_script', [var_handle.dup(), var_script.dup()])
		} else {
			var_footer_text_mutated = rt.call_function('__', [rt.new_string('Thank you for selling with WooCommerce.'), rt.new_string('woocommerce')])
		}
	}
	return '<span id="footer-thankyou">' + (var_footer_text_mutated).str() + '</span>'
}

fn (mut this Class_WC_Admin) update_footer_version(var_version rt.PhpVal) rt.PhpVal {
	mut var_version_mutated := var_version
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_screen_ids')]))))) {
		return var_version_mutated.dup()
	}
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_wc_pages := rt.call_function('array_merge', [rt.call_function('wc_get_screen_ids', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val:  }])])
	var_wc_pages = rt.call_function('array_diff', [.dup(), ])
	if rt.is_true(rt.new_bool(!().is_null() && rt.is_true())) {
		
	}
	return .dup()
}

fn (mut this Class_WC_Admin) setup_wizard_check_jetpack()  {
}

fn (mut this Class_WC_Admin) disable_webhook_post_export(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Admin) include_admin_body_class(var_classes rt.PhpVal) rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

fn create_wc_admin() &Class_WC_Admin {
	mut obj := &Class_WC_Admin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller() &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'buffer' {
			this.buffer()
			return rt.new_null()
		}
		'includes' {
			this.includes()
			return rt.new_null()
		}
		'init_page_controller' {
			this.init_page_controller()
			return rt.new_null()
		}
		'conditional_includes' {
			this.conditional_includes()
			return rt.new_null()
		}
		'admin_redirects' {
			this.admin_redirects()
			return rt.new_null()
		}
		'prevent_admin_access' {
			this.prevent_admin_access()
			return rt.new_null()
		}
		'preview_emails' {
			this.preview_emails()
			return rt.new_null()
		}
		'admin_footer_text' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.admin_footer_text(dispatch_arg_0))
		}
		'update_footer_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_footer_version(dispatch_arg_0)
		}
		'setup_wizard_check_jetpack' {
			this.setup_wizard_check_jetpack()
			return rt.new_null()
		}
		'disable_webhook_post_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.disable_webhook_post_export(dispatch_arg_0)
		}
		'include_admin_body_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.include_admin_body_class(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
