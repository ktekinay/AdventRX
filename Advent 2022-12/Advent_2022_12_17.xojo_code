#tag Class
Protected Class Advent_2022_12_17
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Unknown"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return false
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return ""
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( Normalize( GetPuzzleInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( Normalize( GetPuzzleInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  return CalculateResultB( Normalize( input ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  const kLastColIndex as integer = 6
		  
		  var grid as new TetrisGrid
		  grid.ResizeTo 15, kLastColIndex
		  
		  for col as integer = 0 to kLastColIndex
		    grid( 0, col ) = new TetrisSquare( "#" )
		  next
		  
		  grid.UpdateHighPoint
		  
		  'Print grid
		  'Print ""
		  
		  var rocks() as TetrisRock = GetRocks
		  var jetPatterns() as string = input.Split( "" )
		  
		  var rockIndex as integer
		  var jetIndex as integer
		  
		  var exampleHeights() as integer
		  if IsTest then
		    exampleHeights = ToIntegerArray( kExampleHeights )
		  end if
		  
		  const kDebugCount as integer = -1
		  
		  for count as integer = 1 to 2022
		    var rock as TetrisRock = NextRock( rocks, rockIndex )
		    PlaceRock grid, rock
		    
		    'if IsTest and count = kDebugCount then
		    'Print grid.HighPoint
		    'Print "Placing"
		    'PrintRockAndGrid rock, grid, "@"
		    'Print ""
		    'end if
		    
		    do
		      var jet as string = NextJet( jetPatterns, jetIndex )
		      PushRock rock, jet, grid
		      'if IsTest and count = kDebugCount then
		      'Print jet
		      'PrintRockAndGrid rock, grid, "@"
		      'end if
		    loop until not LowerRock( rock, grid )
		    
		    DrawRock rock, Grid
		    
		    if IsTest then
		      'if count = kDebugCount then
		      'Print grid
		      'Print ""
		      'end if
		      
		      if grid.HighPoint <> exampleHeights( count - 1 ) then
		        Print "mismatch at", count, "got", grid.HighPoint, "expected", exampleHeights( count - 1 )
		        'exit
		      end if
		    end if
		  next
		  
		  'Print grid
		  'Print ""
		  
		  return grid.HighPoint
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawRock(rock As TetrisRock, grid As TetrisGrid, symbol As String = "#")
		  for rockRow as integer = 0 to rock.LastRowIndex
		    var gridRow as integer = rock.GridRow + rockRow
		    for rockCol as integer = 0 to rock.LastColIndex
		      if rock( rockRow, rockCol ) = "#" then
		        var gridCol as integer = rock.GridColumn + rockCol
		        grid( gridRow, gridCol ) = new TetrisSquare( symbol )
		      end if
		    next
		  next
		  
		  grid.UpdateHighPoint
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetRocks() As TetrisRock()
		  var patterns() as string = kRockPatterns.Split( EndOfLine + EndOfLine )
		  
		  var rocks() as TetrisRock
		  
		  for each pattern as string in patterns
		    var rock as new TetrisRock
		    rocks.Add rock
		    
		    var rows() as string = pattern.Split( EndOfLine )
		    rock.ResizeTo rows.LastIndex, 3
		    
		    var maxCol as integer
		    
		    var rowIndex as integer = rock.LastRowIndex + 1
		    for each rowPattern as string in rows
		      rowIndex = rowIndex - 1
		      var chars() as string = rowPattern.Split( "" )
		      maxCol = max( maxCol, chars.LastIndex )
		      
		      for col as integer = 0 to chars.LastIndex
		        var char as string = chars( col )
		        if char <> "#" then
		          char = ""
		        end if
		        rock( rowIndex, col ) = char
		      next
		    next
		    
		    rock.ResizeTo rock.LastRowIndex, maxCol
		  next
		  
		  return rocks
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LowerRock(rock As TetrisRock, grid As TetrisGrid) As Boolean
		  var targetGridRow as integer = rock.GridRow - 1
		  if targetGridRow = 0 then
		    return false
		  end if
		  
		  for rockCol as integer = 0 to rock.LastColIndex
		    var rockRow as integer
		    while rockRow <= rock.LastRowIndex and rock( rockRow, rockCol ) <> "#"
		      rockRow = rockRow + 1
		    wend
		    if rockRow > rock.LastRowIndex then
		      continue
		    end if
		    
		    var testGridCol as integer = rock.GridColumn + rockCol
		    var testGridRow as integer = targetGridRow + rockRow
		    
		    if grid( testGridRow, testGridCol ) <> nil then
		      return false
		    end if
		  next
		  
		  rock.GridRow = targetGridRow
		  return true
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NextJet(jetPatterns() As String, ByRef jetIndex As Integer) As String
		  var jet as string = jetPatterns( jetIndex )
		  
		  if jetIndex = jetPatterns.LastIndex then
		    jetIndex = 0
		  else
		    jetIndex = jetIndex + 1
		  end if
		  
		  return jet
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NextRock(rocks() As TetrisRock, ByRef rockIndex As Integer) As TetrisRock
		  var rock as TetrisRock = rocks( rockIndex )
		  
		  if rockIndex = rocks.LastIndex then
		    rockIndex = 0
		  else
		    rockIndex = rockIndex + 1
		  end if
		  
		  return rock
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PlaceRock(grid As TetrisGrid, rock As TetrisRock)
		  rock.GridColumn = 2
		  rock.GridRow = grid.HighPoint + 4
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PrintRockAndGrid(rock As TetrisRock, grid As TetrisGrid, symbol As String = "#")
		  var debugGrid as new TetrisGrid 
		  debugGrid.ResizeTo grid.LastRowIndex, grid.LastColIndex
		  
		  for each m as GridMember in grid
		    if m isa object then
		      debugGrid( m.Row, m.Column ) = new TetrisSquare( "#" )
		    end if
		  next
		  
		  DrawRock rock, debugGrid, symbol
		  Print debugGrid
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PushRock(rock As TetrisRock, direction As String, grid As TetrisGrid)
		  var targetGridCol as integer
		  var targetRockCol as integer
		  var rockEdgeCol as integer
		  var stepper as integer
		  
		  if direction = "<" then
		    targetGridCol = rock.GridColumn - 1
		    
		    if targetGridCol < 0 then
		      return
		    end if
		    targetRockCol = targetGridCol
		    rockEdgeCol = 0
		    stepper = 1
		    
		  else
		    targetGridCol = rock.GridColumn + rock.LastColIndex + 1
		    if targetGridCol > grid.LastColIndex then
		      return
		    end
		    targetRockCol = rock.GridColumn + 1
		    rockEdgeCol = rock.LastColIndex
		    stepper = -1
		  end if
		  
		  for rockRow as integer = 0 to rock.LastRowIndex
		    var testRockCol as integer = rockEdgeCol
		    var testGridCol as integer = targetGridCol
		    while rock( rockRow, testRockCol ) <> "#" and testRockCol >= 0 and testRockCol <= rock.LastColIndex
		      testRockCol = testRockCol + stepper
		      testGridCol = testGridCol + stepper
		    wend
		    
		    if testRockCol < 0 or testRockCol > rock.LastColIndex then
		      continue
		    end if
		    
		    var testGridRow as integer = rock.GridRow + rockRow
		    if grid( testGridRow, testGridCol ) <> nil then
		      return
		    end if
		  next
		  
		  rock.GridColumn = targetRockCol
		  
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kExampleHeights, Type = String, Dynamic = False, Default = \"1\n4\n6\n7\n9\n10\n13\n15\n17\n17\n18\n21\n23\n23\n25\n26\n29\n32\n36\n36\n37\n39\n42\n42\n43\n44\n47\n49\n51\n51\n51\n53\n56\n60\n60\n61\n63\n64\n66\n66\n67\n69\n70\n72\n72\n73\n76\n78\n78\n78\n79\n82\n85\n89\n89\n90\n92\n95\n95\n96\n97\n100\n102\n104\n104\n104\n106\n109\n113\n113\n114\n116\n117\n119\n119\n120\n122\n123\n125\n125\n126\n129\n131\n131\n131\n132\n135\n138\n142\n142\n143\n145\n148\n148\n149\n150\n153\n155\n157\n157\n157\n159\n162\n166\n166\n167\n169\n170\n172\n172\n173\n175\n176\n178\n178\n179\n182\n184\n184\n184\n185\n188\n191\n195\n195\n196\n198\n201\n201\n202\n203\n206\n208\n210\n210\n210\n212\n215\n219\n219\n220\n222\n223\n225\n225\n226\n228\n229\n231\n231\n232\n235\n237\n237\n237\n238\n241\n244\n248\n248\n249\n251\n254\n254\n255\n256\n259\n261\n263\n263\n263\n265\n268\n272\n272\n273\n275\n276\n278\n278\n279\n281\n282\n284\n284\n285\n288\n290\n290\n290\n291\n294\n297\n301\n301\n302\n304\n307\n307\n308\n309\n312\n314\n316\n316\n316\n318\n321\n325\n325\n326\n328\n329\n331\n331\n332\n334\n335\n337\n337\n338\n341\n343\n343\n343\n344\n347\n350\n354\n354\n355\n357\n360\n360\n361\n362\n365\n367\n369\n369\n369\n371\n374\n378\n378\n379\n381\n382\n384\n384\n385\n387\n388\n390\n390\n391\n394\n396\n396\n396\n397\n400\n403\n407\n407\n408\n410\n413\n413\n414\n415\n418\n420\n422\n422\n422\n424\n427\n431\n431\n432\n434\n435\n437\n437\n438\n440\n441\n443\n443\n444\n447\n449\n449\n449\n450\n453\n456\n460\n460\n461\n463\n466\n466\n467\n468\n471\n473\n475\n475\n475\n477\n480\n484\n484\n485\n487\n488\n490\n490\n491\n493\n494\n496\n496\n497\n500\n502\n502\n502\n503\n506\n509\n513\n513\n514\n516\n519\n519\n520\n521\n524\n526\n528\n528\n528\n530\n533\n537\n537\n538\n540\n541\n543\n543\n544\n546\n547\n549\n549\n550\n553\n555\n555\n555\n556\n559\n562\n566\n566\n567\n569\n572\n572\n573\n574\n577\n579\n581\n581\n581\n583\n586\n590\n590\n591\n593\n594\n596\n596\n597\n599\n600\n602\n602\n603\n606\n608\n608\n608\n609\n612\n615\n619\n619\n620\n622\n625\n625\n626\n627\n630\n632\n634\n634\n634\n636\n639\n643\n643\n644\n646\n647\n649\n649\n650\n652\n653\n655\n655\n656\n659\n661\n661\n661\n662\n665\n668\n672\n672\n673\n675\n678\n678\n679\n680\n683\n685\n687\n687\n687\n689\n692\n696\n696\n697\n699\n700\n702\n702\n703\n705\n706\n708\n708\n709\n712\n714\n714\n714\n715\n718\n721\n725\n725\n726\n728\n731\n731\n732\n733\n736\n738\n740\n740\n740\n742\n745\n749\n749\n750\n752\n753\n755\n755\n756\n758\n759\n761\n761\n762\n765\n767\n767\n767\n768\n771\n774\n778\n778\n779\n781\n784\n784\n785\n786\n789\n791\n793\n793\n793\n795\n798\n802\n802\n803\n805\n806\n808\n808\n809\n811\n812\n814\n814\n815\n818\n820\n820\n820\n821\n824\n827\n831\n831\n832\n834\n837\n837\n838\n839\n842\n844\n846\n846\n846\n848\n851\n855\n855\n856\n858\n859\n861\n861\n862\n864\n865\n867\n867\n868\n871\n873\n873\n873\n874\n877\n880\n884\n884\n885\n887\n890\n890\n891\n892\n895\n897\n899\n899\n899\n901\n904\n908\n908\n909\n911\n912\n914\n914\n915\n917\n918\n920\n920\n921\n924\n926\n926\n926\n927\n930\n933\n937\n937\n938\n940\n943\n943\n944\n945\n948\n950\n952\n952\n952\n954\n957\n961\n961\n962\n964\n965\n967\n967\n968\n970\n971\n973\n973\n974\n977\n979\n979\n979\n980\n983\n986\n990\n990\n991\n993\n996\n996\n997\n998\n1001\n1003\n1005\n1005\n1005\n1007\n1010\n1014\n1014\n1015\n1017\n1018\n1020\n1020\n1021\n1023\n1024\n1026\n1026\n1027\n1030\n1032\n1032\n1032\n1033\n1036\n1039\n1043\n1043\n1044\n1046\n1049\n1049\n1050\n1051\n1054\n1056\n1058\n1058\n1058\n1060\n1063\n1067\n1067\n1068\n1070\n1071\n1073\n1073\n1074\n1076\n1077\n1079\n1079\n1080\n1083\n1085\n1085\n1085\n1086\n1089\n1092\n1096\n1096\n1097\n1099\n1102\n1102\n1103\n1104\n1107\n1109\n1111\n1111\n1111\n1113\n1116\n1120\n1120\n1121\n1123\n1124\n1126\n1126\n1127\n1129\n1130\n1132\n1132\n1133\n1136\n1138\n1138\n1138\n1139\n1142\n1145\n1149\n1149\n1150\n1152\n1155\n1155\n1156\n1157\n1160\n1162\n1164\n1164\n1164\n1166\n1169\n1173\n1173\n1174\n1176\n1177\n1179\n1179\n1180\n1182\n1183\n1185\n1185\n1186\n1189\n1191\n1191\n1191\n1192\n1195\n1198\n1202\n1202\n1203\n1205\n1208\n1208\n1209\n1210\n1213\n1215\n1217\n1217\n1217\n1219\n1222\n1226\n1226\n1227\n1229\n1230\n1232\n1232\n1233\n1235\n1236\n1238\n1238\n1239\n1242\n1244\n1244\n1244\n1245\n1248\n1251\n1255\n1255\n1256\n1258\n1261\n1261\n1262\n1263\n1266\n1268\n1270\n1270\n1270\n1272\n1275\n1279\n1279\n1280\n1282\n1283\n1285\n1285\n1286\n1288\n1289\n1291\n1291\n1292\n1295\n1297\n1297\n1297\n1298\n1301\n1304\n1308\n1308\n1309\n1311\n1314\n1314\n1315\n1316\n1319\n1321\n1323\n1323\n1323\n1325\n1328\n1332\n1332\n1333\n1335\n1336\n1338\n1338\n1339\n1341\n1342\n1344\n1344\n1345\n1348\n1350\n1350\n1350\n1351\n1354\n1357\n1361\n1361\n1362\n1364\n1367\n1367\n1368\n1369\n1372\n1374\n1376\n1376\n1376\n1378\n1381\n1385\n1385\n1386\n1388\n1389\n1391\n1391\n1392\n1394\n1395\n1397\n1397\n1398\n1401\n1403\n1403\n1403\n1404\n1407\n1410\n1414\n1414\n1415\n1417\n1420\n1420\n1421\n1422\n1425\n1427\n1429\n1429\n1429\n1431\n1434\n1438\n1438\n1439\n1441\n1442\n1444\n1444\n1445\n1447\n1448\n1450\n1450\n1451\n1454\n1456\n1456\n1456\n1457\n1460\n1463\n1467\n1467\n1468\n1470\n1473\n1473\n1474\n1475\n1478\n1480\n1482\n1482\n1482\n1484\n1487\n1491\n1491\n1492\n1494\n1495\n1497\n1497\n1498\n1500\n1501\n1503\n1503\n1504\n1507\n1509\n1509\n1509\n1510\n1513\n1516\n1520\n1520\n1521\n1523\n1526\n1526\n1527\n1528\n1531\n1533\n1535\n1535\n1535\n1537\n1540\n1544\n1544\n1545\n1547\n1548\n1550\n1550\n1551\n1553\n1554\n1556\n1556\n1557\n1560\n1562\n1562\n1562\n1563\n1566\n1569\n1573\n1573\n1574\n1576\n1579\n1579\n1580\n1581\n1584\n1586\n1588\n1588\n1588\n1590\n1593\n1597\n1597\n1598\n1600\n1601\n1603\n1603\n1604\n1606\n1607\n1609\n1609\n1610\n1613\n1615\n1615\n1615\n1616\n1619\n1622\n1626\n1626\n1627\n1629\n1632\n1632\n1633\n1634\n1637\n1639\n1641\n1641\n1641\n1643\n1646\n1650\n1650\n1651\n1653\n1654\n1656\n1656\n1657\n1659\n1660\n1662\n1662\n1663\n1666\n1668\n1668\n1668\n1669\n1672\n1675\n1679\n1679\n1680\n1682\n1685\n1685\n1686\n1687\n1690\n1692\n1694\n1694\n1694\n1696\n1699\n1703\n1703\n1704\n1706\n1707\n1709\n1709\n1710\n1712\n1713\n1715\n1715\n1716\n1719\n1721\n1721\n1721\n1722\n1725\n1728\n1732\n1732\n1733\n1735\n1738\n1738\n1739\n1740\n1743\n1745\n1747\n1747\n1747\n1749\n1752\n1756\n1756\n1757\n1759\n1760\n1762\n1762\n1763\n1765\n1766\n1768\n1768\n1769\n1772\n1774\n1774\n1774\n1775\n1778\n1781\n1785\n1785\n1786\n1788\n1791\n1791\n1792\n1793\n1796\n1798\n1800\n1800\n1800\n1802\n1805\n1809\n1809\n1810\n1812\n1813\n1815\n1815\n1816\n1818\n1819\n1821\n1821\n1822\n1825\n1827\n1827\n1827\n1828\n1831\n1834\n1838\n1838\n1839\n1841\n1844\n1844\n1845\n1846\n1849\n1851\n1853\n1853\n1853\n1855\n1858\n1862\n1862\n1863\n1865\n1866\n1868\n1868\n1869\n1871\n1872\n1874\n1874\n1875\n1878\n1880\n1880\n1880\n1881\n1884\n1887\n1891\n1891\n1892\n1894\n1897\n1897\n1898\n1899\n1902\n1904\n1906\n1906\n1906\n1908\n1911\n1915\n1915\n1916\n1918\n1919\n1921\n1921\n1922\n1924\n1925\n1927\n1927\n1928\n1931\n1933\n1933\n1933\n1934\n1937\n1940\n1944\n1944\n1945\n1947\n1950\n1950\n1951\n1952\n1955\n1957\n1959\n1959\n1959\n1961\n1964\n1968\n1968\n1969\n1971\n1972\n1974\n1974\n1975\n1977\n1978\n1980\n1980\n1981\n1984\n1986\n1986\n1986\n1987\n1990\n1993\n1997\n1997\n1998\n2000\n2003\n2003\n2004\n2005\n2008\n2010\n2012\n2012\n2012\n2014\n2017\n2021\n2021\n2022\n2024\n2025\n2027\n2027\n2028\n2030\n2031\n2033\n2033\n2034\n2037\n2039\n2039\n2039\n2040\n2043\n2046\n2050\n2050\n2051\n2053\n2056\n2056\n2057\n2058\n2061\n2063\n2065\n2065\n2065\n2067\n2070\n2074\n2074\n2075\n2077\n2078\n2080\n2080\n2081\n2083\n2084\n2086\n2086\n2087\n2090\n2092\n2092\n2092\n2093\n2096\n2099\n2103\n2103\n2104\n2106\n2109\n2109\n2110\n2111\n2114\n2116\n2118\n2118\n2118\n2120\n2123\n2127\n2127\n2128\n2130\n2131\n2133\n2133\n2134\n2136\n2137\n2139\n2139\n2140\n2143\n2145\n2145\n2145\n2146\n2149\n2152\n2156\n2156\n2157\n2159\n2162\n2162\n2163\n2164\n2167\n2169\n2171\n2171\n2171\n2173\n2176\n2180\n2180\n2181\n2183\n2184\n2186\n2186\n2187\n2189\n2190\n2192\n2192\n2193\n2196\n2198\n2198\n2198\n2199\n2202\n2205\n2209\n2209\n2210\n2212\n2215\n2215\n2216\n2217\n2220\n2222\n2224\n2224\n2224\n2226\n2229\n2233\n2233\n2234\n2236\n2237\n2239\n2239\n2240\n2242\n2243\n2245\n2245\n2246\n2249\n2251\n2251\n2251\n2252\n2255\n2258\n2262\n2262\n2263\n2265\n2268\n2268\n2269\n2270\n2273\n2275\n2277\n2277\n2277\n2279\n2282\n2286\n2286\n2287\n2289\n2290\n2292\n2292\n2293\n2295\n2296\n2298\n2298\n2299\n2302\n2304\n2304\n2304\n2305\n2308\n2311\n2315\n2315\n2316\n2318\n2321\n2321\n2322\n2323\n2326\n2328\n2330\n2330\n2330\n2332\n2335\n2339\n2339\n2340\n2342\n2343\n2345\n2345\n2346\n2348\n2349\n2351\n2351\n2352\n2355\n2357\n2357\n2357\n2358\n2361\n2364\n2368\n2368\n2369\n2371\n2374\n2374\n2375\n2376\n2379\n2381\n2383\n2383\n2383\n2385\n2388\n2392\n2392\n2393\n2395\n2396\n2398\n2398\n2399\n2401\n2402\n2404\n2404\n2405\n2408\n2410\n2410\n2410\n2411\n2414\n2417\n2421\n2421\n2422\n2424\n2427\n2427\n2428\n2429\n2432\n2434\n2436\n2436\n2436\n2438\n2441\n2445\n2445\n2446\n2448\n2449\n2451\n2451\n2452\n2454\n2455\n2457\n2457\n2458\n2461\n2463\n2463\n2463\n2464\n2467\n2470\n2474\n2474\n2475\n2477\n2480\n2480\n2481\n2482\n2485\n2487\n2489\n2489\n2489\n2491\n2494\n2498\n2498\n2499\n2501\n2502\n2504\n2504\n2505\n2507\n2508\n2510\n2510\n2511\n2514\n2516\n2516\n2516\n2517\n2520\n2523\n2527\n2527\n2528\n2530\n2533\n2533\n2534\n2535\n2538\n2540\n2542\n2542\n2542\n2544\n2547\n2551\n2551\n2552\n2554\n2555\n2557\n2557\n2558\n2560\n2561\n2563\n2563\n2564\n2567\n2569\n2569\n2569\n2570\n2573\n2576\n2580\n2580\n2581\n2583\n2586\n2586\n2587\n2588\n2591\n2593\n2595\n2595\n2595\n2597\n2600\n2604\n2604\n2605\n2607\n2608\n2610\n2610\n2611\n2613\n2614\n2616\n2616\n2617\n2620\n2622\n2622\n2622\n2623\n2626\n2629\n2633\n2633\n2634\n2636\n2639\n2639\n2640\n2641\n2644\n2646\n2648\n2648\n2648\n2650\n2653\n2657\n2657\n2658\n2660\n2661\n2663\n2663\n2664\n2666\n2667\n2669\n2669\n2670\n2673\n2675\n2675\n2675\n2676\n2679\n2682\n2686\n2686\n2687\n2689\n2692\n2692\n2693\n2694\n2697\n2699\n2701\n2701\n2701\n2703\n2706\n2710\n2710\n2711\n2713\n2714\n2716\n2716\n2717\n2719\n2720\n2722\n2722\n2723\n2726\n2728\n2728\n2728\n2729\n2732\n2735\n2739\n2739\n2740\n2742\n2745\n2745\n2746\n2747\n2750\n2752\n2754\n2754\n2754\n2756\n2759\n2763\n2763\n2764\n2766\n2767\n2769\n2769\n2770\n2772\n2773\n2775\n2775\n2776\n2779\n2781\n2781\n2781\n2782\n2785\n2788\n2792\n2792\n2793\n2795\n2798\n2798\n2799\n2800\n2803\n2805\n2807\n2807\n2807\n2809\n2812\n2816\n2816\n2817\n2819\n2820\n2822\n2822\n2823\n2825\n2826\n2828\n2828\n2829\n2832\n2834\n2834\n2834\n2835\n2838\n2841\n2845\n2845\n2846\n2848\n2851\n2851\n2852\n2853\n2856\n2858\n2860\n2860\n2860\n2862\n2865\n2869\n2869\n2870\n2872\n2873\n2875\n2875\n2876\n2878\n2879\n2881\n2881\n2882\n2885\n2887\n2887\n2887\n2888\n2891\n2894\n2898\n2898\n2899\n2901\n2904\n2904\n2905\n2906\n2909\n2911\n2913\n2913\n2913\n2915\n2918\n2922\n2922\n2923\n2925\n2926\n2928\n2928\n2929\n2931\n2932\n2934\n2934\n2935\n2938\n2940\n2940\n2940\n2941\n2944\n2947\n2951\n2951\n2952\n2954\n2957\n2957\n2958\n2959\n2962\n2964\n2966\n2966\n2966\n2968\n2971\n2975\n2975\n2976\n2978\n2979\n2981\n2981\n2982\n2984\n2985\n2987\n2987\n2988\n2991\n2993\n2993\n2993\n2994\n2997\n3000\n3004\n3004\n3005\n3007\n3010\n3010\n3011\n3012\n3015\n3017\n3019\n3019\n3019\n3021\n3024\n3028\n3028\n3029\n3031\n3032\n3034\n3034\n3035\n3037\n3038\n3040\n3040\n3041\n3044\n3046\n3046\n3046\n3047\n3050\n3053\n3057\n3057\n3058\n3060\n3063\n3063\n3064\n3065\n3068", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kRockPatterns, Type = String, Dynamic = False, Default = \"####\n\n.#.\n###\n.#.\n\n..#\n..#\n###\n\n#\n#\n#\n#\n\n##\n##", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="IsComplete"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
