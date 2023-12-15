#tag Class
Protected Class Advent_2023_12_03
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Look for adjacent numbers and symbols on a grid"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Gear Ratios"
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Variant
		  return CalculateResultA( Normalize( GetPuzzleInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Variant
		  return CalculateResultB( Normalize( GetPuzzleInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Variant
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  return CalculateResultB( Normalize( input ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  var rows() as string = ToStringArray( input )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "\d+"
		  
		  var total as integer
		  
		  for row as integer = 0 to rows.LastIndex
		    var line as string = rows( row )
		    
		    var match as RegExMatch = rx.Search( line )
		    
		    while match isa RegExMatch
		      var d as string = match.SubExpressionString( 0 )
		      var startPos as integer = match.SubExpressionStartB( 0 ) - 1
		      var endPos as integer = startPos + d.Bytes + 1
		      
		      if IsSymbol( line, startPos ) or IsSymbol( line, endPos ) or HasSymbol( rows, row - 1, startPos, endPos ) _
		        or HasSymbol( rows, row + 1, startPos, endPos ) then
		        total = total + d.ToInteger
		      end if
		      
		      match = rx.Search
		    wend
		  next
		  
		  return total : if( IsTest, 4361, 520135 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var rows() as string = ToStringArray( input )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "\*"
		  
		  var total as integer
		  
		  for row as integer = 0 to rows.LastIndex
		    var line as string = rows( row )
		    
		    var match as RegExMatch = rx.Search( line )
		    
		    while match isa RegExMatch
		      var startPos as integer = match.SubExpressionStartB( 0 )
		      
		      var numbers() as integer
		      GetNumbers( line, startPos, numbers )
		      if row > 0 then
		        GetNumbers( rows( row - 1 ), startPos, numbers )
		      end if
		      if row < rows.LastIndex then
		        GetNumbers( rows( row + 1 ), startPos, numbers )
		      end if
		      
		      if numbers.Count = 2 then
		        total = total + ( numbers( 0 ) * numbers( 1 ) )
		      end if
		      
		      match = rx.Search
		    wend
		  next
		  
		  return total : if( IsTest, 467835, 72514855 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetNumbers(line As String, startPos As Integer, toArr() As Integer)
		  var n as integer
		  
		  if IsNumeric( line.MiddleBytes( startPos, 1 ) ) then
		    for i as integer = startPos - 1 downto 0
		      if IsNumeric( line.MiddleBytes( i, 1 ) ) then
		        startPos = i
		      else
		        exit
		      end if
		    next
		    
		    for i as integer = startPos to line.Bytes - 1
		      var s as string = line.MiddleBytes( i, 1 )
		      if IsNumeric( s ) then
		        n = n * 10 + s.ToInteger
		      else
		        exit
		      end if
		    next
		    
		    if n > 0 then
		      toArr.Add n
		    end if
		    
		  else
		    var mult as integer = 1
		    
		    for i as integer = startPos - 1 downto 0
		      var s as string = line.MiddleBytes( i, 1 )
		      if IsNumeric( s ) then
		        n = n + ( s.ToInteger * mult )
		        mult = mult * 10
		      else
		        exit
		      end if
		    next
		    
		    if n > 0 then
		      toArr.Add n
		      n = 0
		    end if
		    
		    for i as integer = startPos + 1 to line.Bytes - 1
		      var s as string = line.MiddleBytes( i, 1 )
		      if IsNumeric( s ) then
		        n = n * 10 + s.ToInteger
		      else
		        exit
		      end if
		    next
		    
		    if n > 0 then
		      toArr.Add n
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HasSymbol(rows() As String, row As Integer, startPos As Integer, endPos As Integer) As Boolean
		  if row < 0 or row > rows.LastIndex then
		    return false
		  end if
		  
		  var line as string = rows( row )
		  
		  if startPos < 0 then
		    startPos = 0
		  end if
		  
		  if endPos >= line.Bytes then
		    endPos = line.Bytes - 1
		  end if
		  
		  var len as integer = endPos - startPos + 1
		  
		  var chunk as string = line.MiddleBytes( startPos, len )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "[^\d.]"
		  
		  return rx.Search( chunk ) isa RegExMatch
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsSymbol(line As String, pos As Integer) As Boolean
		  if pos < 0 then
		    return false
		  end if
		  
		  var char as string = line.MiddleBytes( pos, 1 )
		  if char = "" or ( char >= "0" and char <= "9" ) or char = "." then
		    return false
		  else
		    return true
		  end if
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"467..114..\n...*......\n..35..633.\n......#...\n617*......\n.....+.58.\n..592.....\n......755.\n...$.*....\n.664.598..", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="IsComplete"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadState"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ThreadStates"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Paused"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
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
	#tag EndViewBehavior
End Class
#tag EndClass
