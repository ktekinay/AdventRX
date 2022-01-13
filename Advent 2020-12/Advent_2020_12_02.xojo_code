#tag Class
Protected Class Advent_2020_12_02
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
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "^(\d+)-(\d+) (\w): (.*)"
		  
		  var validCount as integer
		  
		  for each row as string in rows
		    var match as RegExMatch = rx.Search( row )
		    var lowEnd as integer = match.SubExpressionString( 1 ).ToInteger
		    var highEnd as integer = match.SubExpressionString( 2 ).ToInteger
		    var char as string = match.SubExpressionString( 3 )
		    var pw as string = match.SubExpressionString( 4 )
		    
		    var replaced as string = pw.ReplaceAll( char, "" )
		    var diff as integer = pw.Length - replaced.Length
		    
		    if diff >= lowEnd and diff <= highEnd then
		      validCount = validCount + 1
		    end if
		  next
		  
		  return validCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "^(\d+)-(\d+) (\w): (.*)"
		  
		  var validCount as integer
		  
		  for each row as string in rows
		    var match as RegExMatch = rx.Search( row )
		    var pos1 as integer = match.SubExpressionString( 1 ).ToInteger
		    var pos2 as integer = match.SubExpressionString( 2 ).ToInteger
		    var char as string = match.SubExpressionString( 3 )
		    var pw as string = match.SubExpressionString( 4 )
		    
		    if pw.Middle( pos1 - 1, 1 ) = char xor pw.Middle( pos2 - 1, 1 ) = char then
		      validCount = validCount + 1
		    end if
		  next
		  
		  return validCount
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"1-14 b: bbbbbbbbbbbbbbbbbbb\n3-14 v: vvpvvvmvvvvvvvv\n2-5 m: mfvxmmm\n15-20 z: zdzzzrjzzzdpzzdzzzzz\n6-8 g: tggjggggrg\n2-3 l: nlllw\n1-5 j: jjjjj\n4-5 t: prttt\n2-4 v: vvrqzp\n4-6 v: vvvvvqvvv\n7-8 d: mpntdwkd\n2-12 w: jwkfktkbthcwvfrkwgz\n12-16 j: jjjjpjjmdhjjdjjjjjjj\n10-11 f: fffffffffff\n3-20 n: pbclshqmxtkmgsmztjlm\n11-12 q: qqqqxqqqqqqqwqrxqs\n5-6 p: hppvnppcvqf\n10-11 k: kckkrbkxtknhkkkk\n5-7 m: kmmgxgmnnpzrzmgsbm\n10-17 b: bbbbbbbbbbbbbbbbrbbb\n5-7 v: vvvvtqvvvv\n6-8 g: gggggpglgzgg\n8-16 q: fqtqqqqxqqzgzfqq\n9-11 r: rrrrprjrwrrrm\n4-13 z: rnlzzqptmhgvk\n4-9 r: rkrzscrrvrtkhrrzvwvs\n9-10 f: qqmkffffrs\n6-11 z: zzkzpzzzwzf\n10-19 n: nnnnnnnnnnnnnnnnnnnn\n7-12 x: xmpxbxxxzxxxsxxsxn\n17-19 f: ffffffffffffffffffff\n2-4 n: nnns\n3-4 q: xhzskzqp\n1-5 l: sllljllll\n8-13 l: ffwsllhmlxcllnr\n1-4 j: jztj\n8-10 b: dbzkwdpcss\n7-9 k: kpckkkkfktkv\n7-11 c: mnzhpxcxxccshcnb\n1-5 l: llllll\n4-6 r: wnjzhrrxchm\n1-2 t: btttlttttt\n14-19 m: lvgmmmwmmmmmmmlmmmz\n1-4 x: xlxg\n2-16 s: jxkwvhwzxwcxhtvss\n3-5 s: rxswsszs\n8-11 d: ddqdkddddddddds\n3-6 v: vpswxv\n8-17 h: hhhhhhhqhhhhhhhdthh\n1-6 j: jjjjjjjjj\n9-10 z: zgzzzzzczzz\n3-5 k: kwzkkdkzfptslvg\n6-7 m: fpmgmmb\n5-13 k: kkkkkkrwkfkkkxkkhkz\n1-3 g: mjggbqgqpqxdwrkwj\n10-12 g: bggggggggggfgg\n4-9 n: nnnnnnnnn\n17-19 p: ppppppppppppppppcpv\n13-14 p: pjkphnpjsgppkfpppmr\n11-12 l: lllllllllllmll\n1-8 v: vzvjhbgvvnzvnt\n8-16 w: vwxmrfwwltswwtcw\n1-5 s: lssdx\n10-13 f: sfffffffffffbffff\n6-10 z: zzzzzzzzzdz\n5-8 m: mmjgmhwm\n1-3 m: mmqmm\n4-6 c: cccrwctcws\n8-15 f: fffffffffffffftffff\n5-6 k: rkddknvp\n1-2 w: pwlw\n7-16 p: pppppppppppppppppp\n7-11 v: fvcszzvdwnbk\n15-16 k: bkkkkkkkkkkkkkkk\n4-5 g: gggggg\n1-6 j: tjhjjfphjjjjjjjjjj\n5-7 z: zhzzpzz\n13-15 w: wwvwwwwcwwwwwkb\n5-19 z: zzzltwskszzrzztkpzd\n2-7 m: rjcmqkwjwx\n11-16 t: ttfttrtmptbttttt\n6-9 k: kkkkkhkkkk\n11-16 l: lllllllllltlllll\n7-8 x: xxxxxgxxx\n3-5 x: jqxlbw\n6-9 k: kdjkkkpzk\n8-10 h: hhhhhhhhhg\n3-4 t: htmrtktcv\n12-16 b: mbxrkbbbzbbpbbbb\n7-12 s: ssrssltsssssssssssss\n3-13 h: hhhjhbhthtblqj\n12-16 d: ddddddddddwwpddkdtd\n18-19 h: hhhhhhhhhhhhhhhhhhh\n3-7 g: vgggggg\n7-9 h: hhhhpkphhtwhhh\n6-7 f: pffffvgqff\n3-7 z: wldszzzz\n6-14 v: vvvvvvrvvvvvvwvv\n1-3 s: qknsgbfsmclhhbrdqg\n8-10 b: bbktbhbpbb\n10-18 j: zljvjwjwjszqjjgvtj\n9-10 p: pppnpnppppppwpz\n8-9 t: ttxtmttntptt\n4-7 t: pwstbrttx\n1-6 w: rwpwwcww\n8-9 j: jjjjjjchmj\n6-9 z: zpxzczzjzz\n8-11 x: mlzjxpjxdxdxx\n10-11 d: dddddkdddmd\n8-9 f: qfpdfhfffffff\n8-9 n: nnnhnncnnngn\n3-4 n: nnnd\n7-8 w: wwwwwwrvwwwwww\n1-8 j: jtpmjnfjzg\n1-4 z: zdzzzf\n3-6 x: xxtxxsx\n5-8 h: hhhhhhhhh\n1-3 s: xsxs\n5-9 l: zlnllqllpl\n16-17 z: jzzgsjwxnklzzxmtz\n10-11 z: zzzzzzztzzsszqmqx\n3-6 l: lldllkl\n2-3 g: sgtggmvwhm\n12-13 m: mmmmmmnmmmmmmb\n1-8 x: hxhdlxxj\n11-17 c: cjccccsccccfccccj\n7-8 x: xxxxsxtxgdxrhvxr\n4-5 b: dbbql\n3-9 w: wwswwwwwbw\n3-5 q: qqqml\n3-8 f: dhsdprvcg\n4-9 m: rhvzxnmwm\n4-11 m: mcncqssmmtj\n2-4 t: btgzt\n4-5 g: ggjgsg\n3-6 h: lmwjhh\n2-10 q: pqnqqqqtzlcqlmgk\n2-4 l: cvmqc\n7-14 c: lzcwzccchgbvcc\n9-11 r: rrrrrrrrcrrrrrrd\n11-13 g: gggpgggwggggj\n10-16 p: mpgtppppfvpptppp\n17-18 g: ggggggggrgggggggqgf\n3-5 g: lpgbgggm\n4-6 d: dddcds\n3-4 c: rbktcqrjvcb\n3-4 g: wgfvgdpgm\n6-11 n: knnhnnfdnknnghnxxsr\n14-15 b: znsbblhbxsxljgb\n8-10 w: lrgwrhdmrwvwwwjc\n4-5 c: gcgjcnc\n3-20 h: fhhnhpshhhhpfhhbhwxh\n4-7 s: sssssbs\n9-12 k: kkkkkkvktkzkw\n3-9 k: skjxkckkk\n13-14 k: kkkkkdkkkkkknp\n4-8 x: mztxblxxxxmcxnljzwqc\n6-8 n: lnbnnznnfn\n3-7 k: khmkkkspkkk\n1-9 j: jbrxjjnvgwkfjwj\n14-16 v: gsfvlhjqkwqrtftvvwlv\n3-6 t: ttrttttttt\n1-5 q: xqqjq\n10-13 n: nnnnnnnnnnnzn\n2-6 f: msfffff\n9-11 s: ksxsssnslss\n9-10 f: fffspfffwsf\n1-9 q: fmqqnqqqq\n1-5 s: kssssssss\n9-18 l: zfqlflvcmlgdwlnlfql\n8-11 s: sssssslsstm\n16-17 n: rmxqmndnrzxrqcrwfmd\n11-17 j: jcjlzcjzjpzjjqjcj\n12-13 r: rrrrrrrrfrrxqrqr\n6-10 n: nnnnznncnnkklqn\n14-16 z: csdpmzztklzzvzmf\n3-4 z: zzzd\n7-8 d: dddpjdfdmjxjddd\n3-11 s: ssshsslfmsspslsxsss\n4-5 m: srwmf\n5-6 l: llllld\n13-14 c: ccdcccczvcbcrrsw\n7-10 h: hhhfhhkhhhhh\n4-5 j: hbpjfwzj\n10-11 l: ldlllllllwn\n4-5 p: jptlp\n2-4 h: hhkzphw\n14-17 b: bbbbtbbbbbbnbrbbz\n14-18 x: hnpzxjzxglxncqldxznf\n2-4 q: qhqqqq\n8-9 j: jwjjjjjjx\n1-2 w: czgpwwfl\n9-10 t: tznttztsctvvttptjt\n6-11 x: gxzxxlxxxxtjxx\n13-17 w: wwwwwwwwwwwwqwwwr\n7-9 d: ddddddddddd\n2-5 h: hqwhhhkqqhnmngl\n4-7 m: mmjmmmj\n13-19 f: jdmfffkfbfnffbffcfxf\n12-13 b: bgbdbgtbbdbjb\n1-6 v: svvvvhvv\n5-6 m: mmmmdm\n10-12 n: nnnnnnnnnrnnnnn\n7-16 t: tttnzxtqrpktgtmzm\n1-3 c: dccccc\n9-17 l: lkqllllllllkllsfj\n5-7 r: zrrrrkrdfrwwr\n2-3 c: ccdjtcc\n13-20 p: pppppppppppppppppppp\n7-10 g: qqwcgfqgfm\n7-8 q: qzdqpzqqqqqhgqkqtnq\n4-9 p: crzpcgqwpd\n14-19 t: ttttttttttttttttttx\n10-13 j: mkjjxjsfxpmqjplhwn\n5-13 p: pzppdqppppprd\n10-14 k: kkkkkxqktkkkkkkkhkk\n9-10 p: srpplgnpjp\n6-9 b: rbbzcbbbjflbbbbxxwbc\n11-14 n: nndngqnnpnnncn\n8-16 z: bhjzjrczkzxzzfgf\n1-6 d: dxptddcddwdd\n6-9 r: fxrhrrtlr\n8-9 m: hmmmmmmmt\n3-11 g: kkfgggvpgzv\n13-18 l: znlllvkzllzrzzzrrl\n3-7 n: nnnnnnnn\n5-7 d: zdptjdd\n15-16 x: xxxxxxxxxxxxxxxlx\n9-12 h: cdbrghhdwhhhh\n10-16 t: ttttxjtttttstttw\n13-14 j: jjjjrsjjjjjjjjjj\n3-4 f: ffflf\n6-9 t: ctpktwjttttttt\n1-10 x: xncxxwqwxxxp\n4-5 x: xxxxxx\n9-17 t: tttttttttttttttth\n7-16 w: wwwwwwwwwwlwcwwkwx\n9-11 v: vlwvvvlvbvtbvv\n4-14 f: ffffsfzffskffffff\n2-4 b: jcqbh\n2-5 j: fjmwjzkfrjprrjj\n16-17 f: fffffffffffffffff\n5-9 n: bjmbpncrpw\n4-11 z: kxzzzzzcrsz\n10-19 z: zzzzzzzzztzzzzzzzztz\n3-8 n: nngnnnnnnnn\n1-15 b: bgxdbrbggnbhjbj\n3-4 d: wddd\n6-7 j: jjjjjjnjlj\n16-17 q: qqgqqwqqqqqqqqqqqql\n2-5 t: tddzt\n8-13 g: qjvkvckgnklmglrxpmpw\n14-17 l: lllllllllllllllll\n9-14 p: nppppphpmpsppp\n3-5 s: ffscssqwssj\n7-17 k: xsbskfwmhsksmxhkkm\n4-5 v: vvvvvv\n7-8 b: bbbbbgbncbbbbbbg\n3-4 f: vwfnmfkxmzgxztlncxk\n1-5 p: lpppb\n3-4 n: dwnzx\n7-13 d: vrdxdcldpddbdv\n12-17 x: cxxxxjdxxxxqxxxxx\n1-2 w: mjwqw\n2-10 w: bwrcwwwsvjwdlsnw\n2-5 b: gbbrx\n17-18 b: bgbbbbbbbbbbbbfbkb\n3-4 m: mmmr\n7-10 f: tkhffrflhzfjf\n2-4 j: fvjjjj\n9-11 n: nnnnnnnnhcnn\n5-14 q: dqnkvqnccqwsnmqmgjq\n2-4 p: ppxt\n2-4 b: bbbbbbb\n1-5 c: ccccqcc\n11-15 k: rfkkgkkkknkkfkkkk\n11-13 j: jjjjmjjjjjqjjjl\n2-6 h: bhhhhh\n4-5 p: ppqpmjppvp\n13-14 h: vhhhvwhnhhhhhh\n1-3 n: mnnnn\n8-14 p: zjpdpjpxzzwqts\n3-7 b: bbbbbbf\n13-15 s: spsscssssgssbsss\n8-12 g: sggggggxgggk\n1-4 f: fjfx\n6-8 l: hgllllll\n4-14 l: znqpzslgsfxrzms\n3-5 b: btbnb\n4-9 b: bnqpbbgrkbstrbj\n6-7 x: xxxxxxxqmxqxd\n2-5 t: jtcctkh\n3-4 v: hvvspvhqv\n9-11 z: bqcklzzpzzk\n17-18 z: tkkvdzxpgkdbrmxmxw\n13-17 w: lmsbqwwwwxlwgwwrbz\n6-9 b: bbbnbbbqbbkbbbnkb\n8-12 l: llkllllgpljlgglrqll\n6-15 j: jwzqwlpjjgjtjjrhjj\n18-19 k: khnrkvlprggwhzlfrkbk\n5-7 v: vghwwvvvvvx\n1-7 p: dpphzmwptpsptrrzdpg\n1-3 k: lkbxk\n3-6 h: qhhcrjzqvqdhfrjxz\n12-13 k: kkkkklkkkkkkk\n12-15 c: ckgkcdcvgcxbcrbz\n2-6 j: zjjljrlj\n6-7 r: rxrntss\n18-20 d: mhvlzntnfvndrpmczwkm\n13-16 z: zzzzzzzzzzzzwzzz\n8-9 p: pgftmlvpvlt\n4-11 v: pvvxxsvhzvzbhwvwz\n4-6 j: jjjjjj\n2-6 q: rhrxgwfhgjkmqtbbs\n11-18 d: qnzwlfgddnhqpxxwsgd\n2-9 p: pqvpnphjm\n5-6 h: wclhgh\n2-14 n: tnkcfsnnknmnndnvntp\n3-13 s: sswxsfsksssswj\n4-12 f: wnhfjgsdfkjwvn\n6-11 h: qxggfhlgfhhtvznxhh\n7-8 r: rrrrrrzrrrr\n1-11 q: fddtjqvqljqqqqprqqs\n11-13 d: ddndddddkddtddddl\n6-8 d: dddddqddk\n7-17 t: lxnzrtjzfzndbbdss\n4-5 w: wwzfmwww\n3-4 s: bgsszwmfbssnmzts\n9-16 q: wtqqqqwqqsqqqpqdqqc\n7-11 k: kkkxkkkkkxkgkkk\n3-6 j: jjjzjj\n15-17 w: ntpqgqzkhvlwqcwpkml\n8-9 s: sssssssss\n3-8 p: phpppwpph\n6-7 l: nlflllc\n5-8 q: qctqqqnq\n5-7 q: qqqqzqtqq\n3-7 k: jgkkbkkkbg\n3-5 b: mzbbc\n6-11 w: qswfwtnfwsw\n9-10 z: zzzzzzzzzzzzz\n3-4 n: nrkn\n11-13 n: ntssnqhwnhfpbsnn\n5-6 d: wsdnjv\n2-7 s: gwsqsgj\n3-5 p: pppppjlpbmhrkp\n1-10 n: zwzpblnrln\n3-7 s: bgstvvn\n11-12 n: tnnnnnnmnnnnnjn\n5-6 v: vvmvvj\n4-6 d: dddqdwd\n5-6 w: xjhwbj\n1-3 q: lqqq\n5-10 g: jgtgplmgggghzsgwgngb\n1-8 x: xxxxxxxjxjx\n1-2 d: mddddddddddm\n8-9 r: rrrrrrrrl\n2-5 w: swwwww\n2-5 b: xwjlb\n2-16 k: kkfkhsqkkkkmpfdbdfb\n9-12 k: kkkkjkkkpfkc\n4-7 s: dstwsss\n6-13 t: tmtrtpttnmtcjk\n14-16 q: qgqqqqqqqqqjqqqqq\n6-8 z: zjzzzzqf\n11-12 t: tttttttttthtq\n11-14 m: hmmmncqmmmmmmm\n8-10 q: qqqqqqqqmq\n4-5 t: qtqtt\n1-5 m: ndkwggwtm\n5-6 n: nnnzcn\n1-7 l: llmllll\n2-4 l: vptl\n6-8 w: lwwwwcwwdwj\n8-18 q: qqqqqqqhqqqqqqqqqqq\n6-9 t: ttttttttwt\n12-14 p: gpprpppwfnpppbgspdpp\n14-15 f: fffffffffffffqf\n14-15 h: hhhhhhhhhhhhhhgh\n10-13 m: mmmmmmmmmvmmm\n10-12 b: bbbbbbbkbbwfb\n9-11 h: hhhmhhbhnhrh\n4-10 v: tvcpfrfvmvczvvwj\n12-13 j: jjjjjjjjjjfjjpj\n3-6 q: cqqqqfq\n18-20 p: ppppppppppppppkppppx\n14-16 l: llllllrllslllllllllv\n17-20 x: txkgsxxxfgcjwxhdxqxt\n2-3 b: bjbb\n14-16 h: hhhhhhhhvhzhhcgthqh\n15-16 m: mmmmmmmmmmmmmmnp\n3-9 r: drvtprzmzjrrmjzrr\n13-14 d: ddddddddddddddc\n5-13 q: zxthgdmsdqqln\n9-10 g: btgpjgglng\n5-7 z: jhnzlltcrgj\n5-11 l: lknhltlnzbljzzpjbfrm\n6-8 n: nnlnnfgdn\n5-11 x: xxxxxxmqfwxjxhk\n2-4 m: mmwm\n1-8 r: rrrrdrjrrp\n2-4 s: ssrsc\n9-10 d: dpdddddhddd\n3-10 q: cqqqqjvqgqgqqmrzq\n5-6 c: ccccshcccc\n6-15 w: wwwwwwwnxwwxwww\n9-12 j: njcgjjjjjjjjjjjgwfj\n8-16 n: nvnnfnrgmndksngn\n14-15 z: zzzdzzzzzzzzzsj\n4-8 h: hthqthcqnbh\n12-14 q: qqqzpqkqqkqsqpwqqqq\n4-6 l: bzqrdj\n4-5 h: hhhfjhhhh\n9-13 x: xxdqbxxwxdxxxhxxmxx\n3-4 t: rtwt\n8-15 s: sssssskdsssssssss\n3-8 r: rrdrrrqsm\n3-4 w: wwzw\n7-11 c: vfgdgnpfswsdjjwz\n16-17 b: bbrbbcbpnbbtklfvtj\n13-14 g: jggggpgggdpgggjv\n2-10 v: wvdfgchsgv\n3-4 s: sswsssx\n8-10 s: sbssssslsss\n14-16 r: grrrrrhrrrrrrlqrrt\n4-9 p: ppzppppprpp\n3-8 m: wmmmfzmdc\n17-18 b: bbbbbsbbbbbbbbbbbb\n5-7 p: ppppvppppppp\n2-4 g: bgmgnj\n1-7 s: sdsjsblc\n3-4 s: qrxk\n10-13 r: rrrrrrrrrjrrtr\n1-3 c: cckc\n10-11 l: llcllllllld\n10-13 s: rlggmfsskssrssjssss\n2-7 v: vvrjzwcrh\n3-5 k: kkkkktk\n1-5 b: xbbbtb\n8-9 b: bbbbbbbbhn\n14-15 s: scsssssssssssls\n5-7 f: gfqfgfwfffffffffg\n9-10 f: ffffqfffhb\n15-16 r: rvrrrrmrrrrrrbrd\n3-5 v: vvhvjv\n2-5 g: ggdgf\n2-10 j: lcfjjjjjjct\n2-4 h: hchh\n8-12 b: drnwwmhgpbhrpq\n11-12 m: mmmmfmrmnzlmmmmmb\n1-5 c: pgcwckcrgc\n12-14 g: jzgpnqlgqjwdksgpmggc\n4-6 q: bhchmrqqt\n5-7 k: kkktzkk\n1-4 n: nnbm\n3-5 m: mmmmms\n6-9 j: jlnnjjtcvjfjjv\n3-6 x: vxxxfwxxxx\n10-16 c: cccccccccccckccct\n1-6 n: xqnbzmd\n8-9 f: fffffffhv\n5-6 p: vphcppmpx\n9-12 b: vbznbbqbpbhbbrb\n3-4 r: rfpkbnptxgj\n4-15 s: sfssssqssznssss\n1-4 k: kkgk\n4-5 w: rqwwww\n10-14 b: fcblhcbhsgnfkb\n4-10 f: dvjhdpdfff\n13-14 p: gcpcbpdppprmpbssd\n10-12 v: vvvvvvvvvvvmvvvvvvvv\n2-4 m: smvmjcrtmxxnmmzxzc\n14-15 x: xfxxxxxxxxxkzxxxxxx\n10-12 d: dpdmddddgrsddddd\n8-10 x: xxgqxqxxxxxxh\n1-9 x: dxxrcxktx\n6-12 d: tddddddddddsdddd\n2-6 p: fjkbdpp\n16-17 p: ppppppppppppkppqpp\n2-4 d: ddthzddddf\n3-4 f: ffvx\n10-12 m: kmmmmmmmmnmmmm\n3-4 r: hrnrr\n3-4 g: gggg\n1-4 j: jqjltjwj\n5-7 j: jjjjcjnj\n5-6 r: rwjbgnrfrh\n5-8 b: bzcxgbbbbh\n2-3 j: jcjrjj\n7-8 b: fhmhlcjj\n5-6 j: jjjjgk\n10-11 x: kxxxxdxxnffxxxx\n5-15 k: kkkknkkkkkkkkkkkkkk\n3-4 t: jttt\n8-10 w: zwwrwwswmn\n4-12 d: dddwdddddtddddbd\n2-3 x: dxxbjcxzxn\n12-16 j: jjjjjjjjjjjjjjjzj\n6-8 c: ccgmclcczccc\n9-10 p: ppppppppsd\n2-3 n: npnz\n7-8 z: zzzzzzzz\n1-10 z: vnqbljpczz\n3-5 t: ttftttttt\n4-5 x: xxdpx\n15-16 z: zzzzzzzzzzzzzzzx\n8-11 m: pmdzmjbmmlmvm\n2-4 x: xxxxzx\n9-11 c: ccccccccrcl\n6-14 r: rrrrrrfsrrrrrrr\n10-12 j: jxjjjnjjjjjjj\n5-7 v: vvvvvvvvvvvvvv\n5-7 n: nnqnnnj\n9-13 l: llllllllxlllcl\n2-14 h: gtjmvthqqtghhhbhk\n2-4 j: wpljhpjh\n3-6 b: dbvmcp\n1-4 p: dpppp\n6-9 x: xnvxxxxxxxzxv\n2-4 n: vnjj\n1-8 l: lllllllz\n4-7 w: qkzwwxwkncwzd\n9-10 r: rhrrlrrrqgfrn\n16-18 m: mmmwmmmmmmmmmmmdmm\n3-5 m: gbmwmmfvmfbdzccqhmmx\n6-8 c: ccccfxzc\n4-5 h: hhhhn\n2-5 l: lwtlv\n4-15 j: jjjljjjjjjjjjjjjj\n8-10 w: wwwwqcwwlvqw\n3-4 g: gfgm\n5-9 t: tthptxkttbshtjv\n7-13 b: nrjjbspgkqpbbcr\n4-7 s: ssscsss\n10-17 d: dsdddddzddcdddddjddd\n3-4 j: jrbjjvsj\n4-7 h: hhhhbdchhhhhhh\n4-10 p: pdpqppppppp\n10-14 g: shznjbglbghtngzbhg\n4-5 k: vhkkskkb\n7-10 j: zjjjjqzcjknjjjg\n10-11 k: kkkzkkkkkgkkkvkkk\n2-6 c: vczcxbbccc\n3-10 l: lldllllllnllll\n5-6 k: kklpksq\n5-9 k: kkhkkkkmkkzk\n4-5 j: djjqj\n9-10 q: qqqqqqqqqz\n2-16 c: ccczxccccccjkcccc\n3-4 l: mljl\n7-8 v: vvvvqrxk\n2-14 v: vntfpvvbrvvvvvvv\n7-10 f: fffsmbffffzftfqfjdj\n10-11 v: kvvtvhvvhvvkpvzc\n10-11 z: zzfgjqkgzzzdz\n2-4 k: xgvr\n2-6 b: bbbbbvbbb\n18-20 f: fffffffcffffffffffff\n2-6 m: mmmlmmjmmm\n7-10 q: qhjqbqqrsrqnmbtqfqbr\n6-10 c: tsqclcqmncpccdd\n3-4 z: ztxzz\n2-4 r: jrrf\n7-9 m: mzmmmmmplpg\n9-13 b: bbbbnmbbbrpbbbbbb\n4-14 z: zzqvwzzzzzzjzbzzf\n2-9 x: gbxxxxxsxfxpxxt\n9-11 v: ddhtvfzvjvv\n2-5 x: hxxxxdwjxnvwx\n8-12 k: gkklpkqgkjncl\n2-6 d: ndvdbk\n3-4 m: mmmmm\n9-10 z: tcstfmslrsxbz\n2-7 j: pjvjjfgfztsvnc\n3-4 j: jjjj\n4-13 r: rzgrkzqkzsgzxwchbtv\n4-7 p: pptdppprwz\n2-5 j: wfpjjzjwjcpsjq\n14-15 x: hxxsdnvgvxxppxxhkn\n10-20 r: rrvrrrpxbvplrrxttrkr\n12-16 v: vvvvvvvvvvhvvvxdvv\n14-19 w: wwbwwwjwwwwwswwwwrw\n7-16 b: jxwbbbbbbbwbbbqbbkz\n3-9 r: xsrmlrzmnrrq\n17-18 m: mmnmmmmmmmmmmmmnnmmm\n1-4 n: nznnnnnnnnn\n6-9 w: kwnbnnwwzl\n1-6 k: kkgnbkpmmjh\n5-9 v: vvwtvvzcvvvfdvflnd\n1-2 q: qqckqspjkgnlnpth\n5-7 b: kfhcdlbpvbslfscbt\n8-9 r: rrrclrrrwrcm\n2-4 d: ndqcbndjvmddpw\n6-8 k: skldfkdbwbpbklkk\n2-8 c: cczcccqcrcccckd\n3-4 c: cchbkcdc\n6-7 l: lwlclrhlll\n2-7 l: cwkllzfmlrrjljl\n13-14 j: jjjjjjjgjjjjjb\n12-13 v: vvvvvvvvvvvvv\n8-9 g: ggdggxggg\n3-4 f: pfwgcrf\n4-7 m: mvhmbwtm\n15-17 c: cpccrslcrspkfjhcc\n12-15 v: vvrvvvzvrvbhvvvvv\n8-17 c: pczcccccncllvpxrpt\n10-12 r: rrrrrrvrrtrrr\n3-10 n: nrzcnnvtnwnnnn\n8-9 x: xxcmxxxdxjx\n1-4 s: fdbsstzvqsxf\n9-11 d: dddddddddmmddd\n8-11 f: nffxfffffff\n3-4 g: zggg\n5-10 g: cphtggfxgg\n3-11 s: nvxqhqgfsklk\n4-5 b: qbxtb\n10-11 h: hhhmhhhzbhm\n6-10 b: bbbmbbbxbqbb\n14-17 h: hhhhhzhfwfhhrhhhh\n5-11 h: xjsnhhjhrhhjnhhwsdmc\n2-8 r: hrrdzhfsrltr\n9-12 n: nnnnnnnndnnx\n6-13 g: gdgzxgnglbgtggnfcglm\n1-3 j: jjlj\n4-7 t: tttxtttt\n4-19 t: vflbmbhngnjkkvqzvjk\n4-12 n: gnnnnnlnxnnnqwngn\n10-13 m: mmmmmmmmmmmmmmm\n1-3 t: ktmqtst\n7-12 q: qclsqqqqqqqfnw\n6-9 r: rrrwrjrqpw\n7-10 s: sssssqfssgsbs\n4-9 t: tfktphnmtncj\n12-16 z: zfjzqzzzzwzzzzfzzzj\n1-4 d: rddxdd\n5-18 z: zzzzlzzzzzzzzzzzzzz\n14-17 x: rmmxdvwxbrwxxxdrjzz\n2-12 d: ddzddkddbnddddd\n2-5 x: xxrxt\n14-15 r: nrrrrrcrrrrrrsrrr\n3-9 z: szgzqvzfmrzztzzz\n1-6 b: fdbpbb\n15-16 z: zzjzzzzzzzzzzzfrz\n2-9 d: zdnmmnfhdc\n3-5 h: hhdzxhhhh\n5-6 v: vvvvnv\n10-13 p: lpbxtppfbphhr\n1-9 p: gmtbnlpsphppvfppp\n4-7 r: rlrcrqrrrrrr\n5-15 f: gffffqvfffrkffb\n5-13 k: lkswkhhqxpfjkrvqbkjs\n2-4 h: fshrhhh\n1-5 l: lplllllmv\n1-15 j: jjjnjjjxpdjjqjpj\n3-4 p: phppf\n14-18 p: pppppppppppppppppp\n3-5 b: jmbbbsxrqhht\n11-13 v: lpzcvmmblzcvctjvvvj\n10-13 z: mszzdwzzntzxzzzv\n2-5 w: wwfjw\n8-9 c: cscccccgscccccw\n5-6 x: xxxxxjxxxxxxxxxx\n14-15 h: hjhhhhhhhhhhhhm\n9-12 l: lllllllllllbl\n7-8 j: jjjjjjrj\n9-13 w: fwwshrkqprlcfwrnnhws\n15-16 w: wwwwwwqwwwwwwfwk\n5-11 g: ggwgxgggggngg\n5-9 h: hhhhhhhhlhh\n7-11 r: rrrxrrhxrjtrr\n5-10 n: nngknxnrnn\n7-12 t: tdptttkvtttst\n4-10 g: dbggxcbvhdvbgg\n2-4 n: bnnnxgqsmqd\n3-7 f: fffdppf\n7-12 n: nnknnldnfpndnnz\n17-18 j: jvjjjjjjjjjjjjjjrk\n4-7 f: nffnfffcf\n4-5 p: pcppqvp\n12-13 c: chccmcczcsbccqhbkccc\n4-12 t: ftjtvbjtftcjxdf\n4-7 r: bgdnrdrfpd\n5-6 m: mmmmmm\n8-9 v: vvjvvvvvvvvl\n9-11 v: vvvvvvvvbvq\n4-12 r: kncrkgzrchvr\n14-18 v: vvgsxvztvvkvvvvbsv\n5-10 v: mwhtvfvvvvtvbpvvhvv\n2-6 f: bfrmbflfk\n13-19 v: wvvzvvhsvdvvmvvvvvh\n8-10 h: hhmhhhhvhsz\n8-9 f: fbfffffkg\n3-5 z: zzqzq\n3-4 s: zdcfbdss\n2-8 n: dzdnhldbpd\n9-11 k: fphphksskqkkz\n2-3 h: ndhgh\n2-3 p: pkpmgp\n7-17 r: brpwrmrfrtvfrqldrnhm\n1-4 q: wtkqq\n9-19 b: bbbbbbbblbbbbbbbbbbb\n3-8 s: ssssttgs\n7-12 w: wwwkwwwmwwwcw\n8-11 s: sszjsslsslnss\n8-9 v: bvkvvvvbvvcpnmv\n1-9 j: qlhcjdtqjjb\n16-17 q: kqgkqnmwdqcxqnnqq\n12-13 f: fffffffftfffff\n10-11 k: kkkkkkkkkkk\n6-7 r: hrrlfrr\n3-4 s: sgsss\n1-4 x: qxqx\n2-12 p: cppdxmdrfmkptslj\n15-16 j: jjjjjjwjjjjtjjjjj\n3-4 c: ccpc\n4-5 b: bzbbh\n4-5 m: mdmzm\n3-5 n: nnnnn\n14-15 b: bbbbbbbbbbbbbbkbb\n9-12 f: htjbckfxbpffl\n8-10 k: kkhxxmwpvkfkkhvv\n7-10 p: ppxppppwmzpp\n1-6 k: kkkkkqk\n9-12 m: mmmmmmmmmjmt\n11-13 q: qcqrqcxsnqxqq\n7-16 z: jfdzzhzznzzzzzdfzcm\n4-5 c: cwcqf\n4-5 p: ppppr\n4-12 r: rrrnrrrrrrrnr\n3-4 j: wjfjj\n6-7 j: wbscpkz\n7-8 f: fffflfwff\n4-6 x: xxxdxt\n2-3 w: sfnw\n4-5 n: nnnnm\n4-5 w: rwwqntw\n3-4 n: dnnnqpn\n4-8 m: mmmfmmmhmmmmmmm\n4-17 n: nnnwnnqzndwbnnnnpnnn\n7-8 x: rqswdxxz\n1-5 x: wshxxxcsxvx\n7-9 m: mmmmmmpms\n17-19 m: fmjmjfbqqpbtnbhmwns\n1-3 j: jtmswbmwlqpnwrsnt\n11-12 r: rrrrrrrrrrbprn\n3-7 v: vvvvvvv\n4-8 h: drhxhbvnrqldgf\n16-20 x: hrvxjqxxxxwfkpzjxtxx\n3-4 b: bbth\n3-9 k: ttpjhlqnkk\n9-10 w: wwwkwwwdnwvlw\n1-2 j: ffjx\n3-4 q: zvmd\n3-6 p: vngptsmhplptp\n11-13 c: xfrccqbcsxcrtfvwg\n2-6 r: rrrrjprrrz\n1-15 t: tttttttttttttttt\n7-11 g: dbxjvjwwsbghhts\n4-5 j: jjjjl\n10-16 b: tbbbbnbgbrwmcxkh\n10-19 g: sgggggsgggggggggggk\n4-6 w: wwwwwwwww\n14-16 k: wkqhxkkkkkkkmkpd\n7-8 w: wbwhwwsg\n8-9 r: nrrrhskwm\n3-8 f: fffnmqfflgffzsjmm\n3-13 n: dznkvhtztwnjf\n6-9 d: zbdddvdddddd\n7-16 j: jjjjjjzjjjjjjjjjjjjj\n2-3 k: qqkk\n15-16 l: lllllllllllllldl\n1-3 j: jjtjjjjjj\n7-17 k: kkknbkkvqbkjgkrkvkkk\n3-6 w: rwvqbx\n7-16 x: xxxxwxsxxxvxxxxmxxm\n6-15 n: zhmnsnmlmgzxdwnhlcbk\n1-17 x: xpxpmxrgxmjxxxxxcxx\n7-9 b: bqnhbbsbbwbb\n8-9 g: ggtggggdg\n6-10 m: mrszmmmmcmgmm\n10-12 j: ljvjgjgjhjjp\n7-9 z: zzdzzzwzhzgzzg\n4-5 k: kkkkk\n2-4 z: szzzzzpzgqzmpcctpc\n5-6 q: qghxqqxqqdfhqbt\n5-6 w: wwwwwww\n4-10 w: wwwbxswwwnwn\n5-10 n: nnnnnngnnjnnw\n4-14 s: fhnscjmmkxplmgnslfz\n4-7 p: nptcxvppp\n2-5 x: lxlxvxxxhr\n8-11 g: fwgrkggrggkggkggj\n8-11 j: ljgjjnjjjsw\n14-15 m: mmmmmmkmmmmmmrv\n1-2 t: trqtc\n2-7 s: sqtssss\n4-6 v: vvvvvwj\n4-12 w: sqwxkvwwwdfwhswww\n5-7 m: mmmnpmmmmmmmtmm\n11-13 h: hhhhhgqhlzkhqhhvhhhs\n8-9 f: fffwbfvfwff\n1-4 s: ssstfzsssns\n5-6 p: cvpfpp\n1-3 b: bblpbzb\n15-16 l: qlppjglsdpfldmlg\n3-7 h: hkshhbrrjrnhbhlrmh\n1-9 b: bbwlbwzbmb\n4-5 d: txlddjgdd\n9-12 k: kkkkkkzknkdkk\n9-17 q: qqdqgqqsvqqmcqnqqqr\n12-15 l: llpllllzflnnltlzkt\n8-9 h: hhhphhhghphhh\n4-6 r: rrmrrdrr\n6-16 r: kcrdvqntdxckjxsqksxg\n4-9 d: grfdddffz\n10-11 m: mmmhmmmmmmm\n8-10 l: llllljlgllxlw\n11-16 h: hhhhhhhhxzshhhhhhhhh\n8-9 s: fmqsdsrsnspsslc\n5-6 h: khrhbhvhhkmh\n2-13 r: srhvjgsgvhqfrhrfhp\n4-5 s: shssss\n4-6 r: rrrcvnrrtr\n5-6 p: ppppxpp\n3-4 r: nxrnxrd\n2-10 q: gqghqqzflmj\n1-10 r: rztsjmwcrrdd\n5-7 b: rsbbnrnlwbgb\n4-12 g: qggggggcgbggg\n11-13 q: qqqpqqqlqqdqh\n5-6 z: tzzzzzvfsz\n15-16 s: smqxzshssmkncscssg\n5-7 f: grlbfrfcjfffgpf\n1-5 r: crrrrrr\n12-13 v: vvsvvvvvvvvvb\n6-7 h: hhhhhzqh\n3-7 b: btdgdbbb\n1-3 x: lxdx\n9-10 p: gpdppwpppppppp\n3-13 w: wjwvwrwwswwwwr\n10-11 p: npppppprpppp\n16-18 x: xxxxxxxxxxxxxxwsxxx\n7-8 m: mmmmmmtj\n2-3 b: lbbbb\n10-16 n: nnnmnnnzxnfnnnqn\n10-12 q: jqqqqpqqqqdqqq\n14-18 x: xxxxxxxxxxxxxxxxxxx\n3-6 n: nnnnfdnz\n7-8 p: plpppppp\n3-7 t: hctttzktntt\n3-4 z: zjzgbz\n4-10 k: mkkskqknklk\n5-7 l: llhlllpl\n2-11 c: cwcccjcccpcccvcccmck\n5-10 l: nvlvlxxlllhlctllglll\n7-11 n: nnnnnnnrnnnn\n4-5 z: zzzfzlkz\n2-4 q: wmqq\n3-5 h: hhhhh\n7-8 j: jkwlwjhj\n13-14 m: mmmzmmbmmmmmfwms\n9-10 k: mkfhkgkjdj\n15-19 n: nnnnnnmnnnvnnxnnnnv\n11-16 l: ltlllljlllpclllltll\n3-9 x: twkgzhpcq\n4-10 l: rsrcwkdcsks\n10-12 g: ggggdggggggj\n8-15 z: tzvbtbnbjjsppczf\n12-13 q: qzrzqjqqxzqqh\n10-11 d: dkdsxxxdkdd\n4-14 l: gllfglslrlvllglzlll\n2-3 r: rrcbrr\n2-5 c: vcdgc\n7-8 z: zzzzxfnz\n1-5 m: tcjkmm\n1-4 v: vvvpvr\n1-3 w: wwmwww\n8-11 t: wsjttdvqttttdrtttt\n9-11 f: mhfxhxvjgvf\n5-8 w: wwwwswwdww\n9-11 n: pcfhnkpnnsnw\n4-7 l: gslllllxllqlnllbdf\n2-4 j: jjjjj\n6-9 m: nmlmmmmkv\n1-10 w: xwwwwwwdww\n5-10 s: nsshbsscnssj\n10-11 f: ffffffffflj\n5-7 v: gwvjvvhzfvnzvqwcqv\n4-7 b: shbpbbbnmdjgmd\n6-11 b: bbbkbpzlhjbjxlbr\n13-15 n: nnnnnnnzrnnnzhnnxzn\n1-2 c: ctcccc\n2-3 p: pppppp\n2-3 g: dggg\n4-5 p: jpppx\n4-6 p: ppppptp\n2-7 s: stsnsjpsss\n6-9 x: cxxdgxhmxfdxxxqtz\n10-14 l: lljblhnllrmlpllhlls\n1-8 m: ppmnmwmmn\n12-15 s: gsssqsssssssslsrjss\n10-12 k: kkkkkkkkkkkq\n8-10 d: ddddddddnjs\n2-3 d: dgmd\n1-18 k: kjjkkkkrkdkkqvkkwdkk\n3-7 d: dhdvqwdbg\n8-9 z: vsccrzszmz\n8-17 r: rrrfrxrzrrrqrwxrrrr\n7-13 z: zhzczhbxphhdzzzmtj\n2-9 w: wbwwwwwwwzqwwwww\n9-13 q: kpwqqljsqdcfwc\n5-11 g: lmbzgggggggzkzg\n4-6 q: qqqqqqcw\n9-10 f: zqffftffvfjffckffg\n3-7 s: dsssshssssss\n3-11 m: njqmrkblsbmlxqn\n8-19 j: jsjjjjjjjjjjjjjjjjc\n12-13 w: mrmxswfhkwmwwl\n3-4 x: xxxx\n11-12 h: hhhhhhhhhhhx\n12-16 k: kkkkkkvkkkkqkkkkk\n3-6 z: zzxzznz\n14-16 l: lllllllklllllfll\n1-10 c: cccccccccdcccwt\n8-9 s: szsssssgspss\n2-4 n: npct\n2-14 x: xmxqbpbxxxxxxxsjxt\n3-12 k: xpfkkkmkmkjwk\n9-10 q: qmqqqqqqqq\n12-15 x: xxxxxxwxldxgxxx\n14-15 v: vvvvvvvvvvvvvvx\n4-9 r: rrrrrdrrrrcrrvr\n2-4 v: rvzxtdkvsnhv\n4-5 j: jnjjclj\n8-9 c: ccccccccc\n7-10 t: ttfjvztrtht\n14-16 f: ffgfbfffffbffgfff\n13-16 z: zzzzgzzzpzvlmclnzzz\n12-15 k: kkxwshnkwfkdwws\n3-4 s: sskb\n14-17 g: ggggggggggggggggs\n12-13 r: rrrrrrrrrxrrrrr\n1-14 l: jzwwlldlhzllmljlclw\n14-15 w: zcwxxmfwlbvnsmcnzbm\n10-12 l: lplblnqpdllwmllttm\n9-17 p: bmbrzkjhqvzlmkttpp\n3-12 q: dwrkbstbbzwqkckvj\n2-7 x: txxxxxbgxx\n6-9 x: xxxxlbvxq\n7-11 k: kkkkkkbkkks\n3-4 p: bxptpp\n3-5 z: fndtmzrmlqh\n1-10 k: tmfjqlghfzbgwt\n8-12 z: zxzzzzfxzlmzz\n3-11 m: mmnjmmmmmmkmmqm\n3-5 z: zzrmzz\n1-2 t: btcq\n5-7 r: rdrrmrr\n3-4 v: hmssgxvqxcqpv\n1-10 s: ssgpdqssps\n9-10 z: zzzzzbzzczzqh\n6-7 n: xmnmnrxnnntn\n9-10 n: nnnnnnnnnc\n5-6 r: tgrjtr\n6-7 d: ddddddd\n8-12 n: pnnhnsnnnnnn\n3-7 c: zkccckqc\n4-17 g: srtggggmggjfxgggzxm\n1-2 c: clcc\n2-6 w: vxwwwcw\n15-16 r: rrdlrrdmrrrrvtrl\n12-15 m: qgfbgpqnnmmsfjz\n1-11 b: bbvbpxbbztbbbqbbgtk\n7-11 l: lllllmlllfllll\n1-2 n: vlnl\n8-11 n: wszsqncnntnm\n10-11 m: cmzmmmmmmvsq\n2-3 j: kjjjdvjx\n2-4 h: hhhfhhhhhg\n3-4 b: bbbc\n9-10 r: rnrrrrrrrrr\n3-5 m: mwmkm\n1-4 h: hldfhhhwh\n1-3 h: hhmh\n11-16 c: vwcccpcznqcqxvjw\n8-9 p: pptppfppkpqqpp\n13-17 r: rrrrrrrrrrrrrrrrb\n7-9 q: jqdzzpqbqklqg\n11-12 c: bccdccccqccx\n4-20 s: sssxsxksssssstnntsqs\n1-2 q: gvcq\n12-14 c: ccscjccccccqzc\n10-13 x: xxxxxxxxxbxxjx\n2-5 h: cphhbhh\n2-3 v: vhfv\n7-14 r: zrqmcfrvsrfrrvmr\n1-2 b: zrdtblbbb\n8-9 q: qssqqxqqcqqgkzbq\n3-8 m: tmmmmmmmmmmmj\n2-5 f: mmcfxtk", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"1-3 a: abcde\n1-3 b: cdefg\n2-9 c: ccccccccc", Scope = Private
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
