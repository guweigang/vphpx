import rt

struct Class_WC_Settings_Emails {
	rt.PhpObjectBase
pub mut:
	icon rt.PhpVal = rt.new_string('atSymbol')
}

fn (mut this Class_WC_Settings_Emails) construct() {
	this.dispatch_set_prop('id', rt.new_string('email'))
	this.dispatch_set_prop('label', rt.call_function('__', [rt.new_string('Emails'),
		rt.new_string('woocommerce')]))
	rt.call_function('add_action', [
		rt.new_string('woocommerce_admin_field_email_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Emails', [
				'WC_Settings_Page',
			], &this) },
			rt.ArrayItem{ key: none, val: 'email_notification_setting' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_admin_field_email_notification_block_emails'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Emails', [
				'WC_Settings_Page',
			], &this) },
			rt.ArrayItem{ key: none, val: 'email_notification_setting_block_emails' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_admin_field_email_preview'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Emails', [
				'WC_Settings_Page',
			], &this) },
			rt.ArrayItem{ key: none, val: 'email_preview' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_admin_field_email_image_url'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Emails', [
				'WC_Settings_Page',
			], &this) },
			rt.ArrayItem{ key: none, val: 'email_image_url' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_admin_field_email_font_family'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Emails', [
				'WC_Settings_Page',
			], &this) },
			rt.ArrayItem{ key: none, val: 'email_font_family' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_admin_field_email_color_palette'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Emails', [
				'WC_Settings_Page',
			], &this) },
			rt.ArrayItem{ key: none, val: 'email_color_palette' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_admin_field_previewing_new_templates'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Emails', [
				'WC_Settings_Page',
			], &this) },
			rt.ArrayItem{ key: none, val: 'previewing_new_templates' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_admin_field_email_improvements_button'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Emails', [
				'WC_Settings_Page',
			], &this) },
			rt.ArrayItem{ key: none, val: 'email_improvements_button' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_settings_after'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Emails', [
				'WC_Settings_Page',
			], &this) },
			rt.ArrayItem{ key: none, val: 'email_preview_single' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_settings_saved'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Emails', [
				'WC_Settings_Page',
			], &this) },
			rt.ArrayItem{ key: none, val: 'enable_email_improvements_when_trying_new_templates' },
		]),
		rt.new_int(999)])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_email_header_image'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Emails', [
				'WC_Settings_Page',
			], &this) },
			rt.ArrayItem{ key: none, val: 'sanitize_email_header_image' },
		]),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_filter', [rt.new_string('woocommerce_tracks_event_properties'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Emails', [
				'WC_Settings_Page',
			], &this) },
			rt.ArrayItem{ key: none, val: 'append_feature_email_improvements_to_tracks' },
		])])
	rt.call_function('add_action', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.feature_enabled_changed_action(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Emails', [
				'WC_Settings_Page',
			], &this) },
			rt.ArrayItem{ key: none, val: 'track_email_improvements_feature_change' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	this.Class_WC_Settings_Page.construct()
}

fn (mut this Class_WC_Settings_Emails) get_own_sections() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '', val: rt.call_function('__', [
			rt.new_string('Email options'),
			rt.new_string('woocommerce'),
		]) },
	])
}

