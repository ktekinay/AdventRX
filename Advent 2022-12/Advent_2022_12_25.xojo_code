#tag Class
Protected Class Advent_2022_12_25
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Convert to SNAFU (base-5, sort of)"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Full of Hot Air"
		  
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
		  var snafus() as string = input.Split( EndOfLine )
		  
		  var sum as integer
		  
		  for each snafu as string in snafus
		    var d as integer = ToDecimal( snafu )
		    
		    'var s as string = ToSnafu( d )
		    'if s <> snafu then
		    'Print "Expected", snafu, "got", s, "for", d
		    'else
		    'Print "BINGO", snafu, "for", d
		    'end if
		    
		    sum = sum + d
		  next
		  
		  print sum, "=", ToSnafu( sum )
		  print ""
		  
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToDecimal(snafu As String) As Integer
		  var result as integer
		  
		  var digits() as string = snafu.Split( "" )
		  for i as integer = 0 to digits.LastIndex
		    var mult as integer = 5 ^ ( digits.LastIndex - i )
		    
		    var digit as string = digits( i )
		    
		    select case digit
		    case "="
		      digit = "-2"
		    case "-"
		      digit = "-1"
		    end select
		    
		    result = result + ( digit.ToInteger * mult )
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToSnafu(decimal As Integer) As String
		  var digits() as integer
		  
		  do
		    var digit as integer = decimal mod 5
		    digits.Add digit
		    decimal = decimal \ 5
		  loop until decimal = 0
		  
		  var builder() as string
		  for each digit as integer in digits
		    builder.Add digit.ToString
		  next
		  
		  var i as integer = -1
		  while i < builder.LastIndex
		    i = i + 1
		    
		    var snafu as string = builder( i )
		    if snafu <= "2" then
		      continue
		    end if
		    
		    var nextSnafu as string
		    if i = builder.LastIndex then
		      nextSnafu = "0"
		      builder.Add nextSnafu
		    else
		      nextSnafu = builder( i + 1 )
		    end if
		    
		    var nextDigit as integer = nextSnafu.ToInteger
		    
		    select case snafu
		    case "3"
		      snafu = "="
		    case "4"
		      snafu = "-"
		    case "5"
		      snafu = "0"
		    end select
		    
		    nextDigit = nextDigit + 1
		    nextSnafu = nextDigit.ToString
		    
		    builder( i ) = snafu
		    builder( i + 1 ) = nextSnafu
		    
		  wend
		  
		  for i = 0 to builder.LastIndex \ 2
		    var temp as string = builder( i )
		    builder( i ) = builder( builder.LastIndex - i )
		    builder( builder.LastIndex - i ) = temp
		  next
		  
		  return String.FromArray( builder, "" )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"1\x3D-0-2\n12111\n2\x3D0\x3D\n21\n2\x3D01\n111\n20012\n112\n1\x3D-1\x3D\n1-12\n12\n1\x3D\n122", Scope = Private
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
