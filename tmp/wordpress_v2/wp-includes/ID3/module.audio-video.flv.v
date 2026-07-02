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
	var_info = rt.get_property(rt.get_property(rt.new_object('getid3_flv', [
		'getid3_handler',
	], &this), 'getid3'), 'info')
	this.fseek(var_info.array_get(rt.new_string('avdataoffset')))
	mut var_FLVdataLength := rt.sub(var_info.array_get(rt.new_string('avdataend')),
		var_info.array_get(rt.new_string('avdataoffset')))
	mut var_FLVheader := this.fread(rt.new_int(5))
	var_info['fileformat'] = rt.new_string('flv')
	var_info.array_get_mut('flv').array_get_mut('header').array_set('signature', rt.call_function('substr', [
		var_FLVheader.clone(),
		rt.new_int(0),
		rt.new_int(3),
	]))
	mut iife_temp_0 := Class_getid3_lib{}
	mut iife_result_0 := iife_temp_0.bigendian2int(rt.call_function('substr', [
		var_FLVheader.clone(),
		rt.new_int(3),
		rt.new_int(1),
	]))
	var_info.array_get_mut('flv').array_get_mut('header').array_set('version', iife_result_0)
	mut iife_temp_1 := Class_getid3_lib{}
	mut iife_result_1 := iife_temp_1.bigendian2int(rt.call_function('substr', [
		var_FLVheader.clone(),
		rt.new_int(4),
		rt.new_int(1),
	]))
	mut var_TypeFlags := iife_result_1
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('header')).array_get(rt.new_string('signature')),
		Class_getid3_flv.magic()))))
	{
		mut iife_temp_2 := Class_getid3_lib{}
		mut iife_result_2 := iife_temp_2.printhexbytes(rt.new_string(Class_getid3_flv.magic()))
		mut iife_temp_3 := Class_getid3_lib{}
		mut iife_result_3 :=
			iife_temp_3.printhexbytes(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('header')).array_get(rt.new_string('signature')))
		this.error(rt.new_string('Expecting "' + iife_result_2.str() + '" at offset ' +
			(var_info.array_get(rt.new_string('avdataoffset'))).str() + ', found "' + iife_result_3.str() +
			'"'))
		var_info.delete('flv')
		var_info.delete('fileformat')
		return false
	}
	var_info.array_get_mut('flv').array_get_mut('header').array_set('hasAudio', (rt.bitwise_and(var_TypeFlags,
		rt.new_int(4))).to_bool())
	var_info.array_get_mut('flv').array_get_mut('header').array_set('hasVideo', (rt.bitwise_and(var_TypeFlags,
		rt.new_int(1))).to_bool())
	mut iife_temp_4 := Class_getid3_lib{}
	mut iife_result_4 := iife_temp_4.bigendian2int(this.fread(rt.new_int(4)))
	mut var_FrameSizeDataLength := iife_result_4
	mut var_FLVheaderFrameLength := rt.new_int(9)
	if rt.is_true(rt.greater(var_FrameSizeDataLength, var_FLVheaderFrameLength)) {
		this.fseek(rt.sub(var_FrameSizeDataLength, var_FLVheaderFrameLength),
			rt.get_constant('SEEK_CUR'))
	}
	mut var_Duration := rt.new_int(0)
	mut var_found_video := rt.new_bool(false)
	mut var_found_audio := rt.new_bool(false)
	mut var_found_meta := rt.new_bool(false)
	mut var_found_valid_meta_playtime := rt.new_bool(false)
	mut var_tagParseCount := rt.new_int(0)
	var_info.array_get_mut('flv').array_set('framecount', rt.create_array([
		rt.ArrayItem{ key: 'total', val: 0 },
		rt.ArrayItem{ key: 'audio', val: 0 },
		rt.ArrayItem{ key: 'video', val: 0 },
	]))
	var_flv_framecount =
		var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('framecount'))
	for rt.is_true(rt.less(rt.add(this.ftell(), rt.new_int(16)), var_info.array_get(rt.new_string('avdataend'))))
		&& rt.is_true(rt.less_equal(rt.post_inc(var_tagParseCount), this.max_frames))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_found_valid_meta_playtime)))) {
		mut var_ThisTagHeader := this.fread(rt.new_int(16))
		mut iife_temp_5 := Class_getid3_lib{}
		mut iife_result_5 := iife_temp_5.bigendian2int(rt.call_function('substr', [
			var_ThisTagHeader.clone(),
			rt.new_int(0),
			rt.new_int(4),
		]))
		mut var_PreviousTagLength := iife_result_5
		mut iife_temp_6 := Class_getid3_lib{}
		mut iife_result_6 := iife_temp_6.bigendian2int(rt.call_function('substr', [
			var_ThisTagHeader.clone(),
			rt.new_int(4),
			rt.new_int(1),
		]))
		mut var_TagType := iife_result_6
		mut iife_temp_7 := Class_getid3_lib{}
		mut iife_result_7 := iife_temp_7.bigendian2int(rt.call_function('substr', [
			var_ThisTagHeader.clone(),
			rt.new_int(5),
			rt.new_int(3),
		]))
		mut var_DataLength := iife_result_7
		mut iife_temp_8 := Class_getid3_lib{}
		mut iife_result_8 := iife_temp_8.bigendian2int(rt.call_function('substr', [
			var_ThisTagHeader.clone(),
			rt.new_int(8),
			rt.new_int(3),
		]))
		mut var_Timestamp := iife_result_8
		mut iife_temp_9 := Class_getid3_lib{}
		mut iife_result_9 := iife_temp_9.bigendian2int(rt.call_function('substr', [
			var_ThisTagHeader.clone(),
			rt.new_int(15),
			rt.new_int(1),
		]))
		mut var_LastHeaderByte := iife_result_9
		mut var_NextOffset := rt.add(rt.sub(this.ftell(), rt.new_int(1)), var_DataLength)
		if rt.is_true(rt.greater(var_Timestamp, var_Duration)) {
			var_Duration = var_Timestamp.clone()
		}
		rt.post_inc(var_flv_framecount.array_get(rt.new_string('total')))
		mut switch_val_1 := var_TagType
		if rt.is_true(rt.equal(switch_val_1, rt.new_int(global_const_getid3_flv_tag_audio))) {
			rt.post_inc(var_flv_framecount.array_get(rt.new_string('audio')))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_found_audio)))) {
				var_found_audio = rt.new_bool(true)
				var_info.array_get_mut('flv').array_get_mut('audio').array_set('audioFormat', rt.shift_right(var_LastHeaderByte,
					rt.new_int(4)) & 15)
				var_info.array_get_mut('flv').array_get_mut('audio').array_set('audioRate', rt.shift_right(var_LastHeaderByte,
					rt.new_int(2)) & 3)
				var_info.array_get_mut('flv').array_get_mut('audio').array_set('audioSampleSize', rt.shift_right(var_LastHeaderByte,
					rt.new_int(1)) & 1)
				var_info.array_get_mut('flv').array_get_mut('audio').array_set('audioType', rt.bitwise_and(var_LastHeaderByte,
					rt.new_int(1)))
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(global_const_getid3_flv_tag_video))) {
			rt.post_inc(var_flv_framecount.array_get(rt.new_string('video')))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_found_video)))) {
				var_found_video = rt.new_bool(true)
				var_info.array_get_mut('flv').array_get_mut('video').array_set('videoCodec', rt.bitwise_and(var_LastHeaderByte,
					rt.new_int(7)))
				mut var_FLVvideoHeader := this.fread(rt.new_int(11))
				mut var_PictureSizeEnc := rt.new_array()
				if rt.is_true(rt.equal(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('video')).array_get(rt.new_string('videoCodec')),
					rt.new_int(global_const_getid3_flv_video_h264)))
				{
					mut iife_temp_10 := Class_getid3_lib{}
					mut iife_result_10 := iife_temp_10.bigendian2int(rt.call_function('substr', [
						var_FLVvideoHeader.clone(),
						rt.new_int(0),
						rt.new_int(1),
					]))
					mut var_AVCPacketType := iife_result_10
					if rt.is_true(rt.equal(var_AVCPacketType,
						rt.new_int(global_const_h264_avc_sequence_header)))
					{
						mut iife_temp_11 := Class_getid3_lib{}
						mut iife_result_11 := iife_temp_11.bigendian2int(rt.call_function('substr', [
							var_FLVvideoHeader.clone(),
							rt.new_int(4),
							rt.new_int(1),
						]))
						mut var_configurationVersion := iife_result_11
						mut iife_temp_12 := Class_getid3_lib{}
						mut iife_result_12 := iife_temp_12.bigendian2int(rt.call_function('substr', [
							var_FLVvideoHeader.clone(),
							rt.new_int(5),
							rt.new_int(1),
						]))
						mut var_AVCProfileIndication := iife_result_12
						mut iife_temp_13 := Class_getid3_lib{}
						mut iife_result_13 := iife_temp_13.bigendian2int(rt.call_function('substr', [
							var_FLVvideoHeader.clone(),
							rt.new_int(6),
							rt.new_int(1),
						]))
						mut var_profile_compatibility := iife_result_13
						mut iife_temp_14 := Class_getid3_lib{}
						mut iife_result_14 := iife_temp_14.bigendian2int(rt.call_function('substr', [
							var_FLVvideoHeader.clone(),
							rt.new_int(7),
							rt.new_int(1),
						]))
						mut var_lengthSizeMinusOne := iife_result_14
						mut iife_temp_15 := Class_getid3_lib{}
						mut iife_result_15 := iife_temp_15.bigendian2int(rt.call_function('substr', [
							var_FLVvideoHeader.clone(),
							rt.new_int(8),
							rt.new_int(1),
						]))
						mut var_numOfSequenceParameterSets := iife_result_15
						if rt.is_true(rt.new_bool(rt.bitwise_and(var_numOfSequenceParameterSets,
							rt.new_int(31)) != 0))
						{
							mut iife_temp_16 := Class_getid3_lib{}
							mut iife_result_16 := iife_temp_16.littleendian2int(rt.call_function('substr', [
								var_FLVvideoHeader.clone(),
								rt.new_int(9),
								rt.new_int(2),
							]))
							mut var_spsSize := iife_result_16
							mut var_sps := this.fread(var_spsSize.clone())
							if rt.is_true(rt.equal(rt.new_int(var_sps.clone().to_string().len),
								var_spsSize))
							{
								mut var_spsReader :=
									create_avcsequenceparametersetreader(var_sps.clone())
								var_spsReader.readdata()
								var_info.array_get_mut('video').array_set('resolution_x',
									var_spsReader.getwidth())
								var_info.array_get_mut('video').array_set('resolution_y',
									var_spsReader.getheight())
							}
						}
					}
				} else if rt.is_true(rt.equal(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('video')).array_get(rt.new_string('videoCodec')),
					rt.new_int(global_const_getid3_flv_video_h263)))
				{
					mut iife_temp_17 := Class_getid3_lib{}
					mut iife_result_17 := iife_temp_17.bigendian2int(rt.call_function('substr', [
						var_FLVvideoHeader.clone(),
						rt.new_int(3),
						rt.new_int(2),
					]))
					mut var_PictureSizeType := rt.new_int(rt.shift_right(iife_result_17,
						rt.new_int(7)))
					var_PictureSizeType = rt.new_int(rt.bitwise_and(var_PictureSizeType,
						rt.new_int(7)))
					var_info.array_get_mut('flv').array_get_mut('header').array_set('videoSizeType',
						var_PictureSizeType.clone())
					mut switch_val_2 := var_PictureSizeType
					if rt.is_true(rt.equal(switch_val_2, rt.new_int(0))) {
						mut iife_temp_18 := Class_getid3_lib{}
						mut iife_result_18 := iife_temp_18.bigendian2int(rt.call_function('substr', [
							var_FLVvideoHeader.clone(),
							rt.new_int(4),
							rt.new_int(2),
						]))
						var_PictureSizeEnc.array_set('x', rt.shift_right(iife_result_18,
							rt.new_int(7)))
						mut iife_temp_19 := Class_getid3_lib{}
						mut iife_result_19 := iife_temp_19.bigendian2int(rt.call_function('substr', [
							var_FLVvideoHeader.clone(),
							rt.new_int(5),
							rt.new_int(2),
						]))
						var_PictureSizeEnc.array_set('y', rt.shift_right(iife_result_19,
							rt.new_int(7)))
						var_info.array_get_mut('video').array_set('resolution_x', rt.bitwise_and(var_PictureSizeEnc.array_get(rt.new_string('x')),
							rt.new_int(255)))
						var_info.array_get_mut('video').array_set('resolution_y', rt.bitwise_and(var_PictureSizeEnc.array_get(rt.new_string('y')),
							rt.new_int(255)))
					} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(1))) {
						mut iife_temp_20 := Class_getid3_lib{}
						mut iife_result_20 := iife_temp_20.bigendian2int(rt.call_function('substr', [
							var_FLVvideoHeader.clone(),
							rt.new_int(4),
							rt.new_int(3),
						]))
						var_PictureSizeEnc.array_set('x', rt.shift_right(iife_result_20,
							rt.new_int(7)))
						mut iife_temp_21 := Class_getid3_lib{}
						mut iife_result_21 := iife_temp_21.bigendian2int(rt.call_function('substr', [
							var_FLVvideoHeader.clone(),
							rt.new_int(6),
							rt.new_int(3),
						]))
						var_PictureSizeEnc.array_set('y', rt.shift_right(iife_result_21,
							rt.new_int(7)))
						var_info.array_get_mut('video').array_set('resolution_x', rt.bitwise_and(var_PictureSizeEnc.array_get(rt.new_string('x')),
							rt.new_int(65535)))
						var_info.array_get_mut('video').array_set('resolution_y', rt.bitwise_and(var_PictureSizeEnc.array_get(rt.new_string('y')),
							rt.new_int(65535)))
					} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(2))) {
						var_info.array_get_mut('video').array_set('resolution_x', 352)
						var_info.array_get_mut('video').array_set('resolution_y', 288)
					} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(3))) {
						var_info.array_get_mut('video').array_set('resolution_x', 176)
						var_info.array_get_mut('video').array_set('resolution_y', 144)
					} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(4))) {
						var_info.array_get_mut('video').array_set('resolution_x', 128)
						var_info.array_get_mut('video').array_set('resolution_y', 96)
					} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(5))) {
						var_info.array_get_mut('video').array_set('resolution_x', 320)
						var_info.array_get_mut('video').array_set('resolution_y', 240)
					} else if rt.is_true(rt.equal(switch_val_2, rt.new_int(6))) {
						var_info.array_get_mut('video').array_set('resolution_x', 160)
						var_info.array_get_mut('video').array_set('resolution_y', 120)
					} else {
						var_info.array_get_mut('video').array_set('resolution_x', 0)
						var_info.array_get_mut('video').array_set('resolution_y', 0)
					}
				} else if rt.is_true(rt.equal(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('video')).array_get(rt.new_string('videoCodec')),
					rt.new_int(global_const_getid3_flv_video_vp6flv_alpha)))
				{
					if !(var_info.array_get(rt.new_string('video')).array_isset(rt.new_string('resolution_x'))) {
						mut iife_temp_22 := Class_getid3_lib{}
						mut iife_result_22 := iife_temp_22.bigendian2int(rt.call_function('substr', [
							var_FLVvideoHeader.clone(),
							rt.new_int(6),
							rt.new_int(2),
						]))
						var_PictureSizeEnc.array_set('x', iife_result_22)
						mut iife_temp_23 := Class_getid3_lib{}
						mut iife_result_23 := iife_temp_23.bigendian2int(rt.call_function('substr', [
							var_FLVvideoHeader.clone(),
							rt.new_int(7),
							rt.new_int(2),
						]))
						var_PictureSizeEnc.array_set('y', iife_result_23)
						var_info.array_get_mut('video').array_set('resolution_x', rt.bitwise_and(var_PictureSizeEnc.array_get(rt.new_string('x')),
							rt.new_int(255)) << 3)
						var_info.array_get_mut('video').array_set('resolution_y', rt.bitwise_and(var_PictureSizeEnc.array_get(rt.new_string('y')),
							rt.new_int(255)) << 3)
					}
				}
				if !(!rt.is_true(var_info.array_get(rt.new_string('video')).array_get(rt.new_string('resolution_x'))))
					&& !(!rt.is_true(var_info.array_get(rt.new_string('video')).array_get(rt.new_string('resolution_y')))) {
					var_info.array_get_mut('video').array_set('pixel_aspect_ratio', rt.div(var_info.array_get(rt.new_string('video')).array_get(rt.new_string('resolution_x')),
						var_info.array_get(rt.new_string('video')).array_get(rt.new_string('resolution_y'))))
				}
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(global_const_getid3_flv_tag_meta))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(var_found_meta)))) {
				var_found_meta = rt.new_bool(true)
				this.fseek(rt.new_int(-1), rt.get_constant('SEEK_CUR'))
				mut var_datachunk := this.fread(var_DataLength.clone())
				mut var_AMFstream := create_amfstream(var_datachunk.clone())
				mut var_reader := create_amfreader(var_AMFstream)
				mut var_eventName := var_reader.readdata()
				var_info.array_get_mut('flv').array_get_mut('meta').array_set(var_eventName,
					var_reader.readdata())
				var_reader = rt.new_null()
				mut var_copykeys := rt.create_array([
					rt.ArrayItem{ key: 'framerate', val: 'frame_rate' },
					rt.ArrayItem{ key: 'width', val: 'resolution_x' },
					rt.ArrayItem{ key: 'height', val: 'resolution_y' },
					rt.ArrayItem{ key: 'audiodatarate', val: 'bitrate' },
					rt.ArrayItem{ key: 'videodatarate', val: 'bitrate' },
				])
				mut iter_1 := var_copykeys.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_destkey := item_1.val
					mut var_sourcekey := item_1.key
					if var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('meta')).array_get(rt.new_string('onMetaData')).array_isset(var_sourcekey) {
						mut switch_val_3 := var_sourcekey
						if rt.is_true(rt.equal(switch_val_3, rt.new_string('width')))
							|| rt.is_true(rt.equal(switch_val_3, rt.new_string('height'))) {
							var_info.array_get_mut('video').array_set(var_destkey, rt.call_function('round', [
								var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('meta')).array_get(rt.new_string('onMetaData')).array_get(var_sourcekey),
							]).to_i64())
						} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('audiodatarate'))) {
							mut iife_temp_24 := Class_getid3_lib{}
							mut iife_result_24 := iife_temp_24.castasint(rt.call_function('round', [
								rt.mul(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('meta')).array_get(rt.new_string('onMetaData')).array_get(var_sourcekey),
									rt.new_int(1000)),
							]))
							var_info.array_get_mut('audio').array_set(var_destkey, iife_result_24)
						} else {
							var_info.array_get_mut('video').array_set(var_destkey,
								var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('meta')).array_get(rt.new_string('onMetaData')).array_get(var_sourcekey))
						}
					}
				}
				if !(!rt.is_true(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('meta')).array_get(rt.new_string('onMetaData')).array_get(rt.new_string('duration')))) {
					var_found_valid_meta_playtime = rt.new_bool(true)
				}
			}
		} else {
		}
		this.fseek(var_NextOffset.clone())
	}
	var_info['playtime_seconds'] = rt.div(var_Duration, rt.new_int(1000))
	if rt.is_true(rt.greater(var_info.array_get(rt.new_string('playtime_seconds')), rt.new_int(0))) {
		var_info['bitrate'] = rt.div(rt.mul(rt.sub(var_info.array_get(rt.new_string('avdataend')),
			var_info.array_get(rt.new_string('avdataoffset'))), rt.new_int(8)),
			var_info.array_get(rt.new_string('playtime_seconds')))
	}
	if rt.is_true(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('header')).array_get(rt.new_string('hasAudio'))) {
		var_info.array_get_mut('audio').array_set('codec',
			Class_getid3_flv.audioformatlookup(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('audio')).array_get(rt.new_string('audioFormat'))))
		var_info.array_get_mut('audio').array_set('sample_rate',
			Class_getid3_flv.audioratelookup(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('audio')).array_get(rt.new_string('audioRate'))))
		var_info.array_get_mut('audio').array_set('bits_per_sample',
			Class_getid3_flv.audiobitdepthlookup(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('audio')).array_get(rt.new_string('audioSampleSize'))))
		var_info.array_get_mut('audio').array_set('channels', rt.add(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('audio')).array_get(rt.new_string('audioType')),
			rt.new_int(1)))
		var_info.array_get_mut('audio').array_set('lossless', if rt.is_true(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('audio')).array_get(rt.new_string('audioFormat'))) {
			false
		} else {
			true
		})
		var_info.array_get_mut('audio').array_set('dataformat', 'flv')
	}
	if !(!rt.is_true(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('header')).array_get(rt.new_string('hasVideo')))) {
		var_info.array_get_mut('video').array_set('codec',
			Class_getid3_flv.videocodeclookup(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('video')).array_get(rt.new_string('videoCodec'))))
		var_info.array_get_mut('video').array_set('dataformat', 'flv')
		var_info.array_get_mut('video').array_set('lossless', false)
	}
	if !(!rt.is_true(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('meta')).array_get(rt.new_string('onMetaData')).array_get(rt.new_string('duration')))) {
		var_info['playtime_seconds'] =
			var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('meta')).array_get(rt.new_string('onMetaData')).array_get(rt.new_string('duration'))
		var_info['bitrate'] = rt.div(rt.mul(rt.sub(var_info.array_get(rt.new_string('avdataend')),
			var_info.array_get(rt.new_string('avdataoffset'))), rt.new_int(8)),
			var_info.array_get(rt.new_string('playtime_seconds')))
	}
	if var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('meta')).array_get(rt.new_string('onMetaData')).array_isset(rt.new_string('audiocodecid')) {
		var_info.array_get_mut('audio').array_set('codec',
			Class_getid3_flv.audioformatlookup(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('meta')).array_get(rt.new_string('onMetaData')).array_get(rt.new_string('audiocodecid'))))
	}
	if var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('meta')).array_get(rt.new_string('onMetaData')).array_isset(rt.new_string('videocodecid')) {
		var_info.array_get_mut('video').array_set('codec',
			Class_getid3_flv.videocodeclookup(var_info.array_get(rt.new_string('flv')).array_get(rt.new_string('meta')).array_get(rt.new_string('onMetaData')).array_get(rt.new_string('videocodecid'))))
	}
	return true
}

