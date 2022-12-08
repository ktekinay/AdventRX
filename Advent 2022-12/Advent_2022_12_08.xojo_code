#tag Class
Protected Class Advent_2022_12_08
Inherits AdventBase
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
		  var grid( -1, -1 ) as integer = ToIntegerGrid( input )
		  
		  return CountVisible( grid )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var grid( -1, -1 ) as integer = ToIntegerGrid( input )
		  
		  var maxScore as integer
		  
		  for row as integer = 0 to grid.LastIndex( 1 )
		    for col as integer = 0 to grid.LastIndex( 2 )
		      maxScore = max( maxScore, ScenicScore( grid, row, col ) )
		    next
		  next
		  
		  return maxScore
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountVisible(grid(, ) As Integer) As Integer
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var count as integer 
		  
		  for row as integer = 0 to lastRowIndex 
		    for col as integer = 0 to lastColIndex 
		      if row = 0 or col = 0 or row = lastRowIndex or col = lastColIndex then
		        count = count + 1
		        continue for col
		      end if
		      
		      var height as integer = grid( row, col )
		      
		      var foundEdge as boolean = true
		      
		      for rowEdge as integer = 0 to row - 1
		        var testHeight as integer = grid( rowEdge, col )
		        if testHeight >= height then
		          foundEdge = false
		          exit
		        end if
		      next
		      
		      if foundEdge = false then
		        foundEdge = true
		        for rowEdge as integer = row + 1 to lastRowIndex
		          var testHeight as integer = grid( rowEdge, col )
		          if testHeight >= height then
		            foundEdge = false
		            exit
		          end if
		        next
		      end if
		      
		      if foundEdge = false then
		        foundEdge = true
		        for colEdge as integer = 0 to col - 1
		          var testHeight as integer = grid( row, colEdge )
		          if testHeight >= height then
		            foundEdge = false
		            exit
		          end if
		        next
		      end if
		      
		      if foundEdge = false then
		        foundEdge = true
		        for colEdge as integer = col + 1 to lastColIndex
		          var testHeight as integer = grid( row, colEdge )
		          if testHeight >= height then
		            foundEdge = false
		            exit
		          end if
		        next
		      end if
		      
		      if foundEdge then
		        count = count + 1
		      end if
		    next
		  next
		  
		  count = count
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ScenicScore(grid(, ) As Integer, row As Integer, col As Integer) As Integer
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  if row = 0 or col = 0 or row = lastRowIndex or col = lastColIndex then
		    return 0
		  end if
		  
		  if IsTest and row = 3 and col = 2 then
		    row = row
		  end if
		  
		  var height as integer = grid( row, col )
		  
		  var counts() as integer
		  var count as integer
		  
		  count = 0
		  for testRow as integer = row - 1 downto 0
		    count = count + 1
		    
		    var testHeight as integer = grid( testRow, col )
		    if testHeight >= height then
		      exit
		    end if
		  next
		  
		  counts.Add count
		  
		  count = 0
		  for testRow as integer = row + 1 to lastRowIndex
		    count = count + 1
		    
		    var testHeight as integer = grid( testRow, col )
		    if testHeight >= height then
		      exit
		    end if
		  next
		  
		  counts.Add count
		  
		  count = 0
		  for testCol as integer = col - 1 downto 0
		    count = count + 1
		    
		    var testHeight as integer = grid( row, testCol )
		    if testHeight >= height then
		      exit
		    end if
		  next
		  
		  counts.Add count
		  
		  count = 0
		  for testCol as integer = col + 1 to lastColIndex
		    count = count + 1
		    
		    var testHeight as integer = grid( row, testCol )
		    if testHeight >= height then
		      exit
		    end if
		  next
		  
		  counts.Add count
		  
		  var mult as integer = 1
		  for each count in counts
		    mult = mult * count
		  next
		  
		  return mult
		  
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
