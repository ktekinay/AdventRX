#tag Class
Protected Class Advent_2023_12_07
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Poker, sorta"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Camel Cards"
		  
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
		  var rows() as string = ToStringArray( input )
		  var hands() as CardHand
		  for each row as string in rows
		    hands.Add new CardHand( row )
		  next
		  
		  hands.Sort AddressOf CardHand.Sorter_Strength
		  
		  var result as integer
		  for i as integer = 0 to hands.LastIndex
		    var h as CardHand = hands( i )
		    var rank as integer = i + 1
		    
		    result = result + ( h.Bid * rank )
		  next
		  
		  return result : if( IsTest, 6440, 250254244 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var rows() as string = ToStringArray( input )
		  var hands() as CardHand
		  for each row as string in rows
		    hands.Add new CardHand( row, true )
		  next
		  
		  hands.Sort AddressOf CardHand.Sorter_Strength
		  
		  var result as integer
		  for i as integer = 0 to hands.LastIndex
		    var h as CardHand = hands( i )
		    var rank as integer = i + 1
		    
		    result = result + ( h.Bid * rank )
		    #if DebugBuild and FALSE
		      var cards as string = h.CardsSorted
		      var myType as CardHand.Types = h.Type
		      
		      select case myType
		      case CardHand.Types.FiveOfAKind
		        print cards + "= Five"
		      case CardHand.Types.FourOfAKind
		        print cards + "= Four"
		      case CardHand.Types.FullHouse
		        print cards + "= FULL"
		      case CardHand.Types.ThreeOfAKind
		        print cards + "= Three"
		      case CardHand.Types.TwoPair
		        print cards + "= Two"
		      case CardHand.Types.Pair
		        print cards + " = Pair"
		      case CardHand.Types.HighCard
		        print cards + "= High"
		      case else
		        print cards + " = ???? (" + Integer( myType ).ToString + ")"
		      end select
		    #endif
		  next
		  
		  
		  
		  
		  return result : if( IsTest, 5905, 250087440 )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"32T3K 765\nT55J5 684\nKK677 28\nKTJJT 220\nQQQJA 483", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
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
