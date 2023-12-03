#tag Class
Protected Class Advent_2021_12_04
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
		  var set as Bingo.Set = GetSet( input )
		  var calls() as integer = GetCalls( input )
		  
		  var winner as Bingo.Board
		  var lastCall as integer
		  for each lastCall in calls
		    winner = set.CallValue( lastCall )
		    if winner isa object then
		      exit
		    end if
		  next
		  
		  if winner is nil then
		    return -999
		  end if
		  
		  var sumUmarked as integer = winner.SumUnmarked
		  var result as integer = sumUmarked * lastCall
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var set as Bingo.Set = GetSet( input )
		  var calls() as integer = GetCalls( input )
		  
		  var winCount as integer
		  
		  var winningResult as integer
		  
		  var lastCall as integer
		  for each lastCall in calls
		    if winCount = 68 then
		      winCount = winCount
		    end if
		    
		    var winner as Bingo.Board = set.CallValue( lastCall )
		    if winner isa object then
		      winCount = winCount + 1
		      winningResult = lastCall * winner.SumUnmarked
		      
		      if winCount = set.Boards.Count then
		        exit
		      end if
		    end if
		  next
		  
		  return winningResult
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCalls(input As String) As Integer()
		  var lines() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  var firstLine as string = lines( 0 )
		  var callStrings() as string = firstLine.Split( "," )
		  
		  var calls() as integer
		  for each callString as string in callStrings
		    calls.Add callString.ToInteger
		  next
		  
		  return calls
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetSet(input As String) As Bingo.Set
		  static rx as RegEx
		  
		  if rx is nil then
		    rx = new RegEx
		    rx.SearchPattern = "(?mi-Us)(^( *\d+){5}(\R|\z)){5}"
		  end if
		  
		  var set as new Bingo.Set
		  
		  var match as RegExMatch = rx.Search( input )
		  while match isa RegExMatch
		    set.AddBoard match.SubExpressionString( 0 )
		    match = rx.Search
		  wend
		  
		  return set
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"7\x2C4\x2C9\x2C5\x2C11\x2C17\x2C23\x2C2\x2C0\x2C14\x2C21\x2C24\x2C10\x2C16\x2C13\x2C6\x2C15\x2C25\x2C12\x2C22\x2C18\x2C20\x2C8\x2C19\x2C3\x2C26\x2C1\n\n22 13 17 11  0\n 8  2 23  4 24\n21  9 14 16  7\n 6 10  3 18  5\n 1 12 20 15 19\n\n 3 15  0  2 22\n 9 18 13 17  5\n19  8  7 25 23\n20 11 10 24  4\n14 21 16 12  6\n\n14 21 17 24  4\n10 16 15  9 19\n18  8 23 26 20\n22 11 13  6  5\n 2  0 12  3  7", Scope = Private
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
