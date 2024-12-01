#tag Class
Protected Class Advent_2016_12_01
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Track distances of travel given L/R instructions"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "No Time for a Taxicab"
		  
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
		Private Function CalculateResultA(input As String) As Variant
		  var instructions() as string = input.Split( ", " )
		  
		  var vert as integer
		  var horiz as integer
		  
		  var direction as integer = 0
		  
		  for each row as string in instructions
		    var turn as string = row.Left( 1 )
		    var spaces as integer = row.Middle( 1 ).ToInteger
		    
		    select case turn
		    case "R"
		      direction = direction + 1
		      if direction = 4 then
		        direction = 0
		      end if
		    case "L"
		      direction = direction - 1
		      if direction = -1 then
		        direction = 3
		      end if
		    end select
		    
		    select case direction
		    case 0
		      vert = vert + spaces
		    case 1
		      horiz = horiz + spaces
		    case 2
		      vert = vert - spaces
		    case 3
		      horiz = horiz - spaces
		    end select
		  next
		  
		  var result as integer = abs( horiz ) + abs( vert )
		  
		  return result : if( IsTest, 12, 242 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  if IsTest then
		    input = "R8, R4, R4, R8"
		  end if
		  
		  var instructions() as string = input.Split( ", " )
		  
		  var vert as integer
		  var horiz as integer
		  
		  var grid as new Set
		  
		  var direction as integer = 0
		  
		  for each row as string in instructions
		    var turn as string = row.Left( 1 )
		    var spaces as integer = row.Middle( 1 ).ToInteger
		    
		    select case turn
		    case "R"
		      direction = direction + 1
		      if direction = 4 then
		        direction = 0
		      end if
		    case "L"
		      direction = direction - 1
		      if direction = -1 then
		        direction = 3
		      end if
		    end select
		    
		    for space as integer = 1 to spaces
		      select case direction
		      case 0
		        vert = vert + 1
		      case 1
		        horiz = horiz + 1
		      case 2
		        vert = vert - 1
		      case 3
		        horiz = horiz - 1
		      end select
		      
		      var key as integer = horiz * 10000000 + vert
		      if grid.HasMember( key ) then
		        exit for row
		      end if
		      
		      grid.Add( key )
		    next
		  next
		  
		  var result as integer = abs( horiz ) + abs( vert )
		  
		  return result : if( IsTest, 4, 150 )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"R5\x2C L5\x2C R5\x2C R3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Type"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Cooperative"
				"1 - Preemptive"
			#tag EndEnumValues
		#tag EndViewProperty
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
