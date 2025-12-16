#tag Class
Protected Class Advent_2025_12_09
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Find largest rectangle given points"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Movie Theater"
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Variant
		  return CalculateResultA( Normalize( GetPuzzleInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Variant
		  return CalculateResultB( Normalize( GetPuzzleInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Variant
		  if kTestInput <> "" then
		    return CalculateResultA( Normalize( kTestInput ) )
		  end if
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  if input <> "" then
		    return CalculateResultB( Normalize( input ) )
		  end if
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  var points() as Xojo.Point = ToPointArray( input )
		  
		  var maxArea as integer
		  
		  for i1 as integer = 0 to points.LastIndex - 1
		    var pt1 as Xojo.Point = points( i1 )
		    for i2 as integer = i1 + 1 to points.LastIndex
		      var pt2 as Xojo.Point = points( i2 )
		      var area as integer = ( abs( pt1.X - pt2.X ) + 1 ) * ( abs( pt1.Y - pt2.Y ) + 1 )
		      if area > maxArea then
		        maxArea = area
		      end if
		    next
		  next
		  
		  var testAnswer as variant = 50
		  var answer as variant = 4741451444
		  
		  return maxArea : if( IsTest, testAnswer, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		  #endif
		  #pragma BoundsChecking false
		  #pragma NilObjectChecking false
		  #pragma StackOverflowChecking false
		  
		  var points() as Xojo.Point = ToPointArray( input )
		  
		  var path as new GraphicsPath
		  
		  var lastPoint as Xojo.Point = points( points.LastIndex )
		  
		  path.MoveToPoint lastPoint.X, lastPoint.Y
		  
		  for each pt as Xojo.Point in points
		    path.AddLineToPoint pt.X, pt.Y
		  next
		  
		  
		  var allPoints() as Pair
		  
		  for i1 as integer = 0 to points.LastIndex - 1
		    var pt1 as Xojo.Point = points( i1 )
		    
		    for i2 as integer = i1 + 1 to points.LastIndex
		      var pt2 as Xojo.Point = points( i2 )
		      
		      var area as integer = ( abs( pt1.X - pt2.X ) + 1 ) * ( abs( pt1.Y - pt2.Y ) + 1 )
		      
		      allPoints.Add area : new Pair( pt1, pt2 )
		    next
		  next
		  
		  allPoints.Sort AddressOf Sorter
		  
		  
		  var maxArea as integer
		  
		  var topLeft as Xojo.Point
		  var topRight as Xojo.Point
		  var bottomLeft as Xojo.Point
		  var bottomRight as Xojo.Point
		  
		  for each p as Pair in allPoints
		    var area as integer = p.Left.IntegerValue
		    var thesePoints as Pair = p.Right
		    
		    var pt1 as Xojo.Point = thesePoints.Left
		    var pt2 as Xojo.Point = thesePoints.Right
		    
		    PointsToCorners( pt1, pt2, topLeft, topRight, bottomLeft, bottomRight )
		    
		    for each otherPoint as Xojo.Point in points
		      if otherPoint.X > topLeft.X and otherPoint.X < topRight.X and _
		        otherPoint.Y > topLeft.Y and otherPoint.Y < bottomLeft.Y then
		        continue for p
		      end if
		    next
		    
		    const kDivisor as integer = 60
		    
		    var xDiff as integer = topRight.X - topLeft.X
		    var yDiff as integer = bottomRight.Y - topRight.Y
		    
		    var xStep as integer = max( xDiff \ kDivisor, 1 )
		    var yStep as integer = max( yDiff \ kDivisor, 1 )
		    
		    for x as integer =  topLeft.X to topRight.X step xStep
		      for y as integer = topRight.Y to bottomRight.Y step yStep
		        if not path.Contains( x, y ) then
		          continue for p
		        end if
		      next
		    next
		    
		    maxArea = area
		    exit
		  next
		  
		  var testAnswer as variant = 24
		  var answer as variant = 1562459680
		  
		  return maxArea : if( IsTest, testAnswer, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub PointsToCorners(pt1 As Xojo.Point, pt2 As Xojo.Point, ByRef topLeft As Xojo.Point, ByRef topRight As Xojo.Point, ByRef bottomLeft As Xojo.Point, ByRef bottomRight As Xojo.Point)
		  var temp as Xojo.Point
		  
		  if pt1.Y > pt2.Y then
		    temp = pt1
		    pt1 = pt2
		    pt2 = temp
		  end if
		  
		  if pt1.X <= pt2.X then
		    topLeft = pt1
		    bottomRight = pt2
		    
		    topRight = new Xojo.Point( bottomRight.X, topLeft.Y )
		    bottomLeft = new Xojo.Point( topLeft.X, bottomRight.Y )
		    
		  else
		    topRight = pt1
		    bottomLeft = pt2
		    
		    topLeft = new Xojo.Point( bottomLeft.X, topRight.Y )
		    bottomRight = new Xojo.Point( topRight.X, bottomLeft.Y )
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Sorter(p1 As Pair, p2 As Pair) As Integer
		  return p2.Left.IntegerValue - p1.Left.IntegerValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ToPointArray(input As String) As Xojo.Point()
		  var points() as Xojo.Point
		  
		  var rows() as string = ToStringArray( input )
		  
		  for each row as string in rows
		    var parts() as string = row.Split( "," )
		    var pt as new Xojo.Point( parts( 0 ).ToInteger, parts( 1 ).ToInteger )
		    points.Add pt
		  next
		  
		  return points
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"7\x2C1\n11\x2C1\n11\x2C7\n9\x2C7\n9\x2C5\n2\x2C5\n2\x2C3\n7\x2C3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2025
	#tag EndUsing


	#tag ViewBehavior
		#tag ViewProperty
			Name="Type"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Cooperative"
				"1 - Preemptive"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsComplete"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadState"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ThreadStates"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Paused"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
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
	#tag EndViewBehavior
End Class
#tag EndClass
