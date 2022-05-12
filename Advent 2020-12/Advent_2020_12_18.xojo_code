#tag Class
Protected Class Advent_2020_12_18
Inherits AdventBase
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
		  var rows() as string = ParseInput( input )
		  
		  var result as integer
		  for each row as string in rows
		    var index as integer
		    result = result + Evaluate( row.Split( " " ), index )
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as string = ParseInput( input )
		  
		  var result as integer
		  for each row as string in rows
		    var tokens() as string = row.Split( " " )
		    
		    var index as integer
		    result = result + Evaluate2( tokens, index )
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Evaluate(tokens() As String, ByRef index As Integer) As Integer
		  var result as integer
		  
		  const kModeAdd as integer = 0
		  const kModeMultiply as integer = 1
		  
		  var mode as integer = kModeAdd
		  
		  while index <= tokens.LastIndex
		    var token as string = tokens( index )
		    index = index + 1
		    
		    select case token
		    case ""
		      continue
		      
		    case "("
		      var nextResult as integer = Evaluate( tokens, index )
		      
		      if mode = kModeAdd then
		        result = result + nextResult
		      else
		        result = result * nextResult
		      end if
		      
		    case ")"
		      return result
		      
		    case "*"
		      mode = kModeMultiply
		      
		    case "+"
		      mode = kModeAdd
		      
		    case else // A number
		      if mode = kModeAdd then
		        result = result + token.ToInteger
		      elseif mode = kModeMultiply then
		        result = result * token.ToInteger
		      end if
		      
		    end select
		  wend
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Evaluate2(tokens() As String, ByRef index As Integer) As Integer
		  var newTokens() as string
		  
		  while index <= tokens.LastIndex
		    var token as string = tokens( index )
		    index = index + 1
		    
		    select case token
		    case ""
		      continue
		      
		    case "("
		      var subresult as integer = Evaluate2( tokens, index )
		      newTokens.Add subresult.ToString
		      
		    case ")"
		      exit
		      
		    case else
		      newTokens.Add token
		    end select
		    
		  wend
		  
		  if newTokens.Count = 0 then
		    return 0
		  end if
		  
		  //
		  // newTokens will only have numbers, +, and * now
		  //
		  
		  for newIndex as integer = newTokens.LastIndex downto 0
		    if newTokens( newIndex ) = "+" then
		      var sum as integer = newTokens( newIndex - 1 ).ToInteger + newTokens( newIndex + 1 ).ToInteger
		      newTokens( newIndex - 1 ) = sum.ToString
		      newTokens.RemoveAt newIndex + 1
		      newTokens.RemoveAt newIndex
		    end if
		  next
		  
		  while newTokens.Count <> 1
		    for newIndex as integer = newTokens.LastIndex downto 0
		      if newTokens( newIndex ) = "*" then
		        var total as integer = newTokens( newIndex - 1 ).ToInteger * newTokens( newIndex + 1 ).ToInteger
		        newTokens( newIndex - 1 ) = total.ToString
		        newTokens.RemoveAt newIndex + 1
		        newTokens.RemoveAt newIndex
		      end if
		    next
		  wend
		  
		  var result as integer = newTokens( 0 ).ToInteger
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As String()
		  var rx as new RegEx
		  rx.Options.ReplaceAllMatches = true
		  
		  rx.SearchPattern = "\((?!\x20)"
		  rx.ReplacementPattern = "( "
		  
		  input = rx.Replace( input )
		  
		  rx.SearchPattern = "(?<!\x20)\)"
		  rx.ReplacementPattern = " )"
		  
		  input = rx.Replace( input )
		  
		  return ToStringArray( input )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"1 + 2 * 3 + 4 * 5 + 6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
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
