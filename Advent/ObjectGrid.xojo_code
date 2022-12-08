#tag Class
Class ObjectGrid
Implements Iterable, Iterator
	#tag Method, Flags = &h0
		Function Above(member As GridMember) As GridMember
		  if member.Row = 0 then
		    return nil
		  else
		    return Grid( member.Row - 1, member.Column )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AboveLeft(member As GridMember) As GridMember
		  if member.Row = 0 or member.Column = 0 then
		    return nil
		  else
		    return Grid( member.Row - 1, member.Column - 1 )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AboveRight(member As GridMember) As GridMember
		  if member.Row = 0 or member.Column = LastColIndex then
		    return nil
		  else
		    return Grid( member.Row - 1, member.Column + 1 )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllDirectionals() As ObjectGrid.NextDelegate()
		  var directionals() as ObjectGrid.NextDelegate = MainDirectionals
		  
		  directionals.Add AddressOf AboveLeft
		  directionals.Add AddressOf AboveRight
		  directionals.Add AddressOf BelowLeft
		  directionals.Add AddressOf BelowRight
		  
		  return directionals
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Below(member As GridMember) As GridMember
		  if member.Row = LastRowIndex then
		    return nil
		  else
		    return Grid( member.Row + 1, member.Column )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BelowLeft(member As GridMember) As GridMember
		  if member.Row = LastRowIndex or member.Column = 0 then
		    return nil
		  else
		    return Grid( member.Row + 1, member.Column - 1 )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BelowRight(member As GridMember) As GridMember
		  if member.Row = LastRowIndex or member.Column = LastColIndex then
		    return nil
		  else
		    return Grid( member.Row + 1, member.Column + 1 )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromIntegerGrid(igrid(, ) As Integer) As ObjectGrid
		  var lastRowIndex as integer = igrid.LastIndex( 1 )
		  var lastColIndex as integer = igrid.LastIndex( 2 )
		  
		  var grid as new ObjectGrid
		  grid.ResizeTo lastRowIndex, lastColIndex
		  
		  for row as integer = 0  to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      grid( row, col ) = new GridMember( igrid( row, col ) )
		    next
		  next
		  
		  return grid
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromStringGrid(sgrid(, ) As String) As ObjectGrid
		  var lastRowIndex as integer = sgrid.LastIndex( 1 )
		  var lastColIndex as integer = sgrid.LastIndex( 2 )
		  
		  var grid as new ObjectGrid
		  grid.ResizeTo lastRowIndex, lastColIndex
		  
		  for row as integer = 0  to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      grid( row, col ) = new GridMember( sgrid( row, col ) )
		    next
		  next
		  
		  return grid
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  return self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Left(member As GridMember) As GridMember
		  if member.Column = 0 then
		    return nil
		  else
		    return Grid( member.Row, member.Column - 1 )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MainDirectionals() As ObjectGrid.NextDelegate()
		  var directionals() as ObjectGrid.NextDelegate
		  directionals.Add AddressOf Above
		  directionals.Add AddressOf Right
		  directionals.Add AddressOf Below
		  directionals.Add AddressOf Left
		  
		  return directionals
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MoveNext() As Boolean
		  IteratorColumn = IteratorColumn + 1
		  if IteratorColumn > LastColIndex then
		    IteratorColumn = 0
		    IteratorRow = IteratorRow + 1
		    if IteratorRow > LastRowIndex then
		      IteratorRow = 0
		      IteratorColumn = -1
		      return false
		    end if
		  end if
		  
		  return true
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function NextDelegate(member As GridMember) As GridMember
	#tag EndDelegateDeclaration

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

	#tag Method, Flags = &h0
		Function Right(member As GridMember) As GridMember
		  if member.Column = LastColIndex then
		    return nil
		  else
		    return Grid( member.Row, member.Column + 1 )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Value() As Variant
		  // Part of the Iterator interface.
		  return Grid( IteratorRow, IteratorColumn )
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Grid(-1,-1) As GridMember
	#tag EndProperty

	#tag Property, Flags = &h21
		Private IteratorColumn As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private IteratorRow As Integer = 0
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
		#tag ViewProperty
			Name="ToString"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
