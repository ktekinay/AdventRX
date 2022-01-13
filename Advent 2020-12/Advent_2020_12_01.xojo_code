#tag Class
Protected Class Advent_2020_12_01
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
		  var nums() as integer = ToIntegerArray( input )
		  
		  for i1 as integer = 0 to nums.LastIndex
		    var n1 as integer = nums( i1 )
		    
		    for i2 as integer = i1 + 1 to nums.LastIndex
		      var n2 as integer = nums( i2 )
		      if ( n1 + n2 ) = 2020 then
		        return n1 * n2
		      end if
		    next
		    
		  next
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var nums() as integer = ToIntegerArray( input )
		  
		  for i1 as integer = 0 to nums.LastIndex
		    var n1 as integer = nums( i1 )
		    
		    for i2 as integer = i1 + 1 to nums.LastIndex
		      var n2 as integer = nums( i2 )
		      
		      for i3 as integer = i2 + 1 to nums.LastIndex
		        var n3 as integer = nums( i3 )
		        
		        if ( n1 + n2 + n3 ) = 2020 then
		          return n1 * n2 * n3
		        end if
		      next
		      
		    next
		    
		  next
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"1779\n1737\n1537\n1167\n1804\n1873\n1894\n1446\n1262\n1608\n1430\n1421\n1826\n1718\n1888\n1314\n1844\n248\n1812\n1627\n1605\n1641\n1126\n1051\n1839\n1067\n1685\n1800\n1383\n1415\n1781\n1372\n1711\n1687\n1357\n1603\n1899\n1856\n1240\n1872\n1483\n1624\n1358\n1168\n1238\n1585\n1159\n1409\n1615\n1258\n1412\n1468\n1912\n1840\n1681\n1700\n1031\n1757\n1911\n1096\n1239\n1331\n1881\n1304\n1694\n1705\n1680\n820\n1744\n1245\n1922\n1545\n1335\n1852\n1318\n1565\n1505\n1535\n1536\n1758\n1508\n1453\n1957\n1375\n1647\n1531\n1261\n1202\n1701\n1562\n1933\n1293\n1828\n334\n1714\n1931\n1385\n1294\n1469\n1629\n1842\n1730\n1534\n1544\n1946\n1805\n1188\n1684\n1875\n1623\n1248\n1347\n2006\n1191\n1037\n1387\n1903\n1746\n16\n952\n1246\n384\n1518\n1738\n1269\n1747\n1423\n1764\n1666\n1999\n1776\n1673\n1350\n1698\n2004\n1235\n1719\n1131\n1671\n1334\n1556\n1299\n1569\n1523\n1655\n1189\n1023\n1264\n1821\n1639\n1114\n1391\n1154\n1225\n1906\n1481\n1728\n1309\n1682\n1662\n1017\n1952\n1948\n2010\n1809\n1394\n1039\n1493\n1509\n1628\n1401\n1515\n1497\n1164\n1829\n1452\n1706\n1919\n1831\n1643\n1849\n1558\n1162\n1328\n1432\n680\n1169\n1393\n1646\n1161\n1104\n1678\n1477\n1824\n1353\n1260\n1736\n1777\n1658\n1715", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"1721\n979\n366\n299\n675\n1456", Scope = Private
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
