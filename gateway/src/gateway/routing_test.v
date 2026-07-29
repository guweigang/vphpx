module gateway

import os

fn test_match_pattern() {
	assert match_pattern('/*', '/anything')
	assert match_pattern('/assets/*', '/assets/app.css')
	assert !match_pattern('/assets/*', '/api/assets')
	assert match_pattern('/health', '/health/')
}

fn test_resolve_php_front_controller() {
	root := os.join_path(os.temp_dir(), 'vphpx_gateway_route_fixture')
	os.mkdir_all(root) or { panic(err) }
	entry := os.join_path(root, 'index.php')
	os.write_file(entry, '<?php echo "ok";') or { panic(err) }
	config := Config{
		routes: [
			RouteRule{
				match_pattern: '/*'
				mode:          'embed_php'
				root:          root
				entry:         entry
			},
		]
	}
	target := resolve_target(config, '/users/42') or { panic(err) }
	assert target.kind == .php
	assert target.path == entry
	assert target.script_name == '/index.php'
}

fn test_resolve_target_rejects_parent_segments() {
	config := Config{
		routes: [
			RouteRule{
				match_pattern: '/*'
				mode:          'embed_php'
				root:          '/tmp'
				entry:         '/tmp/index.php'
			},
		]
	}
	if _ := resolve_target(config, '/../etc/passwd') {
		assert false
	} else {
		assert err.msg().contains('escapes')
	}
}

fn test_static_route_never_serves_php_source() {
	root := os.join_path(os.temp_dir(), 'vphpx_gateway_static_php_fixture')
	os.mkdir_all(root) or { panic(err) }
	php_file := os.join_path(root, 'uploaded.php')
	os.write_file(php_file, '<?php echo "secret";') or { panic(err) }
	config := Config{
		routes: [
			RouteRule{
				match_pattern: '/*'
				mode:          'static'
				root:          root
			},
		]
	}
	if _ := resolve_target(config, '/uploaded.php') {
		assert false
	} else {
		assert err.msg() == 'forbidden'
	}
}

fn test_try_static_defers_php_to_embed_route() {
	root := os.join_path(os.temp_dir(), 'vphpx_gateway_try_static_fixture')
	os.mkdir_all(root) or { panic(err) }
	entry := os.join_path(root, 'index.php')
	asset := os.join_path(root, 'app.css')
	os.write_file(entry, '<?php echo "ok";') or { panic(err) }
	os.write_file(asset, 'body {}') or { panic(err) }
	config := Config{
		routes: [
			RouteRule{
				match_pattern: '/*'
				mode:          'try_static'
				root:          root
			},
			RouteRule{
				match_pattern: '/*'
				mode:          'embed_php'
				root:          root
				entry:         entry
			},
		]
	}
	asset_target := resolve_target(config, '/app.css') or { panic(err) }
	assert asset_target.kind == .static_file
	php_target := resolve_target(config, '/index.php') or { panic(err) }
	assert php_target.kind == .php
	assert php_target.path == os.real_path(entry)
}
