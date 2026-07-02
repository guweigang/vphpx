import rt

struct Class_WC_SmoothGenerator_Generator_CustomerInfo {
	rt.PhpObjectBase
}

fn Class_WC_SmoothGenerator_Generator_CustomerInfo.get_valid_country_code(mut var_country_code Class_WC_SmoothGenerator_Generator_?string) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
	var_country_code_mutated = rt.new_string((if !(!rt.is_true(var_country_code_mutated)) { var_country_code_mutated.to_string().to_upper() } else { '' }).str())
	if rt.is_true(var_country_code_mutated) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'country_exists', [var_country_code_mutated]))))) {
	var_country_code_mutated = create_wc_smoothgenerator_generator_wp_error(rt.new_string('smoothgenerator_customer_invalid_country'), rt.call_function('sprintf', [rt.new_string('No data for a country with country code "%s"'), rt.call_function('esc_html', [var_country_code_mutated])]))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_country_code_mutated)))) {
	mut var_valid_countries := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_allowed_countries', []rt.PhpVal{})
	var_country_code_mutated = rt.call_function('array_rand', [var_valid_countries.clone()])
	}
	return rt.new_object('WC_SmoothGenerator_Generator_?string', []string{}, var_country_code_mutated)
}

fn Class_WC_SmoothGenerator_Generator_CustomerInfo.get_country_locale_info(country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	mut var_all_locale_info := rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/i18n/locale-info.php', '1')
	if !(var_all_locale_info.array_isset(rt.new_string(country_code_mutated))) {
		return rt.new_array()
	}
	return var_all_locale_info.array_get(rt.new_string(country_code_mutated))
}

fn Class_WC_SmoothGenerator_Generator_CustomerInfo.get_faker(country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	mut var_locale_info := Class_WC_SmoothGenerator_Generator_CustomerInfo.get_country_locale_info(country_code_mutated)
	mut var_default_locale := if !(!rt.is_true(var_locale_info.array_get(rt.new_string('default_locale')))) { var_locale_info.array_get(rt.new_string('default_locale')) } else { rt.new_string('en_US') }
	mut iife_temp_0 := Class_WC_SmoothGenerator_Generator_Faker_Factory{}
	mut iife_result_0 := iife_temp_0.create(var_default_locale.clone())
	mut var_faker := iife_result_0
	return var_faker.clone()
}

fn Class_WC_SmoothGenerator_Generator_CustomerInfo.get_provider_instance(mut var_faker Class_WC_SmoothGenerator_Generator_Faker_Generator, provider_name string) rt.PhpVal {
	mut var_faker_mutated := var_faker
	mut var_instance := rt.new_null()
	mut iter_1 := rt.call_method(var_faker_mutated, 'getProviders', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_provider := item_1.val
		if rt.is_true(rt.call_function('str_ends_with', [rt.call_function('get_class', [var_provider.clone()]), rt.new_string(provider_name)])) {
			var_instance = var_provider
			break
		}
	}
	return var_instance.clone()
}