fn (mut this Class_WC_Settings_Emails) get_settings_for_default_section() rt.PhpVal {
	mut var_desc_help_text := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('To ensure your store&rsquo;s notifications arrive in your and your customers&rsquo; inboxes, we recommend connecting your email address to your domain and setting up a dedicated SMTP server. If something doesn&rsquo;t seem to be sending correctly, install the <a href="%1$s">WP Mail Logging Plugin</a> or check the <a href="%2$s">Email FAQ page</a>.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('https://wordpress.org/plugins/wp-mail-logging/'),
		rt.new_string('https://woocommerce.com/document/email-faq'),
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('block_email_editor'))
	mut var_block_email_editor_enabled := iife_result_0
	mut var_email_improvements_enabled := this.get_email_improvements_enabled()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Email_EmailColors{}
	mut iife_result_1 := iife_temp_1.get_default_colors(var_email_improvements_enabled.clone())
	mut var_default_colors := iife_result_1
	if rt.is_true(var_block_email_editor_enabled) {
		mut var_email_notifications_field := rt.new_string('email_notification_block_emails')
		mut var_email_notifications_desc := rt.new_null()
	} else {
		var_email_notifications_field = rt.new_string('email_notification')
		var_email_notifications_desc = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Email notifications sent from WooCommerce are listed below. Click on an email to configure it.<br>%s'),
				rt.new_string('woocommerce'),
			]),
			var_desc_help_text.clone(),
		])
	}
	mut var_settings := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Email notifications'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: var_email_notifications_desc },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'id', val: 'email_notification_settings' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: var_email_notifications_field },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'email_notification_settings' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'email_recipient_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Email sender options'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string("Set the name and email address you'd like your outgoing emails to use."),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'email_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('"From" name'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: '' },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_email_from_name' },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'css', val: 'min-width:400px;' },
			rt.ArrayItem{ key: 'default', val: rt.call_function('esc_attr', [
				rt.call_function('get_bloginfo', [rt.new_string('name'),
					rt.new_string('display')]),
			]) },
			rt.ArrayItem{ key: 'autoload', val: false },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'skip_initial_save', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('"From" address'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: '' },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_email_from_address' },
			rt.ArrayItem{ key: 'type', val: 'email' },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: 'multiple' },
			]) },
			rt.ArrayItem{ key: 'css', val: 'min-width:400px;' },
			rt.ArrayItem{ key: 'default', val: rt.call_function('get_option', [
				rt.new_string('admin_email'),
			]) },
			rt.ArrayItem{ key: 'autoload', val: false },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
	])
	if rt.is_true(var_block_email_editor_enabled) {
		var_settings = rt.call_function('array_merge', [var_settings.clone(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Add "Reply-to" email'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
						rt.new_string('Add a different email address to receive replies.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'id', val: 'woocommerce_email_reply_to_enabled' },
					rt.ArrayItem{ key: 'type', val: 'checkbox' },
					rt.ArrayItem{ key: 'default', val: 'no' },
					rt.ArrayItem{ key: 'autoload', val: false },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('"Reply-to" name'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'desc', val: '' },
					rt.ArrayItem{ key: 'id', val: 'woocommerce_email_reply_to_name' },
					rt.ArrayItem{ key: 'type', val: 'text' },
					rt.ArrayItem{ key: 'css', val: 'min-width:400px;' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'autoload', val: false },
					rt.ArrayItem{ key: 'desc_tip', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('"Reply-to" address'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'desc', val: '' },
					rt.ArrayItem{ key: 'id', val: 'woocommerce_email_reply_to_address' },
					rt.ArrayItem{ key: 'type', val: 'email' },
					rt.ArrayItem{ key: 'css', val: 'min-width:400px;' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'autoload', val: false },
					rt.ArrayItem{ key: 'desc_tip', val: true },
				]) },
			])])
	}
	var_settings = rt.call_function('array_merge', [var_settings.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'sectionend' },
				rt.ArrayItem{ key: 'id', val: 'email_options' },
			]) },
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_block_email_editor_enabled)))) {
		var_settings = rt.call_function('array_merge', [var_settings.clone(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Email template'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'title' },
					rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
						rt.new_string('Customize your WooCommerce email template and preview it below.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'id', val: 'email_template_options' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Try new templates'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'previewing_new_templates' },
					rt.ArrayItem{ key: 'id', val: 'previewing_new_templates' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Logo'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
						rt.new_string('Add your logo to each of your WooCommerce emails. If no logo is uploaded, your site title will be used instead.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'id', val: 'woocommerce_email_header_image' },
					rt.ArrayItem{ key: 'type', val: 'email_image_url' },
					rt.ArrayItem{ key: 'css', val: 'min-width:400px;' },
					rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
						rt.new_string('N/A'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'autoload', val: false },
					rt.ArrayItem{ key: 'desc_tip', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Logo width (px)'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'id', val: 'woocommerce_email_header_image_width' },
					rt.ArrayItem{ key: 'desc_tip', val: '' },
					rt.ArrayItem{ key: 'default', val: '120' },
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{
						key: 'row_class'
						val: if rt.is_true(var_email_improvements_enabled) { '' } else { 'disabled' }
					},
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Header alignment'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'id', val: 'woocommerce_email_header_alignment' },
					rt.ArrayItem{ key: 'desc_tip', val: '' },
					rt.ArrayItem{ key: 'default', val: 'left' },
					rt.ArrayItem{ key: 'type', val: 'select' },
					rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
					rt.ArrayItem{ key: 'options', val: rt.create_array([
						rt.ArrayItem{ key: 'left', val: rt.call_function('__', [
							rt.new_string('Left'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'center', val: rt.call_function('__', [
							rt.new_string('Center'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'right', val: rt.call_function('__', [
							rt.new_string('Right'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{
						key: 'row_class'
						val: if rt.is_true(var_email_improvements_enabled) { '' } else { 'disabled' }
					},
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Font family'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'id', val: 'woocommerce_email_font_family' },
					rt.ArrayItem{ key: 'default', val: 'Helvetica' },
					rt.ArrayItem{ key: 'type', val: 'email_font_family' },
					rt.ArrayItem{
						key: 'row_class'
						val: if rt.is_true(var_email_improvements_enabled) { '' } else { 'disabled' }
					},
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Footer text'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{
						key: 'desc'
						val:
							(rt.call_function('__', [rt.new_string('This text will appear in the footer of all of your WooCommerce emails.'), rt.new_string('woocommerce')])).str() +
							' ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Available placeholders: %s'), rt.new_string('woocommerce')]), rt.new_string('{site_title} {site_url} {store_address} {store_email}')])).str()
					},
					rt.ArrayItem{ key: 'id', val: 'woocommerce_email_footer_text' },
					rt.ArrayItem{ key: 'css', val: 'width:400px; height: 75px;' },
					rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
						rt.new_string('N/A'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'textarea' },
					rt.ArrayItem{ key: 'default', val: '{site_title}<br />{store_address}' },
					rt.ArrayItem{ key: 'autoload', val: false },
					rt.ArrayItem{ key: 'desc_tip', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'sectionend' },
					rt.ArrayItem{ key: 'id', val: 'email_template_options' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Color palette'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'email_color_palette' },
					rt.ArrayItem{ key: 'id', val: 'email_color_palette' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Accent'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Customize the color of your buttons and links. Default %s.'),
							rt.new_string('woocommerce'),
						]),
						rt.new_string('<code>' +
							(var_default_colors.array_get(rt.new_string('base'))).str() + '</code>'),
					]) },
					rt.ArrayItem{ key: 'id', val: 'woocommerce_email_base_color' },
					rt.ArrayItem{ key: 'type', val: 'color' },
					rt.ArrayItem{ key: 'css', val: 'width:6em;' },
					rt.ArrayItem{
						key: 'default'
						val: var_default_colors.array_get(rt.new_string('base'))
					},
					rt.ArrayItem{ key: 'autoload', val: false },
					rt.ArrayItem{ key: 'desc_tip', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Email background'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Select a color for the background of your emails. Default %s.'),
							rt.new_string('woocommerce'),
						]),
						rt.new_string('<code>' +
							(var_default_colors.array_get(rt.new_string('bg'))).str() + '</code>'),
					]) },
					rt.ArrayItem{ key: 'id', val: 'woocommerce_email_background_color' },
					rt.ArrayItem{ key: 'type', val: 'color' },
					rt.ArrayItem{ key: 'css', val: 'width:6em;' },
					rt.ArrayItem{
						key: 'default'
						val: var_default_colors.array_get(rt.new_string('bg'))
					},
					rt.ArrayItem{ key: 'autoload', val: false },
					rt.ArrayItem{ key: 'desc_tip', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Content background'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Choose a background color for the content area of your emails. Default %s.'),
							rt.new_string('woocommerce'),
						]),
						rt.new_string('<code>' +
							(var_default_colors.array_get(rt.new_string('body_bg'))).str() + '</code>'),
					]) },
					rt.ArrayItem{ key: 'id', val: 'woocommerce_email_body_background_color' },
					rt.ArrayItem{ key: 'type', val: 'color' },
					rt.ArrayItem{ key: 'css', val: 'width:6em;' },
					rt.ArrayItem{
						key: 'default'
						val: var_default_colors.array_get(rt.new_string('body_bg'))
					},
					rt.ArrayItem{ key: 'autoload', val: false },
					rt.ArrayItem{ key: 'desc_tip', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Heading & text'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Set the color of your headings and text. Default %s.'),
							rt.new_string('woocommerce'),
						]),
						rt.new_string('<code>' +
							(var_default_colors.array_get(rt.new_string('body_text'))).str() + '</code>'),
					]) },
					rt.ArrayItem{ key: 'id', val: 'woocommerce_email_text_color' },
					rt.ArrayItem{ key: 'type', val: 'color' },
					rt.ArrayItem{ key: 'css', val: 'width:6em;' },
					rt.ArrayItem{
						key: 'default'
						val: var_default_colors.array_get(rt.new_string('body_text'))
					},
					rt.ArrayItem{ key: 'autoload', val: false },
					rt.ArrayItem{ key: 'desc_tip', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Secondary text'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Choose a color for your secondary text, such as your footer content. Default %s.'),
							rt.new_string('woocommerce'),
						]),
						rt.new_string('<code>' +
							(var_default_colors.array_get(rt.new_string('footer_text'))).str() + '</code>'),
					]) },
					rt.ArrayItem{ key: 'id', val: 'woocommerce_email_footer_text_color' },
					rt.ArrayItem{ key: 'type', val: 'color' },
					rt.ArrayItem{ key: 'css', val: 'width:6em;' },
					rt.ArrayItem{
						key: 'default'
						val: var_default_colors.array_get(rt.new_string('footer_text'))
					},
					rt.ArrayItem{ key: 'autoload', val: false },
					rt.ArrayItem{ key: 'desc_tip', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Auto-sync with theme'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
						rt.new_string('Automatically update email styles when theme styles change'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'id', val: 'woocommerce_email_auto_sync_with_theme' },
					rt.ArrayItem{ key: 'type', val: 'hidden' },
					rt.ArrayItem{ key: 'default', val: 'no' },
					rt.ArrayItem{ key: 'autoload', val: false },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'sectionend' },
					rt.ArrayItem{ key: 'id', val: 'email_color_palette' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Email improvements button'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'email_improvements_button' },
					rt.ArrayItem{ key: 'id', val: 'email_improvements_button' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'email_preview' },
				]) },
			])])
	}
	var_settings = rt.call_function('array_filter', [var_settings.clone()])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_settings'),
		var_settings.clone(),
	])
}

