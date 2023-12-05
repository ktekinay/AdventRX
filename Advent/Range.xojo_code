#tag Class
Protected Class Range
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(otherRange As Advent.Range)
		  Constructor( otherRange.Minimum, otherRange.Maximum )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(minimum As Integer, maximum As Integer)
		  Constructor
		  
		  self.Minimum = minimum
		  self.Maximum = maximum
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(otherRange As Advent.Range) As Boolean
		  return Minimum <= otherRange.Minimum and Maximum >= otherRange.Maximum
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  return ToString
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Overlaps(otherRange As Advent.Range) As Boolean
		  if otherRange.Minimum <= Minimum and otherRange.Maximum >= Minimum then
		    return true
		  elseif Minimum <= otherRange.Minimum and Maximum >= otherRange.Minimum then
		    return true
		  end if
		  
		  return false
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Maximum - Minimum + 1
			End Get
		#tag EndGetter
		Distance As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Maximum As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Minimum As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Minimum.ToString + "-" + Maximum.ToString
			  
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
			Name="Maximum"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Minimum"
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
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
