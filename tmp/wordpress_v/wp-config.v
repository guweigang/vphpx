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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_table_prefix := 'wp_'
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.include_file(var_vhttpdVendor.dup().to_string().trim_right(' \t\n\r') + '/wordpress/vhttpd-db.php', '4')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		rt.call_function('define', [rt.new_string('ABSPATH'), @DIR + '/'])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-settings.php', '4')
}
