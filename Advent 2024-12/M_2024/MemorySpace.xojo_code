#tag Class
Protected Class MemorySpace
Inherits Advent.GridMember
Implements M_Path.MilestoneInterface
	#tag Method, Flags = &h21
		Private Function DistanceFromParent(parent As M_Path.MilestoneInterface) As Double
		  return 1.0
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DistanceToGoal(goal As M_Path.MilestoneInterface) As Double
		  var g as MemorySpace = MemorySpace( goal )
		  
		  return M_Path.ManhattanDistance( Column, Row, g.Column, g.Row )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetKey() As Variant
		  return Row * 10000 + Column
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetParent(parent As M_Path.MilestoneInterface)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Successors() As M_Path.MilestoneInterface()
		  var neighbors() as Advent.GridMember = self.Neighbors( false, true )
		  
		  var result() as M_Path.MilestoneInterface
		  
		  for i as integer = neighbors.LastIndex downto 0
		    if neighbors( i ).RawValue <> "#" then
		      result.Add M_Path.MilestoneInterface( neighbors( i ) )
		    end if
		  next
		  
		  return result
		End Function
	#tag EndMethod


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
