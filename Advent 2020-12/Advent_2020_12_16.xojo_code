#tag Class
Protected Class Advent_2020_12_16
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
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  return CalculateResultB( Normalize( input ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  if input = "" then
		    return -1
		  end if
		  
		  var rules() as TicketRule
		  var grid as IntegerGrid
		  
		  ParseInput input, rules, grid
		  
		  var invalidValues() as integer
		  
		  for row as integer = 1 to grid.LastRowIndex
		    for col as integer = 0 to grid.LastColIndex
		      var value as integer = grid( row, col )
		      
		      for each tr as TicketRule in rules
		        if tr.Contains( value ) then
		          continue for col
		        end if
		      next tr
		      
		      //
		      // If we get here, it was an invalid value
		      //
		      invalidValues.Add value
		    next col
		  next row
		  
		  var sum as integer = SumArray( invalidValues )
		  return sum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  if input = "" then
		    return -1
		  end if
		  
		  var rules() as TicketRule
		  var grid as IntegerGrid
		  
		  ParseInput input, rules, grid
		  
		  var goodRows() as integer
		  
		  for row as integer = grid.LastRowIndex downto 0
		    var goodColCount as integer
		    
		    for col as integer = 0 to grid.LastColIndex
		      var value as integer = grid( row, col )
		      
		      for each tr as TicketRule in rules
		        if tr.Contains( value ) then
		          goodColCount = goodColCount + 1
		          continue for col
		        end if
		      next tr
		    next col
		    
		    if goodColCount = ( grid.LastColIndex + 1 ) then
		      //
		      // This is a good row
		      //
		      goodRows.Add row
		    end if
		  next row
		  
		  //
		  // Check the good rows and test the columns against the rules again
		  //
		  for each row as integer in goodRows
		    for col as integer = 0 to grid.LastColIndex
		      var value as integer = grid( row, col )
		      
		      for each tr as TicketRule in rules
		        if tr.Contains( value ) then
		          tr.MaybeAddMatchingColumn col
		        else
		          tr.AddColumnThatDoesNotMatch col
		        end if
		      next
		    next
		  next
		  
		  //
		  // Use the rules that only match one column to narrow down the other rules
		  //
		  do
		    var wasChanged as boolean
		    
		    for each tr as TicketRule in rules
		      if tr.ColumnsThatMatch.Count = 1 then
		        var matchingCol as integer = tr.ColumnsThatMatch( 0 )
		        
		        for each otherTr as TicketRule in rules
		          if otherTr is tr then
		            continue for otherTr
		          end if
		          if otherTr.ColumnsThatMatch.IndexOf( matchingCol ) <> -1 then
		            otherTr.AddColumnThatDoesNotMatch matchingCol
		            wasChanged = true
		          end if
		        next
		      end if
		    next
		    
		    if not wasChanged then
		      exit do
		    end if
		  loop
		  
		  var departureValues() as integer
		  for each tr as TicketRule in rules
		    if tr.ColumnsThatMatch.Count <> 1 then
		      break
		    end if
		    
		    if tr.Name.BeginsWith( "departure" ) then
		      departureValues.Add grid( 0, tr.ColumnsThatMatch( 0 ) )
		    end if
		  next
		  
		  return MultiplyArray( departureValues, true )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseInput(input As String, ByRef rules() As TicketRule, ByRef grid As IntegerGrid)
		  input = Normalize( input )
		  var sections() as string = input.Split( EndOfLine + EndOfLine )
		  
		  var rows() as string
		  
		  rows = ToStringArray( sections( 0 ) )
		  
		  for each row as string in rows
		    var mainParts() as string = row.Split( ": " )
		    var tr as new TicketRule
		    tr.Name = mainParts( 0 )
		    
		    var rangeParts() as string = mainParts( 1 ).Split( " or " )
		    for each p as string in rangeParts
		      tr.AddRange p
		    next
		    
		    rules.Add tr
		  next
		  
		  rows = ToStringArray( sections( 1 ) )
		  var myTicket() as string = rows( 1 ).Split( "," )
		  
		  grid = new IntegerGrid
		  grid.ResizeTo 0, myTicket.LastIndex
		  
		  for col as integer = 0 to grid.LastColIndex
		    grid( 0, col ) = myTicket( col ).ToInteger
		  next
		  
		  rows = ToStringArray( sections( 2 ) )
		  
		  grid.ResizeTo rows.LastIndex, grid.LastColIndex
		  
		  for row as integer = 1 to rows.LastIndex
		    var thisTicket() as string = rows( row ).Split( "," )
		    for col as integer = 0 to thisTicket.LastIndex
		      grid( row, col ) = thisTicket( col ).ToInteger
		    next
		  next
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"class: 1-3 or 5-7\nrow: 6-11 or 33-44\nseat: 13-40 or 45-50\n\nyour ticket:\n7\x2C1\x2C14\n\nnearby tickets:\n7\x2C3\x2C47\n40\x2C4\x2C50\n55\x2C2\x2C20\n38\x2C6\x2C12", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"class: 0-1 or 4-19\nrow: 0-5 or 8-19\nseat: 0-13 or 16-19\n\nyour ticket:\n11\x2C12\x2C13\n\nnearby tickets:\n3\x2C9\x2C18\n15\x2C1\x2C5\n5\x2C14\x2C9", Scope = Private
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
