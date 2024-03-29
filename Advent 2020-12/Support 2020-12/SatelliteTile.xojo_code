#tag Class
Protected Class SatelliteTile
	#tag Method, Flags = &h0
		Sub Constructor(data As String)
		  LinkTested = new Dictionary
		  OrientationLinkedAtRightDict = new Dictionary
		  OrientationLinkedBelowDict = new Dictionary
		  
		  var rows() as string = data.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  //
		  // First row is ID
		  //
		  ID = rows( 0 ).NthField( " ", 2 ).Trim( ":" ).ToInteger
		  
		  rows.RemoveAt 0 
		  
		  Grid.ResizeTo rows.LastIndex, rows( 1 ).Bytes - 1
		  
		  for rowIndex as integer = 0 to rows.LastIndex
		    var row as string = rows( rowIndex )
		    
		    var cols() as string = row.Split( "" )
		    for colIndex as integer = 0 to cols.LastIndex
		      Grid( rowIndex, colIndex ) = cols( colIndex )
		    next
		  next
		  
		  //
		  // Calculate the hashes
		  //
		  var lastRowIndex as integer = Grid.LastIndex( 1 )
		  var lastColIndex as integer = Grid.LastIndex( 2 )
		  
		  var calculate() as string
		  calculate.ResizeTo lastColIndex
		  
		  
		  for row as integer = 0 to lastRowIndex
		    calculate( row ) = Grid( row, 0 )
		  next
		  
		  LeftBorderHash = HashArray( calculate )
		  BorderHashes.Add LeftBorderHash.Left
		  BorderHashes.Add LeftBorderHash.Right
		  
		  
		  for col as integer = 0 to lastColIndex
		    calculate( col ) = Grid( 0, col )
		  next
		  
		  TopBorderHash = HashArray( calculate )
		  BorderHashes.Add TopBorderHash.Left
		  BorderHashes.Add TopBorderHash.Right
		  
		  
		  for row as integer = 0 to lastRowIndex
		    calculate( row ) = Grid( row, lastColIndex )
		  next
		  
		  RightBorderHash = HashArray( calculate )
		  BorderHashes.Add RightBorderHash.Left
		  BorderHashes.Add RightBorderHash.Right
		  
		  
		  for col as integer = 0 to lastColIndex
		    calculate( col ) = Grid( lastRowIndex, col )
		  next
		  
		  BottomBorderHash = HashArray( calculate )
		  BorderHashes.Add BottomBorderHash.Left
		  BorderHashes.Add BottomBorderHash.Right
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HashArray(arr() As String) As Pair
		  var forward as MemoryBlock = Crypto.SHA2_256( String.FromArray( arr, "" ) )
		  
		  var reverseArr() as string
		  reverseArr.ResizeTo arr.LastIndex
		  for i as integer = 0 to arr.LastIndex
		    reverseArr( reverseArr.LastIndex - i ) = arr( i )
		  next
		  
		  var reverse as MemoryBlock = Crypto.SHA2_256( String.FromArray( reverseArr, "" ) )
		  
		  return forward : reverse
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Link(other As SatelliteTile)
		  if other.ID = ID then
		    //
		    // Same tile
		    //
		    return
		  end if
		  
		  if LinkTested.HasKey( other.ID ) then
		    //
		    // Already tested
		    //
		    return
		  end if
		  
		  LinkTested.Value( other.ID ) = nil
		  
		  var startingOrientation as Orientations = Orientation
		  
		  for thisOrientationIndex as integer = kFirstOrientationIndex to kLastOrientationIndex
		    Orientation = Ctype( thisOrientationIndex, Orientations )
		    
		    var rightHash as MemoryBlock = self.RightHash
		    var bottomHash as MemoryBlock = self.BottomHash
		    
		    var otherStartingOrientation as Orientations = other.Orientation
		    
		    for otherOrientationIndex as integer = kFirstOrientationIndex to kLastOrientationIndex
		      other.Orientation = Ctype( otherOrientationIndex, Orientations )
		      
		      if other.LeftHash = rightHash then
		        var empty() as Pair
		        var arr() as Pair = OrientationLinkedAtRightDict.Lookup( Orientation, empty )
		        arr.Add other.ID : other.Orientation
		        OrientationLinkedAtRightDict.Value( Orientation ) = arr
		      end if
		      
		      if other.TopHash = bottomHash then
		        var empty() as Pair
		        var arr() as Pair = OrientationLinkedBelowDict.Lookup( Orientation, empty )
		        arr.Add other.ID : other.Orientation
		        OrientationLinkedBelowDict.Value( Orientation ) = arr
		      end if
		    next
		    
		    other.Orientation = otherStartingOrientation
		  next
		  
		  Orientation = startingOrientation
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LinkedAtRight() As Pair()
		  var empty() as Pair
		  return OrientationLinkedAtRightDict.Lookup( Orientation, empty )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LinkedBelow() As Pair()
		  var empty() as Pair
		  return OrientationLinkedBelowDict.Lookup( Orientation, empty )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NextCol0(ByRef row As Integer, ByRef col As Integer, lastIndex As Integer, leftToRight As Boolean, topToBottom As Boolean) As Boolean
		  var rowStepper as integer = if( topToBottom, 1, -1 )
		  
		  if leftToRight then
		    col = col + 1
		    if col > lastIndex then
		      row = row + rowStepper
		      col = 1
		    end if
		    
		  else
		    col = col - 1
		    if col < 1 then
		      col = lastIndex
		      row = row + rowStepper
		    end if
		    
		  end if
		  
		  if row > lastIndex or row < 1 then
		    return false
		  end if
		  
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NextCol90(ByRef row As Integer, ByRef col As Integer, lastIndex As Integer, leftToRight As Boolean, topToBottom As Boolean) As Boolean
		  var colStepper as integer = if( leftToRight, 1, -1 )
		  
		  if topToBottom then
		    row = row + 1
		    if row > lastIndex then
		      row = 1
		      col = col + colStepper
		    end if
		    
		  else
		    row = row - 1
		    if row < 1 then
		      row = lastIndex
		      col = col + colStepper
		    end if
		    
		  end if
		  
		  if col > lastIndex or col < 1 then
		    return false
		  end if
		  
		  return true
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function NextColDelegate(ByRef row As Integer, ByRef col As Integer, lastIndex As Integer, leftToRight As Boolean, topToBottom As Boolean) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub WriteTo(stringGrid(, ) As String, startRow As Integer, startCol As Integer)
		  var lastIndex as integer = Grid.LastIndex - 1
		  
		  var firstRow as integer
		  var firstCol as integer
		  
		  var stepper as NextColDelegate
		  var leftToRight as boolean
		  var topToBottom as boolean
		  
		  select case Orientation
		  case Orientations.R0
		    firstRow = 1
		    firstCol = 1
		    
		    stepper = AddressOf NextCol0
		    leftToRight = true
		    topToBottom = true
		    
		  case Orientations.R0FlippedBoth
		    firstRow = lastIndex
		    firstCol = lastIndex
		    
		    stepper = AddressOf nextCol0
		    leftToRight = false
		    topToBottom = false
		    
		  case Orientations.R0FlippedHorizontal
		    firstRow = 1
		    firstCol = lastIndex
		    
		    stepper = AddressOf NextCol0
		    leftToRight = false
		    topToBottom = true
		    
		  case Orientations.R0FlippedVertical
		    firstRow = lastIndex
		    firstCol = 1
		    
		    stepper = AddressOf nextCol0
		    leftToRight = true
		    topToBottom = false
		    
		    
		  case Orientations.R90
		    firstRow = lastIndex
		    firstCol = 1
		    
		    stepper = AddressOf NextCol90
		    leftToRight = true
		    topToBottom = false
		    
		  case Orientations.R90FlippedBoth
		    firstRow = 1
		    firstCol = lastIndex
		    
		    stepper = AddressOf nextCol90
		    leftToRight = false
		    topToBottom = true
		    
		  case Orientations.R90FlippedHorizontal
		    firstRow = 1
		    firstCol = 1
		    
		    stepper = AddressOf nextCol90
		    leftToRight = true
		    topToBottom = true
		    
		  case Orientations.R90FlippedVertical
		    firstRow = lastIndex
		    firstCol = lastIndex
		    
		    stepper = AddressOf NextCol90
		    leftToRight = false
		    topToBottom = false
		    
		    
		  case Orientations.R180
		    firstRow = lastIndex
		    firstCol = lastIndex
		    
		    stepper = AddressOf NextCol0
		    leftToRight = false
		    topToBottom = false
		    
		  case Orientations.R180FlippedHorizontal
		    firstRow = lastIndex
		    firstCol = 1
		    
		    stepper = AddressOf NextCol0
		    leftToRight = true
		    topToBottom = false
		    
		  case Orientations.R180FlippedVertical
		    firstRow = 1
		    firstCol = lastIndex
		    
		    stepper = AddressOf NextCol0
		    leftToRight = false
		    topToBottom = true
		    
		    
		  case Orientations.R270
		    firstRow = lastIndex
		    firstCol = 1
		    
		    stepper = AddressOf NextCol90
		    leftToRight = true
		    topToBottom = false
		    
		  case Orientations.R270FlippedBoth
		    firstRow = 1
		    firstCol = lastIndex
		    
		    stepper = AddressOf nextCol90
		    leftToRight = false
		    topToBottom = true
		    
		  case Orientations.R270FlippedHorizontal
		    firstRow = lastIndex
		    firstCol = lastIndex
		    
		    stepper = AddressOf nextCol90
		    leftToRight = false
		    topToBottom = false
		    
		  case Orientations.R270FlippedVertical
		    firstRow = 1
		    firstCol = 1
		    
		    stepper = AddressOf NextCol90
		    leftToRight = true
		    topToBottom = true
		    
		  end select
		  
		  var row as integer = firstRow
		  var col as integer = firstCol
		  
		  var writeRow as integer = startRow
		  var writeCol as integer = startCol
		  var lastWriteCol as integer = startCol + lastIndex - 1
		  
		  do
		    stringGrid( writeRow, writeCol ) = grid( row, col )
		    
		    writeCol = writeCol + 1
		    if writeCol > lastWriteCol then
		      writeCol = startCol
		      writeRow = writeRow + 1
		    end if
		  loop until stepper.Invoke( row, col, lastIndex, leftToRight, topToBottom ) = false
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1, Description = 416C6C2074686520626F72646572206861736865733A20546F7020466F72776172642C20546F7020526576657273652C204C65667420466F72776172642C204C65667420526576657273652C206574632E
		Protected BorderHashes() As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private BottomBorderHash As Pair
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  select case Orientation
			  case Orientations.R0
			    return BottomBorderHash.Left
			    
			  case Orientations.R0FlippedHorizontal
			    return BottomBorderHash.Right
			    
			  case Orientations.R0FlippedVertical
			    return TopBorderHash.Left
			    
			  case Orientations.R0FlippedBoth
			    return TopBorderHash.Right
			    
			  case Orientations.R90
			    return RightBorderHash.Right
			    
			  case Orientations.R90FlippedHorizontal
			    return RightBorderHash.Left
			    
			  case Orientations.R90FlippedVertical
			    return LeftBorderHash.Right
			    
			  case Orientations.R90FlippedBoth
			    return LeftBorderHash.Left
			    
			  case Orientations.R180
			    return TopBorderHash.Right
			    
			  case Orientations.R180FlippedHorizontal
			    return TopBorderHash.Left
			    
			  case Orientations.R180FlippedVertical
			    return BottomBorderHash.Right
			    
			  case Orientations.R270
			    return LeftBorderHash.Left
			    
			  case Orientations.R270FlippedHorizontal
			    return LeftBorderHash.Right
			    
			  case Orientations.R270FlippedVertical
			    return RightBorderHash.Left
			    
			  case Orientations.R270FlippedBoth
			    return RightBorderHash.Right
			    
			  case else
			    raise new UnsupportedOperationException
			    
			  end select
			  
			End Get
		#tag EndGetter
		BottomHash As MemoryBlock
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Grid(-1,-1) As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		IsInUse As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LeftBorderHash As Pair
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  select case Orientation
			  case Orientations.R0
			    return LeftBorderHash.Left
			    
			  case Orientations.R0FlippedHorizontal
			    return RightBorderHash.Left
			    
			  case Orientations.R0FlippedVertical
			    return LeftBorderHash.Right
			    
			  case Orientations.R0FlippedBoth
			    return RightBorderHash.Right
			    
			  case Orientations.R90
			    return BottomBorderHash.Left
			    
			  case Orientations.R90FlippedHorizontal
			    return TopBorderHash.Left
			    
			  case Orientations.R90FlippedVertical
			    return BottomBorderHash.Right
			    
			  case Orientations.R90FlippedBoth
			    return TopBorderHash.Right
			    
			  case Orientations.R180
			    return RightBorderHash.Right
			    
			  case Orientations.R180FlippedHorizontal
			    return LeftBorderHash.Right
			    
			  case Orientations.R180FlippedVertical
			    return RightBorderHash.Left
			    
			  case Orientations.R270
			    return TopBorderHash.Right
			    
			  case Orientations.R270FlippedHorizontal
			    return BottomBorderHash.Right
			    
			  case Orientations.R270FlippedVertical
			    return TopBorderHash.Left
			    
			  case Orientations.R270FlippedBoth
			    return BottomBorderHash.Left
			    
			  case else
			    raise new UnsupportedOperationException
			    
			  end select
			  
			End Get
		#tag EndGetter
		LeftHash As MemoryBlock
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private LinkTested As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		Orientation As Orientations = Orientations.R0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private OrientationLinkedAtRightDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private OrientationLinkedBelowDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private RightBorderHash As Pair
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  select case Orientation
			  case Orientations.R0
			    return RightBorderHash.Left
			    
			  case Orientations.R0FlippedHorizontal
			    return LeftBorderHash.Left
			    
			  case Orientations.R0FlippedVertical
			    return RightBorderHash.Right
			    
			  case Orientations.R0FlippedBoth
			    return LeftBorderHash.Right
			    
			  case Orientations.R90
			    return TopBorderHash.Left
			    
			  case Orientations.R90FlippedHorizontal
			    return BottomBorderHash.Left
			    
			  case Orientations.R90FlippedVertical
			    return TopBorderHash.Right
			    
			  case Orientations.R90FlippedBoth
			    return BottomBorderHash.Right
			    
			  case Orientations.R180
			    return LeftBorderHash.Right
			    
			  case Orientations.R180FlippedHorizontal
			    return RightBorderHash.Right
			    
			  case Orientations.R180FlippedVertical
			    return LeftBorderHash.Left
			    
			  case Orientations.R270
			    return BottomBorderHash.Right
			    
			  case Orientations.R270FlippedHorizontal
			    return TopBorderHash.Right
			    
			  case Orientations.R270FlippedVertical
			    return BottomBorderHash.Left
			    
			  case Orientations.R270FlippedBoth
			    return TopBorderHash.Left
			    
			  case else
			    raise new UnsupportedOperationException
			    
			  end select
			  
			End Get
		#tag EndGetter
		RightHash As MemoryBlock
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private TopBorderHash As Pair
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  select case Orientation
			  case Orientations.R0
			    return TopBorderHash.Left
			    
			  case Orientations.R0FlippedHorizontal
			    return TopBorderHash.Right
			    
			  case Orientations.R0FlippedVertical
			    return BottomBorderHash.Left
			    
			  case Orientations.R0FlippedBoth
			    return BottomBorderHash.Right
			    
			  case Orientations.R90
			    return LeftBorderHash.Right
			    
			  case Orientations.R90FlippedHorizontal
			    return LeftBorderHash.Left
			    
			  case Orientations.R90FlippedVertical
			    return RightBorderHash.Right
			    
			  case Orientations.R90FlippedBoth
			    return RightBorderHash.Left
			    
			  case Orientations.R180
			    return BottomBorderHash.Right
			    
			  case Orientations.R180FlippedHorizontal
			    return BottomBorderHash.Left
			    
			  case Orientations.R180FlippedVertical
			    return TopBorderHash.Right
			    
			  case Orientations.R270
			    return RightBorderHash.Left
			    
			  case Orientations.R270FlippedHorizontal
			    return RightBorderHash.Right
			    
			  case Orientations.R270FlippedVertical
			    return LeftBorderHash.Left
			    
			  case Orientations.R270FlippedBoth
			    return LeftBorderHash.Right
			    
			  case else
			    raise new UnsupportedOperationException
			    
			  end select
			  
			End Get
		#tag EndGetter
		TopHash As MemoryBlock
	#tag EndComputedProperty


	#tag Constant, Name = kFirstOrientationIndex, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLastOrientationIndex, Type = Double, Dynamic = False, Default = \"14", Scope = Public
	#tag EndConstant


	#tag Enum, Name = Orientations, Type = Integer, Flags = &h0
		R0
		  R0FlippedHorizontal
		  R0FlippedVertical
		  R0FlippedBoth
		  R90
		  R90FlippedHorizontal
		  R90FlippedVertical
		  R90FlippedBoth
		  R180
		  R180FlippedHorizontal
		  R180FlippedVertical
		  R270
		  R270FlippedHorizontal
		  R270FlippedVertical
		R270FlippedBoth
	#tag EndEnum


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
			Name="ID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Orientation"
			Visible=false
			Group="Behavior"
			InitialValue="Orientations.R0"
			Type="Orientations"
			EditorType="Enum"
			#tag EnumValues
				"0 - R0"
				"1 - R0FlippedHorizontal"
				"2 - R0FlippedVertical"
				"3 - R0FlippedBoth"
				"4 - R90"
				"5 - R90FlippedHorizontal"
				"6 - R90FlippedVertical"
				"7 - R90FlippedBoth"
				"8 - R180"
				"9 - R180FlippedHorizontal"
				"10 - R180FlippedVertical"
				"11 - R270"
				"12 - R270FlippedHorizontal"
				"13 - R270FlippedVertical"
				"14 - R270FlippedBoth"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsInUse"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
