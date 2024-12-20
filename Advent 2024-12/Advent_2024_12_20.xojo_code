#tag Class
Protected Class Advent_2024_12_20
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
		  
		  var path() as Xojo.Point = Traverse( grid )
		  
		  var limit as integer = if( IsTest, 38, 100 ) 
		  var lastIndexToConsider as integer = path.LastIndex - limit
		  
		  var count as integer
		  
		  for upIndex as integer = 0 to lastIndexToConsider
		    var lowPoint as Xojo.Point = path( upIndex )
		    
		    for downIndex as integer = path.LastIndex downto upIndex + 1
		      var savings as integer = downIndex - upIndex - 1
		      if savings < limit then
		        continue for upIndex
		      end if
		      
		      var highPoint as Xojo.Point = path( downIndex )
		      
		      if lowPoint.X <> highPoint.X and lowPoint.Y <> highPoint.Y then
		        continue
		      end if
		      
		      if abs( lowPoint.X - highPoint.X ) = 2 or abs( lowPoint.Y - highPoint.Y ) = 2 then
		        count = count + 1
		      end if
		    next
		  next
		  
		  return count : if( IsTest, 3, 1429 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  
		  
		  
		  return 0 : if( IsTest, 0, 0 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Key(X As Integer, Y As Integer) As Integer
		  return X * 10000 + Y
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Key(pt As Xojo.Point) As Integer
		  return Key( pt.X, pt.Y )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function NextPoint(grid(, ) As String, current As Xojo.Point, travelled As Dictionary) As Xojo.Point
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  for xinc as integer = -1 to 1
		    var x as integer = current.X + xinc
		    
		    if x < 0 or x > lastColIndex then
		      continue
		    end if
		    
		    for yinc as integer = -1 to 1
		      if xinc = 0 and yinc = 0 then
		        continue
		      elseif xinc <> 0 and yinc <> 0 then
		        continue
		      end if
		      
		      var y as integer = current.Y + yinc
		      
		      if y < 0 or y > lastRowIndex then
		        continue
		      end if
		      
		      var key as integer = Key( x,  y )
		      
		      if travelled.HasKey( key ) then
		        continue
		      end if
		      
		      var char as string = grid( y, x )
		      
		      if char = "." or char = "E" then
		        var pt as new Xojo.Point( x, y )
		        travelled.Value( key ) = pt
		        return pt
		      end if
		    next
		  next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Traverse(grid(, ) As String) As Xojo.Point()
		  var path() as Xojo.Point
		  
		  var current as Xojo.Point = FindInStringGrid( grid, "S" )
		  path.Add current
		  
		  var travelled as new Dictionary( Key( current ) : current )
		  
		  do
		    current = NextPoint( grid, current, travelled )
		    path.Add current
		  loop until grid( current.Y, current.X ) = "E"
		  
		  return path
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"###############\n#...#...#.....#\n#.#.#.#.#.###.#\n#S#...#.#.#...#\n#######.#.#.###\n#######.#.#...#\n#######.#.###.#\n###..E#...#...#\n###.#######.###\n#...###...#...#\n#.#####.#.###.#\n#.#...#.#.#...#\n#.#.#.#.#.#.###\n#...#...#...###\n###############", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
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
