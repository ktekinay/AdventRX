#tag Class
Protected Class Advent_2020_12_20
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Rearrange satellite images by matching borders."
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return false
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Jurassic Jigsaw"
		  
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
		Private Sub Assemble(tiles() As SatelliteTile, grid(, ) As SatelliteTile)
		  var lastIndex as integer = ( tiles.Count ^ 0.5 ) - 1
		  grid.ResizeTo lastIndex, lastIndex
		  
		  var tilesDict as new Dictionary
		  for each tile as SatelliteTile in tiles
		    tilesDict.Value( tile.Id ) = tile
		  next
		  
		  var matchDict as new Dictionary
		  
		  //
		  // Cycle through each tile in turn
		  //
		  for tileIndex as integer = 0 to tiles.LastIndex
		    var firstTile as SatelliteTile = tiles.Pop
		    grid( 0, 0 ) = firstTile
		    
		    for orientationIndex as integer = SatelliteTile.kFirstOrientationIndex to SatelliteTile.kLastOrientationIndex
		      var o as SatelliteTile.Orientations = Ctype( orientationIndex, SatelliteTile.Orientations )
		      firstTile.Orientation = o
		      
		      if PlaceNext( grid, tiles, tilesDict, matchDict ) then
		        //
		        // Success!
		        //
		        return
		      end if
		    next
		    
		    //
		    // Put back the tile
		    //
		    tiles.AddAt 0, grid( 0, 0 )
		  next tileIndex
		  
		  return
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var tiles() as SatelliteTile = ParseInput( input )
		  LinkTiles tiles
		  
		  var grid( -1, -1 ) as SatelliteTile
		  Assemble( tiles, grid )
		  
		  var result as integer = _
		  grid( 0, 0 ).ID * _
		  grid( 0, grid.LastIndex ).ID * _
		  grid( grid.LastIndex, 0 ).ID * _
		  grid( grid.LastIndex, grid.LastIndex ).ID
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LinkTiles(tiles() As SatelliteTile)
		  for outer as integer = 0 to tiles.LastIndex
		    var outerTile as SatelliteTile = tiles( outer )
		    
		    var firstInner as integer = outer + 1
		    for inner as integer = firstInner to tiles.LastIndex
		      outerTile.Link tiles( inner )
		    next
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MatchDictKey(tile As SatelliteTile, tileToLeft As SatelliteTile, tileAbove As SatelliteTile) As String
		  var builder( 5 ) as string
		  
		  builder( 0 ) = tile.ID.ToString
		  builder( 1 ) = integer( tile.Orientation ).ToString
		  
		  if tileToLeft isa object then
		    builder( 2 ) = tileToLeft.ID.ToString
		    builder( 3 ) = integer( tileToLeft.Orientation ).ToString
		  end if
		  
		  if tileAbove isa object then
		    builder( 4 ) = tileAbove.ID.ToString
		    builder( 5 ) = integer( tileAbove.Orientation ).ToString
		  end if
		  
		  return String.FromArray( builder, ":" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(data As String) As SatelliteTile()
		  var rows() as string = Normalize( data ).Split( EndOfLine + EndOfLine )
		  
		  var arr() as SatelliteTile
		  
		  for each row as string in rows
		    arr.Add new SatelliteTile( row )
		  next
		  
		  return arr
		  return arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PlaceNext(grid(, ) As SatelliteTile, tiles() As SatelliteTile, tilesDict As Dictionary, matchDict As Dictionary) As Boolean
		  if tiles.Count = 0 then
		    return true
		  end if
		  
		  //
		  // What slot are we in?
		  //
		  var gridLastIndex as integer = grid.LastIndex
		  var currentSlot as integer = ( grid.Count * grid.Count ) - tiles.Count
		  
		  var gridRow as integer = currentSlot \ grid.Count
		  var gridCol as integer = currentSlot mod grid.Count
		  
		  var tileToLeft as SatelliteTile = if( gridCol > 0, grid( gridRow, gridCol - 1 ), nil )
		  var tileAbove as SatelliteTile = if( gridRow > 0, grid( gridRow - 1, gridCol ), nil )
		  
		  //
		  // Get the intersection of ids that are linked
		  //
		  var linkedIds() as integer
		  if tileToLeft is nil then
		    linkedIds = tileAbove.LinkedIDs
		    
		  elseif tileAbove is nil then
		    linkedIds = tileToLeft.LinkedIDs
		    
		  else
		    for each id as integer in tileAbove.LinkedIDs
		      if tileToLeft.LinkedIDs.IndexOf( id ) <> -1 then
		        linkedIds.Add id
		      end if
		    next
		    
		  end if
		  
		  for each linkedId as integer in linkedIds
		    var tile as SatelliteTile = tilesDict.Value( linkedId )
		    
		    var tilePos as integer = tiles.IndexOf( tile )
		    if tilePos = -1 then
		      //
		      // Already in use
		      //
		      continue
		    end if
		    
		    tiles.RemoveAt tilePos
		    
		    grid( gridRow, gridCol ) = tile
		    PrintGrid grid
		    
		    for orientationIndex as integer = SatelliteTile.kFirstOrientationIndex to SatelliteTile.kLastOrientationIndex
		      tile.Orientation = Ctype( orientationIndex, SatelliteTile.Orientations )
		      
		      var mKey as string =  MatchDictKey( tile, tileToLeft, tileAbove )
		      
		      if matchDict.HasKey( mKey ) then
		        if matchDict.Lookup( mKey, false ).BooleanValue and PlaceNext( grid, tiles, tilesDict, matchDict ) then
		          return true
		        end if
		        
		        continue
		      end if
		      
		      var isMatch as boolean = tileToLeft is nil or tile.LeftHash = tileToLeft.RightHash
		      isMatch = isMatch and _
		      ( tileAbove is nil or tile.TopHash = tileAbove.BottomHash )
		      
		      matchDict.Value( mKey ) = isMatch
		      
		      if isMatch then
		        if PlaceNext( grid, tiles, tilesDict, matchDict ) then
		          return true
		        end if
		      end if
		    next
		    
		    //
		    // Put back this tile
		    //
		    tiles.AddAt tilePos, tile
		  next
		  
		  grid( gridRow, gridCol ) = nil
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PrintGrid(grid(, ) As SatelliteTile)
		  const kDebug as boolean = true
		  
		  #if not kDebug then
		    #pragma unused grid
		    
		  #else
		    
		    const kSlots as string = "      "
		    
		    var lastIndex as integer = grid.LastIndex
		    
		    
		    for row as integer = 0 to lastIndex
		      var builder() as string
		      
		      for col as integer = 0 to lastIndex
		        var tile as SatelliteTile = grid( row, col )
		        if tile is nil then
		          Print String.FromArray( builder, "" )
		          exit for row
		        end if
		        
		        var item as string = kSlots + tile.ID.ToString
		        item = item.Right( kSlots.Length )
		        builder.Add item
		      next
		      
		      Print String.FromArray( builder, "" )
		    next
		    
		    Print ""
		    
		  #endif
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Tile 2311:\n..##.#..#.\n##..#.....\n#...##..#.\n####.#...#\n##.##.###.\n##...#.###\n.#.#.#..##\n..#....#..\n###...#.#.\n..###..###\n\nTile 1951:\n#.##...##.\n#.####...#\n.....#..##\n#...######\n.##.#....#\n.###.#####\n###.##.##.\n.###....#.\n..#.#..#.#\n#...##.#..\n\nTile 1171:\n####...##.\n#..##.#..#\n##.#..#.#.\n.###.####.\n..###.####\n.##....##.\n.#...####.\n#.##.####.\n####..#...\n.....##...\n\nTile 1427:\n###.##.#..\n.#..#.##..\n.#.##.#..#\n#.#.#.##.#\n....#...##\n...##..##.\n...#.#####\n.#.####.#.\n..#..###.#\n..##.#..#.\n\nTile 1489:\n##.#.#....\n..##...#..\n.##..##...\n..#...#...\n#####...#.\n#..#.#.#.#\n...#.#.#..\n##.#...##.\n..##.##.##\n###.##.#..\n\nTile 2473:\n#....####.\n#..#.##...\n#.##..#...\n######.#.#\n.#...#.#.#\n.#########\n.###.#..#.\n########.#\n##...##.#.\n..###.#.#.\n\nTile 2971:\n..#.#....#\n#...###...\n#.#.###...\n##.##..#..\n.#####..##\n.#..####.#\n#..#.#..#.\n..####.###\n..#.#.###.\n...#.#.#.#\n\nTile 2729:\n...#.#.#.#\n####.#....\n..#.#.....\n....#..#.#\n.##..##.#.\n.#.####...\n####.#.#..\n##.####...\n##..#.##..\n#.##...##.\n\nTile 3079:\n#.#.#####.\n.#..######\n..#.......\n######....\n####.#..#.\n.#...#.##.\n#.#####.##\n..#.###...\n..#.......\n..#.###...", Scope = Private
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
