#tag Class
Class SpacialGrid
	#tag Method, Flags = &h0
		Sub Constructor()
		  Grid = new Dictionary
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectAt(x As Integer, y As Integer, z As Integer) As Advent3DObject
		  var hash as integer = Advent3DObject.HashOf( x, y, z )
		  
		  return Grid.Lookup( hash, nil )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectAt(x As Integer, y As Integer, z As Integer, w As Integer) As Advent3DObject
		  var hash as integer = Advent3DObject.HashOf( x, y, z, w )
		  
		  return Grid.Lookup( hash, nil )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectsAround(x As Integer, y As Integer, z As Integer) As Advent3DObject()
		  var result() as Advent3DObject
		  
		  var lowx as integer = x - 1
		  var highx as integer = x + 1
		  if highx < MinX or lowx > MaxX then
		    return result
		  end if
		  
		  var lowy as integer = y - 1
		  var highy as integer = y + 1
		  if highy < MinY or lowy > MaxY then
		    return result
		  end if
		  
		  var lowz as integer = z - 1
		  var highz as integer = z + 1
		  if highz < MinZ or lowz > MaxZ then
		    return result
		  end if
		  
		  for xIndex as integer = lowx to highx
		    for yIndex as integer = lowy to highy
		      for zIndex as integer = lowz to highz
		        var o as Advent3DObject = ObjectAt( xIndex, yIndex, zIndex )
		        if o isa object then
		          result.Add o
		        end if
		      next zIndex
		    next yIndex
		  next xIndex
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectsAround(x As Integer, y As Integer, z As Integer, w As Integer) As Advent3DObject()
		  var result() as Advent3DObject
		  
		  var lowx as integer = x - 1
		  var highx as integer = x + 1
		  if highx < MinX or lowx > MaxX then
		    return result
		  end if
		  
		  var lowy as integer = y - 1
		  var highy as integer = y + 1
		  if highy < MinY or lowy > MaxY then
		    return result
		  end if
		  
		  var lowz as integer = z - 1
		  var highz as integer = z + 1
		  if highz < MinZ or lowz > MaxZ then
		    return result
		  end if
		  
		  var loww as integer = w - 1
		  var highw as integer = w + 1
		  if highw < MinW or loww > MaxW then
		    return result
		  end if
		  
		  for xIndex as integer = lowx to highx
		    for yIndex as integer = lowy to highy
		      for zIndex as integer = lowz to highz
		        for wIndex as integer = loww to highw
		          var o as Advent3DObject = ObjectAt( xIndex, yIndex, zIndex, wIndex )
		          if o isa object then
		            result.Add o
		          end if
		        next wIndex
		      next zIndex
		    next yIndex
		  next xIndex
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(x As Integer, y As Integer, z As Integer) As Advent3DObject
		  return ObjectAt( x, y, z )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(x As Integer, y As Integer, z As Integer, Assigns o As Advent3DObject)
		  o.SetCoordinates x, y, z
		  
		  Grid.Value( o.Hash ) = o
		  
		  mMaxX = max( mMaxX, x )
		  mMaxY = max( mMaxY, y )
		  mMaxZ = max( mMaxZ, z )
		  
		  mMinX = min( mMinX, x )
		  mMinY = min( mMinY, y )
		  mMinZ = min( mMinZ, z )
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(x As Integer, y As Integer, z As Integer, w As Integer) As Advent3DObject
		  return ObjectAt( x, y, z, w )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(x As Integer, y As Integer, z As Integer, w As Integer, Assigns o As Advent3DObject)
		  o.SetCoordinates x, y, z, w
		  
		  Grid.Value( o.Hash ) = o
		  
		  mMaxX = max( mMaxX, x )
		  mMaxY = max( mMaxY, y )
		  mMaxZ = max( mMaxZ, z )
		  mMaxW = max( mMaxW, w )
		  
		  mMinX = min( mMinX, x )
		  mMinY = min( mMinY, y )
		  mMinZ = min( mMinZ, z )
		  mMinW = min( mMinW, w )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToArray() As Advent3DObject()
		  var result() as Advent3DObject
		  var values() as variant = Grid.Values
		  result.ResizeTo values.LastIndex
		  
		  for i as integer = 0 to values.LastIndex
		    result( i ) = values( i )
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if Grid isa object then
			    return Grid.KeyCount
			  else
			    return 0
			  end if
			  
			End Get
		#tag EndGetter
		Count As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Grid As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mMaxW
			End Get
		#tag EndGetter
		MaxW As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mMaxX
			End Get
		#tag EndGetter
		MaxX As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mMaxY
			End Get
		#tag EndGetter
		MaxY As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mMaxZ
			End Get
		#tag EndGetter
		MaxZ As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mMinW
			  
			End Get
		#tag EndGetter
		MinW As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mMinX
			End Get
		#tag EndGetter
		MinX As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mMinY
			End Get
		#tag EndGetter
		MinY As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mMinZ
			  
			End Get
		#tag EndGetter
		MinZ As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mMaxW As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mMaxX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mMaxY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mMaxZ As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mMinW As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mMinX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mMinY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mMinZ As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mWeakRef As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mWeakRef is nil then
			    mWeakRef = new WeakRef( self )
			  end if
			  
			  return mWeakRef
			  
			End Get
		#tag EndGetter
		WeakRef As WeakRef
	#tag EndComputedProperty


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
			Name="MaxX"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxZ"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
		#tag ViewProperty
			Name="MinX"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinZ"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
