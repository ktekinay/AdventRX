#tag Class
Private Class ObjectGridIterator
Implements Iterator
	#tag Method, Flags = &h0
		Sub Constructor(grid As ObjectGrid)
		  self.Grid = grid
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MoveNext() As Boolean
		  NextColumn = NextColumn + 1
		  if NextColumn > grid.LastColIndex then
		    NextColumn = 0
		    NextRow = NextRow + 1
		  end if
		  
		  return NextRow <= grid.LastRowIndex
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Value() As Variant
		  return grid( NextRow, NextColumn )
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Grid As ObjectGrid
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
		#tag ViewProperty
			Name="Grid"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
