import rt

struct Class_WC_Email {
	rt.PhpObjectBase
pub mut:
	id                         rt.PhpVal = rt.new_null()
	title                      rt.PhpVal = rt.new_null()
	enabled                    rt.PhpVal = rt.new_null()
	description                rt.PhpVal = rt.new_null()
	heading                    rt.PhpVal = rt.new_string('')
	subject                    rt.PhpVal = rt.new_string('')
	template_plain             rt.PhpVal = rt.new_null()
	template_html              rt.PhpVal = rt.new_null()
	template_block             rt.PhpVal = rt.new_null()
	template_base              rt.PhpVal = rt.new_null()
	recipient                  rt.PhpVal = rt.new_null()
	cc                         rt.PhpVal = rt.new_null()
	bcc                        rt.PhpVal = rt.new_null()
	object                     rt.PhpVal = rt.new_null()
	mime_boundary              rt.PhpVal = rt.new_null()
	mime_boundary_header       rt.PhpVal = rt.new_null()
	sending                    bool
	manual                     rt.PhpVal = rt.new_bool(false)
	customer_email             rt.PhpVal = rt.new_bool(false)
	email_group                rt.PhpVal = rt.new_string('')
	plain_search               rt.PhpVal = rt.new_array()
	plain_replace              rt.PhpVal = rt.new_array()
	placeholders               rt.PhpVal = rt.new_array()
	find                       rt.PhpVal = rt.new_array()
	replace                    rt.PhpVal = rt.new_array()
	email_type                 rt.PhpVal = rt.new_null()
	email_improvements_enabled rt.PhpVal = rt.new_null()
	block_email_editor_enabled rt.PhpVal = rt.new_null()
	personalizer               rt.PhpVal = rt.new_null()
	template_block_content     rt.PhpVal = rt.new_string('emails/block/general-block-email.php')
}

fn (mut this Class_WC_Email) construct() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('email_improvements'))
	this.email_improvements_enabled = iife_result_0
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_1 := iife_temp_1.feature_is_enabled(rt.new_string('block_email_editor'))
	this.block_email_editor_enabled = iife_result_1
	this.placeholders = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: '{site_title}', val: this.get_blogname() },
			rt.ArrayItem{ key: '{site_address}', val: rt.call_function('wp_parse_url', [
				rt.call_function('home_url', []rt.PhpVal{}),
				rt.get_constant('PHP_URL_HOST'),
			]) }, rt.ArrayItem{ key: '{site_url}', val: rt.call_function('wp_parse_url', [
				rt.call_function('home_url', []rt.PhpVal{}),
				rt.get_constant('PHP_URL_HOST'),
			]) }, rt.ArrayItem{ key: '{store_email}', val: this.get_from_address('') }]),
		this.placeholders,
	])
	this.init_form_fields()
	this.init_settings()
	if rt.is_true(rt.new_bool(this.template_base.is_null())) {
		this.template_base =
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
			'/templates/'
	}
	this.email_type = this.get_option(rt.new_string('email_type'), rt.new_null())
	this.enabled = this.get_option(rt.new_string('enabled'), rt.new_null())
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_2 := iife_temp_2.feature_is_enabled(rt.new_string('email_improvements'))
	if rt.is_true(iife_result_2) {
		this.cc = this.get_option(rt.new_string('cc'), rt.new_string(''))
		this.bcc = this.get_option(rt.new_string('bcc'), rt.new_string(''))
	}
	if rt.is_true(this.block_email_editor_enabled) {
		this.personalizer = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
			'get', [
			Class_Automattic_WooCommerce_Internal_EmailEditor_TransactionalEmailPersonalizer.class(),
		])
	}
	rt.call_function('add_action', [rt.new_string('phpmailer_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email', [
				'WC_Settings_API',
			], &this) },
			rt.ArrayItem{ key: none, val: 'handle_multipart' },
		])])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_update_options_email_' + (this.id).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email', [
				'WC_Settings_API',
			], &this) },
			rt.ArrayItem{ key: none, val: 'process_admin_options' },
		]),
	])
	rt.call_function('add_filter', [rt.new_string('wp_get_attachment_image_attributes'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email', [
				'WC_Settings_API',
			], &this) },
			rt.ArrayItem{ key: none, val: 'prevent_lazy_loading_on_attachment' },
		]),
		rt.new_int(1), rt.new_int(1)])
}

fn (mut this Class_WC_Email) handle_multipart(var_mailer rt.PhpVal) rt.PhpVal {
	mut var_mailer_mutated := var_mailer
	if !(this.sending) {
		return var_mailer_mutated.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('multipart'), this.get_email_type())) {
		rt.set_property(var_mailer_mutated, 'AltBody', rt.call_function('wordwrap', [
			rt.call_function('preg_replace', [this.plain_search, this.plain_replace,
				rt.call_function('wp_strip_all_tags', [
					rt.new_string(this.get_content_plain()),
				])]),
		]))
	} else {
		rt.set_property(var_mailer_mutated, 'AltBody', rt.new_string(''))
	}
	this.sending = false
	return var_mailer_mutated.clone()
}

fn (mut this Class_WC_Email) format_string(var_string rt.PhpVal) rt.PhpVal {
	mut var_string_mutated := var_string
	mut var_find := rt.func_array_keys(this.placeholders)
	mut var_replace := rt.call_function('array_values', [this.placeholders])
	var_find = rt.call_function('array_merge', [rt.cast_array(this.find),
		var_find.clone()])
	var_replace = rt.call_function('array_merge', [rt.cast_array(this.replace),
		var_replace.clone()])
	var_find.array_push('{blogname}')
	var_replace.array_push(this.get_blogname())
	if rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_email_format_string_replace')]))
		|| rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_email_format_string_find')])) {
		mut var_legacy_find := this.find
		mut var_legacy_replace := this.replace
		mut iter_1 := this.placeholders.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_replace_shadow := item_1.val
			mut var_find_shadow := item_1.key
			mut var_legacy_key := rt.call_function('sanitize_title', [
				rt.call_function('str_replace', [rt.new_string('_'),
					rt.new_string('-'), rt.new_string(var_find_shadow.clone().to_string().trim_space())]),
			])
			var_legacy_find.array_set(var_legacy_key, var_find_shadow.clone())
			var_legacy_replace.array_set(var_legacy_key, var_replace_shadow.clone())
		}
		var_string_mutated = rt.call_function('str_replace', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_email_format_string_find'),
				var_legacy_find.clone(),
				rt.new_object('WC_Email', ['WC_Settings_API'], &this),
			]),
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_email_format_string_replace'),
				var_legacy_replace.clone(),
				rt.new_object('WC_Email', ['WC_Settings_API'], &this),
			]),
			var_string_mutated.clone(),
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_format_string'),
		rt.call_function('str_replace', [var_find.clone(), var_replace.clone(),
			var_string_mutated.clone()]),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Email) setup_locale() {
	mut var_switch_email_locale := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_allow_switching_email_locale'),
		rt.new_bool(true),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
	if rt.is_true(var_switch_email_locale) && rt.is_true(this.is_customer_email())
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_email_setup_locale'), rt.new_bool(true)])) {
		rt.call_function('wc_switch_to_site_locale', []rt.PhpVal{})
	}
}

