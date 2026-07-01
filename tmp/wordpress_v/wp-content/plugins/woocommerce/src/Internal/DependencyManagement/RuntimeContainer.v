import rt

pub fn Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer.woocommerce_namespace() string {
	return 'Automattic\\WooCommerce\\'
}
struct Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer {
	rt.PhpObjectBase
pub mut:
		resolved_cache rt.PhpVal = rt.new_null()
		initial_resolved_cache rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer) construct(mut var_initial_resolved_cache Class_Automattic_WooCommerce_Internal_DependencyManagement_array)  {
	this.initial_resolved_cache = var_initial_resolved_cache.dup()
	this.resolved_cache = var_initial_resolved_cache.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer) get(class_name string) rt.PhpVal {
	mut class_name_mutated := class_name
	class_name_mutated = class_name_mutated.trim_space()
	mut var_resolve_chain := rt.new_array()
	return this.get_core(class_name_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DependencyManagement_array](var_resolve_chain))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer) get_core(class_name string, mut var_resolve_chain Class_Automattic_WooCommerce_Internal_DependencyManagement_array) rt.PhpVal {
	mut class_name_mutated := class_name
	mut var_resolve_chain_mutated := var_resolve_chain
	if this.resolved_cache.array_isset(rt.new_string(class_name_mutated)) {
		return this.resolved_cache.array_get(class_name_mutated)
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string(class_name_mutated).dup(), var_resolve_chain_mutated.dup(), rt.new_bool(true)])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DependencyManagement_ContainerException', []string{}, create_automattic_woocommerce_internal_dependencymanagement_containerexception("Recursive resolution of class '${var_class_name.to_string()}'. Resolution chain: " + (rt.call_function('implode', [rt.new_string(', '), var_resolve_chain_mutated.dup()])).str())))
	}
	if !(this.is_class_allowed(class_name_mutated)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DependencyManagement_ContainerException', []string{}, create_automattic_woocommerce_internal_dependencymanagement_containerexception("Attempt to get an instance of class '${var_class_name.to_string()}', which is not in the " + (Class_Automattic_WooCommerce_Internal_DependencyManagement_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer.woocommerce_namespace()).str() + ' namespace. Did you forget to add a namespace import?')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string(class_name_mutated).dup()]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DependencyManagement_ContainerException', []string{}, create_automattic_woocommerce_internal_dependencymanagement_containerexception(rt.new_string("Attempt to get an instance of class '${var_class_name.to_string()}', which doesn't exist."))))
	}
	if rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.starts_with(arg_0, arg_1) }(rt.new_string(class_name_mutated), rt.new_string('Automattic\\WooCommerce\\StoreApi\\'))) {
		return rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_StoreApi{}; return temp.container() }(), 'get', [rt.new_string(class_name_mutated).dup()])
	}
	if rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.starts_with(arg_0, arg_1) }(rt.new_string(class_name_mutated), rt.new_string('Automattic\\WooCommerce\\Blocks\\'))) {
		return rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Package{}; return temp.container() }(), 'get', [rt.new_string(class_name_mutated).dup()])
	}
	var_resolve_chain_mutated.array_push(class_name_mutated)
	mut var_instance := this.instantiate_class_using_reflection(class_name_mutated, mut var_resolve_chain_mutated)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_DependencyManagement_ReflectionException') {
		mut var_e := var_e_1.dup()
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DependencyManagement_ContainerException', []string{}, create_automattic_woocommerce_internal_dependencymanagement_containerexception("Reflection error when resolving '${var_class_name.to_string()}': (" + (rt.call_function('get_class', [var_e.dup()])).str() + rt.concat(rt.new_string(') '), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})), rt.new_int(0), var_e.dup())))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	this.resolved_cache.array_set(class_name_mutated, var_instance.dup())
	return var_instance.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer) instantiate_class_using_reflection(class_name string, mut var_resolve_chain Class_Automattic_WooCommerce_Internal_DependencyManagement_array) rt.PhpVal {
	mut class_name_mutated := class_name
	mut var_resolve_chain_mutated := var_resolve_chain
	mut var_ref_class := create_automattic_woocommerce_internal_dependencymanagement_reflectionclass(rt.new_string(class_name_mutated).dup())
	mut var_constructor := var_ref_class.getconstructor()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_constructor.dup().is_null()))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_constructor, 'isPublic', []rt.PhpVal{}))))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DependencyManagement_ContainerException', []string{}, create_automattic_woocommerce_internal_dependencymanagement_containerexception(rt.new_string("Error resolving '${var_class_name.to_string()}': the class doesn't have a public constructor."))))
		}
		mut var_constructor_arguments := rt.call_method(var_constructor, 'getParameters', []rt.PhpVal{})
		{
			mut iter_1 := var_constructor_arguments.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_argument := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_argument, 'isOptional', []rt.PhpVal{}))))) {
					rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DependencyManagement_ContainerException', []string{}, create_automattic_woocommerce_internal_dependencymanagement_containerexception(rt.new_string("Error resolving '${var_class_name.to_string()}': the class constructor has non-optional arguments."))))
				}
			}
		}
	}
	mut var_instance := var_ref_class.newinstance()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ref_class.hasmethod(rt.new_string('init')))))) {
		return var_instance.dup()
	}
	mut var_init_method := var_ref_class.getmethod(rt.new_string('init'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_init_method, 'isPublic', []rt.PhpVal{}))))) || rt.is_true(rt.call_method(var_init_method, 'isStatic', []rt.PhpVal{})))) {
		return var_instance.dup()
	}
	mut var_init_args := rt.call_method(var_init_method, 'getParameters', []rt.PhpVal{})
	closure_2_fn := fn [var_class_name, mut var_resolve_chain] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_class_name, mut var_resolve_chain] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_arg := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_arg_type := rt.call_method(var_arg, 'getType', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_arg_type, 'Automattic_WooCommerce_Internal_DependencyManagement_ReflectionNamedType')))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DependencyManagement_ContainerException', []string{}, create_automattic_woocommerce_internal_dependencymanagement_containerexception(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Error resolving \''), rt.new_string(class_name_mutated)), rt.new_string('\': argument \'$')), rt.call_method(var_arg, 'getName', []rt.PhpVal{})), rt.new_string('\' doesn\'t have a type declaration.')))))
	}
	if rt.is_true(rt.call_method(var_arg_type, 'isBuiltin', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DependencyManagement_ContainerException', []string{}, create_automattic_woocommerce_internal_dependencymanagement_containerexception(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Error resolving \''), rt.new_string(class_name_mutated)), rt.new_string('\': argument \'$')), rt.call_method(var_arg, 'getName', []rt.PhpVal{})), rt.new_string('\' is not of a class type.')))))
	}
	if rt.is_true(rt.call_method(var_arg, 'isPassedByReference', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DependencyManagement_ContainerException', []string{}, create_automattic_woocommerce_internal_dependencymanagement_containerexception(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Error resolving \''), rt.new_string(class_name_mutated)), rt.new_string('\': argument \'$')), rt.call_method(var_arg, 'getName', []rt.PhpVal{})), rt.new_string('\' is passed by reference.')))))
	}
	return this.get_core((rt.call_method(var_arg_type, 'getName', []rt.PhpVal{})).str(), mut var_resolve_chain_mutated)
	}
	mut var_arg := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_arg_type := rt.call_method(var_arg, 'getType', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_arg_type, 'Automattic_WooCommerce_Internal_DependencyManagement_ReflectionNamedType')))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DependencyManagement_ContainerException', []string{}, create_automattic_woocommerce_internal_dependencymanagement_containerexception(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Error resolving \''), rt.new_string(class_name_mutated)), rt.new_string('\': argument \'$')), rt.call_method(var_arg, 'getName', []rt.PhpVal{})), rt.new_string('\' doesn\'t have a type declaration.')))))
	}
	if rt.is_true(rt.call_method(var_arg_type, 'isBuiltin', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DependencyManagement_ContainerException', []string{}, create_automattic_woocommerce_internal_dependencymanagement_containerexception(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Error resolving \''), rt.new_string(class_name_mutated)), rt.new_string('\': argument \'$')), rt.call_method(var_arg, 'getName', []rt.PhpVal{})), rt.new_string('\' is not of a class type.')))))
	}
	if rt.is_true(rt.call_method(var_arg, 'isPassedByReference', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DependencyManagement_ContainerException', []string{}, create_automattic_woocommerce_internal_dependencymanagement_containerexception(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Error resolving \''), rt.new_string(class_name_mutated)), rt.new_string('\': argument \'$')), rt.call_method(var_arg, 'getName', []rt.PhpVal{})), rt.new_string('\' is passed by reference.')))))
	}
	return this.get_core((rt.call_method(var_arg_type, 'getName', []rt.PhpVal{})).str(), mut var_resolve_chain_mutated)
	}
	mut var_init_arg_instances := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_init_args.dup()])
	rt.call_method(var_init_method, 'invoke', [var_instance.dup(), var_init_arg_instances.dup()])
	return var_instance.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer) has(class_name string) bool {
	mut class_name_mutated := class_name
	class_name_mutated = class_name_mutated.trim_space()
	return this.is_class_allowed(class_name_mutated) || this.resolved_cache.array_isset(rt.new_string(class_name_mutated))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer) is_class_allowed(class_name string) bool {
	mut class_name_mutated := class_name
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.starts_with(arg_0, arg_1, arg_2) }(rt.new_string(class_name_mutated), Class_Automattic_WooCommerce_Internal_DependencyManagement_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer.woocommerce_namespace(), rt.new_bool(false))).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_DependencyManagement_ContainerException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_StoreApi {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DependencyManagement_ReflectionClass {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_dependencymanagement_runtimecontainer(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer {
	mut obj := &Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer{
		PhpObjectBase: rt.PhpObjectBase{}
		resolved_cache: rt.new_null()
		initial_resolved_cache: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_internal_dependencymanagement_containerexception() &Class_Automattic_WooCommerce_Internal_DependencyManagement_ContainerException {
	mut obj := &Class_Automattic_WooCommerce_Internal_DependencyManagement_ContainerException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil() &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_storeapi() &Class_Automattic_WooCommerce_StoreApi_StoreApi {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_StoreApi{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package() &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_dependencymanagement_reflectionclass() &Class_Automattic_WooCommerce_Internal_DependencyManagement_ReflectionClass {
	mut obj := &Class_Automattic_WooCommerce_Internal_DependencyManagement_ReflectionClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DependencyManagement_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get(dispatch_arg_0)
		}
		'get_core' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DependencyManagement_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_core(dispatch_arg_0, mut dispatch_arg_1)
		}
		'instantiate_class_using_reflection' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DependencyManagement_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.instantiate_class_using_reflection(dispatch_arg_0, mut dispatch_arg_1)
		}
		'has' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has(dispatch_arg_0))
		}
		'is_class_allowed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_class_allowed(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'resolved_cache' { return this.resolved_cache }
		'initial_resolved_cache' { return this.initial_resolved_cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_RuntimeContainer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'resolved_cache' { this.resolved_cache = val; return true }
		'initial_resolved_cache' { this.initial_resolved_cache = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_ContainerException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DependencyManagement_ContainerException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_ContainerException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_ReflectionClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DependencyManagement_ReflectionClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_ReflectionClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_dependencymanagement_runtimecontainer_php() {
	// unsupported statement: Stmt_Declare
}
