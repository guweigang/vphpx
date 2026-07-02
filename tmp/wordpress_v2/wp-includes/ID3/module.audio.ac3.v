import rt

pub fn Class_getid3_ac3.syncword() i64 {
	return 2935
}

struct Class_getid3_ac3 {
	rt.PhpObjectBase
pub mut:
	AC3header rt.PhpVal = rt.new_array()
	BSIoffset rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_getid3_ac3) analyze() bool {
	mut var_info := map[string]rt.PhpVal{}
	mut var_thisfile_ac3 := rt.new_null()
	mut var_thisfile_ac3_raw := map[string]rt.PhpVal{}
	mut var_thisfile_ac3_raw_bsi := map[string]rt.PhpVal{}
	var_info = rt.get_property(rt.get_property(rt.new_object('getid3_ac3', [
		'getid3_handler',
	], &this), 'getid3'), 'info')
	var_info.array_get_mut('ac3').array_get_mut('raw').array_set('bsi', rt.new_array())
	var_thisfile_ac3 = var_info.array_get(rt.new_string('ac3'))
	var_thisfile_ac3_raw = var_thisfile_ac3.array_get(rt.new_string('raw'))
	var_thisfile_ac3_raw_bsi = var_thisfile_ac3_raw.array_get(rt.new_string('bsi'))
	var_info['fileformat'] = rt.new_string('ac3')
	this.fseek(var_info.array_get(rt.new_string('avdataoffset')))
	mut var_tempAC3header := this.fread(rt.new_int(100))
	mut iife_temp_0 := Class_getid3_lib{}
	mut iife_result_0 := iife_temp_0.bigendian2int(rt.call_function('substr', [
		var_tempAC3header.clone(),
		rt.new_int(0),
		rt.new_int(2),
	]))
	this.AC3header.array_set('syncinfo', iife_result_0)
	mut iife_temp_1 := Class_getid3_lib{}
	mut iife_result_1 := iife_temp_1.bigendian2bin(rt.call_function('substr', [
		var_tempAC3header.clone(),
		rt.new_int(2),
	]))
	this.AC3header.array_set('bsi', iife_result_1)
	mut iife_temp_2 := Class_getid3_lib{}
	mut iife_result_2 := iife_temp_2.littleendian2int(rt.call_function('substr', [
		var_tempAC3header.clone(),
		rt.new_int(5),
		rt.new_int(1),
	]))
	var_thisfile_ac3_raw_bsi['bsid'] = rt.bitwise_and(iife_result_2, rt.new_int(248)) >> 3
	var_tempAC3header = rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.AC3header.array_get(rt.new_string('syncinfo')),
		Class_getid3_ac3.syncword()))))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(this.isdependencyfor(rt.new_string('matroska')))))) {
			var_info.delete('fileformat')
			var_info.delete('ac3')
			return (this.error(rt.new_string('Expecting "' +
				(rt.call_function('dechex', [rt.new_int(Class_getid3_ac3.syncword())])).str() +
				'" at offset ' +
				(var_info.array_get(rt.new_string('avdataoffset'))).str() + ', found "' + (rt.call_function('dechex', [this.AC3header.array_get(rt.new_string('syncinfo'))])).str() +
				'"'))).to_bool()
		}
	}
	var_info.array_get_mut('audio').array_set('dataformat', 'ac3')
	var_info.array_get_mut('audio').array_set('bitrate_mode', 'cbr')
	var_info.array_get_mut('audio').array_set('lossless', false)
	if rt.is_true(rt.less_equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('bsid')),
		rt.new_int(8)))
	{
		mut iife_temp_3 := Class_getid3_lib{}
		mut iife_result_3 := iife_temp_3.bin2dec(this.readheaderbsi(rt.new_int(16)))
		var_thisfile_ac3_raw_bsi['crc1'] = iife_result_3
		var_thisfile_ac3_raw_bsi['fscod'] = this.readheaderbsi(rt.new_int(2))
		var_thisfile_ac3_raw_bsi['frmsizecod'] = this.readheaderbsi(rt.new_int(6))
		if rt.is_true(rt.greater(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('frmsizecod')),
			rt.new_int(37)))
		{
			this.warning(rt.new_string('Unexpected ac3.bsi.frmsizecod value: ' +
				(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('frmsizecod'))).str() + ', bitrate not set correctly'))
		}
		var_thisfile_ac3_raw_bsi['bsid'] = this.readheaderbsi(rt.new_int(5))
		var_thisfile_ac3_raw_bsi['bsmod'] = this.readheaderbsi(rt.new_int(3))
		var_thisfile_ac3_raw_bsi['acmod'] = this.readheaderbsi(rt.new_int(3))
		if rt.is_true(rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')),
			rt.new_int(1)))
		{
			var_thisfile_ac3_raw_bsi['cmixlev'] = this.readheaderbsi(rt.new_int(2))
			var_thisfile_ac3.array_set('center_mix_level',
				Class_getid3_ac3.centermixlevellookup(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('cmixlev'))))
		}
		if rt.is_true(rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')),
			rt.new_int(4)))
		{
			var_thisfile_ac3_raw_bsi['surmixlev'] = this.readheaderbsi(rt.new_int(2))
			var_thisfile_ac3.array_set('surround_mix_level',
				Class_getid3_ac3.surroundmixlevellookup(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('surmixlev'))))
		}
		if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')),
			rt.new_int(2)))
		{
			var_thisfile_ac3_raw_bsi['dsurmod'] = this.readheaderbsi(rt.new_int(2))
			var_thisfile_ac3.array_set('dolby_surround_mode',
				Class_getid3_ac3.dolbysurroundmodelookup(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('dsurmod'))))
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('lfeon',
			(this.readheaderbsi(rt.new_int(1))).to_bool())
		var_thisfile_ac3_raw_bsi['dialnorm'] = this.readheaderbsi(rt.new_int(5))
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('compr',
			(this.readheaderbsi(rt.new_int(1))).to_bool())
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('compr'))) {
			var_thisfile_ac3_raw_bsi['compr'] = this.readheaderbsi(rt.new_int(8))
			var_thisfile_ac3.array_set('heavy_compression',
				Class_getid3_ac3.heavycompression(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('compr'))))
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('langcod',
			(this.readheaderbsi(rt.new_int(1))).to_bool())
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('langcod'))) {
			var_thisfile_ac3_raw_bsi['langcod'] = this.readheaderbsi(rt.new_int(8))
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('audprodinfo',
			(this.readheaderbsi(rt.new_int(1))).to_bool())
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('audprodinfo'))) {
			var_thisfile_ac3_raw_bsi['mixlevel'] = this.readheaderbsi(rt.new_int(5))
			var_thisfile_ac3_raw_bsi['roomtyp'] = this.readheaderbsi(rt.new_int(2))
			var_thisfile_ac3.array_set('mixing_level',
				(rt.add(rt.new_int(80), var_thisfile_ac3_raw_bsi.array_get(rt.new_string('mixlevel')))).str() +
				'dB')
			var_thisfile_ac3.array_set('room_type',
				Class_getid3_ac3.roomtypelookup(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('roomtyp'))))
		}
		var_thisfile_ac3_raw_bsi['dialnorm2'] = this.readheaderbsi(rt.new_int(5))
		var_thisfile_ac3.array_set('dialogue_normalization2', '-' +
			(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('dialnorm2'))).str() + 'dB')
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('compr2',
			(this.readheaderbsi(rt.new_int(1))).to_bool())
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('compr2'))) {
			var_thisfile_ac3_raw_bsi['compr2'] = this.readheaderbsi(rt.new_int(8))
			var_thisfile_ac3.array_set('heavy_compression2',
				Class_getid3_ac3.heavycompression(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('compr2'))))
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('langcod2',
			(this.readheaderbsi(rt.new_int(1))).to_bool())
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('langcod2'))) {
			var_thisfile_ac3_raw_bsi['langcod2'] = this.readheaderbsi(rt.new_int(8))
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('audprodinfo2',
			(this.readheaderbsi(rt.new_int(1))).to_bool())
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('audprodinfo2'))) {
			var_thisfile_ac3_raw_bsi['mixlevel2'] = this.readheaderbsi(rt.new_int(5))
			var_thisfile_ac3_raw_bsi['roomtyp2'] = this.readheaderbsi(rt.new_int(2))
			var_thisfile_ac3.array_set('mixing_level2',
				(rt.add(rt.new_int(80), var_thisfile_ac3_raw_bsi.array_get(rt.new_string('mixlevel2')))).str() +
				'dB')
			var_thisfile_ac3.array_set('room_type2',
				Class_getid3_ac3.roomtypelookup(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('roomtyp2'))))
		}
		var_thisfile_ac3_raw_bsi['copyright'] = (this.readheaderbsi(rt.new_int(1))).to_bool()
		var_thisfile_ac3_raw_bsi['original'] = (this.readheaderbsi(rt.new_int(1))).to_bool()
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('timecod1',
			this.readheaderbsi(rt.new_int(2)))
		if rt.is_true(rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('timecod1')),
			rt.new_int(1)))
		{
			var_thisfile_ac3_raw_bsi['timecod1'] = this.readheaderbsi(rt.new_int(14))
			var_thisfile_ac3.array_set('timecode1', 0)
			var_thisfile_ac3.array_get(rt.new_string('timecode1')) = rt.add(var_thisfile_ac3.array_get(rt.new_string('timecode1')), rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('timecod1')),
				rt.new_int(15872)) >> 9 * 3600)
			var_thisfile_ac3.array_get(rt.new_string('timecode1')) = rt.add(var_thisfile_ac3.array_get(rt.new_string('timecode1')), rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('timecod1')),
				rt.new_int(504)) >> 3 * 60)
			var_thisfile_ac3.array_get(rt.new_string('timecode1')) = rt.add(var_thisfile_ac3.array_get(rt.new_string('timecode1')), rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('timecod1')),
				rt.new_int(3)) >> 0 * 8)
		}
		if rt.is_true(rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('timecod1')),
			rt.new_int(2)))
		{
			var_thisfile_ac3_raw_bsi['timecod2'] = this.readheaderbsi(rt.new_int(14))
			var_thisfile_ac3.array_set('timecode2', 0)
			var_thisfile_ac3.array_get(rt.new_string('timecode2')) = rt.add(var_thisfile_ac3.array_get(rt.new_string('timecode2')), rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('timecod2')),
				rt.new_int(14336)) >> 11 * 1)
			var_thisfile_ac3.array_get(rt.new_string('timecode2')) = rt.add(var_thisfile_ac3.array_get(rt.new_string('timecode2')), rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('timecod2')),
				rt.new_int(1984)) >> 6 * 1 / 30)
			var_thisfile_ac3.array_get(rt.new_string('timecode2')) = rt.add(var_thisfile_ac3.array_get(rt.new_string('timecode2')), rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('timecod2')),
				rt.new_int(63)) >> 0 * 1 / 30 / 60)
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('addbsi',
			(this.readheaderbsi(rt.new_int(1))).to_bool())
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('addbsi'))) {
			var_thisfile_ac3_raw_bsi['addbsi_length'] = rt.add(this.readheaderbsi(rt.new_int(6)),
				rt.new_int(1))
			mut iife_temp_4 := Class_getid3_lib{}
			mut iife_result_4 :=
				iife_temp_4.bigendian2bin(this.fread(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('addbsi_length'))))
			this.AC3header.array_get(rt.new_string('bsi')) = rt.concat(this.AC3header.array_get(rt.new_string('bsi')),
				iife_result_4)
			var_thisfile_ac3_raw_bsi['addbsi_data'] = rt.call_function('substr', [
				this.AC3header.array_get(rt.new_string('bsi')),
				this.BSIoffset,
				rt.mul(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('addbsi_length')),
					rt.new_int(8)),
			])
			this.BSIoffset = rt.add(this.BSIoffset, rt.mul(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('addbsi_length')),
				rt.new_int(8)))
		}
	} else if rt.is_true(rt.less_equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('bsid')),
		rt.new_int(16)))
	{
		this.error(rt.new_string(
			'E-AC3 parsing is incomplete and experimental in this version of getID3 (' + (rt.call_method(rt.get_property(rt.new_object('getid3_ac3', ['getid3_handler'], &this), 'getid3'), 'version', []rt.PhpVal{})).str() +
			'). Notably the bitrate calculations are wrong -- value might (or not) be correct, but it is not calculated correctly. Email info@getid3.org if you know how to calculate EAC3 bitrate correctly.'))
		var_info.array_get_mut('audio').array_set('dataformat', 'eac3')
		var_thisfile_ac3_raw_bsi['strmtyp'] = this.readheaderbsi(rt.new_int(2))
		var_thisfile_ac3_raw_bsi['substreamid'] = this.readheaderbsi(rt.new_int(3))
		var_thisfile_ac3_raw_bsi['frmsiz'] = this.readheaderbsi(rt.new_int(11))
		var_thisfile_ac3_raw_bsi['fscod'] = this.readheaderbsi(rt.new_int(2))
		if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('fscod')),
			rt.new_int(3)))
		{
			var_thisfile_ac3_raw_bsi['fscod2'] = this.readheaderbsi(rt.new_int(2))
			var_thisfile_ac3_raw_bsi['numblkscod'] = rt.new_int(3)
		} else {
			var_thisfile_ac3_raw_bsi['numblkscod'] = this.readheaderbsi(rt.new_int(2))
		}
		var_thisfile_ac3.array_get_mut('bsi').array_set('blocks_per_sync_frame',
			Class_getid3_ac3.blockspersyncframe(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('numblkscod'))))
		var_thisfile_ac3_raw_bsi['acmod'] = this.readheaderbsi(rt.new_int(3))
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('lfeon',
			(this.readheaderbsi(rt.new_int(1))).to_bool())
		var_thisfile_ac3_raw_bsi['bsid'] = this.readheaderbsi(rt.new_int(5))
		var_thisfile_ac3_raw_bsi['dialnorm'] = this.readheaderbsi(rt.new_int(5))
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('compr',
			(this.readheaderbsi(rt.new_int(1))).to_bool())
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('compr'))) {
			var_thisfile_ac3_raw_bsi['compr'] = this.readheaderbsi(rt.new_int(8))
		}
		if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')),
			rt.new_int(0)))
		{
			var_thisfile_ac3_raw_bsi['dialnorm2'] = this.readheaderbsi(rt.new_int(5))
			var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('compr2',
				(this.readheaderbsi(rt.new_int(1))).to_bool())
			if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('compr2'))) {
				var_thisfile_ac3_raw_bsi['compr2'] = this.readheaderbsi(rt.new_int(8))
			}
		}
		if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('strmtyp')),
			rt.new_int(1)))
		{
			var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('chanmap',
				(this.readheaderbsi(rt.new_int(1))).to_bool())
			if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('chanmap'))) {
				var_thisfile_ac3_raw_bsi['chanmap'] = this.readheaderbsi(rt.new_int(8))
			}
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('mixmdat',
			(this.readheaderbsi(rt.new_int(1))).to_bool())
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('mixmdat'))) {
			if rt.is_true(rt.greater(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')),
				rt.new_int(2)))
			{
				var_thisfile_ac3_raw_bsi['dmixmod'] = this.readheaderbsi(rt.new_int(2))
			}
			if rt.is_true(rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')), rt.new_int(1)))
				&& rt.is_true(rt.greater(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')), rt.new_int(2))) {
				var_thisfile_ac3_raw_bsi['ltrtcmixlev'] = this.readheaderbsi(rt.new_int(3))
				var_thisfile_ac3_raw_bsi['lorocmixlev'] = this.readheaderbsi(rt.new_int(3))
			}
			if rt.is_true(rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')),
				rt.new_int(4)))
			{
				var_thisfile_ac3_raw_bsi['ltrtsurmixlev'] = this.readheaderbsi(rt.new_int(3))
				var_thisfile_ac3_raw_bsi['lorosurmixlev'] = this.readheaderbsi(rt.new_int(3))
			}
			if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('lfeon'))) {
				var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('lfemixlevcod',
					(this.readheaderbsi(rt.new_int(1))).to_bool())
				if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('lfemixlevcod'))) {
					var_thisfile_ac3_raw_bsi['lfemixlevcod'] = this.readheaderbsi(rt.new_int(5))
				}
			}
			if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('strmtyp')),
				rt.new_int(0)))
			{
				var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('pgmscl',
					(this.readheaderbsi(rt.new_int(1))).to_bool())
				if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('pgmscl'))) {
					var_thisfile_ac3_raw_bsi['pgmscl'] = this.readheaderbsi(rt.new_int(6))
				}
				if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')),
					rt.new_int(0)))
				{
					var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('pgmscl2',
						(this.readheaderbsi(rt.new_int(1))).to_bool())
					if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('pgmscl2'))) {
						var_thisfile_ac3_raw_bsi['pgmscl2'] = this.readheaderbsi(rt.new_int(6))
					}
				}
				var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('extpgmscl',
					(this.readheaderbsi(rt.new_int(1))).to_bool())
				if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('extpgmscl'))) {
					var_thisfile_ac3_raw_bsi['extpgmscl'] = this.readheaderbsi(rt.new_int(6))
				}
				var_thisfile_ac3_raw_bsi['mixdef'] = this.readheaderbsi(rt.new_int(2))
				if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('mixdef')),
					rt.new_int(1)))
				{
					var_thisfile_ac3_raw_bsi['premixcmpsel'] =
						(this.readheaderbsi(rt.new_int(1))).to_bool()
					var_thisfile_ac3_raw_bsi['drcsrc'] =
						(this.readheaderbsi(rt.new_int(1))).to_bool()
					var_thisfile_ac3_raw_bsi['premixcmpscl'] = this.readheaderbsi(rt.new_int(3))
				} else if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('mixdef')),
					rt.new_int(2)))
				{
					var_thisfile_ac3_raw_bsi['mixdata'] = this.readheaderbsi(rt.new_int(12))
				} else if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('mixdef')),
					rt.new_int(3)))
				{
					mut var_mixdefbitsread := rt.new_int(0)
					var_thisfile_ac3_raw_bsi['mixdeflen'] = this.readheaderbsi(rt.new_int(5))
					var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(5))
					var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('mixdata2',
						(this.readheaderbsi(rt.new_int(1))).to_bool())
					var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
					if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('mixdata2'))) {
						var_thisfile_ac3_raw_bsi['premixcmpsel'] =
							(this.readheaderbsi(rt.new_int(1))).to_bool()
						var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
						var_thisfile_ac3_raw_bsi['drcsrc'] =
							(this.readheaderbsi(rt.new_int(1))).to_bool()
						var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
						var_thisfile_ac3_raw_bsi['premixcmpscl'] = this.readheaderbsi(rt.new_int(3))
						var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(3))
						var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('extpgmlscl',
							(this.readheaderbsi(rt.new_int(1))).to_bool())
						var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
						if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('extpgmlscl'))) {
							var_thisfile_ac3_raw_bsi['extpgmlscl'] =
								this.readheaderbsi(rt.new_int(4))
							var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(4))
						}
						var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('extpgmcscl',
							(this.readheaderbsi(rt.new_int(1))).to_bool())
						var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
						if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('extpgmcscl'))) {
							var_thisfile_ac3_raw_bsi['extpgmcscl'] =
								this.readheaderbsi(rt.new_int(4))
							var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(4))
						}
						var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('extpgmrscl',
							(this.readheaderbsi(rt.new_int(1))).to_bool())
						var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
						if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('extpgmrscl'))) {
							var_thisfile_ac3_raw_bsi['extpgmrscl'] =
								this.readheaderbsi(rt.new_int(4))
						}
						var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('extpgmlsscl',
							(this.readheaderbsi(rt.new_int(1))).to_bool())
						var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
						if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('extpgmlsscl'))) {
							var_thisfile_ac3_raw_bsi['extpgmlsscl'] =
								this.readheaderbsi(rt.new_int(4))
							var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(4))
						}
						var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('extpgmrsscl',
							(this.readheaderbsi(rt.new_int(1))).to_bool())
						var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
						if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('extpgmrsscl'))) {
							var_thisfile_ac3_raw_bsi['extpgmrsscl'] =
								this.readheaderbsi(rt.new_int(4))
							var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(4))
						}
						var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('extpgmlfescl',
							(this.readheaderbsi(rt.new_int(1))).to_bool())
						var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
						if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('extpgmlfescl'))) {
							var_thisfile_ac3_raw_bsi['extpgmlfescl'] =
								this.readheaderbsi(rt.new_int(4))
							var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(4))
						}
						var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('dmixscl',
							(this.readheaderbsi(rt.new_int(1))).to_bool())
						var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
						if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('dmixscl'))) {
							var_thisfile_ac3_raw_bsi['dmixscl'] = this.readheaderbsi(rt.new_int(4))
							var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(4))
						}
						var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('addch',
							(this.readheaderbsi(rt.new_int(1))).to_bool())
						var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
						if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('addch'))) {
							var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('extpgmaux1scl',
								(this.readheaderbsi(rt.new_int(1))).to_bool())
							var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
							if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('extpgmaux1scl'))) {
								var_thisfile_ac3_raw_bsi['extpgmaux1scl'] =
									this.readheaderbsi(rt.new_int(4))
								var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(4))
							}
							var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('extpgmaux2scl',
								(this.readheaderbsi(rt.new_int(1))).to_bool())
							var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
							if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('extpgmaux2scl'))) {
								var_thisfile_ac3_raw_bsi['extpgmaux2scl'] =
									this.readheaderbsi(rt.new_int(4))
								var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(4))
							}
						}
					}
					var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('mixdata3',
						(this.readheaderbsi(rt.new_int(1))).to_bool())
					var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
					if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('mixdata3'))) {
						var_thisfile_ac3_raw_bsi['spchdat'] = this.readheaderbsi(rt.new_int(5))
						var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(5))
						var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('addspchdat',
							(this.readheaderbsi(rt.new_int(1))).to_bool())
						var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
						if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('addspchdat'))) {
							var_thisfile_ac3_raw_bsi['spchdat1'] = this.readheaderbsi(rt.new_int(5))
							var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(5))
							var_thisfile_ac3_raw_bsi['spchan1att'] =
								this.readheaderbsi(rt.new_int(2))
							var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(2))
							var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('addspchdat1',
								(this.readheaderbsi(rt.new_int(1))).to_bool())
							var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(1))
							if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('addspchdat1'))) {
								var_thisfile_ac3_raw_bsi['spchdat2'] =
									this.readheaderbsi(rt.new_int(5))
								var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(5))
								var_thisfile_ac3_raw_bsi['spchan2att'] =
									this.readheaderbsi(rt.new_int(3))
								var_mixdefbitsread = rt.add(var_mixdefbitsread, rt.new_int(3))
							}
						}
					}
					mut var_mixdata_bits := rt.sub(rt.mul(rt.new_int(8), rt.add(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('mixdeflen')),
						rt.new_int(2))), var_mixdefbitsread)
					mut var_mixdata_fill := if rt.is_true(rt.mod_(var_mixdata_bits, rt.new_int(8))) {
						rt.sub(rt.new_int(8), rt.mod_(var_mixdata_bits, rt.new_int(8)))
					} else {
						rt.new_int(0)
					}
					var_thisfile_ac3_raw_bsi['mixdata'] =
						this.readheaderbsi(var_mixdata_bits.clone())
					var_thisfile_ac3_raw_bsi['mixdatafill'] =
						this.readheaderbsi(var_mixdata_fill.clone())
					var_mixdefbitsread = rt.new_null()
					var_mixdata_bits = rt.new_null()
					var_mixdata_fill = rt.new_null()
				}
				if rt.is_true(rt.less(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')),
					rt.new_int(2)))
				{
					var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('paninfo',
						(this.readheaderbsi(rt.new_int(1))).to_bool())
					if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('paninfo'))) {
						var_thisfile_ac3_raw_bsi['panmean'] = this.readheaderbsi(rt.new_int(8))
						var_thisfile_ac3_raw_bsi['paninfo'] = this.readheaderbsi(rt.new_int(6))
					}
					if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')),
						rt.new_int(0)))
					{
						var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('paninfo2',
							(this.readheaderbsi(rt.new_int(1))).to_bool())
						if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('paninfo2'))) {
							var_thisfile_ac3_raw_bsi['panmean2'] = this.readheaderbsi(rt.new_int(8))
							var_thisfile_ac3_raw_bsi['paninfo2'] = this.readheaderbsi(rt.new_int(6))
						}
					}
				}
				var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('frmmixcfginfo',
					(this.readheaderbsi(rt.new_int(1))).to_bool())
				if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('frmmixcfginfo'))) {
					if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('numblkscod')),
						rt.new_int(0)))
					{
						var_thisfile_ac3_raw_bsi.array_get_mut('blkmixcfginfo').array_set(0,
							this.readheaderbsi(rt.new_int(5)))
					} else {
						mut var_blk := rt.new_int(0)
						for {
							if !(rt.is_true(rt.less(var_blk, var_thisfile_ac3_raw_bsi.array_get(rt.new_string('numblkscod'))))) { break
							 }
							var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set(
								'blkmixcfginfo' + var_blk.str(),
								(this.readheaderbsi(rt.new_int(1))).to_bool())
							if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string(
								'blkmixcfginfo' + var_blk.str())))
							{
								var_thisfile_ac3_raw_bsi.array_get_mut('blkmixcfginfo').array_set(var_blk,
									this.readheaderbsi(rt.new_int(5)))
							}
							rt.post_inc(var_blk)
						}
					}
				}
			}
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('infomdat',
			(this.readheaderbsi(rt.new_int(1))).to_bool())
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('infomdat'))) {
			var_thisfile_ac3_raw_bsi['bsmod'] = this.readheaderbsi(rt.new_int(3))
			var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('copyrightb',
				(this.readheaderbsi(rt.new_int(1))).to_bool())
			var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('origbs',
				(this.readheaderbsi(rt.new_int(1))).to_bool())
			if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')),
				rt.new_int(2)))
			{
				var_thisfile_ac3_raw_bsi['dsurmod'] = this.readheaderbsi(rt.new_int(2))
				var_thisfile_ac3_raw_bsi['dheadphonmod'] = this.readheaderbsi(rt.new_int(2))
			}
			if rt.is_true(rt.greater_equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')),
				rt.new_int(6)))
			{
				var_thisfile_ac3_raw_bsi['dsurexmod'] = this.readheaderbsi(rt.new_int(2))
			}
			var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('audprodi',
				(this.readheaderbsi(rt.new_int(1))).to_bool())
			if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('audprodi'))) {
				var_thisfile_ac3_raw_bsi['mixlevel'] = this.readheaderbsi(rt.new_int(5))
				var_thisfile_ac3_raw_bsi['roomtyp'] = this.readheaderbsi(rt.new_int(2))
				var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('adconvtyp',
					(this.readheaderbsi(rt.new_int(1))).to_bool())
			}
			if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')),
				rt.new_int(0)))
			{
				var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('audprodi2',
					(this.readheaderbsi(rt.new_int(1))).to_bool())
				if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('audprodi2'))) {
					var_thisfile_ac3_raw_bsi['mixlevel2'] = this.readheaderbsi(rt.new_int(5))
					var_thisfile_ac3_raw_bsi['roomtyp2'] = this.readheaderbsi(rt.new_int(2))
					var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('adconvtyp2',
						(this.readheaderbsi(rt.new_int(1))).to_bool())
				}
			}
			if rt.is_true(rt.less(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('fscod')),
				rt.new_int(3)))
			{
				var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('sourcefscod',
					(this.readheaderbsi(rt.new_int(1))).to_bool())
			}
		}
		if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('strmtyp')), rt.new_int(0)))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('numblkscod')), rt.new_int(3))))) {
			var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('convsync',
				(this.readheaderbsi(rt.new_int(1))).to_bool())
		}
		if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('strmtyp')),
			rt.new_int(2)))
		{
			if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('numblkscod')),
				rt.new_int(3)))))
			{
				var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('blkid', 1)
			} else {
				var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('blkid',
					(this.readheaderbsi(rt.new_int(1))).to_bool())
			}
			if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('blkid'))) {
				var_thisfile_ac3_raw_bsi['frmsizecod'] = this.readheaderbsi(rt.new_int(6))
			}
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('addbsi',
			(this.readheaderbsi(rt.new_int(1))).to_bool())
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('addbsi'))) {
			var_thisfile_ac3_raw_bsi['addbsil'] = this.readheaderbsi(rt.new_int(6))
			var_thisfile_ac3_raw_bsi['addbsi'] = this.readheaderbsi(rt.mul(rt.add(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('addbsil')),
				rt.new_int(1)), rt.new_int(8)))
		}
	} else {
		this.error(rt.new_string('Bit stream identification is version ' +
			(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('bsid'))).str() + ', but getID3() only understands up to version 16. Please submit a support ticket with a sample file.'))
		var_info.delete('ac3')
		return false
	}
	if var_thisfile_ac3_raw_bsi.array_isset(rt.new_string('fscod2')) {
		var_thisfile_ac3.array_set('sample_rate',
			Class_getid3_ac3.sampleratecodelookup2(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('fscod2'))))
	} else {
		var_thisfile_ac3.array_set('sample_rate',
			Class_getid3_ac3.sampleratecodelookup(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('fscod'))))
	}
	if rt.is_true(rt.less_equal(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('fscod')),
		rt.new_int(3)))
	{
		var_info.array_get_mut('audio').array_set('sample_rate',
			var_thisfile_ac3.array_get(rt.new_string('sample_rate')))
	} else {
		this.warning(rt.new_string('Unexpected ac3.bsi.fscod value: ' +
			(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('fscod'))).str()))
	}
	if var_thisfile_ac3_raw_bsi.array_isset(rt.new_string('frmsizecod')) {
		var_thisfile_ac3.array_set('frame_length', Class_getid3_ac3.framesizelookup(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('frmsizecod')),
			var_thisfile_ac3_raw_bsi.array_get(rt.new_string('fscod'))))
		var_thisfile_ac3.array_set('bitrate',
			Class_getid3_ac3.bitratelookup(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('frmsizecod'))))
	} else if !(!rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('frmsiz')))) {
		var_thisfile_ac3.array_set('bitrate', rt.mul(rt.mul(rt.add(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('frmsiz')),
			rt.new_int(1)), rt.new_int(16)), rt.new_int(30)))
		var_thisfile_ac3.array_set('bitrate', rt.mul(rt.call_function('round', [
			rt.new_float(var_thisfile_ac3.array_get(rt.new_string('bitrate')) * 1.05 / 16000),
		]), rt.new_int(16000)))
	}
	var_info.array_get_mut('audio').array_set('bitrate',
		var_thisfile_ac3.array_get(rt.new_string('bitrate')))
	if var_thisfile_ac3_raw_bsi.array_isset(rt.new_string('bsmod'))
		&& var_thisfile_ac3_raw_bsi.array_isset(rt.new_string('acmod')) {
		var_thisfile_ac3.array_set('service_type', Class_getid3_ac3.servicetypelookup(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('bsmod')),
			var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod'))))
	}
	mut var_ac3_coding_mode :=
		Class_getid3_ac3.audiocodingmodelookup(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')))
	mut iter_1 := var_ac3_coding_mode.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		var_thisfile_ac3.array_set(var_key, var_value.clone())
	}
	mut switch_val_1 := var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_int(0)))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		var_info.array_get_mut('audio').array_set('channelmode', 'mono')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(3)))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_int(4))) {
		var_info.array_get_mut('audio').array_set('channelmode', 'stereo')
	} else {
		var_info.array_get_mut('audio').array_set('channelmode', 'surround')
	}
	var_info.array_get_mut('audio').array_set('channels',
		var_thisfile_ac3.array_get(rt.new_string('num_channels')))
	var_thisfile_ac3.array_set('lfe_enabled',
		var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('lfeon')))
	if rt.is_true(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('lfeon'))) {
		var_info.array_get(rt.new_string('audio')).array_get(rt.new_string('channels')) = rt.concat(var_info.array_get(rt.new_string('audio')).array_get(rt.new_string('channels')),
			rt.new_string('.1'))
	}
	var_thisfile_ac3.array_set('channels_enabled', Class_getid3_ac3.channelsenabledlookup(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('acmod')),
		var_thisfile_ac3_raw_bsi.array_get(rt.new_string('flags')).array_get(rt.new_string('lfeon'))))
	var_thisfile_ac3.array_set('dialogue_normalization', '-' +
		(var_thisfile_ac3_raw_bsi.array_get(rt.new_string('dialnorm'))).str() + 'dB')
	return true
}

