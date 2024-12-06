#tag Class
Protected Class Advent_2015_12_14
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Reindeer rates of travel"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Reindeer Olympics"
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
		Private Function CalculateResultA(input As String) As Variant
		  var secs as integer = if( IsTest, 1000, 2503 )
		  
		  var maxDistance as integer
		  
		  var rx as new RegEx
		  rx.SearchPattern = "(\d+)\D+(\d+)\D+(\d+)"
		  
		  var match as RegExMatch = rx.Search( input )
		  
		  while match isa object
		    var ratePerSecond as integer = match.SubExpressionString( 1 ).ToInteger
		    var flyTime as integer = match.SubExpressionString( 2 ).ToInteger
		    var restTime as integer = match.SubExpressionString( 3 ).ToInteger
		    
		    var blockTime as integer = flyTime + restTime
		    var distanceOverBlock as integer = flyTime * ratePerSecond
		    
		    var blocks as integer = secs / blockTime
		    var remainingSecs as integer = secs mod blockTime
		    
		    var distance as integer = blocks * distanceOverBlock
		    
		    if remainingSecs < flyTime then
		      distance = distance + ( remainingSecs * ratePerSecond )
		    else
		      distance = distance + ( flyTime * ratePerSecond )
		    end if
		    
		    maxDistance = max( maxDistance, distance )
		    
		    match = rx.Search
		  wend
		  
		  
		  return maxDistance : if( IsTest, 1120, 2696 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var secs as integer = if( IsTest, 1000, 2503 )
		  
		  var deers() as Reindeer
		  
		  var rx as new RegEx
		  rx.SearchPattern = "^(\w+)\D+(\d+)\D+(\d+)\D+(\d+)"
		  
		  var match as RegExMatch = rx.Search( input )
		  
		  while match isa object
		    var name as string = match.SubExpressionString( 1 )
		    var ratePerSecond as integer = match.SubExpressionString( 2 ).ToInteger
		    var flyTime as integer = match.SubExpressionString( 3 ).ToInteger
		    var restTime as integer = match.SubExpressionString( 4 ).ToInteger
		    
		    var deer as new Reindeer
		    deer.Name = name
		    deer.FlyTime = flyTime
		    deer.RestTime = restTime
		    deer.RatePerSecond = ratePerSecond
		    deer.RemainingFlyTime = flyTime
		    deer.RemainingRestTime = restTime
		    
		    deers.Add deer
		    
		    match = rx.Search
		  wend
		  
		  for sec as integer = 1 to secs
		    for each deer as Reindeer in deers
		      if deer.RemainingFlyTime = 0 and deer.RemainingRestTime = 0 then
		        deer.RemainingRestTime = deer.RestTime
		        deer.RemainingFlyTime = deer.FlyTime - 1
		        deer.DistanceTravelled = deer.DistanceTravelled + deer.RatePerSecond
		      elseif deer.RemainingFlyTime > 0 then
		        deer.RemainingFlyTime = deer.RemainingFlyTime - 1
		        deer.DistanceTravelled = deer.DistanceTravelled + deer.RatePerSecond
		      else
		        deer.RemainingRestTime = deer.RemainingRestTime - 1
		      end if
		    next
		    
		    var maxDistance as integer
		    for each deer as Reindeer in deers
		      maxDistance = max( maxDistance, deer.DistanceTravelled )
		    next
		    
		    for each deer as Reindeer in deers
		      if deer.DistanceTravelled = maxDistance then
		        deer.Points = deer.Points + 1
		      end if
		    next
		  next
		  
		  var maxPoints as integer
		  
		  for each deer as Reindeer in deers
		    maxPoints = max( maxPoints, deer.Points )
		  next
		  
		  return maxPoints : if( IsTest, 689, 1084 )
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Comet can fly 14 km/s for 10 seconds\x2C but then must rest for 127 seconds.\nDancer can fly 16 km/s for 11 seconds\x2C but then must rest for 162 seconds", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2015
	#tag EndUsing


	#tag ViewBehavior
		#tag ViewProperty
			Name="Type"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Cooperative"
				"1 - Preemptive"
			#tag EndEnumValues
		#tag EndViewProperty
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
