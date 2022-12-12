#tag Class
Protected Class Elevation
Inherits Advent.GridMember
	#tag Event
		Function StringValue() As String
		  return RawValue.StringValue
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ElevationNeighbors(includeDiagonal As Boolean) As Elevation()
		  if not GotNeighbors then
		    var members() as GridMember = super.Neighbors( includeDiagonal )
		    var elevations() as Elevation
		    for each m as GridMember in members
		      elevations.Add Elevation( m )
		    next
		    MyNeighbors = elevations
		    
		    GotNeighbors = true
		  end if
		  
		  return MyNeighbors
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		BestSteps As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  static ascA as integer = asc( "a" )
			  static ascZ as integer = asc( "z" )
			  
			  if IsStart then
			    return ascA
			  elseif IsEnd then
			    return ascZ
			  else
			    return Value
			  end if
			  
			End Get
		#tag EndGetter
		CompareValue As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private GotNeighbors As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  static endValue as integer = asc( "E" )
			  return Value = endValue
			  
			End Get
		#tag EndGetter
		IsEnd As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  static startValue as integer = asc( "S" )
			  return Value = startValue
			  
			End Get
		#tag EndGetter
		IsStart As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return BestSteps >= 0
			  
			End Get
		#tag EndGetter
		IsValid As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private MyNeighbors() As Elevation
	#tag EndProperty

	#tag Property, Flags = &h0
		Value As Integer
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
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
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
			Name="IsValid"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsStart"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsEnd"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
