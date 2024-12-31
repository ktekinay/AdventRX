#tag Class
Protected Class Gate
	#tag Method, Flags = &h0
		Sub Calculate()
		  var w1 as Wire = InWire1
		  
		  if not w1.WasSet then
		    return
		  end if
		  
		  var w2 as Wire = InWire2
		  
		  if not w2.WasSet then
		    return
		  end if
		  
		  var o as Wire = OutWire
		  
		  select case Op
		  case "AND"
		    o.Set w1.Value and w2.Value
		    
		  case "OR"
		    o.Set w1.Value or w2.Value
		    
		  case "XOR"
		    o.Set w1.Value xor w2.Value
		    
		  case else
		    raise new RuntimeException
		    
		  end select
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if InWires.LastIndex >= 0 then
			    return Wire( InWires( 0 ).Value )
			  end if
			  
			End Get
		#tag EndGetter
		InWire1 As Wire
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if InWires.LastIndex >= 1 then
			    return Wire( InWires( 1 ).Value )
			  end if
			  
			End Get
		#tag EndGetter
		InWire2 As Wire
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		InWires() As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOutWire As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0
		Op As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mOutWire is nil then
			    return nil
			  else
			    return Wire( mOutWire.Value )
			  end if
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  if value is nil then
			    mOutWire = nil
			  else
			    mOutWire = value.MyWeakRef
			  end if
			  
			End Set
		#tag EndSetter
		OutWire As Wire
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
		#tag ViewProperty
			Name="Op"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mOutWire"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
