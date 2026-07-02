import rt

struct Class_Automattic_WooCommerce_Container {
	rt.PhpObjectBase
pub mut:
	container rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Container) construct() {
	this.container = create_automattic_woocommerce_internal_dependencymanagement_runtimecontainer(rt.create_array([
		rt.ArrayItem{ key: @STRUCT, val: rt.new_object('Automattic_WooCommerce_Container',
			[]string{}, &this) },
		rt.ArrayItem{ key: 'Psr\\Container\\ContainerInterface', val: rt.new_object('Automattic_WooCommerce_Container',
			[]string{}, &this) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Container) get(id string) rt.PhpVal {
	return rt.call_method(this.container, 'get', [rt.new_string(id)])
}

fn (mut this Class_Automattic_WooCommerce_Container) has(id string) bool {
	return (rt.call_method(this.container, 'has', [rt.new_string(id)])).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_container() &Class_Automattic_WooCommerce_Container {
	mut obj := &Class_Automattic_WooCommerce_Container{
		PhpObjectBase: rt.PhpObjectBase{}
		container:     rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_dependencymanagement_runtimecontainer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer {
	mut obj := &Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get(dispatch_arg_0)
		}
		'has' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'container' { return this.container }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'container' {
			this.container = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
