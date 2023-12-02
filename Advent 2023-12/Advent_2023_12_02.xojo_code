#tag Class
Protected Class Advent_2023_12_02
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Parse games to get the max of each cube color in each game"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Cube Conundrum"
		  
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
		  var games() as Dictionary = ToGames( input )
		  
		  var ids() as integer
		  for i as integer = 1 to games.Count
		    var game as Dictionary = games( i - 1 )
		    
		    if game.Lookup( "red", 0 ) <= 12 and game.Lookup( "green", 0 ) <= 13 and game.Lookup( "blue", 0) <= 14 then
		      ids.Add i
		    end if
		  next
		  
		  return SumArray( ids )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var games() as Dictionary = ToGames( input )
		  
		  var powers as integer
		  
		  for each game as Dictionary in games
		    powers = powers + ( game.Lookup( "red", 0 ) * game.Lookup( "green", 0 ) * game.Lookup( "blue", 0 ) )
		  next
		  
		  return powers
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToGames(input As String) As Dictionary()
		  var arr() as string = ToStringArray( input )
		  
		  var games() as Dictionary
		  
		  for each line as string in arr
		    var game as new Dictionary
		    
		    var parts() as string = line.Split( ": " )
		    line = parts( 1 )
		    
		    var sections() as string = line.Split( "; " )
		    for each section as string in sections
		      var colors() as string = section.Split( ", " )
		      for each c as string in colors
		        var info() as string = c.Split( " " )
		        game.Value( info( 1 ) ) = max( game.Lookup( info( 1 ), 0 ), info( 0 ).ToInteger )
		      next
		      
		    next
		    
		    games.Add game
		  next
		  
		  return games
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Game 1: 3 blue\x2C 4 red; 1 red\x2C 2 green\x2C 6 blue; 2 green\nGame 2: 1 blue\x2C 2 green; 3 green\x2C 4 blue\x2C 1 red; 1 green\x2C 1 blue\nGame 3: 8 green\x2C 6 blue\x2C 20 red; 5 blue\x2C 4 red\x2C 13 green; 5 green\x2C 1 red\nGame 4: 1 green\x2C 3 red\x2C 6 blue; 3 green\x2C 6 red; 3 green\x2C 15 blue\x2C 14 red\nGame 5: 6 red\x2C 1 blue\x2C 3 green; 2 blue\x2C 1 red\x2C 2 green", Scope = Private
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
