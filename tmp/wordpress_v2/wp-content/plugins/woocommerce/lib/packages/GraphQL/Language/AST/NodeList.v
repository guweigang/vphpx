import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	rt.PhpObjectBase
pub mut:
	nodes rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) construct(mut var_nodes Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_array) {
	this.nodes = var_nodes
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) offsetexists(var_offset rt.PhpVal) bool {
	return (rt.new_bool(this.nodes.array_isset(var_offset))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	mut var_item := this.nodes.array_get(var_offset)
	if rt.is_true(rt.new_bool(var_item.clone().is_array())) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
		mut iife_result_0 := iife_temp_0.fromarray(var_item.clone())
		return this.nodes.array_set(var_offset, iife_result_0)
	}
	return var_item.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_value_mutated.clone().is_array())) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
		mut iife_result_1 := iife_temp_1.fromarray(var_value_mutated.clone())
		var_value_mutated = iife_result_1
	}
	if rt.is_true(rt.identical(var_offset, rt.new_null())) {
		this.nodes.array_push(var_value_mutated.clone())
		return
	}
	this.nodes.array_set(var_offset, var_value_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) offsetunset(var_offset rt.PhpVal) {
	this.nodes.array_unset(var_offset)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) getiterator() {
	mut iter_1 := this.nodes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var__ := item_1.val
		mut var_key := item_1.key
		rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) count() i64 {
	return this.nodes.array_count()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) splice(offset i64, length i64, var_replacement rt.PhpVal) rt.PhpVal {
	mut var_replacement_mutated := var_replacement
	if rt.is_true(rt.call_function('is_iterable', [var_replacement_mutated.clone()]))
		&& !(var_replacement_mutated.clone().is_array()) {
		var_replacement_mutated = rt.call_function('iterator_to_array', [
			var_replacement_mutated.clone()])
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList', [
		'ArrayAccess',
		'IteratorAggregate',
		'Countable',
	], create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(rt.call_function('array_splice', [
		this.nodes,
		rt.new_int(offset),
		rt.new_int(length),
		var_replacement_mutated.clone(),
	])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) merge(mut var_list Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_iterable) rt.PhpVal {
	mut var_list_mutated := var_list
	if !(var_list_mutated.is_array()) {
		var_list_mutated = rt.call_function('iterator_to_array', [var_list_mutated])
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList', [
		'ArrayAccess',
		'IteratorAggregate',
		'Countable',
	], create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(rt.call_function('array_merge', [
		this.nodes,
		var_list_mutated,
	])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) reindex() {
	this.nodes = rt.call_function('array_values', [this.nodes])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) clonedeep() rt.PhpVal {
	mut var_empty := rt.new_array()
	mut var_cloned :=
		create_automattic_woocommerce_vendor_graphql_language_ast_static(var_empty.clone())
	mut iter_2 := this.getiterator().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_node := item_2.val
		mut var_key := item_2.key
		var_cloned.array_set(var_key, rt.call_method(var_node, 'cloneDeep', []rt.PhpVal{}))
	}
	return mut var_cloned
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_static {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList{
		PhpObjectBase: rt.PhpObjectBase{}
		nodes:         rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_ast(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_static {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.offsetexists(dispatch_arg_0))
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetget(dispatch_arg_0)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'getIterator' {
			this.getiterator()
			return rt.new_null()
		}
		'count' {
			return rt.new_int(this.count())
		}
		'splice' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.splice(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'merge' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_iterable](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.merge(mut dispatch_arg_0)
		}
		'reindex' {
			this.reindex()
			return rt.new_null()
		}
		'cloneDeep' {
			return this.clonedeep()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'nodes' { return this.nodes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'nodes' {
			this.nodes = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
