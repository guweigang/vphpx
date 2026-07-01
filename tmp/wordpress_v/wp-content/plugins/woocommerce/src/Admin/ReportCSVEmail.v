import rt

struct Class_Automattic_WooCommerce_Admin_ReportCSVEmail {
	rt.PhpObjectBase
pub mut:
	report_labels rt.PhpVal = rt.new_null()
	report_type   rt.PhpVal = rt.new_null()
	download_url  rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVEmail) construct() {
	this.dispatch_set_prop('id', rt.new_string('admin_report_export_download'))
	this.dispatch_set_prop('template_base',
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/includes/react-admin/emails/')
	this.dispatch_set_prop('template_html', rt.new_string('html-admin-report-export-download.php'))
	this.dispatch_set_prop('template_plain',
		rt.new_string('plain-admin-report-export-download.php'))
	this.report_labels = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_report_export_email_labels'),
		rt.create_array([
			rt.ArrayItem{ key: 'categories', val: rt.call_function('__', [
				rt.new_string('Categories'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'coupons', val: rt.call_function('__', [
				rt.new_string('Coupons'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'customers', val: rt.call_function('__', [
				rt.new_string('Customers'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'downloads', val: rt.call_function('__', [
				rt.new_string('Downloads'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'orders', val: rt.call_function('__', [
				rt.new_string('Orders'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'products', val: rt.call_function('__', [
				rt.new_string('Products'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'revenue', val: rt.call_function('__', [
				rt.new_string('Revenue'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'stock', val: rt.call_function('__', [
				rt.new_string('Stock'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'taxes', val: rt.call_function('__', [
				rt.new_string('Taxes'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'variations', val: rt.call_function('__', [
				rt.new_string('Variations'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
	this.Class_Automattic_WooCommerce_Admin_WC_Email.construct()
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVEmail) init_form_fields() {
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVEmail) init_settings() {
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVEmail) get_email_type() string {
	return if rt.is_true(rt.call_function('class_exists', [rt.new_string('DOMDocument')])) {
		'html'
	} else {
		'plain'
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVEmail) get_default_heading() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Your Report Download'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVEmail) get_default_subject() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('[{site_title}]: Your {report_name} Report download is ready'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVEmail) get_content_html() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_ReportCSVEmail', [
			'Automattic_WooCommerce_Admin_WC_Email',
		], &this), 'template_html'),
		rt.create_array([
			rt.ArrayItem{ key: 'report_name', val: this.report_type },
			rt.ArrayItem{ key: 'download_url', val: this.download_url },
			rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'sent_to_admin', val: true },
			rt.ArrayItem{ key: 'plain_text', val: false },
			rt.ArrayItem{ key: 'email', val: rt.new_object('Automattic_WooCommerce_Admin_ReportCSVEmail', [
				'Automattic_WooCommerce_Admin_WC_Email',
			], &this) },
		]),
		rt.new_string(''),
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_ReportCSVEmail', [
			'Automattic_WooCommerce_Admin_WC_Email',
		], &this), 'template_base'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVEmail) get_content_plain() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_ReportCSVEmail', [
			'Automattic_WooCommerce_Admin_WC_Email',
		], &this), 'template_plain'),
		rt.create_array([
			rt.ArrayItem{ key: 'report_name', val: this.report_type },
			rt.ArrayItem{ key: 'download_url', val: this.download_url },
			rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'sent_to_admin', val: true },
			rt.ArrayItem{ key: 'plain_text', val: true },
			rt.ArrayItem{ key: 'email', val: rt.new_object('Automattic_WooCommerce_Admin_ReportCSVEmail', [
				'Automattic_WooCommerce_Admin_WC_Email',
			], &this) },
		]),
		rt.new_string(''),
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_ReportCSVEmail', [
			'Automattic_WooCommerce_Admin_WC_Email',
		], &this), 'template_base'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVEmail) trigger(var_user_id rt.PhpVal, var_report_type rt.PhpVal, var_download_url rt.PhpVal) {
	mut var_user := create_automattic_woocommerce_admin_wp_user(var_user_id.dup())
	this.dispatch_set_prop('recipient', rt.get_property(var_user, 'user_email'))
	this.download_url = var_download_url.dup()
	if this.report_labels.array_isset(var_report_type) {
		this.report_type = this.report_labels.array_get(var_report_type)
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_ReportCSVEmail', [
			'Automattic_WooCommerce_Admin_WC_Email',
		], &this), 'placeholders').array_set('{report_name}', this.report_type)
	}
	this.send(this.get_recipient(), this.get_subject(), this.get_content(), this.get_headers(),
		this.get_attachments())
}

struct Class_Automattic_WooCommerce_Admin_WC_Email {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_WP_User {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_reportcsvemail() &Class_Automattic_WooCommerce_Admin_ReportCSVEmail {
	mut obj := &Class_Automattic_WooCommerce_Admin_ReportCSVEmail{
		PhpObjectBase: rt.PhpObjectBase{}
		report_labels: rt.new_null()
		report_type:   rt.new_null()
		download_url:  rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_wc_email() &Class_Automattic_WooCommerce_Admin_WC_Email {
	mut obj := &Class_Automattic_WooCommerce_Admin_WC_Email{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_wp_user() &Class_Automattic_WooCommerce_Admin_WP_User {
	mut obj := &Class_Automattic_WooCommerce_Admin_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVEmail) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'init_settings' {
			this.init_settings()
			return rt.new_null()
		}
		'get_email_type' {
			return rt.new_string(this.get_email_type())
		}
		'get_default_heading' {
			return this.get_default_heading()
		}
		'get_default_subject' {
			return this.get_default_subject()
		}
		'get_content_html' {
			return this.get_content_html()
		}
		'get_content_plain' {
			return this.get_content_plain()
		}
		'trigger' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.trigger(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_ReportCSVEmail) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'report_labels' { return this.report_labels }
		'report_type' { return this.report_type }
		'download_url' { return this.download_url }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVEmail) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'report_labels' {
			this.report_labels = val
			return true
		}
		'report_type' {
			this.report_type = val
			return true
		}
		'download_url' {
			this.download_url = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_WC_Email) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_WC_Email) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WC_Email) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_admin_reportcsvemail_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Email'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/emails/class-wc-email.php',
			'2')
	}
}