fn (mut this Class_WC_Settings_Emails) get_custom_fonts() rt.PhpVal {
	mut var_custom_fonts := rt.new_array()
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_Font_Face_Resolver')])) {
		mut iife_temp_2 := Class_WP_Font_Face_Resolver{}
		mut iife_result_2 := iife_temp_2.get_fonts_from_theme_json()
		mut var_theme_fonts := iife_result_2
		if var_theme_fonts.clone().array_count() > 0 {
			mut iter_1 := var_theme_fonts.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_font := item_1.val
				if !(!rt.is_true(var_font.array_get(rt.new_int(0)).array_get(rt.new_string('font-family')))) {
					var_custom_fonts.array_set(var_font.array_get(rt.new_int(0)).array_get(rt.new_string('font-family')),
						var_font.array_get(rt.new_int(0)).array_get(rt.new_string('font-family')))
				}
			}
		}
	}
	rt.call_function('ksort', [var_custom_fonts.clone()])
	return var_custom_fonts.clone()
}

fn (mut this Class_WC_Settings_Emails) output() {
	mut var_current_section := rt.new_null()
	mut var_mailer := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{})
	mut var_email_templates := rt.call_method(var_mailer, 'get_emails', []rt.PhpVal{})
	if rt.is_true(var_current_section) {
		mut iter_2 := var_email_templates.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_email := item_2.val
			mut var_email_key := item_2.key
			if rt.is_true(rt.identical(rt.new_string(var_email_key.clone().to_string().to_lower()),
				var_current_section))
			{
				this.run_email_admin_options(var_email.clone())
				break
			}
		}
	}
	this.Class_WC_Settings_Page.output()
}

