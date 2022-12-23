#tag Class
Protected Class TunnelValve
	#tag Method, Flags = &h21
		Private Sub Destructor()
		  IsOpen = false
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return ValvesWithFlowRate - OpenedValves
			  
			End Get
		#tag EndGetter
		Shared ClosedValves As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		FlowRate As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mIsOpen
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  if value <> mIsOpen then
			    mIsOpen = value
			    
			    if value then 
			      OpenValveArray.Add Name
			      OpenValveArray.Sort
			    else
			      var pos as integer = OpenValveArray.IndexOf( Name )
			      if pos <> -1 then
			        OpenValveArray.RemoveAt pos
			      end if
			    end if
			  end if
			  
			End Set
		#tag EndSetter
		IsOpen As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		LeadsTo() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsOpen As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return OpenValveArray.Count
			  
			End Get
		#tag EndGetter
		Shared OpenedValves As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Shared OpenValveArray() As String
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
		#tag ViewProperty
			Name="FlowRate"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsOpen"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
