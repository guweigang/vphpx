import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService.create_transformer(var_name rt.PhpVal) rt.PhpVal {
	mut var_camel_cased := rt.call_function('str_replace', [rt.new_string(' '),
		rt.new_string(''),
		rt.call_function('ucwords', [
			rt.call_function('str_replace', [rt.new_string('_'),
				rt.new_string(' '), var_name.clone()]),
		])])
	mut var_classname := rt.new_string(
		'Automattic\\WooCommerce\\Admin\\RemoteSpecs\\RuleProcessors\\Transformers' + '\\' +
		var_camel_cased.str())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		var_classname.clone()])))))
	{
		return rt.new_null()
	}
	return rt.create_object_dynamically(var_classname, []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService.apply(var_target_value rt.PhpVal, mut var_transformer_configs Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_array, var_is_default_set rt.PhpVal, var_default_value rt.PhpVal) rt.PhpVal {
	mut var_target_value_mutated := var_target_value
	mut iter_1 := var_transformer_configs.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_transformer_config := item_1.val
		if !(!(rt.get_property(var_transformer_config, 'use')).is_null()) {
			rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
				create_invalidargumentexception(rt.new_string('Missing required config value: use'))))
		}
		if !(!(rt.get_property(var_transformer_config, 'arguments')).is_null()) {
			rt.set_property(var_transformer_config, 'arguments', rt.new_null())
		}
		mut var_transformer := Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService.create_transformer(rt.get_property(var_transformer_config,
			'use'))
		if rt.is_true(rt.identical(rt.new_null(), var_transformer)) {
			rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.concat(rt.new_string('Unable to find a transformer by name: '), rt.get_property(var_transformer_config,
				'use')))))
		}
		var_target_value_mutated = rt.call_method(var_transformer, 'transform', [
			var_target_value_mutated.clone(),
			rt.get_property(var_transformer_config, 'arguments'),
			if rt.is_true(var_is_default_set) { var_default_value } else { rt.new_null() },
		])
		if rt.is_true(rt.identical(rt.new_null(), var_target_value_mutated)) {
			break
		}
	}
	if rt.is_true(var_is_default_set) {
		if rt.is_true(rt.identical(rt.new_null(), var_target_value_mutated)) {
			return var_default_value.clone()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('gettype', [
			var_default_value.clone(),
		]), rt.call_function('gettype', [var_target_value_mutated.clone()])))))
		{
			return var_default_value.clone()
		}
	}
	return var_target_value_mutated.clone()
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_transformers_transformerservice(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create_transformer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService.create_transformer(dispatch_arg_0)
		}
		'apply' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService.apply(dispatch_arg_0, mut
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService', fn (args []rt.PhpVal) rt.PhpVal {
		obj :=
			create_automattic_woocommerce_admin_remotespecs_ruleprocessors_transformers_transformerservice()
		return rt.new_object('Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService',
			[]string{}, obj)
	})
	rt.register_class_factory('InvalidArgumentException', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_invalidargumentexception()
		return rt.new_object('InvalidArgumentException', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
