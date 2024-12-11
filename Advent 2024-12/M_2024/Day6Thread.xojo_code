#tag Class
Protected Class Day6Thread
Inherits Thread
	#tag Event
		Sub Run()
		  var dotCode as integer = Asc( "." )
		  var poundCode as integer = Asc( "#" )
		  
		  var grid as MemoryBlock = self.Grid
		  var gridPtr as ptr = grid
		  
		  var lastRowIndex as integer = self.LastRowIndex
		  var lastColIndex as integer = self.LastColIndex
		  
		  var rowCount as integer = lastRowIndex + 1
		  var colCount as integer = lastColIndex + 1
		  var counterLimit as integer = rowCount * colCount + 1
		  
		  var startingRow as integer = self.StartingRow
		  var startingCol as integer = self.StartingCol
		  
		  var startingDirection as integer
		  select case self.StartingDirection
		  case "^"
		    startingDirection = 0
		  case ">"
		    startingDirection = 1
		  case "v"
		    startingDirection = 2
		  case "<"
		    startingDirection = 3
		  end select
		  
		  var visitedArr() as variant = ParseJSON( VisitedJSON )
		  var visited as new Dictionary
		  for each v as variant in visitedArr
		    visited.Value( v ) = nil
		  next
		  
		  var result as integer
		  
		  var startingObstacleRow as integer = self.StartingObstacleRow
		  var endingObstacleRow as integer = min( self.EndingObstacleRow, lastRowIndex )
		  
		  for obstacleRow as integer = startingObstacleRow to endingObstacleRow
		    for obstacleCol as integer = 0 to lastColIndex
		      var obstacleIndex as integer = obstacleRow * colCount + obstacleCol
		      
		      if not visited.HasKey( obstacleIndex ) then
		        continue
		      end if
		      
		      var char as integer = gridPtr.Byte( obstacleIndex )
		      
		      if char <> dotCode then
		        continue for obstacleCol
		      end if
		      
		      gridPtr.Byte( obstacleIndex ) = poundCode
		      
		      var row as integer = startingRow
		      var col as integer = startingCol
		      var direction as integer = startingDirection
		      
		      var counter as integer
		      
		      do
		        counter = counter + 1
		        if counter > counterLimit then
		          result = result + 1
		          exit
		        end if
		        
		        //
		        // Move
		        //
		        var newRow as integer
		        var newCol as integer 
		        
		        do
		          newRow = row
		          newCol = col
		          
		          select case direction
		          case 0
		            newRow = newRow - 1
		          case 1
		            newCol = newCol + 1
		          case 2
		            newRow = newRow + 1
		          case 3
		            newCol = newCol - 1
		          end select
		          
		          if newRow < 0 or newRow > lastRowIndex or _
		            newCol < 0 or newCol > lastColIndex then
		            row = -1
		            exit
		          end if
		          
		          var newByteIndex as integer = newRow * colCount + newCol
		          
		          if gridPtr.Byte( newByteIndex ) <> poundCode then
		            row = newRow
		            col = newCol
		            exit
		          end if
		          
		          direction = ( direction + 1 ) mod 4
		        loop
		        
		        if row < 0 then 
		          exit
		        end if
		      loop
		      
		      gridPtr.Byte( obstacleIndex ) = dotCode
		    next
		  next
		  
		  self.Result = result
		  
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h0
		EndingObstacleRow As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		EndingRow As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Grid As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h0
		LastColIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		LastRowIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Result As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		StartingCol As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		StartingDirection As String
	#tag EndProperty

	#tag Property, Flags = &h0
		StartingObstacleRow As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		StartingRow As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		VisitedJSON As String
	#tag EndProperty


	#tag ViewBehavior
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
			InitialValue=""
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
			Name="StartingRow"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EndingRow"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Result"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StartingCol"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StartingObstacleRow"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EndingObstacleRow"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StartingDirection"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastRowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastColIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
