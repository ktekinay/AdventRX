#tag Class
Protected Class Advent_2023_12_15
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Hash labels and sort lenses"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Lens Library"
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Variant
		  return CalculateResultA( Normalize( GetPuzzleInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Variant
		  return CalculateResultB( Normalize( GetPuzzleInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Variant
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  return CalculateResultB( Normalize( input ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  var data() as string = input.Split( "," )
		  
		  var total as integer
		  
		  for each v as string in data
		    total = total + Hash( v )
		  next
		  
		  return total : if( IsTest, 1320, 511215 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var data() as string = input.Split( "," )
		  
		  var boxes( 255 ) as LensBox
		  
		  for b as integer = 0 to boxes.LastIndex
		    boxes( b ) = new LensBox
		    boxes( b ).BoxNumber = b + 1
		  next
		  
		  for each v as string in data
		    var label as string
		    var op as string
		    var focalLength as integer
		    
		    var parts() as string
		    
		    if v.Contains( "=" ) then
		      parts = v.Split( "=" )
		      label = parts( 0 )
		      op = "="
		      focalLength = parts( 1 ).ToInteger
		    else
		      parts = v.Split( "-" )
		      label = parts( 0 )
		      op = "-"
		    end if
		    
		    var boxNumber as integer = Hash( label )
		    var box as LensBox = boxes( boxNumber )
		    
		    if op = "=" then
		      var foundIt as boolean
		      
		      for i as integer = 0 to box.Lenses.LastIndex
		        if box.Lenses( i ).Label = label then
		          box.Lenses( i ).FocalLength = focalLength
		          
		          foundIt = true
		          exit
		        end if
		      next
		      
		      if not foundIt then
		        box.Lenses.Add new Lens( label, focalLength )
		      end if
		      
		    else // "-"
		      for i as integer = 0 to box.Lenses.LastIndex
		        if box.Lenses( i ).Label = label then
		          box.Lenses.RemoveAt i
		          exit
		        end if
		      next
		      
		    end if
		  next
		  
		  var total as integer
		  
		  for each box as LensBox in boxes
		    var lenses() as Lens = box.Lenses
		    
		    for lensIndex as integer = 0 to lenses.LastIndex
		      var l as Lens = lenses( lensIndex )
		      total = total + ( box.BoxNumber * ( lensIndex + 1 ) * l.FocalLength )
		    next
		  next
		  
		  return total : if( IsTest, 145, 236057 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Hash(s As String) As Integer
		  var mb as MemoryBlock = s
		  var p as Ptr = mb
		  
		  var vTotal as integer
		  
		  for i as integer = 0 to mb.Size - 1
		    vTotal = ( ( vTotal + p.Byte( i ) ) * 17 ) mod 256
		  next
		  
		  return vTotal
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"rn\x3D1\x2Ccm-\x2Cqp\x3D3\x2Ccm\x3D2\x2Cqp-\x2Cpc\x3D4\x2Cot\x3D9\x2Cab\x3D5\x2Cpc-\x2Cpc\x3D6\x2Cot\x3D7", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2023
	#tag EndUsing


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
