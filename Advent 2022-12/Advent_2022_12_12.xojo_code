#tag Class
Protected Class Advent_2022_12_12
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Find shortest path"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Hill Climbing Algorithm"
		  
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
		  var grid as new ObjectGrid
		  var startPos as GridMember
		  var endPos as GridMember
		  
		  ParseInput input, grid, startPos, endPos
		  call grid.BestPath( startPos, endPos, AddressOf Compare, false )
		  
		  if not IsTest then
		    self.Grid = grid
		    self.InitialStartPos = startPos
		    self.EndPos = endPos
		  end if
		  
		  return startPos.BestSteps
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var grid as ObjectGrid
		  var startPos as GridMember
		  var endPos as GridMember
		  
		  if not IsTest and self.Grid isa object then
		    //
		    // No need to do this work again
		    //
		    startPos = self.InitialStartPos
		    endPos = self.EndPos
		    grid = self.Grid
		    
		  else
		    grid = new ObjectGrid
		    ParseInput input, grid, startPos, endPos
		    call grid.BestPath startPos, endPos, AddressOf compare, false
		    
		  end if
		  
		  var best as integer = startPos.BestSteps
		  
		  var ascA as integer = asc( "a" )
		  
		  for each member as GridMember in grid
		    if member.Value = ascA then
		      if member.BestSteps > 0 and member.BestSteps <= best then
		        best = member.BestSteps
		        
		      else
		        //
		        // Set BestSteps so BestPath will know when to quit
		        //
		        startPos.BestSteps = best
		        
		        call grid.BestPath( member, endPos, AddressOf Compare, false )
		        
		        if startPos.BestSteps > 0 and startPos.BestSteps < best then
		          best = startPos.BestSteps
		        end if
		      end if
		    end if
		  next
		  
		  return best
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Compare(fromMember As GridMember, toMember As GridMember) As Integer
		  if fromMember.Value.IntegerValue >= toMember.Value.IntegerValue then
		    return 1
		  end if
		  
		  var highPoint as integer = fromMember.Value.IntegerValue + 1
		  if toMember.Value.IntegerValue > highPoint then
		    return 0
		  end if
		  
		  return 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseInput(input As String, grid As ObjectGrid, ByRef startPos As GridMember, ByRef endPos As GridMember)
		  var sarr( -1, -1 ) as string = ToStringGrid( input )
		  
		  grid.ResizeTo sarr.LastIndex( 1 ), sarr.LastIndex( 2 )
		  
		  for row as integer = 0 to grid.LastRowIndex
		    for col as integer = 0 to grid.LastColIndex
		      var member as new GridMember
		      member.PrintType = GridMember.PrintTypes.UseRawValue
		      
		      var sValue as string = sarr( row, col )
		      
		      if sValue.Compare( "S", ComparisonOptions.CaseSensitive ) = 0 then
		        sValue = "a"
		        startPos = member
		      elseif sValue.Compare( "E", ComparisonOptions.CaseSensitive ) = 0 then
		        sValue = "z"
		        endPos = member
		      end if
		      
		      var value as integer = sValue.Asc
		      
		      member.RawValue = sValue
		      member.Value = value
		      member.BestSteps = 0
		      grid( row, col ) = member
		    next
		  next
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private EndPos As GridMember
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Grid As ObjectGrid
	#tag EndProperty

	#tag Property, Flags = &h21
		Private InitialStartPos As GridMember
	#tag EndProperty


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Sabqponm\nabcryxxl\naccszExk\nacctuvwj\nabdefghi", Scope = Private
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
