#tag Class
Protected Class Advent_2020_12_25
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return ""
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Combo Breaker"
		  
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
		  var rows() as string = ToStringArray( input )
		  
		  var pk1 as integer = rows( 0 ).ToInteger
		  var pk2 as integer = rows( 1 ).ToInteger
		  
		  var subjectNum1 as integer
		  var subjectNum2 as integer
		  
		  var lp1 as integer
		  GetLoop( pk1, subjectNum1, lp1 )
		  var lp2 as integer
		  GetLoop( pk2, subjectNum2, lp2 )
		  
		  var enc1 as integer = Transform( pk1, lp2 )
		  return enc1
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetLoop(pk As Integer, ByRef returnSubjectNumber As Integer, ByRef returnLoop As Integer)
		  const kMaxLoops as integer = 100000000
		  
		  var subjectNumber as integer = returnSubjectNumber
		  if subjectNumber < 0 then
		    subjectNumber = 0
		  end if
		  
		  var lp as integer = returnLoop
		  
		  if lp < 1 then
		    lp = 1
		  end if
		  
		  do
		    subjectNumber = subjectNumber + 1
		    
		    var result as integer = subjectNumber
		    
		    do
		      lp = lp + 1
		      
		      result = result * subjectNumber
		      result = result mod kDivisor
		      
		      if result = subjectNumber then
		        exit
		      end if
		      
		      if result = pk then
		        Print "PK: " + pk.ToString + ", Loop: " + lp.ToString + ", SubjectNumber: " + subjectNumber.ToString
		        returnSubjectNumber = subjectNumber
		        returnLoop = lp
		        return 
		      end if
		    loop
		    
		    lp = 1
		  loop
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Transform(subjectNumber As Integer, loops As Integer) As Integer
		  var result as integer = subjectNumber
		  
		  for lp as integer = 2 to loops
		    result = result * subjectNumber
		    result = result mod kDivisor
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kDivisor, Type = Double, Dynamic = False, Default = \"20201227", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"5764801\n17807724", Scope = Private
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
