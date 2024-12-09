#tag Class
Protected Class Advent_2024_12_09
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Unknown"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Disk Fragmenter"
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
		  var layout() as integer = ToValues( input )
		  
		  do
		    var lastValue as integer = layout.Pop
		    while lastValue = -1
		      lastValue = layout.Pop
		    wend
		    
		    var nextIndex as integer = layout.IndexOf( -1 )
		    if nextIndex = -1 then
		      layout.Add lastValue
		      exit
		    end if
		    layout( nextIndex ) = lastValue
		  loop
		  
		  var result as integer
		  for i as integer = 0 to layout.LastIndex
		    result = result + ( i * layout( i ) )
		  next
		  
		  return result : if( IsTest, 1928, 6353658451014 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var layout() as integer = ToValues( input )
		  
		  var currentId as integer
		  
		  for i as integer = layout.LastIndex downto 0
		    currentId = layout( i )
		    if currentId <> -1 then
		      exit
		    end if
		  next
		  
		  var searchPos as integer = layout.LastIndex
		  var freeSpaceSearchPos as integer = Locate( layout, 0, -1 )
		  
		  outer :
		  do
		    'while layout( layout.LastIndex ) = -1
		    'call layout.Pop
		    'wend
		    
		    if searchPos > layout.LastIndex then
		      searchPos = layout.LastIndex
		    end if
		    
		    for searchIndex as integer = searchPos downto 0
		      if layout( searchIndex ) = currentId then
		        searchPos = searchIndex
		        exit
		      end if
		    next
		    
		    var blockCount as integer = 1
		    
		    for searchIndex as integer = searchPos - 1 downto 0
		      if layout( searchIndex ) <> currentId then
		        searchPos = searchIndex + 1
		        exit
		      else
		        blockCount = blockCount + 1
		      end if
		    next
		    
		    //
		    // Look for a block of free space that can accommodate
		    //
		    var freeSpacePos as integer = freeSpaceSearchPos
		    do
		      if freeSpacePos > searchPos then
		        exit
		      end if
		      
		      var freeSpaceCount as integer = CountValue( layout, freeSpacePos, -1 )
		      
		      if freeSpaceCount >= blockCount then
		        for inner as integer = freeSpacePos to freeSpacePos + blockCount - 1
		          layout( inner ) = currentId
		        next
		        
		        for inner as integer = searchPos to searchPos + blockCount - 1
		          layout( inner ) = -1
		        next
		        
		        if freeSpaceSearchPos = freeSpacePos then
		          freeSpaceSearchPos = Locate( layout, freeSpacePos + 1, -1 )
		          if freeSpaceSearchPos = -1 then
		            currentId = -1 
		          end if
		        end if
		        
		        exit
		      end if
		      
		      freeSpacePos = Locate( layout, freeSpacePos + freeSpaceCount, -1 )
		      if freeSpacePos = -1 then
		        exit
		      end if
		    loop
		    
		    currentId = currentId - 1
		  loop until currentId < 0
		  
		  var result as integer
		  for i as integer = 0 to layout.LastIndex
		    if layout( i ) <> -1 then
		      result = result + ( i * layout( i ) )
		    end if
		  next
		  
		  return result : if( IsTest, 2858, 6382582136592 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CountValue(layout() As Integer, startingIndex As Integer, target As Integer) As Integer
		  var count as integer = 1
		  for i as integer = startingIndex + 1 to layout.LastIndex
		    if layout( i ) = target then
		      count = count + 1
		    else
		      exit
		    end if
		  next
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Locate(arr() As Integer, startingIndex As Integer, target As Integer) As Integer
		  for i as integer = startingIndex to arr.LastIndex
		    if arr( i ) = target then
		      return i
		    end if
		  next
		  
		  return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToValues(input As String) As Integer()
		  var values() as integer = ToIntegerArray( Normalize( input ).Split( "" ) )
		  
		  var layout() as integer
		  var id as integer
		  var isFile as boolean = true
		  
		  for i as integer = 0 to values.LastIndex
		    var value as integer = values( i )
		    
		    var addThis as integer
		    if isFile then
		      addThis = id
		      id = id + 1
		    else
		      addThis = -1
		    end if
		    
		    for inner as integer = 1 to value
		      layout.Add addThis
		    next
		    
		    isFile = not isFile
		  next
		  
		  return layout
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"2333133121414131402", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2024
	#tag EndUsing


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
