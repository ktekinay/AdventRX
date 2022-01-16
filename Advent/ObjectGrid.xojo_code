#tag Class
Class ObjectGrid
	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  return ToString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(row As Integer, col As Integer) As GridMember
		  return Grid( row, col )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(row As Integer, col As Integer, Assigns m As GridMember)
		  Grid( row, col ) = m
		  m.Grid = self
		  m.Row = row
		  m.Column = col
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(row As Integer, col As Integer)
		  mLastRowIndex = row
		  mLastColIndex = col
		  
		  Grid.ResizeTo row, col
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Grid(-1,-1) As GridMember
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mLastColIndex
			End Get
		#tag EndGetter
		LastColIndex As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mLastRowIndex
			End Get
		#tag EndGetter
		LastRowIndex As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mLastColIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastRowIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWeakRef As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  var rowBuilder() as string
			  for row as integer = 0 to mLastRowIndex
			    var colBuilder() as string
			    for col as integer = 0 to mLastColIndex
			      var m as GridMember = Grid( row, col )
			      if m is nil then
			        colBuilder.Add &uFF0E
			      else
			        colBuilder.Add Grid( row, col ).ToString
			      end if
			    next
			    rowBuilder.Add String.FromArray( colBuilder, "" )
			  next
			  
			  return String.FromArray( rowBuilder, EndOfLine )
			  
			End Get
		#tag EndGetter
		ToString As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mWeakRef is nil then
			    mWeakRef = new WeakRef( self )
			  end if
			  
			  return mWeakRef
			  
			End Get
		#tag EndGetter
		WeakRef As WeakRef
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
