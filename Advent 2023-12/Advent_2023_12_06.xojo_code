#tag Class
Protected Class Advent_2023_12_06
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Boat races"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Wait For It"
		  
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
		    winners( raceIndex ) = CalcWinners( time, dist )
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
		  
		  var winners as integer = CalcWinners( time, dist )
		  return winners : if( IsTest, 71503, 41513103 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalcWinners(time As Integer, dist As Integer) As Integer
		  var startHold as integer
		  var endHold as integer
		  #if DebugBuild
		    var checked as integer
		  #endif
		  
		  var firstWinningHold as integer 
		  
		  startHold = 1
		  endHold = time - 1
		  
		  while startHold <= endHold
		    #if DebugBuild
		      checked = checked + 1
		    #endif
		    
		    var hold as integer = ( endHold - startHold ) \ 2 + startHold
		    
		    var remaining as integer = time - hold
		    var travelled as integer = hold * remaining
		    
		    if travelled > dist then
		      firstWinningHold = hold
		      endHold = hold - 1
		    else
		      startHold = hold + 1
		    end if
		  wend
		  
		  var lastWinningHold as integer
		  
		  startHold = firstWinningHold + 1
		  endHold = time - 1
		  
		  while startHold <= endHold
		    #if DebugBuild
		      checked = checked + 1
		    #endif
		    
		    var hold as integer = ( endHold - startHold ) \ 2 + startHold
		    
		    var remaining as integer = time - hold
		    var travelled as integer = hold * remaining
		    
		    if travelled > dist then
		      lastWinningHold = hold
		      startHold = hold + 1
		    else
		      endHold = hold - 1
		    end if
		  wend
		  
		  #if DebugBuild
		    if not IsTest then
		      System.DebugLog "Checked: " + checked.ToString
		    end if
		  #endif
		  
		  return lastWinningHold - firstWinningHold + 1
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
