#tag Class
Protected Class SequenceStat
	#tag Property, Flags = &h0
		LastRecordedRowIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSum As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSumCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Prices() As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if Prices.Count <> mSumCount then
			    mSumCount = Prices.Count
			    mSum = Advent.SumArray( Prices )
			  end if
			  
			  return mSum
			  
			End Get
		#tag EndGetter
		Sum As Integer
	#tag EndComputedProperty


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
