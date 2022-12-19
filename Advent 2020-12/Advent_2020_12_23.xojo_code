#tag Class
Protected Class Advent_2020_12_23
Inherits AdventBase
	#tag Event
		Function CancelRun(type As Types) As Boolean
		  if type = Types.TestB then
		    return false
		  end if
		  
		  'return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnDescription() As String
		  return "Circular linked list"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Crab Cups"
		  
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
		  if input = "" then
		    input = kPuzzleInput
		  end if
		  
		  var items() as LinkedListItem = ToItems( input )
		  
		  const kMoves as integer = 100
		  MakeMoves kMoves, items
		  
		  var current as LinkedListItem = items( 0 ).NextItem
		  
		  var result as integer
		  do
		    result = result * 10 + current.Value
		    current = current.NextItem
		  loop until current.Value = 1
		  
		  current.NextItem = nil
		  
		  return result
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  StopProfiling
		  
		  if input = "" then
		    input = kPuzzleInput
		  end if
		  
		  var items() as LinkedListItem = ToItems( input )
		  
		  var values() as integer
		  var maxValue as integer = -1
		  
		  for each item as LinkedListItem in items
		    var thisValue as integer = item.Value
		    maxValue = max( maxValue, thisValue )
		    values.Add thisValue
		  next
		  
		  items.ResizeTo 999999
		  
		  for val as integer = maxValue to items.LastIndex
		    var item as new LinkedListItem( val + 1 )
		    items( val ) = item
		  next
		  
		  'Print "Count: " + items.Count.ToString( "#,##0" )
		  'Print "Last Item: " + items( items.LastIndex ).Value.ToString
		  
		  const kMoves as integer = 10000000
		  'const kMoves as integer = 100
		  
		  StartProfiling
		  
		  MakeMoves kMoves, items
		  
		  var cup1 as LinkedListItem = items( 0 ).NextItem
		  var cup2 as LinkedListItem = cup1.NextItem
		  var result as integer = cup1.Value * cup2.Value
		  
		  cup1.NextItem = nil
		  
		  StopProfiling
		  
		  return result
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MakeMoves(moves As Integer, items() As LinkedListItem)
		  StartProfiling
		  
		  var current as LinkedListItem = items( 0 )
		  
		  for i as integer = 1 to items.LastIndex
		    items( i - 1).NextItem = items( i )
		  next
		  
		  items( items.LastIndex ).NextItem = items( 0 )
		  
		  StopProfiling
		  LinkedListItem.Sort items
		  StartProfiling
		  
		  var minValue as integer = items( 0 ).Value
		  var maxValue as integer = items( items.LastIndex ).Value
		  
		  for i as integer = 1 to moves
		    'Print i.ToString( "000" ) + ": " + list.ToString
		    
		    var firstRemoved as linkedListItem = current.NextItem
		    var lastRemoved as LinkedListItem = firstRemoved.NextItem.NextItem
		    
		    current.NextItem = lastRemoved.NextItem
		    
		    var destValue as integer = current.Value - 1
		    do
		      if destValue < minValue then
		        destValue = maxValue
		      end if
		      
		      if _
		        destValue = firstRemoved.Value or _
		        destValue = firstRemoved.NextItem.Value or _
		        destValue = lastRemoved.Value then
		        destValue = destValue - 1
		      else
		        exit
		      end if
		    loop
		    
		    var insertAfter as LinkedListItem = items( destValue - 1 )
		    
		    lastRemoved.NextItem = insertAfter.NextItem
		    insertAfter.NextItem = firstRemoved
		    
		    current = current.NextItem
		  next
		  
		  StopProfiling
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToItems(input As String) As LinkedListItem()
		  var chars() as string = input.Trim.Split( "" )
		  
		  var arr() as LinkedListItem
		  for each char as string in chars
		    arr.Add new LinkedListItem( char )
		  next
		  
		  return arr
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"871369452", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"389125467", Scope = Private
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
