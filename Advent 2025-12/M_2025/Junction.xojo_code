#tag Class
Protected Class Junction
	#tag Method, Flags = &h0
		Function Closest() As Pair
		  for each p as Pair in Others
		    var j as Junction = p.Right
		    if not j.IsClosed then
		      return p
		    end if
		  next
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Distance(j1 As Junction, j2 As Junction) As Double
		  var xVal as double = ( j1.X - j2.X ) ^ 2.0
		  var yVal as double = ( j1.Y - j2.Y ) ^ 2.0
		  var zVal as double = ( j1.Z - j2.Z ) ^ 2.0
		  
		  return Sqrt( xVal + yVal + zVal )
		   
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PairSorter(p1 As Pair, p2 As Pair) As Integer
		  const kMult as double = 100000.0
		  
		  var d1 as integer = p1.Left.DoubleValue * kMult
		  var d2 as integer = p2.Left.DoubleValue * kMult
		  
		  return d1 - d2
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  Connections.RemoveAll
		  Others.RemoveAll
		  Circuit = nil
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Circuit As Set
	#tag EndProperty

	#tag Property, Flags = &h0
		Connections() As Junction
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Connections.Count = 2
			  
			End Get
		#tag EndGetter
		IsClosed As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Others() As Pair
	#tag EndProperty

	#tag Property, Flags = &h0
		X As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Y As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Z As Integer
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
