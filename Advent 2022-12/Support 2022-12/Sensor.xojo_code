#tag Class
Protected Class Sensor
Inherits Xojo.Point
	#tag Method, Flags = &h0
		Function MaxXForRow(row As Integer) As Integer
		  if row > MaxY or row < MinY then
		    return X
		  end if
		  
		  var rowDistance as integer = abs( row - Y ) // 1
		  
		  return MaxX - rowDistance
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinXForRow(row As Integer) As Integer
		  if row > MaxY or row < MinY then
		    return X
		  end if
		  
		  var rowDistance as integer = abs( row - Y ) // 1
		  
		  return MinX + rowDistance
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Beacon As Xojo.Point
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return abs( X - Beacon.X )
			  
			End Get
		#tag EndGetter
		DeltaX As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return abs( Y - Beacon.Y )
			  
			End Get
		#tag EndGetter
		DeltaY As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Index As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return X + DeltaX + DeltaY
			End Get
		#tag EndGetter
		MaxX As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Y + DeltaX + DeltaY
			  
			End Get
		#tag EndGetter
		MaxY As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return X - ( DeltaX + DeltaY )
			  
			End Get
		#tag EndGetter
		MinX As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Y - ( DeltaX + DeltaY )
			  
			End Get
		#tag EndGetter
		MinY As Integer
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Y"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
