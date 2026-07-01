import rt

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_Email_CustomerNewAccount {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Email_CustomerNewAccount) construct(mut var_package Class_Automattic_WooCommerce_Blocks_Domain_Package) {
	this.Class_Automattic_WooCommerce_Blocks_Domain_Services_Email_WC_Email.construct()
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_Email_WC_Email {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_domain_services_email_customernewaccount(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_Email_CustomerNewAccount {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_Email_CustomerNewAccount{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_email_wc_email() &Class_Automattic_WooCommerce_Blocks_Domain_Services_Email_WC_Email {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_Email_WC_Email{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Email_CustomerNewAccount) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_Email_CustomerNewAccount) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Email_CustomerNewAccount) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Email_WC_Email) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_Email_WC_Email) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Email_WC_Email) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_domain_services_email_customernewaccount_php() {
	// unsupported statement: Stmt_Declare
}
