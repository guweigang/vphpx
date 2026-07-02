import rt

struct Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards.guardagainstinvalidname(name string) {
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(name.trim_space()))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException',
			[]string{},
			create_automattic_woocommerce_vendor_league_iso3166_exception_domainexception(rt.new_string('Expected string, got empty string'))))
	}
}

fn Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards.guardagainstinvalidalpha2(alpha2 string) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [
		rt.new_string('/^[a-zA-Z]{2}$/'),
		rt.new_string(alpha2),
	])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException',
			[]string{}, create_automattic_woocommerce_vendor_league_iso3166_exception_domainexception(rt.call_function('sprintf', [
			rt.new_string('Not a valid alpha2 key: %s'),
			rt.new_string(alpha2),
		]))))
	}
}

fn Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards.guardagainstinvalidalpha3(alpha3 string) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [
		rt.new_string('/^[a-zA-Z]{3}$/'),
		rt.new_string(alpha3),
	])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException',
			[]string{}, create_automattic_woocommerce_vendor_league_iso3166_exception_domainexception(rt.call_function('sprintf', [
			rt.new_string('Not a valid alpha3 key: %s'),
			rt.new_string(alpha3),
		]))))
	}
}

fn Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards.guardagainstinvalidnumeric(numeric string) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [
		rt.new_string('/^\\d{3}$/'),
		rt.new_string(numeric),
	])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException',
			[]string{}, create_automattic_woocommerce_vendor_league_iso3166_exception_domainexception(rt.call_function('sprintf', [
			rt.new_string('Not a valid numeric key: %s'),
			rt.new_string(numeric),
		]))))
	}
}

struct Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_league_iso3166_guards(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards {
	mut obj := &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_league_iso3166_exception_domainexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'guardAgainstInvalidName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards.guardagainstinvalidname(dispatch_arg_0)
			return rt.new_null()
		}
		'guardAgainstInvalidAlpha2' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards.guardagainstinvalidalpha2(dispatch_arg_0)
			return rt.new_null()
		}
		'guardAgainstInvalidAlpha3' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards.guardagainstinvalidalpha3(dispatch_arg_0)
			return rt.new_null()
		}
		'guardAgainstInvalidNumeric' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards.guardagainstinvalidnumeric(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
