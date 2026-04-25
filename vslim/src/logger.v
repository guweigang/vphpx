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

@[php_method: 'disabledLevel']
pub fn VSlimLogger.disabled_level() string {
	return VSlimLogLevel.disabled()
}

@[php_method: 'fatalLevel']
pub fn VSlimLogger.fatal_level() string {
	return VSlimLogLevel.fatal()
}

@[php_method: 'errorLevel']
pub fn VSlimLogger.error_level() string {
	return VSlimLogLevel.error()
}

@[php_method: 'warnLevel']
pub fn VSlimLogger.warn_level() string {
	return VSlimLogLevel.warn()
}

@[php_method: 'infoLevel']
pub fn VSlimLogger.info_level() string {
	return VSlimLogLevel.info()
}

@[php_method: 'debugLevel']
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

@[php_method: 'setLevel']
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

@[php_method: 'setChannel']
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

@[php_method: 'setContext']
pub fn (mut logger VSlimLogger) set_context(context vphp.RequestBorrowedZBox) &VSlimLogger {
	ensure_vslim_logger(mut logger)
	logger.context = normalize_log_context(context.to_zval())
	return logger
}

@[php_method]
pub fn (logger &VSlimLogger) context() map[string]string {
	return logger.context.clone()
}

@[php_method: 'withContext']
pub fn (mut logger VSlimLogger) with_context(key string, value string) &VSlimLogger {
	ensure_vslim_logger(mut logger)
	if key.trim_space() != '' {
		logger.context[key] = value
	}
	return logger
}

@[php_method: 'clearContext']
pub fn (mut logger VSlimLogger) clear_context() &VSlimLogger {
	ensure_vslim_logger(mut logger)
	logger.context = map[string]string{}
	return logger
}

@[php_method: 'setLocalTime']
pub fn (mut logger VSlimLogger) set_local_time(enabled bool) &VSlimLogger {
	ensure_vslim_logger(mut logger)
	logger.local_time_enabled = enabled
	reconfigure_vslim_logger(mut logger)
	return logger
}

@[php_method: 'setShortTag']
pub fn (mut logger VSlimLogger) set_short_tag(enabled bool) &VSlimLogger {
	ensure_vslim_logger(mut logger)
	logger.short_tag_enabled = enabled
	reconfigure_vslim_logger(mut logger)
	return logger
}

@[php_method: 'setOutputFile']
pub fn (mut logger VSlimLogger) set_output_file(path string) &VSlimLogger {
	ensure_vslim_logger(mut logger)
	if path.trim_space() == '' {
		return logger
	}
	logger.output_file = path
	reconfigure_vslim_logger(mut logger)
	return logger
}

@[php_method: 'outputFile']
pub fn (logger &VSlimLogger) output_file() string {
	return logger.output_file
}

@[php_method: 'useStdout']
pub fn (mut logger VSlimLogger) use_stdout() &VSlimLogger {
	ensure_vslim_logger(mut logger)
	logger.console_target = 'stdout'
	reconfigure_vslim_logger(mut logger)
	return logger
}

@[php_method: 'useStderr']
pub fn (mut logger VSlimLogger) use_stderr() &VSlimLogger {
	ensure_vslim_logger(mut logger)
	logger.console_target = 'stderr'
	reconfigure_vslim_logger(mut logger)
	return logger
}

@[php_method: 'outputTarget']
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
	ensure_vslim_logger(mut logger)
	vslim_logger_write(mut logger, level, message, map[string]string{})
	return logger
}

@[php_method: 'logContext']
pub fn (mut logger VSlimLogger) log_context(level string, message string, context vphp.RequestBorrowedZBox) &VSlimLogger {
	ensure_vslim_logger(mut logger)
	vslim_logger_write(mut logger, level, message, normalize_log_context(context.to_zval()))
	return logger
}

@[php_method]
pub fn (mut logger VSlimLogger) debug(message string) &VSlimLogger {
	return logger.log('debug', message)
}

