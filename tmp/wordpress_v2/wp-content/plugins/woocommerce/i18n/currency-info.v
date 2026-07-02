import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_global_formats := {
		'ls_comma_dot_ltr':   {
			'thousand_sep': rt.new_string('.')
			'decimal_sep':  rt.new_string(',')
			'direction':    rt.new_string('ltr')
			'currency_pos': rt.new_string('left_space')
		}
		'ls_comma_dot_rtl':   {
			'thousand_sep': rt.new_string('.')
			'decimal_sep':  rt.new_string(',')
			'direction':    rt.new_string('rtl')
			'currency_pos': rt.new_string('left_space')
		}
		'ls_comma_space_ltr': {
			'thousand_sep': rt.new_string(' ')
			'decimal_sep':  rt.new_string(',')
			'direction':    rt.new_string('ltr')
			'currency_pos': rt.new_string('left_space')
		}
		'ls_dot_apos_ltr':    {
			'thousand_sep': rt.new_string("'")
			'decimal_sep':  rt.new_string('.')
			'direction':    rt.new_string('ltr')
			'currency_pos': rt.new_string('left_space')
		}
		'ls_dot_comma_ltr':   {
			'thousand_sep': rt.new_string(',')
			'decimal_sep':  rt.new_string('.')
			'direction':    rt.new_string('ltr')
			'currency_pos': rt.new_string('left_space')
		}
		'ls_dot_comma_rtl':   {
			'thousand_sep': rt.new_string(',')
			'decimal_sep':  rt.new_string('.')
			'direction':    rt.new_string('rtl')
			'currency_pos': rt.new_string('left_space')
		}
		'lx_comma_dot_ltr':   {
			'thousand_sep': rt.new_string('.')
			'decimal_sep':  rt.new_string(',')
			'direction':    rt.new_string('ltr')
			'currency_pos': rt.new_string('left')
		}
		'lx_comma_dot_rtl':   {
			'thousand_sep': rt.new_string('.')
			'decimal_sep':  rt.new_string(',')
			'direction':    rt.new_string('rtl')
			'currency_pos': rt.new_string('left')
		}
		'lx_comma_space_ltr': {
			'thousand_sep': rt.new_string(' ')
			'decimal_sep':  rt.new_string(',')
			'direction':    rt.new_string('ltr')
			'currency_pos': rt.new_string('left')
		}
		'lx_dot_comma_ltr':   {
			'thousand_sep': rt.new_string(',')
			'decimal_sep':  rt.new_string('.')
			'direction':    rt.new_string('ltr')
			'currency_pos': rt.new_string('left')
		}
		'lx_dot_space_ltr':   {
			'thousand_sep': rt.new_string(' ')
			'decimal_sep':  rt.new_string('.')
			'direction':    rt.new_string('ltr')
			'currency_pos': rt.new_string('left')
		}
		'rs_comma_dot_ltr':   {
			'thousand_sep': rt.new_string('.')
			'decimal_sep':  rt.new_string(',')
			'direction':    rt.new_string('ltr')
			'currency_pos': rt.new_string('right_space')
		}
		'rs_comma_dot_rtl':   {
			'thousand_sep': rt.new_string('.')
			'decimal_sep':  rt.new_string(',')
			'direction':    rt.new_string('rtl')
			'currency_pos': rt.new_string('right_space')
		}
		'rs_comma_space_ltr': {
			'thousand_sep': rt.new_string(' ')
			'decimal_sep':  rt.new_string(',')
			'direction':    rt.new_string('ltr')
			'currency_pos': rt.new_string('right_space')
		}
		'rs_dot_apos_ltr':    {
			'thousand_sep': rt.new_string("'")
			'decimal_sep':  rt.new_string('.')
			'direction':    rt.new_string('ltr')
			'currency_pos': rt.new_string('right_space')
		}
		'rs_dot_comma_ltr':   {
			'thousand_sep': rt.new_string(',')
			'decimal_sep':  rt.new_string('.')
			'direction':    rt.new_string('ltr')
			'currency_pos': rt.new_string('right_space')
		}
		'rs_dot_comma_rtl':   {
			'thousand_sep': rt.new_string(',')
			'decimal_sep':  rt.new_string('.')
			'direction':    rt.new_string('rtl')
			'currency_pos': rt.new_string('right_space')
		}
		'rx_comma_dot_ltr':   {
			'thousand_sep': rt.new_string('.')
			'decimal_sep':  rt.new_string(',')
			'direction':    rt.new_string('ltr')
			'currency_pos': rt.new_string('right')
		}
		'rx_dot_comma_ltr':   {
			'thousand_sep': rt.new_string(',')
			'decimal_sep':  rt.new_string('.')
			'direction':    rt.new_string('ltr')
			'currency_pos': rt.new_string('right')
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'AED', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_AE', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'AFN', val: rt.create_array([
			rt.ArrayItem{ key: 'fa_AF', val: var_global_formats['ls_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'ps_AF', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'uz_AF', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'ALL', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'sq_AL', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'AMD', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'hy_AM', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'ANG', val: rt.create_array([
			rt.ArrayItem{ key: 'en_SX', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'nl_CW', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'nl_SX', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'AOA', val: rt.create_array([
			rt.ArrayItem{ key: 'pt_AO', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'ARS', val: rt.create_array([
			rt.ArrayItem{ key: 'es_AR', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'AUD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_AU', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_CC', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_CX', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_KI', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_NF', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_NR', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_TV', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'AWG', val: rt.create_array([
			rt.ArrayItem{ key: 'nl_AW', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'AZN', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'az_AZ', val: var_global_formats['rs_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'BAM', val: rt.create_array([
			rt.ArrayItem{ key: 'hr_BA', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'sr_Latn_BA', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'bs_BA', val: var_global_formats['rs_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'BBD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_BB', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'BDT', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'bn_BD', val: var_global_formats['rx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'BGN', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'bg_BG', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'BHD', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_BH', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'BIF', val: rt.create_array([
			rt.ArrayItem{ key: 'en_BI', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'fr_BI', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'rn_BI', val: var_global_formats['rx_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'BMD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_BM', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'BND', val: rt.create_array([
			rt.ArrayItem{ key: 'ms_BN', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'BOB', val: rt.create_array([
			rt.ArrayItem{ key: 'es_BO', val: var_global_formats['lx_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'qu_BO', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'BRL', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'pt_BR', val: var_global_formats['ls_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'BSD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_BS', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'BTN', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'dz_BT', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'BWP', val: rt.create_array([
			rt.ArrayItem{ key: 'en_BW', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'BYN', val: rt.create_array([
			rt.ArrayItem{ key: 'ru_BY', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'be_BY', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'BZD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_BZ', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'CAD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_CA', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'fr_CA', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'CDF', val: rt.create_array([
			rt.ArrayItem{ key: 'fr_CD', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'sw_CD', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'ln_CD', val: var_global_formats['rs_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'CHF', val: rt.create_array([
			rt.ArrayItem{ key: 'de_CH', val: var_global_formats['ls_dot_apos_ltr'] },
			rt.ArrayItem{ key: 'de_LI', val: var_global_formats['ls_dot_apos_ltr'] },
			rt.ArrayItem{ key: 'fr_CH', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'gsw_LI', val: var_global_formats['rs_dot_apos_ltr'] },
			rt.ArrayItem{ key: 'it_CH', val: var_global_formats['ls_dot_apos_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_dot_apos_ltr'] },
			rt.ArrayItem{ key: 'gsw_CH', val: var_global_formats['rs_dot_apos_ltr'] },
			rt.ArrayItem{ key: 'rm_CH', val: var_global_formats['rs_dot_apos_ltr'] },
		]) },
		rt.ArrayItem{ key: 'CLP', val: rt.create_array([
			rt.ArrayItem{ key: 'es_CL', val: var_global_formats['lx_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'CNY', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'bo_CN', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ug_CN', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'zh_CN', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'COP', val: rt.create_array([
			rt.ArrayItem{ key: 'es_CO', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'CRC', val: rt.create_array([
			rt.ArrayItem{ key: 'es_CR', val: var_global_formats['lx_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'CUC', val: rt.create_array([
			rt.ArrayItem{ key: 'es_CU', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'CVE', val: rt.create_array([
			rt.ArrayItem{ key: 'pt_CV', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'CZK', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'cs_CZ', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'DJF', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_DJ', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'fr_DJ', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'DKK', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'da_DK', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'fo_FO', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'kl_GL', val: var_global_formats['lx_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'DOP', val: rt.create_array([
			rt.ArrayItem{ key: 'es_DO', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'DZD', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_DZ', val: var_global_formats['ls_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'fr_DZ', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'EGP', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_EG', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'ERN', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_ER', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'en_ER', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ti_ER', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'ETB', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'am_ET', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'EUR', val: rt.create_array([
			rt.ArrayItem{ key: 'ca_AD', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'de_AT', val: var_global_formats['ls_comma_space_ltr'] },
			rt.ArrayItem{ key: 'de_BE', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'de_LU', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'el_CY', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'en_IE', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_MT', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'es_EA', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'es_IC', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'fr_BE', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_BL', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_GF', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_GP', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_LU', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'fr_MC', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_MF', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_MQ', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_PM', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_RE', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_YT', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'it_SM', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'it_VA', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'nl_BE', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'pt_PT', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'sq_XK', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'sr_Latn_ME', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'sr_Latn_XK', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'sv_AX', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'sv_FI', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'tr_CY', val: var_global_formats['lx_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'ast_ES', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'ca_ES', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'de_DE', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'el_GR', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'es_ES', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'et_EE', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'eu_ES', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'fi_FI', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_FR', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fy_NL', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'ga_IE', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'gl_ES', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'it_IT', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'lb_LU', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'lt_LT', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'lv_LV', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'mt_MT', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'nl_NL', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'sk_SK', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'sl_SI', val: var_global_formats['rs_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'FJD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_FJ', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'FKP', val: rt.create_array([
			rt.ArrayItem{ key: 'en_FK', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'GBP', val: rt.create_array([
			rt.ArrayItem{ key: 'en_GB', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_GG', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_IM', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_JE', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ga_GB', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'cy_GB', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'gd_GB', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'gv_IM', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'GEL', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'ka_GE', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'os_GE', val: var_global_formats['ls_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'GHS', val: rt.create_array([
			rt.ArrayItem{ key: 'en_GH', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ak_GH', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ee_GH', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'GIP', val: rt.create_array([
			rt.ArrayItem{ key: 'en_GI', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'GMD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_GM', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'GNF', val: rt.create_array([
			rt.ArrayItem{ key: 'fr_GN', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'GTQ', val: rt.create_array([
			rt.ArrayItem{ key: 'es_GT', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'GYD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_GY', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'HKD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_HK', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'zh_Hant_HK', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'HNL', val: rt.create_array([
			rt.ArrayItem{ key: 'es_HN', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'HRK', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'hr_HR', val: var_global_formats['rs_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'HUF', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'hu_HU', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'IDR', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'id_ID', val: var_global_formats['lx_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'ILS', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_IL', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'ar_PS', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'he_IL', val: var_global_formats['rs_dot_comma_rtl'] },
		]) },
		rt.ArrayItem{ key: 'INR', val: rt.create_array([
			rt.ArrayItem{ key: 'bn_IN', val: var_global_formats['rx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_IN', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ne_IN', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ur_IN', val: var_global_formats['ls_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'as_IN', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'dz_BT', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'gu_IN', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'hi_IN', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'kn_IN', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'kok_IN', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'mai_IN', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ml_IN', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'mr_IN', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'or_IN', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'sa_IN', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'sd_PK', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'ta_IN', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'te_IN', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'IQD', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_IQ', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'ckb_IQ', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'IRR', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'fa_IR', val: var_global_formats['lx_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'ISK', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'is_IS', val: var_global_formats['rs_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'JMD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_JM', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'JOD', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_JO', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'ar_PS', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'JPY', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ja_JP', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'KES', val: rt.create_array([
			rt.ArrayItem{ key: 'en_KE', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'sw_KE', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'KGS', val: rt.create_array([
			rt.ArrayItem{ key: 'ru_KG', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'ky_KG', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'KHR', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rx_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'km_KH', val: var_global_formats['rx_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'KMF', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_KM', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'fr_KM', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'KPW', val: rt.create_array([
			rt.ArrayItem{ key: 'ko_KP', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'KRW', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ko_KR', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'KWD', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_KW', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'KYD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_KY', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'KZT', val: rt.create_array([
			rt.ArrayItem{ key: 'ru_KZ', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'kk_KZ', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'LAK', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'lo_LA', val: var_global_formats['lx_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'LBP', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_LB', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'LKR', val: rt.create_array([
			rt.ArrayItem{ key: 'ta_LK', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'si_LK', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'LRD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_LR', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'LSL', val: rt.create_array([
			rt.ArrayItem{ key: 'en_LS', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'LYD', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_LY', val: var_global_formats['ls_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'MAD', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_EH', val: var_global_formats['ls_dot_comma_rtl'] },
			rt.ArrayItem{ key: 'ar_MA', val: var_global_formats['ls_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'fr_MA', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_dot_comma_rtl'] },
			rt.ArrayItem{ key: 'tzm_MA', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'MDL', val: rt.create_array([
			rt.ArrayItem{ key: 'ro_MD', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'MGA', val: rt.create_array([
			rt.ArrayItem{ key: 'en_MG', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'fr_MG', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'mg_MG', val: var_global_formats['ls_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'MKD', val: rt.create_array([
			rt.ArrayItem{ key: 'sq_MK', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'mk_MK', val: var_global_formats['rs_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'MMK', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'my_MM', val: var_global_formats['rs_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'MNT', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'mn_MN', val: var_global_formats['ls_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'MOP', val: rt.create_array([
			rt.ArrayItem{ key: 'pt_MO', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'zh_Hant_MO', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'MRU', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_MR', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'MUR', val: rt.create_array([
			rt.ArrayItem{ key: 'en_MU', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'fr_MU', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'MVR', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: 'MWK', val: rt.create_array([
			rt.ArrayItem{ key: 'en_MW', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'MXN', val: rt.create_array([
			rt.ArrayItem{ key: 'es_MX', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'MYR', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ms_MY', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'MZN', val: rt.create_array([
			rt.ArrayItem{ key: 'pt_MZ', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'NAD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_NA', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'NGN', val: rt.create_array([
			rt.ArrayItem{ key: 'en_NG', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'yo_NG', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'NIO', val: rt.create_array([
			rt.ArrayItem{ key: 'es_NI', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'NOK', val: rt.create_array([
			rt.ArrayItem{ key: 'nb_SJ', val: var_global_formats['ls_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_comma_space_ltr'] },
			rt.ArrayItem{ key: 'nb_NO', val: var_global_formats['ls_comma_space_ltr'] },
			rt.ArrayItem{ key: 'nn_NO', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'se_NO', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'NPR', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ne_NP', val: var_global_formats['ls_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'NZD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_CK', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_NU', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_NZ', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_PN', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_TK', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'mi_NZ', val: var_global_formats['ls_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'OMR', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_OM', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'PEN', val: rt.create_array([
			rt.ArrayItem{ key: 'es_PE', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'qu_PE', val: var_global_formats['ls_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'PGK', val: rt.create_array([
			rt.ArrayItem{ key: 'en_PG', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'PHP', val: rt.create_array([
			rt.ArrayItem{ key: 'en_PH', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ceb_PH', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'fil_PH', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'PKR', val: rt.create_array([
			rt.ArrayItem{ key: 'en_PK', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ur_PK', val: var_global_formats['ls_dot_comma_rtl'] },
		]) },
		rt.ArrayItem{ key: 'PLN', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'pl_PL', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'PYG', val: rt.create_array([
			rt.ArrayItem{ key: 'es_PY', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'QAR', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_QA', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'RON', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'ro_RO', val: var_global_formats['rs_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'RSD', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'sr_RS', val: var_global_formats['rs_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'RUB', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'ce_RU', val: var_global_formats['rs_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ru_RU', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'sah_RU', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'tt_RU', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'RWF', val: rt.create_array([
			rt.ArrayItem{ key: 'en_RW', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'fr_RW', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'rw_RW', val: var_global_formats['ls_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'SAR', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_SA', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'SBD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_SB', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'SCR', val: rt.create_array([
			rt.ArrayItem{ key: 'en_SC', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'fr_SC', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'SDG', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_SD', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'en_SD', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'SEK', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'sv_SE', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'SGD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_SG', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ms_SG', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'ta_SG', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'SHP', val: rt.create_array([
			rt.ArrayItem{ key: 'en_SH', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'SLL', val: rt.create_array([
			rt.ArrayItem{ key: 'en_SL', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'SOS', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_SO', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'so_SO', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'SRD', val: rt.create_array([
			rt.ArrayItem{ key: 'nl_SR', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'SSP', val: rt.create_array([
			rt.ArrayItem{ key: 'en_SS', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'STN', val: rt.create_array([
			rt.ArrayItem{ key: 'pt_ST', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'SYP', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_SY', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'fr_SY', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'SZL', val: rt.create_array([
			rt.ArrayItem{ key: 'en_SZ', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'THB', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'th_TH', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'TJS', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'tg_TJ', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'TMT', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'tk_TM', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'TND', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_TN', val: var_global_formats['ls_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'fr_TN', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'TOP', val: rt.create_array([
			rt.ArrayItem{ key: 'en_TO', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'to_TO', val: var_global_formats['ls_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'TRY', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'tr_TR', val: var_global_formats['lx_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'TTD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_TT', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'TWD', val: rt.create_array([
			rt.ArrayItem{ key: 'zh_Hant', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'TZS', val: rt.create_array([
			rt.ArrayItem{ key: 'en_TZ', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'sw_TZ', val: var_global_formats['ls_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'UAH', val: rt.create_array([
			rt.ArrayItem{ key: 'ru_UA', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'uk_UA', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'UGX', val: rt.create_array([
			rt.ArrayItem{ key: 'en_UG', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'sw_UG', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'USD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_AS', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_DG', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_FM', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_GU', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_IO', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_MH', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_MP', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_PR', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_PW', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_TC', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_UM', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_VG', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_VI', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_ZW', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'es_EC', val: var_global_formats['lx_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'es_PA', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'es_PR', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'es_SV', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'es_US', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'fr_HT', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'nl_BQ', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'pt_TL', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'qu_EC', val: var_global_formats['ls_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_US', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'haw_US', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'nd_ZW', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'sn_ZW', val: var_global_formats['ls_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'UYU', val: rt.create_array([
			rt.ArrayItem{ key: 'es_UY', val: var_global_formats['ls_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'UZS', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'uz_AF', val: var_global_formats['rs_comma_space_ltr'] },
		]) },
		rt.ArrayItem{ key: 'VES', val: rt.create_array([
			rt.ArrayItem{ key: 'es_VE', val: var_global_formats['lx_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'VND', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'vi_VN', val: var_global_formats['rs_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'VUV', val: rt.create_array([
			rt.ArrayItem{ key: 'en_VU', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'fr_VU', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'WST', val: rt.create_array([
			rt.ArrayItem{ key: 'en_WS', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'XAF', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_TD', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'en_CM', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'es_GQ', val: var_global_formats['lx_comma_dot_ltr'] },
			rt.ArrayItem{ key: 'fr_CF', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_CG', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_CM', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_GA', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_GQ', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_TD', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'pt_GQ', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'sg_CF', val: var_global_formats['lx_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'XCD', val: rt.create_array([
			rt.ArrayItem{ key: 'en_AG', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_AI', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_DM', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_GD', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_KN', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_LC', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_MS', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_VC', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'XOF', val: rt.create_array([
			rt.ArrayItem{ key: 'fr_BF', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_BJ', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_CI', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_ML', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_NE', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_SN', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_TG', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'pt_GW', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'dyo_SN', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'wo_SN', val: var_global_formats['ls_comma_dot_ltr'] },
		]) },
		rt.ArrayItem{ key: 'XPF', val: rt.create_array([
			rt.ArrayItem{ key: 'fr_NC', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_PF', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'fr_WF', val: var_global_formats['rs_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['ls_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'YER', val: rt.create_array([
			rt.ArrayItem{ key: 'ar_YE', val: var_global_formats['rs_comma_dot_rtl'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['rs_comma_dot_rtl'] },
		]) },
		rt.ArrayItem{ key: 'ZAR', val: rt.create_array([
			rt.ArrayItem{ key: 'en_LS', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_NA', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'en_ZA', val: var_global_formats['lx_comma_space_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'af_ZA', val: var_global_formats['lx_comma_space_ltr'] },
			rt.ArrayItem{ key: 'xh_ZA', val: var_global_formats['lx_dot_space_ltr'] },
			rt.ArrayItem{ key: 'zu_ZA', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
		rt.ArrayItem{ key: 'ZMW', val: rt.create_array([
			rt.ArrayItem{ key: 'en_ZM', val: var_global_formats['lx_dot_comma_ltr'] },
			rt.ArrayItem{ key: 'default', val: var_global_formats['lx_dot_comma_ltr'] },
		]) },
	])
}
