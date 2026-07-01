import rt

struct Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonPsr17ClassesStrategy {
	rt.PhpObjectBase
pub mut:
		classes rt.PhpVal = rt.new_array()
}

fn Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonPsr17ClassesStrategy.getcandidates(var_type rt.PhpVal) rt.PhpVal {
	mut var_candidates := rt.new_array()
	if // unsupported expression: Expr_StaticPropertyFetch.array_isset(var_type) {
		{
			mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.array_get(var_type).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_class := item_1.val
				var_candidates.array_push(rt.create_array([rt.ArrayItem{ key: 'class', val: var_class }, rt.ArrayItem{ key: 'condition', val: rt.create_array([rt.ArrayItem{ key: none, val: var_class }]) }]))
			}
		}
	}
	return var_candidates.dup()
}

fn create_wordpress_aiclientdependencies_http_discovery_strategy_commonpsr17classesstrategy() &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonPsr17ClassesStrategy {
	mut obj := &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonPsr17ClassesStrategy{
		PhpObjectBase: rt.PhpObjectBase{}
		classes: rt.new_array()
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonPsr17ClassesStrategy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getCandidates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonPsr17ClassesStrategy.getcandidates(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonPsr17ClassesStrategy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'classes' { return this.classes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Http_Discovery_Strategy_CommonPsr17ClassesStrategy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'classes' { this.classes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_php_ai_client_third_party_http_discovery_strategy_commonpsr17classesstrategy_php() {
}
