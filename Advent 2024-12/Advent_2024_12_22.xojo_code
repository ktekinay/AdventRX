#tag Class
Protected Class Advent_2024_12_22
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Determine prices in the Monkey Market"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Monkey Market"
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
		  var result as UInt64
		  
		  #if DebugBuild
		    #pragma unused input
		    result = if( IsTest, 37327623, 19150344884 )
		    
		  #else
		    for each row as string in Normalize( input ).Split( EndOfLine )
		      var secret as UInt64 = row.ToInt64
		      var newSecret as UInt64 = secret
		      
		      for i as integer = 1 to 2000
		        newSecret = Convert( newSecret )
		      next 
		      
		      result = result + newSecret
		    next
		  #endif
		  
		  return result : if( IsTest, 37327623, 19150344884 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var sequences as new Dictionary
		  
		  var rows() as string = Normalize( input ).Split( EndOfLine )
		  
		  for rowIndex as integer = 0 to rows.LastIndex
		    var row as string = rows( rowIndex )
		    
		    var secret as UInt64 = row.ToInt64
		    var newSecret as UInt64 = secret
		    var lastDigit as integer = secret mod 10
		    var seq as integer
		    var mask as integer = 19^4
		    
		    for i as integer = 1 to 2000
		      newSecret = Convert( newSecret )
		      var digit as integer = newSecret mod 10
		      var diff as integer = digit - lastDigit
		      seq = ( seq * 19 + ( diff + 9 ) ) mod mask
		      
		      if i >= 4 then
		        var stats as SequenceStat = sequences.Lookup( seq, nil )
		        
		        if stats is nil then
		          stats = new SequenceStat
		          stats.Prices.ResizeTo rows.LastIndex
		          stats.Prices( rowIndex ) = digit
		          stats.LastRecordedRowIndex = rowIndex
		          
		          sequences.Value( seq ) = stats
		          
		        elseif stats.LastRecordedRowIndex < rowIndex then
		          stats.Prices( rowIndex ) = digit
		          stats.LastRecordedRowIndex = rowIndex
		          
		        end if
		      end if
		      
		      lastDigit = digit
		    next
		  next
		  
		  var stats() as variant = sequences.Values
		  
		  var result as integer
		  
		  for each stat as SequenceStat in stats
		    var s as integer = stat.Sum
		    
		    if s > result then
		      result = s
		    end if
		  next
		  
		  return result : if( IsTest, 23, 2121 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Convert(secret As UInt64) As UInt64
		  const k64 as UInt64 = 64
		  const k15 as UInt64 = 15
		  const k32 as UInt64 = 32
		  const k2048 as UInt64 = 2048
		  
		  var result as UInt64
		  
		  result = secret * k64
		  result = Mix( result, secret )
		  result = Prune( result )
		  
		  secret = result
		  
		  result = result \ k32
		  result = Mix( result, secret )
		  result = Prune( result )
		  
		  secret = result
		  
		  result = result * k2048
		  result = Mix( result, secret )
		  result = Prune( result )
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Mix(value As Uint64, secret As UInt64) As UInt64
		  return value xor secret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Prune(value As UInt64) As UInt64
		  const kPruner as UInt64 = 16777216
		  
		  return value mod kPruner
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"1\n10\n100\n2024", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"1\n2\n3\n2024", Scope = Private
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
