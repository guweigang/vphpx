import rt

struct Class_WP_Customize_Cropped_Image_Control {
	rt.PhpObjectBase
pub mut:
	prop_type   rt.PhpVal = rt.new_string('cropped_image')
	width       rt.PhpVal = rt.new_int(150)
	height      rt.PhpVal = rt.new_int(150)
	flex_width  rt.PhpVal = rt.new_bool(false)
	flex_height rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WP_Customize_Cropped_Image_Control) enqueue() {
	rt.call_function('wp_enqueue_script', [rt.new_string('customize-views')])
	this.Class_WP_Customize_Image_Control.enqueue()
}

fn (mut this Class_WP_Customize_Cropped_Image_Control) to_json() {
	this.Class_WP_Customize_Image_Control.to_json()
	rt.get_property(rt.new_object('WP_Customize_Cropped_Image_Control', [
		'WP_Customize_Image_Control',
	], &this), 'json').array_set('width', rt.call_function('absint', [this.width]))
	rt.get_property(rt.new_object('WP_Customize_Cropped_Image_Control', [
		'WP_Customize_Image_Control',
	], &this), 'json').array_set('height', rt.call_function('absint', [this.height]))
	rt.get_property(rt.new_object('WP_Customize_Cropped_Image_Control', [
		'WP_Customize_Image_Control',
	], &this), 'json').array_set('flex_width', rt.call_function('absint', [this.flex_width]))
	rt.get_property(rt.new_object('WP_Customize_Cropped_Image_Control', [
		'WP_Customize_Image_Control',
	], &this), 'json').array_set('flex_height', rt.call_function('absint', [
		this.flex_height,
	]))
}

struct Class_WP_Customize_Image_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_cropped_image_control(_args ...rt.PhpVal) &Class_WP_Customize_Cropped_Image_Control {
	mut obj := &Class_WP_Customize_Cropped_Image_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('cropped_image')
		width:         rt.new_int(150)
		height:        rt.new_int(150)
		flex_width:    rt.new_bool(false)
		flex_height:   rt.new_bool(false)
	}
	return obj
}

fn create_wp_customize_image_control(_args ...rt.PhpVal) &Class_WP_Customize_Image_Control {
	mut obj := &Class_WP_Customize_Image_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Cropped_Image_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'enqueue' {
			this.enqueue()
			return rt.new_null()
		}
		'to_json' {
			this.to_json()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Cropped_Image_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'width' { return this.width }
		'height' { return this.height }
		'flex_width' { return this.flex_width }
		'flex_height' { return this.flex_height }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Cropped_Image_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'width' {
			this.width = val
			return true
		}
		'height' {
			this.height = val
			return true
		}
		'flex_width' {
			this.flex_width = val
			return true
		}
		'flex_height' {
			this.flex_height = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Customize_Image_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Image_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Image_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