fn (mut this Class_WC_Email) restore_locale() {
	mut var_restore_email_locale := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_allow_restoring_email_locale'),
		rt.new_bool(true),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
	if rt.is_true(var_restore_email_locale) && rt.is_true(this.is_customer_email())
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_email_restore_locale'), rt.new_bool(true)])) {
		rt.call_function('wc_restore_locale', []rt.PhpVal{})
	}
}

fn (mut this Class_WC_Email) get_email_groups() rt.PhpVal {
	mut var_email_groups := rt.create_array([
		rt.ArrayItem{ key: 'accounts', val: rt.call_function('__', [
			rt.new_string('Accounts'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'orders', val: rt.call_function('__', [
			rt.new_string('Orders'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'order-processing', val: rt.call_function('__', [
			rt.new_string('Order updates'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'order-updates', val: rt.call_function('__', [
			rt.new_string('Order updates'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'order-exceptions', val: rt.call_function('__', [
			rt.new_string('Order changes'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'order-changes', val: rt.call_function('__', [
			rt.new_string('Order changes'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'payments', val: rt.call_function('__', [
			rt.new_string('Payments'),
			rt.new_string('woocommerce'),
		]) },
	])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_email_groups'),
		var_email_groups.clone()])
}

fn (mut this Class_WC_Email) get_email_group_title() string {
	mut var_email_groups := this.get_email_groups()
	mut var_title := if var_email_groups.array_isset(this.email_group) {
		var_email_groups.array_get(this.email_group)
	} else {
		this.email_group
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_group_title'),
		var_title.clone(),
		this.email_group,
		var_email_groups.clone(),
	])).str()
}

fn (mut this Class_WC_Email) get_default_subject() rt.PhpVal {
	return this.subject
}

fn (mut this Class_WC_Email) get_default_heading() rt.PhpVal {
	return this.heading
}

fn (mut this Class_WC_Email) get_default_additional_content() string {
	return ''
}

fn (mut this Class_WC_Email) get_additional_content() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_additional_content_' + (this.id).str()),
		this.format_string(this.get_option_or_transient('additional_content', rt.new_null())),
		this.object,
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Email) get_subject() rt.PhpVal {
	mut var_subject := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_subject_' + (this.id).str()),
		this.format_string(this.get_option_or_transient('subject', this.get_default_subject())),
		this.object,
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
	if rt.is_true(this.block_email_editor_enabled) {
		var_subject = rt.call_function('wp_strip_all_tags', [
			rt.call_method(this.personalizer, 'personalize_transactional_content', [
				var_subject.clone(),
				rt.new_object('WC_Email', ['WC_Settings_API'], &this),
			]),
		])
	}
	return var_subject.clone()
}

fn (mut this Class_WC_Email) get_preheader() rt.PhpVal {
	mut var_preheader := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_preheader' + (this.id).str()),
		this.format_string(this.get_option_or_transient('preheader', rt.new_string(''))),
		this.object,
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
	if rt.is_true(this.block_email_editor_enabled) {
		var_preheader = rt.call_method(this.personalizer, 'personalize_transactional_content', [
			var_preheader.clone(),
			rt.new_object('WC_Email', ['WC_Settings_API'], &this),
		])
	}
	return var_preheader.clone()
}

fn (mut this Class_WC_Email) get_heading() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_heading_' + (this.id).str()),
		this.format_string(this.get_option_or_transient('heading', this.get_default_heading())),
		this.object,
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Email) get_recipient() rt.PhpVal {
	mut var_recipient := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_recipient_' + (this.id).str()),
		this.recipient,
		this.object,
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
	mut var_recipients := rt.call_function('array_map', [rt.new_string('trim'),
		rt.call_function('explode', [rt.new_string(','), if !var_recipient.is_null() {
			var_recipient
		} else {
			rt.new_string('')
		}])])
	var_recipients = rt.call_function('array_filter', [var_recipients.clone(),
		rt.new_string('is_email')])
	return rt.call_function('implode', [rt.new_string(', '), var_recipients.clone()])
}

fn (mut this Class_WC_Email) get_cc_recipient() rt.PhpVal {
	mut var_cc := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_cc_recipient_' + (this.id).str()),
		this.cc,
		this.object,
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
	mut var_ccs := rt.call_function('array_map', [rt.new_string('trim'),
		rt.call_function('explode', [rt.new_string(','), if !var_cc.is_null() {
			var_cc
		} else {
			rt.new_string('')
		}])])
	var_ccs = rt.call_function('array_filter', [var_ccs.clone(),
		rt.new_string('is_email')])
	var_ccs = rt.call_function('array_map', [rt.new_string('sanitize_email'),
		var_ccs.clone()])
	return rt.call_function('implode', [rt.new_string(', '), var_ccs.clone()])
}

fn (mut this Class_WC_Email) get_bcc_recipient() rt.PhpVal {
	mut var_bcc := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_bcc_recipient_' + (this.id).str()),
		this.bcc,
		this.object,
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
	mut var_bccs := rt.call_function('array_map', [rt.new_string('trim'),
		rt.call_function('explode', [rt.new_string(','), if !var_bcc.is_null() {
			var_bcc
		} else {
			rt.new_string('')
		}])])
	var_bccs = rt.call_function('array_filter', [var_bccs.clone(),
		rt.new_string('is_email')])
	var_bccs = rt.call_function('array_map', [rt.new_string('sanitize_email'),
		var_bccs.clone()])
	return rt.call_function('implode', [rt.new_string(', '), var_bccs.clone()])
}

fn (mut this Class_WC_Email) get_headers() rt.PhpVal {
	mut var_header := rt.new_string('Content-Type: ' + (this.get_content_type('')).str() + '\r\n')
	if rt.is_true(rt.call_function('in_array', [this.id,
		rt.create_array([rt.ArrayItem{ key: none, val: 'new_order' },
			rt.ArrayItem{ key: none, val: 'cancelled_order' },
			rt.ArrayItem{ key: none, val: 'failed_order' }]),
		rt.new_bool(true)]))
	{
		if rt.is_true(this.object)
			&& rt.is_true(rt.call_method(this.object, 'get_billing_email', []rt.PhpVal{}))
			&& rt.is_true(rt.call_method(this.object, 'get_billing_first_name', []rt.PhpVal{}))
			|| rt.is_true(rt.call_method(this.object, 'get_billing_last_name', []rt.PhpVal{})) {
			var_header = rt.concat(var_header, rt.new_string('Reply-to: ' +
				(rt.call_method(this.object, 'get_billing_first_name', []rt.PhpVal{})).str() + ' ' +
				(rt.call_method(this.object, 'get_billing_last_name', []rt.PhpVal{})).str() + ' <' +
				(rt.call_method(this.object, 'get_billing_email', []rt.PhpVal{})).str() + '>\r\n'))
		}
	} else {
		mut var_reply_to_enabled := rt.new_bool(this.get_reply_to_enabled())
		mut var_reply_to_address := this.get_reply_to_address('')
		mut var_reply_to_name := this.get_reply_to_name('')
		if rt.is_true(var_reply_to_enabled) && !(!rt.is_true(var_reply_to_address))
			&& rt.is_true(rt.call_function('is_email', [var_reply_to_address.clone()])) {
			var_reply_to_name = if !(!rt.is_true(var_reply_to_name)) {
				var_reply_to_name
			} else {
				this.get_from_name('')
			}
			var_header = rt.concat(var_header, rt.new_string('Reply-to: ' +
				var_reply_to_name.str() + ' <' + var_reply_to_address.str() + '>\r\n'))
		} else if rt.is_true(this.get_from_address('')) && rt.is_true(this.get_from_name('')) {
			var_header = rt.concat(var_header, rt.new_string('Reply-to: ' +
				(this.get_from_name('')).str() + ' <' + (this.get_from_address('')).str() + '>\r\n'))
		}
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_3 := iife_temp_3.feature_is_enabled(rt.new_string('email_improvements'))
	if rt.is_true(iife_result_3) {
		mut var_cc := this.get_cc_recipient()
		if !(!rt.is_true(var_cc)) {
			var_header = rt.concat(var_header, rt.new_string('Cc: ' +
				(rt.call_function('sanitize_text_field', [var_cc.clone()])).str() + '\r\n'))
		}
		mut var_bcc := this.get_bcc_recipient()
		if !(!rt.is_true(var_bcc)) {
			var_header = rt.concat(var_header, rt.new_string('Bcc: ' +
				(rt.call_function('sanitize_text_field', [var_bcc.clone()])).str() + '\r\n'))
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_email_headers'),
		var_header.clone(), this.id, this.object, rt.new_object('WC_Email', [
			'WC_Settings_API',
		], &this)])
}

fn (mut this Class_WC_Email) get_attachments() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_attachments'),
		rt.new_array(),
		this.id,
		this.object,
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Email) get_email_type() rt.PhpVal {
	mut var_email_type := this.email_type
	mut var_is_email_preview := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_is_email_preview'),
		rt.new_bool(false),
	])
	if rt.is_true(var_is_email_preview) {
		mut var_transient := rt.call_function('get_transient', [
			rt.concat(rt.concat(rt.new_string('woocommerce_'), this.id),
				rt.new_string('_email_type')),
		])
		var_email_type = if rt.is_true(var_transient) { var_transient } else { var_email_type }
	}
	return if rt.is_true(var_email_type)
		&& rt.is_true(rt.call_function('class_exists', [rt.new_string('DOMDocument')])) {
		var_email_type
	} else {
		rt.new_string('plain')
	}
}

fn (mut this Class_WC_Email) get_block_editor_email_template_content() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [this.template_block_content,
		rt.create_array([rt.ArrayItem{ key: 'order', val: this.object },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email', [
				'WC_Settings_API',
			], &this) }])])
}

fn (mut this Class_WC_Email) get_content_type(default_content_type string) rt.PhpVal {
	mut switch_val_1 := this.get_email_type()
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('html'))) {
		mut var_content_type := rt.new_string('text/html')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('multipart'))) {
		var_content_type = rt.new_string('multipart/alternative')
	} else {
		var_content_type = rt.new_string('text/plain')
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_content_type'),
		var_content_type.clone(),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
		rt.new_string(default_content_type),
	])
}

fn (mut this Class_WC_Email) get_title() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_email_title'),
		this.title, rt.new_object('WC_Email', ['WC_Settings_API'], &this)])
}

