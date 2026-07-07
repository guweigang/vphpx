module main

import rt

pub fn run_transpiled_wp_blog_header() string {
	println('PHP2V - Executing transpiled wp_blog_header.v')
	
	// 1. 执行上一级引导
	_ = run_transpiled_wp_load()
	
	// 2. 调用核心初始化 wp() 函数
	_ = rt.call_function('wp', []rt.PhpVal{})
	
	// 3. 原生加载执行 template-loader.php 编译主题模板
	_ = rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/template-loader.php', '4')
		
	return ''
}
