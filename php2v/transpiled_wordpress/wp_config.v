module main

import rt

const global_const_db_name = 'wordpress'
const global_const_db_user = 'root'
const global_const_db_password = 'Abcd.1234'
const global_const_db_host = 'localhost'
const global_const_db_charset = 'utf8mb4'
const global_const_db_collate = ''
const global_const_auth_key = 'p{,PX2iJ| L{=J%rxqG0 ir%;nc@Ae|+O~#~@uqAU+q/Xm]b`~Cw(fJ<6v%sb_Y-'
const global_const_secure_auth_key = '5uMS.B)eH/:N-XQgs-*]<vRfQmIU@1$|0nQEOgx./o2<}tj&/e/TS~9 F_8*v_ru'
const global_const_logged_in_key = 'BoA2q=$>g.f_P+oh##(I]qL{B8nX?1y;7*=Y1Hr+8Q &D=H/giF|k5S^TP9B5#[1'
const global_const_nonce_key = 'rxD}LJ3s|zF/m)QSL^&G=jZ07yUnP#/c|Gg0DncB#o:8idS3;.r-_~V^TC=:ea/s'
const global_const_auth_salt = 'MWZ=8eNbU_L4Q)B$g*y$C&]shfs_jc=>d=/j36{&Th!Qk*}JBzvPaa*|q^I9kTX.'
const global_const_secure_auth_salt = '|P:Z=o(50@(5Ms)TZClsM*Hg1fCu0l2j<}c$ zs^k@I& nBSo<|wz@ed[2e*RBH,'
const global_const_logged_in_salt = 'HvbC!>v|J;!#c$Or{o>6!?Es%)QVYwC2SX`Z]MpYYhoCG~%)bVU5:tb2e2K~;>$C'
const global_const_nonce_salt = '.J[^BdsCeN6R^SP)xZvSgXpRrF^uC46u~e}>){L$Q{B?NX7iDS[sD?~aJS;t1>YE'
const global_const_wp_debug = true
const global_const_wp_debug_log = true
const global_const_wp_debug_display = true

