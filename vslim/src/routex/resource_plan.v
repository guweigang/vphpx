module routex

import routingx
import vphp

pub struct ResourceRoutePlanItem {
pub:
	method          string
	name            string
	pattern         string
	handler         vphp.PhpValue
	action          string
	missing_handler vphp.PhpCallable
}

pub fn resource_route_plan(raw_resource_path string, controller string, include_page_routes bool, options ResourceRouteOptions) []ResourceRoutePlanItem {
	clean_controller := controller.trim_space()
	path := routingx.Resource.normalize_path(raw_resource_path)
	if clean_controller == '' || path == '' {
		return []ResourceRoutePlanItem{}
	}
	base_name := routingx.Resource.name_from_path(path)
	opts := options
	actions := ['index', 'create', 'store', 'show', 'edit', 'update', 'destroy']
	handler_index := make_resource_handler(clean_controller, 'index')
	handler_show := make_resource_handler(clean_controller, 'show')
	handler_store := make_resource_handler(clean_controller, 'store')
	handler_update := make_resource_handler(clean_controller, 'update')
	handler_destroy := make_resource_handler(clean_controller, 'destroy')
	handler_create := make_resource_handler(clean_controller, 'create')
	handler_edit := make_resource_handler(clean_controller, 'edit')
	id_param := routingx.Resource.normalize_param_name(opts.param_name)
	member_base_path := if opts.shallow {
		routingx.Resource.shallow_member_base_path(path)
	} else {
		path
	}
	id_path := '${member_base_path}/:${id_param}'
	mut out := []ResourceRoutePlanItem{}
	if handler_index.is_valid() && opts.should_include_action('index', actions) {
		out << resource_route_plan_item('GET', opts.route_name(base_name, 'index'), path,
			handler_index, 'index', opts.missing_handler)
	}
	if include_page_routes && handler_create.is_valid()
		&& opts.should_include_action('create', actions) {
		out << resource_route_plan_item('GET', opts.route_name(base_name, 'create'),
			'${path}/create', handler_create, 'create', opts.missing_handler)
	}
	if handler_store.is_valid() && opts.should_include_action('store', actions) {
		out << resource_route_plan_item('POST', opts.route_name(base_name, 'store'), path,
			handler_store, 'store', opts.missing_handler)
	}
	if handler_show.is_valid() && opts.should_include_action('show', actions) {
		out << resource_route_plan_item('GET', opts.route_name(base_name, 'show'), id_path,
			handler_show, 'show', opts.missing_handler)
	}
	if include_page_routes && handler_edit.is_valid() && opts.should_include_action('edit', actions) {
		out << resource_route_plan_item('GET', opts.route_name(base_name, 'edit'),
			'${id_path}/edit', handler_edit, 'edit', opts.missing_handler)
	}
	if handler_update.is_valid() && opts.should_include_action('update', actions) {
		name := opts.route_name(base_name, 'update')
		out << resource_route_plan_item('PUT', name, id_path, handler_update, 'update',
			opts.missing_handler)
		out << resource_route_plan_item('PATCH', name, id_path, handler_update, 'update',
			opts.missing_handler)
	}
	if handler_destroy.is_valid() && opts.should_include_action('destroy', actions) {
		out << resource_route_plan_item('DELETE', opts.route_name(base_name, 'destroy'), id_path,
			handler_destroy, 'destroy', opts.missing_handler)
	}
	return out
}

pub fn singleton_route_plan(raw_resource_path string, controller string, include_page_routes bool, options ResourceRouteOptions) []ResourceRoutePlanItem {
	clean_controller := controller.trim_space()
	path := routingx.Resource.normalize_path(raw_resource_path)
	if clean_controller == '' || path == '' {
		return []ResourceRoutePlanItem{}
	}
	base_name := routingx.Resource.name_from_path(path)
	opts := options
	actions := ['show', 'create', 'store', 'edit', 'update', 'destroy']
	handler_show := make_resource_handler(clean_controller, 'show')
	handler_store := make_resource_handler(clean_controller, 'store')
	handler_update := make_resource_handler(clean_controller, 'update')
	handler_destroy := make_resource_handler(clean_controller, 'destroy')
	handler_create := make_resource_handler(clean_controller, 'create')
	handler_edit := make_resource_handler(clean_controller, 'edit')
	mut out := []ResourceRoutePlanItem{}
	if handler_show.is_valid() && opts.should_include_action('show', actions) {
		out << resource_route_plan_item('GET', opts.route_name(base_name, 'show'), path,
			handler_show, 'show', opts.missing_handler)
	}
	if include_page_routes && handler_create.is_valid()
		&& opts.should_include_action('create', actions) {
		out << resource_route_plan_item('GET', opts.route_name(base_name, 'create'),
			'${path}/create', handler_create, 'create', opts.missing_handler)
	}
	if handler_store.is_valid() && opts.should_include_action('store', actions) {
		out << resource_route_plan_item('POST', opts.route_name(base_name, 'store'), path,
			handler_store, 'store', opts.missing_handler)
	}
	if include_page_routes && handler_edit.is_valid() && opts.should_include_action('edit', actions) {
		out << resource_route_plan_item('GET', opts.route_name(base_name, 'edit'), '${path}/edit',
			handler_edit, 'edit', opts.missing_handler)
	}
	if handler_update.is_valid() && opts.should_include_action('update', actions) {
		name := opts.route_name(base_name, 'update')
		out << resource_route_plan_item('PUT', name, path, handler_update, 'update',
			opts.missing_handler)
		out << resource_route_plan_item('PATCH', name, path, handler_update, 'update',
			opts.missing_handler)
	}
	if handler_destroy.is_valid() && opts.should_include_action('destroy', actions) {
		out << resource_route_plan_item('DELETE', opts.route_name(base_name, 'destroy'), path,
			handler_destroy, 'destroy', opts.missing_handler)
	}
	return out
}

fn resource_route_plan_item(method string, name string, pattern string, handler vphp.PhpValue, action string, missing_handler vphp.PhpCallable) ResourceRoutePlanItem {
	return ResourceRoutePlanItem{
		method:          method
		name:            name
		pattern:         pattern
		handler:         handler
		action:          action
		missing_handler: missing_handler
	}
}
