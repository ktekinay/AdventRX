#tag Class
Protected Class Advent_2022_12_20
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Rotate an array"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Grove Positioning System"
		  
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
		Private Function CalculateResultA(input As String) As Integer
		  var values() as integer = ToIntegerArray( input )
		  
		  var indexes() as integer
		  indexes.ResizeTo values.LastIndex
		  
		  for i as integer = 0 to indexes.LastIndex
		    indexes( i ) = i
		  next
		  
		  if kDebug and IsTest then
		    Print ""
		    Print values
		  end if
		  
		  for index as integer = 0 to values.LastIndex
		    Move index, indexes, values
		    
		    if kDebug and IsTest then
		      Print values
		    end if
		  next
		  
		  var sum as integer = PartASum( values )
		  
		  return sum
		  return sum
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  const kDecryptionKey as integer = 811589153
		  
		  var values() as integer = ToIntegerArray( input )
		  
		  for i as integer = 0 to values.LastIndex
		    values( i ) = values( i ) * kDecryptionKey
		  next
		  
		  var indexes() as integer
		  indexes.ResizeTo values.LastIndex
		  
		  for i as integer = 0 to indexes.LastIndex
		    indexes( i ) = i
		  next
		  
		  if kDebug and IsTest then
		    Print ""
		    Print values
		  end if
		  
		  for rep as integer = 1 to 10
		    for index as integer = 0 to values.LastIndex
		      Move index, indexes, values
		    next
		    
		    if kDebug and IsTest then
		      Print "Rep" : rep, values
		    end if
		  next
		  
		  var sum as integer = PartASum( values )
		  
		  return sum
		  return sum
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Move(index As Integer, indexes() As Integer, values() As Integer)
		  var pos as integer = indexes.IndexOf( index )
		  var value as integer = values( pos )
		  
		  if value = 0 then
		    return
		  end if
		  
		  values.RemoveAt pos
		  indexes.RemoveAt pos
		  
		  var newPos as integer = pos + value
		  newPos = newPos mod values.Count
		  
		  while newPos < 0 
		    newPos = values.Count + newPos
		  wend
		  
		  values.AddAt newPos, value
		  indexes.AddAt newPos, index
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MoveSlow(index As Integer, indexes() As Integer, values() As Integer)
		  var pos as integer = indexes.IndexOf( index )
		  var value as integer = values( pos )
		  
		  if value = 0 then
		    return
		  end if
		  
		  var originalValue as integer = value
		  
		  values.RemoveAt pos
		  indexes.RemoveAt pos
		  
		  value = value mod values.Count
		  
		  while value > 0
		    values.Add values( 0 )
		    values.RemoveAt 0
		    indexes.Add indexes( 0 )
		    indexes.RemoveAt 0
		    
		    value = value - 1
		  wend
		  
		  while value < 0
		    values.AddAt 0, values.Pop
		    indexes.AddAt 0, indexes.Pop
		    
		    value = value + 1
		  wend
		  
		  values.AddAt pos, originalValue
		  indexes.AddAt pos, index
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PartASum(values() As Integer) As Integer
		  var pos as integer = values.IndexOf( 0 )
		  
		  var sum as integer
		  
		  for i as integer = 1000 to 3000 step 1000
		    pos = ( pos + 1000 ) mod values.Count
		    if kDebug then
		      Print "Pos:", pos, "=", values( pos )
		    end if
		    
		    sum = sum + values( pos )
		  next
		  
		  return sum
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kDebug, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"1\n2\n-3\n3\n-2\n0\n4", Scope = Private
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
