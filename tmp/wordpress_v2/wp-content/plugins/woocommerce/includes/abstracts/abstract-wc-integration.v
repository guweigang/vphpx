import rt

struct Class_WC_Integration {
	rt.PhpObjectBase
pub mut:
	enabled            string
	method_title       rt.PhpVal = rt.new_string('')
	method_description rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WC_Integration) get_method_title() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_integration_title'),
		this.method_title,
		rt.new_object('WC_Integration', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Integration) get_method_description() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_integration_description'),
		this.method_description,
		rt.new_object('WC_Integration', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Integration) admin_options() {
	print('<h2>' + (rt.call_function('esc_html', [this.get_method_title()])).str() + '</h2>')
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('wpautop', [this.get_method_description()]),
	]))
	print('<div><input type="hidden" name="section" value="' +
		(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Integration', ['WC_Settings_API'], &this), 'id')])).str() +
		'" /></div>')
	this.Class_WC_Settings_API.admin_options()
}

fn (mut this Class_WC_Integration) init_settings() {
	this.Class_WC_Settings_API.init_settings()
	this.enabled = if
		!(!rt.is_true(rt.get_property(rt.new_object('WC_Integration', ['WC_Settings_API'], &this), 'settings').array_get(rt.new_string('enabled'))))
		&& rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(rt.new_object('WC_Integration', ['WC_Settings_API'], &this), 'settings').array_get(rt.new_string('enabled')))) {
		'yes'
	} else {
		'no'
	}
}

struct Class_WC_Settings_API {
	rt.PhpObjectBase
}

fn create_wc_integration(_args ...rt.PhpVal) &Class_WC_Integration {
	mut obj := &Class_WC_Integration{
		PhpObjectBase:      rt.PhpObjectBase{}
		enabled:            ''
		method_title:       rt.new_string('')
		method_description: rt.new_string('')
	}
	return obj
}

fn create_wc_settings_api(_args ...rt.PhpVal) &Class_WC_Settings_API {
	mut obj := &Class_WC_Settings_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Integration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_method_title' {
			return this.get_method_title()
		}
		'get_method_description' {
			return this.get_method_description()
		}
		'admin_options' {
			this.admin_options()
			return rt.new_null()
		}
		'init_settings' {
			this.init_settings()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Integration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'enabled' { return rt.new_string(this.enabled) }
		'method_title' { return this.method_title }
		'method_description' { return this.method_description }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Integration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'enabled' {
			this.enabled = val.str()
			return true
		}
		'method_title' {
			this.method_title = val
			return true
		}
		'method_description' {
			this.method_description = val
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
}
