#tag Class
Protected Class Advent_2021_12_21
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( GetPuzzleInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var players() as Player = GetPlayers( input, 10 )
		  if players.Count = 0 then
		    return 0
		  end if
		  
		  var die as new DeterministicDie
		  die.MaxValue = 100
		  
		  const kRollCount as integer = 3
		  const kWinningScore as integer = 1000
		  
		  var lowestScore as integer
		  
		  do
		    for i as integer = 0 to players.LastIndex
		      var p as Player = players( i )
		      
		      var dieRoll as integer = die.Roll( kRollCount )
		      
		      if dieRoll < ( 1 + 2 + 3 ) or dieRoll > ( 98 + 99 + 100 ) then
		        dieRoll = dieRoll
		      end if
		      
		      p.Position = p.Position + dieRoll
		      
		      if p.Position < 1 or p.Position > p.MaxPosition then
		        p = p
		      end if
		      
		      p.Score = p.Score + p.Position
		      
		      'System.DebugLog "Player " + p.Index.ToString + " " + _
		      '"rolled " + dieRoll.ToString + " " + _
		      '"and advanced to position " + p.Position.ToString + ", " + _
		      '"score " + p.Score.ToString
		      
		      if p.Score >= kWinningScore then
		        lowestScore = p.Score
		        exit do
		      end if
		    next
		  loop
		  
		  for each p as Player in players
		    lowestScore = min( lowestScore, p.Score )
		  next
		  
		  return lowestScore * die.RollCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var players() as Player = GetPlayers( input, 10 )
		  if players.Count = 0 then
		    return 0
		  end if
		  
		  Cache = new Dictionary
		  
		  var wins as pair = _
		  RollDirakDie( players( 0 ), players( 1 ) )
		  
		  return max( wins.Left.IntegerValue, wins.Right.IntegerValue )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCacheKey(p0 As Player, p1 As Player) As Integer
		  return _
		  ( p0.Position * 100000 ) + ( p0.Score * 1000 ) + _
		  ( p1.Position * 100 ) + p1.Score
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetPlayers(input As String, maxPosition As Integer) As Player()
		  'Player 1 starting position: 4
		  'Player 2 starting position: 8
		  
		  var rx as new RegEx
		  rx.SearchPattern = "Player (\d+) starting position: (\d+)"
		  
		  var result() as Player
		  
		  var match as RegExMatch = rx.Search( input )
		  while match isa object
		    var p as new Player
		    p.Index = match.SubExpressionString( 1 ).ToInteger
		    p.MaxPosition = maxPosition
		    p.Position = match.SubExpressionString( 2 ).ToInteger
		    result.Add p
		    
		    match = rx.Search
		  wend
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RollDirakDie(p0 As Player, p1 As Player) As Pair
		  var startScore as integer =     p0.Score
		  var startPosition as integer =  p0.Position
		  
		  var p0Wins as integer
		  var p1Wins as integer
		  
		  for d1 as integer = 1 to 3
		    for d2 as integer = 1 to 3
		      for d3 as integer = 1 to 3
		        var roll as integer = d1 + d2 + d3
		        p0.Position = startPosition + roll
		        p0.Score = startScore + p0.Position
		        
		        if p0.Score >= kWinningScore then
		          p0Wins = p0Wins + 1
		          continue for d3
		        end if
		        
		        var key as integer = GetCacheKey( p0, p1 )
		        
		        var result as pair = Cache.Lookup( key, nil )
		        if result isa pair then
		          p0Wins = p0Wins + result.Left.IntegerValue
		          p1Wins = p1Wins + result.Right.IntegerValue
		          continue for d3
		        end if
		        
		        result = RollDirakDie( p1, p0 )
		        p0Wins = p0Wins + result.Right.IntegerValue
		        p1Wins = p1Wins + result.Left.IntegerValue
		        Cache.Value( key ) = result.Right : result.Left
		      next d3
		    next d2
		  next d1
		  
		  p0.Score = startScore
		  p0.Position = startPosition
		  
		  return p0Wins : p1Wins
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Cache As Dictionary
	#tag EndProperty


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Player 1 starting position: 4\nPlayer 2 starting position: 8", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kWinningScore, Type = Double, Dynamic = False, Default = \"21", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
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
