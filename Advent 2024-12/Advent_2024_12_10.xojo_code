#tag Class
Protected Class Advent_2024_12_10
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Unknown"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Hoof It"
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
		  var grid( -1, -1 ) as integer = ToIntegerGrid( Normalize( input ) )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var visited as new Dictionary
		  
		  var result as integer
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      visited.RemoveAll
		      result = result + Evaluate( grid, row, col, 0, visited )
		    next
		  next
		  
		  return result : if( IsTest, 36, 517 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var grid( -1, -1 ) as integer = ToIntegerGrid( Normalize( input ) )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var visited as new Dictionary
		  
		  var result as integer
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      result = result + Evaluate2( grid, row, col, 0, visited )
		    next
		  next
		  
		  return result : if( IsTest, 81, 1116 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Evaluate(grid(, ) As Integer, row As Integer, col As Integer, target As Integer, visited As Dictionary) As Integer
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  if row < 0 or row > lastRowIndex or col < 0 or col > lastColIndex then
		    return 0
		  end if
		  
		  var value as integer = grid( row, col )
		  
		  if value <> target then
		    return 0
		  end if
		  
		  var key as integer = row * ( lastColIndex + 1 ) + col
		  if visited.HasKey( key ) then
		    return 0
		  end if
		  
		  if value = 9 then
		    visited.Value( key ) = 1
		    return 1
		  end if
		  
		  var result as integer = _
		  Evaluate( grid, row + 1, col, target + 1, visited ) + _
		  Evaluate( grid, row - 1, col, target + 1, visited ) + _
		  Evaluate( grid, row, col + 1, target + 1, visited ) + _
		  Evaluate( grid, row, col - 1, target + 1, visited )
		  
		  visited.Value( key ) = result
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Evaluate2(grid(, ) As Integer, row As Integer, col As Integer, target As Integer, visited As Dictionary) As Integer
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  if row < 0 or row > lastRowIndex or col < 0 or col > lastColIndex then
		    return 0
		  end if
		  
		  var value as integer = grid( row, col )
		  
		  if value <> target then
		    return 0
		  end if
		  
		  if value = 9 then
		    return 1
		  end if
		  
		  var key as integer = row * ( lastColIndex + 1 ) + col
		  
		  var result as integer = visited.Lookup( key, -1 )
		  
		  if result <> -1 then
		    return result
		  end if
		  
		  result = _
		  Evaluate2( grid, row + 1, col, target + 1, visited ) + _
		  Evaluate2( grid, row - 1, col, target + 1, visited ) + _
		  Evaluate2( grid, row, col + 1, target + 1, visited ) + _
		  Evaluate2( grid, row, col - 1, target + 1, visited )
		  
		  visited.Value( key ) = result
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"89010123\n78121874\n87430965\n96549874\n45678903\n32019012\n01329801\n10456732", Scope = Private
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