fn (mut this Class_WC_Settings_Emails) run_email_admin_options(var_email rt.PhpVal) {
	rt.call_method(var_email, 'admin_options', []rt.PhpVal{})
}

fn (mut this Class_WC_Settings_Emails) save() {
	mut var_current_section := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_section)))) {
		this.save_settings_for_current_section()
		this.do_update_options_action()
	} else {
		mut iife_temp_3 := Class_WC_Emails{}
		mut iife_result_3 := iife_temp_3.instance()
		mut var_wc_emails := iife_result_3
		if rt.is_true(rt.call_function('in_array', [var_current_section.clone(),
			rt.call_function('array_map', [rt.new_string('sanitize_title'),
				rt.func_array_keys(rt.call_method(var_wc_emails, 'get_emails', []rt.PhpVal{}))]),
			rt.new_bool(true)]))
		{
			mut iter_3 := rt.call_method(var_wc_emails, 'get_emails', []rt.PhpVal{}).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_email := item_3.val
				mut var_email_id := item_3.key
				if rt.is_true(rt.identical(rt.call_function('sanitize_title', [
					var_email_id.clone(),
				]), var_current_section))
				{
					this.do_update_options_action(rt.get_property(var_email, 'id'))
				}
			}
		} else {
			this.save_settings_for_current_section()
			this.do_update_options_action()
		}
	}
}

