#tag Class
Protected Class Advent_2021_12_14
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( GetPuzzleInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  return GetForSteps( input, 10 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  return GetForSteps( input, 40 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountElements(template As String) As Dictionary
		  var result as new Dictionary
		  
		  var chars() as string = template.Split( "" )
		  chars.Sort
		  chars.Add ""
		  
		  var refChar as string = chars( 0 )
		  var refIndex as integer
		  
		  for i as integer = 1 to chars.LastIndex
		    var char as string = chars( i )
		    
		    if char <> refChar then
		      var count as integer = i - refIndex
		      result.Value( refChar ) = count
		      refIndex = i
		      refChar = char
		    end if
		  next
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetForSteps(input As String, stepCount As Integer) As Integer
		  const kLastCharPairIndex as integer = 25 * 26 + 25
		  
		  var template as string = GetTemplate( input )
		  var rules() as Rule = GetRules( input )
		  
		  var charCount( 25 ) as integer
		  var chars() as string = template.Split( "" )
		  for each char as string in chars
		    var charIndex as integer = IndexForChars( char )
		    charCount( charIndex ) = charCount( charIndex ) + 1
		  next
		  
		  var charPairCounts( kLastCharPairIndex ) as integer
		  for i as integer = 1 to template.Length - 1
		    var charPair as string = template.Middle( i - 1, 2 )
		    var charPairIndex as integer = IndexForChars( charPair )
		    charPairCounts( charPairIndex ) = charPairCounts( charPairIndex ) + 1
		  next
		  
		  for stepIndex as integer = 1 to stepCount
		    var charPairIncrements( kLastCharPairIndex ) as integer
		    
		    for each r as Rule in rules
		      var pairCount as integer = charPairCounts( r.PairIndex )
		      if pairCount <> 0 then
		        charCount( r.IncrementCharIndex ) = charCount( r.IncrementCharIndex ) + pairCount
		        charPairIncrements( r.IncrementPairLeftIndex ) = charPairIncrements( r.IncrementPairLeftIndex ) + pairCount
		        charPairIncrements( r.IncrementPairRightIndex ) = charPairIncrements( r.IncrementPairRightIndex ) + pairCount
		        charPairCounts( r.PairIndex ) = 0
		      end if
		    next r
		    
		    for i as integer = 0 to charPairIncrements.LastIndex
		      charPairCounts( i ) = charPairCounts( i ) + charPairIncrements( i )
		    next
		  next stepIndex
		  
		  var leastIndex as integer
		  var leastCount as integer = &h7FFFFFFFFFFFFFFF
		  var mostIndex as integer
		  var mostCount as integer
		  
		  for i as integer = 0 to charCount.LastIndex
		    var count as integer = charCount( i )
		    if count = 0 then
		      continue
		    end if
		    
		    if count > mostCount then
		      mostCount = count
		      mostIndex = i
		    end if
		    
		    if count < leastCount then
		      leastCount = count
		      leastIndex = i
		    end if
		  next
		  
		  return mostCount - leastCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetRules(input As String) As Rule()
		  var parts() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine + EndOfLine )
		  var rows() as string = parts( 1 ).Split( EndOfLine )
		  
		  var rules() as Rule
		  
		  for each row as string in rows
		    parts = row.Split( "->" )
		    var chars as string = parts( 0 ).Trim
		    var insertion as string = parts( 1 ).Trim
		    
		    var r as new Rule
		    
		    var ruleIndex as integer = IndexForChars( chars )
		    r.PairIndex = ruleIndex
		    r.IncrementCharIndex = IndexForChars( insertion )
		    r.IncrementPairLeftIndex = IndexForChars( chars.Left( 1 ) + insertion )
		    r.IncrementPairRightIndex = IndexForChars( insertion + chars.Right( 1 ) )
		    
		    r.TriggerChars = chars
		    r.InsertChar = insertion
		    
		    rules.Add r
		  next
		  
		  return rules
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetTemplate(input As String) As String
		  var parts() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine + EndOfLine )
		  return parts( 0 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IndexForChars(s As String) As Integer
		  if s.Length = 2 then
		    var leftChar as string = s.Left( 1 )
		    var rightChar as string = s.Right( 1 )
		    return ( ( leftChar.Asc - kA ) * 26 ) + ( rightChar.Asc - kA )
		    
		  else
		    return s.Asc - kA
		    
		  end if
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kA, Type = Double, Dynamic = False, Default = \"65", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"NNCB\n\nCH -> B\nHH -> N\nCB -> H\nNH -> C\nHB -> C\nHC -> B\nHN -> C\nNN -> C\nBH -> H\nNC -> B\nNB -> B\nBN -> B\nBB -> N\nBC -> B\nCC -> N\nCN -> C", Scope = Private
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
