module logger

import configx as cfgx
import os

__global (
	vslim_cli_debug_override_inited  bool
	vslim_cli_debug_enabled_override bool
	vslim_cli_debug_file_override    string
)

pub fn cli_debug_reset_overrides() {
	unsafe {
		vslim_cli_debug_override_inited = false
		vslim_cli_debug_enabled_override = false
		vslim_cli_debug_file_override = ''
	}
}

pub fn cli_debug_sync_from_config(config &cfgx.VSlimConfig) {
	if config == unsafe { nil } {
		return
	}
	unsafe {
		if config.has('cli.debug') {
			vslim_cli_debug_enabled_override = config.get_bool('cli.debug', false)
			vslim_cli_debug_override_inited = true
		}
		if config.has('cli.debug_file') {
			vslim_cli_debug_file_override = config.get_string('cli.debug_file', '').trim_space()
			vslim_cli_debug_override_inited = true
		}
	}
}

fn cli_debug_enabled() bool {
	unsafe {
		if vslim_cli_debug_override_inited {
			return vslim_cli_debug_enabled_override
		}
	}
	return os.getenv('VSLIM_CLI_DEBUG').trim_space().to_lower() in ['1', 'true', 'yes', 'on']
}

pub fn cli_debug_log(message string) {
	mut debug_file := ''
	unsafe {
		if vslim_cli_debug_override_inited {
			debug_file = vslim_cli_debug_file_override.trim_space()
		}
	}
	if debug_file == '' {
		debug_file = os.getenv('VSLIM_CLI_DEBUG_FILE').trim_space()
	}
	if debug_file == '' && !cli_debug_enabled() {
		return
	}
	mut log_writer := &VSlimLogger{}
	log_writer.construct()
	log_writer.set_channel('vslim.cli')
	log_writer.set_level(VSlimLogLevel.debug())
	if debug_file != '' {
		log_writer.set_output_file_only(debug_file)
	} else {
		log_writer.use_stderr()
	}
	log_writer.debug('[vslim-cli-debug] ' + message)
	log_writer.close_engine()
}
