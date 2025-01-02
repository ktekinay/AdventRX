#tag Class
Protected Class MazeSquare
Inherits M_Path.GridSquare
Implements M_Path.MilestoneInterface
	#tag Method, Flags = &h0
		Sub CloneTo(copy As M_Path.GridSquare)
		  super.CloneTo(copy)
		  
		  MazeSquare( copy ).CostToStart = self.CostToStart
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistanceFromParent(parent As M_Path.MilestoneInterface) As Double
		  var p as MazeSquare = MazeSquare( parent )
		  
		  var additionalCost as double
		  
		  if p.Direction <> self.Direction then
		    var diff as integer = abs( integer( p.Direction ) - integer( self.Direction ) )
		    if diff = 1 or diff = 3 then
		      additionalCost = kCost
		    else
		      additionalCost = kCost + kCost
		    end if
		  end if
		  
		  CostToStart = p.CostToStart + 1.0 + additionalCost
		  return 1.0 + additionalCost
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Successors() As M_Path.MilestoneInterface()
		  var neighbors() as M_Path.GridSquare
		  
		  if BestCostToStart > 0.0 and CostToStart >= BestCostToStart then
		    return neighbors
		  end if
		  
		  neighbors = super.Neighbors()
		  
		  var result() as M_Path.MilestoneInterface
		  
		  for each n as M_Path.GridSquare in neighbors
		    if Grid( n.Row, n.Column ) <> "#" then
		      var ms as new MazeSquare
		      n.CloneTo ms
		      result.Add M_Path.MilestoneInterface( ms )
		    end if
		  next
		  
		  return result
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Shared BestCostToStart As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		CostToStart As Double
	#tag EndProperty


	#tag Constant, Name = kCost, Type = Double, Dynamic = False, Default = \"1000.0", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="CostToParent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CostToEnd"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
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
	#tag EndViewBehavior
End Class
#tag EndClass
