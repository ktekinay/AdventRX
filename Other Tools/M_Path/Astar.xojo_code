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

	#tag Method, Flags = &h21
		Private Sub InsertIntoOpenList(node As M_Path.Node)
		  var score as double = node.Score
		  
		  var openList() as M_Path.Node = self.OpenList
		  
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
		Function Map(startPosition As M_Path.MilestoneInterface, goal As M_Path.MilestoneInterface) As MilestoneInterface()
		  var goalNode as new M_Path.Node( goal )
		  nodeMaster.Value( goalNode.Key ) = goalNode
		  
		  var startNode as new Node( startPosition )
		  NodeMaster.Value( startNode.Key ) = startNode
		  
		  OpenList.Add startNode
		  startNode.Status = Statuses.IsOpen
		  
		  var parentNode as M_Path.Node
		  
		  var foundIt as boolean
		  
		  while openList.Count <> 0
		    parentNode = OpenList.Pop
		    
		    parentNode.Status = Statuses.IsClosed
		    ClosedList.Value( parentNode.Key ) = parentNode
		    
		    if parentNode is goalNode then
		      foundIt = true
		      exit
		    end if
		    
		    var successors() as M_Path.Node = parentNode.GetSuccessors( nodeMaster )
		    for each n as M_Path.Node in successors
		      if n is parentNode.Parent then
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
		        InsertIntoOpenList n
		        n.Status = Statuses.IsOpen
		        
		      case Statuses.IsOpen
		        if n.DistanceFromStart > distanceFromStart then
		          n.Parent = parentNode
		          n.DistanceFromStart = distanceFromStart
		          n.Score = n.DistanceFromStart + n.DistanceToGoal
		          
		          var pos as integer = OpenList.IndexOf( n )
		          OpenList.RemoveAt pos
		          
		          InsertIntoOpenList n
		        end if
		        
		      case else // IsClosed
		        if n.DistanceFromStart > distanceFromStart then
		          ClosedList.Remove( n.Key )
		          InsertIntoOpenList n
		          
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
		    
		    trail.AddAt 0, startPosition
		  end if
		  
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
