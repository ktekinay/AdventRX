#tag Class
Protected Class Day6ThreadPool
Inherits ThreadPool
	#tag Event , Description = 496D706C656D656E7420746F2068616E646C652070726F63657373696E67206F66206F6E65206974656D206F6620646174612E
		Sub Process(data As Variant)
		  var settings as Dictionary = data
		  
		  var grid( -1, -1 ) as string = settings.Value( "grid" )
		  var startingRow as integer = settings.Value( "startingRow" )
		  var startingCol as integer = settings.Value( "startingCol" )
		  var startingDirection as string = settings.Value( "startingDirection" )
		  var checkRowStart as integer = settings.Value( "checkRowStart" )
		  var checkRowEnd as integer = settings.Value( "checkRowEnd" )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  checkRowEnd = min( checkRowEnd, lastRowIndex )
		  
		  var thisResult as integer
		  
		  for obstacleRow as integer = checkRowStart to checkRowEnd
		    for obstacleCol as integer = 0 to lastColIndex
		      var char as string = grid( obstacleRow, obstacleCol )
		      if char <> "." then
		        continue for obstacleCol
		      end if
		      
		      grid( obstacleRow, obstacleCol ) = "#"
		      
		      var visited as new Dictionary
		      
		      var row as integer = startingRow
		      var col as integer = startingCol
		      var direction as string = startingDirection
		      
		      do
		        Advent_2024_12_06.Move( grid, direction, row, col )
		        
		        if row < 0 or row > lastRowIndex or col < 0 or col > lastColIndex then
		          exit
		        end if
		        
		        var key as integer = Advent_2024_12_06.Key( row, col, direction )
		        if visited.HasKey( key ) then
		          thisResult = thisResult + 1
		          exit
		        end if
		        
		        visited.Value( key ) = nil
		      loop
		      
		      grid( obstacleRow, obstacleCol ) = "."
		    next
		  next
		  
		  ResultCS.Enter
		  self.Result = self.Result + thisResult
		  ResultCS.Leave
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  super.Constructor
		  
		  ResultCS = new CriticalSection
		  ResultCS.Type = self.Type
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Result As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ResultCS As CriticalSection
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
		#tag ViewProperty
			Name="MaximumJobs"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsFinished"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="QueueLimit"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RemainingInQueue"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsQueueFull"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActiveJobs"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ElapsedMicroseconds"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
