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
	this.email_improvements_enabled = fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		return temp.feature_is_enabled(arg_0)
	}(rt.new_string('email_improvements'))
	this.block_email_editor_enabled = fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		return temp.feature_is_enabled(arg_0)
	}(rt.new_string('block_email_editor'))
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
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		return temp.feature_is_enabled(arg_0)
	}(rt.new_string('email_improvements')))
	{
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
		'woocommerce_update_options_email_' + (this.id).str(),
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
	if rt.is_true(rt.new_bool(!(rt.is_true(this.sending)))) {
		return var_mailer_mutated.dup()
	}
	if rt.is_true(rt.identical(rt.new_string('multipart'), this.get_email_type())) {
		rt.set_property(var_mailer_mutated, 'AltBody', rt.call_function('wordwrap', [
			rt.call_function('preg_replace', [this.plain_search, this.plain_replace,
				rt.call_function('wp_strip_all_tags', [this.get_content_plain()])]),
		]))
	} else {
		rt.set_property(var_mailer_mutated, 'AltBody', rt.new_string(''))
		// unsupported statement: Stmt_Nop
	}
	this.sending = false
	return var_mailer_mutated.dup()
}

fn (mut this Class_WC_Email) format_string(var_string rt.PhpVal) rt.PhpVal {
	mut var_string_mutated := var_string
	mut var_find := rt.func_array_keys(this.placeholders)
	mut var_replace := rt.call_function('array_values', [this.placeholders])
	var_find = rt.call_function('array_merge', [rt.cast_array(this.find),
		var_find.dup()])
	var_replace = rt.call_function('array_merge', [rt.cast_array(this.replace),
		var_replace.dup()])
	var_find.array_push('{blogname}')
	var_replace.array_push(this.get_blogname())
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_email_format_string_replace')]))
		|| rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_email_format_string_find')]))))
	{
		mut var_legacy_find := this.find
		mut var_legacy_replace := this.replace
		{
			mut iter_1 := this.placeholders.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_replace_shadow := item_1.val
				mut var_find_shadow := item_1.key
				mut var_legacy_key := rt.call_function('sanitize_title', [
					rt.call_function('str_replace', [rt.new_string('_'),
						rt.new_string('-'),
						rt.new_string(var_find_shadow.dup().to_string().trim_space())]),
				])
				var_legacy_find.array_set(var_legacy_key, var_find_shadow.dup())
				var_legacy_replace.array_set(var_legacy_key, var_replace_shadow.dup())
			}
		}
		var_string_mutated = rt.call_function('str_replace', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_email_format_string_find'),
				var_legacy_find.dup(),
				rt.new_object('WC_Email', ['WC_Settings_API'], &this),
			]),
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_email_format_string_replace'),
				var_legacy_replace.dup(),
				rt.new_object('WC_Email', ['WC_Settings_API'], &this),
			]),
			var_string_mutated.dup(),
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_format_string'),
		rt.call_function('str_replace', [var_find.dup(), var_replace.dup(),
			var_string_mutated.dup()]),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Email) setup_locale() {
	mut var_switch_email_locale := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_allow_switching_email_locale'),
		rt.new_bool(true),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_switch_email_locale)
		&& rt.is_true(this.is_customer_email())))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_email_setup_locale'), rt.new_bool(true)]))))
	{
		rt.call_function('wc_switch_to_site_locale', []rt.PhpVal{})
	}
}

fn (mut this Class_WC_Email) restore_locale() {
	mut var_restore_email_locale := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_allow_restoring_email_locale'),
		rt.new_bool(true),
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_restore_email_locale)
		&& rt.is_true(this.is_customer_email())))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_email_restore_locale'), rt.new_bool(true)]))))
	{
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
		var_email_groups.dup()])
}