fn (mut this Class_WC_Email) get_description() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_description'),
		this.description,
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Email) get_option(var_key rt.PhpVal, var_empty_value rt.PhpVal) rt.PhpVal {
	mut var_value := this.Class_WC_Settings_API.get_option(var_key.clone(), var_empty_value.clone())
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_get_option'),
		var_value.clone(),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
		var_value.clone(),
		var_key.clone(),
		var_empty_value.clone(),
	])
}

fn (mut this Class_WC_Email) is_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_enabled_' + (this.id).str()),
		rt.identical(rt.new_string('yes'), this.enabled),
		this.object,
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Email) is_manual() rt.PhpVal {
	return this.manual
}

fn (mut this Class_WC_Email) is_customer_email() rt.PhpVal {
	return this.customer_email
}

fn (mut this Class_WC_Email) get_blogname() rt.PhpVal {
	return rt.call_function('wp_specialchars_decode', [
		rt.call_function('get_option', [rt.new_string('blogname')]),
		rt.get_constant('ENT_QUOTES'),
	])
}

fn (mut this Class_WC_Email) get_content() rt.PhpVal {
	this.sending = true
	mut var_block_email_content := rt.new_string(this.get_block_email_html_content())
	if rt.is_true(var_block_email_content) {
		this.email_type = if rt.is_true(rt.identical(rt.new_string('plain'), this.email_type)) {
			rt.new_string('html')
		} else {
			this.email_type
		}
		return var_block_email_content.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('plain'), this.get_email_type())) {
		mut var_email_content := rt.call_function('wordwrap', [
			rt.call_function('preg_replace', [this.plain_search, this.plain_replace,
				rt.call_function('wp_strip_all_tags', [
					rt.new_string(this.get_content_plain()),
				])]),
			rt.new_int(70),
		])
	} else {
		var_email_content = rt.new_string(this.get_content_html())
	}
	return var_email_content.clone()
}

fn (mut this Class_WC_Email) style_inline(var_content rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	if rt.is_true(rt.call_function('in_array', [this.get_content_type(''),
		rt.create_array([rt.ArrayItem{ key: none, val: 'text/html' },
			rt.ArrayItem{ key: none, val: 'multipart/alternative' }]),
		rt.new_bool(true)]))
	{
		mut var_style_inline_callback := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_mail_style_inline_callback'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Email', [
					'WC_Settings_API',
				], &this) },
				rt.ArrayItem{ key: none, val: 'apply_inline_style' },
			]),
			var_content_mutated.clone(),
			rt.new_object('WC_Email', [
				'WC_Settings_API',
			], &this),
		])
		if !(rt.call_function('is_callable', [var_style_inline_callback.clone()])) {
			var_style_inline_callback = rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Email', [
					'WC_Settings_API',
				], &this) },
				rt.ArrayItem{ key: none, val: 'apply_inline_style' },
			])
		}
		return rt.call_function('call_user_func', [var_style_inline_callback.clone(),
			var_content_mutated.clone()])
	}
	return var_content_mutated.clone()
}