fn Class_getid3_flv.audioformatlookup(var_id rt.PhpVal) rt.PhpVal {
	mut var_lookup := rt.new_null()
	return if var_lookup.array_isset(var_id) {
		var_lookup.array_get(var_id)
	} else {
		rt.new_bool(false)
	}
}

fn Class_getid3_flv.audioratelookup(var_id rt.PhpVal) rt.PhpVal {
	mut var_lookup := rt.new_null()
	return if var_lookup.array_isset(var_id) {
		var_lookup.array_get(var_id)
	} else {
		rt.new_bool(false)
	}
}

fn Class_getid3_flv.audiobitdepthlookup(var_id rt.PhpVal) rt.PhpVal {
	mut var_lookup := rt.new_null()
	return if var_lookup.array_isset(var_id) {
		var_lookup.array_get(var_id)
	} else {
		rt.new_bool(false)
	}
}

fn Class_getid3_flv.videocodeclookup(var_id rt.PhpVal) rt.PhpVal {
	mut var_lookup := rt.new_null()
	return if var_lookup.array_isset(var_id) {
		var_lookup.array_get(var_id)
	} else {
		rt.new_bool(false)
	}
}

struct Class_AMFStream {
	rt.PhpObjectBase
pub mut:
	bytes rt.PhpVal = rt.new_null()
	pos   rt.PhpVal = rt.new_null()
}

