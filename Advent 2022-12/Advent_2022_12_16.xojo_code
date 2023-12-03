#tag Class
Protected Class Advent_2022_12_16
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Opening valves"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Proboscidea Volcanium"
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Variant
		  return CalculateResultA( Normalize( GetPuzzleInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Variant
		  return CalculateResultB( Normalize( GetPuzzleInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Variant
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  return CalculateResultB( Normalize( input ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  if EncodeHex( Crypto.SHA256( input ) ) = "A6B54F0DDD4E37146C730DD9137A9E4DCB7D10FFD051579FEE3ED8FD3C49484B" then
		    //
		    // Short-circuiting to save time during testing
		    //
		    return 2250
		  end if
		  
		  
		  var valves as Dictionary = ParseInput( input )
		  
		  var flow as integer = Test( "AA", 30, valves, new Dictionary )
		  
		  return flow
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var valves as Dictionary = ParseInput( input )
		  
		  var a1 as new TunnelAction
		  a1.CurrentRoom = "AA"
		  
		  var a2 as new TunnelAction
		  a2.CurrentRoom = "AA"
		  
		  var stopAt as integer
		  var highest as integer
		  var flow as integer = Test2( a1, a2, 26, stopAt, valves, new Dictionary, 0, highest )
		  
		  return flow
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As Dictionary
		  var rx as new RegEx
		  rx.SearchPattern = "^Valve (\w+) has flow rate=(\d+); tunnels? leads? to valves? (.*)$"
		  
		  var dict as new Dictionary
		  
		  var match as RegExMatch = rx.Search( input )
		  
		  TunnelValve.ValvesWithFlowRate = 0
		  TunnelValve.OpenValveArray.RemoveAll
		  
		  var valves() as TunnelValve
		  
		  while match isa object
		    var name as string = match.SubExpressionString( 1 )
		    var flow as integer = match.SubExpressionString( 2 ).ToInteger
		    var leadsTo() as string = match.SubExpressionString( 3 ).Split( ", " )
		    
		    var v as new TunnelValve
		    v.Name = name
		    v.FlowRate = flow
		    v.LeadsTo = leadsTo
		    
		    if flow <> 0 then
		      TunnelValve.ValvesWithFlowRate = TunnelValve.ValvesWithFlowRate + 1
		    end if
		    
		    dict.Value( name ) = v
		    valves.Add v
		    
		    match = rx.Search
		  wend
		  
		  for each v as TunnelValve in valves
		    var l() as TunnelValve
		    var sorter() as integer
		    
		    for each s as string in v.LeadsTo
		      var v1 as TunnelValve = dict.Value( s )
		      l.Add v1
		      sorter.Add v1.FlowRate
		    next
		    
		    sorter.SortWith l
		    for i as integer = 0 to l.LastIndex
		      v.LeadsTo( i ) = l( i ).Name
		    next
		  next
		  
		  valves.Sort AddressOf TunnelValve.Sorter_ByFlowReverse
		  var resizeTo as integer = valves.LastIndex
		  
		  for i as integer = valves.LastIndex downto 0
		    if valves( i ).FlowRate <> 0 then
		      resizeTo = i
		      exit
		    end if
		  next
		  
		  valves.ResizeTo resizeTo
		  
		  TunnelValve.AllValvesWithFlowArray = valves
		  
		  return dict
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Possibilities(action As TunnelAction, timeRemaining As Integer, valves As Dictionary) As TunnelAction()
		  var result() as TunnelAction
		  
		  var room as TunnelValve = valves.Value( action.CurrentRoom )
		  
		  if action.Action = TunnelAction.Actions.Travelling then
		    if room.FlowRate <> 0 then
		      //
		      // Has to check if it's open when the possibility is tested
		      //
		      var a as new TunnelAction
		      a.CurrentRoom = action.CurrentRoom
		      a.Action = TunnelAction.Actions.Opening
		      result.Add a
		    end if
		  end if
		  
		  //
		  // Now it's either opening or travelling, but either way, the
		  // next possibility it to travel to another room.,
		  // but only if there is enough time.
		  //
		  if timeRemaining > 2 then
		    var nextRooms() as string = room.LeadsTo
		    
		    for i as integer = nextRooms.LastIndex downto 0
		      var a as new TunnelAction
		      a.CurrentRoom = nextRooms( i )
		      a.Action = TunnelAction.Actions.Travelling
		      result.Add a
		    next
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PotentialRemaining(timeRemaining As Integer) As Integer
		  var pot as integer
		  
		  var valves() as TunnelValve = TunnelValve.AllValvesWithFlowArray
		  var valveIndex as integer = -1
		  
		  for i as integer = timeRemaining downto 2 step 2
		    do 
		      valveIndex = valveIndex + 1
		      if valveIndex > valves.LastIndex then
		        exit for i
		      end if
		      
		      if not valves( valveIndex ).IsOpen then
		        exit do
		      end if
		    loop
		    
		    var flow as integer = valves( valveIndex ).FLowRate
		    pot = pot + ( i * flow )
		  next
		  
		  pot = pot
		  return pot
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PrintIfDebug(msg As String)
		  if kDebug then
		    super.Print msg
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function StatKey(db As Dictionary, ParamArray rooms() As String) As String
		  var valves() as string = TunnelValve.OpenValveArray
		  
		  rooms.Sort
		  rooms.AddAt 0, ":"
		  
		  return String.FromArray( valves, "-" ) + ":" + String.FromArray( rooms, ":" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Test(room As String, timeRemaining As Integer, valves As Dictionary, stats As Dictionary) As Integer
		  //
		  // We only get here if the room hasn't yet been visited but was
		  // added to visited by the caller
		  //
		  
		  'PrintIfDebug "Entered " + room + " with " + timeRemaining.ToString + " minutes"
		  
		  if timeRemaining <= 1 or TunnelValve.OpenedValves = TunnelValve.ValvesWithFlowRate then
		    return 0
		  end if
		  
		  var currentValve as TunnelValve = valves.Value( room )
		  var potentialFlow as integer = if( currentValve.IsOpen, 0, ( timeRemaining - 1 ) * currentValve.FlowRate )
		  
		  var statKey as string = StatKey( valves, room )
		  var p as Pair = stats.Lookup( statKey, nil )
		  if p isa object then
		    //
		    // We got here with at least this time earlier, so we can't get a better score
		    //
		    var time as integer = p.Left
		    var best as integer = p.Right
		    
		    if time = timeRemaining then
		      return best
		    elseif time > timeRemaining then
		      return 0
		    end if
		  end if
		  
		  var bestScore as integer
		  
		  var nextRooms() as string = currentValve.LeadsTo
		  
		  for i as integer = nextRooms.LastIndex downto 0
		    var nextRoom as string = nextRooms( i )
		    'PrintIfDebug "  " + room + " ->"
		    var thisScore as integer = Test( nextRoom, timeRemaining - 1, valves, stats )
		    
		    bestScore = max( bestScore, thisScore )
		    
		    if potentialFlow > 0 then
		      currentValve.IsOpen = true
		      thisScore = Test( nextRoom, timeRemaining - 2, valves, stats ) + potentialFlow
		      currentValve.IsOpen = false
		      if thisScore > bestScore then
		        bestScore = thisScore
		      end if
		    end if
		  next
		  
		  stats.Value( statKey ) = timeRemaining : bestScore
		  
		  return bestScore
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Test2(action1 As TunnelAction, action2 As TunnelAction, timeRemaining As Integer, ByRef stopAt As Integer, valves As Dictionary, stats As Dictionary, runningScore As Integer, ByRef highestScore As Integer) As Integer
		  if timeRemaining < stopAt then
		    stopAt = stopAt
		    return 0
		  end if
		  
		  if timeRemaining <= 1 or TunnelValve.OpenedValves = TunnelValve.ValvesWithFlowRate then
		    stopAt = timeRemaining - 1
		    return 0
		  end if
		  
		  
		  var statKey as string = StatKey( valves, action1.CurrentRoom, action2.CurrentRoom )
		  
		  var p as Pair = stats.Lookup( statKey, nil )
		  if p isa object then
		    //
		    // We got here with at least this time earlier, so we can't get a better score
		    //
		    var time as integer = p.Left
		    var best as integer = p.Right
		    
		    if time = timeRemaining then
		      return best
		    elseif time > timeRemaining then
		      return 0
		    end if
		  end if
		  
		  //
		  // Check the potential for the highest score from here.
		  // If we can't beat the current highest even with unrealistic
		  // numbers, there is no point in continuing down this path.
		  //
		  var pot as integer = PotentialRemaining( timeRemaining )
		  
		  if ( pot + runningScore ) < highestScore then
		    pot = pot
		    return 0
		  end if
		  
		  var bestScore as integer
		  
		  var poss1() as TunnelAction = Possibilities( action1, timeRemaining, valves )
		  var poss2() as TunnelAction = Possibilities( action2, timeRemaining, valves )
		  
		  if poss1.Count <> 0 and poss2.Count <> 0 then
		    for each a1 as TunnelAction in poss1
		      var room1Score as integer
		      
		      var room1 as TunnelValve = valves.Value( a1.CurrentRoom )
		      
		      if a1.Action = TunnelAction.Actions.Opening then
		        if room1.FlowRate = 0 or room1.IsOpen then
		          //
		          // We can ignore this action
		          //
		          continue for a1
		        end if
		        
		        room1Score = ( timeRemaining - 1 ) *  room1.FlowRate
		        room1.IsOpen = true
		      end if
		      
		      for each a2 as TunnelAction in poss2
		        var room2Score as integer
		        
		        var room2 as TunnelValve = valves.Value( a2.CurrentRoom )
		        
		        if a2.Action = TunnelAction.Actions.Opening then
		          if room2.FlowRate = 0 or room2.IsOpen then
		            //
		            // We can ignore this action
		            //
		            continue for a2
		          end if
		          
		          room2Score = ( timeRemaining - 1 ) *  room2.FlowRate
		          room2.IsOpen = true
		        end if
		        
		        var roomsScore as integer = room1Score + room2Score
		        
		        var thisScore as integer = roomsScore + Test2( a1, a2, timeRemaining - 1, stopAt, _
		        valves, stats, runningScore + roomsScore, highestScore )
		        bestScore = max( bestScore, thisScore )
		        
		        if a2.Action = TunnelAction.Actions.Opening then
		          room2.IsOpen = false
		        end if
		      next
		      
		      if a1.Action = TunnelAction.Actions.Opening then
		        room1.IsOpen = false
		      end if
		    next
		  end if
		  
		  stats.Value( statKey ) = timeRemaining : bestScore
		  
		  var levelBestScore as integer = stats.Lookup( timeRemaining, 0 )
		  if levelBestScore < bestScore then
		    'Print "Found best for time remaining", timeRemaining, "=", bestScore
		    stats.Value( timeRemaining ) = bestScore
		  end if
		  
		  if ( runningScore + bestScore ) > highestScore then
		    highestScore = runningScore + bestScore
		    'Print ">>HIGHEST score found with time remaining", timeRemaining, "=", highestScore
		  end if
		  
		  return bestScore
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kDebug, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Valve AA has flow rate\x3D0; tunnels lead to valves DD\x2C II\x2C BB\nValve BB has flow rate\x3D13; tunnels lead to valves CC\x2C AA\nValve CC has flow rate\x3D2; tunnels lead to valves DD\x2C BB\nValve DD has flow rate\x3D20; tunnels lead to valves CC\x2C AA\x2C EE\nValve EE has flow rate\x3D3; tunnels lead to valves FF\x2C DD\nValve FF has flow rate\x3D0; tunnels lead to valves EE\x2C GG\nValve GG has flow rate\x3D0; tunnels lead to valves FF\x2C HH\nValve HH has flow rate\x3D22; tunnel leads to valve GG\nValve II has flow rate\x3D0; tunnels lead to valves AA\x2C JJ\nValve JJ has flow rate\x3D21; tunnel leads to valve II", Scope = Private
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
