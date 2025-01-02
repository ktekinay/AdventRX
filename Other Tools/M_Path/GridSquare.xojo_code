#tag Class
Protected Class GridSquare
Implements M_Path.MilestoneInterface
	#tag Method, Flags = &h1
		Protected Sub CloneTo(copy As M_Path.GridSquare)
		  copy.Column = self.Column
		  copy.Direction = self.Direction
		  copy.Grid = self.Grid
		  copy.Parent = self.Parent
		  copy.Row = self.Row
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(row As Integer, column As Integer, direction As M_Path.Directions, parent As M_Path.GridSquare)
		  self.Row = row
		  self.Column = column
		  self.Direction = direction
		  if parent isa object then
		    self.Grid = parent.Grid
		    SetParent parent
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DirectionalNeighbors() As M_Path.GridSquare()
		  var lastRowIndex as integer = Grid.LastIndex( 1 )
		  var lastColIndex as integer = Grid.LastIndex( 2 )
		  
		  var neighbors() as M_Path.GridSquare
		  
		  select case Direction
		  case Directions.North
		    neighbors.Add new M_Path.GridSquare( Row - 1, Column, Direction, self )
		    neighbors.Add new M_Path.GridSquare( Row, Column - 1, Directions.West, self )
		    neighbors.Add new M_Path.GridSquare( Row, Column + 1, Directions.East, self )
		    
		  case Directions.East
		    neighbors.Add new M_Path.GridSquare( Row, Column + 1, Direction, self )
		    neighbors.Add new M_Path.GridSquare( Row - 1, Column, Directions.North, self )
		    neighbors.Add new M_Path.GridSquare( Row + 1, Column, Directions.South, self )
		    
		  case Directions.South
		    neighbors.Add new M_Path.GridSquare( Row + 1, Column, Direction, self )
		    neighbors.Add new M_Path.GridSquare( Row, Column - 1, Directions.West, self )
		    neighbors.Add new M_Path.GridSquare( Row, Column + 1, Directions.East, self )
		    
		  case Directions.West
		    neighbors.Add new M_Path.GridSquare( Row, Column - 1, Direction, self )
		    neighbors.Add new M_Path.GridSquare( Row - 1, Column, Directions.North, self )
		    neighbors.Add new M_Path.GridSquare( Row + 1, Column, Directions.South, self )
		    
		  end select
		  
		  for i as integer = neighbors.LastIndex downto 0
		    var n as M_Path.GridSquare = neighbors( i )
		    
		    if n.Row < 0 or n.Row > lastRowIndex or n.Column < 0 or n.Column > lastColIndex then
		      neighbors.RemoveAt i
		    end if
		  next
		  
		  return neighbors
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistanceFromParent(parent As M_Path.MilestoneInterface) As Double
		  raise new RuntimeException( "Must be implemented in subclass" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistanceToGoal(goal As M_Path.MilestoneInterface) As Double
		  var goalSquare as M_Path.GridSquare = M_Path.GridSquare( goal )
		  
		  return ManhattanDistance( goalSquare.Column, goalSquare.Row, Column, Row )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetKey() As Variant
		  var rowCount as integer = Grid.LastIndex( 1 ) + 1
		  var colCount as integer = Grid.LastIndex( 2 ) + 1
		  
		  var d as integer = if( grid( Row, Column ) = "E", 0, integer( Direction ) )
		  
		  return _
		  ( d * rowCount * colCount ) _
		  + ( Row * colCount ) _
		  + Column
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Neighbors() As M_Path.GridSquare()
		  var lastRowIndex as integer = Grid.LastIndex( 1 )
		  var lastColIndex as integer = Grid.LastIndex( 2 )
		  
		  var neighbors() as M_Path.GridSquare
		  
		  if Column < lastColIndex then
		    neighbors.Add new M_Path.GridSquare( Row, Column + 1, Directions.East, self )
		  end if
		  if Row < lastRowIndex then
		    neighbors.Add new M_Path.GridSquare( Row + 1, Column, Directions.South, self )
		  end if
		  if Column > 0 then
		    neighbors.Add new M_Path.GridSquare( Row, Column - 1, Directions.West, self )
		  end if
		  if Row > 0 then
		    neighbors.Add new M_Path.GridSquare( Row - 1, Column, Directions.North, self )
		  end if
		  
		  return neighbors
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetParent(parent As M_Path.MilestoneInterface)
		  self.Parent = M_Path.GridSquare( parent )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Successors() As M_Path.MilestoneInterface()
		  raise new RuntimeException( "Must be implemented in subclass" )
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Column As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Direction As M_Path.Directions
	#tag EndProperty

	#tag Property, Flags = &h0
		Grid(-1,-1) As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Parent As M_Path.GridSquare
	#tag EndProperty

	#tag Property, Flags = &h0
		Row As Integer
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
		#tag ViewProperty
			Name="Direction"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="M_Path.Directions"
			EditorType="Enum"
			#tag EnumValues
				"0 - North"
				"1 - East"
				"2 - South"
				"3 - West"
			#tag EndEnumValues
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
	#tag EndViewBehavior
End Class
#tag EndClass
