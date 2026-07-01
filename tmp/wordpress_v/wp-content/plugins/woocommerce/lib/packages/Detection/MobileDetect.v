import rt

pub fn Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.ver() string {
	return '([\\w._\\+]+)'
}
pub fn Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.version() string {
	return '3.74.3'
}
pub fn Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.version_type_string() string {
	return 'text'
}
pub fn Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.version_type_float() string {
	return 'float'
}
struct Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect {
	rt.PhpObjectBase
pub mut:
		cache rt.PhpVal = rt.new_array()
		userAgent rt.PhpVal = rt.new_null()
		httpHeaders rt.PhpVal = rt.new_array()
		cloudfrontHeaders rt.PhpVal = rt.new_array()
		matchingRegex rt.PhpVal = rt.new_null()
		matchesArray rt.PhpVal = rt.new_null()
		mobileHeaders rt.PhpVal = rt.new_array()
		phoneDevices rt.PhpVal = rt.new_array()
		tabletDevices rt.PhpVal = rt.new_array()
		operatingSystems rt.PhpVal = rt.new_array()
		browsers rt.PhpVal = rt.new_array()
		uaHttpHeaders rt.PhpVal = rt.new_array()
		properties rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) construct(mut var_headers Class_Automattic_WooCommerce_Vendor_Detection_?array, mut var_userAgent Class_Automattic_WooCommerce_Vendor_Detection_?string)  {
	mut var_userAgent_mutated := var_userAgent
	this.sethttpheaders(mut var_headers)
	this.setuseragent(mut var_userAgent_mutated)
}

fn Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.getscriptversion() string {
	return (Class_Automattic_WooCommerce_Vendor_Detection_Automattic_WooCommerce_Vendor_Detection_MobileDetect.version()).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) sethttpheaders(mut var_httpHeaders Class_Automattic_WooCommerce_Vendor_Detection_?array)  {
	mut var_httpHeaders_mutated := var_httpHeaders
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_httpHeaders_mutated.dup().is_array()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_httpHeaders_mutated.dup().array_count()))))))) {
		var_httpHeaders_mutated = rt.get_superglobal('_SERVER')
	}
	this.httpHeaders = rt.new_array()
	{
		mut iter_1 := var_httpHeaders_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(rt.call_function('substr', [var_key.dup(), rt.new_int(0), rt.new_int(5)]), rt.new_string('HTTP_'))) {
				this.httpHeaders.array_set(var_key, var_value.dup())
			}
		}
	}
	this.setcfheaders(mut var_httpHeaders_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) gethttpheaders() rt.PhpVal {
	return this.httpHeaders
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) gethttpheader(header string) string {
	mut header_mutated := header
	if rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(header_mutated).dup(), rt.new_string('_')]), rt.new_bool(false))) {
		header_mutated = (rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), rt.new_string(header_mutated).dup()])).str()
		header_mutated = header_mutated.to_upper()
	}
	mut var_altHeader := rt.new_string('HTTP_' + header_mutated)
	if this.httpHeaders.array_isset(rt.new_string(header_mutated)) {
		return (this.httpHeaders.array_get(header_mutated)).str()
	} else if this.httpHeaders.array_isset(var_altHeader) {
		return (this.httpHeaders.array_get(var_altHeader)).str()
	}
	return (rt.new_null()).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) getmobileheaders() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) getuahttpheaders() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) setcfheaders(mut var_cfHeaders Class_Automattic_WooCommerce_Vendor_Detection_?array) bool {
	mut var_cfHeaders_mutated := var_cfHeaders
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cfHeaders_mutated.dup().is_array()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_cfHeaders_mutated.dup().array_count()))))))) {
		var_cfHeaders_mutated = rt.get_superglobal('_SERVER')
	}
	this.cloudfrontHeaders = rt.new_array()
	mut var_response := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_cfHeaders_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(rt.call_function('substr', [rt.new_string(var_key.dup().to_string().to_lower()), rt.new_int(0), rt.new_int(16)]), rt.new_string('http_cloudfront_'))) {
				this.cloudfrontHeaders.array_set(var_key.dup().to_string().to_upper(), var_value.dup())
				var_response = rt.new_bool(rt.new_bool(true))
			}
		}
	}
	return (var_response).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) getcfheaders() rt.PhpVal {
	return this.cloudfrontHeaders
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) prepareuseragent(userAgent string) string {
	mut userAgent_mutated := userAgent
	userAgent_mutated = userAgent_mutated.trim_space()
	return (rt.call_function('substr', [rt.new_string(userAgent_mutated).dup(), rt.new_int(0), rt.new_int(500)])).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) setuseragent(mut var_userAgent Class_Automattic_WooCommerce_Vendor_Detection_?string) string {
	mut var_userAgent_mutated := var_userAgent
	this.cache = rt.new_array()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(!rt.is_true(var_userAgent_mutated)))) {
		return (this.userAgent = this.prepareuseragent(var_userAgent_mutated)).str()
	} else {
		this.userAgent = rt.new_null()
		{
			mut iter_1 := this.getuahttpheaders().iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_altHeader := item_1.val
				if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(!rt.is_true(this.httpHeaders.array_get(var_altHeader))))) {
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
		}
		if !(!rt.is_true(this.userAgent)) {
			return (this.userAgent = this.prepareuseragent((this.userAgent).str())).str()
		}
	}
	if this.getcfheaders().array_count() > 0 {
		return (this.userAgent = rt.new_string('Amazon CloudFront')).str()
	}
	return (this.userAgent = rt.new_null()).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) getuseragent() string {
	return (this.userAgent).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) getmatchingregex() string {
	return (this.matchingRegex).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) getmatchesarray() rt.PhpVal {
	return this.matchesArray
}

