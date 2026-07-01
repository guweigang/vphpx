import rt

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.default_deprecation_reason() string {
	return 'No longer supported'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.include_name() string {
	return 'include'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.if_argument_name() string {
	return 'if'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.skip_name() string {
	return 'skip'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.deprecated_name() string {
	return 'deprecated'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.reason_argument_name() string {
	return 'reason'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.one_of_name() string {
	return 'oneOf'
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	rt.PhpObjectBase
pub mut:
	internalDirectives rt.PhpVal = rt.new_null()
	name               rt.PhpVal = rt.new_null()
	description        rt.PhpVal = rt.new_null()
	args               rt.PhpVal = rt.new_null()
	isRepeatable       rt.PhpVal = rt.new_null()
	locations          rt.PhpVal = rt.new_null()
	astNode            rt.PhpVal = rt.new_null()
	config             rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) construct(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) {
	this.name = var_config.array_get('name')
	this.description = if !(var_config.array_get('description')).is_null() {
		var_config.array_get('description')
	} else {
		rt.new_null()
	}
	this.args = if var_config.array_isset(rt.new_string('args')) {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument{}
			return temp.listfromconfig(arg_0)
		}(var_config.array_get('args'))
	} else {
		rt.new_array()
	}
	this.isRepeatable = if !(var_config.array_get('isRepeatable')).is_null() {
		var_config.array_get('isRepeatable')
	} else {
		rt.new_bool(false)
	}
	this.locations = var_config.array_get('locations')
	this.astNode = if !(var_config.array_get('astNode')).is_null() {
		var_config.array_get('astNode')
	} else {
		rt.new_null()
	}
	this.config = var_config.dup()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.builtindirectives() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.include_name()
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.includedirective()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.skip_name()
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.skipdirective()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.deprecated_name()
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.deprecateddirective()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.one_of_name()
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.oneofdirective()
		},
	])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.getinternaldirectives() rt.PhpVal {
	return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.builtindirectives()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.includedirective() rt.PhpVal {
	return
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.skipdirective() rt.PhpVal {
	return
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.deprecateddirective() rt.PhpVal {
	return
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.oneofdirective() rt.PhpVal {
	return
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.isbuiltindirective(mut var_directive Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self) bool {
	return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.builtindirectives().array_isset(rt.get_property(var_directive,
		'name'))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.isspecifieddirective(mut var_directive Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) bool {
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.isbuiltindirective(mut var_directive)).to_bool()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.resetcachedinstances() {
	// unsupported assign target: Expr_StaticPropertyFetch
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_directive(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{
		PhpObjectBase:      rt.PhpObjectBase{}
		internalDirectives: rt.new_null()
		name:               rt.new_null()
		description:        rt.new_null()
		args:               rt.new_null()
		isRepeatable:       rt.new_null()
		locations:          rt.new_null()
		astNode:            rt.new_null()
		config:             rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_argument() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'builtInDirectives' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.builtindirectives()
		}
		'getInternalDirectives' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.getinternaldirectives()
		}
		'includeDirective' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.includedirective()
		}
		'skipDirective' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.skipdirective()
		}
		'deprecatedDirective' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.deprecateddirective()
		}
		'oneOfDirective' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.oneofdirective()
		}
		'isBuiltInDirective' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.isbuiltindirective(mut dispatch_arg_0))
		}
		'isSpecifiedDirective' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.isspecifieddirective(mut dispatch_arg_0))
		}
		'resetCachedInstances' {
			Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive.resetcachedinstances()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'internalDirectives' { return this.internalDirectives }
		'name' { return this.name }
		'description' { return this.description }
		'args' { return this.args }
		'isRepeatable' { return this.isRepeatable }
		'locations' { return this.locations }
		'astNode' { return this.astNode }
		'config' { return this.config }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'internalDirectives' {
			this.internalDirectives = val
			return true
		}
		'name' {
			this.name = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'args' {
			this.args = val
			return true
		}
		'isRepeatable' {
			this.isRepeatable = val
			return true
		}
		'locations' {
			this.locations = val
			return true
		}
		'astNode' {
			this.astNode = val
			return true
		}
		'config' {
			this.config = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_directive_php() {
	// unsupported statement: Stmt_Declare
}