fn (mut this Class_AMFStream) construct(var_bytes rt.PhpVal) {
	this.bytes = var_bytes
	this.pos = rt.new_int(0)
}

fn (mut this Class_AMFStream) readbyte() rt.PhpVal {
	return rt.call_function('ord', [
		rt.call_function('substr', [this.bytes, rt.post_inc(this.pos),
			rt.new_int(1)]),
	])
}

fn (mut this Class_AMFStream) readint() rt.PhpVal {
	return rt.add(rt.shift_left(this.readbyte(), rt.new_int(8)), this.readbyte())
}

fn (mut this Class_AMFStream) readlong() rt.PhpVal {
	return rt.add(rt.shift_left(this.readbyte(), rt.new_int(24)) +
		rt.shift_left(this.readbyte(), rt.new_int(16)) +
		rt.shift_left(this.readbyte(), rt.new_int(8)), this.readbyte())
}

fn (mut this Class_AMFStream) readdouble() rt.PhpVal {
	mut iife_temp_25 := Class_getid3_lib{}
	mut iife_result_25 := iife_temp_25.bigendian2float(this.read(rt.new_int(8)))
	return iife_result_25
}

fn (mut this Class_AMFStream) readutf() rt.PhpVal {
	mut var_length := this.readint()
	return this.read(var_length.clone())
}

