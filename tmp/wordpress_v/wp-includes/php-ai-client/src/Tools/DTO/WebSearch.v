import rt

pub fn Class_WordPress_AiClient_Tools_DTO_WebSearch.key_allowed_domains() string {
	return 'allowedDomains'
}

pub fn Class_WordPress_AiClient_Tools_DTO_WebSearch.key_disallowed_domains() string {
	return 'disallowedDomains'
}

struct Class_WordPress_AiClient_Tools_DTO_WebSearch {
	rt.PhpObjectBase
pub mut:
	allowedDomains    rt.PhpVal = rt.new_null()
	disallowedDomains rt.PhpVal = rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_WebSearch) construct(mut var_allowedDomains Class_WordPress_AiClient_Tools_DTO_array, mut var_disallowedDomains Class_WordPress_AiClient_Tools_DTO_array) {
	this.allowedDomains = var_allowedDomains.dup()
	this.disallowedDomains = var_disallowedDomains.dup()
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_WebSearch) getalloweddomains() rt.PhpVal {
	return this.allowedDomains
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_WebSearch) getdisalloweddomains() rt.PhpVal {
	return this.disallowedDomains
}

fn Class_WordPress_AiClient_Tools_DTO_WebSearch.getjsonschema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_WebSearch.key_allowed_domains()
				val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
					]) }, rt.ArrayItem{
						key: 'description'
						val: 'List of domains that are allowed for web search.'
					}])
			},
			rt.ArrayItem{
				key: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_WebSearch.key_disallowed_domains()
				val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
					]) }, rt.ArrayItem{
						key: 'description'
						val: 'List of domains that are disallowed for web search.'
					}])
			},
		]) }, rt.ArrayItem{ key: 'required', val: rt.new_array() }])
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_WebSearch) toarray() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_WebSearch.key_allowed_domains()
			val: this.allowedDomains
		},
		rt.ArrayItem{
			key: Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_WebSearch.key_disallowed_domains()
			val: this.disallowedDomains
		},
	])
}

fn Class_WordPress_AiClient_Tools_DTO_WebSearch.fromarray(mut var_array Class_WordPress_AiClient_Tools_DTO_array) rt.PhpVal {
	return create_wordpress_aiclient_tools_dto_self(if !(var_array.array_get(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_WebSearch.key_allowed_domains())).is_null() {
		var_array.array_get(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_WebSearch.key_allowed_domains())
	} else {
		rt.new_array()
	}, if !(var_array.array_get(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_WebSearch.key_disallowed_domains())).is_null() {
		var_array.array_get(Class_WordPress_AiClient_Tools_DTO_WordPress_AiClient_Tools_DTO_WebSearch.key_disallowed_domains())
	} else {
		rt.new_array()
	})
}

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Tools_DTO_self {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_tools_dto_websearch(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WordPress_AiClient_Tools_DTO_WebSearch {
	mut obj := &Class_WordPress_AiClient_Tools_DTO_WebSearch{
		PhpObjectBase:     rt.PhpObjectBase{}
		allowedDomains:    rt.new_null()
		disallowedDomains: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wordpress_aiclient_common_abstractdatatransferobject() &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_tools_dto_self() &Class_WordPress_AiClient_Tools_DTO_self {
	mut obj := &Class_WordPress_AiClient_Tools_DTO_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_WebSearch) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'getAllowedDomains' {
			return this.getalloweddomains()
		}
		'getDisallowedDomains' {
			return this.getdisalloweddomains()
		}
		'getJsonSchema' {
			return Class_WordPress_AiClient_Tools_DTO_WebSearch.getjsonschema()
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Tools_DTO_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_WordPress_AiClient_Tools_DTO_WebSearch.fromarray(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Tools_DTO_WebSearch) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'allowedDomains' { return this.allowedDomains }
		'disallowedDomains' { return this.disallowedDomains }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_WebSearch) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'allowedDomains' {
			this.allowedDomains = val
			return true
		}
		'disallowedDomains' {
			this.disallowedDomains = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WordPress_AiClient_Common_AbstractDataTransferObject) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_AbstractDataTransferObject) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_AbstractDataTransferObject) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Tools_DTO_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Tools_DTO_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_php_ai_client_src_tools_dto_websearch_php() {
	// unsupported statement: Stmt_Declare
}