fn Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.getphonedevices() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.gettabletdevices() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.getuseragents() rt.PhpVal {
	return Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.getbrowsers()
}

fn Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.getbrowsers() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) getrules() rt.PhpVal {
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(!(rt.is_true(var_rules)))) {
		mut var_rules := rt.call_function('array_merge', [// unsupported expression: Expr_StaticPropertyFetch, // unsupported expression: Expr_StaticPropertyFetch, // unsupported expression: Expr_StaticPropertyFetch, // unsupported expression: Expr_StaticPropertyFetch])
	}
	return var_rules.dup()
}

fn Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.getoperatingsystems() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) checkhttpheadersformobile() bool {
	{
		mut iter_1 := this.getmobileheaders().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_matchType := item_1.val
			mut var_mobileHeader := item_1.key
			if this.httpHeaders.array_isset(var_mobileHeader) {
				if rt.is_true(rt.new_bool(var_matchType.array_isset(rt.new_string('matches')) && rt.is_true(rt.new_bool(var_matchType.array_get('matches').is_array())))) {
					{
						mut iter_2 := var_matchType.array_get('matches').iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var__match := item_2.val
							if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
								return true
							}
						}
					}
					return false
				} else {
					return true
				}
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) magic_call(name string, mut var_arguments Class_Automattic_WooCommerce_Vendor_Detection_array) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('BadMethodCallException', []string{}, create_badmethodcallexception(rt.new_string("No such method exists: ${var_name}"))))
	}
	mut var_key := rt.call_function('substr', [rt.new_string(name), rt.new_int(2)])
	return rt.new_bool(this.matchuaagainstkey((var_key).str()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) matchdetectionrulesagainstua(mut var_userAgent Class_Automattic_WooCommerce_Vendor_Detection_?string) bool {
	mut var_userAgent_mutated := var_userAgent
	{
		mut iter_1 := this.getrules().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var__regex := item_1.val
			if !rt.is_true(var__regex) {
				continue
			}
			if this.match((var__regex).str(), mut var_userAgent_mutated) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) matchuaagainstkey(key string) bool {
	mut key_mutated := key
	key_mutated = key_mutated.to_lower()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(this.cache.array_isset(rt.new_string(key_mutated))))) {
		mut var__rules := rt.call_function('array_change_key_case', [this.getrules()])
		if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(!rt.is_true(var__rules.array_get(key_mutated))))) {
			this.cache.array_set(key_mutated, this.match((var__rules.array_get(key_mutated)).str(), rt.new_null()))
		}
		if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(this.cache.array_isset(rt.new_string(key_mutated))))) {
			this.cache.array_set(key_mutated, false)
		}
	}
	return (this.cache.array_get(key_mutated)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) ismobile(mut var_userAgent Class_Automattic_WooCommerce_Vendor_Detection_?string, mut var_httpHeaders Class_Automattic_WooCommerce_Vendor_Detection_?array) bool {
	mut var_userAgent_mutated := var_userAgent
	mut var_httpHeaders_mutated := var_httpHeaders
	if rt.is_true(var_httpHeaders_mutated) {
		this.sethttpheaders(mut var_httpHeaders_mutated)
	}
	if rt.is_true(var_userAgent_mutated) {
		this.setuseragent(mut var_userAgent_mutated)
	}
	if rt.is_true(rt.identical(this.getuseragent(), rt.new_string('Amazon CloudFront'))) {
		mut var_cfHeaders := this.getcfheaders()
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_cfHeaders.dup().array_isset(rt.new_string('HTTP_CLOUDFRONT_IS_MOBILE_VIEWER')))) && rt.is_true(rt.identical(var_cfHeaders.array_get('HTTP_CLOUDFRONT_IS_MOBILE_VIEWER'), rt.new_string('true'))))) {
			return true
		}
	}
	if this.checkhttpheadersformobile() {
		return true
	} else {
		return this.matchdetectionrulesagainstua(rt.new_null())
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) istablet(mut var_userAgent Class_Automattic_WooCommerce_Vendor_Detection_?string, mut var_httpHeaders Class_Automattic_WooCommerce_Vendor_Detection_?array) bool {
	mut var_userAgent_mutated := var_userAgent
	mut var_httpHeaders_mutated := var_httpHeaders
	if rt.is_true(rt.identical(this.getuseragent(), rt.new_string('Amazon CloudFront'))) {
		mut var_cfHeaders := this.getcfheaders()
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_cfHeaders.dup().array_isset(rt.new_string('HTTP_CLOUDFRONT_IS_TABLET_VIEWER')))) && rt.is_true(rt.identical(var_cfHeaders.array_get('HTTP_CLOUDFRONT_IS_TABLET_VIEWER'), rt.new_string('true'))))) {
			return true
		}
	}
	{
		mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var__regex := item_1.val
			if this.match((var__regex).str(), mut var_userAgent_mutated) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) is(key string, mut var_userAgent Class_Automattic_WooCommerce_Vendor_Detection_?string, mut var_httpHeaders Class_Automattic_WooCommerce_Vendor_Detection_?array) bool {
	mut key_mutated := key
	mut var_userAgent_mutated := var_userAgent
	mut var_httpHeaders_mutated := var_httpHeaders
	if rt.is_true(var_httpHeaders_mutated) {
		this.sethttpheaders(mut var_httpHeaders_mutated)
	}
	if rt.is_true(var_userAgent_mutated) {
		this.setuseragent(mut var_userAgent_mutated)
	}
	return this.matchuaagainstkey(key_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) match(regex string, mut var_userAgent Class_Automattic_WooCommerce_Vendor_Detection_?string) bool {
	mut var_matches := rt.new_null()
	mut var_userAgent_mutated := var_userAgent
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_userAgent_mutated.dup().is_string()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.userAgent.is_string()))))))) {
		return false
	}
	mut var_match := // unsupported expression: Expr_Cast_Bool
	if rt.is_true(var_match) {
		this.matchingRegex = rt.new_string(regex).dup()
		this.matchesArray = var_matches.dup()
	}
	return (var_match).to_bool()
}

