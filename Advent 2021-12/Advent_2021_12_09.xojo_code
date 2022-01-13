#tag Class
Protected Class Advent_2021_12_09
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
		  var lastRowIndex as integer
		  var lastColIndex as integer
		  
		  var grid( -1, -1 ) as integer = ToGrid( input, lastRowIndex, lastColIndex )
		  
		  var sum as integer
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      if IsLowPoint( grid, row, col, lastRowIndex, lastColIndex ) then
		        sum = sum + grid( row, col ) + 1
		      end if
		    next col
		  next row
		  
		  return sum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var lastRowIndex as integer
		  var lastColIndex as integer
		  
		  var grid( -1, -1 ) as integer = ToGrid( input, lastRowIndex, lastColIndex )
		  
		  var basinSizes() as integer
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      if IsLowPoint( grid, row, col, lastRowIndex, lastColIndex ) then
		        basinSizes.Add GetBasinSize( grid, row, col, lastRowIndex, lastColIndex )
		      end if
		    next col
		  next row
		  
		  basinSizes.Sort
		  
		  var mult as integer = 1
		  for i as integer = basinSizes.LastRowIndex downto (  basinSizes.LastRowIndex - 2 )
		    mult = mult * basinSizes( i )
		  next
		  
		  return mult
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetBasinSize(grid(, ) As Integer, row As Integer, col As Integer, lastRowIndex As Integer, lastColIndex As Integer, visited() As Integer = Nil) As Integer
		  var visitIndex as integer = ( row * ( lastColIndex + 1 ) ) + col
		  
		  if visited is nil then
		    var empty() as integer
		    visited = empty
		  end if
		  
		  if visited.IndexOf( visitIndex ) <> -1 then
		    //
		    // Visited
		    //
		    return 0
		  end if
		  
		  visited.Add visitIndex
		  
		  var value as integer = grid( row, col )
		  
		  if row = 0 and col = 9 then
		    row = row
		  end if
		  
		  if value = 9 then
		    return 0
		  end if
		  
		  var count as integer = 1
		  
		  if row > 0 and grid( row - 1, col ) > value then
		    count = count + GetBasinSize( grid, row - 1, col, lastRowIndex, lastColIndex, visited )
		  end if
		  
		  if row < lastRowIndex and grid( row + 1, col ) > value then
		    count = count + GetBasinSize( grid, row + 1, col, lastRowIndex, lastColIndex, visited )
		  end if
		  
		  if col > 0 and grid( row, col - 1 ) > value then
		    count = count + GetBasinSize( grid, row, col - 1, lastRowIndex, lastColIndex, visited )
		  end if
		  
		  if col < lastColIndex and grid( row, col + 1 ) > value then
		    count = count + GetBasinSize( grid, row, col + 1, lastRowIndex, lastColIndex, visited )
		  end if
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsLowPoint(grid(, ) As Integer, row As Integer, col As Integer, lastRowIndex As Integer, lastColIndex As Integer) As Boolean
		  var value as integer = grid( row, col )
		  
		  var valAbove as integer = if( row = 0, value + 1, grid( row - 1, col ) )
		  var valBelow as integer = if( row = lastRowIndex, value + 1, grid( row + 1, col ) )
		  var valLeft as integer = if( col = 0, value + 1, grid( row, col - 1 ) )
		  var valRight as integer = if( col = lastColIndex, value + 1, grid( row, col + 1 ) )
		  
		  select case value
		  case is >= valAbove
		  case is >= valBelow
		  case is >= valLeft
		  case is >= valRight
		  case else
		    return true
		  end select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToGrid(input As String, ByRef lastRowIndex As Integer, ByRef lastColIndex As Integer) As Integer(,)
		  var stringRows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  lastRowIndex = stringRows.LastIndex
		  lastColIndex = stringRows( 0 ).Bytes - 1
		  
		  var grid( -1, -1 ) as integer
		  grid.ResizeTo lastRowIndex, lastColIndex
		  
		  for row as integer = 0 to lastRowIndex
		    var stringRow as string = stringRows( row )
		    
		    for col as integer = 0 to lastColIndex
		      grid( row, col ) = stringRow.Middle( col, 1 ).ToInteger
		    next col
		  next row
		  
		  return grid
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"6543656799989432399987654342234567896545789323988432145689954545656789543434567987757565678995432345\n7432345678978921987896543210145679987326891019876321034567893234345878952129679876543454599989501234\n6543456789567899876789654321234798765434989198765432123458932101234567891098998987432323989878912449\n7854587893458998765678965536545679878545678949898743234567893234569678932987997654321019878767893598\n8967678932347893234589876545656989987656799656987654345698954345998999549876789765432198765456789987\n9878989543456789355999989678789897698967999769898767456789765659896789698765698976745297672347895656\n9989697659567998767899896989898789549879878998769876567899876798785678987664567897856398561238954345\n9894598798979899878998765499989678934998767897654987878999987899654569876573456989878987432367890166\n8743459987898789989999876349878567923987656798543498989989698998743498765432345678989876543456921278\n7652369896987678999898765498765456899832545987659569999976549987656987674321256989094998654567896389\n8993498765879567898789978987654345789721234598798978998765434798767896543210127892123989767879965456\n9889987654568456789678999896543236679654345679987899987654323679878987654321234989239879878989999967\n8778998543212347994599898765432124568965458789876796598795434567989398765432345678998767989998988898\n7659989654301498923989779896545235678976567898765689999886745699999499976843476799989854599987676789\n6745878967499989219876567987656776789987678987654577899987876789898989987654569899878943459876545679\n5434767898988978909765456798789887893498989876543656989998997898787679998765678999765452565989934989\n4321456989976567898954345999899998912349998765432345678999989989656567899876789988674341234598747899\n4210345678965454967895499888999999323456999998321234567898978978943456789987899876543210346987656789\n4321256789654323459999988767778987654567899987432346798987569765732369895498987999694321234598987890\n7652345678964012378998767654667898775678959876543456789876458954321298954329476988989432349679198991\n6543456799743233456789656543456789897899345989664567898985347895630987893214345977678943458989019789\n7654567897654356967898743212349891998921296799875678987897656789732396789101299867567894567894125678\n8765678989865767898987655623458910989890989892986789876798789899849985678912987756456789878943234567\n9876789878976788989198768784767899678789878901297898765689899932998764567923496544367999989654356789\n9987898767987899771019899895878998547679967892998954564567999891239965678994985431256789998765467897\n8598989658998987654123999976989987434567898999879543423456789789349876789989876542345678969879879986\n7439878946779998993234998989399896523456789898765432014567895678959989899879876543467789654989989345\n6598765234568969874349877691289765434567895679876743125778934589998993998765987654578996543499995459\n7989654145989459765698765430178998765678934567987654236799547678987892989654698765678965432989897598\n9978543036789398976798764321467999876789323456798885349899956789876799878543459876789999569878789987\n8765432123678967899899875432349899987893212347899976459999897899765678965432347989899878998765678996\n9878543954589656789949876545498789998954393958999876598798799997654569896547656799989767897654567895\n6999999895694345678932987676987678999995989899996987997678678998543456797656769898765656789423478954\n5439889789789234568991998989976567999989876789987999876543588999654567898767878987654545678912589895\n4329768678990123456789769899865456789878965678999864998654567898785678949878999876543434567893456789\n5498656567943234567895456798954347898767834567894212398765678959897899034999989997432123456789587894\n6987543456794589678999347987643234589656725989992101239876789543998979124989878989543014567897698943\n9876432369895678989998958998754395678943419898989232345987895432129568939878767678952165678999789432\n9987571456996989599997899129876786789532109787678949456798954321012367898965654589643236789999894321\n9898682367987897459876789098987897899676219654567898987899875432123456987654323456954347999989943210\n8789793478999976598765699987698998998754398743234767898987986593245787898645212367896788999878799321\n5679876567898987989854789996549679349765987432101256999656987989356898999432103798987899698765678932\n4345987878987899879765678989698543239879876545212345896543299878967939998543224678998996549876989548\n1239998989766798769876789878987832125989989854345456789951098767898920987654335699889975433987897656\n0198999997654987654987898969876543034799998765456587897892197656789439899876445789779894321098998769\n9987789898769898743298997654987969125678959876568698956789986543678998767986556899669789432999239898\n8766676789898765210129789743499898945789545987678979645678975212567897656597678998455678949890124987\n7655445678987654321335678954598787896995434598789765435889854501456898747498789987324567998789239876\n8943234567898765765456789767679656897894323359899987576798763212367895432329899876212678987678998765\n7632123456789896876569899898796545679932101248999998697899874363678976791012998765423799876567987654\n6543012378899987987678943939987656989653212357898989789901965654567897989134569876534899985459876543\n5432143567899899798989432123498777899654543467997679893212398765679999878965678988945678954349965632\n6743254578998767679996593234989898978965654578986567994343999878789998769896899599656789965498754321\n7654345679899656567897989345978939567896795989985456789959878999895987658789943498787899876569964320\n8765456789789543458999878959865323456789989899872347899898767891964596545678954679898954987699875431\n9876568895678932369898767898754212387899878789765478999765656792943997656789765678999123498789976842\n7987679954569893498787856789543201238998765678976569998654534989899898767899878989891012349997987653\n6598989963456789987696545678964912469899854587897678959432129876789769878999989998789124598756798969\n5439398894569899976543234569899893456798763456789989645944098965678954989998999899678935987645439878\n4321256797678998797432123498788789767987654567897896539895987654789943299987987656567896799732323989\n5410147889789789654321034987674678989998765879976989698789999769897893129996898543458999898721012996\n4321235678997698765453239876543799999989896789895467987678987989956789098989987632569998987632129864\n5452345678996559876574398983412989989876969898789329876569996492345689987678998543678987896543298765\n6543458789589434987865987632109878978965459987698910987678954321456789876567898654567896789654989876\n7655678993478949998978996543298767769896998654567891298799765210127896987878949987689965678969976987\n8768789012367898769989679984987658658789876743456932349898954323456965498989234598798954567898765498\n9989894323456987654399498765698743234678965432348946569977899436767899569993195679897893456789864329\n1099965454597898765458999876987652123489654321237898698765678945698948999854989799976789667898763212\n2149876585989909876567890989876541014569793210126789789854567896789236789769878989765678998987652103\n3234997679878919987888941296985432123678989321235678999843458999892125678998769878954586789698743214\n4349998798767898998999432345796554254689678932548789698756567898943234589989658769892345896549654325\n5498989997656567789998743659987674345679569893656896569869878997654445679876547658789456789439795456\n6987679886545456678999654798798765456893456789867975479878989549876596798765432745678998899598989578\n9832598767431345578999865987659876569932345678998964345989297632987678999874321234789769978997878989\n8763459854320123456789878997543989678921236789999651234599199754998789989985210165678954567976567992\n7654678975431234567898989986432395989433445699876540123498988969879899879876543278789323459876447893\n8765899987632345678987899876521234596554656789998431235987877898767998965987654349893212567987236789\n9896789798785456789876789987760235987675878992987542949876456789656987854398765998989543456798545699\n1997899659876569896545679999854345699876989991998659898765345678949876543239899887678954567987656789\n0129998943987689965634568999875456789989799989899798789894256789434987432123988776567895678998787891\n1998987892199897654323459999876567899995678976789987678989369892129876543459879655456789789899898990\n9897656789012976543212367987987678969876989765679876567678978991019989654598768542345899898785979789\n8765545678923987654393479876598989654987898754598765456567899689198698769987654431236789987654565678\n7654234789434798789989598765459896543298989885987654323456789567987549878996543210345678998743234569\n8985345678995679899978999654345789932129678976798778954767893459876434989898654321456789019859395698\n9876656889789989999867999963234567891012568987899989965678932598765323496789765632567892129998989987\n7998767995695399998758789892123678932343489998923499876889745699893212345779898743678989298987678976\n6779878954789299876545679791014567893654678999895901987899656987932101234567969898789678997876567895\n5665989543998989997732345692123456789765789998789892398998769876543242347698954989894569986765456964\n4734897699867879876521034789234877899878999989656789989769878987654343456789765678943598765654345893\n3123698987656767965432123678945989998989239876545679876758989998965654567899876789432459654321256789\n9234569976545659876543234567896799987690198765434398965347899899998765698945987898521345987210145698\n8945798765432345998754345678987899876541987654323287893256798789879877899436898986410129876541234567\n7899899984321656789765458789098936987632998795410126789143987654567989987547999874323498765432356678\n6798999873210127899876569999129325698549879987323245891012998543456799998958998765454599876543467789\n5487897654321678999987678998939214569698969876564346789199875432345678989869989877665678987654568993\n4376798965434567898798789987898923998797654989675678999987654321234789673979873989876989998777679212\n3235789876565678987659897896567939869986543298786789998999976532345895432399762094989997899888789349\n2123678987676789876543956989457898752597632129897899876543987543456954321987654123499876799999895458\n1014569998788899985432345678998976543498743234998932987612398754567896410198965234598765789212976567", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"2199943210\n3987894921\n9856789892\n8767896789\n9899965678", Scope = Private
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
