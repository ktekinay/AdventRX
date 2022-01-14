#tag Class
Protected Class Advent_2020_12_06
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( Normalize( kInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( Normalize( kInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  return CalculateResultB( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var groups() as string = ParseInput( input )
		  
		  var count as integer
		  
		  for each group as string in groups
		    var d as new Dictionary
		    for each c as string in group.ReplaceLineEndings( "" ).Characters
		      d.Value( c ) = nil
		    next
		    count = count + d.KeyCount
		  next
		  
		  return count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var groups() as string = ParseInput( input )
		  
		  var count as integer
		  
		  for each group as string in groups
		    var people() as string = group.Split( EndOfLine )
		    
		    var d as new Dictionary
		    for each person as string in people
		      for each answer as string in person.Characters
		        d.Value( answer ) = d.Lookup( answer, 0 ).IntegerValue + 1
		      next
		    next
		    
		    var keys() as variant = d.Keys
		    var values() as variant = d.Values
		    
		    for i as integer = values.LastIndex downto 0
		      if values( i ).IntegerValue <> people.Count then
		        keys.Remove i
		      end if
		    next
		    
		    count = count + keys.Count
		  next
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As String()
		  var rows() as string = input.Split( EndOfLine + EndOfLine )
		  
		  var result() as string
		  for each row as string in rows
		    result.Add row
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"c\njc\nck\ncue\nc\n\nysjircxtgfzpb\nynsxpgtcifz\nriydpzsfxutcg\ngsyitzdvpfcrox\nyclxfzietsmghwp\n\nbacqdjhsf\nfhbdjacsq\ntbjmcxlqashdfo\nhebjascfdq\nbgqjscdfha\n\npt\ntp\nxtzn\ntu\npt\n\nzjn\nnzj\n\nh\nh\nrzh\nh\n\ncfqurmlxnzhpy\nwjaufshgemktox\n\nah\nahe\ntvhrq\n\nawbte\ntbawjen\nwtubea\nwjaebt\newtab\n\nvlz\nlv\nvrqyl\nlv\nelv\n\nrfu\nrpujz\n\nfoniw\nnfo\n\nkaumhjywgtvzndcire\nqulkzxoinadvtbgymh\nvgdzlahiounmykt\ntkglyzdunsvmhoxiaf\n\nrxmdbgikaywentqvzhfolcpuj\nenipkytvdmbgqzaufjxlohwrc\n\ngdhiqazwcv\nmouqpltacvw\ndcvyqhwfaj\nwbhgaevcqn\nvawqkcxr\n\ndmtaowgp\nmwtdipa\n\nrvpwoshm\nosvprmwh\nsmwpfvhr\n\naxmhdqzctfspgeu\nzpmcauexshtfdq\ndqfmteacshpxzu\n\nptryjvufglaxmqwonck\nnupfyjrwktlmxaqgvc\ntjgapcflbmuynqwvxrk\nrwjgnauflvymcotkqxdp\nsejyrkqtwalhncxuvfpmg\n\nkjlucpqysrbe\ncotlifeqgmspzkdr\nprasckbluqe\n\nsvjwcigopdflhy\ncorvxsaigbflwheyqzuj\ndfclkgmwsvyithoj\n\nsxrynelg\nelygxoms\nglmexyt\nuyxfgelkb\n\ncljshbxnaeqrivupwtgz\nqplrtgeshxviaunwcbz\nwhcxivzgtaneqpsrbul\nlvgzibncxwrdopqeatuhs\nzlqcvbmrsktwpeaxinuhg\n\nfngcrihykv\nirhgfkvcny\nivpcfgkhrny\nckhyirdfngv\nvnchisygrkf\n\nrsqmk\nkufbscval\nyjksih\njksmo\n\nknszclmhryfvgdtwj\njhrwzlgdfyqcv\n\nulbyhi\nyqhuzsim\nhkienuwfcy\nyuhpio\n\nnqblomzhgtikdwjpcasyvuexf\nkngcjvymbzqoahesfi\n\nxlebgtjpz\nsvlqfwkuaipbmc\nrhgxplndb\nlpzjbyo\n\nrzqpashvw\ndmlcoq\n\nhkxi\nkixh\nhikx\nxhik\n\npljraokdmec\nzhtdrlaqfgbnue\n\npeofrnkgauhzctwldjb\ntgnbokrjufmshd\nygktbmnuodshrfjx\n\nbfzqvolaymsxue\nbeyvlnfsqzuxao\nvfozbaisjyexhqgclrwu\nfsxpaobulvzyeq\nflzxbesauqvoy\n\njipavclbehxrngdwsk\nmkjshalwdxqntev\n\nixrtj\nwcmxij\nmjwix\nxzvjghbdnuqi\nixrjs\n\nlroxesmfqdbt\nqtloefydr\nlerfqivnjodt\neokdmftlxqr\n\nakow\nka\n\npnjkvoxatm\njmktpoaxnv\n\nufejltwq\nteqfljuw\ntwqjufel\neultqwjf\n\nucoleqmyxfwzhnriskt\nlnkfuiythsxrzwemocq\n\nfvwakuorhpzyjmxl\nahltpwjozkxmf\nwkpjzfhmdlexsao\njxolzknmhpwcfa\nlfjhtsxqkmwoazpd\n\nguoytrawsiexknq\ngopukszvctnjbai\niaglmuotnsk\nkgdisuotafn\n\npdtsnx\nns\n\nign\nngi\nding\n\ndhryg\ncksn\nih\nebpo\nqxs\n\nbavsrfcntmgqxu\nfxbnvpasmuogqc\ngcusamnbfqxv\nikmnhvybqgxcdfusa\n\nk\njk\nk\nj\nnh\n\nmjsfl\nomisj\n\numdoiqabcrhlyf\nolymbihfdusaqc\n\nwuvymbghitrelazpok\ngsmrepwzkuthbvil\n\ngfdjb\ngbfjd\nfgjbd\n\njdxghipmorlvfzw\nzqlcjwfrbvpoxmid\nenwrflodjzstapmuyik\n\nlaiegdk\nnvhqlgz\nxscuf\n\nubtdong\nnubdysrg\ndgubn\n\nn\nn\noycw\n\ndmlewthyrqnkxagvszb\nvdgkyxabtqhnzmsewlr\nhdbxnvtwzyspkqagmelr\nhnzlrtywdfaqsjbemxgkv\nmrkqbdsyaegvzlwxtnh\n\nrkouvs\nkpobrgq\ncxknfrow\n\nuyve\nuyve\nyvuce\nvekouy\neuyv\n\navgoinutrxjymlpbqwhsek\npwirvaostmgjukxnqhebyl\nokndimpehgtlsujqaxbywrv\nanbvohsetlpqirxyfjkmwug\njqenglrhkuixbyapmvtsow\n\nzbos\nszbo\nszbo\nobizs\nzabso\n\ndstiveo\nedsivo\nevodsi\n\nvimbcytwuzajlqogpkfrexd\njdubvxkeofqrgzytipncla\ngpkqrlyofaxzictejuvdb\n\ndb\ncbd\ndb\ndb\ndb\n\nk\nk\nk\nk\nk\n\nwqo\nqo\noq\nqoc\nlikmqoef\n\nvdfrjn\norjfna\nfmrjnd\n\niyashplx\nhaslxypi\nahpsxyil\nyxhliaps\nhiasyzpxl\n\nucdlfx\nlcxudf\ncxdflu\ndcxulf\nfxlucd\n\netfhylmiajvcdxnqbps\nfastbwphiqdlruxymcokv\ntsxfidhcymqapgblv\nspzhavtmdqgjlyicbxf\n\njxc\ncjb\n\ncowg\nqxzwajco\n\nrypjntgd\nsplna\npxuvcnke\nljpmznwrdft\npodn\n\nuowirdqvc\ngtpimard\n\nhntmubdlvspagxqy\nycbfnkjrzw\n\nbjvnyau\nuakxynm\n\ndanpzlubyhgsfxtkvjriewo\nfahtkzslbpwyijongvrxud\ngalonbkpxzsdwtfrivjyuh\n\ngspxvjoq\noiqzjv\ngqpjov\nqjvonr\nujmahqyeobv\n\ngzuovxlmwhjbesqipak\ntcjkrfanexgudqsb\n\nxkvgzaqfeih\nvkqgiezcfxh\nhzxkfvqgei\nkxigvqhezf\nyxgzkhefdivq\n\nypaof\nopya\nyaop\n\ntiefwhqyzxr\ntljiwxyeqhrzf\nqezwhtsifxry\nzfrpxeqytwhi\n\nfbscaxrhpdeqz\nrehxpfg\nfhroxep\nkpxhtref\n\ntynqhrdulomfxazgipjb\noltrqiwcfjaspvuekn\n\nepbvtfldsixj\nxcdnzbetv\nzbvltcadx\ntxzbmvd\nqktdovwxuhb\n\nuqtewcsrdiyphkxjvboz\nhovsxtqckzurwipyje\nxcpwthszuiknjoyqevr\n\nbqckxnvtdfspzu\nvcfdanxspzkqtbu\ndxckstuqvzynbpf\n\nhjus\noxsuhj\nhjsu\n\nbxait\nbftijxaw\ntabix\n\ngvmdl\nkfla\nutpywqrsz\nngol\nxiha\n\nydvxqtkarigh\niohkgyczqtdrxs\n\npzhxoytmave\nxzamvptoyeh\nstimxyevapzoh\nvxmohptayez\nhlvpyamoexrzt\n\nvdjsy\ndsyv\n\nwedcxpt\nviawqdpefco\ncesudwp\nupwtdceg\npweucd\n\nu\nu\nu\nu\nu\n\nunwkls\nfkuanylm\nlumank\neqlorxcgkuvtn\nlzufnkh\n\nwembhayqcks\nbksyqhceamw\nqwceskyabhm\niwekfymbchqas\nsormjywlhbzupckaeq\n\nkrtohjcvxidyfm\nsewgzil\npiwbza\nuqib\n\nghpnicabeuroftvkyzm\nraionvykhtfcbpmzgeu\ntnzgcvubrhaefmkpioy\npvfnetiycurkomazgbh\nhonmbpfvzctkiryaegu\n\nq\nh\njdg\n\nbykvmpgojzwlrcexi\nyzwerjpcbgkivoxlm\necvyijmbpzwrkxgol\nwyjripkzlmcxgoebv\nljzcrwoemkpgisxbyv\n\nugmaicqtejkbhsx\nxtahjbsimcqukeg\nximchajkfgtvbuesq\n\nnrqfdcghioslp\nlzsrthgfndoip\ndrslpfgniho\n\nq\nfqb\nq\nqfdz\numaxtq\n\njoucqnzsgt\njgquo\nuoqgyjpb\neojlqgu\nujgkwqo\n\nlhcrnxkogepw\nwheorgpcnxkl\nwrexgponhlck\n\nchgqirekozbypjst\nhyqdvsjbrctzgpuoi\n\nfylsimtuvad\nytgdhicfjauvml\nvafiuldmtyp\nuptifdslmvay\n\nobkuc\nwnm\nrvgqdayhjte\nx\npfs\n\nyrkv\nrdvyt\nfynrejcw\nyrdk\n\ndfqnchypg\nhgypnfdqc\npcqhgydfn\nqcgfjhndyp\n\nb\nt\nt\nt\nt\n\nehajgwscibr\nuhdcmiwbjr\nirbknwjhc\n\ngihcrjazpld\nadgsnzjxlihrp\nlzfhgdajpir\nrgzlhnjqidpa\n\nrzpvjmbuac\nqwbgmzurcpj\nujpmzbfrc\nmucbrfzjp\n\nfu\nfu\nuf\nfu\n\ntliwkzcanyjebq\nmealtnofizcqjbsw\n\neakbolcjugnmwdhrzy\nelumwbzorjhnkcgayd\narnhycmjebduwgolkz\nzbwaklmordhcgejynu\n\nysnalmr\nlsynrmf\nsimnbrfl\nlsnimr\nkmqlwsrxn\n\nozbdtcgifhe\niocmtzdgefvh\nefcgtdihzo\noczphgetlfdi\n\nwumdilea\njyahzgspq\niba\n\nwsonzrb\nrboszwn\nozbnysrw\nwbznros\n\nwzumjfrvscpq\ncliwvsqbfzpeoru\n\nd\ntdpm\nrd\n\nvgnpfu\nkgpaqictf\n\nphjlzk\npu\nup\niwp\n\nedsbcnioxqlafupywkh\nlfbqrhnxiseacyjkpow\nxgeonhfqcybsapkiwrl\n\nwvczikeobyuamfpd\nbxroupgizjkaytcmenwf\n\nq\nq\nq\nkq\nq\n\neintqz\ntqin\nqitys\ntifqxkh\nqitsmv\n\nhdtzoyjrqkwpalv\nowzjvahkdqlyprt\njhoywtdvkrpazlq\noyzavltphdkqwrj\n\nsxgfl\nfxlge\nglfx\n\nntozcvdqes\nordesnczqtv\nntedczuvqos\nsvtaeodcznq\n\nlcpoi\nuxinkaol\neyoila\nowliy\njzhqdtlirmfsbgvo\n\nmje\njem\n\nkqunjoi\njiuno\noinju\ntohinj\nuionj\n\no\npcgodj\noi\no\nosi\n\nsqvmoejdgibuwyxrknfzapt\nczlystrwjvpef\n\nybtaflcopmirjdusxzvkhq\nzlevmpqauroticjhbgkxfd\nfrumxlpzqivcwthkbdaoj\n\nwdivrf\nfzritwjn\neioxqhkyfs\nfiv\n\ngvs\nscmrg\n\nvzgt\ntzg\ngwozt\nwgzto\ngtpdz\n\nrvh\nr\nzr\nr\nrdw\n\nfqkxosbgwynic\ncsfikqnbxgwyo\nkogibcsqynfwx\n\nrpzsjhlaefxbvmodunigw\npxwgvfdlonieamhbsrju\n\nprgk\nhepxkrvgi\nkprg\n\nesfjanprvxzugcqdyowimhl\nktihxpnvwzogrclysbqadme\n\ncdykos\ndisycok\nkdysloc\n\nchgzpxym\nxhpgmczy\nghcyzpxm\nhcpxyzgm\ngpyxzchm\n\npvkzy\npvgkxy\npyquvfcl\nywdvmhprena\ncyvupq\n\ntyobwsehjrfunziqmg\ncwujptqkreodvmfa\n\nr\nnb\nc\ndktyap\nsn\n\nmaqevwtijbnlp\nvrlkjawbmqnipt\n\nphizanuolbfgrt\nbzipnauglforht\noignblthfapzur\n\nfd\nd\nd\nd\nd\n\nrazemjtpsxgiq\npeqmsarxgjwizt\nixjtzeargmpsq\nitqermazxsjgp\nztmiqsxajerpg\n\ni\np\npu\n\nitkxhb\nbuxki\naicksxdpb\n\nqpczutx\ngczjuhtq\n\ntxqncbg\nqtogvjcb\ngcqrbt\nbcaqrtg\n\neqtwvkrnhusy\nnjtsqhwru\n\nua\nakcq\nai\n\nmgdcoxrnwvletpkbusihy\nbdmslhpkgonvreiucyxtw\n\nlfoazxqyw\nyrpbmnkceu\n\nj\nj\n\nuwrzpvaxindebtloch\nizvoxwbpuanrchet\ntmrakvncphwiezobxu\npwruaixbhctvzedlon\nrsebuowhxigtnjpcvqaz\n\nmsnvf\najx\n\nvgahuqimkblfyjexotp\nhygaiepjlvuksmxoqfbt\nytlhbfmkoxujgedpvaiq\n\nxcdv\nxgv\nvxlu\n\nkm\nm\nmfk\ncyqwm\n\nrawphceqti\nylgmjconzbvsu\n\nlwy\nywl\nyldw\n\ncmgsiykfd\nicmgksdyf\nmcdfsgiky\nimksdcfogy\n\navptxrnwubqi\nvunbxwldt\nvzkocbwn\n\nsvhkjpfmzudeyc\nhpmugixtezkavjd\nzeqpxvmhdukj\n\ntw\nztw\nwt\n\nbwfjxu\ntjfvwub\nubnojfw\n\nktnipjyeq\ntkiwyb\n\nwmhqjc\nhjwmcq\nmhqjwc\nhmjwqc\n\nhkzjgb\nhgbjk\nghbjkz\nkgxfbjyh\n\nofwinqzbmkjgdxv\nclbfwtozkiaugdvjnpqeh\n\nqmdrsbjeptgkw\nwpnqkregtd\nkfqewhdlgirzp\n\nsgqkuptxlvic\njkpgsxbt\n\nmvfik\nxnljsuek\nkibrpzfh\nbkmcwr\n\nqzyv\nyvmzq\nqvz\nzqvg\n\nvxjbaeirnylzhocpkqwstd\nqvsuyerpthjwbcaizlxodkn\nozsaxtledcyvwpkjngbrihq\ncsvirwzhjoxlbnkqdtyape\n\nb\ncoxe\nu\n\nkexawtfpg\nguwfptxake\nxpkgfteaw\n\ntgnr\nnrgt\ngrnt\n\nkludgpxi\ngkdxrp\n\naibgqykuvs\nbzgausdvwciq\nqvbsgniua\niusqjvabg\nbpvusajiyqg\n\nw\nxu\nkbu\n\nu\nu\nu\nu\nuoei\n\nzogb\nob\nob\nboe\nsbo\n\ncs\nzm\n\noleqm\noilq\nqmlo\n\nwoxzdcshnl\nldoshwxp\n\nntkbjxpqwhlmecsrdga\nqpebarkoizywsxmlfgdju\n\nmxk\nyxm\nkmx\nxym\nxzvmb\n\nnl\nno\non\nn\nn\n\nfqlyezxtjgoa\nhyeoatksq\n\nkhtj\nasmu\nthkn\n\nt\nz\nz\nm\nz\n\ntyz\ntyz\n\ngkmdubiacx\nimjkudgcx\ngdumcxik\ngmuckidx\n\niysarmnfphgctzj\nhngozfpmstayj\nyaskgvuqmdzhfnpbexjl\n\nedwvrzuloqfsctim\nwromkzfdaicelvqnt\nwokdiecqtvrsnmuf\nkemtocfqvrdisw\nowjdtqicxyfvgremhp\n\nihdrnakm\nandmkri\n\nojetcq\naubtkl\n\nqsyfchx\nhykvzfg\nxye\nrlwioyj\n\nodzqbvmlrfkjgye\nvwlojbqdanrxtsyk\ndohigvpjqyblkr\nulocbvjkyidqrp\n\nketyogpsabhzwxiqfl\njixcwguhefqzkmbdolatn\n\npko\nkpo\npko\n\nwm\nwm\nmps\nm\nmw\n\nnghwmdf\nhmfdgw\nhfmgdjw\nfmhvgdjw\ndgwjfmh\n\numnkpzedga\ngpokqdzmeun\nmhctzkgnuebdp\njpszkgeyunfdrxm\n\nbfcdysziphquxvmjagen\nzfduabihvnqgpjsymcxe\nnzabmuxyvijqfcedgpsh\nhpsxnacvfdqguijbtzmye\ncbsevkuanpdhmqifzjxyg\n\nhrjlbfwq\nrfjwqbhl\nfojqbkhlm\nqfhjbls\nqhlfcwjbu\n\nvfjicx\nvjicfx\nfcxjiv\n\nj\nuc\nn\nq\nq\n\nbmrvzsa\neaoqubzxmrnf\n\nyjnvze\nnajyvtze\nzynvej\n\nwf\nfb\n\nbejpn\nbpnje\n\no\nyc\n\njwhsena\nuw\nutwn\nnwc\nxmvw\n\nhtsqagwko\nlydzerxjunvifpm\n\ndrujlenvswomythgkp\nxaeypwrhsikbtucdlgn\nazylhrdkeftsnuwigcqp\n\nopzvefmcgst\nepscmzofgtv\nozmtgevfcps\nzgotvspmfce\ntspzfgecovm\n\nuvsi\nepgju\n\nsrbpygw\nsdwoyebv\n\nwiacz\naiwzc\nazicw\nwczxapi\n\nvria\nrcvdah\n\nqvleubajx\nbuvqxealyj\n\nvegtzmpl\ngslnxzv\ndowlkygvf\ngmvel\npgvzsl\n\nmp\nk\nk\nubo\nm\n\njdymxhqeszrfgo\niheugkxmrwsbynjadfvoz\noyjrtsgzmfepxhd\nhdxlzryejmgcosf\n\npndcs\ncwdsp\n\noceishrgqp\ntsgphoje\nzenpkougasl\nhgorxeywsfpb\n\npzejodvy\nvyzdejop\nejdvyzpo\nyozvjped\n\nmdjzibuqrvkecl\nqcaejodxlgbvuiprzh\najyzdvrgeqbiclu\nncslezwfutrvqjib\n\nn\no\ns\n\nwnqftxaurblhpikmzjv\nqxfyiwjnmhtbkpauzrl\ncirtbjmpeafkudnhzwlqgx\nztrxfauslbjmqpwnihk\n\nxfrtleh\nhkxzi\nbyhxj\n\nvloiwkeadbcqrgx\nobldgwaymxjvqier\n\ndryhtpoawvi\ninpaowhrtydbv\nhyotdwvrip\nvioytprwdh\nqywoprdhgtvil\n\nvszuj\njo\nmjpihxr\n\ny\ne\na\na\na\n\nnpju\njun\nejnuv\nnuj\n\nfgpcswhmdixy\ncrxhiwkdmotpgnfysb\nwgihuydcpmfxs\n\nacesgkpv\nraosgpvc\n\npcorf\npfcrol\n\nzsympkbl\npsykzlamb\nzylskpmb\nyzlpksmb\nyblzsmpk\n\nlrdgspoxqaywvjiu\nswdjupvrixelgaq\nxublsdjqyrpgvaiowe\njpgqmxalrsdvfuiw\n\npxlfi\nbdvsk\nne\neirhgn\n\nqsvrmp\naqgzys\n\nchpukadomensgfj\njlnepdzuok\ndewnpjquktriob\n\naqshxtgruwkzncoi\niwtxlnbzakoqcdu\nqzxadiolmtunecjpwk\n\nvzasxecfdigkbj\nacsdvefzijbk\nyibvdcfujzasnke\nfozvndsbcjkaie\n\nmjbdpsh\nmbdypxj\nmbypdj\ncpmjfbd\n\ncjdvlgzk\n\npwuskgtc\ncktwugp\n\nstxgacjdnbezwoukhivlypr\nzpieoljbaknyguswfxtcvhrd\n\nfrqpswzajgk\ntusgjqkapzfw\ngazwfskqjrp\n\nyuqsj\nhrwmgvkial\nhernctopbzdm\n\nxudtjlakfqhepzm\nkflzpjexdqamtuh\nqtlmbdauprfovyhkexnzj\nzkathjldumepfxq\n\nltezfiwcsnxyg\nzckxfelsgtywni\n\nhmlxoknayqwgtfs\nhgfaqtlsxowmynk\nsalxqwnyfoghmkt\nlfqyantmwgokdhxs\n\nhpcduo\nodpcuh\ndmhoupc\n\nvijeghudcaspxomwkyrzblt\nkzrhpsabulxycodtemiwvqgj\n\nydrcxhkwbenqj\nxnkyqedhbcj\njbexydknqch\n\njlqkisftwdahnpemcrb\nwstfplujibdkcyqe\ncfjiqlpyszutdwebk\n\nvhtumyxriocj\nvcjyhrtmiuxo\nxroyjemuictvh\n\nqlxymefuiwvbrgn\nwqvlfixmngyrube\ngmfnbewyvixurlzq\nflwuxrmnvegyibq\nvrqfbixlmnwjygcue\n\nznxadjwcqsihbfovupt\ntsdjqraoxfuegcinv\n\nrjtsfzxhigdamkcqpb\nenmawxiyuorclfsqv\n\nlagipb\nsgapwni\nvgmapix\npacligt\npirga\n\njsnbm\nwxlioajqbytr\nvpghbj\nmnkdjbu\n\ndvb\nbdv\nvdbh\n\ncmfkubsnwhvydl\nkodmluyvbnscwf\nncuywdmlvkbsf\n\nwxzt\nx\nt\nga\n\nwyidutgqxcan\nktjcqgdy\nyrtdpcqjg\n\npfbdrmwtgv\nvldcrbxwgfe\nrbhpvfzgdmnw\nvaorgqfdpbzw\n\ntdsyjbpkzwx\nslnead\nedqhrnsgia\n\na\na\na\nn\n\nzprvfqcgi\npvyfzgqbidl\newxufqzi\n\ntsbaq\nqatlsk\nqtasf\n\newmsx\nigawsxrm\nwsxme\nwmsxe\ncmwzsx\n\nwovxhanyftglrkzmiscu\niufrvxzcyqjgebthmso\n\nem\nk\nk\nk\n\naerg\nfedapg\nega\nagme\n\nwroghldeqtnc\ncgtnrdoweqlh\nnogdrthcezlpqw\nchdolwtgrneq\ngowehqndctrl\n\nlrbvsgexaqptnfwjmcdhouk\nrnjsuegkbxmwpcqflaohvt\ngswokutqamfhxnrljevcbp\nrufgtqlonsawmvjhbkcpxe\nubkcaolmvjsxhtenwfqrpg\n\nwexgind\nnediwxg\ndgeiwvxn\n\npejqdczw\nzwjepc\nvjemowcz\n\nabzdgfhko\ntrvsjuqmx\n\nwnxjbcqogyfdzhitapku\nugczsntijqkwfyab\nknjbwagltcyiuerfqz\nfzwctuyigkajnbqs\nrktyifgajecnzwqbsu\n\njyidghp\njgyidph\ndgjpiyh\npjiyhgd\n\nvdwrlxqbphykjmuzftcio\ntmxifqbpyazncesrkouj\n\nfwildrejtbhzsknxpqyo\njyusnvtlowefhzdikgxrq\nkotzwhsafniljdxeqyr\nsxikerjqyaolzfhdnwgt\nmkdnogzqwlrjxesiytfh\n\nbivzsuthgrpd\nnphkubrq\nwabukmhrpj\n\nnplkgxfhsaomrjuze\nuhskaxfrnpmglzoj\njgkarmzonlsfphux\n\nmdhxznwoelckfgay\npxmbeohgnwyfacklz\nagnzfexclwokymhb\nmclgxfeoywkhnaz\nenxjkczfomhayglw\n\no\no\no\ng\no\n\npymldua\nlymudap\nmalkyupd\n\nmhnx\nxmnh\njhnmlx\n\nzmniyxufgbtjcvpk\ngkzxcvbmtipnfyju\ncnzmptbixvyfjkgu\n\nfxdbvymtgqnrozw\npgrmznsvtkfwuxboqy\nxfmzvygabltrwqno\n\npkgi\npmikeag\ngkivp\nipjkvtg\nkgpui\n\ncygobhesdxvpiutlajknz\nzinkjdbeyhstlvgxpucr\nxudegivwzpkjbqtycshfnl\negixvjubncaklzphdyts\n\nflepqzvch\nhclvpqdez\nvlctxzyhqpe\nvehqclzp\n\nrchxbltygzekmudo\nercgl\njnacwglre\nsclreg\ngalercp\n\ngsbtcuih\nubisvegatphdc\nvtfiecsugxbdh\nscrtibhugoq\n\nbaxqpi\naxrjiqbp\nixbpaq\nqpbxfwai\n\nogpedvhwuzbc\nltsfr\nmjriax\nrqkty\n\ns\ns\ns\ns\ns\n\ntuabpkqxvroyhjz\nptksvbyajurqoz\n\naiz\nikza\nizdva\nazi\niza\n\nczpng\ngpc\ngumck\ncgu\nyxrsgetch\n\nufz\nxoicgj\n\nabt\nerabt\ngzbntw\ntb\n\nndvfc\nxetilhb\n\nhvfxeqlwdkpozuabmijcygstnr\nthfylcdbwnexovmzriqjasgkpu\n\nqodgh\nojqhdg\nodmchltqeugr\nqohgdp\n\nlyutwgix\nwhtcrdjnsvfe\n\neugizoflxqjmrsdn\nsdjofexzmigruqln\nnqzrfimxsdjgoelu\nrjfqosdglumxeizn\ngdrmsjhoxeqfznlui\n\nwboy\nwyob\nobwy\nwoyb\n\nxofzdbqlernhvjip\ndbmwjoflxipr\nxriplfjobd\n\nlb\nb\nyb\nb\nbey\n\njsuehvblciq\njivushbcqe\n\njpdisezohtu\ntjihdpozuse\ndpuhztoiejs\nuestoipdjhz\nhejopstuzid\n\nahqwolftrvz\nrlckoaeumtjywsghbqxz\n\nelbjcwqpyfsrh\nzgkixucotmnylavd\n\novwpgedlfajy\ndjaoulgepyvwi\n\nvxanb\nkanxhv\nuvxan\nvnax\nxnav\n\nvqhknrjeua\ndvrjcqae\nkqjvcrea\nvobalfjpxgqr\n\nmfcaysjvl\niypgxdwzokbu\nsmy\n\nnsxhqofuk\nqkjfox\nxqwokfy\ndkqfoxv\n\nncprkyix\nijxykrnc\nnykxirc\nnkrcyxi\n\nvqylnfdcsgxu\ncunqdlafgsyvx\ncdfnxvjlguyrsi\n\nsxrklj\netma\n\nxpdgmf\ndahxmpg\nwernogsvlt\nxpgqm\nqgkb\n\navcmxptndkowj\naoduwpjktcnvx\nxwtcovnpakjd\nwzdvcpokjxnast\n\ntwobeiakfrmpgjdyqsn\nowmfryguxadcnebkivhl\n\nhevgwtocbdkz\nhbkoavxzdcetw\noesktmwdvyz\n\nanmzwy\nmknwazy\n\naendgmvjolfzy\njgfnbymvoeadczl\nybdmpofnralgzjve\nnaolymjwvzedfg\ngoxnvmfalsejyzd\n\nqrcbadgel\nhoseabdjrg\n\nmuar\ntrwum\numrw\numt\nnmgsfucjlyipbk\n\niolqwxkjzcpsg\nxjkbfplzqin\n\nnsiuqctvbf\nycwqgokibud\n\nwi\nsrnvx\nasrx\nax\ns\n\nnolmhubsafxjgc\nwancbvsjmqkxzglu\n\nlr\nlr\nlr\nlr\nhlr\n\nhwcjl\nanbqmskw\nowiyl\n\nsk\nsk\nks\nsk\nsk\n\ngishwxe\nplfkxmbyhzjwvtoad\nnuehwcx\nrhwxq\n\nxemwhdsozfqtvajcnk\nosjueztdcxqhrvfnmwk\nkncxosjfwdhrtzmqve\n\nav\nx\nu\ng\n\nsehzwjqgfxicamkrnbp\nwznemrfajqxhpkcisgb\n\nwhq\nh\nh\nh\nh\n\npwhltnxiq\nxhpiwnlqt\ntipqwnxlh\nwixtqhnpl\npwqxintlh\n\ndqmxibuv\nvdxqiubj\nvnadfxquib\nuixqbdv\nqxvdibu\n\nqtzgodpv\nzgfkvqtdp\nztdqvmbpgo\ntpdvziqg\n\nsyml\nmys\n\nhtuseaxzln\nuxlnzatseh\nsznaxutleh\nthxzealsnu\nltzuahxnse\n\nbh\nbu\nbu\nonwb\n\nxidlsobaqgh\nrxdgouqslbach\nbxvsqoglhad\nqepgdkxowblajhsnz\n\nvizqmhner\nzynmvedi\nszbmnewvir\nnmfvtpwize\n\ncsazebwqdmtrolvxinphf\nynfjamsqlcgpwohu\n\nrfld\ndlf\nivklhozd\n\npiyxdelnma\neclroyapnbvudfmtsx\nyimadzlpexnq\nxkgedyqlhmpan\nyxnhalepmd\n\nmwyskbjad\nopmdbhskcjxyuwe\nfsrjbywgdnmvikz\nsdymbqtkwilj\n\nbipr\nkwbjotea\nb\n\nugokxmcabzp\nwslrjept\nplfviewy\n\nowvkzbdijtnpfhl\neondwjtgkbli\n\nhgdjzupisnwmvtxoecyk\ngyopdewzvtjxckmisnh\ndpmtvocszigjnwkhey\nwdphmnelgqjtksfciozvy\n\nwludkmqjnpxvyigboasrc\nfsjolrybcgqivwxpudmkan\ndowxgcirmjapsvuylnqkb\nbaulnkrcqgijvsyodpxwm\n\ngbxedknljayfhcvu\nxztjkfeblgiqvydau\ngvlksybpemdxjawiuf\n\npds\nldfs\nshg\nsa\n\noyhipj\npdohywb\npaqlhou\nomrgyphtwd\n\npuexjovza\nbgvcejrisy\nwrejvq\n\nswzkvxtafnqyi\nwksiqxzvfnyta\n\nbuxsqlordam\nixslbpnfvtukahze\n\nzvnbreaqmwsodcy\nvmwsadyobqznrec\nebvmawdrzcnqsyo\ncbmwoaynszdvqer\n\nvxdzibpaw\navsfegby\nakvbc\nzabvu\n\ndhlxsy\nldyxsw\nlsayzx\nyxsjlh\n\nxtbe\nplj\n\nn\nm\nowx\n\nali\nmd\n\njmi\njl\njac\nlj\njlc\n\nwhjagdblr\nwdhrgbajl\njahbewndlrfpg\nwarljgdvbh\ngrsldajwbh\n\nubi\ndwb\nlnb\npbx\n\nnmsjacwzqdh\npbfkugeytoi\nrkvxl\n\nvdx\nbndx\nxvd\n\nnezmhlw\nexzmwgslhuon\nwtemnqhpliz\nfnedlbkvwmhzg\n\nzcvoarqi\nuqg\nthqg\n\nqedaghsxln\ncsxldqen\ndenxhyqls\n\nblegpfuaznrdhoj\nzghslinmvxejroaqp\n\nyjev\neyvj\n\nxhnqtvlaewfgupyrz\nzghfpnxtyelvaqurw\n\nbsno\ndovpt\nglfjzw\nhxmfc\niyrkqu\n\nta\nl\nm\nbrq\n\nezchvnpy\njphbyvcrze\nvychzep\nhytcpevz\n\nwurmizf\ndyqlwmuvi\nuimbw\neuibwm\nzmiuwhae\n\nbdngyolcxipva\ngswmucjby\n\nxzrkwep\nnjblugmhqvrsizw\n\ndijwksuhyrefmbtzp\nwsrtempdbijykuzc\nbewszdumjptcyrki\ndmbjkyzwpcesruti\n\nutameknglfxci\nohmnetvqjsawbik\n\nves\ns\nqbpkiywt\ngfe\n\neogztnu\nmonutzeg\n\nfjqvucdoz\ncfzvuyodqn\n\nj\nt\nj\nj\n\nxwcpkudjagnzmto\nczjgdnwmtkxua\nxjnkcwglzdutma\n\ng\nfisteknohd\nxmg\nuxrqz\n\ny\ny\ny\ny\ny\n\nyebaxitskm\ntxljeyaimok\n\nwytxl\nw\nwj\nw\nw\n\ny\nym\ny\ny\ny\n\ntuqacpofz\nafzuotp\nautzfpgdro\noufzatp\nasnzfuotp\n\nfmxcdtakjqsolvnwzpre\ncwslxozmedvqprakft\nzcepkrqaowsxdmlfvt\nadkrcltzfwqomxepvs\ncftdkzsuvxwroelapmq\n\nvnukwf\nwfu\nwuvf\nuqfw\nfucw\n\nucezxlv\nxcluzev\necuizvxl\nveluxcz\nzexcvlu\n\ncfdzeomh\nhzfmde\nlnrmhzifd\nmzfdh\n\nimklvjabtqdxcw\ndqtmiwjflcavkx\ntldzxkqnmwjcsavi\nlrvfgtdcjxakpmiwq\n\nhfgvjpminkouyscxdwzle\nfimyuswanovkdgzelcjxthp\ncyhigexozldsvknfumwjp\n\nobgv\nbvo\norgvb\nxpvsboau\nbov\n\ntidn\nljs\nrly\noljsrah\n\nhlpkbqo\noklbp\n\nupsfvhjeqiolra\npfjovuahelqsrim\nyqanieuglpvojsrhf\n\nrzlsoiwnmfjxac\najvextygdhwum\njqmpaxwt\nmygwbjpeaxdk\n\ndnkilgqrscye\nkhlzdxpbwo\nlgkrdm\nlvdtgk\nsfdklmtj\n\nu\nu\n\nkctfengbsqdjy\njtsehoqfbgix\naweqmugpzr\n\ngfkxci\niocxfu\nmdxneihrfqcj\ncsiopxf\nuyitxfoc\n\nw\nq\nvjgesf\nzkpxc\nn\n\naiqlfegkx\nrboptwvjsnu\n\nysamgbzc\nbczsga\ndaubcszg\n\ndufvmajroptly\nhsdwlyp\n\nogjwnmhktvubi\nuigwtjkb\nkqwiuetz\n\nfmdwnscru\nyli\n\ncnjr\nrcjn\njncxr\njcrn\nrjnc\n\ntjzqs\njblstz\n\nrmxcinhbeql\nmrfbtlenquhxij\n\nn\ng\nbwh\nrju\n\nmdol\nmdol\ndmol\nlomd\nmodl\n\napzodfktx\nzjkopdtxfa\noxjfakptzd\nowdkacxupzyft\naofkzpdtx\n\njmibuxvgcodkrewfnasz\nfsrzunjcbxdmweakigvo\naxkedgfubjczvowinmrs\ngruxwiscodkavjefmbzn\n\nmqpubxrzhktcfj\nhotqnigsavzeylmd\n\nntmkpjuzcilgd\nhpdugjkqltzxnmci\n\ndxwbfonuvjaskyeqzipctrlh\nwkcxydvhiaurbqepotljnzsf\ntafgehdurxybzwpkojvlscnqi\n\naf\nf\nf\nf\n\npovwrfhklm\nazvixotjbegsy\nsvjnocd\n\nysfeukcdrbxnl\nscpyrextbwokdufn\nskcudxneqryfbl\n\nhmwbzcodtijqavxnsyl\nvlpcaqyjsfiortmhz\nhvmizletopsjyaqc\nvmqajlgostizyhc\nkvcoqmajlyzhist\n\nx\nx\nx\nx\nx", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"abc\n\na\nb\nc\n\nab\nac\n\na\na\na\na\n\nb", Scope = Private
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
