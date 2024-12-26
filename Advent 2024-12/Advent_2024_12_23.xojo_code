#tag Class
Protected Class Advent_2024_12_23
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Determined linked computers"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "LAN Party"
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
		  var relations as new Dictionary
		  
		  Parse input, relations
		  
		  var ts() as variant = relations.Keys
		  var found as new Set
		  
		  for each c as string in ts
		    if not c.BeginsWith( "t" ) then
		      continue
		    end if
		    
		    var s as Set = relations.Value( c )
		    
		    if s.Count < 2 then
		      continue
		    end if
		    
		    var others() as variant = s.ToArray
		    
		    for outer as integer = 0 to others.LastIndex - 1
		      var outerChar as string = others( outer )
		      var outerSet as Set = relations.Value( outerChar )
		      
		      for inner as integer = outer + 1 to others.LastIndex
		        var innerChar as string = others( inner )
		        
		        if outerSet.HasMember( innerChar ) then
		          var keyBuilder() as string
		          keyBuilder.Add c
		          keyBuilder.Add outerChar
		          keyBuilder.Add innerChar
		          keyBuilder.Sort
		          
		          found.Add String.FromArray( keyBuilder, "-" )
		        end if
		      next
		    next
		  next
		  
		  var result as integer = found.Count
		  return result : if( IsTest, 7, 1314 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var relations as new Dictionary
		  
		  Parse input, relations
		  
		  var computers() as variant = relations.Keys
		  var computerSets() as variant = relations.Values
		  
		  var foundMax as integer
		  var foundMaxSet as new Set
		  var cache as new Dictionary
		  
		  for i as integer = 0 to computers.LastIndex
		    var computer as string = computers( i )
		    var compSet as Set = computerSets( i )
		    
		    var tryThese() as variant = compSet.ToArray
		    
		    var linkedSet as Set = Walk( tryThese, compSet, relations, foundMax, cache )
		    
		    if linkedSet.Count >= foundMax then
		      foundMaxSet = linkedSet
		      foundMaxSet.Add computer
		      foundMax = foundMaxSet.Count
		    end if
		  next
		  
		  var result as string = Key( foundMaxSet.ToArray )
		  
		  return result : if( IsTest, "co,de,ka,ta", "bg,bu,ce,ga,hw,jw,nf,nt,ox,tj,uu,vk,wp" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Key(keys() As Variant) As String
		  var sKeys() as string
		  
		  for each k as variant in keys
		    sKeys.Add k.StringValue
		  next
		  
		  sKeys.Sort
		  return String.FromArray( sKeys, "," )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Parse(input As String, relations As Dictionary)
		  var rows() as string = Normalize( input ).Split( EndOfLine )
		  
		  for each pair as string in rows
		    var parts() as string = pair.Split( "-" )
		    var c1 as string = parts( 0 )
		    var c2 as string = parts( 1 )
		    
		    var s as Set
		    
		    s = relations.Lookup( c1, nil )
		    if s is nil then
		      s = new Set
		      relations.Value( c1 ) = s
		    end if
		    
		    s.Add c2
		    
		    s = relations.Lookup( c2, nil )
		    if s is nil then
		      s = new Set
		      relations.Value( c2 ) = s
		    end if
		    
		    s.Add c1
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Walk(tryThese() As Variant, againstSet As Set, relations As Dictionary, foundMax As Integer, cache As Dictionary) As Set
		  var key as string = Key( againstSet.ToArray ) + "-" + Key( tryThese )
		  
		  var bestSet as Set = cache.Lookup( key, nil )
		  
		  if bestSet isa Set then
		    return Set.FromArray( bestSet.ToArray )
		  end if
		  
		  bestSet = new Set
		  
		  for each computer as string in tryThese
		    var compSet as Set = relations.Value( computer )
		    
		    var newSet as Set = againstSet.Intersection( compSet )
		    
		    var linkedSet as Set 
		    
		    if newSet.Count < againstSet.Count then
		      var newTryThese() as variant = newSet.ToArray
		      
		      linkedSet = Walk( newTryThese, newSet, relations, foundMax, cache )
		    else
		      linkedSet = Set.FromArray( againstSet.ToArray )
		      
		    end if
		    
		    if linkedSet.Count >= bestSet.Count then
		      linkedSet.Add computer
		      bestSet = linkedSet
		    end if
		  next
		  
		  cache.Value( key ) = Set.FromArray( bestSet.ToArray )
		  return bestSet
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"kh-tc\nqp-kh\nde-cg\nka-co\nyn-aq\nqp-ub\ncg-tb\nvc-aq\ntb-ka\nwh-tc\nyn-cg\nkh-ub\nta-co\nde-co\ntc-td\ntb-wq\nwh-td\nta-ka\ntd-qp\naq-cg\nwq-ub\nub-vc\nde-ta\nwq-aq\nwq-vc\nwh-yn\nka-de\nkh-ta\nco-tc\nwh-qp\ntb-vc\ntd-yn", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2024
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
