#tag Class
Protected Class TreeGridMember
Inherits GridMember
Implements M_Path.MilestoneInterface
	#tag Method, Flags = &h0
		Function DistanceFromParent(parent As M_Path.MilestoneInterface) As Double
		  return 1.0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistanceToGoal(goal As M_Path.MilestoneInterface) As Double
		  var g as TreeGridMember = TreeGridMember( goal )
		  return M_Path.ManhattanDistance( Column, Row, g.Column, g.Row )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetKey() As Variant
		  return self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Successors() As M_Path.MilestoneInterface()
		  var arr() as M_Path.MilestoneInterface
		  
		  for each n as GridMember in Neighbors( false )
		    if ( n.Value - Value ) <= 1 then
		      arr.Add TreeGridMember( n )
		    end if
		  next
		  
		  return arr
		  
		  
		End Function
	#tag EndMethod


End Class
#tag EndClass
