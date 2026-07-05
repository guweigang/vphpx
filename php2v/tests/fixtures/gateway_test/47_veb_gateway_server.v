module main

import rt
import net.http
import time

fn main() {
	// 1. 异步启动 veb 网关，在端口 8083 运行我们的转译脚本 run_47_veb_gateway
	spawn rt.start_gateway(8083, run_47_veb_gateway)
	
	// 2. 等待网关启动监听
	time.sleep(1000 * time.millisecond)
	
	println('Sending test HTTP requests to veb gateway...')
	
	// 3. 并发/交替发送请求以验证超全局变量 $_GET 与 $_SERVER 的线程局部并发隔离
	res1 := http.get('http://localhost:8083/?user=alice') or { panic(err) }
	println('Response 1: ${res1.body}')
	assert res1.body == 'Hello, alice! Method is GET'
	
	res2 := http.get('http://localhost:8083/?user=bob') or { panic(err) }
	println('Response 2: ${res2.body}')
	assert res2.body == 'Hello, bob! Method is GET'
	
	res3 := http.get('http://localhost:8083/?user=charlie') or { panic(err) }
	println('Response 3: ${res3.body}')
	assert res3.body == 'Hello, charlie! Method is GET'
	
	println('All veb gateway requests validated successfully!')
	exit(0)
}
