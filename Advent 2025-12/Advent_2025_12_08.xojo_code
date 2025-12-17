#tag Class
Protected Class Advent_2025_12_08
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Create circuits from junction boxes"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Playground"
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
		  var targetCount as integer = if( IsTest, 10, 1000 )
		  
		  var junctions() as Junction = Parse( input )
		  
		  var combos() as Pair = GetCombos( junctions )
		  
		  for comboIndex as integer = 0 to targetCount - 1
		    var combo as Pair = combos( comboIndex )
		    
		    var j1 as Junction = combo.Left
		    var j2 as Junction = combo.Right
		    
		    j1.AddToCircuit j2
		  next
		  
		  var circuits as new Set
		  var counts() as integer
		  
		  for each j as Junction in junctions
		    if j.Circuit is nil or circuits.HasMember( j.Circuit ) then
		      continue
		    end if
		    
		    circuits.Add j.Circuit
		    counts.Add j.Circuit.Count
		  next
		  
		  counts.Sort
		  
		  var prod as integer = 1
		  
		  for i as integer = counts.LastIndex downto counts.LastIndex - 2
		    prod = prod * counts( i )
		  next
		  
		  var testAnswer as variant = 40
		  var answer as variant = 26400
		  
		  return prod : if( IsTest, testAnswer, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var junctions() as Junction = Parse( input )
		  
		  var combos() as Pair = GetCombos( junctions )
		  
		  var prod as integer
		  
		  for each combo as Pair in combos
		    var j1 as Junction = combo.Left
		    var j2 as Junction = combo.Right
		    
		    j1.AddToCircuit j2
		    
		    if j1.Circuit.Count = junctions.Count then
		      prod = j1.X * j2.X
		      exit
		    end if
		  next
		  
		  var testAnswer as variant = 25272
		  var answer as variant = 8199963486
		  
		  return prod : if( IsTest, testAnswer, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function GetCombos(junctions() As Junction) As Pair()
		  var combos() as Pair
		  var distances() as double
		  
		  for i1 as integer = 0 to junctions.LastIndex - 1
		    var j1 as Junction = junctions( i1 )
		    
		    for i2 as integer = i1 + 1 to junctions.LastIndex
		      var j2 as Junction = junctions( i2 )
		      
		      combos.Add j1 : j2
		      distances.Add Junction.Distance( j1, j2 )
		    next
		  next
		  
		  distances.SortWith combos
		  
		  return combos
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Parse(input As String) As Junction()
		  var rows() as string = ToStringArray( input )
		  
		  var junctions() as Junction
		  
		  for each row as string in rows
		    var parts() as string = row.Split( "," )
		    
		    var j as new Junction
		    j.X = parts( 0 ).ToInteger
		    j.Y = parts( 1 ).ToInteger
		    j.Z = parts( 2 ).ToInteger
		    
		    junctions.Add j
		  next
		  
		  return junctions
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"162\x2C817\x2C812\n57\x2C618\x2C57\n906\x2C360\x2C560\n592\x2C479\x2C940\n352\x2C342\x2C300\n466\x2C668\x2C158\n542\x2C29\x2C236\n431\x2C825\x2C988\n739\x2C650\x2C466\n52\x2C470\x2C668\n216\x2C146\x2C977\n819\x2C987\x2C18\n117\x2C168\x2C530\n805\x2C96\x2C715\n346\x2C949\x2C466\n970\x2C615\x2C88\n941\x2C993\x2C340\n862\x2C61\x2C35\n984\x2C92\x2C344\n425\x2C690\x2C689", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2025
	#tag EndUsing


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
