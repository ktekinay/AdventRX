#tag Class
Protected Class Advent_2022_12_02
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Unknown"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Rock Paper Scissors"
		  
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
		  var turns() as string = ToStringArray( input )
		  
		  var myScore as integer
		  
		  for each turn as string in turns
		    var moves() as string = turn.Split( " " )
		    myScore = myScore + self.MyScore( moves( 0 ), moves( 1 ) )
		  next turn
		  
		  return myScore
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var turns() as string = ToStringArray( input )
		  
		  var myScore as integer
		  
		  for each turn as string in turns
		    var moves() as string = turn.Split( " " )
		    
		    select case moves( 1 )
		    case "X" // Lose
		      moves( 1 ) = LoserFrom( moves( 0 ) )
		    case "Y" // Draw
		      moves( 1 ) = moves( 0 )
		    case "Z" // Win
		      moves( 1 ) = WinnerFrom( moves( 0 ) )
		    end select
		    
		    myScore = myScore + self.MyScore( moves( 0 ), moves( 1 ) )
		  next turn
		  
		  return myScore
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ConvertMove(move As String) As String
		  static diff as integer = Asc( "X" ) - Asc( "A" )
		  
		  if move >= "X" then
		    var v as integer = move.Asc - diff
		    move = Chr( v )
		  end if
		  
		  return move
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LoserFrom(move As String) As String
		  static ascA as integer = Asc( "A" )
		  static ascC as integer = Asc( "C" )
		  
		  var v as integer = move.Asc - 1
		  if v < ascA then
		    v = ascC
		  end if
		  
		  return chr( v )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MyScore(theirMove As String, myMove As String) As Integer
		  theirMove = ConvertMove( theirMove )
		  myMove = ConvertMove( myMove )
		  
		  var myScore as integer = ToPoints( myMove )
		  
		  var bonus as integer
		  
		  select case true
		  case theirMove = myMove
		    bonus = 3
		  case theirMove.Asc = ( myMove.Asc - 1 )
		    bonus = 6
		  case theirMove = "C" and myMove = "A"
		    bonus = 6
		  end select
		  
		  return myScore + bonus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToPoints(move As String) As Integer
		  select case move
		  case "A", "X"
		    return 1
		  case "B", "Y"
		    return 2
		  case "C", "Z"
		    return 3
		  end select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function WinnerFrom(move As String) As String
		  static ascA as integer = Asc( "A" )
		  static ascC as integer = Asc( "C" )
		  
		  var v as integer = move.Asc + 1
		  if v > ascC then
		    v = ascA
		  end if
		  
		  return chr( v )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"A Y\nB X\nC Z", Scope = Private
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
