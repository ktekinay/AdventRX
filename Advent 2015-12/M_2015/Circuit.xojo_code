#tag Class
Protected Class Circuit
	#tag Method, Flags = &h0
		Function Calculate() As UInt16
		  var result as UInt16
		  
		  select case Gate
		  case ""
		    result = Values( 0 )
		  case kGateAnd
		    result = Values( 0 ) and Values( 1 )
		  case kGateOr
		    result = Values( 0 ) or Values( 1 )
		  case kGateNot
		    result = not Values( 0 )
		  case kGateLShift
		    result = Bitwise.ShiftLeft( Values( 0 ), Values( 1 ) )
		  case kGateRShift
		    result = Bitwise.ShiftRight( Values( 0 ), Values( 1 ) )
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(raw As String)
		  self.Raw = raw
		  
		  var parts() as string = raw.Split( " " )
		  var firstPart as string = parts( 0 )
		  
		  if firstPart = kGateNot then
		    Gate = firstPart
		    Store parts( 1 ), 0
		    
		    return
		  end if
		  
		  if parts.Count = 1 then
		    Store firstPart, 0
		    return
		  end if
		  
		  Gate = parts( 1 )
		  
		  var val1 as string = parts( 0 )
		  var val2 as string = parts( 2 )
		  
		  Store val1, 0
		  Store val2, 1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Store(rawValue As String, index As Integer)
		  if IsNumeric( rawValue ) then
		    Values( index ) = rawValue.ToInteger
		    Wires( index ) = ""
		  else
		    Wires( index ) = rawValue
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Gate As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Wires( 0 ) = "" and Wires( 1 ) = ""
			End Get
		#tag EndGetter
		IsReady As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Raw As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Values(1) As UInt16
	#tag EndProperty

	#tag Property, Flags = &h0
		Wires(1) As String
	#tag EndProperty


	#tag Constant, Name = kGateAnd, Type = String, Dynamic = False, Default = \"AND", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kGateLShift, Type = String, Dynamic = False, Default = \"LSHIFT", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kGateNot, Type = String, Dynamic = False, Default = \"NOT", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kGateOr, Type = String, Dynamic = False, Default = \"OR", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kGateRShift, Type = String, Dynamic = False, Default = \"RSHIFT", Scope = Public
	#tag EndConstant


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
			Name="Raw"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Gate"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsReady"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
