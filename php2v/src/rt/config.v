module rt

import os

pub struct RouteRule {
pub mut:
	match_pattern string
	mode          string // static | v_native | embed_php
	root          string
	entry         string
	handler       string
}

pub struct GatewayConfig {
pub mut:
	host            string = '0.0.0.0'
	port            int    = 8086
	bypass_patterns []string
	routes          []RouteRule
}

// load_gateway_config 从指定 yaml/config 文件路径解析网关路由配置
pub fn load_gateway_config(config_path string) GatewayConfig {
	mut cfg := GatewayConfig{
		bypass_patterns: ['*.zip', '*.tar.gz', 'downloads.wordpress.org', 'download.wordpress.org']
	}

	if !os.exists(config_path) {
		eprintln('[GATEWAY CONFIG] ${config_path} not found, using default fallback config.')
		return cfg
	}

	content := os.read_file(config_path) or { return cfg }
	lines := content.split_into_lines()

	mut in_routes := false
	mut current_rule := RouteRule{}

	for line in lines {
		trimmed := line.trim_space()
		if trimmed == '' || trimmed.starts_with('#') {
			continue
		}

		if trimmed.starts_with('port:') {
			val := trimmed.all_after('port:').trim_space().trim('"\'')
			if val != '' {
				cfg.port = val.int()
			}
			continue
		}

		if trimmed == 'routes:' {
			in_routes = true
			continue
		}

		if in_routes {
			if trimmed.starts_with('- match:') {
				if current_rule.match_pattern != '' {
					cfg.routes << current_rule
					current_rule = RouteRule{}
				}
				current_rule.match_pattern = trimmed.all_after('- match:').trim_space().trim('"\'')
			} else if trimmed.starts_with('mode:') {
				current_rule.mode = trimmed.all_after('mode:').trim_space().trim('"\'')
			} else if trimmed.starts_with('root:') {
				current_rule.root = trimmed.all_after('root:').trim_space().trim('"\'')
			} else if trimmed.starts_with('entry:') {
				current_rule.entry = trimmed.all_after('entry:').trim_space().trim('"\'')
			} else if trimmed.starts_with('handler:') {
				current_rule.handler = trimmed.all_after('handler:').trim_space().trim('"\'')
			}
		}
	}

	if current_rule.match_pattern != '' {
		cfg.routes << current_rule
	}

	eprintln('[GATEWAY CONFIG] Successfully loaded ${cfg.routes.len} route rules from ${config_path}')
	return cfg
}
