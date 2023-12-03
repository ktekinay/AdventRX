#tag Class
Protected Class Advent_2015_12_08
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Encoding strings"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Matchsticks"
		  
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
		Private Function CalculateResultA(input As String) As Integer
		  var lines() as string = ToStringArray( input )
		  
		  var rawTotal as integer
		  var byteTotal as integer
		  
		  for each line as string in lines
		    rawTotal = rawTotal + line.Bytes
		    
		    var adjusted as string = Substitute( line )
		    byteTotal = byteTotal + adjusted.Bytes
		    
		    'print line + ": raw = " + line.Bytes.ToString + ", ajusted (" + adjusted + ") = " + adjusted.Bytes.ToString
		  next
		  
		  return rawTotal - byteTotal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var lines() as string = ToStringArray( input )
		  
		  var rawTotal as integer
		  var encodedTotal as integer
		  
		  for each line as string in lines
		    rawTotal = rawTotal + line.Bytes
		    
		    var adjusted as string = Encode( line )
		    encodedTotal = encodedTotal + adjusted.Bytes
		  next
		  
		  return encodedTotal - rawTotal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Encode(raw As String) As String
		  var result as string = raw
		  
		  result = result.ReplaceAll( "\", "\\" )
		  result = result.ReplaceAll( """", "\""" )
		  
		  return """" + result + """"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Substitute(input As String) As String
		  static rx as RegEx
		  if rx is nil then
		    rx = new RegEx
		    rx.SearchPattern = "\\([""\\]|x[[:xdigit:]]{2})"
		    rx.ReplacementPattern = "x"
		    rx.Options.ReplaceAllMatches = true
		  end if
		  
		  var justString as string = input.Middle( 1, input.Length - 2 )
		  justString = rx.Replace( justString )
		  return justString
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"\"\"\n\"abc\"\n\"aaa\\\"aaa\"\n\"\\x27\"", Scope = Private
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
