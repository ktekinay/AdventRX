#tag Class
Protected Class Advent_2021_12_11
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Flash energy levels"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Dumbo Octopus"
		  
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

	#tag Event
		Function RunTestB() As Variant
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var grid( -1, -1 ) as integer = ToGrid( input )
		  
		  var flashCount as integer
		  
		  for stepper as integer = 1 to 100
		    IncrementGrid( grid )
		    flashCount = flashCount + Flash( grid )
		  next
		  
		  return flashCount
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var grid( -1, -1 ) as integer = ToGrid( input )
		  
		  var stepper as integer
		  
		  do
		    stepper = stepper + 1
		    
		    IncrementGrid( grid )
		    call Flash( grid )
		    
		    for row as integer = 0 to 9
		      for col as integer = 0 to 9
		        if grid( row, col ) <> 0 then
		          continue do
		        end if
		      next col
		    next row
		    
		    //
		    // If we get here, it's all zeros
		    //
		    exit
		  loop
		  
		  return stepper
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Flash(grid(, ) As Integer) As Integer
		  var count as integer
		  
		  for row as integer = 0 to 9
		    for col as integer = 0 to 9
		      var value as integer = grid( row, col )
		      if value > 9 then
		        count = count + 1
		        grid( row, col ) = 0
		      end if
		    next col
		  next row
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Increment(grid(, ) As Integer, row As Integer, col As Integer)
		  if row < 0 or row > 9 or col < 0 or col > 9 then
		    return
		  end if
		  
		  var value as integer = grid( row, col )
		  if value > 9 then
		    return
		  end if
		  
		  value = value + 1
		  grid( row, col ) = value
		  
		  if value > 9 then
		    Increment( grid, row - 1, col - 1 )
		    Increment( grid, row - 1, col )
		    Increment( grid, row - 1, col + 1 )
		    Increment( grid, row, col - 1 )
		    Increment( grid, row, col + 1 )
		    Increment( grid, row + 1, col - 1 )
		    Increment( grid, row + 1, col )
		    Increment( grid, row + 1, col + 1 )
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub IncrementGrid(grid(, ) As Integer)
		  for row as integer = 0 to 9
		    for col as integer = 0 to 9
		      Increment( grid, row, col )
		    next
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToGrid(input As String) As Integer(,)
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var grid( 9, 9 ) as integer
		  
		  for row as integer = 0 to rows.LastIndex
		    var chars() as string = rows( row ).Split( "" )
		    for col as integer = 0 to chars.LastIndex
		      grid( row, col ) = chars( col ).ToInteger
		    next col
		  next row
		  
		  return grid
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"5483143223\n2745854711\n5264556173\n6141336146\n6357385478\n4167524645\n2176841721\n6882881134\n4846848554\n5283751526", Scope = Private
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
