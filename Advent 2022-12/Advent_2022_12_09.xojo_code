#tag Class
Protected Class Advent_2022_12_09
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Track the trailing knot"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Rope Bridge"
		  
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
		Private Sub Adjust(pt As Xojo.Point, prevPt As Xojo.Point)
		  var diffX as integer = prevPt.X - pt.X
		  var diffY as integer = prevPt.Y - pt.Y
		  
		  while abs( diffX ) > 1 or abs( diffY ) > 1
		    select case diffX 
		    case is < 0
		      pt.X = pt.X - 1
		      diffX = diffX + 1
		      
		    case is > 0
		      pt.X = pt.X + 1
		      diffX = diffX - 1
		    end select
		    
		    select case diffY
		    case is < 0
		      pt.Y = pt.Y - 1
		      diffY = diffY + 1
		      
		    case is > 0
		      pt.Y = pt.Y + 1
		      diffY = diffY - 1
		    end select
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var instructions() as string = ToStringArray( input )
		  
		  var visited as new Dictionary
		  
		  var headCoords as new Xojo.Point
		  headCoords.X = kCoordZero
		  headCoords.Y = headCoords.X
		  
		  var tailCoords as new Xojo.Point
		  tailCoords.X = headCoords.X
		  tailCoords.Y = headCoords.Y
		  
		  visited.Value( tailCoords.ToKey ) = nil
		  
		  for each instruction as string in instructions
		    var parts() as string = instruction.Split( " " )
		    var direction as string = parts( 0 )
		    var moves as integer = parts( 1 ).ToInteger
		    
		    for move as integer = 1 to moves
		      Move headCoords, direction
		      Adjust( tailCoords, headCoords )
		      visited.Value( tailCoords.ToKey ) = nil
		    next
		  next
		  
		  var count as integer = visited.Count
		  return count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var instructions() as string = ToStringArray( input )
		  
		  var visited as new Dictionary
		  
		  var headCoords as new Xojo.Point
		  headCoords.X = kCoordZero
		  headCoords.Y = headCoords.X
		  
		  var allCoords() as Xojo.Point
		  allCoords.Add headCoords
		  
		  for i as integer = 1 to 9
		    var pt as new Xojo.Point
		    pt.X = headCoords.X
		    pt.Y = headCoords.Y
		    allCoords.Add pt
		  next
		  
		  var tailCoords as Xojo.Point = allCoords( allCoords.LastIndex )
		  
		  visited.Value( tailCoords.ToKey ) = nil
		  
		  for each instruction as string in instructions
		    var parts() as string = instruction.Split( " " )
		    var direction as string = parts( 0 )
		    var moves as integer = parts( 1 ).ToInteger
		    
		    for move as integer = 1 to moves
		      Move headCoords, direction
		      
		      for i as integer = 1 to allCoords.LastIndex
		        var pt as Xojo.Point = allCoords( i )
		        var prevPt as Xojo.Point = allCoords( i - 1 )
		        Adjust( pt, prevPt )
		      next
		      
		      'if IsTest then
		      'PrintStringGrid allCoords
		      'end if
		      
		      visited.Value( tailCoords.ToKey ) = nil
		    next
		  next
		  
		  var count as integer = visited.Count
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Move(pt As Xojo.Point, direction As String)
		  select case direction
		  case "R"
		    pt.X = pt.X + 1
		  case "D"
		    pt.Y = pt.Y - 1
		  case "L"
		    pt.X = pt.X - 1
		  case "U"
		    pt.Y = pt.Y + 1
		  case else
		    raise new RuntimeException
		  end select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PrintStringGrid(coords() As Xojo.Point)
		  var xAdjust as integer = kCoordZero - 12
		  var yAdjust as integer = kCoordZero - 8
		  
		  var grid( 30, 30 ) as string
		  
		  for i as integer = coords.LastIndex downto 0
		    var pt as Xojo.Point = coords( i )
		    var marker as string
		    if i = 0 then
		      marker = "H"
		    elseif i = coords.LastIndex then
		      marker= "T"
		    else
		      marker = i.ToString
		    end if
		    
		    var col as integer = pt.X - xAdjust
		    var row as integer = pt.Y - yAdjust
		    
		    grid( row, col ) = marker
		  next
		  
		  super.PrintStringGrid( grid, "." )
		  Print ""
		End Sub
	#tag EndMethod


	#tag Constant, Name = kCoordZero, Type = Double, Dynamic = False, Default = \"10000000", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"R 4\nU 4\nL 3\nD 1\nR 4\nD 1\nL 5\nR 2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"R 5\nU 8\nL 8\nD 3\nR 17\nD 10\nL 25\nU 20", Scope = Private
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
