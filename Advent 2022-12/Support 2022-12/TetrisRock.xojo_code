#tag Class
Protected Class TetrisRock
Inherits StringGrid
	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  var rows() as string
		  
		  for rowIndex as integer = 0 to LastRowIndex
		    var row() as string
		    for colIndex as integer = 0 to LastColIndex
		      var char as string = Grid( rowIndex, colIndex )
		      if char = "" then
		        char = LightDotString
		      end if
		      
		      row.Add Grid( rowIndex, colIndex )
		    next
		    
		    rows.Add String.FromArray( row, "" )
		  next
		  
		  return String.FromArray( rows, EndOfLine )
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		GridColumn As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		GridRow As Integer
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
			Name="LastColIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastRowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
