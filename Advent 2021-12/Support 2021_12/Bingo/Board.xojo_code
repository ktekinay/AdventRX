#tag Class
Protected Class Board
	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  var builder() as string
			  
			  for row as integer = 0 to 4
			    var rowBuilder() as string
			    for col as integer = 0 to 4
			      var square as Bingo.Square = Grid( row, col )
			      rowBuilder.Add if( square.IsMarked, "T", "f" )
			    next
			    builder.Add String.FromArray( rowBuilder, "" )
			  next
			  
			  return String.FromArray( builder, EndOfLine )
			  
			End Get
		#tag EndGetter
		DebugGrid As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Grid(4,4) As Bingo.Square
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  for col as integer = 0 to 4
			    for row as integer = 0 to 4
			      var square as Bingo.Square = Grid( row, col )
			      if not square.IsMarked then
			        continue for col
			      end if
			    next row
			    
			    return true
			  next col
			  
			  for row as integer = 0 to 4
			    for col as integer = 0 to 4
			      var square as Bingo.Square = Grid( row, col )
			      if not square.IsMarked then
			        continue for row
			      end if
			    next col
			    
			    return true
			  next row
			  
			  return false
			  
			End Get
		#tag EndGetter
		IsBingo As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		IsWinner As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  var sum as integer
			  
			  for row as integer = 0 to 4
			    for col as integer = 0 to 4
			      var square as Bingo.Square = Grid( row, col )
			      if not square.IsMarked then
			        sum = sum + square.Value
			      end if
			    next col
			  next row
			  
			  return sum
			  
			End Get
		#tag EndGetter
		SumUnmarked As Integer
	#tag EndComputedProperty


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
			Name="IsBingo"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SumUnmarked"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsWinner"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugGrid"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
