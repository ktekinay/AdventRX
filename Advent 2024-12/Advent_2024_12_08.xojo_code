#tag Class
Protected Class Advent_2024_12_08
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Unknown"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Resonant Collinearity"
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
		  input = Normalize( input )
		  
		  var antennas( -1, -1 ) as string = ToStringGrid( input )
		  
		  var lastRowIndex as integer = antennas.LastIndex( 1 )
		  var lastColIndex as integer = antennas.LastIndex( 2 )
		  
		  var antinodes( -1, -1 ) as string = ToStringGrid( input )
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      if antennas( row, col ) <> "." then
		        Map antennas, row, col, antinodes
		      end if
		    next
		  next
		  
		  var count as integer = CountAntinodes( antinodes )
		  
		  return count : if( IsTest, 14, 369 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  input = Normalize( input )
		  
		  var antennas( -1, -1 ) as string = ToStringGrid( input )
		  
		  var lastRowIndex as integer = antennas.LastIndex( 1 )
		  var lastColIndex as integer = antennas.LastIndex( 2 )
		  
		  var antinodes( -1, -1 ) as string = ToStringGrid( input )
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      if antennas( row, col ) <> "." then
		        Map2 antennas, row, col, antinodes
		      end if
		    next
		  next
		  
		  var count as integer = CountAntinodes( antinodes )
		  
		  return count : if( IsTest, 34, 1169 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CountAntinodes(antinodes(, ) As String) As Integer
		  var lastRowIndex as integer = antinodes.LastIndex( 1 )
		  var lastColIndex as integer = antinodes.LastIndex( 2 )
		  
		  var count as integer
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      if antinodes( row, col ) = "#" then
		        count = count + 1
		      end if
		    next
		  next
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Map(antennas(, ) As String, targetRow As Integer, targetCol As Integer, antinodes(, ) As String)
		  var lastRowIndex as integer = antennas.LastIndex( 1 )
		  var lastColIndex as integer = antennas.LastIndex( 2 )
		  
		  var targetChar as string = antennas( targetRow, targetCol )
		  var targetCode as integer = targetChar.Asc
		  
		  var row as integer = targetRow
		  var col as integer = targetCol
		  
		  do
		    col = col + 1
		    
		    if col > lastColIndex then
		      col = 0
		      row = row + 1
		      
		      if row > lastRowIndex then
		        exit
		      end if
		    end if
		    
		    var char as string = antennas( row, col )
		    if char <> targetChar or char.Asc <> targetCode then
		      continue
		    end if
		    
		    var rowDiff as integer = row - targetRow
		    var colDiff as integer = col - targetCol
		    
		    var aRow as integer = targetRow - rowDiff
		    var aCol as integer = targetCol - colDiff
		    
		    if aRow >= 0 and aRow <= lastRowIndex and aCol >= 0 and aCol <= lastColIndex then
		      antinodes( aRow, aCol ) = "#"
		    end if
		    
		    aRow = row + rowDiff
		    aCol = col + colDiff
		    
		    if aRow >= 0 and aRow <= lastRowIndex and aCol >= 0 and aCol <= lastColIndex then
		      antinodes( aRow, aCol ) = "#"
		    end if
		  loop
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Map2(antennas(, ) As String, targetRow As Integer, targetCol As Integer, antinodes(, ) As String)
		  var lastRowIndex as integer = antennas.LastIndex( 1 )
		  var lastColIndex as integer = antennas.LastIndex( 2 )
		  
		  var targetChar as string = antennas( targetRow, targetCol )
		  var targetCode as integer = targetChar.Asc
		  
		  var row as integer = targetRow
		  var col as integer = targetCol
		  
		  do
		    col = col + 1
		    
		    if col > lastColIndex then
		      col = 0
		      row = row + 1
		      
		      if row > lastRowIndex then
		        exit
		      end if
		    end if
		    
		    var char as string = antennas( row, col )
		    if char <> targetChar or char.Asc <> targetCode then
		      continue
		    end if
		    
		    var rowDiff as integer = row - targetRow
		    var colDiff as integer = col - targetCol
		    
		    var aRow as integer = targetRow
		    var aCol as integer = targetCol
		    
		    while ( aRow - rowDiff ) >= 0 and ( aCol - colDiff ) >= 0 and ( aCol - colDiff ) <= lastColIndex
		      aRow = aRow - rowDiff
		      aCol = aCol - colDiff
		    wend
		    
		    do
		      antinodes( aRow, aCol ) = "#"
		      aRow = aRow + rowDiff
		      aCol = aCol + colDiff
		    loop until aRow > lastRowIndex or aCol < 0 or aCol > lastColIndex
		  loop
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"............\n........0...\n.....0......\n.......0....\n....0.......\n......A.....\n............\n............\n........A...\n.........A..\n............\n............", Scope = Private
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
