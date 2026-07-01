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
	// unsupported expression: Expr_AssignRef
	var_info.array_get_mut('ac3').array_get_mut('raw').array_set('bsi', rt.new_array())
	// unsupported expression: Expr_AssignRef
	// unsupported expression: Expr_AssignRef
	// unsupported expression: Expr_AssignRef
	var_info['fileformat'] = rt.new_string('ac3')
	this.fseek(var_info.array_get('avdataoffset'))
	mut var_tempAC3header := this.fread(rt.new_int(100))
	this.AC3header.array_set('syncinfo', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_tempAC3header.dup(), rt.new_int(0), rt.new_int(2)])))
	this.AC3header.array_set('bsi', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2bin(arg_0) }(rt.call_function('substr', [var_tempAC3header.dup(), rt.new_int(2)])))
	var_thisfile_ac3_raw_bsi['bsid'] = rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_tempAC3header.dup(), rt.new_int(5), rt.new_int(1)])), rt.new_int(248)) >> 3
	var_tempAC3header = rt.new_null()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.new_bool(!(rt.is_true(this.isdependencyfor(rt.new_string('matroska')))))) {
			var_info.delete('fileformat')
			var_info.delete('ac3')
			return (this.error(rt.new_string('Expecting "' + (rt.call_function('dechex', [Class_getid3_ac3.syncword()])).str() + '" at offset ' + (var_info.array_get('avdataoffset')).str() + ', found "' + (rt.call_function('dechex', [this.AC3header.array_get('syncinfo')])).str() + '"'))).to_bool()
		}
	}
	var_info.array_get_mut('audio').array_set('dataformat', 'ac3')
	var_info.array_get_mut('audio').array_set('bitrate_mode', 'cbr')
	var_info.array_get_mut('audio').array_set('lossless', false)
	if rt.is_true(rt.less_equal(var_thisfile_ac3_raw_bsi.array_get('bsid'), rt.new_int(8))) {
		var_thisfile_ac3_raw_bsi['crc1'] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bin2dec(arg_0) }(this.readheaderbsi(rt.new_int(16)))
		var_thisfile_ac3_raw_bsi['fscod'] = this.readheaderbsi(rt.new_int(2))
		var_thisfile_ac3_raw_bsi['frmsizecod'] = this.readheaderbsi(rt.new_int(6))
		if rt.is_true(rt.greater(var_thisfile_ac3_raw_bsi.array_get('frmsizecod'), rt.new_int(37))) {
			this.warning(rt.new_string('Unexpected ac3.bsi.frmsizecod value: ' + (var_thisfile_ac3_raw_bsi.array_get('frmsizecod')).str() + ', bitrate not set correctly'))
		}
		var_thisfile_ac3_raw_bsi['bsid'] = this.readheaderbsi(rt.new_int(5))
		var_thisfile_ac3_raw_bsi['bsmod'] = this.readheaderbsi(rt.new_int(3))
		var_thisfile_ac3_raw_bsi['acmod'] = this.readheaderbsi(rt.new_int(3))
		if rt.is_true(rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get('acmod'), rt.new_int(1))) {
			var_thisfile_ac3_raw_bsi['cmixlev'] = this.readheaderbsi(rt.new_int(2))
			var_thisfile_ac3.array_set('center_mix_level', Class_getid3_ac3.centermixlevellookup(var_thisfile_ac3_raw_bsi.array_get('cmixlev')))
		}
		if rt.is_true(rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get('acmod'), rt.new_int(4))) {
			var_thisfile_ac3_raw_bsi['surmixlev'] = this.readheaderbsi(rt.new_int(2))
			var_thisfile_ac3.array_set('surround_mix_level', Class_getid3_ac3.surroundmixlevellookup(var_thisfile_ac3_raw_bsi.array_get('surmixlev')))
		}
		if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get('acmod'), rt.new_int(2))) {
			var_thisfile_ac3_raw_bsi['dsurmod'] = this.readheaderbsi(rt.new_int(2))
			var_thisfile_ac3.array_set('dolby_surround_mode', Class_getid3_ac3.dolbysurroundmodelookup(var_thisfile_ac3_raw_bsi.array_get('dsurmod')))
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('lfeon', // unsupported expression: Expr_Cast_Bool)
		var_thisfile_ac3_raw_bsi['dialnorm'] = this.readheaderbsi(rt.new_int(5))
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('compr', // unsupported expression: Expr_Cast_Bool)
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get('flags').array_get('compr')) {
			var_thisfile_ac3_raw_bsi['compr'] = this.readheaderbsi(rt.new_int(8))
			var_thisfile_ac3.array_set('heavy_compression', Class_getid3_ac3.heavycompression(var_thisfile_ac3_raw_bsi.array_get('compr')))
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('langcod', // unsupported expression: Expr_Cast_Bool)
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get('flags').array_get('langcod')) {
			var_thisfile_ac3_raw_bsi['langcod'] = this.readheaderbsi(rt.new_int(8))
			// unsupported statement: Stmt_Nop
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('audprodinfo', // unsupported expression: Expr_Cast_Bool)
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get('flags').array_get('audprodinfo')) {
			var_thisfile_ac3_raw_bsi['mixlevel'] = this.readheaderbsi(rt.new_int(5))
			var_thisfile_ac3_raw_bsi['roomtyp'] = this.readheaderbsi(rt.new_int(2))
			var_thisfile_ac3.array_set('mixing_level', (rt.add(rt.new_int(80), var_thisfile_ac3_raw_bsi.array_get('mixlevel'))).str() + 'dB')
			var_thisfile_ac3.array_set('room_type', Class_getid3_ac3.roomtypelookup(var_thisfile_ac3_raw_bsi.array_get('roomtyp')))
		}
		var_thisfile_ac3_raw_bsi['dialnorm2'] = this.readheaderbsi(rt.new_int(5))
		var_thisfile_ac3.array_set('dialogue_normalization2', '-' + (var_thisfile_ac3_raw_bsi.array_get('dialnorm2')).str() + 'dB')
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('compr2', // unsupported expression: Expr_Cast_Bool)
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get('flags').array_get('compr2')) {
			var_thisfile_ac3_raw_bsi['compr2'] = this.readheaderbsi(rt.new_int(8))
			var_thisfile_ac3.array_set('heavy_compression2', Class_getid3_ac3.heavycompression(var_thisfile_ac3_raw_bsi.array_get('compr2')))
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('langcod2', // unsupported expression: Expr_Cast_Bool)
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get('flags').array_get('langcod2')) {
			var_thisfile_ac3_raw_bsi['langcod2'] = this.readheaderbsi(rt.new_int(8))
			// unsupported statement: Stmt_Nop
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('audprodinfo2', // unsupported expression: Expr_Cast_Bool)
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get('flags').array_get('audprodinfo2')) {
			var_thisfile_ac3_raw_bsi['mixlevel2'] = this.readheaderbsi(rt.new_int(5))
			var_thisfile_ac3_raw_bsi['roomtyp2'] = this.readheaderbsi(rt.new_int(2))
			var_thisfile_ac3.array_set('mixing_level2', (rt.add(rt.new_int(80), var_thisfile_ac3_raw_bsi.array_get('mixlevel2'))).str() + 'dB')
			var_thisfile_ac3.array_set('room_type2', Class_getid3_ac3.roomtypelookup(var_thisfile_ac3_raw_bsi.array_get('roomtyp2')))
		}
		var_thisfile_ac3_raw_bsi['copyright'] = // unsupported expression: Expr_Cast_Bool
		var_thisfile_ac3_raw_bsi['original'] = // unsupported expression: Expr_Cast_Bool
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('timecod1', this.readheaderbsi(rt.new_int(2)))
		if rt.is_true(rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get('flags').array_get('timecod1'), rt.new_int(1))) {
			var_thisfile_ac3_raw_bsi['timecod1'] = this.readheaderbsi(rt.new_int(14))
			var_thisfile_ac3.array_set('timecode1', 0)
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported statement: Stmt_Nop
		}
		if rt.is_true(rt.bitwise_and(var_thisfile_ac3_raw_bsi.array_get('flags').array_get('timecod1'), rt.new_int(2))) {
			var_thisfile_ac3_raw_bsi['timecod2'] = this.readheaderbsi(rt.new_int(14))
			var_thisfile_ac3.array_set('timecode2', 0)
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported statement: Stmt_Nop
		}
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('addbsi', // unsupported expression: Expr_Cast_Bool)
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get('flags').array_get('addbsi')) {
			var_thisfile_ac3_raw_bsi['addbsi_length'] = rt.add(this.readheaderbsi(rt.new_int(6)), rt.new_int(1))
			// unsupported expression: Expr_AssignOp_Concat
			var_thisfile_ac3_raw_bsi['addbsi_data'] = rt.call_function('substr', [this.AC3header.array_get('bsi'), this.BSIoffset, rt.mul(var_thisfile_ac3_raw_bsi.array_get('addbsi_length'), rt.new_int(8))])
			// unsupported expression: Expr_AssignOp_Plus
		}
	} else if rt.is_true(rt.less_equal(var_thisfile_ac3_raw_bsi.array_get('bsid'), rt.new_int(16))) {
		this.error(rt.new_string('E-AC3 parsing is incomplete and experimental in this version of getID3 (' + (rt.call_method(rt.get_property(rt.new_object('getid3_ac3', ['getid3_handler'], &this), 'getid3'), 'version', []rt.PhpVal{})).str() + '). Notably the bitrate calculations are wrong -- value might (or not) be correct, but it is not calculated correctly. Email info@getid3.org if you know how to calculate EAC3 bitrate correctly.'))
		var_info.array_get_mut('audio').array_set('dataformat', 'eac3')
		var_thisfile_ac3_raw_bsi['strmtyp'] = this.readheaderbsi(rt.new_int(2))
		var_thisfile_ac3_raw_bsi['substreamid'] = this.readheaderbsi(rt.new_int(3))
		var_thisfile_ac3_raw_bsi['frmsiz'] = this.readheaderbsi(rt.new_int(11))
		var_thisfile_ac3_raw_bsi['fscod'] = this.readheaderbsi(rt.new_int(2))
		if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get('fscod'), rt.new_int(3))) {
			var_thisfile_ac3_raw_bsi['fscod2'] = this.readheaderbsi(rt.new_int(2))
			var_thisfile_ac3_raw_bsi['numblkscod'] = rt.new_int(3)
			// unsupported statement: Stmt_Nop
		} else {
			var_thisfile_ac3_raw_bsi['numblkscod'] = this.readheaderbsi(rt.new_int(2))
		}
		var_thisfile_ac3.array_get_mut('bsi').array_set('blocks_per_sync_frame', Class_getid3_ac3.blockspersyncframe(var_thisfile_ac3_raw_bsi.array_get('numblkscod')))
		var_thisfile_ac3_raw_bsi['acmod'] = this.readheaderbsi(rt.new_int(3))
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('lfeon', // unsupported expression: Expr_Cast_Bool)
		var_thisfile_ac3_raw_bsi['bsid'] = this.readheaderbsi(rt.new_int(5))
		var_thisfile_ac3_raw_bsi['dialnorm'] = this.readheaderbsi(rt.new_int(5))
		var_thisfile_ac3_raw_bsi.array_get_mut('flags').array_set('compr', // unsupported expression: Expr_Cast_Bool)
		if rt.is_true(var_thisfile_ac3_raw_bsi.array_get('flags').array_get('compr')) {
			var_thisfile_ac3_raw_bsi['compr'] = this.readheaderbsi(rt.new_int(8))
		}
		if rt.is_true(rt.equal(var_thisfile_ac3_raw_bsi.array_get('acmod'), rt.new_int(0))) {
			var_thisfile_ac3_raw_bsi['dialnorm2'] = this.readheaderbsi(rt.new_int())
			.array_get_mut().array_set(, )
			if rt.is_true() {
			}
		}
		if rt.is_true(rt.equal(, )) {
			
		}
		
	} else {
	}
	if .array_isset() {
	} else {
	}
	if rt.is_true() {
	} else {
	}
	if .array_isset() {
	} else if !(!rt.is_true()) {
	}
	
}

fn (mut this Class_getid3_ac3) readheaderbsi(var_length rt.PhpVal) rt.PhpVal {
}

fn Class_getid3_ac3.sampleratecodelookup(var_fscod rt.PhpVal) rt.PhpVal {
	mut var_sampleRateCodeLookup := rt.new_null()
}

fn Class_getid3_ac3.sampleratecodelookup2(var_fscod2 rt.PhpVal) rt.PhpVal {
	mut var_sampleRateCodeLookup2 := rt.new_null()
}

fn Class_getid3_ac3.servicetypelookup(var_bsmod rt.PhpVal, var_acmod rt.PhpVal) rt.PhpVal {
	mut var_serviceTypeLookup := []rt.PhpVal{}
}

fn Class_getid3_ac3.audiocodingmodelookup(var_acmod rt.PhpVal) rt.PhpVal {
	mut var_audioCodingModeLookup := rt.new_null()
}

fn Class_getid3_ac3.centermixlevellookup(var_cmixlev rt.PhpVal) rt.PhpVal {
}

fn Class_getid3_ac3.surroundmixlevellookup(var_surmixlev rt.PhpVal) rt.PhpVal {
}

fn Class_getid3_ac3.dolbysurroundmodelookup(var_dsurmod rt.PhpVal) rt.PhpVal {
	mut var_dolbySurroundModeLookup := rt.new_null()
}

fn Class_getid3_ac3.channelsenabledlookup(var_acmod rt.PhpVal, var_lfeon rt.PhpVal) rt.PhpVal {
}

fn Class_getid3_ac3.heavycompression(var_compre rt.PhpVal) rt.PhpVal {
}

fn Class_getid3_ac3.roomtypelookup(var_roomtyp rt.PhpVal) rt.PhpVal {
	mut var_roomTypeLookup := rt.new_null()
}

fn Class_getid3_ac3.framesizelookup(var_frmsizecod rt.PhpVal, var_fscod rt.PhpVal) rt.PhpVal {
}

fn Class_getid3_ac3.bitratelookup(var_frmsizecod rt.PhpVal) rt.PhpVal {
	mut var_bitrateLookup := rt.new_null()
}

fn Class_getid3_ac3.blockspersyncframe(var_numblkscod rt.PhpVal) rt.PhpVal {
	mut var_blocksPerSyncFrameLookup := rt.new_null()
}

struct Class_getid3_handler {
	rt.PhpObjectBase
}

struct Class_getid3_lib {
	rt.PhpObjectBase
}

fn create_getid3_ac3() &Class_getid3_ac3 {
	mut obj := &Class_getid3_ac3{
		PhpObjectBase: rt.PhpObjectBase{}
		AC3header: rt.new_array()
		BSIoffset: rt.new_int(0)
	}
	return obj
}

fn create_getid3_handler() &Class_getid3_handler {
	mut obj := &Class_getid3_handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_getid3_lib() &Class_getid3_lib {
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
		else { return none }
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
		'AC3header' { this.AC3header = val; return true }
		'BSIoffset' { this.BSIoffset = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_includes_id3_module_audio_ac3_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_INCLUDEPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
