#tag Module
Protected Module BITS
	#tag Method, Flags = &h21
		Private Function ExtractBitsxx(mb As MemoryBlock, ByRef bitStart As Integer, bitLength As Integer) As MemoryBlock
		  mb.LittleEndian = false
		  
		  var firstByteIndex as integer = bitStart \ 8
		  var lastByteIndex as integer = ( bitStart + bitLength - 1 ) \ 8
		  var firstBitIndex as integer = bitStart mod 8
		  var lastBitIndex as integer = firstBitIndex + bitLength - 1 
		  var flushBits as integer = ( lastBitIndex + 1 ) mod 8
		  if flushBits <> 0 then
		    flushBits = 8 - flushBits
		  end if
		  var newSize as integer = lastByteIndex - firstBYteIndex + 1
		  
		  var result as new MemoryBlock( newSize )
		  result.LittleEndian = mb.LittleEndian
		  
		  result.StringValue( 0, newSize ) = mb.StringValue( firstByteIndex, newSize )
		  
		  if firstBitIndex <> 0 then
		    mb.Byte( 0 ) = Bitwise.ShiftLeft( mb.Byte( 0 ), firstBitIndex )
		    
		    for byteIndex as integer = 1 to lastByteIndex
		      var thisByte as integer = mb.Byte( byteIndex )
		      var prevByte as integer = mb.Byte( byteIndex - 1 )
		      prevByte = prevByte or BitWise.ShiftRight( thisByte, 8 - firstBitIndex )
		      mb.Byte( byteIndex - 1 ) = prevByte
		      
		      thisByte = Bitwise.ShiftLeft( thisByte, firstBitIndex )
		    next
		  end if
		  
		  bitStart = bitStart + bitLength
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExtractBitValue(mb As MemoryBlock, ByRef bitStart As Integer, bitLength As Integer) As UInt64
		  mb.LittleEndian = false
		  
		  var firstByteIndex as integer = bitStart \ 8
		  var lastByteIndex as integer = ( bitStart + bitLength - 1 ) \ 8
		  var firstBitIndex as integer = bitStart mod 8
		  var lastBitIndex as integer = firstBitIndex + bitLength - 1 
		  var flushBits as integer = ( lastBitIndex + 1 ) mod 8
		  if flushBits <> 0 then
		    flushBits = 8 - flushBits
		  end if
		  
		  var value as UInt64
		  for byteIndex as integer = firstByteIndex to lastByteIndex
		    var thisByte as integer = mb.Byte( byteIndex )
		    value = Bitwise.ShiftLeft( value, 8 ) or thisByte
		  next
		  
		  if flushBits <> 0 then
		    value = Bitwise.ShiftRight( value, flushBits )
		  end if
		  
		  var mask as UInt64 = ( 2 ^ bitLength ) - 1
		  value = value and mask
		  
		  bitStart = bitStart + bitLength
		  
		  return value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Parse(mb As MemoryBlock, ByRef bitStart As Integer) As BITS.Packet
		  mb.LittleEndian = false
		  
		  var version as integer = ExtractBitValue( mb, bitStart, 3 )
		  var type as integer = ExtractBitValue( mb, bitStart, 3 )
		  
		  var result as BITS.Packet
		  
		  select case type
		  case 4
		    result = new BITS.LiteralPacket
		    
		  case else
		    result = new BITS.Operator
		    
		  end select
		  
		  if result isa object then
		    result.Version = version
		    result.Type = type
		    
		    result.Parse mb, bitStart
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod


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
End Module
#tag EndModule
