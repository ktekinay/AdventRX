#tag Class
Protected Class Advent_2025_12_04
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Count rolls of paper that can be moved"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Printing Department"
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
		  var points() as Xojo.Point = MapPoints( grid )
		  
		  var count as integer = RemoveRolls( points, grid, false )
		  
		  var answer as variant = 1397
		  return count : if( IsTest, 13, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var grid( -1, -1 ) as string = ToStringGrid( input )
		  
		  var points() as Xojo.Point = MapPoints( grid )
		  
		  var count as integer
		  
		  do
		    var lastCount as integer = count
		    
		    count = count + RemoveRolls( points, grid, true )
		    
		    if count = lastCount then
		      exit
		    end if  
		  loop
		  
		  var answer as variant = 8758
		  return count : if( IsTest, 43, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function MapPoints(grid(, ) As String) As Xojo.Point()
		  var points() as Xojo.Point
		  
		  for x as integer = 0 to grid.LastIndex( 1 )
		    for y as integer = 0 to grid.LastIndex( 2 )
		      if grid( x, y ) = "@" then
		        points.Add new Xojo.Point( x, y )
		      end if
		    next
		  next
		  
		  return points
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RemoveRolls(points() As Xojo.Point, grid(, ) As String, doRemove As Boolean) As Integer
		  var count as integer
		  
		  for ptIndex as integer = points.LastIndex downto 0
		    var pt as Xojo.Point = points( ptIndex )
		    
		    var x as integer = pt.X
		    var y as integer = pt.Y
		    
		    var tester as string = grid( x, y )
		    
		    var adjCount as integer
		    
		    for deltax as integer = -1 to 1
		      var testx as integer = x + deltax
		      
		      if testx < 0 or testx > grid.LastIndex( 1 ) then
		        continue
		      end if
		      
		      for deltay as integer = -1 to 1
		        if deltay = 0 and deltax = 0 then 
		          continue
		        end if
		        
		        var testy as integer = y + deltay
		        
		        if testy < 0 or testy > grid.LastIndex( 2 ) then
		          continue
		        end if
		        
		        var compare as string = grid( testx, testy )
		        
		        if compare = "@" then
		          adjCount = adjCount + 1
		          
		          if adjCount = 4 then
		            continue for ptIndex
		          end if
		        end if
		      next
		    next
		    
		    count = count + 1
		    
		    if doRemove then
		      grid( x, y ) = "."
		      points.RemoveAt ptIndex
		    end if
		  next
		  
		  return count
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"..@@.@@@@.\n@@@.@.@.@@\n@@@@@.@.@@\n@.@@@@..@.\n@@.@@@@.@@\n.@@@@@@@.@\n.@.@.@.@@@\n@.@@@.@@@@\n.@@@@@@@@.\n@.@.@@@.@.", Scope = Private
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
