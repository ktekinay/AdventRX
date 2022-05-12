#tag Class
Protected Class Advent_2021_12_13
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( kInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( kInput )
		  
		  // Answer is ECFHLHZF
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
		  var lastXIndex as integer
		  var lastYIndex as integer
		  var grid( -1, -1 ) as boolean = GetGrid( input, lastXIndex, lastYIndex )
		  var instructions() as pair = GetInstructions( input )
		  
		  Fold( grid, instructions( 0 ), lastXIndex, lastYIndex )
		  var display as string = ToDisplay( grid, lastXIndex, lastYIndex )
		  #pragma unused display
		  
		  return Count( grid, lastXIndex, lastYIndex )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var lastXIndex as integer
		  var lastYIndex as integer
		  var grid( -1, -1 ) as boolean = GetGrid( input, lastXIndex, lastYIndex )
		  var instructions() as pair = GetInstructions( input )
		  
		  var display as string
		  
		  for each instruction as pair in instructions
		    Fold( grid, instruction, lastXIndex, lastYIndex )
		    display = display
		  next
		  
		  display = ToDisplay( grid, lastXIndex, lastYIndex )
		  display = display
		  Print display
		  
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Count(grid(, ) As Boolean, lastXIndex As Integer, lastYIndex As Integer) As Integer
		  var count as integer
		  
		  for x as integer = 0 to lastXIndex
		    for y as integer = 0 to lastYIndex
		      if grid( x, y ) then
		        count = count + 1
		      end if
		    next y
		  next x
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Fold(grid(, ) As Boolean, instruction As Pair, ByRef lastXIndex As Integer, ByRef lastYIndex As Integer)
		  var direction as Directions = instruction.Left
		  var rowOrColumn as integer = instruction.Right
		  
		  var fromBaseLine as integer
		  
		  select case direction
		  case Directions.Up
		    do
		      fromBaseLine = fromBaseLine + 1
		      var fromY as integer = rowOrColumn + fromBaseLine
		      if fromY > lastYIndex then
		        exit
		      end if
		      var toY as integer = rowOrColumn - fromBaseLine
		      for x as integer = 0 to lastXIndex
		        grid( x, toY ) = grid( x, toY ) or grid( x, fromY )
		      next
		    loop
		    
		    lastYIndex = rowOrColumn - 1
		    
		  case Directions.Left
		    do
		      fromBaseLine = fromBaseLine + 1
		      var fromX as integer = rowOrColumn + fromBaseLine
		      if fromX > lastXIndex then
		        exit
		      end if
		      var toX as integer = rowOrColumn - fromBaseLine
		      for y as integer = 0 to lastYIndex
		        grid( toX, y ) = grid( toX, y ) or grid( fromX, y )
		      next
		    loop
		    
		    lastXIndex = rowOrColumn - 1
		    
		  end select
		  
		  grid.ResizeTo( lastXIndex, lastYIndex )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetGrid(input As String, ByRef lastXIndex As Integer, ByRef lastYIndex As Integer) As Boolean(,)
		  var parts() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine + EndOfLine )
		  var rows() as string = parts( 0 ).Split( EndOfLine )
		  
		  var xArr() as integer
		  var yArr() as integer
		  
		  for each row as string in rows
		    parts = row.Split( "," )
		    var x as integer = parts( 0 ).Trim.ToInteger
		    var y as integer = parts( 1 ).Trim.ToInteger
		    
		    lastXIndex = max( lastXIndex, x )
		    lastYIndex = max( lastYIndex, y )
		    
		    xArr.Add x
		    yArr.Add y
		  next
		  
		  var grid( -1, -1 ) as boolean
		  grid.ResizeTo lastXIndex, lastYIndex
		  
		  for i as integer = 0 to xArr.LastIndex
		    grid( xArr( i ), yArr( i ) ) = true
		  next i
		  
		  return grid
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetInstructions(input As String) As Pair()
		  var parts() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine + EndOfLine )
		  var rows() as string = parts( 1 ).Split( EndOfLine )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "\b([xy])=(\d+)"
		  
		  var result() as pair
		  for each row as string in rows
		    var direction as Directions
		    var value as integer
		    
		    var match as RegExMatch = rx.Search( row )
		    select case match.SubExpressionString( 1 )
		    case "x"
		      direction = Directions.Left
		    case "y"
		      direction = Directions.Up
		    end select
		    value = match.SubExpressionString( 2 ).ToInteger
		    
		    result.Add direction : value
		  next row
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToDisplay(grid(, ) As Boolean, lastXIndex As Integer, lastYIndex As Integer) As String
		  var display as string
		  
		  var displayBuilder() as string
		  
		  for y as integer = 0 to lastYIndex
		    var builder() as string
		    builder.ResizeTo lastXIndex
		    for x as integer = 0 to lastXIndex
		      if grid( x, y ) then
		        builder( x ) = &uFF0A
		      else
		        builder( x ) = &uFF0E
		      end if
		    next
		    displayBuilder.Add String.FromArray( builder, "" )
		  next
		  
		  display = String.FromArray( displayBuilder, EndOfLine )
		  return display
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"470\x2C705\n331\x2C196\n1241\x2C728\n1034\x2C161\n181\x2C850\n999\x2C484\n480\x2C680\n798\x2C33\n226\x2C86\n475\x2C226\n113\x2C287\n770\x2C702\n47\x2C35\n848\x2C312\n1129\x2C402\n179\x2C326\n766\x2C404\n1258\x2C717\n470\x2C494\n723\x2C434\n418\x2C291\n100\x2C298\n994\x2C316\n423\x2C434\n985\x2C292\n721\x2C261\n528\x2C572\n595\x2C567\n909\x2C665\n411\x2C292\n1056\x2C291\n1051\x2C434\n311\x2C484\n462\x2C312\n187\x2C273\n715\x2C567\n114\x2C819\n634\x2C861\n79\x2C318\n912\x2C344\n1144\x2C845\n152\x2C745\n201\x2C464\n840\x2C185\n291\x2C100\n1084\x2C31\n1255\x2C434\n909\x2C229\n895\x2C827\n557\x2C29\n441\x2C159\n661\x2C193\n826\x2C215\n535\x2C70\n974\x2C767\n254\x2C739\n512\x2C189\n868\x2C75\n1076\x2C9\n700\x2C86\n684\x2C515\n356\x2C422\n348\x2C344\n605\x2C341\n360\x2C586\n383\x2C824\n239\x2C393\n751\x2C12\n253\x2C229\n403\x2C759\n166\x2C273\n1196\x2C819\n406\x2C301\n343\x2C102\n1119\x2C618\n333\x2C892\n711\x2C789\n283\x2C70\n418\x2C603\n380\x2C714\n756\x2C255\n20\x2C375\n1145\x2C794\n642\x2C180\n1140\x2C273\n984\x2C451\n763\x2C619\n196\x2C427\n869\x2C159\n460\x2C96\n35\x2C548\n512\x2C709\n1231\x2C318\n1163\x2C21\n465\x2C275\n32\x2C187\n212\x2C296\n718\x2C835\n1036\x2C42\n1002\x2C672\n108\x2C492\n321\x2C892\n294\x2C0\n252\x2C350\n377\x2C733\n1196\x2C822\n316\x2C344\n254\x2C519\n1168\x2C49\n1158\x2C745\n142\x2C49\n130\x2C504\n397\x2C56\n718\x2C186\n463\x2C170\n482\x2C463\n1032\x2C752\n649\x2C193\n512\x2C158\n895\x2C501\n1150\x2C122\n537\x2C833\n915\x2C434\n790\x2C262\n1058\x2C539\n764\x2C44\n512\x2C861\n493\x2C296\n472\x2C422\n44\x2C86\n1101\x2C592\n671\x2C276\n977\x2C2\n822\x2C621\n179\x2C668\n415\x2C46\n1067\x2C154\n895\x2C169\n475\x2C728\n231\x2C434\n156\x2C103\n1176\x2C72\n113\x2C607\n301\x2C851\n927\x2C824\n346\x2C870\n892\x2C603\n610\x2C86\n1114\x2C19\n295\x2C353\n402\x2C350\n1118\x2C145\n201\x2C318\n681\x2C732\n338\x2C792\n855\x2C733\n202\x2C364\n125\x2C430\n1140\x2C285\n917\x2C309\n1309\x2C542\n10\x2C540\n246\x2C499\n1038\x2C178\n209\x2C609\n242\x2C16\n10\x2C214\n20\x2C519\n276\x2C173\n540\x2C520\n192\x2C582\n681\x2C891\n830\x2C680\n600\x2C44\n895\x2C848\n1009\x2C219\n425\x2C442\n1049\x2C185\n994\x2C166\n1034\x2C733\n453\x2C240\n605\x2C833\n154\x2C71\n141\x2C607\n840\x2C494\n131\x2C87\n1084\x2C86\n1193\x2C592\n1163\x2C166\n847\x2C724\n329\x2C318\n567\x2C46\n850\x2C798\n554\x2C255\n817\x2C598\n723\x2C658\n1027\x2C70\n1154\x2C103\n822\x2C273\n704\x2C290\n985\x2C72\n386\x2C593\n1015\x2C353\n907\x2C435\n867\x2C847\n711\x2C835\n415\x2C718\n903\x2C343\n252\x2C539\n574\x2C310\n295\x2C801\n156\x2C733\n1173\x2C395\n736\x2C218\n700\x2C360\n865\x2C144\n1044\x2C240\n708\x2C628\n354\x2C262\n1298\x2C42\n987\x2C250\n857\x2C430\n184\x2C185\n1066\x2C14\n130\x2C894\n917\x2C585\n882\x2C596\n156\x2C791\n868\x2C296\n1248\x2C29\n1300\x2C354\n1180\x2C504\n542\x2C385\n710\x2C850\n172\x2C407\n1064\x2C310\n962\x2C166\n458\x2C504\n992\x2C295\n517\x2C667\n95\x2C12\n484\x2C299\n523\x2C390\n865\x2C733\n326\x2C82\n1300\x2C91\n69\x2C728\n470\x2C548\n1015\x2C541\n141\x2C735\n278\x2C756\n1237\x2C140\n642\x2C714\n728\x2C71\n1064\x2C666\n1128\x2C477\n301\x2C403\n677\x2C159\n340\x2C266\n984\x2C812\n972\x2C792\n212\x2C374\n828\x2C463\n987\x2C810\n1109\x2C318\n212\x2C178\n1275\x2C548\n1016\x2C894\n962\x2C128\n840\x2C548\n10\x2C149\n933\x2C833\n80\x2C411\n1136\x2C883\n676\x2C766\n421\x2C632\n242\x2C786\n131\x2C721\n274\x2C189\n407\x2C576\n80\x2C35\n393\x2C361\n425\x2C421\n184\x2C397\n1101\x2C196\n1154\x2C411\n529\x2C878\n711\x2C518\n1223\x2C270\n579\x2C459\n343\x2C838\n428\x2C415\n933\x2C733\n930\x2C628\n55\x2C294\n1226\x2C336\n378\x2C721\n435\x2C553\n546\x2C492\n1019\x2C100\n763\x2C684\n1076\x2C885\n1150\x2C772\n276\x2C876\n574\x2C51\n25\x2C610\n117\x2C644\n410\x2C563\n311\x2C838\n192\x2C817\n626\x2C696\n1309\x2C352\n604\x2C18\n1036\x2C705\n782\x2C124\n338\x2C464\n502\x2C774\n1243\x2C882\n950\x2C756\n1232\x2C593\n25\x2C284\n853\x2C173\n1295\x2C614\n1144\x2C534\n44\x2C534\n1118\x2C312\n954\x2C515\n410\x2C747\n806\x2C348\n1193\x2C644\n1248\x2C59\n700\x2C836\n247\x2C318\n1121\x2C739\n681\x2C715\n1185\x2C430\n759\x2C103\n459\x2C504\n981\x2C292\n1131\x2C668\n798\x2C64\n728\x2C39\n251\x2C435\n688\x2C187\n326\x2C451\n828\x2C351\n654\x2C869\n723\x2C712\n1300\x2C680\n442\x2C598\n1310\x2C645\n688\x2C222\n994\x2C344\n277\x2C833\n309\x2C318\n26\x2C184\n711\x2C387\n418\x2C515\n1109\x2C436\n274\x2C705\n1131\x2C813\n618\x2C614\n229\x2C298\n388\x2C128\n411\x2C366\n125\x2C464\n3\x2C362\n131\x2C173\n1216\x2C772\n830\x2C540\n572\x2C115\n922\x2C576\n830\x2C214\n520\x2C184\n895\x2C718\n808\x2C203\n443\x2C847\n729\x2C453\n781\x2C240\n1078\x2C794\n1282\x2C144\n196\x2C390\n502\x2C203\n992\x2C711\n557\x2C588\n934\x2C828\n1010\x2C632\n212\x2C520\n174\x2C11\n976\x2C630\n1066\x2C147\n913\x2C822\n731\x2C459\n213\x2C93\n244\x2C270\n306\x2C791\n254\x2C155\n103\x2C103\n671\x2C52\n1128\x2C271\n1010\x2C262\n62\x2C708\n412\x2C556\n5\x2C193\n294\x2C446\n828\x2C95\n201\x2C458\n838\x2C271\n47\x2C859\n314\x2C628\n425\x2C473\n571\x2C654\n994\x2C540\n567\x2C841\n236\x2C575\n141\x2C287\n197\x2C621\n480\x2C206\n868\x2C534\n435\x2C822\n62\x2C59\n363\x2C346\n1056\x2C739\n201\x2C10\n994\x2C680\n907\x2C135\n974\x2C743\n1168\x2C64\n380\x2C180\n247\x2C103\n1225\x2C747\n841\x2C287\n79\x2C352\n295\x2C161\n393\x2C306\n864\x2C646\n1158\x2C149\n348\x2C128\n348\x2C469\n189\x2C739\n199\x2C285\n318\x2C711\n888\x2C794\n1109\x2C458\n1068\x2C108\n463\x2C724\n397\x2C822\n1255\x2C294\n917\x2C185\n272\x2C716\n706\x2C466\n979\x2C644\n887\x2C460\n1053\x2C838\n1131\x2C226\n1173\x2C787\n979\x2C196\n557\x2C865\n441\x2C735\n1290\x2C519\n1044\x2C576\n1222\x2C854\n989\x2C165\n107\x2C723\n1238\x2C155\n67\x2C460\n1238\x2C71\n1213\x2C726\n443\x2C47\n316\x2C166\n711\x2C105\n498\x2C273\n70\x2C102\n65\x2C585\n475\x2C442\n599\x2C789\n32\x2C873\n1012\x2C379\n623\x2C609\n10\x2C91\n569\x2C147\n1067\x2C814\n580\x2C798\n321\x2C2\n209\x2C196\n967\x2C410\n1230\x2C411\n1282\x2C870\n731\x2C87\n736\x2C859\n294\x2C894\n546\x2C402\n334\x2C630\n559\x2C12\n651\x2C196\n65\x2C261\n1149\x2C598\n473\x2C492\n393\x2C452\n629\x2C491\n480\x2C763\n1202\x2C44\n1261\x2C61\n1056\x2C519\n992\x2C127\n972\x2C430\n740\x2C562\n344\x2C290\n882\x2C479\n45\x2C644\n1193\x2C302\n1113\x2C273\n58\x2C525\n718\x2C865\n400\x2C515\n1084\x2C479\n1074\x2C603\n835\x2C450\n316\x2C728\n480\x2C373\n1154\x2C733\n892\x2C575\n1097\x2C129\n353\x2C59\n1136\x2C688\n1128\x2C422\n547\x2C619\n587\x2C182\n962\x2C344\n622\x2C707\n626\x2C198\n1154\x2C483\n75\x2C135\n277\x2C161\n894\x2C406\n278\x2C534\n951\x2C609\n711\x2C152\n70\x2C550\n738\x2C432\n907\x2C759\n882\x2C534\n923\x2C327\n933\x2C229\n383\x2C294\n25\x2C3\n1009\x2C851\n507\x2C614\n174\x2C883\n295\x2C129\n276\x2C428\n446\x2C86\n318\x2C767\n703\x2C859\n1094\x2C710\n480\x2C688\n1184\x2C124\n336\x2C127\n923\x2C567\n790\x2C184\n1285\x2C284\n152\x2C579\n599\x2C742\n1197\x2C287\n639\x2C500\n467\x2C273\n785\x2C495\n300\x2C262\n855\x2C285\n277\x2C285\n267\x2C567\n403\x2C459\n1179\x2C56\n1029\x2C801\n551\x2C103\n1289\x2C159\n415\x2C515\n97\x2C596\n1109\x2C884\n885\x2C227\n166\x2C534\n213\x2C129\n927\x2C70\n472\x2C623\n1113\x2C49\n480\x2C354\n166\x2C397\n1034\x2C721\n629\x2C610\n376\x2C590\n442\x2C411\n676\x2C861\n1230\x2C859\n1068\x2C878\n278\x2C590\n49\x2C161\n899\x2C528\n759\x2C791\n1071\x2C169\n1230\x2C758\n1032\x2C380\n271\x2C387\n974\x2C711\n0\x2C197\n70\x2C400\n806\x2C856\n987\x2C698\n1038\x2C380\n395\x2C460\n793\x2C107\n376\x2C828\n405\x2C152\n78\x2C301\n256\x2C550\n1113\x2C497\n892\x2C274\n853\x2C721\n783\x2C865\n397\x2C166\n579\x2C87\n243\x2C154\n454\x2C280\n999\x2C500\n898\x2C502\n55\x2C600\n621\x2C161\n786\x2C894\n1144\x2C808\n192\x2C134\n1126\x2C285\n196\x2C245\n1290\x2C833\n1223\x2C501\n847\x2C276\n835\x2C452\n1228\x2C523\n653\x2C542\n413\x2C250\n1200\x2C490\n278\x2C304\n813\x2C365\n582\x2C855\n633\x2C735\n520\x2C710\n398\x2C344\n1145\x2C122\n740\x2C332\n1131\x2C529\n544\x2C180\n1039\x2C61\n363\x2C548\n981\x2C740\n830\x2C521\n674\x2C865\n736\x2C676\n300\x2C632\n671\x2C170\n572\x2C299\n185\x2C607\n907\x2C459\n1196\x2C72\n687\x2C285\n196\x2C19\n55\x2C434\n999\x2C813\n288\x2C754\n446\x2C646\n981\x2C154\n587\x2C460\n323\x2C810\n1126\x2C497\n110\x2C714\n512\x2C326\n830\x2C354\n1232\x2C301\n266\x2C240\n172\x2C487\n1208\x2C152\n618\x2C280\n766\x2C714\n721\x2C633\n316\x2C680\n987\x2C523\n147\x2C614\n672\x2C380\n467\x2C173\n253\x2C665\n840\x2C189\n673\x2C878\n944\x2C754\n278\x2C75\n1163\x2C813\n927\x2C294\n1310\x2C197\n1183\x2C865\n47\x2C488\n152\x2C315\n472\x2C477\n770\x2C371\n388\x2C766\n108\x2C44\n863\x2C294\n629\x2C715\n1043\x2C775\n924\x2C593\n1179\x2C838\n703\x2C655\n1213\x2C596\n985\x2C766\n830\x2C11\n1031\x2C721\n623\x2C285\n130\x2C448\n380\x2C628\n72\x2C739\n84\x2C749\n977\x2C729\n318\x2C183\n229\x2C227\n687\x2C733\n179\x2C564\n415\x2C270\n606\x2C138\n1274\x2C280\n295\x2C541\n1054\x2C550\n610\x2C836\n239\x2C583\n524\x2C894\n383\x2C600\n1102\x2C808\n830\x2C883\n828\x2C543\n686\x2C845\n252\x2C544\n832\x2C490\n1109\x2C10\n1009\x2C267\n869\x2C765\n822\x2C360\n928\x2C716\n1118\x2C817\n1063\x2C103\n10\x2C680\n497\x2C813\n295\x2C609\n1230\x2C310\n1042\x2C145\n1144\x2C397\n70\x2C494\n226\x2C31\n378\x2C466\n401\x2C441\n592\x2C29\n257\x2C838\n366\x2C754\n174\x2C540\n1253\x2C49\n78\x2C593\n903\x2C576\n764\x2C828\n382\x2C716\n793\x2C499\n1063\x2C576\n316\x2C878\n1128\x2C417\n1298\x2C266\n520\x2C262\n10\x2C354\n388\x2C576\n403\x2C435\n393\x2C451\n626\x2C750\n610\x2C58\n279\x2C721\n358\x2C574\n239\x2C400\n1010\x2C184\n1253\x2C845\n415\x2C67\n867\x2C47\n1032\x2C75\n1156\x2C519\n254\x2C827\n582\x2C603\n360\x2C696\n1071\x2C311\n246\x2C666\n353\x2C851\n838\x2C477\n320\x2C182\n835\x2C220\n1282\x2C24\n200\x2C280\n57\x2C845\n504\x2C856\n741\x2C182\n242\x2C430\n291\x2C794\n\nfold along x\x3D655\nfold along y\x3D447\nfold along x\x3D327\nfold along y\x3D223\nfold along x\x3D163\nfold along y\x3D111\nfold along x\x3D81\nfold along y\x3D55\nfold along x\x3D40\nfold along y\x3D27\nfold along y\x3D13\nfold along y\x3D6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"6\x2C10\n0\x2C14\n9\x2C10\n0\x2C3\n10\x2C4\n4\x2C11\n6\x2C0\n6\x2C12\n4\x2C1\n0\x2C13\n10\x2C12\n3\x2C4\n3\x2C0\n8\x2C4\n1\x2C10\n2\x2C14\n8\x2C10\n9\x2C0\n\nfold along y\x3D7\nfold along x\x3D5", Scope = Private
	#tag EndConstant


	#tag Enum, Name = Directions, Type = Integer, Flags = &h21
		Up
		Left
	#tag EndEnum


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
