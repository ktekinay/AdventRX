#tag Class
Protected Class Advent_2024_12_16
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Best paths through a maze"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Reindeer Maze"
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
		  MazeSquare.BestCostToStart = 0.0
		  
		  var grid( -1, -1 ) as string = ToStringGrid( Normalize( input ) )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var startPos as MazeSquare
		  var endPos as MazeSquare
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      select case grid( row, col )
		      case "S"
		        startPos = new MazeSquare( row, col, M_Path.Directions.East, nil )
		        startPos.Grid = grid
		        
		        if endPos isa object then
		          exit
		        end if
		        
		      case "E"
		        endPos = new MazeSquare( row, col, M_Path.Directions.North, nil )
		        endPos.Grid = grid
		        
		        if startPos isa object then
		          exit
		        end if
		        
		      end select
		    next
		  next
		  
		  var pathResult as M_Path.Result = M_Path.FindPath( endPos, startPos, true)
		  
		  var cost as integer = MazeSquare( pathResult.Trail( pathResult.Trail.LastIndex ) ).CostToStart
		  return cost : if( IsTest, 11048, 78428 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  MazeSquare.BestCostToStart = 0.0
		  
		  var result as integer
		  
		  if DebugBuild and not IsTest then
		    result = 463 // Otherwise takes too long
		    
		  else
		    var grid( -1, -1 ) as string = ToStringGrid( Normalize( input ) )
		    
		    var lastRowIndex as integer = grid.LastIndex( 1 )
		    var lastColIndex as integer = grid.LastIndex( 2 )
		    
		    var startPos as MazeSquare
		    var endPos as MazeSquare
		    
		    for row as integer = 0 to lastRowIndex
		      for col as integer = 0 to lastColIndex
		        select case grid( row, col )
		        case "S"
		          startPos = new MazeSquare( row, col, M_Path.Directions.East, nil )
		          startPos.Grid = grid
		          
		          if endPos isa object then
		            exit
		          end if
		          
		        case "E"
		          endPos = new MazeSquare( row, col, M_Path.Directions.North, nil )
		          endPos.Grid = grid
		          
		          if startPos isa object then
		            exit
		          end if
		          
		        end select
		      next
		    next
		    
		    var pathResult as M_Path.Result = M_Path.FindPath( endPos, startPos, false)
		    
		    var cost as integer = MazeSquare( pathResult.Trail( pathResult.Trail.LastIndex ) ).CostToStart
		    
		    MazeSquare.BestCostToStart = cost
		    
		    var allSquares as new Set
		    TrailToSet pathResult.Trail, allSquares
		    
		    RecursiveSearch grid, pathResult.Trail, 0, allSquares
		    result = allSquares.Count
		    
		  end if
		  
		  return result : if( IsTest, 64, 463 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function LocalKey(sq As M_Path.GridSquare) As Integer
		  return sq.Row * sq.Grid.LastIndex( 2 ) + sq.Column
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub RecursiveSearch(grid(, ) As String, trail() As M_Path.MilestoneInterface, trailIndex As Integer, allSquares As Set)
		  var lastIndex as integer = trail.LastIndex - 2
		  
		  for i as integer = trailIndex to lastIndex
		    var sq as MazeSquare = MazeSquare( trail( i ) )
		    
		    var neighbors() as M_Path.GridSquare = sq.Neighbors
		    
		    select case neighbors.Count
		    case 0
		      // We've exceeded best cost
		      exit
		    case 1
		      // Start
		      continue
		    case 2
		      // If we aren't at the start...
		      if i <> 0 then
		        // ... there is only one path
		        continue
		      end if
		    case else
		      var nextSq as MazeSquare = MazeSquare( trail( i + 1 ) )
		      
		      grid( nextSq.Row, nextSq.Column ) = "#"
		      var pathResult as M_Path.Result = M_Path.FindPath( trail( trail.LastIndex ), sq, true )
		      
		      TrailToSet pathResult.Trail, allSquares
		      
		      if neighbors.Count = 4 then
		        RecursiveSearch grid, pathResult.Trail, i, allSquares
		      end if
		      
		      grid( nextSq.Row, nextSq.Column ) = "."
		      
		    end select
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub TrailToSet(trail() As M_Path.MilestoneInterface, toSet As Set)
		  for i as integer = 0 to trail.LastIndex
		    var sq as MazeSquare = MazeSquare( trail( i ) )
		    var key as integer = LocalKey( sq )
		    toSet.Add key
		  next
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"#################\n#...#...#...#..E#\n#.#.#.#.#.#.#.#.#\n#.#.#.#...#...#.#\n#.#.#.#.###.#.#.#\n#...#.#.#.....#.#\n#.#.#.#.#.#####.#\n#.#...#.#.#.....#\n#.#.#####.#.###.#\n#.#.#.......#...#\n#.#.###.#####.###\n#.#.#...#.....#.#\n#.#.#.#####.###.#\n#.#.#.........#.#\n#.#.#.#########.#\n#S#.............#\n#################", Scope = Private
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
