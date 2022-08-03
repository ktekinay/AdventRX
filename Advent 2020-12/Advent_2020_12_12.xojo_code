#tag Class
Protected Class Advent_2020_12_12
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
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
		  return CalculateResultB( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var rows() as string = ToStringArray( input )
		  if rows.Count = 0 then
		    return -1
		  end if
		  
		  var directions() as string = array( "E", "S", "W", "N" )
		  var currentDirection as integer
		  
		  var coordinates as new Dictionary
		  for each direction as string in directions
		    coordinates.Value( direction ) = 0
		  next
		  
		  for each row as string in rows
		    var instruction as string = row.Left( 1 )
		    var value as integer = row.Middle( 1 ).ToInteger
		    
		    if instruction = "L" then
		      instruction = "R"
		      value = 360 - value
		    end if
		    
		    select case instruction
		    case "N", "S", "E", "W"
		      coordinates.Value( instruction ) = coordinates.Value( instruction ).IntegerValue + value
		      
		    case "F"
		      var inc as string = directions( currentDirection )
		      coordinates.Value( inc ) = coordinates.Value( inc ).IntegerValue + value
		      
		    case "R"
		      var inc as integer = value \ 90
		      currentDirection = ( currentDirection + inc ) mod directions.Count
		      
		    end select
		  next
		  
		  var ewPosition as integer = coordinates.Value( "E" ).IntegerValue - coordinates.Value( "W" ).IntegerValue
		  var nsPosition as integer = coordinates.Value( "N" ).IntegerValue - coordinates.Value( "S" ).IntegerValue
		  
		  return abs( ewPosition ) + abs( nsPosition )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as string = ToStringArray( input )
		  if rows.Count = 0 then
		    return -1
		  end if
		  
		  var waypoint as new Xojo.Point( 10, 1 ) // E : N
		  var coords as new Xojo.Point( 0, 0 )
		  
		  for each row as string in rows
		    var instruction as string = row.Left( 1 )
		    var value as integer = row.Middle( 1 ).ToInteger
		    
		    if instruction = "L" then
		      instruction = "R"
		      value = 360 - value
		    end if
		    
		    select case instruction
		    case "R"
		      var units as integer = value \ 90
		      for i as integer = 1 to units
		        var temp as integer = waypoint.X
		        waypoint.X = waypoint.Y
		        waypoint.Y = -temp
		      next
		      
		    case "E"
		      waypoint.X = waypoint.X + value
		      
		    case "S"
		      waypoint.Y = waypoint.Y - value
		      
		    case "W"
		      waypoint.X = waypoint.X - value
		      
		    case "N"
		      waypoint.Y = waypoint.Y + value
		      
		    case "F"
		      coords.X = coords.X + ( value * waypoint.X )
		      coords.Y = coords.Y + ( value * waypoint.Y )
		      
		    case else
		      break
		      
		    end select
		  next
		  
		  return abs( coords.X ) + abs( coords.Y )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"F10\nN3\nF7\nR90\nF11", Scope = Private
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
