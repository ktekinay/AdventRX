#tag Class
Protected Class Advent_2021_12_15
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( GetPuzzleInput )
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
		  var lastRowIndex as integer
		  var lastColIndex as integer
		  
		  var grid( -1, -1 ) as Chiton
		  ToGrid( input, grid, lastRowIndex, lastColIndex )
		  RateChitons( grid, lastRowIndex, lastColIndex )
		  
		  var firstGrid as Chiton = grid( 0, 0 )
		  return firstGrid.BestRisk
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var lastRowIndex as integer
		  var lastColIndex as integer
		  
		  var grid( -1, -1 ) as Chiton
		  ToGrid( input, grid, lastRowIndex, lastColIndex )
		  var origLastRowIndex as integer = lastRowIndex
		  var origLastColIndex as integer = lastColIndex
		  
		  ExpandGrid( grid, lastRowIndex, lastColIndex, 5 )
		  
		  RateChitons( grid, lastRowIndex, lastColIndex )
		  
		  #if FALSE then
		    //
		    // Debugging
		    //
		    var debugGrid as string
		    
		    var rowBuilder() as string
		    for row as integer = 0 to lastRowIndex
		      var colBuilder() as string
		      for col as integer = 0 to lastColIndex
		        var c as Chiton = grid( row, col )
		        colBuilder.Add c.Risk.ToString
		        if ( col + 1 ) mod ( origLastColIndex + 1 ) = 0 then
		          colBuilder.Add &uFF0E
		        end if
		      next
		      rowBuilder.Add String.FromArray( colBuilder, "" )
		      if ( row + 1 ) mod ( origLastRowIndex + 1 ) = 0 then
		        debugGrid = debugGrid + EndOfLine + String.FromArray( rowBuilder, EndOfLine ) + EndOfLine
		        rowBuilder.RemoveAll
		      end if
		    next
		    
		    debugGrid = debugGrid.Trim
		    #pragma unused debugGrid
		    
		  #else
		    #pragma unused origLastRowIndex
		    #pragma unused origLastColIndex
		    
		  #endif
		  
		  var firstGrid as Chiton = grid( 0, 0 )
		  return firstGrid.BestRisk
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExpandGrid(grid(, ) As Chiton, ByRef lastRowIndex As Integer, ByRef lastColIndex As Integer, times As Integer)
		  var origLastRowIndex as integer = lastRowIndex
		  var origLastColIndex as integer = lastColIndex
		  
		  lastRowIndex = ( lastRowIndex + 1 ) * times - 1
		  lastColIndex = ( lastColIndex + 1 ) * times - 1
		  
		  grid.ResizeTo lastRowIndex, lastColIndex
		  
		  for row as integer = 0 to lastRowIndex 
		    for col as integer = 0 to lastColIndex
		      if row <= origLastRowIndex and col <= origLastColIndex then
		        continue for col
		      end if
		      
		      var copyFromCol as integer
		      var copyFromRow as integer
		      
		      if col <= origLastColIndex then
		        copyFromCol = col
		        copyFromRow = row - origLastRowIndex - 1
		      else
		        copyFromCol = col - origLastColIndex - 1
		        copyFromRow = row
		      end if
		      
		      var origChiton as Chiton = grid( copyFromRow, copyFromCol )
		      var newChiton as new Chiton
		      newChiton.Risk = origChiton.Risk + 1
		      if newChiton.Risk > 9 then
		        newChiton.Risk = 1
		      end if
		      newChiton.Row = row
		      newChiton.Column = col
		      
		      grid( row, col ) = newChiton
		    next col
		  next row
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RateChitons(grid(, ) As Chiton, lastRowIndex As Integer, lastColIndex As Integer)
		  var startPoint as Chiton = grid( 0, 0 )
		  
		  for row as integer = lastRowIndex downto 0
		    for col as integer = lastColIndex downto 0
		      if row = lastRowIndex and col = lastColIndex then
		        continue
		      end if
		      
		      var c as Chiton = grid( row, col )
		      if row < lastRowIndex then
		        var below as Chiton = grid( row + 1, col )
		        var risk as integer = below.CombinedRisk
		        if c.BestRisk = 0 or c.BestRisk > risk then
		          c.BestRisk = risk
		        end if
		      end if
		      
		      if col < lastColIndex then
		        var toRight as Chiton = grid( row, col + 1 )
		        var risk as integer = toRight.CombinedRisk
		        if c.BestRisk = 0 or c.BestRisk > risk then
		          c.BestRisk = risk
		        end if
		      end if
		      
		      'if startPoint.BestRisk <> 0 then
		      'if startPoint.BestRisk < c.Risk then
		      'continue for row
		      'end if
		      'end if
		    next col
		  next row
		  
		  if true then
		    var doAnotherPass as boolean = true
		    
		    while doAnotherPass
		      doAnotherPass = false
		      
		      var c as Chiton
		      var sorter( 3 ) as Chiton
		      
		      for row as integer = 0 to lastRowIndex
		        for col as integer = 0 to lastColIndex
		          if row = lastRowIndex and col = lastColIndex then
		            continue
		          end if
		          
		          c = grid( row, col )
		          
		          var chitonDown as Chiton = if( row < lastRowIndex, grid( row + 1, col ), nil )
		          var chitonRight as Chiton = if( col < lastColIndex, grid( row, col + 1 ) , nil )
		          var chitonUp as Chiton = if( row > 0, grid( row - 1, col ), nil )
		          var chitonLeft as Chiton = if( col > 0, grid( row, col - 1 ), nil )
		          
		          sorter( 0 ) = chitonDown
		          sorter( 1 ) = chitonRight
		          sorter( 2 ) = chitonUp
		          sorter( 3 ) = chitonLeft
		          
		          sorter.Sort AddressOf SortByCombinedRisk
		          c.BestRisk = sorter( 0 ).CombinedRisk
		        next col
		      next row
		      
		      
		      c = startPoint
		      var trail() as Chiton
		      var visited as new Dictionary
		      visited.Value( c ) = nil
		      
		      do
		        var row as integer = c.Row
		        var col as integer = c.Column
		        
		        if row = lastRowIndex and col = lastColIndex then
		          exit
		        end if
		        
		        var chitonDown as Chiton = if( row < lastRowIndex, grid( row + 1, col ), nil )
		        var chitonRight as Chiton = if( col < lastColIndex, grid( row, col + 1 ) , nil )
		        var chitonUp as Chiton = if( row > 0, grid( row - 1, col ), nil )
		        var chitonLeft as Chiton = if( col > 0, grid( row, col - 1 ), nil )
		        
		        sorter( 0 ) = chitonDown
		        sorter( 1 ) = chitonRight
		        sorter( 2 ) = chitonUp
		        sorter( 3 ) = chitonLeft
		        
		        sorter.Sort AddressOf SortByCombinedRisk
		        
		        for each ordered as Chiton in sorter
		          if not visited.HasKey( ordered ) then
		            if c.BestRisk > ordered.CombinedRisk then
		              c.BestRisk = ordered.CombinedRisk
		            end if
		            c = ordered
		            trail.Add c
		            visited.Value( c ) = nil
		            
		            exit for ordered
		          end if
		        next
		      loop 
		      
		      for i as integer = 1 to trail.LastIndex
		        var before as Chiton = trail( i - 1 )
		        c = trail( i )
		        if before.BestRisk <> c.CombinedRisk then
		          before.BestRisk = c.CombinedRisk
		          doAnotherPass = true
		        end if
		      next
		      
		      var bestRisk as integer
		      for each c in trail
		        bestRisk = bestRisk + c.Risk
		      next
		      
		      if bestRisk < grid( 0, 0 ).BestRisk then
		        grid( 0, 0 ).BestRisk = bestRisk
		        doAnotherPass = true
		      end if
		      
		    wend
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RateChitons_bad(grid(, ) As Chiton, lastRowIndex As Integer, lastColIndex As Integer)
		  var startPoint as Chiton = grid( 0, 0 )
		  
		  var onlyDownAndRight as boolean = true
		  
		  for pass as integer = 1 to 2
		    for row as integer = lastRowIndex downto 0
		      for col as integer = lastColIndex downto 0
		        if row = lastRowIndex and col = lastColIndex then
		          continue
		        end if
		        
		        var c as Chiton = grid( row, col )
		        c.NextChiton = c.GetNextChiton( grid, lastRowIndex, lastColIndex, onlyDownAndRight )
		      next col
		    next row
		    
		    onlyDownAndRight = not onlyDownAndRight
		  next pass
		  
		  //
		  // Now we be selective
		  //
		  var doItAgain as boolean
		  
		  var row as integer = lastRowIndex
		  var col as integer = lastColIndex - 1
		  var adder as integer = -1
		  
		  do
		    doItAgain = false
		    
		    while row >= 0 and row <= lastRowIndex
		      var c as Chiton = grid( row, col )
		      var best as Chiton = c.GetNextChiton( grid, lastRowIndex, lastColIndex )
		      
		      if not ( best is c.NextChiton ) and best.CombinedRisk < c.NextChiton.CombinedRisk then
		        c.NextChiton = best
		        doItAgain = true
		      end if
		      
		      col = col + adder
		      if col < 0 then
		        col = lastColIndex
		        row = row - 1
		      elseif col > lastColIndex then
		        col = 0
		        row = row + 1
		      end if
		    wend
		    
		    if doItAgain then
		      if row < 0 then
		        row = 0
		        col = 0
		        adder = 1
		      elseif row > lastRowIndex then
		        row = lastRowIndex
		        col = lastColIndex - 1
		        adder = -1
		      end if
		      
		    else
		      exit
		      
		    end if
		  loop
		  
		  startPoint.BestRisk = startPoint.NextChiton.CombinedRisk
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SortByCombinedRisk(c1 As Chiton, c2 As Chiton) As Integer
		  if c1 is nil and c2 is nil then
		    return 0
		  elseif c1 is nil then
		    return 1
		  elseif c2 is nil then
		    return -1
		  else
		    return c1.CombinedRisk - c2.CombinedRisk
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ToGrid(input As String, grid(, ) As Chiton, ByRef lastRowIndex As Integer, ByRef lastColIndex As Integer)
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  lastRowIndex = rows.LastIndex
		  lastColIndex = rows( 0 ).Bytes - 1
		  
		  grid.ResizeTo lastRowIndex, lastColIndex
		  
		  for row as integer = 0 to rows.LastIndex
		    var chars() as string = rows( row ).Split( "" )
		    for col as integer = 0 to chars.LastIndex
		      var g as new Chiton
		      g.Risk = chars( col ).ToInteger
		      g.Row = row
		      g.Column = col
		      
		      grid( row, col ) = g
		    next
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TraverseGrid_old(grid(, ) As Chiton, lastRowIndex As Integer, lastColIndex As Integer)
		  'const kLeft as integer = 1
		  'const kUp as integer = 2
		  'const kRight as integer = 3
		  'const kDown as integer = 4
		  '
		  'var stack( 1000 ) as Chiton
		  'var stackIndex as integer = 0
		  'var visited as new Dictionary
		  '
		  'var startingChiton as Chiton = grid( 0, 0 )
		  'var endingChiton as Chiton = grid( lastRowIndex, lastColIndex )
		  '
		  'var runningRisk as integer = -startingChiton.Risk
		  'stack( stackIndex ) = startingChiton
		  '
		  'do
		  'var thisChiton as Chiton = stack( stackIndex )
		  '
		  'if thisChiton.DirectionTried = 0 then
		  'runningRisk = runningRisk + thisChiton.Risk
		  '
		  '
		  'if thisChiton is endingChiton then
		  'if runningRisk < startingChiton.BestRisk then
		  'startingChiton.BestRisk = runningRisk
		  'end if
		  '
		  'runningRisk = runningRisk - thisChiton.Risk
		  'stackIndex = stackIndex - 1
		  'continue
		  '
		  'elseif runningRisk > startingChiton.BestRisk then
		  'runningRisk = runningRisk - thisChiton.Risk
		  'stackIndex = stackIndex - 1
		  'continue
		  '
		  'end if
		  '
		  'visited.Value( thisChiton ) = nil
		  '
		  'elseif thisChiton.DirectionTried >= kDown then
		  '//
		  '// We've tried all directions
		  '//
		  'runningRisk = runningRisk - thisChiton.Risk
		  'thisChiton.DirectionTried = 0
		  'stackIndex = stackIndex - 1
		  'visited.Remove( thisChiton )
		  'continue
		  '
		  'end if
		  '
		  'var nextChiton as Chiton
		  '
		  'do
		  'thisChiton.DirectionTried = thisChiton.DirectionTried + 1
		  '
		  'select case thisChiton.DirectionTried
		  'case kLeft
		  'if thisChiton.Column > 0 then
		  'nextChiton = grid( thisChiton.Row, thisChiton.Column - 1 )
		  'if visited.HasKey( nextChiton ) then
		  'nextChiton = nil
		  'else
		  'exit
		  'end if
		  'end if
		  '
		  'case kUp
		  'if thisChiton.Row > 0 then
		  'nextChiton = grid( thisChiton.Row - 1, thisChiton.Column )
		  'if visited.HasKey( nextChiton ) then
		  'nextChiton = nil
		  'else
		  'exit
		  'end if
		  'end if
		  '
		  'case kRight
		  'if thisChiton.Column < lastColIndex then
		  'nextChiton = grid( thisChiton.Row, thisChiton.Column + 1 )
		  'if visited.HasKey( nextChiton ) then
		  'nextChiton = nil
		  'else
		  'exit
		  'end if
		  'end if
		  '
		  'case kDown
		  'if thisChiton.Row < lastRowIndex then
		  'nextChiton = grid( thisChiton.Row + 1, thisChiton.Column )
		  'if visited.HasKey( nextChiton ) then
		  'nextChiton = nil
		  'else
		  'exit
		  'end if
		  'end if
		  '
		  'case else
		  '//
		  '// No more directions to try
		  '//
		  'thisChiton.DirectionTried = 0
		  'runningRisk = runningRisk - thisChiton.Risk
		  'visited.Remove( thisChiton )
		  'stackIndex = stackIndex - 1
		  'exit
		  '
		  'end select
		  '
		  'loop
		  '
		  'if nextChiton isa object then
		  'stackIndex = stackIndex + 1
		  'if stackIndex > stack.LastIndex then
		  'stack.ResizeTo stackIndex + stackIndex
		  'end if
		  '
		  'stack( stackIndex ) = nextChiton
		  'end if
		  '
		  'loop until stackIndex = -1
		  '
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kInput_Jeremy, Type = String, Dynamic = False, Default = \"1153122486338196417261639921288211131723142991381714663988573539371125147579911789799911191116969182\n1831332932365721112271938859551961274184513439211372318789319176946137219492492161941188122228928142\n9821911543414142186827941122266167714126412612261328558992198212729611567923298114131222451713511114\n7246861617121926197913771333862216431691242331821373133472917112415411291112194329821255594119385913\n7283532811518311511133564162553362112249591513461311252729218443397781539589433111319711824661393631\n2515929137212718342949516922111713621859318118719617839125124564721161658335944181553941811143591517\n4916512552144322517215234299958319381621661767349167411222321248229439251953192958644239143882919241\n6262117322113477913692595649873914143546632433711128717141141195552948491953485631229194119276499991\n7392251899873812797958691238437453551415231331821364182879918291981738573962231152511911211128951113\n8413992251188993837397124261942199712837511841216512261395311785116811331719185479137512367447923291\n5231148122926582218424829117852548196215169569393712471373474748341292612868417935562413892295951885\n6969394124432223195175331296521928139597331582718251211495645114941612246194231312174117214121281842\n1492115983511981562257418211112925117322921195483112122256639228399618419541416852185938991328915818\n3337387528424632949433449211831892186689931141431821341112121116121183221372428184716111222586158651\n2919993831163121652312168296893876448879562949946693212289822132922233191147264817817431124414532533\n9831131365513121681981321111241225246211721245114513343139123311189247841338544122968113145391142716\n1727694314953352984564533684197836278119128336766459163262254212898918649112624992813951781316416374\n2271812917172151781117223114852112121981121667671421934421226898295554752996914271128911169789451951\n9641181231223141385164135392637559471954819529821233561311577143643837514229221871189471954194331152\n4842773719613551934224188641425166389122136165128121415358911721153164127212813948168736781136952951\n1192227966237198835311112231914836119223535631325132172552427754922112812179423656275381194611522453\n4587521661134142224185212119671223232647264672526518611961218313988518799959611424294177988911237867\n7841978128159981542211119531397179123564484381479727821915161363181216177352158299813648446813627222\n7284166795958241131999192919211621771144435542434154129323533329121215444282759763242637299473619699\n1521878281243112584389365171394192883659218227373853328197872435319181781919941925172732491338886311\n1327321441516991964782129484116368713248197522187147122388963111996334499727625711211235126217275463\n5432221784759463981982328941214217778116531411971739126861352255217191611697312757994113151311379972\n1185912419912167768598675227235243957241898718929234342122112138667448683289595212416151634918119782\n2142391197693165425931997914283877473934922668732952746725116377382215211222574165995121111118383226\n2517671922159312542191175127158214971341213911213276212516415975771618811321511144775331189114464662\n7422195152192114261215487181219928252132916876218849814118182116115931338892173123147871155216241119\n3619695411396123442155212519261891139921251199959962859246511384671182317569141243719313574613299114\n2895333123772993112294182624661491247795159971883633469119158351982981542649324118914796267121748913\n1421145424229377289371813129244589145113287748254253711637741529919416291278816369198475199772891934\n4226139942429431915575192843585749419348133173935216599874822673919238822771191128122524833751214529\n1682417751943991485271671248268311378571948341453293291196141934239152143595141717431161329855424112\n9916921853141162653286394526948121272378729683198391723494146711544133983626379417921189376352821798\n3251721727717131197339261311211519541459852173796114841169131848229719476992898439988142411881982514\n4224411911215323811873118144131911362211323994194273231611315238461136131411252251162414111299942115\n2245998155138161121631272285319936718281123752141998833128632147447117622119239893148242825136988411\n5128199191117746931424197696535944336182191931232292669562695112789951271493241291449919211342319956\n6185982121672329189115713515854662969113811769468312383127983222331916531821851915411131158716583266\n5447295461711381231589918947462282687649213121842921247116618391182167591292292272427141281715111177\n8257924948412473451961749898696413137392994416792374818227237143259116197488773961321624141163921432\n5189182291437314198489212141482184531697461226931512711191277526274712938812991613191947812232211244\n4555193184311911877999628197321551669874119131381183472179843972338461241911119924731168169352182272\n1121437621439149119353295941221222611786169917291122315558611419191633395499286111392381131171511238\n3181921181713184161942383164918982475421419929329239389548923261242417419233827235774153744131399151\n2144212113563135873312739193234226974131375159978272831447529333649424911425997613845276711174127394\n3139444361591195812958262711719931339591119823111113659752771219379921513182322111739482111579992212\n5621114341514728539451953111111724132613731214322289351224233177342291112529731353511549332152218981\n6158168164191463855184279714113662914367391459179668815811157124186552341548726599639264298312521815\n1995166266961996427961626535695212999191152112511338187611994115221111513691288611241921111251372396\n1339761931754125912894291611219167392229911558394529712234844524138351824911642926117836229449412319\n9127349377251112496211472777128795852299174781996397114134149188119193322618691616951273511925125149\n8979991927511499882118151229977284915581711491442571271831929283464123921696618123459172952156541118\n1911692955379514126841178174387511771789182282127314533841585231141954116191778276825221831612429254\n5812355192199983562136559621645794551755421236216311141149191254313741187262232164511315391297811915\n3424115732536482892978161186279711991592926127111589527519294376927741975118126955891355141746112114\n6989941658111289514721269122153856231312841221973781139894173114171591227833319376143957344117411911\n6125319278191932229114977252161577595177236842461172428859131892491678152164849198117325377432911476\n1152159324115134285596152231419112191947931122416535331212222762281719735281322382683941829919252797\n1119721171315374228473139951219963744542691955341851975111136422261596313992998971487819823291188481\n7916691142991816614421279131181771221333191348939869225827422531914334297979111781117184291912141817\n4459327512328523319571281171326141578961259819944448411558661132918284758431913397353129322141161339\n2636366417937791462122113461636413998893541599942374691221751914312218911394582119131724772161614249\n2312134166373181653911821772162314821142231391492122319111729983112421444715911629144339121416957937\n3112516582317416535542536957174341267787173494338391217911299591219692263281699341161832522294199592\n9514591666441193718119658181314241938166223118279113851527114813726452723842267929929348492111811581\n2482729124382111776179548733255881848149314161382118317221111921159882699921428496911916531781511634\n9673188569811459713271234169339644147411196161312836419131114224582591681121732551983658361231121738\n5977261429276572591351918817394787862812237116862142154391916283123565283389128193466927821786719949\n1769231445614929166298921531456368161915897211818781845929893127147256121829334316761162311125197837\n1312932111292124723831423127589975348261278421245946222431414328266141181139541218291313371199864618\n1591541125718121791926128149145611995157614226342145453466331146123719411716214432222151824877286273\n5619772119639321277117794132142411693117313872211776175416651697194197314115755297937932111148312514\n3178155419234246512532322711217369829144825612481941883499963679121511192214851616393725262185717671\n8114544152321812691913671222116334143125135245317392176495119442215315158941951195112914646111416558\n2741424121962339159791233465491165831161141431641127346424975111522251556164932982924154345265421893\n9921292358581466829119129911354441116986795112151124693382512674629191214183823931133116279292839481\n4569992111222111767136498792647332989342421348986559111618194724271412113395213251221446621936113217\n4991122344121493911982135121517399926352621891628211138999762133631115524112414391988299737366143123\n1114219232723168147329499525731115791152145213242183484163395711685154619941295185822161212821127794\n3839939524162212272145271115941119628111292192143171182921748857216541211912191929681297597929989911\n6189222318123913691725491531195561764199223114289691819733939824312544261311413928241912419255471755\n6426739442179681969621433347831187114554482194517792954314812523872919511933951481153159254111697312\n3891136638118997612371161161869992758221428676819193193631251844929339437511925493964819195151911142\n3115528121186224125618416185811129492665191334214154857416725217848287113213313571291989451911312351\n1921697432735261814811926199115788283324123249786652194311225419818513851175191913114233615261679173\n9444991493136334111115319771955169591434195411111175815119829517874288512561129573999727849941111891\n1431112211573298299618391113146347462491189192712317692165138111135921811621112921281114883152314218\n5349597921218431142281944271195411131831918391119511453181163891916131323533571231586827199329874375\n2393311319453249344541783217229449844183323339879189832259959321537131883822116122414429411226898557\n5457346279314981225362682181133799953141791522219253884328373198344561547931335524431911513277866156\n9699896735252183122231391818121491312934119311392547291169316419871163336631292698139515916993934313\n8556743922581192811645225163415825162574946272881497914233171916774511883981111996335911294624327449\n7521896193918149224732111989318369361944639558148182889252323156955979551215231329134223563528193297\n1911494977559119125389742991144919361368163938188656739221192361834613121494215789387959266616116631\n9511636215215555892846453398163358213162129919192181114219891142443311555291982463217261131119391179\n1549621141231921135259218425986586892253161313771915914851811321611989191411321126995515519721279591", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"1163751742\n1381373672\n2136511328\n3694931569\n7463417111\n1319128137\n1359912421\n3125421639\n1293138521\n2311944581", Scope = Private
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
