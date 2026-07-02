import rt

struct Class_IXR_Base64 {
	rt.PhpObjectBase
pub mut:
	data rt.PhpVal = rt.new_null()
}

fn (mut this Class_IXR_Base64) construct(var_data rt.PhpVal) {
	this.data = var_data.clone()
}

fn (mut this Class_IXR_Base64) ixr_base64(var_data rt.PhpVal) {
	mut iife_temp_0 := Class_IXR_Base64{}
	iife_temp_0.construct(var_data.clone())
	rt.new_null()
}

fn (mut this Class_IXR_Base64) getxml() string {
	return '<base64>' + (rt.call_function('base64_encode', [this.data])).str() + '</base64>'
}

fn create_ixr_base64(arg_0 rt.PhpVal) &Class_IXR_Base64 {
	mut obj := &Class_IXR_Base64{
		PhpObjectBase: rt.PhpObjectBase{}
		data:          rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_IXR_Base64) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'IXR_Base64' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.ixr_base64(dispatch_arg_0)
			return rt.new_null()
		}
		'getXml' {
			return rt.new_string(this.getxml())
		}
		else {
			return none
		}
	}
}

fn (this &Class_IXR_Base64) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_IXR_Base64) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' {
			this.data = val
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
