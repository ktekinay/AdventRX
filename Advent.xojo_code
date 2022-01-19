#tag Module
Protected Module Advent
	#tag Method, Flags = &h0
		Function IsBelow(Extends pt As Xojo.Point, rect As Advent.GraphRect) As Boolean
		  return pt.Y < rect.Bottom
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBetween(Extends i As Integer, v1 As Integer, v2 As Integer) As Boolean
		  if v1 <= v2 then
		    return i >= v1 and i <= v2
		  else
		    return i >= v2 and i <= v1
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsInteger(Extends v As Variant) As Boolean
		  select case v.Type
		  case Variant.TypeInteger
		  case Variant.TypeInt32
		  case Variant.TypeInt64
		  case else
		    return false
		  end select
		  
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLeftOf(Extends pt As Xojo.Point, rect As Advent.GraphRect) As Boolean
		  return pt.X < rect.Left
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRightOf(Extends pt As Xojo.Point, rect As Advent.GraphRect) As Boolean
		  return pt.X > rect.Right
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MultiplyArray(arr() As Integer, includeZeros As Boolean) As Integer
		  var result as integer = 1
		  var foundItems as boolean
		  
		  for each num as integer in arr
		    if includeZeros or num <> 0 then
		      foundItems = true
		      result = result * num
		    end if
		  next
		  
		  if foundItems then
		    return result
		  else
		    return 0
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SumArray(arr() As Integer) As Integer
		  var sum as integer
		  
		  for each value as integer in arr
		    sum = sum + value
		  next
		  
		  return sum
		  
		End Function
	#tag EndMethod


	#tag ViewBehavior
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
End Module
#tag EndModule
