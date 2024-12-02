#tag Class
Protected Class Advent_2024_12_02
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Check for valid values in reports"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Red-Nosed Reports"
		  
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
		  var reports() as string = input.Trim.Split( EndOfLine )
		  
		  var count as integer
		  
		  for each report as string in reports
		    report = report.Squeeze
		    
		    var items() as string = report.Split( " " )
		    
		    var values() as integer = ToIntegerArray( items )
		    
		    if CheckValues( values ) then
		      count = count + 1
		    end if
		  next
		  
		  return count : if( IsTest, 2, 279 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var reports() as string = input.Trim.Split( EndOfLine )
		  
		  var count as integer
		  
		  for each report as string in reports
		    report = report.Squeeze
		    
		    var items() as string = report.Split( " " )
		    
		    var values() as integer = ToIntegerArray( items )
		    
		    var removalIndex as integer
		    while removalIndex <= values.LastIndex
		      var newValues() as integer
		      
		      for i as integer = 0 to values.LastIndex
		        if i <> removalIndex then
		          newValues.Add values( i )
		        end if
		      next
		      
		      if CheckValues( newValues ) then
		        count = count + 1
		        continue for report
		      end if
		      
		      removalIndex = removalIndex + 1
		    wend
		  next
		  
		  return count : if( IsTest, 4, 343 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CheckValues(values() As Integer) As Boolean
		  var isGood as boolean = true
		  
		  var lastIndex as integer = values.LastIndex - 1
		  for i as integer = 0 to lastIndex
		    var v1 as integer = values( i )
		    var v2 as integer = values( i + 1 )
		    
		    if v1 < v2 and abs( v1 - v2 ) <= 3 then
		      continue
		    end if
		    
		    isGood = false
		    exit
		  next
		  
		  if isGood then
		    return true
		  end if
		  
		  for i as integer = values.LastIndex downto 1
		    var v1 as integer = values( i )
		    var v2 as integer = values( i - 1 )
		    
		    if v1 < v2 and abs( v1 - v2 ) <= 3 then
		      continue
		    end if
		    
		    return false
		    exit
		  next
		  
		  return true
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"7 6 4 2 1\n1 2 7 8 9\n9 7 6 2 1\n1 3 2 4 5\n8 6 4 4 1\n1 3 6 7 9", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2024
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
