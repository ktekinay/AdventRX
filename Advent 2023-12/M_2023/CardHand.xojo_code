#tag Class
Protected Class CardHand
	#tag Method, Flags = &h21
		Private Function CardToValue(card As String) As Integer
		  select case card
		  case "2" to "9"
		    return card.ToInteger
		  case "T"
		    return 10
		  case "J"
		    return 11
		  case "Q"
		    return 12
		  case "K"
		    return 13
		  case "A"
		    return 14
		  case else
		    break
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(data As String)
		  var parts() as string = data.Split( " " )
		  Cards = parts( 0 )
		  Bid = parts( 1 ).ToInteger
		  
		  var cardStrings() as string = parts( 0 ).Split( "" )
		  for each cardString as string in cardStrings
		    CardValues.Add CardToValue( cardString )
		  next
		  
		  cardStrings.Sort
		  var cards as string = String.FromArray( cardStrings, "" )
		  
		  DetermineType( cards )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(data As String, isTwo As Boolean)
		  var parts() as string = data.Split( " " )
		  Cards = parts( 0 )
		  Bid = parts( 1 ).ToInteger
		  
		  var cardStrings() as string = parts( 0 ).Split( "" )
		  for each cardString as string in cardStrings
		    if cardString = "J" then
		      CardValues.Add 1
		    else
		      CardValues.Add CardToValue( cardString )
		    end if
		  next
		  
		  cardStrings.Sort AddressOf Sorter_Cards
		  var cards as string = String.FromArray( cardStrings, "" )
		  CardsSorted = cards
		  
		  DetermineType2( cards )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DetermineType(cards As String)
		  static rxFive, rxFour, rxFull, rxThree, rxTwoPair, rxPair as RegEx
		  
		  if rxFive is nil then
		    rxFive = new RegEx
		    rxFive.SearchPattern = "(.)\1{4}"
		    
		    rxFour = new RegEx
		    rxFour.SearchPattern = "(.)\1{3}"
		    
		    rxFull = new RegEx
		    rxFull.SearchPattern = "(.)\1(.)\2\2|(.)\3\3(.)\4"
		    
		    rxThree = new RegEx
		    rxThree.SearchPattern = "(.)\1\1"
		    
		    rxTwoPair = new RegEx
		    rxTwoPair.SearchPattern = "(.)\1.?(.)\2"
		    
		    rxPair = new RegEx
		    rxPair.SearchPattern = "(.)\1"
		  end if
		  
		  static rxArr() as RegEx = array( rxFive, rxFour, rxFull, rxThree, rxTwoPair, rxPair )
		  
		  for i as integer = 0 to rxArr.LastIndex
		    var rx as RegEx = rxArr( i )
		    if rx.Search( cards ) isa RegExMatch then
		      var myType as Types = Types( 6 - i )
		      Type = myType
		      return
		    end if
		  next
		  
		  Type = Types.HighCard
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DetermineType2(cards As String)
		  static rxFive, rxFour, rxFull, rxThree, rxTwoPair, rxPair as RegEx
		  
		  if rxFive is nil then
		    rxFive = new RegEx
		    rxFive.SearchPattern = "(.)(\1|J){4}"
		    
		    rxFour = new RegEx
		    rxFour.SearchPattern = "^.?(.).?(J|\1).?(J|\1).?(J|\1).?$"
		    
		    rxFull = new RegEx
		    rxFull.SearchPattern = "(.)\1(.)(J|\2){2}|(.)\4\4(.)(J|\5)"
		    
		    rxThree = new RegEx
		    rxThree.SearchPattern = "(.).*(J|\1).*(J|\1)"
		    
		    rxTwoPair = new RegEx
		    rxTwoPair.SearchPattern = "(.)\1.?(.)(J|\2)"
		    
		    rxPair = new RegEx
		    rxPair.SearchPattern = "(.)(J|\1)"
		  end if
		  
		  static rxArr() as RegEx = array( rxFive, rxFour, rxFull, rxThree, rxTwoPair, rxPair )
		  
		  var myType as Types = Types.HighCard
		  
		  for i as integer = 0 to rxArr.LastIndex
		    var rx as RegEx = rxArr( i )
		    if rx.Search( cards ) isa RegExMatch then
		      myType = Types( 6 - i )
		      exit
		    end if
		  next
		  
		  Type = myType
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Sorter_Cards(c1 As String, c2 As String) As Integer
		  if c1 = c2 then return 0
		  if c1 = "j" then return 1
		  if c2 = "j" then return -1
		  
		  return CardToValue( c1 ) - CardToValue( c2 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Sorter_Strength(h1 As CardHand, h2 As CardHand) As Integer
		  var result as integer
		  
		  result = integer( h1.Type ) - integer( h2.Type )
		  if result <> 0 then
		    return result
		  end if
		  
		  for i as integer = 0 to h1.CardValues.LastIndex
		    result = h1.CardValues( i ) - h2.CardValues( i )
		    if result <> 0 then
		      return result
		    end if
		  next
		  
		  return 0
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Bid As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Cards As String
	#tag EndProperty

	#tag Property, Flags = &h0
		CardsSorted As String
	#tag EndProperty

	#tag Property, Flags = &h0
		CardValues() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Type As Types
	#tag EndProperty


	#tag Enum, Name = Types, Type = Integer, Flags = &h0
		HighCard
		  Pair
		  TwoPair
		  ThreeOfAKind
		  FullHouse
		  FourOfAKind
		FiveOfAKind
	#tag EndEnum


	#tag ViewBehavior
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
		#tag ViewProperty
			Name="Bid"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Cards"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CardsSorted"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Types"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
