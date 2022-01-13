#tag Class
Protected Class Advent_2021_12_07
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


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var arr() as integer = ToIntegerArray( input )
		  arr.Sort
		  
		  var highestPos as integer = arr( arr.LastIndex )
		  
		  var counts() as integer
		  counts.ResizeTo highestPos
		  
		  for each pos as integer in arr
		    counts( pos ) = counts( pos ) + 1
		  next
		  
		  var lowestFuel as integer = 999999999999
		  
		  for target as integer = 0 to highestPos
		    var thisFuel as integer
		    for pos as integer = 0 to counts.LastIndex
		      if pos <> target then
		        thisFuel = thisFuel + ( abs( pos - target ) * counts( pos ) )
		      end if
		    next pos
		    
		    if thisFuel < lowestFuel then
		      lowestFuel = thisFuel
		    end if
		    
		  next target
		  
		  return lowestFuel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var arr() as integer = ToIntegerArray( input )
		  arr.Sort
		  
		  var highestPos as integer = arr( arr.LastIndex )
		  
		  var counts() as integer
		  counts.ResizeTo highestPos
		  
		  for each pos as integer in arr
		    counts( pos ) = counts( pos ) + 1
		  next
		  
		  var lowestFuel as integer = 999999999999
		  
		  for target as integer = 0 to highestPos
		    var thisFuel as integer
		    for pos as integer = 0 to counts.LastIndex
		      if pos <> target then
		        var diff as integer = abs( pos - target )
		        var perm as integer = Permutation( diff )
		        thisFuel = thisFuel + ( perm * counts( pos ) )
		      end if
		    next pos
		    
		    if thisFuel < lowestFuel then
		      lowestFuel = thisFuel
		    end if
		    
		  next target
		  
		  return lowestFuel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Permutation(value As Integer) As Integer
		  var sum as integer
		  
		  if Permutations.LastIndex < value then
		    sum = Permutations( Permutations.LastIndex )
		    
		    var firstIndex as integer = Permutations.Count
		    var lastIndex as integer = value * 2 + 1
		    
		    Permutations.ResizeTo lastIndex
		    
		    for i as integer = firstIndex to lastIndex
		      sum = sum + i
		      Permutations( i ) = sum
		    next
		  end if
		  
		  sum = Permutations( value )
		  
		  return sum
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Permutations(0) As Integer
	#tag EndProperty


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"1101\x2C1\x2C29\x2C67\x2C1102\x2C0\x2C1\x2C65\x2C1008\x2C65\x2C35\x2C66\x2C1005\x2C66\x2C28\x2C1\x2C67\x2C65\x2C20\x2C4\x2C0\x2C1001\x2C65\x2C1\x2C65\x2C1106\x2C0\x2C8\x2C99\x2C35\x2C67\x2C101\x2C99\x2C105\x2C32\x2C110\x2C39\x2C101\x2C115\x2C116\x2C32\x2C112\x2C97\x2C115\x2C32\x2C117\x2C110\x2C101\x2C32\x2C105\x2C110\x2C116\x2C99\x2C111\x2C100\x2C101\x2C32\x2C112\x2C114\x2C111\x2C103\x2C114\x2C97\x2C109\x2C10\x2C33\x2C133\x2C43\x2C1060\x2C890\x2C12\x2C15\x2C136\x2C42\x2C25\x2C96\x2C694\x2C522\x2C893\x2C204\x2C204\x2C1168\x2C311\x2C1046\x2C1699\x2C26\x2C399\x2C299\x2C66\x2C644\x2C402\x2C65\x2C480\x2C711\x2C72\x2C894\x2C244\x2C249\x2C337\x2C331\x2C774\x2C126\x2C23\x2C484\x2C1299\x2C662\x2C404\x2C235\x2C86\x2C1492\x2C556\x2C73\x2C478\x2C210\x2C82\x2C433\x2C597\x2C154\x2C130\x2C178\x2C491\x2C578\x2C856\x2C532\x2C1191\x2C544\x2C256\x2C831\x2C252\x2C1001\x2C109\x2C37\x2C1290\x2C317\x2C376\x2C22\x2C742\x2C496\x2C930\x2C118\x2C28\x2C376\x2C73\x2C247\x2C942\x2C895\x2C38\x2C675\x2C138\x2C387\x2C203\x2C271\x2C104\x2C65\x2C1099\x2C981\x2C167\x2C67\x2C57\x2C607\x2C1095\x2C202\x2C225\x2C1067\x2C1757\x2C324\x2C127\x2C785\x2C266\x2C518\x2C135\x2C914\x2C1006\x2C1402\x2C578\x2C28\x2C548\x2C211\x2C673\x2C302\x2C525\x2C208\x2C115\x2C92\x2C514\x2C518\x2C71\x2C1298\x2C796\x2C780\x2C166\x2C1341\x2C475\x2C273\x2C101\x2C1155\x2C838\x2C1219\x2C901\x2C727\x2C497\x2C168\x2C543\x2C416\x2C174\x2C31\x2C755\x2C865\x2C106\x2C358\x2C236\x2C186\x2C369\x2C550\x2C465\x2C617\x2C375\x2C535\x2C1639\x2C513\x2C419\x2C1377\x2C1024\x2C704\x2C77\x2C38\x2C0\x2C149\x2C5\x2C28\x2C1163\x2C149\x2C1654\x2C614\x2C1201\x2C89\x2C1141\x2C844\x2C1390\x2C1081\x2C132\x2C1385\x2C52\x2C1027\x2C80\x2C572\x2C377\x2C340\x2C39\x2C630\x2C875\x2C692\x2C289\x2C339\x2C358\x2C68\x2C205\x2C54\x2C149\x2C41\x2C1208\x2C1528\x2C171\x2C204\x2C438\x2C571\x2C308\x2C556\x2C1372\x2C426\x2C204\x2C18\x2C31\x2C51\x2C40\x2C287\x2C1845\x2C1721\x2C441\x2C240\x2C875\x2C901\x2C328\x2C800\x2C341\x2C59\x2C530\x2C134\x2C275\x2C11\x2C7\x2C7\x2C1\x2C1571\x2C218\x2C374\x2C536\x2C992\x2C464\x2C234\x2C398\x2C300\x2C74\x2C99\x2C1163\x2C1039\x2C430\x2C43\x2C659\x2C667\x2C1115\x2C407\x2C257\x2C717\x2C657\x2C249\x2C46\x2C109\x2C734\x2C67\x2C1010\x2C581\x2C1070\x2C738\x2C478\x2C621\x2C183\x2C224\x2C1372\x2C560\x2C1573\x2C1026\x2C338\x2C485\x2C1138\x2C1007\x2C910\x2C16\x2C846\x2C556\x2C423\x2C200\x2C962\x2C103\x2C570\x2C540\x2C900\x2C839\x2C319\x2C171\x2C14\x2C22\x2C205\x2C225\x2C569\x2C81\x2C381\x2C132\x2C127\x2C139\x2C123\x2C788\x2C1571\x2C35\x2C830\x2C65\x2C677\x2C1745\x2C819\x2C804\x2C854\x2C346\x2C190\x2C480\x2C1500\x2C76\x2C1049\x2C306\x2C17\x2C668\x2C113\x2C163\x2C755\x2C1015\x2C718\x2C1037\x2C156\x2C267\x2C158\x2C74\x2C377\x2C26\x2C294\x2C203\x2C334\x2C1186\x2C88\x2C384\x2C853\x2C404\x2C290\x2C135\x2C620\x2C668\x2C234\x2C1158\x2C2\x2C1102\x2C137\x2C884\x2C287\x2C15\x2C638\x2C1003\x2C187\x2C24\x2C534\x2C24\x2C647\x2C683\x2C934\x2C275\x2C1844\x2C887\x2C1746\x2C1614\x2C1788\x2C632\x2C100\x2C332\x2C1565\x2C1352\x2C341\x2C1027\x2C475\x2C958\x2C289\x2C1564\x2C89\x2C1138\x2C233\x2C535\x2C790\x2C990\x2C863\x2C889\x2C45\x2C44\x2C169\x2C251\x2C522\x2C11\x2C41\x2C104\x2C45\x2C828\x2C1206\x2C1515\x2C645\x2C39\x2C544\x2C382\x2C1413\x2C995\x2C188\x2C310\x2C51\x2C39\x2C474\x2C14\x2C7\x2C1387\x2C809\x2C428\x2C77\x2C8\x2C867\x2C1105\x2C718\x2C426\x2C146\x2C486\x2C191\x2C1251\x2C677\x2C1139\x2C802\x2C585\x2C1140\x2C46\x2C39\x2C128\x2C867\x2C49\x2C33\x2C198\x2C731\x2C349\x2C661\x2C296\x2C103\x2C22\x2C444\x2C1198\x2C1149\x2C188\x2C245\x2C492\x2C1147\x2C230\x2C213\x2C300\x2C551\x2C295\x2C1313\x2C365\x2C975\x2C587\x2C1416\x2C1213\x2C233\x2C257\x2C631\x2C564\x2C876\x2C434\x2C1353\x2C51\x2C748\x2C1179\x2C1428\x2C915\x2C115\x2C57\x2C90\x2C1312\x2C892\x2C200\x2C1349\x2C35\x2C1010\x2C445\x2C619\x2C1261\x2C108\x2C14\x2C1424\x2C481\x2C381\x2C209\x2C154\x2C23\x2C972\x2C646\x2C593\x2C6\x2C289\x2C171\x2C543\x2C97\x2C28\x2C401\x2C290\x2C298\x2C14\x2C37\x2C1326\x2C1177\x2C533\x2C67\x2C75\x2C294\x2C328\x2C527\x2C449\x2C455\x2C176\x2C345\x2C226\x2C729\x2C210\x2C55\x2C45\x2C0\x2C834\x2C887\x2C123\x2C1326\x2C931\x2C278\x2C449\x2C1278\x2C608\x2C217\x2C411\x2C143\x2C447\x2C16\x2C1043\x2C29\x2C165\x2C88\x2C860\x2C582\x2C21\x2C811\x2C920\x2C162\x2C1788\x2C15\x2C423\x2C1172\x2C842\x2C801\x2C845\x2C20\x2C155\x2C155\x2C642\x2C40\x2C1036\x2C560\x2C348\x2C689\x2C328\x2C505\x2C84\x2C1013\x2C58\x2C93\x2C1653\x2C233\x2C233\x2C383\x2C380\x2C84\x2C617\x2C1128\x2C305\x2C123\x2C508\x2C205\x2C6\x2C322\x2C118\x2C359\x2C1186\x2C84\x2C677\x2C640\x2C80\x2C1357\x2C868\x2C1035\x2C8\x2C64\x2C995\x2C1246\x2C266\x2C443\x2C346\x2C112\x2C523\x2C625\x2C206\x2C66\x2C565\x2C1878\x2C25\x2C1277\x2C936\x2C283\x2C148\x2C987\x2C282\x2C368\x2C883\x2C542\x2C631\x2C946\x2C118\x2C53\x2C4\x2C235\x2C16\x2C950\x2C4\x2C998\x2C106\x2C25\x2C151\x2C1013\x2C27\x2C1038\x2C77\x2C140\x2C82\x2C1119\x2C236\x2C125\x2C947\x2C1446\x2C680\x2C301\x2C301\x2C936\x2C21\x2C609\x2C516\x2C280\x2C264\x2C281\x2C108\x2C43\x2C215\x2C36\x2C126\x2C401\x2C402\x2C693\x2C360\x2C321\x2C92\x2C1809\x2C305\x2C551\x2C86\x2C77\x2C278\x2C81\x2C524\x2C400\x2C1458\x2C1342\x2C897\x2C49\x2C35\x2C518\x2C288\x2C655\x2C91\x2C398\x2C38\x2C251\x2C647\x2C79\x2C400\x2C151\x2C520\x2C459\x2C960\x2C425\x2C663\x2C298\x2C584\x2C90\x2C533\x2C690\x2C610\x2C755\x2C56\x2C19\x2C21\x2C244\x2C548\x2C1116\x2C773\x2C43\x2C115\x2C171\x2C1127\x2C103\x2C1199\x2C1470\x2C176\x2C451\x2C693\x2C65\x2C186\x2C262\x2C963\x2C137\x2C1422\x2C431\x2C533\x2C210\x2C799\x2C17\x2C388\x2C600\x2C1113\x2C2\x2C181\x2C815\x2C1153\x2C6\x2C618\x2C590\x2C719\x2C196\x2C39\x2C301\x2C424\x2C193\x2C560\x2C175\x2C351\x2C279\x2C603\x2C171\x2C423\x2C146\x2C158\x2C48\x2C398\x2C513\x2C115\x2C1\x2C1051\x2C817\x2C200\x2C473\x2C143\x2C261\x2C435\x2C856\x2C1057\x2C503\x2C51\x2C846\x2C1020\x2C177\x2C1091\x2C232\x2C500\x2C372\x2C475\x2C70\x2C485\x2C1227\x2C1032\x2C64\x2C743\x2C299\x2C159\x2C1077\x2C18\x2C204\x2C944\x2C1075\x2C29\x2C78\x2C63\x2C67\x2C9\x2C1007\x2C354\x2C1046\x2C491\x2C448\x2C206\x2C222\x2C121\x2C955\x2C290\x2C381\x2C147\x2C146\x2C104\x2C576\x2C722\x2C163\x2C715\x2C1475\x2C130\x2C1104\x2C586\x2C97\x2C352\x2C173\x2C713\x2C315\x2C1482\x2C1221\x2C38\x2C10\x2C81\x2C457\x2C745\x2C323\x2C47\x2C197\x2C1012\x2C1593\x2C128\x2C463\x2C373\x2C272\x2C90\x2C121\x2C1248\x2C1451\x2C540\x2C681\x2C63\x2C950\x2C19\x2C208\x2C230\x2C1362\x2C1225\x2C1500\x2C207\x2C81\x2C739\x2C288\x2C626\x2C261\x2C1188\x2C356\x2C889\x2C408\x2C3\x2C368\x2C94\x2C858\x2C1512\x2C834\x2C43\x2C5\x2C833\x2C826\x2C33\x2C791\x2C800\x2C39\x2C299\x2C1587\x2C41\x2C783\x2C498\x2C899\x2C296\x2C1189\x2C470\x2C66\x2C307\x2C892\x2C47\x2C207\x2C199\x2C902\x2C17\x2C14\x2C1831\x2C11\x2C576\x2C729\x2C1436\x2C153\x2C142\x2C81\x2C165\x2C214\x2C1543\x2C1464\x2C561\x2C737\x2C180\x2C162\x2C515\x2C867\x2C65\x2C74\x2C200\x2C9\x2C11\x2C539\x2C19\x2C305\x2C996\x2C334\x2C297\x2C1825\x2C427\x2C169\x2C225\x2C53\x2C688\x2C420\x2C623\x2C111\x2C313\x2C324\x2C5\x2C376\x2C433\x2C135\x2C308\x2C94", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"16\x2C1\x2C2\x2C0\x2C4\x2C2\x2C7\x2C1\x2C2\x2C14", Scope = Private
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
