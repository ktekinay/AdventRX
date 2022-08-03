#tag Class
Protected Class Advent_2021_12_19
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

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
		  
		  print ""
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
		  
		  'print "Checking scanner " + goodScanner.Index.ToString + " against scanner " + candidate.Index.ToString
		  
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
		          print "Scanner " + candidate.Index.ToString + " matched scanner " + goodScanner.Index.ToString + " on orientation " + orientation.ToString
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


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestingExpected, Type = String, Dynamic = False, Default = \"-892\x2C524\x2C684\n-876\x2C649\x2C763\n-838\x2C591\x2C734\n-789\x2C900\x2C-551\n-739\x2C-1745\x2C668\n-706\x2C-3180\x2C-659\n-697\x2C-3072\x2C-689\n-689\x2C845\x2C-530\n-687\x2C-1600\x2C576\n-661\x2C-816\x2C-575\n-654\x2C-3158\x2C-753\n-635\x2C-1737\x2C486\n-631\x2C-672\x2C1502\n-624\x2C-1620\x2C1868\n-620\x2C-3212\x2C371\n-618\x2C-824\x2C-621\n-612\x2C-1695\x2C1788\n-601\x2C-1648\x2C-643\n-584\x2C868\x2C-557\n-537\x2C-823\x2C-458\n-532\x2C-1715\x2C1894\n-518\x2C-1681\x2C-600\n-499\x2C-1607\x2C-770\n-485\x2C-357\x2C347\n-470\x2C-3283\x2C303\n-456\x2C-621\x2C1527\n-447\x2C-329\x2C318\n-430\x2C-3130\x2C366\n-413\x2C-627\x2C1469\n-345\x2C-311\x2C381\n-36\x2C-1284\x2C1171\n-27\x2C-1108\x2C-65\n7\x2C-33\x2C-71\n12\x2C-2351\x2C-103\n26\x2C-1119\x2C1091\n346\x2C-2985\x2C342\n366\x2C-3059\x2C397\n377\x2C-2827\x2C367\n390\x2C-675\x2C-793\n396\x2C-1931\x2C-563\n404\x2C-588\x2C-901\n408\x2C-1815\x2C803\n423\x2C-701\x2C434\n432\x2C-2009\x2C850\n443\x2C580\x2C662\n455\x2C729\x2C728\n456\x2C-540\x2C1869\n459\x2C-707\x2C401\n465\x2C-695\x2C1988\n474\x2C580\x2C667\n496\x2C-1584\x2C1900\n497\x2C-1838\x2C-617\n527\x2C-524\x2C1933\n528\x2C-643\x2C409\n534\x2C-1912\x2C768\n544\x2C-627\x2C-890\n553\x2C345\x2C-567\n564\x2C392\x2C-477\n568\x2C-2007\x2C-577\n605\x2C-1665\x2C1952\n612\x2C-1593\x2C1893\n630\x2C319\x2C-379\n686\x2C-3108\x2C-505\n776\x2C-3184\x2C-501\n846\x2C-3110\x2C-434\n1135\x2C-1161\x2C1235\n1243\x2C-1093\x2C1063\n1660\x2C-552\x2C429\n1693\x2C-557\x2C386\n1735\x2C-437\x2C1738\n1749\x2C-1800\x2C1813\n1772\x2C-405\x2C1572\n1776\x2C-675\x2C371\n1779\x2C-442\x2C1789\n1780\x2C-1548\x2C337\n1786\x2C-1538\x2C337\n1847\x2C-1591\x2C415\n1889\x2C-1729\x2C1762\n1994\x2C-1805\x2C1792", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"--- scanner 0 ---\n404\x2C-588\x2C-901\n528\x2C-643\x2C409\n-838\x2C591\x2C734\n390\x2C-675\x2C-793\n-537\x2C-823\x2C-458\n-485\x2C-357\x2C347\n-345\x2C-311\x2C381\n-661\x2C-816\x2C-575\n-876\x2C649\x2C763\n-618\x2C-824\x2C-621\n553\x2C345\x2C-567\n474\x2C580\x2C667\n-447\x2C-329\x2C318\n-584\x2C868\x2C-557\n544\x2C-627\x2C-890\n564\x2C392\x2C-477\n455\x2C729\x2C728\n-892\x2C524\x2C684\n-689\x2C845\x2C-530\n423\x2C-701\x2C434\n7\x2C-33\x2C-71\n630\x2C319\x2C-379\n443\x2C580\x2C662\n-789\x2C900\x2C-551\n459\x2C-707\x2C401\n\n--- scanner 1 ---\n686\x2C422\x2C578\n605\x2C423\x2C415\n515\x2C917\x2C-361\n-336\x2C658\x2C858\n95\x2C138\x2C22\n-476\x2C619\x2C847\n-340\x2C-569\x2C-846\n567\x2C-361\x2C727\n-460\x2C603\x2C-452\n669\x2C-402\x2C600\n729\x2C430\x2C532\n-500\x2C-761\x2C534\n-322\x2C571\x2C750\n-466\x2C-666\x2C-811\n-429\x2C-592\x2C574\n-355\x2C545\x2C-477\n703\x2C-491\x2C-529\n-328\x2C-685\x2C520\n413\x2C935\x2C-424\n-391\x2C539\x2C-444\n586\x2C-435\x2C557\n-364\x2C-763\x2C-893\n807\x2C-499\x2C-711\n755\x2C-354\x2C-619\n553\x2C889\x2C-390\n\n--- scanner 2 ---\n649\x2C640\x2C665\n682\x2C-795\x2C504\n-784\x2C533\x2C-524\n-644\x2C584\x2C-595\n-588\x2C-843\x2C648\n-30\x2C6\x2C44\n-674\x2C560\x2C763\n500\x2C723\x2C-460\n609\x2C671\x2C-379\n-555\x2C-800\x2C653\n-675\x2C-892\x2C-343\n697\x2C-426\x2C-610\n578\x2C704\x2C681\n493\x2C664\x2C-388\n-671\x2C-858\x2C530\n-667\x2C343\x2C800\n571\x2C-461\x2C-707\n-138\x2C-166\x2C112\n-889\x2C563\x2C-600\n646\x2C-828\x2C498\n640\x2C759\x2C510\n-630\x2C509\x2C768\n-681\x2C-892\x2C-333\n673\x2C-379\x2C-804\n-742\x2C-814\x2C-386\n577\x2C-820\x2C562\n\n--- scanner 3 ---\n-589\x2C542\x2C597\n605\x2C-692\x2C669\n-500\x2C565\x2C-823\n-660\x2C373\x2C557\n-458\x2C-679\x2C-417\n-488\x2C449\x2C543\n-626\x2C468\x2C-788\n338\x2C-750\x2C-386\n528\x2C-832\x2C-391\n562\x2C-778\x2C733\n-938\x2C-730\x2C414\n543\x2C643\x2C-506\n-524\x2C371\x2C-870\n407\x2C773\x2C750\n-104\x2C29\x2C83\n378\x2C-903\x2C-323\n-778\x2C-728\x2C485\n426\x2C699\x2C580\n-438\x2C-605\x2C-362\n-469\x2C-447\x2C-387\n509\x2C732\x2C623\n647\x2C635\x2C-688\n-868\x2C-804\x2C481\n614\x2C-800\x2C639\n595\x2C780\x2C-596\n\n--- scanner 4 ---\n727\x2C592\x2C562\n-293\x2C-554\x2C779\n441\x2C611\x2C-461\n-714\x2C465\x2C-776\n-743\x2C427\x2C-804\n-660\x2C-479\x2C-426\n832\x2C-632\x2C460\n927\x2C-485\x2C-438\n408\x2C393\x2C-506\n466\x2C436\x2C-512\n110\x2C16\x2C151\n-258\x2C-428\x2C682\n-393\x2C719\x2C612\n-211\x2C-452\x2C876\n808\x2C-476\x2C-593\n-575\x2C615\x2C604\n-485\x2C667\x2C467\n-680\x2C325\x2C-822\n-627\x2C-443\x2C-432\n872\x2C-547\x2C-609\n833\x2C512\x2C582\n807\x2C604\x2C487\n839\x2C-516\x2C451\n891\x2C-625\x2C532\n-652\x2C-548\x2C-490\n30\x2C-46\x2C-14", Scope = Private
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
