#tag Class
Protected Class Advent_2021_12_07
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( GetPuzzleInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var arr() as integer = ToIntegerArray( input )
		  arr.Sort
		  
		  var highestPos as integer = arr( arr.LastIndex )
		  
		  var counts() as integer
		  counts.ResizeTo highestPos
		  
		  for each pos as integer in arr
		    counts( pos ) = counts( pos ) + 1
		  next
		  
		  var lowestFuel as integer = 999999999999
		  
		  for target as integer = 0 to highestPos
		    var thisFuel as integer
		    for pos as integer = 0 to counts.LastIndex
		      if pos <> target then
		        thisFuel = thisFuel + ( abs( pos - target ) * counts( pos ) )
		      end if
		    next pos
		    
		    if thisFuel < lowestFuel then
		      lowestFuel = thisFuel
		    end if
		    
		  next target
		  
		  return lowestFuel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var arr() as integer = ToIntegerArray( input )
		  arr.Sort
		  
		  var highestPos as integer = arr( arr.LastIndex )
		  
		  var counts() as integer
		  counts.ResizeTo highestPos
		  
		  for each pos as integer in arr
		    counts( pos ) = counts( pos ) + 1
		  next
		  
		  var lowestFuel as integer = 999999999999
		  
		  for target as integer = 0 to highestPos
		    var thisFuel as integer
		    for pos as integer = 0 to counts.LastIndex
		      if pos <> target then
		        var diff as integer = abs( pos - target )
		        var perm as integer = Permutation( diff )
		        thisFuel = thisFuel + ( perm * counts( pos ) )
		      end if
		    next pos
		    
		    if thisFuel < lowestFuel then
		      lowestFuel = thisFuel
		    end if
		    
		  next target
		  
		  return lowestFuel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Permutation(value As Integer) As Integer
		  var sum as integer
		  
		  if Permutations.LastIndex < value then
		    sum = Permutations( Permutations.LastIndex )
		    
		    var firstIndex as integer = Permutations.Count
		    var lastIndex as integer = value * 2 + 1
		    
		    Permutations.ResizeTo lastIndex
		    
		    for i as integer = firstIndex to lastIndex
		      sum = sum + i
		      Permutations( i ) = sum
		    next
		  end if
		  
		  sum = Permutations( value )
		  
		  return sum
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Permutations(0) As Integer
	#tag EndProperty


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"16\x2C1\x2C2\x2C0\x2C4\x2C2\x2C7\x2C1\x2C2\x2C14", Scope = Private
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
