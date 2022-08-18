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
		  return false
		  
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
		  
		  var list as new CircularLinkedList
		  list.Insert items
		  
		  const kMoves as integer = 100
		  MakeMoves list, kMoves, items
		  
		  while list.Current.Value.IntegerValue <> 1
		    list.MoveNext
		  wend
		  
		  list.MoveNext
		  
		  var result as integer
		  do
		    result = result * 10 + list.Current.Value.IntegerValue
		    list.MoveNext
		  loop until list.Current.Value.IntegerValue = 1
		  
		  return result
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  if input = "" then
		    input = kPuzzleInput
		  end if
		  
		  var items() as LinkedListItem = ToItems( input )
		  
		  var values() as integer
		  var maxValue as integer = -1
		  
		  for each item as LinkedListItem in items
		    var thisValue as integer = item.Value.IntegerValue
		    maxValue = max( maxValue, thisValue )
		    values.Add thisValue
		  next
		  
		  items.ResizeTo 999999
		  
		  for val as integer = maxValue to items.LastIndex
		    var item as new LinkedListItem( val + 1 )
		    items( val ) = item
		  next
		  
		  var list as new CircularLinkedList
		  list.Insert items
		  
		  const kMoves as integer = 10000000
		  MakeMoves list, kMoves, items
		  
		  var cup1 as LinkedListItem = items( 0 )
		  list.Current = cup1
		  
		  var result as integer = 1
		  for i as integer = 1 to 2
		    list.MoveNext
		    result = result * list.Current.Value.IntegerValue
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MakeMoves(list As CircularLinkedList, moves As Integer, items() As LinkedListItem)
		  LinkedListItem.Sort items
		  
		  var removed( 2 ) as LinkedListItem
		  
		  for i as integer = 1 to moves
		    'Print i.ToString( "000" ) + ": " + list.ToString
		    
		    var current as LinkedListItem = list.Current
		    list.RemoveNextTo( removed )
		    
		    var removedValues() as integer
		    for each item as LinkedListItem in removed
		      removedValues.Add item.Value.IntegerValue
		    next
		    
		    var dest as integer = current.Value.IntegerValue - 1
		    do
		      if dest < list.MininimumValue then
		        dest = list.MaximumValue
		      end if
		      
		      if removedValues.IndexOf( dest ) <> -1 then
		        dest = dest - 1
		      else
		        exit
		      end if
		    loop
		    
		    list.Current = items( dest - 1 )
		    
		    list.Insert removed
		    list.Current = current
		    
		    list.MoveNext
		  next
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
