#tag Class
Protected Class Range
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(otherRange As Advent.Range)
		  Constructor( otherRange.Minimum, otherRange.Maximum )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(minimum As Integer, maximum As Integer)
		  Constructor
		  
		  self.Minimum = minimum
		  self.Maximum = maximum
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(otherRange As Advent.Range) As Boolean
		  return Minimum <= otherRange.Minimum and Maximum >= otherRange.Maximum
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(value As Integer) As Boolean
		  return value >= Minimum and value <= Maximum
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden )  Function Operator_Compare(other As Advent.Range) As Integer
		  select case true
		  case Minimum < other.Minimum
		    return -1
		  case Minimum = other.Minimum
		    return other.Maximum - Maximum
		  case else
		    return 1
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  return ToString
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Overlaps(otherRange As Advent.Range) As Boolean
		  if otherRange.Minimum <= Minimum and otherRange.Maximum >= Minimum then
		    return true
		  elseif Minimum <= otherRange.Minimum and Maximum >= otherRange.Minimum then
		    return true
		  end if
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206D756C7469706C652C2064697374696E63742072616E676573207468617420636F7665722074686520636F6D62696E6564206C656E677468206F6620656163682072616E67652E
		Function Segment(other As Advent.Range) As Advent.Range()
		  var segments() as Advent.Range
		  
		  if other = self then
		    segments.Add new Advent.Range( self )
		    return segments
		  end if
		  
		  var lesser as Advent.Range
		  var greater as Advent.Range
		  
		  if self < other then
		    lesser = self
		    greater = other
		  else
		    lesser = other
		    greater = self
		  end if
		  
		  if not lesser.Overlaps( greater ) then
		    segments.Add new Advent.Range( lesser )
		    segments.Add new Advent.Range( greater )
		    
		    return segments // EARLY RETURN!!
		  end if
		  
		  if lesser.Minimum < greater.Minimum then
		    segments.Add new Advent.Range( lesser.Minimum, greater.Minimum - 1 )
		    
		    if lesser.Maximum = greater.Maximum then
		      segments.Add new Advent.Range( greater )
		    elseif lesser.Maximum < greater.Maximum then
		      segments.Add new Advent.Range( greater.Minimum, lesser.Maximum )
		      segments.Add new Advent.Range( lesser.Maximum + 1, greater.Maximum )
		    else // lesser.Maximum > greater.Maximum
		      segments.Add new Advent.Range( greater )
		      segments.Add new Advent.Range( greater.Maximum + 1, lesser.Maximum )
		    end if
		    
		    return segments // EARLY RETURN!!
		  end if
		  
		  //
		  // The Minimums are equal so lesser.Maximum < greater.Maximum
		  //
		  segments.Add new Advent.Range( lesser )
		  segments.Add new Advent.Range( lesser.Maximum + 1, greater.Maximum )
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Maximum - Minimum + 1
			End Get
		#tag EndGetter
		Length As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Maximum As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Minimum As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Minimum.ToString + "-" + Maximum.ToString
			  
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
			Name="Maximum"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Minimum"
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
		#tag ViewProperty
			Name="Length"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