fn (mut this Class_WC_Settings_Emails) email_notification_setting() {
	mut var_mailer := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{})
	mut var_email_templates := rt.call_method(var_mailer, 'get_emails', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	mut var_columns := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_setting_columns'),
		rt.create_array([rt.ArrayItem{ key: 'status', val: '' },
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Email'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'email_type', val: rt.call_function('__', [
				rt.new_string('Content type'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'recipient', val: rt.call_function('__', [
				rt.new_string('Recipient(s)'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'actions', val: '' }]),
	])
	mut iter_4 := var_columns.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_column := item_4.val
		mut var_key := item_4.key
		print('<th class="wc-email-settings-table-' +
			(rt.call_function('esc_attr', [var_key.clone()])).str() + '">' +
			(rt.call_function('esc_html', [var_column.clone()])).str() + '</th>')
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_5 := var_email_templates.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_email := item_5.val
		mut var_email_key := item_5.key
		print('<tr>')
		mut iter_6 := var_columns.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_column := item_6.val
			mut var_key := item_6.key
			mut switch_val_1 := var_key
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('name'))) {
				print('<td class="wc-email-settings-table-' +
					(rt.call_function('esc_attr', [var_key.clone()])).str() +
					'">\n\t\t\t\t\t\t\t\t\t\t<a href="' +
					(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=email&section=' + var_email_key.clone().to_string().to_lower())])])).str() +
					'">' +
					(rt.call_function('esc_html', [rt.call_method(var_email, 'get_title', []rt.PhpVal{})])).str() +
					'</a>\n\t\t\t\t\t\t\t\t\t\t' +
					(rt.call_function('wc_help_tip', [rt.call_method(var_email, 'get_description', []rt.PhpVal{})])).str() +
					'\n\t\t\t\t\t\t\t\t\t\t</td>')
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('recipient'))) {
				mut var_to := if rt.is_true(rt.call_method(var_email, 'is_customer_email', []rt.PhpVal{})) { rt.call_function('__', [
						rt.new_string('Customer'),
						rt.new_string('woocommerce'),
					]) } else { rt.call_method(var_email, 'get_recipient', []rt.PhpVal{}) }
				mut var_cc := rt.new_bool(false)
				mut var_bcc := rt.new_bool(false)
				mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
				mut iife_result_4 :=
					iife_temp_4.feature_is_enabled(rt.new_string('email_improvements'))
				if rt.is_true(iife_result_4) {
					mut var_ccs := rt.call_method(var_email, 'get_cc_recipient', []rt.PhpVal{})
					mut var_bccs := rt.call_method(var_email, 'get_bcc_recipient', []rt.PhpVal{})
					var_cc = if rt.is_true(var_ccs) { rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('<b>Cc</b>: %s'),
								rt.new_string('woocommerce')]),
							var_ccs.clone(),
						]) } else { rt.new_bool(false) }
					var_bcc = if rt.is_true(var_bccs) { rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('<b>Bcc</b>: %s'),
								rt.new_string('woocommerce')]),
							var_bccs.clone(),
						]) } else { rt.new_bool(false) }
					if rt.is_true(var_cc) || rt.is_true(var_bcc) {
						var_to = rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('<b>To</b>: %s'),
								rt.new_string('woocommerce')]),
							var_to.clone(),
						])
					}
				}
				mut var_allowed_tags := rt.create_array([
					rt.ArrayItem{ key: 'b', val: rt.new_array() },
				])
				print('<td class="wc-email-settings-table-' +
					(rt.call_function('esc_attr', [var_key.clone()])).str() + '">')
				rt.echo_val(rt.call_function('wp_kses', [var_to.clone(),
					var_allowed_tags.clone()]))
				if rt.is_true(var_cc) {
					print('<br>' +(rt.call_function('wp_kses', [var_cc.clone(), var_allowed_tags.clone()])).str())
				}
				if rt.is_true(var_bcc) {
					print('<br>' +(rt.call_function('wp_kses', [var_bcc.clone(), var_allowed_tags.clone()])).str())
				}
				print('</td>')
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('status'))) {
				print('<td class="wc-email-settings-table-' +
					(rt.call_function('esc_attr', [var_key.clone()])).str() + '">')
				if rt.is_true(rt.call_method(var_email, 'is_manual', []rt.PhpVal{})) {
					print('<span class="status-manual tips" data-tip="' +
						(rt.call_function('esc_attr__', [rt.new_string('Manually sent'), rt.new_string('woocommerce')])).str() +
						'">' +
						(rt.call_function('esc_html__', [rt.new_string('Manual'), rt.new_string('woocommerce')])).str() +
						'</span>')
				} else if rt.is_true(rt.call_method(var_email, 'is_enabled', []rt.PhpVal{})) {
					print('<span class="status-enabled tips" data-tip="' +
						(rt.call_function('esc_attr__', [rt.new_string('Enabled'), rt.new_string('woocommerce')])).str() +
						'">' +
						(rt.call_function('esc_html__', [rt.new_string('Yes'), rt.new_string('woocommerce')])).str() +
						'</span>')
				} else {
					print('<span class="status-disabled tips" data-tip="' +
						(rt.call_function('esc_attr__', [rt.new_string('Disabled'), rt.new_string('woocommerce')])).str() +
						'">-</span>')
				}
				print('</td>')
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('email_type'))) {
				print('<td class="wc-email-settings-table-' +
					(rt.call_function('esc_attr', [var_key.clone()])).str() +
					'">\n\t\t\t\t\t\t\t\t\t\t' +
					(rt.call_function('esc_html', [rt.call_method(var_email, 'get_content_type', []rt.PhpVal{})])).str() +
					'\n\t\t\t\t\t\t\t\t\t\t</td>')
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('actions'))) {
				print('<td class="wc-email-settings-table-' +
					(rt.call_function('esc_attr', [var_key.clone()])).str() +
					'">\n\t\t\t\t\t\t\t\t\t\t<a class="button alignright" href="' +
					(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=email&section=' + var_email_key.clone().to_string().to_lower())])])).str() +
					'">' +
					(rt.call_function('esc_html__', [rt.new_string('Manage'), rt.new_string('woocommerce')])).str() +
					'</a>\n\t\t\t\t\t\t\t\t\t\t</td>')
			} else {
				rt.call_function('do_action', [
					rt.new_string('woocommerce_email_setting_column_' + var_key.str()),
					var_email.clone(),
				])
			}
		}
		print('</tr>')
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Settings_Emails) email_notification_setting_block_emails() {
	mut var_desc_help_text := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('To ensure your store&rsquo;s notifications arrive in your and your customers&rsquo; inboxes, we recommend connecting your email address to your domain and setting up a dedicated SMTP server. If something doesn&rsquo;t seem to be sending correctly, install the <a href="%1$s">WP Mail Logging Plugin</a> or check the <a href="%2$s">Email FAQ page</a>.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('https://wordpress.org/plugins/wp-mail-logging/'),
		rt.new_string('https://woocommerce.com/document/email-faq'),
	])
	mut iife_temp_5 :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}
	mut iife_result_5 := iife_temp_5.get_instance()
	mut var_email_post_manager := iife_result_5
	mut var_emails := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'mailer', []rt.PhpVal{}), 'get_emails', []rt.PhpVal{})
	mut var_email_types := rt.new_array()
	mut var_post_id_for_template := rt.new_null()
	mut iter_7 := var_emails.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_email := item_7.val
		mut var_email_key := item_7.key
		mut var_post_id := rt.call_method(var_email_post_manager, 'get_email_template_post_id', [
			rt.get_property(var_email, 'id'),
		])
		var_email_types << rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_method(var_email, 'get_title', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'description', val: rt.call_method(var_email, 'get_description',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'id', val: rt.get_property(var_email, 'id') },
			rt.ArrayItem{ key: 'email_key', val: var_email_key.clone().to_string().to_lower() },
			rt.ArrayItem{ key: 'post_id', val: var_post_id },
			rt.ArrayItem{ key: 'enabled', val: rt.call_method(var_email, 'is_enabled',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'manual', val: rt.call_method(var_email, 'is_manual', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'recipients', val: rt.create_array([
				rt.ArrayItem{
					key: 'to'
					val: if rt.is_true(rt.call_method(var_email, 'is_customer_email', []rt.PhpVal{})) { rt.call_function('__', [
							rt.new_string('Customers'),
							rt.new_string('woocommerce'),
						]) } else { rt.call_method(var_email, 'get_recipient', []rt.PhpVal{}) }
				},
				rt.ArrayItem{ key: 'cc', val: rt.call_method(var_email, 'get_cc_recipient',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'bcc', val: rt.call_method(var_email, 'get_bcc_recipient',
					[]rt.PhpVal{}) },
			]) },
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id_for_template))))
			&& rt.is_true(var_post_id) {
			var_post_id_for_template = var_post_id.clone()
		}
	}
	mut var_edit_template_url := rt.new_null()
	if rt.is_true(var_post_id_for_template) {
		mut var_email_template_id := rt.new_string(
			(rt.call_function('get_stylesheet', []rt.PhpVal{})).str() + '//' +(Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate.template_slug()).str())
		var_edit_template_url = rt.call_function('admin_url', [
			rt.new_string('post.php?post=' + var_post_id_for_template.str() +
				'&action=edit&template=' + var_email_template_id.str()),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wp_json_encode', [rt.create_array_from_list(var_email_types)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_edit_template_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Loading&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('wpautop', [
			rt.call_function('wptexturize', [var_desc_help_text.clone()]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Settings_Emails) email_preview() {
	this.delete_transient_email_settings()
	mut var_emails := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'mailer', []rt.PhpVal{}), 'get_emails', []rt.PhpVal{})
	mut var_email_types := rt.new_array()
	mut iter_8 := var_emails.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_email := item_8.val
		var_email_types << rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_method(var_email, 'get_title', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('get_class', [
				var_email.clone()]) },
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wp_nonce_url', [
			rt.call_function('admin_url', [
				rt.new_string('?preview_woocommerce_mail=true'),
			]),
			rt.new_string('preview-mail'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wp_json_encode', [rt.create_array_from_list(var_email_types)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview{}
	mut iife_result_6 := iife_temp_6.get_email_style_setting_ids()
	mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview{}
	mut iife_result_7 := iife_temp_7.get_email_style_setting_ids()
	mut iife_temp_8 := Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview{}
	mut iife_result_8 := iife_temp_8.get_email_style_setting_ids()
	mut iife_temp_9 := Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview{}
	mut iife_result_9 := iife_temp_9.get_email_style_setting_ids()
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wp_json_encode', [iife_result_6]),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Settings_Emails) email_preview_single(var_email rt.PhpVal) {
	this.delete_transient_email_settings()
	mut var_email_types := [
		[rt.call_method(var_email, 'get_title', []rt.PhpVal{}),
			rt.call_function('get_class', [var_email.clone()])],
	]
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('__', [rt.new_string('Email preview'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('__', [
			rt.new_string('Preview your email template. You can also test on different devices and send yourself a test email.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wp_nonce_url', [
			rt.call_function('admin_url', [
				rt.new_string('?preview_woocommerce_mail=true'),
			]),
			rt.new_string('preview-mail'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wp_json_encode', [rt.create_array_from_list(var_email_types)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_10 := Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview{}
	mut iife_result_10 :=
		iife_temp_10.get_email_content_setting_ids(rt.get_property(var_email, 'id'))
	mut iife_temp_11 := Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview{}
	mut iife_result_11 :=
		iife_temp_11.get_email_content_setting_ids(rt.get_property(var_email, 'id'))
	mut iife_temp_12 := Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview{}
	mut iife_result_12 :=
		iife_temp_12.get_email_content_setting_ids(rt.get_property(var_email, 'id'))
	mut iife_temp_13 := Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview{}
	mut iife_result_13 :=
		iife_temp_13.get_email_content_setting_ids(rt.get_property(var_email, 'id'))
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wp_json_encode', [iife_result_10]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('get_option', [rt.new_string('woocommerce_email_from_name')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('get_option', [rt.new_string('woocommerce_email_from_address')]),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Settings_Emails) delete_transient_email_settings() {
	mut iife_temp_14 := Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview{}
	mut iife_result_14 := iife_temp_14.get_all_email_setting_ids()
	mut var_setting_ids := iife_result_14
	mut iter_9 := var_setting_ids.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_id := item_9.val
		rt.call_function('delete_transient', [var_id.clone()])
	}
}

fn (mut this Class_WC_Settings_Emails) email_image_url(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	mut var_option_value := var_value_mutated.array_get(rt.new_string('value'))
	if !(var_value_mutated.array_isset(rt.new_string('field_name'))) {
		var_value_mutated.array_set('field_name', var_value_mutated.array_get(rt.new_string('id')))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr',
		[var_value_mutated.array_get(rt.new_string('row_class'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_value_mutated.array_get(rt.new_string('id'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_value_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip',
		[var_value_mutated.array_get(rt.new_string('desc'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('sanitize_title', [var_value_mutated.array_get(rt.new_string('type'))]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr',
		[var_value_mutated.array_get(rt.new_string('field_name'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_value_mutated.array_get(rt.new_string('id'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_option_value.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_value_mutated.array_get(rt.new_string('id'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_option_value.clone()]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Settings_Emails) sanitize_email_header_image(var_value rt.PhpVal, var_option rt.PhpVal, var_raw_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	return rt.call_function('sanitize_url', [var_raw_value.clone()])
}

fn (mut this Class_WC_Settings_Emails) email_font_family(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	mut var_option_value := var_value_mutated.array_get(rt.new_string('value'))
	mut var_custom_fonts := rt.new_null()
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr',
		[var_value_mutated.array_get(rt.new_string('row_class'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_value_mutated.array_get(rt.new_string('id'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_value_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('sanitize_title', [var_value_mutated.array_get(rt.new_string('type'))]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [var_value_mutated.array_get(rt.new_string('id'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr',
		[var_value_mutated.array_get(rt.new_string('field_name'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_value_mutated.array_get(rt.new_string('id'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr__', [rt.new_string('Standard fonts'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	mut iter_10 :=
		rt.get_static_prop('Automattic_WooCommerce_Internal_Email_EmailFont', 'font').iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_font_family := item_10.val
		mut var_key := item_10.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_font_family.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_option_value.clone(),
			rt.new_string(var_key.str())])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_key.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_custom_fonts) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr__', [rt.new_string('Custom fonts'),
			rt.new_string('woocommerce')]))
		// unsupported statement: Stmt_InlineHTML
		mut iter_11 := var_custom_fonts.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_val := item_11.val
			mut var_key := item_11.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [var_option_value.clone(),
				rt.new_string(var_key.str())])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_val.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Settings_Emails) email_color_palette(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	mut var_email_improvements_enabled := this.get_email_improvements_enabled()
	mut iife_temp_15 := Class_Automattic_WooCommerce_Internal_Email_EmailColors{}
	mut iife_result_15 := iife_temp_15.get_default_colors(var_email_improvements_enabled.clone())
	mut var_default_colors := iife_result_15
	mut var_auto_sync := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Email_EmailStyleSync.auto_sync_option(),
		rt.new_string('no'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_value_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_email_improvements_enabled) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('wp_json_encode', [var_default_colors.clone()]),
		]))
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{})) {
			'data-has-theme-json'
		} else {
			''
		})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_auto_sync.clone()]))
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Sync with theme'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Settings_Emails) previewing_new_templates() {
	if !(this.is_trying_new_templates()) {
		return
	}
	mut iife_temp_16 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_16 := iife_temp_16.feature_is_enabled(rt.new_string('email_improvements'))
	if rt.is_true(iife_result_16) {
		return
	}
	rt.call_function('update_option', [
		rt.new_string('woocommerce_admin_dismissed_try_email_improvements_modal'),
		rt.new_string('yes'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Previewing new template designs. You can customize and test your emails and switch to the new template whenever you are ready.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Save changes'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Switch to new template'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Keep legacy template'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Settings_Emails) email_improvements_button() {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_transient', [
		rt.new_string('wc_settings_email_improvements_reverted'),
	])))
	{
		// unsupported statement: Stmt_InlineHTML
	}
	mut iife_temp_17 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_17 := iife_temp_17.feature_is_enabled(rt.new_string('email_improvements'))
	mut var_is_feature_enabled := iife_result_17
	mut var_trying_new_templates := rt.new_bool(this.is_trying_new_templates())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_feature_enabled))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_trying_new_templates)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Try our new email templates!'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		return
	}
	mut var_has_feature_enabled_since_installation := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_email_improvements_default_enabled'),
		rt.new_string('no'),
	]))
	if rt.is_true(var_is_feature_enabled)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_has_feature_enabled_since_installation)))) {
		mut var_disable_feature_args := {
			'email_improvements': rt.new_string('0')
			'_feature_nonce':     rt.call_function('wp_create_nonce', [
				rt.new_string('change_feature_enable'),
			])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('add_query_arg', [
				rt.create_array_from_native_map(var_disable_feature_args),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [
			rt.new_string('Are you sure want to revert to legacy? Doing so will erase any changes you’ve made to your new email templates, and will restore your previous email designs.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Revert to legacy template'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		return
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Settings_Emails) append_feature_email_improvements_to_tracks(var_event_properties rt.PhpVal) rt.PhpVal {
	mut var_event_properties_mutated := var_event_properties
	if rt.is_true(rt.new_bool(var_event_properties_mutated.clone().is_array())) {
		mut iife_temp_18 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		mut iife_result_18 := iife_temp_18.feature_is_enabled(rt.new_string('email_improvements'))
		mut var_is_email_improvements_enabled := iife_result_18
		var_event_properties_mutated.array_set('feature_email_improvements', if rt.is_true(var_is_email_improvements_enabled) {
			'enabled'
		} else {
			'disabled'
		})
	}
	return var_event_properties_mutated.clone()
}

fn (mut this Class_WC_Settings_Emails) track_email_improvements_feature_change(var_feature_id rt.PhpVal, var_enabled rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_string('email_improvements'), var_feature_id)) {
		mut var_current_date := rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')])
		if rt.is_true(var_enabled) {
			mut var_enabled_count := rt.call_function('get_option', [
				rt.new_string('woocommerce_email_improvements_enabled_count'),
				rt.new_int(0),
			])
			rt.call_function('update_option', [
				rt.new_string('woocommerce_email_improvements_enabled_count'),
				rt.add(var_enabled_count, rt.new_int(1)),
			])
			rt.call_function('add_option', [
				rt.new_string('woocommerce_email_improvements_first_enabled_at'),
				var_current_date.clone(),
			])
			rt.call_function('update_option', [
				rt.new_string('woocommerce_email_improvements_last_enabled_at'),
				var_current_date.clone(),
			])
		} else {
			mut var_disabled_count := rt.call_function('get_option', [
				rt.new_string('woocommerce_email_improvements_disabled_count'),
				rt.new_int(0),
			])
			rt.call_function('update_option', [
				rt.new_string('woocommerce_email_improvements_disabled_count'),
				rt.add(var_disabled_count, rt.new_int(1)),
			])
			rt.call_function('add_option', [
				rt.new_string('woocommerce_email_improvements_first_disabled_at'),
				var_current_date.clone(),
			])
			rt.call_function('update_option', [
				rt.new_string('woocommerce_email_improvements_last_disabled_at'),
				var_current_date.clone(),
			])
		}
	}
}

fn (mut this Class_WC_Settings_Emails) enable_email_improvements_when_trying_new_templates() {
	if this.is_trying_new_templates() {
		mut var_feature_controller := rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
		])
		rt.call_method(var_feature_controller, 'change_feature_enable', [
			rt.new_string('email_improvements'),
			rt.new_bool(true),
		])
		rt.call_function('wp_safe_redirect', [
			rt.call_function('remove_query_arg', [rt.new_string('try-new-templates')]),
		])
		exit(0)
	}
}

fn (mut this Class_WC_Settings_Emails) get_email_improvements_enabled() rt.PhpVal {
	mut iife_temp_19 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_19 := iife_temp_19.feature_is_enabled(rt.new_string('email_improvements'))
	mut var_email_improvements_enabled := iife_result_19
	if this.is_trying_new_templates() {
		var_email_improvements_enabled = rt.new_bool(true)
		rt.call_function('set_transient', [
			Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.transient_preview_email_improvements(),
			rt.new_string('yes'),
		])
	} else {
		rt.call_function('delete_transient', [
			Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.transient_preview_email_improvements(),
		])
	}
	return var_email_improvements_enabled.clone()
}

fn (mut this Class_WC_Settings_Emails) is_trying_new_templates() bool {
	mut var_current_tab := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('email'), var_current_tab)))) {
		return false
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('section')) {
		return false
	}
	return (rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('try-new-templates')))).to_bool()
	return false
}

struct Class_WC_Settings_Page {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Email_EmailColors {
	rt.PhpObjectBase
}

struct Class_WP_Font_Face_Resolver {
	rt.PhpObjectBase
}

struct Class_WC_Emails {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview {
	rt.PhpObjectBase
}

fn create_wc_settings_emails() &Class_WC_Settings_Emails {
	mut obj := &Class_WC_Settings_Emails{
		PhpObjectBase: rt.PhpObjectBase{}
		icon:          rt.new_string('atSymbol')
	}
	obj.construct()
	return obj
}

fn create_wc_settings_page(_args ...rt.PhpVal) &Class_WC_Settings_Page {
	mut obj := &Class_WC_Settings_Page{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_email_emailcolors(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Email_EmailColors {
	mut obj := &Class_Automattic_WooCommerce_Internal_Email_EmailColors{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_font_face_resolver(_args ...rt.PhpVal) &Class_WP_Font_Face_Resolver {
	mut obj := &Class_WP_Font_Face_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_emails(_args ...rt.PhpVal) &Class_WC_Emails {
	mut obj := &Class_WC_Emails{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsmanager(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_emailpreview_emailpreview(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Settings_Emails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_own_sections' {
			return this.get_own_sections()
		}
		'get_settings_for_default_section' {
			return this.get_settings_for_default_section()
		}
		'get_custom_fonts' {
			return this.get_custom_fonts()
		}
		'output' {
			this.output()
			return rt.new_null()
		}
		'run_email_admin_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.run_email_admin_options(dispatch_arg_0)
			return rt.new_null()
		}
		'save' {
			this.save()
			return rt.new_null()
		}
		'email_notification_setting' {
			this.email_notification_setting()
			return rt.new_null()
		}
		'email_notification_setting_block_emails' {
			this.email_notification_setting_block_emails()
			return rt.new_null()
		}
		'email_preview' {
			this.email_preview()
			return rt.new_null()
		}
		'email_preview_single' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.email_preview_single(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_transient_email_settings' {
			this.delete_transient_email_settings()
			return rt.new_null()
		}
		'email_image_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.email_image_url(dispatch_arg_0)
			return rt.new_null()
		}
		'sanitize_email_header_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.sanitize_email_header_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'email_font_family' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.email_font_family(dispatch_arg_0)
			return rt.new_null()
		}
		'email_color_palette' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.email_color_palette(dispatch_arg_0)
			return rt.new_null()
		}
		'previewing_new_templates' {
			this.previewing_new_templates()
			return rt.new_null()
		}
		'email_improvements_button' {
			this.email_improvements_button()
			return rt.new_null()
		}
		'append_feature_email_improvements_to_tracks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.append_feature_email_improvements_to_tracks(dispatch_arg_0)
		}
		'track_email_improvements_feature_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.track_email_improvements_feature_change(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'enable_email_improvements_when_trying_new_templates' {
			this.enable_email_improvements_when_trying_new_templates()
			return rt.new_null()
		}
		'get_email_improvements_enabled' {
			return this.get_email_improvements_enabled()
		}
		'is_trying_new_templates' {
			return rt.new_bool(this.is_trying_new_templates())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Settings_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'icon' { return this.icon }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Settings_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'icon' {
			this.icon = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Settings_Page) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Settings_Page) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_Page) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailColors) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Email_EmailColors) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailColors) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Font_Face_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Font_Face_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Font_Face_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Emails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Settings_Emails'),
		rt.new_bool(false)]))
	{
		return rt.new_object('WC_Settings_Emails', ['WC_Settings_Page'],
			create_wc_settings_emails())
	}
	return rt.new_object('WC_Settings_Emails', ['WC_Settings_Page'], create_wc_settings_emails())
}