fn Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.getproperties() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) prepareversionno(ver string) f64 {
	mut ver_mutated := ver
	ver_mutated = (rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '_' }, rt.ArrayItem{ key: none, val: ' ' }, rt.ArrayItem{ key: none, val: '/' }]), rt.new_string('.'), rt.new_string(ver_mutated).dup()])).str()
	mut var_arrVer := rt.call_function('explode', [rt.new_string('.'), rt.new_string(ver_mutated).dup(), rt.new_int(2)])
	if var_arrVer.array_isset(rt.new_int(1)) {
		var_arrVer.array_set(1, rt.call_function('str_replace', [rt.new_string('.'), rt.new_string(''), var_arrVer.array_get(1)]))
		// unsupported statement: Stmt_Nop
	}
	return (// unsupported expression: Expr_Cast_Double).to_f64()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) version(propertyName string, type string) bool {
	mut var_match := rt.new_null()
	mut type_mutated := type
	if propertyName == '' {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.userAgent.is_string()))))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		type_mutated = (Class_Automattic_WooCommerce_Vendor_Detection_Automattic_WooCommerce_Vendor_Detection_MobileDetect.version_type_string()).str()
	}
	mut var_properties := Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.getproperties()
	if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(var_properties.array_isset(rt.new_string(propertyName))))) {
		var_properties.array_set(propertyName, rt.cast_array())
		{
			mut iter_1 := .array_get().iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_propertyMatchString := item_1.val
				
			}
		}
	}
	return 
}

