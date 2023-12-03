#tag Class
Protected Class Advent_2022_12_15
Inherits AdventBase
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Function ReturnDescription() As String
		  return "Sensors and beacons"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Beacon Exclusion Zone"
		  
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
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
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
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  const kMult as integer = 4000000
		  
		  var maxRow as integer = if( IsTest, 20, kMult )
		  var maxCol as integer = maxRow
		  
		  var sensors() as Sensor = ParseInput( input )
		  sensors.Sort AddressOf SensorSorter
		  
		  var curX as integer
		  var row as integer
		  
		  for row = 0 to maxRow
		    var nextRow as integer = kMult + 1
		    
		    curX = 0
		    var retries as integer
		    var tried as UInt64
		    
		    do
		      for sIndex as integer = 0 to sensors.LastIndex
		        var mask as UInt64 = 2 ^ sIndex
		        
		        if ( tried and mask ) <> 0 then
		          continue for sIndex
		        end if
		        
		        var s as Sensor = sensors( sIndex )
		        
		        if row < s.MinY or row > s.MaxY then
		          tried = tried or mask
		          continue for sIndex
		        end if
		        
		        if curX < s.MinXForRow( row ) then
		          continue for sIndex
		        end if
		        
		        tried = tried or mask
		        if s.Y < nextRow then
		          nextRow = s.Y
		        end if
		        
		        var nextX as integer = s.NextXForRow( row, curX )
		        if nextX = curX then
		          continue for sIndex
		        end if
		        
		        if nextX > maxCol then
		          if nextRow > row then
		            row = nextRow
		          end if
		          
		          continue for row
		        end if
		        
		        curX = nextX
		        retries = 0
		      next
		      
		      retries = retries + 1
		    loop until retries = 2
		    
		    var result as integer = curX * kMult + row
		    return result
		  next
		  
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
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

	#tag Method, Flags = &h21
		Private Function SensorSorter(s1 As Sensor, s2 As Sensor) As Integer
		  var result as integer = s1.MinX - s2.MinX
		  if result = 0 then
		    result = s1.MinY - s2.MinY
		  end if
		  
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