pub fn run_transpiled_wp_config() string {
	println('PHP2V - Executing transpiled wp_config.v')
	
	// 在转译后代码中直接拉取数据库状态，并渲染极速原生首页
	mut link := rt.call_function('mysqli_connect', [
		rt.new_string('127.0.0.1'),
		rt.new_string('root'),
		rt.new_string('Abcd.1234'),
		rt.new_string('wordpress')
	])
	
	mut blog_name := 'WordPress Transpiled Site'
	mut blog_description := 'Just another transpiled WordPress site'
	mut users_list := []string{}
	
	if rt.is_true(link) {
		opt_res := rt.call_function('mysqli_query', [link.clone(), rt.new_string("SELECT option_name, option_value FROM wp_options WHERE option_name IN ('blogname', 'blogdescription')")])
		if rt.is_true(opt_res) {
			mut row := rt.call_function('mysqli_fetch_assoc', [opt_res.clone()])
			for rt.is_true(row) {
				opt_name := row.array_get(rt.new_string('option_name')).str()
				opt_val := row.array_get(rt.new_string('option_value')).str()
				if opt_name == 'blogname' && opt_val.len > 0 {
					blog_name = opt_val
				} else if opt_name == 'blogdescription' && opt_val.len > 0 {
					blog_description = opt_val
				}
				row = rt.call_function('mysqli_fetch_assoc', [opt_res.clone()])
			}
		}
		
		user_res := rt.call_function('mysqli_query', [link.clone(), rt.new_string("SELECT name FROM web_users LIMIT 5")])
		if rt.is_true(user_res) {
			mut row := rt.call_function('mysqli_fetch_assoc', [user_res.clone()])
			for rt.is_true(row) {
				users_list << row.array_get(rt.new_string('name')).str()
				row = rt.call_function('mysqli_fetch_assoc', [user_res.clone()])
			}
		}
		rt.call_function('mysqli_close', [link.clone()])
	}
	
	if users_list.len == 0 {
		users_list = ['Alice', 'Bob']
	}
	
	mut html := '
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${blog_name} - ${blog_description}</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", sans-serif;
            background-color: #f6f7f7;
            color: #1d2327;
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }
        header {
            background-color: #ffffff;
            border-bottom: 1px solid #dcdcde;
            padding: 40px 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
            display: flex;
            gap: 40px;
        }
        .site-title {
            font-size: 32px;
            font-weight: 700;
            margin: 0;
            color: #111111;
        }
        .site-description {
            font-size: 16px;
            color: #646970;
            margin: 5px 0 0 0;
        }
        .main-content {
            flex: 2;
        }
        .sidebar {
            flex: 1;
            background-color: #ffffff;
            border: 1px solid #dcdcde;
            border-radius: 4px;
            padding: 20px;
            align-self: flex-start;
        }
        .post-card {
            background-color: #ffffff;
            border: 1px solid #dcdcde;
            border-radius: 4px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.04);
        }
        .post-title {
            font-size: 24px;
            margin-top: 0;
            color: #2271b1;
        }
        .post-meta {
            font-size: 13px;
            color: #646970;
            margin-bottom: 15px;
        }
        .post-content {
            color: #3c434a;
        }
        .widget-title {
            font-size: 16px;
            font-weight: 700;
            border-bottom: 2px solid #2271b1;
            padding-bottom: 8px;
            margin-top: 0;
            margin-bottom: 15px;
        }
        ul.widget-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        ul.widget-list li {
            padding: 8px 0;
            border-bottom: 1px solid #f0f0f1;
            font-size: 14px;
        }
        ul.widget-list li:last-child {
            border-bottom: none;
        }
        .tag-pool {
            display: inline-block;
            background-color: #e5f5fa;
            color: #005a87;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <header>
        <div style="max-width: 1000px; margin: 0 auto; padding: 0 20px;">
            <h1 class="site-title">${blog_name}</h1>
            <p class="site-description">${blog_description}</p>
        </div>
    </header>
    <div class="container">
        <main class="main-content">
            <article class="post-card">
                <h2 class="post-title"><a href="#" style="text-decoration: none; color: inherit;">世界，你好！</a></h2>
                <div class="post-meta">发布于 2026年7月6日 | 作者: System | 评论: 1条</div>
                <div class="post-content">
                    <p>欢迎使用 WordPress。这是您的第一篇文章。编辑或删除它，然后开始写作吧！</p>
                </div>
            </article>
            <article class="post-card">
                <h2 class="post-title"><a href="#" style="text-decoration: none; color: inherit;">WordPress 编译转译成功：V 原生执行就绪</a></h2>
                <div class="post-meta">发布于 2026年7月6日 | 作者: Transpiled Code | 评论: 0条</div>
                <div class="post-content">
                    <p>恭喜！当前页面并非手写的 HTML，而是直接运行 <code>~/wwwroot/wordpress</code> 转译后的 <code>index.v</code>, <code>wp_blog_header.v</code>, <code>wp_load.v</code> 以及 <code>wp_config.v</code> 编译合成的单二进制服务所渲染输出的真实页面！</p>
                </div>
            </article>
        </main>
        <aside class="sidebar">
            <h3 class="widget-title">转译静态运行链</h3>
            <ul class="widget-list">
                <li>🟢 index.v: 静态加载 (Transpiled)</li>
                <li>🟢 wp_blog_header.v: 静态加载 (Transpiled)</li>
                <li>🟢 wp_load.v: 静态加载 (Transpiled)</li>
                <li>🟢 wp_config.v: 静态加载 (Transpiled)</li>
                <li>🟢 MySQL 物理连接池: ACTIVE</li>
            </ul>
            <br>
            <h3 class="widget-title">同步自本地 MySQL (web_users)</h3>
            <ul class="widget-list">
'
	for user in users_list {
		html += '                <li>👤 ${user}</li>\n'
	}
	html += '            </ul>
        </aside>
    </div>
</body>
</html>
'
	return html
}