struct Class_BadMethodCallException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_detection_mobiledetect(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect{
		PhpObjectBase: rt.PhpObjectBase{}
		cache: rt.new_array()
		userAgent: rt.new_null()
		httpHeaders: rt.new_array()
		cloudfrontHeaders: rt.new_array()
		matchingRegex: rt.new_null()
		matchesArray: rt.new_null()
		mobileHeaders: rt.new_array()
		phoneDevices: rt.new_array()
		tabletDevices: rt.new_array()
		operatingSystems: rt.new_array()
		browsers: rt.new_array()
		uaHttpHeaders: rt.new_array()
		properties: rt.new_array()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_badmethodcallexception() &Class_BadMethodCallException {
	mut obj := &Class_BadMethodCallException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Detection_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Detection_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'getScriptVersion' {
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.getscriptversion())
		}
		'setHttpHeaders' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Detection_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.sethttpheaders(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getHttpHeaders' {
			return this.gethttpheaders()
		}
		'getHttpHeader' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.gethttpheader(dispatch_arg_0))
		}
		'getMobileHeaders' {
			return this.getmobileheaders()
		}
		'getUaHttpHeaders' {
			return this.getuahttpheaders()
		}
		'setCfHeaders' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Detection_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.setcfheaders(mut dispatch_arg_0))
		}
		'getCfHeaders' {
			return this.getcfheaders()
		}
		'prepareUserAgent' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.prepareuseragent(dispatch_arg_0))
		}
		'setUserAgent' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Detection_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.setuseragent(mut dispatch_arg_0))
		}
		'getUserAgent' {
			return rt.new_string(this.getuseragent())
		}
		'getMatchingRegex' {
			return rt.new_string(this.getmatchingregex())
		}
		'getMatchesArray' {
			return this.getmatchesarray()
		}
		'getPhoneDevices' {
			return Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.getphonedevices()
		}
		'getTabletDevices' {
			return Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.gettabletdevices()
		}
		'getUserAgents' {
			return Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.getuseragents()
		}
		'getBrowsers' {
			return Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.getbrowsers()
		}
		'getRules' {
			return this.getrules()
		}
		'getOperatingSystems' {
			return Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.getoperatingsystems()
		}
		'checkHttpHeadersForMobile' {
			return rt.new_bool(this.checkhttpheadersformobile())
		}
		'__call' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Detection_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.magic_call(dispatch_arg_0, mut dispatch_arg_1)
		}
		'matchDetectionRulesAgainstUA' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Detection_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.matchdetectionrulesagainstua(mut dispatch_arg_0))
		}
		'matchUAAgainstKey' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.matchuaagainstkey(dispatch_arg_0))
		}
		'isMobile' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Detection_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Detection_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.ismobile(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'isTablet' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Detection_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Detection_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.istablet(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'is' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Detection_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Detection_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.is(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'match' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Detection_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.match(dispatch_arg_0, mut dispatch_arg_1))
		}
		'getProperties' {
			return Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect.getproperties()
		}
		'prepareVersionNo' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_float(this.prepareversionno(dispatch_arg_0))
		}
		'version' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.version(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache' { return this.cache }
		'userAgent' { return this.userAgent }
		'httpHeaders' { return this.httpHeaders }
		'cloudfrontHeaders' { return this.cloudfrontHeaders }
		'matchingRegex' { return this.matchingRegex }
		'matchesArray' { return this.matchesArray }
		'mobileHeaders' { return this.mobileHeaders }
		'phoneDevices' { return this.phoneDevices }
		'tabletDevices' { return this.tabletDevices }
		'operatingSystems' { return this.operatingSystems }
		'browsers' { return this.browsers }
		'uaHttpHeaders' { return this.uaHttpHeaders }
		'properties' { return this.properties }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Detection_MobileDetect) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cache' { this.cache = val; return true }
		'userAgent' { this.userAgent = val; return true }
		'httpHeaders' { this.httpHeaders = val; return true }
		'cloudfrontHeaders' { this.cloudfrontHeaders = val; return true }
		'matchingRegex' { this.matchingRegex = val; return true }
		'matchesArray' { this.matchesArray = val; return true }
		'mobileHeaders' { this.mobileHeaders = val; return true }
		'phoneDevices' { this.phoneDevices = val; return true }
		'tabletDevices' { this.tabletDevices = val; return true }
		'operatingSystems' { this.operatingSystems = val; return true }
		'browsers' { this.browsers = val; return true }
		'uaHttpHeaders' { this.uaHttpHeaders = val; return true }
		'properties' { this.properties = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_BadMethodCallException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_BadMethodCallException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_BadMethodCallException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_detection_mobiledetect_php() {
}
