import rt

const global_const_ebml_id_chapters = 4433776
const global_const_ebml_id_seekhead = 21863284
const global_const_ebml_id_tags = 39109479
const global_const_ebml_id_info = 88713574
const global_const_ebml_id_tracks = 106212971
const global_const_ebml_id_segment = 139690087
const global_const_ebml_id_attachments = 155296873
const global_const_ebml_id_ebml = 172351395
const global_const_ebml_id_cues = 206814059
const global_const_ebml_id_cluster = 256095861
const global_const_ebml_id_language = 177564
const global_const_ebml_id_tracktimecodescale = 209231
const global_const_ebml_id_defaultduration = 254851
const global_const_ebml_id_codecname = 362120
const global_const_ebml_id_codecdownloadurl = 438848
const global_const_ebml_id_timecodescale = 710577
const global_const_ebml_id_colourspace = 963876
const global_const_ebml_id_gammavalue = 1029411
const global_const_ebml_id_codecsettings = 1742487
const global_const_ebml_id_codecinfourl = 1785920
const global_const_ebml_id_prevfilename = 1868715
const global_const_ebml_id_prevuid = 1882403
const global_const_ebml_id_nextfilename = 1999803
const global_const_ebml_id_nextuid = 2013475
const global_const_ebml_id_contentcompalgo = 596
const global_const_ebml_id_contentcompsettings = 597
const global_const_ebml_id_doctype = 642
const global_const_ebml_id_doctypereadversion = 645
const global_const_ebml_id_ebmlversion = 646
const global_const_ebml_id_doctypeversion = 647
const global_const_ebml_id_ebmlmaxidlength = 754
const global_const_ebml_id_ebmlmaxsizelength = 755
const global_const_ebml_id_ebmlreadversion = 759
const global_const_ebml_id_chaplanguage = 892
const global_const_ebml_id_chapcountry = 894
const global_const_ebml_id_segmentfamily = 1092
const global_const_ebml_id_dateutc = 1121
const global_const_ebml_id_taglanguage = 1146
const global_const_ebml_id_tagdefault = 1156
const global_const_ebml_id_tagbinary = 1157
const global_const_ebml_id_tagstring = 1159
const global_const_ebml_id_duration = 1161
const global_const_ebml_id_chapprocessprivate = 1293
const global_const_ebml_id_chapterflagenabled = 1432
const global_const_ebml_id_tagname = 1443
const global_const_ebml_id_editionentry = 1465
const global_const_ebml_id_editionuid = 1468
const global_const_ebml_id_editionflaghidden = 1469
const global_const_ebml_id_editionflagdefault = 1499
const global_const_ebml_id_editionflagordered = 1501
const global_const_ebml_id_filedata = 1628
const global_const_ebml_id_filemimetype = 1632
const global_const_ebml_id_filename = 1646
const global_const_ebml_id_filereferral = 1653
const global_const_ebml_id_filedescription = 1662
const global_const_ebml_id_fileuid = 1710
const global_const_ebml_id_contentencalgo = 2017
const global_const_ebml_id_contentenckeyid = 2018
const global_const_ebml_id_contentsignature = 2019
const global_const_ebml_id_contentsigkeyid = 2020
const global_const_ebml_id_contentsigalgo = 2021
const global_const_ebml_id_contentsighashalgo = 2022
const global_const_ebml_id_muxingapp = 3456
const global_const_ebml_id_seek = 3515
const global_const_ebml_id_contentencodingorder = 4145
const global_const_ebml_id_contentencodingscope = 4146
const global_const_ebml_id_contentencodingtype = 4147
const global_const_ebml_id_contentcompression = 4148
const global_const_ebml_id_contentencryption = 4149
const global_const_ebml_id_cuerefnumber = 4959
const global_const_ebml_id_name = 4974
const global_const_ebml_id_cueblocknumber = 4984
const global_const_ebml_id_trackoffset = 4991
const global_const_ebml_id_seekid = 5035
const global_const_ebml_id_seekposition = 5036
const global_const_ebml_id_stereomode = 5048
const global_const_ebml_id_oldstereomode = 5049
const global_const_ebml_id_pixelcropbottom = 5290
const global_const_ebml_id_displaywidth = 5296
const global_const_ebml_id_displayunit = 5298
const global_const_ebml_id_aspectratiotype = 5299
const global_const_ebml_id_displayheight = 5306
const global_const_ebml_id_pixelcroptop = 5307
const global_const_ebml_id_pixelcropleft = 5324
const global_const_ebml_id_pixelcropright = 5341
const global_const_ebml_id_flagforced = 5546
const global_const_ebml_id_maxblockadditionid = 5614
const global_const_ebml_id_writingapp = 5953
const global_const_ebml_id_clustersilenttracks = 6228
const global_const_ebml_id_clustersilenttracknumber = 6359
const global_const_ebml_id_attachedfile = 8615
const global_const_ebml_id_contentencoding = 8768
const global_const_ebml_id_bitdepth = 8804
const global_const_ebml_id_codecprivate = 9122
const global_const_ebml_id_targets = 9152
const global_const_ebml_id_chapterphysicalequiv = 9155
const global_const_ebml_id_tagchapteruid = 9156
const global_const_ebml_id_tagtrackuid = 9157
const global_const_ebml_id_tagattachmentuid = 
fn create_getid3_matroska() &Class_getid3_matroska {
	mut obj := &Class_getid3_matroska{
		PhpObjectBase: rt.PhpObjectBase{}
		hide_clusters: rt.new_bool(true)
		parse_whole_file: rt.new_bool(false)
		EBMLbuffer: rt.new_string('')
		EBMLbuffer_offset: rt.new_int(0)
		EBMLbuffer_length: rt.new_int(0)
		current_offset: rt.new_int(0)
		unuseful_elements: rt.new_array()
		scan_mode: rt.new_null()
	}
	return obj
}

fn (mut this Class_getid3_matroska) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_getid3_matroska) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.Class_getid3_handler.dispatch_get_prop(prop_name)
}

fn (mut this Class_getid3_matroska) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.Class_getid3_handler.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('getid3_matroska', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_getid3_matroska()
		return rt.new_object('getid3_matroska', ['getid3_handler'], obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_id3_module_audio_video_matroska_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('GETID3_INCLUDEPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
