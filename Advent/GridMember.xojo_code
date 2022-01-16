#tag Class
Class GridMember
	#tag Method, Flags = &h0
		Function Neighbors(includeDiagonal As Boolean) As GridMember()
		  var result() as GridMember
		  var g as ObjectGrid = Grid
		  
		  if g is nil then
		    return result
		  end if
		  
		  if includeDiagonal then
		    var firstRow as integer = max( Row - 1, 0 )
		    var lastRow as integer = min( Row + 1, g.LastRowIndex )
		    var firstCol as integer = max( Column - 1, 0 )
		    var lastCol as integer = min( Column + 1, g.LastColIndex )
		    
		    for row as integer = firstRow to lastRow
		      for col as integer = firstCol to lastCol
		        if row = self.Row and col = Self.Column then
		          continue
		        end if
		        result.Add g( row, col )
		      next
		    next
		    
		  else
		    if Column > 0 then
		      result.Add g( Row, Column - 1 )
		    end if
		    if Row > 0 then
		      result.Add g( Row - 1, Column )
		    end if
		    if Column < g.LastColIndex then
		      result.Add g( Row, Column + 1 )
		    end if
		    if Row < g.LastRowIndex then
		      result.Add g( Row + 1, Column )
		    end if
		    
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  return ToString
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event StringValue() As String
	#tag EndHook


	#tag Property, Flags = &h0
		Column As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mGrid is nil then
			    return nil
			  else
			    return ObjectGrid( mGrid.Value )
			  end if
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  if value is nil then
			    mGrid = nil
			  else
			    mGrid = value.WeakRef
			  end if
			  
			End Set
		#tag EndSetter
		Grid As ObjectGrid
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mGrid As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0
		Row As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return RaiseEvent StringValue
			End Get
		#tag EndGetter
		ToString As String
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
