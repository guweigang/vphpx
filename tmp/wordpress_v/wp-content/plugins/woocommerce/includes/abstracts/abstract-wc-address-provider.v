import rt

struct Class_WC_Address_Provider {
	rt.PhpObjectBase
pub mut:
	id            rt.PhpVal = rt.new_null()
	name          rt.PhpVal = rt.new_null()
	branding_html rt.PhpVal = rt.new_string('')
}

fn create_wc_address_provider() &Class_WC_Address_Provider {
	mut obj := &Class_WC_Address_Provider{
		PhpObjectBase: rt.PhpObjectBase{}
		id:            rt.new_null()
		name:          rt.new_null()
		branding_html: rt.new_string('')
	}
	return obj
}

fn (mut this Class_WC_Address_Provider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Address_Provider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'name' { return this.name }
		'branding_html' { return this.branding_html }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Address_Provider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		'name' {
			this.name = val
			return true
		}
		'branding_html' {
			this.branding_html = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_includes_abstracts_abstract_wc_address_provider_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
