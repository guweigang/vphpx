import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema.identifier() string {
	return 'image'
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema {
	rt.PhpObjectBase
pub mut:
	title rt.PhpVal = rt.new_string('image')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema) get_properties() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Image ID.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
		]) },
		rt.ArrayItem{ key: 'src', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Full size image URL.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'uri' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
		]) },
		rt.ArrayItem{ key: 'thumbnail', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Thumbnail URL.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'uri' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
		]) },
		rt.ArrayItem{ key: 'srcset', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Full size image srcset for responsive images.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
		]) },
		rt.ArrayItem{ key: 'sizes', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Full size image sizes for responsive images.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
		]) },
		rt.ArrayItem{ key: 'thumbnail_srcset', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Thumbnail srcset for responsive images.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
		]) },
		rt.ArrayItem{ key: 'thumbnail_sizes', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Thumbnail sizes for responsive images.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
		]) },
		rt.ArrayItem{ key: 'name', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Image name.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
		]) },
		rt.ArrayItem{ key: 'alt', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Image alternative text.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema) get_item_response(var_attachment_id rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attachment_id)))) {
		return rt.new_null()
	}
	mut var_attachment := rt.call_function('wp_get_attachment_image_src', [
		var_attachment_id.clone(), rt.new_string('full')])
	if !(var_attachment.clone().is_array()) {
		return rt.new_null()
	}
	mut var_thumbnail := rt.call_function('wp_get_attachment_image_src', [
		var_attachment_id.clone(), rt.new_string('woocommerce_thumbnail')])
	return rt.new_object('stdClass', []string{}, rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.new_int(var_attachment_id.to_i64()) },
		rt.ArrayItem{ key: 'src', val: rt.call_function('current', [
			var_attachment.clone()]) },
		rt.ArrayItem{ key: 'thumbnail', val: rt.call_function('current', [
			var_thumbnail.clone()]) },
		rt.ArrayItem{ key: 'srcset', val: (rt.call_function('wp_get_attachment_image_srcset', [
			var_attachment_id.clone(), rt.new_string('full')])).str() },
		rt.ArrayItem{ key: 'sizes', val: (rt.call_function('wp_get_attachment_image_sizes', [
			var_attachment_id.clone(), rt.new_string('full')])).str() },
		rt.ArrayItem{ key: 'thumbnail_srcset', val: (rt.call_function('wp_get_attachment_image_srcset', [
			var_attachment_id.clone(), rt.new_string('woocommerce_thumbnail')])).str() },
		rt.ArrayItem{ key: 'thumbnail_sizes', val: (rt.call_function('wp_get_attachment_image_sizes', [
			var_attachment_id.clone(), rt.new_string('woocommerce_thumbnail')])).str() },
		rt.ArrayItem{ key: 'name', val: rt.call_function('get_the_title', [
			var_attachment_id.clone()]) },
		rt.ArrayItem{ key: 'alt', val: rt.call_function('get_post_meta', [
			var_attachment_id.clone(), rt.new_string('_wp_attachment_image_alt'),
			rt.new_bool(true)]) },
	])))
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_imageattachmentschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title:         rt.new_string('image')
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_properties' {
			return this.get_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' {
			this.title = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
