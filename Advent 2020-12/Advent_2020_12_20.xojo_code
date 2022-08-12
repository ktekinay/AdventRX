#tag Class
Protected Class Advent_2020_12_20
Inherits AdventBase
	#tag Event
		Function CancelRun(type As Types) As Boolean
		  if type <> Types.TestA then
		    return false
		  end if
		  
		  var data as string = _
		  "Tile 1:" + EndOfLine + _
		  "ABCDE" + EndOfLine + _
		  "FGHIJ" + EndOfLine + _
		  "KLMNO" + EndOfLine + _
		  "PQRST" + EndOfLine + _
		  "UVWXY"
		  
		  var tile as new SatelliteTile( data )
		  if tile.ID <> 1 then
		    Print "Test failed at ID"
		    return true
		  end if
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "AFKPU" ) then
		    Print "Test failed at 1"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "ABCDE" ) then
		    Print "Test failed at 2"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "EJOTY" ) then
		    Print "Test failed at 3"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "UVWXY" ) then
		    Print "Test failed at 4"
		    return true
		  end if
		  
		  tile.Orientation = SatelliteTile.Orientations.R90
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "UVWXY" ) then
		    Print "Test failed at 5"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "UPKFA" ) then
		    Print "Test failed at 6"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "ABCDE" ) then
		    Print "Test failed at 7"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "YTOJE" ) then
		    Print "Test failed at 8"
		    return true
		  end if
		  
		  '"ABCDE" + EndOfLine + _
		  '"FGHIJ" + EndOfLine + _
		  '"KLMNO" + EndOfLine + _
		  '"PQRST" + EndOfLine + _
		  '"UVWXY"
		  
		  tile.Orientation = SatelliteTile.Orientations.R180
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "YTOJE" ) then
		    Print "Test failed at 9"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "YXWVU" ) then
		    Print "Test failed at 10"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "UPKFA" ) then
		    Print "Test failed at 11"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "EDCBA" ) then
		    Print "Test failed at 12"
		    return true
		  end if
		  
		  '"ABCDE" + EndOfLine + _
		  '"FGHIJ" + EndOfLine + _
		  '"KLMNO" + EndOfLine + _
		  '"PQRST" + EndOfLine + _
		  '"UVWXY"
		  
		  tile.Orientation = SatelliteTile.Orientations.R270
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "EDCBA" ) then
		    Print "Test failed at 12"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "EJOTY" ) then
		    Print "Test failed at 14"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "YXWVU" ) then
		    Print "Test failed at 15"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "AFKPU" ) then
		    Print "Test failed at 16"
		    return true
		  end if
		  
		  '"ABCDE" + EndOfLine + _
		  '"FGHIJ" + EndOfLine + _
		  '"KLMNO" + EndOfLine + _
		  '"PQRST" + EndOfLine + _
		  '"UVWXY"
		  
		  tile.Orientation = SatelliteTile.Orientations.R0FlippedHorizontal
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "EJOTY" ) then
		    Print "Test failed at 17"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "EDCBA" ) then
		    Print "Test failed at 18"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "AFKPU" ) then
		    Print "Test failed at 19"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "YXWVU" ) then
		    Print "Test failed at 20"
		    return true
		  end if
		  
		  '"ABCDE" + EndOfLine + _
		  '"FGHIJ" + EndOfLine + _
		  '"KLMNO" + EndOfLine + _
		  '"PQRST" + EndOfLine + _
		  '"UVWXY"
		  
		  tile.Orientation = SatelliteTile.Orientations.R90FlippedHorizontal
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "ABCDE" ) then
		    Print "Test failed at 21"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "AFKPU" ) then
		    Print "Test failed at 22"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "UVWXY" ) then
		    Print "Test failed at 23"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "EJOTY" ) then
		    Print "Test failed at 24"
		    return true
		  end if
		  
		  '"ABCDE" + EndOfLine + _
		  '"FGHIJ" + EndOfLine + _
		  '"KLMNO" + EndOfLine + _
		  '"PQRST" + EndOfLine + _
		  '"UVWXY"
		  
		  tile.Orientation = SatelliteTile.Orientations.R180FlippedHorizontal
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "UPKFA" ) then
		    Print "Test failed at 25"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "UVWXY" ) then
		    Print "Test failed at 26"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "YTOJE" ) then
		    Print "Test failed at 27"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "ABCDE" ) then
		    Print "Test failed at 28"
		    return true
		  end if
		  
		  '"ABCDE" + EndOfLine + _
		  '"FGHIJ" + EndOfLine + _
		  '"KLMNO" + EndOfLine + _
		  '"PQRST" + EndOfLine + _
		  '"UVWXY"
		  
		  tile.Orientation = SatelliteTile.Orientations.R270FlippedHorizontal
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "YXWVU" ) then
		    Print "Test failed at 29"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "YTOJE" ) then
		    Print "Test failed at 30"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "EDCBA" ) then
		    Print "Test failed at 31"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "UPKFA" ) then
		    Print "Test failed at 32"
		    return true
		  end if
		  
		  '"ABCDE" + EndOfLine + _
		  '"FGHIJ" + EndOfLine + _
		  '"KLMNO" + EndOfLine + _
		  '"PQRST" + EndOfLine + _
		  '"UVWXY"
		  
		  tile.Orientation = SatelliteTile.Orientations.R0FlippedVertical
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "UPKFA" ) then
		    Print "Test failed at 33"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "UVWXY" ) then
		    Print "Test failed at 34"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "YTOJE" ) then
		    Print "Test failed at 35"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "ABCDE" ) then
		    Print "Test failed at 36"
		    return true
		  end if
		  
		  '"ABCDE" + EndOfLine + _
		  '"FGHIJ" + EndOfLine + _
		  '"KLMNO" + EndOfLine + _
		  '"PQRST" + EndOfLine + _
		  '"UVWXY"
		  
		  tile.Orientation = SatelliteTile.Orientations.R90FlippedVertical
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "YXWVU" ) then
		    Print "Test failed at 37"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "YTOJE" ) then
		    Print "Test failed at 38"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "EDCBA" ) then
		    Print "Test failed at 39"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "UPKFA" ) then
		    Print "Test failed at 40"
		    return true
		  end if
		  
		  '"ABCDE" + EndOfLine + _
		  '"FGHIJ" + EndOfLine + _
		  '"KLMNO" + EndOfLine + _
		  '"PQRST" + EndOfLine + _
		  '"UVWXY"
		  
		  tile.Orientation = SatelliteTile.Orientations.R180FlippedVertical
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "EJOTY" ) then
		    Print "Test failed at 41"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "EDCBA" ) then
		    Print "Test failed at 42"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "AFKPU" ) then
		    Print "Test failed at 43"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "YXWVU" ) then
		    Print "Test failed at 44"
		    return true
		  end if
		  
		  '"ABCDE" + EndOfLine + _
		  '"FGHIJ" + EndOfLine + _
		  '"KLMNO" + EndOfLine + _
		  '"PQRST" + EndOfLine + _
		  '"UVWXY"
		  
		  tile.Orientation = SatelliteTile.Orientations.R270FlippedVertical
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "ABCDE" ) then
		    Print "Test failed at 45"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "AFKPU" ) then
		    Print "Test failed at 46"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "UVWXY" ) then
		    Print "Test failed at 47"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "EJOTY" ) then
		    Print "Test failed at 48"
		    return true
		  end if
		  
		  '"ABCDE" + EndOfLine + _
		  '"FGHIJ" + EndOfLine + _
		  '"KLMNO" + EndOfLine + _
		  '"PQRST" + EndOfLine + _
		  '"UVWXY"
		  
		  tile.Orientation = SatelliteTile.Orientations.R0FlippedBoth
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "YTOJE" ) then
		    Print "Test failed at 49"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "YXWVU" ) then
		    Print "Test failed at 50"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "UPKFA" ) then
		    Print "Test failed at 51"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "EDCBA" ) then
		    Print "Test failed at 52"
		    return true
		  end if
		  
		  '"ABCDE" + EndOfLine + _
		  '"FGHIJ" + EndOfLine + _
		  '"KLMNO" + EndOfLine + _
		  '"PQRST" + EndOfLine + _
		  '"UVWXY"
		  
		  tile.Orientation = SatelliteTile.Orientations.R90FlippedBoth
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "EDCBA" ) then
		    Print "Test failed at 53"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "EJOTY" ) then
		    Print "Test failed at 54"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "YXWVU" ) then
		    Print "Test failed at 55"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "AFKPU" ) then
		    Print "Test failed at 56"
		    return true
		  end if
		  
		  '"ABCDE" + EndOfLine + _
		  '"FGHIJ" + EndOfLine + _
		  '"KLMNO" + EndOfLine + _
		  '"PQRST" + EndOfLine + _
		  '"UVWXY"
		  
		  tile.Orientation = SatelliteTile.Orientations.R270FlippedBoth
		  
		  if tile.LeftHash <> Crypto.SHA2_256( "UVWXY" ) then
		    Print "Test failed at 57"
		    return true
		  end if
		  
		  if tile.TopHash <> Crypto.SHA2_256( "UPKFA" ) then
		    Print "Test failed at 58"
		    return true
		  end if
		  
		  if tile.RightHash <> Crypto.SHA2_256( "ABCDE" ) then
		    Print "Test failed at 59"
		    return true
		  end if
		  
		  if tile.BottomHash <> Crypto.SHA2_256( "YTOJE" ) then
		    Print "Test failed at 60"
		    return true
		  end if
		End Function
	#tag EndEvent

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
		  
		  //
		  // Cycle through each tile in turn
		  //
		  var tileLastIndex as integer = tiles.LastIndex
		  
		  for tileIndex as integer = 0 to tileLastIndex
		    var firstTile as SatelliteTile = tiles.Pop
		    grid( 0, 0 ) = firstTile
		    
		    for orientationIndex as integer = SatelliteTile.kFirstOrientationIndex to SatelliteTile.kLastOrientationIndex
		      var o as SatelliteTile.Orientations = Ctype( orientationIndex, SatelliteTile.Orientations )
		      firstTile.Orientation = o
		      
		      if PlaceNext( grid, tiles, tilesDict ) then
		        //
		        // Success!
		        //
		        return
		      end if
		    next
		    
		    //
		    // Put back the tile
		    //
		    tiles.AddAt 0, firstTile
		  next tileIndex
		  
		  return
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  'if IsTest then
		  'return -1
		  'end if
		  
		  var tiles() as SatelliteTile = ParseInput( input )
		  if IsTest then
		    tiles.Shuffle
		  end if
		  
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
		    
		    for inner as integer = 0 to tiles.LastIndex
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
		Private Function PlaceNext(grid(, ) As SatelliteTile, tiles() As SatelliteTile, tilesDict As Dictionary) As Boolean
		  static aaaIndex as integer = 0
		  
		  if tiles.Count = 0 then
		    return true
		  end if
		  
		  aaaIndex = aaaIndex + 1
		  
		  //
		  // What slot are we in?
		  //
		  var currentSlot as integer = ( grid.Count * grid.Count ) - tiles.Count
		  
		  var gridRow as integer = currentSlot \ grid.Count
		  var gridCol as integer = currentSlot mod grid.Count
		  
		  var tileToLeft as SatelliteTile = if( gridCol > 0, grid( gridRow, gridCol - 1 ), nil )
		  var tileAbove as SatelliteTile = if( gridRow > 0, grid( gridRow - 1, gridCol ), nil )
		  
		  //
		  // Get the intersection of ids that are linked
		  //
		  var linkedTileInfo() as pair = PossibleTiles( tileToLeft, tileAbove )
		  
		  for each info as pair in linkedTileInfo
		    var id as integer = info.Left
		    var orientation as SatelliteTile.Orientations = info.Right
		    
		    var tile as SatelliteTile = tilesDict.Value( id )
		    
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
		    
		    tile.Orientation = orientation
		    
		    if PlaceNext( grid, tiles, tilesDict ) then
		      return true
		    end if
		    
		    //
		    // Put back this tile
		    //
		    tiles.AddAt tilePos, tile
		    tile.Orientation = SatelliteTile.Orientations.R0
		  next
		  
		  grid( gridRow, gridCol ) = nil
		  aaaIndex = aaaIndex - 1
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PossibleTiles(tileToLeft As SatelliteTile, tileAbove As SatelliteTile) As Pair()
		  if tileToLeft is nil then
		    return tileAbove.LinkedBelow
		  end if
		  
		  if tileAbove is nil then
		    return tileToLeft.LinkedAtRight
		  end if
		  
		  var linkedBelow() as pair = tileAbove.LinkedBelow
		  var linkedAtRight() as pair = tileToLeft.LinkedAtRight
		  
		  var result() as Pair
		  
		  for each link1 as Pair in linkedAtRight
		    var id as integer = link1.Left
		    var orientation as SatelliteTile.Orientations = link1.Right
		    
		    for each link2 as Pair in linkedBelow
		      if link2.Left = id and link2.Right = orientation then
		        result.Add link2
		        continue for link1
		      end if
		    next
		    
		  next
		  
		  return result
		  
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
