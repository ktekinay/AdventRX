#tag Class
Protected Class BlockGridMember
Inherits GridMember
Implements M_Path.MilestoneInterface
	#tag Method, Flags = &h21
		Private Function DistanceFromParent(parent As M_Path.MilestoneInterface) As Double
		  return Value.IntegerValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DistanceToGoal(goal As M_Path.MilestoneInterface) As Double
		  return M_Path.ManhattanDistance( Row, Column, GridMember( goal ).Row, GridMember( goal ).Column )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FilterFromTrail(trail() As GridMember, neighbors() As GridMember)
		  for each gm as GridMember in trail
		    var b as BlockGridMember = BlockGridMember( gm )
		    if b.Direction <> Direction then
		      return
		    end if
		  next
		  
		  select case Direction
		  case "<", ">"
		    for i as integer = neighbors.LastIndex downto 0
		      if neighbors( i ).Row = Row then
		        neighbors.RemoveAt i
		      end if
		    next
		    
		  case "v", "^"
		    for i as integer = neighbors.LastIndex downto 0
		      if neighbors( i ).Column = Column then
		        neighbors.RemoveAt i
		      end if
		    next
		    
		  end select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetKey() As Variant
		  return self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetTrail(count As Integer) As GridMember()
		  var trail() as GridMember
		  
		  var previous as BlockGridMember = self
		  while trail.Count < count
		    previous = previous.Parent
		    
		    if previous is nil then
		      exit
		    end if
		    
		    trail.Add previous
		  wend
		  
		  return trail
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetParent(parent As M_Path.MilestoneInterface)
		  var p as BlockGridMember = BlockGridMember( parent )
		  self.Parent = p
		  
		  if p.Row < Row then
		    Direction = "v"
		  elseif p.Row > Row then
		    Direction = "^"
		  elseif p.Column < Column then
		    Direction = ">"
		  else
		    Direction = "<"
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Successors() As M_Path.MilestoneInterface()
		  var neighbors() as GridMember = self.Neighbors( false, true )
		  
		  const kCount as integer = 2
		  
		  var trail() as GridMember = GetTrail( kCount )
		  if trail.Count >= kCount then
		    FilterFromTrail trail, neighbors
		  end if
		  
		  var result() as M_Path.MilestoneInterface
		  for each n as GridMember in neighbors
		    result.Add M_Path.MilestoneInterface( n )
		  next
		  
		  result.Shuffle
		  return result
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Direction As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Parent As BlockGridMember
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
