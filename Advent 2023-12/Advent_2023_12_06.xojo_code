#tag Class
Protected Class Advent_2023_12_06
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
		  var lines() as string = ToStringArray( input.Squeeze )
		  
		  for i as integer = 0 to lines.LastIndex
		    lines( i ) = lines( i ).NthField( ": ", 2 )
		  next
		  
		  var timeStrings() as string = lines( 0 ).Split( " " )
		  var times() as integer
		  for each t as string in timeStrings
		    times.Add t.ToInteger
		  next
		  
		  var distStrings() as string = lines( 1 ).Split( " " )
		  var dists() as integer 
		  for each d as string in distStrings
		    dists.Add d.ToInteger
		  next
		  
		  var winners() as integer
		  winners.ResizeTo times.LastIndex
		  
		  for raceIndex as integer = 0 to times.LastIndex
		    var time as integer = times( raceIndex )
		    var dist as integer = dists( raceIndex )
		    
		    for hold as integer = 1 to time - 1
		      var speed as integer = hold
		      var remaining as integer = time - hold
		      var travelled as integer = remaining * speed
		      
		      if travelled > dist then
		        winners( raceIndex ) = winners( raceIndex ) + 1
		      elseif winners( raceIndex ) <> 0 then
		        exit for hold
		      end if
		    next
		  next
		  
		  var result as integer = MultiplyArray( winners, true )
		  return result : if( IsTest, 288, 1159152 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var lines() as string = ToStringArray( input.Squeeze )
		  
		  for i as integer = 0 to lines.LastIndex
		    lines( i ) = lines( i ).NthField( ": ", 2 )
		  next
		  
		  var time as integer = lines( 0 ).ReplaceAll( " ", "" ).ToInteger
		  
		  var dist as integer = lines( 1 ).ReplaceAll( " ", "" ).ToInteger
		  
		  var winners as integer
		  
		  for hold as integer = 1 to time - 1
		    var speed as integer = hold
		    var remaining as integer = time - hold
		    var travelled as integer = remaining * speed
		    
		    if travelled > dist then
		      winners = winners + 1
		    elseif winners <> 0 then
		      exit for hold
		    end if
		  next
		  
		  return winners : if( IsTest, 71503, 41513103 )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Time:      7  15   30\nDistance:  9  40  200", Scope = Private
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
