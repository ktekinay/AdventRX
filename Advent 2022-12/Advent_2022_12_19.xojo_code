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
		Private Function Advance(remainingMinutes as Integer, scenario as MiningScenario, history as Dictionary, ByRef highCount as Integer) As Integer
		  if remainingMinutes = 0 then
		    if scenario.Inventory.Geode > highCount then
		      self.Print "", "New High" : scenario.Inventory.Geode
		      highCount = scenario.Inventory.Geode
		    end if
		    
		    return scenario.Inventory.Geode
		  end if
		  
		  var key as variant = Key( remainingMinutes, scenario )
		  if history.HasKey( key ) then
		    return history.Value( key ).IntegerValue + scenario.Inventory.Geode
		  end if
		  
		  var startingGeodes as integer = scenario.Inventory.Geode
		  
		  var mined as integer
		  
		  //
		  // Try building each design
		  //
		  var wasCalled as boolean
		  
		  var newScenario as MiningScenario
		  
		  for i as integer = 0 to scenario.Blueprint.Designs.LastIndex
		    if remainingMinutes <= 5 and i = 3 then
		      continue
		    end if
		    
		    var design as RobotDesign = scenario.Blueprint.Designs( i )
		    
		    if newScenario is nil then
		      newScenario = scenario.Clone
		    end if
		    
		    var newRobot as Robot = Produce( design, newScenario.Inventory )
		    if newRobot isa object then
		      Mine( newScenario )
		      
		      newScenario.ExistingRobots.Add newRobot
		      newScenario.HaveCounts( i ) = newScenario.HaveCounts( i ) + 1
		      
		      var nowMined as integer = Advance( remainingMinutes - 1, newScenario, history, highCount )
		      
		      mined = max( mined, nowMined )
		      wasCalled = true
		      
		      newScenario = nil
		    end if
		  next
		  
		  if not wasCalled or scenario.HaveCounts( 0 ) <> 0 or scenario.HaveCounts( 1 ) <> 0 or scenario.HaveCounts( 2 ) <> 0 then
		    Mine( scenario )
		    var nowMined as integer = Advance( remainingMinutes - 1, scenario, history, highCount )
		    mined = max( mined, nowMined )
		  end if
		  
		  history.Value( key ) = mined - startingGeodes
		  
		  return mined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var blueprints() as RobotBlueprint = ParseInput( input )
		  
		  var quality as integer
		  
		  for each bp as RobotBlueprint in blueprints
		    self.Print "Blueprint id" : bp.ID
		    
		    var scenario as MiningScenario = MiningScenario.NewScenario
		    scenario.Blueprint = bp
		    
		    var highCount as integer
		    call Advance( 24, scenario, new Dictionary, highCount )
		    
		    self.Print "", "Count" : highCount
		    
		    quality = quality + ( bp.ID * highCount )
		  next
		  
		  return quality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Key(remainingMinutes As Integer, scenario As MiningScenario) As Variant
		  var key as integer
		  
		  var inventory as OreInventory = scenario.Inventory
		  var haveCounts() as integer = scenario.HaveCounts
		  
		  for each cnt as integer in haveCounts
		    key = key * 100 + cnt
		  next
		  
		  key = key * 100 + inventory.Ore
		  key = key * 100 + inventory.Clay
		  key = key * 100 + inventory.Obsidian
		  
		  return key
		  
		  
		  
		  
		  'var builder() as string = array( _
		  'remainingMinutes.ToString, _
		  'inventory.Ore.ToString, _
		  'inventory.Clay.ToString, _
		  'inventory.Obsidian.ToString _
		  ')
		  '
		  'for each cnt as integer in haveCounts
		  'builder.Add cnt.ToString
		  'next
		  '
		  'return String.FromArray( builder, ":" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Mine(scenario As MiningScenario)
		  for each robot as Robot  in scenario.ExistingRobots
		    robot.Mine( scenario.Inventory )
		  next
		  
		End Sub
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
		  if kDebug then
		    super.Print(msg)
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Print(msg1 As Variant, msg2 As Variant, ParamArray moreMsgs() As Variant)
		  if kDebug then
		    // Calling the overridden superclass method.
		    super.Print(msg1, msg2, moreMsgs)
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Produce(design As RobotDesign, inventory As OreInventory) As Robot
		  if inventory.Clay >= design.RequiredClay and _
		    inventory.Ore >= design.RequiredOre and _
		    inventory.Obsidian >= design.RequiredObsidian _
		    then
		    var r as Robot
		    var type as Introspection.TypeInfo = design.RobotType
		    var constructors() as Introspection.ConstructorInfo = type.GetConstructors
		    r = Robot( constructors( 0 ).Invoke )
		    
		    inventory.Clay = inventory.Clay - design.RequiredClay
		    inventory.Ore = inventory.Ore - design.RequiredOre
		    inventory.Obsidian = inventory.Obsidian - design.RequiredObsidian
		    
		    return r
		  end if
		  
		  return nil
		  
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
