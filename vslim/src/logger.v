module main

import log
import os
import strings
import vphp

const vslim_log_level_consts = VSlimLogLevelConsts{
	disabled: 'disabled'
	fatal:    'fatal'
	error:    'error'
	warn:     'warn'
	info:     'info'
	debug:    'debug'
}

@[php_method]
pub fn (mut logger VSlimLogger) construct() &VSlimLogger {
	ensure_vslim_logger(mut logger)
	return logger
}

@[php_method]
pub fn VSlimLogger.disabled_level() string {
	return VSlimLogLevel.disabled()
}

@[php_method]
pub fn VSlimLogger.fatal_level() string {
	return VSlimLogLevel.fatal()
}

@[php_method]
pub fn VSlimLogger.error_level() string {
	return VSlimLogLevel.error()
}

@[php_method]
pub fn VSlimLogger.warn_level() string {
	return VSlimLogLevel.warn()
}

@[php_method]
pub fn VSlimLogger.info_level() string {
	return VSlimLogLevel.info()
}

@[php_method]
pub fn VSlimLogger.debug_level() string {
	return VSlimLogLevel.debug()
}

@[php_method]
pub fn VSlimLogLevel.disabled() string {
	return 'disabled'
}

@[php_method]
pub fn VSlimLogLevel.fatal() string {
	return 'fatal'
}

@[php_method]
pub fn VSlimLogLevel.error() string {
	return 'error'
}

@[php_method]
pub fn VSlimLogLevel.warn() string {
	return 'warn'
}

@[php_method]
pub fn VSlimLogLevel.info() string {
	return 'info'
}

@[php_method]
pub fn VSlimLogLevel.debug() string {
	return 'debug'
}

@[php_method]
pub fn VSlimLogLevel.all() map[string]string {
	return {
		'disabled': VSlimLogLevel.disabled()
		'fatal':    VSlimLogLevel.fatal()
		'error':    VSlimLogLevel.error()
		'warn':     VSlimLogLevel.warn()
		'info':     VSlimLogLevel.info()
		'debug':    VSlimLogLevel.debug()
	}
}

@[php_method]
pub fn (mut logger VSlimLogger) set_level(level string) &VSlimLogger {
	ensure_vslim_logger(mut logger)
	parsed := vslim_log_level_from_name(level) or { log.Level.info }
	logger.level_name = vslim_log_level_name(parsed)
	reconfigure_vslim_logger(mut logger)
	return logger
}

@[php_method]
pub fn (logger &VSlimLogger) level() string {
	return if logger.level_name == '' { 'info' } else { logger.level_name }
}

@[php_method]
pub fn (mut logger VSlimLogger) set_channel(channel string) &VSlimLogger {
	ensure_vslim_logger(mut logger)
	logger.channel = normalize_logger_channel(channel)
	reconfigure_vslim_logger(mut logger)
	return logger
}

@[php_method]
pub fn (logger &VSlimLogger) channel() string {
	return if logger.channel == '' { 'vslim' } else { logger.channel }
}

@[php_method]
pub fn (mut logger VSlimLogger) set_context(context vphp.ZVal) &VSlimLogger {
	ensure_vslim_logger(mut logger)
	logger.context = normalize_log_context(context)
	return logger
}

@[php_method]
pub fn (logger &VSlimLogger) context() map[string]string {
	return logger.context.clone()
}

@[php_method]
pub fn (mut logger VSlimLogger) with_context(key string, value string) &VSlimLogger {
	ensure_vslim_logger(mut logger)
	if key.trim_space() != '' {
		logger.context[key] = value
	}
	return logger
}

@[php_method]
pub fn (mut logger VSlimLogger) clear_context() &VSlimLogger {
	ensure_vslim_logger(mut logger)
	logger.context = map[string]string{}
	return logger
}

@[php_method]
pub fn (mut logger VSlimLogger) set_local_time(enabled bool) &VSlimLogger {
	ensure_vslim_logger(mut logger)
	logger.local_time_enabled = enabled
	reconfigure_vslim_logger(mut logger)
	return logger
}