fn (mut this Class_getid3_ac3) readheaderbsi(var_length rt.PhpVal) rt.PhpVal {
	mut var_data := rt.call_function('substr', [this.AC3header.array_get(rt.new_string('bsi')),
		this.BSIoffset, var_length.clone()])
	this.BSIoffset = rt.add(this.BSIoffset, var_length)
	return rt.call_function('bindec', [var_data.clone()])
}

fn Class_getid3_ac3.sampleratecodelookup(var_fscod rt.PhpVal) rt.PhpVal {
	mut var_sampleRateCodeLookup := rt.new_null()
	return if var_sampleRateCodeLookup.array_isset(var_fscod) {
		var_sampleRateCodeLookup.array_get(var_fscod)
	} else {
		rt.new_bool(false)
	}
}

fn Class_getid3_ac3.sampleratecodelookup2(var_fscod2 rt.PhpVal) rt.PhpVal {
	mut var_sampleRateCodeLookup2 := rt.new_null()
	return if var_sampleRateCodeLookup2.array_isset(var_fscod2) {
		var_sampleRateCodeLookup2.array_get(var_fscod2)
	} else {
		rt.new_bool(false)
	}
}

fn Class_getid3_ac3.servicetypelookup(var_bsmod rt.PhpVal, var_acmod rt.PhpVal) rt.PhpVal {
	mut var_serviceTypeLookup := []rt.PhpVal{}
	if !rt.is_true(var_serviceTypeLookup) {
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less_equal(var_i, rt.new_int(7)))) { break
			 }
			var_serviceTypeLookup.array_get_mut(0).array_set(var_i,
				'main audio service: complete main (CM)')
			var_serviceTypeLookup.array_get_mut(1).array_set(var_i,
				'main audio service: music and effects (ME)')
			var_serviceTypeLookup.array_get_mut(2).array_set(var_i,
				'associated service: visually impaired (VI)')
			var_serviceTypeLookup.array_get_mut(3).array_set(var_i,
				'associated service: hearing impaired (HI)')
			var_serviceTypeLookup.array_get_mut(4).array_set(var_i,
				'associated service: dialogue (D)')
			var_serviceTypeLookup.array_get_mut(5).array_set(var_i,
				'associated service: commentary (C)')
			var_serviceTypeLookup.array_get_mut(6).array_set(var_i,
				'associated service: emergency (E)')
			rt.post_inc(var_i)
		}
		var_serviceTypeLookup.array_get_mut(7).array_set(1, 'associated service: voice over (VO)')
		var_i = rt.new_int(2)
		for {
			if !(rt.is_true(rt.less_equal(var_i, rt.new_int(7)))) { break
			 }
			var_serviceTypeLookup.array_get_mut(7).array_set(var_i, 'main audio service: karaoke')
			rt.post_inc(var_i)
		}
	}
	return if var_serviceTypeLookup.array_get(var_bsmod).array_isset(var_acmod) {
		var_serviceTypeLookup.array_get(var_bsmod).array_get(var_acmod)
	} else {
		rt.new_bool(false)
	}
}