fn (mut this Class_AMFStream) readlongutf() rt.PhpVal {
	mut var_length := this.readlong()
	return this.read(var_length.clone())
}

fn (mut this Class_AMFStream) read(var_length rt.PhpVal) rt.PhpVal {
	mut var_length_mutated := var_length
	mut var_val := rt.call_function('substr', [this.bytes, this.pos, var_length_mutated.clone()])
	this.pos = rt.add(this.pos, var_length_mutated)
	return var_val.clone()
}

fn (mut this Class_AMFStream) peekbyte() rt.PhpVal {
	mut var_pos := this.pos
	mut var_val := this.readbyte()
	this.pos = var_pos.clone()
	return var_val.clone()
}

fn (mut this Class_AMFStream) peekint() rt.PhpVal {
	mut var_pos := this.pos
	mut var_val := this.readint()
	this.pos = var_pos.clone()
	return var_val.clone()
}

fn (mut this Class_AMFStream) peeklong() rt.PhpVal {
	mut var_pos := this.pos
	mut var_val := this.readlong()
	this.pos = var_pos.clone()
	return var_val.clone()
}

fn (mut this Class_AMFStream) peekdouble() rt.PhpVal {
	mut var_pos := this.pos
	mut var_val := this.readdouble()
	this.pos = var_pos.clone()
	return var_val.clone()
}

