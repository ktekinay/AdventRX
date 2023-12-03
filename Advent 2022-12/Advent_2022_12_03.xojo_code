#tag Class
Protected Class Advent_2022_12_03
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Sacks of common types"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Rucksack Reorganization"
		  
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
		Private Function CalculateResultA(input As String) As Integer
		  var sacks() as string = ToStringArray( input )
		  
		  var score as integer
		  
		  for each sack as string in sacks
		    var p as pair = SplitSack( sack )
		    var com1 as string = p.Left
		    var com2 as string = p.Right
		    
		    var common as Dictionary = GetCommon( com1, com2 )
		    
		    for each c as string in common.Keys
		      var pr as integer = PriorityOf( c )
		      score = score + pr
		    next
		  next sack
		  
		  return score
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var sacks() as string = ToStringArray( input )
		  
		  var score as integer
		  
		  for groupIndex as integer = 0 to sacks.LastIndex step 3
		    var common as Dictionary = GetCommon( sacks( groupIndex ), sacks( groupIndex + 1 ) )
		    var common2 as Dictionary = GetCommon( sacks( groupIndex + 1 ), sacks( groupIndex + 2 ) )
		    
		    for each key as variant in common.Keys
		      if common2.HasKey( key ) then
		        score = score + PriorityOf( key.StringValue )
		        exit
		      end if
		    next
		  next
		  
		  return score
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCommon(com1 As String, com2 As String) As Dictionary
		  var chars1() as string = com1.Split( "" )
		  var chars2() as string = com2.Split( "" )
		  
		  var d1 as Dictionary = ParseJSON( "{}" )
		  for each c as string in chars1
		    d1.Value( c ) = nil
		  next
		  
		  var common as Dictionary = ParseJSON( "{}" )
		  for each c as string in chars2
		    if d1.HasKey( c ) then
		      common.Value( c ) = nil
		    end if
		  next
		  
		  return common
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PriorityOf(c As String) As Integer
		  static ascLittleA as integer = asc( "a" )
		  static ascCapA as integer = asc( "A" )
		  
		  select case c.Asc
		  case is >= ascLittleA
		    return c.Asc - ascLittleA + 1
		  case else
		    return c.Asc - ascCapA + 27
		  end
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SplitSack(sack as String) As Pair
		  var com1 as string = sack.Left( sack.Length / 2 )
		  var com2 as string = sack.Right( sack.Length / 2 )
		  
		  return com1 : com2
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"vJrwpWtwJgWrhcsFMMfFFhFp\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\nPmmdzqPrVvPwwTWBwg\nwMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\nttgJtRGJQctTZtZT\nCrZsJsPPZsGzwwsLwLmpwMDw", Scope = Private
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
