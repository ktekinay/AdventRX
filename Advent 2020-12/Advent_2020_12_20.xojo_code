#tag Class
Protected Class Advent_2020_12_20
Inherits AdventBase
	#tag Event
		Function CancelRun(type As Types) As Boolean
		  if type <> Types.TestA then
		    return false
		  end if
		  
		  var writeGrid( 2, 2 ) as string
		  
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
		  
		  tile.WriteTo writeGrid, 0, 0
		  if writeGrid( 0, 0 ) <> "G" or writeGrid( 2, 2 ) <> "S" then
		    Print "Failed WriteTo R0"
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
		  
		  tile.WriteTo writeGrid, 0, 0
		  if writeGrid( 0, 0 ) <> "Q" or writeGrid( 2, 2 ) <> "I" then
		    Print "Failed WriteTo R90"
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
		  
		  tile.WriteTo writeGrid, 0, 0
		  if writeGrid( 0, 0 ) <> "I" or writeGrid( 2, 2 ) <> "Q" then
		    Print "Failed WriteTo R90FlippedBoth"
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
		  
		  var breadcrumbs as new Dictionary
		  
		  //
		  // Cycle through each tile in turn
		  //
		  var tileLastIndex as integer = tiles.LastIndex
		  
		  for tileIndex as integer = 0 to tileLastIndex
		    var thisTile as SatelliteTile = tiles( tileIndex )
		    grid( 0, 0 ) = thisTile
		    thisTile.IsInUse = true
		    
		    for orientationIndex as integer = SatelliteTile.kFirstOrientationIndex to SatelliteTile.kLastOrientationIndex
		      var o as SatelliteTile.Orientations = Ctype( orientationIndex, SatelliteTile.Orientations )
		      thisTile.Orientation = o
		      
		      if PlaceNext( grid, 1, tilesDict, breadcrumbs ) then
		        //
		        // Success!
		        //
		        return
		      end if
		    next
		    
		    //
		    // Put back the tile
		    //
		    thisTile.IsInUse = false
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
		  
		  if IsTest then
		    TestGrid = grid
		  else
		    PuzzleGrid = grid
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  #pragma unused input
		  
		  var tiles( -1, -1 ) as SatelliteTile = if( IsTest, TestGrid, PuzzleGrid )
		  
		  var tilesAcross as integer = tiles.Count
		  var tileWidth as integer = tiles( 0, 0 ).Grid.Count - 2
		  
		  var gridWidth as integer = tilesAcross * tileWidth
		  var lastIndex as integer = gridWidth - 1
		  
		  var grid( -1, -1 ) as string
		  grid.ResizeTo lastIndex, lastIndex
		  
		  var writeRow as integer
		  var writeCol as integer
		  
		  for tileRow as integer = 0 to tiles.LastIndex
		    for tileCol as integer = 0 to tiles.LastIndex
		      var tile as SatelliteTile = tiles( tileRow, tileCol )
		      tile.WriteTo grid, writeRow, writeCol
		      
		      writeCol = writeCol + tileWidth
		      if writeCol > lastIndex then
		        writeCol = 0
		        writeRow = writeRow + tileWidth
		      end if
		    next
		  next
		  
		  'if IsTest then
		  'PrintGrid TestGrid
		  'PrintStringGrid grid
		  'end if
		  
		  var monsterMap() as Xojo.Point = MapMonster
		  
		  var identifiedMonsterMap() as Xojo.Point = FindMonsterVertical( grid, monsterMap )
		  if identifiedMonsterMap.Count = 0 then
		    identifiedMonsterMap = FindMonsterHorizontal( grid, monsterMap )
		  end if
		  
		  //
		  // Count the "#" in the grid
		  //
		  var cnt as integer
		  for row as integer = 0 to grid.LastIndex
		    for col as integer = 0 to grid.LastIndex
		      if grid( row, col ) = "#" then
		        cnt = cnt + 1
		      end if
		    next
		  next
		  
		  cnt = cnt - identifiedMonsterMap.Count
		  return cnt // NOT 2294
		  return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FindMonsterHorizontal(grid(, ) As String, monsterMap() As Xojo.Point) As Xojo.Point()
		  var result() as Xojo.Point
		  
		  var lastIndex as integer = grid.LastIndex
		  
		  var firstRow as integer = 0
		  var lastRow as integer = lastIndex
		  
		  var firstCol as integer = 0
		  var lastCol as integer = lastIndex
		  
		  var rowStep as integer = 1
		  var colStep as integer = 1
		  
		  for repeats as integer = 1 to 4
		    for row as integer = firstRow to lastRow step rowStep
		      for col as integer = firstCol to lastCol step colStep
		        var testRow as integer = row
		        var testCol as integer = col
		        var cleanResultIndex as integer = result.LastIndex
		        
		        for each pt as Xojo.Point in monsterMap
		          testRow = testRow + ( pt.Y * rowStep )
		          testCol = testCol + ( pt.X * colStep )
		          if testRow < 0 or testRow > lastIndex or testCol < 0 or testCol > lastIndex or grid( testCol, testRow ) <> "#" then
		            result.ResizeTo cleanResultIndex
		            continue for col
		          end if
		          
		          result.Add new Xojo.Point( testCol, testRow )
		        next
		      next col
		    next row
		    
		    if result.Count <> 0 then
		      return result
		    end if
		    
		    if colStep = 1 then
		      firstCol = lastIndex
		      lastCol = 0
		      colStep = -1
		      
		    elseif rowStep = 1 then
		      firstRow = lastIndex
		      lastRow = 0
		      rowStep = -1
		      
		    else
		      firstCol = 0
		      lastCol = lastIndex
		      colStep = 1
		      
		    end if
		  next repeats
		  
		  return result
		  
		  // 1: 1, 1
		  // 2: -1, 1
		  // 3: -1, -1
		  // 4: 1, -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FindMonsterVertical(grid(, ) As String, monsterMap() As Xojo.Point) As Xojo.Point()
		  var result() as Xojo.Point
		  
		  var lastIndex as integer = grid.LastIndex
		  
		  var firstRow as integer = 0
		  var lastRow as integer = lastIndex
		  
		  var firstCol as integer = 0
		  var lastCol as integer = lastIndex
		  
		  var rowStep as integer = 1
		  var colStep as integer = 1
		  
		  for repeats as integer = 1 to 4
		    for row as integer = firstRow to lastRow step rowStep
		      for col as integer = firstCol to lastCol step colStep
		        var testRow as integer = row
		        var testCol as integer = col
		        var cleanResultIndex as integer = result.LastIndex
		        
		        for each pt as Xojo.Point in monsterMap
		          testRow = testRow + ( pt.Y * rowStep )
		          testCol = testCol + ( pt.X * colStep )
		          if testRow < 0 or testRow > lastIndex or testCol < 0 or testCol > lastIndex or grid( testRow, testCol ) <> "#" then
		            result.ResizeTo cleanResultIndex
		            continue for col
		          end if
		          
		          result.Add new Xojo.Point( testCol, testRow )
		        next
		      next col
		    next row
		    
		    if result.Count <> 0 then
		      return result
		    end if
		    
		    if colStep = 1 then
		      firstCol = lastIndex
		      lastCol = 0
		      colStep = -1
		      
		    elseif rowStep = 1 then
		      firstRow = lastIndex
		      lastRow = 0
		      rowStep = -1
		      
		    else
		      firstCol = 0
		      lastCol = lastIndex
		      colStep = 1
		      
		    end if
		  next repeats
		  
		  return result
		  
		  // 1: 1, 1
		  // 2: -1, 1
		  // 3: -1, -1
		  // 4: 1, -1
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
		Private Function MapMonster() As Xojo.Point()
		  var monsterGrid( -1, -1 ) as string
		  monsterGrid = ToStringGrid( kMonster )
		  
		  var map() as Xojo.Point
		  
		  var lastRowIndex as integer = monsterGrid.LastIndex( 1 )
		  var lastColIndex as integer = monsterGrid.LastIndex( 2 )
		  
		  var prevRow as integer = -1
		  var prevCol as integer = -1
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      var char as string = monsterGrid( row, col )
		      
		      if char = "#" then
		        var rowDiff as integer = row
		        var colDiff as integer = col
		        
		        if prevRow <> -1 then
		          rowDiff = row - prevRow
		          colDiff = col - prevCol
		        end if
		        
		        map.Add new Xojo.Point( colDiff, rowDiff )
		        prevRow = row
		        prevCol = col
		      end if
		    next
		  next
		  
		  return map
		  
		  
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
		Private Function PlaceNext(grid(, ) As SatelliteTile, currentSlot As Integer, tilesDict As Dictionary, breadcrumbs As Dictionary) As Boolean
		  static aaaIndex as integer = 0
		  
		  if currentSlot = tilesDict.KeyCount then
		    return true
		  end if
		  
		  aaaIndex = aaaIndex + 1
		  
		  //
		  // What slot are we in?
		  //
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
		    
		    var bkey as string = gridRow.ToString + ":" + gridCol.ToString + ":" + id.ToString + ":" + integer( orientation ).ToString
		    
		    if breadcrumbs.HasKey( bkey ) then
		      'Print aaaIndex.ToString + ": ALREADY TRIED ID " + id.ToString
		      continue for info
		    end if
		    
		    'Print aaaIndex.ToString + ": Trying id " + id.ToString + ", orientation " + integer( orientation ).ToString
		    
		    var tile as SatelliteTile = tilesDict.Value( id )
		    if tile.IsInUse then
		      'Print aaaIndex.ToString + ": ...in use, continuing"
		      continue
		    end if
		    
		    tile.IsInUse = true
		    tile.Orientation = orientation
		    
		    grid( gridRow, gridCol ) = tile
		    'PrintGrid grid
		    
		    breadcrumbs.Value( bkey ) = nil
		    
		    if PlaceNext( grid, currentSlot + 1, tilesDict, breadcrumbs ) then
		      return true
		    end if
		    
		    //
		    // Put back this tile
		    //
		    tile.IsInUse = false
		    tile.Orientation = SatelliteTile.Orientations.R0
		    grid( gridRow, gridCol ) = nil
		  next
		  
		  'Print aaaIndex.ToString + ": ...no more to try"
		  
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
		Private Sub Print(msg As Variant)
		  #if kDebug then
		    Super.Print(msg)
		  #else
		    #pragma unused msg
		  #endif
		End Sub
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


	#tag Property, Flags = &h21
		Private PuzzleGrid(-1,-1) As SatelliteTile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private TestGrid(-1,-1) As SatelliteTile
	#tag EndProperty


	#tag Constant, Name = kDebug, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kMonster, Type = String, Dynamic = False, Default = \"                  # \n#    ##    ##    ###\n #  #  #  #  #  #   ", Scope = Private
	#tag EndConstant

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
