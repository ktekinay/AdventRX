#tag Class
Protected Class LinkedListItem
	#tag Method, Flags = &h0
		Sub Constructor(value As Variant)
		  self.Value = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ItemSorter(item1 As LinkedListItem, item2 As LinkedListItem) As Integer
		  return item1.Value - item2.Value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Sort(items() As LinkedListItem)
		  items.Sort AddressOf ItemSorter
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		NextItem As LinkedListItem
	#tag EndProperty

	#tag Property, Flags = &h0
		Value As Integer
	#tag EndProperty


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
		#tag ViewProperty
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
