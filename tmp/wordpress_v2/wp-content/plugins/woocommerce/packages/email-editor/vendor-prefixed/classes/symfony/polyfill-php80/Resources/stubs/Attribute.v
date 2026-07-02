import rt

pub fn Class_EmailEditorVendor_Attribute.target_class() i64 {
	return 1
}

pub fn Class_EmailEditorVendor_Attribute.target_function() i64 {
	return 2
}

pub fn Class_EmailEditorVendor_Attribute.target_method() i64 {
	return 4
}

pub fn Class_EmailEditorVendor_Attribute.target_property() i64 {
	return 8
}

pub fn Class_EmailEditorVendor_Attribute.target_class_constant() i64 {
	return 16
}

pub fn Class_EmailEditorVendor_Attribute.target_parameter() i64 {
	return 32
}

pub fn Class_EmailEditorVendor_Attribute.target_all() i64 {
	return 63
}

pub fn Class_EmailEditorVendor_Attribute.is_repeatable() i64 {
	return 64
}

struct Class_EmailEditorVendor_Attribute {
	rt.PhpObjectBase
pub mut:
	flags i64
}

fn (mut this Class_EmailEditorVendor_Attribute) construct(flags i64) {
	this.flags = flags
}

fn create_emaileditorvendor_attribute(flags i64) &Class_EmailEditorVendor_Attribute {
	mut obj := &Class_EmailEditorVendor_Attribute{
		PhpObjectBase: rt.PhpObjectBase{}
		flags:         i64(0)
	}
	obj.construct(flags)
	return obj
}

fn (mut this Class_EmailEditorVendor_Attribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_EmailEditorVendor_Attribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'flags' { return rt.new_int(this.flags) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_EmailEditorVendor_Attribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'flags' {
			this.flags = val.to_i64()
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
