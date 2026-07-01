import rt

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages {
	rt.PhpObjectBase
pub mut:
	messages rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages) add(mut var_message Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message) {
	this.messages.array_push(var_message.dup())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages) has_errors() bool {
	{
		mut iter_1 := this.messages.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_message := item_1.val
			if rt.is_true(rt.call_method(var_message, 'is_error', []rt.PhpVal{})) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages) get_formatted_messages() rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_message := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return var_message.to_array()
		}
		mut var_message := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return var_message.to_array()
	}
	return rt.call_function('array_map', [rt.new_closure(closure_1_fn), this.messages])
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_messages_messages() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages{
		PhpObjectBase: rt.PhpObjectBase{}
		messages:      rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.add(mut dispatch_arg_0)
			return rt.new_null()
		}
		'has_errors' {
			return rt.new_bool(this.has_errors())
		}
		'get_formatted_messages' {
			return this.get_formatted_messages()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'messages' { return this.messages }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'messages' {
			this.messages = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_agentic_messages_messages_php() {
	// unsupported statement: Stmt_Declare
}
