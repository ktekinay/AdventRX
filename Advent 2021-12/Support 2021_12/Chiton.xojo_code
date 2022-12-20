#tag Class
Protected Class Chiton
Inherits GridMember
Implements M_Path.MilestoneInterface
	#tag Method, Flags = &h0
		Function DistanceFromParent(parent As M_Path.MilestoneInterface) As Double
		  return Risk
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistanceToGoal(goal As M_Path.MilestoneInterface) As Double
		  return M_Path.ManhattanDistance( Column, Row, grid.LastColIndex, grid.LastRowIndex )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetKey() As Variant
		  return self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Successors() As M_Path.MilestoneInterface()
		  var neighbors() as GridMember = self.Neighbors( false )
		  
		  var chitons() as Chiton
		  for each n as GridMember in neighbors
		    chitons.Add Chiton( n )
		  next
		  
		  return chitons
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Risk As Integer
	#tag EndProperty


	#tag Constant, Name = kMaxLeft, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kMaxUp, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Row"
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
		#tag ViewProperty
			Name="ToString"
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
			Name="Risk"
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
	#tag EndViewBehavior
End Class
#tag EndClass
