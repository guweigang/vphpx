module main

import vphp

fn (mut app VSlimApp) register_resource_routes(raw_resource_path string, controller string, include_page_routes bool) {
	app.register_resource_routes_with_options(raw_resource_path, controller, include_page_routes,
		ResourceRouteOptions{})
}

fn (mut app VSlimApp) register_singleton_routes(raw_resource_path string, controller string, include_page_routes bool) {
	app.register_singleton_routes_with_options(raw_resource_path, controller, include_page_routes,
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
	missing_handler vphp.PhpCallable = vphp.PhpCallable.invalid()
}

fn (mut app VSlimApp) register_resource_routes_with_options(raw_resource_path string, controller string, include_page_routes bool, options ResourceRouteOptions) {
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
	if handler_index.is_valid() && opts.should_include_action('index', actions) {
		app.add_route_with_resource_meta('GET', opts.route_name(base_name,
			'index'), path, handler_index, 'index', opts.missing_handler)
	}
	if include_page_routes && handler_create.is_valid()
		&& opts.should_include_action('create', actions) {
		app.add_route_with_resource_meta('GET', opts.route_name(base_name,
			'create'), '${path}/create', handler_create, 'create', opts.missing_handler)
	}
	if handler_store.is_valid() && opts.should_include_action('store', actions) {
		app.add_route_with_resource_meta('POST', opts.route_name(base_name,
			'store'), path, handler_store, 'store', opts.missing_handler)
	}
	if handler_show.is_valid() && opts.should_include_action('show', actions) {
		app.add_route_with_resource_meta('GET', opts.route_name(base_name,
			'show'), id_path, handler_show, 'show', opts.missing_handler)
	}
	if include_page_routes && handler_edit.is_valid()
		&& opts.should_include_action('edit', actions) {
		app.add_route_with_resource_meta('GET', opts.route_name(base_name,
			'edit'), '${id_path}/edit', handler_edit, 'edit', opts.missing_handler)
	}
	if handler_update.is_valid() && opts.should_include_action('update', actions) {
		name := opts.route_name(base_name, 'update')
		app.add_route_with_resource_meta('PUT', name, id_path, handler_update, 'update',
			opts.missing_handler)
		app.add_route_with_resource_meta('PATCH', name, id_path, handler_update, 'update',
			opts.missing_handler)
	}
	if handler_destroy.is_valid() && opts.should_include_action('destroy', actions) {
		app.add_route_with_resource_meta('DELETE', opts.route_name(base_name,
			'destroy'), id_path, handler_destroy, 'destroy', opts.missing_handler)
	}
}

fn (mut app VSlimApp) register_singleton_routes_with_options(raw_resource_path string, controller string, include_page_routes bool, options ResourceRouteOptions) {
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
	if handler_show.is_valid() && opts.should_include_action('show', actions) {
		app.add_route_with_resource_meta('GET', opts.route_name(base_name,
			'show'), path, handler_show, 'show', opts.missing_handler)
	}
	if include_page_routes && handler_create.is_valid()
		&& opts.should_include_action('create', actions) {
		app.add_route_with_resource_meta('GET', opts.route_name(base_name,
			'create'), '${path}/create', handler_create, 'create', opts.missing_handler)
	}
	if handler_store.is_valid() && opts.should_include_action('store', actions) {
		app.add_route_with_resource_meta('POST', opts.route_name(base_name,
			'store'), path, handler_store, 'store', opts.missing_handler)
	}
	if include_page_routes && handler_edit.is_valid()
		&& opts.should_include_action('edit', actions) {
		app.add_route_with_resource_meta('GET', opts.route_name(base_name,
			'edit'), '${path}/edit', handler_edit, 'edit', opts.missing_handler)
	}
	if handler_update.is_valid() && opts.should_include_action('update', actions) {
		name := opts.route_name(base_name, 'update')
		app.add_route_with_resource_meta('PUT', name, path, handler_update, 'update',
			opts.missing_handler)
		app.add_route_with_resource_meta('PATCH', name, path, handler_update, 'update',
			opts.missing_handler)
	}
	if handler_destroy.is_valid() && opts.should_include_action('destroy', actions) {
		app.add_route_with_resource_meta('DELETE', opts.route_name(base_name,
			'destroy'), path, handler_destroy, 'destroy', opts.missing_handler)
	}
}

fn make_resource_handler(controller string, action string) vphp.PhpValue {
	if controller.trim_space() == '' || action.trim_space() == '' {
		return vphp.PhpValue.null()
	}
	if vphp.PhpClass.named(controller).exists() {
		mut controller_arg := vphp.PhpString.of(controller)
		mut action_arg := vphp.PhpString.of(action)
		defer {
			controller_arg.release()
			action_arg.release()
		}
		exists := vphp.PhpFunction.named('method_exists').result_bool(controller_arg, action_arg)
		if !exists {
			return vphp.PhpValue.null()
		}
	}
	mut handler := vphp.PhpArray.new()
	handler.push_string(controller)
	handler.push_string(action)
	return handler.take_value()
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

fn ResourceRouteOptions.from_options(options vphp.PhpArray) ResourceRouteOptions {
	mut out := ResourceRouteOptions{
		only:            map[string]bool{}
		except:          map[string]bool{}
		names:           map[string]string{}
		name_prefix:     ''
		param_name:      'id'
		shallow:         false
		missing_handler: vphp.PhpCallable.invalid()
	}
	if !options.is_valid() {
		return out
	}
	only_value := options['only']
	except_value := options['except']
	name_prefix := options['name_prefix']
	if is_present_resource_option(name_prefix) {
		out.name_prefix = name_prefix.to_string().trim_space()
	}
	param := options['param']
	if is_present_resource_option(param) {
		out.param_name = normalize_resource_param_name(param.to_string())
	}
	shallow := options['shallow']
	if is_present_resource_option(shallow) {
		out.shallow = value_subject(shallow).resource_bool_option()
	}
	missing := options['missing']
	if handler := missing.as_callable() {
		out.missing_handler = handler.retain()
	}
	for action in value_subject(only_value).resource_action_list() {
		out.only[action] = true
	}
	for action in value_subject(except_value).resource_action_list() {
		out.except[action] = true
	}

	names := options['names'].as_array() or { vphp.PhpArray.empty() }
	if names.is_valid() {
		for key, value in names.to_string_map() {
			if key.trim_space() != '' && value.trim_space() != '' {
				out.names[key.trim_space()] = value.trim_space()
			}
		}
	}
	for action in ['index', 'create', 'store', 'show', 'edit', 'update', 'destroy'] {
		alt := options['name_${action}']
		if is_present_resource_option(alt) && alt.to_string().trim_space() != '' {
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

fn is_present_resource_option(value vphp.PhpValue) bool {
	return value.is_valid() && !value.is_null() && !value.is_undef()
}

fn (subject PhpValueSubject) resource_bool_option() bool {
	value := subject.value
	if value.is_bool() {
		return value.to_bool()
	}
	if value.is_long() {
		return value.to_i64() != 0
	}
	if value.is_string() {
		text := value.to_string().trim_space().to_lower()
		return text in ['1', 'true', 'yes', 'on']
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

fn (subject PhpValueSubject) resource_action_list() []string {
	value := subject.value
	if !is_present_resource_option(value) {
		return []string{}
	}
	if actions := value.as_array() {
		mut out := []string{}
		for item in actions.to_string_list() {
			clean := item.trim_space().to_lower()
			if clean != '' && clean !in out {
				out << clean
			}
		}
		return out
	}
	mut out := []string{}
	for part in value.to_string().split(',') {
		clean := part.trim_space().to_lower()
		if clean != '' && clean !in out {
			out << clean
		}
	}
	return out
}

fn (opts ResourceRouteOptions) should_include_action(action string, all_actions []string) bool {
	if opts.only.len > 0 {
		return action in opts.only
	}
	if action in opts.except {
		return false
	}
	return action in all_actions
}

fn (opts ResourceRouteOptions) route_name(base_name string, action string) string {
	if action in opts.names {
		return opts.names[action]
	}
	if opts.name_prefix.trim_space() != '' {
		return '${opts.name_prefix}.${action}'
	}
	return '${base_name}.${action}'
}
