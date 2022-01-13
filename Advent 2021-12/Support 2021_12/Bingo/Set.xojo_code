#tag Class
Protected Class Set
	#tag Method, Flags = &h0
		Sub AddBoard(input As String)
		  do
		    var orig as string = input
		    input = input.ReplaceAll( "  ", " " )
		    if input = orig then
		      exit
		    end if
		  loop
		  
		  var b as new Bingo.Board
		  
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  for row as integer = 0 to rows.LastIndex
		    var cols() as string = rows( row ).Trim.Split( " " )
		    for col as integer = 0 to cols.LastIndex
		      var squareValue as integer = cols( col ).Trim.ToInteger
		      b.Grid( row, col ) = Squares( squareValue )
		    next col
		  next row
		  
		  Boards.Add b
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CallValue(value As Integer) As Bingo.Board
		  Squares( value ).IsMarked = true
		  
		  var winner as Bingo.Board
		  
		  for each b as Bingo.Board in Boards
		    if b.IsWinner = false and b.IsBingo then
		      b.IsWinner = true
		      if winner is nil then
		        winner = b
		      end if
		      //
		      // Mark the rest of the boards
		      //
		    end if
		  next
		  
		  return winner
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  for i as integer = 0 to 500
		    Squares.Add new Square( i )
		  next
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Boards() As Bingo.Board
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Squares() As Bingo.Square
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