@[php_method: 'debugContext']
pub fn (mut logger VSlimLogger) debug_context(message string, context vphp.RequestBorrowedZBox) &VSlimLogger {
	return logger.log_context('debug', message, context)
}

@[php_method]
pub fn (mut logger VSlimLogger) info(message string) &VSlimLogger {
	return logger.log('info', message)
}

@[php_method: 'infoContext']
pub fn (mut logger VSlimLogger) info_context(message string, context vphp.RequestBorrowedZBox) &VSlimLogger {
	return logger.log_context('info', message, context)
}

@[php_method]
pub fn (mut logger VSlimLogger) warn(message string) &VSlimLogger {
	return logger.log('warn', message)
}

@[php_method: 'warnContext']
pub fn (mut logger VSlimLogger) warn_context(message string, context vphp.RequestBorrowedZBox) &VSlimLogger {
	return logger.log_context('warn', message, context)
}

@[php_method]
pub fn (mut logger VSlimLogger) error(message string) &VSlimLogger {
	return logger.log('error', message)
}

@[php_method: 'errorContext']
pub fn (mut logger VSlimLogger) error_context(message string, context vphp.RequestBorrowedZBox) &VSlimLogger {
	return logger.log_context('error', message, context)
}

@[php_method]
pub fn (mut logger VSlimLogger) warning(message string) &VSlimLogger {
	return logger.warn(message)
}

@[php_method: 'warningContext']
pub fn (mut logger VSlimLogger) warning_context(message string, context vphp.RequestBorrowedZBox) &VSlimLogger {
	return logger.warn_context(message, context)
}

@[php_method]
pub fn (mut logger VSlimLogger) notice(message string) &VSlimLogger {
	return logger.log('notice', message)
}

@[php_method: 'noticeContext']
pub fn (mut logger VSlimLogger) notice_context(message string, context vphp.RequestBorrowedZBox) &VSlimLogger {
	return logger.log_context('notice', message, context)
}

@[php_method]
pub fn (mut logger VSlimLogger) critical(message string) &VSlimLogger {
	return logger.log('critical', message)
}

@[php_method: 'criticalContext']
pub fn (mut logger VSlimLogger) critical_context(message string, context vphp.RequestBorrowedZBox) &VSlimLogger {
	return logger.log_context('critical', message, context)
}

@[php_method]
pub fn (mut logger VSlimLogger) alert(message string) &VSlimLogger {
	return logger.log('alert', message)
}

@[php_method: 'alertContext']
pub fn (mut logger VSlimLogger) alert_context(message string, context vphp.RequestBorrowedZBox) &VSlimLogger {
	return logger.log_context('alert', message, context)
}

@[php_method]
pub fn (mut logger VSlimLogger) emergency(message string) &VSlimLogger {
	return logger.log('emergency', message)
}

@[php_method: 'emergencyContext']
pub fn (mut logger VSlimLogger) emergency_context(message string, context vphp.RequestBorrowedZBox) &VSlimLogger {
	return logger.log_context('emergency', message, context)
}

@[php_method]
pub fn (mut logger VSlimPsrLogger) construct() &VSlimPsrLogger {
	ensure_vslim_psr_logger(mut logger)
	return logger
}

@[php_method: 'setLogger']
pub fn (mut logger VSlimPsrLogger) set_logger(inner &VSlimLogger) &VSlimPsrLogger {
	logger.logger_ref = inner
	return logger
}

@[php_method]
pub fn (mut logger VSlimPsrLogger) logger() &VSlimLogger {
	ensure_vslim_psr_logger(mut logger)
	return logger.logger_ref
}

@[php_method: 'setLevel']
pub fn (mut logger VSlimPsrLogger) set_level(level string) &VSlimPsrLogger {
	mut inner := logger.logger()
	inner.set_level(level)
	return logger
}

@[php_method: 'setChannel']
pub fn (mut logger VSlimPsrLogger) set_channel(channel string) &VSlimPsrLogger {
	mut inner := logger.logger()
	inner.set_channel(channel)
	return logger
}