@[php_method]
pub fn (mut logger VSlimLogger) set_short_tag(enabled bool) &VSlimLogger {
	ensure_vslim_logger(mut logger)
	logger.short_tag_enabled = enabled
	reconfigure_vslim_logger(mut logger)
	return logger
}

@[php_method]
pub fn (mut logger VSlimLogger) set_output_file(path string) &VSlimLogger {
	ensure_vslim_logger(mut logger)
	if path.trim_space() == '' {
		return logger
	}
	logger.output_file = path
	reconfigure_vslim_logger(mut logger)
	return logger
}

@[php_method]
pub fn (logger &VSlimLogger) output_file() string {
	return logger.output_file
}

@[php_method]
pub fn (mut logger VSlimLogger) use_stdout() &VSlimLogger {
	ensure_vslim_logger(mut logger)
	logger.console_target = 'stdout'
	reconfigure_vslim_logger(mut logger)
	return logger
}

@[php_method]
pub fn (mut logger VSlimLogger) use_stderr() &VSlimLogger {
	ensure_vslim_logger(mut logger)
	logger.console_target = 'stderr'
	reconfigure_vslim_logger(mut logger)
	return logger
}

@[php_method]
pub fn (logger &VSlimLogger) output_target() string {
	if logger.output_file != '' {
		if logger.console_target != '' {
			return '${logger.console_target}+file'
		}
		return 'file'
	}
	return if logger.console_target == '' { 'stderr' } else { logger.console_target }
}

@[php_method]
pub fn (mut logger VSlimLogger) log(level string, message string) &VSlimLogger {
	return logger.log_context(level, message, vphp.ZVal.new_null())
}

@[php_method]
pub fn (mut logger VSlimLogger) log_context(level string, message string, context vphp.ZVal) &VSlimLogger {
	ensure_vslim_logger(mut logger)
	vslim_logger_write(mut logger, level, message, normalize_log_context(context))
	return logger
}

@[php_method]
pub fn (mut logger VSlimLogger) debug(message string) &VSlimLogger {
	return logger.log('debug', message)
}

@[php_method]
pub fn (mut logger VSlimLogger) debug_context(message string, context vphp.ZVal) &VSlimLogger {
	return logger.log_context('debug', message, context)
}

@[php_method]
pub fn (mut logger VSlimLogger) info(message string) &VSlimLogger {
	return logger.log('info', message)
}

@[php_method]
pub fn (mut logger VSlimLogger) info_context(message string, context vphp.ZVal) &VSlimLogger {
	return logger.log_context('info', message, context)
}

@[php_method]
pub fn (mut logger VSlimLogger) warn(message string) &VSlimLogger {
	return logger.log('warn', message)
}

@[php_method]
pub fn (mut logger VSlimLogger) warn_context(message string, context vphp.ZVal) &VSlimLogger {
	return logger.log_context('warn', message, context)
}

@[php_method]
pub fn (mut logger VSlimLogger) error(message string) &VSlimLogger {
	return logger.log('error', message)
}

@[php_method]
pub fn (mut logger VSlimLogger) error_context(message string, context vphp.ZVal) &VSlimLogger {
	return logger.log_context('error', message, context)
}

@[php_method]
pub fn (logger &VSlimLogger) str() string {
	return 'VSlim\\Log\\Logger(channel=${logger.channel()}, level=${logger.level()})'
}

fn ensure_vslim_logger(mut logger VSlimLogger) {
	if logger.engine_ref != unsafe { nil } {
		return
	}
	if logger.level_name == '' {
		logger.level_name = 'info'
	}
	if logger.channel == '' {
		logger.channel = normalize_logger_channel(logger.channel)
	}
	if logger.context.len == 0 {
		logger.context = map[string]string{}
	}
	if logger.console_target == '' {
		logger.console_target = 'stderr'
	}
	reconfigure_vslim_logger(mut logger)
}

