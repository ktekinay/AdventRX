#tag Class
Protected Class Advent_2024_12_15
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Move boxes around a grid"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Warehouse Woes"
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
		  var sections() as string = Normalize( input ).Split( EndOfLine + EndOfLine )
		  
		  var grid( -1, -1 ) as string = ToStringGrid( sections( 0 ) )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  sections( 1 ) = sections( 1 ).ReplaceLineEndings( "" )
		  var instructions() as string = sections( 1 ).Split( "" )
		  
		  var posRow as integer = -1
		  var posCol as integer = -1
		  
		  RobotPosition grid, posRow, posCol
		  
		  for each instruction as string in instructions
		    var rowInc as integer
		    var colInc as integer
		    
		    select case instruction
		    case "^"
		      rowInc = -1
		    case ">"
		      colInc = 1
		    case "v"
		      rowInc = 1
		    case "<"
		      colInc = -1
		    end select
		    
		    var gapRow as integer 
		    var gapCol as integer 
		    
		    FindGap( grid, posRow, posCol, rowInc, colInc, gapRow, gapCol )
		    
		    if gapRow = -1 then
		      continue for instruction
		    end if 
		    
		    var moveToRow as integer = posRow + rowInc
		    var moveToCol as integer = posCol + colInc
		    
		    if moveToRow <> gapRow or moveToCol <> gapCol then
		      grid( gapRow, gapCol ) = grid( moveToRow, moveToCol )
		    end if
		    
		    grid( moveToRow, moveToCol ) = "@"
		    grid( posRow, posCol ) = "."
		    
		    posRow = moveToRow
		    posCol = moveToCol
		  next
		  
		  var result as integer
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      if grid( row, col ) = "O" then
		        result = result + ( row * 100 ) + col
		      end if
		    next
		  next
		  
		  return result : if( IsTest, 2028, 1509074 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var sections() as string = Normalize( input ).Split( EndOfLine + EndOfLine )
		  
		  sections( 0 ) = sections( 0 ) _
		  .ReplaceAll( "#", "##" ) _
		  .ReplaceAll( ".", ".." ) _
		  .ReplaceAll( "O", "[]" ) _
		  .ReplaceAll( "@", "@." )
		  var grid( -1, -1 ) as string = ToStringGrid( sections( 0 ) )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  sections( 1 ) = sections( 1 ).ReplaceLineEndings( "" )
		  var instructions() as string = sections( 1 ).Split( "" )
		  
		  var posRow as integer = -1
		  var posCol as integer = -1
		  
		  RobotPosition grid, posRow, posCol
		  
		  for each instruction as string in instructions
		    var rowInc as integer
		    var colInc as integer
		    
		    select case instruction
		    case "^"
		      rowInc = -1
		    case ">"
		      colInc = 1
		    case "v"
		      rowInc = 1
		    case "<"
		      colInc = -1
		    end select
		    
		    var gapRow as integer 
		    var gapCol as integer 
		    
		    FindGap( grid, posRow, posCol, rowInc, colInc, gapRow, gapCol )
		    
		    if gapRow = -1 then
		      continue for instruction
		    end if 
		    
		    var moveToRow as integer = posRow + rowInc
		    var moveToCol as integer = posCol + colInc
		    
		    if moveToRow = gapRow and moveToCol = gapCol then
		      grid( moveToRow, moveToCol ) = "@"
		      grid( posRow, posCol ) = "."
		      
		      posRow = gapRow
		      posCol = gapCol
		      
		      continue for instruction
		    end if
		    
		    if colInc <> 0 then // Horizontal move
		      var stepper as integer = 0 - colInc
		      
		      for tempCol as integer = gapCol to moveToCol step stepper
		        grid( gapRow, tempCol ) = grid( gapRow, tempCol - colInc )
		      next
		      
		      grid( posRow, posCol ) = "."
		      
		      posRow = moveToRow
		      posCol = moveToCol
		      
		      continue for instruction
		    end if
		    
		    var boxesDict as Dictionary = CollectBoxes( grid, posRow + rowInc, posCol, rowInc, new Dictionary )
		    
		    if boxesDict is nil then 
		      continue for instruction
		    end if
		    
		    var points() as variant = boxesDict.Keys
		    var chars() as variant = boxesDict.Values
		    
		    for each pt as Xojo.Point in points
		      grid( pt.Y, pt.X ) = "."
		    next
		    
		    for i as integer = 0 to points.LastIndex
		      var pt as Xojo.Point = points( i )
		      var char as string = chars( i )
		      
		      grid( pt.Y + rowInc, pt.X ) = char
		    next
		    
		    grid( moveToRow, moveToCol ) = "@"
		    grid( posRow, posCol ) = "."
		    
		    posRow = moveToRow
		    posCol = moveToCol
		  next
		  
		  var result as integer
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      if grid( row, col ) = "[" then
		        result = result + ( row * 100 + col )
		      end if
		    next
		  next
		  
		  return result : if( IsTest, 9021, 1521453 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CollectBoxes(grid(, ) As String, row As Integer, col As Integer, rowInc As Integer, boxesDict As Dictionary) As Dictionary
		  var char as string = grid( row, col )
		  
		  select case char
		  case "#"
		    return nil
		    
		  case "."
		    return boxesDict
		    
		  end select
		  
		  boxesDict = CollectBoxes( grid, row + rowInc, col, rowInc, boxesDict )
		  
		  if boxesDict is nil then
		    return nil
		  end if
		  
		  select case char
		  case "["
		    boxesDict.Value( new Xojo.Point( col + 1, row ) ) = "]"
		    boxesDict = CollectBoxes( grid, row + rowInc, col + 1, rowInc, boxesDict )
		    
		  case "]"
		    boxesDict.Value( new Xojo.Point( col - 1, row ) ) = "["
		    boxesDict = CollectBoxes( grid, row + rowInc, col - 1, rowInc, boxesDict )
		    
		  end select
		  
		  if boxesDict isa object then
		    boxesDict.Value( new Xojo.Point( col, row ) ) = char
		  end if
		  
		  return boxesDict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub FindGap(grid(, ) As String, startRow As Integer, startCol As Integer, rowInc As Integer, colInc As Integer, ByRef gapRow As Integer, ByRef gapCol As Integer)
		  gapRow = startRow + rowInc
		  gapCol = startCol + colInc
		  
		  do
		    var char as string = grid( gapRow, gapCol )
		    
		    if char = "." then
		      return
		    elseif char = "#" then
		      exit
		    end if
		    
		    gapRow = gapRow + rowInc
		    gapCol = gapCol + colInc
		  loop
		  
		  gapRow = -1
		  gapCol = -1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub RobotPosition(grid(, ) As String, ByRef row As Integer, ByRef col As Integer)
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  for posRow as integer = 0 to lastRowIndex
		    for posCol as integer = 0 to lastColIndex
		      if grid( posRow, posCol ) = "@" then
		        row = posRow
		        col = posCol
		        
		        return
		      end if
		    next
		  next
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"########\n#..O.O.#\n##@.O..#\n#...O..#\n#.#.O..#\n#...O..#\n#......#\n########\n\n<^^>>>vv<v>>v<<", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"##########\n#..O..O.O#\n#......O.#\n#.OO..O.O#\n#..O@..O.#\n#O#..O...#\n#O..O..O.#\n#.OO.O.OO#\n#....O...#\n##########\n\n<vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^\nvvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v\n><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<\n<<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^\n^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><\n^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^\n>^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^\n<><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>\n^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>\nv^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^", Scope = Private
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
