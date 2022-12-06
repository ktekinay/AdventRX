#tag Class
Protected Class Advent_2015_12_03
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Directions to Santa/Robo-Santa"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Perfectly Spherical Houses in a Vacuum"
		  
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
		  const mult as integer = 100000000
		  
		  var visited as new Dictionary( 0 : nil )
		  var houseCount as integer = 1
		  
		  var x, y as integer
		  
		  for each direction as string in input.Split( "" )
		    select case direction
		    case ">"
		      x = x + 1
		    case "v"
		      y = y - 1
		    case "<"
		      x = x - 1
		    case "^"
		      y = y + 1
		    end select
		    
		    var key as integer = x * mult + y
		    
		    if not visited.HasKey( key ) then
		      houseCount = houseCount + 1
		      visited.Value( key ) = nil
		    end if
		  next
		  
		  return houseCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  const mult as integer = 100000000
		  
		  var visited as new Dictionary( 0 : nil )
		  var houseCount as integer = 1
		  
		  var x, y as integer
		  
		  var directions() as string = input.Split( "" )
		  
		  for i as integer = 0 to directions.LastIndex step 2
		    var direction as string = directions( i )
		    select case direction
		    case ">"
		      x = x + 1
		    case "v"
		      y = y - 1
		    case "<"
		      x = x - 1
		    case "^"
		      y = y + 1
		    end select
		    
		    var key as integer = x * mult + y
		    
		    if not visited.HasKey( key ) then
		      houseCount = houseCount + 1
		      visited.Value( key ) = nil
		    end if
		  next
		  
		  x = 0
		  y = 0
		  
		  for i as integer = 1 to directions.LastIndex step 2
		    var direction as string = directions( i )
		    select case direction
		    case ">"
		      x = x + 1
		    case "v"
		      y = y - 1
		    case "<"
		      x = x - 1
		    case "^"
		      y = y + 1
		    end select
		    
		    var key as integer = x * mult + y
		    
		    if not visited.HasKey( key ) then
		      houseCount = houseCount + 1
		      visited.Value( key ) = nil
		    end if
		  next
		  
		  return houseCount
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"^v^v^v^v^v", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"^v^v^v^v^v", Scope = Private
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
