#tag Class
Protected Class Advent_2020_12_17
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( Normalize( kInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( Normalize( kInput ) )
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
		  return DoIt( input, false )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  return DoIt( input, true )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountActive(cubes() As Advent3DObject) As Integer
		  var result as integer
		  for each cube as Advent3DObject in cubes
		    if cube.Value.BooleanValue then
		      result = result + 1
		    end if
		  next
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CreateCubes(grid As SpacialGrid, x1 As Integer, x2 As Integer, y1 As Integer, y2 As Integer, z1 As Integer, z2 As Integer)
		  for x as integer = x1 to x2
		    for y as integer = y1 to y2
		      for z as integer = z1 to z2
		        if grid( x, y, z ) is nil then
		          var cube as new Advent3DObject
		          cube.Value = false
		          grid( x, y, z ) = cube
		        end if
		      next z
		    next y
		  next x
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CreateCubes(grid As SpacialGrid, x1 As Integer, x2 As Integer, y1 As Integer, y2 As Integer, z1 As Integer, z2 As Integer, w1 As Integer, w2 As Integer)
		  for x as integer = x1 to x2
		    for y as integer = y1 to y2
		      for z as integer = z1 to z2
		        for w as integer = w1 to w2
		          if grid( x, y, z, w ) is nil then
		            var cube as new Advent3DObject
		            cube.Value = false
		            grid( x, y, z, w ) = cube
		          end if
		        next w
		      next z
		    next y
		  next x
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DoIt(input As String, as4D As Boolean) As Integer
		  var grid as SpacialGrid = ParseInput( input, as4D )
		  
		  if grid.Count = 0 then
		    return -1
		  end if
		  
		  print "Count=0"
		  PrintGrid grid
		  
		  for count as integer = 1 to 6
		    ExpandGrid grid, as4D
		    
		    var cubes() as Advent3DObject = grid.ToArray
		    var changeThese() as Advent3DObject
		    
		    for each cube as Advent3DObject in cubes
		      
		      var isActive as boolean = cube.Value.BooleanValue
		      var neighbors() as Advent3DObject
		      if as4D then
		        neighbors = grid.ObjectsAround( cube.X, cube.Y, cube.Z, cube.W )
		      else
		        neighbors = grid.ObjectsAround( cube.X, cube.Y, cube.Z )
		      end if
		      
		      var activeCount as integer = CountActive( neighbors ) - if( isActive, 1, 0 ) // Remove this cube if it's active
		      
		      if isActive and ( activeCount < 2 or activeCount > 3 ) then
		        changeThese.Add cube
		      elseif not isActive and activeCount = 3 then
		        changeThese.Add cube
		      end if
		    next  cube
		    
		    for each cube as Advent3DObject in changeThese
		      cube.Value = not cube.Value.BooleanValue
		    next
		    
		    print "Count=" + count.ToString
		    PrintGrid grid
		  next count
		  
		  return CountActive( grid.ToArray )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExpandGrid(grid as SpacialGrid, as4D as Boolean)
		  if as4D then
		    
		    CreateCubes grid, _
		    grid.MinX - 1, grid.MaxX + 1, _
		    grid.MinY - 1, grid.MaxY + 1, _
		    grid.MinZ - 1, grid.MaxZ + 1, _
		    grid.MinW - 1, grid.MaxW + 1
		    
		  else
		    
		    CreateCubes grid, _
		    grid.MinX - 1, grid.MaxX + 1, _
		    grid.MinY - 1, grid.MaxY + 1, _
		    grid.MinZ - 1, grid.MaxZ + 1
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String, as4D As Boolean) As SpacialGrid
		  var grid as new SpacialGrid
		  
		  var rows() as string = ToStringArray( input )
		  if rows.Count = 0 then
		    return grid
		  end if
		  
		  for y as integer = 0 to rows.LastIndex
		    var cols() as string = rows( y ).Split( "" )
		    for x as integer = 0 to cols.LastIndex
		      var cube as new Advent3DObject
		      cube.Value = cols( x ) = "#"
		      
		      if as4D then
		        grid( x, y, 0, 0 ) = cube
		      else
		        grid( x, y, 0 ) = cube
		      end if
		    next x
		  next y
		  
		  return grid
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Print(msg As Variant)
		  #if FALSE then
		    Super.Print(msg)
		  #else
		    #pragma unused msg
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PrintGrid(grid As SpacialGrid)
		  for z as integer = grid.MinZ to grid.MaxZ
		    var builder() as string
		    builder.Add "z=" + z.ToString
		    
		    for y as integer = grid.MinY to grid.MaxY
		      var rowBuilder() as string
		      for x as integer = grid.MinX to grid.MaxX
		        var cube as Advent3DObject = grid( x, y, z )
		        var isActive as boolean = cube isa object and cube.Value.BooleanValue
		        rowBuilder.Add if( isActive, "#", "." )
		      next x
		      builder.Add String.FromArray( rowBuilder, "" )
		    next y
		    
		    print String.FromArray( builder, EndOfLine )
		    print ""
		  next z
		  
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"..##.#.#\n.#####..\n#.....##\n##.##.#.\n..#...#.\n.#..##..\n.#...#.#\n#..##.##", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \".#.\n..#\n###", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
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
