import rt

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message {
	rt.PhpObjectBase
pub mut:
	content_type rt.PhpVal = rt.new_null()
	content      rt.PhpVal = rt.new_null()
	param        rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message) is_error() bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message) to_array() {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message) use_markdown() {
	this.content_type =
		Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageContentType.markdown()
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_messages_message(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message{
		PhpObjectBase: rt.PhpObjectBase{}
		content_type:  rt.new_null()
		content:       rt.new_null()
		param:         rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_error' {
			return rt.new_bool(this.is_error())
		}
		'to_array' {
			this.to_array()
			return rt.new_null()
		}
		'use_markdown' {
			this.use_markdown()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'content_type' { return this.content_type }
		'content' { return this.content }
		'param' { return this.param }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'content_type' {
			this.content_type = val
			return true
		}
		'content' {
			this.content = val
			return true
		}
		'param' {
			this.param = val
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