fn (mut this Class_WC_Email) apply_inline_style(var_content rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	mut var_css := rt.new_string('')
	var_css = rt.concat(var_css, this.get_must_use_css_styles())
	var_css = rt.concat(var_css, rt.new_string('\n'))
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wc_get_template', [rt.new_string('emails/email-styles.php')])
	var_css = rt.concat(var_css, rt.call_function('ob_get_clean', []rt.PhpVal{}))
	var_css = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_styles'),
		var_css.clone(),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
	mut var_css_inliner_class :=
		Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_CssInliner.class()
	if rt.is_true(this.supports_emogrifier())
		&& rt.is_true(rt.call_function('class_exists', [var_css_inliner_class.clone()])) {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_CssInliner{}
		mut iife_result_4 := iife_temp_4.fromhtml(var_content_mutated.clone())
		mut var_css_inliner := rt.call_method(iife_result_4, 'inlineCss', [
			var_css.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_function('do_action', [rt.new_string('woocommerce_emogrifier'),
			var_css_inliner.clone(), rt.new_object('WC_Email', ['WC_Settings_API'], &this)])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut var_dom_document := rt.call_method(var_css_inliner, 'getDomDocument', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(this.block_email_editor_enabled)))) {
			mut iife_temp_5 :=
				Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner{}
			mut iife_result_5 := iife_temp_5.fromdomdocument(var_dom_document.clone())
			rt.call_method(iife_result_5, 'removeElementsWithDisplayNone', []rt.PhpVal{})
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut iife_temp_6 :=
			Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter{}
		mut iife_result_6 := iife_temp_6.fromdomdocument(var_dom_document.clone())
		var_content_mutated = rt.call_method(rt.call_method(iife_result_6,
			'convertCssToVisualAttributes', []rt.PhpVal{}), 'render', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.clone()
			mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
			rt.call_method(var_logger, 'error', [
				rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
				rt.create_array([rt.ArrayItem{ key: 'source', val: 'emogrifier' }]),
			])
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
	} else {
		var_content_mutated = rt.new_string('<style type="text/css">' + var_css.str() + '</style>' +
			var_content_mutated.str())
	}
	return var_content_mutated.clone()
}

fn (mut this Class_WC_Email) get_must_use_css_styles() string {
	mut var_css :=
		rt.new_string('\n/*\n* Temporary measure until e-mail clients more properly support the correct styles.\n* See https://github.com/woocommerce/woocommerce/pull/47738.\n*/\n.screen-reader-text {\n\tdisplay: none;\n}\n')
	return var_css.str()
}

fn (mut this Class_WC_Email) supports_emogrifier() rt.PhpVal {
	return rt.call_function('class_exists', [rt.new_string('DOMDocument')])
}

fn (mut this Class_WC_Email) get_content_plain() string {
	return ''
}

fn (mut this Class_WC_Email) get_content_html() string {
	return ''
}

fn (mut this Class_WC_Email) get_from_name(from_name string) rt.PhpVal {
	mut from_name_mutated := from_name
	mut var_default := rt.call_function('get_bloginfo', [rt.new_string('name'),
		rt.new_string('display')])
	from_name_mutated = (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_from_name'),
		rt.call_function('get_option', [rt.new_string('woocommerce_email_from_name'),
			var_default.clone()]),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
		rt.new_string(from_name_mutated).clone(),
	])).str()
	return rt.call_function('wp_specialchars_decode', [
		rt.call_function('esc_html', [rt.new_string(from_name_mutated).clone()]),
		rt.get_constant('ENT_QUOTES'),
	])
}

fn (mut this Class_WC_Email) get_from_address(from_email string) rt.PhpVal {
	mut from_email_mutated := from_email
	from_email_mutated = (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_from_address'),
		rt.call_function('get_option', [rt.new_string('woocommerce_email_from_address')]),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
		rt.new_string(from_email_mutated).clone(),
	])).str()
	return rt.call_function('sanitize_email', [rt.new_string(from_email_mutated).clone()])
}

fn (mut this Class_WC_Email) get_reply_to_enabled() bool {
	mut var_enabled := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_reply_to_enabled'),
		rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_email_reply_to_enabled'),
			rt.new_string('no'),
		])),
		rt.new_object('WC_Email', [
			'WC_Settings_API',
		], &this),
	])
	return var_enabled.to_bool()
}

fn (mut this Class_WC_Email) get_reply_to_name(reply_to_name string) rt.PhpVal {
	mut reply_to_name_mutated := reply_to_name
	reply_to_name_mutated = (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_reply_to_name'),
		rt.call_function('get_option', [rt.new_string('woocommerce_email_reply_to_name'),
			rt.new_string('')]),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
		rt.new_string(reply_to_name_mutated).clone(),
	])).str()
	return rt.call_function('wp_specialchars_decode', [
		rt.call_function('sanitize_text_field', [rt.new_string(reply_to_name_mutated).clone()]),
		rt.get_constant('ENT_QUOTES'),
	])
}

fn (mut this Class_WC_Email) get_reply_to_address(reply_to_email string) rt.PhpVal {
	mut reply_to_email_mutated := reply_to_email
	reply_to_email_mutated = (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_reply_to_address'),
		rt.call_function('get_option', [
			rt.new_string('woocommerce_email_reply_to_address'),
			rt.new_string(''),
		]),
		rt.new_object('WC_Email', [
			'WC_Settings_API',
		], &this),
		rt.new_string(reply_to_email_mutated).clone(),
	])).str()
	return rt.call_function('sanitize_email', [rt.new_string(reply_to_email_mutated).clone()])
}

fn (mut this Class_WC_Email) set_object(var_object rt.PhpVal) {
	this.object = var_object.clone()
}

fn (mut this Class_WC_Email) send(var_to rt.PhpVal, var_subject rt.PhpVal, var_message rt.PhpVal, var_headers rt.PhpVal, var_attachments rt.PhpVal) rt.PhpVal {
	mut var_subject_mutated := var_subject
	mut var_message_mutated := var_message
	rt.call_function('add_filter', [rt.new_string('wp_mail_from'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email', [
				'WC_Settings_API',
			], &this) },
			rt.ArrayItem{ key: none, val: 'get_from_address' },
		])])
	rt.call_function('add_filter', [rt.new_string('wp_mail_from_name'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email', [
				'WC_Settings_API',
			], &this) },
			rt.ArrayItem{ key: none, val: 'get_from_name' },
		])])
	rt.call_function('add_filter', [rt.new_string('wp_mail_content_type'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email', [
				'WC_Settings_API',
			], &this) },
			rt.ArrayItem{ key: none, val: 'get_content_type' },
		])])
	var_message_mutated = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_mail_content'),
		this.style_inline(var_message_mutated.clone()),
	])
	mut var_mail_callback := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_mail_callback'),
		rt.new_string('wp_mail'),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
	mut var_mail_callback_params := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_mail_callback_params'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_to },
			rt.ArrayItem{ key: none, val: rt.call_function('wp_specialchars_decode', [
				var_subject_mutated.clone(),
			]) }, rt.ArrayItem{ key: none, val: var_message_mutated },
			rt.ArrayItem{ key: none, val: var_headers }, rt.ArrayItem{
				key: none
				val: var_attachments
			}]),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
	mut var_return := rt.call_callable(var_mail_callback, [var_mail_callback_params.clone()])
	rt.call_function('remove_filter', [rt.new_string('wp_mail_from'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email', [
				'WC_Settings_API',
			], &this) },
			rt.ArrayItem{ key: none, val: 'get_from_address' },
		])])
	rt.call_function('remove_filter', [rt.new_string('wp_mail_from_name'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email', [
				'WC_Settings_API',
			], &this) },
			rt.ArrayItem{ key: none, val: 'get_from_name' },
		])])
	rt.call_function('remove_filter', [rt.new_string('wp_mail_content_type'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email', [
				'WC_Settings_API',
			], &this) },
			rt.ArrayItem{ key: none, val: 'get_content_type' },
		])])
	this.clear_alt_body_field()
	rt.call_function('do_action', [rt.new_string('woocommerce_email_sent'),
		var_return.clone(), rt.new_string((this.id).str()),
		rt.new_object('WC_Email', [
			'WC_Settings_API',
		], &this)])
	return var_return.clone()
}

