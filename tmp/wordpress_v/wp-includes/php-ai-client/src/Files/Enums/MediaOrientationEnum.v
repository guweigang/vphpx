import rt

pub fn Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum.square() string {
	return 'square'
}

pub fn Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum.landscape() string {
	return 'landscape'
}

pub fn Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum.portrait() string {
	return 'portrait'
}

struct Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_AbstractEnum {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_files_enums_mediaorientationenum() &Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum {
	mut obj := &Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_abstractenum() &Class_WordPress_AiClient_Common_AbstractEnum {
	mut obj := &Class_WordPress_AiClient_Common_AbstractEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Files_Enums_MediaOrientationEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_AbstractEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_php_ai_client_src_files_enums_mediaorientationenum_php() {
	// unsupported statement: Stmt_Declare
}
