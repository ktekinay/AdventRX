#tag Class
Protected Class Advent_2023_12_01
Inherits AdventBase
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Function ReturnDescription() As String
		  return "Get first and last digit of each line to form two-digit values, then sum them"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Trebuchet?!"
		  
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
		  return Solve( input )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif 
		  
		  input = input.ReplaceAllBytes( "one", "o1e" )
		  input = input.ReplaceAllBytes( "two", "t2o" )
		  input = input.ReplaceAllBytes( "three", "t3e" )
		  input = input.ReplaceAllBytes( "four", "f4r" )
		  input = input.ReplaceAllBytes( "five", "f5e" )
		  input = input.ReplaceAllBytes( "six", "s6x" )
		  input = input.ReplaceAllBytes( "seven", "s7n" )
		  input = input.ReplaceAllBytes( "eight", "e8t" )
		  input = input.ReplaceAllBytes( "nine", "n9e" )
		  
		  return Solve( input )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Solve(input As String) As Integer
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif 
		  
		  //
		  // Original code using a RegEx
		  //
		  'var rx as new RegEx
		  'rx.SearchPattern = "[^\d\n\r]"
		  'rx.ReplacementPattern = ""
		  'rx.Options.ReplaceAllMatches = true
		  'input = rx.Replace( input )
		  
		  //
		  // New code with MemoryBlocks because I'm quite mad
		  //
		  var mb as MemoryBlock = input
		  mb.Size = mb.Size + 1
		  var p as ptr = mb
		  
		  var lastByteIndex as integer = mb.Size - 1
		  p.Byte( lastByteIndex ) = 10
		  
		  var total as integer
		  
		  var firstDigit as integer
		  var lastDigit as integer
		  
		  for b as integer = 0 to lastByteIndex
		    var thisByte as integer = p.Byte( b )
		    
		    select case thisByte
		    case 48 to 57
		      firstDigit = thisByte - 48
		      lastDigit = firstDigit
		      
		      for secondb as integer = b+1 to lastByteIndex
		        thisByte = p.Byte( secondb )
		        select case thisByte
		        case 10
		          total = total + ( firstDigit * 10 + lastDigit )
		          b = secondb
		          exit for secondb
		        case 48 to 57
		          lastDigit = thisByte - 48
		        end
		      next
		    end
		  next
		  
		  return total
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"two1nine\neightwothree\nabcone2threexyz\nxtwone3four\n4nineeightseven2\nzoneight234\n7pqrstsixteen", Scope = Private
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
