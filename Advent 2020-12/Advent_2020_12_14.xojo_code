#tag Class
Protected Class Advent_2020_12_14
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
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
		  return CalculateResultB( Normalize( kTestInputB ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var rows() as string = ToStringArray( input )
		  if rows.Count = 0 then
		    return -1
		  end if
		  
		  var mask1 as UInt64 = ( 2 ^ 36 ) - 1
		  var mask2 as UInt64 = 0
		  var registers as new Dictionary
		  
		  for each row as string in rows
		    var parts() as string = row.Split( " = " )
		    var key as string = parts( 0 )
		    var value as string = parts( 1 )
		    
		    select case key
		    case "mask"
		      var mask1String as string = "&b" + value.ReplaceAll( "1", "0" ).ReplaceAll( "X", "1" )
		      mask1 = mask1String.ToInteger
		      var mask2String as string = "&b" + value.ReplaceAll( "X", "0" )
		      mask2 = mask2String.ToInteger
		      
		    case else
		      var num as UInt64 = value.ToInteger
		      num = num and mask1
		      num = num or mask2
		      registers.Value( key ) = num
		      
		    end select
		  next
		  
		  var sum as integer = SumRegisters( registers )
		  return sum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as string = ToStringArray( input )
		  if rows.Count = 0 then
		    return -1
		  end if
		  
		  var mask1 as UInt64 = 0
		  var mask2 as UInt64 = ( 2 ^ 36 ) - 1
		  var maskMap() as string
		  
		  var registers as new Dictionary
		  
		  for each row as string in rows
		    var parts() as string = row.Split( " = " )
		    var key as string = parts( 0 )
		    var value as string = parts( 1 )
		    
		    select case key
		    case "mask"
		      var mask1String as string = "&b" + value.ReplaceAll( "X", "0" ) // OR to force 1s
		      mask1 = mask1String.ToInteger
		      var mask2String as string = "&b" + value.ReplaceAll( "0", "1" ).ReplaceAll( "X", "0" ) // AND to clear X bits
		      mask2 = mask2String.ToInteger
		      
		      maskMap = value.Split( "" )
		      
		    case else
		      var memAddress as UInt64 = key.Middle( 4 ).Left( key.Length - 1 ).ToInteger
		      memAddress = memAddress or mask1 // Force the 1s
		      memAddress = memAddress and mask2 // Clear the X bits
		      
		      var num as UInt64 = value.ToInteger
		      
		      StoreToRegisters( registers, memAddress, num, maskMap )
		      
		    end select
		  next
		  
		  var sum as integer = SumRegisters( registers )
		  return sum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StoreToRegisters(registers As Dictionary, memAddress As UInt64, value As Integer, maskMap() As String, startingIndex As Integer = 0)
		  for i as integer = startingIndex to maskMap.LastIndex
		    var map as string = maskMap( i )
		    
		    if map = "X" then
		      StoreToRegisters( registers, memAddress, value, maskMap, i + 1 )
		      memAddress = memAddress or CType( 2 ^ ( maskMap.LastIndex - i ), UInt64 )
		      StoreToRegisters( registers, memAddress, value, maskMap, i + 1 )
		      return
		    end if
		  next
		  
		  //
		  // If we get here, we didn't find another "X", so store it here
		  //
		  registers.Value( memAddress ) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SumRegisters(registers As Dictionary) As Integer
		  var sum as integer
		  
		  for each num as UInt64 in registers.Values
		    sum = sum + num
		  next
		  
		  return sum
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"mask \x3D XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X\nmem[8] \x3D 11\nmem[7] \x3D 101\nmem[8] \x3D 0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"mask \x3D 000000000000000000000000000000X1001X\nmem[42] \x3D 100\nmask \x3D 00000000000000000000000000000000X0XX\nmem[26] \x3D 1", Scope = Private
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
