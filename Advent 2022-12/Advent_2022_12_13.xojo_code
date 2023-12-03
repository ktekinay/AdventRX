#tag Class
Protected Class Advent_2022_12_13
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Compare and sort packets"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Distress Signal"
		  
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
		Private Function CalculateResultA(input As String) As Integer
		  var groups() as string = input.Split( EndOfLine + EndOfLine )
		  
		  var result as integer
		  
		  for i as integer = 0 to groups.LastIndex
		    var group as string = groups( i )
		    
		    if CompareValues( group.NthField( EndOfLine, 1 ), group.NthField( EndOfLine, 2 ) ) then
		      var index as integer = i + 1
		      result = result + index
		    end if
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  input = input.ReplaceAll( EndOfLine + EndOfLine, EndOfLine )
		  var sarr() as string = input.Split( EndOfLine )
		  
		  sarr.Add "[[2]]"
		  sarr.Add "[[6]]"
		  
		  var j as string = "[" + String.FromArray( sarr, "," ) + "]"
		  var jarr() as variant = ParseJSON( j )
		  
		  jarr.Sort AddressOf Sorter
		  
		  'if IsTest then
		  'for each v as variant in jarr
		  'Print GenerateJSON( v )
		  'next
		  'Print ""
		  'end if
		  
		  var indexes() as integer
		  
		  for index as integer = 0 to jarr.LastIndex
		    var arr() as variant = jarr( index )
		    
		    if arr.Count = 1 and arr( 0 ).IsArray then
		      arr = arr( 0 )
		      if arr.Count = 1 then
		        var el as variant = arr( 0 )
		        if el.Type = Variant.TypeInteger and ( el = 2 or el = 6 ) then
		          indexes.Add index + 1
		          
		          if indexes.Count = 2 then
		            exit
		          end if
		        end if
		      end if
		    end if
		  next
		  
		  return indexes( 0 ) * indexes( 1 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CompareArrays(j1() As Variant, j2() As Variant) As Integer
		  if j1.Count = j2.Count then
		    for i as integer = 0 to j1.LastIndex
		      var e1 as variant = j1( i )
		      var e2 as variant = j2( i )
		      
		      if e1.IsArray and e2.IsArray then
		        var r as integer = CompareArrays( e1, e2 ) 
		        if r <> 0 then
		          return r
		        end if
		      end if
		      
		      var r as integer = CompareElements( e1, e2 )
		      
		      if r = 0 then
		        continue
		      end if
		      
		      return r
		    next
		    
		    return 0
		  end if
		  
		  var index as integer = -1
		  
		  do
		    index = index + 1
		    
		    if j1.LastIndex < index then
		      return -1
		    end if
		    
		    if j2.LastIndex < index then
		      return 1
		    end if
		    
		    var e1 as variant = j1( index )
		    var e2 as variant = j2( index )
		    
		    var r as integer = CompareElements( e1, e2 )
		    
		    if r = 0 then
		      continue
		    end if
		    
		    return r
		  loop
		  
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CompareElements(e1 As Variant, e2 As Variant) As Integer
		  if e1.Type = Variant.TypeInteger and e2.Type = Variant.TypeInteger then
		    return e1.IntegerValue - e2.IntegerValue
		  end if
		  
		  var j1() as variant
		  var j2() as variant
		  
		  if e1.IsArray then
		    j1 = e1
		  else
		    j1.Add e1
		  end if
		  
		  if e2.IsArray then
		    j2 = e2
		  else
		    j2.Add e2
		  end if
		  
		  return CompareArrays( j1, j2 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CompareValues(val1 As String, val2 As String) As Boolean
		  var j1() as variant = ParseJSON( val1 )
		  var j2() as variant = ParseJSON( val2 )
		  
		  ExpandArrays j1, j2
		  'Print val1 + " -> " + GenerateJSON( j1 )
		  'Print val2 + " -> " + GenerateJSON( j2 )
		  
		  return CompareArrays( j1, j2 ) < 0 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExpandArrays(j1() As Variant, j2() As Variant)
		  var i as integer = -1
		  
		  do
		    i = i + 1
		    
		    if j1.LastIndex < i or j2.LastIndex < i then
		      return
		    end if
		    
		    if j1( i ).Type = j2( i ).Type then
		      continue
		    end if
		    
		    if not j1( i ).IsArray then
		      var arr() as variant
		      arr.Add j1( i )
		      j1( i ) = arr
		    end if
		    
		    if not j2( i ).IsArray then
		      var arr() as variant
		      arr.Add j2( i )
		      j2( i ) = arr
		    end if
		    
		    ExpandArrays j1( i ), j2( i )
		  loop
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Sorter(j1 As Variant, j2 As Variant) As Integer
		  return CompareArrays( j1, j2 )
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"[1\x2C1\x2C3\x2C1\x2C1]\n[1\x2C1\x2C5\x2C1\x2C1]\n\n[[1]\x2C[2\x2C3\x2C4]]\n[[1]\x2C4]\n\n[9]\n[[8\x2C7\x2C6]]\n\n[[4\x2C4]\x2C4\x2C4]\n[[4\x2C4]\x2C4\x2C4\x2C4]\n\n[7\x2C7\x2C7\x2C7]\n[7\x2C7\x2C7]\n\n[]\n[3]\n\n[[[]]]\n[[]]\n\n[1\x2C[2\x2C[3\x2C[4\x2C[5\x2C6\x2C7]]]]\x2C8\x2C9]\n[1\x2C[2\x2C[3\x2C[4\x2C[5\x2C6\x2C0]]]]\x2C8\x2C9]", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


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
