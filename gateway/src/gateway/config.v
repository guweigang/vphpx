module gateway

import os
import yaml

pub struct ServerConfig {
pub mut:
	host      string = '0.0.0.0'
	port      int    = 8086
	workers   int    = 1
	php_lanes int
}

pub struct RouteRule {
pub mut:
	match_pattern string @[json: 'match']
	mode          string
	root          string
	entry         string
	autoindex     bool
}

pub struct Config {
pub mut:
	server    ServerConfig
	autoindex bool
	routes    []RouteRule
}

pub fn load_config(path string) !Config {
	if !os.is_file(path) {
		return error('gateway config not found: ${path}')
	}
	content := os.read_file(path)!
	mut config := yaml.decode[Config](content)!
	if config.server.port <= 0 {
		config.server.port = 8086
	}
	if config.server.host == '' {
		config.server.host = '0.0.0.0'
	}
	if config.server.workers <= 0 {
		config.server.workers = 1
	}
	if config.server.php_lanes <= 0 {
		config.server.php_lanes = config.server.workers
	}
	if config.server.php_lanes > 64 {
		return error('server.php_lanes cannot exceed 64')
	}
	base_dir := os.dir(os.real_path(path))
	for index in 0 .. config.routes.len {
		if config.routes[index].match_pattern == '' {
			config.routes[index].match_pattern = '/*'
		}
		config.routes[index].mode = config.routes[index].mode.to_lower()
		if config.routes[index].root != '' && !os.is_abs_path(config.routes[index].root) {
			config.routes[index].root = os.norm_path(os.join_path(base_dir,
				config.routes[index].root))
		}
		if config.routes[index].entry != '' && !os.is_abs_path(config.routes[index].entry) {
			config.routes[index].entry = os.norm_path(os.join_path(base_dir,
				config.routes[index].entry))
		}
	}
	return config
}
