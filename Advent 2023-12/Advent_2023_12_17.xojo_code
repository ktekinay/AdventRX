#tag Class
Protected Class Advent_2023_12_17
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
		  BlockGridSquare.BestCost = 0.0
		  BlockGridSquare.IsReverse = false
		  
		  var total as integer
		  
		  var grid( -1, -1 ) as string = ToStringGrid( input )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var goal as new BlockGridSquare( lastRowIndex, lastColIndex, M_Path.Directions.North, nil )
		  goal.Grid = grid
		  
		  var start1 as new BlockGridSquare( 0, 0, M_Path.Directions.East, nil )
		  start1.Grid = grid
		  
		  var start2 as new BlockGridSquare( 0, 0, M_Path.Directions.South, nil )
		  start2.Grid = grid
		  
		  var bestTrail() as M_Path.MilestoneInterface
		  
		  for each start as BlockGridSquare in array( start1, start2 )
		    var thisTotal as integer
		    
		    var result as M_Path.Result = M_Path.FindPath( goal, start, false )
		    var trail() as M_Path.MilestoneInterface = result.Trail
		    
		    thisTotal = GetTotal( grid, trail, 1, trail.LastIndex )
		    
		    if total = 0 or thisTotal < total then
		      bestTrail = trail
		      total = thisTotal
		    end if
		  next
		  
		  'BlockGridSquare.IsReverse = true
		  '
		  'goal.Direction = M_Path.Directions.North
		  'var result as M_Path.Result = M_Path.FindPath( start1, goal, false )
		  'var thisTotal as integer = GetTotal( grid, result.Trail, 0, result.Trail.LastIndex - 1 )
		  'if thisTotal < total then
		  'total = thisTotal
		  'bestTrail = result.Trail
		  'end if
		  '
		  'goal.Direction = M_Path.Directions.West
		  'result = M_Path.FindPath( start2, goal, false )
		  'thisTotal = GetTotal( grid, result.Trail, 0, result.Trail.LastIndex - 1 )
		  'if thisTotal < total then
		  'total = thisTotal
		  'bestTrail = result.Trail
		  'end if
		  
		  BlockGridSquare.BestCost = total
		  
		  total = RecursiveSearch( grid, bestTrail, 0 )
		  
		  if IsTest then
		    PrintWithTrail grid, bestTrail
		  end if
		  
		  return total : if( IsTest, 102, 0 )
		  // TOO HIGH: 1483
		  // TOO HIGH: 1429
		  // TOO HIGH: 1008
		  // INCORRECT: 923
		  // INCORRECT: 975
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  
		  
		  
		  return 0 : if( IsTest, 0, 0 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function GetTotal(grid(, ) As String, trail() As M_Path.MilestoneInterface, startIndex As Integer, endIndex As Integer) As Integer
		  var total as integer
		  
		  for i as integer = startIndex to endIndex
		    var sq as BlockGridSquare = BlockGridSquare( trail( i ) )
		    
		    total = total + grid( sq.Row, sq.Column ).ToInteger
		  next
		  
		  return total
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PrintWithTrail(grid(, ) As String, trail() As M_Path.MilestoneInterface)
		  'for i as integer = 1 to trail.LastIndex
		  'var this as BlockGridMember = BlockGridMember( trail( i ) )
		  'var prev as BlockGridMember = BlockGridMember( trail( i - 1 ) )
		  '
		  'if this.Row = prev.Row then
		  'if this.Column > prev.Column then
		  'this.Value = ">"
		  'else
		  'this.Value = "<"
		  'end if
		  '
		  'else // this.Column = prev.Column
		  'if this.Row > prev.Row then
		  'this.Value = "v"
		  'else
		  'this.Value = "^"
		  'end if
		  '
		  'end if
		  'next
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var printGrid( -1, -1 ) as string
		  printGrid.ResizeTo lastRowIndex, lastColIndex
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      printGrid( row, col ) = grid( row, col )
		    next
		  next
		  
		  for each m as M_Path.MilestoneInterface in trail
		    var gm as BlockGridSquare = BlockGridSquare( m )
		    printGrid( gm.Row, gm.Column ) = gm.Direction.ToString
		  next
		  
		  Print printGrid
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RecursiveSearch(grid(, ) As String, trail() As M_Path.MilestoneInterface, index As Integer) As Integer
		  var lastIndex as integer = trail.LastIndex - 2
		  var goal as M_Path.MilestoneInterface = trail( trail.LastIndex )
		  var start as M_Path.MilestoneInterface = trail( 0 )
		  
		  var total as integer = BlockGridSquare.BestCost
		  
		  for trailIndex as integer = index to lastIndex
		    'var sq as BlockGridSquare = BlockGridSquare( trail( trailIndex ) )
		    var nextSq as BlockGridSquare = BlockGridSquare( trail( trailIndex + 1 ) )
		    
		    var existing as string = grid( nextSq.Row, nextSq.Column )
		    grid( nextSq.Row, nextSq.Column ) = "#"
		    
		    var result as M_Path.Result = M_Path.FindPath( goal, start, false )
		    grid( nextSq.Row, nextSq.Column ) = existing
		    
		    if result.Trail.Count <> 0 then
		      var thisTrail() as M_Path.MilestoneInterface = result.Trail
		      var lastSq as BlockGridSquare = BlockGridSquare( thisTrail( thisTrail.LastIndex ) )
		      if lastSq.CostToStart < total then
		        BlockGridSquare.BestCost = lastSq.CostToStart
		        total = RecursiveSearch( grid, thisTrail, 0 )
		      end if
		    end if
		  next
		  
		  return total
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"2413432311323\n3215453535623\n3255245654254\n3446585845452\n4546657867536\n1438598798454\n4457876987766\n3637877979653\n4654967986887\n4564679986453\n1224686865563\n2546548887735\n4322674655533", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2023
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
