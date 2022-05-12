#tag Class
Protected Class Advent_2021_12_01
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  var arr() as integer = ToIntegerArray( GetPuzzleInput )
		  
		  return GetIncreaseCount( arr )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  var arr() as integer = ToIntegerArray( GetPuzzleInput )
		  var groupArr() as integer
		  
		  for i as integer = 2 to arr.LastIndex
		    groupArr.Add arr( i - 2 ) + arr( i - 1 ) + arr( i )
		  next
		  
		  return GetIncreaseCount( groupArr )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  var arr() as integer = ToIntegerArray( kTestInput )
		  
		  return GetIncreaseCount( arr )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function GetIncreaseCount(arr() As Integer) As Integer
		  var increaseCount as integer
		  for i as integer = 1 to arr.LastIndex
		    if arr( i ) > arr( i - 1 ) then
		      increaseCount = increaseCount + 1
		    end if
		  next
		  
		  return increaseCount
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"199\n200\n208\n210\n200\n207\n240\n269\n260\n263", Scope = Private
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
