#tag Class
Class PathFinder_MTC
	#tag Method, Flags = &h0
		Sub Constructor(goal As M_Path.MilestoneInterface)
		  NodeMaster = new Dictionary
		  
		  GoalNode = new M_Path.Node( goal )
		  nodeMaster.Value( goalNode.Key ) = GoalNode
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  for each n as M_Path.Node in NodeMaster.Values
		    n.ClearSuccessors
		    n.Milestone = nil
		    n.Parent = nil
		    n.Key = nil
		  next
		  
		  NodeMaster = nil
		  GoalNode = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E64656E746966792074686520626573742070617468206265747765656E20746865207374617274696E6720706F736974696F6E7320616E6420676F616C2E
		Function Map(startPosition As M_Path.MilestoneInterface) As M_Path.Result
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  var result as new M_Path.Result
		  
		  var startNode as M_Path.Node = NodeMaster.Lookup( startPosition.GetKey, nil )
		  if startNode is nil then
		    startNode = new M_Path.Node( startPosition )
		    NodeMaster.Value( startNode.Key ) = startNode
		  end if
		  
		  if startNode.Status = Statuses.IsDeadEnd then
		    result.Touched.Value( startPosition ) = nil
		    return result
		  end if
		  
		  var closedList as new Dictionary
		  var openList as new PriorityQueue_MTC
		  
		  //
		  // Reset the known nodes
		  //
		  for each node as M_Path.Node in NodeMaster.Values
		    if node.Status <> Statuses.IsDeadEnd then
		      node.Parent = nil
		      node.Status = Statuses.IsReset
		      node.DistanceFromStart = 0
		      node.Score = 0
		    end if
		  next
		  
		  GoalNode.Status = Statuses.IsOpen
		  var goal as M_Path.MilestoneInterface = GoalNode.Milestone
		  
		  startNode.Status = Statuses.IsOpen
		  startNode.DistanceFromStart = 0
		  startNode.DistanceToGoal = startPosition.DistanceToGoal( goal )
		  startNode.Score = startNode.DistanceToGoal
		  openList.Add startNode.Score, startNode
		  
		  var parentNode as M_Path.Node
		  
		  var foundIt as boolean
		  
		  while openList.Count <> 0
		    parentNode = OpenList.Pop
		    
		    parentNode.Status = Statuses.IsClosed
		    closedList.Value( parentNode.Key ) = parentNode
		    
		    if parentNode is goalNode then
		      foundIt = true
		      exit while
		    end if
		    
		    var successors() as M_Path.Node = parentNode.GetSuccessors( nodeMaster )
		    for each n as M_Path.Node in successors
		      if n is parentNode.Parent or n is startNode then
		        continue
		      end if
		      
		      if n is GoalNode then
		        foundIt = true
		        n.Parent = parentNode
		        parentNode = n
		        exit while
		      end if
		      
		      if n.DistanceFromStart <> 0 and n.DistanceFromStart <= parentNode.DistanceFromStart then
		        //
		        // Do nothing
		        //
		        continue
		      end if
		      
		      var distanceFromStart as double = n.Milestone.DistanceFromParent( parentNode.Milestone ) + parentNode.DistanceFromStart
		      
		      select case n.Status
		      case Statuses.IsNew
		        n.Parent = parentNode
		        n.DistanceFromStart = distanceFromStart
		        n.DistanceToGoal = n.Milestone.DistanceToGoal( goal )
		        n.Score = n.DistanceFromStart + n.DistanceToGoal
		        openList.Add n.Score, n
		        n.Status = Statuses.IsOpen
		        
		      case Statuses.IsReset
		        n.Parent = parentNode
		        n.DistanceFromStart = distanceFromStart
		        if n.DistanceToGoal = 0 then
		          n.DistanceToGoal = n.Milestone.DistanceToGoal( goal )
		        end if
		        n.Score = n.DistanceFromStart + n.DistanceToGoal
		        openList.Add n.Score, n
		        n.Status = Statuses.IsOpen
		        
		      case Statuses.IsOpen
		        if n.DistanceFromStart > distanceFromStart then
		          n.Parent = parentNode
		          n.DistanceFromStart = distanceFromStart
		          n.Score = n.DistanceFromStart + n.DistanceToGoal
		          
		          openList.Add n.Score, n
		        end if
		        
		      case Statuses.IsDeadEnd
		        //
		        // Do nothing
		        //
		        
		      case else // IsClosed
		        if n.DistanceFromStart > distanceFromStart then
		          ClosedList.Remove( n.Key )
		          openList.Add n.Score, n
		          
		          n.Parent = parentNode
		          n.DistanceFromStart = distanceFromStart
		          n.Score = n.DistanceFromStart + n.DistanceToGoal
		          n.Status = Statuses.IsOpen
		        end if
		        
		      end select
		      
		    next
		  wend
		  
		  var trail() as MilestoneInterface
		  
		  if foundIt then
		    while not ( parentNode is startNode )
		      trail.AddAt 0, parentNode.Milestone
		      parentNode = parentNode.Parent
		    wend
		    
		    trail.AddAt 0, startNode.Milestone
		  end if
		  
		  result.Trail = trail
		  result.Touched = new Dictionary
		  
		  //
		  // If there was no trail found, every item in the Closed list is a dead end
		  //
		  var setStatus as Statuses = if( foundIt, Statuses.IsClosed, Statuses.IsDeadEnd )
		  for each m as M_Path.Node in ClosedList.Values
		    result.Touched.Value( m.Milestone ) = nil
		    if m.Status <> Statuses.IsDeadEnd then
		      m.Status = setStatus
		    end if
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private GoalNode As M_Path.Node
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NodeMaster As Dictionary
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
