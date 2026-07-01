import rt

pub fn Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_alpha2() string {
	return 'alpha2'
}
pub fn Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_alpha3() string {
	return 'alpha3'
}
pub fn Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_numeric() string {
	return 'numeric'
}
pub fn Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_name() string {
	return 'name'
}
struct Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166 {
	rt.PhpObjectBase
pub mut:
		keys rt.PhpVal = rt.new_array()
		countries rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) construct(mut var_countries Class_Automattic_WooCommerce_Vendor_League_ISO3166_array)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.countries = var_countries.dup()
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) name(name string) rt.PhpVal {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards{}; return temp.guardagainstinvalidname(arg_0) }(rt.new_string(name))
	return this.lookup((Class_Automattic_WooCommerce_Vendor_League_ISO3166_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_name()).str(), name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) alpha2(alpha2 string) rt.PhpVal {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards{}; return temp.guardagainstinvalidalpha2(arg_0) }(rt.new_string(alpha2))
	return this.lookup((Class_Automattic_WooCommerce_Vendor_League_ISO3166_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_alpha2()).str(), alpha2)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) alpha3(alpha3 string) rt.PhpVal {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards{}; return temp.guardagainstinvalidalpha3(arg_0) }(rt.new_string(alpha3))
	return this.lookup((Class_Automattic_WooCommerce_Vendor_League_ISO3166_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_alpha3()).str(), alpha3)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) numeric(numeric string) rt.PhpVal {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards{}; return temp.guardagainstinvalidnumeric(arg_0) }(rt.new_string(numeric))
	return this.lookup((Class_Automattic_WooCommerce_Vendor_League_ISO3166_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_numeric()).str(), numeric)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) exactname(name string) rt.PhpVal {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards{}; return temp.guardagainstinvalidname(arg_0) }(rt.new_string(name))
	mut var_value := rt.call_function('mb_strtolower', [rt.new_string(name)])
	{
		mut iter_1 := this.countries.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_country := item_1.val
			mut var_comparison := rt.call_function('mb_strtolower', [var_country.array_get(Class_Automattic_WooCommerce_Vendor_League_ISO3166_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_name())])
			if rt.is_true(rt.identical(var_value, var_comparison)) {
				return var_country.dup()
			}
		}
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_League_ISO3166_Exception_OutOfBoundsException', []string{}, create_automattic_woocommerce_vendor_league_iso3166_exception_outofboundsexception(rt.call_function('sprintf', [rt.new_string('No "%s" key found matching: %s'), Class_Automattic_WooCommerce_Vendor_League_ISO3166_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166.key_name(), var_value.dup()]))))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) all() rt.PhpVal {
	return this.countries
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) iterator(key string)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(key), this.keys, rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException', []string{}, create_automattic_woocommerce_vendor_league_iso3166_exception_domainexception(rt.call_function('sprintf', [rt.new_string('Invalid value for $key, got "%s", expected one of: %s'), rt.new_string(key), rt.call_function('implode', [rt.new_string(', '), this.keys])]))))
	}
	{
		mut iter_1 := this.countries.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_country := item_1.val
			// unsupported expression: Expr_Yield
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) count() i64 {
	return this.countries.array_count()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) getiterator()  {
	{
		mut iter_1 := this.countries.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_country := item_1.val
			// unsupported expression: Expr_Yield
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) lookup(key string, value string) rt.PhpVal {
	mut value_mutated := value
	value_mutated = (rt.call_function('mb_strtolower', [rt.new_string(value_mutated).dup()])).str()
	{
		mut iter_1 := this.countries.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_country := item_1.val
			mut var_comparison := rt.call_function('mb_strtolower', [var_country.array_get(key)])
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(value_mutated), var_comparison)) || rt.is_true(rt.identical(rt.new_string(value_mutated), rt.call_function('mb_substr', [var_comparison.dup(), rt.new_int(0), rt.call_function('mb_strlen', [rt.new_string(value_mutated).dup()])]))))) {
				return var_country.dup()
			}
		}
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_League_ISO3166_Exception_OutOfBoundsException', []string{}, create_automattic_woocommerce_vendor_league_iso3166_exception_outofboundsexception(rt.call_function('sprintf', [rt.new_string('No "%s" key found matching: %s'), rt.new_string(key), rt.new_string(value_mutated).dup()]))))
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_OutOfBoundsException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_league_iso3166_iso3166(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166 {
	mut obj := &Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166{
		PhpObjectBase: rt.PhpObjectBase{}
		keys: rt.new_array()
		countries: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_league_iso3166_guards() &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards {
	mut obj := &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Guards{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_league_iso3166_exception_outofboundsexception() &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_OutOfBoundsException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_OutOfBoundsException{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_League_ISO3166_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.name(dispatch_arg_0)
		}
		'alpha2' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.alpha2(dispatch_arg_0)
		}
		'alpha3' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.alpha3(dispatch_arg_0)
		}
		'numeric' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.numeric(dispatch_arg_0)
		}
		'exactName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.exactname(dispatch_arg_0)
		}
		'all' {
			return this.all()
		}
		'iterator' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.iterator(dispatch_arg_0)
			return rt.new_null()
		}
		'count' {
			return rt.new_int(this.count())
		}
		'getIterator' {
			this.getiterator()
			return rt.new_null()
		}
		'lookup' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.lookup(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'keys' { return this.keys }
		'countries' { return this.countries }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'keys' { this.keys = val; return true }
		'countries' { this.countries = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_OutOfBoundsException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_OutOfBoundsException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_OutOfBoundsException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_league_iso3166_iso3166_php() {
	// unsupported statement: Stmt_Declare
}
