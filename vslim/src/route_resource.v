module main

import vphp

fn register_resource_routes(mut app VSlimApp, raw_resource_path string, controller string, include_page_routes bool) {
	register_resource_routes_with_options(mut app, raw_resource_path, controller, include_page_routes,
		ResourceRouteOptions{})
}

fn register_singleton_routes(mut app VSlimApp, raw_resource_path string, controller string, include_page_routes bool) {
	register_singleton_routes_with_options(mut app, raw_resource_path, controller, include_page_routes,
		ResourceRouteOptions{})
}

struct ResourceRouteOptions {
mut:
	only            map[string]bool
	except          map[string]bool
	names           map[string]string
	name_prefix     string
	param_name      string = 'id'
	shallow         bool
	missing_handler vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
}

fn register_resource_routes_with_options(mut app VSlimApp, raw_resource_path string, controller string, include_page_routes bool, options ResourceRouteOptions) {
	clean_controller := controller.trim_space()
	path := normalize_resource_path(raw_resource_path)
	if clean_controller == '' || path == '' {
		return
	}
	base_name := resource_name_from_path(path)
	mut opts := options
	actions := ['index', 'create', 'store', 'show', 'edit', 'update', 'destroy']
	handler_index := make_resource_handler(clean_controller, 'index')
	handler_show := make_resource_handler(clean_controller, 'show')
	handler_store := make_resource_handler(clean_controller, 'store')
	handler_update := make_resource_handler(clean_controller, 'update')
	handler_destroy := make_resource_handler(clean_controller, 'destroy')
	handler_create := make_resource_handler(clean_controller, 'create')
	handler_edit := make_resource_handler(clean_controller, 'edit')
	id_param := normalize_resource_param_name(opts.param_name)
	member_base_path := if opts.shallow { shallow_member_base_path(path) } else { path }
	id_path := '${member_base_path}/:${id_param}'
	if handler_index.is_valid() && should_include_resource_action(opts, 'index', actions) {
		app.add_php_route_with_resource_meta('GET', resource_route_name(opts, base_name,
			'index'), path, handler_index, 'index', opts.missing_handler)
	}
	if include_page_routes && handler_create.is_valid()
		&& should_include_resource_action(opts, 'create', actions) {
		app.add_php_route_with_resource_meta('GET', resource_route_name(opts, base_name,
			'create'), '${path}/create', handler_create, 'create', opts.missing_handler)
	}
	if handler_store.is_valid() && should_include_resource_action(opts, 'store', actions) {
		app.add_php_route_with_resource_meta('POST', resource_route_name(opts, base_name,
			'store'), path, handler_store, 'store', opts.missing_handler)
	}
	if handler_show.is_valid() && should_include_resource_action(opts, 'show', actions) {
		app.add_php_route_with_resource_meta('GET', resource_route_name(opts, base_name,
			'show'), id_path, handler_show, 'show', opts.missing_handler)
	}
	if include_page_routes && handler_edit.is_valid()
		&& should_include_resource_action(opts, 'edit', actions) {
		app.add_php_route_with_resource_meta('GET', resource_route_name(opts, base_name,
			'edit'), '${id_path}/edit', handler_edit, 'edit', opts.missing_handler)
	}
	if handler_update.is_valid() && should_include_resource_action(opts, 'update', actions) {
		name := resource_route_name(opts, base_name, 'update')
		app.add_php_route_with_resource_meta('PUT', name, id_path, handler_update, 'update',
			opts.missing_handler)
		app.add_php_route_with_resource_meta('PATCH', name, id_path, handler_update, 'update',
			opts.missing_handler)
	}
	if handler_destroy.is_valid() && should_include_resource_action(opts, 'destroy', actions) {
		app.add_php_route_with_resource_meta('DELETE', resource_route_name(opts, base_name,
			'destroy'), id_path, handler_destroy, 'destroy', opts.missing_handler)
	}
}

