#tag Class
Protected Class KeyLock
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(data As String)
		  var grid( -1, -1 ) as string = AdventBase.ToStringGrid( data )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  Height = lastRowIndex - 1
		  PinCount = lastColIndex
		  
		  IsLock = true
		  
		  for col as integer = 0 to lastColIndex
		    if grid( 0, col ) <> "#" then
		      IsKey = true
		      exit
		    end if
		  next
		  
		  var startRow as integer
		  var endRow as integer
		  var rowStepper as integer
		  
		  if IsKey then
		    startRow = lastRowIndex - 1
		    endRow = 0
		    rowStepper = -1
		  else
		    startRow = 1
		    endRow = lastRowIndex
		    rowStepper = 1
		  end if
		  
		  Pins.ResizeTo lastColIndex
		  
		  for col as integer = 0 to lastColIndex
		    for row as integer = startRow to endRow step rowStepper
		      if grid( row, col ) = "#" then
		        Pins( col ) = Pins( col ) + 1
		      end if
		    next
		  next
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Height As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		IsKey As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return not IsKey
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  IsKey = not value
			End Set
		#tag EndSetter
		IsLock As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  var result as integer
			  
			  for each pin as integer in Pins
			    result = result * 100 + pin
			  next
			  
			  return result
			End Get
		#tag EndGetter
		Key As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		PinCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Pins() As Integer
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
	#tag EndViewBehavior
End Class
#tag EndClass