fn (mut this Class_AMFStream) peekutf() rt.PhpVal {
	mut var_pos := this.pos
	mut var_val := this.readutf()
	this.pos = var_pos.clone()
	return var_val.clone()
}

fn (mut this Class_AMFStream) peeklongutf() rt.PhpVal {
	mut var_pos := this.pos
	mut var_val := this.readlongutf()
	this.pos = var_pos.clone()
	return var_val.clone()
}

struct Class_AMFReader {
	rt.PhpObjectBase
pub mut:
	stream rt.PhpVal = rt.new_null()
}

fn (mut this Class_AMFReader) construct(mut var_stream Class_AMFStream) {
	this.stream = var_stream
}

fn (mut this Class_AMFReader) readdata() rt.PhpVal {
	mut var_value := rt.new_null()
	mut var_type := rt.call_method(this.stream, 'readByte', []rt.PhpVal{})
	mut switch_val_4 := var_type
	if rt.is_true(rt.equal(switch_val_4, rt.new_int(0))) {
		var_value = this.readdouble()
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_int(1))) {
		var_value = this.readboolean()
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_int(2))) {
		var_value = this.readstring()
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_int(3))) {
		var_value = this.readobject()
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_int(6))) {
		return rt.new_null()
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_int(8))) {
		var_value = this.readmixedarray()
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_int(10))) {
		var_value = this.readarray()
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_int(11))) {
		var_value = this.readdate()
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_int(13))) {
		var_value = this.readlongstring()
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_int(15))) {
		var_value = this.readxml()
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_int(16))) {
		var_value = this.readtypedobject()
	} else {
		var_value = rt.new_string('(unknown or unsupported data type)')
	}
	return var_value.clone()
}

