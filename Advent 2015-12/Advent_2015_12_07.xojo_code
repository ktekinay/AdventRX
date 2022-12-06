#tag Class
Protected Class Advent_2015_12_07
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Trace circuits"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Some Assembly Required"
		  
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
		  if input = "" then
		    return -1
		  end if
		  
		  var dict as Dictionary = ToCircuits( input )
		  
		  WireASignal = GetCircuitValue( "a", dict )
		  return WireASignal
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  if input = "" then
		    return -1
		  end if
		  
		  var dict as Dictionary = ToCircuits( input )
		  dict.Value( "b" ) = WireASignal
		  
		  return GetCircuitValue( "a", dict )
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCircuitValue(wire As String, dict As Dictionary) As UInt16
		  var stack() as string = array( wire )
		  
		  while stack.Count <> 0
		    var toWire as string = stack.Pop
		    var value as variant = dict.Value( toWire )
		    if value.Type <> Variant.TypeObject then
		      continue
		    end if
		    
		    var c as Circuit = value
		    
		    for i as integer = 0 to 1
		      var w as string = c.Wires( i )
		      if w = "" then
		        continue for i
		      end if
		      
		      var wValue as variant = dict.Value( w )
		      
		      if wValue isa Circuit then
		        Stack.Add toWire
		        Stack.Add w
		        continue while
		      end if
		      
		      c.Store wValue, i
		    next
		    
		    dict.Value( toWire ) = c.Calculate
		  wend
		  
		  return dict.Value( wire )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToCircuits(input As String) As Dictionary
		  var raw() as string = ToStringArray( input )
		  
		  var dict as new Dictionary
		  
		  for each instruction as string in raw
		    var parts() as string = instruction.Split( " -> " )
		    var toWire as string = parts( 1 )
		    
		    var c as new Circuit( parts( 0 ) )
		    dict.Value( toWire ) = c
		  next
		  
		  return dict
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private WireASignal As UInt16
	#tag EndProperty


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"", Scope = Private
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
