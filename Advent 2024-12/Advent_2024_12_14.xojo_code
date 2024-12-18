#tag Class
Protected Class Advent_2024_12_14
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Robots for a Christmas tree"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Restroom Redoubt"
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
		  var seconds as integer = 100
		  
		  var width as integer
		  var height as integer
		  
		  if IsTest then
		    width = 11
		    height = 7
		  else
		    width = 101
		    height = 103
		  end if
		  
		  var midWidth as integer = width \ 2
		  var midHeight as integer = height \ 2
		  
		  var q1, q2, q3, q4 as integer
		  
		  var rx as new RegEx
		  rx.SearchPattern = "p=(\d+),(\d+) v=(-?\d+),(-?\d+)"
		  
		  var rows() as string = Normalize( input ).Split( EndOfLine )
		  
		  for each robot as string in rows
		    var match as RegExMatch = rx.Search( robot )
		    
		    var x as integer = match.SubExpressionString( 1 ).ToInteger
		    var y as integer = match.SubExpressionString( 2 ).ToInteger
		    var vx as integer = match.SubExpressionString( 3 ).ToInteger
		    var vy as integer = match.SubExpressionString( 4 ).ToInteger
		    
		    var posx as integer = PositionInSeconds( x, vx, width, seconds )
		    var posy as integer = PositionInSeconds( y, vy, height, seconds )
		    
		    select case true
		    case posx < midWidth and posy < midHeight
		      q1 = q1 + 1
		    case posx > midWidth and posy < midHeight
		      q2 = q2 + 1
		    case posx < midWidth and posy > midHeight
		      q3 = q3 + 1
		    case posx > midWidth and posy > midHeight
		      q4 = q4 + 1
		    end select
		  next
		  
		  var result as integer = q1 * q2 * q3 * q4
		  return result : if( IsTest, 12, 215476074 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  if IsTest then
		    return ""
		  end if
		  
		  var width as integer
		  var height as integer
		  
		  width = 101
		  height = 103
		  
		  var rx as new RegEx
		  rx.SearchPattern = "p=(\d+),(\d+) v=(-?\d+),(-?\d+)"
		  
		  var robots() as SecurityRobot
		  
		  var rows() as string = Normalize( input ).Split( EndOfLine )
		  
		  for each row as string in rows
		    var match as RegExMatch = rx.Search( row )
		    
		    var x as integer = match.SubExpressionString( 1 ).ToInteger
		    var y as integer = match.SubExpressionString( 2 ).ToInteger
		    var vx as integer = match.SubExpressionString( 3 ).ToInteger
		    var vy as integer = match.SubExpressionString( 4 ).ToInteger
		    
		    var r as new SecurityRobot
		    r.StartX = x
		    r.StartY = y
		    r.VelocityX = vx
		    r.VelocityY = vy
		    
		    robots.Add r
		  next
		  
		  var result as integer
		  
		  for seconds as integer = 1 to 50000000
		    var grid( -1, -1 ) as string
		    grid.ResizeTo( height - 1, width - 1 )
		    
		    var checkMB as new MemoryBlock( width * height )
		    var checkPtr as ptr = checkMB
		    
		    for each robot as SecurityRobot in robots
		      var posx as integer = PositionInSeconds( robot.StartX, robot.VelocityX, width, seconds )
		      var posy as integer = PositionInSeconds( robot.StartY, robot.VelocityY, height, seconds )
		      
		      grid( posy, posx ) = "X"
		      checkPtr.Byte( posy * width + posx ) = &h44
		    next
		    
		    var checkString as string = checkMB
		    var foundIt as boolean = checkString.IndexOfBytes( "DDDDDDDD" ) <> -1
		    
		    if not foundIt then
		      continue for seconds
		    end if
		    
		    for row as integer = 0 to height - 1
		      for col as integer = 0 to width - 1
		        if grid( row, col ) = "" then
		          grid( row, col ) = "."
		        end if
		      next
		    next
		    
		    Print seconds
		    Print grid
		    
		    result = seconds
		    exit for seconds
		  next
		  
		  return result : if( IsTest, 0, 6285 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function PositionInSeconds(startPos As Integer, velocity As Integer, limit As Integer, seconds As Integer) As Integer
		  var pos as integer = ( ( velocity * seconds ) + startPos ) mod limit
		  if pos < 0 then
		    pos = limit + pos
		  end if
		  
		  return pos
		   
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"p\x3D0\x2C4 v\x3D3\x2C-3\np\x3D6\x2C3 v\x3D-1\x2C-3\np\x3D10\x2C3 v\x3D-1\x2C2\np\x3D2\x2C0 v\x3D2\x2C-1\np\x3D0\x2C0 v\x3D1\x2C3\np\x3D3\x2C0 v\x3D-2\x2C-2\np\x3D7\x2C6 v\x3D-1\x2C-3\np\x3D3\x2C0 v\x3D-1\x2C-2\np\x3D9\x2C3 v\x3D2\x2C3\np\x3D7\x2C3 v\x3D-1\x2C2\np\x3D2\x2C4 v\x3D2\x2C-3\np\x3D9\x2C5 v\x3D-3\x2C-3", Scope = Private
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