fn register_singleton_routes_with_options(mut app VSlimApp, raw_resource_path string, controller string, include_page_routes bool, options ResourceRouteOptions) {
	clean_controller := controller.trim_space()
	path := normalize_resource_path(raw_resource_path)
	if clean_controller == '' || path == '' {
		return
	}
	base_name := resource_name_from_path(path)
	opts := options
	actions := ['show', 'create', 'store', 'edit', 'update', 'destroy']
	handler_show := make_resource_handler(clean_controller, 'show')
	handler_store := make_resource_handler(clean_controller, 'store')
	handler_update := make_resource_handler(clean_controller, 'update')
	handler_destroy := make_resource_handler(clean_controller, 'destroy')
	handler_create := make_resource_handler(clean_controller, 'create')
	handler_edit := make_resource_handler(clean_controller, 'edit')
	if handler_show.is_valid() && should_include_resource_action(opts, 'show', actions) {
		app.add_php_route_with_resource_meta('GET', resource_route_name(opts, base_name,
			'show'), path, handler_show, 'show', opts.missing_handler)
	}
	if include_page_routes && handler_create.is_valid()
		&& should_include_resource_action(opts, 'create', actions) {
		app.add_php_route_with_resource_meta('GET', resource_route_name(opts, base_name,
			'create'), '${path}/create', handler_create, 'create', opts.missing_handler)
	}
	if handler_store.is_valid() && should_include_resource_action(opts, 'store', actions) {
		app.add_php_route_with_resource_meta('POST', resource_route_name(opts, base_name,
			'store'), path, handler_store, 'store', opts.missing_handler)
	}
	if include_page_routes && handler_edit.is_valid()
		&& should_include_resource_action(opts, 'edit', actions) {
		app.add_php_route_with_resource_meta('GET', resource_route_name(opts, base_name,
			'edit'), '${path}/edit', handler_edit, 'edit', opts.missing_handler)
	}
	if handler_update.is_valid() && should_include_resource_action(opts, 'update', actions) {
		name := resource_route_name(opts, base_name, 'update')
		app.add_php_route_with_resource_meta('PUT', name, path, handler_update, 'update',
			opts.missing_handler)
		app.add_php_route_with_resource_meta('PATCH', name, path, handler_update, 'update',
			opts.missing_handler)
	}
	if handler_destroy.is_valid() && should_include_resource_action(opts, 'destroy', actions) {
		app.add_php_route_with_resource_meta('DELETE', resource_route_name(opts, base_name,
			'destroy'), path, handler_destroy, 'destroy', opts.missing_handler)
	}
}

fn make_resource_handler(controller string, action string) vphp.ZVal {
	if controller.trim_space() == '' || action.trim_space() == '' {
		return vphp.ZVal.new_null()
	}
	if vphp.class_exists(controller) {
		exists := vphp.php_call_result_bool('method_exists', [
			vphp.RequestOwnedZBox.new_string(controller).to_zval(),
			vphp.RequestOwnedZBox.new_string(action).to_zval(),
		])
		if !exists {
			return vphp.ZVal.new_null()
		}
	}
	handler := vphp.new_zval_from[[]string]([controller, action]) or { return vphp.ZVal.new_null() }
	return handler
}

fn normalize_resource_path(path string) string {
	mut clean := path.trim_space()
	if clean == '' {
		return ''
	}
	if !clean.starts_with('/') {
		clean = '/${clean}'
	}
	clean = clean.trim_right('/')
	if clean == '' {
		return '/'
	}
	return clean
}

fn resource_name_from_path(path string) string {
	mut clean := path.trim_space()
	if clean.starts_with('/') {
		clean = clean[1..]
	}
	if clean == '' {
		return 'resource'
	}
	return clean.replace('/', '.')
}

