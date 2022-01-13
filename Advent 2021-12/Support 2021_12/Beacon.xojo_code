#tag Class
Protected Class Beacon
Inherits Advent3DObject
	#tag Method, Flags = &h0
		Sub Constructor(fromBeacon As Beacon = Nil)
		  if fromBeacon isa object then
		    IsOrigSet = fromBeacon.IsOrigSet
		    
		    OrigRelativeX = fromBeacon.OrigRelativeX
		    OrigRelativeY = fromBeacon.OrigRelativeY
		    OrigRelativeZ = fromBeacon.OrigRelativeZ
		    
		    RelativeX = fromBeacon.RelativeX
		    RelativeY = fromBeacon.RelativeY
		    RelativeZ = fromBeacon.RelativeZ
		    
		    X = fromBeacon.X
		    Y = fromBeacon.Y
		    Z = fromBeacon.Z
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reorient(orientation As Integer)
		  if not IsOrigSet then
		    OrigRelativeX = RelativeX
		    OrigRelativeY = RelativeY
		    OrigRelativeZ = RelativeZ
		    IsOrigSet = true
		  end if
		  
		  select case orientation
		  case 1 // Upright
		    SetRelativeCoordinates OrigRelativeX, OrigRelativeY, OrigRelativeZ
		    
		  case 2 // Face right
		    SetRelativeCoordinates -OrigRelativeZ, OrigRelativeY, OrigRelativeX
		    
		  case 3 // Turn around
		    SetRelativeCoordinates -OrigRelativeX, OrigRelativeY, -OrigRelativeZ
		    
		  case 4 // Face left
		    SetRelativeCoordinates OrigRelativeZ, OrigRelativeY, -OrigRelativeX
		    
		  case 5 // Face down
		    SetRelativeCoordinates OrigRelativeX, OrigRelativeZ, -OrigRelativeY
		    
		  case 6 // Standing on head, turned around
		    SetRelativeCoordinates OrigRelativeX, -OrigRelativeY, -OrigRelativeZ
		    
		  case 7 // Face up
		    SetRelativeCoordinates OrigRelativeX, -OrigRelativeZ, OrigRelativeY
		    
		  case 8 // 90°
		    SetRelativeCoordinates -OrigRelativeY, OrigRelativeX, OrigRelativeZ
		    
		  case 9 // 180°
		    SetRelativeCoordinates -OrigRelativeX, -OrigRelativeY, OrigRelativeZ
		    
		  case 10 // -90°
		    SetRelativeCoordinates OrigRelativeY, -OrigRelativeX, OrigRelativeZ
		    
		  case 11 // 90° face up
		    SetRelativeCoordinates OrigRelativeZ, OrigRelativeX, OrigRelativeY
		    
		  case 12 // 90° turn around
		    SetRelativeCoordinates OrigRelativeY, OrigRelativeX, -OrigRelativeZ
		    
		  case 13 // 90° face down
		    SetRelativeCoordinates -OrigRelativeZ, OrigRelativeX, -OrigRelativeY
		    
		  case 14 // -90° face up
		    SetRelativeCoordinates -OrigRelativeZ, -OrigRelativeX, OrigRelativeY
		    
		  case 15 // -90° turn around
		    SetRelativeCoordinates -OrigRelativeY, -OrigRelativeX, -OrigRelativeZ
		    
		  case 16 // -90° face down
		    SetRelativeCoordinates OrigRelativeZ, -OrigRelativeX, -OrigRelativeY
		    
		  case 17 // 180° face right
		    SetRelativeCoordinates OrigRelativeZ, -OrigRelativeY, OrigRelativeX
		    
		  case 18 // 180° face left
		    SetRelativeCoordinates -OrigRelativeZ, -OrigRelativeY, -OrigRelativeX
		    
		  case 19 // Face down, 90°
		    SetRelativeCoordinates -OrigRelativeY, OrigRelativeZ, -OrigRelativeX
		    
		  case 20 // Face down, -90°
		    SetRelativeCoordinates OrigRelativeY, OrigRelativeZ, OrigRelativeX
		    
		  case 21 // Face up, 90°
		    SetRelativeCoordinates -OrigRelativeY, -OrigRelativeZ, OrigRelativeX
		    
		  case 22 // Face up, -90°
		    SetRelativeCoordinates OrigRelativeY, -OrigRelativeZ, -OrigRelativeX
		    
		  case 23 // Face up, head forward
		    SetRelativeCoordinates -OrigRelativeX, OrigRelativeZ, OrigRelativeY
		    
		  case 24 // Face down, head away
		    SetRelativeCoordinates -OrigRelativeX, -OrigRelativeZ, -OrigRelativeY
		    
		  case else
		    raise new OutOfBoundsException
		    
		  end select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetRelativeCoordinates(x As Integer, y As Integer, z As Integer)
		  self.RelativeX = x
		  self.RelativeY = y
		  self.RelativeZ = z
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private IsOrigSet As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private OrigRelativeX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private OrigRelativeY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private OrigRelativeZ As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		RelativeX As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		RelativeY As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		RelativeZ As Integer
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
		#tag ViewProperty
			Name="RelativeX"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RelativeY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RelativeZ"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
