#tag Class
Protected Class SeedMap
	#tag Method, Flags = &h0
		Sub Add(sourceRange As Advent.Range, destRange As Advent.Range)
		  SourceRanges.Add sourceRange
		  DestRanges.Add destRange
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Corresponding(range As Advent.Range) As Advent.Range()
		  for i as integer = 0 to SourceRanges.LastIndex
		    var source as Advent.Range = SourceRanges( i )
		    if source.Overlaps( range ) then
		      var result() as Advent.Range
		      var dest as Advent.Range = DestRanges( i )
		      var adjustedDest as new Advent.Range( dest )
		      
		      var diff as integer = source.Minimum - range.Minimum
		      if diff > 0 then
		        result.Add new Advent.Range( range.Minimum, source.Minimum - 1 )
		      elseif diff < 0 then
		        adjustedDest.Minimum = adjustedDest.Minimum - diff
		      end if
		      
		      diff = range.Maximum - source.Maximum
		      if diff > 0 then
		        result.Add new Advent.Range( source.Maximum + 1, range.Maximum )
		      elseif diff < 0 then
		        adjustedDest.Maximum = adjustedDest.Maximum + diff
		      end if
		      
		      result.Add adjustedDest
		      return result
		      
		    end if
		  next
		  
		  return Array( range )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Corresponding(id As Integer) As Integer
		  for i as integer = 0 to SourceRanges.LastIndex
		    var source as Advent.Range = SourceRanges( i )
		    if id.IsWithin( source ) then
		      var diff as integer = id - source.Minimum
		      var dest as Advent.Range = DestRanges( i )
		      return dest.Minimum + diff
		    end if
		  next
		  
		  return id
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		DestRanges() As Advent.Range
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceRanges() As Advent.Range
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
