import rt

struct Class_getid3_asf {
	rt.PhpObjectBase
pub mut:
		ASFIndexParametersObjectIndexSpecifiersIndexTypes rt.PhpVal = rt.new_array()
		ASFMediaObjectIndexParametersObjectIndexSpecifiersIndexTypes rt.PhpVal = rt.new_array()
		ASFTimecodeIndexParametersObjectIndexSpecifiersIndexTypes rt.PhpVal = rt.new_array()
}

fn (mut this Class_getid3_asf) construct(mut var_getid3 Class_getID3)  {
	this.Class_getid3_handler.construct(rt.new_object('getID3', []string{}, var_getid3))
	mut var_GUIDarray := this.knownguids()
	{
		mut iter_1 := var_GUIDarray.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_hexstringvalue := item_1.val
			mut var_GUIDname := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [var_GUIDname.dup()]))))) {
				rt.call_function('define', [var_GUIDname.dup(), this.guidtobytestring(var_hexstringvalue.dup())])
			}
		}
	}
}

fn (mut this Class_getid3_asf) analyze() bool {
	mut var_info := map[string]rt.PhpVal{}
	mut var_thisfile_video := map[string]rt.PhpVal{}
	mut var_thisfile_asf := map[string]rt.PhpVal{}
	mut var_thisfile_asf_comments := rt.new_null()
	mut var_thisfile_asf_headerobject := map[string]rt.PhpVal{}
	mut var_thisfile_asf_filepropertiesobject := rt.new_null()
	mut var_thisfile_asf_headerextensionobject := rt.new_null()
	mut var_thisfile_asf_codeclistobject_codecentries_current := rt.new_null()
	mut var_AudioCodecBitrate := rt.new_null()
	mut var_AudioCodecChannels := rt.new_null()
	mut var_thisfile_asf_scriptcommandobject := rt.new_null()
	mut var_thisfile_asf_markerobject := rt.new_null()
	mut var_thisfile_asf_bitratemutualexclusionobject := rt.new_null()
	mut var_thisfile_asf_errorcorrectionobject := rt.new_null()
	mut var_thisfile_asf_contentdescriptionobject := rt.new_null()
	mut var_thisfile_asf_extendedcontentdescriptionobject := rt.new_null()
	mut var_thisfile_asf_extendedcontentdescriptionobject_contentdescriptor_current := rt.new_null()
	mut var_thisfile_asf_paddingobject := rt.new_null()
	mut var_thisfile_asf_videomedia_currentstream := rt.new_null()
	mut var_thisfile_asf_dataobject := rt.new_null()
	mut var_thisfile_asf_simpleindexobject := rt.new_null()
	mut var_thisfile_asf_asfindexobject := rt.new_null()
	// unsupported expression: Expr_AssignRef
	// unsupported expression: Expr_AssignRef
	// unsupported expression: Expr_AssignRef
	var_info['asf'] = rt.new_array()
	// unsupported expression: Expr_AssignRef
	var_thisfile_asf['comments'] = rt.new_array()
	// unsupported expression: Expr_AssignRef
	var_thisfile_asf['header_object'] = rt.new_array()
	// unsupported expression: Expr_AssignRef
	var_info['fileformat'] = rt.new_string('asf')
	this.fseek(var_info.array_get('avdataoffset'))
	mut var_HeaderObjectData := this.fread(rt.new_int(30))
	var_thisfile_asf_headerobject['objectid'] = rt.call_function('substr', [var_HeaderObjectData.dup(), rt.new_int(0), rt.new_int(16)])
	var_thisfile_asf_headerobject['objectid_guid'] = this.bytestringtoguid(var_thisfile_asf_headerobject.array_get('objectid'))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		var_info.delete('fileformat')
		var_info.delete('asf')
		return (this.error(rt.new_string('ASF header GUID {' + this.bytestringtoguid(var_thisfile_asf_headerobject.array_get('objectid')) + '} does not match expected "GETID3_ASF_Header_Object" GUID {' + this.bytestringtoguid(rt.get_constant('GETID3_ASF_Header_Object')) + '}'))).to_bool()
	}
	var_thisfile_asf_headerobject['objectsize'] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_HeaderObjectData.dup(), rt.new_int(16), rt.new_int(8)]))
	var_thisfile_asf_headerobject['headerobjects'] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_HeaderObjectData.dup(), rt.new_int(24), rt.new_int(4)]))
	var_thisfile_asf_headerobject['reserved1'] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_HeaderObjectData.dup(), rt.new_int(28), rt.new_int(1)]))
	var_thisfile_asf_headerobject['reserved2'] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_HeaderObjectData.dup(), rt.new_int(29), rt.new_int(1)]))
	mut var_NextObjectOffset := this.ftell()
	mut var_ASFHeaderData := this.fread(rt.sub(var_thisfile_asf_headerobject.array_get('objectsize'), rt.new_int(30)))
	mut var_offset := rt.new_int(rt.new_int(0))
	mut var_thisfile_asf_streambitratepropertiesobject := rt.new_array()
	mut var_thisfile_asf_codeclistobject := rt.new_array()
	mut var_StreamPropertiesObjectData := rt.new_array()
	{
		mut var_HeaderObjectsCounter := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_HeaderObjectsCounter, var_thisfile_asf_headerobject.array_get('headerobjects')))) { break }
			mut var_NextObjectGUID := rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(16)])
			// unsupported expression: Expr_AssignOp_Plus
			mut var_NextObjectGUIDtext := rt.new_string(this.bytestringtoguid(var_NextObjectGUID.dup()))
			mut var_NextObjectSize := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(8)]))
			// unsupported expression: Expr_AssignOp_Plus
			mut switch_val_1 := var_NextObjectGUID
			if rt.is_true(rt.equal(switch_val_1, rt.get_constant('GETID3_ASF_File_Properties_Object'))) {
				var_thisfile_asf['file_properties_object'] = rt.new_array()
				// unsupported expression: Expr_AssignRef
				var_thisfile_asf_filepropertiesobject.array_set('offset', rt.add(var_NextObjectOffset, var_offset))
				var_thisfile_asf_filepropertiesobject.array_set('objectid', var_NextObjectGUID.dup())
				var_thisfile_asf_filepropertiesobject.array_set('objectid_guid', var_NextObjectGUIDtext.dup())
				var_thisfile_asf_filepropertiesobject.array_set('objectsize', var_NextObjectSize.dup())
				var_thisfile_asf_filepropertiesobject.array_set('fileid', rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(16)]))
				// unsupported expression: Expr_AssignOp_Plus
				var_thisfile_asf_filepropertiesobject.array_set('fileid_guid', this.bytestringtoguid(var_thisfile_asf_filepropertiesobject.array_get('fileid')))
				var_thisfile_asf_filepropertiesobject.array_set('filesize', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(8)])))
				// unsupported expression: Expr_AssignOp_Plus
				var_thisfile_asf_filepropertiesobject.array_set('creation_date', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(8)])))
				var_thisfile_asf_filepropertiesobject.array_set('creation_date_unix', this.filetimetounixtime(var_thisfile_asf_filepropertiesobject.array_get('creation_date'), false))
				// unsupported expression: Expr_AssignOp_Plus
				var_thisfile_asf_filepropertiesobject.array_set('data_packets', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(8)])))
				// unsupported expression: Expr_AssignOp_Plus
				var_thisfile_asf_filepropertiesobject.array_set('play_duration', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(8)])))
				// unsupported expression: Expr_AssignOp_Plus
				var_thisfile_asf_filepropertiesobject.array_set('send_duration', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(8)])))
				// unsupported expression: Expr_AssignOp_Plus
				var_thisfile_asf_filepropertiesobject.array_set('preroll', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(8)])))
				// unsupported expression: Expr_AssignOp_Plus
				var_thisfile_asf_filepropertiesobject.array_set('flags_raw', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(4)])))
				// unsupported expression: Expr_AssignOp_Plus
				var_thisfile_asf_filepropertiesobject.array_get_mut('flags').array_set('broadcast', // unsupported expression: Expr_Cast_Bool)
				var_thisfile_asf_filepropertiesobject.array_get_mut('flags').array_set('seekable', // unsupported expression: Expr_Cast_Bool)
				var_thisfile_asf_filepropertiesobject.array_set('min_packet_size', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(4)])))
				// unsupported expression: Expr_AssignOp_Plus
				var_thisfile_asf_filepropertiesobject.array_set('max_packet_size', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(4)])))
				// unsupported expression: Expr_AssignOp_Plus
				var_thisfile_asf_filepropertiesobject.array_set('max_bitrate', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(4)])))
				// unsupported expression: Expr_AssignOp_Plus
				if rt.is_true(var_thisfile_asf_filepropertiesobject.array_get('flags').array_get('broadcast')) {
					var_thisfile_asf_filepropertiesobject.array_unset(rt.new_string('filesize'))
					var_thisfile_asf_filepropertiesobject.array_unset(rt.new_string('data_packets'))
					var_thisfile_asf_filepropertiesobject.array_unset(rt.new_string('play_duration'))
					var_thisfile_asf_filepropertiesobject.array_unset(rt.new_string('send_duration'))
					var_thisfile_asf_filepropertiesobject.array_unset(rt.new_string('min_packet_size'))
					var_thisfile_asf_filepropertiesobject.array_unset(rt.new_string('max_packet_size'))
				} else {
					var_info['playtime_seconds'] = rt.sub(rt.div(var_thisfile_asf_filepropertiesobject.array_get('play_duration'), rt.new_int(10000000)), rt.div(var_thisfile_asf_filepropertiesobject.array_get('preroll'), rt.new_int(1000)))
					var_info['bitrate'] = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.safediv(arg_0, arg_1) }(rt.mul(var_thisfile_asf_filepropertiesobject.array_get('filesize'), rt.new_int(8)), var_info.array_get('playtime_seconds'))
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.get_constant('GETID3_ASF_Stream_Properties_Object'))) {
				var_StreamPropertiesObjectData.array_set('offset', rt.add(var_NextObjectOffset, var_offset))
				var_StreamPropertiesObjectData.array_set('objectid', var_NextObjectGUID.dup())
				var_StreamPropertiesObjectData.array_set('objectid_guid', var_NextObjectGUIDtext.dup())
				var_StreamPropertiesObjectData.array_set('objectsize', var_NextObjectSize.dup())
				var_StreamPropertiesObjectData.array_set('stream_type', rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(16)]))
				// unsupported expression: Expr_AssignOp_Plus
				var_StreamPropertiesObjectData.array_set('stream_type_guid', this.bytestringtoguid(var_StreamPropertiesObjectData.array_get('stream_type')))
				var_StreamPropertiesObjectData.array_set('error_correct_type', rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(16)]))
				// unsupported expression: Expr_AssignOp_Plus
				var_StreamPropertiesObjectData.array_set('error_correct_guid', this.bytestringtoguid(var_StreamPropertiesObjectData.array_get('error_correct_type')))
				var_StreamPropertiesObjectData.array_set('time_offset', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(8)])))
				// unsupported expression: Expr_AssignOp_Plus
				var_StreamPropertiesObjectData.array_set('type_data_length', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(4)])))
				// unsupported expression: Expr_AssignOp_Plus
				var_StreamPropertiesObjectData.array_set('error_data_length', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [var_ASFHeaderData.dup(), var_offset.dup(), rt.new_int(4)])))
				// unsupported expression: Expr_AssignOp_Plus
				var_StreamPropertiesObjectData.array_set('flags_raw', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.littleendian2int(arg_0) }(rt.call_function('substr', [.dup(), .dup(), ])))
				// unsupported expression: Expr_AssignOp_Plus
				mut var_StreamPropertiesObjectStreamNumber := rt.new_int()
				
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) {
			} else {
			}
			
		}
	}
}

