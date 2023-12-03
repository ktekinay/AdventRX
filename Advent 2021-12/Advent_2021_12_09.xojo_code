#tag Class
Protected Class Advent_2021_12_09
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
		  
		  var grid( -1, -1 ) as integer = ToGrid( input, lastRowIndex, lastColIndex )
		  
		  var sum as integer
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      if IsLowPoint( grid, row, col, lastRowIndex, lastColIndex ) then
		        sum = sum + grid( row, col ) + 1
		      end if
		    next col
		  next row
		  
		  return sum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var lastRowIndex as integer
		  var lastColIndex as integer
		  
		  var grid( -1, -1 ) as integer = ToGrid( input, lastRowIndex, lastColIndex )
		  
		  var basinSizes() as integer
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      if IsLowPoint( grid, row, col, lastRowIndex, lastColIndex ) then
		        basinSizes.Add GetBasinSize( grid, row, col, lastRowIndex, lastColIndex )
		      end if
		    next col
		  next row
		  
		  basinSizes.Sort
		  
		  var mult as integer = 1
		  for i as integer = basinSizes.LastRowIndex downto (  basinSizes.LastRowIndex - 2 )
		    mult = mult * basinSizes( i )
		  next
		  
		  return mult
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetBasinSize(grid(, ) As Integer, row As Integer, col As Integer, lastRowIndex As Integer, lastColIndex As Integer, visited() As Integer = Nil) As Integer
		  var visitIndex as integer = ( row * ( lastColIndex + 1 ) ) + col
		  
		  if visited is nil then
		    var empty() as integer
		    visited = empty
		  end if
		  
		  if visited.IndexOf( visitIndex ) <> -1 then
		    //
		    // Visited
		    //
		    return 0
		  end if
		  
		  visited.Add visitIndex
		  
		  var value as integer = grid( row, col )
		  
		  if row = 0 and col = 9 then
		    row = row
		  end if
		  
		  if value = 9 then
		    return 0
		  end if
		  
		  var count as integer = 1
		  
		  if row > 0 and grid( row - 1, col ) > value then
		    count = count + GetBasinSize( grid, row - 1, col, lastRowIndex, lastColIndex, visited )
		  end if
		  
		  if row < lastRowIndex and grid( row + 1, col ) > value then
		    count = count + GetBasinSize( grid, row + 1, col, lastRowIndex, lastColIndex, visited )
		  end if
		  
		  if col > 0 and grid( row, col - 1 ) > value then
		    count = count + GetBasinSize( grid, row, col - 1, lastRowIndex, lastColIndex, visited )
		  end if
		  
		  if col < lastColIndex and grid( row, col + 1 ) > value then
		    count = count + GetBasinSize( grid, row, col + 1, lastRowIndex, lastColIndex, visited )
		  end if
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsLowPoint(grid(, ) As Integer, row As Integer, col As Integer, lastRowIndex As Integer, lastColIndex As Integer) As Boolean
		  var value as integer = grid( row, col )
		  
		  var valAbove as integer = if( row = 0, value + 1, grid( row - 1, col ) )
		  var valBelow as integer = if( row = lastRowIndex, value + 1, grid( row + 1, col ) )
		  var valLeft as integer = if( col = 0, value + 1, grid( row, col - 1 ) )
		  var valRight as integer = if( col = lastColIndex, value + 1, grid( row, col + 1 ) )
		  
		  select case value
		  case is >= valAbove
		  case is >= valBelow
		  case is >= valLeft
		  case is >= valRight
		  case else
		    return true
		  end select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToGrid(input As String, ByRef lastRowIndex As Integer, ByRef lastColIndex As Integer) As Integer(,)
		  var stringRows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  lastRowIndex = stringRows.LastIndex
		  lastColIndex = stringRows( 0 ).Bytes - 1
		  
		  var grid( -1, -1 ) as integer
		  grid.ResizeTo lastRowIndex, lastColIndex
		  
		  for row as integer = 0 to lastRowIndex
		    var stringRow as string = stringRows( row )
		    
		    for col as integer = 0 to lastColIndex
		      grid( row, col ) = stringRow.Middle( col, 1 ).ToInteger
		    next col
		  next row
		  
		  return grid
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"2199943210\n3987894921\n9856789892\n8767896789\n9899965678", Scope = Private
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