fn (mut this Class_AMFReader) readdouble() rt.PhpVal {
	return rt.call_method(this.stream, 'readDouble', []rt.PhpVal{})
}

fn (mut this Class_AMFReader) readboolean() rt.PhpVal {
	return rt.equal(rt.call_method(this.stream, 'readByte', []rt.PhpVal{}), rt.new_int(1))
}

fn (mut this Class_AMFReader) readstring() rt.PhpVal {
	return rt.call_method(this.stream, 'readUTF', []rt.PhpVal{})
}

fn (mut this Class_AMFReader) readobject() rt.PhpVal {
	mut var_data := rt.new_array()
	mut var_key := rt.new_null()
	var_key = rt.call_method(this.stream, 'readUTF', []rt.PhpVal{})
	for rt.is_true(var_key) {
		var_data.array_set(var_key, this.readdata())
	}
	if rt.is_true(rt.equal(var_key, rt.new_string('')))
		&& rt.is_true(rt.equal(rt.call_method(this.stream, 'peekByte', []rt.PhpVal{}), rt.new_int(9))) {
		rt.call_method(this.stream, 'readByte', []rt.PhpVal{})
	}
	return var_data.clone()
}

fn (mut this Class_AMFReader) readmixedarray() rt.PhpVal {
	mut var_highestIndex := rt.call_method(this.stream, 'readLong', []rt.PhpVal{})
	mut var_data := rt.new_array()
	mut var_key := rt.new_null()
	var_key = rt.call_method(this.stream, 'readUTF', []rt.PhpVal{})
	for rt.is_true(var_key) {
		if rt.is_true(rt.new_bool(var_key.clone().is_long() || var_key.clone().is_double())) {
			var_key = rt.new_int(var_key.to_i64())
		}
		var_data.array_set(var_key, this.readdata())
	}
	if rt.is_true(rt.equal(var_key, rt.new_string('')))
		&& rt.is_true(rt.equal(rt.call_method(this.stream, 'peekByte', []rt.PhpVal{}), rt.new_int(9))) {
		rt.call_method(this.stream, 'readByte', []rt.PhpVal{})
	}
	return var_data.clone()
}

fn (mut this Class_AMFReader) readarray() rt.PhpVal {
	mut var_length := rt.call_method(this.stream, 'readLong', []rt.PhpVal{})
	mut var_data := rt.new_array()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_length))) { break
		 }
		var_data.array_push(this.readdata())
		rt.post_inc(var_i)
	}
	return var_data.clone()
}

fn (mut this Class_AMFReader) readdate() rt.PhpVal {
	mut var_timestamp := rt.call_method(this.stream, 'readDouble', []rt.PhpVal{})
	mut var_timezone := rt.call_method(this.stream, 'readInt', []rt.PhpVal{})
	return var_timestamp.clone()
}

fn (mut this Class_AMFReader) readlongstring() rt.PhpVal {
	return rt.call_method(this.stream, 'readLongUTF', []rt.PhpVal{})
}

fn (mut this Class_AMFReader) readxml() rt.PhpVal {
	return rt.call_method(this.stream, 'readLongUTF', []rt.PhpVal{})
}

fn (mut this Class_AMFReader) readtypedobject() rt.PhpVal {
	mut var_className := rt.call_method(this.stream, 'readUTF', []rt.PhpVal{})
	return this.readobject()
}

struct Class_AVCSequenceParameterSetReader {
	rt.PhpObjectBase
pub mut:
	sps          rt.PhpVal = rt.new_null()
	start        rt.PhpVal = rt.new_int(0)
	currentBytes rt.PhpVal = rt.new_int(0)
	currentBits  rt.PhpVal = rt.new_int(0)
	width        rt.PhpVal = rt.new_null()
	height       rt.PhpVal = rt.new_null()
}

