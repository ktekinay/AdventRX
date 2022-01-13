#tag Class
Protected Class Amphipod
	#tag Method, Flags = &h0
		Shared Function FromLetter(letter As String) As Amphipod
		  const kA as string = "A"
		  
		  var asNumber as integer = letter.Uppercase.Asc - kA.Asc + 1
		  
		  var result as new Amphipod
		  result.Letter = letter
		  result.Energy = 10 ^ ( asNumber - 1 )
		  result.TargetColumn = asNumber * 2
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Move(grid(, ) As Amphipod, amphipods() As Amphipod, energyUsed As Integer) As Integer
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Column As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Energy As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Letter As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Row As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		TargetColumn As Integer
	#tag EndProperty


	#tag Constant, Name = kInfiniteEnergy, Type = Double, Dynamic = False, Default = \"&hFFFFFFFFFFFFFF", Scope = Private
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
			Name="TargetColumn"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Energy"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Letter"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
