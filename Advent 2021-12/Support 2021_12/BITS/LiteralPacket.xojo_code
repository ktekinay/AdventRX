#tag Class
Protected Class LiteralPacket
Inherits BITS.Packet
	#tag Event
		Function GetValue() As Integer
		  return mValue
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Parse(mb As MemoryBlock, ByRef bitStart As Integer)
		  var value as UInt64
		  
		  do
		    var thisValue as UInt64 = ExtractBitValue( mb, bitStart, 5 )
		    value = Bitwise.ShiftLeft( value, 4 ) or ( thisValue and &b1111 )
		    if ( thisValue and &b10000 ) = 0 then
		      exit
		    end if
		  loop
		  
		  self.mValue = value
		  
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h21
		Private mValue As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
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
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