fn parse_resource_options(options vphp.RequestBorrowedZBox) ResourceRouteOptions {
	mut out := ResourceRouteOptions{
		only:            map[string]bool{}
		except:          map[string]bool{}
		names:           map[string]string{}
		name_prefix:     ''
		param_name:      'id'
		shallow:         false
		missing_handler: vphp.PersistentOwnedZBox.new_null()
	}
	if !options.is_valid() || !options.is_array() {
		return out
	}
	only_raw := options.to_zval().get('only') or { vphp.ZVal.new_null() }
	except_raw := options.to_zval().get('except') or { vphp.ZVal.new_null() }
	name_prefix_raw := options.to_zval().get('name_prefix') or { vphp.ZVal.new_null() }
	if name_prefix_raw.is_valid() && !name_prefix_raw.is_null() && !name_prefix_raw.is_undef() {
		out.name_prefix = name_prefix_raw.to_string().trim_space()
	}
	param_raw := options.to_zval().get('param') or { vphp.ZVal.new_null() }
	if param_raw.is_valid() && !param_raw.is_null() && !param_raw.is_undef() {
		out.param_name = normalize_resource_param_name(param_raw.to_string())
	}
	shallow_raw := options.to_zval().get('shallow') or { vphp.ZVal.new_null() }
	if shallow_raw.is_valid() && !shallow_raw.is_null() && !shallow_raw.is_undef() {
		out.shallow = parse_resource_bool_option(shallow_raw)
	}
	missing_raw := options.to_zval().get('missing') or { vphp.ZVal.new_null() }
	if missing_raw.is_valid() && missing_raw.is_callable() {
		out.missing_handler = vphp.PersistentOwnedZBox.from_callable_zval(missing_raw)
	}
	for action in parse_action_list(only_raw) {
		out.only[action] = true
	}
	for action in parse_action_list(except_raw) {
		out.except[action] = true
	}

	names_raw := options.to_zval().get('names') or { vphp.ZVal.new_null() }
	if names_raw.is_valid() && names_raw.is_array() {
		for key, value in names_raw.to_string_map() {
			if key.trim_space() != '' && value.trim_space() != '' {
				out.names[key.trim_space()] = value.trim_space()
			}
		}
	}
	for action in ['index', 'create', 'store', 'show', 'edit', 'update', 'destroy'] {
		alt := options.to_zval().get('name_${action}') or { vphp.ZVal.new_null() }
		if alt.is_valid() && !alt.is_null() && !alt.is_undef() && alt.to_string().trim_space() != '' {
			out.names[action] = alt.to_string().trim_space()
		}
	}
	return out
}

fn normalize_resource_param_name(param_name string) string {
	mut clean := param_name.trim_space().trim_left(':')
	if clean == '' {
		return 'id'
	}
	return clean
}

fn parse_resource_bool_option(raw vphp.ZVal) bool {
	if raw.is_bool() {
		return raw.to_bool()
	}
	if raw.is_long() {
		return raw.to_i64() != 0
	}
	if raw.is_string() {
		value := raw.to_string().trim_space().to_lower()
		return value in ['1', 'true', 'yes', 'on']
	}
	return false
}

fn shallow_member_base_path(path string) string {
	mut clean := normalize_resource_path(path)
	if clean == '' || clean == '/' {
		return clean
	}
	segments := clean.trim_left('/').split('/').filter(it.len > 0)
	if segments.len == 0 {
		return clean
	}
	last_segment := segments[segments.len - 1]
	return '/${last_segment}'
}

fn parse_action_list(raw vphp.ZVal) []string {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return []string{}
	}
	if raw.is_array() {
		mut out := []string{}
		for item in raw.to_string_list() {
			clean := item.trim_space().to_lower()
			if clean != '' && clean !in out {
				out << clean
			}
		}
		return out
	}
	mut out := []string{}
	for part in raw.to_string().split(',') {
		clean := part.trim_space().to_lower()
		if clean != '' && clean !in out {
			out << clean
		}
	}
	return out
}

fn should_include_resource_action(opts ResourceRouteOptions, action string, all_actions []string) bool {
	if opts.only.len > 0 {
		return action in opts.only
	}
	if action in opts.except {
		return false
	}
	return action in all_actions
}

fn resource_route_name(opts ResourceRouteOptions, base_name string, action string) string {
	if action in opts.names {
		return opts.names[action]
	}
	if opts.name_prefix.trim_space() != '' {
		return '${opts.name_prefix}.${action}'
	}
	return '${base_name}.${action}'
}
