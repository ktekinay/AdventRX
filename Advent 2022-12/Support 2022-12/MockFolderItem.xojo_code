#tag Class
Protected Class MockFolderItem
	#tag Method, Flags = &h0
		Sub AddChild(child As MockFolderItem)
		  Files.Add child
		  child.Parent = self
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Child(name As String) As MockFolderItem
		  for each f as MockFolderItem in Files
		    if f.Name = name then
		      return f
		    end if
		  next
		  
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateSize()
		  if not IsDirectory then
		    return
		  end if
		  
		  Size = 0
		  
		  for each f as MockFolderItem in Files
		    if f.IsDirectory then
		      f.UpdateSize
		    end if
		    Size = Size + f.Size
		  next
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Files() As MockFolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		IsDirectory As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParentWR As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mParentWR is nil then
			    return nil
			  else
			    return MockFolderItem( mParentWR.Value )
			  end if
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  if value is nil then
			    mParentWR = nil
			  else
			    mParentWR = new WeakRef( value )
			  end if
			End Set
		#tag EndSetter
		Parent As MockFolderItem
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Size As Integer
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