fn Class_getid3_ac3.audiocodingmodelookup(var_acmod rt.PhpVal) rt.PhpVal {
	mut var_audioCodingModeLookup := rt.new_null()
	return if var_audioCodingModeLookup.array_isset(var_acmod) {
		var_audioCodingModeLookup.array_get(var_acmod)
	} else {
		rt.new_bool(false)
	}
}

fn Class_getid3_ac3.centermixlevellookup(var_cmixlev rt.PhpVal) rt.PhpVal {
	mut var_centerMixLevelLookup := rt.new_null()
	if !rt.is_true(var_centerMixLevelLookup) {
		var_centerMixLevelLookup = [
			rt.call_function('pow', [rt.new_int(2), rt.new_float(-3 / 6)]),
			rt.call_function('pow', [rt.new_int(2), rt.new_float(-4.5 / 6)]),
			rt.call_function('pow', [rt.new_int(2), rt.new_float(-6 / 6)]),
			rt.new_string('reserved'),
		]
	}
	return if var_centerMixLevelLookup.array_isset(var_cmixlev) {
		var_centerMixLevelLookup[var_cmixlev]
	} else {
		rt.new_bool(false)
	}
}

fn Class_getid3_ac3.surroundmixlevellookup(var_surmixlev rt.PhpVal) rt.PhpVal {
	mut var_surroundMixLevelLookup := rt.new_null()
	if !rt.is_true(var_surroundMixLevelLookup) {
		var_surroundMixLevelLookup = [
			rt.call_function('pow', [rt.new_int(2), rt.new_float(-3 / 6)]),
			rt.call_function('pow', [rt.new_int(2), rt.new_float(-6 / 6)]),
			rt.new_int(0),
			rt.new_string('reserved'),
		]
	}
	return if var_surroundMixLevelLookup.array_isset(var_surmixlev) {
		var_surroundMixLevelLookup[var_surmixlev]
	} else {
		rt.new_bool(false)
	}
}

