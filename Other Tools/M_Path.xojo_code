#tag Module
Protected Module M_Path
	#tag Method, Flags = &h1
		Protected Function DiagnonalDistance(x1 As Double, y1 As Double, x2 As Double, y2 As Double) As Double
		  const kLengthOfNode as double = 1.0
		  static diagDistanceBetweenNodes as double = sqrt( 2.0 )
		  
		  var dx as double = abs( x1 - x2 )
		  var dy as double = abs( y1 - y2 )
		  
		  return _
		  kLengthOfNode * ( dx + dy ) + ( diagDistanceBetweenNodes - 2 * diagDistanceBetweenNodes ) * min( dx, dy )
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EuclideanDistance(x1 As Double, y1 As Double, x2 As Double, y2 As Double) As Double
		  return sqrt( ( x1 - x2 ) ^ 2.0 + ( y1 - y2 ) ^ 2.0 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ManhattanDistance(x1 As Double, y1 As Double, x2 As Double, y2 As Double) As Double
		  return abs( x1 - x2 ) + abs( y1 - y2 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 496E64656E746966792074686520626573742070617468206265747765656E20746865207374617274696E6720706F736974696F6E7320616E6420676F616C2E
		Protected Function Map(startPosition As M_Path.MilestoneInterface, goal As M_Path.MilestoneInterface) As MilestoneInterface()
		  var finder as new Astar
		  var trail() as M_Path.MilestoneInterface = finder.Map( startPosition, goal )
		  return trail
		  
		End Function
	#tag EndMethod


	#tag Enum, Name = Statuses, Type = Integer, Flags = &h21
		IsNew
		  IsOpen
		IsClosed
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
