#tag Class
Class GridMember
	#tag Method, Flags = &h0
		Sub Constructor(value As Variant = Nil)
		  self.RawValue = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Neighbors(includeDiagonal As Boolean, reset As Boolean = False) As GridMember()
		  if not reset and GotNeighbors then
		    return MyNeighbors
		  end if
		  
		  var neighbors() as GridMember
		  var g as ObjectGrid = Grid
		  
		  if g is nil then
		    return neighbors
		  end if
		  
		  var directionals() as ObjectGrid.NextDelegate
		  if includeDiagonal then
		    directionals = g.AllDirectionals
		  else
		    directionals = g.MainDirectionals
		    end if
		    
		  for each direction as ObjectGrid.NextDelegate in directionals
		    var neighbor as GridMember = direction.Invoke( self )
		    if neighbor isa object then
		      neighbors.Add neighbor
		  end if
		  next
		  
		  MyNeighbors = neighbors
		  GotNeighbors = true
		  
		  return MyNeighbors
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  return ToString
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event StringValue() As String
	#tag EndHook


	#tag Property, Flags = &h0
		Column As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected GotNeighbors As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mGrid is nil then
			    return nil
			  else
			    return ObjectGrid( mGrid.Value )
			  end if
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  if value is nil then
			    mGrid = nil
			  else
			    mGrid = value.WeakRef
			  end if
			  
			End Set
		#tag EndSetter
		Grid As ObjectGrid
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mGrid As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private MyNeighbors() As GridMember
	#tag EndProperty

	#tag Property, Flags = &h0
		RawValue As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		Row As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return RaiseEvent StringValue
			End Get
		#tag EndGetter
		ToString As String
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
			Name="Row"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Column"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToString"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
