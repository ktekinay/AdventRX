#tag Class
Private Class ObjectGridIterator
Implements Iterator
	#tag Method, Flags = &h0
		Sub Constructor(grid(, ) As GridMember)
		  self.Grid = grid
		  LastRowIndex = grid.LastIndex( 1 )
		  LastColIndex = grid.LastIndex( 2 )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MoveNext() As Boolean
		  NextColumn = NextColumn + 1
		  if NextColumn > LastColIndex then
		    NextColumn = 0
		    NextRow = NextRow + 1
		  end if
		  
		  return NextRow <= LastRowIndex
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Value() As Variant
		  return grid( NextRow, NextColumn )
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Grid(-1,-1) As GridMember
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LastColIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LastRowIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NextColumn As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NextRow As Integer
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
