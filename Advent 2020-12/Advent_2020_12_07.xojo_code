#tag Class
Protected Class Advent_2020_12_07
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
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
		  return CalculateResultB( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function BuildTree(input As String) As Dictionary
		  var rules() as string = ToStringArray( input )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "\b(\d+) ([^.,]+) bags?"
		  
		  var allLuggage as new Dictionary
		  
		  for each rule as string in rules
		    var parts() as string = rule.Split( " bags contain " )
		    var outer as Luggage = allLuggage.Lookup( parts( 0 ), nil )
		    if outer is nil then
		      outer = new Luggage
		      outer.Name = parts( 0 )
		      allLuggage.Value( parts( 0 ) ) = outer
		    end if
		    
		    outer.CanBeOutermost = true
		    
		    var innerString as string = parts( 1 )
		    
		    var match as RegExMatch = rx.Search( innerString )
		    while match isa object
		      var count as integer = match.SubExpressionString( 1 ).ToInteger
		      var name as string = match.SubExpressionString( 2 )
		      var inner as Luggage = allLuggage.Lookup( name, nil )
		      if inner is nil then
		        inner = new Luggage
		        inner.Name = name
		        allLuggage.Value( name ) = inner
		      end if
		      
		      outer.Holds count, inner
		      
		      match = rx.Search
		    wend
		  next
		  
		  return allLuggage
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var allLuggage as Dictionary = BuildTree( input )
		  if allLuggage.KeyCount = 0 then
		    return -1
		  end if
		  
		  var shinyGold as Luggage = allLuggage.Value( "shiny gold" )
		  
		  var parents as Dictionary = GetOutermostLuggage( shinyGold )
		  return parents.KeyCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var allLuggage as Dictionary = BuildTree( input )
		  if allLuggage.KeyCount = 0 then
		    return -1
		  end if
		  
		  var shinyGold as Luggage = allLuggage.Value( "shiny gold" )
		  
		  var count as integer = CountLuggage( shinyGold )
		  return count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountLuggage(l As Luggage) As Integer
		  var count as integer
		  
		  for each p as pair in l.LuggageInside
		    var lCount as integer = p.Left
		    var inner as Luggage = p.Right
		    var innerCount as integer = CountLuggage( inner )
		    
		    count = count + ( lCount * innerCount ) + lCount
		  next 
		  
		  return count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetOutermostLuggage(l As Luggage, appendTo As Dictionary = Nil) As Dictionary
		  if appendTo is nil then
		    appendTo = new Dictionary
		  end if
		  
		  for each outer as Luggage in l.LuggageOutside
		    if outer.CanBeOutermost then
		      appendTo.Value( outer.Name ) = nil
		    end if
		    
		    call GetOutermostLuggage( outer, appendTo )
		  next
		  
		  return appendTo
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"light red bags contain 1 bright white bag\x2C 2 muted yellow bags.\ndark orange bags contain 3 bright white bags\x2C 4 muted yellow bags.\nbright white bags contain 1 shiny gold bag.\nmuted yellow bags contain 2 shiny gold bags\x2C 9 faded blue bags.\nshiny gold bags contain 1 dark olive bag\x2C 2 vibrant plum bags.\ndark olive bags contain 3 faded blue bags\x2C 4 dotted black bags.\nvibrant plum bags contain 5 faded blue bags\x2C 6 dotted black bags.\nfaded blue bags contain no other bags.\ndotted black bags contain no other bags.", Scope = Private
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
