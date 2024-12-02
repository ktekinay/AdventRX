#tag Class
Protected Class Advent_2016_12_03
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Determine which sets of numbers cannot be triangles"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Squares With Three Sides"
		  
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
		  var v1() as integer
		  var v2() as integer
		  var v3() as integer
		  
		  ToArrays input, v1, v2, v3
		  
		  var count as integer
		  
		  for i as integer = 0 to v1.LastIndex
		    count = count + CanBeTriangle( array( v1( i ), v2( i ), v3( i ) ) )
		  next
		  
		  return count : if( IsTest, 3, 983 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var v1() as integer
		  var v2() as integer
		  var v3() as integer
		  
		  ToArrays input, v1, v2, v3
		  
		  var count as integer
		  
		  for i as integer = 0 to v1.LastIndex step 3
		    count = count + CanBeTriangle( array( v1( i ), v1( i + 1 ), v1( i + 2 ) ) )
		    count = count + CanBeTriangle( array( v2( i ), v2( i + 1 ), v2( i + 2 ) ) )
		    count = count + CanBeTriangle( array( v3( i ), v3( i + 1 ), v3( i + 2 ) ) )
		  next
		  
		  return count : if( IsTest, 6, 1836 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CanBeTriangle(sides() As Integer) As Integer
		  sides.Sort
		  
		  if ( sides( 0 ) + sides( 1 ) ) > sides( 2 ) then
		    return 1
		  else
		    return 0
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ToArrays(input As String, v1() As Integer, v2() As Integer, v3() As Integer)
		  var lines() as string = input.Squeeze.Trim.Split( EndOfLine )
		  
		  for each l as string in lines
		    var parts() as string = l.Trim.Split( " " )
		    v1.Add parts( 0 ).ToInteger
		    v2.Add parts( 1 ).ToInteger
		    v3.Add parts( 2 ).ToInteger
		  next
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"101 301 501\n102 302 502\n103 303 503\n201 401 601\n202 402 602\n203 403 603", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


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
