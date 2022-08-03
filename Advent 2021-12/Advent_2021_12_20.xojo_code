#tag Class
Protected Class Advent_2021_12_20
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( GetPuzzleInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddBlanks(image() As String, iteration As Integer)
		  if image.Count = 0 then
		    return
		  end if
		  
		  var isEven as boolean = ( iteration mod 2 ) = 0
		  
		  const kPadding as string = "00"
		  static paddingLength as integer = kPadding.Length
		  
		  static cachedBlankLines() as string
		  
		  const kRowPadding as string = "00"
		  
		  var rowPadding as string = kRowPadding
		  if isEven then
		    rowPadding = rowPadding.ReplaceAll( "0", "1" )
		  end if
		  
		  for row as integer = 0 to image.LastIndex
		    image( row ) = rowPadding + image( row ) + rowPadding
		  next
		  
		  var blankLine as string
		  var lineLength as integer = image( 0 ).Length
		  
		  if cachedBlankLines.LastIndex >= lineLength and cachedBlankLines( lineLength ) <> "" then
		    blankLine = cachedBlankLines( lineLength )
		    
		  else
		    var halfLength as integer = ( lineLength + 1 ) \ 2
		    
		    blankLine = kPadding
		    var blankLineLength as integer = paddingLength
		    
		    while blankLineLength <= halfLength
		      blankLine = blankLine + blankLine
		      blankLineLength = blankLineLength + blankLineLength
		    wend
		    
		    var diff as integer = lineLength - blankLineLength
		    if diff > 0 then
		      blankLine = blankLine + blankLine.Left( diff )
		    elseif diff <= 0 then
		      blankLine = blankLine.Left( lineLength )
		    end if
		    
		    if cachedBlankLines.LastIndex < lineLength then
		      cachedBlankLines.ResizeTo lineLength
		    end if
		    
		    cachedBlankLines( lineLength ) = blankLine
		  end if
		  
		  if isEven then
		    blankLine = blankLine.ReplaceAll( "0", "1" )
		  end if
		  
		  for pass as integer = 1 to 2
		    image.Add blankLine
		    image.AddAt 0, blankLine
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Calculate(input As String, passes As Integer) As Integer
		  var algorithm as string = GetAlgorithm( input )
		  var isLit as boolean = algorithm.Left( 1 ) = "1"
		  
		  var image() as string = GetInputImage( input )
		  'CheckImage image
		  
		  var enhanced() as string = image
		  
		  for pass as integer = 1 to passes
		    if pass = 50 then
		      pass = pass
		    end if
		    AddBlanks enhanced, if( isLit, pass, 1 )
		    enhanced = Enhance( enhanced, algorithm )
		    'CheckImage enhanced
		  next
		  
		  var count as integer
		  for each row as string in enhanced
		    var chars() as string = row.Split( "1" )
		    var thisCount as integer = chars.LastIndex
		    if thisCount <> 0 then
		      count = count + thisCount
		    end if
		  next
		  
		  count = count
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  return Calculate( input, 2 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  return Calculate( input, 50 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckImage(image() As String)
		  for row as integer = 1 to image.LastIndex
		    var b1 as integer = image( row - 1 ).Bytes
		    var b2 as integer = image( row ).Bytes
		    if b1 <> b2 then
		      break
		      return
		    end if
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ConvertToBinary(s As String) As String
		  'static rx as RegEx
		  'if rx is nil then
		  'rx = new RegEx
		  'rx.SearchPattern = "[^\.#\n\r]"
		  'end if
		  '
		  'var match as RegExMatch = rx.Search( s )
		  'if match isa object then
		  'break
		  'end if
		  
		  return s.ReplaceAll( ".", "0" ).ReplaceAll( "#", "1" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Enhance(image() As String, algorithm As String) As String()
		  var result() as string
		  
		  if image.Count = 0 then
		    return result
		  end if
		  
		  const kAllZeros as string = "000000000"
		  
		  for row as integer = 1 to image.LastIndex - 1
		    var prevRow as string = image( row - 1 )
		    var thisRow as string = image( row )
		    var nextRow as string = image( row + 1 )
		    
		    'var checker as string = prevRow + thisRow + nextRow
		    'if checker.ReplaceAll( "0", "" ) = "" then
		    'result.Add thisRow.Left( thisRow.Length - 2 )
		    'continue
		    'end if
		    
		    var firstColIndex as integer = 1
		    var lastColIndex as integer = thisRow.Length - 2
		    
		    var resultRow() as string
		    
		    for col as integer = firstColIndex to lastColIndex
		      var binary as string = prevRow.Middle( col - 1, 3 ) + thisRow.Middle( col - 1, 3 ) + nextRow.Middle( col - 1, 3 )
		      
		      var binaryString as string = "&b" + binary
		      var algorithmIndex as integer = binaryString.ToInteger
		      resultRow.Add algorithm.Middle( algorithmIndex, 1 )
		    next
		    
		    result.Add String.FromArray( resultRow, "" )
		  next
		  
		  result = result
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetAlgorithm(input As String) As String
		  input = input.Trim.ReplaceLineEndings( EndOfLine )
		  
		  if input = "" then
		    return ""
		  end if
		  
		  var parts() as string = input.Split( EndOfLine + EndOfLine )
		  input = parts( 0 )
		  input = input.ReplaceLineEndings( "" )
		  
		  var result as string = ConvertToBinary( input )
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetInputImage(input As String) As String()
		  input = input.Trim.ReplaceLineEndings( EndOfLine )
		  
		  var result() as string
		  
		  if input = "" then
		    return result
		  end if
		  
		  var parts() as string = input.Split( EndOfLine + EndOfLine )
		  input = parts( 1 ).Trim
		  
		  result = ConvertToBinary( input ).Split( EndOfLine )
		  
		  return result
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..##\n#..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###\n.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#.\n.#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#.....\n.#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#..\n...####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.....\n..##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#\n\n#..#.\n#....\n##..#\n..#..\n..###", Scope = Private
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
