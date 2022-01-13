#tag Class
Protected Class Advent_2021_12_08
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( kInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( kInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var rows() as pair = ParseInput( input )
		  
		  var digitCount as integer
		  
		  for each row as pair in rows
		    var digits() as string = row.Right
		    
		    for each digit as string in digits
		      select case digit.Length
		      case 2, 4, 3, 7  // 1, 4, 7, 8
		        digitCount = digitCount + 1
		      end select
		    next
		  next
		  
		  return digitCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as pair = ParseInput( input )
		  
		  var total as integer
		  
		  for each row as pair in rows
		    total = total + Decode( row.Left, row.Right )
		  next row
		  
		  return total
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Decode(wires() As String, digits() As String) As Integer
		  var translator as new DigitTranslator
		  
		  for each wire as string in wires
		    translator.AddDigit wire
		  next
		  
		  Translator.Finalize
		  
		  if not translator.IsDecoded then
		    translator = translator
		  end if
		  
		  var total as integer
		  for each digit as string in digits
		    total = total * 10 + Translator.Decode( digit )
		  next
		  
		  return total
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As Pair()
		  var result() as pair
		  
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).ReplaceAll( "|" + EndOfLine, "| " ).Split( EndOfLine )
		  
		  for each row as string in rows
		    var parts() as string = row.Split( "|" )
		    
		    var wires() as string = parts( 0 ).Split( " " )
		    var digits() as string = parts( 1 ).Split( " " )
		    
		    if wires( 0 ).Trim = "" then
		      wires.RemoveAt 0
		    end if
		    
		    if wires( wires.LastIndex ).Trim = "" then
		      wires.RemoveAt wires.LastIndex
		    end if
		    
		    if digits( 0 ).Trim = "" then
		      digits.RemoveAt 0
		    end if
		    
		    if digits( digits.LastIndex ).Trim = "" then
		      digits.RemoveAt( digits.LastIndex )
		    end if
		    
		    result.Add wires : digits
		  next row
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"fdceba bafdgc abeg afbdgec gbeacd abced bgc fcdge bg bedgc | bafdec cgefd gcebd ebcgd\ngbfac fegbda fcedagb bea ea abcdef dgbfe gfabe dgea gbdfec | gdea bgefdc bea efdbg\neg dagef gbcfeda ageb cegbfd gfe dbefa facdg abfged cedbaf | befda daefb egf gcdfa\nedgacfb gcfd dgb degfab bcega bdagc cgafbd fbacd gd fceabd | fbdac gd gdbcaf dgb\neaf bedgaf dbafc bfceag fedcbg eafdcgb debfa ae adge gdebf | abcdfeg febdg ae daebf\nafbdc aefg ea edbacfg dbefg eab gcbfde abecgd bgefad bfdae | gfea bfdea gbdef fcdebg\ndeagf daegc dcgabe abcgdfe gc cabg fedgbc cdg dcafeb ecabd | ebfcdg gcade cfegdb dcg\nagecd bdegca cfea af abdgef fbcaedg gaf dgcfb fadgce afdcg | fadgcbe ecadg bgefad fag\ndegcba cfbge cdgaefb gbecfd ae gafdc gfcaeb beaf cae cefag | feba abdcge becagdf bagefdc\nbfcga ecgdbaf facedg cdfae abecf eb dbae ebf ebcdfg cefabd | bafec ebf afdce egadfc\ncfaegbd adbecg ebgca debafg cdfge fa afg cafb fgaec afbcge | gcbaef cdfeg efgacb gaecb\nefacdg egdbfca bcdagf ceadg dface daf bafec dfeg fd cdgabe | efbca cdgae daebcg geafdc\nbeg dgfab geaf gdeab fbcagd efdbcag cbdefg edbgfa ge baced | gdfab ge gcbdfa badfg\ngdab bfdeca bgfeac becagd abegdcf edcgf dcb edbcg bgcae bd | dbegc dfbeac cafgbe db\ncefga dc fedcgb dcf fdabe ecbfda dcfea dabc debgaf bfgadec | gafec aebdcgf agdbfe cfega\nbfdec gbac bda dagfeb becdag cagebfd agecd feacgd ab cdaeb | ab bacde ba decgaf\ndbg ecabg gacefd dbaf agefd gebdcf fdacegb bedga fgbade db | dgb gbcefad dbg bdagef\nfbge gaedb eg dbeacf dgcafe gedabfc cdgab aegfdb dbfae ged | dgcba abegd bdacg begda\nabefg ad gcebd dae dfbgce bdeag dgacfe dcab cgafebd geacbd | agfbe ebcgd dagcbe egbda\ngdcfab cdeafb fg dbeacfg gcafe cbeafg gdcea ebcfa gaf fgbe | acfeb fag dcgae acfbgd\ncegfad fedb fbgadce bacdfg acbeg bad fcdabe debac db cefad | fdgcae cfgdea edfcab cefad\nfbg bgec efbac fbgca gb fbcdea bfdgea bdcagef fgadc cbeagf | fgb fegdba fbaedc aefcdb\naecfd agcdfe bdegcaf efbad bfeadc eb aegbfc dcbe bef dbagf | bcfead fgbcea eb aefdb\ngedab cfdbg egca dfegab gedcb fdebcag acfebd ce cbe decgab | acdbge bfacde bgade cedabf\nedfg fbgdae bagec feagb fbg abgdcf dbefa bdeafc agfdbec fg | dfeg daebf dcbfga gf\nbcgaefd cfbeg cdefgb fcde adgbec acgbf efb gebdc fe dabfeg | abgcf aegbfdc bedacgf edgabc\ndgfbc bfaegc fad dcea adcfg edagbf da eadfgc cdafegb geafc | da fcgad gdbfc afgbce\ncdea bafdgec gcbeaf bcafd fdbga bcd cd ecfba fcebdg efdbac | dfgebc cbd fcbad cdae\nafcegdb edagf ab gbfce ceab gdfbec fdgcba gbeaf gab cgbaef | ecbgaf bgafecd cbea gacbdf\nefgcab ecb bedf be cbfgaed bcdea cdefab ecgad fdacb gafbdc | adfegbc gcafbe fcbgae adecb\ngfecad gc egcf afcbgd ebadcf cag eagcd acefd bagefdc dgeba | gc acg dcafe begad\ndacgb cbadge dcf cf cdbaf afgc bfeda dgfebc bdafgc feabcdg | cgfa dbagcf fcag fagc\nfgb fcabd fdage bafegc bg dgface afgcedb adbgef dfbga bged | abfdc ebfagc agbdf dcfegba\nafd cdfega cdbgfe bgefad dfegc becfa feadc bcfdega da agcd | deafgc fabce da gbcdef\nfcdgb baefgcd fe dgeabc ceabd fde eafc febcad defbag cbedf | bfedca gdcbf daceb ebgdfa\ncbgf bg decafgb ecadgf dcagf gfabd bgcafd gbd cbadge dfeab | cgfb edbfa dbagf gbd\nbda dfgbec efdga cagb bgead egcbad ba dfceba degcb egabcfd | gfead ba gbac egbdc\nbd dab cbgdea dbge bcdga gdcaf fbdgeca abgce abdfec cbegaf | abd bd gebcadf dafcg\nfaegcbd bdagcf cdgbfe cb efbdg gdafbe bdc aegcd becf degbc | bc cb fgdabc bc\ncfbae bcfged cafdeg fa acf febcg fegcdba bagf afcgeb dabec | cfgbe egdafc fbgdec cbfea\ndabfgc gdcfbea cedaf gebda dagfec ecbf beacd bac bc cafedb | begda bc decab defcga\necd decgf gebc ec dcgaf cfaebd efdbga afebdcg bfedcg dbfge | dgfecba cgeb bfdecg aedbfg\nefb afbgdce fdceg aebg afcbg gdfbca efcgb be dcbfea fagebc | bgfaedc afbcg efdgc cgfeb\neb adcfeb eab dacbg gebcfad gaedb cgbe gafde gedcba gcfbda | abgde bgdae daefg cfbagd\ncdfeab cgfead bfgdca bfgcead dfcea bdeaf aedgb bf becf bfd | cefb dafce dcebaf edgcafb\nacfbegd bf gfb cbaeg gaefd fegab cafb agebdc bfgdce bcfega | fdbgec faegd eafgd gbf\neadfg gdc fegbcd ebdfc debcga bceafdg eadcbf bgfc gecdf gc | dcfbea debcf gdefc gdc\ngdb afbdgce gb gfdce dacefg edbfcg bdaecg fegb bdafc gbcdf | cfdbg dbfgc fcdegb debcga\nbfcdg befcd efgb cgdbea ceb eb fdeca efgcbda dcbfag dcebgf | gfbcd ebagdc dabfgc dfbgc\nacefdb afbgd cda ac adcgfb bdgeafc gcaf gabedf bgdac ecbgd | gfbdac dbgca edacfb dfeagb\ncfadb dfcgea aebdgf ba edfacb eafbdgc baec cdbfg abf cadfe | dgcfabe aceb edgcaf afdgeb\ncgfda ec cgdbea gedcabf dfgcab egcf beadf dfeac ecgadf eca | gfcbad feadc fcead gcafd\nedgfa gfbd bg adfcbge agfbde edcgfa abfec abecgd eabfg agb | fcaeb dgcefa facedg bdgf\ndb eabcdfg gefcda cbegdf dcbg bdf gedfb edcfg fdecab beagf | ecfadg cgdb bcdg gcfead\ndbeca cdbafg gcdaeb ec feagcbd fdbea cbe gdce bdgac abefcg | cadbg dacbg cbadg bagcef\ncagbfde gbaec cfbage fa bfcadg efacb ecbadg cbfed bfa afeg | gefa abcef dbfcga fbeca\ncdefg degacf dbfca dfcga cedgbf fdgaceb gaed gca ga gcefab | ecgdbf gedcfa gdcef gcdef\nabcdgf acdge eac ea dabefc aegdfbc edcfg cebdag abgdc agbe | aegdc bcgad dcgfe fedacb\negbcdfa becaf ecbdaf dcaf edabc cbf fc ebgfa bgdaec bdefgc | ebdcfa ecbfa fcb cbagde\nbacfed ecagf ad gadfe aed bdga fdgbe dfaegb gdbefc dbcafeg | gafec gfdeb fadbcge dcegbf\nfcdgbae bgcadf bged eabdc ed bcadg baefc acgdfe eda cdgbae | fbgcda bgcad faceb eagdcf\nfbcd ecfba aegdc dab bceagfd fbdeac db afecbg decab fagbed | cegda bd cgeda bd\ngcdeab gbedcaf gefc defba ced faedc cbgdfa dgcaef ce cgdfa | abgcfd cfgbad cgeabfd dfcga\nba gfdbac bdgecaf eafcb gface bfa eagb cgefad dfbec bfegca | ebacf ab gdafbc cgfeab\nfeadcbg fbg decbag ebgdfc faebdg dabeg feab fb dacfg fgbad | agfdc gefcadb gdfba gfcdbea\nbcgfead adecfg dcfb dbg agfdc egcab fdgbac bd gdbca gfabed | bagedcf gebca fcadg gbd\nadbfec afgecb edf cbefd fegcda deab cfbgd ed cebaf cefbgad | efbcd fegcda bfdacge fgcbd\nbf gcabdfe adefg fdgab adbgc bcgade efagbc cfdb bfa bcgdaf | abf fba bdgaf fagbdc\nfgeadbc bfcgd dcga cd bfedca abcgdf badgf fcegb daegfb cdf | cfd dc bdgcf gcebf\nbgecdf geab abd begdc defcba agcbd ab becagd dcgaf abfcedg | agfdc bda dab dbacfe\negca gcf aedgf gc dbfgae gebdfc fecdga adbfegc dcbfa afgcd | gfeda deacgf ecgfda deagbf\ncdfbg dafb gcbde bfc aecfbg fagdc agdcfb bf bgcdeaf cagdfe | ceafbg adgcf gdecb bf\ngeabfc ecgfa fgebd dgeabc aedgf facd fcedga ead da fbecgad | degfa cdaf aed bacdeg\ndcg cbde abfgcd fcgeab gaceb dc dacbgef cgaed degfa degbca | dcfabg dacgeb debc dcfbga\nagc fcgdaeb gdba dfabc fgced gecbaf efdcba agdcf gcadbf ga | cdefg fcebag ebdfca fcbega\nfeabdgc badef fg acfbdg gfed afbge afg dbeafg begac bfcead | fedcab fabge agbefd fcdbae\nbfcead cfe bdgafe cadefg fbdc bacef cgeab fc dbagcfe fbdea | adgfce cfbd cdfage fgacde\ncedg ebcda ebfcga efdbag dcfba cgeba de badcge eda fbcagde | cgaebf beagfd cbgae efagbd\ncfead acegd cedbgf cdafgeb dcebg dabcgf acg aegb ga eacbgd | dcefa agdce ga abge\nac bdcgf acbefgd cgdaf fdgbca dbcefg bgecaf cbad cfa gfade | gaecfbd adbc fdcgeb adcb\ndcgebfa fcdbg adcgbe bdfcae dec abcfe ed fcebag ebfdc defa | aecgbd dgcfb gcbaef bdfgc\nbecdg ag dbcfge fadegb dga ecgbda dgbaefc cafde gbca gaecd | agdebc bfegdc dcafe debfgca\ndebgfc dcbaegf dbg afgcd fecgb acbdeg bfgace gcbdf db bfed | fbed bgd db dfcbge\ndcegba gebac adfcg egd debc debagf agdec ecbfga ed fbecdga | dfbage deg efbadg fagceb\ncf dbfgec bfedac bcf egfc bdceg dbaceg fabcdge gbdfc gdabf | cfgdeba dgbcf cedfab cbf\ngaedbfc bdfae gfe fdgeab dbefg gcdeb fdbeca fg efgacd agbf | feabd fdegb dbafe bfead\nfgbce cgdfa ab gdbfea cafbdge cagfb cdgfbe ebgfac bace bfa | ceba afcdg ecfbagd efbgac\ncedgf gc gedaf faecbd dbfceg dcbg cge efbgca bfcde fcbdgae | eafgd cbgd fagde edafg\ndbgfc dbfce de dbe cbgefd dafbcg cabfe debafg fceadgb edgc | abefc cbfadg bcdfe cdeg\nfabde db fbeac dbf dfega ebcfdag cefdba cdbfge dcab gfbace | dgefbc bfd db dacb\nfgaedb ecd dcbfe edafgc dc bgefc edfcab dcba afedbcg fabde | bgcfe fgaedc cd dfgaeb\nadcfe dbcga eb dbe bceda cafgebd aefgdc bedcaf fagdeb fbec | abgdc bde deb bcadgef\ndacgf gafdeb ag cabfdeg bfdac dbfcge gdeacf geca afg cdgef | fcgbde cegfdb fdecga degfc\nfc cbf gfbadec dabef cbfda acebgf gdcf bfgcda bagdc gdebac | gecabf dcgf fbc cdgf\ncbdafe fdabe gdafcbe bcgade adcf dfegb abd agfbec da febca | acgebf bdfaec adb agecbd\nebgfd fdgcbea dc gfdecb edgc dgabcf afceb dbc bgdfae cfbed | dcebf afebdg adcfbeg gbefdc\nfaecbgd gd gabd cdebg dbecf deg cagfed bcaeg fcgabe abdceg | cedgb gebdc cefgad aegcb\nde gbedf dgcebfa gbfae cbde cbadgf dcfgb fedcbg edg cgafed | fgadce daegfc de eagbf\ngadfbc ec bagcf edfacg begfc ecab gdbef cgedafb ecf bgfeca | fbcga dgecaf fce cbea\nafe abdfgc egfcbda gabcf edcafg gcfeba acefb abeg ae ecbfd | degcfab dfaecg gdafbc ecafdg\nacgdb fbgd decfa fg bcegad gfa debfagc gfcbae cabfgd acfgd | bdcga dfgca dagcb cfabgd\ngefac ecfdb acdfbe adfegb gabefcd gd dbcg gdefc cfdebg egd | gdbcfe decgf efdgc gd\nadgfe gfcdeab fgdbea aefcd dfbgec abgf eag egfbd cdbage ga | fgdcbae dbgfae bgdaef edgaf\nbgfae degb cadbef cbagfe dba db gcabdfe fgbad dbegfa gdacf | adgfb dbgaf fcedab dba\nfb cabdgf becgda bgaf gbdfce dagbc cabdf bdf bfagced edcfa | dbcfga badcf aedcf bagdfc\nbdaegf ebgd gdfeacb gd gafbc agd bafgd ecgadf fdbeac dbfae | degacf egdb ebadf dfbeagc\ndfecg bdceg dcbafg cafgedb begdca gcf afedg gdbfce cbef fc | dcfgbe egdabfc cfg fdega\ndgfcab cdefga fcebdag cb bcd abcg dfagc bgfcde cadbf dbfea | bcd fdcbeg gedcfab gcdabf\nedgcbaf gcaf dcbfeg edfcg adcge dceafb cfdage dbeag ace ca | dcbfge fadceb cdegf befacdg\ngacde bgdac gdcbaf fdagb bdc cfbeagd bc gcbf abcfde fbedag | dabfg eafbcd bgcda aefcbd\nebdcaf cegbd afdbceg faeb cgdefa bfced ef cbfda cef bagdcf | dfebc cfdbag ebcfd aebf\nbecgaf adceb decg cad dcafgbe efdba fdbcga bdcaeg cd gebac | bagce dac gbcfad adfbe\ndcaeb geb dgcfb gbafec ge eadg daecfbg ebdacg deacbf ebcgd | dgcbe beg adbec bfadce\nbcfega gcdba gfcab cebgd bdcgafe agd afcd geafdb ad dcagbf | fdca agfbc fadbeg gefbca\ncbdea ecbfd gecafbd def ef efcg fabgcd agedfb bdfcg egbcdf | ecbad fbgced bcfdg fde\nebgacfd gbfeac gcbde degac ace gbadce gfdac fgbdce ea abde | fdgeabc bedgca ebdgca bdegc\nca gaedfbc cfa dgfabc bcdgf fbdgec geadf agcfd cbag bedafc | fdcgb bcefdg gdbcf acf\nfcg bcadf cg cfgbde gfbca ebdfacg geca defabg befga acbgef | gfaecdb gbfca fgc gebfa\ncafegb dc gcd dfacg cefga dfagb cade bcedgaf dfcgae bfecdg | cbedfg ecad cd cgaef\ndfcba ad gbdafce bfgdc fgebac dacebf dab dcae gebfad bacfe | bcdfg caed ad cbgfd\nabfegc dbfea aedfgc fdcag cdbg bc fcb fgcdba cfegabd cfbad | fdcab fegcab bdeaf bc\nbcedf abdec ae daegcf gabe bdcga facbdg daecgfb dae edagcb | dea cbdfe bage ea\neagdfcb adceb dc fecagb cedgab cbeag daebf dgbc adc acdegf | dbgfcea cbead gbfcea geadcfb\nebadg cdb afbgced badgef bgacf dbcag daec cbedag cd gfcbde | baecgd acfgb adebgc fbdcega\nceagf egdac aegdcf bgeadfc edc afbecg cfbdae ed gedf bgacd | cgebaf fegacb efcagb ebafcg\nadfgbce acgef adbgef egcfad cafdb cafgb fgbeca gfb gb bgce | bedcafg eacgf gfdace gbf\nbaefgdc deacfb egfb gdace bcaefg bg gba aegbc eabfc cdgfba | caged dfaecb gbef ecgbfad\nca edgacf abdgf gcefba dace gca ebgfcad bdfegc agcdf dcfeg | adefcg fgcbde afgdb ac\ncdafg gdf agcfe fgaebc df dcabg dcfbge acgdef fead gfeadbc | gdfac gcdab fd fagec\nbedag dbfca gdfe gedfba baecgf fe efa dcgaeb defba efgbadc | dgbea bagde aefdb abedf\ncabegf ecbagfd aebcgd dg cbgad gaecb dcge cadfb bgd ebfagd | cegd abgcde gdb afcbd\nabfcd agdef efc bdafgce ce acge gdfcae efgadb efdgcb edcfa | acbdf cfabd cafde gfdeba\negca bcg dfbaec gefdb ebdac cfbgad cg egcdba becdg bfgecda | ebgacfd becdg ebfgd edgabc\nbfaegdc gfeda ecg ec bacfg cdae aedgcf efgac egdcbf begfad | gabfc adfge afbcgde fbgca\ngacbf adgfbe gdcbfea bcgfea bdf agcfdb cdegb df fbdgc cadf | cedbg gdcbaf gecbd cgdafb\nfgbac fbgad gefcba dbeaf abcfgd dg fdg bfdagce gadc fcebdg | fbdea dbegcf abfgced acfdbg\ngae cfabg dbceg fabgced ea fcbdag ecfa aecbg bfcgae faegbd | aebgc eafc acgbe bcfadg\nfbcad gcbefa acbfdge ecgd cegabd ec dbage aefbgd ecb cbaed | ecadb agebd bgdaec decg\nbegac eg ebcfa fgbdca eag gcabd gdcbefa adebgc cged dagbfe | eg eagcb gfacbed cgeba\ngfcdea dbeac ebc bdfceg gfecbad bega agdec bcadf eadbcg eb | cegad cdaeg ecgad gedac\nefbag egfdba agbd fdage gaebdfc daf gceafb cdegf da afcbde | abfge abdg begafc ad\nceda gfedac ad aegfd egfcba edfgb agfec agd gafbcd gbcdafe | gfdeb ebdgf fcbgea aedbgcf\nfagb cdeag bgfde af afe dgfaceb feagd cabfde bfdgec adbfeg | fcbegd gfaed fea fea\nefcbdg fdagcb de cefba fdcgb dfcagbe fed cegd gdfeab ebdcf | ed gced cdeg ebfgda\ncbdeg bdgac bca aecbdf bdgfec cafgd acdebg ceabgdf ab gaeb | gaebdc geba cbgade ebag\ngedac afcgdeb begc bgaecd fabdcg cga efdac eagdb cg daefgb | dafgebc eacdg gc cbeg\ngaceb bgefca eg bfeg age aebfgdc ebafc abcgd badcef gafdce | bfcage bfeg fcdbgae gabec\nebgdcf aedf gcfda gefdca eabcfg dgf fd agcdb ecfag fgbeacd | cgdaf gdcba feagcb fdg\nefbag efg ge fdgab befca dfbaeg gdae afbdgc gedfbc fgdbcae | ebgaf edfcgb fbage fge\ngaefbd bf agfecd efadg agfb dbgef ebdcg acefdb feb aegcbfd | egfda gafde gbfa bfe\ndafebgc bfdecg cdaebg da gcdbe dab bfceda adge bdcga bfgca | dcgbae da cagbfed daeg\nba gcfad adbfg fabdeg dbfegc dbcgfae acdebg aebf bdgef abg | faeb bdefag cgeabd egcabd\ngafb ga fdcgba ebcad gbfcd deacfg dcbga cfegbd agd agebcfd | gecfbd cfbegd cbafdg cegfbd\nfa fab cfbea gbeac cefdb cebagd cdegabf cgfa dabgef faebcg | abf efcab bgaedf gcaf\ncdafeb bg aedcg gab acbfedg gbfd bfaecg bcfda gabdc gdfbac | bg gcdae bgdcfa fbgd\nafdgc gefbda ebfc dgfec dbfge cbdfeg gadceb ced ce dbfcgae | ce edfcg bcef dcgbef\negbafc fdag ad dcbfaeg cgfba dfacb baecdg dac gcabdf edbcf | fgabecd bacefg agdf befcd\ndcefgba edaf ebafc gbecaf de cedfgb bdace cbfead agdcb dec | gfaceb ed gcbad begfac\ndcea aefdb eaf badcfg ebfdg beafcg ae befdca ceafgdb bacfd | aef dfbea fdgabc afe\nag bgac dgfebca gea gdace bceda gedcab bcafed egcdf ebdfga | cabed bdeac dcfeg eadcb\neacbf ecabgd abcegfd cbage agdcef dbge bgc bg dgfacb dagce | cagbe cebdgfa edacfg bg\nabd db cdbefa dagfeb dceaf fcaedg cbade fcbd egbca abfcdge | decab aebcd cafbed cadbe\ngdefb deg bfgaed ebgaf afed fgbcd fbedgca adecgb ed gabfec | fdbcg faegdb fgbae egcfbda\ndecf dbfgce ecdfabg acbfge dbe dfbeg fgabd fcegb bdagce de | cegbf bedgf de fadbg\nabgedf cbag fecgd ebcfg fcb bc cebfad abfcge egabf bcegdfa | egfdc abcdef fegcd cgefadb\ncadf feabc da cbgafe bfcdea adb bdagec bfdae bdcegaf gfbed | bcafe adbegc cbfae defcgba\nbdfe db gcdbfe bfcag edbgcfa abegcd fbcgd dfgec gbd adfgce | dgabecf dcgfe db gcfdb\nacf afbceg dbfae cf ecfba abdecgf cgbea gcef fgabcd dbaegc | cfge afedb aebcg gdbcafe\ndgabce fbcea eafdbcg fdcg cd fgdecb fedgb afdegb dbc dfecb | cd dbc aedfbgc cdegba\nfagdbce abd fgbedc decfb bfdace baedc ebfdag agdec bcaf ba | daecb acfdbe cadeb dba\ndfceb bcfedag gbecdf dgfe ebdcaf fg fcg cafdgb ebgca gfbec | bedcf dcefb bfcaed abdefcg\ngcfba badegc bga afbdcge ag fgebc bfacd dfcegb bafegc faeg | gedcfb cadbf fbacg bcgefd\ncbg aedbcf ecbgfda cg fgcdbe ecfbd bcegda afegb bfcge dcfg | fbdce gc bcefd gcedfb\ndgbcf ebgd fgdbca agdfec bdfec ed efcgbd cdgaebf fde fabce | fedacg cdbgf ed efabdgc\neafgbcd afcgb gbfcda gecabd efgcd acgfeb gecfa ea gae feab | edbgcaf dbgeac gacbf beafgc\nacgfdeb cegabf beacg bacfd dbcea gacbed gcdbef de edb eagd | de dgcbfe ed daeg\ndefa cdbagf bfa agbfced cfbegd efdgba egbaf egfbd bcgea af | fa fbadcg gadfebc cafbdg\ndgebcf degab afed gafbd gabfed df gdf bafgc bdcega daecfgb | cebfadg debga abgfd abgfecd\ngdeca dcegba dcagfe ageb acefbgd egdcbf bgd adcgb bg bcadf | fgedbc gbdcef ebag gfbced\ndc edbgcaf cbadf fdc bfdgac bgadf cbgdef fdageb ebafc adcg | dgbaef dfc bfeac bacfe\neagcbdf caefdb fceda egfab bdca gbdfec efcdga bc ceb eabcf | bface bc bfdeca faecb\ngadec becgdf aedcb gfcdae edagfbc dg gefca acegfb fgad egd | cdeab fagec gd dcgafe\nabdc cedag cd fabdcge agebcd gdeab feagdb gaefc ced gdbcfe | baged fbceagd ecd edc\ngcadeb gabed gfab bdfec abfged fa ecgafd fad gfedcba dbfae | fbced gbaf aegcdb acdgef\ndf bcgfe fdb beacgd gefdcab fead aefdbg fbcgda edabg dgbef | efbdg gdefb eafd baefdgc\ndaec bfgde gedabcf bgcad ae dbgaec age afcdbg dgeab cafbeg | eag beagd edfbg degbac\nfgbcad agbcd aecbd febcgd fdagceb gdc gc gfdba cafg gaedbf | geafdcb dgefab ecabd dcaeb\nbfgca febag dgefba egda efcbda eab fdbge ae egfcbd gacdbfe | aedg efgba dcagefb efdacb\nbdagec ecbfa daebc gafcb cgdfea efa fdeb dceafb ef gcfdabe | efcba cabged gfabc fbacde\nfe gfabe dbaceg aegcbdf dfcbea fcabg deagb gfde edagbf efa | aedcfb efa afe fe\nadfceb eb gdeb fegbda bcfagd fbe agbdf fgeac gafeb defbacg | ebafg feb agfbe bgde\ncgdaeb ade agbcefd adfecb febad aecfb efgabc fadgb ed fecd | acbgef facbe cgbafe deabf\nbfc fabdgc agcbe dfeac fdabceg ecabf fb bdfe edfcag bdfeca | fb cadebf gdabfc cfbdga\ncfbdge adegfbc cdgeab fbg gedf baecgf bcfda fg cdbge cdgbf | fdge gbecd egfbca cfadb\ndbcfeag gecda bed eb dfcab abeg agfced dcebfg adgceb abecd | be gabe bed fbdac\nfbagec ecfga fgdac ec cbfe agbef gce aefgbd fcgbdae gdaceb | fbadge cfgda gfbace egcaf\nbdcfge cbaefgd cagbde fecab fdecga gafd dfe fd gdace edafc | efd daecf cdaefg eacbf\ncefgda daefc agecfb fce cgdbefa dfcga dbaef ce badgcf gced | fbdgcea ebafd gdefacb fdcag\nebagd fb fbgd cefda ebcagf cgfbade afegdb bdagce bef badfe | ebafgd bfdgea ecdfa bfdcega\ngcedb fdcb aebgcd bf fcgabe cfbaedg fdbceg bfegd aedgf gbf | bfg cdgeb fdebg cebdg", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb |\nfdgacbe cefdb cefbgd gcbe\nedbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec |\nfcgedb cgb dgebacf gc\nfgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef |\ncg cg fdcagb cbg\nfbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega |\nefabcd cedba gadfec cb\naecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga |\ngecf egdcabf bgf bfgea\nfgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf |\ngebdcfa ecba ca fadegcb\ndbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf |\ncefg dcbef fcge gbcadfe\nbdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd |\ned bcgafe cdgba cbgef\negadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg |\ngbdfcae bgc cg cgb\ngcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc |\nfgae cfgab fg bagce", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadState"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ThreadStates"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Paused"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
