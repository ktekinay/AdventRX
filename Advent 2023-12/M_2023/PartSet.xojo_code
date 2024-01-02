#tag Class
Protected Class PartSet
	#tag Method, Flags = &h0
		Sub Constructor(maximum As Integer = 4000)
		  A = new Advent.Range( 1, maximum )
		  M = new Advent.Range( 1, maximum )
		  S = new Advent.Range( 1, maximum )
		  X = new Advent.Range( 1, maximum )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(other As PartSet)
		  A = new Advent.Range( other.A )
		  M = new Advent.Range( other.M )
		  S = new Advent.Range( other.S )
		  X = new Advent.Range( other.X )
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		A As Advent.Range
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if A is nil then
			    return false
			  end if
			  
			  if A.Length <= 0 or M.Length <= 0 or S.Length <= 0 or X.Length <= 0 then
			    return false
			  end if
			  
			  return true
			  
			End Get
		#tag EndGetter
		IsValid As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		M As Advent.Range
	#tag EndProperty

	#tag Property, Flags = &h0
		S As Advent.Range
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if A is nil then
			    return ""
			  end if
			  
			  var builder() as string
			  builder.Add "A:" + A.ToString + " (" + A.Length.ToString + ")"
			  builder.Add "M:" + M.ToString + " (" + M.Length.ToString + ")"
			  builder.Add "S:" + S.ToString + " (" + S.Length.ToString + ")"
			  builder.Add "X:" + X.ToString + " (" + X.Length.ToString + ")"
			  
			  return String.FromArray( builder, ", " )
			  
			End Get
		#tag EndGetter
		StringValue As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		X As Advent.Range
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
	#tag EndViewBehavior
End Class
#tag EndClass
