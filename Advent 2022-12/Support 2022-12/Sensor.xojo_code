#tag Class
Protected Class Sensor
Inherits Xojo.Point
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Function MaxXForRow(row As Integer) As Integer
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  if row > MaxY or row < MinY then
		    return X
		  end if
		  
		  var rowDistance as integer = abs( row - Y ) // 1
		  
		  return MaxX - rowDistance
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinXForRow(row As Integer) As Integer
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  if row > MaxY or row < MinY then
		    return X
		  end if
		  
		  var rowDistance as integer = abs( row - Y ) // 1
		  
		  return MinX + rowDistance
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextXForRow(row As Integer, currentX As Integer) As Integer
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  if row > MaxY or row < MinY then
		    return currentX
		  end if
		  
		  var rowDistance as integer = abs( row - Y ) // 1
		  
		  var result as integer = MaxX - rowDistance
		  
		  if result < currentX then
		    return currentX
		  else
		    return result + 1
		  end if
		  
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #pragma StackOverflowChecking false
			  
			  return mBeacon
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #if not DebugBuild
			    #pragma BackgroundTasks false
			    #pragma BoundsChecking false
			    #pragma NilObjectChecking false
			    #pragma StackOverflowChecking false
			  #endif
			  
			  mBeacon = value
			  DeltaX = abs( mBeacon.X - self.X )
			  DeltaY = abs( mBeacon.Y - self.Y )
			  MinX = X - ( DeltaX + DeltaY )
			  MaxX = X + DeltaX + DeltaY
			  MinY = Y - ( Deltax + DeltaY )
			  MaxY = Y + DeltaX + DeltaY
			  
			End Set
		#tag EndSetter
		Beacon As Xojo.Point
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		DeltaX As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		DeltaY As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Index As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		MaxX As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		MaxY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBeacon As Xojo.Point
	#tag EndProperty

	#tag Property, Flags = &h0
		MinX As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		MinY As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="X"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Y"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DeltaX"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DeltaY"
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
			Name="MinY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