fn (mut this Class_WC_Email) init_form_fields() {
	mut var_placeholder_text := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Available placeholders: %s'),
			rt.new_string('woocommerce')]),
		rt.new_string('<code>' +
			(rt.call_function('esc_html', [rt.call_function('implode', [rt.new_string('</code>, <code>'), rt.func_array_keys(this.placeholders)])])).str() +
			'</code>'),
	])
	this.dispatch_set_prop('form_fields', rt.create_array([
		rt.ArrayItem{ key: 'enabled', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Enable/Disable'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Enable this email notification'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: 'yes' },
		]) },
		rt.ArrayItem{ key: 'subject', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Subject'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'description', val: var_placeholder_text },
			rt.ArrayItem{ key: 'placeholder', val: this.get_default_subject() },
			rt.ArrayItem{ key: 'default', val: '' },
		]) },
		rt.ArrayItem{ key: 'heading', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Email heading'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'description', val: var_placeholder_text },
			rt.ArrayItem{ key: 'placeholder', val: this.get_default_heading() },
			rt.ArrayItem{ key: 'default', val: '' },
		]) },
		rt.ArrayItem{ key: 'additional_content', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Additional content'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val:
				(rt.call_function('__', [rt.new_string('Text to appear below the main email content.'), rt.new_string('woocommerce')])).str() +
				' ' + var_placeholder_text.str() },
			rt.ArrayItem{ key: 'css', val: 'width:400px; height: 75px;' },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('N/A'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'textarea' },
			rt.ArrayItem{ key: 'default', val: this.get_default_additional_content() },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: 'email_type', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Email type'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Choose which format of email to send.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: 'html' },
			rt.ArrayItem{ key: 'class', val: 'email_type wc-enhanced-select' },
			rt.ArrayItem{ key: 'options', val: this.get_email_type_options() },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
	]))
	mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_7 := iife_temp_7.feature_is_enabled(rt.new_string('email_improvements'))
	if rt.is_true(iife_result_7) {
		rt.get_property(rt.new_object('WC_Email', ['WC_Settings_API'], &this), 'form_fields').array_set('cc',
			this.get_cc_field())
		rt.get_property(rt.new_object('WC_Email', ['WC_Settings_API'], &this), 'form_fields').array_set('bcc',
			this.get_bcc_field())
	}
	if rt.is_true(this.block_email_editor_enabled) {
		rt.get_property(rt.new_object('WC_Email', ['WC_Settings_API'], &this), 'form_fields').array_set('preheader',
			this.get_preheader_field())
	}
}

fn (mut this Class_WC_Email) get_cc_field() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Cc(s)'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'type', val: 'text' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Enter Cc recipients (comma-separated) for this email.'),
			rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'placeholder', val: '' },
		rt.ArrayItem{ key: 'default', val: '' },
		rt.ArrayItem{ key: 'desc_tip', val: true },
	])
}

fn (mut this Class_WC_Email) get_bcc_field() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Bcc(s)'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'type', val: 'text' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Enter Bcc recipients (comma-separated) for this email.'),
			rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'placeholder', val: '' },
		rt.ArrayItem{ key: 'default', val: '' },
		rt.ArrayItem{ key: 'desc_tip', val: true },
	])
}

fn (mut this Class_WC_Email) get_preheader_field() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Preheader'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Shown as a preview in the Inbox, next to the subject line. (Max 150 characters).'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'placeholder', val: '' },
		rt.ArrayItem{ key: 'type', val: 'text' },
		rt.ArrayItem{ key: 'default', val: '' },
		rt.ArrayItem{ key: 'desc_tip', val: true },
	])
}

fn (mut this Class_WC_Email) get_email_type_options() rt.PhpVal {
	mut var_types := {
		'plain': rt.call_function('__', [rt.new_string('Plain text'),
			rt.new_string('woocommerce')])
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('DOMDocument')])) {
		var_types['html'] = rt.call_function('__', [rt.new_string('HTML'),
			rt.new_string('woocommerce')])
		var_types['multipart'] = rt.call_function('__', [rt.new_string('Multipart'),
			rt.new_string('woocommerce')])
	}
	return var_types.clone()
}

fn (mut this Class_WC_Email) process_admin_options() {
	this.Class_WC_Settings_API.process_admin_options()
	mut var_post_data := this.get_post_data()
	if var_post_data.array_isset(rt.new_string('template_html_code')) {
		this.save_template(var_post_data.array_get(rt.new_string('template_html_code')),
			this.template_html)
	}
	if var_post_data.array_isset(rt.new_string('template_plain_code')) {
		this.save_template(var_post_data.array_get(rt.new_string('template_plain_code')),
			this.template_plain)
	}
}

fn (mut this Class_WC_Email) get_template(var_type rt.PhpVal) string {
	mut var_type_mutated := var_type
	var_type_mutated = rt.call_function('basename', [var_type_mutated.clone()])
	if rt.is_true(rt.identical(rt.new_string('template_html'), var_type_mutated)) {
		return (this.template_html).str()
	} else if rt.is_true(rt.identical(rt.new_string('template_plain'), var_type_mutated)) {
		return (this.template_plain).str()
	} else if rt.is_true(rt.identical(rt.new_string('template_block'), var_type_mutated)) {
		return (this.template_block).str()
	}
	return ''
}

fn (mut this Class_WC_Email) save_template(var_template_code rt.PhpVal, var_template_path rt.PhpVal) {
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_themes')]))
		&& !(!rt.is_true(var_template_code)) && !(!rt.is_true(var_template_path)) {
		mut var_saved := rt.new_bool(false)
		mut var_file := rt.new_string(this.get_theme_template_file(var_template_path.clone()))
		mut var_code := rt.call_function('wp_unslash', [var_template_code.clone()])
		if rt.is_true(rt.call_function('is_writeable', [var_file.clone()])) {
			mut var_f := rt.call_function('fopen', [var_file.clone(),
				rt.new_string('w+')])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_f)))) {
				rt.call_function('fwrite', [var_f.clone(), var_code.clone()])
				rt.call_function('fclose', [var_f.clone()])
				var_saved = rt.new_bool(true)
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_saved)))) {
			mut var_redirect := rt.call_function('add_query_arg', [
				rt.new_string('wc_error'),
				rt.call_function('rawurlencode', [
					rt.call_function('__', [
						rt.new_string('Could not write to template file.'),
						rt.new_string('woocommerce'),
					]),
				]),
			])
			rt.call_function('wp_safe_redirect', [var_redirect.clone()])
			exit(0)
		}
		rt.call_function('wc_clear_template_cache', []rt.PhpVal{})
	}
}

fn (mut this Class_WC_Email) get_theme_template_file(var_template rt.PhpVal) string {
	mut var_template_mutated := var_template
	return (rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).str() + '/' +
		(rt.call_function('apply_filters', [rt.new_string('woocommerce_template_directory'), rt.new_string('woocommerce'), var_template_mutated.clone()])).str() +
		'/' + var_template_mutated.str()
}

fn (mut this Class_WC_Email) move_template_action(var_template_type rt.PhpVal) {
	mut var_template := rt.new_string(this.get_template(var_template_type.clone()))
	if !(!rt.is_true(var_template)) {
		mut var_theme_file := rt.new_string(this.get_theme_template_file(var_template.clone()))
		if rt.is_true(rt.call_function('wp_mkdir_p', [rt.call_function('dirname', [var_theme_file.clone()])]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_theme_file.clone()]))))) {
			mut var_core_file := rt.new_string((this.template_base).str() + var_template.str())
			mut var_template_file := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_locate_core_template'),
				var_core_file.clone(),
				var_template.clone(),
				this.template_base,
				this.id,
			])
			rt.call_function('copy', [var_template_file.clone(),
				var_theme_file.clone()])
			rt.call_function('do_action', [
				rt.new_string('woocommerce_copy_email_template'),
				var_template_type.clone(),
				rt.new_object('WC_Email', ['WC_Settings_API'], &this),
			])
			rt.call_function('wc_clear_template_cache', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html__', [
				rt.new_string('Template file copied to theme.'),
				rt.new_string('woocommerce'),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
}

