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
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var row, col as integer
		  
		  StartingPosition grid, row, col
		  var direction as string = grid( row, col )
		  
		  var visited as new Dictionary( Key( row, col ) : nil )
		  
		  do
		    #pragma BreakOnExceptions false
		    try
		      Move( grid, direction, row, col )
		    catch err as OutOfBoundsException
		      exit
		    end try
		    #pragma BreakOnExceptions default
		    
		    visited.Value( Key( row, col ) ) = nil
		  loop
		  
		  var result as integer = visited.KeyCount
		  return result : if( IsTest, 41, 5453 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var grid( -1, -1 ) as string = ToStringGrid( input )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var startingRow, startingCol as integer
		  
		  StartingPosition grid, startingRow, startingCol
		  var startingDirection as string = grid( startingRow, startingCol )
		  
		  var result as integer
		  
		  for obstacleRow as integer = 0 to lastRowIndex
		    for obstacleCol as integer = 0 to lastColIndex
		      var char as string = grid( obstacleRow, obstacleCol )
		      if char <> "." then
		        continue for obstacleCol
		      end if
		      
		      grid( obstacleRow, obstacleCol ) = "#"
		      
		      var visited as new Dictionary
		      
		      var row as integer = startingRow
		      var col as integer = startingCol
		      var direction as string = startingDirection
		      
		      do
		        #pragma BreakOnExceptions false
		        try
		          Move( grid, direction, row, col )
		        catch err as OutOfBoundsException
		          exit
		        end try
		        #pragma BreakOnExceptions default
		        
		        var key as integer = Key( row, col, direction )
		        if visited.HasKey( key ) then
		          result = result + 1
		          exit
		        end if
		        
		        visited.Value( key ) = nil
		      loop
		      
		      grid( obstacleRow, obstacleCol ) = "."
		    next
		  next
		  
		  return result : if( IsTest, 6, 2188 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Key(row As Integer, col As Integer, direction As String = "") As Integer
		  var key as integer = row * 10000 + col
		  select case direction
		  case "", "^"
		    return key
		  case ">"
		    return key + 200000000
		  case "v"
		    return key + 300000000
		  case "<"
		    return key + 400000000
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Move(grid(, ) As String, ByRef direction As String, ByRef row As Integer, ByRef col As Integer)
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
		    
		    if grid( newRow, newCol ) <> "#" then
		      row = newRow
		      col = newCol
		      return
		    end if
		    
		    direction = Turn( direction )
		  loop
		  
		End Sub
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
