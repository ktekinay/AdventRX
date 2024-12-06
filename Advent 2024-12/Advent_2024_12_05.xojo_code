#tag Class
Protected Class Advent_2024_12_05
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Put pages in order according to rules"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Print Queue"
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
		  var parts() as string = Normalize( input ).Split( EndOfLine + EndOfLine )
		  var rules() as pair = ToPairs( parts( 0 ) )
		  var rows() as string = parts( 1 ).Split( EndOfLine )
		  
		  var result as integer
		  
		  for each row as string in rows
		    var pages() as string = row.Split( "," )
		    
		    if IsValid( pages, rules ) then
		      var midPos as integer = pages.LastIndex \ 2
		      result = result + pages( midPos ).ToInteger
		    end if
		  next
		  
		  return result : if( IsTest, 143, 5964 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var parts() as string = Normalize( input ).Split( EndOfLine + EndOfLine )
		  var rules() as pair = ToPairs( parts( 0 ) )
		  var rows() as string = parts( 1 ).Split( EndOfLine )
		  
		  var result as integer
		  
		  for each row as string in rows
		    var pages() as string = row.Split( "," )
		    
		    var applicableRules() as pair
		    
		    var isInvalid as boolean
		    
		    for each rule as pair in rules
		      var leftPage as string = rule.Left.StringValue
		      var rightPage as string = rule.Right.StringValue
		      
		      var leftPos as integer = pages.IndexOf( leftPage )
		      if leftPos = -1 then
		        continue for rule
		      end if
		      
		      var rightPos as integer = pages.IndexOf( rightPage )
		      if rightPos = -1 then
		        continue for rule
		      end if
		      
		      applicableRules.Add rule
		      
		      if leftPos > rightPos then
		        isInvalid = true
		      end if
		    next
		    
		    if isInvalid then
		      OrderPages pages, applicableRules
		      
		      var midPos as integer = pages.LastIndex \ 2
		      result = result + pages( midPos ).ToInteger
		    end if
		  next
		  
		  return result : if( IsTest, 123, 4719 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function IsValid(pages() As String, rules() As Pair) As Boolean
		  for each rule as pair in rules
		    var leftPage as string = rule.Left.StringValue
		    var rightPage as string = rule.Right.StringValue
		    
		    var leftPos as integer = pages.IndexOf( leftPage )
		    if leftPos = -1 then
		      continue for rule
		    end if
		    
		    var rightPos as integer = pages.IndexOf( rightPage )
		    if rightPos = -1 then
		      continue for rule
		    end if
		    
		    if leftPos > rightPos then
		      return false
		    end if
		  next
		  
		  return true
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub OrderPages(pages() As String, rules() As Pair)
		  var isValid as boolean
		  
		  do
		    isValid = true
		    
		    for each rule as pair in rules
		      var leftPage as string = rule.Left.StringValue
		      var rightPage as string = rule.Right.StringValue
		      
		      var leftPos as integer = pages.IndexOf( leftPage )
		      var rightPos as integer = pages.IndexOf( rightPage )
		      
		      if leftPos > rightPos then
		        var temp as string = pages( leftPos )
		        pages( leftPos ) = pages( rightPos )
		        pages( rightPos ) = temp
		        isValid = false
		      end if
		    next
		  loop until isValid
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ToPairs(data As String) As Pair()
		  var rows() as string = data.Split( EndOfLine )
		  
		  var result() as pair
		  
		  for each row as string in rows
		    var parts() as string = row.Split( "|" )
		    result.Add parts( 0 ) : parts( 1 )
		  next
		  
		  return result
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"47|53\n97|13\n97|61\n97|47\n75|29\n61|13\n75|53\n29|13\n97|29\n53|29\n61|53\n97|53\n61|29\n47|13\n75|47\n97|75\n47|61\n75|61\n47|29\n75|13\n53|13\n\n75\x2C47\x2C61\x2C53\x2C29\n97\x2C61\x2C53\x2C29\x2C13\n75\x2C29\x2C13\n75\x2C97\x2C47\x2C61\x2C53\n61\x2C13\x2C29\n97\x2C13\x2C75\x2C29\x2C47", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2024
	#tag EndUsing


	#tag ViewBehavior
		#tag ViewProperty
			Name="Type"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Cooperative"
				"1 - Preemptive"
			#tag EndEnumValues
		#tag EndViewProperty
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