fn Class_WC_SmoothGenerator_Generator_CustomerInfo.generate_person(country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	country_code_mutated = (Class_WC_SmoothGenerator_Generator_CustomerInfo.get_valid_country_code(mut country_code_mutated)).str()
	if rt.is_true(rt.call_function('is_wp_error', [rt.new_string(country_code_mutated).clone()])) {
		return rt.new_string(country_code_mutated)
	}
	mut var_faker := Class_WC_SmoothGenerator_Generator_CustomerInfo.get_faker(country_code_mutated)
	mut var_first_name := rt.call_method(var_faker, 'firstName', [rt.call_method(var_faker, 'randomElement', [rt.create_array([rt.ArrayItem{ key: none, val: 'male' }, rt.ArrayItem{ key: none, val: 'female' }])])])
	mut var_last_name := rt.call_method(var_faker, 'lastName', []rt.PhpVal{})
	if rt.is_true(rt.less(rt.call_method(var_faker, 'randomDigit', []rt.PhpVal{}), rt.new_int(3))) {
	var_first_name = rt.new_string(var_first_name.clone().to_string().to_lower())
	var_last_name = rt.new_string(var_last_name.clone().to_string().to_lower())
	}
	mut var_person := rt.create_array([rt.ArrayItem{ key: 'first_name', val: var_first_name }, rt.ArrayItem{ key: 'last_name', val: var_last_name }, rt.ArrayItem{ key: 'password', val: 'password' }])
	mut var_person_provider := Class_WC_SmoothGenerator_Generator_CustomerInfo.get_provider_instance(mut rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_Faker_Generator](var_faker), 'Person')
	mut var_reflected_provider := create_wc_smoothgenerator_generator_reflectionclass(var_person_provider.clone())
	mut var_orig_fn_male := var_reflected_provider.getstaticpropertyvalue(rt.new_string('firstNameMale'), rt.new_array())
	mut var_orig_fn_female := var_reflected_provider.getstaticpropertyvalue(rt.new_string('firstNameFemale'), rt.new_array())
	mut var_orig_ln := var_reflected_provider.getstaticpropertyvalue(rt.new_string('lastName'), rt.new_array())
	var_reflected_provider.setstaticpropertyvalue(rt.new_string('firstNameMale'), rt.create_array([rt.ArrayItem{ key: none, val: var_first_name }]))
	var_reflected_provider.setstaticpropertyvalue(rt.new_string('firstNameFemale'), rt.create_array([rt.ArrayItem{ key: none, val: var_first_name }]))
	var_reflected_provider.setstaticpropertyvalue(rt.new_string('lastName'), rt.create_array([rt.ArrayItem{ key: none, val: var_last_name }]))
	var_person.array_set('display_name', rt.call_method(var_faker, 'name', []rt.PhpVal{}))
	rt.call_method(var_faker, 'safeEmail', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_faker, 'userName', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WC_SmoothGenerator_Generator_Exception') {
		mut var_e := var_e_1.clone()
		var_faker = Class_WC_SmoothGenerator_Generator_CustomerInfo.get_faker()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	for {
		var_person.array_set('email', rt.call_method(var_faker, 'safeEmail', []rt.PhpVal{}))
		if !(rt.is_true(rt.call_function('email_exists', [var_person.array_get(rt.new_string('email'))]))) {
			break
		}
	}
	for {
		var_person.array_set('username', rt.call_method(var_faker, 'userName', []rt.PhpVal{}))
		if !(rt.is_true(rt.call_function('username_exists', [var_person.array_get(rt.new_string('username'))]))) {
			break
		}
	}
	var_reflected_provider.setstaticpropertyvalue(rt.new_string('firstNameMale'), var_orig_fn_male.clone())
	var_reflected_provider.setstaticpropertyvalue(rt.new_string('firstNameFemale'), var_orig_fn_female.clone())
	var_reflected_provider.setstaticpropertyvalue(rt.new_string('lastName'), var_orig_ln.clone())
	return var_person.clone()
}

fn Class_WC_SmoothGenerator_Generator_CustomerInfo.generate_company(country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	country_code_mutated = (Class_WC_SmoothGenerator_Generator_CustomerInfo.get_valid_country_code(mut country_code_mutated)).str()
	if rt.is_true(rt.call_function('is_wp_error', [rt.new_string(country_code_mutated).clone()])) {
		return rt.new_string(country_code_mutated)
	}
	mut var_faker := Class_WC_SmoothGenerator_Generator_CustomerInfo.get_faker(country_code_mutated)
	mut var_last_names := rt.new_array()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(3)))) { break }
		var_last_names.array_push(rt.call_method(rt.call_method(var_faker, 'unique', []rt.PhpVal{}), 'lastName', []rt.PhpVal{}))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		unsafe { goto end_label_2 }

catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'WC_SmoothGenerator_Generator_OverflowException') {
			mut var_e := var_e_2.clone()
			var_last_names.array_push(rt.call_method(rt.call_method(var_faker, 'unique', [rt.new_bool(true)]), 'lastName', []rt.PhpVal{}))
			unsafe { goto end_label_2 }
		}
		else {
			rt.throw_exception(var_e_2)
			unsafe { goto end_label_2 }
		}