@[php_method: 'setContext']
pub fn (mut logger VSlimPsrLogger) set_context(context vphp.RequestBorrowedZBox) &VSlimPsrLogger {
	mut inner := logger.logger()
	inner.set_context(context)
	return logger
}

@[php_method: 'withContext']
pub fn (mut logger VSlimPsrLogger) with_context(key string, value string) &VSlimPsrLogger {
	mut inner := logger.logger()
	inner.with_context(key, value)
	return logger
}

@[php_method: 'clearContext']
pub fn (mut logger VSlimPsrLogger) clear_context() &VSlimPsrLogger {
	mut inner := logger.logger()
	inner.clear_context()
	return logger
}

@[php_method: 'setOutputFile']
pub fn (mut logger VSlimPsrLogger) set_output_file(path string) &VSlimPsrLogger {
	mut inner := logger.logger()
	inner.set_output_file(path)
	return logger
}

@[php_method: 'useStdout']
pub fn (mut logger VSlimPsrLogger) use_stdout() &VSlimPsrLogger {
	mut inner := logger.logger()
	inner.use_stdout()
	return logger
}

@[php_method: 'useStderr']
pub fn (mut logger VSlimPsrLogger) use_stderr() &VSlimPsrLogger {
	mut inner := logger.logger()
	inner.use_stderr()
	return logger
}

@[php_method]
@[php_arg_name: 'default_context=defaultContext']
@[php_arg_default: 'default_context=[]']
@[php_arg_optional: 'default_context']
pub fn (mut logger VSlimPsrLogger) log(level vphp.RequestBorrowedZBox, message vphp.RequestBorrowedZBox, default_context vphp.RequestBorrowedZBox) {
	mut inner := logger.logger()
	level_name := zval_to_log_message(level.to_zval())
	if !is_valid_psr3_level(level_name) {
		vphp.throw_exception_class('InvalidArgumentException', 'invalid PSR-3 log level: ' + level_name, 0)
		return
	}
	inner.log_context(level_name, zval_to_log_message(message.to_zval()), default_context)
}

@[php_method]
@[php_arg_name: 'default_context=defaultContext']
@[php_arg_default: 'default_context=[]']
@[php_arg_optional: 'default_context']
pub fn (mut logger VSlimPsrLogger) emergency(message vphp.RequestBorrowedZBox, default_context vphp.RequestBorrowedZBox) {
	mut inner := logger.logger()
	inner.log_context('emergency', zval_to_log_message(message.to_zval()), default_context)
}

@[php_method]
@[php_arg_name: 'default_context=defaultContext']
@[php_arg_default: 'default_context=[]']
@[php_arg_optional: 'default_context']
pub fn (mut logger VSlimPsrLogger) alert(message vphp.RequestBorrowedZBox, default_context vphp.RequestBorrowedZBox) {
	mut inner := logger.logger()
	inner.log_context('alert', zval_to_log_message(message.to_zval()), default_context)
}

@[php_method]
@[php_arg_name: 'default_context=defaultContext']
@[php_arg_default: 'default_context=[]']
@[php_arg_optional: 'default_context']
pub fn (mut logger VSlimPsrLogger) critical(message vphp.RequestBorrowedZBox, default_context vphp.RequestBorrowedZBox) {
	mut inner := logger.logger()
	inner.log_context('critical', zval_to_log_message(message.to_zval()), default_context)
}

@[php_method]
@[php_arg_name: 'default_context=defaultContext']
@[php_arg_default: 'default_context=[]']
@[php_arg_optional: 'default_context']
pub fn (mut logger VSlimPsrLogger) error(message vphp.RequestBorrowedZBox, default_context vphp.RequestBorrowedZBox) {
	mut inner := logger.logger()
	inner.log_context('error', zval_to_log_message(message.to_zval()), default_context)
}

