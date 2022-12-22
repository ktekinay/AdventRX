#tag Class
Protected Class TunnelValve
	#tag Method, Flags = &h0
		Sub Constructor()
		  Stats = new Dictionary
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		FlowRate As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		IsOpen As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		LeadsTo() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared OpenedValves As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Stats As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared ValvesWithFlowRate As Integer
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