fn (mut this Class_AVCSequenceParameterSetReader) construct(var_sps rt.PhpVal) {
	mut var_sps_mutated := var_sps
	this.sps = var_sps_mutated.clone()
}

fn (mut this Class_AVCSequenceParameterSetReader) readdata() {
	this.skipbits(rt.new_int(8))
	this.skipbits(rt.new_int(8))
	mut var_profile := this.getbits(rt.new_int(8))
	if rt.is_true(rt.greater(var_profile, rt.new_int(0))) {
		this.skipbits(rt.new_int(8))
		mut var_level_idc := this.getbits(rt.new_int(8))
		this.expgolombue()
		this.expgolombue()
		mut var_picOrderType := rt.new_int(this.expgolombue())
		if rt.is_true(rt.equal(var_picOrderType, rt.new_int(0))) {
			this.expgolombue()
		} else if rt.is_true(rt.equal(var_picOrderType, rt.new_int(1))) {
			this.skipbits(rt.new_int(1))
			this.expgolombse()
			this.expgolombse()
			mut var_num_ref_frames_in_pic_order_cnt_cycle := rt.new_int(this.expgolombue())
			mut var_i := rt.new_int(0)
			for {
				if !(rt.is_true(rt.less(var_i, var_num_ref_frames_in_pic_order_cnt_cycle))) { break
				 }
				this.expgolombse()
				rt.post_inc(var_i)
			}
		}
		this.expgolombue()
		this.skipbits(rt.new_int(1))
		mut var_pic_width_in_mbs_minus1 := rt.new_int(this.expgolombue())
		mut var_pic_height_in_map_units_minus1 := rt.new_int(this.expgolombue())
		mut var_frame_mbs_only_flag := this.getbits(rt.new_int(1))
		if rt.is_true(rt.equal(var_frame_mbs_only_flag, rt.new_int(0))) {
			this.skipbits(rt.new_int(1))
		}
		this.skipbits(rt.new_int(1))
		mut var_frame_cropping_flag := this.getbits(rt.new_int(1))
		mut var_frame_crop_left_offset := rt.new_int(0)
		mut var_frame_crop_right_offset := rt.new_int(0)
		mut var_frame_crop_top_offset := rt.new_int(0)
		mut var_frame_crop_bottom_offset := rt.new_int(0)
		if rt.is_true(var_frame_cropping_flag) {
			var_frame_crop_left_offset = rt.new_int(this.expgolombue())
			var_frame_crop_right_offset = rt.new_int(this.expgolombue())
			var_frame_crop_top_offset = rt.new_int(this.expgolombue())
			var_frame_crop_bottom_offset = rt.new_int(this.expgolombue())
		}
		this.skipbits(rt.new_int(1))
		this.width = rt.sub(rt.sub(rt.mul(rt.add(var_pic_width_in_mbs_minus1, rt.new_int(1)),
			rt.new_int(16)), rt.mul(var_frame_crop_left_offset, rt.new_int(2))), rt.mul(var_frame_crop_right_offset,
			rt.new_int(2)))
		this.height = rt.sub(rt.sub(rt.mul(rt.mul(rt.sub(rt.new_int(2), var_frame_mbs_only_flag), rt.add(var_pic_height_in_map_units_minus1,
			rt.new_int(1))), rt.new_int(16)), rt.mul(var_frame_crop_top_offset, rt.new_int(2))), rt.mul(var_frame_crop_bottom_offset,
			rt.new_int(2)))
	}
}

fn (mut this Class_AVCSequenceParameterSetReader) skipbits(var_bits rt.PhpVal) {
	mut var_newBits := rt.add(this.currentBits, var_bits)
	this.currentBytes = rt.add(this.currentBytes, rt.new_int((rt.call_function('floor', [
		rt.div(var_newBits, rt.new_int(8)),
	])).to_i64()))
	this.currentBits = rt.mod_(var_newBits, rt.new_int(8))
}

fn (mut this Class_AVCSequenceParameterSetReader) getbit() rt.PhpVal {
	mut iife_temp_26 := Class_getid3_lib{}
	mut iife_result_26 := iife_temp_26.bigendian2int(rt.call_function('substr', [this.sps,
		this.currentBytes, rt.new_int(1)]))
	mut var_result := rt.new_int(rt.shift_right(iife_result_26, rt.sub(rt.new_int(7),
		this.currentBits)) & 1)
	this.skipbits(rt.new_int(1))
	return var_result.clone()
}

fn (mut this Class_AVCSequenceParameterSetReader) getbits(var_bits rt.PhpVal) rt.PhpVal {
	mut var_result := rt.new_int(0)
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_bits))) { break
		 }
		var_result = rt.add(rt.shift_left(var_result, rt.new_int(1)), this.getbit())
		rt.post_inc(var_i)
	}
	return var_result.clone()
}

fn (mut this Class_AVCSequenceParameterSetReader) expgolombue() i64 {
	mut var_significantBits := rt.new_int(0)
	mut var_bit := this.getbit()
	for rt.is_true(rt.equal(var_bit, rt.new_int(0))) {
		rt.post_inc(var_significantBits)
		var_bit = this.getbit()
		if rt.is_true(rt.greater(var_significantBits, rt.new_int(31))) {
			return 0
		}
	}
	return (rt.sub(rt.add(rt.shift_left(rt.new_int(1), var_significantBits),
		this.getbits(var_significantBits.clone())), rt.new_int(1))).to_i64()
}

