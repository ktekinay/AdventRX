#tag Class
Protected Class Advent_2020_12_19
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( Normalize( kInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( Normalize( kInput ) )
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


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"72: \"b\"\n45: 46 52 | 9 72\n85: 9 52 | 9 72\n82: 52 87 | 72 77\n133: 52 30 | 72 56\n118: 7 52 | 70 72\n18: 52 113 | 72 52\n119: 72 46 | 52 18\n25: 19 72 | 103 52\n32: 90 52 | 78 72\n50: 113 113\n71: 72 106 | 52 128\n3: 103 72 | 18 52\n41: 86 72 | 19 52\n96: 86 72 | 108 52\n33: 44 52 | 104 72\n127: 52 36 | 72 50\n51: 72 79 | 52 38\n43: 72 50 | 52 106\n14: 32 72 | 129 52\n6: 2 72 | 33 52\n108: 52 72 | 72 52\n129: 6 52 | 82 72\n34: 127 72 | 3 52\n74: 128 52 | 9 72\n80: 52 103 | 72 19\n2: 134 72 | 13 52\n54: 128 72 | 114 52\n19: 72 72 | 113 52\n0: 8 11\n30: 132 72 | 39 52\n60: 72 64 | 52 5\n4: 18 52 | 114 72\n57: 72 71 | 52 54\n111: 52 27 | 72 102\n76: 122 52 | 75 72\n134: 86 52 | 9 72\n49: 17 52 | 81 72\n124: 103 72 | 86 52\n123: 72 28 | 52 121\n117: 18 52 | 86 72\n26: 51 72 | 58 52\n62: 85 52 | 44 72\n55: 126 52 | 92 72\n115: 72 13 | 52 67\n109: 128 72 | 106 52\n52: \"a\"\n93: 60 52 | 133 72\n64: 67 72 | 84 52\n102: 52 128 | 72 48\n84: 86 52 | 46 72\n77: 41 72 | 21 52\n27: 52 9 | 72 108\n95: 89 72 | 105 52\n36: 52 72\n110: 72 50 | 52 9\n9: 72 72\n120: 72 19 | 52 18\n67: 52 48\n112: 65 72 | 119 52\n75: 62 52 | 123 72\n23: 15 72 | 119 52\n42: 131 52 | 61 72\n94: 52 91 | 72 18\n66: 52 128 | 72 103\n10: 113 108\n37: 52 18 | 72 50\n98: 72 69 | 52 94\n126: 115 52 | 29 72\n79: 59 52 | 94 72\n104: 19 72 | 36 52\n125: 96 72 | 4 52\n122: 52 73 | 72 112\n130: 52 20 | 72 45\n90: 72 40 | 52 88\n132: 103 52\n121: 91 52 | 46 72\n7: 52 114 | 72 128\n5: 52 66 | 72 41\n97: 52 18 | 72 91\n89: 72 109 | 52 116\n53: 52 108 | 72 128\n114: 52 113 | 72 72\n16: 1 52 | 110 72\n113: 72 | 52\n31: 52 14 | 72 12\n69: 52 103 | 72 48\n128: 72 52\n40: 72 3 | 52 83\n101: 63 52 | 127 72\n1: 72 91 | 52 114\n58: 52 111 | 72 99\n13: 19 72 | 9 52\n35: 22 72 | 125 52\n65: 72 114 | 52 91\n12: 52 24 | 72 93\n46: 72 72 | 52 52\n20: 9 72\n73: 72 37 | 52 43\n15: 52 50 | 72 108\n103: 52 52\n106: 72 52 | 72 72\n21: 36 72\n28: 72 50 | 52 46\n78: 72 16 | 52 23\n70: 36 72 | 19 52\n87: 72 107 | 52 47\n116: 19 52 | 106 72\n29: 72 68 | 52 65\n8: 42\n68: 9 52 | 128 72\n99: 110 72 | 25 52\n17: 52 118 | 72 130\n11: 42 31\n48: 52 52 | 72 52\n83: 48 113\n105: 52 100 | 72 80\n61: 55 52 | 26 72\n100: 48 52 | 108 72\n56: 52 53 | 72 74\n63: 52 106 | 72 9\n44: 72 114 | 52 128\n47: 52 50 | 72 36\n107: 52 36 | 72 91\n39: 114 72 | 86 52\n86: 52 72 | 52 52\n24: 52 95 | 72 35\n81: 98 72 | 34 52\n131: 49 52 | 76 72\n92: 52 101 | 72 57\n59: 52 114 | 72 50\n38: 52 74 | 72 124\n88: 97 72 | 10 52\n22: 117 72 | 120 52\n91: 72 72 | 52 72\n\nbbabbaabaabaaaababbbbabaabbaabab\nbaaabaaabaaababbabababaabababaaa\naaabbbabaabbbbbbbbabaaba\naaababbbaaabaabbabbbbabbaaaabbbb\nababaabbaabbbaabbbabbababbabbbbbbaaabbbbaaaabbbabbbaaabbaaaabbaa\nbbbbaabaababaaabbbaaaaabbbbabbabaaabaabaabbaaaba\nbbaababbbbbbaabbbbbaaaabbbbbabaaaabbbabaabbbaaaa\naaaaaaaaaababaaaabaaababaabbbbaababaaaaaaaaabaaabbaabbbaaabaabababbbbaaabbbbbabb\nbbbbabbbbbbbbbbababbabbabbbabbbaaabbbbbaabbbbbaa\nbbabaaababbbaabababbabbbabaabbbbbaaabbaaaaabbbaaaaabaabbaabbabba\nbabbbabaaabbaaaabaaaaabbbabaaaaa\nababaabbaaabbabbbbbbbaaaaabaabaabaaaababbaaaaaaa\nbaaaababaaaaaaababaaabba\nbbaabbbaaabababbbaaaaabbbbbbbaaaaabbaabaabaaabaabbbaabaaaaaababbababbbbb\nbbababbbaaabbabababbbabaaabbaababbbaaabaaabbbabbabababab\nbabbabbabbbaabbbbaabaaabbabababbbbbbbbaa\nabbaaaaaabbabbaabbabbabababbaabaabbbaaaa\nababaabbabbbbbabbabbbaaaabbbaabbabbbbabb\naaabbbbaabbbababaabaaaaa\nbabbbaaaabaaabaaabbabbabbabaabab\naaabbaabaabbabaaaaaaaabb\nababbbabaabbaabbabaababababbbbaa\nbabbabaaabbbababbbababaaaaaabbaaababaaab\nbbaababbbabaaababbaaabab\naabababbbbaabbbbabaabaababababaaabababab\nbaaaaabbbbbaabbbbbababbbbbbabbab\nbaaaabaaabaabaaabbabaaaababaaaab\naabbbabababaaabababbaaaa\nababbbaaabababbaaabaaababbaaaabaabbbbbab\nababbbaaaabaaaababababba\naaabbbabaabbaababbbbabbbbbabbabaababbabb\naabbabaaaabbaababbabbabbaaabaabababaaabaaaaaabab\nabaaabbbabbaaababaaababa\nbbaaabbbbababbababaababb\naaabbabababaaabaabbabaab\nbbabbaaaabbbaabbaaabbbbbbbbabaabbbbbabbbbabbaabaabbaababaaabaabb\nbabbabbabbbbababaaaaabaababbbabbaabaabbbabaaaabb\nbbabbaababababbabaaababb\nbabaaabaaabababbaabababbabbababaabbaaabbbababaaaababbbbbaaaabbbbabbbbaaa\naaabaabaaabbbaabbbabbbbbbbababba\naabaababbbaaaababbabaaaa\naaaabaaabbabababbabbbaab\nbaaabaabbaaaababbbaabaaaaabbabaaabaaabaabbbbbabbbabaabababaabbaaabbaaababbabbbbb\naabaabbbababbbababaababaabbbaaaa\naabaabbaaaabaabaabaaaaaabababbaababaaabbabbbbabbbaaaaaaabababbabbbbbabaa\nbaaabbbaaaaaabbbbbaaaaabbabbaabaaaaabbba\nbaaabaaaabbbbaaaaabbaababbabbababaaaabbbbabbaaabaabbbaabbaaaabbb\nbaaabbbabaabbabaabbabaaabaaabbbaabbaaabbabaaabab\nabbaaabbaaabbabbabaaabba\naaaaaaabbabbbabababbbaaaababaabbabbaaabaabbaabab\naabababaaabbaabbbbaabbbababbaaaa\naabbbabaaabaabbbbbbabaabababbbbb\nbbbababbbabbbbbbbabaaabaaaabbabaaabbbbabbabababaaabaaaaa\nabaabbaabbbabaabbabaaabbaaabbaaaaabbaaabbaaabbbbbabbaabb\nabbbbbabaabaabababababbaaabababbaabbbababbaabaaa\naaabbaabaabaaaabbbbabbbbbabaababaaaaabab\naabbbaabbbbbababaabbbbbbaababbbb\nbbababbbaabaaaabbaaaaabbbaababaabbaabaab\naabaababaabbbbbbbabbbbab\naaaaabaababbbabbabbbaabbbbabbaaa\nbaaaabababbbabbbbaaababbbbbababaaaaaaabb\nbaaaabaabaaabbaaabbbbbbaabaabbaabbbbbbabbbbbbbbbbabaabababbbbabbaababbbb\nbababbabaaabaaaaaaababbbbbabbbaabaaabbbb\nbbbbbbbabbabaaabaaaaaaabaabaaabaaaaaaaaababbaaabbaabbaaababaaabbabaaaaaa\nabbaaababbbabaabbaaabbab\naabaabbbabaaaababaaabbbabaaaabbbbabbbababbbbabaaaaaababbaaabaabbbbbaabababbaabbb\nabaaabaabbabaabbaabbaabaababaaaa\nbabbabaabaaaaababaaaabba\nbbabbbbaaabbbabaaaaabbbb\nabbabababbabbbbbaaabaaabaaaaabbaabbabbababbaabbaaabbbabbabbaabbbaabbabaaabaabbab\nbaabaaabbbbbaabbbaaababa\nbbaaabbabbbbabbabbaabbaabaaaaabbabaabbba\nbabbbabaaabbbaaababababb\nabaabbbbbbbbbababaaabbbabbababaaabaaaabababaaaab\nbbbbbabbbabbbbbababbabaaabbbaabbbbabbbbbabbabababababaabaaabaaabbaaabaaaaaabbaaa\nbababababbbbbbaaaabbbbaabbaaabaababbbbaaabbabbab\nababbaabababaababbbbbabbbbabbababaaabbbabaaaabbbaaaaaaba\nabaabababbbbabbbbabbaaab\nbbaaaaaaabbababaabbbababbabbbabbbaabaaaabbabbaba\nabbbaabbabbabaabbbbbbbaabaaaaabbbbaaaabbbbbbabba\naabbbbbbaaabbaabaababbbababbabaaaaabbaaa\nabaabbaaaabababbabbabbabbbaaaaab\nbabbbababbbbbbbababaaaaa\nbaabbbbbaabbbaabbabbababbbbbbbbb\nbbaaabbbbbbabaabaaaaabaa\nbbababaaabbabbabbabbbaaabbabbbab\nbbbbabbababbababaababbaa\nbbababaabbabaabaabbaabab\naabbbaabbbbaababbabababa\nababaaababbbbaaaabbbbaaaaaababbb\nbaaaababbbaabaaabbabbbabaababbabbaaaaaaabbaaaaaa\nabbbababbaababbbbbaabbbbababbbaabaaababaabaababbbabbbbab\nbbabaaabbaabbaaabbbaaabaaaaabbabbaaaabaaabbbbabbbaabbbbbabbabaababaaaaab\nbbbbabbabbbbbbaaaaaabbbbabaabababbabbbbbbabaabbaaabbbbbbbbbbaaaa\nbaababaaaaabbbaaabaabbba\nbbbbababbbabbaabbbabaaababbaaaababababaa\naaaaaaaaaaaaaababaaababbabbbabaa\naaabbabababbbaaabaabbbbbababbbbaaabbbabb\naabaaaabbbbbaaaaababbaabaaabbbbabbaaaaaabbababbbaababaaabaabbaabbabaaaaa\naaaabaaabbaabbaaaabbabba\nbbbbaaabbaababaaababbabb\nabbbbababbbbabbbbbbbababbaabbbbbaaabaabaabababbabaaabaaa\nbaabbabaabbbaababbabbaba\nbbbbaabbbabbabaaaabaaaaababbaababaaabaabbbaaabaaaaababab\nabbbbbbababbabbbbaababababbabbabababbbbb\naaabbbabbbbaaaaaabbbabaababababb\naabbaaabaaabaaabbbaaabaaaabbaaaaaaabababbbaabaab\nbabaababbaabaaaababaaaaa\naaabbbaaaabaabbbaaabbbbb\nabaabaabbaabbabaaaabbbbaaabbbbabaabbbabb\nbaaababbabaaababaaababbababbbbba\naabbaaaabbabaabbbabaaabaaaaaaaabbbbaaaaa\nbbbabbbbaabbbbaabbbaaaabbbbaaabb\nabaaabababbabababbaabbbabaaabaaaaaaaaaabaabbbaaaaabbbbbbabbabbaaabaaaaaa\nbbbbbbbabbabbaabbabbbaaabaabbaaa\nbababbabbaabaabbaaabbbbabaabbbbaaabaaabb\nbbbbbababaaaaabbabbbbbbabaaaabab\nbabbabaabbbbaaabaaabbbbaababaabbaabbaabb\nababaabbbbbaaababaabbaaaabbabbbbaaabbaaa\nababbaabbbbbbaaaaaabbbbb\nbabbabaababbabbabaabbbab\nbbaabbaabbbbaabbabbbbbbaabbbaabaaaababbbbaaabbbbbaabbaaa\naabaabbbbabbbbbbabbabbaaabaabababbbbbabbbbaabaaa\nabbbbbbaaabbbbaaabbabbbb\naaaaaaaaababbbabaaabbaabababbbba\nbaaabbaabaaaabaaabaabaaabbaabbbbaaaaaaababaababb\nababbbaababbbbabbabaaaaabababbba\naaaaabaaaaabbbababaaabbbabbbabba\nbbbabbbaaaaaaaaaaaabbbbb\nabbbbbbabbabbabbabababaa\nbaaaaabaaaaabaaabbaabbba\nbaaaabbbaababbbaaaaaaabb\nbbbabaabbabbabbbabaabbbbaabbaababaaabaaababaabbb\nbbbabbaabbbaabbbbbbabbbabbababababbabbbb\nbaabaabbbbbaabbaaaababab\nbbabbaabbababbabbbabaabbbabbbbbaaaabbabaabbbbbbbababbaba\nbabbabbaabbaaabbbbabbbbabaaaaaaabbbaaaaa\nabaabbaabbbabbbaabbabaaaaababaaaaaaaabbb\naababbabbbabbaabbabaaabbabbabaabbbbaaababbabbaaabbaaaababbbaaabbbaabaabaabababaa\nabbabababbaaabbbbaababbaabaabbbbbbbbbbaa\nbbbabbbabbabbbbabaaabaaababaaababbbaababbbbabababbabbbabaaabaaaaaabaabbb\nbaaaaaababbabaabbbabaabaabbbbbabaaababab\nbaabaabababbbbbabbbbaabaaaaabbbb\nbaabbabaababbbabbabbbbab\nbbbbaabbbbbaaaabbbbbaaaa\nbbbbaababaabaaababbbbbaa\nbbbbbabbaaabaababbbaaaababaaabba\nababbbabbbbaaaababaaaabbbbaabbbaaaaaababababbbbababbbbbaababbbabaaaaaaababaabbababbbaaaa\naabaababbbbbababbaabbbab\nbaaaaababbbababbababaaab\nbaabaabbaaabbaaaabaabbbabbabbbbababbbbab\nabbbbbbababbbabaaabababbbbaabbbabbbbababaabaaabb\nbbabbabbabbabababaaaabba\nabbabbbabbbbbababaaabaaa\nbbbbbaabbabbbbaaabaaaaaabbbabbabaabbbabbabbabaaaabaababbbbbaaabb\nbaaabbbaaabaabaababaabab\nbaabaababaaaaabaabaabbaababbbbbabaaabbababbaabab\nbbabbbbabaaaabaaaabababbabbabaab\nbabbaababaaaaaabbbaabaab\nabaabbabaaabbbabaaaaabbbbbabababbbbaabbabbbabbbbabaaaaab\nababbbabaababababaabaaaa\nabaaabaaababbbabbaababaabaabbaab\naaabbbbabbbaabbabbabaabbbaabbbaa\naaabbbaaaabaabaaabbbbbbb\nabbbbabbababaabbbbaababbaabaabbbabbbbabbababbbab\nbaabaabbbbaaaababbabaabbbbabbaaaabbbaaaaaaababaaaabaabbbbbaaaaabbbbaaaaaaaaabbababbabbba\nabbaababbbaaaaabbaabbaaa\nbabbbbabbbaababaaaaaaaaaabbbbaabbbababbbabbaaaaabababbaabaabbaaaaabaabbbaaaaaaaaababbbbbabbaabaa\nabbbabababbabaaaababaaaaababbbbaabaabbbababbaabb\nabbaaabaaabbabaaababbaab\nbbaabbbabaabbbbbabbabbbaaabbaaaabbaaabbbabbaabbababbbbababbaabab\nabaaabbbbbabaababbabaaaa\nbbababbbbbbababbaaaaaaabbabaaabb\nbbbaabbbaabbbbaaabbabbaabaabaabbbababaaa\nbabbbaaaaabaabbbabbbbbaa\nabaabbaabaabbbbbabbbaabbaaabbaaa\nabbbaabaababbbabaaaaaaaabbbabbbabbbaabab\naaaabbaabbabbaabbbaababaabbabbbbabaaabbaabbbbbbbaababbbbbbaabbabaabbbaaabbaabbba\nabababbabbabbabbbbabbbab\nbbbababbaaaabaaabaabbbba\nbbbbaababbbbbbabbbbbabbaababaabaaababaab\nbbaaaaaaaabbbaaabaaabaab\nbabbbbbbbbbbbaaabbaaabbaaabbabbaaaabbaaa\nabaabbabaaabaababbbaaabb\nabaababaaaaaaabbbababaabaaaababaabbabaabababbbba\naaabbabaabaababaababbbba\nbbaaaaaababaaababababaaa\nabbabaaabaabaaabbabbaaba\nabbabababbabaabbabbabababbbaaaaa\naabaaabaababbbaaababaaab\nbbabbbbaabaaabbbabbaaaab\nbbbbababbbbaaababbbaaaba\nbbbbbbababbbbbbaaaaaabab\nbbababbbabaaabaabaabbaaaabbbabbabbbbbbaaabbabbbb\nbaababbbaaabbbaaaabaabbbaabaaabb\nabaabbabbaaaabababbaabbb\nbbbabaababbbbbbabaabaaabbabbbbbbbbbaabaabbabbbaaabbababb\nbabbabbbbbbbbabbbaaaababbbbbbbbababababa\nbaabababaabbaabbaabbabba\nbaabaababaaaaabbbabaabbbababbbaaabbaaaba\nbbbbabbbbaabbbababbbaabaabaabaaaaaaaabaaabbaaaaa\nbbabababbaabbabaabbabbaabaababaabaaaabba\nabbbbbbaaaaabbaabbbbbaabaabbabbbaabababaaaababbbbabbbbbabaaabbab\nbbbbaaabaaaabaaaaabbbaab\naabbaabbaaaaaaaaabbbbababaabababbabbabbbbbbbababaaabaabb\nbbabababbabbabbbbaaaabaaaabbaababbbaaaaaabbbaaaa\nbbabbabbaaabababbabbbbababaabbabbbbabbbababbaaab\nabaaaaaabbbaabaaaabbbbabbababaab\naabababbbabbabbabbaabaaa\nababbbaaaaabbabaaaabbabbaaaaaabb\nbaaaababbbaaaababbbbbabbbbbaaabaabbabaaabbbbbabaaaaaaaababbbababaabbbbbbaabbbbaa\nbaabbbbbbbbbaabaabbababb\nbababbababaabbbbababaaab\nbaababbbbabbaabbabbabbaabababbabaaaabbbaabaabaaa\naabaabababaaaabaabababbbbaaabaaaabaaabab\nabbaaaaababbabbabaaaabbbbaaaabba\nbabbbaaabaaaaabbbabbbbab\nababbbabbaabbabaabbbabba\nabaabbabaaaabaabbaaabbbbbbbabbaaaaabaabb\nbbbaabbaaabbbaabbaabaabaababbaab\nababbbaabbbbbbbabaababaaabbabbabaababaaabbbaaababaabbaab\nbbbbbbbabbaaaaaaaaabbbababbbbbbb\naabaaababbabbabaaaaabaaabbabbaabaabbbbbbababaaaa\nbaabaaabaaabbbabbababbabababbaba\nabbbabbbababbabbbbbbaaaababbabbbaaaaaaaaabbaabbabbaaaaabbbabaaaabababbbaaabbabbb\nbaabaaabbabbababbbbaabbaaaabbaabbbbbabbbabbbaaabbbbabaaa\nabaaabbbabaabaaaabbbbbabaaabbbbabababbbbbabbbbabaabaaaaa\naaaaaaaaabaaaababbbaaabababababa\nbbbbaabbbababaaaaaaaaaab\naaabaaaabaaaababbabbbbbbaaaabbababbbabaa\nbabaaababbbbbbbaabbbbabb\nbaaabbaaaabbbbaabbbababa\nbaababbbaababbbabbbaabbbbbbbabaaaabbaaab\nbaaaabaabaabaabbbababbababbbaabbaaabbaabbaaaabba\nbaabaababbbaabbbabbabababaaaaaaa\nbbbababbaabbababaaaaabbb\nbbbabaaaaaaaaaaabbbaabbbbabaabbaabaaabbbabbaabbbbabbbbab\naaaaaaabbaababaaaaabaaaababbbaab\nabababbaababbbabaabbbbaaaaaabaaaabbaaaba\nbaababbaaabaabbbbbbaabbabbbbaabbaabbabaabbabbbabaabbabba\nabaaabbbbabbbaaabbbbaabaabaabababbaaabbbaabbbbabbababbbabaabbaaabaaabaaa\naabaaabaababbaabbbbbbbabbaaaaabbaaaabbba\naabbabaaabbbbabababbbbbbbaaabbbabaabbaaababbbbabbbbabaaa\nabaabbbbbbbbabbbabbaaaaabbaaaaaaabbabbbbabababaa\nababaabbbbbbabaaabbaabba\nbbbbababaababaaaaaaabbaabaabaaaa\nabbbababbbbbaaababaaaabb\naabbbbbbaababbbaababbbabbaabbabaabaababaaaabaaab\naabaababaaabbbaabbaababababbbaaaabababaa\nabaabaabbabbbababbaaaabaabaaabaabaabaabbabbababbaaabaaababaaabba\nbaaaaabbbbbaaaabbbbbbabb\nabbbababbbbbbbbaabbaaaaababbbabbabababbaabaababb\naabbaababbabbaabbbbbaabaaaabbabbababbaba\nababbbaababbbbbabbbabaaa\nabaaabbbabababbaabaaabbb\nabababbabbabbababbbaabbaababbbaaaabbaaab\nabbbbabbbaabaabbbaaaabbbbaaabbbbbbbabbbaababbababbbabbab\nbbbbbaabbbaababbabbbaaaababbbabaaaababaaabaabbaa\nababbbaababababaaabaabbbabaaabbbbaabababbabbbbbaababbaaa\nbaababaabbbabbbbaaabaabb\nbabaabbbbbaabbbbbbabbabaabbbaaaaabbaabbabbbbaabaabbabbbbbbabbbaa\nbaabbabaaabbbababbaaaaba\nabbbbbabbaaabbbabbaabbaaaabbbbaaaabbabbabaabbbba\naaaaaaabbaaabbbaaaaabbab\nbaabbbbbbaaabbbbaabbabaaaababbabbbaababaaabbbbbaabaaaaaabaabaabababbbaaa\naabbaaaaabbabaaaabbbbbaa\nbbbabaabbbaaaaaaaabbbabaababaaab\nbabbabaaaaabbbababaaaaaa\nbaabbabaabaaabbbaabaaaaa\naabbaababbababbbbababaabaabbbbba\nabbbbabaaabaaababbbbbaaaaaabaaab\nbbbabaabbbbbabbaaababaaa\nbbbbbabaabbaaabaaaabbbaaabbbbbbabaabbbaaabbbbbbbbaabbaaa\nbbbbaaaabaabaabbbbabbabbbbbbbabaaaaabaaabbabbbbbbaabbbabaaabaabb\nbbbbbaaabbbbabaabbabbbbbbaabaaabbabbbbbaabbbabbaabbbbbaa\naaabbbabbabbabbbbabaaaaaabbbbbaaaaababaaaaaaabbaabbabababababaaabbbababaabbaaaabbaaabaaababbaabb\nabbaaaaaabbababaaababababaaaaabbaaabbaaa\naaaabaaaaabbabaaaaaabbaa\nbbbbbbbabaababbbbbbbaaaabbbbbaab\nababaaaababbabbabbbababaabbaaabbabbbbbbbaabbababbbabbaba\nbbbbbbbaaaaaababbaabbaaaaaababbbabaaabab\nbaabbbaaaaabbbbabbababbaaaaababaabbababaaaabbbbbbbbaaaababbbbbaababaaabb\nbbbabbbaaabbbaabaaababbaaaabbaaa\nbaabaababbbbbaaabbbbabaaaabbabbaaaabaabb\nabbbaabbabbabbabbbbaabbbbbabbbab\nbabbabaaabbabbbabaababaabbabaaba\nbaababbbbaaaabaaabbbaabbbbbaaaaa\nbbaababbaaabbbbabbbabaaa\nbabababaaabbababbbbbabbbbbbababbabbbabbaaabbabbbabbaaaabbabbbabbaabbaaba\nbbbbaaaabaaaaaaabbaaabaabaaaababaabaababbbbabababbabbbbaabbaaaabbbbaaababbbabbababaababb\nbabaaabbaabaaabbbabbbaabaaaabbbaaaaaabababababbabbababba\naaaabaaabbabaaabaabbbaaabbbbabaa\nabbababaabaabbaabbbababbbbabbbbbaabbaaaaaaaabbabaaababbbbbabbbaa\naababbbababbabaabbbbabbaaabaaababbbbabababaaabaaaababaaaaabbaaab\nababbbaaaababbbaabbbbabaabaaabaabbbaabbaabbbbbaabbbaaaaabaabbabb\nbbbabbaabaabababaabbababaababaaa\naaaaaaabbbbbbbabbabaabaa\nabaabaaaaabbaaaabbbbaabaaabaabaabbbaabaa\naabbabaabaaabbaaaaaabbbb\nabbabbaabaabababaabbbaabbbbbaababbbbabbbabbbaaab\nabbaaabbabaaaabaaaaaabaaaababbbbbaabaaabaaabaabbbbabbabbbbbaaabababbabbabbbbbaaa\nabaaabbbbabaaaaaabbaaababaaaaabaababbaababaabaaaabaaaaabbbaaaaab\naababababbbbbbbaabaabbabbbbbbaaaabbbaaaa\naabbaabaaabbaaaaaabaababaabbbbab\naabaaababbaaaaaabbababababaaaaabbababaab\nbaababaababbabbbabbaabaababbaabbaabaabbabbbbbaab\nabaaabaaaaabbbaaabbababababbbabaaababaaa\naabaaababbbbbabbbaabbabb\naaabbabbaaabbbaabbbbbbababbababb\naabaaaabaabbbbaaaaaabaaabbaabbbaabbbbbbb\nbbbbabaaaabbababbbabaaabbabaabba\nbaabaabaaabababababbabbbbbababaaaaababab\naabbbaaaaabbbbaaababbaaaababbbbaababaaaabbbabaab\nabbaaabbbaabbbbabababbbabaabbbbaaabbabaabbaaaaba\naaaaaaabbbabaabbaabbbabaabbababaabbbbbbaabbbbaaaabababaaaaaabbbbaabbabba\nabbbbabaabaabaabbbabbbbaabbbbabaabababbbbbaabbabbaabaaaa\nabaabababbbbbabbbabaaaab\nbababbabbbbabaaabbaaaabb\nabbabaaabbbababbbbbaabbaaabbbbaababbaaba\nbbbbaabaaabbbbbbabaabaaaaabaababbabbabbbabaaabab\nbabbabbbbbbabbaabbbabaabbbbbbbbb\nbabaabaaababbbbaabaabbbaababaaabbbabbbaaaaaaaaaabaababbbbaabbaaa\nbbbbaabaabbabbaaabaabaaababababa\nabbaababbbbabbabaabbbbbaababaaabaaabbbaaabaababbbbbaabaa\naabbaaaabbbbababaaaabbab\naabaababbabbbabaaabababaabaaabbaabaaaabb\nbbabbabbbbaabbbbabaabaaaaaaaaaababaaabba\naaababbaabababaabababaaababaabaaabaaaabb\nbaaabbbabbaaaaabbaabbbab\nbababaabbabbbababaaaababbabbaabbbbbaababbabbabbb\nbbababaaabbbaabbaaabbbabaaabbbaabbbaaaaa\naabbbbaaabbbbbabaabaaababbaabbaaaabbbbbaabaaababbbbaabab\naaaaaaabaaaababbabababbaaababaabaabaaaaaabbaaaaaabaabbbaaaaabaaa\nabaabbbbbbbabbaaaababbab\nbbaaaaaaababaabbbaabaaabaababaaa\naabbbababaabababbabbbaab\nabaabbbbbbaaaaaabbbbbbbabbbbabbbbabbaabb\naabbbbaabbababaabababbba\nbababbabaaaabaaabaababaaaaaaaabb\nbbbbaababbbabbaabbaabbaaabbbaabbbbabbaabaaaaaabb\nbbbbabbabbbbaabaaaabaaaabaaaaabbaaabbbbaabaabbbaaabaaaaaabbaabbb\nabbabaaabbaababbaabaaabbbbabbaabbbaabbbb\nbbaaabbabbbbbababababaababaaaaaababaaaaaaabbbbab\naababbbaabbbbabaabbabaab\nbbbaabbbaaaaabaabbaaaaab\nbbabbabbbbaaabbbbbaaaaaababaabbaababbabbabaabbbabbaaaabb\naaabbabaaabaabbbbbaababbbaaaaaababbabaab\nabbabbabbbaabbaabbaaabaa\nabaabbabaaaabaaaaaaaabab\nabbbbaabaabbabbbaabaaabbbaaaaaaa\nabbabbaaaababbbabbabbababbaababaabbabaabbbbaaabb\naabaaaaabbbababbbaaababbabbbbababababaaabbabbbba\naaabbabababbbababbbaabbbbaabbbbaaababaaa\naabababbaaabaaaabbababaaaaaababb\nabbaaaaaabababbaabaabaababbaaababaababbbaaaababbbabbaaabaabbabbaabbaabba\nbbaaaabaaaabbaabbbaaaabaababbbbb\nababbbabbaababbbabaabaababbbababbbaabbaaabaababbabaaaaab\naabaaabaababaabaababaaaa\nbaabbbbbbaaaaabbbaabbbaa\nabbabbabbabbabbbabbbbabaabbbabbb\nababbaabaabbababbbbababbbbbbabaabbabbbabbabbbbaa\nbbbabaabbababbabbbabbbaa\naabaabbbaaabbababaabaaababababbbaabababbabaabbbabaaabaabbababbba\nabaabaabababaababaabbabb\nbbaabbbaaaabbbabaaababaa\nbbbbabbbaabbaaaaabaaabba\nbaaaabbbbbbbaaabbaaaaabbabaabbabaabaabbbbaabbbabaababbaa\nbbabaabbbaababbabbaabbaaaaabbbababaabbbaaaaabbab\nbabaaababbbabbbbabaabaaababaabbb\nbaaabbaabaaaabaaaaabaabaaaaabaaaaaabababababaaab\nbbbbbabbbbaaaaaabaababbababbaaaaabbaabbb\nabaaabbbabbbaabbbaaabaab\nbbbabbaaaaabaabaaabababaaaabbbabbbbbabbbaababaab\nbbbbabbbbaabbabbaabbbbbbabaaababbbbaaabaaaaabaabaabbaaab\nbaaaabbaaaaababbbbaaaaabbbbbbbaababbbabb\nbbaabbbaababbaabbabbabababbbaababaabaaaa\nbbbabbbbbaaaabbbabbbbbbaabaabbabbababaab\nbaababbbaabaabaabbaababaabaaabbbbbbababbbaaaabba\nbabbabababbbbbabababbbba\naabbbaaabbaaabbaabaaabab\nbbbbbbbaabaaabaabbbbbabaabaababbabbabaab\nbbaabbbbaaabbaababaaabbabababbbaaaabababbababaaaaabaaaab\nbabbbabaaabbabaaaabbbaabbabaabab\nbbaaaabaaaaaaabbababbaaaababbbbbabaabaaababbabbbabbaaaaaaaaaababaaabbabbbbbbabaa\nababaabbaabbaaaabaaaaabbababbbba\nbaaaababbbbbaabbbaaabaaa\naababababbbaabbabbaabbbb\nbaababbaaaabbabbababbaba\nbabbabaabbbbbbbaaabbbabb\nbbbbbbabbbbbbbabbbbbbabbabaaaabb\nbbbaabbbbbbbbababababbbb\naabbaaaabbabbabbbbbaabaa\nbbababababbbbaabaaabaababbbbaaabaaaabbab\nababbaabaabbbaababbbaababbabbabbaaabbababaabbaabababaaaaaabaaaaa\naabaababbabbbaaaabababbaaaaabbab\nabbaaabbaabbaababbbabbbaababaaaa\naabaabaabbbbbabbaabbaabaaabaabaabaabaabbaaaabaaababbaabb\naabaaaabbbbbaaaabaaabbbbbbbbaaabababaaabababbaabbbaabaabaababbaabaaaabab\nbbbabbabaaabaaaabababbaabaaabbbabbaabbba\nbbaaaabababbbbaabaaabbaababbabbaaabbbababaaaabaaabbbbbbb\nbbaabbaaaaaaabaaaaabbbbabbbbbabbbaabaabaaabbbabb\nbbaabbbaabbaaaaaaaabaabababababbaabaaaaa\nbabbababbaabaababaababbabbbbbbabbbbbaabbbaabbbbbbabaabab\nababaabbaabbbaabaaaabbba\naaaabaaaabbabbbabbbbababbbaabbab\naaabaaaaaaabbabaaaaaabbb\nbbbbabbaababbaabbbabbabbabaaaabbabaaabba\nababbaabbbabbbbbaaaabbba\nabbbbabaaabbbaabbbbaaaabababaaaa\naaabaabaaabbbbbbaaabaababbabbabbbbbabbab\naaabaababaaaaaabbababbabbabaabbaabababbabaabaabaaaababbabbaabbaa\nbaaabbbabbabbaababbbaaab\naabbabababaabbabaaaaaaba\naabbbabaabbaaaaaaababbaa\nbbbbbbabbaaaabaaabbabbabbaaaababbbababaa\naababababaaaaabbaaaaabaabbabbabbabbbabba\nbbbbaaababbbbabaabbbaaaa\nbabababbbabababaabaabbabbbbbbbbbaaaabbaaaababababbabaaab\nabaaabbbaabbbaabbbbaaaba\naabbaabbbabaaabaabbabaaabbbbbaba\nbbbbaaabaaabaabaababbaabbbababbbabaaabbbabbaabaababaabababbbbabbbababbba\nabaaabbbaabbaabbabbabbbabbbaaaaabaaabaabbbbbaabbaaabbbbaabababab\nbbabbbbaaabbbabaababbbaaababaabb\naabababbbaabbabaaaaaabab\nabaababaabbababaaabbaabbbbbaabbaaaaababa\naaabbbabaababbbabbbaaaabbabbbbaabaaabaaa", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kQuote, Type = String, Dynamic = False, Default = \"\"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"0: 4 1 5\n1: 2 3 | 3 2\n2: 4 4 | 5 5\n3: 4 5 | 5 4\n4: \"a\"\n5: \"b\"\n\nababbb\nbababa\nabbbab\naaabbb\naaaabbb", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"42: 9 14 | 10 1\n9: 14 27 | 1 26\n10: 23 14 | 28 1\n1: \"a\"\n11: 42 31\n5: 1 14 | 15 1\n19: 14 1 | 14 14\n12: 24 14 | 19 1\n16: 15 1 | 14 14\n31: 14 17 | 1 13\n6: 14 14 | 1 14\n2: 1 24 | 14 4\n0: 8 11\n13: 14 3 | 1 12\n15: 1 | 14\n17: 14 2 | 1 7\n23: 25 1 | 22 14\n28: 16 1\n4: 1 1\n20: 14 14 | 1 15\n3: 5 14 | 16 1\n27: 1 6 | 14 18\n14: \"b\"\n21: 14 1 | 1 14\n25: 1 1 | 1 14\n22: 14 14\n8: 42\n26: 14 22 | 1 20\n18: 15 15\n7: 14 5 | 1 21\n24: 14 1\n\nabbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa\nbbabbbbaabaabba\nbabbbbaabbbbbabbbbbbaabaaabaaa\naaabbbbbbaaaabaababaabababbabaaabbababababaaa\nbbbbbbbaaaabbbbaaabbabaaa\nbbbababbbbaaaaaaaabbababaaababaabab\nababaaaaaabaaab\nababaaaaabbbaba\nbaabbaaaabbaaaababbaababb\nabbbbabbbbaaaababbbbbbaaaababb\naaaaabbaabaaaaababaa\naaaabbaaaabbaaa\naaaabbaabbaaaaaaabbbabbbaaabbaabaaa\nbabaaabbbaaabaababbaabababaaab\naabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba", Scope = Private
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