fn (mut this Class_WC_Email) delete_template_action(var_template_type rt.PhpVal) {
	mut var_template := rt.new_string(this.get_template(var_template_type.clone()))
	if rt.is_true(var_template) {
		if !(!rt.is_true(var_template)) {
			mut var_theme_file := rt.new_string(this.get_theme_template_file(var_template.clone()))
			if rt.is_true(rt.call_function('file_exists', [var_theme_file.clone()])) {
				rt.call_function('unlink', [var_theme_file.clone()])
				rt.call_function('do_action', [
					rt.new_string('woocommerce_delete_email_template'),
					var_template_type.clone(),
					rt.new_object('WC_Email', ['WC_Settings_API'], &this),
				])
				rt.call_function('wc_clear_template_cache', []rt.PhpVal{})
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html__', [
					rt.new_string('Template file deleted from theme.'),
					rt.new_string('woocommerce'),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
		}
	}
}

fn (mut this Class_WC_Email) admin_actions() {
	if !(!rt.is_true(this.template_html)) || !(!rt.is_true(this.template_plain))
		&& !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('move_template'))))
		|| !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('delete_template'))))
		&& rt.is_true(rt.identical(rt.new_string('GET'), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD')))) {
		if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('_wc_email_nonce')))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('_wc_email_nonce'))])]), rt.new_string('woocommerce_email_template_nonce')]))))) {
			rt.call_function('wp_die', [
				rt.call_function('esc_html__', [
					rt.new_string('Action failed. Please refresh the page and retry.'),
					rt.new_string('woocommerce'),
				]),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_themes'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('esc_html__', [
					rt.new_string('You don&#8217;t have permission to do this.'),
					rt.new_string('woocommerce'),
				]),
			])
		}
		if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('move_template')))) {
			this.move_template_action(rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_GET').array_get(rt.new_string('move_template')),
				]),
			]))
		}
		if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('delete_template')))) {
			this.delete_template_action(rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_GET').array_get(rt.new_string('delete_template')),
				]),
			]))
		}
	}
}

fn (mut this Class_WC_Email) admin_options() {
	this.admin_actions()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_back_header', [this.get_title(),
		rt.call_function('__', [rt.new_string('Return to emails'),
			rt.new_string('woocommerce')]),
		rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=email')])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wpautop', [
		rt.call_function('wp_kses_post', [this.get_description()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_email_settings_before'),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this)])
	// unsupported statement: Stmt_InlineHTML
	this.generate_settings_html()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_email_settings_after'),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this)])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_themes')]))
		&& !(!rt.is_true(this.template_html)) || !(!rt.is_true(this.template_plain)) {
		// unsupported statement: Stmt_InlineHTML
		mut var_templates := {
			'template_html':  rt.call_function('__', [rt.new_string('HTML template'),
				rt.new_string('woocommerce')])
			'template_plain': rt.call_function('__', [
				rt.new_string('Plain text template'),
				rt.new_string('woocommerce'),
			])
		}
		for var_template_type, var_title in var_templates {
			mut var_template := rt.new_string(this.get_template(rt.new_string(template_type)))
			if !rt.is_true(var_template) {
				continue
			}
			mut var_local_file := rt.new_string(this.get_theme_template_file(var_template.clone()))
			mut var_core_file := rt.new_string((this.template_base).str() + var_template.str())
			mut var_template_file := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_locate_core_template'),
				var_core_file.clone(),
				var_template.clone(),
				this.template_base,
				this.id,
			])
			mut var_template_dir := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_template_directory'),
				rt.new_string('woocommerce'),
				var_template.clone(),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_string(template_type)]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [var_title.clone()]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_function('file_exists', [var_local_file.clone()])) {
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.call_function('is_writable', [
					var_local_file.clone()]))
				{
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_url', [
						rt.call_function('wp_nonce_url', [
							rt.call_function('remove_query_arg', [
								rt.create_array([
									rt.ArrayItem{ key: none, val: 'move_template' },
									rt.ArrayItem{ key: none, val: 'saved' },
								]),
								rt.call_function('add_query_arg', [
									rt.new_string('delete_template'),
									rt.new_string(template_type),
								]),
							]),
							rt.new_string('woocommerce_email_template_nonce'),
							rt.new_string('_wc_email_nonce'),
						]),
					]))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [
						rt.new_string('Delete template file'),
						rt.new_string('woocommerce'),
					])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.call_function('esc_html__', [
						rt.new_string('This template has been overridden by your theme and can be found in: %s.'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('<code>' +
						(rt.call_function('esc_html', [rt.new_string((rt.call_function('trailingslashit', [rt.call_function('basename', [rt.call_function('get_stylesheet_directory', []rt.PhpVal{})])])).str() +
						var_template_dir.str() + '/' + var_template.str())])).str() + '</code>'),
				])
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [
					var_local_file.clone(),
				])))))
				{
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
					print((rt.call_function('esc_attr', [rt.new_string(template_type)])).str() +
						'_code')
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('file_get_contents', [var_local_file.clone()]),
				]))
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.call_function('file_exists', [
				var_template_file.clone()]))
			{
				// unsupported statement: Stmt_InlineHTML
				mut var_emails_dir := rt.new_string(
					(rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).str() + '/' +
					var_template_dir.str() + '/emails')
				mut var_templates_dir := rt.new_string(
					(rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).str() + '/' +
					var_template_dir.str())
				mut var_theme_dir := rt.call_function('get_stylesheet_directory', []rt.PhpVal{})
				if rt.is_true(rt.call_function('is_dir', [var_emails_dir.clone()])) {
					mut var_target_dir := var_emails_dir.clone()
				} else if rt.is_true(rt.call_function('is_dir', [
					var_templates_dir.clone()]))
				{
					var_target_dir = var_templates_dir.clone()
				} else {
					var_target_dir = var_theme_dir.clone()
				}
				if rt.is_true(rt.call_function('is_writable', [
					var_target_dir.clone()]))
				{
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_url', [
						rt.call_function('wp_nonce_url', [
							rt.call_function('remove_query_arg', [
								rt.create_array([
									rt.ArrayItem{ key: none, val: 'delete_template' },
									rt.ArrayItem{ key: none, val: 'saved' },
								]),
								rt.call_function('add_query_arg', [
									rt.new_string('move_template'),
									rt.new_string(template_type),
								]),
							]),
							rt.new_string('woocommerce_email_template_nonce'),
							rt.new_string('_wc_email_nonce'),
						]),
					]))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('esc_html_e', [rt.new_string('Copy file to theme'),
						rt.new_string('woocommerce')])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.call_function('esc_html__', [
						rt.new_string('To override and edit this email template copy %1$s to your theme folder: %2$s.'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('<code>' +
						(rt.call_function('esc_html', [rt.call_function('plugin_basename', [var_template_file.clone()])])).str() +
						'</code>'),
					rt.new_string('<code>' +
						(rt.call_function('esc_html', [rt.new_string((rt.call_function('trailingslashit', [rt.call_function('basename', [rt.call_function('get_stylesheet_directory', []rt.PhpVal{})])])).str() +
						var_template_dir.str() + '/' + var_template.str())])).str() + '</code>'),
				])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('file_get_contents', [var_template_file.clone()]),
				]))
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('File was not found.'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut var_handle := rt.new_string('wc-admin-settings-email')
		rt.call_function('wp_register_script', [var_handle.clone(),
			rt.new_string(''), rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
			rt.get_constant('WC_VERSION'),
			rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }])])
		rt.call_function('wp_enqueue_script', [var_handle.clone()])
		rt.call_function('wp_add_inline_script', [var_handle.clone(),
			rt.new_string(
				"jQuery( 'select.email_type' ).on( 'change', function() {\n\n\t\t\t\t\tconst val = jQuery( this ).val();\n\n\t\t\t\t\tjQuery( '.template_plain, .template_html' ).show();\n\n\t\t\t\t\tif ( val != 'multipart' && val != 'html' ) {\n\t\t\t\t\t\tjQuery('.template_html').hide();\n\t\t\t\t\t}\n\n\t\t\t\t\tif ( val != 'multipart' && val != 'plain' ) {\n\t\t\t\t\t\tjQuery('.template_plain').hide();\n\t\t\t\t\t}\n\n\t\t\t\t}).trigger( 'change' );\n\n\t\t\t\tconst view = '" +
				(rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('View template'), rt.new_string('woocommerce')])])).str() +
				"';\n\t\t\t\tconst hide = '" +
				(rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Hide template'), rt.new_string('woocommerce')])])).str() +
				"';\n\n\t\t\t\tjQuery( 'a.toggle_editor' ).text( view ).on( 'click', function() {\n\t\t\t\t\tlet label = hide;\n\n\t\t\t\t\tif ( jQuery( this ).closest(' .template' ).find( '.editor' ).is(':visible') ) {\n\t\t\t\t\t\tlabel = view;\n\t\t\t\t\t}\n\n\t\t\t\t\tjQuery( this ).text( label ).closest(' .template' ).find( '.editor' ).slideToggle();\n\t\t\t\t\treturn false;\n\t\t\t\t} );\n\n\t\t\t\tjQuery( 'a.delete_template' ).on( 'click', function() {\n\t\t\t\t\tif ( window.confirm('" + (rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Are you sure you want to delete this template file?'), rt.new_string('woocommerce')])])).str() +
				"') ) {\n\t\t\t\t\t\treturn true;\n\t\t\t\t\t}\n\n\t\t\t\t\treturn false;\n\t\t\t\t});\n\n\t\t\t\tjQuery( '.editor textarea' ).on( 'change', function() {\n\t\t\t\t\tconst name = jQuery( this ).attr( 'data-name' );\n\n\t\t\t\t\tif ( name ) {\n\t\t\t\t\t\tjQuery( this ).attr( 'name', name );\n\t\t\t\t\t}\n\t\t\t\t});")])
	}
}