fn reconfigure_vslim_logger(mut logger VSlimLogger) {
	close_vslim_logger_engine(mut logger)
	mut engine := &log.Log{}
	engine.set_level(vslim_log_level_from_name(logger.level_name) or { log.Level.info })
	engine.set_local_time(logger.local_time_enabled)
	engine.set_short_tag(logger.short_tag_enabled)
	engine.set_always_flush(true)
	engine.set_output_label(normalize_logger_channel(logger.channel))
	match logger.console_target {
		'stdout' {
			engine.set_output_stream(os.stdout())
		}
		'stderr', '' {
			engine.set_output_stream(os.stderr())
		}
		else {
			engine.set_output_stream(os.stderr())
		}
	}
	if logger.output_file != '' {
		engine.set_full_logpath(logger.output_file)
		if logger.console_target != '' {
			engine.set_output_stream(vslim_console_stream(logger.console_target))
			engine.log_to_console_too()
		}
	}
	logger.engine_ref = engine
	logger.channel = normalize_logger_channel(logger.channel)
	if logger.context.len == 0 {
		logger.context = map[string]string{}
	}
	if logger.level_name == '' {
		logger.level_name = 'info'
	}
}

fn close_vslim_logger_engine(mut logger VSlimLogger) {
	if logger.engine_ref == unsafe { nil } {
		return
	}
	unsafe {
		mut engine := &log.Log(logger.engine_ref)
		engine.close()
	}
	logger.engine_ref = unsafe { nil }
}

fn vslim_console_stream(target string) os.File {
	return if target == 'stdout' { os.stdout() } else { os.stderr() }
}

fn vslim_log_level_from_name(level string) ?log.Level {
	normalized := level.trim_space().to_upper()
	if normalized == '' {
		return none
	}
	if normalized == 'WARNING' {
		return log.Level.warn
	}
	return log.level_from_tag(normalized)
}

fn vslim_log_level_name(level log.Level) string {
	return match level {
		.disabled { 'disabled' }
		.fatal { 'fatal' }
		.error { 'error' }
		.warn { 'warn' }
		.info { 'info' }
		.debug { 'debug' }
	}
}

fn normalize_logger_channel(channel string) string {
	trimmed := channel.trim_space()
	return if trimmed == '' { 'vslim' } else { trimmed }
}

fn normalize_log_context(raw vphp.ZVal) map[string]string {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return map[string]string{}
	}
	return raw.to_string_map()
}

fn vslim_logger_write(mut logger VSlimLogger, level string, message string, context map[string]string) {
	parsed := vslim_log_level_from_name(level) or { log.Level.info }
	payload := format_vslim_log_message(logger.channel(), message, logger.context, context)
	unsafe {
		mut engine := &log.Log(logger.engine_ref)
		match parsed {
			.disabled {}
			.fatal { engine.error(payload) }
			.error { engine.error(payload) }
			.warn { engine.warn(payload) }
			.info { engine.info(payload) }
			.debug { engine.debug(payload) }
		}
	}
}

fn format_vslim_log_message(channel string, message string, base_context map[string]string, extra_context map[string]string) string {
	mut parts := []string{}
	if channel.trim_space() != '' {
		parts << '[${channel}]'
	}
	msg := message.trim_space()
	if msg != '' {
		parts << msg
	}
	merged := merge_log_context(base_context, extra_context)
	if merged.len > 0 {
		parts << format_log_context_pairs(merged)
	}
	if parts.len == 0 {
		return '[${channel}]'
	}
	return parts.join(' ')
}

fn merge_log_context(base_context map[string]string, extra_context map[string]string) map[string]string {
	mut out := base_context.clone()
	for key, value in extra_context {
		out[key] = value
	}
	return out
}

fn format_log_context_pairs(context map[string]string) string {
	mut keys := context.keys()
	keys.sort()
	mut out := []string{}
	for key in keys {
		value := context[key] or { '' }
		out << '${key}=${quote_log_context_value(value)}'
	}
	return out.join(' ')
}

fn quote_log_context_value(value string) string {
	if value == '' {
		return '""'
	}
	if !value.contains(' ') && !value.contains('"') && !value.contains('=') {
		return value
	}
	mut builder := strings.new_builder(value.len + 2)
	builder.write_string('"')
	for ch in value {
		if ch == `"` || ch == `\\` {
			builder.write_u8(`\\`)
		}
		builder.write_u8(ch)
	}
	builder.write_string('"')
	return builder.str()
}
