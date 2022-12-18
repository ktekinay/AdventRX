#tag Class
Private Class Astar
	#tag Method, Flags = &h0
		Sub Constructor()
		  NodeMaster = new Dictionary
		  ClosedList = new Dictionary
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  for each n as M_Path.Node in NodeMaster.Values
		    n.ClearSuccessors
		    n.Milestone = nil
		    n.Parent = nil
		  next
		  
		  OpenList.RemoveAll
		  ClosedList = nil
		  NodeMaster = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E64656E746966792074686520626573742070617468206265747765656E20746865207374617274696E6720706F736974696F6E7320616E6420676F616C2E
		Function Map(startPosition As M_Path.MilestoneInterface, goal As M_Path.MilestoneInterface) As MilestoneInterface()
		  var startNode as new Node( startPosition )
		  OpenList.Add startNode
		  
		  startNode.Status = Statuses.IsOpen
		  
		  NodeMaster.Value( startNode.Key ) = startNode
		  
		  var thisNode as M_Path.Node
		  
		  while openList.Count <> 0
		    thisNode = openList.Pop
		    thisNode.Status = Statuses.IsClosed
		    ClosedList.Value( thisNode.Key ) = thisNode
		    
		    if thisNode is goal then
		      exit
		    end if
		    
		    var successors() as M_Path.Node = thisNode.GetSuccessors( nodeMaster )
		    for each n as M_Path.Node in successors
		      var g as double = n.Milestone.DistanceFromParent( thisNode.Milestone ) + thisNode.DistanceFromStart
		      
		      select case n.Status
		      case Statuses.IsNew
		        n.Parent = thisNode
		        n.DistanceFromStart = g
		        n.DistanceToGoal = n.Milestone.DistanceToGoal( goal )
		        OpenList.Add n
		        n.Status = Statuses.IsOpen
		        
		      case Statuses.IsOpen
		        if n.DistanceFromStart >= g then
		          n.Parent = thisNode
		          n.DistanceFromStart = g
		        end if
		        
		      case else // IsClosed
		        if n.DistanceFromStart > g then
		          ClosedList.Remove( n.Key )
		          OpenList.Add n
		          n.Parent = thisNode
		          n.DistanceFromStart = g
		          n.Status = Statuses.IsOpen
		        end if
		        
		      end select
		      
		    next
		    
		    openList.Sort AddressOf SortByScoreReverse
		  wend
		  
		  var trail() as MilestoneInterface
		  
		  while not ( thisNode is startNode )
		    trail.AddAt 0, thisNode.Milestone
		    thisNode = thisNode.Parent
		  wend
		  
		  trail.AddAt 0, startPosition
		  
		  return trail
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ClosedList As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NodeMaster As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private OpenList() As M_Path.Node
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
