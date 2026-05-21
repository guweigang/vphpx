module logger

import configx as cfgx
import log
import os
import strings
import vphp

struct VSlimLogLevelConsts {
	disabled string
	fatal    string
	error    string
	warn     string
	info     string
	debug    string
}

const vslim_log_level_consts = VSlimLogLevelConsts{
	disabled: 'disabled'
	fatal:    'fatal'
	error:    'error'
	warn:     'warn'
	info:     'info'
	debug:    'debug'
}

@[php_class: 'VSlim\\Log\\Logger']
@[heap]
pub struct VSlimLogger {
mut:
	engine_ref         &log.Log = unsafe { nil } @[php_ignore]
	channel            string
	context            map[string]string
	level_name         string @[php_prop: levelName]
	output_file        string @[php_prop: outputFile]
	console_target     string @[php_prop: consoleTarget]
	local_time_enabled bool = true   @[php_prop: localTimeEnabled]
	short_tag_enabled  bool   @[php_prop: shortTagEnabled]
}

@[php_implements: 'Psr\\Log\\LoggerInterface']
@[php_class: 'VSlim\\Log\\PsrLogger']
@[heap]
pub struct VSlimPsrLogger {
mut:
	logger_ref &VSlimLogger = unsafe { nil } @[php_ignore]
}

@[php_const: 'vslim_log_level_consts']
@[php_class: 'VSlim\\Log\\Level']
@[heap]
pub struct VSlimLogLevel {}

@[php_method]
pub fn (mut log_writer VSlimLogger) construct() &VSlimLogger {
	log_writer.ensure()
	return log_writer
}