fn Class_getid3_ac3.dolbysurroundmodelookup(var_dsurmod rt.PhpVal) rt.PhpVal {
	mut var_dolbySurroundModeLookup := rt.new_null()
	return if var_dolbySurroundModeLookup.array_isset(var_dsurmod) {
		var_dolbySurroundModeLookup.array_get(var_dsurmod)
	} else {
		rt.new_bool(false)
	}
}

fn Class_getid3_ac3.channelsenabledlookup(var_acmod rt.PhpVal, var_lfeon rt.PhpVal) rt.PhpVal {
	mut var_lookup := {
		'ch1':            rt.equal(var_acmod, rt.new_int(0))
		'ch2':            rt.equal(var_acmod, rt.new_int(0))
		'left':           rt.greater(var_acmod, rt.new_int(1))
		'right':          rt.greater(var_acmod, rt.new_int(1))
		'center':         (rt.bitwise_and(var_acmod, rt.new_int(1))).to_bool()
		'surround_mono':  rt.new_bool(false)
		'surround_left':  rt.new_bool(false)
		'surround_right': rt.new_bool(false)
		'lfe':            var_lfeon
	}
	mut switch_val_2 := var_acmod
	if rt.is_true(rt.equal(switch_val_2, rt.new_int(4)))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_int(5))) {
		var_lookup['surround_mono'] = rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(6)))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_int(7))) {
		var_lookup['surround_left'] = rt.new_bool(true)
		var_lookup['surround_right'] = rt.new_bool(true)
	}
	return var_lookup.clone()
}

