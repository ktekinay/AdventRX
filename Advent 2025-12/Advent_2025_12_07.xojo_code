#tag Class
Protected Class Advent_2025_12_07
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Splitters and timelines"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Laboratories"
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
		  if kTestInput <> "" then
		    return CalculateResultA( Normalize( kTestInput ) )
		  end if
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  if input <> "" then
		    return CalculateResultB( Normalize( input ) )
		  end if
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  var grid( -1, -1 ) as string = ToStringGrid( input )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var keyMaker as integer = lastColIndex + 1
		  
		  var stack() as integer
		  
		  var startRow as integer
		  var startCol as integer
		  
		  FindStart( grid, startRow, startCol )
		  
		  stack.Add startRow * keyMaker + startCol
		  
		  var splits as integer
		  
		  var visited as new Set
		  visited.Add stack( 0 )
		  
		  while stack.Count <> 0
		    var pos as integer = stack.Pop
		    var row as integer = pos \ keyMaker
		    var col as integer = pos mod keyMaker
		    
		    do
		      row = row + 1
		      
		      if row > lastRowIndex then
		        exit do
		      end if
		      
		      var checkPos as integer = row * keyMaker + col
		      
		      if visited.HasMember( checkPos ) then
		        exit do
		      end if
		      
		      visited.Add checkPos
		      
		      if grid( row, col ) = "^" then
		        splits = splits + 1
		        
		        if col < lastColIndex then
		          var posRight as integer = row * keyMaker + ( col + 1 )
		          stack.Add posRight
		        end if
		        
		        if col > 0 then
		          col = col - 1
		          continue
		        else
		          exit do
		        end if
		      end if
		    loop
		  wend
		  
		  var testAnswer as variant = 21
		  var answer as variant = 1675
		  
		  return splits : if( IsTest, testAnswer, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var grid( -1, -1 ) as string = ToStringGrid( input )
		  
		  var startRow as integer
		  var startCol as integer
		  
		  FindStart( grid, startRow, startCol )
		  
		  var timelines as integer = FollowTimeLine( grid, startRow, startCol, new Dictionary )
		  
		  var testAnswer as variant = 40
		  var answer as variant = 187987920774390
		  
		  return timelines : if( IsTest, testAnswer, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub FindStart(grid(, ) As String, ByRef foundRow As Integer, ByRef foundCol As Integer)
		  for row as integer = 0 to grid.LastIndex( 1 )
		    for col as integer = 0 to grid.LastIndex( 2 )
		      if grid( row, col ) = "S" then
		        foundRow = row
		        foundCol = col
		        return
		      end if
		    next
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FollowTimeLine(grid(, ) As String, row As Integer, col As Integer, cache As Dictionary) As Integer
		  var keyMaker as integer = grid.LastIndex( 2 ) + 1
		  var startingKey as integer = row * keyMaker + col
		  
		  if cache.HasKey( startingKey ) then
		    return cache.Value( startingKey ).IntegerValue
		  end if
		  
		  var count as integer = 1
		  
		  do
		    row = row + 1
		    
		    if row > grid.LastIndex( 1 ) then
		      exit
		    end if
		    
		    var key as integer = row * keyMaker + col
		    
		    if cache.HasKey( key ) then
		      count = cache.Value( key ).IntegerValue
		      exit
		    end if
		    
		    if grid( row, col ) = "^" then
		      count = FollowTimeLine( grid, row, col - 1, cache ) + FollowTimeLine( grid, row, col + 1, cache )
		      exit
		    end if
		  loop
		  
		  cache.Value( startingKey ) = count
		  
		  return count
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \".......S.......\n...............\n.......^.......\n...............\n......^.^......\n...............\n.....^.^.^.....\n...............\n....^.^...^....\n...............\n...^.^...^.^...\n...............\n..^...^.....^..\n...............\n.^.^.^.^.^...^.\n...............\n", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2025
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
