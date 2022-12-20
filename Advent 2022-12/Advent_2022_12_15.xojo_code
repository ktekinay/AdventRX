#tag Class
Protected Class Advent_2022_12_15
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Unknown"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return false
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return ""
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( Normalize( GetPuzzleInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( Normalize( GetPuzzleInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  return CalculateResultB( Normalize( input ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var sensors() as Sensor = ParseInput( input )
		  
		  var row as integer = if( IsTest, 10, 2000000 )
		  
		  var count as integer
		  
		  var minXs() as integer
		  var maxXs() as integer
		  var goodSensors() as Sensor
		  
		  FilterForRow row, sensors, goodSensors, minXs, maxXs
		  
		  var occupied as new Dictionary
		  
		  for each s as Sensor in goodSensors
		    if s.Y = row then
		      occupied.Value( s.X ) = s
		    end if
		    if s.Beacon.Y = row then
		      occupied.Value( s.Beacon.X ) = s
		    end if
		  next
		  
		  count = count - occupied.KeyCount
		  
		  for i as integer = 0 to minXs.LastIndex
		    var minX as integer = minXs( i )
		    var maxX as integer = maxXs( i )
		    
		    var scount as integer = maxX - minX + 1
		    
		    count = count + scount
		  next
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  const kMult as integer = 4000000
		  
		  var maxRow as integer = if( IsTest, 20, kMult )
		  
		  var sensors() as Sensor = ParseInput( input )
		  
		  var minXs() as integer
		  var maxXs() as integer
		  var goodSensors() as Sensor
		  
		  var emptyX as integer
		  var emptyY as integer
		  
		  for row as integer = 0 to maxRow
		    FilterForRow row, sensors, goodSensors, minXs, maxXs
		    
		    if minXs.Count = 0 then
		      break
		    end if
		    
		    var minX as integer = max( 0, minXs( 0 ) )
		    var maxX as integer = min( maxRow, maxXs( maxXs.LastIndex ) )
		    
		    if minXs.Count = 1 and minX = 0 and maxX = maxRow then
		      continue
		    end if
		    
		    var occupied as new Dictionary
		    for each s as Sensor in goodSensors
		      if s.Y = row then
		        occupied.Value( s.X ) = nil
		      end if
		      if s.Beacon.Y = row then
		        occupied.Value( s.Beacon.X ) = nil
		      end if
		    next
		    
		    if minXs.Count = 1 then
		      emptyY = row
		      
		      if minX > 0 then
		        emptyX = 0
		        
		      else
		        emptyX = maxRow
		      end if
		      
		      if occupied.HasKey( emptyX ) then
		        continue
		      end if
		      
		    else
		      emptyY = row
		      
		      for i as integer = 1 to minXs.LastIndex
		        emptyX = minXs( i ) - 1
		        if not occupied.HasKey( emptyX ) then
		          exit
		        end if
		      next
		      
		    end if
		    
		    exit
		  next
		  
		  var result as integer = emptyX * kMult + emptyY
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FilterForRow(row As Integer, sensors() As Sensor, goodSensors() As Sensor, minXs() As Integer, maxXs() As Integer)
		  goodSensors.RemoveAll
		  minXs.RemoveAll
		  maxXs.RemoveAll
		  
		  for each s as Sensor in sensors
		    if row < s.MinY or row > s.MaxY then
		      continue
		    end if
		    
		    var minX as integer = s.MinXForRow( row )
		    var maxX as integer = s.MaxXForRow( row )
		    
		    if minX > maxX then
		      continue
		    end if
		    
		    minXs.Add minX
		    maxXs.Add maxX
		    goodSensors.Add s
		  next
		  
		  minXs.SortWith maxXs, goodSensors
		  
		  var wasOverlap as boolean = true
		  while wasOverlap
		    wasOverlap = false
		    
		    //
		    // Check for overlap
		    //
		    for outer as integer = minXs.LastIndex downto 1
		      var oMinX as integer = minXs( outer )
		      var oMaxX as integer = maxXs( outer )
		      var oLen as integer = oMaxX - oMinX + 1
		      
		      for inner as integer = outer - 1 downto 0
		        var iMinX as integer = minXs( inner )
		        var iMaxX as integer = maxXs( inner )
		        var iLen as integer = iMaxX - iMinX + 1
		        
		        if iMinX > iMaxX then
		          continue
		        end if
		        
		        var overlaps as boolean = ( oMinX <= iMinX and oMaxX >= iMinX ) or _
		        ( iMinX <= oMinX and iMaxX >= oMinX )
		        
		        if not overlaps then
		          continue
		        end if
		        
		        wasOverlap = true
		        
		        if oMinX = iMinX and oLen = iLen then
		          oMaxX = oMinX - 1
		        elseif oMinX <= iMinX and oMaxX >= iMaxX then
		          iMaxX = iMinX - 1
		        elseif iMinX <= oMinX and iMaxX >= oMaxX then
		          oMaxX = oMinX - 1
		        elseif oMinX <= iMinX then
		          oMaxX = iMinX - 1
		        elseif iMinX <= oMinX then
		          iMaxX = oMinX - 1
		        else
		          break
		        end if
		        
		        minXs( inner ) = iMinX
		        maxXs( inner ) = iMaxX
		        
		        if iMinX > iMaxX then
		          exit for inner
		        end if
		      next
		      
		      minXs( outer ) = oMinX
		      maxXs( outer ) = oMaxX
		    next
		    
		    minXs.SortWith maxXs
		    
		    for i as integer = minXs.LastIndex downto 0
		      var minX as integer = minXs( i )
		      var maxX as integer = maxXs( i )
		      
		      if maxX < minX then
		        minXs.RemoveAt i
		        maxXs.RemoveAt i
		      end if
		    next
		    
		    for i as integer = minXs.LastIndex downto 1
		      var minX as integer = minXs( i )
		      var pmaxX as integer = maxXs( i - 1 )
		      
		      if minX = ( pMaxX + 1 ) then
		        maxXs( i - 1 ) = maxXs( i )
		        minXs.RemoveAt i
		        maxXs.RemoveAt i
		      end if
		    next
		  wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As Sensor()
		  var rx as new RegEx
		  rx.SearchPattern = "^Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)"
		  
		  var result() as Sensor
		  var index as integer = -1
		  
		  var match as RegExMatch = rx.Search( input )
		  while match isa object
		    
		    var spt as new Sensor( match.SubExpressionString( 1 ).ToInteger, match.SubExpressionString( 2 ).ToInteger )
		    
		    var bpt as new Xojo.Point( match.SubExpressionString( 3 ).ToInteger, match.SubExpressionString( 4 ).ToInteger )
		    spt.Beacon = bpt
		    
		    index = index + 1
		    spt.Index = index
		    
		    result.Add spt
		    
		    match = rx.Search
		  wend
		  
		  return result
		   
		  
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kKeyFactor, Type = Double, Dynamic = False, Default = \"100000000.0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Sensor at x\x3D2\x2C y\x3D18: closest beacon is at x\x3D-2\x2C y\x3D15\nSensor at x\x3D9\x2C y\x3D16: closest beacon is at x\x3D10\x2C y\x3D16\nSensor at x\x3D13\x2C y\x3D2: closest beacon is at x\x3D15\x2C y\x3D3\nSensor at x\x3D12\x2C y\x3D14: closest beacon is at x\x3D10\x2C y\x3D16\nSensor at x\x3D10\x2C y\x3D20: closest beacon is at x\x3D10\x2C y\x3D16\nSensor at x\x3D14\x2C y\x3D17: closest beacon is at x\x3D10\x2C y\x3D16\nSensor at x\x3D8\x2C y\x3D7: closest beacon is at x\x3D2\x2C y\x3D10\nSensor at x\x3D2\x2C y\x3D0: closest beacon is at x\x3D2\x2C y\x3D10\nSensor at x\x3D0\x2C y\x3D11: closest beacon is at x\x3D2\x2C y\x3D10\nSensor at x\x3D20\x2C y\x3D14: closest beacon is at x\x3D25\x2C y\x3D17\nSensor at x\x3D17\x2C y\x3D20: closest beacon is at x\x3D21\x2C y\x3D22\nSensor at x\x3D16\x2C y\x3D7: closest beacon is at x\x3D15\x2C y\x3D3\nSensor at x\x3D14\x2C y\x3D3: closest beacon is at x\x3D15\x2C y\x3D3\nSensor at x\x3D20\x2C y\x3D1: closest beacon is at x\x3D15\x2C y\x3D3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
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
