#tag Class
Protected Class Advent_2022_12_18
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Count exposed cube sides"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Boiling Boulders"
		  
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
		Private Sub AddVoidNeighbors(grid As Advent.SpacialGrid, square As Advent3DObject, toArray() As Advent3DObject)
		  MaybeAddVoid grid, square.X - 1, square.Y, square.Z, toArray
		  MaybeAddVoid grid, square.X + 1, square.Y, square.Z, toArray
		  MaybeAddVoid grid, square.X, square.Y - 1, square.Z, toArray
		  MaybeAddVoid grid, square.X, square.Y + 1, square.Z, toArray
		  MaybeAddVoid grid, square.X, square.Y, square.Z - 1, toArray
		  MaybeAddVoid grid, square.X, square.Y, square.Z + 1, toArray
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var cubes() as Advent3DObject
		  var cubeDict as new Dictionary
		  
		  var rows() as string = input.Split( EndOfLine )
		  rows.Sort
		  
		  for each row as string in rows
		    var parts() as string = row.Split( "," )
		    var x as integer = parts( 0 ).ToInteger
		    var y as integer = parts( 1 ).ToInteger
		    var z as integer = parts( 2 ).ToInteger
		    
		    var cube as new Advent3DObject
		    cube.SetCoordinates x, y, z
		    cube.Value = 6
		    
		    cubes.Add cube
		    cubeDict.Value( ToString( x, y, z ) ) = cube
		  next
		  
		  for each cube as Advent3DObject in cubes
		    var x as integer = cube.X
		    var y as integer = cube.Y
		    var z as integer = cube.Z
		    
		    for i as integer = -1 to 1 step 2
		      if cubeDict.HasKey( ToString( x + i, y, z ) ) then
		        cube.Value = cube.Value - 1
		      end if
		      if cubeDict.HasKey( ToString( x, y + i, z ) ) then
		        cube.Value = cube.Value - 1
		      end if
		      if cubeDict.HasKey( ToString( x, y, z + i ) ) then
		        cube.Value = cube.Value - 1
		      end if
		    next
		  next
		  
		  var count as integer
		  for each cube as Advent3DObject in cubes
		    count = count + cube.Value
		  next
		  
		  return count
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var cubes() as Advent3DObject
		  var cubeDict as new Dictionary
		  var grid as new Advent.SpacialGrid
		  
		  var rows() as string = input.Split( EndOfLine )
		  rows.Sort
		  
		  var minX, maxX as integer
		  var minY, maxY as integer
		  var minZ, maxZ as integer
		  
		  minX = &hFFFFFFFFFFFF
		  minY = minX
		  minZ = minX
		  
		  for each row as string in rows
		    var parts() as string = row.Split( "," )
		    var x as integer = parts( 0 ).ToInteger
		    var y as integer = parts( 1 ).ToInteger
		    var z as integer = parts( 2 ).ToInteger
		    
		    maxX = max( maxX, x )
		    maxY = max( maxY, y )
		    maxZ = max( maxZ, z )
		    
		    minX = min( minX, x )
		    minY = min( minY, y )
		    minZ = min( minZ, z )
		    
		    var cube as new Advent3DObject
		    grid( x, y, z ) = cube
		    cube.Value = 6
		    
		    cubes.Add cube
		    cubeDict.Value( ToString( x, y, z ) ) = cube
		  next
		  
		  for each cube as Advent3DObject in cubes
		    var x as integer = cube.X
		    var y as integer = cube.Y
		    var z as integer = cube.Z
		    
		    for i as integer = -1 to 1 step 2
		      if cubeDict.HasKey( ToString( x + i, y, z ) ) then
		        cube.Value = cube.Value - 1
		      end if
		      
		      if cubeDict.HasKey( ToString( x, y + i, z ) ) then
		        cube.Value = cube.Value - 1
		      end if
		      
		      if cubeDict.HasKey( ToString( x, y, z + i ) ) then
		        cube.Value = cube.Value - 1
		      end if
		    next
		  next
		  
		  //
		  // Adjust the mins and maxs so we go around the entire perimeter
		  //
		  minX = minX - 1
		  minY = minY - 1
		  minZ = minZ - 1
		  maxX = maxX + 1
		  maxY = maxY + 1
		  maxZ = maxZ + 1
		  
		  var open() as Advent3dObject
		  
		  for x as integer = minX to maxX
		    for y as integer = minY to maxY
		      for z as integer = minZ to maxZ
		        if grid( x, y, z ) is nil then
		          open.Add NewVoid( grid, x, y, z )
		          exit for x
		        end if
		      next
		    next
		  next
		  
		  while open.Count <> 0
		    var square as Advent3DObject = open.Pop
		    if square.X < minX or square.X > maxX or _
		      square.Y < minY or square.Y > maxY or _
		      square.Z < minZ  or square.Z > maxZ then
		      continue
		    end if
		    
		    AddVoidNeighbors grid, square, open
		  wend
		  
		  for each cube as Advent3DObject in cubes
		    var x as integer = cube.X
		    var y as integer = cube.Y
		    var z as integer = cube.Z
		    
		    cube.Value = cube.Value - CountVoid( grid, x - 1, y, z )
		    cube.Value = cube.Value - CountVoid( grid, x + 1, y, z )
		    cube.Value = cube.Value - CountVoid( grid, x, y - 1, z )
		    cube.Value = cube.Value - CountVoid( grid, x, y + 1, z )
		    cube.Value = cube.Value - CountVoid( grid, x, y, z - 1 )
		    cube.Value = cube.Value - CountVoid( grid, x, y, z + 1 )
		  next
		  
		  var count as integer
		  for each cube as Advent3DObject in cubes
		    count = count + cube.Value
		  next
		  
		  
		  return count
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountVoid(grid As Advent.SpacialGrid, x As Integer, y As Integer, z As Integer) As Integer
		  if grid( x, y, z ) is nil then
		    return 1
		  end if
		  
		  return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MaybeAddVoid(grid As Advent.SpacialGrid, x As Integer, y As Integer, z As Integer, toArray() As Advent3DObject)
		  if grid( x, y, z ) is nil then
		    var o as Advent3DObject = NewVoid( grid, x, y, z )
		    toArray.Add o
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NewVoid(grid As Advent.SpacialGrid, x As Integer, y As Integer, z As Integer) As Advent3DObject
		  var o as new Advent3dObject
		  o.Value = kVoidValue
		  grid( x, y, z ) = o
		  return o
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToString(x As Integer, y As Integer, z As Integer) As String
		  return x.ToString + "," + y.ToString + "," + z.ToString
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"2\x2C2\x2C2\n1\x2C2\x2C2\n3\x2C2\x2C2\n2\x2C1\x2C2\n2\x2C3\x2C2\n2\x2C2\x2C1\n2\x2C2\x2C3\n2\x2C2\x2C4\n2\x2C2\x2C6\n1\x2C2\x2C5\n3\x2C2\x2C5\n2\x2C1\x2C5\n2\x2C3\x2C5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kVoidValue, Type = Double, Dynamic = False, Default = \"-1", Scope = Private
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
