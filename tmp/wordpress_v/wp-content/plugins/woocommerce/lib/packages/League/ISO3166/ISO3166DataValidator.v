import rt

struct Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166DataValidator {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166DataValidator) validate(mut var_data Class_Automattic_WooCommerce_Vendor_League_ISO3166_array) rt.PhpVal {
	{
		mut iter_1 := var_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_entry := item_1.val
			this.assertentryhasrequiredkeys(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_League_ISO3166_array](var_entry))
		}
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_League_ISO3166_array', []string{}, var_data)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166DataValidator) assertentryhasrequiredkeys(mut var_entry Class_Automattic_WooCommerce_Vendor_League_ISO3166_array) {
	if !(var_entry.array_isset(Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_name())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException',
			[]string{},
			create_automattic_woocommerce_vendor_league_iso3166_exception_domainexception(rt.new_string('Each data entry must have a name key.'))))
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards{}
		return temp.guardagainstinvalidname(arg_0)
	}(var_entry.array_get(Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_name()))
	if !(var_entry.array_isset(Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_alpha2())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException',
			[]string{},
			create_automattic_woocommerce_vendor_league_iso3166_exception_domainexception(rt.new_string('Each data entry must have a alpha2 key.'))))
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards{}
		return temp.guardagainstinvalidalpha2(arg_0)
	}(var_entry.array_get(Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_alpha2()))
	if !(var_entry.array_isset(Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_alpha3())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException',
			[]string{},
			create_automattic_woocommerce_vendor_league_iso3166_exception_domainexception(rt.new_string('Each data entry must have a alpha3 key.'))))
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards{}
		return temp.guardagainstinvalidalpha3(arg_0)
	}(var_entry.array_get(Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_alpha3()))
	if !(var_entry.array_isset(Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_numeric())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException',
			[]string{},
			create_automattic_woocommerce_vendor_league_iso3166_exception_domainexception(rt.new_string('Each data entry must have a numeric key.'))))
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards{}
		return temp.guardagainstinvalidnumeric(arg_0)
	}(var_entry.array_get(Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_numeric()))
}

struct Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_league_iso3166_iso3166datavalidator() &Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166DataValidator {
	mut obj := &Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166DataValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_league_iso3166_exception_domainexception() &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_league_iso3166_guards() &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards {
	mut obj := &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166DataValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'validate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_League_ISO3166_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.validate(mut dispatch_arg_0)
		}
		'assertEntryHasRequiredKeys' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_League_ISO3166_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.assertentryhasrequiredkeys(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166DataValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166DataValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_league_iso3166_iso3166datavalidator_php() {
	// unsupported statement: Stmt_Declare
}
