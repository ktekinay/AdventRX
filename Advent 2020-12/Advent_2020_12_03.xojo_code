#tag Class
Protected Class Advent_2020_12_03
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( GetPuzzleInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var grid( -1, -1 ) as string
		  var lastRowIndex as integer
		  var lastColIndex as integer
		  
		  ParseInput input, grid, lastRowIndex, lastColIndex
		  
		  if lastRowIndex = -1 then
		    return -1
		  end if
		  
		  var treeCount as integer
		  
		  var row as integer = 0
		  var col as integer = 0
		  
		  do
		    if grid( row, col ) = "#" then
		      treeCount = treeCount + 1
		    end if
		    Traverse 3, 1, row, col, lastColIndex
		  loop until row > lastRowIndex
		  
		  return treeCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var grid( -1, -1 ) as string
		  var lastRowIndex as integer
		  var lastColIndex as integer
		  
		  ParseInput input, grid, lastRowIndex, lastColIndex
		  
		  var travels() as pair
		  travels.Add 1 : 1
		  travels.Add 3 : 1
		  travels.Add 5 : 1
		  travels.Add 7 : 1
		  travels.Add 1 : 2
		  
		  var counts() as integer
		  
		  for each travel as pair in travels
		    var row as integer
		    var col as integer
		    
		    var treeCount as integer
		    do
		      if grid( row, col ) = "#" then
		        treeCount = treeCount + 1
		      end if
		      Traverse travel.Left.IntegerValue, travel.Right.IntegerValue, row, col, lastColIndex
		    loop until row > lastRowIndex
		    
		    counts.Add treeCount
		  next
		  
		  var mult as integer = 1
		  for each count as integer in counts
		    mult = mult * count
		  next
		  
		  return mult
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseInput(input As String, ByRef grid(, ) As String, ByRef lastRowIndex As Integer, ByRef lastColIndex As Integer)
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
		  
		  for row as integer = 0 to lastRowIndex
		    var chars() as string = rows( row ).Split( "" )
		    for col as integer = 0 to chars.LastIndex
		      grid( row, col ) = chars( col )
		    next
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Traverse(right As Integer, down As Integer, ByRef row As Integer, ByRef col As Integer, lastColIndex As Integer)
		  col = col + right
		  col = col mod ( lastColIndex + 1 )
		  row = row + down
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"..##.......\n#...#...#..\n.#....#..#.\n..#.#...#.#\n.#...##..#.\n..#.##.....\n.#.#.#....#\n.#........#\n#.##...#...\n#...##....#\n.#..#...#.#", Scope = Private
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
