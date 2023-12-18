#tag Class
Class GridMember
	#tag Method, Flags = &h0
		Sub Constructor(value As Variant = Nil)
		  self.RawValue = value
		  self.Value = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Teardown
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Neighbors(includeDiagonal As Boolean, ignoreCache As Boolean = False) As GridMember()
		  var useCache as boolean = not ignoreCache
		  
		  if useCache and GotNeighbors then
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
		  
		  if useCache then
		    MyNeighbors = neighbors
		    GotNeighbors = true
		  end if
		  
		  return neighbors
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  return ToString
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Teardown()
		  MyNeighbors.RemoveAll
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event StringValue() As String
	#tag EndHook


	#tag Property, Flags = &h0, Description = 5768656E2066696E64696E6720746865206265737420706174682C207265636F726473207468652062657374206E756D626572206F6620737465707320746F2074686520656E6420706F736974696F6E2E
		BestSteps As Integer
	#tag EndProperty

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
		PrintType As PrintTypes
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652062617369632076616C7565206F6620746865206D656D6265722C2075736566756C20746F207468652063616C6C6572206F6E6C792E
		RawValue As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		Row As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  select case PrintType
			  case PrintTypes.UseRawValue
			    return RawValue
			    
			  case PrintTypes.UseValue
			    return Value
			    
			  end select
			  
			  var s as string = RaiseEvent StringValue
			  
			  if s = "" then
			    s = Value
			  end if
			  
			  if s = "" then
			    s = RawValue
			  end if
			  
			  return s
			End Get
		#tag EndGetter
		ToString As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 496620746865726520697320612076616C75652073657061726174652066726F6D2C206F7220696E7374656164206F662C2052617756616C75652C2073746F726520697420686572652E20546869732069732075736566756C20746F207468652063616C6C6572206F6E6C792E
		Value As Variant
	#tag EndProperty


	#tag Enum, Name = PrintTypes, Type = Integer, Flags = &h0
		UseEvent
		  UseRawValue
		UseValue
	#tag EndEnum


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
		#tag ViewProperty
			Name="BestSteps"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PrintType"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="PrintTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - UseEvent"
				"1 - UseRawValue"
				"2 - UseValue"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
