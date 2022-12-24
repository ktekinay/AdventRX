#tag Class
Protected Class TetrisGrid
Inherits ObjectGrid
	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  var original as string = super.Operator_Convert()
		  
		  var rows() as string = original.Split( EndOfLine )
		  
		  for rowIndex as integer = rows.LastIndex downto 0
		    var row as string = rows( rowIndex )
		    if row.IndexOf( "#" ) <> -1 or row.IndexOf( "@" ) <> -1 then
		      rows.ResizeTo rowIndex + 1
		      exit
		    end if
		  next
		  
		  var midPoint as integer = rows.LastIndex / 2
		  for i as integer = 0 to midPoint
		    var temp as string = rows( rows.LastIndex - i )
		    rows( rows.LastIndex - i ) = rows( i )
		    rows( i ) = temp
		  next
		  
		  return String.FromArray( rows, EndOfLine )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateHighPoint()
		  for row as integer = LastRowIndex downto HighPoint
		    for col as integer = 0 to LastColIndex
		      if grid( row, col ) <> nil then
		        HighPoint = row
		        exit for row
		      end if
		    next
		  next
		  
		  if LastRowIndex <= ( HighPoint + 10 ) then
		    ResizeTo( LastRowIndex + 20, LastColIndex )
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		HighPoint As Integer
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
		#tag ViewProperty
			Name="ToString"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
