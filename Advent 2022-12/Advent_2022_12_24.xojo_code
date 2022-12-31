#tag Class
Protected Class Advent_2022_12_24
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Navigate blizzards"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Blizzard Basin"
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( Normalize( GetPuzzleInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( Normalize( GetPuzzleInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  return CalculateResultB( Normalize( input ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AdvanceBlizzards(grids() As ObjectGrid)
		  var source as ObjectGrid = grids( grids.LastIndex )
		  
		  var grid as new ObjectGrid
		  grid.ResizeTo source.LastRowIndex, source.LastColIndex
		  
		  for row as integer = 0 to grid.LastRowIndex
		    for col as integer = 0 to grid.LastColIndex
		      var square as GridMember = source( row, col )
		      
		      if not ( square isa BlizzardTracker ) then // Wall
		        square = new GridMember
		        square.Value = "#"
		        grid( row, col ) = square
		        
		        continue
		      end if
		      
		      var bt as new BlizzardTracker 
		      
		      if row > 0 and row < grid.LastRowIndex then
		        var prevRow as integer = row - 1
		        if prevRow <= 0 then
		          prevRow = grid.LastRowIndex - 1
		        end if
		        
		        var nextRow as integer = row + 1
		        if nextRow >= grid.LastRowIndex then
		          nextRow = 1
		        end if
		        
		        var prevCol as integer = col - 1
		        if prevCol <= 0 then
		          prevCol = grid.LastColIndex - 1
		        end if
		        
		        var nextCol as integer = col + 1
		        if nextCol >= grid.LastColIndex then
		          nextCol = 1
		        end if
		        
		        bt.UpCount = BlizzardTracker( source( nextRow, col ) ).UpCount
		        bt.DownCount = BlizzardTracker( source( prevRow, col ) ).DownCount
		        bt.LeftCount = BlizzardTracker( source( row, nextCol ) ).LeftCount
		        bt.RightCount = BlizzardTracker( source( row, prevCol ) ).RightCount
		      end if
		      
		      grid( row, col ) = bt
		    next
		  next
		  
		  grids.Add grid
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AreSame(grid1 As ObjectGrid, grid2 As ObjectGrid) As Boolean
		  if grid1.LastRowIndex <> grid2.LastRowIndex or grid1.LastColIndex <> grid2.LastColIndex then
		    return false
		  end if
		  
		  for row as integer = 1 to grid1.LastRowIndex - 1
		    for col as integer = 1 to grid2.LastColIndex - 1
		      var g1 as BlizzardTracker = BlizzardTracker( grid1( row, col ) )
		      var g2 as BlizzardTracker = BlizzardTracker( grid2( row, col ) )
		      if g1.UpCount <> g2.UpCount then
		        return false
		      end if
		      if g1.DownCount <> g2.DownCount then
		        return false
		      end if
		      if g1.LeftCount <> g2.LeftCount then
		        return false
		      end if
		      if g1.RightCount <> g2.RightCount then
		        return false
		      end if
		    next
		  next
		  
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function BestMoves(move As Integer, rowPos As Integer, colPos As Integer, destRow As Integer, destCol As Integer, grids() As ObjectGrid, ByRef bestMoves As Integer) As Integer
		  const kMaxMoves as integer = &hFFFFFFFFFFFF
		  
		  if rowPos = destRow and colPos = destCol then
		    //
		    // We are here
		    //
		    if bestMoves = 0 or bestMoves > move then
		      bestMoves = move
		    end if
		    
		    return move
		  end if
		  
		  
		  if bestMoves > 0 then
		     var mdist as integer = M_Path.ManhattanDistance( colPos, rowPos, destCol, destRow )
		    
		    if( move + mdist ) >= bestMoves then
		      return kMaxMoves
		    end if
		  end if
		  
		  if move >= grids.LastIndex then
		    AdvanceBlizzards grids
		  end if
		  
		  var grid as ObjectGrid = grids( move )
		  
		  if colPos < 0 or colPos > grid.LastColIndex or rowPos < 0 or rowPos > grid.LastRowIndex then
		    return kMaxMoves
		  end if
		  
		  var curPos as GridMember = grid( rowPos, colPos )
		  
		  if not ( curPos isa BlizzardTracker ) then
		    //
		    // Wall
		    //
		    return kMaxMoves
		  end if
		  
		  if curPos.BestSteps <> 0 then
		    return curPos.BestSteps
		  end if
		  
		  if BlizzardTracker( curPos ).IsClear = false then
		    curPos.BestSteps = kMaxMoves
		    return kMaxMoves
		  end if
		  
		  var myBestMoves as integer = kMaxMoves
		  
		  if destRow = 0 then
		    myBestMoves = min( myBestMoves, BestMoves( move + 1, rowPos - 1, colPos, destRow, destCol, grids, bestMoves ) )
		    myBestMoves = min( myBestMoves, BestMoves( move + 1, rowPos, colPos - 1, destRow, destCol, grids, bestMoves ) )
		    myBestMoves = min( myBestMoves, BestMoves( move + 1, rowPos + 1, colPos, destRow, destCol, grids, bestMoves ) )
		    myBestMoves = min( myBestMoves, BestMoves( move + 1, rowPos, colPos + 1, destRow, destCol, grids, bestMoves ) )
		  else
		    myBestMoves = min( myBestMoves, BestMoves( move + 1, rowPos + 1, colPos, destRow, destCol, grids, bestMoves ) )
		    myBestMoves = min( myBestMoves, BestMoves( move + 1, rowPos, colPos + 1, destRow, destCol, grids, bestMoves ) )
		    myBestMoves = min( myBestMoves, BestMoves( move + 1, rowPos - 1, colPos, destRow, destCol, grids, bestMoves ) )
		    myBestMoves = min( myBestMoves, BestMoves( move + 1, rowPos, colPos - 1, destRow, destCol, grids, bestMoves ) )
		  end if
		  
		  myBestMoves = min( myBestMoves, BestMoves( move + 1, rowPos, colPos, destRow, destCol, grids, bestMoves ) )
		  
		  curPos.BestSteps = myBestMoves
		  return myBestMoves
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var grid as ObjectGrid = ParseInput( input )
		  'if IsTest then
		  'Print grid
		  'Print ""
		  'end if
		  
		  var grids() as ObjectGrid
		  grids.Add grid
		  
		  'if IsTest then
		  'Print grids( 1 )
		  'Print ""
		  'end if
		  
		  var startingBestMoves as integer = M_Path.ManhattanDistance( 1, 0, grid.LastColIndex - 1, grid.LastRowIndex )
		  
		  var bestMoves as integer
		  var thisBestMoves as integer
		  
		  do
		    startingBestMoves = startingBestMoves * 2
		    bestMoves = startingBestMoves
		    thisBestMoves = BestMoves( 0, 0, 1, grid.LastRowIndex, grid.LastColIndex - 1, grids, bestMoves )
		    
		    if thisBestMoves < startingBestMoves then
		      exit
		    end if
		    
		    grids.RemoveAll
		    Reset grid
		    grids.Add grid
		  loop 
		  
		  return bestMoves
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var grid as ObjectGrid = ParseInput( input )
		  
		  var grids() as ObjectGrid
		  grids.Add grid
		  
		  var accumulated() as integer
		  
		  var startRow as integer = 0
		  var startCol as integer = 1
		  var destRow as integer = grid.LastRowIndex
		  var destCol as integer = grid.LastColIndex - 1
		  
		  var bestMoves as integer = M_Path.ManhattanDistance( 1, 0, grid.LastColIndex - 1, grid.LastRowIndex )
		  
		  for i as integer = 1 to 3
		    var startingBestMoves as integer = bestMoves
		    var thisBestMoves as integer
		    
		    do
		      startingBestMoves = startingBestMoves * 2
		      bestMoves = startingBestMoves
		      
		      thisBestMoves = BestMoves( 0, startRow, startCol, destRow, destCol, grids, bestMoves )
		      
		      if thisBestMoves < startingBestMoves then
		        exit
		      end if
		      
		      grids.RemoveAll
		      Reset grid
		      grids.Add grid
		    loop
		    
		    accumulated.Add bestMoves
		    Print i, bestMoves
		    
		    var tempRow as integer = startRow
		    var tempCol as integer = startCol
		    startRow = destRow
		    startCol = destCol
		    destRow = tempRow
		    destCol = tempCol
		    
		    while grids.LastIndex < bestMoves 
		      AdvanceBlizzards grids
		    wend
		    
		    if i = 3 then
		      exit
		    end if
		    
		    grid = grids( bestMoves )
		    Reset grid
		    grids.RemoveAll
		    grids.Add grid
		  next
		  
		  var sum as integer = SumArray( accumulated )
		  return sum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As ObjectGrid
		  var sgrid( -1, -1 ) as string = ToStringGrid( input )
		  
		  var grid as new ObjectGrid
		  grid.ResizeTo sgrid.LastIndex( 1 ), sgrid.LastIndex( 2 )
		  
		  for row as integer = 0 to grid.LastRowIndex
		    for col as integer = 0 to grid.LastColIndex
		      var char as string = sgrid( row, col )
		      
		      var square as GridMember
		      if char = "#" then
		        square = new GridMember
		        square.Value = "#"
		        
		      else
		        var bt as new BlizzardTracker
		        square = bt
		        
		        select case char
		        case "<"
		          bt.LeftCount = 1
		        case ">"
		          bt.RightCount = 1
		        case "^"
		          bt.UpCount = 1
		        case "v"
		          bt.DownCount = 1
		        end select
		        
		      end if
		      
		      grid( row, col ) = square
		    next
		  next
		  
		  return grid
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Reset(grid As ObjectGrid)
		  for each member as GridMember in grid
		    if member isa object then
		      member.BestSteps = 0
		    end if
		  next
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"#.######\n#>>.<^<#\n#.<..<<#\n#>v.><>#\n#<^v^^>#\n######.#", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


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
