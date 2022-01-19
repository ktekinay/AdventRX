#tag Class
Protected Class Advent_2020_12_14
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
		  return CalculateResultB( Normalize( kTestInputB ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var rows() as string = ToStringArray( input )
		  if rows.Count = 0 then
		    return -1
		  end if
		  
		  var mask1 as UInt64 = ( 2 ^ 36 ) - 1
		  var mask2 as UInt64 = 0
		  var registers as new Dictionary
		  
		  for each row as string in rows
		    var parts() as string = row.Split( " = " )
		    var key as string = parts( 0 )
		    var value as string = parts( 1 )
		    
		    select case key
		    case "mask"
		      var mask1String as string = "&b" + value.ReplaceAll( "1", "0" ).ReplaceAll( "X", "1" )
		      mask1 = mask1String.ToInteger
		      var mask2String as string = "&b" + value.ReplaceAll( "X", "0" )
		      mask2 = mask2String.ToInteger
		      
		    case else
		      var num as UInt64 = value.ToInteger
		      num = num and mask1
		      num = num or mask2
		      registers.Value( key ) = num
		      
		    end select
		  next
		  
		  var sum as integer = SumRegisters( registers )
		  return sum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as string = ToStringArray( input )
		  if rows.Count = 0 then
		    return -1
		  end if
		  
		  var mask1 as UInt64 = 0
		  var mask2 as UInt64 = ( 2 ^ 36 ) - 1
		  var maskMap() as string
		  
		  var registers as new Dictionary
		  
		  for each row as string in rows
		    var parts() as string = row.Split( " = " )
		    var key as string = parts( 0 )
		    var value as string = parts( 1 )
		    
		    select case key
		    case "mask"
		      var mask1String as string = "&b" + value.ReplaceAll( "X", "0" ) // OR to force 1s
		      mask1 = mask1String.ToInteger
		      var mask2String as string = "&b" + value.ReplaceAll( "0", "1" ).ReplaceAll( "X", "0" ) // AND to clear X bits
		      mask2 = mask2String.ToInteger
		      
		      maskMap = value.Split( "" )
		      
		    case else
		      var memAddress as UInt64 = key.Middle( 4 ).Left( key.Length - 1 ).ToInteger
		      memAddress = memAddress or mask1 // Force the 1s
		      memAddress = memAddress and mask2 // Clear the X bits
		      
		      var num as UInt64 = value.ToInteger
		      
		      StoreToRegisters( registers, memAddress, num, maskMap )
		      
		    end select
		  next
		  
		  var sum as integer = SumRegisters( registers )
		  return sum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StoreToRegisters(registers As Dictionary, memAddress As UInt64, value As Integer, maskMap() As String, startingIndex As Integer = 0)
		  for i as integer = startingIndex to maskMap.LastIndex
		    var map as string = maskMap( i )
		    
		    if map = "X" then
		      StoreToRegisters( registers, memAddress, value, maskMap, i + 1 )
		      memAddress = memAddress or CType( 2 ^ ( maskMap.LastIndex - i ), UInt64 )
		      StoreToRegisters( registers, memAddress, value, maskMap, i + 1 )
		      return
		    end if
		  next
		  
		  //
		  // If we get here, we didn't find another "X", so store it here
		  //
		  registers.Value( memAddress ) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SumRegisters(registers As Dictionary) As Integer
		  var sum as integer
		  
		  for each num as UInt64 in registers.Values
		    sum = sum + num
		  next
		  
		  return sum
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"mask \x3D 1001X0X00110011X01X1000110100011000X\nmem[5228] \x3D 409649\nmem[64037] \x3D 474625\nmask \x3D 1X0110X0X110000100X01100000011101111\nmem[62395] \x3D 48627\nmem[32253] \x3D 16724249\nmem[29843] \x3D 241166\nmask \x3D 100X100X110001111101X0X0010100111X10\nmem[9042] \x3D 12448\nmem[36389] \x3D 14915399\nmem[53378] \x3D 2004566\nmem[60022] \x3D 121815\nmem[46937] \x3D 1238\nmask \x3D X001X0X101X10X10101X0000001110100011\nmem[55791] \x3D 2998\nmem[16538] \x3D 4120048\nmem[36864] \x3D 183554\nmem[38989] \x3D 7774725\nmem[43983] \x3D 18397304\nmem[26551] \x3D 1232\nmask \x3D 1111X0110110X0010110000010X1X1X10X1X\nmem[28101] \x3D 14619727\nmem[35256] \x3D 29030667\nmem[63194] \x3D 146129065\nmem[44798] \x3D 189\nmem[2426] \x3D 16693877\nmem[695] \x3D 30070848\nmem[45241] \x3D 4271881\nmask \x3D 1001X011X1100X01XX101X110001X110X101\nmem[17482] \x3D 7601\nmem[35168] \x3D 164940\nmem[50171] \x3D 1047374131\nmask \x3D X0010X101X00111X11100111110110X11X01\nmem[55397] \x3D 6883232\nmem[36276] \x3D 460553\nmem[28164] \x3D 6184\nmem[32800] \x3D 3846\nmask \x3D 100110X1X1100X110110XXX00X00101X010X\nmem[34061] \x3D 8335\nmem[19672] \x3D 806\nmem[20346] \x3D 45051423\nmem[36909] \x3D 75717\nmem[14949] \x3D 12484\nmask \x3D X00XX1100100111X00X11XX00000110X1010\nmem[32991] \x3D 13151\nmem[26489] \x3D 54180147\nmem[55564] \x3D 5690\nmem[7187] \x3D 807798\nmem[4660] \x3D 21323\nmask \x3D 0001X01001100111101X0111101X1110001X\nmem[53378] \x3D 33491\nmem[11625] \x3D 23905844\nmem[11286] \x3D 226133438\nmem[59562] \x3D 61\nmem[39496] \x3D 45492350\nmem[35168] \x3D 1063\nmem[35116] \x3D 1135415\nmask \x3D 1X011X100X1001X1111011011XX000010100\nmem[14949] \x3D 7088\nmem[27179] \x3D 249426\nmem[12840] \x3D 3398667\nmask \x3D 100110X0X1X0011111011X0001XX00111X1X\nmem[9310] \x3D 377264021\nmem[39496] \x3D 5310\nmask \x3D 1X0111100X0011X10001100X00X0X1X0X01X\nmem[23624] \x3D 3559669\nmem[4358] \x3D 25901\nmask \x3D X0X1111001X0111X11011X00110000000X10\nmem[41470] \x3D 74601\nmem[46470] \x3D 28860028\nmem[28699] \x3D 579\nmem[50915] \x3D 8018491\nmem[9582] \x3D 512\nmem[17809] \x3D 2468\nmem[19264] \x3D 382929593\nmask \x3D 1X01X01001X001X1XX100111X0000X110000\nmem[53852] \x3D 671\nmem[829] \x3D 14607863\nmem[59475] \x3D 42176426\nmem[50352] \x3D 917431806\nmem[25565] \x3D 2735024\nmem[31268] \x3D 8203\nmem[63568] \x3D 18725\nmask \x3D 1011X01101X0X0X1X1X0X0110X0100001110\nmem[14581] \x3D 534274885\nmem[60208] \x3D 23685066\nmem[59262] \x3D 268487956\nmem[243] \x3D 75944\nmask \x3D 1001XX0001X01111001XX1X0X01000X10X11\nmem[53831] \x3D 4237440\nmem[24052] \x3D 1451049\nmem[64125] \x3D 432782904\nmem[8892] \x3D 15419\nmask \x3D 10X0101101000X1XX010100X110001XXX11X\nmem[47441] \x3D 9514\nmem[24633] \x3D 4407646\nmem[40184] \x3D 15477\nmem[1696] \x3D 106342632\nmem[36011] \x3D 606150\nmem[14545] \x3D 874\nmask \x3D 100X1XX11110X001X1X011000X0011010100\nmem[18822] \x3D 1345\nmem[31329] \x3D 49781332\nmem[1256] \x3D 23323\nmem[47095] \x3D 360\nmem[28233] \x3D 122942\nmask \x3D 1X01XX100100X1110X1110X10001X100X00X\nmem[20346] \x3D 6255\nmem[2088] \x3D 10531698\nmem[19802] \x3D 23124041\nmem[13152] \x3D 64318\nmask \x3D 1XX110100X100011011000XX10X00XX10X00\nmem[55530] \x3D 462159\nmem[53302] \x3D 4050\nmask \x3D 11X1X01X00X0X011X1101100100X101X100X\nmem[32170] \x3D 2300\nmem[60379] \x3D 1946048\nmem[38974] \x3D 935362865\nmem[30527] \x3D 38214\nmem[39317] \x3D 309\nmask \x3D 0X0XX11011X001X11X101011111X01100101\nmem[6761] \x3D 3363\nmem[30072] \x3D 488192925\nmem[30577] \x3D 5587652\nmem[36815] \x3D 820921800\nmem[48185] \x3D 90597685\nmem[45346] \x3D 14766\nmask \x3D 10XX000X0100000X011000X1X1X0X1X00101\nmem[65328] \x3D 277939257\nmem[32705] \x3D 259305\nmem[8201] \x3D 1708\nmask \x3D 100110X101100X01X110X011X001101X1101\nmem[1321] \x3D 133255266\nmem[33628] \x3D 464\nmem[58727] \x3D 673\nmask \x3D 1001101001X001010XX0X00001X0X0100000\nmem[19034] \x3D 17040206\nmem[34637] \x3D 15994570\nmem[58564] \x3D 7623\nmask \x3D 1001101101100101011X11110000X1001XX0\nmem[23305] \x3D 8044\nmem[64547] \x3D 395\nmem[37420] \x3D 27907889\nmem[27608] \x3D 612\nmem[7901] \x3D 680129\nmem[2047] \x3D 829469\nmask \x3D 1X0X0X100100111100011011100111XX1100\nmem[55530] \x3D 17794\nmem[35214] \x3D 6843366\nmem[55948] \x3D 325722\nmem[50625] \x3D 1010688\nmem[1409] \x3D 7196\nmem[61824] \x3D 484817479\nmem[18803] \x3D 12612636\nmask \x3D 1001X01XX1X0X1111X1001110X110X011101\nmem[28127] \x3D 1963295\nmem[11625] \x3D 1018106\nmem[30920] \x3D 1636\nmem[15448] \x3D 10027\nmem[13104] \x3D 13415208\nmask \x3D 11011010011101111X100000X0X110XXX101\nmem[32426] \x3D 26317976\nmem[33610] \x3D 953396121\nmem[18997] \x3D 205749058\nmask \x3D 1001101XX1100XX1011010XXXX00011X1100\nmem[16512] \x3D 115996365\nmem[9541] \x3D 816\nmem[2017] \x3D 47814977\nmem[48769] \x3D 6960\nmem[57904] \x3D 17542395\nmem[31268] \x3D 536187\nmask \x3D 100X101011X0X1X100100010101000X1100X\nmem[12315] \x3D 151687693\nmem[2426] \x3D 585162\nmem[58101] \x3D 840013\nmask \x3D X00110000100111100X1001001000XX00XXX\nmem[61146] \x3D 100666431\nmem[64619] \x3D 4637046\nmem[27122] \x3D 237312\nmem[43315] \x3D 2538822\nmem[6097] \x3D 889148\nmask \x3D 101110100X10X0110110111X1X001000X110\nmem[59937] \x3D 1039821042\nmem[5228] \x3D 20695323\nmem[16793] \x3D 1847174\nmem[58963] \x3D 11095\nmem[22680] \x3D 5166227\nmem[44856] \x3D 15083\nmask \x3D X001X0111X10X0110X10X1X0010110010100\nmem[60974] \x3D 391897\nmem[54413] \x3D 376986\nmem[16685] \x3D 488\nmask \x3D 1X0X0X00X0000111X00110X10X000110X000\nmem[16055] \x3D 28402351\nmem[30402] \x3D 379124674\nmem[34946] \x3D 13507\nmem[52357] \x3D 5299\nmem[64564] \x3D 106012728\nmem[2719] \x3D 45355693\nmem[12] \x3D 89762\nmask \x3D XX011X1111X00011X1X0010000001101X101\nmem[29208] \x3D 29115\nmem[18551] \x3D 426909992\nmem[23699] \x3D 15195667\nmem[3422] \x3D 11107\nmem[34134] \x3D 15916\nmem[18069] \x3D 1238938\nmem[50734] \x3D 4062867\nmask \x3D 1001X000XX00011100X100X1100XX11000X0\nmem[62530] \x3D 18469859\nmem[54219] \x3D 239365\nmem[43155] \x3D 3473\nmem[38944] \x3D 358650\nmask \x3D 1X01001X11001110X11X1010X0X111X010XX\nmem[10724] \x3D 2916217\nmem[44147] \x3D 416\nmem[4105] \x3D 2413\nmem[38699] \x3D 1661\nmem[64725] \x3D 1933034\nmem[20996] \x3D 13732\nmem[63194] \x3D 484290\nmask \x3D 1001X010110X1111X11111110011X0010000\nmem[56756] \x3D 53912\nmem[55265] \x3D 2802\nmem[55521] \x3D 61411987\nmem[43040] \x3D 1167\nmask \x3D 1XX1111101001X11001001111110101X1011\nmem[29769] \x3D 87000096\nmem[15343] \x3D 480461\nmem[16428] \x3D 51254247\nmem[13162] \x3D 53048239\nmask \x3D 100100100100XX010X1001XX1XXXX0100100\nmem[13117] \x3D 136\nmem[63074] \x3D 35112135\nmask \x3D 1101101001XX01110010111X100XX11X1XX0\nmem[21012] \x3D 2037\nmem[54144] \x3D 3133068\nmem[63961] \x3D 14080353\nmask \x3D 1001X11X01101111110X10X1010001000X0X\nmem[62471] \x3D 12508052\nmem[14338] \x3D 435627\nmem[318] \x3D 3687092\nmem[64508] \x3D 2664\nmem[58433] \x3D 14556\nmem[8995] \x3D 938\nmem[32875] \x3D 1012574980\nmask \x3D 1X01XX100X10011101X01001011X11011X01\nmem[26989] \x3D 97197022\nmem[9541] \x3D 150895995\nmem[36956] \x3D 174431384\nmem[43247] \x3D 2881\nmem[6758] \x3D 18074756\nmem[35444] \x3D 3197755\nmem[42854] \x3D 28212\nmask \x3D 100X101X0X00X1110010100011X0X01X1010\nmem[17239] \x3D 76342363\nmem[48185] \x3D 30296621\nmem[26693] \x3D 55049\nmem[30110] \x3D 28232858\nmem[40609] \x3D 197705858\nmem[63074] \x3D 1491954\nmask \x3D 100X1X1XX100111100XXX01110X00000101X\nmem[28233] \x3D 16456060\nmem[37936] \x3D 1485\nmem[60589] \x3D 1108\nmem[58201] \x3D 178477087\nmem[35353] \x3D 5172\nmem[58317] \x3D 582\nmem[3707] \x3D 124900\nmask \x3D 1001X0110XXXX11X1X100101101X000X1011\nmem[6853] \x3D 53203870\nmem[10134] \x3D 15607855\nmem[55789] \x3D 65720\nmem[40948] \x3D 26255\nmem[23925] \x3D 247\nmask \x3D 10XX00X001X0X11101100101100X0XX1X011\nmem[21991] \x3D 12365\nmem[60284] \x3D 475281124\nmem[27156] \x3D 712381\nmem[40992] \x3D 32030028\nmem[55639] \x3D 459820\nmask \x3D XX0110000100011X1X011101111X0X0001X1\nmem[21777] \x3D 23804\nmem[18660] \x3D 16096160\nmem[13001] \x3D 133879324\nmem[55679] \x3D 16534\nmem[35334] \x3D 95963075\nmask \x3D 1111X01X01100X01X1X00101000010101X01\nmem[42543] \x3D 830\nmem[35104] \x3D 119069\nmem[30672] \x3D 237624\nmem[57513] \x3D 11273\nmem[24425] \x3D 8038\nmem[15062] \x3D 880\nmem[3370] \x3D 1147051\nmask \x3D 100110X00100X111001X10X100XX0010X0X0\nmem[34880] \x3D 47552929\nmem[56463] \x3D 1311038\nmem[34134] \x3D 48583\nmem[26841] \x3D 28022630\nmem[34391] \x3D 238829624\nmem[61488] \x3D 64163\nmask \x3D 100110100X000X11001000111000X1X00000\nmem[64564] \x3D 9373265\nmem[45253] \x3D 516852473\nmem[54102] \x3D 7680\nmem[56373] \x3D 6272\nmem[32800] \x3D 20520227\nmask \x3D 100XX0X00100011100110001X00X01X00000\nmem[11445] \x3D 17299797\nmem[45739] \x3D 26477\nmem[35104] \x3D 8020\nmem[44856] \x3D 5098\nmask \x3D 100110100XXX0111001010XX0100001100X0\nmem[31855] \x3D 4562526\nmem[37196] \x3D 49264053\nmask \x3D 10011X1011X0011X1X010X00000000100X11\nmem[51356] \x3D 2533530\nmem[21991] \x3D 617827134\nmem[59007] \x3D 146920\nmask \x3D 10X11010001000110110001010XX101X1110\nmem[17438] \x3D 724\nmem[40037] \x3D 26066923\nmem[62740] \x3D 64849289\nmem[51356] \x3D 362548959\nmask \x3D 1001111XX000X1010001X1X1X010X1X00001\nmem[62654] \x3D 495\nmem[13661] \x3D 784\nmem[2201] \x3D 825060967\nmem[56463] \x3D 25468\nmem[11152] \x3D 332175\nmem[11201] \x3D 318547\nmem[56898] \x3D 19359\nmask \x3D 10011011111X011X01101010X00101001X11\nmem[39227] \x3D 183088177\nmem[11942] \x3D 18427\nmem[56845] \x3D 74552997\nmem[9386] \x3D 30899\nmem[7664] \x3D 28246572\nmask \x3D 1001101001100X11X11X100010X00X110XX0\nmem[18885] \x3D 28794\nmem[1321] \x3D 2616\nmem[31268] \x3D 1924\nmem[26938] \x3D 384173\nmem[12796] \x3D 400542613\nmem[64037] \x3D 104083\nmask \x3D 1001X01101X001010110110X0110000011X0\nmem[47972] \x3D 49309\nmem[45634] \x3D 85099607\nmem[34920] \x3D 28977\nmem[58564] \x3D 2559\nmem[4311] \x3D 700\nmem[60974] \x3D 658\nmem[5228] \x3D 4807\nmask \x3D XX011X11X1100011011X010X100011000110\nmem[17753] \x3D 70529\nmem[17324] \x3D 248339160\nmem[60589] \x3D 5812\nmask \x3D 11011110010X0X110X111011X1000X0X10XX\nmem[35474] \x3D 63093\nmem[35770] \x3D 170945\nmem[31209] \x3D 658557270\nmem[41345] \x3D 3895120\nmem[28522] \x3D 164751383\nmask \x3D X0X11XX01100011111X1X0000100XX111000\nmem[8995] \x3D 18206851\nmem[21601] \x3D 756\nmem[64169] \x3D 2372\nmem[54020] \x3D 40408\nmask \x3D 000111XX0100XX1100010000000010000110\nmem[32975] \x3D 11379458\nmem[35264] \x3D 191\nmem[48634] \x3D 372213\nmem[37443] \x3D 12419\nmem[11441] \x3D 168862967\nmask \x3D 1X0001100100X1X1XXXX100000X011101X01\nmem[60955] \x3D 121774\nmem[33433] \x3D 728\nmem[34602] \x3D 174\nmem[41800] \x3D 4552421\nmask \x3D 10011010X11000X1XXX0111100001X111000\nmem[6773] \x3D 15578957\nmem[28044] \x3D 3493208\nmem[62407] \x3D 169767\nmem[51334] \x3D 52448434\nmem[53093] \x3D 4752\nmem[14545] \x3D 1251\nmask \x3D 100110X01XX0X11111110110X01100110XXX\nmem[18935] \x3D 231360\nmem[19721] \x3D 876\nmem[63491] \x3D 56496605\nmask \x3D 10011010X110011X11X10X10101000010000\nmem[61488] \x3D 115634\nmem[1321] \x3D 19197\nmem[33154] \x3D 31600682\nmask \x3D 10011X1101X00111101X10X101X11010000X\nmem[31209] \x3D 30697\nmem[30292] \x3D 56770\nmem[46372] \x3D 4474\nmem[22434] \x3D 894\nmask \x3D X1011X11XXXXX01101X0X100100001100011\nmem[33610] \x3D 386\nmem[46743] \x3D 9985\nmem[18581] \x3D 25393973\nmask \x3D 1XX100X101X000010X10X011X001101X0101\nmem[56281] \x3D 2427\nmem[23013] \x3D 124563907\nmem[41470] \x3D 6819267\nmem[58727] \x3D 5142531\nmem[63093] \x3D 802798807\nmem[58709] \x3D 88\nmask \x3D 1001101X11100X011110010001XX010X01X0\nmem[35264] \x3D 9076212\nmem[58092] \x3D 3559173\nmem[48925] \x3D 58523913\nmem[28101] \x3D 402638054\nmask \x3D 10011010011001010111100001XX0010X0X1\nmem[47972] \x3D 128418944\nmem[62530] \x3D 288\nmem[17179] \x3D 77713212\nmask \x3D X0011011X0100X010110100X000100011100\nmem[24524] \x3D 107898\nmem[46010] \x3D 82127781\nmem[45253] \x3D 156159\nmask \x3D X0011X000100X1110X11100110000XX01010\nmem[47222] \x3D 15963\nmem[13206] \x3D 184605823\nmem[34890] \x3D 92193985\nmem[64547] \x3D 606039\nmask \x3D 1X0X101X011X011101101X111X000X1X0001\nmem[4144] \x3D 85071\nmem[63340] \x3D 3568335\nmem[42980] \x3D 2223\nmem[65165] \x3D 15723492\nmem[55303] \x3D 228834\nmem[41409] \x3D 120704\nmask \x3D X0X11X1011X0XX1111100X0110110111X1X0\nmem[28969] \x3D 5451626\nmem[23890] \x3D 202\nmem[32579] \x3D 893738\nmem[19768] \x3D 9755\nmem[46679] \x3D 4469\nmem[10572] \x3D 2621\nmask \x3D 1X01X010011X011111X001XX0001101X100X\nmem[13230] \x3D 4177769\nmem[6789] \x3D 1570\nmem[12814] \x3D 6330042\nmem[19862] \x3D 399947\nmask \x3D 100X0110X1001111001111X10001X1100000\nmem[16428] \x3D 62747997\nmem[57753] \x3D 3812740\nmem[53818] \x3D 2042073\nmem[57170] \x3D 65402596\nmask \x3D 00000110010X1X1X0011010000001X0X1X1X\nmem[39125] \x3D 231032\nmem[41182] \x3D 8309392\nmem[41659] \x3D 69862358\nmem[2426] \x3D 3954\nmem[29634] \x3D 1877\nmask \x3D 10011XX00X00110100X11X01100001X10000\nmem[3276] \x3D 165739267\nmem[18985] \x3D 215914582\nmem[51726] \x3D 2911\nmem[1198] \x3D 2689\nmem[25096] \x3D 38217\nmem[65146] \x3D 750396\nmask \x3D 100X000X11100111X0111X111X010X0X0100\nmem[55354] \x3D 71488486\nmem[26941] \x3D 153429\nmem[27903] \x3D 1242771\nmem[20076] \x3D 13658750\nmask \x3D 1X0X1X111100011110100X11XX0001X01101\nmem[8106] \x3D 8655\nmem[13105] \x3D 326089686\nmask \x3D 11110011011000010110XX0X1X0111X0X1X1\nmem[47972] \x3D 4628833\nmem[64742] \x3D 108229\nmem[20310] \x3D 234311\nmem[22525] \x3D 1268681\nmem[57315] \x3D 2293399\nmem[1415] \x3D 309220\nmask \x3D 1X01101001100X110X10X01110000X110001\nmem[63491] \x3D 55284\nmem[6892] \x3D 1776247\nmem[22680] \x3D 10087682\nmask \x3D 100110100X100111XX10X011100100101001\nmem[32836] \x3D 529\nmem[60379] \x3D 108710\nmem[3707] \x3D 119489129\nmem[41220] \x3D 407759\nmem[17438] \x3D 4570597\nmem[18735] \x3D 116991\nmem[45194] \x3D 632\nmask \x3D 10X100000X10111100100110001X01X000X0\nmem[29832] \x3D 17415\nmem[18326] \x3D 149774707\nmem[61969] \x3D 27327701\nmask \x3D 10011X100110X1X1X1X1101X000000X00X10\nmem[37977] \x3D 32149847\nmem[10572] \x3D 23418\nmem[21601] \x3D 46807\nmem[3432] \x3D 205866675\nmem[15290] \x3D 52828\nmask \x3D 1001X0X0010X111100101X100X0X000001X0\nmem[29496] \x3D 3463669\nmem[22900] \x3D 14028901\nmem[59821] \x3D 26258\nmem[6007] \x3D 3083265\nmem[26841] \x3D 223727\nmask \x3D 100110XX010001110001X000100X0X110X11\nmem[47185] \x3D 37062\nmem[53497] \x3D 486088\nmem[20646] \x3D 1031395\nmem[51185] \x3D 335\nmem[42320] \x3D 2256917\nmask \x3D X1011X1X0XX00101011010X10000XX010000\nmem[24688] \x3D 536538\nmem[30782] \x3D 45733\nmask \x3D 100010110X0X00100X10100X01X01011110X\nmem[3691] \x3D 61776413\nmem[37654] \x3D 3873\nmem[32875] \x3D 780114\nmask \x3D 10011X001X1X011X1111X010X00X1X110001\nmem[54410] \x3D 836\nmem[63661] \x3D 970522\nmem[62471] \x3D 1855\nmem[16994] \x3D 201\nmem[27546] \x3D 1249156\nmem[37773] \x3D 220004102\nmem[39306] \x3D 22122687\nmask \x3D 10011011XX10010101101X0100X01X001000\nmem[16428] \x3D 1095\nmem[56732] \x3D 121853353\nmem[58092] \x3D 234\nmask \x3D X010X01X010011X101X001X11000X0XX1011\nmem[367] \x3D 74756331\nmem[55921] \x3D 529419\nmem[39160] \x3D 278975\nmem[6758] \x3D 920\nmem[32922] \x3D 33406\nmem[59763] \x3D 1563\nmem[10382] \x3D 886\nmask \x3D 10011X100XX0010110100011001X10010X01\nmem[25565] \x3D 26956\nmem[23146] \x3D 57605\nmem[28925] \x3D 962\nmask \x3D 1X11X100X100011X111XX010001110X01011\nmem[35334] \x3D 92117904\nmem[34488] \x3D 59287493\nmem[7861] \x3D 64986498\nmask \x3D X001X0XXX1X00111X01110111X0101100X00\nmem[50457] \x3D 17353399\nmem[62959] \x3D 16719393\nmem[49674] \x3D 134654\nmem[55789] \x3D 2243\nmem[22434] \x3D 99455\nmem[8288] \x3D 142594569\nmask \x3D 10011010X11001111111110010X00X1X0001\nmem[37420] \x3D 41618762\nmem[11560] \x3D 48435\nmem[829] \x3D 2389\nmem[40014] \x3D 70681907\nmem[36217] \x3D 715125593\nmem[30774] \x3D 510\nmem[15212] \x3D 10840", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"mask \x3D XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X\nmem[8] \x3D 11\nmem[7] \x3D 101\nmem[8] \x3D 0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"mask \x3D 000000000000000000000000000000X1001X\nmem[42] \x3D 100\nmask \x3D 00000000000000000000000000000000X0XX\nmem[26] \x3D 1", Scope = Private
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
