#tag Class
Protected Class Operator
Inherits BITS.Packet
	#tag Event
		Function GetValue() As Integer
		  var value as integer
		  
		  select case Type
		  case 0 // sum
		    for each s as BITS.Packet in Subpackets
		      value = value + s.Value
		    next
		    
		  case 1 // product
		    value = 1
		    
		    for each s as BITS.Packet in Subpackets
		      value = value * s.Value
		    next
		    
		  case 2 // minimum
		    value = Subpackets( 0 ).Value
		    
		    for each s as BITS.Packet in Subpackets
		      value = min( value, s.Value )
		    next
		    
		  case 3 // maximum
		    value = Subpackets( 0 ).Value
		    
		    for each s as BITS.Packet in Subpackets
		      value = max( value, s.Value )
		    next
		    
		  case 5 // greater
		    value = if( Subpackets( 0 ).Value > Subpackets( 1 ).Value, 1, 0 )
		    
		  case 6 // less than
		    value = if( Subpackets( 0 ).Value < Subpackets( 1 ).Value, 1, 0 )
		    
		  case 7 // equal
		    value = if( Subpackets( 0 ).Value = Subpackets( 1 ).Value, 1, 0 )
		    
		  end select
		  
		  return value
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Parse(mb As MemoryBlock, ByRef bitStart As Integer)
		  var lengthType as integer = ExtractBitValue( mb, bitStart, 1 )
		  
		  select case lengthType
		  case 0
		    var length as integer = ExtractBitValue( mb, bitStart, 15 )
		    var expectedBitStart as integer = bitStart + length
		    while bitStart < expectedBitStart
		      Subpackets.Add BITS.Parse( mb, bitStart )
		    wend
		    
		  case 1
		    var count as integer = ExtractBitValue( mb, bitStart, 11 )
		    
		    for i as integer = 1 to count
		      Subpackets.Add BITS.Parse( mb, bitStart )
		    next
		    
		  end select
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function GetVersionSum() As Integer
		  var sum as integer = Version
		  
		  for each s as BITS.Packet in Subpackets
		    sum = sum + s.GetVersionSum
		  next
		  
		  return sum
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Subpackets() As BITS.Packet
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