pub fn VSlimLogger.app_default(config &cfgx.VSlimConfig) &VSlimLogger {
	mut log_writer := &VSlimLogger{}
	log_writer.construct()
	log_writer.set_channel('vslim.app')
	log_writer.configure_defaults(config)
	return log_writer
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
pub fn (mut log_writer VSlimLogger) set_level(level string) &VSlimLogger {
	log_writer.ensure()
	parsed := vslim_log_level_from_name(level) or { log.Level.info }
	log_writer.level_name = vslim_log_level_name(parsed)
	log_writer.reconfigure()
	return log_writer
}

@[php_method]
pub fn (log_writer &VSlimLogger) level() string {
	return if log_writer.level_name == '' { 'info' } else { log_writer.level_name }
}

@[php_method: 'setChannel']
pub fn (mut log_writer VSlimLogger) set_channel(channel string) &VSlimLogger {
	log_writer.ensure()
	log_writer.channel = normalize_logger_channel(channel)
	log_writer.reconfigure()
	return log_writer
}

@[php_method]
pub fn (log_writer &VSlimLogger) channel() string {
	return if log_writer.channel == '' { 'vslim' } else { log_writer.channel }
}

@[php_method: 'setContext']
pub fn (mut log_writer VSlimLogger) set_context(context vphp.PhpArray) &VSlimLogger {
	log_writer.ensure()
	log_writer.context = normalize_log_context(context)
	return log_writer
}

@[php_method]
pub fn (log_writer &VSlimLogger) context() map[string]string {
	return log_writer.context.clone()
}

@[php_method: 'withContext']
pub fn (mut log_writer VSlimLogger) with_context(key string, value string) &VSlimLogger {
	log_writer.ensure()
	if key.trim_space() != '' {
		log_writer.context[key] = value
	}
	return log_writer
}

@[php_method: 'clearContext']
pub fn (mut log_writer VSlimLogger) clear_context() &VSlimLogger {
	log_writer.ensure()
	log_writer.context = map[string]string{}
	return log_writer
}

@[php_method: 'setLocalTime']
pub fn (mut log_writer VSlimLogger) set_local_time(enabled bool) &VSlimLogger {
	log_writer.ensure()
	log_writer.local_time_enabled = enabled
	log_writer.reconfigure()
	return log_writer
}

@[php_method: 'setShortTag']
pub fn (mut log_writer VSlimLogger) set_short_tag(enabled bool) &VSlimLogger {
	log_writer.ensure()
	log_writer.short_tag_enabled = enabled
	log_writer.reconfigure()
	return log_writer
}

@[php_method: 'setOutputFile']
pub fn (mut log_writer VSlimLogger) set_output_file(path string) &VSlimLogger {
	log_writer.ensure()
	if path.trim_space() == '' {
		return log_writer
	}
	log_writer.output_file = path
	log_writer.reconfigure()
	return log_writer
}

@[php_method: 'outputFile']
pub fn (log_writer &VSlimLogger) output_file() string {
	return log_writer.output_file
}

@[php_method: 'useStdout']
pub fn (mut log_writer VSlimLogger) use_stdout() &VSlimLogger {
	log_writer.ensure()
	log_writer.console_target = 'stdout'
	log_writer.reconfigure()
	return log_writer
}

@[php_method: 'useStderr']
pub fn (mut log_writer VSlimLogger) use_stderr() &VSlimLogger {
	log_writer.ensure()
	log_writer.console_target = 'stderr'
	log_writer.reconfigure()
	return log_writer
}

@[php_method: 'outputTarget']
pub fn (log_writer &VSlimLogger) output_target() string {
	if log_writer.output_file != '' {
		if log_writer.console_target != '' {
			return '${log_writer.console_target}+file'
		}
		return 'file'
	}
	return if log_writer.console_target == '' { 'stderr' } else { log_writer.console_target }
}

@[php_method]
pub fn (mut log_writer VSlimLogger) log(level string, message string) &VSlimLogger {
	log_writer.ensure()
	log_writer.write_log(level, message, map[string]string{})
	return log_writer
}

@[php_method: 'logContext']
pub fn (mut log_writer VSlimLogger) log_context(level string, message string, context vphp.PhpArray) &VSlimLogger {
	log_writer.ensure()
	log_writer.write_log(level, message, normalize_log_context(context))
	return log_writer
}

@[php_method]
pub fn (mut log_writer VSlimLogger) debug(message string) &VSlimLogger {
	return log_writer.log('debug', message)
}

@[php_method: 'debugContext']
pub fn (mut log_writer VSlimLogger) debug_context(message string, context vphp.PhpArray) &VSlimLogger {
	return log_writer.log_context('debug', message, context)
}

@[php_method]
pub fn (mut log_writer VSlimLogger) info(message string) &VSlimLogger {
	return log_writer.log('info', message)
}

@[php_method: 'infoContext']
pub fn (mut log_writer VSlimLogger) info_context(message string, context vphp.PhpArray) &VSlimLogger {
	return log_writer.log_context('info', message, context)
}

@[php_method]
pub fn (mut log_writer VSlimLogger) warn(message string) &VSlimLogger {
	return log_writer.log('warn', message)
}

@[php_method: 'warnContext']
pub fn (mut log_writer VSlimLogger) warn_context(message string, context vphp.PhpArray) &VSlimLogger {
	return log_writer.log_context('warn', message, context)
}

@[php_method]
pub fn (mut log_writer VSlimLogger) error(message string) &VSlimLogger {
	return log_writer.log('error', message)
}

@[php_method: 'errorContext']
pub fn (mut log_writer VSlimLogger) error_context(message string, context vphp.PhpArray) &VSlimLogger {
	return log_writer.log_context('error', message, context)
}

@[php_method]
pub fn (mut log_writer VSlimLogger) warning(message string) &VSlimLogger {
	return log_writer.warn(message)
}

@[php_method: 'warningContext']
pub fn (mut log_writer VSlimLogger) warning_context(message string, context vphp.PhpArray) &VSlimLogger {
	return log_writer.warn_context(message, context)
}

@[php_method]
pub fn (mut log_writer VSlimLogger) notice(message string) &VSlimLogger {
	return log_writer.log('notice', message)
}

@[php_method: 'noticeContext']
pub fn (mut log_writer VSlimLogger) notice_context(message string, context vphp.PhpArray) &VSlimLogger {
	return log_writer.log_context('notice', message, context)
}

@[php_method]
pub fn (mut log_writer VSlimLogger) critical(message string) &VSlimLogger {
	return log_writer.log('critical', message)
}

@[php_method: 'criticalContext']
pub fn (mut log_writer VSlimLogger) critical_context(message string, context vphp.PhpArray) &VSlimLogger {
	return log_writer.log_context('critical', message, context)
}

@[php_method]
pub fn (mut log_writer VSlimLogger) alert(message string) &VSlimLogger {
	return log_writer.log('alert', message)
}

@[php_method: 'alertContext']
pub fn (mut log_writer VSlimLogger) alert_context(message string, context vphp.PhpArray) &VSlimLogger {
	return log_writer.log_context('alert', message, context)
}

@[php_method]
pub fn (mut log_writer VSlimLogger) emergency(message string) &VSlimLogger {
	return log_writer.log('emergency', message)
}

@[php_method: 'emergencyContext']
pub fn (mut log_writer VSlimLogger) emergency_context(message string, context vphp.PhpArray) &VSlimLogger {
	return log_writer.log_context('emergency', message, context)
}

pub fn (mut log_writer VSlimLogger) configure_defaults(config &cfgx.VSlimConfig) {
	if config == unsafe { nil } {
		return
	}
	if config.has('logging.channel') {
		log_writer.set_channel(config.get_string('logging.channel', log_writer.channel()))
	}
	if config.has('logging.level') {
		log_writer.set_level(config.get_string('logging.level', log_writer.level()))
	}
	if config.has('logging.output_file') {
		output_file := config.get_string('logging.output_file', '').trim_space()
		if output_file != '' {
			log_writer.set_output_file(output_file)
		}
	}
	if config.has('logging.target') {
		target := config.get_string('logging.target', '').trim_space().to_lower()
		match target {
			'stdout' {
				log_writer.console_target = 'stdout'
				log_writer.reconfigure()
			}
			'stderr' {
				log_writer.console_target = 'stderr'
				log_writer.reconfigure()
			}
			'file' {
				log_writer.console_target = ''
				log_writer.reconfigure()
			}
			else {}
		}
	}
}

pub fn (mut log_writer VSlimLogger) set_output_file_only(path string) &VSlimLogger {
	log_writer.ensure()
	log_writer.console_target = ''
	return log_writer.set_output_file(path)
}

@[php_method]
pub fn (mut log_writer VSlimPsrLogger) construct() &VSlimPsrLogger {
	log_writer.ensure()
	return log_writer
}

pub fn VSlimPsrLogger.from_logger(inner &VSlimLogger) &VSlimPsrLogger {
	mut log_writer := &VSlimPsrLogger{}
	log_writer.construct()
	log_writer.set_logger(inner)
	return log_writer
}

@[php_method: 'setLogger']
pub fn (mut log_writer VSlimPsrLogger) set_logger(inner &VSlimLogger) &VSlimPsrLogger {
	log_writer.logger_ref = inner
	return log_writer
}

@[php_method]
pub fn (mut log_writer VSlimPsrLogger) logger() &VSlimLogger {
	log_writer.ensure()
	return log_writer.logger_ref
}

@[php_method: 'setLevel']
pub fn (mut log_writer VSlimPsrLogger) set_level(level string) &VSlimPsrLogger {
	mut inner := log_writer.logger()
	inner.set_level(level)
	return log_writer
}

@[php_method: 'setChannel']
pub fn (mut log_writer VSlimPsrLogger) set_channel(channel string) &VSlimPsrLogger {
	mut inner := log_writer.logger()
	inner.set_channel(channel)
	return log_writer
}

@[php_method: 'setContext']
pub fn (mut log_writer VSlimPsrLogger) set_context(context vphp.PhpArray) &VSlimPsrLogger {
	mut inner := log_writer.logger()
	inner.set_context(context)
	return log_writer
}

@[php_method: 'withContext']
pub fn (mut log_writer VSlimPsrLogger) with_context(key string, value string) &VSlimPsrLogger {
	mut inner := log_writer.logger()
	inner.with_context(key, value)
	return log_writer
}

@[php_method: 'clearContext']
pub fn (mut log_writer VSlimPsrLogger) clear_context() &VSlimPsrLogger {
	mut inner := log_writer.logger()
	inner.clear_context()
	return log_writer
}

@[php_method: 'setOutputFile']
pub fn (mut log_writer VSlimPsrLogger) set_output_file(path string) &VSlimPsrLogger {
	mut inner := log_writer.logger()
	inner.set_output_file(path)
	return log_writer
}

@[php_method: 'useStdout']
pub fn (mut log_writer VSlimPsrLogger) use_stdout() &VSlimPsrLogger {
	mut inner := log_writer.logger()
	inner.use_stdout()
	return log_writer
}

@[php_method: 'useStderr']
pub fn (mut log_writer VSlimPsrLogger) use_stderr() &VSlimPsrLogger {
	mut inner := log_writer.logger()
	inner.use_stderr()
	return log_writer
}

@[params]
struct VSlimPsrLoggerContextParams {
	context vphp.PhpArray
}

@[php_method]
pub fn (mut log_writer VSlimPsrLogger) log(level vphp.PhpValue, message vphp.PhpValue, params VSlimPsrLoggerContextParams) {
	mut inner := log_writer.logger()
	level_name := log_message_from_value(level)
	if !is_valid_psr3_level(level_name) {
		vphp.PhpException.raise_class('InvalidArgumentException', 'invalid PSR-3 log level: ' +
			level_name, 0)
		return
	}
	inner.log_context(level_name, log_message_from_value(message), params.context)
}

@[php_method]
pub fn (mut log_writer VSlimPsrLogger) emergency(message vphp.PhpValue, params VSlimPsrLoggerContextParams) {
	mut inner := log_writer.logger()
	inner.log_context('emergency', log_message_from_value(message), params.context)
}

@[php_method]
pub fn (mut log_writer VSlimPsrLogger) alert(message vphp.PhpValue, params VSlimPsrLoggerContextParams) {
	mut inner := log_writer.logger()
	inner.log_context('alert', log_message_from_value(message), params.context)
}

@[php_method]
pub fn (mut log_writer VSlimPsrLogger) critical(message vphp.PhpValue, params VSlimPsrLoggerContextParams) {
	mut inner := log_writer.logger()
	inner.log_context('critical', log_message_from_value(message), params.context)
}

@[php_method]
pub fn (mut log_writer VSlimPsrLogger) error(message vphp.PhpValue, params VSlimPsrLoggerContextParams) {
	mut inner := log_writer.logger()
	inner.log_context('error', log_message_from_value(message), params.context)
}

@[php_method]
pub fn (mut log_writer VSlimPsrLogger) warning(message vphp.PhpValue, params VSlimPsrLoggerContextParams) {
	mut inner := log_writer.logger()
	inner.log_context('warning', log_message_from_value(message), params.context)
}

@[php_method]
pub fn (mut log_writer VSlimPsrLogger) notice(message vphp.PhpValue, params VSlimPsrLoggerContextParams) {
	mut inner := log_writer.logger()
	inner.log_context('notice', log_message_from_value(message), params.context)
}

@[php_method]
pub fn (mut log_writer VSlimPsrLogger) info(message vphp.PhpValue, params VSlimPsrLoggerContextParams) {
	mut inner := log_writer.logger()
	inner.log_context('info', log_message_from_value(message), params.context)
}

@[php_method]
pub fn (mut log_writer VSlimPsrLogger) debug(message vphp.PhpValue, params VSlimPsrLoggerContextParams) {
	mut inner := log_writer.logger()
	inner.log_context('debug', log_message_from_value(message), params.context)
}

@[php_method]
pub fn (log_writer &VSlimPsrLogger) str() string {
	if log_writer.logger_ref == unsafe { nil } {
		return 'VSlim\\Log\\PsrLogger(uninitialized)'
	}
	return 'VSlim\\Log\\PsrLogger(' + log_writer.logger_ref.str() + ')'
}

@[php_method]
pub fn (log_writer &VSlimLogger) str() string {
	return 'VSlim\\Log\\Logger(channel=${log_writer.channel()}, level=${log_writer.level()})'
}

fn (mut log_writer VSlimPsrLogger) ensure() {
	if log_writer.logger_ref != unsafe { nil } {
		return
	}
	mut inner := &VSlimLogger{}
	inner.construct()
	inner.set_channel('vslim.psr')
	log_writer.logger_ref = inner
}

fn (mut log_writer VSlimLogger) ensure() {
	if log_writer.engine_ref != unsafe { nil } {
		return
	}
	if log_writer.level_name == '' {
		log_writer.level_name = 'info'
	}
	if log_writer.channel == '' {
		log_writer.channel = normalize_logger_channel(log_writer.channel)
	}
	if log_writer.context.len == 0 {
		log_writer.context = map[string]string{}
	}
	if log_writer.console_target == '' {
		log_writer.console_target = 'stderr'
	}
	log_writer.reconfigure()
}

fn (mut log_writer VSlimLogger) reconfigure() {
	log_writer.close_engine()
	mut engine := &log.Log{}
	engine.set_level(vslim_log_level_from_name(log_writer.level_name) or { log.Level.info })
	engine.set_local_time(log_writer.local_time_enabled)
	engine.set_short_tag(log_writer.short_tag_enabled)
	engine.set_always_flush(true)
	engine.set_output_label(normalize_logger_channel(log_writer.channel))
	match log_writer.console_target {
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

	if log_writer.output_file != '' {
		engine.set_full_logpath(log_writer.output_file)
		if log_writer.console_target != '' {
			engine.set_output_stream(vslim_console_stream(log_writer.console_target))
			engine.log_to_console_too()
		}
	}
	log_writer.engine_ref = engine
	log_writer.channel = normalize_logger_channel(log_writer.channel)
	if log_writer.context.len == 0 {
		log_writer.context = map[string]string{}
	}
	if log_writer.level_name == '' {
		log_writer.level_name = 'info'
	}
}

pub fn (mut log_writer VSlimLogger) close_engine() {
	if log_writer.engine_ref == unsafe { nil } {
		return
	}
	unsafe {
		mut engine := &log.Log(log_writer.engine_ref)
		engine.close()
	}
	log_writer.engine_ref = unsafe { nil }
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

fn log_message_from_value(value vphp.PhpValue) string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return ''
	}
	return value.to_string()
}

fn normalize_log_context(context vphp.PhpArray) map[string]string {
	if !context.is_valid() {
		return map[string]string{}
	}
	return context.fold_values[map[string]string](map[string]string{}, fn (key vphp.PhpValue, value vphp.PhpValue, mut out map[string]string) {
		out[key.to_string()] = stringify_log_context_value(value)
	})
}

fn (mut log_writer VSlimLogger) write_log(level string, message string, context map[string]string) {
	parsed := vslim_log_level_from_name(level) or { log.Level.info }
	payload := format_vslim_log_message(log_writer.channel(), message, log_writer.context, context)
	unsafe {
		mut engine := &log.Log(log_writer.engine_ref)
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

fn stringify_log_context_value(value vphp.PhpValue) string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return ''
	}
	if value.is_string() || value.is_bool() || value.is_long() || value.is_double() {
		return value.to_string()
	}
	if value.is_resource() {
		kind := value.resource_type() or { 'resource' }
		return 'resource(${kind})'
	}
	if value.is_object() {
		if value.method_exists('__toString') {
			return value.to_string()
		}
		class_name := value.class_name()
		return if class_name == '' { '[object]' } else { '[object ${class_name}]' }
	}
	if value.is_array() {
		return '[array]'
	}
	return '[' + value.type_name() + ']'
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
