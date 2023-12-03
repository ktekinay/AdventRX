#tag Class
Protected Class Advent_2022_12_08
Inherits AdventBase
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Function ReturnDescription() As String
		  return "Scan a forest"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Treetop Tree House"
		  
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
		Private Function CalculateResultA(input As String) As Integer
		  var grid as ObjectGrid = ToGrid( input )
		  
		  var count as integer = CountVisible( grid )
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  var grid as ObjectGrid = ToGrid( input )
		  
		  var maxScore as integer
		  
		  for each square as GridMember in grid
		    maxScore = max( maxScore, ScenicScore( grid, square ) )
		  next
		  
		  maxScore = maxScore
		  return maxScore
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountVisible(grid As ObjectGrid) As Integer
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  var lastRowIndex as integer = grid.LastRowIndex
		  var lastColIndex as integer = grid.LastColIndex
		  
		  var directionals() as ObjectGrid.NextDelegate = grid.MainDirectionals
		  
		  var count as integer 
		  
		  for each square as GridMember in grid
		    if square.Row = 0 or square.Column = 0 or square.Row = lastRowIndex or square.Column = lastColIndex then
		      count = count + 1
		      continue for square
		    end if
		    
		    var height as integer = square.RawValue
		    
		    for each directional as ObjectGrid.NextDelegate in directionals
		      var thisSquare as GridMember = square
		      
		      do
		        thisSquare = directional.Invoke( thisSquare )
		        if thisSquare is nil then
		          count = count + 1
		          continue for square
		        end if
		        
		        if thisSquare.RawValue.IntegerValue >= height then
		          continue for directional
		        end if
		      loop
		    next
		  next
		  
		  count = count
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ScenicScore(grid As ObjectGrid, square As GridMember) As Integer
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  if square.Row = 0 or square.Row = grid.LastRowIndex or square.Column = 0 or square.Column = grid.LastColIndex then
		    return 0
		  end if
		  
		  var directionals() as ObjectGrid.NextDelegate = grid.MainDirectionals
		  
		  var height as integer = square.RawValue
		  
		  var score as integer = 1
		  
		  for each directional as ObjectGrid.NextDelegate in directionals
		    var nextSquare as GridMember = square
		    var thisScore as integer
		    
		    do
		      nextSquare = directional.Invoke( nextSquare )
		      if nextSquare is nil then
		        exit do
		      end if
		      
		      thisScore = thisScore + 1
		      
		      if nextSquare.RawValue >= height then
		        exit
		      end if
		    loop
		    
		    score = score * thisScore
		  next
		  
		  score = score
		  return score
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToGrid(input As String) As ObjectGrid
		  var igrid( -1, -1 ) as integer = ToIntegerGrid( input )
		  return ObjectGrid.FromIntegerGrid( igrid )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"30373\n25512\n65332\n33549\n35390", Scope = Private
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
