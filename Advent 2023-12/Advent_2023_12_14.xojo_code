#tag Class
Protected Class Advent_2023_12_14
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Tilt the board and find the pattern"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Parabolic Reflector Dish"
		  
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
		  
		  var mb as MemoryBlock = input.ReplaceAll( &uA, "" )
		  
		  Tilt mb, lastRowIndex, lastColIndex, "N"
		  
		  var result as integer = CalculateScore( mb, lastRowIndex, lastColIndex )
		  
		  return result : if( IsTest, 136, 109385 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  const kCycles as integer = 1000000000
		  
		  var grid( -1, -1 ) as string = ToStringGrid( input )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var directions() as string = array( "N", "W", "S", "E" )
		  
		  var mb as MemoryBlock = input.ReplaceAll( &uA, "" )
		  var trail() as string
		  
		  var beforeCycleGridKey as string
		  var afterCycleGridKey as string
		  var circleLen as integer
		  
		  for cycle as integer = 1 to kCycles
		    beforeCycleGridKey = mb
		    
		    for each direction as string in directions
		      Tilt mb, lastRowIndex, lastColIndex, direction
		    next
		    
		    afterCycleGridKey = mb
		    
		    if circleLen <> 0 then
		      continue
		    end if
		    
		    var beforePos as integer = trail.IndexOf( beforeCycleGridKey )
		    var afterPos as integer = trail.IndexOf( afterCycleGridKey )
		    if beforePos = -1 or afterPos = -1 then
		      //
		      // Do nothing
		      //
		      
		    elseif beforePos = ( afterPos - 1 ) then
		      //
		      // We are in a circle
		      //
		      circleLen = trail.Count - afterPos
		      var remaining as integer = kCycles - cycle
		      cycle = kCycles - ( remaining mod circleLen )
		      
		      continue
		    end if
		    
		    trail.Add afterCycleGridKey
		    
		  next
		  
		  var result as integer = CalculateScore( mb, lastRowIndex, lastColIndex )
		  
		  return result : if( IsTest, 64, 93102 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateScore(grid As MemoryBlock, lastRowIndex As Integer, lastColIndex As Integer) As Integer
		  var p as ptr = grid
		  
		  var score as integer
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      var byteIndex as integer = row * ( lastColIndex + 1 ) + col
		      if p.Byte( byteIndex ) = kO then
		        score = score + ( lastRowIndex - row + 1 )
		      end if
		    next
		  next
		  
		  return score
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MbToGrid(mb As MemoryBlock, grid(, ) As String)
		  for row as integer = 0 to grid.LastIndex( 1 )
		    for col as integer = 0 to grid.LastIndex( 2 )
		      var byteIndex as integer = row * ( grid.LastIndex( 2 ) + 1 ) + col
		      grid( row, col ) = chr( mb.Byte( byteIndex ) )
		    next
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Tilt(grid As MemoryBlock, lastRowIndex As Integer, lastColIndex As Integer, direction As String)
		  var startRow as integer = 0
		  var endRow as integer = lastRowIndex
		  var rowStepper as integer = 1
		  
		  var startCol as integer = 0
		  var endCol as integer = lastColIndex
		  var colStepper as integer = 1
		  
		  select case direction
		  case "N"
		    startRow = 1
		  case "W"
		    startCol = 1
		  case "S"
		    startRow = lastRowIndex - 1
		    endRow = 0
		    rowStepper = -1
		  case "E"
		    startCol = lastColIndex - 1
		    endCol = 0
		    colStepper = -1
		  end select
		  
		  var p as ptr = grid
		  
		  for thisRow as integer = startRow to endRow step rowStepper
		    for thisCol as integer = startCol to endCol step colStepper
		      var thisByteIndex as integer = thisRow * ( lastColIndex + 1 ) + thisCol
		      
		      var this as integer = p.Byte( thisByteIndex )
		      
		      if this <> kO then
		        continue for thisCol
		      end if
		      
		      var toRow as integer = thisRow
		      var toCol as integer = thisCol
		      
		      do
		        var nextRow as integer
		        var nextCol as integer
		        
		        select case direction
		        case "N"
		          nextRow = toRow - 1
		          nextCol = toCol
		        case "W"
		          nextRow = toRow
		          nextCol = toCol - 1
		        case "S"
		          nextRow = toRow + 1
		          nextCol = toCol
		        case "E"
		          nextRow = toRow
		          nextCol = toCol + 1
		        case else
		          raise new RuntimeException
		        end select
		        
		        if nextRow < 0 or nextRow > lastRowIndex or nextCol < 0 or nextCol > lastColIndex then
		          exit do
		        end if
		        
		        var nextByteIndex as integer = nextRow * ( lastColIndex + 1 ) + nextCol
		        var nextSquare as integer = p.Byte( nextByteIndex )
		        if nextSquare <> kDot then
		          exit do
		        end if
		        
		        toRow = nextRow
		        toCol = nextCol
		      loop
		      
		      if toRow <> thisRow or toCol <> thisCol then
		        var toByteIndex as integer = toRow * ( lastColIndex + 1 ) + toCol
		        p.Byte( toByteIndex ) = this
		        p.Byte( thisByteIndex ) = kDot
		      end if
		    next
		  next
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kDot, Type = Double, Dynamic = False, Default = \"46", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kO, Type = Double, Dynamic = False, Default = \"79", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"O....#....\nO.OO#....#\n.....##...\nOO.#O....O\n.O.....O#.\nO.#..O.#.#\n..O..#O..O\n.......O..\n#....###..\n#OO..#....", Scope = Private
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
