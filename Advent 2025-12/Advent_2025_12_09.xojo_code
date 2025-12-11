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
		  return false
		  
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
		Private Shared Sub AllPoints(pt1 As Xojo.Point, pt2 As Xojo.Point, ByRef topLeft As Xojo.Point, ByRef topRight As Xojo.Point, ByRef bottomLeft As Xojo.Point, ByRef bottomRight As Xojo.Point)
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
		Private Function CalculateResultA(input As String) As Variant
		  var points() as Xojo.Point = ToPointArray( input )
		  
		  var maxArea as integer
		  
		  for i1 as integer = 0 to points.LastIndex - 1
		    var pt1 as Xojo.Point = points( i1 )
		    for i2 as integer = i1 + 1 to points.LastIndex
		      var pt2 as Xojo.Point = points( i2 )
		      var area as integer = ( abs( pt1.X - pt2.X ) + 1 ) * ( abs( pt1.Y - pt2.Y ) + 1 )
		      maxArea = max( maxArea, area )
		    next
		  next
		  
		  var testAnswer as variant = 50
		  var answer as variant = 4741451444
		  
		  return maxArea : if( IsTest, testAnswer, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var points() as Xojo.Point = ToPointArray( input )
		  
		  var firstIndex as integer
		  var firstPoint as Xojo.Point = points( 0 )
		  
		  for i as integer = 1 to points.LastIndex
		    var pt as Xojo.Point = points( i )
		    
		    if pt.X <= firstPoint.X and pt.Y <= firstPoint.Y then
		      firstIndex = i
		      firstPoint = pt
		    end if
		  next
		  
		  if firstIndex <> 0 then
		    var newPoints() as Xojo.Point
		    
		    for i as integer = 0 to points.LastIndex
		      var newIndex as integer = ( firstIndex + i ) mod points.Count
		      newPoints.Add points( newIndex )
		    next
		    
		    points = newPoints
		  end if
		  
		  return 0
		  
		  var areas() as Xojo.Rect
		  
		  for i1 as integer = 0 to points.LastIndex
		    var i2 as integer = ( i1 + 1 ) mod points.Count
		    var i3 as integer = ( i1 + 2 ) mod points.Count
		    
		    areas.Add CompleteRect( points( i1 ), points( i2 ), points( i3 ))
		  next
		  
		  var maxArea as integer
		  
		  var topLeft as Xojo.Point
		  var topRight as Xojo.Point
		  var bottomLeft as Xojo.Point
		  var bottomRight as Xojo.Point
		  
		  for i1 as integer = 0 to points.LastIndex - 1
		    var pt1 as Xojo.Point = points( i1 )
		    for i2 as integer = i1 + 1 to points.LastIndex
		      var pt2 as Xojo.Point = points( i2 )
		      var area as integer = ( abs( pt1.X - pt2.X ) + 1 ) * ( abs( pt1.Y - pt2.Y ) + 1 )
		      
		      if area <= maxArea then
		        continue
		      end if
		      
		      AllPoints( pt1, pt2, topLeft, topRight, bottomLeft, bottomRight )
		      var rect as new Xojo.Rect( topLeft.X, topLeft.Y, topRight.X - topLeft.X, bottomRight.Y - topRight.Y )
		      
		      if area = 40 then
		        area = area
		      end if
		    next
		  next
		  
		  var testAnswer as variant = 24
		  var answer as variant = 0
		  
		  return maxArea : if( IsTest, testAnswer, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CompleteRect(pt1 As Xojo.Point, pt2 As Xojo.Point, pt3 As Xojo.Point) As Xojo.Rect
		  var topLeft as Xojo.Point
		  var topRight as Xojo.Point
		  var bottomLeft as Xojo.Point
		  var bottomRight as Xojo.Point
		  
		  if pt1.X < pt2.X and pt1.Y = pt2.Y and pt3.X = pt2.X and pt3.Y > pt2.Y then
		    topLeft = pt1
		    topRight = pt2
		    bottomRight = pt3
		    bottomLeft = new Xojo.Point( topLeft.X, bottomRight.Y )
		    
		  elseif pt1.Y < pt2.Y and pt1.X = pt2.X and pt3.X < pt2.X and pt3.Y = pt2.Y then
		    topRight = pt1
		    bottomRight = pt2
		    bottomLeft = pt3
		    topLeft = new Xojo.Point( bottomLeft.X, topRight.Y )
		    
		  elseif pt1.X > pt2.X and pt1.Y = pt2.Y and pt3.Y < pt2.Y and pt3.X = pt2.X then
		    bottomRight = pt1
		    bottomLeft = pt2
		    topLeft = pt3
		    topRight = new Xojo.Point( bottomRight.X, topLeft.Y )
		    
		  elseif pt1.X = pt2.X and pt1.Y > pt2.Y and pt3.X > pt2.X and pt3.Y = pt2.Y then
		    bottomLeft = pt1
		    topLeft = pt2
		    topRight = pt3
		    bottomRight = new Xojo.Point( topRight.X, bottomLeft.Y )
		    
		  elseif pt1.X < pt2.X and pt1.Y = pt2.Y and pt3.Y < pt2.Y and pt3.X = pt2.X then
		    bottomLeft = pt1
		    bottomRight = pt2
		    topRight = pt3
		    topLeft = new Xojo.Point( bottomLeft.X, topRight.Y )
		    
		  elseif pt1.Y > pt2.Y and pt1.X = pt2.X and pt3.Y = pt2.Y and pt3.X < pt2.X then
		    bottomRight = pt1
		    topRight = pt2
		    topLeft = pt3
		    bottomLeft = new Xojo.Point( topLeft.X, bottomRight.Y )
		    
		  else
		    break
		    
		  end if
		  
		  return new Xojo.Rect( topLeft.X, topLeft.Y, bottomRight.X - bottomLeft.X, bottomLeft.Y - topLeft.Y )
		  
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
