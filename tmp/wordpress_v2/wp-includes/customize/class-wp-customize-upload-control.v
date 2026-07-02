import rt

struct Class_WP_Customize_Upload_Control {
	rt.PhpObjectBase
pub mut:
	prop_type     rt.PhpVal = rt.new_string('upload')
	mime_type     rt.PhpVal = rt.new_string('')
	button_labels rt.PhpVal = rt.new_array()
	removed       rt.PhpVal = rt.new_string('')
	context       rt.PhpVal = rt.new_null()
	extensions    rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Customize_Upload_Control) to_json() {
	this.Class_WP_Customize_Media_Control.to_json()
	mut var_value := this.value()
	if rt.is_true(var_value) {
		mut var_attachment_id := rt.call_function('attachment_url_to_postid', [
			var_value.clone(),
		])
		if rt.is_true(var_attachment_id) {
			rt.get_property(rt.new_object('WP_Customize_Upload_Control', [
				'WP_Customize_Media_Control',
			], &this), 'json').array_set('attachment', rt.call_function('wp_prepare_attachment_for_js', [
				var_attachment_id.clone(),
			]))
		}
	}
}

struct Class_WP_Customize_Media_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_upload_control(_args ...rt.PhpVal) &Class_WP_Customize_Upload_Control {
	mut obj := &Class_WP_Customize_Upload_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('upload')
		mime_type:     rt.new_string('')
		button_labels: rt.new_array()
		removed:       rt.new_string('')
		context:       rt.new_null()
		extensions:    rt.new_array()
	}
	return obj
}

fn create_wp_customize_media_control(_args ...rt.PhpVal) &Class_WP_Customize_Media_Control {
	mut obj := &Class_WP_Customize_Media_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Upload_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'to_json' {
			this.to_json()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Upload_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'mime_type' { return this.mime_type }
		'button_labels' { return this.button_labels }
		'removed' { return this.removed }
		'context' { return this.context }
		'extensions' { return this.extensions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Upload_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'mime_type' {
			this.mime_type = val
			return true
		}
		'button_labels' {
			this.button_labels = val
			return true
		}
		'removed' {
			this.removed = val
			return true
		}
		'context' {
			this.context = val
			return true
		}
		'extensions' {
			this.extensions = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Customize_Media_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Media_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Media_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
