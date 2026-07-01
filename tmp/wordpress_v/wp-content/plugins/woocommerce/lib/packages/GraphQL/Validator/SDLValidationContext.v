import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext {
	rt.PhpObjectBase
pub mut:
		ast rt.PhpVal = rt.new_null()
		schema rt.PhpVal = rt.new_null()
		errors rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) construct(mut var_ast Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_?Schema)  {
	this.ast = var_ast.dup()
	this.schema = var_schema.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) reporterror(mut var_error Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error)  {
	this.errors.array_push(var_error.dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) geterrors() rt.PhpVal {
	return this.errors
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) getdocument() rt.PhpVal {
	return this.ast
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) getschema() rt.PhpVal {
	return this.schema
}

fn create_automattic_woocommerce_vendor_graphql_validator_sdlvalidationcontext(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext{
		PhpObjectBase: rt.PhpObjectBase{}
		ast: rt.new_null()
		schema: rt.new_null()
		errors: rt.new_array()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_?Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'reportError' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error](if args.len > 0 { args[0] } else { rt.new_null() })
			this.reporterror(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getErrors' {
			return this.geterrors()
		}
		'getDocument' {
			return this.getdocument()
		}
		'getSchema' {
			return this.getschema()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'ast' { return this.ast }
		'schema' { return this.schema }
		'errors' { return this.errors }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'ast' { this.ast = val; return true }
		'schema' { this.schema = val; return true }
		'errors' { this.errors = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_sdlvalidationcontext_php() {
	// unsupported statement: Stmt_Declare
}
