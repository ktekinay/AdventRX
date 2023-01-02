#tag Class
Protected Class Advent_2022_12_19
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Unknown"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return false
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return ""
		  
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
		  var blueprints() as RobotBlueprint = ParseInput( input )
		  
		  var quality as integer
		  
		  for each bp as RobotBlueprint in blueprints
		    Print "Blueprint id" : bp.ID
		    
		    var inventory as new OreInventory
		    
		    var existingRobots() as Robot
		    existingRobots.Add new OreRobot
		    
		    for minute as integer = 1 to 24
		      Print "=== Minute ", minute, "==="
		      
		      if IsTest and minute = 10 then
		        minute = minute
		      end if
		      
		      var newRobots() as Robot = Produce( bp, inventory )
		      
		      for each robot as Robot in existingRobots
		        Print "robot", Introspection.GetType( robot ).Name
		        robot.Mine inventory
		      next
		      
		      Print "Ore" : inventory.Ore, "Clay" : inventory.Clay, "Obsidian" : inventory.Obsidian, "Geode" : inventory.Geode
		      
		      for each newRobot as Robot in newRobots
		        existingRobots.Add newRobot
		      next
		      
		      quality = quality + ( bp.ID * inventory.Geode )
		    next
		  next
		  
		  return quality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As RobotBlueprint()
		  var rx as new RegEx
		  rx.SearchPattern = "Each (\w+) robot costs ([^.]+)\."
		  
		  var rxReq as new RegEx
		  rxReq.SearchPattern = "\b(\d+) (\w+)\b"
		  
		  var rows() as string = input.Split( EndOfLine )
		  
		  var id as integer
		  
		  var blueprints() as RobotBlueprint
		  
		  for each row as string in rows
		    id = id + 1
		    var bp as new RobotBlueprint
		    bp.ID = id
		    
		    blueprints.Add bp
		    
		    var match as RegExMatch = rx.Search( row )
		    
		    while match isa object
		      var design as new RobotDesign
		      bp.Designs.AddAt 0, design
		      
		      design.Name = match.SubExpressionString( 1 )
		      select case design.Name
		      case "ore"
		        design.RobotType = GetTypeInfo( OreRobot )
		        design.Have = 1
		      case "clay"
		        design.RobotType = GetTypeInfo( ClayRobot )
		      case "obsidian"
		        design.RobotType = GetTypeInfo( ObsidianRobot )
		      case "geode"
		        design.RobotType = GetTypeInfo( GeodeRobot )
		      case else
		        raise new RuntimeException( "Unknown robot " + design.Name )
		      end select
		      
		      var reqMatch as RegExMatch = rxReq.Search( match.SubExpressionString( 2 ) )
		      
		      while reqMatch isa object
		        var value as integer = reqMatch.SubExpressionString( 1 ).ToInteger
		        var type as string = reqMatch.SubExpressionString( 2 )
		        
		        select case type
		        case "ore"
		          design.RequiredOre = value
		        case "clay"
		          design.RequiredClay = value
		        case "obsidian"
		          design.RequiredObsidian = value
		        case else
		          raise new RuntimeException( "Unknown type " + type )
		        end select
		        
		        reqMatch = rxReq.Search
		      wend
		      
		      match = rx.Search
		    wend
		  next
		  
		  return blueprints
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Print(msg As Variant)
		  if IsTest and kDebug then
		    super.Print(msg)
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Print(msg1 As Variant, msg2 As Variant, ParamArray moreMsgs() As Variant)
		  if IsTest and kDebug then
		    // Calling the overridden superclass method.
		    super.Print(msg1, msg2, moreMsgs)
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Produce(blueprint As RobotBlueprint, inventory As OreInventory) As Robot()
		  var robots() as Robot
		  
		  for each design as RobotDesign in blueprint.Designs
		    if inventory.Clay >= design.RequiredClay and _
		      inventory.Ore >= design.RequiredOre and _
		      inventory.Obsidian >= design.RequiredObsidian _
		      and ( design.Want = 0 or design.Have < design.Want ) then
		      var r as Robot
		      var type as Introspection.TypeInfo = design.RobotType
		      var constructors() as Introspection.ConstructorInfo = type.GetConstructors
		      r = Robot( constructors( 0 ).Invoke )
		      
		      robots.Add r
		      
		      inventory.Clay = inventory.Clay - design.RequiredClay
		      inventory.Ore = inventory.Ore - design.RequiredOre
		      inventory.Obsidian = inventory.Obsidian - design.RequiredObsidian
		      
		      design.Have = design.Have + 1
		    end if
		  next
		  
		  return robots
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kDebug, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Blueprint 1:  Each ore robot costs 4 ore.  Each clay robot costs 2 ore.  Each obsidian robot costs 3 ore and 14 clay.  Each geode robot costs 2 ore and 7 obsidian.\nBlueprint 2:  Each ore robot costs 2 ore.  Each clay robot costs 3 ore.  Each obsidian robot costs 3 ore and 8 clay.  Each geode robot costs 3 ore and 12 obsidian.", Scope = Private
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