fn (mut this Class_WC_Email) clear_alt_body_field() {
	mut var_phpmailer := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_phpmailer, 'PHPMailer_PHPMailer_PHPMailer'))) {
		rt.set_property(var_phpmailer, 'AltBody', rt.new_string(''))
	}
}

fn (mut this Class_WC_Email) get_option_or_transient(key string, var_empty_value rt.PhpVal) rt.PhpVal {
	mut var_option := this.get_option(rt.new_string(key), var_empty_value.clone())
	mut var_is_email_preview := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_is_email_preview'),
		rt.new_bool(false),
	])
	if rt.is_true(var_is_email_preview) {
		mut var_plugin_id := rt.get_property(rt.new_object('WC_Email', [
			'WC_Settings_API',
		], &this), 'plugin_id')
		mut var_email_id := this.id
		mut var_transient := rt.call_function('get_transient', [
			rt.new_string('${var_plugin_id.to_string()}${var_email_id.to_string()}_${var_key}'),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_transient)))) {
			var_option = if rt.is_true(var_transient) { var_transient } else { var_empty_value }
		}
	}
	return var_option.clone()
}

fn (mut this Class_WC_Email) get_block_email_html_content() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.block_email_editor_enabled)))) {
		return (rt.new_null()).str()
	}
	mut var_renderer := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer.class(),
	])
	return (rt.call_method(var_renderer, 'maybe_render_block_email', [
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])).str()
}

fn (mut this Class_WC_Email) prevent_lazy_loading_on_attachment(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	if !(this.sending) {
		return var_attributes_mutated.clone()
	}
	mut var_skip_classes := ['skip-lazy', 'no-lazyload', 'lazyload-disabled', 'no-lazy',
		'skip-lazyload']
	if var_attributes_mutated.array_isset(rt.new_string('class')) {
		mut var_classes := rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('trim'),
				rt.call_function('explode', [rt.new_string(' '),
					var_attributes_mutated.array_get(rt.new_string('class'))])]),
		])
		var_classes = rt.call_function('array_unique', [
			rt.call_function('array_merge', [var_classes.clone(),
				rt.create_array_from_list(var_skip_classes)]),
		])
		var_attributes_mutated.array_set('class', rt.call_function('implode', [
			rt.new_string(' '),
			var_classes.clone(),
		]))
	} else {
		var_attributes_mutated.array_set('class', rt.call_function('implode', [
			rt.new_string(' '),
			rt.create_array_from_list(var_skip_classes),
		]))
	}
	var_attributes_mutated.array_set('data-skip-lazy', 'true')
	return var_attributes_mutated.clone()
}

