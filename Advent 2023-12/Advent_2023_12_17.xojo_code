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
		  var total as integer
		  
		  var grid( -1, -1 ) as string = ToStringGrid( input )
		  var goalGrid as ObjectGrid = ObjectGrid.FromStringGrid( grid )
		  
		  'MapAllGoalCost goalGrid
		  
		  BlockGridSquare.GoalGrid = goalGrid
		  BlockGridSquare.GoalMultiplier = 0.0
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var goal as new BlockGridSquare( lastRowIndex, lastColIndex, M_Path.Directions.North, nil )
		  goal.Grid = grid
		  
		  var bestTrail() as M_Path.MilestoneInterface
		  
		  do
		    'BlockGridSquare.GoalMultiplier = BlockGridSquare.GoalMultiplier + 1.0
		    
		    var start1 as new BlockGridSquare( 0, 0, M_Path.Directions.East, nil )
		    start1.Grid = grid
		    
		    var start2 as new BlockGridSquare( 0, 0, M_Path.Directions.South, nil )
		    start2.Grid = grid
		    
		    
		    for each start as BlockGridSquare in array( start1, start2 )
		      var thisTotal as integer
		      
		      var result as M_Path.Result = M_Path.FindPath( goal, start, false, true )
		      var trail() as M_Path.MilestoneInterface = result.Trail
		      
		      thisTotal = GetTotal( grid, trail, 1, trail.LastIndex )
		      thisTotal = BlockGridSquare( trail( trail.LastIndex ) ).CostToStart
		      
		      if total = 0 or thisTotal < total then
		        bestTrail = trail
		        total = thisTotal
		      end if
		    next
		    bestTrail = bestTrail
		    exit
		  loop until not MapGoalCosts( bestTrail ) and BlockGridSquare.GoalMultiplier > 10.0
		  
		  if IsTest then
		    PrintWithTrail grid, bestTrail
		  end if
		  
		  return total : if( IsTest, 102, 0 )
		  // TOO HIGH: 1483
		  // TOO HIGH: 1429
		  // TOO HIGH: 1008
		  // INCORRECT: 923
		  // INCORRECT: 925
		  // INCORRECT: 975
		  // INCORRECT: 979
		  // INCORRECT: 980
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
		Private Shared Sub MapAllGoalCost(grid As ObjectGrid)
		  var goal as GridMember = grid( grid.LastRowIndex, grid.LastColIndex )
		  
		  for count as integer = 1 to 1
		    var queue as new Set
		    
		    if true then
		      var neighbors() as GridMember = goal.Neighbors( false )
		      for each n as GridMember in neighbors
		        queue.Add n
		      next
		    end if
		    
		    while queue.Count <> 0
		      var gm as GridMember = queue.Pop
		      
		      var neighbors() as GridMember = gm.Neighbors( false )
		      
		      var wasChanged as boolean
		      
		      for each n as GridMember in neighbors
		        if n.BestSteps = 0 and not ( n is goal ) then
		          queue.Add n
		          continue
		        end if
		        
		        var theseBest as integer = n.Value + n.BestSteps
		        
		        if gm.BestSteps = 0 or gm.BestSteps > theseBest then
		          gm.BestSteps = theseBest
		          wasChanged = true
		        end if
		      next
		      
		      if wasChanged then
		        for each n as GridMember in neighbors
		          if not ( n is goal ) then
		            queue.Add n
		          end if
		        next
		      end if
		    wend
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function MapGoalCosts(trail() As M_Path.MilestoneInterface) As Boolean
		  var keepGoing as boolean
		  
		  var goalGrid as ObjectGrid = BlockGridSquare.GoalGrid
		  var newCost as integer
		  
		  for i as integer = trail.LastIndex downto 0
		    var sq as BlockGridSquare = BlockGridSquare( trail( i ) )
		    var og as GridMember = goalGrid( sq.Row, sq.Column )
		    
		    if og.BestSteps <> newCost then
		      og.BestSteps = newCost
		      keepGoing = true
		    end if
		    
		    newCost = newCost + og.Value.IntegerValue
		  next
		  
		  return keepGoing
		  
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
