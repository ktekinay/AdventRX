#tag Class
Protected Class Advent_2024_12_12
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
		Private Function CalculateResultA(input As String) As Variant
		  var grid( -1, -1 ) as string = ToStringGrid( Normalize( input ) )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var checkedDict as new Dictionary
		  
		  var result as integer
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      var key as integer = Key( row, col )
		      if not checkedDict.HasKey( key ) then
		        var pointsDict as new Dictionary
		        var plot as string = grid( row, col )
		        var perimeter as integer = IdentifyRegion( plot, grid, row, col, pointsDict, checkedDict )
		        
		        result = result + ( perimeter * pointsDict.KeyCount )
		      end if
		    next
		  next
		  
		  return result : if( IsTest, 1930, 1396562 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var grid( -1, -1 ) as string = ToStringGrid( Normalize( input ) )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var checkedDict as new Dictionary
		  
		  var result as integer
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      var key as integer = Key( row, col )
		      if not checkedDict.HasKey( key ) then
		        var pointsDict as new Dictionary
		        var plot as string = grid( row, col )
		        
		        call IdentifyRegion( plot, grid, row, col, pointsDict, checkedDict )
		        var perimeterDict as Dictionary = Perimeter( grid, pointsDict )
		        
		        'if IsTest then
		        'var graphGrid( -1, -1 ) as string
		        'graphGrid.ResizeTo lastRowIndex + 2, lastColIndex + 2
		        '
		        'for gr as integer = 0 to lastRowIndex + 2
		        'for gc as integer = 0 to lastColIndex + 2
		        'graphGrid( gr, gc ) = "."
		        'next
		        'next
		        '
		        'for each pt as Xojo.Point in perimeterDict.Values
		        'graphGrid( pt.Y + 1, pt.X + 1 ) = "X"
		        'next
		        '
		        'Print graphGrid
		        'end if
		        
		        var sides as integer = CountSides( grid, row - 1, col, plot, pointsDict, perimeterDict )
		        var points as integer = pointsDict.Count
		        result = result + ( sides * points )
		      end if
		    next
		  next
		  
		  // 564799 is too low
		  // 810784 is too low
		  // 810785 is too low
		  // 811064 is not right
		  // 811108 is not right
		  return result : if( IsTest, 1206, 0 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CountSides(grid(, ) As String, row As Integer, col As Integer, plot As String, pointsDict As Dictionary, perimeterDict As Dictionary) As Integer
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var turns as integer
		  var direction as integer = 1
		  
		  var startingRow as integer = row
		  var startingCol as integer = col
		  
		  var triedDict as new Dictionary
		  var pt as Xojo.Point
		  var path() as Xojo.Point
		  
		  do
		    perimeterDict.TryRemove( Key( row, col ) )
		    
		    var newDirection as integer 
		    var key as integer
		    
		    newDirection = TurnRight( direction )
		    key = Key( row, col, newDirection )
		    
		    if not triedDict.HasKey( key ) then
		      triedDict.Value( key ) = nil
		      
		      pt = LookRight( row, col, direction, pointsDict )
		      if pt is nil then
		        direction = newDirection
		        Move row, col, direction
		        turns = turns + 1
		        
		        continue
		      end if
		    end if
		    
		    key = Key( row, col, direction )
		    
		    if not triedDict.HasKey( key ) then
		      triedDict.Value( key ) = nil
		      
		      pt = LookAhead( row, col, direction, pointsDict )
		      if pt is nil then
		        path.Add new Xojo.Point( col, row )
		        Move row, col, direction
		        
		        continue
		      end if
		    end if
		    
		    newDirection = TurnLeft( direction )
		    key = Key( row, col, newDirection )
		    
		    if not triedDict.HasKey( key ) then
		      triedDict.Value( key ) = nil
		      
		      pt = LookLeft( row, col, direction, pointsDict )
		      if pt is nil then
		        direction = newDirection
		        Move row, col, direction
		        turns = turns + 1
		        
		        continue
		      end if
		    end if
		    
		    newDirection = TurnAround( direction )
		    key = Key( row, col, newDirection )
		    
		    if not triedDict.HasKey( key ) then
		      triedDict.Value( key ) = nil
		      
		      pt = LookBack( row, col, direction, pointsDict )
		      if pt is nil then
		        direction = newDirection
		        Move row, col, direction
		        turns = turns + 2
		        
		        continue
		      end if
		    end if
		    
		    exit
		  loop until row = startingRow and col = startingCol and direction = 1
		  
		  var pickOne as boolean
		  
		  select case perimeterDict.Count
		  case 0
		  case 1
		    turns = turns + 4
		  case 2
		    var pts() as Xojo.Point
		    for each pt in perimeterDict.Values
		      pts.Add pt
		    next
		    
		    if pts( 0 ).X = pts( 1 ).X and abs( pts( 0 ).Y - pts( 1 ).Y ) = 1 then
		      turns = turns + 4
		    elseif pts( 0 ).Y = pts( 1 ).Y and abs( pts( 0 ).X - pts( 1 ).X ) = 1 then
		      turns = turns + 4
		    else
		      turns = turns + 8
		    end if
		  case else
		    pickOne = true
		    
		  end select
		  
		  if pickOne then
		    var values() as variant = perimeterDict.Values
		    for each pt in values
		      for x as integer = -1 to 1
		        for y as integer = -1 to 1
		          if x = 0 and y = 0 then
		            continue
		          elseif x <> 0 and y <> 0 then
		            continue
		          else
		            if grid( pt.Y + y, pt.X + x ) = plot then
		              turns = turns + CountSides( grid, pt.Y, pt.X, plot, pointsDict, perimeterDict )
		              exit for pt
		            end if
		          end if
		        next
		      next
		    next
		  end if
		  
		  return turns
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub GraphPath(path() As Xojo.Point, grid(, ) As String)
		  const kGraphLastIndex as integer = 49
		  
		  var graphGrid( kGraphLastIndex, kGraphLastIndex ) as string
		  
		  var pt as Xojo.Point = path( 0 )
		  var rowDiff as integer = pt.Y - 5
		  var colDiff as integer = pt.X - 5
		  
		  for graphRow as integer = 0 to kGraphLastIndex
		    for graphCol as integer = 0 to kGraphLastIndex
		      var gridRow as integer = graphRow + rowDiff
		      var gridCol as integer = graphCol + colDiff
		      
		      if gridRow < 0 or gridRow > grid.LastIndex( 1 ) or _
		        gridCol < 0 or gridCol > grid.LastIndex( 2 ) then
		        graphGrid( graphRow, graphCol ) = "?"
		        continue
		      end if
		      
		      graphGrid( graphRow, graphCol ) = grid( gridRow, gridCol )
		    next
		  next
		  
		  for each pt in path
		    var graphRow as integer = pt.Y - rowDiff
		    var graphCol as integer = pt.X - colDiff
		    
		    if graphRow < 0 or graphRow > kGraphLastIndex or graphCol < 0 or graphCol > kGraphLastIndex then
		      continue
		    end if
		    
		    graphGrid( graphRow, graphCol ) = "*"
		  next
		  
		  print graphGrid
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function IdentifyRegion(plot As String, grid(, ) As String, row As Integer, col As Integer, pointsDict As Dictionary, checkedDict As Dictionary) As Integer
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  if row < 0 or row > lastRowIndex or col < 0 or col > lastColIndex then
		    return 1
		  end if
		  
		  if grid( row, col ) <> plot then
		    return 1
		  end if
		  
		  var key as integer = Key( row, col )
		  
		  if pointsDict.HasKey( key ) then
		    return 0
		  end if
		  
		  pointsDict.Value( key ) = new Xojo.Point( col, row )
		  checkedDict.Value( key ) = nil
		  
		  var result as integer
		  result = result + IdentifyRegion( plot, grid, row - 1, col, pointsDict, checkedDict )
		  result = result + IdentifyRegion( plot, grid, row + 1, col, pointsDict, checkedDict )
		  result = result + IdentifyRegion( plot, grid, row, col - 1, pointsDict, checkedDict )
		  result = result + IdentifyRegion( plot, grid, row, col + 1, pointsDict, checkedDict )
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Key(row As Integer, col As Integer, direction As Integer = 0) As Integer
		  return ( direction * 10000000 ) + ( row * 10000 ) + col
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function LookAhead(row As Integer, col As Integer, direction As Integer, pointsDict As Dictionary) As Xojo.Point
		  select case direction
		  case 0
		    row = row - 1
		  case 1
		    col = col + 1
		  case 2
		    row = row + 1
		  case 3
		    col = col - 1
		  end select
		  
		  return pointsDict.Lookup( Key( row, col ), nil )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function LookBack(row As Integer, col As Integer, direction As Integer, pointsDict As Dictionary) As Xojo.Point
		  select case direction
		  case 0
		    row = row + 1
		  case 1
		    col = col - 1
		  case 2
		    row = row - 1
		  case 3
		    col = col + 1
		  end select
		  
		  return pointsDict.Lookup( Key( row, col ), nil )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function LookLeft(row As Integer, col As Integer, direction As Integer, pointsDict As Dictionary) As Xojo.Point
		  select case direction
		  case 0
		    col = col - 1
		  case 1
		    row = row - 1
		  case 2
		    col = col + 1
		  case 3
		    row = row + 1
		  end select
		  
		  return pointsDict.Lookup( Key( row, col ), nil )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function LookRight(row As Integer, col As Integer, direction As Integer, pointsDict As Dictionary) As Xojo.Point
		  select case direction
		  case 0
		    col = col + 1
		  case 1
		    row = row + 1
		  case 2
		    col = col - 1
		  case 3
		    row = row - 1
		  end select
		  
		  return pointsDict.Lookup( Key( row, col ), nil )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Move(ByRef row As Integer, ByRef col As Integer, direction As Integer)
		  select case direction
		  case 0
		    row = row - 1
		  case 1
		    col = col + 1
		  case 2
		    row = row + 1
		  case 3
		    col = col - 1
		  end select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Perimeter(grid(, ) As String, pointsDict As Dictionary) As Dictionary
		  var perimeterDict as new Dictionary
		  
		  var pointKeys() as variant = pointsDict.Keys
		  var pointValues() as variant = pointsDict.Values
		  
		  for i as integer = 0 to pointKeys.LastIndex
		    var point as Xojo.Point = pointValues( i )
		    
		    for checkX as integer = -1 to 1
		      for checkY as integer = -1 to 1
		        if checkX = 0 and checkY = 0 then
		          continue
		        end if
		        if checkX <> 0 and checkY <> 0 then
		          continue
		        end if
		        
		        var checkKey as integer = Key( point.Y + checkY, point.X + checkX )
		        
		        if not pointsDict.HasKey( checkKey ) then
		          perimeterDict.Value( checkKey ) = new Xojo.Point( point.X + checkX, point.Y + checkY )
		        end if
		      next
		    next
		  next
		  
		  return perimeterDict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function TurnAround(direction As Integer) As Integer
		  return ( direction + 2 ) mod 4
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function TurnLeft(direction As Integer) As Integer
		  return ( direction + 3 ) mod 4
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function TurnRight(direction As Integer) As Integer
		  return ( direction + 1 ) mod 4
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"RRRRIICCFF\nRRRRIICCCF\nVVRRRCCFFF\nVVRCCCJFFF\nVVVVCJJCFE\nVVIVCCJJEE\nVVIIICJJEE\nMIIIIIJJEE\nMIIISIJEEE\nMMMISSJEEE", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"AAAAAA\nAAABBA\nAAABBA\nABBAAA\nABBAAA\nAAAAAA", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2024
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
