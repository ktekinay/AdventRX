#tag Class
Protected Class Advent_2020_12_15
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
		  return CalculateResultB( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var values() as integer = ToIntegerArray( input )
		  if values.Count = 0 then
		    return -1
		  end if
		  
		  return ResultOnTurn( 2020, values )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var values() as integer = ToIntegerArray( input )
		  if values.Count = 0 then
		    return -1
		  end if
		  
		  return ResultOnTurn( 30000000, values )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ResultOnTurn(targetTurn As Integer, values() As Integer) As Integer
		  var lastValue as integer = values.Pop
		  
		  var trace as new Dictionary
		  trace.BinCount = max( ( targetTurn * 10 ) + 1, 100001 )
		  
		  for i as integer = 0 to values.LastIndex
		    trace.Value( values( i ) ) = i + 1
		  next
		  
		  var turn as integer = values.Count + 1
		  
		  do
		    turn = turn + 1
		    
		    var thisValue as integer
		    
		    var v as variant = trace.Lookup( lastValue, nil )
		    
		    if v is nil then
		      thisValue = 0
		      trace.Value( lastValue ) = turn - 1
		      
		    else
		      thisValue = ( turn - 1 ) - v.IntegerValue
		      trace.Value( lastValue ) = turn - 1
		      
		    end if
		    
		    lastValue = thisValue
		  loop until turn = targetTurn
		  
		  return lastValue
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"0\x2C14\x2C1\x2C3\x2C7\x2C9", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"0\x2C3\x2C6", Scope = Private
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
