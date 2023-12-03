#tag Class
Protected Class Advent_2021_12_22
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Variant
		  return CalculateResultA( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Variant
		  return CalculateResultB( GetPuzzleInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Variant
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var target as new CubeRange
		  target.X0 = -50
		  target.X1 = 50
		  target.Y0 = target.X0
		  target.Y1 = target.X1
		  target.Z0 = target.X0
		  target.Z1 = target.X1
		  
		  var cubes() as CubeRange = ParseInput( input )
		  
		  var count as integer
		  for each cube as CubeRange in cubes
		    count = count + cube.CountInRange( target )
		  next
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var cubes() as CubeRange = ParseInput( input )
		  
		  var count as integer
		  for each cube as CubeRange in cubes
		    count = count + cube.Count
		  next
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetInstructions(input As String) As CubeRange()
		  var rx as new RegEx
		  rx.SearchPattern = "^(off|on) x=(-?\d+)\.\.(-?\d+),y=(-?\d+)\.\.(-?\d+),z=(-?\d+)\.\.(-?\d+)$"
		  // on x=-20..26,y=-36..17,z=-47..7
		  
		  var result() as CubeRange
		  
		  var match as RegExMatch = rx.Search( input )
		  
		  while match isa object
		    var cube as new CubeRange
		    
		    select case match.SubExpressionString( 1 )
		    case "on"
		      cube.State = CubeRange.States.On
		    case "off"
		      cube.State = CubeRange.States.Off
		    end select
		    
		    cube.X0 = match.SubExpressionString( 2 ).ToInteger
		    cube.X1 = match.SubExpressionString( 3 ).ToInteger
		    
		    cube.Y0 = match.SubExpressionString( 4 ).ToInteger
		    cube.Y1 = match.SubExpressionString( 5 ).ToInteger
		    
		    cube.Z0 = match.SubExpressionString( 6 ).ToInteger
		    cube.Z1 = match.SubExpressionString( 7 ).ToInteger
		    
		    result.Add cube
		    
		    match = rx.Search
		  wend
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As CubeRange()
		  var cubes() as CubeRange
		  
		  var instructions() as CubeRange = GetInstructions( input )
		  
		  if instructions.Count = 0 then
		    return cubes
		  end if
		  
		  while instructions.Count <> 0 and instructions( 0 ).State = CubeRange.States.Off
		    instructions.RemoveAt 0 
		  wend
		  
		  cubes.Add instructions( 0 )
		  
		  for each instruction as CubeRange in instructions
		    var newCubes() as CubeRange
		    
		    for each cube as CubeRange in cubes
		      var modified() as CubeRange = cube.Apply( instruction )
		      for each item as CubeRange in modified
		        newCubes.Add item
		      next
		      if instruction is nil then
		        exit
		      end if
		    next cube
		    
		    if instruction isa object and instruction.State = CubeRange.States.On then
		      newCubes.Add instruction
		    end if
		    
		    cubes = newCubes
		    
		  next instruction
		  
		  return cubes
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"on x\x3D-20..26\x2Cy\x3D-36..17\x2Cz\x3D-47..7\non x\x3D-20..33\x2Cy\x3D-21..23\x2Cz\x3D-26..28\non x\x3D-22..28\x2Cy\x3D-29..23\x2Cz\x3D-38..16\non x\x3D-46..7\x2Cy\x3D-6..46\x2Cz\x3D-50..-1\non x\x3D-49..1\x2Cy\x3D-3..46\x2Cz\x3D-24..28\non x\x3D2..47\x2Cy\x3D-22..22\x2Cz\x3D-23..27\non x\x3D-27..23\x2Cy\x3D-28..26\x2Cz\x3D-21..29\non x\x3D-39..5\x2Cy\x3D-6..47\x2Cz\x3D-3..44\non x\x3D-30..21\x2Cy\x3D-8..43\x2Cz\x3D-13..34\non x\x3D-22..26\x2Cy\x3D-27..20\x2Cz\x3D-29..19\noff x\x3D-48..-32\x2Cy\x3D26..41\x2Cz\x3D-47..-37\non x\x3D-12..35\x2Cy\x3D6..50\x2Cz\x3D-50..-2\noff x\x3D-48..-32\x2Cy\x3D-32..-16\x2Cz\x3D-15..-5\non x\x3D-18..26\x2Cy\x3D-33..15\x2Cz\x3D-7..46\noff x\x3D-40..-22\x2Cy\x3D-38..-28\x2Cz\x3D23..41\non x\x3D-16..35\x2Cy\x3D-41..10\x2Cz\x3D-47..6\noff x\x3D-32..-23\x2Cy\x3D11..30\x2Cz\x3D-14..3\non x\x3D-49..-5\x2Cy\x3D-3..45\x2Cz\x3D-29..18\noff x\x3D18..30\x2Cy\x3D-20..-8\x2Cz\x3D-3..13\non x\x3D-41..9\x2Cy\x3D-7..43\x2Cz\x3D-33..15\non x\x3D-54112..-39298\x2Cy\x3D-85059..-49293\x2Cz\x3D-27449..7877\non x\x3D967..23432\x2Cy\x3D45373..81175\x2Cz\x3D27513..53682", Scope = Private
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