fn (mut this Class_WC_Email) get_email_group_title() rt.PhpVal {
	mut var_email_groups := this.get_email_groups()
	mut var_title := if var_email_groups.array_isset(this.email_group) {
		var_email_groups.array_get(this.email_group)
	} else {
		this.email_group
	}
	return
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
		'woocommerce_email_additional_content_' + (this.id).str(),
		this.format_string(this.get_option_or_transient('additional_content', rt.new_null())),
		this.object,
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Email) get_subject() rt.PhpVal {
	mut var_subject := rt.call_function('apply_filters', [
		'woocommerce_email_subject_' + (this.id).str(),
		this.format_string(this.get_option_or_transient('subject', this.get_default_subject())),
		this.object,
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
	if rt.is_true(this.block_email_editor_enabled) {
		var_subject = rt.call_function('wp_strip_all_tags', [
			rt.call_method(this.personalizer, 'personalize_transactional_content', [
				var_subject.dup(),
				rt.new_object('WC_Email', ['WC_Settings_API'], &this),
			]),
		])
	}
	return var_subject.dup()
}

fn (mut this Class_WC_Email) get_preheader() rt.PhpVal {
	mut var_preheader := rt.call_function('apply_filters', [
		'woocommerce_email_preheader' + (this.id).str(),
		this.format_string(this.get_option_or_transient('preheader', rt.new_string(''))),
		this.object,
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
	if rt.is_true(this.block_email_editor_enabled) {
		var_preheader = rt.call_method(this.personalizer, 'personalize_transactional_content', [
			var_preheader.dup(),
			rt.new_object('WC_Email', ['WC_Settings_API'], &this),
		])
	}
	return var_preheader.dup()
}

fn (mut this Class_WC_Email) get_heading() rt.PhpVal {
	return rt.call_function('apply_filters', [
		'woocommerce_email_heading_' + (this.id).str(),
		this.format_string(this.get_option_or_transient('heading', this.get_default_heading())),
		this.object,
		rt.new_object('WC_Email', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Email) get_recipient() rt.PhpVal {
	mut var_recipient := rt.call_function('apply_filters', [
		'woocommerce_email_recipient_' + (this.id).str(),
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
	var_recipients = rt.call_function('array_filter', [var_recipients.dup(),
		rt.new_string('is_email')])
	return rt.call_function('implode', [rt.new_string(', '), var_recipients.dup()])
}

fn (mut this Class_WC_Email) get_cc_recipient() rt.PhpVal {
	mut var_cc := rt.call_function('apply_filters', [
		'woocommerce_email_cc_recipient_' + (this.id).str(),
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
	var_ccs = rt.call_function('array_filter', [var_ccs.dup(),
		rt.new_string('is_email')])
	var_ccs = rt.call_function('array_map', [rt.new_string('sanitize_email'),
		var_ccs.dup()])
	return rt.call_function('implode', [rt.new_string(', '), var_ccs.dup()])
}

fn (mut this Class_WC_Email) get_bcc_recipient() rt.PhpVal {
	mut var_bcc := rt.call_function('apply_filters', [
		'woocommerce_email_bcc_recipient_' + (this.id).str(),
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
	var_bccs = rt.call_function('array_filter', [var_bccs.dup(),
		rt.new_string('is_email')])
	var_bccs = rt.call_function('array_map', [rt.new_string('sanitize_email'),
		var_bccs.dup()])
	return rt.call_function('implode', [rt.new_string(', '), var_bccs.dup()])
}

fn (mut this Class_WC_Email) get_headers() rt.PhpVal {
	mut var_header := rt.new_string('Content-Type: ' + (this.get_content_type('')).str() + '\r\n')
	if rt.is_true(rt.call_function('in_array', [this.id,
		rt.create_array([rt.ArrayItem{ key: none, val: 'new_order' },
			rt.ArrayItem{ key: none, val: 'cancelled_order' },
			rt.ArrayItem{ key: none, val: 'failed_order' }]),
		rt.new_bool(true)]))
	{
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.object)
			&& rt.is_true(rt.call_method(this.object, 'get_billing_email', []rt.PhpVal{}))))
			&& rt.is_true(rt.new_bool(rt.is_true(rt.call_method(this.object, 'get_billing_first_name', []rt.PhpVal{}))
			|| rt.is_true(rt.call_method(this.object, 'get_billing_last_name', []rt.PhpVal{}))))))
		{
			// unsupported expression: Expr_AssignOp_Concat
		}
	} else {
		mut var_reply_to_enabled := this.get_reply_to_enabled()
		mut var_reply_to_address := this.get_reply_to_address('')
		mut var_reply_to_name := this.get_reply_to_name('')
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_reply_to_enabled)
			&& !(!rt.is_true(var_reply_to_address))))
			&& rt.is_true(rt.call_function('is_email', [var_reply_to_address.dup()]))))
		{
			var_reply_to_name = if !(!rt.is_true(var_reply_to_name)) {
				var_reply_to_name
			} else {
				this.get_from_name('')
			}
			// unsupported expression: Expr_AssignOp_Concat
		} else if rt.is_true(rt.new_bool(rt.is_true(this.get_from_address(''))
			&& rt.is_true(this.get_from_name(''))))
		{
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		return temp.feature_is_enabled(arg_0)
	}(rt.new_string('email_improvements')))
	{
		mut var_cc := this.get_cc_recipient()
		if !(!rt.is_true(var_cc)) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		mut var_bcc := this.get_bcc_recipient()
		if !(!rt.is_true(var_bcc)) {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_email_headers'),
		var_header.dup(), this.id, this.object, rt.new_object('WC_Email', [
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
	return if rt.is_true(rt.new_bool(rt.is_true(var_email_type)
		&& rt.is_true(rt.call_function('class_exists', [rt.new_string('DOMDocument')]))))
	{
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
		mut var_content_type := rt.new_string()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('multipart'))) {
	} else {
	}
}

fn (mut this Class_WC_Email) get_title() rt.PhpVal {
}

fn (mut this Class_WC_Email) get_description() rt.PhpVal {
}

fn (mut this Class_WC_Email) get_option(var_key rt.PhpVal, var_empty_value rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Email) is_enabled() rt.PhpVal {
}

fn (mut this Class_WC_Email) is_manual() rt.PhpVal {
}

fn (mut this Class_WC_Email) is_customer_email() rt.PhpVal {
}

fn (mut this Class_WC_Email) get_blogname() rt.PhpVal {
}

fn (mut this Class_WC_Email) get_content() rt.PhpVal {
}

fn (mut this Class_WC_Email) style_inline(var_content rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
}

fn (mut this Class_WC_Email) apply_inline_style(var_content rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
}

fn (mut this Class_WC_Email) get_must_use_css_styles() string {
}

fn (mut this Class_WC_Email) supports_emogrifier() rt.PhpVal {
}

fn (mut this Class_WC_Email) get_content_plain() string {
}

fn (mut this Class_WC_Email) get_content_html() string {
}

fn (mut this Class_WC_Email) get_from_name(from_name string) rt.PhpVal {
	mut from_name_mutated := from_name
}

fn (mut this Class_WC_Email) get_from_address(from_email string) rt.PhpVal {
	mut from_email_mutated := from_email
}

fn (mut this Class_WC_Email) get_reply_to_enabled() rt.PhpVal {
}

fn (mut this Class_WC_Email) get_reply_to_name(reply_to_name string) rt.PhpVal {
	mut reply_to_name_mutated := reply_to_name
}

fn (mut this Class_WC_Email) get_reply_to_address(reply_to_email string) rt.PhpVal {
	mut reply_to_email_mutated := reply_to_email
}

fn (mut this Class_WC_Email) set_object(var_object rt.PhpVal) {
}

fn (mut this Class_WC_Email) send(var_to rt.PhpVal, var_subject rt.PhpVal, var_message rt.PhpVal, var_headers rt.PhpVal, var_attachments rt.PhpVal) rt.PhpVal {
	mut var_subject_mutated := var_subject
	mut var_message_mutated := var_message
}

fn (mut this Class_WC_Email) init_form_fields() {
}

fn (mut this Class_WC_Email) get_cc_field() rt.PhpVal {
}

fn (mut this Class_WC_Email) get_bcc_field() rt.PhpVal {
}

fn (mut this Class_WC_Email) get_preheader_field() rt.PhpVal {
}

fn (mut this Class_WC_Email) get_email_type_options() rt.PhpVal {
}

fn (mut this Class_WC_Email) process_admin_options() {
}

fn (mut this Class_WC_Email) get_template(var_type rt.PhpVal) string {
	mut var_type_mutated := var_type
}

fn (mut this Class_WC_Email) save_template(var_template_code rt.PhpVal, var_template_path rt.PhpVal) {
}

fn (mut this Class_WC_Email) get_theme_template_file(var_template rt.PhpVal) string {
	mut var_template_mutated := var_template
}

fn (mut this Class_WC_Email) move_template_action(var_template_type rt.PhpVal) {
}

fn (mut this Class_WC_Email) delete_template_action(var_template_type rt.PhpVal) {
}

fn (mut this Class_WC_Email) admin_actions() {
}

fn (mut this Class_WC_Email) admin_options() {
}

fn (mut this Class_WC_Email) clear_alt_body_field() {
	mut var_phpmailer := rt.new_null()
}

fn (mut this Class_WC_Email) get_option_or_transient(key string, var_empty_value rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Email) get_block_email_html_content() string {
}

fn (mut this Class_WC_Email) prevent_lazy_loading_on_attachment(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
}

struct Class_WC_Settings_API {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
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

fn create_wc_settings_api() &Class_WC_Settings_API {
	mut obj := &Class_WC_Settings_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
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
			return this.get_email_group_title()
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
			return this.get_reply_to_enabled()
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

fn init_registry() {
}

fn init() {
	init_registry()
}

pub fn init_wp_content_plugins_woocommerce_includes_emails_class_wc_email_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Email'),
		rt.new_bool(false)]))
	{
		return rt.new_null()
	}
}
