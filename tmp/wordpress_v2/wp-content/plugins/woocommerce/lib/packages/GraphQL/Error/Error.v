import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
pub mut:
		locations rt.PhpVal = rt.new_null()
		path rt.PhpVal = rt.new_null()
		unaliasedPath rt.PhpVal = rt.new_null()
		nodes rt.PhpVal = rt.new_null()
		source rt.PhpVal = rt.new_null()
		positions rt.PhpVal = rt.new_null()
		isClientSafe rt.PhpVal = rt.new_null()
		extensions rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) construct(message string, var_nodes rt.PhpVal, mut var_source Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?Source, mut var_positions Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?array, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?array, mut var_previous Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?Throwable, mut var_extensions Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?array) {
	mut message_mutated := message
	mut var_nodes_mutated := var_nodes
	mut var_source_mutated := var_source
	mut var_positions_mutated := var_positions
	mut var_path_mutated := var_path
	mut var_extensions_mutated := var_extensions
	this.Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Exception.construct(rt.new_string(message_mutated), rt.new_int(0), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_?Throwable', []string{}, var_previous))
	if rt.is_true(rt.new_bool(rt.instance_of(var_nodes_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Error_Traversable'))) {
		this.nodes = rt.call_function('array_filter', [rt.call_function('iterator_to_array', [var_nodes_mutated.clone()])])
	} else if rt.is_true(rt.new_bool(var_nodes_mutated.clone().is_array())) {
		this.nodes = rt.call_function('array_filter', [var_nodes_mutated.clone()])
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_nodes_mutated, rt.new_null())))) {
		this.nodes = rt.create_array([rt.ArrayItem{ key: none, val: var_nodes_mutated }])
	} else {
		this.nodes = rt.new_null()
	}
	this.source = var_source_mutated
	this.positions = var_positions_mutated
	this.path = var_path_mutated
	this.unaliasedPath = var_unaliasedPath
	if var_extensions_mutated.is_array() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_extensions_mutated, rt.new_array())))) {
		this.extensions = var_extensions_mutated
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_?Throwable', []string{}, var_previous), 'Automattic_WooCommerce_Vendor_GraphQL_Error_ProvidesExtensions'))) {
		this.extensions = var_previous.getextensions()
	} else {
		this.extensions = rt.new_null()
	}
	this.isClientSafe = if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_?Throwable', []string{}, var_previous), 'Automattic_WooCommerce_Vendor_GraphQL_Error_ClientAware'))) { var_previous.isclientsafe() } else { rt.identical(var_previous, rt.new_null()) }
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error.createlocatederror(var_error rt.PhpVal, var_nodes rt.PhpVal, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?array) rt.PhpVal {
	mut var_nodes_mutated := var_nodes
	mut var_path_mutated := var_path
	if rt.is_true(rt.new_bool(rt.instance_of(var_error, 'Automattic_WooCommerce_Vendor_GraphQL_Error_self'))) {
		if rt.is_true(rt.call_method(var_error, 'isLocated', []rt.PhpVal{})) {
			return var_error.clone()
		}
		rt.new_null()
		rt.new_null()
		rt.new_null()
	}
	mut var_source := rt.new_null()
	mut var_originalError := rt.new_null()
	mut var_positions := rt.new_array()
	mut var_extensions := rt.new_array()
	if rt.is_true(rt.new_bool(rt.instance_of(var_error, 'Automattic_WooCommerce_Vendor_GraphQL_Error_self'))) {
	mut var_message := rt.call_method(var_error, 'getMessage', []rt.PhpVal{})
	var_originalError = var_error
	var_source = rt.call_method(var_error, 'getSource', []rt.PhpVal{})
	var_positions = rt.call_method(var_error, 'getPositions', []rt.PhpVal{})
	var_extensions = rt.call_method(var_error, 'getExtensions', []rt.PhpVal{})
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_error, 'Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation'))) {
	var_message = rt.call_method(var_error, 'getMessage', []rt.PhpVal{})
	var_originalError = if !(rt.call_method(var_error, 'getPrevious', []rt.PhpVal{})).is_null() { rt.call_method(var_error, 'getPrevious', []rt.PhpVal{}) } else { var_error }
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_error, 'Automattic_WooCommerce_Vendor_GraphQL_Error_Throwable'))) {
	var_message = rt.call_method(var_error, 'getMessage', []rt.PhpVal{})
	var_originalError = var_error
	} else {
	var_message = rt.new_string((var_error).str())
	}
	mut var_nonEmptyMessage := if rt.is_true(rt.identical(var_message, rt.new_string(''))) { rt.new_string('An unknown error occurred.') } else { var_message }
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_static', []string{}, create_automattic_woocommerce_vendor_graphql_error_static(var_nonEmptyMessage.clone(), var_nodes_mutated.clone(), var_source.clone(), var_positions.clone(), var_path_mutated, var_originalError.clone(), var_extensions.clone(), var_unaliasedPath))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) islocated() bool {
	mut var_path := this.getpath()
	mut var_nodes := this.getnodes()
	return rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_path, rt.new_null())))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_path, rt.new_array())))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_nodes, rt.new_null())))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_nodes, rt.new_array()))))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) isclientsafe() bool {
	return (this.isClientSafe).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) getsource() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) getpositions() rt.PhpVal {
	if !(!(this.positions).is_null()) {
		this.positions = rt.new_array()
		if !(this.nodes).is_null() {
			mut iter_1 := this.nodes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_node := item_1.val
				if !(rt.get_property(rt.get_property(var_node, 'loc'), 'start')).is_null() {
					this.positions.array_push(rt.get_property(rt.get_property(var_node, 'loc'), 'start'))
				}
			}
		}
	}
	return this.positions
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) getlocations() rt.PhpVal {
	if !(!(this.locations).is_null()) {
		mut var_positions := this.getpositions()
		mut var_source := this.getsource()
		mut var_nodes := this.getnodes()
		this.locations = rt.new_array()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_source, rt.new_null())))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_positions, rt.new_array())))) {
			mut iter_2 := var_positions.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_position := item_2.val
				this.locations.array_push(rt.call_method(var_source, 'getLocation', [var_position.clone()]))
			}
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_nodes, rt.new_null())))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_nodes, rt.new_array())))) {
			mut iter_3 := var_nodes.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_node := item_3.val
				if !(rt.get_property(rt.get_property(var_node, 'loc'), 'source')).is_null() {
					this.locations.array_push(rt.call_method(rt.get_property(rt.get_property(var_node, 'loc'), 'source'), 'getLocation', [rt.get_property(rt.get_property(var_node, 'loc'), 'start')]))
				}
			}
		}
	}
	return this.locations
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) getnodes() rt.PhpVal {
	return this.nodes
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) getpath() rt.PhpVal {
	return this.path
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) getunaliasedpath() rt.PhpVal {
	return this.unaliasedPath
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) getextensions() rt.PhpVal {
	return this.extensions
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) jsonserialize() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError{}
	mut iife_result_0 := iife_temp_0.createfromexception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, this))
	return iife_result_0
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) magic_tostring() string {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError{}
	mut iife_result_1 := iife_temp_1.printerror(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, this))
	return (iife_result_1).str()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_static {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_error_error(message string, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal, arg_6 rt.PhpVal, arg_7 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
		locations: rt.new_null()
		path: rt.new_null()
		unaliasedPath: rt.new_null()
		nodes: rt.new_null()
		source: rt.new_null()
		positions: rt.new_null()
		isClientSafe: rt.new_null()
		extensions: rt.new_null()
	}
	obj.construct(message, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Exception {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_static {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_formattederror(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?Source](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?array](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?Throwable](if args.len > 5 { args[5] } else { rt.new_null() })
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?array](if args.len > 6 { args[6] } else { rt.new_null() })
			mut dispatch_arg_7 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?array](if args.len > 7 { args[7] } else { rt.new_null() })
			this.construct(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6, mut dispatch_arg_7)
			return rt.new_null()
		}
		'createLocatedError' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?array](if args.len > 3 { args[3] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error.createlocatederror(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'isLocated' {
			return rt.new_bool(this.islocated())
		}
		'isClientSafe' {
			return rt.new_bool(this.isclientsafe())
		}
		'getSource' {
			return this.getsource()
		}
		'getPositions' {
			return this.getpositions()
		}
		'getLocations' {
			return this.getlocations()
		}
		'getNodes' {
			return this.getnodes()
		}
		'getPath' {
			return this.getpath()
		}
		'getUnaliasedPath' {
			return this.getunaliasedpath()
		}
		'getExtensions' {
			return this.getextensions()
		}
		'jsonSerialize' {
			return this.jsonserialize()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'locations' { return this.locations }
		'path' { return this.path }
		'unaliasedPath' { return this.unaliasedPath }
		'nodes' { return this.nodes }
		'source' { return this.source }
		'positions' { return this.positions }
		'isClientSafe' { return this.isClientSafe }
		'extensions' { return this.extensions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'locations' { this.locations = val; return true }
		'path' { this.path = val; return true }
		'unaliasedPath' { this.unaliasedPath = val; return true }
		'nodes' { this.nodes = val; return true }
		'source' { this.source = val; return true }
		'positions' { this.positions = val; return true }
		'isClientSafe' { this.isClientSafe = val; return true }
		'extensions' { this.extensions = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
