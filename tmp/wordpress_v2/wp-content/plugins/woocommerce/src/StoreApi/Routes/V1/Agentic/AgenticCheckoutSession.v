import rt

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession {
	rt.PhpObjectBase
pub mut:
	cart     rt.PhpVal = rt.new_null()
	messages rt.PhpVal = rt.new_null()
	id       rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) construct(mut var_cart Class_WC_Cart) {
	this.cart = var_cart
	this.messages = create_automattic_woocommerce_storeapi_routes_v1_agentic_messages_messages()
	this.id = this.get_or_set_checkout_session_id()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) get_cart() rt.PhpVal {
	return this.cart
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) get_messages() rt.PhpVal {
	return this.messages
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) get_id() string {
	return (this.id).str()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) get_or_set_checkout_session_id() string {
	mut var_wc_session := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')
	if rt.is_true(rt.identical(rt.new_null(), var_wc_session)) {
		return ''
	}
	mut var_session_id := rt.call_method(var_wc_session, 'get', [
		Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey.agentic_checkout_session_id(),
	])
	if rt.is_true(rt.identical(rt.new_null(), var_session_id)) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{}
		mut iife_result_0 := iife_temp_0.get_cart_token(rt.new_string((rt.call_method(var_wc_session,
			'get_customer_id', []rt.PhpVal{})).str()))
		var_session_id = iife_result_0
		rt.call_method(var_wc_session, 'set', [
			Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey.agentic_checkout_session_id(),
			var_session_id.clone(),
		])
	}
	return var_session_id.str()
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_agenticcheckoutsession(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession{
		PhpObjectBase: rt.PhpObjectBase{}
		cart:          rt.new_null()
		messages:      rt.new_null()
		id:            rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_messages_messages(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_carttokenutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Cart](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_cart' {
			return this.get_cart()
		}
		'get_messages' {
			return this.get_messages()
		}
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_or_set_checkout_session_id' {
			return rt.new_string(this.get_or_set_checkout_session_id())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cart' { return this.cart }
		'messages' { return this.messages }
		'id' { return this.id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cart' {
			this.cart = val
			return true
		}
		'messages' {
			this.messages = val
			return true
		}
		'id' {
			this.id = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Messages) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