@[php_method]
@[php_arg_name: 'default_context=defaultContext']
@[php_arg_default: 'default_context=[]']
@[php_arg_optional: 'default_context']
pub fn (mut logger VSlimPsrLogger) warning(message vphp.RequestBorrowedZBox, default_context vphp.RequestBorrowedZBox) {
	mut inner := logger.logger()
	inner.log_context('warning', zval_to_log_message(message.to_zval()), default_context)
}

@[php_method]
@[php_arg_name: 'default_context=defaultContext']
@[php_arg_default: 'default_context=[]']
@[php_arg_optional: 'default_context']
pub fn (mut logger VSlimPsrLogger) notice(message vphp.RequestBorrowedZBox, default_context vphp.RequestBorrowedZBox) {
	mut inner := logger.logger()
	inner.log_context('notice', zval_to_log_message(message.to_zval()), default_context)
}

@[php_method]
@[php_arg_name: 'default_context=defaultContext']
@[php_arg_default: 'default_context=[]']
@[php_arg_optional: 'default_context']
pub fn (mut logger VSlimPsrLogger) info(message vphp.RequestBorrowedZBox, default_context vphp.RequestBorrowedZBox) {
	mut inner := logger.logger()
	inner.log_context('info', zval_to_log_message(message.to_zval()), default_context)
}

@[php_method]
@[php_arg_name: 'default_context=defaultContext']
@[php_arg_default: 'default_context=[]']
@[php_arg_optional: 'default_context']
pub fn (mut logger VSlimPsrLogger) debug(message vphp.RequestBorrowedZBox, default_context vphp.RequestBorrowedZBox) {
	mut inner := logger.logger()
	inner.log_context('debug', zval_to_log_message(message.to_zval()), default_context)
}

@[php_method]
pub fn (logger &VSlimPsrLogger) str() string {
	if logger.logger_ref == unsafe { nil } {
		return 'VSlim\\Log\\PsrLogger(uninitialized)'
	}
	return 'VSlim\\Log\\PsrLogger(' + logger.logger_ref.str() + ')'
}

@[php_method]
pub fn (logger &VSlimLogger) str() string {
	return 'VSlim\\Log\\Logger(channel=${logger.channel()}, level=${logger.level()})'
}

fn ensure_vslim_psr_logger(mut logger VSlimPsrLogger) {
	if logger.logger_ref != unsafe { nil } {
		return
	}
	mut inner := &VSlimLogger{}
	inner.construct()
	inner.set_channel('vslim.psr')
	logger.logger_ref = inner
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
	if normalized == 'NOTICE' {
		return log.Level.info
	}
	if normalized == 'CRITICAL' || normalized == 'ALERT' {
		return log.Level.error
	}
	if normalized == 'EMERGENCY' {
		return log.Level.fatal
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

fn zval_to_log_message(raw vphp.ZVal) string {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return ''
	}
	return raw.to_string()
}

fn normalize_log_context(raw vphp.ZVal) map[string]string {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return map[string]string{}
	}
	if !raw.is_array() {
		return map[string]string{}
	}
	mut out := map[string]string{}
	for key in raw.assoc_keys() {
		value := raw.get(key) or { continue }
		out[key] = stringify_log_context_value(value)
	}
	return out
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

fn is_valid_psr3_level(level string) bool {
	return level.trim_space().to_lower() in [
		'emergency',
		'alert',
		'critical',
		'error',
		'warning',
		'notice',
		'info',
		'debug',
	]
}

fn stringify_log_context_value(raw vphp.ZVal) string {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return ''
	}
	if raw.is_string() || raw.is_bool() || raw.is_long() || raw.is_double() {
		return raw.to_string()
	}
	if raw.is_resource() {
		kind := raw.resource_type() or { 'resource' }
		return 'resource(${kind})'
	}
	if raw.is_object() {
		if raw.method_exists('__toString') {
			return raw.to_string()
		}
		class_name := raw.class_name()
		return if class_name == '' { '[object]' } else { '[object ${class_name}]' }
	}
	if raw.is_array() {
		return '[array]'
	}
	return '[' + raw.type_name() + ']'
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
