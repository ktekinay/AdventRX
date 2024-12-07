#tag Class
Protected Class Advent_2024_12_07
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Insert operators to test values"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Bridge Repair"
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
		  var rows() as string = Normalize( input ).Split( EndOfLine )
		  
		  var result as integer
		  
		  for each row as string in rows
		    var parts() as string = row.Split( " " )
		    var testValue as integer = parts( 0 ).TrimRight( ":" ).ToInteger
		    
		    parts.RemoveAt( 0 )
		    var values() as integer = ToIntegerArray( parts )
		    
		    if TestValues( values, 1, values( 0 ), testValue ) then
		      result = result + testValue
		    end if
		  next
		  
		  return result : if( IsTest, 3749, 1611660863222 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var rows() as string = Normalize( input ).Split( EndOfLine )
		  
		  var result as integer
		  
		  for each row as string in rows
		    var parts() as string = row.Split( " " )
		    var testValue as integer = parts( 0 ).TrimRight( ":" ).ToInteger
		    
		    parts.RemoveAt( 0 )
		    var values() as integer = ToIntegerArray( parts )
		    
		    if TestValues2( values, 1, values( 0 ), testValue ) then
		      result = result + testValue
		    end if
		  next
		  
		  return result : if( IsTest, 11387, 945341732469724 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function TestValues(values() As Integer, index As Integer, incoming As Integer, testValue As Integer) As Boolean
		  if index > values.LastIndex then
		    return incoming = testValue
		  end if
		  
		  return TestValues( values, index + 1, incoming + values( index ), testValue ) or _
		  TestValues( values, index + 1, incoming * values( index ), testValue )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function TestValues2(values() As Integer, index As Integer, incoming As Integer, testValue As Integer) As Boolean
		  if index > values.LastIndex then
		    return incoming = testValue
		  end if
		  
		  var thisValue as integer = values( index )
		  
		  if TestValues2( values, index + 1, incoming + thisValue, testValue ) or _
		    TestValues2( values, index + 1, incoming * thisValue, testValue ) then
		    return true
		  end if
		  
		  var exp as integer = log( thisValue ) / log( 10 ) + 1
		  var mult as integer = 10^exp
		  var shiftedIncoming as integer = incoming * mult
		  var sendToNext as integer = shiftedIncoming + thisValue
		  
		  return TestValues2( values, index + 1, sendToNext, testValue )
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"190: 10 19\n3267: 81 40 27\n83: 17 5\n156: 15 6\n7290: 6 8 6 15\n161011: 16 10 13\n192: 17 8 14\n21037: 9 7 18 13\n292: 11 6 16 20", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2024
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
