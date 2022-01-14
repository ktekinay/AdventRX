#tag Class
Protected Class Advent_2021_12_19
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
		  Scanners.RemoveAll
		  TestScanners.RemoveAll
		  
		  var result as integer = CalculateResultA( kTestInput )
		  TestScanners = Scanners
		  
		  return result
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  var temp() as Scanner = Scanners
		  Scanners = TestScanners
		  
		  var result as integer = CalculateResultB( kTestInput )
		  
		  Scanners = temp
		  return result
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddBeacons(s As Scanner)
		  var dict as Dictionary = s.KnownBeacons
		  
		  for i as integer = 0 to s.Beacons.LastIndex
		    var b as Beacon = s.Beacons( i )
		    
		    if dict.HasKey( b.Hash ) then
		      var existingBeacon as Beacon = dict.Value( b.Hash )
		      existingBeacon = existingBeacon
		    end if
		    
		    dict.Value( b.Hash ) = b
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var scanners() as Scanner = ParseInput( input )
		  
		  if scanners.Count = 0 then
		    return -1
		  end if
		  
		  AddBeacons scanners( 0 )
		  
		  const kMatchingBeacons as integer = 12
		  
		  var identificationCount as integer = 1
		  
		  do
		    var foundThisRound as boolean
		    
		    for testScannerIndex as integer = 1 to scanners.LastIndex
		      var candidate as Scanner = scanners( testScannerIndex )
		      if candidate.KnownBeacons.KeyCount <> 0 then
		        continue
		      end if
		      
		      var foundMatch as boolean
		      
		      for each goodScanner as Scanner in scanners
		        if goodScanner.KnownBeacons.KeyCount = 0 then
		          //
		          // Not a good scanner yet
		          //
		          continue
		        end if
		        
		        foundMatch = IsMatch( goodScanner, candidate, kMatchingBeacons )
		        if foundMatch then
		          identificationCount = identificationCount + 1
		          AddBeacons candidate
		          foundThisRound = true
		          exit for goodScanner
		        end if
		      next goodScanner
		      
		      if not foundMatch then
		        foundMatch = foundMatch
		      end if
		    next testScannerIndex
		    
		    if not foundThisRound then
		      return -1
		    end if
		  loop until identificationCount = scanners.Count
		  
		  var knownBeacons as new Dictionary
		  
		  for each s as Scanner in scanners
		    var dict as Dictionary = s.KnownBeacons
		    var keys() as variant = dict.Keys
		    var values() as variant = dict.Values
		    for i as integer = 0 to keys.LastIndex
		      var k as variant = keys( i )
		      var b as Beacon = values( i )
		      knownBeacons.Value( k ) = b
		    next
		  next
		  
		  self.Scanners = scanners
		  
		  return knownBeacons.KeyCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var maxDistance as integer
		  
		  for each s1 as Scanner in Scanners
		    for each s2 as Scanner in Scanners
		      if s1 is s2 then
		        continue
		      end if
		      
		      var diff as integer = ( s1.X - s2.X ) + ( s1.Y - s2.Y ) + ( s1.Z - s2.Z )
		      maxDistance = max( maxDistance, diff )
		    next
		  next
		  
		  return maxDistance
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CoordSorter(v1 As String, v2 As String) As Integer
		  var parts1() as string = v1.Split( "," )
		  var parts2() as string = v2.Split( "," )
		  
		  for i as integer = 0 to parts1.LastIndex
		    if parts1( i ) <> parts2( i ) then
		      return parts1( i ).ToInteger - parts2( i ).ToInteger
		    end if
		  next
		  
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsMatch(goodScanner As Scanner, candidate As Scanner, targetCount As Integer) As Boolean
		  if goodScanner.AttemptedAgainstScannerIndexes.IndexOf( candidate.Index ) <> -1 then
		    //
		    // Already tried this one
		    //
		    return false
		  end if
		  
		  print "Checking scanner " + goodScanner.Index.ToString + " against scanner " + candidate.Index.ToString
		  
		  goodScanner.AttemptedAgainstScannerIndexes.Add candidate.Index
		  
		  for anchorBeaconIndex as integer = 0 to goodScanner.Beacons.LastIndex
		    'print "... pulling anchor beacon " + anchorBeaconIndex.ToString
		    
		    var anchorBeacon as Beacon = goodScanner.Beacons( anchorBeaconIndex )
		    
		    //
		    // We have to reorient the candidate in every direction
		    //
		    for orientation as integer = 1 to 24
		      'print "... orientation  " + orientation.ToString
		      
		      candidate.Reorient orientation
		      
		      //
		      // Cycle through the candidate beacons and match them up
		      //
		      for candidateBeaconIndex as integer = 0 to candidate.Beacons.LastIndex
		        var candidateBeacon as Beacon = candidate.Beacons( candidateBeaconIndex )
		        
		        //
		        // Set the scanner's position assuming the candidate and anchor beacons are the same
		        // (the anchor beacon's coordinates have already been set)
		        //
		        candidate.SetCoordinates _
		        anchorBeacon.X - candidateBeacon.RelativeX, _
		        anchorBeacon.Y - candidateBeacon.RelativeY, _
		        anchorBeacon.Z - candidateBeacon.RelativeZ
		        
		        //
		        // See if the other beacons match up
		        //
		        var matchCount as integer
		        var remaining as integer = candidate.Beacons.Count
		        for otherBeaconIndex as integer = 0 to candidate.Beacons.LastIndex
		          var otherBeacon as Beacon = candidate.Beacons( otherBeaconIndex )
		          
		          otherBeacon.SetCoordinates _
		          candidate.X + otherBeacon.RelativeX, _
		          candidate.Y + otherBeacon.RelativeY, _
		          candidate.Z + otherBeacon.RelativeZ
		          if goodScanner.KnownBeacons.HasKey( otherBeacon.Hash ) then
		            matchCount = matchCount + 1
		          end if 
		          
		          remaining = remaining - 1
		          if ( remaining + matchCount ) < targetCount then
		            exit
		          end if
		        next
		        
		        if matchCount = targetCount then
		          print "... MATCHED!"
		          return true
		        end if
		      next
		      
		    next
		  next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As Scanner()
		  var scanners() as Scanner
		  if input = "" then
		    return scanners
		  end if
		  
		  var sections() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( "--- scanner " )
		  
		  for each section as string in sections
		    section = section.Trim
		    if section = "" then
		      continue
		    end if
		    
		    var s as new Scanner
		    scanners.Add s
		    
		    var rows() as string = section.Split( EndOfLine )
		    var parts() as string = rows( 0 ).Split( " " )
		    s.Index = parts( 0 ).ToInteger
		    
		    for row as integer = 1 to rows.LastIndex
		      var b as new Beacon
		      s.Beacons.Add b
		      
		      parts() = rows( row ).Split( "," )
		      b.SetRelativeCoordinates( parts( 0 ).ToInteger, parts( 1 ).ToInteger, parts( 2 ).ToInteger )
		    next
		    
		  next
		  
		  for each b as Beacon in scanners( 0 ).Beacons
		    b.SetCoordinates b.RelativeX, b.RelativeY, b.RelativeZ
		  next
		  
		  return scanners
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Scanners() As Scanner
	#tag EndProperty

	#tag Property, Flags = &h21
		Private TestScanners() As Scanner
	#tag EndProperty


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"--- scanner 0 ---\n-775\x2C-554\x2C-532\n43\x2C-16\x2C96\n-784\x2C-551\x2C460\n718\x2C-337\x2C582\n-892\x2C-499\x2C-569\n463\x2C-600\x2C-530\n-815\x2C-637\x2C-599\n776\x2C-278\x2C495\n858\x2C-268\x2C526\n293\x2C497\x2C-799\n531\x2C-580\x2C-430\n286\x2C704\x2C496\n-718\x2C-447\x2C453\n314\x2C831\x2C609\n280\x2C497\x2C-675\n-125\x2C122\x2C195\n-917\x2C755\x2C-729\n-728\x2C-466\x2C600\n-910\x2C798\x2C-490\n277\x2C733\x2C552\n-428\x2C756\x2C796\n-491\x2C713\x2C739\n-425\x2C674\x2C850\n469\x2C-473\x2C-489\n-923\x2C625\x2C-580\n374\x2C459\x2C-626\n\n--- scanner 1 ---\n337\x2C-770\x2C-686\n715\x2C590\x2C522\n714\x2C-784\x2C879\n286\x2C-914\x2C-728\n371\x2C565\x2C-546\n314\x2C-890\x2C-714\n336\x2C518\x2C-686\n-556\x2C-575\x2C592\n-541\x2C750\x2C-562\n-605\x2C-753\x2C-639\n-708\x2C776\x2C377\n736\x2C426\x2C566\n778\x2C607\x2C538\n-600\x2C-640\x2C772\n-125\x2C-54\x2C56\n35\x2C-9\x2C-45\n-563\x2C609\x2C-523\n-700\x2C-738\x2C-597\n-738\x2C-900\x2C-636\n-854\x2C786\x2C421\n-639\x2C-586\x2C745\n810\x2C-713\x2C806\n294\x2C597\x2C-553\n731\x2C-800\x2C785\n-781\x2C768\x2C547\n-590\x2C720\x2C-395\n\n--- scanner 2 ---\n-441\x2C556\x2C-929\n-327\x2C708\x2C-896\n-479\x2C696\x2C684\n-620\x2C-835\x2C781\n543\x2C548\x2C-776\n780\x2C-569\x2C-623\n72\x2C-35\x2C-28\n739\x2C-671\x2C589\n-722\x2C-829\x2C846\n751\x2C-616\x2C690\n-726\x2C-518\x2C-431\n614\x2C357\x2C-777\n820\x2C-560\x2C-520\n-395\x2C593\x2C590\n409\x2C467\x2C503\n-480\x2C689\x2C-930\n-638\x2C-678\x2C796\n-659\x2C-697\x2C-393\n-670\x2C-521\x2C-456\n-381\x2C674\x2C686\n505\x2C478\x2C-820\n724\x2C-562\x2C541\n512\x2C487\x2C569\n799\x2C-727\x2C-520\n383\x2C626\x2C564\n\n--- scanner 3 ---\n-471\x2C-463\x2C618\n-528\x2C536\x2C550\n580\x2C589\x2C470\n611\x2C632\x2C475\n-631\x2C-616\x2C-517\n387\x2C908\x2C-363\n-420\x2C-552\x2C711\n-596\x2C872\x2C-676\n558\x2C-453\x2C-661\n-57\x2C3\x2C-53\n343\x2C898\x2C-509\n432\x2C-607\x2C530\n-532\x2C492\x2C595\n-673\x2C-631\x2C-612\n-429\x2C842\x2C-627\n513\x2C890\x2C-436\n711\x2C-464\x2C-578\n-458\x2C-587\x2C707\n515\x2C-559\x2C625\n334\x2C-581\x2C608\n-670\x2C-778\x2C-479\n-539\x2C593\x2C691\n738\x2C-518\x2C-617\n-557\x2C731\x2C-654\n649\x2C644\x2C484\n\n--- scanner 4 ---\n773\x2C-717\x2C-634\n808\x2C667\x2C616\n-324\x2C505\x2C684\n129\x2C-130\x2C-61\n-775\x2C808\x2C-500\n-352\x2C-815\x2C452\n-799\x2C666\x2C-540\n66\x2C54\x2C34\n535\x2C-677\x2C376\n954\x2C517\x2C-467\n801\x2C-678\x2C-463\n749\x2C572\x2C-432\n-419\x2C-830\x2C362\n699\x2C682\x2C568\n-816\x2C781\x2C-501\n754\x2C694\x2C467\n541\x2C-779\x2C311\n-622\x2C-542\x2C-779\n-755\x2C-542\x2C-767\n-373\x2C626\x2C725\n-404\x2C568\x2C818\n777\x2C-727\x2C-350\n-663\x2C-338\x2C-764\n-274\x2C-843\x2C495\n692\x2C-695\x2C361\n791\x2C545\x2C-440\n\n--- scanner 5 ---\n-760\x2C593\x2C537\n-686\x2C583\x2C544\n427\x2C-483\x2C728\n-401\x2C-648\x2C-691\n-570\x2C-596\x2C-652\n531\x2C634\x2C-630\n-519\x2C424\x2C-468\n-729\x2C419\x2C-444\n-738\x2C-441\x2C557\n527\x2C-382\x2C-315\n-788\x2C622\x2C509\n693\x2C567\x2C425\n-812\x2C-366\x2C558\n460\x2C-418\x2C-286\n393\x2C-523\x2C622\n729\x2C514\x2C586\n600\x2C-440\x2C-304\n-741\x2C-585\x2C560\n511\x2C577\x2C-450\n501\x2C-567\x2C630\n-22\x2C169\x2C14\n-547\x2C479\x2C-473\n466\x2C587\x2C-645\n-516\x2C-651\x2C-761\n766\x2C630\x2C561\n\n--- scanner 6 ---\n-326\x2C322\x2C730\n-445\x2C-390\x2C376\n574\x2C489\x2C585\n-735\x2C-527\x2C-435\n-496\x2C330\x2C803\n91\x2C47\x2C-14\n-542\x2C-548\x2C387\n648\x2C-569\x2C724\n603\x2C-590\x2C-612\n-736\x2C-587\x2C-407\n-487\x2C491\x2C-756\n828\x2C-581\x2C704\n-527\x2C-545\x2C430\n-471\x2C508\x2C-693\n-768\x2C-536\x2C-342\n596\x2C-524\x2C-524\n-515\x2C672\x2C-714\n858\x2C-559\x2C735\n-370\x2C312\x2C876\n604\x2C501\x2C-272\n0\x2C-116\x2C153\n627\x2C-517\x2C-719\n446\x2C378\x2C612\n737\x2C580\x2C-314\n613\x2C348\x2C563\n597\x2C533\x2C-349\n\n--- scanner 7 ---\n394\x2C-586\x2C-661\n393\x2C-558\x2C-601\n-689\x2C562\x2C-354\n684\x2C225\x2C-798\n-114\x2C-56\x2C111\n-739\x2C-893\x2C597\n-565\x2C-643\x2C-577\n-861\x2C-971\x2C590\n-704\x2C490\x2C533\n-17\x2C-119\x2C-35\n361\x2C-493\x2C-652\n-796\x2C-915\x2C662\n507\x2C388\x2C760\n587\x2C236\x2C-640\n-534\x2C-597\x2C-598\n651\x2C391\x2C763\n385\x2C-536\x2C502\n428\x2C-570\x2C366\n-499\x2C540\x2C-276\n-597\x2C579\x2C-433\n470\x2C-427\x2C432\n726\x2C317\x2C762\n-683\x2C546\x2C506\n602\x2C279\x2C-643\n-526\x2C-685\x2C-624\n-701\x2C405\x2C437\n\n--- scanner 8 ---\n-399\x2C844\x2C418\n-722\x2C-795\x2C-540\n627\x2C-452\x2C885\n-443\x2C829\x2C419\n-747\x2C-451\x2C528\n556\x2C-356\x2C812\n408\x2C573\x2C-471\n633\x2C433\x2C707\n-620\x2C317\x2C-769\n547\x2C404\x2C848\n757\x2C-880\x2C-722\n-754\x2C-872\x2C-547\n364\x2C498\x2C-597\n487\x2C536\x2C-630\n-61\x2C48\x2C31\n643\x2C-435\x2C791\n-764\x2C-388\x2C544\n-152\x2C-77\x2C-70\n-583\x2C-430\x2C572\n-675\x2C-830\x2C-680\n-472\x2C893\x2C309\n-634\x2C319\x2C-814\n613\x2C-829\x2C-680\n733\x2C-852\x2C-708\n-486\x2C380\x2C-859\n567\x2C444\x2C728\n\n--- scanner 9 ---\n-477\x2C-923\x2C-562\n-779\x2C-536\x2C360\n-459\x2C-972\x2C-443\n-795\x2C-519\x2C454\n320\x2C809\x2C936\n419\x2C279\x2C-638\n-646\x2C-969\x2C-505\n476\x2C281\x2C-604\n-785\x2C349\x2C538\n18\x2C6\x2C-41\n-699\x2C320\x2C397\n-708\x2C-440\x2C433\n247\x2C760\x2C827\n469\x2C-915\x2C-835\n553\x2C-964\x2C-787\n-719\x2C360\x2C517\n291\x2C745\x2C826\n-603\x2C790\x2C-602\n-579\x2C787\x2C-649\n534\x2C239\x2C-691\n-54\x2C-171\x2C71\n-536\x2C693\x2C-708\n324\x2C-938\x2C-747\n431\x2C-514\x2C673\n612\x2C-472\x2C701\n595\x2C-535\x2C717\n\n--- scanner 10 ---\n-476\x2C-681\x2C-773\n501\x2C743\x2C-516\n553\x2C756\x2C508\n663\x2C-627\x2C790\n683\x2C-639\x2C610\n-522\x2C743\x2C510\n-653\x2C-618\x2C565\n479\x2C763\x2C518\n-460\x2C346\x2C-739\n451\x2C791\x2C547\n346\x2C-660\x2C-580\n694\x2C-649\x2C820\n-426\x2C482\x2C-782\n427\x2C742\x2C-441\n-559\x2C612\x2C389\n389\x2C-663\x2C-565\n498\x2C740\x2C-660\n-448\x2C-621\x2C-774\n-317\x2C412\x2C-697\n36\x2C-9\x2C7\n-760\x2C-691\x2C589\n-472\x2C578\x2C535\n335\x2C-818\x2C-483\n-565\x2C-684\x2C558\n-383\x2C-672\x2C-806\n\n--- scanner 11 ---\n410\x2C-606\x2C803\n449\x2C-844\x2C814\n383\x2C-848\x2C778\n-484\x2C796\x2C561\n-728\x2C-606\x2C-672\n-741\x2C469\x2C-674\n-478\x2C816\x2C785\n-597\x2C-643\x2C-793\n-59\x2C1\x2C97\n-776\x2C367\x2C-635\n655\x2C637\x2C540\n706\x2C-844\x2C-593\n6\x2C-117\x2C-25\n642\x2C579\x2C-392\n654\x2C599\x2C-572\n664\x2C610\x2C-362\n621\x2C578\x2C662\n699\x2C-649\x2C-624\n-664\x2C-391\x2C802\n-725\x2C-496\x2C900\n-563\x2C-556\x2C-647\n-679\x2C-428\x2C850\n-748\x2C395\x2C-664\n687\x2C732\x2C647\n-481\x2C753\x2C754\n633\x2C-737\x2C-617\n\n--- scanner 12 ---\n646\x2C-480\x2C-717\n-770\x2C505\x2C551\n913\x2C318\x2C447\n448\x2C812\x2C-365\n-560\x2C667\x2C-499\n-564\x2C-524\x2C-734\n-680\x2C-549\x2C-697\n851\x2C263\x2C498\n-601\x2C-500\x2C792\n417\x2C-462\x2C-695\n-617\x2C487\x2C-479\n-775\x2C481\x2C761\n549\x2C-537\x2C-665\n437\x2C744\x2C-417\n848\x2C-770\x2C371\n-572\x2C-472\x2C820\n-607\x2C682\x2C-434\n401\x2C722\x2C-491\n790\x2C326\x2C600\n817\x2C-767\x2C434\n163\x2C39\x2C-44\n1\x2C-5\x2C58\n-611\x2C-507\x2C718\n-627\x2C-388\x2C-661\n-715\x2C510\x2C579\n624\x2C-764\x2C391\n\n--- scanner 13 ---\n311\x2C670\x2C-775\n712\x2C-733\x2C566\n-560\x2C-681\x2C-278\n-51\x2C60\x2C110\n-700\x2C-659\x2C-296\n641\x2C-514\x2C568\n624\x2C694\x2C891\n470\x2C-503\x2C-644\n-551\x2C763\x2C738\n-493\x2C-576\x2C630\n483\x2C676\x2C822\n301\x2C-451\x2C-683\n539\x2C697\x2C795\n416\x2C-448\x2C-753\n-527\x2C-616\x2C736\n-627\x2C-717\x2C-307\n-601\x2C-532\x2C638\n-815\x2C661\x2C-730\n-478\x2C691\x2C870\n-750\x2C658\x2C-716\n446\x2C748\x2C-705\n-967\x2C689\x2C-763\n638\x2C-658\x2C565\n-478\x2C615\x2C676\n428\x2C597\x2C-769\n\n--- scanner 14 ---\n624\x2C622\x2C-621\n649\x2C590\x2C-567\n10\x2C57\x2C64\n394\x2C-674\x2C-779\n693\x2C781\x2C830\n-556\x2C369\x2C-750\n-590\x2C410\x2C496\n-648\x2C-683\x2C518\n-560\x2C389\x2C-781\n-29\x2C-77\x2C-73\n856\x2C-788\x2C330\n-500\x2C371\x2C598\n-638\x2C-830\x2C499\n366\x2C-787\x2C-652\n798\x2C-701\x2C389\n635\x2C617\x2C-580\n357\x2C-731\x2C-681\n-345\x2C-433\x2C-622\n938\x2C-757\x2C320\n-411\x2C-544\x2C-661\n-579\x2C491\x2C615\n141\x2C50\x2C-115\n-348\x2C-487\x2C-704\n521\x2C745\x2C757\n491\x2C729\x2C859\n-704\x2C-823\x2C603\n-533\x2C382\x2C-904\n\n--- scanner 15 ---\n-263\x2C581\x2C-415\n-281\x2C390\x2C-455\n916\x2C-537\x2C-806\n-605\x2C382\x2C414\n837\x2C-450\x2C-785\n820\x2C-466\x2C-879\n392\x2C-336\x2C728\n-632\x2C-350\x2C636\n-594\x2C-512\x2C597\n-499\x2C-497\x2C639\n65\x2C78\x2C-18\n-707\x2C462\x2C345\n789\x2C668\x2C-384\n684\x2C328\x2C667\n-644\x2C442\x2C525\n-232\x2C625\x2C-454\n552\x2C397\x2C728\n-450\x2C-675\x2C-592\n876\x2C640\x2C-488\n-494\x2C-610\x2C-772\n719\x2C346\x2C687\n420\x2C-360\x2C714\n-533\x2C-664\x2C-745\n443\x2C-480\x2C686\n758\x2C684\x2C-529\n\n--- scanner 16 ---\n874\x2C677\x2C-708\n-575\x2C-438\x2C574\n673\x2C661\x2C488\n94\x2C-32\x2C-47\n-444\x2C467\x2C-486\n-64\x2C28\x2C70\n-445\x2C392\x2C-412\n-775\x2C648\x2C332\n760\x2C-684\x2C787\n-705\x2C733\x2C441\n557\x2C-393\x2C-495\n735\x2C590\x2C500\n772\x2C-816\x2C735\n-396\x2C-596\x2C-436\n581\x2C-398\x2C-705\n843\x2C-843\x2C784\n765\x2C622\x2C-654\n-431\x2C-557\x2C-538\n804\x2C674\x2C-823\n-444\x2C-559\x2C537\n-447\x2C611\x2C-483\n586\x2C-453\x2C-677\n-841\x2C690\x2C475\n-609\x2C-584\x2C487\n-424\x2C-567\x2C-464\n676\x2C610\x2C517\n\n--- scanner 17 ---\n-457\x2C602\x2C-521\n-785\x2C-705\x2C788\n287\x2C-452\x2C868\n235\x2C664\x2C699\n408\x2C-468\x2C-355\n-439\x2C580\x2C-661\n-747\x2C-785\x2C826\n298\x2C-656\x2C818\n-559\x2C876\x2C501\n477\x2C729\x2C-620\n-108\x2C152\x2C68\n-783\x2C-472\x2C-590\n-798\x2C-425\x2C-655\n291\x2C702\x2C828\n433\x2C-352\x2C-392\n272\x2C-405\x2C-428\n240\x2C704\x2C825\n-468\x2C544\x2C-594\n245\x2C-536\x2C845\n-488\x2C821\x2C519\n575\x2C645\x2C-694\n-689\x2C-747\x2C941\n469\x2C685\x2C-728\n-477\x2C793\x2C620\n-603\x2C-415\x2C-610\n14\x2C11\x2C7\n\n--- scanner 18 ---\n788\x2C552\x2C-857\n-660\x2C-556\x2C795\n-557\x2C617\x2C662\n-25\x2C-55\x2C-84\n794\x2C776\x2C-877\n524\x2C-673\x2C-456\n157\x2C-18\x2C13\n531\x2C-683\x2C-530\n-302\x2C718\x2C-648\n547\x2C891\x2C435\n-481\x2C-842\x2C-697\n675\x2C-802\x2C582\n-294\x2C841\x2C-801\n-743\x2C-397\x2C792\n544\x2C-681\x2C545\n-672\x2C-424\x2C743\n608\x2C793\x2C330\n-486\x2C-787\x2C-669\n-239\x2C779\x2C-750\n791\x2C745\x2C-814\n593\x2C841\x2C367\n709\x2C-656\x2C495\n-530\x2C631\x2C649\n-457\x2C-847\x2C-487\n-525\x2C642\x2C608\n496\x2C-644\x2C-428\n\n--- scanner 19 ---\n-238\x2C548\x2C843\n842\x2C-440\x2C418\n-285\x2C454\x2C751\n799\x2C419\x2C-559\n719\x2C-870\x2C-801\n740\x2C536\x2C579\n807\x2C491\x2C-376\n-549\x2C300\x2C-752\n-661\x2C-859\x2C519\n811\x2C577\x2C-506\n-686\x2C-675\x2C576\n908\x2C-476\x2C414\n626\x2C541\x2C737\n741\x2C-825\x2C-767\n881\x2C-451\x2C656\n677\x2C411\x2C619\n-621\x2C-612\x2C-426\n32\x2C40\x2C20\n-251\x2C628\x2C740\n-587\x2C-669\x2C-313\n-416\x2C346\x2C-677\n675\x2C-673\x2C-842\n-709\x2C-695\x2C-334\n-715\x2C-764\x2C472\n184\x2C-69\x2C70\n-550\x2C391\x2C-735\n\n--- scanner 20 ---\n488\x2C654\x2C558\n451\x2C888\x2C-733\n483\x2C888\x2C-660\n-798\x2C636\x2C-780\n-717\x2C497\x2C622\n-643\x2C572\x2C623\n-665\x2C-462\x2C643\n596\x2C698\x2C550\n481\x2C-464\x2C-423\n-3\x2C6\x2C-186\n522\x2C614\x2C452\n438\x2C-558\x2C-488\n-693\x2C-491\x2C671\n-461\x2C-554\x2C-759\n-591\x2C-452\x2C636\n639\x2C871\x2C-733\n-755\x2C621\x2C-783\n824\x2C-383\x2C594\n105\x2C51\x2C-18\n861\x2C-499\x2C619\n-809\x2C539\x2C-938\n-646\x2C716\x2C620\n-481\x2C-734\x2C-747\n410\x2C-375\x2C-562\n788\x2C-436\x2C755\n-450\x2C-764\x2C-769\n\n--- scanner 21 ---\n-492\x2C308\x2C450\n-319\x2C346\x2C369\n-389\x2C604\x2C-841\n627\x2C687\x2C-533\n768\x2C-378\x2C-808\n-443\x2C346\x2C356\n661\x2C279\x2C514\n-519\x2C-788\x2C-739\n652\x2C694\x2C-527\n-688\x2C-731\x2C607\n481\x2C-473\x2C512\n457\x2C-735\x2C508\n750\x2C-467\x2C-853\n762\x2C295\x2C510\n772\x2C-434\x2C-805\n81\x2C-10\x2C87\n-79\x2C-146\x2C66\n-549\x2C-650\x2C-816\n517\x2C-627\x2C495\n621\x2C252\x2C457\n-586\x2C-705\x2C-699\n-628\x2C647\x2C-834\n-538\x2C474\x2C-847\n650\x2C678\x2C-718\n-588\x2C-751\x2C539\n-629\x2C-624\x2C545\n\n--- scanner 22 ---\n816\x2C750\x2C750\n413\x2C-797\x2C-714\n-683\x2C-851\x2C-281\n-915\x2C736\x2C410\n673\x2C816\x2C792\n-820\x2C700\x2C413\n661\x2C584\x2C-482\n-723\x2C-943\x2C-352\n361\x2C-785\x2C-582\n660\x2C-698\x2C763\n-499\x2C-562\x2C697\n631\x2C-701\x2C712\n-700\x2C-876\x2C-425\n574\x2C550\x2C-336\n-387\x2C-534\x2C674\n-855\x2C686\x2C385\n648\x2C-760\x2C692\n-502\x2C464\x2C-636\n611\x2C419\x2C-457\n-568\x2C-549\x2C721\n-52\x2C-100\x2C132\n-401\x2C404\x2C-659\n364\x2C-868\x2C-741\n707\x2C680\x2C835\n-129\x2C-24\x2C-46\n-438\x2C456\x2C-592\n\n--- scanner 23 ---\n-664\x2C626\x2C764\n388\x2C-888\x2C-500\n-675\x2C507\x2C845\n549\x2C479\x2C-672\n539\x2C-610\x2C633\n-14\x2C70\x2C75\n-708\x2C742\x2C-850\n-622\x2C-839\x2C-781\n-112\x2C-80\x2C-29\n-618\x2C-893\x2C873\n-863\x2C654\x2C-829\n-645\x2C-770\x2C866\n756\x2C494\x2C-685\n550\x2C-569\x2C638\n-667\x2C-779\x2C-675\n-771\x2C737\x2C-775\n564\x2C-556\x2C665\n290\x2C-783\x2C-439\n-641\x2C-739\x2C886\n340\x2C-851\x2C-485\n-585\x2C609\x2C884\n406\x2C870\x2C526\n614\x2C566\x2C-711\n-495\x2C-839\x2C-657\n436\x2C768\x2C510\n608\x2C841\x2C474\n\n--- scanner 24 ---\n492\x2C-446\x2C-368\n-847\x2C-473\x2C896\n-686\x2C-645\x2C-471\n602\x2C-574\x2C731\n-895\x2C-458\x2C859\n-621\x2C-684\x2C-558\n-696\x2C660\x2C618\n370\x2C807\x2C483\n-829\x2C553\x2C-862\n343\x2C878\x2C434\n425\x2C-394\x2C-331\n448\x2C-454\x2C-432\n-60\x2C18\x2C-53\n-671\x2C692\x2C564\n-479\x2C-658\x2C-486\n502\x2C795\x2C431\n-627\x2C501\x2C-833\n732\x2C953\x2C-653\n659\x2C886\x2C-630\n-685\x2C665\x2C577\n-945\x2C-412\x2C791\n748\x2C-540\x2C644\n-13\x2C142\x2C95\n803\x2C861\x2C-613\n627\x2C-409\x2C681\n-799\x2C537\x2C-760\n\n--- scanner 25 ---\n584\x2C-913\x2C-621\n-669\x2C585\x2C723\n-590\x2C347\x2C-711\n81\x2C-101\x2C14\n387\x2C-872\x2C-577\n-791\x2C-634\x2C-757\n781\x2C343\x2C-388\n-534\x2C-464\x2C686\n853\x2C763\x2C674\n-621\x2C542\x2C-704\n432\x2C-838\x2C-555\n806\x2C585\x2C-415\n437\x2C-582\x2C474\n817\x2C347\x2C-454\n-28\x2C1\x2C-89\n-644\x2C635\x2C558\n-798\x2C-860\x2C-702\n-778\x2C-704\x2C-654\n903\x2C695\x2C720\n-614\x2C454\x2C-638\n-467\x2C-427\x2C738\n-490\x2C-528\x2C678\n805\x2C800\x2C659\n644\x2C-567\x2C487\n579\x2C-654\x2C448\n-790\x2C548\x2C592\n\n--- scanner 26 ---\n423\x2C-847\x2C767\n653\x2C-771\x2C-637\n-845\x2C-744\x2C-484\n-806\x2C746\x2C-548\n-152\x2C-123\x2C-153\n278\x2C-860\x2C634\n599\x2C-943\x2C-691\n-531\x2C-694\x2C753\n-48\x2C45\x2C-50\n-695\x2C665\x2C561\n-848\x2C-800\x2C-459\n408\x2C551\x2C311\n328\x2C488\x2C445\n377\x2C609\x2C404\n471\x2C338\x2C-463\n-669\x2C-733\x2C-421\n-797\x2C706\x2C-651\n-804\x2C650\x2C513\n390\x2C412\x2C-574\n602\x2C-896\x2C-717\n-639\x2C725\x2C-548\n-688\x2C-712\x2C768\n356\x2C-832\x2C677\n435\x2C333\x2C-465\n-537\x2C-796\x2C818\n-750\x2C677\x2C662\n\n--- scanner 27 ---\n729\x2C503\x2C-479\n-517\x2C-963\x2C373\n-378\x2C-582\x2C-567\n414\x2C-594\x2C-678\n-559\x2C244\x2C-879\n-318\x2C-621\x2C-456\n-695\x2C246\x2C-838\n605\x2C592\x2C-466\n674\x2C-732\x2C730\n728\x2C-693\x2C703\n-542\x2C344\x2C-835\n-561\x2C-994\x2C412\n633\x2C510\x2C507\n-708\x2C521\x2C549\n585\x2C415\x2C424\n-398\x2C-519\x2C-387\n576\x2C-632\x2C-639\n-326\x2C-945\x2C413\n561\x2C-727\x2C-681\n45\x2C-86\x2C-77\n739\x2C-776\x2C550\n-654\x2C543\x2C735\n640\x2C596\x2C-428\n-677\x2C680\x2C596\n611\x2C493\x2C326\n\n--- scanner 28 ---\n-401\x2C-616\x2C740\n703\x2C-826\x2C599\n-690\x2C-659\x2C-687\n-348\x2C560\x2C910\n624\x2C-868\x2C732\n900\x2C331\x2C-443\n-484\x2C839\x2C-465\n-467\x2C-528\x2C733\n812\x2C423\x2C-526\n-451\x2C630\x2C897\n-717\x2C-417\x2C-662\n778\x2C310\x2C-469\n-651\x2C-421\x2C-698\n892\x2C384\x2C420\n-550\x2C764\x2C-313\n-528\x2C798\x2C-268\n906\x2C-475\x2C-374\n758\x2C321\x2C510\n656\x2C-791\x2C739\n852\x2C-522\x2C-279\n-403\x2C786\x2C917\n877\x2C-579\x2C-463\n-394\x2C-421\x2C709\n744\x2C323\x2C465\n105\x2C-23\x2C64\n\n--- scanner 29 ---\n-481\x2C471\x2C-306\n562\x2C-724\x2C861\n476\x2C-793\x2C-720\n-785\x2C753\x2C665\n-567\x2C-417\x2C-645\n-655\x2C-633\x2C546\n-620\x2C-523\x2C657\n517\x2C-618\x2C801\n-890\x2C860\x2C687\n566\x2C930\x2C915\n413\x2C-718\x2C-715\n321\x2C-772\x2C-632\n-680\x2C-567\x2C-661\n-501\x2C453\x2C-380\n-607\x2C459\x2C-359\n543\x2C943\x2C761\n509\x2C902\x2C-485\n689\x2C-600\x2C861\n-867\x2C634\x2C707\n-656\x2C-364\x2C571\n-775\x2C-406\x2C-665\n539\x2C923\x2C792\n520\x2C821\x2C-604\n599\x2C941\x2C-587\n-49\x2C148\x2C48\n-146\x2C23\x2C-56\n\n--- scanner 30 ---\n-573\x2C-366\x2C309\n-619\x2C-298\x2C359\n531\x2C-593\x2C583\n-820\x2C946\x2C424\n276\x2C717\x2C482\n-791\x2C-310\x2C-476\n-156\x2C152\x2C71\n504\x2C-580\x2C569\n268\x2C870\x2C359\n-752\x2C836\x2C-543\n380\x2C600\x2C-403\n-889\x2C872\x2C-507\n213\x2C819\x2C421\n739\x2C-256\x2C-599\n-8\x2C44\x2C-80\n-915\x2C-310\x2C-603\n276\x2C689\x2C-454\n-817\x2C883\x2C455\n499\x2C-539\x2C558\n752\x2C-410\x2C-622\n326\x2C650\x2C-466\n-634\x2C-261\x2C407\n-809\x2C-370\x2C-648\n732\x2C-379\x2C-626\n-814\x2C926\x2C648\n-775\x2C839\x2C-399\n\n--- scanner 31 ---\n12\x2C9\x2C58\n-528\x2C-741\x2C535\n821\x2C-855\x2C-688\n933\x2C458\x2C730\n829\x2C-738\x2C634\n-489\x2C-657\x2C-824\n774\x2C-596\x2C637\n-391\x2C-745\x2C-874\n-728\x2C646\x2C405\n710\x2C-695\x2C719\n-673\x2C717\x2C423\n-454\x2C748\x2C-617\n-432\x2C766\x2C-757\n895\x2C516\x2C845\n168\x2C-26\x2C-52\n573\x2C407\x2C-751\n597\x2C-899\x2C-676\n563\x2C602\x2C-706\n682\x2C-790\x2C-718\n-645\x2C728\x2C524\n-517\x2C-691\x2C758\n-396\x2C737\x2C-690\n-454\x2C-776\x2C-912\n853\x2C420\x2C692\n-427\x2C-722\x2C713\n620\x2C422\x2C-686\n\n--- scanner 32 ---\n556\x2C-743\x2C700\n-394\x2C816\x2C770\n723\x2C-794\x2C659\n855\x2C406\x2C-530\n-561\x2C816\x2C749\n171\x2C-11\x2C61\n-352\x2C905\x2C-776\n-259\x2C-559\x2C-443\n-703\x2C-678\x2C317\n714\x2C560\x2C493\n-14\x2C166\x2C-124\n793\x2C-472\x2C-412\n880\x2C-500\x2C-516\n-640\x2C-698\x2C497\n688\x2C-812\x2C639\n762\x2C-456\x2C-557\n523\x2C559\x2C564\n-601\x2C-758\x2C386\n-228\x2C-515\x2C-482\n722\x2C407\x2C-491\n644\x2C516\x2C455\n-277\x2C-750\x2C-483\n874\x2C440\x2C-377\n-531\x2C943\x2C-709\n-403\x2C713\x2C730\n-355\x2C880\x2C-720\n\n--- scanner 33 ---\n-622\x2C343\x2C490\n489\x2C286\x2C-639\n-98\x2C-108\x2C-3\n-846\x2C381\x2C-702\n-570\x2C362\x2C-701\n521\x2C-425\x2C-554\n674\x2C715\x2C760\n499\x2C570\x2C-635\n-611\x2C-606\x2C-586\n878\x2C700\x2C801\n373\x2C-559\x2C412\n401\x2C-516\x2C490\n538\x2C399\x2C-663\n-616\x2C-819\x2C408\n674\x2C703\x2C893\n437\x2C-375\x2C-403\n-700\x2C-507\x2C-575\n-604\x2C-751\x2C479\n-500\x2C-758\x2C430\n-804\x2C286\x2C539\n386\x2C-426\x2C557\n67\x2C-103\x2C139\n539\x2C-440\x2C-397\n-742\x2C466\x2C-703\n-574\x2C-488\x2C-570\n-660\x2C232\x2C552\n\n--- scanner 34 ---\n-922\x2C-608\x2C651\n435\x2C-272\x2C-755\n-479\x2C617\x2C-635\n-564\x2C571\x2C507\n322\x2C412\x2C743\n493\x2C-310\x2C-870\n-761\x2C-376\x2C-659\n579\x2C-642\x2C681\n399\x2C-585\x2C661\n254\x2C423\x2C795\n-813\x2C-523\x2C693\n384\x2C-632\x2C726\n429\x2C439\x2C-675\n-121\x2C75\x2C-1\n-658\x2C582\x2C-669\n-619\x2C-431\x2C-662\n317\x2C534\x2C-598\n-468\x2C541\x2C392\n-644\x2C555\x2C-656\n397\x2C-352\x2C-717\n267\x2C500\x2C-631\n-878\x2C-384\x2C663\n-718\x2C-495\x2C-744\n344\x2C376\x2C669\n-478\x2C499\x2C485\n\n--- scanner 35 ---\n-760\x2C373\x2C-598\n-714\x2C574\x2C383\n-499\x2C-330\x2C-781\n439\x2C-375\x2C-810\n-644\x2C-789\x2C695\n555\x2C520\x2C671\n-641\x2C-372\x2C-687\n323\x2C-754\x2C683\n-705\x2C366\x2C-824\n-570\x2C-494\x2C-743\n-704\x2C-788\x2C667\n453\x2C-347\x2C-845\n389\x2C-712\x2C826\n-68\x2C12\x2C56\n-695\x2C-821\x2C760\n-657\x2C386\x2C-668\n459\x2C-797\x2C717\n683\x2C630\x2C-428\n-641\x2C550\x2C490\n403\x2C-372\x2C-905\n735\x2C697\x2C-391\n-707\x2C543\x2C578\n675\x2C674\x2C-492\n51\x2C-73\x2C-87\n589\x2C374\x2C584\n720\x2C495\x2C621\n\n--- scanner 36 ---\n580\x2C-390\x2C-635\n524\x2C-463\x2C348\n338\x2C791\x2C497\n684\x2C-341\x2C-642\n-688\x2C-469\x2C-394\n-613\x2C-321\x2C-360\n562\x2C-401\x2C459\n610\x2C659\x2C-372\n-562\x2C-720\x2C487\n-807\x2C357\x2C614\n380\x2C-450\x2C402\n484\x2C664\x2C-391\n-886\x2C390\x2C488\n-717\x2C-495\x2C-378\n-128\x2C-55\x2C-8\n-701\x2C598\x2C-436\n-818\x2C429\x2C597\n614\x2C790\x2C478\n573\x2C675\x2C-490\n-863\x2C636\x2C-370\n442\x2C792\x2C582\n-814\x2C648\x2C-428\n568\x2C-319\x2C-703\n-560\x2C-644\x2C497\n23\x2C63\x2C84\n-638\x2C-687\x2C585", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestingExpected, Type = String, Dynamic = False, Default = \"-892\x2C524\x2C684\n-876\x2C649\x2C763\n-838\x2C591\x2C734\n-789\x2C900\x2C-551\n-739\x2C-1745\x2C668\n-706\x2C-3180\x2C-659\n-697\x2C-3072\x2C-689\n-689\x2C845\x2C-530\n-687\x2C-1600\x2C576\n-661\x2C-816\x2C-575\n-654\x2C-3158\x2C-753\n-635\x2C-1737\x2C486\n-631\x2C-672\x2C1502\n-624\x2C-1620\x2C1868\n-620\x2C-3212\x2C371\n-618\x2C-824\x2C-621\n-612\x2C-1695\x2C1788\n-601\x2C-1648\x2C-643\n-584\x2C868\x2C-557\n-537\x2C-823\x2C-458\n-532\x2C-1715\x2C1894\n-518\x2C-1681\x2C-600\n-499\x2C-1607\x2C-770\n-485\x2C-357\x2C347\n-470\x2C-3283\x2C303\n-456\x2C-621\x2C1527\n-447\x2C-329\x2C318\n-430\x2C-3130\x2C366\n-413\x2C-627\x2C1469\n-345\x2C-311\x2C381\n-36\x2C-1284\x2C1171\n-27\x2C-1108\x2C-65\n7\x2C-33\x2C-71\n12\x2C-2351\x2C-103\n26\x2C-1119\x2C1091\n346\x2C-2985\x2C342\n366\x2C-3059\x2C397\n377\x2C-2827\x2C367\n390\x2C-675\x2C-793\n396\x2C-1931\x2C-563\n404\x2C-588\x2C-901\n408\x2C-1815\x2C803\n423\x2C-701\x2C434\n432\x2C-2009\x2C850\n443\x2C580\x2C662\n455\x2C729\x2C728\n456\x2C-540\x2C1869\n459\x2C-707\x2C401\n465\x2C-695\x2C1988\n474\x2C580\x2C667\n496\x2C-1584\x2C1900\n497\x2C-1838\x2C-617\n527\x2C-524\x2C1933\n528\x2C-643\x2C409\n534\x2C-1912\x2C768\n544\x2C-627\x2C-890\n553\x2C345\x2C-567\n564\x2C392\x2C-477\n568\x2C-2007\x2C-577\n605\x2C-1665\x2C1952\n612\x2C-1593\x2C1893\n630\x2C319\x2C-379\n686\x2C-3108\x2C-505\n776\x2C-3184\x2C-501\n846\x2C-3110\x2C-434\n1135\x2C-1161\x2C1235\n1243\x2C-1093\x2C1063\n1660\x2C-552\x2C429\n1693\x2C-557\x2C386\n1735\x2C-437\x2C1738\n1749\x2C-1800\x2C1813\n1772\x2C-405\x2C1572\n1776\x2C-675\x2C371\n1779\x2C-442\x2C1789\n1780\x2C-1548\x2C337\n1786\x2C-1538\x2C337\n1847\x2C-1591\x2C415\n1889\x2C-1729\x2C1762\n1994\x2C-1805\x2C1792", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"--- scanner 0 ---\n404\x2C-588\x2C-901\n528\x2C-643\x2C409\n-838\x2C591\x2C734\n390\x2C-675\x2C-793\n-537\x2C-823\x2C-458\n-485\x2C-357\x2C347\n-345\x2C-311\x2C381\n-661\x2C-816\x2C-575\n-876\x2C649\x2C763\n-618\x2C-824\x2C-621\n553\x2C345\x2C-567\n474\x2C580\x2C667\n-447\x2C-329\x2C318\n-584\x2C868\x2C-557\n544\x2C-627\x2C-890\n564\x2C392\x2C-477\n455\x2C729\x2C728\n-892\x2C524\x2C684\n-689\x2C845\x2C-530\n423\x2C-701\x2C434\n7\x2C-33\x2C-71\n630\x2C319\x2C-379\n443\x2C580\x2C662\n-789\x2C900\x2C-551\n459\x2C-707\x2C401\n\n--- scanner 1 ---\n686\x2C422\x2C578\n605\x2C423\x2C415\n515\x2C917\x2C-361\n-336\x2C658\x2C858\n95\x2C138\x2C22\n-476\x2C619\x2C847\n-340\x2C-569\x2C-846\n567\x2C-361\x2C727\n-460\x2C603\x2C-452\n669\x2C-402\x2C600\n729\x2C430\x2C532\n-500\x2C-761\x2C534\n-322\x2C571\x2C750\n-466\x2C-666\x2C-811\n-429\x2C-592\x2C574\n-355\x2C545\x2C-477\n703\x2C-491\x2C-529\n-328\x2C-685\x2C520\n413\x2C935\x2C-424\n-391\x2C539\x2C-444\n586\x2C-435\x2C557\n-364\x2C-763\x2C-893\n807\x2C-499\x2C-711\n755\x2C-354\x2C-619\n553\x2C889\x2C-390\n\n--- scanner 2 ---\n649\x2C640\x2C665\n682\x2C-795\x2C504\n-784\x2C533\x2C-524\n-644\x2C584\x2C-595\n-588\x2C-843\x2C648\n-30\x2C6\x2C44\n-674\x2C560\x2C763\n500\x2C723\x2C-460\n609\x2C671\x2C-379\n-555\x2C-800\x2C653\n-675\x2C-892\x2C-343\n697\x2C-426\x2C-610\n578\x2C704\x2C681\n493\x2C664\x2C-388\n-671\x2C-858\x2C530\n-667\x2C343\x2C800\n571\x2C-461\x2C-707\n-138\x2C-166\x2C112\n-889\x2C563\x2C-600\n646\x2C-828\x2C498\n640\x2C759\x2C510\n-630\x2C509\x2C768\n-681\x2C-892\x2C-333\n673\x2C-379\x2C-804\n-742\x2C-814\x2C-386\n577\x2C-820\x2C562\n\n--- scanner 3 ---\n-589\x2C542\x2C597\n605\x2C-692\x2C669\n-500\x2C565\x2C-823\n-660\x2C373\x2C557\n-458\x2C-679\x2C-417\n-488\x2C449\x2C543\n-626\x2C468\x2C-788\n338\x2C-750\x2C-386\n528\x2C-832\x2C-391\n562\x2C-778\x2C733\n-938\x2C-730\x2C414\n543\x2C643\x2C-506\n-524\x2C371\x2C-870\n407\x2C773\x2C750\n-104\x2C29\x2C83\n378\x2C-903\x2C-323\n-778\x2C-728\x2C485\n426\x2C699\x2C580\n-438\x2C-605\x2C-362\n-469\x2C-447\x2C-387\n509\x2C732\x2C623\n647\x2C635\x2C-688\n-868\x2C-804\x2C481\n614\x2C-800\x2C639\n595\x2C780\x2C-596\n\n--- scanner 4 ---\n727\x2C592\x2C562\n-293\x2C-554\x2C779\n441\x2C611\x2C-461\n-714\x2C465\x2C-776\n-743\x2C427\x2C-804\n-660\x2C-479\x2C-426\n832\x2C-632\x2C460\n927\x2C-485\x2C-438\n408\x2C393\x2C-506\n466\x2C436\x2C-512\n110\x2C16\x2C151\n-258\x2C-428\x2C682\n-393\x2C719\x2C612\n-211\x2C-452\x2C876\n808\x2C-476\x2C-593\n-575\x2C615\x2C604\n-485\x2C667\x2C467\n-680\x2C325\x2C-822\n-627\x2C-443\x2C-432\n872\x2C-547\x2C-609\n833\x2C512\x2C582\n807\x2C604\x2C487\n839\x2C-516\x2C451\n891\x2C-625\x2C532\n-652\x2C-548\x2C-490\n30\x2C-46\x2C-14", Scope = Private
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
