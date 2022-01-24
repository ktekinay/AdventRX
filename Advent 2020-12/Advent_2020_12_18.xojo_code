#tag Class
Protected Class Advent_2020_12_18
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


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"6 * ((4 * 8 + 4) + (3 * 5 + 3 + 3 * 7 * 5)) + 7 + (9 * (6 + 9 * 7 + 2 * 6 * 6)) + 2\n6 + 6 * (8 + 9 * 6 * 7 + 4 * 8) * (3 * 2 + 8 * (5 * 8 + 6 * 3 * 7 + 4))\n((2 + 5 * 5 + 8 + 3 + 4) + 8 * 7 * 6) * 9 * 8 + 2\n(2 + 7 * (3 + 5 * 2 + 3 + 6) * (4 * 6 + 8 * 3 * 2 + 7)) + 3 * ((2 + 8 + 6) * 8 + 9 * 6 * 6) + 5 + 6 + 5\n((5 * 8 * 4 + 6 * 9) + 2 * 7 + 2 + (6 * 7 + 6)) + 6 + 6 * 9 * (2 * 8 * (3 + 7) * 9) * 7\n6 * 4 + 8 + (2 * (4 * 3 * 7 * 4) * 3)\n6 + 8 + ((3 + 7 + 4 + 9 + 6) * 7 + 9 + 2 * 4 * 6) * (3 + 6 * 5 * 2 * 4) * 3 + 9\n(5 * 5 * 5 * 7 + 9) * 7 * 5\n9 + 5 + (2 + (2 * 3 + 5 * 9) * 6) * 2 * (2 * (4 + 5 + 2 + 9 + 3))\n8 + 7 + (2 + 4 + 5 + 9) * (7 + 4) * 7\n9 * (3 + 9 + 5 + 7) * 5 + 6\n2 + 3 + 4\n8 * 4\n6 * 4 * (2 * 7 * 7 * 2) * 4\n2 * (6 + 5) + 5\n(5 + 6 * 2 * 3) * (3 + 8 + 4 + 2 + 6) * 8\n((7 + 7 * 3 + 3 + 7) * 3 + 7 + 2 * (3 * 8 * 2 + 2 * 7 * 4) + 9) + 4 + 3 * 7\n6 + 8 + ((4 + 9 + 5 + 9 + 5 + 6) * 6 * (3 * 5 + 2 * 8) * 9 * 5 + 9)\n(4 * 2) + 7 + 9 + 8 + ((2 * 9 * 4 + 3 + 7 + 8) + 7 * 9)\n2 * 3 + 3 * 8\n9 * 6 * 3 * 8 * ((8 * 4 * 2 * 6) + 3 * 8)\n7 * 8 + 5 * 8 * 9\n7 * ((3 * 3 + 4 + 4) * 3) + 8 + 7 + 2 * 8\n2 * (9 + 9 * (8 * 9))\n(8 + 6 + 9 * (5 + 5 + 5) * 6 * 9) * ((2 + 7 * 6 + 2) + 4 * 9 * 8 * (5 * 2 + 5 + 2 + 5))\n(6 * 9) + 5 * 8 * 8 + 8 * (7 + 4 + 6 * (9 * 9) + 8)\n2 * 9 + 3 * ((3 * 7 * 4 * 3 + 3 * 8) * (8 + 6 + 3 * 8 + 6) + 5 + 3 + 7 + 5) + 9 * (3 + 3 + 6 + 4)\n((9 + 2 * 7 * 8 + 7) + 3 * (6 + 9 * 3)) + 7\n4 * (8 * (6 + 3 * 4))\n4 + 3 + 7 + 4 + 2 * 7\n7 * 8 * 5 + 7\n(7 * 9) * (2 * 9 + 5 + (5 + 2)) + ((9 + 7 + 9 * 7 * 4 + 8) * (6 * 7 + 4) + 3 * 7 + 4 * 8)\n(8 * 6 * 9 * 7 + 2 * 2) * 8 * 2 * 9 + (8 + 9 * 7 * 8 * 7) + (5 * 5)\n9 * 4 + 8 + (8 * 6 * 4 + (5 * 6 * 3 * 6 + 3) + 5) * 9 + 4\n7 * (7 * 8 * 9) * 2\n(3 + 3 + (8 + 5 * 6) + 7 + (9 + 8 + 2 * 3 * 9 + 2)) + (3 + 4 + (9 * 5 * 2 + 2 + 8) + (4 * 3 + 4)) + 8 * 6 * ((9 + 8) + 9 * 3)\n3 + 2 + 7\n(6 + 6 + 6 * 3 + (5 + 5 * 4)) * (3 * (9 + 2 + 4 * 5 * 3 * 3)) + (3 + 6 + 6 + 5 + 6 * 8)\n(9 + (9 * 7 + 7 * 4 + 2) + (8 * 8) + 5 + 9 * 2) * 5 * (5 * 9 * 5 + 8 * 6)\n2 + 5 + (2 + 2 + (7 * 2 * 7)) * (2 * (6 * 5 + 9 * 4)) * 4\n5 + 7\n7 + 5 * 4 * ((8 + 6 + 9 * 7 * 7 + 6) + 3 + 3 + 5) * (8 + (4 * 2 * 9) * 5 * 6 + (2 * 8 + 2 * 7)) + 8\n6 * 7 * (2 * 3) * 3 * 3\n6 * 3 + 8 * (4 * 7 + 9) + 4 * 7\n4 + 2 + ((3 + 7) + (4 + 9))\n4 + 8 * 6 * 5 * 7 + (7 * (8 + 5 + 5 + 2 + 3 * 5) * (6 + 3) + (2 * 3 * 5 + 4))\n4 + (7 * 7 * (5 * 4 + 8) * 2) + 8 * 3\n(4 * 9 * 8 * 9 * (6 * 7 + 2 * 5 + 6)) * ((4 + 2 * 5 + 9 * 9) * 3 + 8 * 2) + 9 + 9 + 2\n4 * 5 + 9 * (4 * (8 + 8 * 5))\n7 + (7 * 5 * (5 * 6) + 2 * 2) + (6 * 3 * (7 * 9 + 2 * 6)) + 5 * 7 + ((7 * 4 * 4 + 8 * 8 * 6) * (8 * 8 * 7 + 9 * 3 + 2) * 2 * 5)\n(8 + 3 * 6 * 6 * 2 + 4) + 4\n9 * 8 * (9 + 8)\n((9 * 4 + 5 + 5) + 2 + 8 * 6) * 6 * 5 * 9\n(7 * 3) + 3 * 8 * 3 * 7 + 8\n8 + (9 * 7 * (6 + 2)) * 9\n((6 + 9 * 2 + 7 + 4) * 5) * 7 + (6 + 3 * 9 + 5 + 9 * 4) + (3 * 6 * 3 + 8) + ((4 * 3 + 2 + 2) + 9 * 5 + 5 * 5)\n(8 * (8 * 6 + 2) * 4) * 4 * 6\n2 + 9 + (3 * 9 * 4 + (7 * 7)) + 7\n(2 * 3 + 2) + ((8 + 4 + 6 * 7 * 8 * 3) * 8 + (3 + 2 + 3 * 8 * 6 + 3) + 8)\n2 * (9 * 7 * (4 + 5 + 8)) + (3 + (7 + 2 * 6 + 2) + 7 * 2 * 9 * 7) + 2 * 4 * 3\n5 + ((9 * 6 * 6) + (6 * 6 + 5) * 2) * 9 + 7 * ((8 * 8 * 2 + 2) + (4 * 9)) + (7 + 2 * 4 + 7 + 6)\n((7 * 9 + 8 * 6 * 4 + 8) + (9 + 9 + 6 * 4) + 6) * 3 * 8\n2 * 5 + 6 + 7 * (6 * (7 * 5 + 2 * 2) + 7 * 8)\n4 * (4 * 4 * 2 + 3 * 9 + 7) * 7 + 6\n7 + 3 * 4 + 2 * 8\n6 + 3 * 8\n5 + ((6 + 2 * 3 + 4) + 8 + 4 + 5 * 6 * 6)\n(2 + (6 + 3 + 4 + 9) * (7 + 3 + 2 + 7 * 9) + (2 * 2 * 7 + 9 * 7) + 4 + 4) + ((5 + 5) + 4 + 5 + 2 * 2) + 2 + 4 * 6\n(5 * (4 + 4 * 5 * 7 + 9 + 6) * 9) * 6 + 2\n(6 + 2 + (8 * 9 + 2) + 8 + 5 + (7 + 2)) * 6\n(9 * 3 * (8 * 7 + 6 + 7 * 3)) + 3\n(4 + 4 + 2 * 9 + (5 * 9 * 3 + 7) + 9) * 2 + 6\n4 * ((9 * 3 + 9) + 4) * 9\n(5 + 3 + 4) * ((5 + 4 + 3 * 6) * 7 * 2 * 6 * 8) + 3 * 9 + 7 + 5\n(3 + 4 * 8 + 8 + 3) * 4 * 7 * ((7 + 8 * 3 + 7 * 7 * 8) + 2 + 4 + (7 + 6 * 4) + 2 * 6)\n4 * (8 + 2 * 8) * 6 * 7 * 9 + 5\n5 + 3 + 6 + 8 * (2 + (4 * 5 * 2 + 9 * 9))\n(3 + 6 + 5) * 2 * 9 + 3\n(7 * 5 * 2 * 2 + 5) * 6\n7 * 8 * (3 * 5 + (4 * 7) + 6) + 6 + (5 * (7 * 3) * 3 * 5) * 6\n(8 + (6 + 2 * 2 * 6) + 3 + 9 + 5) * 3 + 6 * 7 + 4\n(5 * 8 + (8 + 6 * 7 * 7 * 3)) + (6 + 7 + (5 + 7 + 7 + 4 * 8) + 8 * 5 + 2) * (5 + (5 * 4 * 9 + 7 * 9 * 6))\n9 * (9 * 2) * 2 * 5\n2 + 3 * 8 * 6 + 7 * 2\n4 + 2 * 6 * 5 * 6 + (4 + 7 * 6 * (2 * 7 + 5 + 6 * 7 + 6))\n((4 * 6 + 5 + 5) * 5 * 4 + 8 * 8) * 3 + 5\n8 * 5 * 5 * (3 * 8 + 3 + 5 + 9 * (5 + 4 * 5 + 3 * 2))\n8 + 4 * 7 * 3 * 4\n(9 + 4 * (5 * 7) + 6 * 8 * (8 + 7 + 9)) + (2 * (4 + 8 * 3)) * 7\n((6 * 6 + 3 + 9 + 6) + 3) + ((9 + 2) + 6 + (2 + 7)) * 5 * ((3 + 2) + 9 * 2)\n(6 * 7) + 8\n(5 * 3 + 8 + (9 * 4 * 4 * 3 * 9 + 2) * 6) * 8 + 4\n8 * 7 + (6 * 8 + (8 + 2 + 8 * 3 * 9))\n8 * (3 + (8 * 6)) + (2 + 5 + 8 * 3 + 8 * 9)\n((9 * 3 + 9) + 8 + 7 * 9) + 5 * (4 + (6 * 7 * 8) * 4 + (5 + 6 + 6 * 2) * 3 * 5) + 8 + 5\n4 + (2 + 3 + 5 + (8 * 2 + 7) + 3) * 8 * 3 * 3 * 2\n5 + 2 * 6 + (5 + (2 * 5 * 7 + 6) * 5 * 4 + 4) + (2 + 5 * 9 * (2 * 5 * 2 + 5 * 2)) * 6\n9 + 5 + 5 + ((7 * 4) * 6) + 3\n(2 * 4 + 6 + (6 * 5 * 6 + 5 * 3 * 5) + 4 * 4) * (3 + 5 + 8 + 3 + (5 * 8 * 4 + 4 * 6 + 5) * 8) * 4 + (3 + 6 + 9 + (4 + 6 * 7 * 2 + 5) + (3 + 2 + 8 * 9 * 9))\n(2 + 9 * 7) + (2 * 4 * (7 + 3 * 2))\n(8 * 4 + 3 * 3) * 9 * 8\n(4 * 3) * 6 * 5 * 7 + (4 + 7 + 4 * 6 * 9 * 6)\n(7 + 4 + 9 + 7) * 3 * (2 * (7 * 5 * 7) * 5 + 9 * 4 + 3)\n2 * 4 * 9 * 7 + (3 * 6 * 5 * 7 + 4)\n5 + 5 * 2 * 3\n5 + 6 * (8 * 9 + (4 + 7 * 6 + 5 * 8 + 8) + 9 * (2 + 7 + 6 + 5)) + (4 * 4 + 7 * 3) + 6\n5 * 8 + 6 + (9 + 3 + (5 + 3 + 2 + 9))\n4 * (7 * 2 * 6 * 2 + 6 * (5 + 3)) * (2 + 5 * 5 * 3) + (7 * 7 + (7 + 6) * 5 * 6) * (4 + (3 + 4) + 4 * 5 * (5 + 4 * 9 * 7 * 9 * 6))\n(5 * 8 + 3 * 3 + (3 + 8)) * 9 + 3 + 4 + 4\n2 + 5 * 2 * 5 * 8 + 6\n4 * 7 * 5 + ((2 + 3 + 9 * 4) + 4 * (4 * 2 * 4 + 9 * 7)) * 6\n(4 * 5 * 3 * 5) * 3 + 8 * 4\n7 + 4 + (6 * (4 * 4 + 7)) + 5 + 9 * 3\n(3 * 8 * 7 * (2 + 6) + (8 * 9 + 8 + 3 * 2) + 6) * 2 + 3 * 8\n(6 + 9 * 4 * 4 * 9 + (4 + 7 + 7 * 7)) + (4 * 3 * (6 * 7 + 4 + 5 + 8) * 7) * ((5 * 7 * 5 * 9) + 4 + 4 + 8) + 3\n8 * 5 * (5 * 8) * 5 + 8 + 9\n3 + 7 + (5 + 4) + ((9 * 8 * 4 + 7 + 7) + 6) * (8 + 8 + (4 * 4 + 8 + 4 + 8) * 8 + 2 + (4 * 7 * 4))\n9 * 3 * 5 + (3 + 3 + (4 + 8 + 6 + 4 + 9 * 2) + 7 * 7)\n((9 * 7 + 8 * 6) + 3 + 2 + 8 + (6 * 6 + 7 * 4) * 6) * 4 + ((8 + 6 * 4 * 7 + 3 + 6) * 6 + 3 * 6 * (5 + 8 + 8 * 6 + 2 + 3)) + 9 + 9 + 6\n7 + 3 + 8 + (9 * 2 + (3 * 3 + 6 + 4)) + (6 + 7 * 3 * 2 * 9 + (4 + 5 + 6 + 9 + 2 + 4))\n(7 + 5 + 6) * 2 * 7 * (3 * 5)\n(6 * 5 * 9 * 4) * 9 * 2 + 3 * 7 * 5\n8 * (2 + (4 + 8 * 5 * 7) * 3)\n(6 + 2 + 8 * 3 * 8) + ((9 + 8 + 8 + 9 * 3) * (3 * 4) * 2 * 4 + 6 + 5) * 5 * 6 * 4 + 7\n(2 * 6) + (7 + 8 + 3)\n5 + 4 * 7 * 3 * (3 + 3 + (2 + 3 * 8 + 4) + 9 + 3 * 3) + 3\n9 * ((8 * 5 * 8 + 7 + 2) * (6 + 2 * 9) + 2) * 7\n(6 * 8 * 8 * (4 + 5 + 3 + 4)) * 9 + (2 + 4 + 2 + 8)\n(8 + (2 + 3 * 7) * 5 * 6 * 3) * 5 * 7 + (7 + (7 * 8 * 4 * 5) * 5 * 3 * 4 * 8) + ((2 + 6 * 9 * 2 + 8) + 7 * (5 * 8 * 5 + 6 + 9)) * 2\n4 * 6 + 3 + (5 + 5) + 2\n5 + (7 + 2) + 7 * 7 + (2 + 5) * 3\n(9 + 4 * 7 + (7 * 2 + 8 * 8 * 8)) + 2 * (7 * 9 + 7 + 6) + 5 + 5\n9 * 9 + (8 + (8 + 7 + 8 + 2 + 8 + 5) + 6 * 2 * 5 * 6) + 3\n6 + (9 + 5 * 3 + 6 + 8) + 3\n2 * 4 * 2 + 9 + 3 * ((8 * 6 * 9 + 7 * 6) * 3 * 2 + 9 + 9)\n6 * 3 + (4 + 8 + (3 + 5 + 5) * 6 * 2 * 3) + 6 * 5 + 9\n(7 * 8 + 9) * 7 * (6 + 5) * (4 + 8 * 5 * 6 * 9) * 4\n5 * (7 * 3 + 3 * 4 * (2 * 3 * 9))\n6 + 6 * 3 + 7 * (4 + 4 * 5) * (6 + 2)\n7 + 8 * 9 * 3 * 8 * 2\n3 * 2\n8 * ((3 * 4 * 3) * 9 + 9 + 9) * 2 * 4 + 6 * 4\n3 + (4 + 5 + 5) + 4 + 6\n(4 * 7 * 5 + 8 * 7) * 4 * (6 * 6 + 4) * 4 + (2 + 7 + 2 + 8 * 6)\n(2 + 2 + 8 + 9 * 9) + (9 * 4 * 2 * 9) * 9\n(8 * (2 * 7 + 9) * 4) * 4 * 5 + 2 * 8\n((7 + 8 + 6) + (9 + 8 * 7) + 6 * (5 * 8)) * 4\n4 + (3 + (5 + 2 * 3 * 3 * 3) * 2) * (7 + 2)\n5 + (5 + 3 * 4 * 6 + 6)\n(4 + 4) + 7 + 8 + 6 * 5\n5 * (6 + (6 + 6 * 2 + 9) + 8 * (2 * 6)) * 6 * 9\n(4 + 7 * 6 * 9) + 6 * (9 * 7) * 4 * ((6 + 7) + 5 + 9 * 5 * 5 + 2)\n(4 + (6 + 8 + 4 * 9) * 8 + (5 + 3 + 7)) + 2 * 3 * 9 * 3\n9 * 9 + 9 + (4 * 9 * 3 + 4) * 9 * 6\n2 * (6 + (8 + 7 + 6) * 9 * 6 * (2 * 8 * 3)) * ((9 * 7 + 6 * 3) * 8 * 5 + 8 + (7 + 7 + 7 * 5) * 5) + 2\n6 + (7 + 8 * (5 + 4 * 3 * 2 + 2)) + (4 + 8 + 5 + 7 + 7 * (7 * 6 + 2 * 8 * 6 + 4)) * (6 * 9) * 9 * 9\n7 * (5 * 7 * 5 * (7 + 7 + 9 + 5 * 2) * 3 * 3) * (4 * 9)\n7 + 2 * 9\n(9 + (6 + 3)) * 3 + 9 + 3 * 9 * (8 * (4 + 3 * 9))\n7 + 2 * 4 * 5 * (6 * 5 + 3 * 3 * (5 * 8 + 7 * 5) * 7)\n6 * (6 * 6 + 5 * 2) + 8 * ((4 + 2 * 7 + 9 + 9) * 4 + 5 * 5 * 2) * 3\n3 * ((7 * 2) * 2 + 5 + 3 * 2 + 5)\n9 * (4 + 3 * 6 * 4 * 6 + 3) + 7\n2 * 8 + (2 + 9) * 8 + (9 + (5 * 8) + 2) * 6\n(4 + (2 * 7 * 8 * 5 * 9) + 6 + (8 + 2 * 9 + 6) * 5 + 8) + 7 + 7 + 7\n8 + (3 + 7 + 5 * 8) + 2 * (4 * 3)\n9 + (2 * 5 * 2) * (2 + 4 + (4 + 4 * 7 * 9) * 6 + (8 + 9 * 3)) + ((2 * 7 * 8 + 5 * 5 + 5) * 6 * 9 + 5 * 9) + 2\n7 + (4 + (2 * 4 + 6 + 3 + 8 + 5) + 2 * 5 + 3)\n(7 + 4 + 9 * 7 + 2 + (5 * 8 * 8 + 2)) + 2 + 7\n8 * (8 + 4)\n5 * (3 + 8 * 4)\n8 + (5 * 4 + 3 + 5)\n3 * 5 * 9 * 5 + 8 + 8\n2 * 4 * ((3 * 3 * 7 * 2 + 7) + 9) * 4 + 3\n9 + 8 + (4 + (6 * 4 * 3 * 8) * (8 + 6 * 3) + 7)\n3 * (3 + 6 * 7 + 8 + 4 + (5 * 4 + 3 + 4 * 6)) * 4 + 3 + (5 * 3 + (8 * 8 + 6 * 3 + 6 * 9) + 2 + 9)\n(5 + 5 * 7) + 3 * 2 + (8 * 4 + 3 + 4)\n(7 * 8 * (2 + 6 + 8) + 6) * 5\n7 * 8 + ((6 * 9) * 5 * 5 * 9 + 9) + (7 + 8 + 2)\n8 * 4 * 4 * (7 + (5 * 4 * 4) + 3 * (4 + 8 * 7) * 2 * 9) * (4 + 5) * 6\n(2 * 3 + (3 * 4 + 7 + 5 + 2 + 2) + 7) + 7\n(6 * (8 + 6 * 3 + 7 * 4 + 7) + 2 + (5 + 2 + 2 + 5 + 4 * 7) * 6 + (2 + 4 * 7)) * 3 + 7\n3 * (2 * 8 * 7 + 6) * 8 + 7 * ((7 + 2 + 3 + 2) * 8 + (3 * 2 + 7 * 7 + 8 + 3) * 8 + 3 + 9) * 2\n(9 * 2 + 4) + 4 * (7 * 2 * 5 * 3 * 6)\n(3 + 9 + 2 * 5) * (6 * 6) * 9 * (4 + 7) * 9 * 7\n(5 + 8 * 6 * 5) + 6 + (3 + 9 * 8 * 2) * 7\n6 + ((9 + 7 + 2 * 7 + 2 + 7) * (5 + 5 * 8 + 9 + 3 + 4) + (9 * 7 + 7 * 7 + 9) + 4 * 6 + 6) + 6 + 2 * 3\n(4 + (4 + 4 + 7 + 5 + 8)) + (7 + (2 * 8 + 4 + 6)) + 8 + 8 + 2\n7 * (4 * 8 * 5 * (4 * 3 * 4 + 2 + 7) + 6 * 6)\n9 * 4 + 4 + ((9 + 3) * 5 + 5) + 6\n(4 * 9 + 3 + (9 * 6 + 4 * 6 + 3) * 8) + 3 + 9 * 4 + 8 * 6\n(3 + 3) + 8 * 4 * 6\n8 + 7 * (4 + 4 * (6 + 3 + 3 + 4 + 7 + 4) * (2 + 8 + 9 * 4 * 7) * 4 * (7 + 2 * 6 + 8 * 2 + 5))\n6 * (2 + (4 * 9 * 8) + 8 + (8 + 6 + 3 * 8 * 5 * 7) + 9) + 8 * 9\n(8 + 5) + (4 * 5 * 2 * 2 + 4 + 6) + (8 + 7 * 2)\n9 * (7 + 3) * 7 * (6 * 9 + 4) * 4\n2 * 4 + (9 + 8 + 3 + 5 + 9 + (4 + 7 * 6 * 7 + 9)) * 9 * 3\n9 * (7 * 3) + 4 * 7 + 2\n7 + 9\n2 * (7 + 7 + 4 + 9 * 5) * 8 + 3\n3 + 9 * 7 * (7 * 8 * 5 * 3)\n((4 + 6 + 6 * 9 * 9) + 2 + 8 + (5 + 8 + 2)) + 5 * 5 + 7\n(9 + 9) * (6 + (5 + 7 + 3 * 4) * 7) + (4 * 7 + 2 + 9 + 9) * 9 + (8 * 4 * 2)\n5 * (7 * 5) * 3 + 3 * 5 + 7\n9 * ((9 * 4 + 2 + 6 * 2 * 5) * (8 + 7) * 7 * 7 * 8 + 9) + 7 * 9 + (8 * 8 + 4 * 4 * 4)\n9 * 9 + (4 + 9) + 7 + (5 * (7 + 7 + 9 + 4 * 4) * (5 + 9 * 7 + 5 * 9 * 2) + 7 + 2)\n7 + 8 + 4 + ((3 + 4) * 2 + 3 * 5 + 9 + 6) * 6 * (9 * 6 + 9 * 8 * 5 * 8)\n4 + (4 + 7 * (5 * 6 * 3 * 9 + 8) * 4) + 6 + 6 * ((8 + 7 * 7 + 5 + 2) + 3 + (8 + 3 + 3 + 2 * 9 + 7) * (8 + 5 + 7 * 9 + 2) + 6 + 5)\n8 * 8 * 9 + (3 * 4 * 4 * 7 * (8 * 2 * 3 + 3)) * 2\n((4 * 5 * 4) + 3) + 6 * 6 * 4 * 5\n3 * 3 + 5 + (7 + 3) * 9 * 6\n((7 * 3 * 7 + 3 * 7) + 4) + 2 + 4 + 7 + 8\n6 + (8 * 9 * 6 * 3 * (5 * 9 + 7 * 5)) * (6 * 6 + 7 * 7) + 2 + 4 * 3\n(2 * (8 * 2 * 3 * 3) * 3) * (2 + 5 * 9) + ((9 * 6 + 6 + 8 + 3 + 6) + 3 * 5 + (3 * 8 + 8 * 2 + 9) + 3 + 6)\n4 + 5\n(7 * (6 * 9 + 5 * 6 + 3) * 3 * (3 * 7 * 2 * 3 + 7 * 9)) * 9\n(8 + 2 + 9 * 6 * (9 + 5 + 4 + 2) * 5) * 9\n(6 + 6) + (7 + 9 + 8) + (7 + 3 * (6 + 2 + 8 * 5 * 7) + 7 * 3 + 7) * 3 + 3 * 6\n6 * 8 + ((6 + 4 * 3) + (3 * 2 + 4) + 9 * 7) * 4\n(7 * (2 * 4 * 5 + 9)) + 9 + (8 * 2 + (2 * 4 + 9 * 2 * 5) + 3 + 6 + 8) * 9 * 8\n8 * 7 * 8 * (4 + 4)\n(4 + 8 + (8 + 7 * 3 + 4 * 2 * 7) * 5 * (9 * 9 * 7 + 3 + 9 + 5)) * 9 + 4 * 3 * (8 + 7 + (9 * 2)) * 3\n6 * 5 * 8 + (2 + 3 * 7 * 4 * 2)\n2 * (7 * 7) * (6 + 7 + 2 * 3 * 7) * 2 * 5 * 7\n7 * 2 * (3 * (2 * 5 * 7 + 3 * 8)) + (9 * (6 * 6 * 7 * 3) + (4 + 3 + 2 + 9 * 8) + 5 * (7 * 2 * 3 * 8 + 5 * 7)) * 8\n((2 * 7 + 5) + 3 * 2 * 7) + 4 * 8\n4 * (4 + 6) + (4 * 2 * 8 + (3 * 8 + 4 * 8))\n3 + 3 * 8 * 6 + (4 + (5 + 5 + 6 + 5 * 5) * 3 * 8 * 4) * 5\n9 + 9 * (5 + 7 + 7) * 5\n(5 * (7 + 6 * 9 + 6 * 9 + 5) + 3 + (4 * 8 + 5 * 8 * 3) * (9 * 9 + 2 * 2 + 2 * 8)) + 7\n((6 * 8 + 5) * (6 + 6 * 4 * 7 + 5 * 5) * 7) * 5 * 8 + 2 * 6 * 8\n(3 + 7 + 2 + 2 * 2 + 6) + 4 * 2 * 3\n5 * 2 * (7 * 2 + 2 + 8 * 2) + 4 * 4\n2 * 6 * 9 + (9 + 2 + 6)\n7 * (4 + 7 + 4 * 4) + 8\n6 * 8 + 9 * 7 + (2 * (6 + 8 * 5 * 9 * 3 * 6) + 7)\n4 * 9 * (4 + 9 + 8 + 7) + 7 + 4 + 7\n((8 * 8) * 6 + 6 * (7 + 8) + 3 + 9) + (2 * 9 + 2 * 3 * 7) + (7 + 2 + 5) * 5\n9 + 9 + 5 * (8 * 7 * 4 + 8 + 8 * 4) + 4\n(2 + (4 + 3 + 7) * 8 + 2) * (7 * 8 * 4 + 5)\n7 * (7 * 5 * 8 * (5 + 8 + 6 + 9) * 6 * 6) * 3\n(6 + 7 * (6 + 9) + 3 * (2 + 9 + 5) * 5) * 3 * (3 * (4 * 6 + 4 * 5 * 5))\n8 + 7 + 4 + (5 + 7 + 9 + 8) + 4 * (4 + 2 + 7)\n4 + 2 * 6 + (9 * (3 + 5) * (2 + 7 * 6 + 8 + 8) + 6 * 8 * 7) + 7\n(2 * (9 * 2 + 8 * 3 + 2) + (7 * 3 * 5 * 6)) * 2 + 9 + 7 + (4 + 7 * 8 + 9 * 3) + 8\n6 * (9 * 8 + (5 + 2 * 5 + 2 * 6 + 6) * 8 + 2)\n8 * 2 + (7 * 7 * (9 * 6 + 3)) + 7 + 5 * 4\n9 + 3 + 7 + 9 + (5 + (7 * 4 * 6 + 3 + 7 + 3) * 8 + (9 + 4 * 8 * 7 * 7) + 2)\n((4 * 4 * 8) + 6 * 4 * 7 + 4 * 7) + 7 * 8 + 3 + 8 + 9\n6 * (5 + 2 * (4 + 3 * 5 + 6 * 2 + 6) * 5 * 4 + 4) + 4 + (9 * (7 * 5 * 2 * 4 + 5) + 8) * (5 * (2 + 2) + 7 + (6 * 4 + 3 * 7 * 9))\n2 * (7 + 9) * (2 * 2 + 4 * 7 * 6) * 5 + 5 * ((5 * 8 + 3 + 9 * 3) + 6 * 4 + 9)\n(4 * 3 + 5 * 7 + 3 + 3) + (3 * 8 * 3 * 4 * 4) * 8 + 5 * 8\n6 * 4 * (4 * (3 + 6) + 2)\n9 * (7 + 8 + 5 + (9 * 9 * 8 * 6 * 5) * 9)\n(6 * 7) * 5 + 5 + 7 + 3 + ((4 + 7 * 5 + 6 + 7) * 3 + 4 * 4 + 3 + (6 + 2 * 3 * 2 + 4 + 8))\n3 + 4 * 2 + 2 * 7\n(7 * 4 + 9) * 9 + 6\n2 * (4 + 7 + 6 + 2 + 5 + 2) * 3 * (5 + (9 * 8) + 4 + 5)\n2 * (6 + 5 + 8 * 5 * (7 * 3 * 7 * 7)) * 8 + 2 + (3 + 7)\n((3 * 8 + 7 * 8) + 5 * 2 + (7 + 4 + 8 * 3 * 6)) + (5 * 2 * 3 + 2 * 2) + 2 + 5 + 3\n3 * 5 * 9 + 4 * ((5 + 5 * 4 * 3) * 5 + 8 + 5)\n9 + 7 + (8 + 2 + 4 * 8 + 8 * 3) * 5\n(4 + 6 * 4 + 7 + 9 + 9) + 5 + 5 * 5 + (4 * 8 + 2) * 2\n(9 + 2 * 8 * 8) + 6 + (6 + 5 + 3) + (8 + 8 + 4) * 7\n2 * (9 * 9 + 9 + 7) * ((5 + 9 * 9 * 8 * 4 + 5) + 8 * (3 * 6) + (9 * 9 * 2)) + 6 + ((7 + 9 + 3 * 3) + 4 + (3 * 6 + 2 * 8))\n((6 * 5 + 7 + 8 * 9 + 4) + 4) * 6 + 4 * (5 + (7 * 9 + 7 + 9) + 7)\n(9 * 3) * (3 + 2) + ((7 * 5 + 8 * 7 + 5) * 2) + 4 + 8\n(8 * (4 * 2 * 8 + 6 + 6) * 9 * (8 + 9 + 9 + 7 * 7 * 2) + 2 * 5) + (4 + 3 + 9) + 4 * 2 * 7 + 5\n5 * 6 + 9 + 6 + (9 * 7)\n(7 * 9 + 9 + 8 * 4) + 5 * (2 + (4 * 5 * 5 + 8) + 3 * 6 * 5) * 7\n2 + (9 * 2 * 4 + (8 + 6 * 6 + 6 * 4)) * 7\n4 * 5 + (2 * 4 + 6 + (8 * 2) * 9 * 2) + 9\n6 * 2 * (7 + 5 + 4 * 3 * 2) * 8\n(6 + (5 * 2 * 9 * 6 + 4) + 8) + 7 * 2 * 9 * 8\n(8 * 8) * ((9 * 4 * 2 * 4) * (2 + 7) + 6 * 7 * 5) + (9 + 6) * 3 * 6 * ((5 * 5 * 3 + 6 * 5 + 4) + 5 + 5)\n5 + 3 * 8 + 7 * 2 + (3 + 3 + 4)\n2 * 2 * 3 + 4\n(6 + 5 * 3 + (7 * 2 * 8) * 4 * 4) + 2\n4 + (2 + (9 * 8) * 2) + (6 + (6 * 3 * 2 * 5 + 4 + 2) + 2 + 8 * 2)\n((3 + 9 + 9) + 3) * (3 * 4 + (3 * 8 * 3) + 3 * 4 + 5) + 3 * 5 * 9 * 5\n(9 * 7 * 4 * 5) * (9 + 6) + (5 * 4 + 7 * 6 + 9 * 4) * 5\n8 + ((2 + 5 * 2 + 4 * 4 + 5) * (2 + 4 * 6 * 8) + 3 * 7 + 8) + 3 + 6\n(4 * 6 + (2 + 9 + 5 + 4 * 7 * 2)) + 4 + 9\n3 + 6 + 9 * (7 * 6 + 5) * (6 * 7 * 3)\n(2 * 6 + (2 * 8 + 2 * 8)) + 4\n6 * 4 + 3 * 7 * 9 * (9 * 2 + 6 + 2)\n(8 + (8 * 6 + 5 * 3 + 9)) * 4 * 9 + 4 + 5\n(8 * 9 * 8) + 7 * 4 * 3 + 5 * (3 + 8 * 2 * 9 * 7 * 8)\n5 + 6 + 8 + (4 + 4 + 4 * 5 + (9 * 2 + 6) + 5)\n2 * (8 * 5 + 7 + 7 + (3 + 2) * 4) * (9 * (2 + 8 * 7))\n(2 * (4 + 7 + 9) * (2 * 3 + 5 * 9 * 5 + 4) * 6) + 2\n2 * (5 * 2 + (9 + 8 + 9 + 9 + 6) * 5) * 9 * 8 + 3 * (2 * (3 * 9) * 7 * 4 * (5 * 7) * 6)\n(5 + 3 * 4 + 9) + 2\n((3 * 9) * (8 + 3 * 3 + 2 + 2) * 3) * 9 * 7 + 4 + (3 + 9 * 3 + (2 + 6 * 7 + 8 + 9) * (6 * 6 + 2 + 3 + 2)) * 8\n8 * (3 + 9 + 5) * (5 * (3 * 4 * 7 * 3) * 2 * 8) * 7 + (6 + 6 + 5)\n9 + (8 + 2 * 3 + 7 * 3) * 5 * 5 + 7 * 4\n6 * 9 + (9 * 5 + 7 * (4 * 5) * 2) + 9 * 4 * 5\n8 + 3 + (4 * 6 + (9 * 2 + 4 + 4 + 4 + 8) + 3)\n(3 * 6) + 2 * 9\n8 * 6 * (2 * 7 * 5 + (8 + 6 + 6) * 4 * (4 * 8)) * 7 + ((4 * 3 + 5 + 2) * 6 + (2 + 6 * 6 * 8 + 8) * 9) + 7\n(9 * (7 * 9) * (9 * 8 + 5) + 8 + (2 + 8 * 6 * 9) * (3 * 5 * 7 * 6 + 2 + 4)) + (8 * 9 + 7 + (3 * 5 * 2 * 4 + 9 * 8)) + 6 * 5\n(7 * 8 * 2 * 4) + 7 + 8 * 8 * 6 * (6 + 2 * (5 * 2) * 4)\n8 * (5 * 4 + 4) * 3 + 4 * 4\n7 + 8 + 5 + ((3 * 2 + 3 + 4 * 8) * 7 * 5)\n((9 * 7 * 6) + 7) + 7 + 3 + (4 * (2 * 8 * 7 + 2 + 9) + (4 + 2 * 3) + 2 + 4)\n(6 + 3 * 6) * 9 * 7 * (4 * 8 * 2 * (5 * 8 * 9 + 4 + 2)) + 3\n3 * 7 * 7 + 9 * 9 + (7 + 6 + (3 + 6))\n5 + 8 + ((8 * 8 * 4 + 5 * 3 * 5) * 4 + 4 + (5 * 5 * 2)) * 4 * 5\n2 * (5 * 4 + (3 * 9 + 9 * 9) * 9) + 6 + (3 * 3) + 9 * 7\n6 * 5 + (6 * (8 * 5) * (9 + 7 * 6 * 5) * 9 + 3 * (6 + 9)) + 8\n4 + 9 + (5 * 9 + (7 * 6 * 3 * 8) + (8 + 2 + 7 * 5 + 3) + (4 + 7 * 7 + 7) + 9) + 7 + (7 + 2 + 8 + 4)\n((6 + 4 * 4 + 5 + 7 + 7) * (8 * 2) * (6 + 3) + (9 + 3 * 4 * 7 + 4 + 9)) + 5\n(6 * 2 * 3) + 8 + 9 + (3 * 3 * 2 + 8) * (3 * 9 * 7 + 5 * 5)\n7 * 5 * (9 + 5 + 3 * 7 + 8 * 4) * 3 + 2 + 4\n(8 + 9) + ((5 * 5 + 5 * 3) + 2 + 8 + 9) * 4 * 2 * 4 * (5 + 4 + 2 * 8 + 7 * 3)\n9 * 3 * 6 + (2 * (3 + 8 * 7 * 4 + 6) + 5 + (4 * 7) + 2 * (3 * 9 * 8)) * 7\n((6 + 3 + 8 * 6 * 8) * (8 * 6 + 4 + 9 + 4) * (4 + 9 + 2 * 2 + 3) + 7 + (3 + 9 + 3 + 7 + 9 * 6) * 4) + 8\n5 * (3 * 4 * 4 + (5 + 7 * 3)) * 3 * 5 * 7\n((5 * 5 * 7 + 7 + 4 * 9) + 3) + 4 + 5\n(7 * 4 + 6) * 2\n6 * 2 * 5 * (8 + 6 + 3 * 8 * 5) * (4 * 3 * 5 + 4 + 5 + 9) * ((4 * 6 + 3 + 9) + 5 + 4 + 2 + 6 + 2)\n4 + (5 + 4 + 7 + (8 * 8 + 7 + 6) * 3 * 4) * (2 + 3 + 4 + 9) + 3 + 8\n5 * 5 + (7 * 9) + 5\n(2 + 3 + 3 + 5 * 6 * 2) * 7 + 8 * (2 + 5 * 8 + 2 + 3 + 5)\n2 + 5 * (5 * 7 * 5 * 3) + 2 * (7 + 4 * (5 * 9 * 5) + 6)\n5 * 7 + 7 * 4\n2 + 8 + 3 + (3 * 8 * 9) + 5\n3 + ((2 * 8 + 3) + 3) * 9 * 6 * 6\n((7 + 6 * 3 + 6 + 7) * 4 * (9 + 6) + 6 + (5 + 8 + 4 * 7 + 9) * 7) + 9\n6 + ((2 * 7 * 6 + 2) * 9) * (8 * 5 * 2 + (2 + 6)) * 4 * 6\n(5 * 6 * 4 * 2 * 7) * 2 + 2 + (5 * 8 * (9 + 8 + 7 * 3 + 2 + 6) + 5) + (2 + (9 * 4 + 3) * 9 * 2 * 4 + 8) * 6\n((7 * 8 + 2) * 8 * 6 * 5) + 4 + ((8 + 3 * 9 + 7) + 8 * 5) + (2 + 5 + 8) * 4\n3 * (4 + (7 + 2 * 4) * 8 * 6)\n9 * ((6 + 8 + 2 * 3) * 2 + 7 + 4 + 9 + 5) + 6 + 9\n6 + 7 + (7 * 7) + (8 * 9 + (9 + 9) + (6 * 5 * 9 + 9 * 4)) * 3\n(5 + (3 * 5) + 5) + (3 + 5 * (4 + 7 + 7 * 8) * 8 * 2) * 7\n5 * 7 + ((9 + 3 * 8) + 3 * 3)\n2 * (8 + 8) * (4 * 9 * 9 * (6 + 8 + 3)) * 7 * 7 + 8\n9 + ((6 * 4 * 9 + 3 + 7) * 5 * 9 + 9 * (2 * 8 + 3 + 7 * 9 + 4)) + 8 + 6 * 8 * 9\n(8 + 3 + 9 + 7 * 6) * 6 * 2 + 7\n7 * (5 * 4 * 8 + (9 * 7) * 7) * 8 + 3\n(5 + 5 + (3 * 9) * 3 * (6 + 2 * 5 * 4 * 5) * (8 * 7 * 9 + 9)) + 9 + ((6 * 2 + 9 + 5 + 6) + 4) * 3 * 8\n4 + 4 + 7 + 2 + (4 * 5 + 2)\n5 + 8 * (5 * (6 * 5 * 7))\n((8 * 5 + 8 + 4 * 9 + 4) * 5 * 2 * 5) + 6 + 5\n4 + ((2 + 6 * 3 + 5) + 9 * 3 * 6 + 4 * 7) * (7 * 6 * 4)\n5 * (4 + 2 * 8 * 3 + 8 * 8)\n5 + 2 + (2 * (2 + 4) * (3 * 3 * 7 * 6 + 5 * 7) * 8 + 4) * (8 * 9 * (5 + 3 + 8 + 4 * 9 * 7))\n8 + ((5 + 4 + 9 + 3 + 8) + 9 * (3 * 2) + (6 + 5)) + ((8 + 7 * 2 * 4) * 5 + 4 + 5 + 2 * (2 * 3))\n(8 + (7 + 6 + 9 + 2 * 6 + 4) * 2 + 5) * (3 + 6 * 9 + 6 + (8 + 9 + 4 * 4 + 2 * 7) * 6) + 4\n8 + ((5 * 4) + 7) * 2 * 3 * 7\n(3 + 4 + 2 + 8 + 2 + 4) + (2 + 6 + (7 * 8 * 4) + 3) + 3 + 2 * 9 + 5\n6 * 8 * (8 * 9 + 5 + 8)\n((8 + 2 + 5 * 8 * 9 + 4) * 8 + 9 * (9 + 2 * 6)) + 3 * 3 + 9 * (5 * 4)\n((2 * 9) + 7 + 7 * (7 + 8 * 4 + 2)) * 6 + 6 + (4 * 2 * 7)\n7 + ((2 + 8 + 7 + 4) * (4 + 2 + 9 + 2 * 9) + 2 + (6 * 8 + 5 * 2 * 3) + 5) + 7 * (6 + 8) * 5 + 2\n8 * 5 + 3 + 7 * 7\n(6 * 3 + 2 * 5 + 6) + 5 * (4 + 9 * 2 * 8 * (7 * 7)) * 7 + 9\n2 * 7 * ((5 + 7 * 5) * 6 + 3 * (2 * 3 + 8) + 5 * (9 + 7 + 5 * 3 * 6)) + (7 * (8 * 5 + 7 * 4) * 9)\n((6 * 9 + 8 * 8 + 2 * 8) + 8 + 5 + 4 * 7 * 4) + 7\n5 * 6 * (3 * 3 * 6) * 6 * 7 * 9\n2 + 3 + ((6 + 5) * 7 + (2 * 4) + 7) + 6\n(7 + 8 + (2 + 4 * 9 * 8 * 5)) + (3 + 8 * 7)\n9 + ((3 + 4 * 8 + 3 * 4) + 2 + 9 + (8 * 7 + 3 * 4 * 7 * 8) + 3) * 2 + 4 * 6\n4 + ((2 + 9 + 4) * 3 + (7 + 3 + 2) * 5 * 3 + 2)\n2 * 4 + 8 + 2 + 5 * (4 + 6)\n(9 + 8 + 9 + 7) * 8 + 4 * 8 * (9 + 9 * 6) * 8\n3 + 5 + (6 * 8 * 2 + (6 * 9) * 6 * 8)\n3 + 4 * 2\n6 * (3 * 2 + 3 + (6 + 3 + 7 * 4 + 2 * 7)) + 6 * 9 + 9 * 7\n8 + 6 + 4 + 4 + (6 * 3 + 9) + 7\n(4 + (3 * 5 * 7 * 7 + 4) * 5) * 2 * 6\n8 + 4 + (5 * 5) + (6 + 8 * (7 + 3 + 7 * 7) + (6 + 4 + 9 * 8) * (2 + 6 + 7 + 4 * 3 * 7)) * (8 * 7 + 9)\n((4 * 6 * 3 + 5 * 6 + 9) + 4 * 7 + 2 + 5) + (3 * 6 + 4) + (7 + 8 + 8)", Scope = Private
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
