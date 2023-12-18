#tag Module
Protected Module M_Path
	#tag Method, Flags = &h1
		Protected Function DiagnonalDistance(x1 As Double, y1 As Double, x2 As Double, y2 As Double) As Double
		  const kLengthOfNode as double = 1.0
		  static diagDistanceBetweenNodes as double = sqrt( 2.0 )
		  
		  var dx as double = abs( x1 - x2 )
		  var dy as double = abs( y1 - y2 )
		  
		  return _
		  kLengthOfNode * ( dx + dy ) + ( diagDistanceBetweenNodes - 2 * diagDistanceBetweenNodes ) * if( dx < dy, dx, dy )
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EuclideanDistance(x1 As Double, y1 As Double, x2 As Double, y2 As Double) As Double
		  return sqrt( ( x1 - x2 ) ^ 2.0 + ( y1 - y2 ) ^ 2.0 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindPath(goal As MilestoneInterface, start As MilestoneInterface) As M_Path.Result
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  var result as new M_Path.Result
		  
		  var startKey as variant = start.GetKey
		  var goalKey as variant = goal.GetKey
		  
		  if startKey = goalKey then
		    result.Trail.Add goal
		    return result
		  end if
		  
		  var queue as new PriorityQueue_MTC
		  var costDict as new Dictionary
		  var trailDict as new Dictionary
		  var neighborDict as new Dictionary
		  
		  var currentCost as CostStructure
		  currentCost.ToGoal = start.DistanceToGoal( goal )
		  currentCost.Total = currentCost.ToGoal
		  
		  costDict.Value( startKey ) = currentCost
		  
		  queue.Add currentCost.Total, start
		  
		  while queue.Count <> 0
		    var current as MilestoneInterface = queue.Pop
		    var currentKey as variant = current.GetKey
		    
		    if currentKey = goalKey then
		      //
		      // Backtrack!
		      //
		      var trail() as MilestoneInterface
		      do
		        trail.Add current
		        current = trailDict.Lookup( currentKey, nil )
		        currentKey = current.GetKey
		      loop until currentKey = startKey
		      
		      trail.Add start
		      
		      result.Trail.ResizeTo trail.LastIndex
		      
		      var addIndex as integer = -1
		      for i as integer = trail.LastIndex downto 0
		        addIndex = addIndex + 1
		        result.Trail( addIndex ) = trail( i )
		      next
		      
		      return result
		    end if
		    
		    currentCost = costDict.Value( currentKey )
		    var neighbors() as MilestoneInterface 
		    if neighborDict.HasKey( currentKey ) then
		      neighbors = neighborDict.Value( currentKey )
		    else
		      neighbors = current.Successors
		      neighborDict.Value( currentKey ) = neighbors
		    end if
		    
		    for each neighbor as MilestoneInterface in neighbors
		      var neighborKey as variant = neighbor.GetKey
		      
		      var neighborCost as CostStructure
		      neighborCost = CostDict.Lookup( neighborKey, neighborCost )
		      
		      var newToStart as double = neighbor.DistanceFromParent( current ) + currentCost.ToStart
		      
		      if neighborCost.Total <> 0 and neighborCost.ToStart <= newToStart then
		        continue
		      end if
		      
		      neighborCost.ToStart = newToStart
		      neighborCost.ToGoal = neighbor.DistanceToGoal( goal )
		      neighborCost.Total = neighborCost.ToStart + neighborCost.ToGoal
		      costDict.Value( neighborKey ) = neighborCost
		      
		      trailDict.Value( neighborKey ) = current
		      neighbor.SetParent current
		      queue.Add neighborCost.Total, neighbor
		    next
		  wend
		  
		  //
		  // If we get here, there is no path
		  //
		  var seen() as variant = trailDict.Values
		  result.Touched = new Dictionary
		  for each m as MilestoneInterface in seen
		    result.Touched.Value( m ) = nil
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ManhattanDistance(x1 As Double, y1 As Double, x2 As Double, y2 As Double) As Double
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  return abs( x1 - x2 ) + abs( y1 - y2 )
		  
		End Function
	#tag EndMethod


	#tag Structure, Name = CostStructure, Flags = &h21
		ToGoal As Double
		  ToStart As Double
		Total As Double
	#tag EndStructure


	#tag Enum, Name = Statuses, Type = Integer, Flags = &h21
		IsNew
		  IsOpen
		  IsClosed
		  IsReset
		IsDeadEnd
	#tag EndEnum


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
End Module
#tag EndModule
