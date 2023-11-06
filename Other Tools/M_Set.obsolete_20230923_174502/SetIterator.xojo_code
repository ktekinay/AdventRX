#tag Class
Private Class SetIterator
Implements Iterator
	#tag Method, Flags = &h0
		Sub Constructor(items() As Variant)
		  self.Items = items
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext() As Boolean
		  ItemIndex = ItemIndex + 1
		  return ItemIndex <= Items.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  return Items( ItemIndex )
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ItemIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Items() As Variant
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
	#tag EndViewBehavior
End Class
#tag EndClass
