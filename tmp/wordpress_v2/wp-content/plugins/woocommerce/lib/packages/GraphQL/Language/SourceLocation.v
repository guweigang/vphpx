import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation {
	rt.PhpObjectBase
pub mut:
	line   i64
	column i64
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation) construct(line i64, col i64) {
	this.line = line
	this.column = col
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation) toarray() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'line', val: this.line },
		rt.ArrayItem{ key: 'column', val: this.column }])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation) toserializablearray() rt.PhpVal {
	return this.toarray()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation) jsonserialize() rt.PhpVal {
	return this.toarray()
}

fn create_automattic_woocommerce_vendor_graphql_language_sourcelocation(line i64, col i64) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation{
		PhpObjectBase: rt.PhpObjectBase{}
		line:          i64(0)
		column:        i64(0)
	}
	obj.construct(line, col)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'toArray' {
			return this.toarray()
		}
		'toSerializableArray' {
			return this.toserializablearray()
		}
		'jsonSerialize' {
			return this.jsonserialize()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'line' { return rt.new_int(this.line) }
		'column' { return rt.new_int(this.column) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'line' {
			this.line = val.to_i64()
			return true
		}
		'column' {
			this.column = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
