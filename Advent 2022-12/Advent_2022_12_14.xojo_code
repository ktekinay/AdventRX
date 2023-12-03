#tag Class
Protected Class Advent_2022_12_14
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Dropping sand"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Regolith Reservoir"
		  
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
		Private Function CalculateResultA(input As String) As Integer
		  var grid( 600, 1001 ) as string
		  
		  var instructions() as string = input.Split( EndOfLine )
		  
		  var maxRow as integer
		  
		  for each ins as string in instructions
		    var parts() as string = ins.Split( " -> " )
		    for i as integer = 1 to parts.LastIndex
		      var pt1 as Xojo.Point = ToPoint( parts( i - 1 ) )
		      var pt2 as Xojo.Point = ToPoint( parts( i ) )
		      
		      FillGrid grid, pt1, pt2
		      maxRow = max( maxRow, pt1.Y )
		      maxRow = max( maxRow, pt2.Y )
		    next
		  next
		  
		  grid.ResizeTo( maxRow, grid.LastIndex( 2 ) )
		  
		  var sandCount as integer
		  while DropSand( grid, maxRow )
		    sandCount = sandCount + 1
		  wend
		  
		  return sandCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var grid( 600, 1001 ) as string
		  
		  var instructions() as string = input.Split( EndOfLine )
		  
		  var maxRow as integer
		  
		  for each ins as string in instructions
		    var parts() as string = ins.Split( " -> " )
		    for i as integer = 1 to parts.LastIndex
		      var pt1 as Xojo.Point = ToPoint( parts( i - 1 ) )
		      var pt2 as Xojo.Point = ToPoint( parts( i ) )
		      
		      FillGrid grid, pt1, pt2
		      maxRow = max( maxRow, pt1.Y )
		      maxRow = max( maxRow, pt2.Y )
		    next
		  next
		  
		  maxRow = maxRow + 2
		  grid.ResizeTo( maxRow, grid.LastIndex( 2 ) )
		  
		  var pt1 as new Xojo.Point
		  pt1.X = 0
		  pt1.Y = maxRow
		  
		  var pt2 as new Xojo.Point
		  pt2.X = grid.LastIndex( 2 )
		  pt2.Y = maxRow
		  FillGrid grid, pt1, pt2
		  
		  var sandCount as integer
		  while DropSand( grid, maxRow )
		    sandCount = sandCount + 1
		  wend
		  
		  'PrintStringGrid grid
		  
		  return sandCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DropSand(grid(, ) As String, maxRow As Integer) As Boolean
		  // Return true if the sand comes to rest, false if it exceeds maxRow
		  
		  var pt as new Xojo.Point
		  pt.X = 500
		  pt.Y = 0
		  
		  if grid( pt.Y, pt.X ) <> "" then
		    return false
		  end if
		  
		  do
		    pt.Y = pt.Y + 1
		    
		    if pt.Y > maxRow then
		      return false
		    end if
		    
		    if grid( pt.Y, pt.X ) = "" then
		      continue
		    end if
		    
		    if grid( pt.Y, pt.X - 1 ) = "" then
		      pt.X = pt.X - 1
		      continue
		    end if
		    
		    if grid( pt.Y, pt.X + 1 ) = "" then
		      pt.X = pt.X + 1
		      continue
		    end if
		    
		    // At rest
		    pt.Y = pt.Y - 1
		    grid( pt.Y, pt.X ) = "o"
		    
		    return true
		  loop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FillGrid(grid(, ) As String, pt1 As Xojo.Point, pt2 As Xojo.Point)
		  var rowStep as integer = if( pt1.Y <= pt2.Y, 1, -1 )
		  var colStep as integer = if( pt1.X <= pt2.X, 1, -1 )
		  
		  for row as integer = pt1.Y to pt2.Y step rowStep
		    for col as integer = pt1.X to pt2.X step colStep
		      grid( row, col ) = "#"
		    next
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToPoint(s As String) As Xojo.Point
		  var parts() as string = s.Split( "," )
		  var pt as new Xojo.Point
		  pt.X = parts( 0 ).ToInteger
		  pt.Y = parts( 1 ).ToInteger
		  return pt
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"498\x2C4 -> 498\x2C6 -> 496\x2C6\n503\x2C4 -> 502\x2C4 -> 502\x2C9 -> 494\x2C9", Scope = Private
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
