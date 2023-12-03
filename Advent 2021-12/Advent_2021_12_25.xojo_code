#tag Class
Protected Class Advent_2021_12_25
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Variant
		  return CalculateResultA( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Variant
		  return CalculateResultB( GetPuzzleInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Variant
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var lastRowIndex as integer
		  var lastColIndex as integer
		  var grid( -1, -1 ) as string
		  
		  GetGrid( input, grid, lastRowIndex, lastColIndex )
		  
		  var counter as integer = 1
		  while Move( grid, lastRowIndex, lastColIndex )
		    counter = counter + 1
		  wend
		  
		  return counter
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetGrid(input As String, grid(, ) As String, ByRef lastRowIndex As Integer, ByRef lastColIndex As Integer)
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  if rows.Count = 0 then
		    lastRowIndex = -1
		    lastColIndex = -1
		    grid.ResizeTo lastRowIndex, lastColIndex
		    
		    return
		  end if
		  
		  lastRowIndex = rows.LastIndex
		  lastColIndex = rows( 0 ).Bytes - 1
		  
		  grid.ResizeTo lastRowIndex, lastColIndex
		  
		  for rowIndex as integer = 0 to lastRowIndex
		    var chars() as string = rows( rowIndex ).Split( "" )
		    for colIndex as integer = 0 to lastColIndex
		      grid( rowIndex, colIndex ) = chars( colIndex )
		    next
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Move(ByRef grid(, ) As String, lastRowIndex As Integer, lastColIndex As Integer) As Boolean
		  const kEmpty as string = "."
		  const kEast as string = ">"
		  const kDown as string = "v"
		  
		  'var debugNewGrid as string
		  var moved as boolean
		  
		  var newGrid( -1, -1 ) as string
		  newGrid.ResizeTo lastRowIndex, lastColIndex
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      newGrid( row, col ) = kEmpty
		    next
		  next
		  
		  //
		  // Move east first
		  //
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      var cell as string = grid( row, col )
		      if cell = kEast then
		        var nextCol as integer = if( col = lastColIndex, 0, col + 1 )
		        if grid( row, nextCol ) = kEmpty then
		          newGrid( row, nextCol ) = kEast
		          moved = true
		        else
		          newGrid( row, col ) = kEast
		        end if
		      end if
		      
		      'debugNewGrid = ToString( newGrid, lastRowIndex, lastColIndex )
		      'debugNewGrid = debugNewGrid
		    next
		  next
		  
		  'var debugGrid as string = ToString( grid, lastRowIndex, lastColIndex )
		  'var debugNewGrid as string = ToString( newGrid, lastRowIndex, lastColIndex )
		  
		  //
		  // Move down 
		  //
		  for col as integer = 0 to lastColIndex
		    for row as integer = 0 to lastRowIndex
		      var cell as string = grid( row, col )
		      if cell = kDown then
		        var nextRow as integer = if( row = lastRowIndex, 0, row + 1 )
		        var nextCell as string = grid( nextRow, col )
		        var newNextCell as string = newGrid( nextRow, col )
		        if ( nextCell = kEmpty or nextCell = kEast ) and newNextCell = kEmpty then
		          newGrid( nextRow, col ) = kDown
		          moved = true
		        else
		          newGrid( row, col ) = kDown
		        end if
		      end if
		      
		      'debugNewGrid = ToString( newGrid, lastRowIndex, lastColIndex )
		      'debugNewGrid = debugNewGrid
		    next
		  next
		  
		  'debugNewGrid = ToString( newGrid, lastRowIndex, lastColIndex)
		  'Print debugNewGrid + EndOfLine
		  
		  grid = newGrid
		  return moved
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToString(grid(, ) As String, lastRowIndex As Integer, lastColIndex As Integer) As String
		  var rows() as string
		  var cols() as string
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      cols.Add grid( row, col )
		    next
		    rows.Add String.FromArray( cols, "" )
		    cols.RemoveAll
		  next
		  
		  var result as string = String.FromArray( rows, EndOfLine )
		  result = result.ReplaceAll( ">", &uFF1E )
		  result = result.ReplaceAll( "v", &uFF56 )
		  result = result.ReplaceAll( ".", &uFF0E )
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"v...>>.vv>\n.vv>>.vv..\n>>.>v>...v\n>>v>>.>.v.\nv>v.vv.v..\n>.>>..v...\n.vv..>.>v.\nv.v..>>v.v\n....v..v.>", Scope = Private
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
