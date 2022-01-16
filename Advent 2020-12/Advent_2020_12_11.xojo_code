#tag Class
Protected Class Advent_2020_12_11
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  IsTest = false
		  return CalculateResultA( Normalize( kInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  IsTest = false
		  
		  return CalculateResultB( Normalize( kInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  IsTest = true
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  IsTest = true
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


	#tag Property, Flags = &h21
		Private IsTest As Boolean
	#tag EndProperty


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"LLLLL.LLLL.LL..LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLL.L.LLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL\nLLLLLLLL.LLLLL.LLLLLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLLLLL.LLLLLLLLLLLLLLL.LL.LLL.LLLL.LLLLLLLL\nLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLL.LLLLLLL..LLLLLL.LLLLLLLLLL..LLLLLLLL.LLLLLLLLL.LLLLLLLLLLL\nLLLLL.LLLLLLLL.LLLLLL.LLLLLLLLL.LLLLLLLL..LLLLL.LLLLL.LLLLLLLLLLLLLLL.L.LLLLLLLLL.LLL.LLLL\nLLLLL.LLL.L..L.LLLLL.LLL.LLLLLLLLLLLLLLL.LL.LLLLLLL.L.LLL..LLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL\nLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLL.LLLLLLLLLL.LLLLLL.LL.LLLLLLLLLLLL.LLLL.LLL\nLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLL.L.LLLLLLLLLLLLL\nL.L..LLL.......LL.LL.L.L....L..............L..LL.......L...L....LL....L.L..LL.....L.L.....\nLLLLL.LLLLLLL.LLLLLLLLLL.LLLLLL.LLLLL..L.LLLLLL.LLLLL.LLLL.LLLL.LLLL.LLLLLLL.LLLL.L.LLLLLL\nLLLLL.LLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLL.L.LLL.LLLL.LLLLLLLLL.LLLLLLL.LLLLL.LL.LLLL\nLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLL.LLLLLLLLLLLL..LLLLLLLL.LLLLLLL.LLLL.LLLLLLLL\nLLLLLLLLLLLLLLLL.LLLLLLL.LLLL.L.LLLLLLLLLLLLLLL.LLLLLLLLLL.LLLLLLLLLL.LLLLL.LLLLL.LL.LLLLL\nL.LLL.LLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLL.L.LL.L.LLL.LLLL.LLLLLLLLLLLLLLLLL.L.LL.LLLLLLLL\nLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLL.LLLL.LLL.LLLLLL.LLLLL.LLLL.LLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL\nLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLL.LL.LL..LLLLL.LLLL.LLLLL.LLL.L.LLL.L.LLLL.L.LLLLLL\nLLLLL.LLLLLLLL.LLLLLLLLL.LLLL.LLLLLLLLLL.LLLLLL.LLLLL.LLLL.LLLLLLLLL.LLLLLLLLLLLL.LLLLLLLL\n.LLL..LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLLLLL.LLLL.L.LLLLL.L.LLLLLLLLLLLL.LLLLLLLL\nL.L.L.....LLL...L...L..LL...L.LL......LLLL.L.LL..LLL.L..L.......L..L.L....LLL.....L.L...L.\nLLLLL.LLLL.LLLLLLLLLLLLL.LLLLLL.LL.LLLLL.LLLLLLL.LLLL.LLLL.LLLL.LLL.LLLLLLLL.LLLLLLLLLLLLL\nLLLLL.L.LLLLLLL.LL.LLLLL.L.LLLLLLLLLLLLL.LLLLLL.LLLLL.LLLLLLLLLLLLLLLLLLLLLL..LLL.LLLLLLLL\nLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLL.LLLLL.L..L.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLL.\nLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLL.L.L.LLL.LLLL.LLLLL.LLL.LLLLLLLLLLLL.LLLLLLLL\nLLL.L.LLLLLL.L.LL.LLLLLL.LLLLLL.LLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLL.L\nLL.LL.L.LLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLL.LLLLL.LLLL.LLLLLLLLL.L.LLLLLLLLLL.LLLLLLL.\nLLLLL.LLLL.LLLLLLLL.LL.L.LLLLLLLLLLLLLLL.LL.LLL.LLLLL.LLLL.LLLLLLLLL.LLLLLLL.LLLL.LL.LLLLL\nLL.........LLL..LL.L...L...L.....L...LL.....L..LLL........LL.L.LL.L......L...........L.LL.\nLLLLLLLLLLLLL.LLLLLLLL.LLLLLLLL.LLLLLLLL..LLLLL.LLLLL.LLLL.LLLLLLLLL.LLLLLLL.LLLL.LLLLLL.L\nLLLLLLLLLLLLLL.LLLLLLLL..LLLLLL.LLLLL.LL.LLLLL.LLLLLLLLLLL.LLLLLLLLL.LLLLLLL.LLLLLLLLLLLLL\nLLLL..LLL.LLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLL.LLLLL.LLLL.LLLLLLLLL.L.LLLLL.LLL..LLLLLLLL\nLLLLLLLLLLLL.L.LLLLLLLLL.LLLL.L.LL.LLLLL.LLLLLL.LLLLL.LLLLLLLLLLLLLL.LLLLLLL.LLLLLLLLLLLLL\n.LLLLLLLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLLL.L.LLLL.LLLLL.LLLL.LLLLL.LLLLLLLLLLLLLLLL.LLLLLLLL\nLLLLL.LL.LLLLL.LLLL.LLLL.LLL.LL.LLLLLLLLLLLLLLLLLLLLL.LLLL.LLLL.LLLL.LLLLLLL.LLLL.LLLLLLLL\nLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLLLLL.LL.L.LLLLLL.LL.LL.LLLL.LLLLLLLLLLLLLLLLL.LLLLL.LLLLLL.\nLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLL.L.LL...LLL.LLLLLL.LLLLLLLLLLLLLLLLLLLLLLLL\n...LL....L.L.L........L.L..LL..LL.L..L...LLL..L.LL.LL.....L.....LL.L..LLL.LL.LL..LL...L...\nLLLLLLLLLLLLLL.LLLLLLLLL.LLL.LL.LLLLLLLL.LLLLLLLLLLLLLLLL..LLLLLLLLLLLLLLLL..LLLL.LLLLLLLL\nLLLLL..LLLLLLL.LLLLLLL.LL..LLLL.LLLLLLLLLLLL.LL.LLLLL.LLLL.LLLLLL.LLLLLLLLLL.LLLLLLLLLLLLL\nLLLLLLLLLLLLL.LLLLLLLLL..LLLLLL.LLLLLLLLLLLL.LL.LLLLLLLLLLLLLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL\nLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLLL.LLLLLLLLL.LLLLLLL.L.LL.LL.LLLLL\nLLLLL.LLLLL.LLLLLLLLLLLL.LLLL.L.LLLLLLLL.LLLLLL.LL.LL.LLLLLLLLLLLLL...LLLLLL.LLLLLLLLLLLLL\nLLLLLL.LLLLL.L.LLL.LLLLL.LLLL.L.LLLLL.LL.LLLLLL..LLLL.LLLLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLLL.\nLLLLL.LLLLLLL..LLLLLLLLL..LLLLL.LLLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLLLLL.LLLLLLL.L.LLLLLLLLLLL\nLLLLL.LLLLLLLL.LLLLLLLLL..LLLL..LLLLLLLL.LLLLLL.LL.LL.LLLLLL.LLLL.L..LLLLLLL.LL.L.LLLLLLLL\n.LL..L....L..LLL.L......LL..L.L.....LLL.....L.LLL.....L...L.......L...LLL...LL...L........\nLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLL.LLLL.LLL.LLLLLL.LLLLL.LLLL.L.LLLLLLL.LLLLLLL.LLL..LLLLLLLL\nLLLLL.LLLL.LLL.LLLLLLLLL.LLLLLL.LLLLLLLL.LL.LLLLLLLLL.LLLL..LLL.LLLL.LLLLLLL.LLLL.LLLLLLLL\nLL.LL.LLLLLLLL.LLLLLLLLL.LLLLLL..LLLLL.L.LLLLLL..LLLL.LLLL.LL.LLLL.LLLLLLLLLLLLLL.LLLLLLL.\nLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLLL.LL.L.LLLLLLLLLLLLLLLLL.LLLLLLLLLLLLL\nL...L.L....L..L...LLL.L..LLLLL.........LL.....LL...L....L..............L.L.L...LL.LL...LL.\nLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLL...LLLLLLLLLLL.LLLL.LL.LLLLL..LLLLLLL.LLLL.LLLLLLLL\nLLLLL.LL.LLLLL.LLLLLLLLL.LLLLLL..LLLLLLLLLLL.LL.LLLLL.LLLL.LLLLLLLLLLLLLLLLL.LLLL.LL.LLLLL\nLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLL.LLLLLLLLLLLLLLLLLLLLLL.LLLLLLLL\nLLLLLLLLLL.LLL.LL.LLLLLL.LLLLLLLLLLLLLLL.L.LLLL.LLLLL.LLLL.LLLLLLLLLLLLLLLLL.LLLL.L.LLLLLL\nLLL.L.LLLLLLLL.LLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLL.LLLL.LLL.LLLL\nLLLLL.LLLLLLL..LLLLLLLLLLLLLLLL.LLLLLLLL.LLLLLL.LLLLL.LL.L.LLLLLLLLLLLLLL.LLLLLLLLLLLLLL.L\n...LL.......LLLL.L..LL..L.LL.L.L..L.........L.L..LLL............L.L.LL..L.LL.L..LL........\nLLLLL.LLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLL.LLLL.LLL.LLLLL.LLLLLLLLLLLL.LLLLLLLL\nL.LLLLLLLLL.LLLLLLLLLLLL.LLLLLL.LLLLLLLL.LLLLLLLLLLLL.LLLL.LLLLLLLLL.LLLLLLL.LLLLLLLLLLL.L\nLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL\nLLLLL.LLLLLLLL.LLLLLL.LL.LLLLLL.LLLLLLLLLLLLLLL.LLLLL.LLLL.LLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL\nLLLLL.LLLL.LLL..LLLLLLLLLLLLLLL.LLLLLLLL.LLLLLL.LLLL..LLLL.LLLLLLLLLLLLLLLLLLLLLL.LLLLLLLL\nLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLL.LLLLL.LLLL.L.LLLLLLLLL.LLLLL.LLLLLLLLLLL.L\nLLLLL.LLLLLLLLLLLLLLLLL..LLLLLLLLLLL.LLL.LLLLLL.LLL.LLLLLL.LLLLLLLLLL.LLLLLL.LLLL.LL.LLLLL\n..L..L....LL.L............L....LL.........LLLL.L.L........L..L...LLL.....L.......LL..L..LL\nLLLLL.L.LLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLL.LLL.LLLLL.LLLL.LLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL\nLLLLLLLLLLLL.LLLLLLLLL.L.LLLLLL.LLLLLLLL.L.LLLL.LLLLL.LLLL..LLLLLLLL.LLLLLLL.LLLLLLLLLLLLL\nLLLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLLLLLLLLL.LLLLL..L.LLL..LLLLLLLLLLLLL.LLLLLLL.LLLL.LLLLLLLL\nLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLL..LLLLLLLLLLLLLLLL.LLLLLLLL.LLLLLLLLL.L.LLLLLLLLLLLLLLLLLLL\n.L..L...L.....LL...........L.LL..LL...LL.LLL..........L.L.LL..L.LLL...L....LL.LL....LLL.LL\nLLLLL.L.LLLL.LLLLLLLLLLLLLLLLLL.LL.LLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLLLLL.LLLLL\nLLLLL.LLLLLLLLLLL.L.LLLLLLLLLLLL.LLLLLLL.LLLLL..L.LLL.LLLLLLL.LLLLLL.LLLLLLL..LLL.LLLLLLL.\nLLLLLLLLLLLLLL.L.LLLLLLL.LLLLLLLLLL.LLLL.LLLLLL.LLLLL.LLLLLLLLLLLL.LLLLLLLLLLL.LLL.LLLLLLL\nLLLLL.LL.LLLLLLLLLLLLLLL.LLLLLL.LLLLL.LL.LLLLLL.LLLLL.LLLLLLLLLLLLLL.LLLLLLLLLLLL.LLLLLLLL\nLL..L.LLLLLLLL.LLLLLLL.L.LLLL.LLLLL.LLLLLLLLLLLL.LLL..LLLL.LLLLLLLL..LLLL.L..LLLLLLLLLLL.L\nLLLLLLLLLLLLLLLLLLLLLLLL.LLL.LL.LLLL.LLL.LLLLLL.LLLLL.LLLL.LLLLLLLLL.LLLLLLLLLLLL.LLLLLLLL\nLLLLLLLLLLLLLLLLLLLLLLLL.LLLL.L.LLLLLLLLLLLLLLL.L.LLLLLLLL..LLLLLLLL.LLLLLLLLLLLLLLLLLLLLL\nLLLLL.LLLLLLLL.L.LLLLLLL.LLLLLL..LLL.LLL.LLLLLL.LLLLL.LLLL.LLLLLLLLLLLLLLLLL.LLLLLLLLLLLLL\n.L.L.L.....LL.LL.LL...LL.L..LL........LL.......L..LLLL..L.L.LL....L...L....L.L.L...L..L...\nLLLLL..LLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLL..LLLLLLL.LLLL.LLLLLLLL\nLLLLL.LLLL.LLL.LLLLLLLLL.LLLLLLLLLLLLLL..LLLLLLLLLLLL.LLLLLLLLLLLLLL.LLLLLLLLLLLL.LLL.LLLL\n.LLLLLLLLLLLLL..LLLLLLLLLLLLLLL.LLLLLLLL.LLLLLL.L.LLL.LLLLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLLLL\nLLLLL.LLLLLLLL.LLLLLLLLL.LLLLL..LL.LLLL.LLLLLLL.LL.LL.LLLL.LLLLLLLLLLLLLL..L.L..L.LLLLLLLL\nLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLL.LLLLL.L..LLLLLLLLLLLL.LLLL.LLLLLLLLL.LLLLLLL.LLLLLLLLLLLLL\nLLLLL.LLLL.LLLL.LLL.LLLL.LLLLLL.LLLLLLLL.LLLLLL.LLLLL.LLLLLLLLLLLLLL..LLLLLL.LLLLLLLLLLLLL\nLLLLLLLLLLLLLL..LLLL.LLL.LLLLLL.LLLLLLLL.LLLLLL.LLLLL..LLL.LLLLLLLLL.LLLLLLLLL.L..LLLLLLLL\n..LLL..L..L.LL..LLL....L..L...L.L.L.L.L.L.L.LLL..LLL..L...L.......LLL..L.....LL...LL....L.\nLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLL.LLLLL.LLLLLLLLL.LLLL.LLLLLLLLL.LLLL.LLLLLLL.LLLLLLLL\nLLLLL.LLLLLLLLLLLLLL.LLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LL.LLLL.LLLLLLL.L.LLLLLLLLLLLL.LLLLLLLL\nLLLLL.LLLL.LLL.LLLLLLLLL.LLLLLLLLLLLLLLL..LLLLL.LLLLL.LLLL..LL..LLLL.LLLLLLL.LLLL.LLLLLLLL\nLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLL.LLLLLL.LLLLLLLLLL..LLLL.LL..LLLLLLL.LLLLLLLLLLLLL\nLLLLLLLLLLLLLL.LL.LLLLLL.LLLL.L..LLLLLLL.LLL.LL.LLLLLLLLLL.LLLLLLLLL.L.LLLLL.LLLL.LLLLLL.L", Scope = Private
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
