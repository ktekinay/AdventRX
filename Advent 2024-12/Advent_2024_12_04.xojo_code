#tag Class
Protected Class Advent_2024_12_04
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Find occurrences of words in a grid"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Ceres Search"
		  
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
		Private Shared Function AllDirectionsXmas(grid(, ) As String, row As Integer, lastRowIndex As Integer, col As Integer, lastColIndex As Integer) As Integer
		  var count as integer
		  
		  // Horizontal right
		  if col+3 <= lastColIndex and _
		    grid( row, col+1 ) = "M" and grid( row, col+2 ) = "A" and grid( row, col+3 ) = "S" then
		    count = count + 1
		  end if
		  
		  // Horizontal left
		  if col >= 3 and _
		    grid( row, col-1 ) = "M" and grid( row, col-2 ) = "A" and grid( row, col-3 ) = "S" then
		    count = count + 1
		  end if
		  
		  // Vertical down
		  if row+3 <= lastRowIndex and _
		    grid( row+1, col ) = "M" and grid( row+2, col ) = "A" and grid( row+3, col ) = "S" then
		    count = count + 1
		  end if
		  
		  // Vertical up
		  if row >= 3 and _
		    grid( row-1, col ) = "M" and grid( row-2, col ) = "A" and grid( row-3, col ) = "S" then
		    count = count + 1
		  end if
		  
		  // Diagonal, down, right
		  if col+3 <= lastColIndex and row+3 <= lastRowIndex and _
		    grid( row+1, col+1 ) = "M" and grid( row+2, col+2 ) = "A" and grid( row+3, col+3 ) = "S" then
		    count = count + 1
		  end if
		  
		  // Diagonal, down, left
		  if col >= 3 and row+3 <= lastRowIndex and _
		    grid( row+1, col-1 ) = "M" and grid( row+2, col-2 ) = "A" and grid( row+3, col-3 ) = "S" then
		    count = count + 1
		  end if
		  
		  // Diagonal, up, right
		  if col+3 <= lastColIndex and row >= 3 and _
		    grid( row-1, col+1 ) = "M" and grid( row-2, col+2 ) = "A" and grid( row-3, col+3 ) = "S" then
		    count = count + 1
		  end if
		  
		  // Diagonal, up, left
		  if col >= 3 and row >= 3 and _
		    grid( row-1, col-1 ) = "M" and grid( row-2, col-2 ) = "A" and grid( row-3, col-3 ) = "S" then
		    count = count + 1
		  end if
		  
		  
		  return count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  var count as integer
		  
		  var grid( -1, -1 ) as string = ToStringGrid( input )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      var char as string = grid( row, col )
		      
		      if char = "X" then
		        count = count + AllDirectionsXmas( grid, row, lastRowIndex, col, lastColIndex )
		      end if
		    next
		  next
		  
		  return count : if( IsTest, 18, 2547 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var count as integer
		  
		  var grid( -1, -1 ) as string = ToStringGrid( input )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      count = count + CheckForMas( grid, row, lastRowIndex, col, lastColIndex )
		    next
		  next
		  
		  return count : if( IsTest, 9, 1939 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CheckForMas(grid(, ) As String, row As Integer, lastRowIndex As Integer, col As Integer, lastColIndex As Integer) As Integer
		  var thisChar as string = grid( row, col )
		  var oppChar as string
		  
		  if thisChar = "M" then
		    oppChar = "S"
		  elseif thisChar = "S" then
		    oppChar = "M"
		  else
		    return 0
		  end if
		  
		  if col+2 <= lastColIndex and row+2 <= lastRowIndex and _
		    grid( row+1, col+1 ) = "A" and grid( row+2, col+2 ) = oppChar and ( _
		    ( grid( row, col+2 ) = "M" and grid( row+2, col ) = "S" ) or _
		    ( grid( row, col+2 ) = "S" and grid( row+2, col ) = "M" ) _
		    ) then
		    return 1
		  end if
		  
		  return 0
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"MMMSXXMASM\nMSAMXMSMSA\nAMXSXMAAMM\nMSAMASMSMX\nXMASAMXAMM\nXXAMMXXAMA\nSMSMSASXSS\nSAXAMASAAA\nMAMMMXMMMM\nMXMXAXMASX", Scope = Private
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
