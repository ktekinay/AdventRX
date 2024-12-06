#tag Class
Protected Class Reindeer
	#tag Property, Flags = &h0
		DistanceTravelled As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		FlyTime As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Points As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		RatePerSecond As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		RemainingFlyTime As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		RemainingRestTime As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		RestTime As Integer
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
