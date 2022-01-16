#tag Class
Protected Class Advent_2020_12_12
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( Normalize( kInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( Normalize( kInput ) )
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


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"F98\nS4\nS4\nL180\nW4\nS2\nR90\nE4\nF60\nE5\nR180\nF100\nR180\nF92\nS1\nR90\nF45\nE4\nF22\nR90\nN3\nF12\nW2\nF95\nR270\nF33\nL90\nF87\nL180\nF17\nE2\nR180\nF75\nW3\nF78\nS1\nF47\nL90\nW2\nF38\nW1\nN4\nE2\nR90\nE4\nF28\nL180\nW2\nS5\nL180\nE4\nS5\nW2\nL90\nS3\nE3\nS1\nF24\nW3\nS2\nF5\nE1\nL90\nF80\nS3\nF83\nS1\nE1\nF49\nN2\nR90\nF28\nN3\nL90\nS5\nL90\nF51\nR90\nE3\nR90\nW1\nF34\nW3\nL90\nE4\nL90\nW4\nL90\nF11\nS3\nL180\nF78\nE3\nF11\nR90\nF72\nW3\nF13\nW1\nN4\nW2\nS2\nW4\nN4\nL90\nF44\nE4\nF2\nW1\nS1\nE1\nR180\nF24\nN3\nR90\nF92\nR90\nL90\nF98\nE5\nF60\nR90\nS2\nE4\nF74\nN4\nF39\nN3\nF13\nW1\nN2\nL90\nF47\nS3\nW4\nF83\nN1\nE3\nS2\nF23\nL270\nE5\nF67\nS1\nL90\nW4\nF86\nN4\nR90\nN3\nW3\nS4\nE5\nR90\nS3\nL180\nF12\nN2\nF66\nW1\nF77\nN3\nS1\nW2\nF84\nN5\nF29\nN4\nR180\nF61\nL270\nE3\nS5\nL180\nF60\nN5\nL90\nE4\nF86\nN5\nW2\nL90\nN2\nW1\nS3\nR90\nE3\nS5\nW3\nF90\nW4\nW5\nS3\nF22\nS3\nF87\nR90\nN2\nW1\nN3\nE4\nF57\nR90\nN3\nE1\nL90\nF69\nW2\nN1\nW3\nL90\nE2\nF21\nW1\nF32\nS5\nW4\nF87\nR90\nF59\nL90\nE5\nF65\nL90\nW2\nF22\nR90\nF24\nE5\nW1\nE2\nL90\nF13\nN4\nE3\nF16\nR90\nL90\nS1\nE5\nF94\nR180\nN5\nL90\nF4\nN4\nW2\nS1\nL180\nS1\nL90\nE3\nF19\nL90\nW2\nS2\nF57\nN5\nR90\nE4\nF95\nS4\nR90\nF10\nN1\nF69\nN4\nF94\nW5\nR90\nN3\nF27\nW5\nF47\nS1\nF6\nN1\nL90\nN5\nR90\nE1\nR90\nS5\nW1\nR90\nF32\nE2\nF58\nE5\nF15\nN5\nR90\nF26\nS3\nF6\nS5\nE5\nS2\nL90\nW5\nL270\nF49\nL90\nF55\nL90\nF62\nR180\nS5\nF36\nF2\nS3\nE1\nR180\nE1\nN5\nR90\nW4\nF21\nL90\nS5\nF11\nS3\nN2\nR90\nN2\nR90\nS3\nF26\nR90\nW3\nW5\nF50\nE3\nS3\nL90\nS2\nE4\nR90\nR90\nF99\nL180\nS4\nW2\nR180\nF47\nE4\nN3\nF43\nS2\nF54\nF71\nS3\nE3\nN5\nF11\nF1\nL180\nF24\nE4\nF84\nL90\nF86\nL90\nF33\nW1\nN3\nW3\nS3\nW3\nF5\nN5\nR90\nF9\nR90\nS4\nF1\nS4\nN2\nL90\nS4\nR90\nE5\nS4\nF87\nN3\nE5\nL180\nN4\nL180\nS3\nF93\nL90\nN5\nL180\nL90\nF41\nS2\nL90\nF88\nS5\nF14\nE1\nW1\nN5\nE1\nR90\nW5\nL90\nS3\nF78\nN1\nR90\nF28\nS3\nE1\nF89\nN1\nL90\nE1\nN5\nW1\nL90\nN3\nL90\nS5\nF55\nL90\nN2\nL180\nN5\nL90\nF19\nL270\nW1\nR90\nE5\nS3\nW1\nF95\nE4\nF51\nS5\nF88\nN4\nL180\nW4\nF97\nS4\nF3\nL180\nW5\nL90\nF62\nE1\nN5\nE3\nN4\nR90\nN1\nE4\nS1\nE4\nF92\nW3\nF22\nE2\nF85\nR90\nS2\nR270\nF16\nR90\nW5\nS4\nL90\nS4\nW3\nS4\nF83\nE3\nF66\nN2\nF63\nS4\nF21\nW5\nF4\nN1\nE3\nF98\nS3\nR90\nF82\nF90\nW2\nF24\nE2\nL90\nN2\nL180\nW2\nS1\nF44\nL90\nF39\nR90\nE3\nL90\nF28\nW5\nS2\nL90\nS4\nF42\nE5\nS4\nR270\nF70\nS1\nR270\nS4\nR90\nE4\nF6\nE2\nR90\nW1\nS3\nW3\nF75\nS1\nR90\nS2\nL90\nF25\nR90\nS1\nR90\nN2\nR180\nF72\nW1\nR90\nF15\nE3\nF86\nR180\nE4\nL180\nF42\nN2\nL90\nW4\nF21\nR90\nS3\nE2\nN5\nE2\nF73\nE5\nL90\nF13\nL90\nF40\nE5\nN5\nF83\nE4\nL90\nN2\nF100\nS1\nW2\nN2\nL90\nF12\nS1\nF15\nE4\nF67\nF47\nR90\nF74\nS4\nF18\nL90\nN3\nF12\nN1\nL180\nF25\nE3\nF27\nN5\nL180\nS5\nF75\nR90\nW3\nR90\nW3\nN4\nR90\nE4\nF15\nS1\nW5\nF19\nN3\nF72\nW5\nL90\nF24\nR90\nF30\nR90\nE4\nN5\nW4\nL90\nF63\nE3\nN3\nS4\nF25\nR90\nS2\nF71\nW2\nS2\nN2\nR90\nF84\nR90\nF37\nW5\nL90\nS3\nF84\nL90\nE3\nR180\nF12\nR90\nF28\nW5\nF13\nF28\nE4\nF41\nN4\nW5\nS4\nE3\nF12\nR180\nS3\nW4\nS5\nR90\nL90\nS2\nL90\nF68\nE2\nS1\nE2\nF32\nR180\nF50\nL270\nS5\nR90\nN3\nF18\nW3\nS1\nL90\nW1\nR90\nW3\nR90\nS2\nF25\nW1\nR90\nE1\nR90\nF71\nE4\nL90\nS4\nW5\nF98\nE4\nN1\nF81\nW1\nR90\nF83\nW1\nF32\nL90\nE5\nF74\nE3\nF37\nE4\nS5\nR90\nF73\nL90\nF60\nE4\nF54\nR90\nE1\nR180\nS1\nL90\nF80\nE3\nS5\nL90\nL180\nN1\nF58\nW2\nE3\nS1\nW2\nR90\nN4\nE4\nR180\nF83\nS5\nF64\nR90\nS1\nE1\nL180\nW3\nF62\nR180\nN3\nL90\nE4\nR90\nN5\nF47\nL180\nW2\nR90\nN4\nW3\nF75\nR90\nS5\nE4\nF11\nR180\nW3\nF40\nL180\nW3\nF91\nW5\nF7\nS4\nE1\nR90\nN1\nF8", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"F10\nN3\nF7\nR90\nF11", Scope = Private
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