fn Class_getid3_ac3.heavycompression(var_compre rt.PhpVal) rt.PhpVal {
	mut var_fourbit := rt.call_function('str_pad', [
		rt.call_function('decbin', [rt.bitwise_and(var_compre, rt.new_int(240)) >> 4]),
		rt.new_int(4),
		rt.new_string('0'),
		rt.get_constant('STR_PAD_LEFT'),
	])
	if rt.is_true(rt.equal(var_fourbit.array_get(rt.new_int(0)), rt.new_string('1'))) {
		mut var_log_gain := rt.add(-8, rt.call_function('bindec', [
			rt.call_function('substr', [var_fourbit.clone(), rt.new_int(1)]),
		]))
	} else {
		var_log_gain = rt.call_function('bindec', [
			rt.call_function('substr', [var_fourbit.clone(), rt.new_int(1)]),
		])
	}
	mut iife_temp_5 := Class_getid3_lib{}
	mut iife_result_5 := iife_temp_5.rgadamplitude2db(rt.new_int(2))
	var_log_gain = rt.mul(rt.add(var_log_gain, rt.new_int(1)), iife_result_5)
	mut var_lin_gain := rt.new_int(16 + rt.bitwise_and(var_compre, rt.new_int(15)) / 32)
	return rt.sub(var_log_gain, var_lin_gain)
}

