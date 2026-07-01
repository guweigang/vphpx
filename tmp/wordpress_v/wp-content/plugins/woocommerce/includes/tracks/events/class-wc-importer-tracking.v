import rt

struct Class_WC_Importer_Tracking {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Importer_Tracking) init()  {
	rt.call_function('add_action', [rt.new_string('product_page_product_importer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Importer_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_product_importer' }])])
}

fn (mut this Class_WC_Importer_Tracking) track_product_importer() rt.PhpVal {
	if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('step'))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('import'), rt.get_superglobal('_REQUEST').array_get('step'))) {
		this.track_product_importer_start()
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('done'), rt.get_superglobal('_REQUEST').array_get('step'))) {
		this.track_product_importer_complete()
		return rt.new_null()
	}
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_WC_Importer_Tracking) track_product_importer_start()  {
	if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('file'))) || !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('_wpnonce'))) {
		return rt.new_null()
	}
	mut var_properties := { 'update_existing': if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('update_existing')) { // unsupported expression: Expr_Cast_Bool } else { rt.new_bool(false) }, 'delimiter': if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('delimiter')) { rt.new_string(',') } else { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('delimiter')])]) } }
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('product_import_start'), var_properties.dup())
}

fn (mut this Class_WC_Importer_Tracking) track_product_importer_complete()  {
	if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('nonce'))) {
		return rt.new_null()
	}
	mut var_properties := { 'imported': if rt.get_superglobal('_GET').array_isset(rt.new_string('products-imported')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get('products-imported')]) } else { rt.new_int(0) }, 'imported_variations': if rt.get_superglobal('_GET').array_isset(rt.new_string('products-imported-variations')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get('products-imported-variations')]) } else { rt.new_int(0) }, 'updated': if rt.get_superglobal('_GET').array_isset(rt.new_string('products-updated')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get('products-updated')]) } else { rt.new_int(0) }, 'failed': if rt.get_superglobal('_GET').array_isset(rt.new_string('products-failed')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get('products-failed')]) } else { rt.new_int(0) }, 'skipped': if rt.get_superglobal('_GET').array_isset(rt.new_string('products-skipped')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get('products-skipped')]) } else { rt.new_int(0) } }
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('product_import_complete'), var_properties.dup())
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn create_wc_importer_tracking() &Class_WC_Importer_Tracking {
	mut obj := &Class_WC_Importer_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks() &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Importer_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'track_product_importer' {
			return this.track_product_importer()
		}
		'track_product_importer_start' {
			this.track_product_importer_start()
			return rt.new_null()
		}
		'track_product_importer_complete' {
			this.track_product_importer_complete()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Importer_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Importer_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_tracks_events_class_wc_importer_tracking_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
