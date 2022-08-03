#tag Class
Protected Class Advent_2021_12_13
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
		  
		  // Answer is ECFHLHZF
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
		  var lastXIndex as integer
		  var lastYIndex as integer
		  var grid( -1, -1 ) as boolean = GetGrid( input, lastXIndex, lastYIndex )
		  var instructions() as pair = GetInstructions( input )
		  
		  Fold( grid, instructions( 0 ), lastXIndex, lastYIndex )
		  var display as string = ToDisplay( grid, lastXIndex, lastYIndex )
		  #pragma unused display
		  
		  return Count( grid, lastXIndex, lastYIndex )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var lastXIndex as integer
		  var lastYIndex as integer
		  var grid( -1, -1 ) as boolean = GetGrid( input, lastXIndex, lastYIndex )
		  var instructions() as pair = GetInstructions( input )
		  
		  var display as string
		  
		  for each instruction as pair in instructions
		    Fold( grid, instruction, lastXIndex, lastYIndex )
		    display = display
		  next
		  
		  display = ToDisplay( grid, lastXIndex, lastYIndex )
		  display = display
		  Print display
		  
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Count(grid(, ) As Boolean, lastXIndex As Integer, lastYIndex As Integer) As Integer
		  var count as integer
		  
		  for x as integer = 0 to lastXIndex
		    for y as integer = 0 to lastYIndex
		      if grid( x, y ) then
		        count = count + 1
		      end if
		    next y
		  next x
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Fold(grid(, ) As Boolean, instruction As Pair, ByRef lastXIndex As Integer, ByRef lastYIndex As Integer)
		  var direction as Directions = instruction.Left
		  var rowOrColumn as integer = instruction.Right
		  
		  var fromBaseLine as integer
		  
		  select case direction
		  case Directions.Up
		    do
		      fromBaseLine = fromBaseLine + 1
		      var fromY as integer = rowOrColumn + fromBaseLine
		      if fromY > lastYIndex then
		        exit
		      end if
		      var toY as integer = rowOrColumn - fromBaseLine
		      for x as integer = 0 to lastXIndex
		        grid( x, toY ) = grid( x, toY ) or grid( x, fromY )
		      next
		    loop
		    
		    lastYIndex = rowOrColumn - 1
		    
		  case Directions.Left
		    do
		      fromBaseLine = fromBaseLine + 1
		      var fromX as integer = rowOrColumn + fromBaseLine
		      if fromX > lastXIndex then
		        exit
		      end if
		      var toX as integer = rowOrColumn - fromBaseLine
		      for y as integer = 0 to lastYIndex
		        grid( toX, y ) = grid( toX, y ) or grid( fromX, y )
		      next
		    loop
		    
		    lastXIndex = rowOrColumn - 1
		    
		  end select
		  
		  grid.ResizeTo( lastXIndex, lastYIndex )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetGrid(input As String, ByRef lastXIndex As Integer, ByRef lastYIndex As Integer) As Boolean(,)
		  var parts() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine + EndOfLine )
		  var rows() as string = parts( 0 ).Split( EndOfLine )
		  
		  var xArr() as integer
		  var yArr() as integer
		  
		  for each row as string in rows
		    parts = row.Split( "," )
		    var x as integer = parts( 0 ).Trim.ToInteger
		    var y as integer = parts( 1 ).Trim.ToInteger
		    
		    lastXIndex = max( lastXIndex, x )
		    lastYIndex = max( lastYIndex, y )
		    
		    xArr.Add x
		    yArr.Add y
		  next
		  
		  var grid( -1, -1 ) as boolean
		  grid.ResizeTo lastXIndex, lastYIndex
		  
		  for i as integer = 0 to xArr.LastIndex
		    grid( xArr( i ), yArr( i ) ) = true
		  next i
		  
		  return grid
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetInstructions(input As String) As Pair()
		  var parts() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine + EndOfLine )
		  var rows() as string = parts( 1 ).Split( EndOfLine )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "\b([xy])=(\d+)"
		  
		  var result() as pair
		  for each row as string in rows
		    var direction as Directions
		    var value as integer
		    
		    var match as RegExMatch = rx.Search( row )
		    select case match.SubExpressionString( 1 )
		    case "x"
		      direction = Directions.Left
		    case "y"
		      direction = Directions.Up
		    end select
		    value = match.SubExpressionString( 2 ).ToInteger
		    
		    result.Add direction : value
		  next row
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToDisplay(grid(, ) As Boolean, lastXIndex As Integer, lastYIndex As Integer) As String
		  var display as string
		  
		  var displayBuilder() as string
		  
		  for y as integer = 0 to lastYIndex
		    var builder() as string
		    builder.ResizeTo lastXIndex
		    for x as integer = 0 to lastXIndex
		      if grid( x, y ) then
		        builder( x ) = &uFF0A
		      else
		        builder( x ) = &uFF0E
		      end if
		    next
		    displayBuilder.Add String.FromArray( builder, "" )
		  next
		  
		  display = String.FromArray( displayBuilder, EndOfLine )
		  return display
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"6\x2C10\n0\x2C14\n9\x2C10\n0\x2C3\n10\x2C4\n4\x2C11\n6\x2C0\n6\x2C12\n4\x2C1\n0\x2C13\n10\x2C12\n3\x2C4\n3\x2C0\n8\x2C4\n1\x2C10\n2\x2C14\n8\x2C10\n9\x2C0\n\nfold along y\x3D7\nfold along x\x3D5", Scope = Private
	#tag EndConstant


	#tag Enum, Name = Directions, Type = Integer, Flags = &h21
		Up
		Left
	#tag EndEnum


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
