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
		  next
		  
		  NodeMaster = nil
		  GoalNode = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InsertIntoOpenList(node As M_Path.Node, openList() As M_Path.Node)
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  var score as double = node.Score
		  
		  var startIndex as integer = 0
		  var endIndex as integer = openList.LastIndex
		  
		  while startIndex <= endIndex
		    var index as integer = ( endIndex - startIndex ) \ 2 + startIndex
		    
		    var candidate as M_Path.Node = openList( index )
		    var candidateScore as double = candidate.Score
		    
		    select case score
		    case is = candidateScore
		      openList.AddAt index + 1, node
		      return
		      
		    case is < candidateScore
		      startIndex = index + 1
		      
		    case else
		      endIndex = index - 1
		      
		    end select
		    
		  wend
		  
		  openList.AddAt startIndex, node
		  
		  
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
		  var openList() as M_Path.Node
		  
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
		  
		  openList.Add startNode
		  startNode.Status = Statuses.IsOpen
		  startNode.Score = 0
		  startNode.DistanceFromStart = 0
		  startNode.DistanceToGoal = 0
		  
		  var parentNode as M_Path.Node
		  
		  var foundIt as boolean
		  
		  while openList.Count <> 0
		    parentNode = OpenList.Pop
		    
		    parentNode.Status = Statuses.IsClosed
		    closedList.Value( parentNode.Key ) = parentNode
		    
		    if parentNode is goalNode then
		      foundIt = true
		      exit
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
		      
		      var distanceFromStart as double = n.Milestone.DistanceFromParent( parentNode.Milestone ) + parentNode.DistanceFromStart
		      
		      select case n.Status
		      case Statuses.IsNew
		        n.Parent = parentNode
		        n.DistanceFromStart = distanceFromStart
		        n.DistanceToGoal = n.Milestone.DistanceToGoal( goal )
		        n.Score = n.DistanceFromStart + n.DistanceToGoal
		        InsertIntoOpenList n, openList
		        n.Status = Statuses.IsOpen
		        
		      case Statuses.IsReset
		        n.Parent = parentNode
		        n.DistanceFromStart = distanceFromStart
		        if n.DistanceToGoal = 0 then
		          n.DistanceToGoal = n.Milestone.DistanceToGoal( goal )
		        end if
		        n.Score = n.DistanceFromStart + n.DistanceToGoal
		        InsertIntoOpenList n, openList
		        n.Status = Statuses.IsOpen
		        
		      case Statuses.IsOpen
		        if n.DistanceFromStart > distanceFromStart then
		          n.Parent = parentNode
		          n.DistanceFromStart = distanceFromStart
		          n.Score = n.DistanceFromStart + n.DistanceToGoal
		          
		          var pos as integer = OpenList.IndexOf( n )
		          OpenList.RemoveAt pos
		          
		          InsertIntoOpenList n, openList
		        end if
		        
		      case Statuses.IsDeadEnd
		        //
		        // Do nothing
		        //
		        
		      case else // IsClosed
		        if n.DistanceFromStart > distanceFromStart then
		          ClosedList.Remove( n.Key )
		          InsertIntoOpenList n, openList
		          
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
		    var nodes() as M_Path.Node
		    
		    while not ( parentNode is startNode )
		      nodes.AddAt 0, parentNode
		      parentNode = parentNode.Parent
		    wend
		    
		    nodes.AddAt 0, startNode
		    
		    //
		    // Nodes now has the complete trail in order
		    //
		    trail.ResizeTo nodes.LastIndex
		    for i as integer = 0 to nodes.LastIndex
		      var n as M_Path.Node = nodes( i )
		      
		      trail( i ) = n.Milestone
		    next
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
