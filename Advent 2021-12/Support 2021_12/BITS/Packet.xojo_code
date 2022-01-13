#tag Class
Protected Class Packet
	#tag Method, Flags = &h0
		Function GetVersionSum() As Integer
		  return Version
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Parse(mb As MemoryBlock, ByRef bitStart As Integer)
		  RaiseEvent Parse( mb, bitStart )
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event GetValue() As Integer
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Parse(mb As MemoryBlock, ByRef bitStart As Integer)
	#tag EndHook


	#tag Property, Flags = &h0
		Type As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return RaiseEvent GetValue
			End Get
		#tag EndGetter
		Value As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Version As Integer
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
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
