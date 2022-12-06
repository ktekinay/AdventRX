#tag Class
Protected Class Advent_2015_12_06
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Increment lights"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Probably a Fire Hazard"
		  
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
		  var grid( 999, 999 ) as boolean
		  
		  Follow input, grid
		  return Count( grid, true )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var grid( 999, 999 ) as integer
		  var instructions() as string = ToStringArray( input )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "^(turn \w+|toggle) (\d+),(\d+) through (\d+),(\d+)"
		  
		  for each instruction as string in instructions
		    var match as RegExMatch = rx.Search( instruction )
		    var action as string = match.SubExpressionString( 1 )
		    var x1 as integer = match.SubExpressionString( 2 ).ToInteger
		    var y1 as integer = match.SubExpressionString( 3 ).ToInteger
		    var x2 as integer = match.SubExpressionString( 4 ).ToInteger
		    var y2 as integer = match.SubExpressionString( 5 ).ToInteger
		    
		    for x as integer = x1 to x2
		      for y as integer = y1 to y2
		        select case action
		        case "toggle"
		          grid( x, y ) = grid( x, y ) + 2
		        case "turn on"
		          grid( x, y ) = grid( x, y ) + 1
		        case else
		          grid( x, y ) = max( grid( x, y ) - 1, 0 )
		        end select
		      next
		    next
		    
		  next
		  
		  var total as integer 
		  
		  for x as integer = 0 to grid.LastIndex( 1 )
		    for y as integer = 0 to grid.LastIndex( 2 )
		      total = total + grid( x, y )
		    next
		  next
		  
		  return total
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Count(grid(, ) As Boolean, value As Boolean) As Integer
		  var count as integer
		  
		  for x as integer = 0 to grid.LastIndex( 1 )
		    for y as integer = 0 to grid.LastIndex( 2 )
		      if grid( x, y ) = value then
		        count = count + 1
		      end if
		    next
		  next
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Follow(input As String, grid(, ) As Boolean)
		  var instructions() as string = ToStringArray( input )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "^(turn \w+|toggle) (\d+),(\d+) through (\d+),(\d+)"
		  
		  for each instruction as string in instructions
		    var match as RegExMatch = rx.Search( instruction )
		    var action as string = match.SubExpressionString( 1 )
		    var x1 as integer = match.SubExpressionString( 2 ).ToInteger
		    var y1 as integer = match.SubExpressionString( 3 ).ToInteger
		    var x2 as integer = match.SubExpressionString( 4 ).ToInteger
		    var y2 as integer = match.SubExpressionString( 5 ).ToInteger
		    
		    for x as integer = x1 to x2
		      for y as integer = y1 to y2
		        select case action
		        case "toggle"
		          grid( x, y ) = not grid( x, y )
		        case "turn on"
		          grid( x, y ) = true
		        case else
		          grid( x, y ) = false
		        end select
		      next
		    next
		    
		  next
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"", Scope = Private
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
