module clix

import appx
import vphp

fn (mut cli VSlimCliApp) reset_command_input() {
	cli.last_command_name = ''
	cli.last_raw_args = []string{}
	cli.last_arguments = map[string]vphp.DynValue{}
	cli.last_options = map[string]vphp.DynValue{}
	cli.last_option_seen = map[string]bool{}
	cli.last_warnings = []string{}
	cli.last_input_parsed = false
}

fn (mut cli VSlimCliApp) set_command_input(command_name string, input CliCommandInput) {
	cli.last_command_name = command_name
	cli.last_raw_args = clone_string_slice(input.raw_args)
	cli.last_arguments = input.arguments.clone()
	cli.last_options = input.options.clone()
	cli.last_option_seen = input.option_seen.clone()
	cli.last_warnings = clone_string_slice(input.warnings)
	cli.last_input_parsed = input.parsed
}

fn (mut cli VSlimCliApp) bind_runtime_to_command(runtime vphp.PhpValue) {
	if !runtime.is_valid() || !runtime.is_object() {
		return
	}
	mut cli_value := cli.self_value()
	defer {
		cli_value.release()
	}
	if runtime.method_exists('setCli') {
		mut set_cli_result := runtime.call_method('setCli', cli_value)
		set_cli_result.release()
	}
	if runtime.method_exists('setApp') {
		mut app_value := cli.ensure_core_app().self_value()
		defer {
			app_value.release()
		}
		mut set_app_result := runtime.call_method('setApp', app_value)
		set_app_result.release()
	}
}

fn (mut cli VSlimCliApp) resolve_command_input(runtime vphp.PhpValue, raw_args []string) !CliCommandInput {
	cli.bind_runtime_to_command(runtime)
	if !runtime.is_valid() || !runtime.is_object() || !runtime.method_exists('definition') {
		return unparsed_input(raw_args)
	}
	def := command_definition(runtime)!
	return def.parse_command_input(raw_args)!
}

fn cli_command_input_error(runtime vphp.PhpValue, program string, command_name string, message string) !int {
	usage := command_usage_text_from_runtime(runtime, program, command_name).trim_space()
	if usage == '' {
		return error(message)
	}
	return error('${message}\n${usage}')
}
