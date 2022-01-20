#tag Class
Protected Class TicketRule
	#tag Method, Flags = &h0
		Sub AddColumnThatDoesNotMatch(col As Integer)
		  if ColumnsThatDoNotMatch.IndexOf( col ) = -1 then
		    ColumnsThatDoNotMatch.Add col
		  end if
		  
		  var pos as integer = ColumnsThatMatch.IndexOf( col )
		  if pos <> -1 then
		    ColumnsThatMatch.RemoveAt pos
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRange(rangeString As String)
		  var parts() as string = rangeString.Split( "-" )
		  var r as new Advent.Range( parts( 0 ).ToInteger, parts( 1 ).ToInteger )
		  Ranges.Add r
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(value As Integer) As Boolean
		  for each r as Advent.Range in Ranges
		    if value.IsWithin( r ) then
		      return true
		    end if
		  next
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaybeAddMatchingColumn(col As Integer)
		  if ColumnsThatDoNotMatch.IndexOf( col ) = -1 and ColumnsThatMatch.IndexOf( col ) = -1 then
		    ColumnsThatMatch.Add col
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  return ToString
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ColumnsThatDoNotMatch() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ColumnsThatMatch() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Ranges() As Advent.Range
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  var builder() as string
			  for each r as Advent.Range in Ranges
			    builder.Add r.ToString
			  next
			  
			  return String.FromArray( builder, "," )
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
	#tag EndViewBehavior
End Class
#tag EndClass
