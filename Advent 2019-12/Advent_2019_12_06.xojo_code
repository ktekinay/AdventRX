#tag Class
Protected Class Advent_2019_12_06
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Determine paths of orbiting objects"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Universal Orbit Map"
		  
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
		Private Shared Sub AddToNeighbors(neighbors As Dictionary, key As String, value As String)
		  if neighbors.HasKey( key ) then
		    var existing() as string = neighbors.Value( key )
		    existing.Add value
		  else
		    var existing() as string = array( value )
		    neighbors.Value( key ) = existing
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  var rows() as string = ToStringArray( input )
		  var orbits as new Dictionary
		  
		  for each row as string in rows
		    var parts() as string = row.Split( ")" )
		    orbits.Value( parts( 1 ) ) = parts( 0 )
		  next
		  
		  var count as integer = Count( orbits )
		  
		  return count : if( IsTest, 42, 292387 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var rows() as string = ToStringArray( input )
		  var neighbors as new Dictionary
		  
		  for each row as string in rows
		    var parts() as string = row.Split( ")" )
		    
		    var a as string = parts( 0 )
		    var b as string = parts( 1 )
		    
		    AddToNeighbors( neighbors, a, b )
		    AddToNeighbors( neighbors, b, a )
		  next
		  
		  var distance as integer = Trace( neighbors.Value( "YOU" ), 0, neighbors, new Set )
		  
		  return distance : if( IsTest, 4, 433 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Count(orbits As Dictionary) As Integer
		  var count as integer
		  
		  var keys() as variant = orbits.Keys
		  
		  for each key as variant in keys
		    var this as variant = key
		    
		    while this.StringValue <> "COM"
		      count = count + 1
		      this = orbits.Value( this )
		    wend
		  next
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Trace(existing() As String, count As Integer, neighbors As Dictionary, visited As Set) As Integer
		  const kTarget as string = "SAN"
		  
		  var distance as integer
		  
		  for each item as string in existing
		    if visited.HasMember( item ) then
		      continue
		    end if
		    
		    if item = kTarget then
		      return count - 1
		    end if
		    
		    visited.Add item
		    var nextItems() as string = neighbors.Value( item )
		    
		    distance = Trace( nextItems, count + 1, neighbors, visited )
		    
		    if distance <> 0 then
		      return distance
		    end if
		  next
		  
		  return 0
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L\nK)YOU\nI)SAN", Scope = Private
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
