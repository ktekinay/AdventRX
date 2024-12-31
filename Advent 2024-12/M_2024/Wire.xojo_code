#tag Class
Protected Class Wire
	#tag Method, Flags = &h0
		Sub Set(value As UInt64)
		  if not WasSet then
		    WasSet = true
		    self.Value = value
		    
		    for each gate as Gate in Gates
		      gate.Calculate
		    next
		  else
		    raise new RuntimeException
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Designation As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Gates() As Gate
	#tag EndProperty

	#tag Property, Flags = &h0
		InGate As Gate
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWeakRef As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mWeakRef is nil then
			    mWeakRef = new WeakRef( self )
			  end if
			  
			  return mWeakRef
			  
			End Get
		#tag EndGetter
		MyWeakRef As WeakRef
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Value As UInt64
	#tag EndProperty

	#tag Property, Flags = &h0
		WasSet As Boolean
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
			Name="NAme"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WasSet"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
