#tag Class
Protected Class Advent_2016_12_05
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "MD5 hashes"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "How About a Nice Game of Chess?"
		  
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
		Private Function CalculateResultA(input As String) As Variant
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  print input
		  
		  var index as integer = 0
		  var pw() as string
		  
		  while pw.Count < 8
		    var tester as string = input + index.ToString
		    var hash as string = EncodeHex( Crypto.MD5( tester ) )
		    
		    if hash.Left( 5 ) = "00000" then
		      var nextChar as string = hash.Middle( 5, 1 ).Lowercase
		      print nextChar
		      pw.Add nextChar
		    end if
		    
		    index = index + 1
		  wend
		  
		  print ""
		  
		  var pwString as string = String.FromArray( pw, "" )
		  
		  return pwString : if( IsTest, "18f47a30", "f97c354d" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  print input
		  
		  var index as integer = -1
		  var pw( 7 ) as string
		  var foundCount as integer
		  
		  while foundCount < 8
		    index = index + 1
		    
		    var tester as string = input + index.ToString
		    var hash as string = EncodeHex( Crypto.MD5( tester ) )
		    
		    if hash.Left( 5 ) = "00000" then
		      var posChar as string = hash.Middle( 5, 1 )
		      if posChar >= "8" then
		        continue while
		      end if
		      
		      var pos as integer = posChar.ToInteger
		      if pw( pos ) <> "" then
		        continue while
		      end if
		      
		      foundCount = foundCount + 1
		      
		      var nextChar as string = hash.Middle( 6, 1 )
		      pw( pos ) = nextChar
		      
		      print pos.ToString + ": " + nextChar
		    end if
		  wend
		  
		  print ""
		  
		  var pwString as string = String.FromArray( pw, "" ).Lowercase
		  
		  return pwString : if( IsTest, "05ace8e3", "863dde27" )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"reyedfim", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"abc", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Type"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Cooperative"
				"1 - Preemptive"
			#tag EndEnumValues
		#tag EndViewProperty
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
