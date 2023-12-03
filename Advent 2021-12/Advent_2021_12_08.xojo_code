#tag Class
Protected Class Advent_2021_12_08
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Variant
		  return CalculateResultA( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Variant
		  return CalculateResultB( GetPuzzleInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Variant
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var rows() as pair = ParseInput( input )
		  
		  var digitCount as integer
		  
		  for each row as pair in rows
		    var digits() as string = row.Right
		    
		    for each digit as string in digits
		      select case digit.Length
		      case 2, 4, 3, 7  // 1, 4, 7, 8
		        digitCount = digitCount + 1
		      end select
		    next
		  next
		  
		  return digitCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as pair = ParseInput( input )
		  
		  var total as integer
		  
		  for each row as pair in rows
		    total = total + Decode( row.Left, row.Right )
		  next row
		  
		  return total
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Decode(wires() As String, digits() As String) As Integer
		  var translator as new DigitTranslator
		  
		  for each wire as string in wires
		    translator.AddDigit wire
		  next
		  
		  Translator.Finalize
		  
		  if not translator.IsDecoded then
		    translator = translator
		  end if
		  
		  var total as integer
		  for each digit as string in digits
		    total = total * 10 + Translator.Decode( digit )
		  next
		  
		  return total
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As Pair()
		  var result() as pair
		  
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).ReplaceAll( "|" + EndOfLine, "| " ).Split( EndOfLine )
		  
		  for each row as string in rows
		    var parts() as string = row.Split( "|" )
		    
		    var wires() as string = parts( 0 ).Split( " " )
		    var digits() as string = parts( 1 ).Split( " " )
		    
		    if wires( 0 ).Trim = "" then
		      wires.RemoveAt 0
		    end if
		    
		    if wires( wires.LastIndex ).Trim = "" then
		      wires.RemoveAt wires.LastIndex
		    end if
		    
		    if digits( 0 ).Trim = "" then
		      digits.RemoveAt 0
		    end if
		    
		    if digits( digits.LastIndex ).Trim = "" then
		      digits.RemoveAt( digits.LastIndex )
		    end if
		    
		    result.Add wires : digits
		  next row
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb |\nfdgacbe cefdb cefbgd gcbe\nedbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec |\nfcgedb cgb dgebacf gc\nfgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef |\ncg cg fdcagb cbg\nfbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega |\nefabcd cedba gadfec cb\naecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga |\ngecf egdcabf bgf bfgea\nfgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf |\ngebdcfa ecba ca fadegcb\ndbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf |\ncefg dcbef fcge gbcadfe\nbdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd |\ned bcgafe cdgba cbgef\negadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg |\ngbdfcae bgc cg cgb\ngcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc |\nfgae cfgab fg bagce", Scope = Private
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
