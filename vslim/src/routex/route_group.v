module routex

import vphp

@[vphp.PhpExportClass(name: 'VSlim\\RouteGroup')]
@[heap]
pub struct RouteGroup {
mut:
	app_ref vphp.PhpObject = vphp.PhpObject.invalid() @[vphp.PhpIgnoreField]
	prefix  string
}

pub fn RouteGroup.empty() &RouteGroup {
	return &RouteGroup{}
}

pub fn RouteGroup.from_app_object(app vphp.PhpObject, prefix string) &RouteGroup {
	return &RouteGroup{
		app_ref: app.retain()
		prefix:  normalize_group_prefix(prefix)
	}
}

pub fn (mut group RouteGroup) cleanup() {
	mut app := group.app_ref
	app.release()
	group.app_ref = vphp.PhpObject.invalid()
}

fn (group &RouteGroup) app_object() ?vphp.PhpObject {
	if !group.app_ref.is_valid() {
		return none
	}
	return group.app_ref.retain()
}

fn (group &RouteGroup) normalized_prefix() string {
	return normalize_group_prefix(group.prefix)
}

fn (group &RouteGroup) prefixed_pattern(pattern string) string {
	return prefixed_group_pattern(group.prefix, pattern)
}

fn (group &RouteGroup) call_app(method string, args ...vphp.PhpArgInput) {
	mut app := group.app_object() or { return }
	defer {
		app.release()
	}
	mut result := app.call_method(method, ...args)
	result.release()
}

fn (group &RouteGroup) call_app_with_pattern(method string, pattern string, handler vphp.PhpValue) {
	mut pattern_arg := vphp.PhpString.of(group.prefixed_pattern(pattern))
	defer {
		pattern_arg.release()
	}
	group.call_app(method, pattern_arg, handler)
}

fn (group &RouteGroup) call_app_named_with_pattern(method string, name string, pattern string, handler vphp.PhpValue) {
	mut name_arg := vphp.PhpString.of(name)
	mut pattern_arg := vphp.PhpString.of(group.prefixed_pattern(pattern))
	defer {
		name_arg.release()
		pattern_arg.release()
	}
	group.call_app(method, name_arg, pattern_arg, handler)
}

fn (group &RouteGroup) call_app_resource(method string, resource_path string, controller string) {
	mut path_arg := vphp.PhpString.of(group.prefixed_pattern(resource_path))
	mut controller_arg := vphp.PhpString.of(controller)
	defer {
		path_arg.release()
		controller_arg.release()
	}
	group.call_app(method, path_arg, controller_arg)
}

