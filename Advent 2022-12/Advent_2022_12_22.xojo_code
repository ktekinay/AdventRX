#tag Class
Protected Class Advent_2022_12_22
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Unknown"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return false
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return ""
		  
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
		Private Function CalculateResultA(input As String) As Integer
		  var grid as ObjectGrid
		  var instructions() as string
		  ParseInput input, grid, instructions
		  
		  var final as GridMember
		  var facing as Facings = Facings.Right
		  
		  Follow grid, instructions, final, facing
		  
		  var result as integer = ( ( final.Row + 1 ) * 1000 ) + ( ( final.Column + 1 ) * 4 ) + integer( facing )
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Follow(grid As ObjectGrid, instructions() As String, ByRef final As GridMember, ByRef facing As Facings)
		  //
		  // Get the starting member
		  //
		  var current as GridMember
		  
		  for each member as GridMember in grid
		    if member isa object and member.Value = "." then
		      current = member
		      exit
		    end if
		  next
		  
		  var directionals() as ObjectGrid.NextDelegate
		  directionals.Add AddressOf NextRight
		  directionals.Add AddressOf NextDown
		  directionals.Add AddressOf NextLeft
		  directionals.Add AddressOf NextUp
		  
		  var directional as ObjectGrid.NextDelegate = directionals( 0 )
		  
		  for each instruction as string in instructions
		    if instruction = "R" then
		      if facing = Facings.Up then
		        facing = Facings.Right
		      else
		        facing = Facings( integer( facing ) + 1 )
		      end if
		      directional = directionals( integer( facing ) )
		      continue
		      
		    elseif instruction = "L" then
		      if facing = Facings.Right then
		        facing = Facings.Up
		      else
		        facing = Facings( integer( facing ) - 1 )
		      end if
		      directional = directionals( integer( facing ) )
		      continue
		      
		    end if
		    
		    var distance as integer = instruction.ToInteger
		    
		    for i as integer = 1 to distance
		      var nextMember as GridMember = directional.Invoke( current )
		      if nextMember is nil then
		        exit
		      end if
		      current = nextMember
		    next
		    
		  next
		  
		  final = current
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NextDown(member As GridMember) As GridMember
		  var grid as ObjectGrid = member.Grid
		  
		  var row as integer = member.Row
		  var col as integer = member.Column
		  
		  do
		    row = row + 1
		    if row > grid.LastRowIndex then
		      row = 0
		    end if
		    
		    var nextMember as GridMember = grid( row, col )
		    if nextMember is nil then
		      continue
		    end if
		    
		    if nextMember.Value = "." then
		      return nextMember
		    end if
		    
		    return nil
		  loop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NextLeft(member As GridMember) As GridMember
		  var grid as ObjectGrid = member.Grid
		  
		  var row as integer = member.Row
		  var col as integer = member.Column
		  
		  do
		    col = col - 1
		    if col < 0 then
		      col = grid.LastColIndex
		    end if
		    
		    var nextMember as GridMember = grid( row, col )
		    if nextMember is nil then
		      continue
		    end if
		    
		    if nextMember.Value = "." then
		      return nextMember
		    end if
		    
		    return nil
		  loop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NextRight(member As GridMember) As GridMember
		  var grid as ObjectGrid = member.Grid
		  
		  var row as integer = member.Row
		  var col as integer = member.Column
		  
		  do
		    col = col + 1
		    if col > grid.LastColIndex then
		      col = 0
		    end if
		    
		    var nextMember as GridMember = grid( row, col )
		    if nextMember is nil then
		      continue
		    end if
		    
		    if nextMember.Value = "." then
		      return nextMember
		    end if
		    
		    return nil
		  loop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NextSquareFor(member As GridMember, directional As ObjectGrid.NextDelegate, distance As Integer) As GridMember
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NextUp(member As GridMember) As GridMember
		  var grid as ObjectGrid = member.Grid
		  
		  var row as integer = member.Row
		  var col as integer = member.Column
		  
		  do
		    row = row - 1
		    if row < 0 then
		      row = grid.LastRowIndex
		    end if
		    
		    var nextMember as GridMember = grid( row, col )
		    if nextMember is nil then
		      continue
		    end if
		    
		    if nextMember.Value = "." then
		      return nextMember
		    end if
		    
		    return nil
		  loop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseInput(input As String, ByRef grid As ObjectGrid, ByRef instructions() As String)
		  var parts() as string = input.Split( EndOfLine + EndOfLine )
		  
		  var rows() as string = parts( 0 ).Split( EndOfLine )
		  
		  grid = new Advent.ObjectGrid
		  grid.ResizeTo rows.LastIndex, rows( 0 ).Length - 1
		  
		  for rowIndex as integer = 0 to rows.LastIndex
		    var chars() as string = rows( rowIndex ).Split( "" )
		    if grid.LastColIndex < chars.LastIndex then
		      grid.ResizeTo grid.LastRowIndex, chars.LastIndex
		    end if
		    
		    for colIndex as integer = 0 to chars.LastIndex
		      var char as string = chars( colIndex )
		      if char <> "." and char <> "#" then
		        continue
		      end if
		      var member as new GridMember( char )
		      grid( rowIndex, colIndex ) = member
		    next
		  next
		  
		  var rx as new RegEx
		  rx.SearchPattern = "\d+|[rl]"
		  
		  var match as RegExMatch = rx.Search( parts( 1 ) )
		  while match isa object
		    instructions.Add match.SubExpressionString( 0 )
		    match = rx.Search
		  wend
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"        ...#\n        .#..\n        #...\n        ....\n...#.......#\n........#...\n..#....#....\n..........#.\n        ...#....\n        .....#..\n        .#......\n        ......#.\n\n10R5L5R10L4R5L5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Enum, Name = Facings, Type = Integer, Flags = &h21
		Right = 0
		  Down = 1
		  Left = 2
		Up = 3
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
