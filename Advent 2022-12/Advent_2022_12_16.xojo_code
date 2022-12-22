#tag Class
Protected Class Advent_2022_12_16
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
		  var valves as Dictionary = ParseInput( input )
		  
		  var flow as integer = Test( "AA", 30, valves )
		  
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
		  
		  var flow as integer = Test2( a1, a2, 30, valves )
		  
		  return flow
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function OpenValves(db As Dictionary) As String()
		  var valves() as string
		  
		  for each valve as TunnelValve in db.Values
		    if valve.FlowRate <> 0 and valve.IsOpen then
		      valves.Add valve.Name
		    end if
		  next
		  
		  valves.Sort
		  
		  return valves
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As Dictionary
		  var rx as new RegEx
		  rx.SearchPattern = "^Valve (\w+) has flow rate=(\d+); tunnels? leads? to valves? (.*)$"
		  
		  var dict as new Dictionary
		  
		  var match as RegExMatch = rx.Search( input )
		  
		  TunnelValve.ValvesWithFlowRate = 0
		  
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
		    
		    match = rx.Search
		  wend
		  
		  return dict
		  
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
		Private Function StatKey(db As Dictionary) As String
		  var valves() as string = OpenValves( db )
		  return String.FromArray( valves, "-" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Test(room As String, timeRemaining As Integer, db As Dictionary) As Integer
		  //
		  // We only get here if the room hasn't yet been visited but was
		  // added to visited by the caller
		  //
		  
		  'PrintIfDebug "Entered " + room + " with " + timeRemaining.ToString + " minutes"
		  
		  if timeRemaining <= 1 or TunnelValve.OpenedValves = TunnelValve.ValvesWithFlowRate then
		    return 0
		  end if
		  
		  var currentValve as TunnelValve = db.Value( room )
		  var potentialFlow as integer = if( currentValve.IsOpen, 0, ( timeRemaining - 1 ) * currentValve.FlowRate )
		  
		  var statKey as string = StatKey( db )
		  var p as Pair = currentValve.Stats.Lookup( statKey, nil )
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
		  
		  for each nextRoom as string in currentValve.LeadsTo
		    'PrintIfDebug "  " + room + " ->"
		    var thisScore as integer = Test( nextRoom, timeRemaining - 1, db )
		    
		    bestScore = max( bestScore, thisScore )
		    
		    if potentialFlow > 0 then
		      currentValve.IsOpen = true
		      TunnelValve.OpenedValves = TunnelValve.OpenedValves + 1
		      thisScore = Test( nextRoom, timeRemaining - 2, db ) + potentialFlow
		      currentValve.IsOpen = false
		      TunnelValve.OpenedValves = TunnelValve.OpenedValves - 1
		      bestScore = max( bestScore, thisScore )
		    end if
		  next
		  
		  currentValve.Stats.Value( statKey ) = timeRemaining : bestScore
		  
		  return bestScore
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Test2(action1 As TunnelAction, action2 As TunnelAction, timeRemaining As Integer, db As Dictionary) As Integer
		  'if timeRemaining <= 1 or TunnelValve.OpenedValves = TunnelValve.ValvesWithFlowRate then
		  'return 0
		  'end if
		  '
		  'var room1 as TunnelValve = db.Value( action1.CurrentRoom )
		  'var statKey1 as string = StatKey( db )
		  'if room1 
		  'var room2 as TunnelValve = db.Value( action2.CurrentRoom )
		  '
		  'var nextA1 as new TunnelAction
		  'var nextA2 as new TunnelAction
		  '
		  'if action1.Action = TunnelAction.Actions.Travelling then
		  '
		  'var bestScore as integer
		  '
		  'select case 
		  'return bestScore
		  
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
