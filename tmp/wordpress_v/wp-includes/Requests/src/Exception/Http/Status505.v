import rt

struct Class_WpOrg_Requests_Exception_Http_Status505 {
	rt.PhpObjectBase
pub mut:
	code   rt.PhpVal = rt.new_int(505)
	reason rt.PhpVal = rt.new_string('HTTP Version Not Supported')
}

struct Class_WpOrg_Requests_Exception_Http {
	rt.PhpObjectBase
}

fn create_wporg_requests_exception_http_status505() &Class_WpOrg_Requests_Exception_Http_Status505 {
	mut obj := &Class_WpOrg_Requests_Exception_Http_Status505{
		PhpObjectBase: rt.PhpObjectBase{}
		code:          rt.new_int(505)
		reason:        rt.new_string('HTTP Version Not Supported')
	}
	return obj
}

fn create_wporg_requests_exception_http() &Class_WpOrg_Requests_Exception_Http {
	mut obj := &Class_WpOrg_Requests_Exception_Http{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Exception_Http_Status505) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_Http_Status505) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'code' { return this.code }
		'reason' { return this.reason }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Exception_Http_Status505) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'code' {
			this.code = val
			return true
		}
		'reason' {
			this.reason = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WpOrg_Requests_Exception_Http) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_Http) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_Http) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_requests_src_exception_http_status505_php() {
}
