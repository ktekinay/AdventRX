#tag Class
Protected Class Advent_2020_12_22
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return ""
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Crab Combat"
		  
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
		  var player1() as integer
		  var player2() as integer
		  
		  GetDecks( input, player1, player2 )
		  
		  while player1.Count <> 0 and player2.Count <> 0
		    var p1 as integer = player1( 0 )
		    player1.RemoveAt 0
		    
		    var p2 as integer= player2( 0 )
		    player2.RemoveAt( 0 )
		    
		    if p1 > p2 then
		      player1.Add p1
		      player1.Add p2
		    else
		      player2.Add p2
		      player2.Add p1
		    end if
		  wend
		  
		  var winner() as integer = if( player1.Count = 0, player2, player1 )
		  
		  return Score( winner )
		  return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var player1() as integer
		  var player2() as integer
		  
		  GetDecks( input, player1, player2 )
		  
		  RGame( player1, player2 )
		  
		  var winner() as integer = if( player1.Count = 0, player2, player1 )
		  var score as integer = Score( winner )
		  return score
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetDecks(input As String, player1() As Integer, player2() As Integer)
		  var parts() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine + EndOfLine )
		  
		  var storage() as variant
		  storage.Add player1
		  storage.Add player2
		  
		  for i as integer = 0 to parts.LastIndex
		    var storeTo() as integer = storage( i )
		    var part as string = parts( i )
		    
		    var rows() as string = part.Split( EndOfLine )
		    rows.RemoveAt 0 // Player label
		    for each row as string in rows
		      storeTo.Add row.ToInteger
		    next
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RGame(player1() As Integer, player2() As Integer)
		  var breadcrumbs as new Dictionary
		  
		  while player1.Count <> 0 and player2.Count <> 0
		    var key as integer = ( 1000000 * Score( player1 ) * player1.Count ) + ( Score( player2 ) * player2.Count )
		    if breadcrumbs.HasKey( key ) then
		      player2.RemoveAll
		      return
		    end if
		    
		    breadcrumbs.Value( key ) = nil
		    
		    var p1 as integer = player1( 0 )
		    var p2 as integer = player2( 0 )
		    player1.RemoveAt( 0 )
		    player2.RemoveAt( 0 )
		    
		    if player1.Count >= p1 and player2.Count >= p2 then
		      var player1Subdeck() as integer = Slice( player1, p1 )
		      var player2Subdeck() as integer = Slice( player2, p2 )
		      
		      RGame( player1Subdeck, player2Subdeck )
		      
		      if player2Subdeck.Count = 0 then
		        player1.Add p1
		        player1.Add p2
		      else
		        player2.Add p2
		        player2.Add p1
		      end if
		      
		    elseif p1 > p2 then
		      player1.Add p1
		      player1.Add p2
		      
		    else
		      player2.Add p2
		      player2.Add p1
		    end if
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Score(winner() As Integer) As Integer
		  var score as integer
		  for i as integer = winner.LastIndex downto 0
		    score = score + ( winner( i ) * ( winner.Count - i ) )
		  next
		  
		  return score
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Slice(arr() As Integer, count As Integer) As Integer()
		  var slice() as integer
		  for i as integer = 0 to count - 1
		    slice.Add arr( i )
		  next
		  
		  return slice
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Player 1:\n9\n2\n6\n3\n1\n\nPlayer 2:\n5\n8\n4\n7\n10", Scope = Private
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
