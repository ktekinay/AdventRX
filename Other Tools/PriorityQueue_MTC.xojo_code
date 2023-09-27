#tag Class
Protected Class PriorityQueue_MTC
	#tag Method, Flags = &h0, Description = 41646420612076616C756520746F2074686520517565756520776974682074686520676976656E207072696F726974792E
		Sub Add(priority As Double, value As Variant)
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  LastIndex = LastIndex + 1
		  if LastIndex = Priorities.Count then
		    //
		    // Expand arrays
		    //
		    var expandTo as integer = min( Priorities.Count * 2, Priorities.Count + 2048 )
		    ResizeTo expandTo - 1
		  end if
		  
		  Priorities( LastIndex ) = priority
		  Values( LastIndex ) = value
		  
		  //
		  // Reposition as needed
		  //
		  var currentIndex as integer = LastIndex
		  
		  while currentIndex <> 0
		    var parentIndex as integer = ( currentIndex - 1 ) \ 2
		    var parentPriority as double = Priorities( parentIndex )
		    
		    if ( IsMinToMax and parentPriority <= priority ) or ( IsMaxToMin and parentPriority >= priority ) then
		      //
		      // We're done
		      //
		      exit
		    end if
		    
		    //
		    // Swap
		    //
		    var parentValue as variant = Values( parentIndex )
		    
		    Priorities( currentIndex ) = parentPriority
		    Values( currentIndex ) = parentValue
		    
		    Priorities( parentIndex ) = priority
		    Values( parentIndex ) = value
		    
		    currentIndex = parentIndex
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526573657473207468652051756575652E
		Sub Clear()
		  Values.RemoveAll
		  ResizeTo kInitialLastIndex
		  
		  LastIndex = -1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5768656E206D696E546F4D61782020697320547275652C20612076616C756520776974682061207072696F72697479206F6620312E302077696C6C2062652072657475726E6564206265666F7265206F6E6520776974682061207072696F72697479206F662031302E302E205768656E2046616C73652C207072696F726974792031302E302077696C6C2062652072657475726E6564206265666F7265207072696F7269747920312E302E
		Sub Constructor(minToMax As Boolean = True)
		  IsMinToMax = minToMax
		  IsMaxToMin = not minToMax
		  
		  Clear
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F766520616E642072657475726E207468652076616C75652061742074686520746F70206F66207468652051756575652E
		Function Pop() As Variant
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  var returnValue as variant = Values( 0 )
		  
		  if LastIndex = 0 then
		    Values( 0 ) = nil
		    LastIndex = -1
		    
		    //
		    // Save some memory
		    //
		    if Priorities.LastIndex > kInitialLastIndex then
		      ResizeTo kInitialLastIndex
		    end if
		    
		    return returnValue
		  end if
		  
		  //
		  // Shuffle the tree
		  //
		  var priority as double = Priorities( LastIndex ) // If the queue was empty, this will raise an OutOfBoundsException
		  var value as variant = Values( LastIndex )
		  Values( LastIndex ) = nil // Remove any references
		  LastIndex = LastIndex - 1
		  
		  var index as integer = 0
		  Priorities( index ) = priority
		  Values( index ) = value
		  
		  do
		    var leftChildIndex as integer = index * 2 + 1
		    if leftChildIndex > LastIndex then
		      //
		      // We're done
		      //
		      exit
		    end if
		    
		    var rightChildIndex as integer = leftChildIndex + 1
		    
		    var leftPriority as double = Priorities( leftChildIndex )
		    var rightPriority as double = if( rightChildIndex <= LastIndex, Priorities( rightChildIndex ), priority )
		    
		    if ( IsMinToMax and priority <= leftPriority and priority <= rightPriority ) or _
		      ( IsMaxToMin and priority >= leftPriority and priority >= rightPriority ) then
		      //
		      // We're done
		      //
		      exit
		    end if
		    
		    
		    var swapIndex as integer = _
		    if( ( IsMinToMax and rightPriority < leftPriority ) or ( IsMaxToMin and rightPriority > leftPriority ), _
		    rightChildIndex, _
		    leftChildIndex )
		    
		    Priorities( index ) = Priorities( swapIndex )
		    Values( index ) = Values( swapIndex )
		    
		    Priorities( swapIndex ) = priority
		    Values( swapIndex ) = value
		    
		    index = swapIndex
		  loop
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ResizeTo(index As Integer)
		  Priorities.ResizeTo index
		  Values.ResizeTo index
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Validate() As String
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  if Priorities.Count = 0 then
		    return "Priorities array is not dimensioned"
		  end if
		  
		  if Values.Count <> Priorities.Count then
		    return "Values array is mis-dimensioned"
		  end if
		  
		  if LastIndex < -1 then
		    return "LastIndex < -1"
		  end if
		  
		  if LastIndex > Priorities.LastIndex then
		    return "LastIndex > Priorities.LastIndex"
		  end if
		  
		  for i as integer = 1 to LastIndex
		    var parentIndex as integer = ( i - 1 ) \ 2
		    var thisPriority as double = Priorities( i )
		    var parentPriority as double = Priorities( parentIndex )
		    
		    if ( IsMinToMax and thisPriority < parentPriority ) or ( IsMaxToMin and thisPriority > parentPriority ) then
		      return "Improper entry at index " + i.ToString + ": " + _
		      "Priority is " + thisPriority.ToString + " but parent priority is " + parentPriority.ToString
		    end if
		  next
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F66206974656D7320696E207468652051756575652E
		#tag Getter
			Get
			  return LastIndex + 1
			  
			End Get
		#tag EndGetter
		Count As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private IsMaxToMin As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private IsMinToMax As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LastIndex As Integer = -1
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865205072696F72697479206F662076616C75652061742074686520746F70206F66207468652051756575652C206F72204E614E2069662074686520517565756520697320656D7074792E
		#tag Getter
			Get
			  if LastIndex = -1 then
			    static nan as double = val( "NaN" )
			    return nan
			  end if
			  
			  var priority as double = Priorities( 0 )
			  
			  return priority
			  
			End Get
		#tag EndGetter
		PeekPriority As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652076616C75652061742074686520746F70206F66207468652051756575652C206F72204E696C2069662074686520517565756520697320656D7074792E
		#tag Getter
			Get
			  return if( LastIndex = -1, nil, Values( 0 ) )
			  
			End Get
		#tag EndGetter
		PeekValue As Variant
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Priorities() As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Values() As Variant
	#tag EndProperty


	#tag Constant, Name = kInitialLastIndex, Type = Double, Dynamic = False, Default = \"127", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kVersion, Type = String, Dynamic = False, Default = \"1.0", Scope = Public
	#tag EndConstant


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
		#tag ViewProperty
			Name="PeekPriority"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
