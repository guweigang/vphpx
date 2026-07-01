import rt

struct Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry {
	rt.PhpObjectBase
pub mut:
	registry_identifier     rt.PhpVal = rt.new_string('')
	registered_integrations rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) initialize(registry_identifier string) bool {
	if var_registry_identifier.len > 0 && var_registry_identifier != '0' {
		this.registry_identifier = rt.new_string(registry_identifier).dup()
	}
	if !rt.is_true(this.registry_identifier) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('esc_html__', [
				rt.new_string('Integration registry requires an identifier.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('4.6.0')])
		return false
	}
	rt.call_function('do_action', [
		'woocommerce_blocks_' + (this.registry_identifier).str() + '_registration',
		rt.new_object('Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry', []string{},
			&this),
	])
	{
		mut iter_1 := this.get_all_registered().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_registered_integration := item_1.val
			rt.call_method(var_registered_integration, 'initialize', []rt.PhpVal{})
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) register(mut var_integration Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationInterface) bool {
	mut var_name := var_integration.get_name()
	if rt.is_true(this.is_registered(var_name.dup())) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('"%s" is already registered.'),
						rt.new_string('woocommerce')]),
					var_name.dup(),
				]),
			]),
			rt.new_string('4.6.0')])
		return false
	}
	this.registered_integrations.array_set(var_name, var_integration.dup())
	return true
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) is_registered(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
	return rt.new_bool(this.registered_integrations.array_isset(var_name_mutated))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) unregister(var_name rt.PhpVal) bool {
	mut var_name_mutated := var_name
	if rt.is_true(rt.new_bool(rt.instance_of(var_name_mutated,
		'Automattic_WooCommerce_Blocks_Integrations_IntegrationInterface')))
	{
		var_name_mutated = rt.call_method(var_name_mutated, 'get_name', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_registered(var_name_mutated.dup()))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Integration "%s" is not registered.'),
						rt.new_string('woocommerce'),
					]),
					var_name_mutated.dup(),
				]),
			]),
			rt.new_string('4.6.0')])
		return false
	}
	mut var_unregistered := this.registered_integrations.array_get(var_name_mutated)
	this.registered_integrations.array_unset(var_name_mutated)
	return var_unregistered.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) get_registered(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
	return if rt.is_true(this.is_registered(var_name_mutated.dup())) {
		this.registered_integrations.array_get(var_name_mutated)
	} else {
		rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) get_all_registered() rt.PhpVal {
	return this.registered_integrations
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) get_all_registered_editor_script_handles() rt.PhpVal {
	mut var_script_handles := rt.new_array()
	mut var_registered_integrations := this.get_all_registered()
	{
		mut iter_1 := var_registered_integrations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_registered_integration := item_1.val
			var_script_handles = rt.call_function('array_merge', [
				var_script_handles.dup(),
				rt.call_method(var_registered_integration,
					'get_editor_script_handles', []rt.PhpVal{})])
		}
	}
	return rt.call_function('array_unique', [
		rt.call_function('array_filter', [var_script_handles.dup()]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) get_all_registered_script_handles() rt.PhpVal {
	mut var_script_handles := rt.new_array()
	mut var_registered_integrations := this.get_all_registered()
	{
		mut iter_1 := var_registered_integrations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_registered_integration := item_1.val
			var_script_handles = rt.call_function('array_merge', [
				var_script_handles.dup(),
				rt.call_method(var_registered_integration,
					'get_script_handles', []rt.PhpVal{})])
		}
	}
	return rt.call_function('array_unique', [
		rt.call_function('array_filter', [var_script_handles.dup()]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) get_all_registered_script_data() rt.PhpVal {
	mut var_script_data := rt.new_array()
	mut var_registered_integrations := this.get_all_registered()
	{
		mut iter_1 := var_registered_integrations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_registered_integration := item_1.val
			var_script_data.array_set(
				(rt.call_method(var_registered_integration, 'get_name', []rt.PhpVal{})).str() +
				'_data', rt.call_method(var_registered_integration, 'get_script_data',
				[]rt.PhpVal{}))
		}
	}
	return rt.call_function('array_filter', [var_script_data.dup()])
}

fn create_automattic_woocommerce_blocks_integrations_integrationregistry() &Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry{
		PhpObjectBase:           rt.PhpObjectBase{}
		registry_identifier:     rt.new_string('')
		registered_integrations: rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.initialize(dispatch_arg_0))
		}
		'register' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationInterface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.register(mut dispatch_arg_0))
		}
		'is_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_registered(dispatch_arg_0)
		}
		'unregister' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.unregister(dispatch_arg_0))
		}
		'get_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_registered(dispatch_arg_0)
		}
		'get_all_registered' {
			return this.get_all_registered()
		}
		'get_all_registered_editor_script_handles' {
			return this.get_all_registered_editor_script_handles()
		}
		'get_all_registered_script_handles' {
			return this.get_all_registered_script_handles()
		}
		'get_all_registered_script_data' {
			return this.get_all_registered_script_data()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registry_identifier' { return this.registry_identifier }
		'registered_integrations' { return this.registered_integrations }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registry_identifier' {
			this.registry_identifier = val
			return true
		}
		'registered_integrations' {
			this.registered_integrations = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_integrations_integrationregistry_php() {
}
