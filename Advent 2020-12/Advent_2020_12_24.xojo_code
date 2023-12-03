#tag Class
Protected Class Advent_2020_12_24
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Hex tiles"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Lobby Layout"
		  
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
		  return CountBlack( GetGrid( input ) )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var grid as Dictionary = GetGrid( input )
		  
		  Print "Move 0: " + CountBlack( grid ).ToString
		  
		  const kMoves as integer = 100
		  
		  var keysAdded() as variant = grid.Keys
		  
		  for move as integer = 1 to kMoves
		    var keys() as variant
		    for each key as variant in keysAdded
		      keys.Add key
		    next
		    keysAdded.RemoveAll
		    
		    //
		    // Expand the grid as needed
		    //
		    for each key as string in keys
		      var x as double = key.NthField( ",", 1 ).ToDouble
		      var y as double = key.NthField( ",", 2 ).ToDouble
		      
		      var adjacentKeys() as string = GetAdjacentKeys( x, y )
		      for each adjacentKey as string in adjacentKeys
		        if not grid.HasKey( adjacentKey ) then
		          grid.Value( adjacentKey ) = false
		          keysAdded.Add adjacentKey
		        end if
		      next
		    next
		    
		    var newGrid as new Dictionary
		    
		    keys = grid.Keys
		    var values() as variant = grid.Values
		    
		    for i as integer = 0 to keys.LastIndex
		      var key as string = keys( i )
		      var isBlack as boolean = values( i )
		      
		      var x as double = key.NthField( ",", 1 ).ToDouble
		      var y as double = key.NthField( ",", 2 ).ToDouble
		      
		      var blackCount as integer
		      
		      var adjacentKeys() as string
		      adjacentKeys.Add ToKey( x - 1.0, y )// w
		      adjacentKeys.Add ToKey( x - 0.5, y + 1.0 ) // nw
		      adjacentKeys.Add ToKey( x + 0.5, y + 1.0 ) // ne
		      adjacentKeys.Add ToKey( x + 1.0, y ) // e
		      adjacentKeys.Add ToKey( x + 0.5, y - 1.0 ) // se
		      adjacentKeys.Add ToKey( x - 0.5, y - 1.0 ) // sw
		      
		      for each adjacentKey as string in adjacentKeys
		        var adjacentIsBlack as boolean = grid.Lookup( adjacentKey, false )
		        blackCount = blackCount + if( adjacentIsBlack, 1, 0 )
		        if blackCount > 2 then
		          exit
		        end if
		      next
		      
		      if isBlack and ( blackCount = 0 or blackCount > 2 ) then
		        isBlack = false
		        
		      elseif not isBlack and blackCount = 2 then
		        isBlack = true
		        
		      end if
		      
		      newGrid.Value( key ) = isBlack
		    next
		    
		    grid = newGrid
		    
		    Print "Move " + move.ToString + ": " + CountBlack( grid ).ToString
		    
		  next
		  
		  return CountBlack( grid )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountBlack(grid As Dictionary) As Integer
		  var blackCount as integer
		  var values() as variant = grid.Values
		  for each isBlack as boolean in values
		    if isBlack then
		      blackCount = blackCount + 1
		    end if
		  next
		  
		  return blackCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetAdjacentKeys(x As Double, y As Double) As String()
		  var adjacentKeys() as string
		  
		  adjacentKeys.Add ToKey( x - 1.0, y )// w
		  adjacentKeys.Add ToKey( x - 0.5, y + 1.0 ) // nw
		  adjacentKeys.Add ToKey( x + 0.5, y + 1.0 ) // ne
		  adjacentKeys.Add ToKey( x + 1.0, y ) // e
		  adjacentKeys.Add ToKey( x + 0.5, y - 1.0 ) // se
		  adjacentKeys.Add ToKey( x - 0.5, y - 1.0 ) // sw
		  
		  return adjacentKeys
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetGrid(input As String) As Dictionary
		  var rows() as string = ToStringArray( input )
		  
		  var grid as new Dictionary
		  
		  for each row as string in rows
		    var directions() as string = row.Trim.Split( "" )
		    
		    var x, y as double
		    var mult as double = 1.0
		    
		    for each direction as string in directions
		      select case direction
		      case "n"
		        y = y + 1.0
		        mult = 0.5
		      case "e"
		        x = x + 1.0 * mult
		        mult = 1.0
		      case "s"
		        y = y - 1.0
		        mult = 0.5
		      case "w"
		        x = x - 1.0 * mult
		        mult = 1.0
		      case else
		        break
		      end select
		    next
		    
		    var key as string = x.ToString( kFormat ) + "," + y.ToString( kFormat )
		    grid.Value( key ) = not grid.Lookup( key, false )
		  next
		  
		  return grid
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToKey(x As Double, y As Double) As String
		  return x.ToString( kFormat ) + "," + y.ToString( kFormat )
		End Function
	#tag EndMethod


	#tag Constant, Name = kFormat, Type = String, Dynamic = False, Default = \"000000000.0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"sesenwnenenewseeswwswswwnenewsewsw\nneeenesenwnwwswnenewnwwsewnenwseswesw\nseswneswswsenwwnwse\nnwnwneseeswswnenewneswwnewseswneseene\nswweswneswnenwsewnwneneseenw\neesenwseswswnenwswnwnwsewwnwsene\nsewnenenenesenwsewnenwwwse\nwenwwweseeeweswwwnwwe\nwsweesenenewnwwnwsenewsenwwsesesenwne\nneeswseenwwswnwswswnw\nnenwswwsewswnenenewsenwsenwnesesenew\nenewnwewneswsewnwswenweswnenwsenwsw\nsweneswneswneneenwnewenewwneswswnese\nswwesenesewenwneswnwwneseswwne\nenesenwswwswneneswsenwnewswseenwsese\nwnwnesenesenenwwnenwsewesewsesesew\nnenewswnwewswnenesenwnesewesw\neneswnwswnwsenenwnwnwwseeswneewsenese\nneswnwewnwnwseenwseesewsenwsweewe\nwseweeenwnesenwwwswnew", Scope = Private
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
