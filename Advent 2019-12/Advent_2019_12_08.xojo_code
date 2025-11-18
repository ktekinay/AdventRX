#tag Class
Protected Class Advent_2019_12_08
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Decode an image"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return false
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Space Image Format"
		  
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
		  if kTestInput <> "" then
		    return CalculateResultA( Normalize( kTestInput ) )
		  end if
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  if input <> "" then
		    return CalculateResultB( Normalize( input ) )
		  end if
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  var layers() as string = input.Trim.SplitEvery( 25 * 6 )
		  
		  var result as integer
		  
		  var bestLayer() as string
		  var bestCount as integer = 200000000
		  
		  for each layer as string in layers
		    var pixels() as string = layer.Split( "" )
		    
		    var count as integer
		    for each p as string in pixels
		      if p = "0" then
		        count = count + 1
		      end if
		    next
		    
		    if count < bestCount then
		      bestCount = count
		      bestLayer = pixels
		    end if
		  next
		  
		  var count1 as integer
		  var count2 as integer
		  
		  for each p as string in bestLayer
		    select case p
		    case "1"
		      count1 = count1 + 1
		    case "2"
		      count2 = count2 + 1
		    end select
		  next
		  
		  result = count1 * count2
		  
		  return result : if( IsTest, 0, 1572 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var kRows as integer = 6
		  var kColumns as integer = 25
		  
		  var rows() as string = input.Trim.SplitEvery( kColumns * kRows )
		  
		  var layers() as variant
		  
		  for each row as string in rows
		    layers.Add row.SplitEvery( kColumns )
		  next
		  
		  var bestRows() as string
		  var firstLayer() as string = layers( 0 )
		  
		  for rowIndex as integer = 0 to kRows - 1
		    var bestRow() as string = firstLayer( rowIndex ).Split( "" )
		    
		    for colIndex as integer = 0 to bestRow.LastIndex
		      if bestRow( colIndex ) <> "2" then
		        continue
		      end if
		      
		      for layerIndex as integer = 1 to layers.LastIndex
		        var layer() as string = layers( layerIndex )
		        
		        var thisRow() as string = layer( rowIndex ).Split( "" )
		        
		        if thisRow( colIndex ) <> "2" then
		          bestRow( colIndex ) = thisRow( colIndex )
		          continue for colIndex
		        end if
		      next
		    next
		    
		    bestRows.Add String.FromArray( bestRow, "" )
		  next
		  
		  const kBox as string = "※"
		  
		  var message as string = String.FromArray( bestRows, EndOfLine )
		  message = message.ReplaceAll( "0", " " )
		  message = message.ReplaceAll( "1", kBox )
		  
		  Print message
		  
		  return 0 : if( IsTest, 0, 0 )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Type"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Cooperative"
				"1 - Preemptive"
			#tag EndEnumValues
		#tag EndViewProperty
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
