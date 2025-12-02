#tag Class
Protected Class Advent_2025_12_02
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Add up ids with repeating patterns"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Gift Shop"
		  
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
		  var sum as integer = CalculateSections( input, true )
		  return sum : if( IsTest, 1227775554, 12586854255 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var sum as integer = CalculateSections( input )
		  return sum : if( IsTest, 4174379265, 17298174201 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CalculateSections(input As String, onlyHalf As Boolean = False) As Integer
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		  #endif
		  #pragma BoundsChecking false
		  #pragma NilObjectChecking false
		  #pragma StackOverflowChecking false
		  
		  var ranges() as string = input.Trim.Split( ",")
		  
		  var sum as integer
		  
		  for each r as string in ranges
		    var parts() as string = r.Split( "-" )
		    
		    var startIndex as integer = parts( 0 ).ToInteger
		    var endIndex as integer = parts( 1 ).ToInteger
		    
		    for v as integer = startIndex to endIndex
		      var digits as integer = Floor( Log10( v ) + 1.0 )
		      
		      if onlyHalf and ( digits mod 2 ) = 1 then
		        continue
		      end if
		      
		      var halfDigits as integer = digits \ 2
		      
		      var lastIndex as integer = if( onlyHalf, halfDigits, 1 )
		      
		      for testDigits as integer = halfDigits downto lastIndex
		        if not onlyHalf and testDigits > 1 and ( digits mod testDigits ) <> 0 then
		          continue
		        end if
		        
		        var mask as integer = 10 ^ testDigits
		        var testValue as integer = v
		        
		        var compare as integer = testValue mod mask
		        testValue = testValue \ mask
		        
		        do
		          if ( testValue mod mask ) <> compare then
		            continue for testDigits
		          end if
		          testValue = testValue \ mask
		        loop until testValue = 0
		        
		        sum = sum + v
		        continue for v
		      next
		    next
		  next
		  
		  return sum 
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"11-22\x2C95-115\x2C998-1012\x2C1188511880-1188511890\x2C222220-222224\x2C1698522-1698528\x2C446443-446449\x2C38593856-38593862\x2C565653-565659\x2C824824821-824824827\x2C2121212118-2121212124", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2025
	#tag EndUsing


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
