#tag Class
Protected Class Advent_2024_12_06
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
		  return "Guard Gallivant"
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
		  var grid( -1, -1 ) as string = ToStringGrid( input )
		  
		  var visited as Dictionary = Solve( grid )
		  
		  var result as integer = visited.KeyCount
		  return result : if( IsTest, 41, 5453 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var grid( -1, -1 ) as string = ToStringGrid( input )
		  
		  var visited as Dictionary = Solve( grid )
		  var visitedJSON as string = GenerateJSON( visited.Keys )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var rowCount as integer = lastRowIndex + 1
		  
		  var startingRow, startingCol as integer
		  StartingPosition grid, startingRow, startingCol
		  var startingDirection as string = grid( startingRow, startingCol )
		  
		  var availableProcessors as integer = max( System.CoreCount - 2, 1 )
		  
		  var rowsPerThread as integer = rowCount / availableProcessors + 1
		  
		  var strippedInput as string = input.ReplaceLineEndings( "" )
		  
		  var threads() as Day6Thread 
		  
		  for row as integer = 0 to lastRowIndex step rowsPerThread
		    var t as new Day6Thread
		    t.Type = Thread.Types.Preemptive
		    
		    t.StartingObstacleRow = row
		    t.EndingObstacleRow = row + rowsPerThread - 1
		    t.StartingRow = startingRow
		    t.StartingCol = startingCol
		    t.StartingDirection = startingDirection
		    t.Grid = strippedInput
		    t.LastRowIndex = lastRowIndex
		    t.LastColIndex = lastColIndex
		    t.VisitedJSON = visitedJSON
		    
		    t.Start
		    threads.Add t
		  next
		  
		  var result as integer
		  
		  do
		    var t as Day6Thread = threads( threads.LastIndex )
		    
		    if t.ThreadState = Thread.ThreadStates.NotRunning then
		      call threads.Pop
		      result = result + t.Result
		    end if
		  loop until threads.Count = 0
		  
		  return result : if( IsTest, 6, 2188 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Key(row As Integer, col As Integer, colCount As Integer) As Integer
		  var key as integer = row * colCount + col
		  
		  return key
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Move(grid(, ) As String, ByRef direction As String, ByRef row As Integer, ByRef col As Integer)
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var newRow as integer
		  var newCol as integer 
		  
		  do
		    newRow = row
		    newCol = col
		    
		    select case direction
		    case "^"
		      newRow = newRow - 1
		    case ">"
		      newCol = newCol + 1
		    case "v"
		      newRow = newRow + 1
		    case "<"
		      newCol = newCol - 1
		    end select
		    
		    if newRow < 0 or newRow > lastRowIndex or _
		      newCol < 0 or newCol > lastColIndex or _
		      grid( newRow, newCol ) <> "#" then
		      row = newRow
		      col = newCol
		      return
		    end if
		    
		    direction = Turn( direction )
		  loop
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Solve(grid(, ) As String) As Dictionary
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  var colCount as integer = lastColIndex + 1
		  
		  var row, col as integer
		  
		  StartingPosition grid, row, col
		  var direction as string = grid( row, col )
		  
		  var visited as new Dictionary( Key( row, col, colCount ) : nil )
		  
		  do
		    Move( grid, direction, row, col )
		    
		    if row < 0 or row > lastRowIndex or _
		      col < 0 or col > lastColIndex then
		      exit
		    end if
		    
		    visited.Value( Key( row, col, colCount ) ) = nil
		  loop
		  
		  return visited
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub StartingPosition(grid(, ) As String, ByRef row As Integer, ByRef col As Integer)
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  for row = 0 to lastRowIndex
		    for col = 0 to lastColIndex
		      var char as string = grid( row, col )
		      if char = "#" or char = "." then
		        continue
		      end if
		      return
		    next
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Turn(direction As String) As String
		  select case direction
		  case "^"
		    return ">"
		  case ">"
		    return "v"
		  case "v"
		    return "<"
		  case "<"
		    return "^"
		  end select
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"....#.....\n.........#\n..........\n..#.......\n.......#..\n..........\n.#..^.....\n........#.\n#.........\n......#...", Scope = Private
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
