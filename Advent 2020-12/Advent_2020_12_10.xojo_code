#tag Class
Protected Class Advent_2020_12_10
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
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
		  return CalculateResultB( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var adapters() as integer = ToIntegerArray( input )
		  adapters.Add 0
		  
		  adapters.Sort
		  adapters.Add adapters( adapters.LastIndex ) + 3
		  
		  var counts( 3 ) as integer
		  for i as integer = 1 to adapters.LastIndex
		    var diff as integer = adapters( i ) - adapters( i - 1 )
		    counts( diff ) = counts( diff ) + 1
		  next
		  
		  return counts( 1 ) * counts( 3 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var adapters() as integer = ToIntegerArray( input )
		  adapters.Add 0
		  
		  adapters.Sort
		  adapters.Add adapters( adapters.LastIndex ) + 3
		  
		  return CountArrangements( adapters, 0, new Dictionary )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountArrangements(adapters() As Integer, currentIndex As Integer, stateDict As Dictionary) As Integer
		  if stateDict.HasKey( currentIndex ) then
		    return stateDict.Value( currentIndex )
		  end if
		  
		  var adapter as integer = adapters( currentIndex )
		  var count as integer
		  
		  for i as integer = currentIndex + 1 to adapters.LastIndex
		    var nextValue as integer = adapters( i )
		    
		    if ( nextValue - adapter ) > 3 then
		      exit
		    end if
		    
		    if i = adapters.LastIndex then
		      count = count + 1
		    else
		      count = count + CountArrangements( adapters, i, stateDict )
		    end if
		  next
		  
		  stateDict.Value( currentIndex ) = count
		  return count
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"28\n33\n18\n42\n31\n14\n46\n20\n48\n47\n24\n23\n49\n45\n19\n38\n39\n11\n1\n32\n25\n35\n8\n17\n7\n9\n4\n2\n34\n10\n3", Scope = Private
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
