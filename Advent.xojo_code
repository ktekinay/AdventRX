#tag Module
Protected Module Advent
	#tag Method, Flags = &h0
		Function BlackVerticalRectangleString() As String
		  return &u25AE
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(Extends arr() As Integer) As Integer()
		  var newArr() as integer
		  newArr.ResizeTo arr.LastIndex
		  
		  for i as integer = 0 to arr.LastIndex
		    newArr( i ) = arr( i )
		  next
		  
		  return newArr
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(Extends arr() As String) As String()
		  var newArr() as string
		  newArr.ResizeTo arr.LastIndex
		  
		  for i as integer = 0 to arr.LastIndex
		    newArr( i ) = arr( i )
		  next
		  
		  return newArr
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Column(Extends arr(, ) As String, column As Integer) As String()
		  var colValues() as string
		  var lastRowIndex as integer = arr.LastIndex( 1 )
		  for row as integer = 0 to lastRowIndex
		    colValues.Add arr( row, column )
		  next
		  
		  return colValues
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Extends mb As MemoryBlock, b As Byte) As Integer
		  var p as ptr = mb
		  var lastByte as integer = mb.Size - 1
		  
		  for pos as integer = 0 to lastByte
		    if p.Byte( pos ) = b then
		      return pos
		    end if
		  next
		  
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBelow(Extends pt As Xojo.Point, rect As Advent.GraphRect) As Boolean
		  return pt.Y < rect.Bottom
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBetween(Extends i As Integer, v1 As Integer, v2 As Integer) As Boolean
		  if v1 <= v2 then
		    return i >= v1 and i <= v2
		  else
		    return i >= v2 and i <= v1
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsInteger(Extends v As Variant) As Boolean
		  select case v.Type
		  case Variant.TypeInteger
		  case Variant.TypeInt32
		  case Variant.TypeInt64
		  case else
		    return false
		  end select
		  
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLeftOf(Extends pt As Xojo.Point, rect As Advent.GraphRect) As Boolean
		  return pt.X < rect.Left
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRightOf(Extends pt As Xojo.Point, rect As Advent.GraphRect) As Boolean
		  return pt.X > rect.Right
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsWithin(Extends value As Integer, range As Advent.Range) As Boolean
		  return range.Contains( value )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LightDotString() As String
		  return &u22C5
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Max(Extends arr() As Double) As Double
		  var result as double = -1.8E308
		  
		  for each d as double in arr
		    result = if( result > d, result, d )
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Max(Extends arr() As Integer) As Integer
		  var result as integer = 0 - &h7FFFFFFFFFFFFFFF
		  
		  for each i as integer in arr
		    result = if( result > i, result, i )
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Min(Extends arr() As Double) As Double
		  var result as double = 1.8E308
		  
		  for each d as double in arr
		    result = if( result < d, result, d )
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Min(Extends arr() As Integer) As Integer
		  var result as integer = &h7FFFFFFFFFFFFFFF
		  
		  for each i as integer in arr
		    result = if( result < i, result, i )
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MultiplyArray(arr() As Integer, includeZeros As Boolean) As Integer
		  var result as integer = 1
		  var foundItems as boolean
		  
		  for each num as integer in arr
		    if includeZeros or num <> 0 then
		      foundItems = true
		      result = result * num
		    end if
		  next
		  
		  if foundItems then
		    return result
		  else
		    return 0
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Row(Extends arr(, ) As String, row As Integer) As String()
		  var rowValues() as string
		  var lastColIndex as integer = arr.LastIndex( 2 )
		  for col as integer = 0 to lastColIndex
		    rowValues.Add arr( row, col )
		  next
		  
		  return rowValues
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Squeeze(Extends src As String, charSet As String = " ") As String
		  // Find any repeating characters, where the character is a member of
		  // charSet, and replace the run with a single character.  Example:
		  // Squeeze("wooow maaan", "aeiou") = "wow man".
		  
		  // Note: This is roughly the same speed as the StringUtils version, but
		  // *might* be faster under some circumstances, like in a long string where
		  // all the repeated strings occur at the end.
		  
		  dim srcLen as integer = src.Len
		  if srcLen < 2 then return src
		  
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  dim origEncoding as TextEncoding = src.Encoding
		  charSet = ConvertEncoding( charSet, origEncoding )
		  dim charArray() as string = charSet.Split( "" ) // Every character
		  dim repeatedChar as string // Declared outside the loop as optimization
		  for each aChar as string in charArray
		    dim buildArr( -1 ) as string
		    repeatedChar = aChar + aChar
		    src = src.ReplaceAll( repeatedChar, aChar )
		    dim n as integer
		    do
		      n = InStr( src, repeatedChar )
		      if n = 0 then
		        exit
		      else
		        buildArr.Append src.Left( n - 1 )
		        src = src.Mid( n + 1 )
		        src = src.ReplaceAll( repeatedChar, aChar )
		      end if
		    loop
		    if buildArr.Ubound > -1 then
		      buildArr.Append src
		      src = join( buildArr, "" ).ConvertEncoding( origEncoding )
		    end if
		  next
		  
		  return src
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SumArray(arr() As Integer) As Integer
		  var sum as integer
		  
		  for each value as integer in arr
		    sum = sum + value
		  next
		  
		  return sum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SumDoubleGroups(stringArr() As String) As Double()
		  var doubleArr( 0 ) as double
		  
		  for each s as string in stringArr
		    if s = "" then
		      doubleArr.Add 0.0
		      continue
		    end if
		    
		    doubleArr( doubleArr.LastIndex ) = doubleArr( doubleArr.LastIndex ) + s.ToDouble
		  next
		  
		  return doubleArr
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SumIntegerGroups(stringArr() As String) As Integer()
		  var intArr( 0 ) as integer
		  
		  for each s as string in stringArr
		    if s = "" then
		      intArr.Add 0
		      continue
		    end if
		    
		    intArr( intArr.LastIndex ) = intArr( intArr.LastIndex ) + s.ToInteger
		  next
		  
		  return intArr
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToFixedWidth(Extends s As String) As String
		  static fixedWidthArr() as string
		  
		  if fixedWidthArr.Count = 0 then
		    fixedWidthArr.ResizeTo 126
		    
		    fixedWidthArr( 0 ) = &u3000
		    
		    for i as integer = 1 to fixedWidthArr.LastIndex
		      fixedWidthArr( i ) = Encodings.UTF8.Chr( &hFF00 + i )
		    next
		  end if
		  
		  var chars() as string = s.Split( "" )
		  
		  for i as integer = 0 to chars.LastIndex
		    var char as string = chars( i )
		    var code as integer = char.Asc
		    var fixedWidthIndex as integer = code - 32
		    
		    if fixedWidthIndex >= 0 and fixedWidthIndex <= fixedWidthArr.LastIndex then
		      chars( i ) = fixedWidthArr( fixedWidthIndex )
		    end if
		  next
		  
		  s = String.FromArray( chars, "" )
		  
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToFixedWidth(s As String) As String
		  return s.ToFixedWidth
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToHMS(duration As Integer) As String
		  var builder() as string
		  
		  if duration > ( 60 * 60 ) then
		    var hours as integer = duration / ( 60 * 60 )
		    duration = duration mod ( 60 * 60 )
		    
		    if hours <> 0 then
		      builder.Add hours.ToString( "00" )
		    end if
		  end if
		  
		  var mins as integer = duration / 60
		  duration = duration mod 60
		  
		  builder.Add mins.ToString( "00" )
		  
		  builder.Add duration.ToString( "00" )
		  
		  return String.FromArray( builder, ":" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToKey(Extends pt As Xojo.Point, adjuster As Double = 10000000.0) As Variant
		  return pt.X * adjuster + pt.Y
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString(Extends arr() As String, sep As String = "") As String
		  return String.FromArray( arr, sep )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TryRemove(Extends dict As Dictionary, key As Variant)
		  if dict.HasKey( key ) then
		    dict.Remove( key )
		  end if
		  
		End Sub
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
