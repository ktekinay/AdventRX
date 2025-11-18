#tag Class
Protected Class Advent_2019_12_03
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Find wire intersections"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Crossed Wires"
		  
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
		  var wires() as string = input.Split( EndOfLine )
		  
		  var paths0() as string = wires( 0 ).Split( "," )
		  var coords0() as Pair = ToCoords( paths0 )
		  
		  var paths1() as string = wires( 1 ).Split( "," )
		  var coords1() as Pair = ToCoords( paths1 )
		  
		  var intersections() as Xojo.Point = Intersections( coords0, coords1 )
		  
		  var bestDistance as integer = 10^8
		  
		  for each pt as Xojo.Point in intersections
		    var distance as integer = abs( Pt.X ) + abs( Pt.Y )
		    bestDistance = min( bestDistance, distance )
		  next
		  
		  return bestDistance : if( IsTest, 135, 2129 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var wires() as string = input.Split( EndOfLine )
		  
		  var paths0() as string = wires( 0 ).Split( "," )
		  var coords0() as Pair = ToCoords( paths0 )
		  
		  var paths1() as string = wires( 1 ).Split( "," )
		  var coords1() as Pair = ToCoords( paths1 )
		  
		  var intersections() as Xojo.Point = Intersections( coords0, coords1 )
		  
		  var bestSteps as integer = 10^8
		  
		  for each intersection as Xojo.Point in intersections
		    var steps0 as integer = StepsTo( intersection, coords0, bestSteps )
		    var steps1 as integer = StepsTo( intersection, coords1, bestSteps - steps0 )
		    
		    bestSteps = min( bestSteps, steps0 + steps1 )
		  next
		  
		  return bestSteps : if( IsTest, 610, 134662 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Intersections(coords0() As Pair, coords1() As Pair) As Xojo.Point()
		  var result() as Xojo.Point
		  
		  var coordsH0() as Pair 
		  var coordsV0() as Pair
		  
		  SplitCoords( coords0, coordsH0, coordsV0 )
		  
		  var coordsH1() As Pair 
		  var coordsV1() as Pair
		  
		  SplitCoords( coords1, coordsH1, coordsV1 )
		  
		  ToIntersections( coordsH0, coordsV1, result )
		  ToIntersections( coordsH1, coordsV0, result )
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function SortPoints(p1 As Xojo.Point, p2 As Xojo.Point) As Pair
		  if p1.X > p2.X or p1.Y > p2.Y then
		    return p2 : p1
		  else
		    return p1 : p2
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub SplitCoords(coords() As Pair, horizontal() As Pair, vertical() As Pair)
		  for each coord as Pair in coords
		    var p1 as Xojo.Point = coord.Left
		    var p2 as Xojo.Point = coord.Right
		    
		    var toAdd as Pair = SortPoints( p1, p2 )
		    
		    if p1.Y = p2.Y then
		      horizontal.Add toAdd
		    else
		      vertical.Add toAdd
		    end if
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function StepsTo(pt As Xojo.Point, coords() As Pair, target As Integer) As Integer
		  var distance as integer
		  
		  for each coord as Pair in coords
		    if distance >= target then
		      return target
		    end if
		    
		    var l as Xojo.Point = coord.Left
		    var r as Xojo.Point = coord.Right
		    
		    var sorted as Pair = SortPoints( l, r )
		    
		    var sl as Xojo.Point = sorted.Left
		    var sr as Xojo.Point = sorted.Right
		    
		    if sl.X = sr.X and sl.X = pt.X and sl.Y <= pt.Y and sr.Y >= pt.Y then
		      var diff as integer = abs( pt.Y - l.Y )
		      
		      distance = distance + diff
		      return distance
		      
		    elseif sl.Y = sr.Y and sl.Y = pt.Y and sl.X <= pt.X and sr.X >= pt.X then
		      var diff as integer = abs( pt.X - l.X )
		      
		      distance = distance + diff
		      return distance
		      
		    end if
		    
		    var diffx as integer = abs( r.X - l.X )
		    if diffx < 0 then
		      raise new RuntimeException
		    end if
		    
		    var diffy as integer = abs( r.Y - l.Y )
		    if diffy < 0 then
		      raise new RuntimeException
		    end if
		    
		    distance = distance + diffx + diffy
		  next
		  
		  raise new RuntimeException
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ToCoords(paths() As String) As Pair()
		  var coords() as Pair
		  
		  var lastCoord as new Xojo.Point( 0, 0 )
		  
		  for each path as string in paths
		    var direction as string = path.Left( 1 )
		    var distance as integer = path.Middle( 1 ).ToInteger
		    
		    var nextX as integer = lastCoord.X
		    var nextY as integer = lastCoord.Y
		    
		    select case direction
		    case "U"
		      nextY = nextY - distance
		    case "D"
		      nextY = nextY + distance
		    case "L"
		      nextX = nextX - distance
		    case "R"
		      nextX = nextX + distance
		    case else
		      raise new RuntimeException
		    end select
		    
		    var nextCoord as new Xojo.Point( nextX, nextY )
		    
		    coords.Add lastCoord : nextCoord
		    lastCoord = nextCoord
		  next
		  
		  return coords
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub ToIntersections(horiz() As Pair, vert() As Pair, intersections() As Xojo.Point)
		  for each c0 as Pair in horiz
		    var c0L as Xojo.Point = c0.Left
		    var c0R as Xojo.Point = c0.Right
		    
		    var hx0 as integer = c0L.X
		    var hx1 as integer = c0R.X
		    var hy as integer = c0L.Y
		    
		    for each c1 as Pair in vert
		      var c1U as Xojo.Point = c1.Left
		      var c1D as Xojo.Point = c1.Right
		      
		      var vy0 as integer = c1U.Y
		      var vy1 as integer = c1D.Y
		      var vx as integer = c1U.X
		      
		      if not ( vx = 0 and hy = 0 ) and _
		        vx >= hx0 and vx <= hx1 and _
		        hy >= vy0 and hy <= vy1 then
		        intersections.Add new Xojo.Point( vx, hy )
		      end if
		    next
		  next
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"R98\x2CU47\x2CR26\x2CD63\x2CR33\x2CU87\x2CL62\x2CD20\x2CR33\x2CU53\x2CR51\nU98\x2CR91\x2CD20\x2CR16\x2CD67\x2CR40\x2CU7\x2CR15\x2CU6\x2CR7", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"R75\x2CD30\x2CR83\x2CU83\x2CL12\x2CD49\x2CR71\x2CU7\x2CL72\nU62\x2CR66\x2CU55\x2CR34\x2CD71\x2CR55\x2CD58\x2CR83", Scope = Private
	#tag EndConstant


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
