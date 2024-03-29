#tag Class
Class StringGrid
	#tag Method, Flags = &h0
		Function Operator_Subscript(row As Integer, col As Integer) As String
		  return Grid( row, col )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(row As Integer, col As Integer, Assigns s As String)
		  Grid( row, col ) = s
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(row As Integer, col As Integer)
		  mLastRowIndex = row
		  mLastColIndex = col
		  
		  Grid.ResizeTo row, col
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected Grid(-1,-1) As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mLastColIndex
			End Get
		#tag EndGetter
		LastColIndex As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mLastRowIndex
			End Get
		#tag EndGetter
		LastRowIndex As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mLastColIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastRowIndex As Integer
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
			Name="LastColIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastRowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
