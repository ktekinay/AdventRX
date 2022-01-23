#tag Class
Class Advent3DObject
	#tag Method, Flags = &h0
		Shared Function HashOf(x As Integer, y As Integer, z As Integer) As Integer
		  const kAdder as integer = 1000000
		  
		  x = x + kAdder
		  y = y + kAdder
		  z = z + kAdder
		  
		  const kMask as UInt64 = &b111111111111111111111 // 21
		  
		  var result as integer = _
		  Bitwise.ShiftLeft( x and kMask, 42 ) or _
		  Bitwise.ShiftLeft( y and kMask, 21 ) or _
		  ( z and kMask ) 
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function HashOf(x As Integer, y As Integer, z As Integer, w As Integer) As Integer
		  var result as integer
		  
		  var ux as UInt16 = x
		  var uy as UInt16 = y
		  var uz as UInt16 = z
		  var uw as UInt16 = w
		  
		  result = _
		  Bitwise.ShiftLeft( ux, 48 ) or _
		  Bitwise.ShiftLeft( uy, 32 ) or _
		  Bitwise.ShiftLeft( uz, 16 ) or _
		  uw
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetCoordinates(x As Integer, y As Integer, z As Integer)
		  self.mX = x
		  self.mY = y
		  self.mZ = z
		  
		  mHash = HashOf( x, y, z )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetCoordinates(x As Integer, y As Integer, z As Integer, w As Integer)
		  self.mX = x
		  self.mY = y
		  self.mZ = z
		  self.mW = w
		  
		  mHash = HashOf( x, y, z, w )
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return X.ToString + "," + Y.ToString + "," + Z.ToString
			End Get
		#tag EndGetter
		Coordinates As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mHash
			End Get
		#tag EndGetter
		Hash As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mHash As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mW As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWeakRef As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mZ As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Value As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mW
			End Get
		#tag EndGetter
		W As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mWeakRef is nil then
			    mWeakRef = new WeakRef( self )
			  end if
			  
			  return mWeakRef
			  
			End Get
		#tag EndGetter
		WeakRef As WeakRef
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mX
			End Get
		#tag EndGetter
		X As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mY
			End Get
		#tag EndGetter
		Y As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mZ
			End Get
		#tag EndGetter
		Z As Integer
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
			Name="Coordinates"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
		#tag ViewProperty
			Name="Hash"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
