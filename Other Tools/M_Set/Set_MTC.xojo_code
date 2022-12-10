#tag Class
Class Set_MTC
Implements Iterable
	#tag Method, Flags = &h0
		Sub Add(item As Variant, ParamArray moreItems() As Variant)
		  Storage.Value( item ) = nil
		  
		  for each additionalItem as variant in moreItems
		    Storage.Value( additionalItem ) = nil
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  Storage.Clear
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Storage = NewStorage
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 437265617465732061207368616C6C6F7720636F70792E
		Sub Constructor(otherSet As Set_MTC)
		  // Make a shallow copy
		  
		  self.Constructor
		  
		  for each key as variant in otherSet.Storage.Keys
		    Add key
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120536574206F66206576657279206974656D2074686174206973206E6F7420696E20626F746820536574732E
		Function Differences(otherSet As Set_MTC) As Set_MTC
		  //
		  // Optimizations
		  //
		  if otherSet is self then
		    return new Set_MTC // Empty
		  end if
		  
		  //
		  // Create the new set
		  //
		  var newSet as new Set_MTC
		  var otherStorage as Dictionary = otherSet.Storage
		  
		  for each key as variant in Storage.Keys
		    if not otherStorage.HasKey( key ) then
		      newSet.Add key
		    end if
		  next
		  
		  for each key as variant in otherStorage.Keys
		    if not Storage.HasKey( key ) then
		      newSet.Add key
		    end if
		  next
		  
		  return newSet
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromArray(doubleArray() As Double) As Set_MTC
		  var s as new Set_MTC
		  
		  for each item as variant in doubleArray
		    s.Storage.Value( item ) = nil
		  next
		  
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromArray(int32Array() As Int32) As Set_MTC
		  var s as new Set_MTC
		  
		  for each item as variant in int32Array
		    s.Storage.Value( item ) = nil
		  next
		  
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromArray(int64Array() As Int64) As Set_MTC
		  var s as new Set_MTC
		  
		  for each item as variant in int64Array
		    s.Storage.Value( item ) = nil
		  next
		  
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromArray(objectArray() As Object) As Set_MTC
		  var s as new Set_MTC
		  
		  for each item as variant in objectArray
		    s.Storage.Value( item ) = nil
		  next
		  
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromArray(singleArray() As Single) As Set_MTC
		  var s as new Set_MTC
		  
		  for each item as variant in singleArray
		    s.Storage.Value( item ) = nil
		  next
		  
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromArray(stringArray() As String) As Set_MTC
		  var s as new Set_MTC
		  
		  for each item as variant in stringArray
		    s.Storage.Value( item ) = nil
		  next
		  
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromArray(variantArray() As Variant) As Set_MTC
		  var s as new Set_MTC
		  
		  for each item as variant in variantArray
		    s.Storage.Value( item ) = nil
		  next
		  
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(dict As Dictionary) As Set_MTC
		  var s as new Set_MTC
		  
		  for each key as variant in dict.Keys
		    s.Storage.Value( key ) = nil
		  next
		  
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasMember(item As Variant) As Boolean
		  return Storage.HasKey( item )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Intersection(otherSet As Set_MTC) As Set_MTC
		  //
		  // Optimizations
		  //
		  if otherSet is self then
		    return new Set_MTC( self )
		  end if
		  
		  var loopStorage as Dictionary
		  var compareStorage as Dictionary
		  
		  if otherSet.Count < Count then
		    loopStorage = otherSet.Storage
		    compareStorage = Storage
		  else
		    loopStorage = Storage
		    compareStorage = otherSet.Storage
		  end if
		  
		  //
		  // Create the new set
		  //
		  var newSet as new Set_MTC
		  
		  for each key as variant in loopStorage.Keys
		    if compareStorage.HasKey( key ) then
		      newSet.Add key
		    end if
		  next
		  
		  return newSet
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73205472756520696620616E79206D656D626572206F6620746865206F746865722053657420696E20696E2074686973205365742E
		Function Intersects(otherSet As Set_MTC) As Boolean
		  for each key as variant in otherSet.Storage.Keys
		    if Storage.HasKey( key ) then
		      return true
		    end if
		  next
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsSubsetOf(otherSet As Set_MTC) As Boolean
		  if otherSet.Count < Count then
		    return false // Can't be a subset if there are more items in the other
		  end if
		  
		  var otherStorage as Dictionary = otherSet.Storage
		  
		  for each key as variant in Storage.Keys
		    if not otherStorage.HasKey( key ) then
		      return false
		    end if
		  next
		  
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  var i as new M_Set.SetIterator( ToArray )
		  return i
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NewStorage() As Dictionary
		  return ParseJSON( "{}" ) // Case-sensitive
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Add(otherSet As Set_MTC) As Set_MTC
		  return Union( otherSet )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(otherSet As Set_MTC) As Integer
		  if otherSet is nil then
		    return -1
		  end if
		  
		  if otherSet is self then
		    return 0
		  end if
		  
		  if otherSet.Count <> Count then
		    return Count - otherSet.Count
		  end if
		  
		  for each key as variant in otherSet.Storage.Keys
		    if not Storage.HasKey( key ) then
		      return 1 // Arbitrary
		    end if
		  next
		  
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_RightCompare(otherSet As Set_MTC) As Integer
		  return -Operator_Compare( otherSet )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subtract(otherSet As Set_MTC) As Set_MTC
		  //
		  // Optimizations
		  //
		  if otherSet is self or Count = 0 then
		    return new Set_MTC // Empty
		  end if
		  
		  if otherSet.Count = 0 then
		    return new Set_MTC( self ) // Copy
		  end if
		  
		  var newSet as new Set_MTC( self )
		  
		  for each key as variant in otherSet.Storage.Keys
		    if Storage.HasKey( key ) then
		      newSet.Remove key
		    end if
		  next
		  
		  return newSet
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616E20617262697472617279206D656D62657220616E642064656C657465732069742066726F6D20746865205365742E
		Function Pop() As Variant
		  if Count = 0 then
		    raise new InvalidArgumentException
		  end if
		  
		  var keys() as variant = Storage.Keys
		  if Count = 1 then
		    Clear
		    return keys( 0 )
		  end if
		  
		  static r as new Random
		  var i as integer = r.InRange( 0, keys.LastIndex )
		  var item as variant = keys( i )
		  Storage.Remove item
		  
		  return item
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(item As Variant)
		  Storage.Remove item
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToArray() As Variant()
		  return Storage.Keys
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  var dict as Dictionary = NewStorage
		  
		  for each key as variant in Storage.Keys
		    dict.Value( key ) = nil
		  next
		  
		  return dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Union(otherSet As Set_MTC) As Set_MTC
		  var newSet as new Set_MTC( self )
		  
		  for each key as variant in otherSet.Storage.Keys
		    newSet.Add key
		  next
		  
		  return newSet
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Storage.Count
			  
			End Get
		#tag EndGetter
		Count As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Storage As Dictionary
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
