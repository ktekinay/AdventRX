#tag Class
Protected Class Advent_2015_12_13
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Guests at circular table"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Knights of the Dinner Table"
		  
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
		  var db as Dictionary = ParseInput( input )
		  
		  var guests() as string
		  for each key as string in db.Keys
		    guests.Add key
		  next
		  
		  var maxScore as integer = CalculateScore( guests, db )
		  
		  var seated() as string
		  seated.Add guests.Pop
		  
		  maxScore = Recurse( guests, seated, db, maxScore )
		  
		  
		  
		  return maxScore
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var db as Dictionary = ParseInput( input )
		  
		  var guests() as string
		  for each key as string in db.Keys
		    guests.Add key
		  next
		  guests.Add "Host"
		  
		  var maxScore as integer = CalculateScore( guests, db )
		  
		  var seated() as string
		  seated.Add guests.Pop
		  
		  maxScore = Recurse( guests, seated, db, maxScore )
		  
		  return maxScore
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateScore(guests() As String, db As Dictionary) As Integer
		  var score as integer
		  
		  for i as integer = 0 to guests.LastIndex
		    var guest as string = guests( i )
		    var guestDict as Dictionary = db.Lookup( guest, nil )
		    
		    if guestDict is nil then
		      continue
		    end if
		    
		    var prevGuest as string = if( i = 0, guests( guests.LastIndex ), guests( i - 1 ) )
		    var nextGuest as string = if( i = guests.LastIndex, guests( 0 ), guests( i + 1 ) )
		    
		    var prevGuestScore as integer = guestDict.Lookup( prevGuest, 0 )
		    var nextGuestScore as integer = guestDict.Lookup( nextGuest, 0 )
		    
		    score = score + prevGuestScore + nextGuestScore
		    
		    'Print guest + ": " + prevGuest + "=" + prevGuestScore.ToString + " " + nextGuest + "=" + nextGuestScore.ToString
		  next
		  
		  return score
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As Dictionary
		  var rx as new RegEx
		  rx.SearchPattern = "^(\w+) would (gain|lose) (\d+) happiness units .*\bnext to (\w+)\.$"
		  
		  var outer as new Dictionary
		  
		  var match as RegExMatch = rx.Search( input )
		  while match isa object
		    var name1 as string = match.SubExpressionString( 1 )
		    var op as string = match.SubExpressionString( 2 )
		    var units as integer = match.SubExpressionString( 3 ).ToInteger
		    var name2 as string = match.SubExpressionString( 4 )
		    
		    if op = "lose" then
		      units = 0 - units
		    end if
		    
		    var subdict as Dictionary = outer.Lookup( name1, nil )
		    if subdict is nil then
		      subdict = new Dictionary
		      outer.Value( name1 ) = subdict
		    end if
		    
		    subdict.Value( name2 ) = units
		    
		    match = rx.Search
		  wend
		  
		  return outer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Recurse(unseated() As String, seated() As String, db As Dictionary, bestScore As Integer) As Integer
		  var score as integer
		  
		  if unseated.Count = 0 then
		    score = CalculateScore( seated, db )
		    
		  else
		    
		    score = bestScore
		    
		    for i as integer = 0 to unseated.LastIndex
		      var guest as string = unseated( i )
		      unseated.RemoveAt i
		      seated.Add guest
		      score = max( score, Recurse( unseated, seated, db, bestScore ) )
		      unseated.AddAt i, seated.Pop
		    next
		  end if
		  
		  return max( score, bestScore )
		  
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Alice would gain 54 happiness units by sitting next to Bob.\nAlice would lose 79 happiness units by sitting next to Carol.\nAlice would lose 2 happiness units by sitting next to David.\nBob would gain 83 happiness units by sitting next to Alice.\nBob would lose 7 happiness units by sitting next to Carol.\nBob would lose 63 happiness units by sitting next to David.\nCarol would lose 62 happiness units by sitting next to Alice.\nCarol would gain 60 happiness units by sitting next to Bob.\nCarol would gain 55 happiness units by sitting next to David.\nDavid would gain 46 happiness units by sitting next to Alice.\nDavid would lose 7 happiness units by sitting next to Bob.\nDavid would gain 41 happiness units by sitting next to Carol.", Scope = Private
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
