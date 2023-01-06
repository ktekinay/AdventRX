#tag Class
Protected Class MiningScenario
	#tag Method, Flags = &h0
		Function Clone() As MiningScenario
		  var copy as new MiningScenario
		  
		  copy.Blueprint = self.Blueprint
		  
		  for each robot as Robot in self.ExistingRobots
		    copy.ExistingRobots.Add robot
		  next
		  
		  copy.HaveCounts = self.HaveCounts.Clone
		  copy.Inventory = self.Inventory.Clone
		  
		  return copy
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function NewScenario() As MiningScenario
		  var scenario as new MiningScenario
		  
		  scenario.Inventory= new OreInventory
		  scenario.ExistingRobots.Add new OreRobot
		  scenario.HaveCounts.ResizeTo( 3 )
		  scenario.HaveCounts( 3 ) = 1
		  
		  return scenario
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Blueprint As RobotBlueprint
	#tag EndProperty

	#tag Property, Flags = &h0
		ExistingRobots() As Robot
	#tag EndProperty

	#tag Property, Flags = &h0
		HaveCounts() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Inventory As OreInventory
	#tag EndProperty


	#tag ViewBehavior
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
