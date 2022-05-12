#tag Class
Protected Class Advent_2021_12_23
Inherits AdventBase
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
		Private Function AreAllHome(amphipods() As Amphipod) As Boolean
		  for each a as Amphipod in amphipods
		    if a.Row = kRowHall or a.Column <> a.TargetColumn then
		      return false
		    end if
		  next
		  
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  BestMinimum = kInfiniteEnergy
		  
		  var grid( -1, -1 ) as Amphipod
		  var amphipods() as Amphipod
		  
		  GetGrid input, grid, amphipods
		  var energy as integer = StartTheCommotion( grid, amphipods, 0, 0 )
		  return energy
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  BestMinimum = kInfiniteEnergy
		  
		  var grid( -1, -1 ) as Amphipod
		  var amphipods() as Amphipod
		  
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  rows.AddAt rows.LastIndex - 1, kInsertForB.ReplaceLineEndings( EndOfLine )
		  input = String.FromArray( rows, EndOfLine )
		  
		  GetGrid input, grid, amphipods
		  var energy as integer = StartTheCommotion( grid, amphipods, 0, 0 )
		  return energy
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CanMoveHome(a As Amphipod, grid(, ) As Amphipod) As Integer
		  for testRow as integer = a.Row - 1 downto kRowHall + 1
		    if grid( testRow, a.Column ) isa object then
		      //
		      // Something is in the way
		      //
		      return -1
		    end if
		  next
		  
		  //
		  // We have to check the path
		  //
		  var stepper as integer = if( a.Column > a.TargetColumn, -1, 1 )
		  var startColumn as integer = a.Column
		  var endColumn as integer = a.TargetColumn
		  
		  for col as integer = startColumn to endColumn step stepper
		    var thisSquare as Amphipod = grid( kRowHall, col )
		    if thisSquare isa object and not ( thisSquare is a ) then
		      return -1
		    end if
		  next
		  
		  //
		  // Check the target column
		  //
		  for testRow as integer = LastRowIndex downto kRowHall + 1
		    var target as Amphipod = grid( testRow, a.TargetColumn )
		    if target is nil then
		      return testRow
		    elseif target.Letter <> a.Letter then
		      return -1
		    end if
		  next
		  
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CanMoveTo(a As Amphipod, grid(, ) As Amphipod, row As Integer, col As Integer) As Boolean
		  if row = kRowHall and ( col = 2 or col = 4 or col = 6 or col = 8 ) then
		    //
		    // In front of a room
		    //
		    return false
		  end if
		  
		  for testRow as integer = a.Row - 1 downto kRowHall + 1
		    var square as Amphipod = grid( testRow, a.Column )
		    if square isa object and not ( square is a ) then
		      return false
		    end if
		  next
		  
		  var stepper as integer = if ( a.Column < col, 1, -1 )
		  for testCol as integer = a.Column to col step stepper
		    var square as Amphipod = grid( kRowHall, testCol )
		    if square isa object and not ( square is a ) then
		      return false
		    end if
		  next
		  
		  for testRow as integer = kRowHall + 1 to row
		    var square as Amphipod = grid( testRow, col )
		    if square isa object and not ( square is a ) then
		      return false
		    end if
		  next
		  
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetGrid(input As String, grid(, ) As Amphipod, amphipods() As Amphipod)
		  var rx as new RegEx
		  rx.SearchPattern = "[ABCD]"
		  
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  LastRowIndex = rows.LastIndex - 2
		  grid.ResizeTo LastRowIndex, rows( 0 ).Bytes - 3
		  
		  for rowIndex as integer = 1 to rows.LastIndex
		    var row as string = rows( rowIndex )
		    var match as RegExMatch = rx.Search( row )
		    while match isa object
		      var letter as string = match.SubExpressionString( 0 )
		      var a as Amphipod = Amphipod.FromLetter( letter )
		      a.Row = rowIndex - 1
		      a.Column = match.SubExpressionStartB( 0 ) - 1
		      
		      grid( a.Row, a.Column ) = a
		      amphipods.Add a
		      
		      match = rx.Search
		    wend
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsAlreadyHome(a As Amphipod, grid(, ) As Amphipod) As Boolean
		  if a.Column <> a.TargetColumn then
		    return false
		  end if
		  
		  if a.Row = kRowHall then
		    return false
		  end if 
		  
		  for testRow as integer = LastRowIndex downto kRowHall + 1
		    var thisSquare as Amphipod = grid( testRow, a.Column )
		    if thisSquare is a then
		      return true
		    end if
		    
		    if thisSquare is nil then
		      break
		      
		    elseif thisSquare.Letter <> a.Letter then
		      //
		      // Has to move
		      //
		      return false
		    end if
		  next
		  
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MoveTo(a As Amphipod, grid(, ) As Amphipod, row As Integer, col As Integer) As Integer
		  //
		  // Assumes the path is clear
		  //
		  
		  var energy as integer = ( a.Row + abs( a.Column - col ) ) * a.Energy // Into and along the hall
		  energy = energy + ( row * a.Energy )
		  
		  grid( a.Row, a.Column ) = nil
		  grid( row, col ) = a
		  
		  a.Row = row
		  a.Column = col
		  
		  return energy
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function StartTheCommotion(grid(, ) As Amphipod, amphipods() As Amphipod, usedSoFar As Integer, runningEnergy As Integer) As Integer
		  if AreAllHome( amphipods ) then
		    BestMinimum = min( BestMinimum, runningEnergy )
		    return usedSoFar
		  end if
		  
		  var minEnergyUsed as integer = kInfiniteEnergy
		  
		  for each candidate as Amphipod in amphipods
		    var candidateLetter as string = candidate.Letter
		    #pragma unused candidateLetter
		    
		    if IsAlreadyHome( candidate, grid ) then
		      continue
		    end if
		    
		    var startRow as integer = candidate.Row
		    var startCol as integer = candidate.Column
		    var myEnergyUsed as integer
		    
		    var bestRow as integer = CanMoveHome( candidate, grid )
		    
		    if bestRow <> -1 then
		      myEnergyUsed = MoveTo( candidate, grid, bestRow, candidate.TargetColumn )
		      
		      if ( myEnergyUsed + runningEnergy ) < BestMinimum then
		        myEnergyUsed = StartTheCommotion( grid, amphipods, myEnergyUsed, myEnergyUsed + runningEnergy )
		        if myEnergyUsed <> kInfiniteEnergy then
		          minEnergyUsed = min( minEnergyUsed, myEnergyUsed )
		        end if
		      end if
		      
		      call MoveTo( candidate, grid, startRow, startCol )
		      
		    elseif candidate.Row = kRowHall then
		      //
		      // Next move has to be home
		      //
		      continue
		      
		    elseif candidate.Row = LastRowIndex and grid( candidate.Row, LastRowIndex - 1 ) isa object then
		      //
		      // Can't move anywhere
		      //
		      continue
		      
		    else
		      //
		      // Try every hall point
		      //
		      for hallColumn as integer = 0 to kLastColumnIndex
		        if CanMoveTo( candidate, grid, kRowHall, hallColumn ) then
		          myEnergyUsed = MoveTo( candidate, grid, kRowHall, hallColumn )
		          
		          if ( myEnergyUsed + runningEnergy ) < BestMinimum then
		            MyEnergyUsed = StartTheCommotion( grid, amphipods, myEnergyUsed, myEnergyUsed + runningEnergy )
		            if myEnergyUsed <> kInfiniteEnergy then
		              minEnergyUsed = min( minEnergyUsed, MyEnergyUsed )
		            end if
		          end if
		          
		          call MoveTo( candidate, grid, startRow, startCol )
		        end if
		        
		      next
		      
		    end if
		    
		  next
		  
		  if minEnergyUsed = kInfiniteEnergy then
		    return minEnergyUsed
		  else
		    return minEnergyUsed + usedSoFar
		  end if
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private BestMinimum As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LastRowIndex As Integer
	#tag EndProperty


	#tag Constant, Name = kInfiniteEnergy, Type = Double, Dynamic = False, Default = \"&hFFFFFFFFFFFFFF", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kInsertForB, Type = String, Dynamic = False, Default = \"  #D#C#B#A#\n  #D#B#A#C#", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kLastColumnIndex, Type = Double, Dynamic = False, Default = \"10", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kRowHall, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"#############\n#...........#\n###B#C#B#D###\n  #A#D#C#A#\n  #########", Scope = Private
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
