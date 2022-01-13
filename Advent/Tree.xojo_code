#tag Class
Protected Class Tree
	#tag Method, Flags = &h0
		Sub Constructor()
		  WR = new WeakRef( self )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(left As Variant, right As Variant)
		  self.Constructor
		  
		  self.Left = left
		  self.Right = right
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  var p as Advent.Tree = Parent
			  
			  if p is nil then
			    return 0
			  else
			    return 1 + p.Depth
			  end if
			  
			End Get
		#tag EndGetter
		Depth As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mLeft
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mLeft = value
			  
			  if mLeft isa Advent.Tree then
			    Advent.Tree( mLeft ).Parent = self
			  end if
			  
			End Set
		#tag EndSetter
		Left As Variant
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mLeft As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParentWR As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRight As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mParentWR is nil then
			    return nil
			  else
			    return Advent.Tree( mParentWR.Value )
			  end if
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  if value is nil then
			    mParentWR = nil
			  else
			    mParentWR = value.WR
			  end if
			  
			End Set
		#tag EndSetter
		Parent As Advent.Tree
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mRight
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRight = value
			  
			  if mRight isa Advent.Tree then
			    Advent.Tree( mRight ).Parent = self
			  end if
			  
			End Set
		#tag EndSetter
		Right As Variant
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected WR As WeakRef
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Depth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
