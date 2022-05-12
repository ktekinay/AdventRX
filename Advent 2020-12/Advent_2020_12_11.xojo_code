#tag Class
Protected Class Advent_2020_12_11
Inherits AdventBase
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
		  return CalculateResultB( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var g as SeatGrid = ParseInput( input )
		  
		  if g is nil then
		    return -1
		  end if
		  
		  do
		    if IsTest then
		      print g
		      print ""
		    end if
		    
		    var changed() as Seat
		    
		    for row as integer = 0 to g.LastRowIndex
		      for col as integer = 0 to g.LastColIndex
		        var s as Seat = g( row, col )
		        if s is nil then
		          continue
		        end if
		        
		        s.NextState = s.State
		        
		        var occupiedCount as integer = CountOccupiedNeighbors( s )
		        
		        select case s.State
		        case Seat.States.Vacant
		          if occupiedCount = 0 then
		            s.NextState = Seat.States.Occupied
		            changed.Add s
		          end if
		          
		        case Seat.States.Occupied
		          if occupiedCount >= 4 then
		            s.NextState = Seat.States.Vacant
		            changed.Add s
		          end if
		          
		        end select
		        
		      next
		    next
		    
		    if changed.Count = 0 then
		      exit
		    end if
		    
		    for each s as Seat in changed
		      s.State = s.NextState
		    next
		  loop 
		  
		  if IsTest then
		    print g
		    print ""
		  end if
		  
		  var occupiedCount as integer = CountOccupied( g )
		  return occupiedCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var g as SeatGrid = ParseInput( input )
		  
		  if g is nil then
		    return -1
		  end if
		  
		  do
		    if IsTest then
		      print g
		      print ""
		    end if
		    
		    var changed() as Seat
		    
		    for row as integer = 0 to g.LastRowIndex
		      for col as integer = 0 to g.LastColIndex
		        var s as Seat = g( row, col )
		        if s is nil then
		          continue
		        end if
		        
		        s.NextState = s.State
		        
		        var occupiedCount as integer = CountOccupiedNeighborsExtended( s )
		        
		        select case s.State
		        case Seat.States.Vacant
		          if occupiedCount = 0 then
		            s.NextState = Seat.States.Occupied
		            changed.Add s
		          end if
		          
		        case Seat.States.Occupied
		          if occupiedCount >= 5 then
		            s.NextState = Seat.States.Vacant
		            changed.Add s
		          end if
		          
		        end select
		        
		      next
		    next
		    
		    if changed.Count = 0 then
		      exit
		    end if
		    
		    for each s as Seat in changed
		      s.State = s.NextState
		    next
		  loop 
		  
		  if IsTest then
		    print g
		    print ""
		  end if
		  
		  var occupiedCount as integer = CountOccupied( g )
		  return occupiedCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountOccupied(g As SeatGrid) As Integer
		  var occupiedCount as integer
		  
		  for row as integer = 0 to g.LastRowIndex
		    for col as integer = 0 to g.LastColIndex
		      var s as Seat = g( row, col )
		      if s isa object and s.State = Seat.States.Occupied then
		        occupiedCount = occupiedCount + 1
		      end if
		    next col
		  next row
		  
		  return occupiedCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountOccupiedNeighbors(s As Seat) As Integer
		  var count as integer
		  
		  var neighbors() as GridMember = s.Neighbors( true )
		  for each n as GridMember in neighbors
		    if n isa object and Seat( n ).State = Seat.States.Occupied then
		      count = count + 1
		    end if
		  next
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountOccupiedNeighborsExtended(s As Seat) As Integer
		  var g as SeatGrid = SeatGrid( s.Grid )
		  
		  var occupiedCount as integer
		  
		  for row as integer = s.Row - 1 downto 0
		    var n as Seat = g( row, s.Column )
		    if n isa object then
		      if n.State = Seat.States.Occupied then
		        occupiedCount = occupiedCount + 1
		      end if
		      exit
		    end if
		  next
		  
		  for row as integer = s.Row + 1 to g.LastRowIndex
		    var n as Seat = g( row, s.Column )
		    if n isa object then
		      if n.State = Seat.States.Occupied then
		        occupiedCount = occupiedCount + 1
		      end if
		      exit
		    end if
		  next
		  
		  for col as integer = s.Column - 1 downto 0
		    var n as Seat = g( s.Row, col )
		    if n isa object then
		      if n.State = Seat.States.Occupied then
		        occupiedCount = occupiedCount + 1
		      end if
		      exit
		    end if
		  next
		  
		  for col as integer = s.Column + 1 to g.LastColIndex
		    var n as Seat = g( s.Row, col )
		    if n isa object then
		      if n.State = Seat.States.Occupied then
		        occupiedCount = occupiedCount + 1
		      end if
		      exit
		    end if
		  next
		  
		  var row as integer
		  var col as integer
		  
		  row = s.Row - 1
		  col = s.Column - 1
		  
		  while row >= 0 and col >= 0
		    var n as Seat = g( row, col )
		    if n isa object then
		      if n.State = Seat.States.Occupied then
		        occupiedCount = occupiedCount + 1
		      end if
		      exit
		    end if
		    
		    row = row - 1
		    col = col - 1
		  wend
		  
		  row = s.Row - 1
		  col = s.Column + 1
		  
		  while row >= 0 and col <= g.LastColIndex
		    var n as Seat = g( row, col )
		    if n isa object then
		      if n.State = Seat.States.Occupied then
		        occupiedCount = occupiedCount + 1
		      end if
		      exit
		    end if
		    
		    row = row - 1
		    col = col + 1
		  wend
		  
		  row = s.Row + 1
		  col = s.Column - 1
		  
		  while row <= g.LastRowIndex and col >= 0
		    var n as Seat = g( row, col )
		    if n isa object then
		      if n.State = Seat.States.Occupied then
		        occupiedCount = occupiedCount + 1
		      end if
		      exit
		    end if
		    
		    row = row + 1
		    col = col - 1
		  wend
		  
		  row = s.Row + 1
		  col = s.Column + 1
		  
		  while row <= g.LastRowIndex and col <= g.LastColIndex
		    var n as Seat = g( row, col )
		    if n isa object then
		      if n.State = Seat.States.Occupied then
		        occupiedCount = occupiedCount + 1
		      end if
		      exit
		    end if
		    
		    row = row + 1
		    col = col + 1
		  wend
		  
		  return occupiedCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As SeatGrid
		  var rows() as string = ToStringArray( input )
		  
		  if rows.Count = 0 then
		    return nil
		  end if
		  
		  var g as new SeatGrid
		  g.ResizeTo rows.LastIndex, rows( 0 ).Bytes - 1
		  
		  for row as integer = 0 to rows.LastIndex
		    var chars() as string = rows( row ).Split( "" )
		    for col as integer = 0 to chars.LastIndex
		      select case chars( col )
		      case "."
		        //
		        // Nothing
		        //
		      case "L"
		        var s as new Seat
		        s.State = Seat.States.Vacant
		        g( row, col ) = s
		        
		      case "#"
		        var s as new Seat
		        s.State = Seat.States.Occupied
		        g( row, col ) = s
		        
		      end select
		    next
		  next
		  
		  return g
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"L.LL.LL.LL\nLLLLLLL.LL\nL.L.L..L..\nLLLL.LL.LL\nL.LL.LL.LL\nL.LLLLL.LL\n..L.L.....\nLLLLLLLLLL\nL.LLLLLL.L\nL.LLLLL.LL", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
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
