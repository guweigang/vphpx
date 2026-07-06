module main

import rt

pub fn run_transpiled_wp_blog_header() string {
	println('PHP2V - Executing transpiled wp_blog_header.v')
	
	// 在 V 侧直接静态调用转译后的 wp_load 引导并原路返回
	return run_transpiled_wp_load()
}
