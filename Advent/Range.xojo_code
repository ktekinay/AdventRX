#tag Class
Protected Class Range
	#tag Method, Flags = &h0
		Sub Constructor()
		  
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
		Function Operator_Convert() As String
		  return ToString
		  
		End Function
	#tag EndMethod


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
	#tag EndViewBehavior
End Class
#tag EndClass
