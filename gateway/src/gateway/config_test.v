module gateway

import os

fn test_framework_example_configs_load() {
	examples_dir := os.norm_path(os.join_path(os.dir(@FILE), '..', '..', 'examples'))
	for name in ['wordpress.yml', 'laravel.yml'] {
		config := load_config(os.join_path(examples_dir, name)) or { panic(err) }
		assert config.server.port > 0
		assert config.server.workers == 4
		assert config.server.php_lanes == 4
		assert config.routes.len > 1
		assert config.routes.last().mode == 'embed_php'
		assert os.is_abs_path(config.routes.last().root)
		assert os.is_abs_path(config.routes.last().entry)
	}
}
