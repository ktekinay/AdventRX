#tag Class
Protected Class Advent_2023_12_11
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
		  var grid as ObjectGrid = ObjectGrid.FromStringGrid( ToStringGrid( input ) )
		  NullBlanks grid
		  
		  Expand grid
		  
		  var galaxies() as GridMember
		  
		  for each gm as GridMember in grid
		    if gm is nil then
		      continue
		    end if
		    
		    galaxies.Add gm
		  next
		  
		  var total as integer
		  
		  for outer as integer = 0 to galaxies.LastIndex - 1
		    var g1 as GridMember = galaxies( outer )
		    for inner as integer = outer + 1 to galaxies.LastIndex
		      var g2 as GridMember = galaxies( inner )
		      var steps as integer = M_Path.ManhattanDistance( g1.Row, g1.Column, g2.Row, g2.Column )
		      total = total + steps
		    next
		  next
		  
		  'if IsTest then
		  'print grid
		  'end if
		  
		  return total : if( IsTest, 374, 0 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  
		  
		  
		  return 0 : if( IsTest, 0, 0 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Expand(grid As ObjectGrid)
		  var blankRows() as integer
		  
		  for row as integer = 0 to grid.LastRowIndex
		    for col as integer = 0 to grid.LastColIndex
		      if grid( row, col ) isa object then
		        continue for row
		      end if
		    next
		    blankRows.Add row
		  next
		  
		  var blankCols() as integer
		  
		  for col as integer = 0 to grid.LastColIndex
		    for row as integer = 0 to grid.LastRowIndex
		      if grid( row, col ) isa object then
		        continue for col
		      end if
		    next
		    blankCols.Add col
		  next
		  
		  for i as integer = blankRows.LastIndex downto 0
		    var row as integer = blankRows( i )
		    grid.InsertRowAt row
		  next
		  
		  for i as integer = blankCols.LastIndex downto 0
		    var col as integer = blankCols( i )
		    grid.InsertColumnAt col
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NullBlanks(grid As ObjectGrid)
		  for each gm as GridMember in grid
		    if gm.Value = "." then
		      grid( gm.Row, gm.Column ) = nil
		    end if
		  next
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"...#......\n.......#..\n#.........\n..........\n......#...\n.#........\n.........#\n..........\n.......#..\n#...#.....", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2023
	#tag EndUsing


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
