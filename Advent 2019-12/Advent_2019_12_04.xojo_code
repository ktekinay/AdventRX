#tag Class
Protected Class Advent_2019_12_04
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Apply rules to digits to find acceptable passwords"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Secure Container"
		  
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
		  if kTestInput <> "" then
		    return CalculateResultA( Normalize( kTestInput ) )
		  end if
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  if input <> "" then
		    return CalculateResultB( Normalize( input ) )
		  end if
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		  #endif
		  #pragma BoundsChecking false
		  #pragma NilObjectChecking false
		  #pragma StackOverflowChecking false
		  
		  var parts() as string = input.Trim.Split( "-" )
		  
		  var low as integer = parts( 0 ).ToInteger
		  var high as integer = parts( 1 ).ToInteger
		  
		  var digits( 5 ) as integer
		  
		  var count as integer
		  
		  for value as integer = low to high
		    ToDigits( value, digits )
		    
		    if IsAscending( digits ) and HasRepeats( digits ) then
		      count = count + 1
		    end if
		  next
		  
		  return count : if( IsTest, 0, 2779 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		  #endif
		  #pragma BoundsChecking false
		  #pragma NilObjectChecking false
		  #pragma StackOverflowChecking false
		  
		  var parts() as string = input.Trim.Split( "-" )
		  
		  var low as integer = parts( 0 ).ToInteger
		  var high as integer = parts( 1 ).ToInteger
		  
		  var digits( 5 ) as integer
		  
		  var count as integer
		  
		  for value as integer = low to high
		    ToDigits( value, digits )
		    
		    if IsAscending( digits ) and HasRepeats2( digits ) then
		      count = count + 1
		    end if
		  next
		  
		  return count : if( IsTest, 0, 1972 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function HasRepeats(digits() As Integer) As Boolean
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		  #endif
		  #pragma BoundsChecking false
		  #pragma NilObjectChecking false
		  #pragma StackOverflowChecking false
		  
		  for i as integer = 1 to digits.LastIndex
		    if digits( i - 1 ) = digits( i ) then
		      return true
		    end if
		  next
		  
		  return false
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function HasRepeats2(digits() As Integer) As Boolean
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		  #endif
		  #pragma BoundsChecking false
		  #pragma NilObjectChecking false
		  #pragma StackOverflowChecking false
		  
		  for i as integer = 1 to digits.LastIndex
		    var testDigit as integer = digits( i )
		    
		    if digits( i - 1 ) = testDigit then
		      select case i
		      case 1
		        if digits( i + 1 ) = testDigit then
		          continue
		        end if
		        
		      case digits.LastIndex
		        if digits( i - 2 ) = testDigit then
		          continue
		        end if
		        
		      case else
		        if digits( i - 2 ) = testDigit or digits( i + 1 ) = testDigit then
		          continue
		        end if
		        
		      end select
		      
		      return true
		    end if
		  next
		  
		  return false
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function IsAscending(digits() As Integer) As Boolean
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		  #endif
		  #pragma BoundsChecking false
		  #pragma NilObjectChecking false
		  #pragma StackOverflowChecking false
		  
		  for i as integer = 1 to digits.LastIndex
		    if digits( i ) < digits( i - 1 ) then
		      return false
		    end if
		  next
		  
		  return true
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub ToDigits(value As Integer, intoArr() As Integer)
		  for i as integer = intoArr.LastIndex downto 0
		    intoArr( i ) = value mod 10
		    value = value \ 10
		  next
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"", Scope = Private
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
