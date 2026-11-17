module clix

import appx
import vphp

@[heap]
struct CliCommandContext {
mut:
	name string
	raw_args []string
	arguments map[string]vphp.DynValue
	options map[string]vphp.DynValue
	option_seen map[string]bool
	warnings []string
	parsed bool
	trace string
}

fn (mut cli VSlimCliApp) begin_invocation() ?&CliCommandContext {
	cli.invocation_depth++
	if cli.invocation_depth == 1 {
		return none
	}
	outer := cli.command_context
	cli.command_context = &CliCommandContext{}
	return outer
}

fn (mut cli VSlimCliApp) end_invocation(outer ?&CliCommandContext) {
	if context := outer {
		cli.command_context.release()
		cli.command_context = context
	}
	cli.invocation_depth--
}

fn (mut context CliCommandContext) release() {
	unsafe {
		context.name.free()
		context.raw_args.free()
		context.arguments.free()
		context.options.free()
		context.option_seen.free()
		context.warnings.free()
	}
}

fn (mut cli VSlimCliApp) reset_command_input() {
	cli.command_context.name = ''
	cli.command_context.raw_args = []string{}
	cli.command_context.arguments = map[string]vphp.DynValue{}
	cli.command_context.options = map[string]vphp.DynValue{}
	cli.command_context.option_seen = map[string]bool{}
	cli.command_context.warnings = []string{}
	cli.command_context.parsed = false
}

fn (mut cli VSlimCliApp) set_command_input(command_name string, input CliCommandInput) {
	cli.command_context.name = command_name
	cli.command_context.raw_args = clone_string_slice(input.raw_args)
	cli.command_context.arguments = input.arguments.clone()
	cli.command_context.options = input.options.clone()
	cli.command_context.option_seen = input.option_seen.clone()
	cli.command_context.warnings = clone_string_slice(input.warnings)
	cli.command_context.parsed = input.parsed
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

fn (mut cli VSlimCliApp) resolve_command_input(runtime vphp.PhpValue, raw_args []string, program string, command_name string) !CliCommandInput {
	cli.bind_runtime_to_command(runtime)
	if !command_has_definition(runtime) {
		return unparsed_input(raw_args)
	}
	def := read_command_definition(runtime) or {
		return cli_command_input_error(none, program, command_name, err.msg())
	}
	return def.parse_command_input(raw_args) or {
		return cli_command_input_error(def, program, command_name, err.msg())
	}
}

fn cli_command_input_error(definition ?CliCommandDefinition, program string, command_name string, message string) IError {
	usage := command_usage_text(definition, program, command_name).trim_space()
	return error('${message}\n${usage}')
}