fn Class_getid3_ac3.roomtypelookup(var_roomtyp rt.PhpVal) rt.PhpVal {
	mut var_roomTypeLookup := rt.new_null()
	return if var_roomTypeLookup.array_isset(var_roomtyp) {
		var_roomTypeLookup.array_get(var_roomtyp)
	} else {
		rt.new_bool(false)
	}
}

fn Class_getid3_ac3.framesizelookup(var_frmsizecod rt.PhpVal, var_fscod rt.PhpVal) rt.PhpVal {
	mut var_padding := rt.new_bool((rt.bitwise_and(var_frmsizecod, rt.new_int(1))).to_bool())
	mut var_framesizeid := rt.new_int(rt.bitwise_and(var_frmsizecod, rt.new_int(62)) >> 1)
	mut var_frameSizeLookup := rt.new_array()
	if !rt.is_true(var_frameSizeLookup) {
		var_frameSizeLookup = [[rt.new_int(128), rt.new_int(138),
			rt.new_int(192)],
			[rt.new_int(160), rt.new_int(174), rt.new_int(240)],
			[rt.new_int(192), rt.new_int(208), rt.new_int(288)],
			[rt.new_int(224), rt.new_int(242), rt.new_int(336)],
			[rt.new_int(256), rt.new_int(278), rt.new_int(384)],
			[rt.new_int(320), rt.new_int(348), rt.new_int(480)],
			[rt.new_int(384), rt.new_int(416), rt.new_int(576)],
			[rt.new_int(448), rt.new_int(486), rt.new_int(672)],
			[rt.new_int(512), rt.new_int(556), rt.new_int(768)],
			[rt.new_int(640), rt.new_int(696), rt.new_int(960)],
			[rt.new_int(768), rt.new_int(834), rt.new_int(1152)],
			[rt.new_int(896), rt.new_int(974), rt.new_int(1344)],
			[rt.new_int(1024), rt.new_int(1114), rt.new_int(1536)],
			[rt.new_int(1280), rt.new_int(1392), rt.new_int(1920)],
			[rt.new_int(1536), rt.new_int(1670), rt.new_int(2304)],
			[rt.new_int(1792), rt.new_int(1950), rt.new_int(2688)],
			[rt.new_int(2048), rt.new_int(2228), rt.new_int(3072)],
			[rt.new_int(2304), rt.new_int(2506), rt.new_int(3456)],
			[rt.new_int(2560), rt.new_int(2786), rt.new_int(3840)]]
	}
	mut var_paddingBytes := rt.new_int(0)
	if rt.is_true(rt.equal(var_fscod, rt.new_int(1))) && rt.is_true(var_padding) {
		var_paddingBytes = rt.new_int(2)
	}
	return if var_frameSizeLookup[var_framesizeid].array_isset(var_fscod) {
		rt.add(var_frameSizeLookup[var_framesizeid].array_get(var_fscod), var_paddingBytes)
	} else {
		rt.new_bool(false)
	}
}

