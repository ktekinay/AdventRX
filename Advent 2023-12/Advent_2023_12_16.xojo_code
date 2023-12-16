#tag Class
Protected Class Advent_2023_12_16
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Reflecting mirrors"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "The Floor Will Be Lava"
		  
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
		  var grid as ObjectGrid = Parse( input )
		  var beam as new LightBeam
		  beam.Column = -1
		  
		  var beams() as LightBeam 
		  beams.Add beam
		  
		  var total as integer = Move( grid, beams )
		  
		  return total : if( IsTest, 46, 7472 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var grid as ObjectGrid = Parse( input )
		  
		  var bestTotal as integer
		  
		  for row as integer = 0 to grid.LastRowIndex
		    var useDirection as string = "E"
		    for col as integer = -1 to grid.LastColIndex + 1 step ( grid.LastColIndex + 2 )
		      var beam as new LightBeam
		      beam.Row = row
		      beam.Column = col
		      beam.Direction = useDirection
		      
		      var beams() as LightBeam 
		      beams.Add beam
		      
		      var total as integer = Move( grid, beams )
		      if total > bestTotal then
		        bestTotal = total
		      end if
		      useDirection = "W"
		    next
		  next
		  
		  for col as integer = 0 to grid.LastColIndex
		    var useDirection as string = "S"
		    for row as integer = -1 to grid.LastRowIndex + 1 step ( grid.LastRowIndex + 2 )
		      var beam as new LightBeam
		      beam.Row = row
		      beam.Column = col
		      beam.Direction = useDirection
		      
		      var beams() as LightBeam 
		      beams.Add beam
		      
		      var total as integer = Move( grid, beams )
		      if total > bestTotal then
		        bestTotal = total
		      end if
		      useDirection = "N"
		    next
		  next
		  
		  return bestTotal : if( IsTest, 51, 7716 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Move(grid As ObjectGrid, beams() As LightBeam) As Integer
		  var trail as new Dictionary
		  var energized as new Dictionary
		  
		  while beams.Count <> 0
		    
		    var newBeams() as LightBeam
		    
		    for i as integer = beams.LastIndex downto 0
		      var beam as LightBeam = beams( i )
		      beam.Move
		      
		      if beam.Row < 0 or beam.Row > grid.LastRowIndex or beam.Column < 0 or beam.Column > grid.LastColIndex then
		        beams.RemoveAt i
		        continue
		      end if
		      
		      var beamKey as integer = ( beam.Row * ( grid.LastColIndex + 1 ) + beam.Column ) + _
		      ( ( grid.LastRowIndex + 1 ) * ( grid.LastColIndex + 1 ) * beam.Direction.Asc )
		      
		      if trail.HasKey( beamKey ) then
		        beams.RemoveAt i
		        continue
		      end if
		      
		      trail.Value( beamKey ) = nil
		      
		      var sq as GridMember = grid( beam.Row, beam.Column )
		      
		      energized.Value( sq ) = nil
		      
		      if sq.Value = "." then
		        continue
		      end if
		      
		      select case sq.Value
		      case "/", "\"
		        Redirect beam, sq.Value
		      case "-"
		        if beam.Direction = "E" or beam.Direction = "W" then
		          continue
		        end if
		        
		        beam.Direction = "W"
		        var newBeam as new LightBeam
		        newBeam.Direction = "E"
		        newBeam.Row = beam.Row
		        newBeam.Column = beam.Column
		        newBeams.Add newBeam
		        
		      case "|"
		        if beam.Direction = "N" or beam.Direction = "S" then
		          continue
		        end if
		        
		        beam.Direction = "N"
		        var newBeam as new LightBeam
		        newBeam.Direction = "S"
		        newBeam.Row = beam.Row
		        newBeam.Column = beam.Column
		        newBeams.Add newBeam
		        
		      end select
		    next
		    
		    for each beam as LightBeam in newBeams
		      beams.Add beam
		    next
		    
		  wend
		  
		  return energized.Count
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Parse(input As String) As ObjectGrid
		  var sgrid( -1, -1 ) as string = ToStringGrid( input )
		  var grid as new ObjectGrid
		  grid.ResizeTo sgrid.LastIndex( 1 ), sgrid.LastIndex( 2 )
		  
		  for row as integer = 0 to sgrid.LastIndex( 1 )
		    for col as integer = 0 to sgrid.LastIndex( 2 )
		      var sq as new GridMember
		      sq.Value = sgrid( row, col )
		      grid( row, col ) = sq
		    next
		  next
		  
		  return grid
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Redirect(beam As LightBeam, reflector As String)
		  select case reflector
		  case "/"
		    select case beam.Direction
		    case "N"
		      beam.Direction = "E"
		    case "E"
		      beam.Direction = "N"
		    case "S"
		      beam.Direction = "W"
		    case "W"
		      beam.Direction = "S"
		    end select
		    
		  case "\"
		    select case beam.Direction
		    case "N"
		      beam.Direction = "W"
		    case "E"
		      beam.Direction = "S"
		    case "S"
		      beam.Direction = "E"
		    case "W"
		      beam.Direction = "N"
		    end select
		    
		  end select
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \".|...\\....\n|.-.\\.....\n.....|-...\n........|.\n..........\n.........\\\n..../.\\\\..\n.-.-/..|..\n.|....-|.\\\n..//.|....", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2023
	#tag EndUsing


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