fn Class_getid3_asf.codeclistobjecttypelookup(var_CodecListType rt.PhpVal) rt.PhpVal {
	mut var_lookup := rt.new_null()
}

fn Class_getid3_asf.knownguids() rt.PhpVal {
	mut var_GUIDarray := rt.new_null()
}

fn Class_getid3_asf.guidname(var_GUIDstring rt.PhpVal) rt.PhpVal {
	mut var_GUIDstring_mutated := var_GUIDstring
}

fn Class_getid3_asf.asfindexobjectindextypelookup(var_id rt.PhpVal) string {
	mut var_ASFIndexObjectIndexTypeLookup := []rt.PhpVal{}
}

fn Class_getid3_asf.guidtobytestring(var_GUIDstring rt.PhpVal) rt.PhpVal {
	mut var_GUIDstring_mutated := var_GUIDstring
}

fn Class_getid3_asf.bytestringtoguid(var_Bytestring rt.PhpVal) string {
}

fn Class_getid3_asf.filetimetounixtime(var_FILETIME rt.PhpVal, round bool) i64 {
}

fn Class_getid3_asf.wmpicturetypelookup(var_WMpictureType rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_getid3_asf) headerextensionobjectdataparse(var_asf_header_extension_object_data rt.PhpVal, var_unhandled_sections rt.PhpVal) rt.PhpVal {
	mut var_unhandled_sections_mutated := var_unhandled_sections
}

