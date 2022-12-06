#tag Class
Protected Class Advent_2015_12_11
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Increment password"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Corporate Policy"
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( Normalize( GetPuzzleInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( Normalize( GetPuzzleInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  return CalculateResultB( Normalize( input ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  if IsTest then
		    return -1
		  end if
		  
		  input = kPuzzleInput
		  
		  var mb as MemoryBlock = input
		  
		  do
		    Increment( mb )
		  loop until IsGood( mb )
		  
		  Part1 = mb.StringValue( 0, mb.Size, Encodings.UTF8 )
		  print Part1
		  
		  return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  if IsTest then
		    return -1
		  end if
		  
		  var mb as MemoryBlock = Part1
		  
		  do
		    Increment( mb )
		  loop until IsGood( mb )
		  
		  print mb.StringValue( 0, mb.Size, Encodings.UTF8 )
		  return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Increment(mb As MemoryBlock)
		  static minChar as integer = asc( "a" )
		  static maxChar as integer = asc( "z" )
		  
		  static verbotin() as integer = array( asc( "i" ), asc( "o" ), asc( "l" ) )
		  
		  var lastByte as integer = mb.Size - 1
		  
		  var p as ptr = mb
		  
		  for byteIndex as integer = lastByte downto 0
		    p.Byte( byteIndex ) = p.Byte( byteIndex ) + 1
		    
		    if p.Byte( byteIndex ) > maxChar then
		      p.Byte( byteIndex ) = minChar
		      continue for byteIndex
		    end if
		    
		    if verbotin.IndexOf( p.Byte( byteIndex ) ) <> -1 then
		      p.Byte( byteIndex ) = p.Byte( byteIndex ) + 1
		      
		      for nextPos as integer = byteIndex + 1 to lastByte
		        p.Byte( nextPos ) = minChar
		      next
		    end if
		    
		    return
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsGood(mb As MemoryBlock) As Boolean
		  var foundSeries as boolean
		  
		  var lastByte as integer = mb.Size - 3
		  var p as ptr = mb
		  
		  for pos as integer = 0 to lastByte
		    if p.Byte( pos ) = ( p.Byte( pos + 1 ) - 1 ) and p.Byte( pos + 1 ) = ( p.Byte( pos + 2 ) - 1 ) then
		      foundSeries = true
		      exit
		    end if
		  next
		  
		  if not foundSeries then
		    return false
		  end if
		  
		  var foundChar as integer
		  lastByte = mb.Size - 2
		  var foundDoubles as boolean
		  
		  for pos as integer = 0 to lastByte
		    if p.Byte( pos ) = p.Byte( pos + 1 ) and p.Byte( pos ) <> foundChar then
		      if foundChar <> 0 then
		        foundDoubles = true
		        exit
		      end if
		      
		      foundChar = p.Byte( pos )
		      pos = pos + 1
		    end if
		  next
		  
		  return foundDoubles
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Part1 As String
	#tag EndProperty


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"cqjxjnds", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"", Scope = Private
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
