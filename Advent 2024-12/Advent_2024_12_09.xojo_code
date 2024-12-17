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
		  
		  var lastIndex as integer = layout.LastIndex
		  var freeIndex as integer = 0
		  
		  do
		    while freeIndex < lastIndex and layout( freeIndex ) <> -1
		      freeIndex = freeIndex + 1
		    wend
		    
		    while lastIndex > freeIndex and layout( lastIndex ) = -1
		      lastIndex = lastIndex - 1
		    wend
		    
		    if freeIndex >= lastIndex then
		      exit
		    end if
		    
		    var move as integer = layout( lastIndex )
		    layout( freeIndex ) = move
		    layout( lastIndex ) = -1
		    
		    lastIndex = lastIndex - 1
		    freeIndex = freeIndex + 1
		  loop
		  
		  var result as integer
		  for i as integer = 0 to lastIndex
		    var value as integer = layout( i )
		    if value <> -1 then
		      result = result + ( i * value )
		    end if
		  next
		  
		  return result : if( IsTest, 1928, 6353658451014 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var free() as DiskFile
		  var layout() as DiskFile
		  
		  var id as integer
		  var isFree as boolean
		  var position as integer
		  
		  for each countString as string in Normalize( input ).Split( "" )
		    var df as new DiskFile
		    
		    df.ID = id
		    df.IsFree = isFree
		    df.Count = countString.ToInteger
		    df.Position = position
		    
		    layout.Add df
		    
		    if isFree then
		      free.Add df
		    else
		      id = id + 1
		    end if
		    
		    isFree = not isFree
		    position = position + 1000
		  next
		  
		  for layoutIndex as integer = layout.LastIndex downto 0
		    var movedDF as DiskFile = layout( layoutIndex )
		    
		    if movedDF.IsFree then
		      continue
		    end if
		    
		    for freeIndex as integer = 0 to free.LastIndex
		      var freeDF as DiskFile = free( freeIndex )
		      
		      if freeDF.Position > movedDF.Position then
		        exit
		      end if
		      
		      if freeDF.Count < movedDF.Count then
		        continue
		      end if
		      
		      if freeDF.Count = movedDF.Count then
		        freeDF.ID = movedDF.ID
		        freeDF.IsFree = false
		        free.RemoveAt freeIndex
		        
		        movedDF.IsFree = true
		        
		        exit
		      end if
		      
		      var originalFreeCount as integer = freeDF.Count
		      var diff as integer = originalFreeCount - movedDF.Count
		      
		      var newFree as new DiskFile
		      newFree.Position = freeDF.Position + 1
		      newFree.Count = diff
		      newFree.IsFree = true
		      
		      freeDF.ID = movedDF.ID
		      freeDF.Count = movedDF.Count
		      freeDF.IsFree = false
		      
		      free.RemoveAt freeIndex
		      free.AddAt freeIndex, newFree
		      
		      movedDF.IsFree = true
		      layout.Add newFree
		      
		      exit
		    next
		  next
		  
		  layout.Sort AddressOf DiskFileSorter
		  
		  var result as integer
		  
		  position = 0
		  
		  for layoutIndex as integer = 0 to layout.LastIndex
		    var df as DiskFile = layout( layoutIndex )
		    
		    if df.IsFree then
		      position = position + df.Count
		      continue
		    end if
		    
		    for i as integer = 1 to df.Count
		      result = result + ( df.ID * position )
		      position = position + 1
		    next
		  next
		  
		  if printer.Count <> 0 then
		    Print String.FromArray( printer, ", " )
		  end if
		  
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

	#tag Method, Flags = &h0
		Shared Function DiskFileSorter(df1 As DiskFile, df2 As DiskFile) As Integer
		  return df1.Position - df2.Position
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
