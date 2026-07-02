import rt

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationRegistry {
	rt.PhpObjectBase
pub mut:
	integrations rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationRegistry) register_integration(mut var_integration Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationInterface) {
	this.integrations.array_set(var_integration.get_id(), var_integration)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationRegistry) get_integration(id string) rt.PhpVal {
	return if !(this.integrations.array_get(rt.new_string(id))).is_null() {
		this.integrations.array_get(rt.new_string(id))
	} else {
		rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationRegistry) get_integrations() rt.PhpVal {
	return this.integrations
}

fn create_automattic_woocommerce_internal_productfeed_integrations_integrationregistry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationRegistry {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
		integrations:  rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_integration' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationInterface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.register_integration(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_integration' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_integration(dispatch_arg_0)
		}
		'get_integrations' {
			return this.get_integrations()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'integrations' { return this.integrations }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'integrations' {
			this.integrations = val
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