end_label_2:
		rt.post_inc(var_i)
	}
	if rt.is_true(rt.less(rt.call_method(var_faker, 'randomDigit', []rt.PhpVal{}), rt.new_int(3))) {
	var_last_names = rt.call_function('array_map', [rt.new_string('strtolower'), var_last_names.clone()])
	}
	mut var_person_provider := Class_WC_SmoothGenerator_Generator_CustomerInfo.get_provider_instance(mut rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_Faker_Generator](var_faker), 'Person')
	mut var_reflected_provider := create_wc_smoothgenerator_generator_reflectionclass(var_person_provider.clone())
	mut var_orig_ln := var_reflected_provider.getstaticpropertyvalue(rt.new_string('lastName'), rt.new_array())
	var_reflected_provider.setstaticpropertyvalue(rt.new_string('lastName'), var_last_names.clone())
	mut var_company := rt.create_array([rt.ArrayItem{ key: 'company', val: rt.call_method(var_faker, 'company', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'password', val: 'password' }])
	var_company.array_set('display_name', var_company.array_get(rt.new_string('company')))
	var_reflected_provider.setstaticpropertyvalue(rt.new_string('lastName'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_faker, 'randomElement', [var_last_names.clone()]) }]))
	for {
		var_company.array_set('email', rt.call_method(var_faker, 'companyEmail', []rt.PhpVal{}))
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		unsafe { goto end_label_3 }

catch_label_3:
		mut var_e_3 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_3, 'WC_SmoothGenerator_Generator_Exception') {
			mut var_e := var_e_3.clone()
			mut var_default_faker := Class_WC_SmoothGenerator_Generator_CustomerInfo.get_faker()
			var_company.array_set('email', rt.call_method(var_default_faker, 'email', []rt.PhpVal{}))
			unsafe { goto end_label_3 }
		}
		else {
			rt.throw_exception(var_e_3)
			unsafe { goto end_label_3 }
		}

end_label_3:
		if !(rt.is_true(rt.call_function('email_exists', [var_company.array_get(rt.new_string('email'))]))) {
			break
		}
	}
	for {
		var_company.array_set('username', (rt.call_method(var_faker, 'domainWord', []rt.PhpVal{})).str() + (rt.call_method(rt.call_method(var_faker, 'optional', []rt.PhpVal{}), 'randomNumber', [rt.new_int(2)])).str())
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		unsafe { goto end_label_4 }

catch_label_4:
		mut var_e_4 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_4, 'WC_SmoothGenerator_Generator_Exception') {
			var_e = var_e_4.clone()
			var_default_faker = Class_WC_SmoothGenerator_Generator_CustomerInfo.get_faker()
			var_company.array_set('username', rt.call_method(var_default_faker, 'userName', []rt.PhpVal{}))
			unsafe { goto end_label_4 }
		}
		else {
			rt.throw_exception(var_e_4)
			unsafe { goto end_label_4 }
		}

end_label_4:
		if !(rt.is_true(rt.call_function('username_exists', [var_company.array_get(rt.new_string('username'))])) || var_company.array_get(rt.new_string('username')).to_string().len < 3) {
			break
		}
	}
	var_reflected_provider.setstaticpropertyvalue(rt.new_string('lastName'), var_orig_ln.clone())
	return var_company.clone()
}

