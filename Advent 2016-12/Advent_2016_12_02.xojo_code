#tag Class
Protected Class Advent_2016_12_02
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Figure out the bathroom code"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Bathroom Security"
		  
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
		  var lines() as string = input.Split( EndOfLine )
		  
		  var keypad( 2, 2 ) as integer
		  
		  var key as integer = 1
		  
		  for row as integer = 0 to 2
		    for col as integer = 0 to 2
		      keypad( row, col ) = key
		      key = key + 1
		    next
		  next
		  
		  var code as integer
		  var row as integer = 1
		  var col as integer = 1
		  
		  for each line as string in lines
		    var directions() as string = line.Split( "" )
		    
		    for each direction as string in directions
		      select case direction
		      case "U"
		        if row > 0 then
		          row = row - 1
		        end if
		      case "R"
		        if col < 2 then
		          col = col + 1
		        end if
		      case "D"
		        if row < 2 then
		          row = row + 1
		        end if
		      case "L"
		        if col > 0 then
		          col = col - 1
		        end if
		      end select
		    next
		    
		    code = code * 10 + keypad( row, col )
		  next
		  
		  
		  return code : if( IsTest, 1985, 47978 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var lines() as string = input.Split( EndOfLine )
		  
		  var keypad( 4, 4 ) as string
		  
		  keypad( 0, 2 ) = "1"
		  keypad( 1, 1 ) = "2"
		  keypad( 1, 2 ) = "3"
		  keypad( 1, 3 ) = "4"
		  keypad( 2, 0 ) = "5"
		  keypad( 2, 1 ) = "6"
		  keypad( 2, 2 ) = "7"
		  keypad( 2, 3 ) = "8"
		  keypad( 2, 4 ) = "9"
		  keypad( 3, 1 ) = "A"
		  keypad( 3, 2 ) = "B"
		  keypad( 3, 3 ) = "C"
		  keypad( 4, 2 ) = "D"
		  
		  var code as string
		  var row as integer = 2
		  var col as integer = 0
		  
		  for each line as string in lines
		    var directions() as string = line.Split( "" )
		    
		    for each direction as string in directions
		      select case direction
		      case "U"
		        if row > 0 and keypad( row - 1, col ) <> "" then
		          row = row - 1
		        end if
		      case "R"
		        if col < 4 and keypad( row, col + 1 ) <> "" then
		          col = col + 1
		        end if
		      case "D"
		        if row < 4 and keypad( row + 1, col ) <> "" then
		          row = row + 1
		        end if
		      case "L"
		        if col > 0 and keypad( row, col - 1 ) <>  ""then
		          col = col - 1
		        end if
		      end select
		    next
		    
		    code = code + keypad( row, col )
		  next
		  
		  
		  return code : if( IsTest, "5DB3", "659AD" )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"ULL\nRRDDD\nLURDL\nUUUUD", Scope = Private
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
