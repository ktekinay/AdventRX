#tag Class
Protected Class MazeGridMember
Inherits GridMember
Implements M_Path.MilestoneInterface
	#tag Method, Flags = &h0
		Function DistanceFromParent(parent As M_Path.MilestoneInterface) As Double
		  var p as MazeGridMember = MazeGridMember( parent )
		  
		  select case p.Direction
		  case 0
		    if Column = p.Column and Row = ( p.Row - 1 ) then
		      return 1
		    else
		      return kCost
		    end if
		    
		  case 1
		    if Row = p.Row and Column = ( p.Column + 1 ) then
		      return 1
		    else
		      return kCost
		    end if
		    
		  case 2
		    if Column = p.Column and Row = ( p.Row + 1 ) then
		      return 1
		    else
		      return kCost
		    end if
		    
		  case 3
		    if Row = p.Row and Column = ( p.Column - 1 ) then
		      return 1
		    else
		      return kCost
		    end if
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistanceToGoal(goal As M_Path.MilestoneInterface) As Double
		  return M_Path.ManhattanDistance( me.Column, me.Row, MazeGridMember( goal ).Column, MazeGridMember( goal ).Row )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetKey() As Variant
		  return Direction * 100000 + Row * 1000 + Column
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetParent(parent As M_Path.MilestoneInterface)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Successors() As M_Path.MilestoneInterface()
		  call Neighbors false
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Direction As Integer
	#tag EndProperty


	#tag Constant, Name = kCost, Type = Double, Dynamic = False, Default = \"1000", Scope = Public
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
