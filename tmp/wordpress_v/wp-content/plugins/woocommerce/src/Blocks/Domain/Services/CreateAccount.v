import rt

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CreateAccount {
	rt.PhpObjectBase
pub mut:
	package rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CreateAccount) construct(mut var_package Class_Automattic_WooCommerce_Blocks_Domain_Package) {
	this.package = var_package.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CreateAccount) init() {
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CreateAccount) customer_new_account(customer_id i64, mut var_new_customer_data Class_Automattic_WooCommerce_Blocks_Domain_Services_array) {
	// unsupported statement: Stmt_Nop
}

fn create_automattic_woocommerce_blocks_domain_services_createaccount(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CreateAccount {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CreateAccount{
		PhpObjectBase: rt.PhpObjectBase{}
		package:       rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CreateAccount) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Package](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'customer_new_account' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Services_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.customer_new_account(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CreateAccount) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'package' { return this.package }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CreateAccount) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'package' {
			this.package = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_domain_services_createaccount_php() {
	// unsupported statement: Stmt_Declare
}
