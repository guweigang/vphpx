import rt

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema {
	rt.PhpObjectBase
pub mut:
	schema rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) minlength(value i64) rt.PhpVal {
	return this.update_schema_property(rt.new_string('minLength'), rt.new_int(value))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) maxlength(value i64) rt.PhpVal {
	return this.update_schema_property(rt.new_string('maxLength'), rt.new_int(value))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) pattern(pattern string) rt.PhpVal {
	this.validate_pattern(rt.new_string(pattern))
	return this.update_schema_property(rt.new_string('pattern'), rt.new_string(pattern))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) formatdatetime() rt.PhpVal {
	return this.update_schema_property(rt.new_string('format'), rt.new_string('date-time'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) formatemail() rt.PhpVal {
	return this.update_schema_property(rt.new_string('format'), rt.new_string('email'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) formathexcolor() rt.PhpVal {
	return this.update_schema_property(rt.new_string('format'), rt.new_string('hex-color'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) formatip() rt.PhpVal {
	return this.update_schema_property(rt.new_string('format'), rt.new_string('ip'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) formaturi() rt.PhpVal {
	return this.update_schema_property(rt.new_string('format'), rt.new_string('uri'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) formatuuid() rt.PhpVal {
	return this.update_schema_property(rt.new_string('format'), rt.new_string('uuid'))
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_validator_schema_string_schema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
		schema:        rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_schema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'minLength' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.minlength(dispatch_arg_0)
		}
		'maxLength' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.maxlength(dispatch_arg_0)
		}
		'pattern' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.pattern(dispatch_arg_0)
		}
		'formatDateTime' {
			return this.formatdatetime()
		}
		'formatEmail' {
			return this.formatemail()
		}
		'formatHexColor' {
			return this.formathexcolor()
		}
		'formatIp' {
			return this.formatip()
		}
		'formatUri' {
			return this.formaturi()
		}
		'formatUuid' {
			return this.formatuuid()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema' {
			this.schema = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
