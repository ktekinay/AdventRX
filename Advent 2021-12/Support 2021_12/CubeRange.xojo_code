#tag Class
Protected Class CubeRange
	#tag Method, Flags = &h0
		Function Apply(ByRef instruction As CubeRange) As CubeRange()
		  var result() as CubeRange
		  
		  if State = States.Off or instruction is self then
		    // Do nothing
		    
		  elseif instruction is nil or not IsOverlapping( instruction ) then
		    result.Add self
		    
		  else // instruction.State = Off
		    //
		    // Reduce or split this range
		    //
		    
		    //
		    // See if the instruction entirely encompasses me
		    //
		    if instruction.X0 <= X0 and instruction.X1 >= X1 and _
		      instruction.Y0 <= Y0 and instruction.Y1 >= Y1 and _
		      instruction.Z0 <= Z0 and instruction.Z1 >= Z1 then
		      //
		      // The instruction entirely encompasses me
		      // so return nothing
		      //
		      instruction = instruction
		      
		    else
		      //
		      // The instruction partially overlaps me
		      //
		      SplitAround instruction, result
		      
		    end if
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fromOther As CubeRange = Nil)
		  if fromOther isa object then
		    X0 = fromOther.X0
		    X1 = fromOther.X1
		    
		    Y0 = fromOther.Y0
		    Y1 = fromOther.Y1
		    
		    Z0 = fromOther.Z0
		    Z1 = fromOther.Z1
		    
		    State = fromOther.State
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountInRange(target As CubeRange) As Integer
		  if not IsOverlapping( target ) then
		    return 0
		  end if
		  
		  var clone as new CubeRange( self )
		  
		  clone.X0 = max( target.X0, clone.X0 )
		  clone.X1 = min( target.X1, clone.X1 )
		  
		  clone.Y0 = max( target.Y0, clone.Y0 )
		  clone.Y1 = min( target.Y1, clone.Y1 )
		  
		  clone.Z0 = max( target.Z0, clone.Z0 )
		  clone.Z1 = min( target.Z1, clone.Z1 )
		  
		  return clone.Count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DoCoordinatesOverlap(start0 As Integer, end0 As Integer, start1 As Integer, end1 As Integer) As Boolean
		  return start0.IsBetween( start1, end1 ) or start1.IsBetween( start0, end0 ) or _
		  end0.IsBetween( start1, end1 ) or end1.IsBetween( start0, end0 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsOverlapping(other As CubeRange) As Boolean
		  return DoCoordinatesOverlap( X0, X1, other.X0, other.X1 ) and _
		  DoCoordinatesOverlap( Y0, Y1, other.Y0, other.Y1 ) and _
		  DoCoordinatesOverlap( Z0, Z1, other.Z0, other.Z1 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SplitAround(other As CubeRange, intoArray() As CubeRange)
		  if not IsOverlapping( other ) then
		    if intoArray.IndexOf( self ) = -1 then
		      intoArray.Add self
		    end if
		    
		    return
		  end if
		  
		  var clone as new CubeRange( self )
		  
		  if clone.X0 < other.X0 and clone.X1 >= other.X0 then
		    var c1 as new CubeRange( clone )
		    
		    c1.X1 = other.X0 - 1
		    if c1.X0 <= c1.X1 then
		      intoArray.Add c1
		    end if
		    
		    clone.X0 = other.X0
		  end if
		  
		  if clone.X1 > other.X1 then
		    var c1 as new CubeRange( clone )
		    
		    c1.X0 = other.X1 + 1
		    if c1.X0 <= c1.X1 then
		      intoArray.Add c1
		    end if
		    
		    clone.X1 = other.X1
		  end if
		  
		  if clone.Y0 < other.Y0 and clone.Y1 >= other.Y0 then
		    var c1 as new CubeRange( clone )
		    
		    c1.Y1 = other.Y0 - 1
		    if c1.Y0 <= c1.Y1 then
		      intoArray.Add c1
		    end if
		    
		    clone.Y0 = other.Y0
		  end if
		  
		  if clone.Y1 > other.Y1 then
		    var c1 as new CubeRange( clone )
		    
		    c1.Y0 = other.Y1 + 1
		    if c1.Y0 <= c1.Y1 then
		      intoArray.Add c1
		    end if
		    
		    clone.Y1 = other.Y1
		  end if
		  
		  if clone.Z0 < other.Z0 and clone.Z1 >= other.Z0 then
		    var c1 as new CubeRange( clone )
		    
		    c1.Z1 = other.Z0 - 1
		    if c1.Z0 <= c1.Z1 then
		      intoArray.Add c1
		    end if
		    
		    clone.Z0 = other.Z0
		  end if
		  
		  if clone.Z1 > other.Z1 then
		    var c1 as new CubeRange( clone )
		    
		    c1.Z0 = other.Z1 + 1
		    if c1.Z0 <= c1.Z1 then
		      intoArray.Add c1
		    end if
		    
		    clone.Z1 = other.Z1
		  end if
		  
		  if not clone.IsOverlapping( other ) then
		    intoArray.Add clone
		  end if
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  var xCount as integer = max( X1 - X0 + 1, 0 )
			  var yCount as integer = max( Y1 - Y0 + 1, 0 )
			  var zCount as integer = max( Z1 - Z0 + 1, 0 )
			  
			  var count as integer = xCount * yCount * zCount
			  return count
			  
			End Get
		#tag EndGetter
		Count As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		State As States
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  var builder() as string 
			  
			  builder.Add if( State = States.On, "on ",  "off " )
			  
			  builder.Add "x="
			  builder.Add X0.ToString
			  builder.Add ".."
			  builder.Add X1.ToString
			  builder.Add ","
			  
			  builder.Add "y="
			  builder.Add Y0.ToString
			  builder.Add ".."
			  builder.Add Y1.ToString
			  builder.Add ","
			  
			  builder.Add "z="
			  builder.Add Z0.ToString
			  builder.Add ".."
			  builder.Add Z1.ToString
			  
			  return String.FromArray( builder, "" )
			  
			  
			End Get
		#tag EndGetter
		ToString As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		X0 As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		X1 As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Y0 As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Y1 As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Z0 As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Z1 As Integer
	#tag EndProperty


	#tag Enum, Name = States, Type = Integer, Flags = &h0
		Off = -1
		On = 1
	#tag EndEnum


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
			Name="X0"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="X1"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Y0"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Y1"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Z0"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Z1"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="State"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="States"
			EditorType="Enum"
			#tag EnumValues
				"-1 - Off"
				"1 - On"
			#tag EndEnumValues
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
			Name="ToString"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