fn Class_getid3_ac3.bitratelookup(var_frmsizecod rt.PhpVal) rt.PhpVal {
	mut var_bitrateLookup := rt.new_null()
	mut var_padding := rt.new_bool((rt.bitwise_and(var_frmsizecod, rt.new_int(1))).to_bool())
	mut var_framesizeid := rt.new_int(rt.bitwise_and(var_frmsizecod, rt.new_int(62)) >> 1)
	return if var_bitrateLookup.array_isset(var_framesizeid) {
		var_bitrateLookup.array_get(var_framesizeid)
	} else {
		rt.new_bool(false)
	}
}

fn Class_getid3_ac3.blockspersyncframe(var_numblkscod rt.PhpVal) rt.PhpVal {
	mut var_blocksPerSyncFrameLookup := rt.new_null()
	return if var_blocksPerSyncFrameLookup.array_isset(var_numblkscod) {
		var_blocksPerSyncFrameLookup.array_get(var_numblkscod)
	} else {
		rt.new_bool(false)
	}
}

struct Class_getid3_handler {
	rt.PhpObjectBase
}

struct Class_getid3_lib {
	rt.PhpObjectBase
}

fn create_getid3_ac3(_args ...rt.PhpVal) &Class_getid3_ac3 {
	mut obj := &Class_getid3_ac3{
		PhpObjectBase: rt.PhpObjectBase{}
		AC3header:     rt.new_array()
		BSIoffset:     rt.new_int(0)
	}
	return obj
}

