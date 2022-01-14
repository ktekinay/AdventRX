#tag Class
Protected Class Luggage
	#tag Method, Flags = &h0
		Sub Holds(count As Integer, l As Luggage)
		  LuggageInside.Add count : l
		  l.mLuggageOutside.Add new WeakRef( self )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LuggageOutside() As Luggage()
		  var result() as Luggage
		  
		  for each wr as WeakRef in mLuggageOutside
		    var l as Luggage = Luggage( wr.Value )
		    result.Add l
		  next
		  
		  return result
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		CanBeOutermost As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		LuggageInside() As Pair
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLuggageOutside() As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
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
