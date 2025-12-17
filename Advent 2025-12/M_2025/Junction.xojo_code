#tag Class
Protected Class Junction
	#tag Method, Flags = &h0
		Sub AddToCircuit(other As Junction)
		  if Circuit is nil and other.Circuit is nil then
		    Circuit = new Set
		    
		    Circuit.Add WR
		    Circuit.Add other.WR
		    
		    other.Circuit = Circuit
		    
		  elseif Circuit is other.Circuit then
		    return
		    
		  elseif Circuit is nil then
		    Circuit = other.Circuit
		    Circuit.Add WR
		    
		  elseif other.Circuit is nil then
		    Circuit.Add other.WR
		    other.Circuit = Circuit
		    
		  else
		    Circuit = Circuit.Union( other.Circuit )
		    
		    for each jwr as WeakRef in Circuit
		      var j as Junction = Junction( jwr.Value )
		      j.Circuit = Circuit
		    next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Distance(j1 As Junction, j2 As Junction) As Double
		  var xVal as double = ( j1.X - j2.X ) ^ 2.0
		  var yVal as double = ( j1.Y - j2.Y ) ^ 2.0
		  var zVal as double = ( j1.Z - j2.Z ) ^ 2.0
		  
		  return Sqrt( xVal + yVal + zVal )
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Circuit As Set
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWR As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mWR is nil then
			    mWR = new WeakRef( self )
			  end if
			  
			  return mWR
			  
			End Get
		#tag EndGetter
		WR As WeakRef
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		X As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Y As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Z As Integer
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
			Name="X"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Y"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Z"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
