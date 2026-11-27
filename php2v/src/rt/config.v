module rt

import os
import yaml

pub struct RouteRule {
pub mut:
	match         string
	match_pattern string
	mode          string // static | v_native | embed_php | deny
	root          string
	entry         string
	handler       string
	autoindex     bool
}

pub struct GatewayServerConfig {
pub mut:
	host      string
	port      int
	autoindex bool
}

pub struct AsyncHttpConfig {
pub mut:
	bypass_patterns []string
}

pub struct GatewayConfig {
pub mut:
	host            string = '0.0.0.0'
	port            int    = 8086
	autoindex       bool
	server          GatewayServerConfig
	override_pdo    bool
	override_redis  bool
	async_http      AsyncHttpConfig
	bypass_patterns []string
	routes          []RouteRule
}

// load_gateway_config 使用 V 语言官方原生 yaml 模块解析网关配置文件
pub fn load_gateway_config(config_path string) GatewayConfig {
	mut cfg := GatewayConfig{
		bypass_patterns: ['*.zip', '*.tar.gz', 'downloads.wordpress.org', 'download.wordpress.org']
	}

	if !os.exists(config_path) {
		eprintln('[GATEWAY CONFIG] ${config_path} not found, using default fallback config.')
		return cfg
	}

	content := os.read_file(config_path) or { return cfg }
	mut decoded := yaml.decode[GatewayConfig](content) or {
		eprintln('[GATEWAY CONFIG ERROR] Failed to parse YAML file ${config_path}: ${err}')
		return cfg
	}

	// 兼容 gateway.yaml / laravel.yml 中的 server 嵌套配置，同时保留旧版顶层字段。
	if decoded.server.host != '' {
		decoded.host = decoded.server.host
	}
	if decoded.server.port > 0 {
		decoded.port = decoded.server.port
	}
	if decoded.server.autoindex {
		decoded.autoindex = true
	}

	// 规范化 routes 规则中的 match_pattern 与默认 bypass 规则
	if decoded.bypass_patterns.len == 0 && decoded.async_http.bypass_patterns.len > 0 {
		decoded.bypass_patterns = decoded.async_http.bypass_patterns.clone()
	}
	if decoded.bypass_patterns.len == 0 {
		decoded.bypass_patterns = cfg.bypass_patterns
	}
	for i in 0 .. decoded.routes.len {
		if decoded.routes[i].match_pattern == '' && decoded.routes[i].match != '' {
			decoded.routes[i].match_pattern = decoded.routes[i].match
		}
	}

	eprintln('[GATEWAY CONFIG] Successfully loaded ${decoded.routes.len} route rules from ${config_path} via official yaml module.')
	return decoded
}
