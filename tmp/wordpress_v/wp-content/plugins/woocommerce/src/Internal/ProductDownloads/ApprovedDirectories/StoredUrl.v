import rt

struct Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl {
	rt.PhpObjectBase
pub mut:
	id      i64
	url     string
	enabled bool
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl) construct(id i64, url string, enabled bool) {
	this.id = id
	this.url = url
	this.enabled = enabled
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl) get_id() i64 {
	return this.id
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl) get_url() string {
	return this.url
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl) is_enabled() bool {
	return this.enabled
}

fn create_automattic_woocommerce_internal_productdownloads_approveddirectories_storedurl(id i64, url string, enabled bool) &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl{
		PhpObjectBase: rt.PhpObjectBase{}
		id:            i64(0)
		url:           ''
		enabled:       false
	}
	obj.construct(id, url, enabled)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_id' {
			return rt.new_int(this.get_id())
		}
		'get_url' {
			return rt.new_string(this.get_url())
		}
		'is_enabled' {
			return rt.new_bool(this.is_enabled())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return rt.new_int(this.id) }
		'url' { return rt.new_string(this.url) }
		'enabled' { return rt.new_bool(this.enabled) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val.to_i64()
			return true
		}
		'url' {
			this.url = val.str()
			return true
		}
		'enabled' {
			this.enabled = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_internal_productdownloads_approveddirectories_storedurl_php() {
}
