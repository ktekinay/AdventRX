#tag Class
Protected Class Advent_2023_12_10
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "A loop and all it encloses"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Pipe Maze"
		  
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
		  
		  var trail() as Pipe = GetTrail( grid, startPipe )
		  var count as integer = ( trail.Count + 1 ) \ 2
		  
		  return count : if( IsTest, 8, 6697 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  'if not IsTest then
		  'return 0
		  'end if
		  
		  
		  const kInside as string = "I"
		  const kOutside as string = "o"
		  
		  var grid as new ObjectGrid
		  var startPipe as Pipe = ToGrid( grid, input )
		  
		  var trail() as Pipe = GetTrail( grid, startPipe )
		  for each gm as GridMember in trail
		    gm.RawValue = gm.Value
		  next
		  
		  const kRight as string = "→︎"
		  const kLeft as string = "←︎"
		  const kUp as string = "↑︎"
		  const kDown as string = "↓︎"
		  
		  for each gm as GridMember in grid
		    gm.Value = kOutside
		  next
		  
		  for i as integer = 0 to trail.LastIndex
		    var this as Pipe = trail( i )
		    var nxt as Pipe = if( i = trail.LastIndex, trail( 0 ), trail( i + 1 ) )
		    
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
		  
		  for each p as Pipe in trail
		    select case p.Value
		    case kRight
		      Mark( grid, grid.Below( p ), kOutside, kInside )
		      if p.RawValue = "7" then
		        Mark( grid, grid.Left( p ), kOutside, kInside )
		      elseif p.RawValue = "J" then
		        Mark( grid, grid.Right( p ), kOutside, kInside )
		      elseif p.RawValue = "L" then
		        Mark( grid, grid.Left( p ), kOutside, kInside )
		      elseif p.RawValue = "J" then
		        Mark( grid, grid.Right( p ), kOutside, kInside )
		      end if
		    case kDown
		      Mark( grid, grid.Left( p ), kOutside, kInside )
		      if p.RawValue = "J" then
		        Mark( grid, grid.Above( p ), kOutside, kInside )
		      elseif p.RawValue = "L" then
		        Mark( grid, grid.Below( p ), kOutside, kInside )
		      end if
		    case kLeft
		      Mark( grid, grid.Above( p ), kOutside, kInside )
		      if p.RawValue = "L" then
		        Mark( grid, grid.Right( p ), kOutside, kInside )
		      elseif p.RawValue = "F" then
		        Mark( grid, grid.Left( p ), kOutside, kInside )
		      end if
		    case kUp
		      Mark( grid, grid.Right( p ), kOutside, kInside )
		      if p.RawValue = "F" then
		        Mark( grid, grid.Below( p ), kOutside, kInside )
		      elseif p.RawValue = "7" then
		        Mark( grid, grid.Above( p ), kOutside, kInside )
		      end if
		    end select
		  next
		  
		  var count as integer
		  for each gm as GridMember in grid
		    if gm.Value = kInside then
		      count = count + 1
		    end if
		  next
		  
		  return count : if( IsTest, 8, 423 )
		  
		End Function
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
		Private Sub Mark(grid As ObjectGrid, m As GridMember, fromMark As String, toMark As String)
		  if m is nil or m.Value <> fromMark then
		    return
		  end if
		  
		  m.Value = toMark
		  
		  var p as Pipe = Pipe( m )
		  var n() as GridMember = p.Neighbors( false )
		  
		  for each gm as GridMember in n
		    Mark( grid, gm, fromMark, toMark )
		  next
		  
		End Sub
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
