#tag Class
Protected Class Advent_2021_12_24
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( kInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( kInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  'return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  'return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function Brute(round As Integer, z As Integer, runningValue As Integer, stepper As Integer) As Boolean
		  if round > 13 then
		    return false
		  end if
		  
		  if StateDicts( round ).HasKey( z ) then
		    return false
		  end if
		  
		  #if not DebugBuild then
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  var storedZ as integer = z
		  
		  var startIndex as integer
		  var endIndex as integer
		  
		  if stepper < 0 then
		    stepper = -1
		    startIndex = 9
		    endIndex = 1
		  else
		    stepper = 1
		    startIndex = 1
		    endIndex = 9
		  end if
		  
		  for w as integer = startIndex to endIndex step stepper
		    z = storedZ
		    
		    var x, y as integer
		    
		    select case round
		    case 0
		      x = z
		      x = x mod 26
		      x = x + 15
		      x = if( x <> w, 1, 0 )
		      y = 25
		      y = y * x
		      y = y + 1
		      z = z * y
		      y = w
		      y = y + 15
		      y = y * x
		      z = z + y
		      'z = w + 15
		      
		    case 1
		      'x = z
		      'x = x mod 26
		      'x = x + 12
		      'x = if( x <> w, 1, 0 )
		      'y = 25
		      'y = y * x
		      'y = y + 1
		      'z = z * y
		      z = z * 26
		      'y = w
		      'y = y + 5
		      'y = y * x
		      'z = z + y
		      z = z + w + 5
		      
		    case 2
		      'x = z
		      'x = x mod 26
		      'x = x + 13
		      'x = if( x <> w, 1, 0 )
		      'y = 25
		      'y = y * x
		      'y = y + 1
		      'z = z * y
		      z = z * 26
		      'y = w
		      'y = y + 6
		      'y = y * x
		      'z = z + y
		      z = z + w + 6
		      
		    case 3
		      x = z
		      x = x mod 26
		      z = z \ 26
		      x = x + -14
		      x = if( x <> w, 1, 0 )
		      y = 25
		      y = y * x
		      y = y + 1
		      z = z * y
		      y = w
		      y = y + 7
		      y = y * x
		      z = z + y
		      
		    case 4
		      'x = z
		      'x = x mod 26
		      'x = x + 15
		      'x = if( x <> w, 1, 0 )
		      'y = 25
		      'y = y * x
		      'y = y + 1
		      'z = z * y
		      z = z * 26
		      'y = w
		      'y = y + 9
		      'y = y * x
		      'z = z + y
		      z = z + w + 9
		      
		    case 5
		      x = z
		      x = x mod 26
		      z = z \ 26
		      x = x + -7
		      x = if( x <> w, 1, 0 )
		      y = 25
		      y = y * x
		      y = y + 1
		      z = z * y
		      'y = w
		      'y = y + 6
		      y = w + 6
		      y = y * x
		      z = z + y
		      
		    case 6
		      'x = z
		      'x = x mod 26
		      'x = x + 14
		      'x = if( x <> w, 1, 0 )
		      'y = 25
		      'y = y * x
		      'y = y + 1
		      'z = z * y
		      z = z * 26
		      'y = w
		      'y = y + 14
		      'y = y * x
		      'z = z + y
		      z = z + w + 14
		      
		    case 7
		      'x = z
		      'x = x mod 26
		      'x = x + 15
		      'x = if( x <> w, 1, 0 )
		      'y = 25
		      'y = y * x
		      'y = y + 1
		      'z = z * y
		      z = z * 26
		      'y = w
		      'y = y + 3
		      'y = y * x
		      'z = z + y
		      z = z + w + 3
		      
		    case 8
		      'x = z
		      'x = x mod 26
		      'x = x + 15
		      'x = if( x <> w, 1, 0 )
		      'y = 25
		      'y = y * x
		      'y = y + 1
		      'z = z * y
		      z = z * 26
		      'y = w
		      'y = y + 1
		      'y = y * x
		      'z = z + y
		      z = z + w + 1
		      
		    case 9
		      x = z
		      x = x mod 26
		      z = z \ 26
		      x = x + -7
		      x = if( x <> w, 1, 0 )
		      y = 25
		      y = y * x
		      y = y + 1
		      z = z * y
		      'y = w
		      'y = y + 3
		      y = w + 3
		      y = y * x
		      z = z + y
		      
		    case 10
		      x = z
		      x = x mod 26
		      z = z \ 26
		      x = x + -8
		      x = if( x <> w, 1, 0 )
		      y = 25
		      y = y * x
		      y = y + 1
		      z = z * y
		      'y = w
		      'y = y + 4
		      y = w + 4
		      y = y * x
		      z = z + y
		      
		    case 11
		      x = z
		      x = x mod 26
		      z = z \ 26
		      x = x + -7
		      x = if( x <> w, 1, 0 )
		      y = 25
		      y = y * x
		      y = y + 1
		      z = z * y
		      'y = w
		      'y = y + 6
		      y = w + 6
		      y = y * x
		      z = z + y
		      
		    case 12
		      x = z
		      x = x mod 26
		      z = z \ 26
		      x = x + -5
		      x = if( x <> w, 1, 0 )
		      y = 25
		      y = y * x
		      y = y + 1
		      z = z * y
		      'y = w
		      'y = y + 7
		      y = w + 7
		      y = y * x
		      z = z + y
		      
		    case 13
		      x = z
		      x = x mod 26
		      z = z \ 26
		      x = x + -10
		      x = if( x <> w, 1, 0 )
		      y = 25
		      y = y * x
		      y = y + 1
		      z = z * y
		      'y = w
		      'y = y + 1
		      y = w + 1
		      y = y * x
		      z = z + y
		      
		    end select
		    
		    
		    if round <> 13 and Brute( round + 1, z, runningValue * 10 + w, stepper ) then
		      ScriptResult = w.ToString + ScriptResult
		      return true
		      
		    elseif round = 13 and z = 0 then
		      ScriptResult = w.ToString
		      return true
		      
		    end if
		    
		  next w
		  
		  StateDicts( round ).Value( storedZ ) = nil
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  StateDicts.ResizeTo 13
		  
		  for i as integer = 0 to StateDicts.LastIndex
		    StateDicts( i ) = new Dictionary
		  next
		  
		  ScriptResult = ""
		  if Brute( 0, 0, 0, -1 ) then
		    return ScriptResult.ToInteger
		  else
		    return -1
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  StateDicts.ResizeTo 13
		  
		  for i as integer = 0 to StateDicts.LastIndex
		    StateDicts( i ) = new Dictionary
		  next
		  
		  ScriptResult = ""
		  if Brute( 0, 0, 0, 1 ) then
		    return ScriptResult.ToInteger
		  else
		    return -1
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Compile(input As String) As XojoScript
		  ScriptResult = ""
		  
		  input = input.Trim.ReplaceLineEndings( EndOfLine )
		  
		  if input = "" then
		    return nil
		  end if
		  
		  
		  var replacementDict as new Dictionary
		  replacementDict.Value( "add" ) = "+"
		  replacementDict.Value( "mul" ) = "*"
		  replacementDict.Value( "div" ) = "\"
		  replacementDict.Value( "mod" ) = "mod"
		  
		  var nextDigitIndex as integer = -1
		  var rows() as string = input.Split( EndOfLine )
		  for i as integer = 0 to rows.LastIndex
		    var parts() as string = rows( i ).Split( " " )
		    
		    var instruction as string = parts( 0 )
		    select case instruction
		    case "eql"
		      rows( i ) = parts( 1 ) + " = if( " + parts( 1 ) + " = " + parts( 2 ) + ", 1, 0 )"
		    case "inp"
		      nextDigitIndex = nextDigitIndex + 1
		      rows( i ) = EndOfLine + "  " + parts( 1 ) + " = Digits( " + nextDigitIndex.ToString + " )"
		      
		    case else
		      var op as string = replacementDict.Value( instruction )
		      rows( i ) = parts( 1 ) + " = " + parts( 1 ) + " " + op + " " + parts( 2 )
		      
		    end select
		  next
		  
		  input = String.FromArray( rows, EndOfLine + "  " )
		  input = "  " + input.Trim + EndOfLine + EndOfLine
		  
		  //
		  // Some optimizations
		  //
		  'x = if( x = w, 1, 0 )
		  'x = if( x = 0, 1, 0 )
		  
		  var optimizations() as pair
		  optimizations.Add "^  (\w) = \g1 \* 0\R  \g1 = \g1 \+ (-?\w+)" : "  $1 = $2"
		  optimizations.Add "^  (\w) = \g1 \\ 1\R" : ""
		  optimizations.Add "^  (\w) = if\( \g1 = (\w), 1, 0 \)\R  \g1 = if\( \g1 = 0, 1, 0 \)" : "  $1 = if( $1 <> $2, 1, 0 )"
		  optimizations.Add "^\x20+\R" : EndOfLine
		  optimizations.Add "^\R" : "  print ""w = "" + w.ToString + "", z = "" + z.ToString" + EndOfLine + EndOfLine
		  
		  var rx as new RegEx
		  rx.Options.ReplaceAllMatches = true
		  
		  for each opt as pair in optimizations
		    rx.SearchPattern = opt.Left
		    rx.ReplacementPattern = opt.Right
		    input = rx.Replace( input )
		  next
		  
		  input = input.Trim + EndOfLine + EndOfLine + "  print ""----------""" + EndOfLine
		  
		  var script as string = kScriptBase
		  script = script.Replace( "// Code here //", input )
		  
		  script = script.Replace( "// DEBUG THRESHOLD //", "100000000" )
		  
		  var xs as new LoggingXojoScript
		  xs.Context = self
		  xs.Source = script
		  
		  return xs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Handle_Print(sender As XojoScript, msg As String)
		  #pragma unused sender
		  
		  System.DebugLog msg
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToString(arr() As Integer) As String
		  var builder() as string
		  for each i as integer in arr
		    builder.Add i.ToString
		  next
		  
		  return String.FromArray( builder, "" )
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ScriptResult As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StateDicts() As Dictionary
	#tag EndProperty


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"inp w\nmul x 0\nadd x z\nmod x 26\ndiv z 1\nadd x 15\neql x w\neql x 0\nmul y 0\nadd y 25\nmul y x\nadd y 1\nmul z y\nmul y 0\nadd y w\nadd y 15\nmul y x\nadd z y\ninp w\nmul x 0\nadd x z\nmod x 26\ndiv z 1\nadd x 12\neql x w\neql x 0\nmul y 0\nadd y 25\nmul y x\nadd y 1\nmul z y\nmul y 0\nadd y w\nadd y 5\nmul y x\nadd z y\ninp w\nmul x 0\nadd x z\nmod x 26\ndiv z 1\nadd x 13\neql x w\neql x 0\nmul y 0\nadd y 25\nmul y x\nadd y 1\nmul z y\nmul y 0\nadd y w\nadd y 6\nmul y x\nadd z y\ninp w\nmul x 0\nadd x z\nmod x 26\ndiv z 26\nadd x -14\neql x w\neql x 0\nmul y 0\nadd y 25\nmul y x\nadd y 1\nmul z y\nmul y 0\nadd y w\nadd y 7\nmul y x\nadd z y\ninp w\nmul x 0\nadd x z\nmod x 26\ndiv z 1\nadd x 15\neql x w\neql x 0\nmul y 0\nadd y 25\nmul y x\nadd y 1\nmul z y\nmul y 0\nadd y w\nadd y 9\nmul y x\nadd z y\ninp w\nmul x 0\nadd x z\nmod x 26\ndiv z 26\nadd x -7\neql x w\neql x 0\nmul y 0\nadd y 25\nmul y x\nadd y 1\nmul z y\nmul y 0\nadd y w\nadd y 6\nmul y x\nadd z y\ninp w\nmul x 0\nadd x z\nmod x 26\ndiv z 1\nadd x 14\neql x w\neql x 0\nmul y 0\nadd y 25\nmul y x\nadd y 1\nmul z y\nmul y 0\nadd y w\nadd y 14\nmul y x\nadd z y\ninp w\nmul x 0\nadd x z\nmod x 26\ndiv z 1\nadd x 15\neql x w\neql x 0\nmul y 0\nadd y 25\nmul y x\nadd y 1\nmul z y\nmul y 0\nadd y w\nadd y 3\nmul y x\nadd z y\ninp w\nmul x 0\nadd x z\nmod x 26\ndiv z 1\nadd x 15\neql x w\neql x 0\nmul y 0\nadd y 25\nmul y x\nadd y 1\nmul z y\nmul y 0\nadd y w\nadd y 1\nmul y x\nadd z y\ninp w\nmul x 0\nadd x z\nmod x 26\ndiv z 26\nadd x -7\neql x w\neql x 0\nmul y 0\nadd y 25\nmul y x\nadd y 1\nmul z y\nmul y 0\nadd y w\nadd y 3\nmul y x\nadd z y\ninp w\nmul x 0\nadd x z\nmod x 26\ndiv z 26\nadd x -8\neql x w\neql x 0\nmul y 0\nadd y 25\nmul y x\nadd y 1\nmul z y\nmul y 0\nadd y w\nadd y 4\nmul y x\nadd z y\ninp w\nmul x 0\nadd x z\nmod x 26\ndiv z 26\nadd x -7\neql x w\neql x 0\nmul y 0\nadd y 25\nmul y x\nadd y 1\nmul z y\nmul y 0\nadd y w\nadd y 6\nmul y x\nadd z y\ninp w\nmul x 0\nadd x z\nmod x 26\ndiv z 26\nadd x -5\neql x w\neql x 0\nmul y 0\nadd y 25\nmul y x\nadd y 1\nmul z y\nmul y 0\nadd y w\nadd y 7\nmul y x\nadd z y\ninp w\nmul x 0\nadd x z\nmod x 26\ndiv z 26\nadd x -10\neql x w\neql x 0\nmul y 0\nadd y 25\nmul y x\nadd y 1\nmul z y\nmul y 0\nadd y w\nadd y 1\nmul y x\nadd z y", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kScriptBase, Type = String, Dynamic = False, Default = \"const kDebugThreshold as integer \x3D // DEBUG THRESHOLD //\n\nconst kLastDigitIndex as integer \x3D 13\n\nvar Digits( kLastDigitIndex ) as integer\nvar Counter as Integer\n\nSub Initialize()\n  for i as integer \x3D 0 to Digits.LastIndex\n    Digits( i ) \x3D 1\n  next\nEnd Sub\n\nSub Decrement()\n  for i as integer \x3D Digits.LastIndex downto 0\n    Digits( i ) \x3D Digits( i ) - 1\n    if Digits( i ) <> 0 then\n      exit\n    end if\n    Digits( i ) \x3D 9\n  next i\nEnd Sub\n\nSub Increment()\n  for i as integer \x3D Digits.LastIndex downto 0\n    Digits( i ) \x3D Digits( i ) + 1\n    if Digits( i ) <> 10 then\n      exit\n    end if\n    Digits( i ) \x3D 1\n  next i\nEnd Sub\n\nFunction DigitsToString () As String\n  var stringBuilder() as string\n  for each digit as integer in Digits\n    stringBuilder.Add digit.ToString\n  next\n  return String.FromArray( stringBuilder\x2C \"\" )\nEnd Function\n\n\nFunction ALU () As Boolean\n  var w\x2C x\x2C y\x2C z as integer\n  \n// Code here //\n  \n  if kDebugThreshold > 0 then\n    Counter \x3D Counter + 1\n    if Counter \x3D kDebugThreshold then\n      Counter \x3D 0\n      print DigitsToString\n    end if\n  end if\n\n  return z \x3D 0\nEnd Function\n\n\n//\n// MAIN\n//\nInitialize\n\nwhile not ALU\n  Increment\n  \'Decrement\nwend\n\nScriptResult \x3D DigitsToString\n", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"inp z\ninp x\nmul z 3\neql z x", Scope = Private
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
