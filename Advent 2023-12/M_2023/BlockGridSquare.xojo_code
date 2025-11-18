#tag Class
Protected Class BlockGridSquare
Inherits M_Path.GridSquare
Implements M_Path.MilestoneInterface
	#tag Method, Flags = &h0
		Function DistanceFromParent(parent As M_Path.MilestoneInterface) As Double
		  var thisCost as double = Grid( Row, Column ).ToDouble
		  CostToStart = BlockGridSquare( parent ).CostToStart + thisCost
		  
		  return thisCost
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistanceToGoal(goal As M_Path.MilestoneInterface) As Double
		  var g as BlockGridSquare = BlockGridSquare( goal )
		  '
		  'var goalGrid as ObjectGrid = BlockGridSquare.GoalGrid
		  '
		  'var gm as GridMember = goalGrid( g.Row, g.Column )
		  'return gm.BestSteps
		  
		  var distance as integer = M_Path.ManhattanDistance( g.Column, g.Row, Column, Row )
		  return distance * 3
		  
		  'var goalMultiplier as double = BlockGridSquare.GoalMultiplier
		  '
		  'if goalMultiplier < 10.0 then
		  'if gm.BestSteps <> 0 then
		  'return distance * 10.0 * goalMultiplier
		  'else
		  'return distance
		  'end if
		  'end if
		  '
		  'if gm.BestSteps <> 0 then
		  'return gm.BestSteps
		  'end if
		  '
		  'return distance
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FilterFromTrail(trail() As M_Path.GridSquare, neighbors() As M_Path.GridSquare)
		  for each gm as M_Path.GridSquare in trail
		    var b as M_Path.GridSquare = M_Path.GridSquare( gm )
		    if b.Direction <> Direction then
		      return
		    end if
		  next
		  
		  for i as integer = neighbors.LastIndex downto 0
		    var n as M_Path.GridSquare = neighbors( i )
		    if n.Direction = Direction then
		      neighbors.RemoveAt i
		      return
		    end if
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetKey() As Variant
		  if Row = grid.LastIndex( 1 ) and Column = grid.LastIndex( 2 ) then
		    return -1
		  end if
		  
		  return super.GetKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetTrail(count As Integer) As M_Path.GridSquare()
		  var trail() as M_Path.GridSquare
		  
		  var previous as M_Path.GridSquare = Parent
		  
		  while trail.Count < count
		    if previous is nil then
		      exit
		    end if
		    
		    trail.Add previous
		    previous = previous.Parent
		  wend
		  
		  return trail
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetParent(parent As M_Path.MilestoneInterface)
		  if Parent is nil then
		    super.SetParent( parent )
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Successors() As M_Path.MilestoneInterface()
		  if Row = 10 and Column >= 11 then
		    Row = Row
		  end if
		  
		  var result() as M_Path.MilestoneInterface
		  
		  var neighbors() as M_Path.GridSquare = self.DirectionalNeighbors
		  
		  const kCount as integer = 2
		  
		  var trail() as M_Path.GridSquare = GetTrail( kCount )
		  if trail.Count >= kCount then
		    FilterFromTrail trail, neighbors
		  end if
		  
		  for each n as M_Path.GridSquare in neighbors
		    if Grid( n.Row, n.Column ) = "#" then
		      continue
		    end if
		    
		    var nn as new BlockGridSquare
		    n.CloneTo nn
		    
		    var p as new BlockGridSquare
		    CloneTo p
		    
		    p.Direction = nn.Direction
		    nn.SetParent p
		    
		    result.Add nn
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		CostToStart As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared GoalGrid As ObjectGrid
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared GoalMultiplier As Double
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
			Name="Direction"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="M_Path.Directions"
			EditorType="Enum"
			#tag EnumValues
				"0 - North"
				"1 - East"
				"2 - South"
				"3 - West"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="CostToStart"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
