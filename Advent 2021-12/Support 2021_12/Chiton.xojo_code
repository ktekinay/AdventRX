#tag Class
Protected Class Chiton
	#tag Method, Flags = &h0
		Function GetNeighbors(grid(, ) As Chiton, lastRowIndex As Integer, lastColIndex As Integer, onlyDownAndRight As Boolean = False) As Chiton()
		  var allNeighbors as boolean = not onlyDownAndRight
		  
		  var result() as Chiton
		  
		  if Row <> lastColIndex or Column <> lastColIndex then
		    
		    if row < lastRowIndex then
		      result.Add grid( Row + 1, Column )
		    end if
		    
		    if Column < lastColIndex then
		      result.Add grid( Row, Column + 1 )
		    end if
		    
		    if allNeighbors then
		      if Row > 0 then
		        result.Add grid( Row - 1, Column )
		      end if
		      
		      if Column > 0 then
		        result.Add grid( Row, Column - 1 )
		      end if
		    end if
		    
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextChiton(grid(, ) As Chiton, lastRowIndex As Integer, lastColIndex As Integer, onlyDownAndRight As Boolean = False) As Chiton
		  var result as Chiton
		  
		  var neighbors() as Chiton = GetNeighbors( grid, lastRowIndex, lastColIndex, onlyDownAndRight )
		  
		  for each neighbor as Chiton in neighbors
		    if result is nil or neighbor.CombinedRisk < result.CombinedRisk then
		      result = neighbor
		    end if
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		BestRisk As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Column As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Risk + BestRisk
			  
			End Get
		#tag EndGetter
		CombinedRisk As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Row = 0 and Column = 0
			End Get
		#tag EndGetter
		IsStart As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mNextChiton As Chiton
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mNextChiton
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mNextChiton = value
			  BestRisk = mNextChiton.CombinedRisk
			  
			End Set
		#tag EndSetter
		NextChiton As Chiton
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Risk As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Row As Integer
	#tag EndProperty


	#tag Constant, Name = kMaxLeft, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kMaxUp, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant


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
		#tag ViewProperty
			Name="Risk"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BestRisk"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Row"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Column"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsStart"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CombinedRisk"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