fn create_getid3_handler(_args ...rt.PhpVal) &Class_getid3_handler {
	mut obj := &Class_getid3_handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_getid3_lib(_args ...rt.PhpVal) &Class_getid3_lib {
	mut obj := &Class_getid3_lib{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_getid3_ac3) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'Analyze' {
			return rt.new_bool(this.analyze())
		}
		'readHeaderBSI' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.readheaderbsi(dispatch_arg_0)
		}
		'sampleRateCodeLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_ac3.sampleratecodelookup(dispatch_arg_0)
		}
		'sampleRateCodeLookup2' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_ac3.sampleratecodelookup2(dispatch_arg_0)
		}
		'serviceTypeLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_getid3_ac3.servicetypelookup(dispatch_arg_0, dispatch_arg_1)
		}
		'audioCodingModeLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_ac3.audiocodingmodelookup(dispatch_arg_0)
		}
		'centerMixLevelLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_ac3.centermixlevellookup(dispatch_arg_0)
		}
		'surroundMixLevelLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_ac3.surroundmixlevellookup(dispatch_arg_0)
		}
		'dolbySurroundModeLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_ac3.dolbysurroundmodelookup(dispatch_arg_0)
		}
		'channelsEnabledLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_getid3_ac3.channelsenabledlookup(dispatch_arg_0, dispatch_arg_1)
		}
		'heavyCompression' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_ac3.heavycompression(dispatch_arg_0)
		}
		'roomTypeLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_ac3.roomtypelookup(dispatch_arg_0)
		}
		'frameSizeLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_getid3_ac3.framesizelookup(dispatch_arg_0, dispatch_arg_1)
		}
		'bitrateLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_ac3.bitratelookup(dispatch_arg_0)
		}
		'blocksPerSyncFrame' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_ac3.blockspersyncframe(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_getid3_ac3) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'AC3header' { return this.AC3header }
		'BSIoffset' { return this.BSIoffset }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_getid3_ac3) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'AC3header' {
			this.AC3header = val
			return true
		}
		'BSIoffset' {
			this.BSIoffset = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_getid3_handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_getid3_handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_getid3_handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_getid3_lib) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_getid3_lib) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_getid3_lib) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('GETID3_INCLUDEPATH'),
	])))))
	{
		exit(0)
	}
}
