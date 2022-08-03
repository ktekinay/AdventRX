#tag Class
Protected Class Advent_2020_12_19
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Monster Messages"
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
		  var rules() as string
		  var data() as string
		  ParseInput( input, rules, data )
		  
		  ParseRules rules
		  
		  var rx as new RegEx
		  rx.SearchPattern = "^" + rules( 0 ) + "$"
		  
		  var matches as integer
		  for each item as string in data
		    if rx.Search( item ) isa RegExMatch then
		      matches = matches + 1
		    end if
		  next
		  
		  return matches
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rules() as string
		  var data() as string
		  ParseInput( input, rules, data )
		  
		  rules( 8 ) = "42 | 42 8"
		  rules( 11 ) = "42 31 | 42 11 31"
		  
		  ParseRules rules
		  
		  var rx as new RegEx
		  rx.SearchPattern = "^" + rules( 0 ) + "$"
		  
		  var matches as integer
		  for each item as string in data
		    if rx.Search( item ) isa RegExMatch then
		      matches = matches + 1
		    end if
		  next
		  
		  return matches
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CleanRules(rules() As String)
		  for i as integer = 0 to rules.LastIndex
		    var rule as string = rules( i )
		    if rule.Left( 1 ) = kQuote then
		      rule = rule.ReplaceAll( kQuote, "" )
		      if rule.IndexOf( "|" ) <> -1 then
		        break
		      end if
		      rules( i ) = rule
		    end if
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseInput(input As String, ByRef rules() As String, ByRef data() As String)
		  input = Normalize( input )
		  
		  var sections() as string = input.Split( EndOfLine + EndOfLine )
		  
		  if sections.Count = 0 then
		    return
		  end if
		  
		  //
		  // First section is rules, second is data
		  //
		  
		  rules = ToStringArray( sections( 0 ) )
		  
		  //
		  // We don't need the array indexes
		  //
		  var sortedRules() as string
		  sortedRules.ResizeTo rules.LastIndex
		  
		  for i as integer = 0 to rules.LastIndex
		    var rule as string = rules( i )
		    var parts() as string = rule.Split( ":" )
		    var newIndex as integer = parts( 0 ).ToInteger
		    parts.RemoveAt 0
		    rule = String.FromArray( parts, ":" )
		    if newIndex > sortedRules.LastIndex then
		      sortedRules.ResizeTo newIndex
		    end if
		    
		    sortedRules( newIndex ) = rule.Trim
		  next i
		  
		  rules = sortedRules
		  CleanRules rules
		  
		  data = ToStringArray( sections( 1 ) )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseRules(rules() As String)
		  var rxHasNumber as new RegEx
		  rxHasNumber.SearchPattern = "\d"
		  
		  var incomplete as new Dictionary
		  var complete as new Dictionary
		  
		  for i as integer = 0 to rules.LastIndex
		    if rxHasNumber.Search( rules( i ) ) is nil then
		      complete.Value( i ) = nil
		    else
		      incomplete.Value( i ) = nil
		    end if
		  next
		  
		  while complete.KeyCount <> rules.Count
		    var ruleIndex as integer
		    while ruleIndex <= rules.LastIndex
		      if complete.HasKey( ruleIndex ) then
		        ruleIndex = ruleIndex + 1
		        continue while
		      end if
		      
		      var rule as string = rules( ruleIndex ) // 1 2 | 3 4
		      if rule = "" then
		        ruleIndex = ruleIndex + 1
		        continue while
		      end if
		      
		      var conditionals() as string = rule.Split( " | " ) // {1 2} {3 4}
		      for conditionIndex as integer = 0 to conditionals.LastIndex
		        var referenceGroup as string = conditionals( conditionIndex ) // {1 2}
		        var references() as string = referenceGroup.Split( " " ) // {1} {2}
		        for referenceIndex as integer = 0 to references.LastIndex
		          var reference as string = references( referenceIndex ) // 1
		          if rxHasNumber.Search( reference ) isa RegExMatch then
		            var otherReferenceIndex as integer = reference.ToInteger
		            if otherReferenceIndex = ruleIndex then
		              //
		              // Loop
		              //
		              ruleIndex = ruleIndex + 1
		              continue while
		            end if
		            
		            if complete.HasKey( otherReferenceIndex ) = false then
		              //
		              // Not resolved yet so let's jump there and resolve it
		              //
		              ruleIndex = otherReferenceIndex
		              continue while
		            end if
		            
		            reference = rules( otherReferenceIndex )
		            
		            //
		            // If we get here, we can resolve this
		            //
		            references( referenceIndex ) = reference
		          end if
		        next referenceIndex
		        
		        //
		        // If we get there, the reference group was resolved
		        //
		        referenceGroup = String.FromArray( references, "" )
		        conditionals( conditionIndex ) = referenceGroup
		      next conditionIndex
		      
		      //
		      // Rejoin the conditions
		      //
		      if conditionals.Count = 1 then
		        rule = conditionals( 0 )
		      else
		        rule = "((" + String.FromArray( conditionals, ")|(" ) + "))"
		      end if
		      
		      rules( ruleIndex ) = rule
		      complete.Value( ruleIndex ) = nil
		      incomplete.Remove( ruleIndex )
		      
		      ruleIndex = ruleIndex + 1
		    wend
		  wend
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kQuote, Type = String, Dynamic = False, Default = \"\"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"0: 4 1 5\n1: 2 3 | 3 2\n2: 4 4 | 5 5\n3: 4 5 | 5 4\n4: \"a\"\n5: \"b\"\n\nababbb\nbababa\nabbbab\naaabbb\naaaabbb", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"42: 9 14 | 10 1\n9: 14 27 | 1 26\n10: 23 14 | 28 1\n1: \"a\"\n11: 42 31\n5: 1 14 | 15 1\n19: 14 1 | 14 14\n12: 24 14 | 19 1\n16: 15 1 | 14 14\n31: 14 17 | 1 13\n6: 14 14 | 1 14\n2: 1 24 | 14 4\n0: 8 11\n13: 14 3 | 1 12\n15: 1 | 14\n17: 14 2 | 1 7\n23: 25 1 | 22 14\n28: 16 1\n4: 1 1\n20: 14 14 | 1 15\n3: 5 14 | 16 1\n27: 1 6 | 14 18\n14: \"b\"\n21: 14 1 | 1 14\n25: 1 1 | 1 14\n22: 14 14\n8: 42\n26: 14 22 | 1 20\n18: 15 15\n7: 14 5 | 1 21\n24: 14 1\n\nabbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa\nbbabbbbaabaabba\nbabbbbaabbbbbabbbbbbaabaaabaaa\naaabbbbbbaaaabaababaabababbabaaabbababababaaa\nbbbbbbbaaaabbbbaaabbabaaa\nbbbababbbbaaaaaaaabbababaaababaabab\nababaaaaaabaaab\nababaaaaabbbaba\nbaabbaaaabbaaaababbaababb\nabbbbabbbbaaaababbbbbbaaaababb\naaaaabbaabaaaaababaa\naaaabbaaaabbaaa\naaaabbaabbaaaaaaabbbabbbaaabbaabaaa\nbabaaabbbaaabaababbaabababaaab\naabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba", Scope = Private
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
