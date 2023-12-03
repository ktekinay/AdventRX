#tag Class
Protected Class Advent_2021_12_10
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Syntax Scoring"
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Variant
		  return CalculateResultA( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Variant
		  return CalculateResultB( GetPuzzleInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Variant
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var lines() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var score as integer
		  
		  for each line as string in lines
		    var stack() as string
		    score = score + GetLineScore( line, stack )
		  next
		  
		  return score
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var lines() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var scores() as integer
		  
		  for each line as string in lines
		    var stack() as string
		    if GetLineScore( line, stack ) = 0 then
		      //
		      // Incomplete line
		      //
		      var score as integer
		      for i as integer = stack.LastIndex downto 0
		        var char as string = stack( i )
		        select case char
		        case ")"
		          score = score * 5 + 1
		        case "]"
		          score = score * 5 + 2
		        case "}"
		          score = score * 5 + 3
		        case ">"
		          score = score * 5 + 4
		        end select
		      next
		      
		      scores.Add score
		    end if
		  next
		  
		  scores.Sort
		  return scores( scores.Count \ 2 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetLineScore(line As String, stack() As String) As Integer
		  var illegalChar as string
		  
		  var chars() as string = line.Split( "" )
		  
		  for each char as string in chars
		    select case char 
		    case "<"
		      stack.Add ">"
		      continue
		      
		    case "["
		      stack.Add "]"
		      continue
		      
		    case "{"
		      stack.Add "}"
		      continue
		      
		    case "("
		      stack.Add ")"
		      continue
		      
		    end select
		    
		    if stack.Count <> 0 then
		      if char = stack( stack.LastIndex ) then
		        call stack.Pop
		        continue
		      end if
		    end if
		    
		    //
		    // If we get here, it's illegal
		    //
		    illegalChar = char
		    exit for char
		  next char
		  
		  select case illegalChar
		  case ")"
		    return 3
		  case "]"
		    return 57
		  case "}"
		    return 1197
		  case ">"
		    return 25137
		  case else
		    return 0
		  end select
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"[({(<(())[]>[[{[]{<()<>>\n[(()[<>])]({[<{<<[]>>(\n{([(<{}[<>[]}>{[]{[(<()>\n(((({<>}<{<{<>}{[]{[]{}\n[[<[([]))<([[{}[[()]]]\n[{[{({}]{}}([{[{{{}}([]\n{<[[]]>}<{[{[{[]{()[[[]\n[<(<(<(<{}))><([]([]()\n<{([([[(<>()){}]>(<<{{\n<{([{{}}[<[[[<>{}]]]>[]]", Scope = Private
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