fn Class_getid3_asf.metadatalibraryobjectdatatypelookup(var_id rt.PhpVal) rt.PhpVal {
	mut var_lookup := rt.new_null()
}

fn (mut this Class_getid3_asf) asf_wmpicture(var_data rt.PhpVal) rt.PhpVal {
}

fn Class_getid3_asf.trimconvert(var_string rt.PhpVal) string {
	mut var_string_mutated := var_string
}

fn Class_getid3_asf.trimterm(var_string rt.PhpVal) rt.PhpVal {
	mut var_string_mutated := var_string
}

struct Class_getid3_lib {
	rt.PhpObjectBase
}

struct Class_getid3_handler {
	rt.PhpObjectBase
}

fn create_getid3_asf(arg_0 rt.PhpVal) &Class_getid3_asf {
	mut obj := &Class_getid3_asf{
		PhpObjectBase: rt.PhpObjectBase{}
		ASFIndexParametersObjectIndexSpecifiersIndexTypes: rt.new_array()
		ASFMediaObjectIndexParametersObjectIndexSpecifiersIndexTypes: rt.new_array()
		ASFTimecodeIndexParametersObjectIndexSpecifiersIndexTypes: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_getid3_lib() &Class_getid3_lib {
	mut obj := &Class_getid3_lib{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_getid3_handler() &Class_getid3_handler {
	mut obj := &Class_getid3_handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_getid3_asf) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_getID3](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'Analyze' {
			return rt.new_bool(this.analyze())
		}
		'codecListObjectTypeLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_asf.codeclistobjecttypelookup(dispatch_arg_0)
		}
		'KnownGUIDs' {
			return Class_getid3_asf.knownguids()
		}
		'GUIDname' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_asf.guidname(dispatch_arg_0)
		}
		'ASFIndexObjectIndexTypeLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_getid3_asf.asfindexobjectindextypelookup(dispatch_arg_0))
		}
		'GUIDtoBytestring' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_asf.guidtobytestring(dispatch_arg_0)
		}
		'BytestringToGUID' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_getid3_asf.bytestringtoguid(dispatch_arg_0))
		}
		'FILETIMEtoUNIXtime' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_int(Class_getid3_asf.filetimetounixtime(dispatch_arg_0, dispatch_arg_1))
		}
		'WMpictureTypeLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_asf.wmpicturetypelookup(dispatch_arg_0)
		}
		'HeaderExtensionObjectDataParse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.headerextensionobjectdataparse(dispatch_arg_0, dispatch_arg_1)
		}
		'metadataLibraryObjectDataTypeLookup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_asf.metadatalibraryobjectdatatypelookup(dispatch_arg_0)
		}
		'ASF_WMpicture' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.asf_wmpicture(dispatch_arg_0)
		}
		'TrimConvert' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_getid3_asf.trimconvert(dispatch_arg_0))
		}
		'TrimTerm' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_getid3_asf.trimterm(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_getid3_asf) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'ASFIndexParametersObjectIndexSpecifiersIndexTypes' { return this.ASFIndexParametersObjectIndexSpecifiersIndexTypes }
		'ASFMediaObjectIndexParametersObjectIndexSpecifiersIndexTypes' { return this.ASFMediaObjectIndexParametersObjectIndexSpecifiersIndexTypes }
		'ASFTimecodeIndexParametersObjectIndexSpecifiersIndexTypes' { return this.ASFTimecodeIndexParametersObjectIndexSpecifiersIndexTypes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_getid3_asf) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'ASFIndexParametersObjectIndexSpecifiersIndexTypes' { this.ASFIndexParametersObjectIndexSpecifiersIndexTypes = val; return true }
		'ASFMediaObjectIndexParametersObjectIndexSpecifiersIndexTypes' { this.ASFMediaObjectIndexParametersObjectIndexSpecifiersIndexTypes = val; return true }
		'ASFTimecodeIndexParametersObjectIndexSpecifiersIndexTypes' { this.ASFTimecodeIndexParametersObjectIndexSpecifiersIndexTypes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_getid3_handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_getid3_handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_getid3_handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_id3_module_audio_video_asf_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_INCLUDEPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_getid3_lib{}; return temp.includedependency(arg_0, arg_1, arg_2) }(rt.new_string((rt.get_constant('GETID3_INCLUDEPATH')).str() + 'module.audio-video.riff.php'), rt.new_string(@FILE), rt.new_bool(true))
}
