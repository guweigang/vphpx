import rt

struct Class_WC_Validation {
	rt.PhpObjectBase
}

fn Class_WC_Validation.is_email(var_email rt.PhpVal) rt.PhpVal {
	return rt.call_function('is_email', [var_email.dup()])
}

fn Class_WC_Validation.is_phone(var_phone rt.PhpVal) bool {
	if 0 < rt.call_function('preg_replace', [rt.new_string('/[\\s\\#0-9_\\-\\+\\/\\(\\)\\.]/'), rt.new_string(''), var_phone.dup()]).to_string().trim_space().len {
		return false
	}
	return true
}

fn Class_WC_Validation.is_postcode(var_postcode rt.PhpVal, var_country rt.PhpVal) bool {
	mut var_postcode_mutated := var_postcode
	if rt.call_function('preg_replace', [rt.new_string('/[\\s\\-A-Za-z0-9]/'), rt.new_string(''), var_postcode_mutated.dup()]).to_string().trim_space().len > 0 {
		return false
	}
	mut switch_val_1 := var_country
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('AT'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('BE'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('CH'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('HU'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('NO'))) {
		mut var_valid := // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('BA'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('BR'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('DE'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('DK'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('ES'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('FI'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('EE'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('FR'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('IT'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('GB'))) {
		var_valid = Class_WC_Validation.is_gb_postcode(var_postcode_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('IE'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('IN'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('JP'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('PT'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('PR'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('US'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('CA'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('PL'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('CZ'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('SE'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('SK'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('NL'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('SI'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('LI'))) {
		var_valid = // unsupported expression: Expr_Cast_Bool
	} else {
		var_valid = rt.new_bool(rt.new_bool(true))
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_validate_postcode'), var_valid.dup(), var_postcode_mutated.dup(), var_country.dup()])).to_bool()
}

fn Class_WC_Validation.is_gb_postcode(var_to_check rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_alpha1 := rt.new_string(rt.new_string('[abcdefghijklmnoprstuwyz]'))
	mut var_alpha2 := rt.new_string(rt.new_string('[abcdefghklmnopqrstuvwxy]'))
	mut var_alpha3 := rt.new_string(rt.new_string('[abcdefghjkpstuw]'))
	mut var_alpha4 := rt.new_string(rt.new_string('[abehmnprvwxy]'))
	mut var_alpha5 := rt.new_string(rt.new_string('[abdefghjlnpqrstuwxyz]'))
	mut var_pcexp := []rt.PhpVal{}
	var_pcexp[0] = '/^(' + (var_alpha1).str() + '{1}' + (var_alpha2).str() + '{0,1}[0-9]{1,2})([0-9]{1}' + (var_alpha5).str() + '{2})$/'
	var_pcexp[1] = '/^(' + (var_alpha1).str() + '{1}[0-9]{1}' + (var_alpha3).str() + '{1})([0-9]{1}' + (var_alpha5).str() + '{2})$/'
	var_pcexp[2] = '/^(' + (var_alpha1).str() + '{1}' + (var_alpha2).str() + '[0-9]{1}' + (var_alpha4).str() + ')([0-9]{1}' + (var_alpha5).str() + '{2})$/'
	var_pcexp[3] = '/^(gir)(0aa)$/'
	var_pcexp[4] = '/^(bfpo)([0-9]{1,4})$/'
	var_pcexp[5] = '/^(bfpo)(c\\/o[0-9]{1,3})$/'
	mut var_postcode := rt.new_string(rt.new_string(var_to_check.dup().to_string().to_lower()))
	var_postcode = rt.call_function('str_replace', [rt.new_string(' '), rt.new_string(''), var_postcode.dup()])
	mut var_valid := rt.new_bool(rt.new_bool(false))
	for var_regexp in var_pcexp {
		if rt.is_true(rt.call_function('preg_match', [rt.new_string(regexp), var_postcode.dup(), var_matches.dup()])) {
			var_valid = rt.new_bool(rt.new_bool(true))
			break
		}
	}
	return var_valid.dup()
}

fn Class_WC_Validation.format_postcode(var_postcode rt.PhpVal, var_country rt.PhpVal) rt.PhpVal {
	mut var_postcode_mutated := var_postcode
	return rt.call_function('wc_format_postcode', [var_postcode_mutated.dup(), var_country.dup()])
}

fn Class_WC_Validation.format_phone(var_tel rt.PhpVal) rt.PhpVal {
	return rt.call_function('wc_format_phone_number', [var_tel.dup()])
}

fn create_wc_validation() &Class_WC_Validation {
	mut obj := &Class_WC_Validation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Validation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Validation.is_email(dispatch_arg_0)
		}
		'is_phone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Validation.is_phone(dispatch_arg_0))
		}
		'is_postcode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Validation.is_postcode(dispatch_arg_0, dispatch_arg_1))
		}
		'is_gb_postcode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Validation.is_gb_postcode(dispatch_arg_0)
		}
		'format_postcode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Validation.format_postcode(dispatch_arg_0, dispatch_arg_1)
		}
		'format_phone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Validation.format_phone(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Validation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Validation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_validation_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
