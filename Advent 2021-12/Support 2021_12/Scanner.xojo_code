#tag Class
Protected Class Scanner
Inherits Advent3DObject
	#tag Method, Flags = &h0
		Sub Reorient(orientation As Integer)
		  if ReorientedBeacons.Count = 0 then
		    ReorientedBeacons.ResizeTo 24
		  end if
		  
		  if ReorientedBeacons( orientation ).IsNull then
		    var newBeacons() as Beacon
		    for each b as Beacon in Beacons
		      var newBeacon as new Beacon( b )
		      newBeacon.Reorient orientation
		      newBeacons.Add newBeacon
		    next
		    ReorientedBeacons( orientation ) = newBeacons
		  end if
		  
		  Beacons = ReorientedBeacons( orientation )
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		AttemptedAgainstScannerIndexes() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Beacons() As Beacon
	#tag EndProperty

	#tag Property, Flags = &h0
		Index As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mKnownBeacons is nil then
			    mKnownBeacons = new Dictionary
			  end if
			  
			  Return mKnownBeacons
			End Get
		#tag EndGetter
		KnownBeacons As Dictionary
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mKnownBeacons As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ReorientedBeacons() As Variant
	#tag EndProperty


	#tag ViewBehavior
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
		#tag ViewProperty
			Name="Coordinates"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