fn Class_WC_SmoothGenerator_Generator_CustomerInfo.generate_address(country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	country_code_mutated = (Class_WC_SmoothGenerator_Generator_CustomerInfo.get_valid_country_code(mut country_code_mutated)).str()
	if rt.is_true(rt.call_function('is_wp_error', [rt.new_string(country_code_mutated).clone()])) {
		return rt.new_string(country_code_mutated)
	}
	mut var_faker := Class_WC_SmoothGenerator_Generator_CustomerInfo.get_faker(country_code_mutated)
	mut var_address := rt.create_array([rt.ArrayItem{ key: 'address1', val: '' }, rt.ArrayItem{ key: 'city', val: '' }, rt.ArrayItem{ key: 'state', val: '' }, rt.ArrayItem{ key: 'postcode', val: '' }, rt.ArrayItem{ key: 'country', val: '' }, rt.ArrayItem{ key: 'phone', val: '' }])
	mut var_exceptions := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_country_locale', []rt.PhpVal{})
	mut iter_2 := rt.func_array_keys(var_address.clone()).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_line := item_2.val
		if var_exceptions.array_get(rt.new_string(country_code_mutated)).array_get(var_line).array_isset(rt.new_string('hidden')) && rt.is_true(rt.identical(rt.new_bool(true), var_exceptions.array_get(rt.new_string(country_code_mutated)).array_get(var_line).array_get(rt.new_string('hidden')))) {
			continue
		}
		if var_exceptions.array_get(rt.new_string(country_code_mutated)).array_get(var_line).array_isset(rt.new_string('required')) && rt.is_true(rt.identical(rt.new_bool(false), var_exceptions.array_get(rt.new_string(country_code_mutated)).array_get(var_line).array_get(rt.new_string('required')))) {
			if rt.is_true(rt.less(rt.call_method(var_faker, 'randomDigit', []rt.PhpVal{}), rt.new_int(5))) {
				continue
			}
		}
		mut switch_val_1 := var_line
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('address1'))) {
			var_address.array_set(var_line, rt.call_method(var_faker, 'streetAddress', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('city'))) {
			var_address.array_set(var_line, rt.call_method(var_faker, 'city', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('state'))) {
			mut var_states := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_states', [rt.new_string(country_code_mutated).clone()])
			if rt.is_true(rt.new_bool(var_states.clone().is_array())) {
				var_address.array_set(var_line, rt.call_method(var_faker, 'randomElement', [rt.func_array_keys(var_states.clone())]))
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('postcode'))) {
			var_address.array_set(var_line, rt.call_method(var_faker, 'postcode', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('country'))) {
			var_address.array_set(var_line, country_code_mutated)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('phone'))) {
			var_address.array_set(var_line, rt.call_method(var_faker, 'phoneNumber', []rt.PhpVal{}))
		}
	}
	return var_address.clone()
}

struct Class_WC_SmoothGenerator_Generator_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_Faker_Factory {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_ReflectionClass {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_generator_customerinfo(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_CustomerInfo {
	mut obj := &Class_WC_SmoothGenerator_Generator_CustomerInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wp_error(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_WP_Error {
	mut obj := &Class_WC_SmoothGenerator_Generator_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_faker_factory(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Faker_Factory {
	mut obj := &Class_WC_SmoothGenerator_Generator_Faker_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_reflectionclass(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_ReflectionClass {
	mut obj := &Class_WC_SmoothGenerator_Generator_ReflectionClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Generator_CustomerInfo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_valid_country_code' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WC_SmoothGenerator_Generator_CustomerInfo.get_valid_country_code(mut dispatch_arg_0)
		}
		'get_country_locale_info' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_SmoothGenerator_Generator_CustomerInfo.get_country_locale_info(dispatch_arg_0)
		}
		'get_faker' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_SmoothGenerator_Generator_CustomerInfo.get_faker(dispatch_arg_0)
		}
		'get_provider_instance' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_Faker_Generator](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WC_SmoothGenerator_Generator_CustomerInfo.get_provider_instance(mut dispatch_arg_0, dispatch_arg_1)
		}
		'generate_person' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_SmoothGenerator_Generator_CustomerInfo.generate_person(dispatch_arg_0)
		}
		'generate_company' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_SmoothGenerator_Generator_CustomerInfo.generate_company(dispatch_arg_0)
		}
		'generate_address' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_SmoothGenerator_Generator_CustomerInfo.generate_address(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_SmoothGenerator_Generator_CustomerInfo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_CustomerInfo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_Faker_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Faker_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Faker_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_ReflectionClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_ReflectionClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_ReflectionClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
