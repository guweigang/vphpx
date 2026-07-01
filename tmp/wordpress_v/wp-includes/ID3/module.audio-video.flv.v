import rt

const global_const_getid3_flv_tag_audio = 8
const global_const_getid3_flv_tag_video = 9
const global_const_getid3_flv_tag_meta = 18
const global_const_getid3_flv_video_h263 = 2
const global_const_getid3_flv_video_screen = 3
const global_const_getid3_flv_video_vp6flv = 4
const global_const_getid3_flv_video_vp6flv_alpha = 5
const global_const_getid3_flv_video_screenv2 = 6
const global_const_getid3_flv_video_h264 = 7
const global_const_h264_avc_sequence_header = 0
const global_const_h264_profile_baseline = 66
const global_const_h264_profile_main = 77
const global_const_h264_profile_extended = 88
const global_const_h264_profile_high = 100
const global_const_h264_profile_high10 = 110
const global_const_h264_profile_high422 = 122
const global_const_h264_profile_high444 = 144
const global_const_h264_profile_high444_predictive = 244
pub fn Class_getid3_flv.magic() string {
	return 'FLV'
}
struct Class_getid3_flv {
	rt.PhpObjectBase
pub mut:
		max_frames rt.PhpVal = rt.new_int(100000)
}

fn (mut this Class_getid3_flv) analyze() bool {
	mut var_info := map[string]rt.PhpVal{}
	mut var_flv_framecount := rt.new_null()
	// unsupported expression: Expr_AssignRef
	this.fseek(var_info.array_get('avdataoffset'))
	mut var_FLVdataLength := rt.sub(var_info.array_get('avdataend'), var_info.array_get('avdataoffset'))
	mut var_FLVheader := this.fread(rt.new_int(5))
	var_info['fileformat'] = rt.new_string('flv')
	var_info.array_get_mut('flv').array_get_mut('header').array_set('signature', rt.call_function('substr', [var_FLVheader.dup(), rt.new_int(0), rt.new_int(3)]))
	var_info.array_get_mut('flv').array_get_mut('header').array_set('version', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_FLVheader.dup(), rt.new_int(3), rt.new_int(1)])))
	mut var_TypeFlags := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_FLVheader.dup(), rt.new_int(4), rt.new_int(1)]))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		this.error(rt.new_string('Expecting "' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.printhexbytes(arg_0) }(rt.new_string(Class_getid3_flv.magic()))).str() + '" at offset ' + (var_info.array_get('avdataoffset')).str() + ', found "' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.printhexbytes(arg_0) }(var_info.array_get('flv').array_get('header').array_get('signature'))).str() + '"'))
		var_info.delete('flv')
		var_info.delete('fileformat')
		return false
	}
	var_info.array_get_mut('flv').array_get_mut('header').array_set('hasAudio', // unsupported expression: Expr_Cast_Bool)
	var_info.array_get_mut('flv').array_get_mut('header').array_set('hasVideo', // unsupported expression: Expr_Cast_Bool)
	mut var_FrameSizeDataLength := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(this.fread(rt.new_int(4)))
	mut var_FLVheaderFrameLength := rt.new_int(rt.new_int(9))
	if rt.is_true(rt.greater(var_FrameSizeDataLength, var_FLVheaderFrameLength)) {
		this.fseek(rt.sub(var_FrameSizeDataLength, var_FLVheaderFrameLength), rt.get_constant('SEEK_CUR'))
	}
	mut var_Duration := rt.new_int(rt.new_int(0))
	mut var_found_video := rt.new_bool(rt.new_bool(false))
	mut var_found_audio := rt.new_bool(rt.new_bool(false))
	mut var_found_meta := rt.new_bool(rt.new_bool(false))
	mut var_found_valid_meta_playtime := rt.new_bool(rt.new_bool(false))
	mut var_tagParseCount := rt.new_int(rt.new_int(0))
	var_info.array_get_mut('flv').array_set('framecount', rt.create_array([rt.ArrayItem{ key: 'total', val: 0 }, rt.ArrayItem{ key: 'audio', val: 0 }, rt.ArrayItem{ key: 'video', val: 0 }]))
	// unsupported expression: Expr_AssignRef
	for rt.is_true(rt.new_bool(rt.is_true(rt.less(rt.add(this.ftell(), rt.new_int(16)), var_info.array_get('avdataend'))) && rt.is_true(rt.new_bool(rt.is_true(rt.less_equal(rt.post_inc(var_tagParseCount), this.max_frames)) || rt.is_true(rt.new_bool(!(rt.is_true(var_found_valid_meta_playtime)))))))) {
		mut var_ThisTagHeader := this.fread(rt.new_int(16))
		mut var_PreviousTagLength := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_ThisTagHeader.dup(), rt.new_int(0), rt.new_int(4)]))
		mut var_TagType := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_ThisTagHeader.dup(), rt.new_int(4), rt.new_int(1)]))
		mut var_DataLength := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_ThisTagHeader.dup(), rt.new_int(5), rt.new_int(3)]))
		mut var_Timestamp := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_ThisTagHeader.dup(), rt.new_int(8), rt.new_int(3)]))
		mut var_LastHeaderByte := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_ThisTagHeader.dup(), rt.new_int(15), rt.new_int(1)]))
		mut var_NextOffset := rt.add(rt.sub(this.ftell(), rt.new_int(1)), var_DataLength)
		if rt.is_true(rt.greater(var_Timestamp, var_Duration)) {
			var_Duration = var_Timestamp.dup()
		}
		rt.post_inc(var_flv_framecount.array_get('total'))
		mut switch_val_1 := var_TagType
		if rt.is_true(rt.equal(switch_val_1, rt.new_int(global_const_getid3_flv_tag_audio))) {
			rt.post_inc(var_flv_framecount.array_get('audio'))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_found_audio)))) {
				var_found_audio = rt.new_bool(rt.new_bool(true))
				var_info.array_get_mut('flv').array_get_mut('audio').array_set('audioFormat', rt.shift_right(var_LastHeaderByte, rt.new_int(4)) & 15)
				var_info.array_get_mut('flv').array_get_mut('audio').array_set('audioRate', rt.shift_right(var_LastHeaderByte, rt.new_int(2)) & 3)
				var_info.array_get_mut('flv').array_get_mut('audio').array_set('audioSampleSize', rt.shift_right(var_LastHeaderByte, rt.new_int(1)) & 1)
				var_info.array_get_mut('flv').array_get_mut('audio').array_set('audioType', rt.bitwise_and(var_LastHeaderByte, rt.new_int(1)))
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(global_const_getid3_flv_tag_video))) {
			rt.post_inc(var_flv_framecount.array_get('video'))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_found_video)))) {
				var_found_video = rt.new_bool(rt.new_bool(true))
				var_info.array_get_mut('flv').array_get_mut('video').array_set('videoCodec', rt.bitwise_and(var_LastHeaderByte, rt.new_int(7)))
				mut var_FLVvideoHeader := this.fread(rt.new_int(11))
				mut var_PictureSizeEnc := rt.new_array()
				if rt.is_true(rt.equal(var_info.array_get('flv').array_get('video').array_get('videoCodec'), rt.new_int(global_const_getid3_flv_video_h264))) {
					mut var_AVCPacketType := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_FLVvideoHeader.dup(), rt.new_int(0), rt.new_int(1)]))
					if rt.is_true(rt.equal(var_AVCPacketType, rt.new_int(global_const_h264_avc_sequence_header))) {
						mut var_configurationVersion := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_FLVvideoHeader.dup(), rt.new_int(4), rt.new_int(1)]))
						mut var_AVCProfileIndication := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_FLVvideoHeader.dup(), rt.new_int(5), rt.new_int(1)]))
						mut var_profile_compatibility := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_FLVvideoHeader.dup(), rt.new_int(6), rt.new_int(1)]))
						mut var_lengthSizeMinusOne := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_FLVvideoHeader.dup(), rt.new_int(7), rt.new_int(1)]))
						mut var_numOfSequenceParameterSets := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_FLVvideoHeader.dup(), rt.new_int(8), rt.new_int(1)]))
						if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
							mut var_spsSize := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_FLVvideoHeader.dup(), rt.new_int(9), rt.new_int(2)]))
							mut var_sps := this.fread(var_spsSize.dup())
							if rt.is_true(rt.equal(rt.new_int(var_sps.dup().to_string().len), var_spsSize)) {
								mut var_spsReader := create_avcsequenceparametersetreader(var_sps.dup())
								var_spsReader.readdata()
								var_info.array_get_mut('video').array_set('resolution_x', var_spsReader.getwidth())
								var_info.array_get_mut('video').array_set('resolution_y', var_spsReader.getheight())
							}
						}
					}
					// unsupported statement: Stmt_Nop
				} else if rt.is_true(rt.equal(var_info.array_get('flv').array_get('video').array_get('videoCodec'), rt.new_int(global_const_getid3_flv_video_h263))) {
					mut var_PictureSizeType := rt.new_int(rt.shift_right(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_FLVvideoHeader.dup(), rt.new_int(3), rt.new_int(2)])), rt.new_int(7)))
					var_PictureSizeType = rt.new_int(rt.bitwise_and(var_PictureSizeType, rt.new_int(7)))
					var_info.array_get_mut('flv').array_get_mut('header').array_set('videoSizeType', var_PictureSizeType.dup())
					mut switch_val_2 := var_PictureSizeType
					if rt.is_true(rt.equal(switch_val_2, rt.new_int(0))) {
						var_PictureSizeEnc.array_set('x', rt.shift_right(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_FLVvideoHeader.dup(), rt.new_int(4), rt.new_int(2)])), rt.new_int(7)))
						var_PictureSizeEnc.array_set('y', rt.shift_right(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_FLVvideoHeader.dup(), rt.new_int(5), rt.new_int(2)])), rt.new_int(7)))
						var_info.array_get_mut('video').array_set('resolution_x', rt.bitwise_and(var_PictureSizeEnc.array_get('x'), rt.new_int(255)))
						var_info.array_get_mut('video').array_set('resolution_y', rt.bitwise_and(var_PictureSizeEnc.array_get('y'), rt.new_int(255)))
					} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(1))) {
						var_PictureSizeEnc.array_set('x', rt.shift_right(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_FLVvideoHeader.dup(), rt.new_int(4), rt.new_int(3)])), rt.new_int(7)))
						var_PictureSizeEnc.array_set('y', rt.shift_right(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.bigendian2int(arg_0) }(rt.call_function('substr', [var_FLVvideoHeader.dup(), rt.new_int(6), rt.new_int(3)])), rt.new_int(7)))
						var_info.array_get_mut('video').array_set('resolution_x', rt.bitwise_and(var_PictureSizeEnc.array_get('x'), rt.new_int(65535)))
						var_info.array_get_mut('video').array_set('resolution_y', rt.bitwise_and(var_PictureSizeEnc.array_get('y'), rt.new_int(65535)))
					} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(2))) {
						var_info.array_get_mut('video').array_set('resolution_x', 352)
						var_info.array_get_mut('video').array_set('resolution_y', 288)
					} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(3))) {
						var_info.array_get_mut('video').array_set('resolution_x', 176)
						var_info.array_get_mut('video').array_set('resolution_y', 144)
					} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(4))) {
						var_info.array_get_mut('video').array_set('resolution_x', 128)
						.array_get_mut().array_set(, )
					} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(5))) {
						
					} else if rt.is_true(rt.equal(switch_val_2, )) {
					} else {
					}
				} else if rt.is_true() {
				}
				if !(!rt.is_true()) && !(!rt.is_true()) {
				}
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(global_const_getid3_flv_tag_meta))) {
			if rt.is_true(rt.new_bool(!(rt.is_true()))) {
				
			}
		} else {
		}
		
	}
}

