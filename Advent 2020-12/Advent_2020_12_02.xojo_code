#tag Class
Protected Class Advent_2020_12_02
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

	#tag Event
		Function RunTestB() As Variant
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "^(\d+)-(\d+) (\w): (.*)"
		  
		  var validCount as integer
		  
		  for each row as string in rows
		    var match as RegExMatch = rx.Search( row )
		    var lowEnd as integer = match.SubExpressionString( 1 ).ToInteger
		    var highEnd as integer = match.SubExpressionString( 2 ).ToInteger
		    var char as string = match.SubExpressionString( 3 )
		    var pw as string = match.SubExpressionString( 4 )
		    
		    var replaced as string = pw.ReplaceAll( char, "" )
		    var diff as integer = pw.Length - replaced.Length
		    
		    if diff >= lowEnd and diff <= highEnd then
		      validCount = validCount + 1
		    end if
		  next
		  
		  return validCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "^(\d+)-(\d+) (\w): (.*)"
		  
		  var validCount as integer
		  
		  for each row as string in rows
		    var match as RegExMatch = rx.Search( row )
		    var pos1 as integer = match.SubExpressionString( 1 ).ToInteger
		    var pos2 as integer = match.SubExpressionString( 2 ).ToInteger
		    var char as string = match.SubExpressionString( 3 )
		    var pw as string = match.SubExpressionString( 4 )
		    
		    if pw.Middle( pos1 - 1, 1 ) = char xor pw.Middle( pos2 - 1, 1 ) = char then
		      validCount = validCount + 1
		    end if
		  next
		  
		  return validCount
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"1-3 a: abcde\n1-3 b: cdefg\n2-9 c: ccccccccc", Scope = Private
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