fn (mut this Class_AVCSequenceParameterSetReader) expgolombse() i64 {
	mut var_result := rt.new_int(this.expgolombue())
	if rt.bitwise_and(var_result, rt.new_int(1)) == 0 {
		return -rt.shift_right(var_result, rt.new_int(1))
	} else {
		return rt.shift_right(rt.add(var_result, rt.new_int(1)), rt.new_int(1))
	}
	return i64(0)
}

fn (mut this Class_AVCSequenceParameterSetReader) getwidth() rt.PhpVal {
	return this.width
}

fn (mut this Class_AVCSequenceParameterSetReader) getheight() rt.PhpVal {
	return this.height
}

struct Class_getid3_handler {
	rt.PhpObjectBase
}

struct Class_getid3_lib {
	rt.PhpObjectBase
}

fn create_getid3_flv(_args ...rt.PhpVal) &Class_getid3_flv {
	mut obj := &Class_getid3_flv{
		PhpObjectBase: rt.PhpObjectBase{}
		max_frames:    rt.new_int(100000)
	}
	return obj
}

fn create_amfstream(arg_0 rt.PhpVal) &Class_AMFStream {
	mut obj := &Class_AMFStream{
		PhpObjectBase: rt.PhpObjectBase{}
		bytes:         rt.new_null()
		pos:           rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_amfreader(arg_0 rt.PhpVal) &Class_AMFReader {
	mut obj := &Class_AMFReader{
		PhpObjectBase: rt.PhpObjectBase{}
		stream:        rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_avcsequenceparametersetreader(arg_0 rt.PhpVal) &Class_AVCSequenceParameterSetReader {
	mut obj := &Class_AVCSequenceParameterSetReader{
		PhpObjectBase: rt.PhpObjectBase{}
		sps:           rt.new_null()
		start:         rt.new_int(0)
		currentBytes:  rt.new_int(0)
		currentBits:   rt.new_int(0)
		width:         rt.new_null()
		height:        rt.new_null()
	}
	obj.construct(arg_0)
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
		else {
			return none
		}
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
		'max_frames' {
			this.max_frames = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_AMFStream) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'readByte' {
			return this.readbyte()
		}
		'readInt' {
			return this.readint()
		}
		'readLong' {
			return this.readlong()
		}
		'readDouble' {
			return this.readdouble()
		}
		'readUTF' {
			return this.readutf()
		}
		'readLongUTF' {
			return this.readlongutf()
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.read(dispatch_arg_0)
		}
		'peekByte' {
			return this.peekbyte()
		}
		'peekInt' {
			return this.peekint()
		}
		'peekLong' {
			return this.peeklong()
		}
		'peekDouble' {
			return this.peekdouble()
		}
		'peekUTF' {
			return this.peekutf()
		}
		'peekLongUTF' {
			return this.peeklongutf()
		}
		else {
			return none
		}
	}
}

fn (this &Class_AMFStream) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'bytes' { return this.bytes }
		'pos' { return this.pos }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_AMFStream) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'bytes' {
			this.bytes = val
			return true
		}
		'pos' {
			this.pos = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_AMFReader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_AMFStream](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'readData' {
			return this.readdata()
		}
		'readDouble' {
			return this.readdouble()
		}
		'readBoolean' {
			return this.readboolean()
		}
		'readString' {
			return this.readstring()
		}
		'readObject' {
			return this.readobject()
		}
		'readMixedArray' {
			return this.readmixedarray()
		}
		'readArray' {
			return this.readarray()
		}
		'readDate' {
			return this.readdate()
		}
		'readLongString' {
			return this.readlongstring()
		}
		'readXML' {
			return this.readxml()
		}
		'readTypedObject' {
			return this.readtypedobject()
		}
		else {
			return none
		}
	}
}

fn (this &Class_AMFReader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'stream' { return this.stream }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_AMFReader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'stream' {
			this.stream = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_AVCSequenceParameterSetReader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'readData' {
			this.readdata()
			return rt.new_null()
		}
		'skipBits' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.skipbits(dispatch_arg_0)
			return rt.new_null()
		}
		'getBit' {
			return this.getbit()
		}
		'getBits' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getbits(dispatch_arg_0)
		}
		'expGolombUe' {
			return rt.new_int(this.expgolombue())
		}
		'expGolombSe' {
			return rt.new_int(this.expgolombse())
		}
		'getWidth' {
			return this.getwidth()
		}
		'getHeight' {
			return this.getheight()
		}
		else {
			return none
		}
	}
}

fn (this &Class_AVCSequenceParameterSetReader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'sps' { return this.sps }
		'start' { return this.start }
		'currentBytes' { return this.currentBytes }
		'currentBits' { return this.currentBits }
		'width' { return this.width }
		'height' { return this.height }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_AVCSequenceParameterSetReader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'sps' {
			this.sps = val
			return true
		}
		'start' {
			this.start = val
			return true
		}
		'currentBytes' {
			this.currentBytes = val
			return true
		}
		'currentBits' {
			this.currentBits = val
			return true
		}
		'width' {
			this.width = val
			return true
		}
		'height' {
			this.height = val
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
