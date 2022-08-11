#tag Class
Protected Class SatelliteTile
	#tag Method, Flags = &h0
		Sub Constructor(data As String)
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
		  
		  for col as integer = 0 to lastColIndex
		    calculate( col ) = Grid( 0, col )
		  next
		  
		  TopBorderHash = HashArray( calculate )
		  BorderHashes.Add TopBorderHash.Left
		  BorderHashes.Add TopBorderHash.Right
		  
		  for row as integer = 0 to lastRowIndex
		    calculate( row ) = Grid( row, 0 )
		  next
		  
		  LeftBorderHash = HashArray( calculate )
		  BorderHashes.Add LeftBorderHash.Left
		  BorderHashes.Add LeftBorderHash.Right
		  
		  for col as integer = 0 to lastColIndex
		    calculate( col ) = Grid( lastRowIndex, col )
		  next
		  
		  BottomBorderHash = HashArray( calculate )
		  BorderHashes.Add BottomBorderHash.Left
		  BorderHashes.Add BottomBorderHash.Right
		  
		  for row as integer = 0 to lastRowIndex
		    calculate( row ) = Grid( row, lastColIndex )
		  next
		  
		  RightBorderHash = HashArray( calculate )
		  BorderHashes.Add RightBorderHash.Left
		  BorderHashes.Add RightBorderHash.Right
		  
		  
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


	#tag Property, Flags = &h0, Description = 416C6C2074686520626F72646572206861736865733A20546F7020466F72776172642C20546F7020526576657273652C204C65667420466F72776172642C204C65667420526576657273652C206574632E
		BorderHashes() As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h0
		BottomBorderHash As Pair
	#tag EndProperty

	#tag Property, Flags = &h0
		Grid(-1,-1) As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		LeftBorderHash As Pair
	#tag EndProperty

	#tag Property, Flags = &h0
		RightBorderHash As Pair
	#tag EndProperty

	#tag Property, Flags = &h0
		TopBorderHash As Pair
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
			Name="ID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