fn Class_getid3_flv.audioformatlookup(var_id rt.PhpVal) rt.PhpVal {
	mut var_lookup := rt.new_null()
}

fn Class_getid3_flv.audioratelookup(var_id rt.PhpVal) rt.PhpVal {
	mut var_lookup := rt.new_null()
}

fn Class_getid3_flv.audiobitdepthlookup(var_id rt.PhpVal) rt.PhpVal {
	mut var_lookup := rt.new_null()
}

fn Class_getid3_flv.videocodeclookup(var_id rt.PhpVal) rt.PhpVal {
	mut var_lookup := rt.new_null()
}

struct Class_getid3_handler {
	rt.PhpObjectBase
}

struct Class_getid3_lib {
	rt.PhpObjectBase
}

struct Class_AVCSequenceParameterSetReader {
	rt.PhpObjectBase
}

fn create_getid3_flv() &Class_getid3_flv {
	mut obj := &Class_getid3_flv{
		PhpObjectBase: rt.PhpObjectBase{}
		max_frames: rt.new_int(100000)
	}
	return obj
}

fn create_amfstream() &Class_AMFStream {
	mut obj := &Class_AMFStream{
		PhpObjectBase: rt.PhpObjectBase{}
		bytes: rt.new_null()
		pos: rt.new_null()
	}
	return obj
}