struct Class_WC_Settings_API {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_CssInliner {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter {
	rt.PhpObjectBase
}

fn create_wc_email() &Class_WC_Email {
	mut obj := &Class_WC_Email{
		PhpObjectBase:              rt.PhpObjectBase{}
		id:                         rt.new_null()
		title:                      rt.new_null()
		enabled:                    rt.new_null()
		description:                rt.new_null()
		heading:                    rt.new_string('')
		subject:                    rt.new_string('')
		template_plain:             rt.new_null()
		template_html:              rt.new_null()
		template_block:             rt.new_null()
		template_base:              rt.new_null()
		recipient:                  rt.new_null()
		cc:                         rt.new_null()
		bcc:                        rt.new_null()
		object:                     rt.new_null()
		mime_boundary:              rt.new_null()
		mime_boundary_header:       rt.new_null()
		sending:                    false
		manual:                     rt.new_bool(false)
		customer_email:             rt.new_bool(false)
		email_group:                rt.new_string('')
		plain_search:               rt.new_array()
		plain_replace:              rt.new_array()
		placeholders:               rt.new_array()
		find:                       rt.new_array()
		replace:                    rt.new_array()
		email_type:                 rt.new_null()
		email_improvements_enabled: rt.new_null()
		block_email_editor_enabled: rt.new_null()
		personalizer:               rt.new_null()
		template_block_content:     rt.new_string('emails/block/general-block-email.php')
	}
	obj.construct()
	return obj
}

fn create_wc_settings_api(_args ...rt.PhpVal) &Class_WC_Settings_API {
	mut obj := &Class_WC_Settings_API{
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

fn create_automattic_woocommerce_vendor_pelago_emogrifier_cssinliner(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_CssInliner {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_CssInliner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_htmlprocessor_htmlpruner(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_htmlprocessor_csstoattributeconverter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Email) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'handle_multipart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.handle_multipart(dispatch_arg_0)
		}
		'format_string' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_string(dispatch_arg_0)
		}
		'setup_locale' {
			this.setup_locale()
			return rt.new_null()
		}
		'restore_locale' {
			this.restore_locale()
			return rt.new_null()
		}
		'get_email_groups' {
			return this.get_email_groups()
		}
		'get_email_group_title' {
			return rt.new_string(this.get_email_group_title())
		}
		'get_default_subject' {
			return this.get_default_subject()
		}
		'get_default_heading' {
			return this.get_default_heading()
		}
		'get_default_additional_content' {
			return rt.new_string(this.get_default_additional_content())
		}
		'get_additional_content' {
			return this.get_additional_content()
		}
		'get_subject' {
			return this.get_subject()
		}
		'get_preheader' {
			return this.get_preheader()
		}
		'get_heading' {
			return this.get_heading()
		}
		'get_recipient' {
			return this.get_recipient()
		}
		'get_cc_recipient' {
			return this.get_cc_recipient()
		}
		'get_bcc_recipient' {
			return this.get_bcc_recipient()
		}
		'get_headers' {
			return this.get_headers()
		}
		'get_attachments' {
			return this.get_attachments()
		}
		'get_email_type' {
			return this.get_email_type()
		}
		'get_block_editor_email_template_content' {
			return this.get_block_editor_email_template_content()
		}
		'get_content_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_content_type(dispatch_arg_0)
		}
		'get_title' {
			return this.get_title()
		}
		'get_description' {
			return this.get_description()
		}
		'get_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_option(dispatch_arg_0, dispatch_arg_1)
		}
		'is_enabled' {
			return this.is_enabled()
		}
		'is_manual' {
			return this.is_manual()
		}
		'is_customer_email' {
			return this.is_customer_email()
		}
		'get_blogname' {
			return this.get_blogname()
		}
		'get_content' {
			return this.get_content()
		}
		'style_inline' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.style_inline(dispatch_arg_0)
		}
		'apply_inline_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.apply_inline_style(dispatch_arg_0)
		}
		'get_must_use_css_styles' {
			return rt.new_string(this.get_must_use_css_styles())
		}
		'supports_emogrifier' {
			return this.supports_emogrifier()
		}
		'get_content_plain' {
			return rt.new_string(this.get_content_plain())
		}
		'get_content_html' {
			return rt.new_string(this.get_content_html())
		}
		'get_from_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_from_name(dispatch_arg_0)
		}
		'get_from_address' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_from_address(dispatch_arg_0)
		}
		'get_reply_to_enabled' {
			return rt.new_bool(this.get_reply_to_enabled())
		}
		'get_reply_to_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_reply_to_name(dispatch_arg_0)
		}
		'get_reply_to_address' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_reply_to_address(dispatch_arg_0)
		}
		'set_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_object(dispatch_arg_0)
			return rt.new_null()
		}
		'send' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.send(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'get_cc_field' {
			return this.get_cc_field()
		}
		'get_bcc_field' {
			return this.get_bcc_field()
		}
		'get_preheader_field' {
			return this.get_preheader_field()
		}
		'get_email_type_options' {
			return this.get_email_type_options()
		}
		'process_admin_options' {
			this.process_admin_options()
			return rt.new_null()
		}
		'get_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_template(dispatch_arg_0))
		}
		'save_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.save_template(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_theme_template_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_theme_template_file(dispatch_arg_0))
		}
		'move_template_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.move_template_action(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_template_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_template_action(dispatch_arg_0)
			return rt.new_null()
		}
		'admin_actions' {
			this.admin_actions()
			return rt.new_null()
		}
		'admin_options' {
			this.admin_options()
			return rt.new_null()
		}
		'clear_alt_body_field' {
			this.clear_alt_body_field()
			return rt.new_null()
		}
		'get_option_or_transient' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_option_or_transient(dispatch_arg_0, dispatch_arg_1)
		}
		'get_block_email_html_content' {
			return rt.new_string(this.get_block_email_html_content())
		}
		'prevent_lazy_loading_on_attachment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prevent_lazy_loading_on_attachment(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Email) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'title' { return this.title }
		'enabled' { return this.enabled }
		'description' { return this.description }
		'heading' { return this.heading }
		'subject' { return this.subject }
		'template_plain' { return this.template_plain }
		'template_html' { return this.template_html }
		'template_block' { return this.template_block }
		'template_base' { return this.template_base }
		'recipient' { return this.recipient }
		'cc' { return this.cc }
		'bcc' { return this.bcc }
		'object' { return this.object }
		'mime_boundary' { return this.mime_boundary }
		'mime_boundary_header' { return this.mime_boundary_header }
		'sending' { return rt.new_bool(this.sending) }
		'manual' { return this.manual }
		'customer_email' { return this.customer_email }
		'email_group' { return this.email_group }
		'plain_search' { return this.plain_search }
		'plain_replace' { return this.plain_replace }
		'placeholders' { return this.placeholders }
		'find' { return this.find }
		'replace' { return this.replace }
		'email_type' { return this.email_type }
		'email_improvements_enabled' { return this.email_improvements_enabled }
		'block_email_editor_enabled' { return this.block_email_editor_enabled }
		'personalizer' { return this.personalizer }
		'template_block_content' { return this.template_block_content }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Email) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		'title' {
			this.title = val
			return true
		}
		'enabled' {
			this.enabled = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'heading' {
			this.heading = val
			return true
		}
		'subject' {
			this.subject = val
			return true
		}
		'template_plain' {
			this.template_plain = val
			return true
		}
		'template_html' {
			this.template_html = val
			return true
		}
		'template_block' {
			this.template_block = val
			return true
		}
		'template_base' {
			this.template_base = val
			return true
		}
		'recipient' {
			this.recipient = val
			return true
		}
		'cc' {
			this.cc = val
			return true
		}
		'bcc' {
			this.bcc = val
			return true
		}
		'object' {
			this.object = val
			return true
		}
		'mime_boundary' {
			this.mime_boundary = val
			return true
		}
		'mime_boundary_header' {
			this.mime_boundary_header = val
			return true
		}
		'sending' {
			this.sending = val.to_bool()
			return true
		}
		'manual' {
			this.manual = val
			return true
		}
		'customer_email' {
			this.customer_email = val
			return true
		}
		'email_group' {
			this.email_group = val
			return true
		}
		'plain_search' {
			this.plain_search = val
			return true
		}
		'plain_replace' {
			this.plain_replace = val
			return true
		}
		'placeholders' {
			this.placeholders = val
			return true
		}
		'find' {
			this.find = val
			return true
		}
		'replace' {
			this.replace = val
			return true
		}
		'email_type' {
			this.email_type = val
			return true
		}
		'email_improvements_enabled' {
			this.email_improvements_enabled = val
			return true
		}
		'block_email_editor_enabled' {
			this.block_email_editor_enabled = val
			return true
		}
		'personalizer' {
			this.personalizer = val
			return true
		}
		'template_block_content' {
			this.template_block_content = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Settings_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Settings_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_CssInliner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_CssInliner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_CssInliner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Email'),
		rt.new_bool(false)]))
	{
		return rt.new_null()
	}
}
