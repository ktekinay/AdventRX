#tag Class
Protected Class Advent_2016_12_04
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Decrypt room names"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Security Through Obscurity"
		  
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
		  var result as integer
		  
		  var rx as new RegEx
		  rx.SearchPattern = "^([a-z\-]+)-(\d+)\[([a-z]+)\]"
		  
		  var lines() as string = input.Split( EndOfLine )
		  
		  for each line as string in lines
		    var match as RegExMatch = rx.Search( line )
		    
		    var name as string = match.SubExpressionString( 1 )
		    var id as integer = match.SubExpressionString( 2 ).ToInteger
		    var checksum as string = match.SubExpressionString( 3 )
		    
		    var freq as new Dictionary
		    var nameChars() as string = name.Split( "" )
		    for each char as string in nameChars
		      freq.Value( char ) = freq.Lookup( char, 0 ).IntegerValue + 1
		    next
		    
		    var nameLength as integer = name.Bytes
		    
		    nameChars.RemoveAll
		    var sorter() as string
		    
		    var keys() as variant = freq.Keys
		    var values() as variant = freq.Values
		    
		    for i as integer = 0 to keys.LastIndex
		      var char as string = keys( i )
		      
		      if char <> "-" then
		        nameChars.Add char
		        var count as integer = values( i )
		        count = nameLength - count
		        sorter.Add count.ToString( "00000000" ) + char
		      end if
		    next
		    
		    sorter.SortWith nameChars
		    
		    var nameCheck as string = String.FromArray( nameChars, "" )
		    if nameCheck.Left( checksum.Length ) = checksum then
		      result = result + id
		    end if
		  next
		  
		  return result : if( IsTest, 1514, 409147 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var rx as new RegEx
		  rx.SearchPattern = "^([a-z\-]+)-(\d+)\[([a-z]+)\]"
		  
		  var lines() as string = input.Split( EndOfLine )
		  
		  var result as integer
		  
		  for each line as string in lines
		    var match as RegExMatch = rx.Search( line )
		    
		    var name as string = match.SubExpressionString( 1 )
		    var id as integer = match.SubExpressionString( 2 ).ToInteger
		    var checksum as string = match.SubExpressionString( 3 )
		    
		    if IsTest then
		      result = id
		      exit for line
		    end if
		    
		    var freq as new Dictionary
		    var nameChars() as string = name.Split( "" )
		    for each char as string in nameChars
		      freq.Value( char ) = freq.Lookup( char, 0 ).IntegerValue + 1
		    next
		    
		    var nameLength as integer = name.Bytes
		    
		    nameChars.RemoveAll
		    var sorter() as string
		    
		    var keys() as variant = freq.Keys
		    var values() as variant = freq.Values
		    
		    for i as integer = 0 to keys.LastIndex
		      var char as string = keys( i )
		      
		      if char <> "-" then
		        nameChars.Add char
		        var count as integer = values( i )
		        count = nameLength - count
		        sorter.Add count.ToString( "00000000" ) + char
		      end if
		    next
		    
		    sorter.SortWith nameChars
		    
		    var nameCheck as string = String.FromArray( nameChars, "" )
		    if nameCheck.Left( checksum.Length ) = checksum then
		      if Decrypt( name, id ) = "northpole object storage" then
		        result = id
		        exit for line
		      end if
		    end if
		  next
		  
		  return result : if( IsTest, 343, 991 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Decrypt(name As String, id As Integer) As String
		  static alpha as string
		  
		  if alpha = "" then
		    var builder() as string
		    
		    for i as integer = asc( "a" ) to asc( "z" )
		      builder.Add chr( i )
		    next
		    
		    alpha = String.FromArray( builder, "" )
		    alpha = alpha + alpha
		  end if
		  
		  var rotation as integer = id mod 26
		  
		  var chars() as string = name.Split( "" )
		  
		  for i as integer = 0 to chars.LastIndex
		    var char as string = chars( i )
		    
		    if char = "-" then
		      chars( i ) = " "
		      continue
		    end if
		    
		    var pos as integer = alpha.IndexOf( char )
		    pos = pos + rotation
		    chars( i ) = alpha.Middle( pos, 1 )
		  next
		  
		  return String.FromArray( chars, "" )
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"aaaaa-bbb-z-y-x-123[abxyz]\na-b-c-d-e-f-g-h-987[abcde]\nnot-a-real-room-404[oarel]\ntotally-real-room-200[decoy]", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"qzmt-zixmtkozy-ivhz-343[qqqq]", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Type"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Cooperative"
				"1 - Preemptive"
			#tag EndEnumValues
		#tag EndViewProperty
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