fn create_amfreader() &Class_AMFReader {
	mut obj := &Class_AMFReader{
		PhpObjectBase: rt.PhpObjectBase{}
		stream: rt.new_null()
	}
	return obj
}

fn create_avcsequenceparametersetreader() &Class_AVCSequenceParameterSetReader {
	mut obj := &Class_AVCSequenceParameterSetReader{
		PhpObjectBase: rt.PhpObjectBase{}
		sps: rt.new_null()
		start: rt.new_int(0)
		currentBytes: rt.new_int(0)
		currentBits: rt.new_int(0)
		width: rt.new_null()
		height: rt.new_null()
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

fn (mut this Class_getid3_flv) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'Analyze' {
			return rt.new_bool(this.analyze())
		}
		'audioFormatLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_flv.audioformatlookup(dispatch_arg_0)
		}
		'audioRateLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_flv.audioratelookup(dispatch_arg_0)
		}
		'audioBitDepthLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_flv.audiobitdepthlookup(dispatch_arg_0)
		}
		'videoCodecLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_flv.videocodeclookup(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_getid3_flv) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'max_frames' { return this.max_frames }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_getid3_flv) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'max_frames' { this.max_frames = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_AMFStream) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_AMFStream) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_AMFStream) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_AMFReader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_AMFReader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_AMFReader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_AVCSequenceParameterSetReader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_AVCSequenceParameterSetReader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_AVCSequenceParameterSetReader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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




pub fn init_wp_includes_id3_module_audio_video_flv_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_INCLUDEPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
