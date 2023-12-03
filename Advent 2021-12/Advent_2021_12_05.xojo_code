#tag Class
Protected Class Advent_2021_12_05
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Variant
		  return CalculateResultA( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Variant
		  return CalculateResultB( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Variant
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var grid( kMaxIndex, kMaxIndex ) as integer
		  
		  var coords() as pair = ToPoints( input )
		  
		  for each coord as pair in coords
		    var startPoint as Xojo.Point = coord.Left
		    var endPoint as Xojo.Point = coord.Right
		    
		    if startPoint.X = endPoint.X or startPoint.Y = endPoint.Y then
		      var startX as integer = startPoint.X
		      var endX as integer = endPoint.X
		      MaybeSwap startX, endX
		      
		      var startY as integer = startPoint.Y
		      var endY as integer = endPoint.Y
		      MaybeSwap startY, endY
		      
		      for x as integer = startX to endX
		        for y as integer = startY to endY
		          grid( x, y ) = grid( x, y ) + 1
		        next
		      next
		    end if
		  next coord
		  
		  return CountGrid( grid )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var grid( kMaxIndex, kMaxIndex ) as integer
		  
		  var coords() as pair = ToPoints( input )
		  
		  for each coord as pair in coords
		    var startPoint as Xojo.Point = coord.Left
		    var endPoint as Xojo.Point = coord.Right
		    
		    var x as integer = startPoint.X
		    var y as integer = startPoint.Y
		    
		    var xInc as integer = GetIncrement( startPoint.X, endPoint.X )
		    var yInc as integer = GetIncrement( startPoint.Y, endPoint.Y )
		    
		    do
		      grid( x, y ) = grid( x, y ) + 1
		      
		      if x = endPoint.X and y = endPoint.Y then
		        exit
		      end if
		      x = x + xInc
		      y = y + yInc
		    loop
		    
		  next coord
		  
		  return CountGrid( grid )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountGrid(grid(, ) As Integer) As Integer
		  var count as integer
		  for x as integer = 0 to kMaxIndex
		    for y as integer = 0 to kMaxIndex
		      if grid( x, y ) >= 2 then
		        count = count + 1
		      end if
		    next y
		  next x
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetIncrement(startVal As Integer, endVal As Integer) As Integer
		  if startVal < endVal then
		    return 1
		  elseif startVal > endVal then
		    return -1
		  else
		    return 0
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MaybeSwap(ByRef v1 As Integer, ByRef v2 As Integer)
		  if v1 > v2 then
		    var temp as integer = v1
		    v1 = v2
		    v2 = temp
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToPoints(input As String) As Pair()
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var result() as pair
		  
		  var rx as new RegEx
		  rx.SearchPattern = "(\d+),(\d+) *-> *(\d+),(\d+)$"
		  
		  for each row as string in rows
		    var match as RegExMatch = rx.Search( row.Trim )
		    var p1 as new Xojo.Point
		    p1.X = match.SubExpressionString( 1 ).ToInteger
		    p1.Y = match.SubExpressionString( 2 ).ToInteger
		    
		    var p2 as new Xojo.Point
		    p2.X = match.SubExpressionString( 3 ).ToInteger
		    p2.Y = match.SubExpressionString( 4 ).ToInteger
		    
		    result.Add p1 : p2
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kMaxIndex, Type = Double, Dynamic = False, Default = \"1000", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"0\x2C9 -> 5\x2C9\n8\x2C0 -> 0\x2C8\n9\x2C4 -> 3\x2C4\n2\x2C2 -> 2\x2C1\n7\x2C0 -> 7\x2C4\n6\x2C4 -> 2\x2C0\n0\x2C9 -> 2\x2C9\n3\x2C4 -> 1\x2C4\n0\x2C0 -> 8\x2C8\n5\x2C5 -> 8\x2C2", Scope = Private
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
