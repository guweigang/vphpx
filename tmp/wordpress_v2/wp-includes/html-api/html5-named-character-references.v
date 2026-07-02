import rt

struct Class_WP_Token_Map {
	rt.PhpObjectBase
}

fn create_wp_token_map(_args ...rt.PhpVal) &Class_WP_Token_Map {
	mut iife_temp_0 := Class_WP_Token_Map{}
	mut iife_result_0 := iife_temp_0.from_precomputed_table(rt.create_array([
		rt.ArrayItem{ key: 'storage_version', val: '6.6.0-trunk' },
		rt.ArrayItem{ key: 'key_length', val: 2 },
		rt.ArrayItem{ key: 'groups', val: 'AE' },
		rt.ArrayItem{ key: 'large_words', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'lig;ÆligÆ' },
			rt.ArrayItem{ key: none, val: 'P;\\&\\P\\&' },
			rt.ArrayItem{ key: none, val: 'cute;ÁcuteÁ' },
			rt.ArrayItem{ key: none, val: 'reve;Ă' },
			rt.ArrayItem{ key: none, val: 'irc;ÂircÂy;А' },
			rt.ArrayItem{ key: none, val: 'r;𝔄' },
			rt.ArrayItem{ key: none, val: 'rave;ÀraveÀ' },
			rt.ArrayItem{ key: none, val: 'pha;Α' },
			rt.ArrayItem{ key: none, val: 'acr;Ā' },
			rt.ArrayItem{ key: none, val: 'd;⩓' },
			rt.ArrayItem{ key: none, val: 'gon;Ąpf;𝔸' },
			rt.ArrayItem{ key: none, val: 'plyFunction;⁡' },
			rt.ArrayItem{ key: none, val: 'ing;ÅingÅ' },
			rt.ArrayItem{ key: none, val: 'sign;≔cr;𝒜' },
			rt.ArrayItem{ key: none, val: 'ilde;ÃildeÃ' },
			rt.ArrayItem{ key: none, val: 'ml;ÄmlÄ' },
			rt.ArrayItem{ key: none, val: 'ckslash;∖rwed;⌆rv;⫧' },
			rt.ArrayItem{ key: none, val: 'y;Б' },
			rt.ArrayItem{ key: none, val: '\trnoullis;ℬcause;∵ta;Β' },
			rt.ArrayItem{ key: none, val: 'r;𝔅' },
			rt.ArrayItem{ key: none, val: 'pf;𝔹' },
			rt.ArrayItem{ key: none, val: 'eve;˘' },
			rt.ArrayItem{ key: none, val: 'cr;ℬ' },
			rt.ArrayItem{ key: none, val: 'mpeq;≎' },
			rt.ArrayItem{ key: none, val: 'cy;Ч' },
			rt.ArrayItem{ key: none, val: 'PY;©PY©' },
			rt.ArrayItem{ key: none, val: 'pitalDifferentialD;ⅅyleys;ℭcute;Ćp;⋒' },
			rt.ArrayItem{ key: none, val: 'onint;∰aron;Čedil;ÇedilÇirc;Ĉ' },
			rt.ArrayItem{ key: none, val: 'ot;Ċ' },
			rt.ArrayItem{ key: none, val: 'nterDot;·dilla;¸' },
			rt.ArrayItem{ key: none, val: 'r;ℭ' },
			rt.ArrayItem{ key: none, val: 'i;Χ' },
			rt.ArrayItem{
				key: none
				val: '\nrcleMinus;⊖\nrcleTimes;⊗\trclePlus;⊕rcleDot;⊙'
			},
			rt.ArrayItem{
				key: none
				val: 'ockwiseContourIntegral;∲oseCurlyDoubleQuote;”oseCurlyQuote;’'
			},
			rt.ArrayItem{
				key: none
				val: 'unterClockwiseContourIntegral;∳ntourIntegral;∮ngruent;≡product;∐lone;⩴nint;∯lon;∷pf;ℂ'
			},
			rt.ArrayItem{ key: none, val: 'oss;⨯' },
			rt.ArrayItem{ key: none, val: 'cr;𝒞' },
			rt.ArrayItem{ key: none, val: 'pCap;≍p;⋓' },
			rt.ArrayItem{ key: none, val: 'otrahd;⤑\\;ⅅ' },
			rt.ArrayItem{ key: none, val: 'cy;Ђ' },
			rt.ArrayItem{ key: none, val: 'cy;Ѕ' },
			rt.ArrayItem{ key: none, val: 'cy;Џ' },
			rt.ArrayItem{ key: none, val: 'gger;‡shv;⫤rr;↡' },
			rt.ArrayItem{ key: none, val: 'aron;Ďy;Д' },
			rt.ArrayItem{ key: none, val: 'lta;Δl;∇' },
			rt.ArrayItem{ key: none, val: 'r;𝔇' },
			rt.ArrayItem{
				key: none
				val: 'acriticalDoubleAcute;˝acriticalAcute;´acriticalGrave;\\`acriticalTilde;˜\racriticalDot;˙fferentialD;ⅆamond;⋄'
			},
			rt.ArrayItem{
				key: none
				val: 'ubleLongLeftRightArrow;⟺ubleContourIntegral;∯ubleLeftRightArrow;⇔ubleLongRightArrow;⟹ubleLongLeftArrow;⟸wnLeftRightVector;⥐wnRightTeeVector;⥟wnRightVectorBar;⥗ubleUpDownArrow;⇕ubleVerticalBar;∥wnLeftTeeVector;⥞wnLeftVectorBar;⥖ubleRightArrow;⇒wnArrowUpArrow;⇵ubleDownArrow;⇓ubleLeftArrow;⇐wnRightVector;⇁\rubleRightTee;⊨\rwnLeftVector;↽ubleLeftTee;⫤ubleUpArrow;⇑wnArrowBar;⤓wnTeeArrow;↧ubleDot;¨wnArrow;↓wnBreve;̑wnarrow;⇓tEqual;≐wnTee;⊤tDot;⃜pf;𝔻t;¨'
			},
			rt.ArrayItem{ key: none, val: 'trok;Đcr;𝒟' },
			rt.ArrayItem{ key: none, val: 'G;Ŋ' },
			rt.ArrayItem{ key: none, val: 'H;Ð\\HÐ' },
			rt.ArrayItem{ key: none, val: 'cute;ÉcuteÉ' },
			rt.ArrayItem{ key: none, val: 'aron;Ěirc;ÊircÊy;Э' },
			rt.ArrayItem{ key: none, val: 'ot;Ė' },
			rt.ArrayItem{ key: none, val: 'r;𝔈' },
			rt.ArrayItem{ key: none, val: 'rave;ÈraveÈ' },
			rt.ArrayItem{ key: none, val: 'ement;∈' },
			rt.ArrayItem{ key: none, val: 'ptyVerySmallSquare;▫ptySmallSquare;◻acr;Ē' },
			rt.ArrayItem{ key: none, val: 'gon;Ępf;𝔼' },
			rt.ArrayItem{ key: none, val: 'silon;Ε' },
			rt.ArrayItem{ key: none, val: '\nuilibrium;⇌\tualTilde;≂ual;⩵' },
			rt.ArrayItem{ key: none, val: 'cr;ℰim;⩳' },
			rt.ArrayItem{ key: none, val: 'a;Η' },
			rt.ArrayItem{ key: none, val: 'ml;ËmlË' },
			rt.ArrayItem{ key: none, val: 'ponentialE;ⅇists;∃' },
			rt.ArrayItem{ key: none, val: 'y;Ф' },
			rt.ArrayItem{ key: none, val: 'r;𝔉' },
			rt.ArrayItem{ key: none, val: 'lledVerySmallSquare;▪lledSmallSquare;◼' },
			rt.ArrayItem{ key: none, val: '\turiertrf;ℱrAll;∀pf;𝔽' },
			rt.ArrayItem{ key: none, val: 'cr;ℱ' },
			rt.ArrayItem{ key: none, val: 'cy;Ѓ' },
			rt.ArrayItem{ key: none, val: '\\;\\>' },
			rt.ArrayItem{ key: none, val: 'mmad;Ϝmma;Γ' },
			rt.ArrayItem{ key: none, val: 'reve;Ğ' },
			rt.ArrayItem{ key: none, val: 'edil;Ģirc;Ĝy;Г' },
			rt.ArrayItem{ key: none, val: 'ot;Ġ' },
			rt.ArrayItem{ key: none, val: 'r;𝔊' },
			rt.ArrayItem{ key: none, val: '\\;⋙' },
			rt.ArrayItem{ key: none, val: 'pf;𝔾' },
			rt.ArrayItem{
				key: none
				val: 'eaterSlantEqual;⩾eaterEqualLess;⋛eaterFullEqual;≧\reaterGreater;⪢eaterEqual;≥eaterTilde;≳\neaterLess;≷'
			},
			rt.ArrayItem{ key: none, val: 'cr;𝒢' },
			rt.ArrayItem{ key: none, val: '\\;≫' },
			rt.ArrayItem{ key: none, val: 'RDcy;Ъ' },
			rt.ArrayItem{ key: none, val: 'cek;ˇt;\\^' },
			rt.ArrayItem{ key: none, val: 'irc;Ĥ' },
			rt.ArrayItem{ key: none, val: 'r;ℌ' },
			rt.ArrayItem{ key: none, val: 'lbertSpace;ℋ' },
			rt.ArrayItem{ key: none, val: '\rrizontalLine;─pf;ℍ' },
			rt.ArrayItem{ key: none, val: 'trok;Ħcr;ℋ' },
			rt.ArrayItem{ key: none, val: 'mpDownHump;≎mpEqual;≏' },
			rt.ArrayItem{ key: none, val: 'cy;Е' },
			rt.ArrayItem{ key: none, val: 'lig;Ĳ' },
			rt.ArrayItem{ key: none, val: 'cy;Ё' },
			rt.ArrayItem{ key: none, val: 'cute;ÍcuteÍ' },
			rt.ArrayItem{ key: none, val: 'irc;ÎircÎy;И' },
			rt.ArrayItem{ key: none, val: 'ot;İ' },
			rt.ArrayItem{ key: none, val: 'r;ℑ' },
			rt.ArrayItem{ key: none, val: 'rave;ÌraveÌ' },
			rt.ArrayItem{ key: none, val: '\taginaryI;ⅈplies;⇒acr;Ī\\;ℑ' },
			rt.ArrayItem{
				key: none
				val: '\rvisibleComma;⁣\rvisibleTimes;⁢tersection;⋂tegral;∫t;∬'
			},
			rt.ArrayItem{ key: none, val: 'gon;Įpf;𝕀ta;Ι' },
			rt.ArrayItem{ key: none, val: 'cr;ℐ' },
			rt.ArrayItem{ key: none, val: 'ilde;Ĩ' },
			rt.ArrayItem{ key: none, val: 'kcy;Іml;ÏmlÏ' },
			rt.ArrayItem{ key: none, val: 'irc;Ĵy;Й' },
			rt.ArrayItem{ key: none, val: 'r;𝔍' },
			rt.ArrayItem{ key: none, val: 'pf;𝕁' },
			rt.ArrayItem{ key: none, val: 'ercy;Јcr;𝒥' },
			rt.ArrayItem{ key: none, val: 'kcy;Є' },
			rt.ArrayItem{ key: none, val: 'cy;Х' },
			rt.ArrayItem{ key: none, val: 'cy;Ќ' },
			rt.ArrayItem{ key: none, val: 'ppa;Κ' },
			rt.ArrayItem{ key: none, val: 'edil;Ķy;К' },
			rt.ArrayItem{ key: none, val: 'r;𝔎' },
			rt.ArrayItem{ key: none, val: 'pf;𝕂' },
			rt.ArrayItem{ key: none, val: 'cr;𝒦' },
			rt.ArrayItem{ key: none, val: 'cy;Љ' },
			rt.ArrayItem{ key: none, val: '\\;\\<' },
			rt.ArrayItem{ key: none, val: '\tplacetrf;ℒcute;Ĺmbda;Λng;⟪rr;↞' },
			rt.ArrayItem{ key: none, val: 'aron;Ľedil;Ļy;Л' },
			rt.ArrayItem{
				key: none
				val: 'ftArrowRightArrow;⇆ftDoubleBracket;⟦ftDownTeeVector;⥡ftDownVectorBar;⥙ftTriangleEqual;⊴ftAngleBracket;⟨ftUpDownVector;⥑ssEqualGreater;⋚ftRightVector;⥎ftTriangleBar;⧏ftUpTeeVector;⥠ftUpVectorBar;⥘\rftDownVector;⇃\rftRightArrow;↔\rftrightarrow;⇔\rssSlantEqual;⩽ftTeeVector;⥚ftVectorBar;⥒ssFullEqual;≦ftArrowBar;⇤ftTeeArrow;↤ftTriangle;⊲ftUpVector;↿\nftCeiling;⌈\nssGreater;≶\tftVector;↼ftArrow;←ftFloor;⌊ftarrow;⇐ssTilde;≲ssLess;⪡ftTee;⊣'
			},
			rt.ArrayItem{ key: none, val: 'r;𝔏' },
			rt.ArrayItem{ key: none, val: '\teftarrow;⇚\\;⋘' },
			rt.ArrayItem{ key: none, val: 'idot;Ŀ' },
			rt.ArrayItem{
				key: none
				val: 'ngLeftRightArrow;⟷ngleftrightarrow;⟺werRightArrow;↘\rngRightArrow;⟶\rngrightarrow;⟹\rwerLeftArrow;↙ngLeftArrow;⟵ngleftarrow;⟸pf;𝕃'
			},
			rt.ArrayItem{ key: none, val: 'trok;Łcr;ℒh;↰' },
			rt.ArrayItem{ key: none, val: '\\;≪' },
			rt.ArrayItem{ key: none, val: 'p;⤅' },
			rt.ArrayItem{ key: none, val: 'y;М' },
			rt.ArrayItem{ key: none, val: '\ndiumSpace; llintrf;ℳ' },
			rt.ArrayItem{ key: none, val: 'r;𝔐' },
			rt.ArrayItem{ key: none, val: 'nusPlus;∓' },
			rt.ArrayItem{ key: none, val: 'pf;𝕄' },
			rt.ArrayItem{ key: none, val: 'cr;ℳ' },
			rt.ArrayItem{ key: none, val: '\\;Μ' },
			rt.ArrayItem{ key: none, val: 'cy;Њ' },
			rt.ArrayItem{ key: none, val: 'cute;Ń' },
			rt.ArrayItem{ key: none, val: 'aron;Ňedil;Ņy;Н' },
			rt.ArrayItem{
				key: none
				val: 'gativeVeryThinSpace;​stedGreaterGreater;≫gativeMediumSpace;​gativeThickSpace;​gativeThinSpace;​\rstedLessLess;≪wLine;\\\n'
			},
			rt.ArrayItem{ key: none, val: 'r;𝔑' },
			rt.ArrayItem{
				key: none
				val: 'tNestedGreaterGreater;⪢̸tSquareSupersetEqual;⋣tPrecedesSlantEqual;⋠tRightTriangleEqual;⋭tSucceedsSlantEqual;⋡tDoubleVerticalBar;∦tGreaterSlantEqual;⩾̸tLeftTriangleEqual;⋬tSquareSubsetEqual;⋢tGreaterFullEqual;≧̸tRightTriangleBar;⧐̸tLeftTriangleBar;⧏̸tGreaterGreater;≫̸tLessSlantEqual;⩽̸tNestedLessLess;⪡̸tReverseElement;∌tSquareSuperset;⊐̸tTildeFullEqual;≇nBreakingSpace; tPrecedesEqual;⪯̸tRightTriangle;⋫tSucceedsEqual;⪰̸tSucceedsTilde;≿̸tSupersetEqual;⊉tGreaterEqual;≱tGreaterTilde;≵tHumpDownHump;≎̸tLeftTriangle;⋪tSquareSubset;⊏̸\rtGreaterLess;≹\rtLessGreater;≸\rtSubsetEqual;⊈\rtVerticalBar;∤tEqualTilde;≂̸tTildeEqual;≄tTildeTilde;≉tCongruent;≢tHumpEqual;≏̸tLessEqual;≰tLessTilde;≴\ntLessLess;≪̸\ntPrecedes;⊀\ntSucceeds;⊁\ntSuperset;⊃⃒\ttElement;∉\ttGreater;≯tCupCap;≭tExists;∄tSubset;⊂⃒tEqual;≠tTilde;≁Break;⁠tLess;≮pf;ℕt;⫬'
			},
			rt.ArrayItem{ key: none, val: 'cr;𝒩' },
			rt.ArrayItem{ key: none, val: 'ilde;ÑildeÑ' },
			rt.ArrayItem{ key: none, val: '\\;Ν' },
			rt.ArrayItem{ key: none, val: 'lig;Œ' },
			rt.ArrayItem{ key: none, val: 'cute;ÓcuteÓ' },
			rt.ArrayItem{ key: none, val: 'irc;ÔircÔy;О' },
			rt.ArrayItem{ key: none, val: 'blac;Ő' },
			rt.ArrayItem{ key: none, val: 'r;𝔒' },
			rt.ArrayItem{ key: none, val: 'rave;ÒraveÒ' },
			rt.ArrayItem{ key: none, val: 'icron;Οacr;Ōega;Ω' },
			rt.ArrayItem{ key: none, val: 'pf;𝕆' },
			rt.ArrayItem{ key: none, val: 'enCurlyDoubleQuote;“\renCurlyQuote;‘' },
			rt.ArrayItem{ key: none, val: '\\;⩔' },
			rt.ArrayItem{ key: none, val: 'lash;ØlashØcr;𝒪' },
			rt.ArrayItem{ key: none, val: 'ilde;Õimes;⨷ildeÕ' },
			rt.ArrayItem{ key: none, val: 'ml;ÖmlÖ' },
			rt.ArrayItem{
				key: none
				val: 'erParenthesis;⏜\nerBracket;⎴erBrace;⏞erBar;‾'
			},
			rt.ArrayItem{ key: none, val: 'rtialD;∂' },
			rt.ArrayItem{ key: none, val: 'y;П' },
			rt.ArrayItem{ key: none, val: 'r;𝔓' },
			rt.ArrayItem{ key: none, val: 'i;Φ' },
			rt.ArrayItem{ key: none, val: '\\;Π' },
			rt.ArrayItem{ key: none, val: 'usMinus;±' },
			rt.ArrayItem{ key: none, val: 'incareplane;ℌpf;ℙ' },
			rt.ArrayItem{
				key: none
				val: 'ecedesSlantEqual;≼ecedesEqual;⪯ecedesTilde;≾oportional;∝\toportion;∷ecedes;≺oduct;∏ime;″\\;⪻'
			},
			rt.ArrayItem{ key: none, val: 'cr;𝒫i;Ψ' },
			rt.ArrayItem{ key: none, val: 'OT;\\"OT\\"' },
			rt.ArrayItem{ key: none, val: 'r;𝔔' },
			rt.ArrayItem{ key: none, val: 'pf;ℚ' },
			rt.ArrayItem{ key: none, val: 'cr;𝒬' },
			rt.ArrayItem{ key: none, val: 'arr;⤐' },
			rt.ArrayItem{ key: none, val: 'G;®\\G®' },
			rt.ArrayItem{ key: none, val: 'cute;Ŕrrtl;⤖ng;⟫rr;↠' },
			rt.ArrayItem{ key: none, val: 'aron;Ředil;Ŗy;Р' },
			rt.ArrayItem{
				key: none
				val: 'verseUpEquilibrium;⥯verseEquilibrium;⇋\rverseElement;∋\\;ℜ'
			},
			rt.ArrayItem{ key: none, val: 'r;ℜ' },
			rt.ArrayItem{ key: none, val: 'o;Ρ' },
			rt.ArrayItem{
				key: none
				val: 'ghtArrowLeftArrow;⇄ghtDoubleBracket;⟧ghtDownTeeVector;⥝ghtDownVectorBar;⥕ghtTriangleEqual;⊵ghtAngleBracket;⟩ghtUpDownVector;⥏ghtTriangleBar;⧐ghtUpTeeVector;⥜ghtUpVectorBar;⥔ghtDownVector;⇂\rghtTeeVector;⥛\rghtVectorBar;⥓ghtArrowBar;⇥ghtTeeArrow;↦ghtTriangle;⊳ghtUpVector;↾ghtCeiling;⌉\nghtVector;⇀\tghtArrow;→\tghtFloor;⌋\tghtarrow;⇒ghtTee;⊢'
			},
			rt.ArrayItem{ key: none, val: 'undImplies;⥰pf;ℝ' },
			rt.ArrayItem{ key: none, val: '\nightarrow;⇛' },
			rt.ArrayItem{ key: none, val: 'cr;ℛh;↱' },
			rt.ArrayItem{ key: none, val: '\nleDelayed;⧴' },
			rt.ArrayItem{ key: none, val: 'CHcy;Щcy;Ш' },
			rt.ArrayItem{ key: none, val: 'FTcy;Ь' },
			rt.ArrayItem{ key: none, val: 'cute;Ś' },
			rt.ArrayItem{ key: none, val: 'aron;Šedil;Şirc;Ŝy;С\\;⪼' },
			rt.ArrayItem{ key: none, val: 'r;𝔖' },
			rt.ArrayItem{
				key: none
				val: 'ortRightArrow;→\rortDownArrow;↓\rortLeftArrow;←ortUpArrow;↑'
			},
			rt.ArrayItem{ key: none, val: 'gma;Σ' },
			rt.ArrayItem{ key: none, val: '\nallCircle;∘' },
			rt.ArrayItem{ key: none, val: 'pf;𝕊' },
			rt.ArrayItem{
				key: none
				val: 'uareSupersetEqual;⊒uareIntersection;⊓uareSubsetEqual;⊑\ruareSuperset;⊐uareSubset;⊏\nuareUnion;⊔uare;□rt;√'
			},
			rt.ArrayItem{ key: none, val: 'cr;𝒮' },
			rt.ArrayItem{ key: none, val: 'ar;⋆' },
			rt.ArrayItem{
				key: none
				val: 'cceedsSlantEqual;≽cceedsEqual;⪰cceedsTilde;≿persetEqual;⊇\nbsetEqual;⊆cceeds;≻chThat;∋perset;⊃bset;⋐pset;⋑b;⋐m;∑p;⋑'
			},
			rt.ArrayItem{ key: none, val: 'ORN;ÞORNÞ' },
			rt.ArrayItem{ key: none, val: 'ADE;™' },
			rt.ArrayItem{ key: none, val: 'Hcy;Ћcy;Ц' },
			rt.ArrayItem{ key: none, val: 'b;\\\tu;Τ' },
			rt.ArrayItem{ key: none, val: 'aron;Ťedil;Ţy;Т' },
			rt.ArrayItem{ key: none, val: 'r;𝔗' },
			rt.ArrayItem{ key: none, val: '\tickSpace;  erefore;∴inSpace; eta;Θ' },
			rt.ArrayItem{
				key: none
				val: '\rldeFullEqual;≅\tldeEqual;≃\tldeTilde;≈lde;∼'
			},
			rt.ArrayItem{ key: none, val: 'pf;𝕋' },
			rt.ArrayItem{ key: none, val: 'ipleDot;⃛' },
			rt.ArrayItem{ key: none, val: 'trok;Ŧcr;𝒯' },
			rt.ArrayItem{ key: none, val: 'rrocir;⥉cute;ÚcuteÚrr;↟' },
			rt.ArrayItem{ key: none, val: 'reve;Ŭrcy;Ў' },
			rt.ArrayItem{ key: none, val: 'irc;ÛircÛy;У' },
			rt.ArrayItem{ key: none, val: 'blac;Ű' },
			rt.ArrayItem{ key: none, val: 'r;𝔘' },
			rt.ArrayItem{ key: none, val: 'rave;ÙraveÙ' },
			rt.ArrayItem{ key: none, val: 'acr;Ū' },
			rt.ArrayItem{
				key: none
				val: 'derParenthesis;⏝derBracket;⎵\tderBrace;⏟ionPlus;⊎derBar;\\_ion;⋃'
			},
			rt.ArrayItem{ key: none, val: 'gon;Ųpf;𝕌' },
			rt.ArrayItem{
				key: none
				val: 'ArrowDownArrow;⇅perRightArrow;↗\rperLeftArrow;↖Equilibrium;⥮\nDownArrow;↕\ndownarrow;⇕\tArrowBar;⤒\tTeeArrow;↥Arrow;↑arrow;⇑silon;ΥTee;⊥si;ϒ'
			},
			rt.ArrayItem{ key: none, val: 'ing;Ů' },
			rt.ArrayItem{ key: none, val: 'cr;𝒰' },
			rt.ArrayItem{ key: none, val: 'ilde;Ũ' },
			rt.ArrayItem{ key: none, val: 'ml;ÜmlÜ' },
			rt.ArrayItem{ key: none, val: 'ash;⊫' },
			rt.ArrayItem{ key: none, val: 'ar;⫫' },
			rt.ArrayItem{ key: none, val: 'y;В' },
			rt.ArrayItem{ key: none, val: 'ashl;⫦ash;⊩' },
			rt.ArrayItem{
				key: none
				val: 'rticalSeparator;❘rticalTilde;≀ryThinSpace; rticalLine;\\|\nrticalBar;∣rbar;‖rt;‖e;⋁'
			},
			rt.ArrayItem{ key: none, val: 'r;𝔙' },
			rt.ArrayItem{ key: none, val: 'pf;𝕍' },
			rt.ArrayItem{ key: none, val: 'cr;𝒱' },
			rt.ArrayItem{ key: none, val: 'dash;⊪' },
			rt.ArrayItem{ key: none, val: 'irc;Ŵ' },
			rt.ArrayItem{ key: none, val: 'dge;⋀' },
			rt.ArrayItem{ key: none, val: 'r;𝔚' },
			rt.ArrayItem{ key: none, val: 'pf;𝕎' },
			rt.ArrayItem{ key: none, val: 'cr;𝒲' },
			rt.ArrayItem{ key: none, val: 'r;𝔛' },
			rt.ArrayItem{ key: none, val: '\\;Ξ' },
			rt.ArrayItem{ key: none, val: 'pf;𝕏' },
			rt.ArrayItem{ key: none, val: 'cr;𝒳' },
			rt.ArrayItem{ key: none, val: 'cy;Я' },
			rt.ArrayItem{ key: none, val: 'cy;Ї' },
			rt.ArrayItem{ key: none, val: 'cy;Ю' },
			rt.ArrayItem{ key: none, val: 'cute;ÝcuteÝ' },
			rt.ArrayItem{ key: none, val: 'irc;Ŷy;Ы' },
			rt.ArrayItem{ key: none, val: 'r;𝔜' },
			rt.ArrayItem{ key: none, val: 'pf;𝕐' },
			rt.ArrayItem{ key: none, val: 'cr;𝒴' },
			rt.ArrayItem{ key: none, val: 'ml;Ÿ' },
			rt.ArrayItem{ key: none, val: 'cy;Ж' },
			rt.ArrayItem{ key: none, val: 'cute;Ź' },
			rt.ArrayItem{ key: none, val: 'aron;Žy;З' },
			rt.ArrayItem{ key: none, val: 'ot;Ż' },
			rt.ArrayItem{ key: none, val: '\rroWidthSpace;​ta;Ζ' },
			rt.ArrayItem{ key: none, val: 'r;ℨ' },
			rt.ArrayItem{ key: none, val: 'pf;ℤ' },
			rt.ArrayItem{ key: none, val: 'cr;𝒵' },
			rt.ArrayItem{ key: none, val: 'cute;ácuteá' },
			rt.ArrayItem{ key: none, val: 'reve;ă' },
			rt.ArrayItem{
				key: none
				val: 'irc;âute;´ircâute´E;∾̳d;∿y;а\\;∾'
			},
			rt.ArrayItem{ key: none, val: 'lig;æligæ' },
			rt.ArrayItem{ key: none, val: 'r;𝔞\\;⁡' },
			rt.ArrayItem{ key: none, val: 'rave;àraveà' },
			rt.ArrayItem{ key: none, val: 'efsym;ℵeph;ℵpha;α' },
			rt.ArrayItem{ key: none, val: 'acr;āalg;⨿p;\\&\\p\\&' },
			rt.ArrayItem{
				key: none
				val: 'dslope;⩘gmsdaa;⦨gmsdab;⦩gmsdac;⦪gmsdad;⦫gmsdae;⦬gmsdaf;⦭gmsdag;⦮gmsdah;⦯grtvbd;⦝grtvb;⊾gzarr;⍼dand;⩕gmsd;∡gsph;∢gle;∠grt;∟gst;Ådd;⩜dv;⩚ge;⦤d;∧g;∠'
			},
			rt.ArrayItem{ key: none, val: 'gon;ąpf;𝕒' },
			rt.ArrayItem{
				key: none
				val: "proxeq;≊acir;⩯prox;≈id;≋os;\\'E;⩰e;≊\\;≈"
			},
			rt.ArrayItem{ key: none, val: 'ing;åingå' },
			rt.ArrayItem{ key: none, val: 'ympeq;≍ymp;≈cr;𝒶t;\\*' },
			rt.ArrayItem{ key: none, val: 'ilde;ãildeã' },
			rt.ArrayItem{ key: none, val: 'ml;ämlä' },
			rt.ArrayItem{ key: none, val: 'conint;∳int;⨑' },
			rt.ArrayItem{ key: none, val: 'ot;⫭' },
			rt.ArrayItem{
				key: none
				val: '\nckepsilon;϶ckprime;‵cksimeq;⋍ckcong;≌rwedge;⌅cksim;∽rvee;⊽rwed;⌅'
			},
			rt.ArrayItem{ key: none, val: 'rktbrk;⎶rk;⎵' },
			rt.ArrayItem{ key: none, val: 'ong;≌y;б' },
			rt.ArrayItem{ key: none, val: 'quo;„' },
			rt.ArrayItem{
				key: none
				val: 'cause;∵mptyv;⦰tween;≬caus;∵rnou;ℬpsi;϶ta;βth;ℶ'
			},
			rt.ArrayItem{ key: none, val: 'r;𝔟' },
			rt.ArrayItem{
				key: none
				val: 'gtriangledown;▽gtriangleup;△gotimes;⨂goplus;⨁gsqcup;⨆guplus;⨄gwedge;⋀gcirc;◯godot;⨀gstar;★gcap;⋂gcup;⋃gvee;⋁'
			},
			rt.ArrayItem{ key: none, val: 'arow;⤍' },
			rt.ArrayItem{
				key: none
				val: 'acktriangleright;▸acktriangledown;▾acktriangleleft;◂acktriangle;▴acklozenge;⧫\nacksquare;▪ank;␣k12;▒k14;░k34;▓ock;█'
			},
			rt.ArrayItem{ key: none, val: 'equiv;≡⃥ot;⌐e;=⃥' },
			rt.ArrayItem{
				key: none
				val: 'xminus;⊟xtimes;⊠xplus;⊞ttom;⊥wtie;⋈xbox;⧉xDL;╗xDR;╔xDl;╖xDr;╓xHD;╦xHU;╩xHd;╤xHu;╧xUL;╝xUR;╚xUl;╜xUr;╙xVH;╬xVL;╣xVR;╠xVh;╫xVl;╢xVr;╟xdL;╕xdR;╒xdl;┐xdr;┌xhD;╥xhU;╨xhd;┬xhu;┴xuL;╛xuR;╘xul;┘xur;└xvH;╪xvL;╡xvR;╞xvh;┼xvl;┤xvr;├pf;𝕓xH;═xV;║xh;─xv;│t;⊥'
			},
			rt.ArrayItem{ key: none, val: 'rime;‵' },
			rt.ArrayItem{ key: none, val: 'vbar;¦eve;˘vbar¦' },
			rt.ArrayItem{
				key: none
				val: 'olhsub;⟈emi;⁏ime;⋍olb;⧅cr;𝒷im;∽ol;\\\\'
			},
			rt.ArrayItem{ key: none, val: 'llet;•mpeq;≏mpE;⪮mpe;≏ll;•mp;≎' },
			rt.ArrayItem{
				key: none
				val: 'pbrcup;⩉cute;ćpand;⩄pcap;⩋pcup;⩇pdot;⩀ret;⁁ron;ˇps;∩︀p;∩'
			},
			rt.ArrayItem{
				key: none
				val: 'upssm;⩐aron;čedil;çaps;⩍edilçirc;ĉups;⩌'
			},
			rt.ArrayItem{ key: none, val: 'ot;ċ' },
			rt.ArrayItem{ key: none, val: 'nterdot;·mptyv;⦲dil;¸dil¸nt;¢nt¢' },
			rt.ArrayItem{ key: none, val: 'r;𝔠' },
			rt.ArrayItem{ key: none, val: 'eckmark;✓eck;✓cy;чi;χ' },
			rt.ArrayItem{
				key: none
				val: 'rclearrowright;↻rclearrowleft;↺\nrcledcirc;⊚\nrcleddash;⊝\trcledast;⊛rcledR;®rcledS;Ⓢrfnint;⨐rscir;⧂rceq;≗rmid;⫯rE;⧃rc;ˆre;≗r;○'
			},
			rt.ArrayItem{ key: none, val: 'ubsuit;♣ubs;♣' },
			rt.ArrayItem{
				key: none
				val: '\tmplement;∁mplexes;ℂloneq;≔ngdot;⩭lone;≔mmat;\\@mpfn;∘nint;∮prod;∐pysr;℗lon;\\:mma;\\,mp;∁ng;≅pf;𝕔py;©py©'
			},
			rt.ArrayItem{ key: none, val: 'arr;↵oss;✗' },
			rt.ArrayItem{ key: none, val: 'ube;⫑upe;⫒cr;𝒸ub;⫏up;⫐' },
			rt.ArrayItem{ key: none, val: 'dot;⋯' },
			rt.ArrayItem{
				key: none
				val: 'rvearrowright;↷\rrvearrowleft;↶\nrlyeqprec;⋞\nrlyeqsucc;⋟\trlywedge;⋏pbrcap;⩈rlyvee;⋎darrl;⤸darrr;⤵larrp;⤽rarrm;⤼larr;↶pcap;⩆pcup;⩊pdot;⊍rarr;↷rren;¤epr;⋞esc;⋟por;⩅rren¤vee;⋎wed;⋏ps;∪︀p;∪'
			},
			rt.ArrayItem{ key: none, val: 'conint;∲int;∱' },
			rt.ArrayItem{ key: none, val: 'lcty;⌭' },
			rt.ArrayItem{ key: none, val: 'rr;⇓' },
			rt.ArrayItem{ key: none, val: 'ar;⥥' },
			rt.ArrayItem{ key: none, val: 'gger;†leth;ℸshv;⊣rr;↓sh;‐' },
			rt.ArrayItem{ key: none, val: 'karow;⤏lac;˝' },
			rt.ArrayItem{ key: none, val: 'aron;ďy;д' },
			rt.ArrayItem{ key: none, val: 'agger;‡otseq;⩷arr;⇊\\;ⅆ' },
			rt.ArrayItem{ key: none, val: 'mptyv;⦱lta;δg;°\\g°' },
			rt.ArrayItem{ key: none, val: 'isht;⥿r;𝔡' },
			rt.ArrayItem{ key: none, val: 'arl;⇃arr;⇂' },
			rt.ArrayItem{
				key: none
				val: 'videontimes;⋇\namondsuit;♦amond;⋄gamma;ϝvide;÷vonx;⋇ams;♦sin;⋲vide÷am;⋄e;¨v;÷'
			},
			rt.ArrayItem{ key: none, val: 'cy;ђ' },
			rt.ArrayItem{ key: none, val: 'corn;⌞crop;⌍' },
			rt.ArrayItem{
				key: none
				val: 'wnharpoonright;⇂wnharpoonleft;⇃\rublebarwedge;⌆\rwndownarrows;⇊tsquare;⊡wnarrow;↓teqdot;≑tminus;∸tplus;∔llar;\\$teq;≐pf;𝕕t;˙'
			},
			rt.ArrayItem{ key: none, val: 'bkarow;⤐corn;⌟crop;⌌' },
			rt.ArrayItem{ key: none, val: 'trok;đcr;𝒹cy;ѕol;⧶' },
			rt.ArrayItem{ key: none, val: 'dot;⋱rif;▾ri;▿' },
			rt.ArrayItem{ key: none, val: 'arr;⇵har;⥯' },
			rt.ArrayItem{ key: none, val: 'angle;⦦' },
			rt.ArrayItem{ key: none, val: 'igrarr;⟿cy;џ' },
			rt.ArrayItem{ key: none, val: 'Dot;⩷ot;≑' },
			rt.ArrayItem{ key: none, val: 'cute;éster;⩮cuteé' },
			rt.ArrayItem{ key: none, val: 'aron;ěolon;≕irc;êir;≖ircêy;э' },
			rt.ArrayItem{ key: none, val: 'ot;ė' },
			rt.ArrayItem{ key: none, val: '\\;ⅇ' },
			rt.ArrayItem{ key: none, val: 'Dot;≒r;𝔢' },
			rt.ArrayItem{ key: none, val: 'rave;èsdot;⪘raveès;⪖\\;⪚' },
			rt.ArrayItem{ key: none, val: 'inters;⏧sdot;⪗l;ℓs;⪕\\;⪙' },
			rt.ArrayItem{
				key: none
				val: 'ptyset;∅ptyv;∅sp13; sp14; acr;ēpty;∅sp; '
			},
			rt.ArrayItem{ key: none, val: 'sp; g;ŋ' },
			rt.ArrayItem{ key: none, val: 'gon;ępf;𝕖' },
			rt.ArrayItem{ key: none, val: 'silon;εarsl;⧣lus;⩱siv;ϵar;⋕si;ε' },
			rt.ArrayItem{
				key: none
				val: '\nslantless;⪕\tslantgtr;⪖vparsl;⧥colon;≕uivDD;⩸circ;≖uals;\\=uest;≟sim;≂uiv;≡'
			},
			rt.ArrayItem{ key: none, val: 'Dot;≓arr;⥱' },
			rt.ArrayItem{ key: none, val: 'dot;≐cr;ℯim;≂' },
			rt.ArrayItem{ key: none, val: 'a;ηh;ð\\hð' },
			rt.ArrayItem{ key: none, val: 'ml;ëro;€mlë' },
			rt.ArrayItem{ key: none, val: 'ponentiale;ⅇ\npectation;ℰist;∃cl;\\!' },
			rt.ArrayItem{ key: none, val: 'llingdotseq;≒' },
			rt.ArrayItem{ key: none, val: 'y;ф' },
			rt.ArrayItem{ key: none, val: 'male;♀' },
			rt.ArrayItem{ key: none, val: 'ilig;ﬃllig;ﬄlig;ﬀr;𝔣' },
			rt.ArrayItem{ key: none, val: 'lig;ﬁ' },
			rt.ArrayItem{ key: none, val: 'lig;fj' },
			rt.ArrayItem{ key: none, val: 'lig;ﬂtns;▱at;♭' },
			rt.ArrayItem{ key: none, val: 'of;ƒ' },
			rt.ArrayItem{ key: none, val: 'rall;∀rkv;⫙pf;𝕗rk;⋔' },
			rt.ArrayItem{ key: none, val: 'artint;⨍' },
			rt.ArrayItem{
				key: none
				val: 'ac12;½ac13;⅓ac14;¼ac15;⅕ac16;⅙ac18;⅛ac23;⅔ac25;⅖ac34;¾ac35;⅗ac38;⅜ac45;⅘ac56;⅚ac58;⅝ac78;⅞ac12½ac14¼ac34¾asl;⁄own;⌢'
			},
			rt.ArrayItem{ key: none, val: 'cr;𝒻' },
			rt.ArrayItem{ key: none, val: 'l;⪌\\;≧' },
			rt.ArrayItem{ key: none, val: 'cute;ǵmmad;ϝmma;γp;⪆' },
			rt.ArrayItem{ key: none, val: 'reve;ğ' },
			rt.ArrayItem{ key: none, val: 'irc;ĝy;г' },
			rt.ArrayItem{ key: none, val: 'ot;ġ' },
			rt.ArrayItem{
				key: none
				val: 'qslant;⩾sdotol;⪄sdoto;⪂sdot;⪀sles;⪔scc;⪩qq;≧sl;⋛︀l;⋛q;≥s;⩾\\;≥'
			},
			rt.ArrayItem{ key: none, val: 'r;𝔤' },
			rt.ArrayItem{ key: none, val: 'g;⋙\\;≫' },
			rt.ArrayItem{ key: none, val: 'mel;ℷ' },
			rt.ArrayItem{ key: none, val: 'cy;ѓ' },
			rt.ArrayItem{ key: none, val: 'E;⪒a;⪥j;⪤\\;≷' },
			rt.ArrayItem{
				key: none
				val: 'approx;⪊eqq;≩sim;⋧ap;⪊eq;⪈E;≩e;⪈'
			},
			rt.ArrayItem{ key: none, val: 'pf;𝕘' },
			rt.ArrayItem{ key: none, val: 'ave;\\`' },
			rt.ArrayItem{ key: none, val: 'ime;⪎iml;⪐cr;ℊim;≳' },
			rt.ArrayItem{
				key: none
				val: '\treqqless;⪌rapprox;⪆reqless;⋛quest;⩼rless;≷lPar;⦕rarr;⥸rdot;⋗rsim;≳cir;⩺dot;⋗cc;⪧\\;\\>'
			},
			rt.ArrayItem{ key: none, val: 'ertneqq;≩︀nE;≩︀' },
			rt.ArrayItem{ key: none, val: 'rr;⇔' },
			rt.ArrayItem{
				key: none
				val: 'rrcir;⥈irsp; milt;ℋrdcy;ъrrw;↭lf;½rr;↔'
			},
			rt.ArrayItem{ key: none, val: 'ar;ℏ' },
			rt.ArrayItem{ key: none, val: 'irc;ĥ' },
			rt.ArrayItem{ key: none, val: 'artsuit;♥arts;♥llip;…rcon;⊹' },
			rt.ArrayItem{ key: none, val: 'r;𝔥' },
			rt.ArrayItem{ key: none, val: 'searow;⤥swarow;⤦' },
			rt.ArrayItem{
				key: none
				val: '\rokrightarrow;↪okleftarrow;↩mtht;∻rbar;―arr;⇿pf;𝕙'
			},
			rt.ArrayItem{ key: none, val: 'lash;ℏtrok;ħcr;𝒽' },
			rt.ArrayItem{ key: none, val: 'bull;⁃phen;‐' },
			rt.ArrayItem{ key: none, val: 'cute;ícuteí' },
			rt.ArrayItem{ key: none, val: 'irc;îircîy;и\\;⁣' },
			rt.ArrayItem{ key: none, val: 'xcl;¡cy;еxcl¡' },
			rt.ArrayItem{ key: none, val: 'f;⇔r;𝔦' },
			rt.ArrayItem{ key: none, val: 'rave;ìraveì' },
			rt.ArrayItem{ key: none, val: 'iint;⨌nfin;⧜int;∭ota;℩\\;ⅈ' },
			rt.ArrayItem{ key: none, val: 'lig;ĳ' },
			rt.ArrayItem{
				key: none
				val: 'agline;ℐagpart;ℑacr;īage;ℑath;ıped;Ƶof;⊷'
			},
			rt.ArrayItem{
				key: none
				val: 'fintie;⧝tegers;ℤtercal;⊺tlarhk;⨗tprod;⨼care;℅odot;ıtcal;⊺fin;∞t;∫\\;∈'
			},
			rt.ArrayItem{ key: none, val: 'gon;įcy;ёpf;𝕚ta;ι' },
			rt.ArrayItem{ key: none, val: 'rod;⨼' },
			rt.ArrayItem{ key: none, val: 'uest;¿uest¿' },
			rt.ArrayItem{
				key: none
				val: 'indot;⋵insv;⋳inE;⋹ins;⋴inv;∈cr;𝒾in;∈'
			},
			rt.ArrayItem{ key: none, val: 'ilde;ĩ\\;⁢' },
			rt.ArrayItem{ key: none, val: 'kcy;іml;ïmlï' },
			rt.ArrayItem{ key: none, val: 'irc;ĵy;й' },
			rt.ArrayItem{ key: none, val: 'r;𝔧' },
			rt.ArrayItem{ key: none, val: 'ath;ȷ' },
			rt.ArrayItem{ key: none, val: 'pf;𝕛' },
			rt.ArrayItem{ key: none, val: 'ercy;јcr;𝒿' },
			rt.ArrayItem{ key: none, val: 'kcy;є' },
			rt.ArrayItem{ key: none, val: 'ppav;ϰppa;κ' },
			rt.ArrayItem{ key: none, val: 'edil;ķy;к' },
			rt.ArrayItem{ key: none, val: 'r;𝔨' },
			rt.ArrayItem{ key: none, val: 'reen;ĸ' },
			rt.ArrayItem{ key: none, val: 'cy;х' },
			rt.ArrayItem{ key: none, val: 'cy;ќ' },
			rt.ArrayItem{ key: none, val: 'pf;𝕜' },
			rt.ArrayItem{ key: none, val: 'cr;𝓀' },
			rt.ArrayItem{ key: none, val: 'tail;⤛arr;⇚rr;⇐' },
			rt.ArrayItem{ key: none, val: 'arr;⤎' },
			rt.ArrayItem{ key: none, val: 'g;⪋\\;≦' },
			rt.ArrayItem{ key: none, val: 'ar;⥢' },
			rt.ArrayItem{
				key: none
				val: 'emptyv;⦴rrbfs;⤟rrsim;⥳cute;ĺgran;ℒmbda;λngle;⟨rrfs;⤝rrhk;↩rrlp;↫rrpl;⤹rrtl;↢tail;⤙ngd;⦑quo;«rrb;⇤tes;⪭︀ng;⟨quo«rr;←te;⪭p;⪅t;⪫'
			},
			rt.ArrayItem{
				key: none
				val: 'rksld;⦏rkslu;⦍race;\\{rack;\\[arr;⤌brk;❲rke;⦋'
			},
			rt.ArrayItem{ key: none, val: 'aron;ľedil;ļeil;⌈ub;\\{y;л' },
			rt.ArrayItem{
				key: none
				val: 'rushar;⥋rdhar;⥧quor;„quo;“ca;⤶sh;↲'
			},
			rt.ArrayItem{
				key: none
				val: 'ftrightsquigarrow;↭ftrightharpoons;⇋ftharpoondown;↽ftrightarrows;⇆\rftleftarrows;⇇\rftrightarrow;↔\rftthreetimes;⋋ftarrowtail;↢ftharpoonup;↼\tssapprox;⪅\tsseqqgtr;⪋ftarrow;←sseqgtr;⋚qslant;⩽sdotor;⪃sdoto;⪁ssdot;⋖ssgtr;≶sssim;≲sdot;⩿sges;⪓scc;⪨qq;≦sg;⋚︀g;⋚q;≤s;⩽\\;≤'
			},
			rt.ArrayItem{ key: none, val: 'isht;⥼loor;⌊r;𝔩' },
			rt.ArrayItem{ key: none, val: 'E;⪑\\;≶' },
			rt.ArrayItem{ key: none, val: 'arul;⥪ard;↽aru;↼blk;▄' },
			rt.ArrayItem{ key: none, val: 'cy;љ' },
			rt.ArrayItem{ key: none, val: 'corner;⌞hard;⥫arr;⇇tri;◺\\;≪' },
			rt.ArrayItem{ key: none, val: '\toustache;⎰idot;ŀoust;⎰' },
			rt.ArrayItem{
				key: none
				val: 'approx;⪉eqq;≨sim;⋦ap;⪉eq;⪇E;≨e;⪇'
			},
			rt.ArrayItem{
				key: none
				val: 'ngleftrightarrow;⟷\rngrightarrow;⟶\roparrowright;↬ngleftarrow;⟵oparrowleft;↫\tngmapsto;⟼times;⨴zenge;◊plus;⨭wast;∗wbar;\\_ang;⟬arr;⇽brk;⟦par;⦅pf;𝕝zf;⧫z;◊'
			},
			rt.ArrayItem{ key: none, val: 'arlt;⦓ar;\\(' },
			rt.ArrayItem{ key: none, val: 'corner;⌟hard;⥭arr;⇆har;⇋tri;⊿m;‎' },
			rt.ArrayItem{
				key: none
				val: 'aquo;‹quor;‚trok;łime;⪍img;⪏quo;‘cr;𝓁im;≲qb;\\[h;↰'
			},
			rt.ArrayItem{
				key: none
				val: 'quest;⩻hree;⋋imes;⋉larr;⥶rPar;⦖cir;⩹dot;⋖rie;⊴rif;◂cc;⪦ri;◃\\;\\<'
			},
			rt.ArrayItem{ key: none, val: 'rdshar;⥊ruhar;⥦' },
			rt.ArrayItem{ key: none, val: 'ertneqq;≨︀nE;≨︀' },
			rt.ArrayItem{ key: none, val: 'Dot;∺' },
			rt.ArrayItem{
				key: none
				val: '\tpstodown;↧\tpstoleft;↤pstoup;↥ltese;✠psto;↦rker;▮cr;¯le;♂lt;✠cr¯p;↦'
			},
			rt.ArrayItem{ key: none, val: 'omma;⨩y;м' },
			rt.ArrayItem{ key: none, val: 'ash;—' },
			rt.ArrayItem{ key: none, val: 'asuredangle;∡' },
			rt.ArrayItem{ key: none, val: 'r;𝔪' },
			rt.ArrayItem{ key: none, val: 'o;℧' },
			rt.ArrayItem{
				key: none
				val: 'nusdu;⨪dast;\\*dcir;⫰ddot;·nusb;⊟nusd;∸cro;µddot·nus;−croµd;∣'
			},
			rt.ArrayItem{ key: none, val: 'cp;⫛dr;…' },
			rt.ArrayItem{ key: none, val: 'plus;∓' },
			rt.ArrayItem{ key: none, val: 'dels;⊧pf;𝕞' },
			rt.ArrayItem{ key: none, val: '\\;∓' },
			rt.ArrayItem{ key: none, val: 'tpos;∾cr;𝓂' },
			rt.ArrayItem{ key: none, val: 'ltimap;⊸map;⊸\\;μ' },
			rt.ArrayItem{ key: none, val: 'tv;≫̸g;⋙̸t;≫⃒' },
			rt.ArrayItem{
				key: none
				val: 'eftrightarrow;⇎\teftarrow;⇍tv;≪̸l;⋘̸t;≪⃒'
			},
			rt.ArrayItem{ key: none, val: '\nightarrow;⇏' },
			rt.ArrayItem{ key: none, val: 'Dash;⊯dash;⊮' },
			rt.ArrayItem{
				key: none
				val: 'turals;ℕpprox;≉tural;♮cute;ńbla;∇pid;≋̸pos;ŉtur;♮ng;∠⃒pE;⩰̸p;≉'
			},
			rt.ArrayItem{ key: none, val: 'umpe;≏̸ump;≎̸sp; sp ' },
			rt.ArrayItem{
				key: none
				val: 'ongdot;⩭̸aron;ňedil;ņong;≇ap;⩃up;⩂y;н'
			},
			rt.ArrayItem{ key: none, val: 'ash;–' },
			rt.ArrayItem{
				key: none
				val: 'arrow;↗xists;∄arhk;⤤quiv;≢sear;⤨xist;∄Arr;⇗arr;↗dot;≐̸sim;≂̸\\;≠'
			},
			rt.ArrayItem{ key: none, val: 'r;𝔫' },
			rt.ArrayItem{
				key: none
				val: 'eqslant;⩾̸eqq;≧̸sim;≵eq;≱es;⩾̸tr;≯E;≧̸e;≱t;≯'
			},
			rt.ArrayItem{ key: none, val: 'Arr;⇎arr;↮par;⫲' },
			rt.ArrayItem{ key: none, val: 'sd;⋺s;⋼v;∋\\;∋' },
			rt.ArrayItem{ key: none, val: 'cy;њ' },
			rt.ArrayItem{
				key: none
				val: 'eftrightarrow;↮\teftarrow;↚eqslant;⩽̸trie;⋬Arr;⇍arr;↚eqq;≦̸ess;≮sim;≴tri;⋪dr;‥eq;≰es;⩽̸E;≦̸e;≰t;≮'
			},
			rt.ArrayItem{ key: none, val: 'id;∤' },
			rt.ArrayItem{
				key: none
				val: 'tindot;⋵̸tinva;∉tinvb;⋷tinvc;⋶tniva;∌tnivb;⋾tnivc;⋽tinE;⋹̸tin;∉tni;∌pf;𝕟t;¬\\t¬'
			},
			rt.ArrayItem{
				key: none
				val: 'arallel;∦olint;⨔receq;⪯̸arsl;⫽⃥rcue;⋠art;∂̸rec;⊀ar;∦re;⪯̸r;⊀'
			},
			rt.ArrayItem{
				key: none
				val: '\nightarrow;↛arrc;⤳̸arrw;↝̸trie;⋭Arr;⇏arr;↛tri;⋫'
			},
			rt.ArrayItem{
				key: none
				val: '\rhortparallel;∦\tubseteqq;⫅̸\tupseteqq;⫆̸hortmid;∤ubseteq;⊈upseteq;⊉qsube;⋢qsupe;⋣ubset;⊂⃒ucceq;⪰̸upset;⊃⃒ccue;⋡imeq;≄ime;≄mid;∤par;∦ubE;⫅̸ube;⊈ucc;⊁upE;⫆̸upe;⊉ce;⪰̸cr;𝓃im;≁ub;⊄up;⊅c;⊁'
			},
			rt.ArrayItem{
				key: none
				val: 'rianglerighteq;⋭rianglelefteq;⋬\rriangleright;⋫riangleleft;⋪ilde;ñildeñgl;≹lg;≸'
			},
			rt.ArrayItem{ key: none, val: 'mero;№msp; m;\\#\\;ν' },
			rt.ArrayItem{
				key: none
				val: 'infin;⧞ltrie;⊴⃒rtrie;⊵⃒Dash;⊭Harr;⤄dash;⊬lArr;⤂rArr;⤃sim;∼⃒ap;≍⃒ge;≥⃒gt;>⃒le;≤⃒lt;<⃒'
			},
			rt.ArrayItem{ key: none, val: 'arrow;↖arhk;⤣near;⤧Arr;⇖arr;↖' },
			rt.ArrayItem{ key: none, val: '\\;Ⓢ' },
			rt.ArrayItem{ key: none, val: 'cute;ócuteóst;⊛' },
			rt.ArrayItem{ key: none, val: 'irc;ôir;⊚ircôy;о' },
			rt.ArrayItem{ key: none, val: 'blac;ősold;⦼ash;⊝iv;⨸ot;⊙' },
			rt.ArrayItem{ key: none, val: 'lig;œ' },
			rt.ArrayItem{ key: none, val: 'cir;⦿r;𝔬' },
			rt.ArrayItem{ key: none, val: 'rave;òraveòon;˛t;⧁' },
			rt.ArrayItem{ key: none, val: 'bar;⦵m;Ω' },
			rt.ArrayItem{ key: none, val: 'nt;∮' },
			rt.ArrayItem{ key: none, val: 'cross;⦻arr;↺cir;⦾ine;‾t;⧀' },
			rt.ArrayItem{ key: none, val: 'icron;οinus;⊖acr;ōega;ωid;⦶' },
			rt.ArrayItem{ key: none, val: 'pf;𝕠' },
			rt.ArrayItem{ key: none, val: 'erp;⦹lus;⊕ar;⦷' },
			rt.ArrayItem{
				key: none
				val: 'derof;ℴslope;⩗igof;⊶arr;↻der;ℴdf;ªdm;ºor;⩖d;⩝dfªdmºv;⩛\\;∨'
			},
			rt.ArrayItem{ key: none, val: 'lash;ølashøcr;ℴol;⊘' },
			rt.ArrayItem{ key: none, val: 'imesas;⨶ilde;õimes;⊗ildeõ' },
			rt.ArrayItem{ key: none, val: 'ml;ömlö' },
			rt.ArrayItem{ key: none, val: 'bar;⌽' },
			rt.ArrayItem{
				key: none
				val: 'rallel;∥rsim;⫳rsl;⫽ra;¶rt;∂r;∥ra¶'
			},
			rt.ArrayItem{ key: none, val: 'y;п' },
			rt.ArrayItem{ key: none, val: 'rtenk;‱rcnt;\\%riod;\\.rmil;‰rp;⊥' },
			rt.ArrayItem{ key: none, val: 'r;𝔭' },
			rt.ArrayItem{ key: none, val: 'mmat;ℳone;☎iv;ϕi;φ' },
			rt.ArrayItem{ key: none, val: 'tchfork;⋔v;ϖ\\;π' },
			rt.ArrayItem{
				key: none
				val: 'usacir;⨣anckh;ℎuscir;⨢ussim;⨦ustwo;⨧anck;ℏankv;ℏusdo;∔usdu;⨥usmn;±usb;⊞use;⩲usmn±us;\\+'
			},
			rt.ArrayItem{ key: none, val: '\\;±' },
			rt.ArrayItem{ key: none, val: 'intint;⨕und;£pf;𝕡und£' },
			rt.ArrayItem{
				key: none
				val: '\neccurlyeq;≼\necnapprox;⪹\tecapprox;⪷ecneqq;⪵ecnsim;⋨ofalar;⌮ofline;⌒ofsurf;⌓ecsim;≾eceq;⪯imes;ℙnsim;⋨opto;∝urel;⊰cue;≼ime;′nap;⪹sim;≾ap;⪷ec;≺nE;⪵od;∏op;∝E;⪳e;⪯\\;≺'
			},
			rt.ArrayItem{ key: none, val: 'cr;𝓅i;ψ' },
			rt.ArrayItem{ key: none, val: 'ncsp; ' },
			rt.ArrayItem{ key: none, val: 'r;𝔮' },
			rt.ArrayItem{ key: none, val: 'nt;⨌' },
			rt.ArrayItem{ key: none, val: 'pf;𝕢' },
			rt.ArrayItem{ key: none, val: 'rime;⁗' },
			rt.ArrayItem{ key: none, val: 'cr;𝓆' },
			rt.ArrayItem{
				key: none
				val: '\naternions;ℍatint;⨖esteq;≟est;\\?ot;\\"ot\\"'
			},
			rt.ArrayItem{ key: none, val: 'tail;⤜arr;⇛rr;⇒' },
			rt.ArrayItem{ key: none, val: 'arr;⤏' },
			rt.ArrayItem{ key: none, val: 'ar;⥤' },
			rt.ArrayItem{
				key: none
				val: 'tionals;ℚemptyv;⦳rrbfs;⤠rrsim;⥴cute;ŕngle;⟩rrap;⥵rrfs;⤞rrhk;↪rrlp;↬rrpl;⥅rrtl;↣tail;⤚dic;√ngd;⦒nge;⦥quo;»rrb;⇥rrc;⤳rrw;↝tio;∶ce;∽̱ng;⟩quo»rr;→'
			},
			rt.ArrayItem{
				key: none
				val: 'rksld;⦎rkslu;⦐race;\\}rack;\\]arr;⤍brk;❳rke;⦌'
			},
			rt.ArrayItem{ key: none, val: 'aron;ředil;ŗeil;⌉ub;\\}y;р' },
			rt.ArrayItem{ key: none, val: 'ldhar;⥩quor;”quo;”ca;⤷sh;↳' },
			rt.ArrayItem{
				key: none
				val: 'alpart;ℜaline;ℛals;ℝal;ℜct;▭g;®\\g®'
			},
			rt.ArrayItem{ key: none, val: 'isht;⥽loor;⌋r;𝔯' },
			rt.ArrayItem{ key: none, val: 'arul;⥬ard;⇁aru;⇀ov;ϱo;ρ' },
			rt.ArrayItem{
				key: none
				val: 'ghtleftharpoons;⇌ghtharpoondown;⇁ghtrightarrows;⇉ghtleftarrows;⇄ghtsquigarrow;↝ghtthreetimes;⋌\rghtarrowtail;↣\rghtharpoonup;⇀singdotseq;≓\tghtarrow;→ng;˚'
			},
			rt.ArrayItem{ key: none, val: 'arr;⇄har;⇌m;‏' },
			rt.ArrayItem{ key: none, val: '\toustache;⎱oust;⎱' },
			rt.ArrayItem{ key: none, val: 'mid;⫮' },
			rt.ArrayItem{
				key: none
				val: 'times;⨵plus;⨮ang;⟭arr;⇾brk;⟧par;⦆pf;𝕣'
			},
			rt.ArrayItem{ key: none, val: 'polint;⨒argt;⦔ar;\\)' },
			rt.ArrayItem{ key: none, val: 'arr;⇉' },
			rt.ArrayItem{ key: none, val: 'aquo;›quor;’quo;’cr;𝓇qb;\\]h;↱' },
			rt.ArrayItem{
				key: none
				val: 'riltri;⧎hree;⋌imes;⋊rie;⊵rif;▸ri;▹'
			},
			rt.ArrayItem{ key: none, val: 'luhar;⥨' },
			rt.ArrayItem{ key: none, val: '\\;℞' },
			rt.ArrayItem{ key: none, val: 'cute;ś' },
			rt.ArrayItem{ key: none, val: 'quo;‚' },
			rt.ArrayItem{
				key: none
				val: 'polint;⨓aron;šedil;şnsim;⋩cue;≽irc;ŝnap;⪺sim;≿ap;⪸nE;⪶E;⪴e;⪰y;с\\;≻'
			},
			rt.ArrayItem{ key: none, val: 'otb;⊡ote;⩦ot;⋅' },
			rt.ArrayItem{
				key: none
				val: 'tminus;∖arrow;↘arhk;⤥swar;⤩Arr;⇘arr;↘tmn;∖ct;§mi;\\;xt;✶ct§'
			},
			rt.ArrayItem{ key: none, val: 'rown;⌢r;𝔰' },
			rt.ArrayItem{
				key: none
				val: 'ortparallel;∥ortmid;∣chcy;щarp;♯cy;шy;­\\y­'
			},
			rt.ArrayItem{
				key: none
				val: 'mplus;⨤mrarr;⥲gmaf;ςgmav;ςmdot;⩪gma;σmeq;≃mgE;⪠mlE;⪟mne;≆me;≃mg;⪞ml;⪝m;∼'
			},
			rt.ArrayItem{ key: none, val: 'arr;←' },
			rt.ArrayItem{
				key: none
				val: 'allsetminus;∖eparsl;⧤ashp;⨳ile;⌣tes;⪬︀id;∣te;⪬t;⪪'
			},
			rt.ArrayItem{ key: none, val: 'ftcy;ьlbar;⌿lb;⧄pf;𝕤l;\\/' },
			rt.ArrayItem{ key: none, val: 'adesuit;♠ades;♠ar;∥' },
			rt.ArrayItem{
				key: none
				val: '\tsubseteq;⊑\tsupseteq;⊒subset;⊏supset;⊐caps;⊓︀cups;⊔︀sube;⊑supe;⊒uare;□uarf;▪cap;⊓cup;⊔sub;⊏sup;⊐uf;▪u;□'
			},
			rt.ArrayItem{ key: none, val: 'arr;→' },
			rt.ArrayItem{ key: none, val: 'etmn;∖mile;⌣tarf;⋆cr;𝓈' },
			rt.ArrayItem{
				key: none
				val: 'raightepsilon;ϵ\nraightphi;ϕarf;★rns;¯ar;☆'
			},
			rt.ArrayItem{
				key: none
				val: '\ncccurlyeq;≽\nccnapprox;⪺\tbsetneqq;⫋\tccapprox;⪸\tpsetneqq;⫌bseteqq;⫅bsetneq;⊊pseteqq;⫆psetneq;⊋bseteq;⊆ccneqq;⪶ccnsim;⋩pseteq;⊇bedot;⫃bmult;⫁bplus;⪿brarr;⥹ccsim;≿pdsub;⫘pedot;⫄phsol;⟉phsub;⫗plarr;⥻pmult;⫂pplus;⫀bdot;⪽bset;⊂bsim;⫇bsub;⫕bsup;⫓cceq;⪰pdot;⪾pset;⊃psim;⫈psub;⫔psup;⫖bnE;⫋bne;⊊pnE;⫌pne;⊋bE;⫅be;⊆cc;≻ng;♪p1;¹p2;²p3;³pE;⫆pe;⊇b;⊂m;∑p1¹p2²p3³p;⊃'
			},
			rt.ArrayItem{ key: none, val: 'arrow;↙arhk;⤦nwar;⤪Arr;⇙arr;↙' },
			rt.ArrayItem{ key: none, val: 'lig;ßligß' },
			rt.ArrayItem{ key: none, val: 'rget;⌖u;τ' },
			rt.ArrayItem{ key: none, val: 'rk;⎴' },
			rt.ArrayItem{ key: none, val: 'aron;ťedil;ţy;т' },
			rt.ArrayItem{ key: none, val: 'ot;⃛' },
			rt.ArrayItem{ key: none, val: 'lrec;⌕' },
			rt.ArrayItem{ key: none, val: 'r;𝔱' },
			rt.ArrayItem{
				key: none
				val: '\nickapprox;≈erefore;∴etasym;ϑicksim;∼ere4;∴etav;ϑinsp; ksim;∼eta;θkap;≈orn;þornþ'
			},
			rt.ArrayItem{
				key: none
				val: 'mesbar;⨱mesb;⊠mesd;⨰lde;˜mes;×mes×nt;∭'
			},
			rt.ArrayItem{
				key: none
				val: 'pfork;⫚pbot;⌶pcir;⫱ea;⤨pf;𝕥sa;⤩p;⊤'
			},
			rt.ArrayItem{ key: none, val: 'rime;‴' },
			rt.ArrayItem{
				key: none
				val: 'ianglerighteq;⊵\rianglelefteq;⊴iangleright;▹iangledown;▿iangleleft;◃iangleq;≜iangle;▵iminus;⨺pezium;⏢iplus;⨹itime;⨻idot;◬ade;™isb;⧍ie;≜'
			},
			rt.ArrayItem{ key: none, val: 'trok;ŧhcy;ћcr;𝓉cy;ц' },
			rt.ArrayItem{ key: none, val: 'oheadrightarrow;↠oheadleftarrow;↞ixt;≬' },
			rt.ArrayItem{ key: none, val: 'rr;⇑' },
			rt.ArrayItem{ key: none, val: 'ar;⥣' },
			rt.ArrayItem{ key: none, val: 'cute;úcuteúrr;↑' },
			rt.ArrayItem{ key: none, val: 'reve;ŭrcy;ў' },
			rt.ArrayItem{ key: none, val: 'irc;ûircûy;у' },
			rt.ArrayItem{ key: none, val: 'blac;űarr;⇅har;⥮' },
			rt.ArrayItem{ key: none, val: 'isht;⥾r;𝔲' },
			rt.ArrayItem{ key: none, val: 'rave;ùraveù' },
			rt.ArrayItem{ key: none, val: 'arl;↿arr;↾blk;▀' },
			rt.ArrayItem{ key: none, val: 'corner;⌜corn;⌜crop;⌏tri;◸' },
			rt.ArrayItem{ key: none, val: 'acr;ūl;¨\\l¨' },
			rt.ArrayItem{ key: none, val: 'gon;ųpf;𝕦' },
			rt.ArrayItem{
				key: none
				val: '\rharpoonright;↾harpoonleft;↿\ndownarrow;↕\tuparrows;⇈arrow;↑silon;υlus;⊎sih;ϒsi;υ'
			},
			rt.ArrayItem{ key: none, val: 'corner;⌝corn;⌝crop;⌎ing;ůtri;◹' },
			rt.ArrayItem{ key: none, val: 'cr;𝓊' },
			rt.ArrayItem{ key: none, val: 'ilde;ũdot;⋰rif;▴ri;▵' },
			rt.ArrayItem{ key: none, val: 'arr;⇈ml;ümlü' },
			rt.ArrayItem{ key: none, val: 'angle;⦧' },
			rt.ArrayItem{ key: none, val: 'rr;⇕' },
			rt.ArrayItem{ key: none, val: 'arv;⫩ar;⫨' },
			rt.ArrayItem{ key: none, val: 'ash;⊨' },
			rt.ArrayItem{
				key: none
				val: 'rtriangleright;⊳rtriangleleft;⊲rsubsetneqq;⫋︀rsupsetneqq;⫌︀rsubsetneq;⊊︀rsupsetneq;⊋︀\trepsilon;ϵ\trnothing;∅rpropto;∝rkappa;ϰrsigma;ςrtheta;ϑngrt;⦜rphi;ϕrrho;ϱrpi;ϖrr;↕'
			},
			rt.ArrayItem{ key: none, val: 'y;в' },
			rt.ArrayItem{ key: none, val: 'ash;⊢' },
			rt.ArrayItem{ key: none, val: 'ebar;⊻llip;⋮rbar;\\|eeq;≚rt;\\|e;∨' },
			rt.ArrayItem{ key: none, val: 'r;𝔳' },
			rt.ArrayItem{ key: none, val: 'tri;⊲' },
			rt.ArrayItem{ key: none, val: 'sub;⊂⃒sup;⊃⃒' },
			rt.ArrayItem{ key: none, val: 'pf;𝕧' },
			rt.ArrayItem{ key: none, val: 'rop;∝' },
			rt.ArrayItem{ key: none, val: 'tri;⊳' },
			rt.ArrayItem{
				key: none
				val: 'ubnE;⫋︀ubne;⊊︀upnE;⫌︀upne;⊋︀cr;𝓋'
			},
			rt.ArrayItem{ key: none, val: 'igzag;⦚' },
			rt.ArrayItem{ key: none, val: 'irc;ŵ' },
			rt.ArrayItem{ key: none, val: 'dbar;⩟dgeq;≙ierp;℘dge;∧' },
			rt.ArrayItem{ key: none, val: 'r;𝔴' },
			rt.ArrayItem{ key: none, val: 'pf;𝕨' },
			rt.ArrayItem{ key: none, val: '\\;℘' },
			rt.ArrayItem{ key: none, val: 'eath;≀\\;≀' },
			rt.ArrayItem{ key: none, val: 'cr;𝓌' },
			rt.ArrayItem{ key: none, val: 'irc;◯ap;⋂up;⋃' },
			rt.ArrayItem{ key: none, val: 'tri;▽' },
			rt.ArrayItem{ key: none, val: 'r;𝔵' },
			rt.ArrayItem{ key: none, val: 'Arr;⟺arr;⟷' },
			rt.ArrayItem{ key: none, val: '\\;ξ' },
			rt.ArrayItem{ key: none, val: 'Arr;⟸arr;⟵' },
			rt.ArrayItem{ key: none, val: 'ap;⟼' },
			rt.ArrayItem{ key: none, val: 'is;⋻' },
			rt.ArrayItem{ key: none, val: 'plus;⨁time;⨂dot;⨀pf;𝕩' },
			rt.ArrayItem{ key: none, val: 'Arr;⟹arr;⟶' },
			rt.ArrayItem{ key: none, val: 'qcup;⨆cr;𝓍' },
			rt.ArrayItem{ key: none, val: 'plus;⨄tri;△' },
			rt.ArrayItem{ key: none, val: 'ee;⋁' },
			rt.ArrayItem{ key: none, val: 'edge;⋀' },
			rt.ArrayItem{ key: none, val: 'cute;ýcuteýcy;я' },
			rt.ArrayItem{ key: none, val: 'irc;ŷy;ы' },
			rt.ArrayItem{ key: none, val: 'n;¥\\n¥' },
			rt.ArrayItem{ key: none, val: 'r;𝔶' },
			rt.ArrayItem{ key: none, val: 'cy;ї' },
			rt.ArrayItem{ key: none, val: 'pf;𝕪' },
			rt.ArrayItem{ key: none, val: 'cr;𝓎' },
			rt.ArrayItem{ key: none, val: 'cy;юml;ÿmlÿ' },
			rt.ArrayItem{ key: none, val: 'cute;ź' },
			rt.ArrayItem{ key: none, val: 'aron;žy;з' },
			rt.ArrayItem{ key: none, val: 'ot;ż' },
			rt.ArrayItem{ key: none, val: 'etrf;ℨta;ζ' },
			rt.ArrayItem{ key: none, val: 'r;𝔷' },
			rt.ArrayItem{ key: none, val: 'cy;ж' },
			rt.ArrayItem{ key: none, val: 'grarr;⇝' },
			rt.ArrayItem{ key: none, val: 'pf;𝕫' },
			rt.ArrayItem{ key: none, val: 'cr;𝓏' },
			rt.ArrayItem{ key: none, val: 'nj;‌j;‍' },
		]) },
		rt.ArrayItem{ key: 'small_words', val: 'GT' },
		rt.ArrayItem{ key: 'small_mappings', val: rt.create_array([
			rt.ArrayItem{ key: none, val: '>' },
			rt.ArrayItem{ key: none, val: '<' },
			rt.ArrayItem{ key: none, val: '>' },
			rt.ArrayItem{ key: none, val: '<' },
		]) },
	]))
	var_html5_named_character_references = iife_result_0
	mut obj := &Class_WP_Token_Map{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Token_Map) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Token_Map) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Token_Map) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_html5_named_character_references :=
		rt.get_superglobal('html5_named_character_references')
}
