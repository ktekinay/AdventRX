#tag Class
Protected Class Advent_2023_12_10
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
		  var grid as new ObjectGrid
		  var startPipe as Pipe = ToGrid( grid, input )
		  
		  var startingPoint as Pipe = GetStartingPoint( startPipe )
		  
		  var count as integer
		  var current as Pipe = startingPoint
		  var visited as new Dictionary
		  
		  do
		    visited.Value( current ) = nil
		    
		    count = count + 1
		    
		    var neighbors() as Pipe = current.Successors
		    for each p as Pipe in neighbors
		      if p is startPipe and count = 1 then
		        continue
		      end if
		      
		      if visited.HasKey( p ) then
		        continue
		      end if
		      
		      current = p
		      exit
		    next
		  loop until current is startPipe
		  
		  count = ( count + 1 ) \ 2
		  return count : if( IsTest, 8, 6697 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  'if not IsTest then
		  'return 0
		  'end if
		  '
		  
		  
		  
		  var grid as new ObjectGrid
		  var startPipe as Pipe = ToGrid( grid, input )
		  
		  var trail() as Pipe = GetTrail( grid, startPipe )
		  
		  const kRight as string = "→︎"
		  const kLeft as string = "←︎"
		  const kUp as string = "↑︎"
		  const kDown as string = "↓︎"
		  const kOutside as string = "o"
		  const kInside as string = "I"
		  
		  for row as integer = 0 to grid.LastRowIndex
		    for col as integer = 0 to grid.LastColIndex
		      grid( row, col ).Value = kOutside
		    next
		  next
		  
		  for i as integer = 0 to trail.LastIndex - 1
		    var this as Pipe = trail( i )
		    var nxt as Pipe = trail( i + 1 )
		    
		    var use as string
		    
		    if nxt.Row > this.Row then 
		      use = kDown
		    elseif nxt.Row < this.Row then
		      use = kUp
		    elseif nxt.Column > this.Column then
		      use = kRight
		    else
		      use = kLeft
		    end if
		    
		    this.Value = use
		  next
		  
		  startPipe.Value = "S"
		  
		  select case trail( 0 ).Value
		  case kUp
		    trail( 0 ).Value = "⇑"
		  case kDown
		    trail( 0 ).Value = "⇓"
		  case kLeft
		    trail( 0 ).Value = "⇐"
		  case kRight
		    trail( 0 ).Value = "⇒"
		  end select
		  
		  for row as integer = 0 to grid.LastRowIndex
		    ClearValue( grid, grid( row, 0 ), kOutside )
		    ClearValue( grid, grid( row, grid.LastColIndex ), kOutside )
		  next
		  for col as integer = 0 to grid.LastColIndex
		    ClearValue( grid, grid( 0, col ), kOutside )
		    ClearValue( grid, grid( grid.LastRowIndex, col ), kOutside )
		  next
		  
		  var count as integer
		  for each gm as GridMember in grid
		    if gm.Value = kOutside then
		      count = count + 1
		      gm.Value = kInside
		    end if
		  next
		  
		  print grid
		  print ""
		  
		  return count : if( IsTest, 8, 0 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ClearValue(grid As ObjectGrid, m As GridMember, outside As String)
		  if m is nil or m.Value = " " then
		    return
		  end if
		  
		  var p as Pipe = Pipe( m )
		  if p.Value = outside then
		    p.Value = " "
		    
		    var n() as GridMember = p.Neighbors( true )
		    
		    for each gm as GridMember in n
		      ClearValue( grid, gm, outside )
		    next
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetStartingPoint(s As Pipe) As Pipe
		  var grid as ObjectGrid = s.Grid
		  
		  var above as string = ValueOf( Pipe( grid.Above( s ) ) )
		  var below as string = ValueOf( Pipe( grid.Below( s ) ) )
		  var left as string = ValueOf( Pipe( grid.Left( s ) ) )
		  var right as string = ValueOf( Pipe( grid.Right( s ) ) )
		  
		  var test() as string
		  
		  test = array( "|",  "F", "7" )
		  var canAbove as boolean = test.IndexOf( above ) <> -1
		  if canAbove then
		    return Pipe( grid.Above( s ) )
		  end if
		  
		  test = array( "|",  "L", "J" )
		  var canBelow as boolean = test.IndexOf( below ) <> -1
		  if canBelow then
		    return Pipe( grid.Below( s ) )
		  end if
		  
		  test = array( "-", "L", "F" )
		  var canLeft as boolean = test.IndexOf( left ) <> -1
		  if canLeft then
		    return Pipe( grid.Left( s ) )
		  end if
		  
		  test = array( "-", "J", "7" )
		  var canRight as boolean = test.IndexOf( right ) <> -1
		  if canRight then
		    return Pipe( grid.Right( s ) )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetTrail(grid As ObjectGrid, startPipe As Pipe) As Pipe()
		  var startingPoint as Pipe = GetStartingPoint( startPipe )
		  
		  var current as Pipe = startingPoint
		  var visited as new Dictionary
		  
		  var count as integer
		  
		  var trail() as Pipe
		  trail.Add startingPoint
		  
		  do
		    count = count + 1
		    
		    visited.Value( current ) = nil
		    
		    var neighbors() as Pipe = current.Successors
		    for each p as Pipe in neighbors
		      if p is startPipe and count = 1 then
		        continue
		      end if
		      
		      if visited.HasKey( p ) then
		        continue
		      end if
		      
		      current = p
		      exit
		    next
		    
		    trail.Add current
		  loop until current is startPipe
		  
		  return trail
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToGrid(grid As ObjectGrid, input As String) As Pipe
		  var rows() as string = ToStringArray( input )
		  
		  var firstRow as string = rows( 0 )
		  var testCols() as string = firstRow.SplitBytes( "" )
		  grid.ResizeTo rows.LastIndex, testCols.LastIndex
		  
		  var startPipe as Pipe
		  
		  for rowIndex as integer = 0 to rows.LastIndex
		    var row as string = rows( rowIndex )
		    
		    var cols() as string = row.SplitBytes( "" )
		    for colIndex as integer = 0 to cols.LastIndex
		      var col as string = cols( colIndex )
		      
		      var p as new Pipe
		      p.Value = col
		      grid( rowIndex, colIndex ) = p
		      
		      if p.Value = "S" then
		        startPipe = p
		      end if
		    next colIndex
		    
		  next rowIndex
		  
		  return startPipe
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ValueOf(p As Pipe) As String
		  if p isa object then
		    return p.Value.StringValue
		  else
		    return ""
		  end if
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"..F7.\n.FJ|.\nSJ.L7\n|F--J\nLJ...", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \".F----7F7F7F7F-7....\n.|F--7||||||||FJ....\n.||.FJ||||||||L7....\nFJL7L7LJLJ||LJ.L-7..\nL--J.L7...LJS7F-7L7.\n....F-J..F7FJ|L7L7L7\n....L7.F7||L7|.L7L7|\n.....|FJLJ|FJ|F7|.LJ\n....FJL-7.||.||||...\n....L---J.LJ.LJLJ...", Scope = Private
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
