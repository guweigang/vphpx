module routex

import routing
import vphp

pub struct ResourceRouteOptions {
pub mut:
	only            map[string]bool
	except          map[string]bool
	names           map[string]string
	name_prefix     string
	param_name      string = 'id'
	shallow         bool
	missing_handler vphp.PhpCallable = vphp.PhpCallable.invalid()
}

pub fn ResourceRouteOptions.default() ResourceRouteOptions {
	return ResourceRouteOptions{
		only:            map[string]bool{}
		except:          map[string]bool{}
		names:           map[string]string{}
		name_prefix:     ''
		param_name:      'id'
		shallow:         false
		missing_handler: vphp.PhpCallable.invalid()
	}
}

pub fn make_resource_handler(controller string, action string) vphp.PhpValue {
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

pub fn ResourceRouteOptions.from_options(options vphp.PhpArray) ResourceRouteOptions {
	mut out := ResourceRouteOptions.default()
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
		out.param_name = routing.Resource.normalize_param_name(param.to_string())
	}
	shallow := options['shallow']
	if is_present_resource_option(shallow) {
		out.shallow = resource_bool_option(shallow)
	}
	missing := options['missing']
	if handler := missing.as_callable() {
		out.missing_handler = handler.retain()
	}
	for action in resource_action_list(only_value) {
		out.only[action] = true
	}
	for action in resource_action_list(except_value) {
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

fn is_present_resource_option(value vphp.PhpValue) bool {
	return value.is_valid() && !value.is_null() && !value.is_undef()
}

fn resource_bool_option(value vphp.PhpValue) bool {
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

fn resource_action_list(value vphp.PhpValue) []string {
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

pub fn (opts ResourceRouteOptions) should_include_action(action string, all_actions []string) bool {
	if opts.only.len > 0 {
		return action in opts.only
	}
	if action in opts.except {
		return false
	}
	return action in all_actions
}

pub fn (opts ResourceRouteOptions) route_name(base_name string, action string) string {
	if action in opts.names {
		return opts.names[action]
	}
	if opts.name_prefix.trim_space() != '' {
		return '${opts.name_prefix}.${action}'
	}
	return '${base_name}.${action}'
}
