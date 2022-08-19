#tag Class
Protected Class CircularLinkedList
	#tag Method, Flags = &h0
		Sub Clear()
		  Current.NextItem = nil
		  Current = nil
		  InitialFirstItem = nil
		  mCount = 0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Clear
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FetchNext(count As Integer) As LinkedListItem()
		  var list() as LinkedListItem
		  
		  var this as LinkedListItem = Current
		  
		  while count > 0
		    if list.IndexOf( this.NextItem ) <> -1 then
		      raise new OutOfBoundsException
		    end if
		    
		    list.Add this.NextItem
		    this = this.NextItem
		    
		    count = count - 1
		  wend
		  
		  return list
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FetchNextTo(arr() As LinkedListItem)
		  if arr.Count > mCount then
		    raise new OutOfBoundsException
		  end if
		  
		  var this as LinkedListItem = Current
		  
		  for i as integer = 0 to arr.LastIndex
		    arr( i ) = this.NextItem
		    this = this.NextItem
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(items() As LinkedListItem)
		  if items.Count = 0 then
		    return
		  end if
		  
		  for i as integer = 0 to items.LastIndex - 1
		    items( i ).NextItem = items( i + 1 )
		  next
		  
		  var first as LinkedListItem = items( 0 )
		  var last as LinkedListItem = items( items.LastIndex )
		  
		  if Current is nil then
		    Current = first
		    last.NextItem = Current
		    
		    InitialFirstItem = first
		    
		  else
		    var insertBefore as LinkedListItem = Current.NextItem
		    Current.NextItem = first
		    last.NextItem = insertBefore
		    
		  end if
		  
		  //
		  // Update the min/max
		  //
		  for each item as LinkedListItem in items
		    if MininimumValue is nil or MininimumValue > item.Value then
		      MininimumValue = item.Value
		    end if
		    
		    if MaximumValue is nil or MaximumValue < item.Value then
		      MaximumValue = item.Value
		    end if
		  next
		  
		  mCount = mCount + items.Count
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MoveNext(count As Integer = 1)
		  while Current isa object and count > 0
		    Current = Current.NextItem
		    count = count - 1
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  return ToString
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RemoveNext(count As Integer) As LinkedListItem()
		  var list() as LinkedListItem
		  list.ResizeTo count - 1
		  RemoveNextTo list
		  return list
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveNextTo(arr() As LinkedListItem)
		  var original as LinkedListItem = Current
		  
		  FetchNextTo( arr )
		  Current = arr( arr.LastIndex ).NextItem
		  
		  original.NextItem = Current
		  
		  Current = original
		  mCount = mCount - arr.Count
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  if Current is nil then
		    return ""
		  end if
		  
		  var original as LinkedListItem = Current
		  
		  Current = InitialFirstItem
		  
		  var builder() as string
		  
		  do
		    if Current is original then
		      builder.Add "(" + Current.Value.ToString + ")"
		    else
		      builder.Add Current.Value.ToString
		    end if
		    MoveNext
		  loop until Current = InitialFirstItem
		  
		  Current = original
		  
		  return String.FromArray( builder, " " )
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCount
			End Get
		#tag EndGetter
		Count As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Current As LinkedListItem
	#tag EndProperty

	#tag Property, Flags = &h0
		InitialFirstItem As LinkedListItem
	#tag EndProperty

	#tag Property, Flags = &h0
		MaximumValue As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		MininimumValue As Variant
	#tag EndProperty


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
		#tag ViewProperty
			Name="Count"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
