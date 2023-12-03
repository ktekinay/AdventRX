#tag Class
Protected Class Advent_2022_12_05
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Move crates among stacks"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Supply Stacks"
		  
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
		Private Function CalculateResultA(input As String) As Integer
		  var parts() as string = input.Split( EndOfLine + EndOfLine )
		  
		  var stackInput as string = parts( 0 )
		  var moves() as string = ToStringArray( parts( 1 ).Trim )
		  
		  var stacks() as variant = ParseStacks( stackInput )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "move (\d+) from (\d+) to (\d+)"
		  
		  for each move as string in moves
		    var match as RegExMatch = rx.Search( move )
		    var count as integer = match.SubExpressionString( 1 ).ToInteger
		    var fromStackIndex as integer = match.SubExpressionString( 2 ).ToInteger - 1
		    var toStackIndex as integer = match.SubExpressionString( 3 ).ToInteger - 1
		    
		    var fromStack() as string = stacks( fromStackIndex )
		    var toStack() as string = stacks( toStackIndex )
		    
		    for turn as integer = 1 to count
		      toStack.AddAt( 0 ), fromStack( 0 )
		      fromStack.RemoveAt 0
		    next
		  next
		  
		  var tops() as string
		  for each item as variant in stacks
		    var arr() as string = item
		    tops.Add arr( 0 )
		  next
		  
		  Print String.FromArray( tops, "" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var parts() as string = input.Split( EndOfLine + EndOfLine )
		  
		  var stackInput as string = parts( 0 )
		  var moves() as string = ToStringArray( parts( 1 ).Trim )
		  
		  var stacks() as variant = ParseStacks( stackInput )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "move (\d+) from (\d+) to (\d+)"
		  
		  for each move as string in moves
		    var match as RegExMatch = rx.Search( move )
		    var count as integer = match.SubExpressionString( 1 ).ToInteger
		    var fromStackIndex as integer = match.SubExpressionString( 2 ).ToInteger - 1
		    var toStackIndex as integer = match.SubExpressionString( 3 ).ToInteger - 1
		    
		    var fromStack() as string = stacks( fromStackIndex )
		    var toStack() as string = stacks( toStackIndex )
		    
		    for turn as integer = 1 to count
		      toStack.AddAt( 0 ), fromStack( count - turn )
		      fromStack.RemoveAt count - turn
		    next
		  next
		  
		  var tops() as string
		  for each item as variant in stacks
		    var arr() as string = item
		    tops.Add arr( 0 )
		  next
		  
		  Print String.FromArray( tops, "" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseStacks(input As String) As Variant()
		  var rows() as string = ToStringArray( input )
		  
		  var result() as variant
		  
		  for each rowData as string in rows
		    var chars() as string = rowData.Split( "" )
		    
		    var stackIndex as integer = -1
		    for i as integer = 1 to chars.LastIndex step 4
		      var char as string = chars( i )
		      
		      if char = "1" then
		        exit for rowData
		      end if
		      
		      stackIndex = stackIndex + 1
		      
		      var stack() as string
		      if stackIndex > result.LastIndex then 
		        result.Add stack
		      else
		        stack = result( stackIndex )
		      end if
		      
		      if char <> " " then
		        stack.Add char
		      end if
		    next
		  next
		  
		  return result
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"    [D]    \n[N] [C]    \n[Z] [M] [P]\n 1   2   3 \n\nmove 1 from 2 to 1\nmove 3 from 1 to 3\nmove 2 from 2 to 1\nmove 1 from 1 to 2", Scope = Private
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