fn (group &RouteGroup) call_app_resource_opts(method string, resource_path string, controller string, options vphp.PhpArray) {
	mut path_arg := vphp.PhpString.of(group.prefixed_pattern(resource_path))
	mut controller_arg := vphp.PhpString.of(controller)
	defer {
		path_arg.release()
		controller_arg.release()
	}
	group.call_app(method, path_arg, controller_arg, options)
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) group(prefix string) &RouteGroup {
	mut app := group.app_object() or { return RouteGroup.empty() }
	defer {
		app.release()
	}
	return RouteGroup.from_app_object(app, prefixed_group_pattern(group.prefix, prefix))
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) middleware(handler vphp.PhpValue) &RouteGroup {
	mut prefix_arg := vphp.PhpString.of(group.normalized_prefix())
	defer {
		prefix_arg.release()
	}
	group.call_app('groupMiddleware', prefix_arg, handler)
	return group
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) before(handler vphp.PhpValue) &RouteGroup {
	mut prefix_arg := vphp.PhpString.of(group.normalized_prefix())
	defer {
		prefix_arg.release()
	}
	group.call_app('groupBefore', prefix_arg, handler)
	return group
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) after(handler vphp.PhpValue) &RouteGroup {
	mut prefix_arg := vphp.PhpString.of(group.normalized_prefix())
	defer {
		prefix_arg.release()
	}
	group.call_app('groupAfter', prefix_arg, handler)
	return group
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) get(pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_with_pattern('get', pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) post(pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_with_pattern('post', pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) put(pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_with_pattern('put', pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) head(pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_with_pattern('head', pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) options(pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_with_pattern('options', pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) patch(pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_with_pattern('patch', pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) delete(pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_with_pattern('delete', pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) any(pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_with_pattern('any', pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) live(pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_with_pattern('live', pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) websocket(pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_with_pattern('websocket', pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) map(methods vphp.PhpValue, pattern string, handler vphp.PhpValue) &RouteGroup {
	mut pattern_arg := vphp.PhpString.of(group.prefixed_pattern(pattern))
	defer {
		pattern_arg.release()
	}
	group.call_app('map', methods, pattern_arg, handler)
	return group
}

@[vphp.PhpExportMethod(name: 'getNamed')]
pub fn (group &RouteGroup) get_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_named_with_pattern('getNamed', name, pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: 'postNamed')]
pub fn (group &RouteGroup) post_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_named_with_pattern('postNamed', name, pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: 'putNamed')]
pub fn (group &RouteGroup) put_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_named_with_pattern('putNamed', name, pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: 'headNamed')]
pub fn (group &RouteGroup) head_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_named_with_pattern('headNamed', name, pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: 'optionsNamed')]
pub fn (group &RouteGroup) options_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_named_with_pattern('optionsNamed', name, pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: 'patchNamed')]
pub fn (group &RouteGroup) patch_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_named_with_pattern('patchNamed', name, pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: 'deleteNamed')]
pub fn (group &RouteGroup) delete_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_named_with_pattern('deleteNamed', name, pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: 'anyNamed')]
pub fn (group &RouteGroup) any_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_named_with_pattern('anyNamed', name, pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: 'websocketNamed')]
pub fn (group &RouteGroup) websocket_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	group.call_app_named_with_pattern('websocketNamed', name, pattern, handler)
	return group
}

@[vphp.PhpExportMethod(name: 'mapNamed')]
pub fn (group &RouteGroup) map_named(methods vphp.PhpValue, name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	mut name_arg := vphp.PhpString.of(name)
	mut pattern_arg := vphp.PhpString.of(group.prefixed_pattern(pattern))
	defer {
		name_arg.release()
		pattern_arg.release()
	}
	group.call_app('mapNamed', methods, name_arg, pattern_arg, handler)
	return group
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) resource(resource_path string, controller string) &RouteGroup {
	group.call_app_resource('resource', resource_path, controller)
	return group
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: 'apiResource')]
pub fn (group &RouteGroup) api_resource(resource_path string, controller string) &RouteGroup {
	group.call_app_resource('apiResource', resource_path, controller)
	return group
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: '')]
pub fn (group &RouteGroup) singleton(resource_path string, controller string) &RouteGroup {
	group.call_app_resource('singleton', resource_path, controller)
	return group
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: 'apiSingleton')]
pub fn (group &RouteGroup) api_singleton(resource_path string, controller string) &RouteGroup {
	group.call_app_resource('apiSingleton', resource_path, controller)
	return group
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: 'resourceOpts')]
pub fn (group &RouteGroup) resource_opts(resource_path string, controller string, options vphp.PhpArray) &RouteGroup {
	group.call_app_resource_opts('resourceOpts', resource_path, controller, options)
	return group
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: 'apiResourceOpts')]
pub fn (group &RouteGroup) api_resource_opts(resource_path string, controller string, options vphp.PhpArray) &RouteGroup {
	group.call_app_resource_opts('apiResourceOpts', resource_path, controller, options)
	return group
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: 'singletonOpts')]
pub fn (group &RouteGroup) singleton_opts(resource_path string, controller string, options vphp.PhpArray) &RouteGroup {
	group.call_app_resource_opts('singletonOpts', resource_path, controller, options)
	return group
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: 'apiSingletonOpts')]
pub fn (group &RouteGroup) api_singleton_opts(resource_path string, controller string, options vphp.PhpArray) &RouteGroup {
	group.call_app_resource_opts('apiSingletonOpts', resource_path, controller, options)
	return group
}
