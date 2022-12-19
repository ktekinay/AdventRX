#tag Class
Private Class Node
	#tag Method, Flags = &h0
		Sub ClearSuccessors()
		  Successors.RemoveAll
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(milestone As M_Path.MilestoneInterface)
		  self.Milestone = milestone
		  self.Key = milestone.GetKey
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSuccessors(fromMaster As Dictionary) As M_Path.Node()
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  if GotSuccessors then
		    return Successors
		  end
		  
		  for each m as MilestoneInterface in Milestone.Successors
		    var key as variant = m.GetKey
		    
		    var n as M_Path.Node = fromMaster.Lookup( key, nil )
		    if n is nil then
		      n = new Node( m )
		      fromMaster.Value( key ) = n
		    end if
		    
		    Successors.Add n
		  next
		  
		  GotSuccessors = true
		  return Successors
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		DistanceFromStart As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		DistanceToGoal As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private GotSuccessors As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Key As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		Milestone As MilestoneInterface
	#tag EndProperty

	#tag Property, Flags = &h0
		Parent As M_Path.Node
	#tag EndProperty

	#tag Property, Flags = &h0
		Score As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Status As M_Path.Statuses
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Successors() As M_Path.Node
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
			Name="Status"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="M_Path.Statuses"
			EditorType="Enum"
			#tag EnumValues
				"0 - IsNew"
				"1 - IsOpen"
				"2 - IsClosed"
				"3 - IsReset"
				"4 - IsDeadEnd"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="DistanceFromStart"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DistanceToGoal"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Score"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
