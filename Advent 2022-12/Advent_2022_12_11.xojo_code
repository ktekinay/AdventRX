#tag Class
Protected Class Advent_2022_12_11
Inherits AdventBase
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Function ReturnDescription() As String
		  return "Monkeys play keep-away"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Monkey in the Middle"
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( Normalize( GetPuzzleInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( Normalize( GetPuzzleInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  return CalculateResultB( Normalize( input ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var monkeys() as Monkey = ParseInput( input )
		  Process monkeys, 20
		  monkeys.Sort AddressOf SortByInspectionCount
		  
		  var m2 as Monkey = monkeys.Pop
		  var m1 as Monkey = monkeys.Pop
		  
		  var calc as integer = m1.InspectionCount * m2.InspectionCount
		  
		  return calc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var monkeys() as Monkey = ParseInput( input )
		  
		  Monkey.LCM = 1
		  for each m as Monkey in monkeys
		    m.DoDivideBy3 = false
		    Monkey.LCM = LeastCommonDivisor( Monkey.LCM, m.Test )
		  next
		  
		  Process monkeys, 10000
		  monkeys.Sort AddressOf SortByInspectionCount
		  
		  var m2 as Monkey = monkeys.Pop
		  var m1 as Monkey = monkeys.Pop
		  
		  var calc as integer = m1.InspectionCount * m2.InspectionCount
		  
		  return calc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MaybePrint(round As Integer, monkeys() As Monkey)
		  if not IsTest or not kDebug then
		    return
		  end if
		  
		  if round <> 1 and round <> 20 and ( round mod 1000 ) <> 0 then
		    return
		  end if
		  
		  Print "ROUND " + round.ToString
		  
		  for each m as Monkey in monkeys
		    Print "Monkey " + m.Index.ToString + " inspected items " + m.InspectionCount.ToString + " times"
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As Monkey()
		  var monkeys() as Monkey
		  
		  var groups() as string = input.Split( EndOfLine + EndOfLine )
		  
		  for each group as string in groups
		    monkeys.Add ParseMonkeyData( group )
		  next
		  
		  return monkeys
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseMonkeyData(data As String) As Monkey
		  'Monkey 0:
		  'Starting items: 93, 54, 69, 66, 71
		  'Operation: new = old * 3
		  'Test: divisible by 7
		  'If true: throw to monkey 7
		  'If false: throw to monkey 1
		  
		  var lines() as string = data.Split( EndOfLine )
		  
		  var m as new Monkey
		  
		  m.Index = lines( 0 ).NthField( " ", 2 ).Replace( ":", "" ).ToInteger
		  m.Items = ToIntegerArray( lines( 1 ).NthField( ": ", 2 ).ReplaceAll( ", ", EndOfLine ) )
		  m.Operation = lines( 2 ).NthField( ": ", 2 ).Replace( "new = ", "" )
		  m.Test = lines( 3 ).Trim.NthField( " ", 4 ).ToInteger
		  m.TrueMonkey = lines( 4 ).Trim.NthField( " ", 6 ).ToInteger
		  m.FalseMonkey = lines( 5 ).Trim.NthField( " ", 6 ).ToInteger
		  
		  return m
		  return m
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Print(monkeys() As Monkey)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Process(monkeys() As Monkey, rounds As Integer)
		  for round as integer = 1 to rounds
		    for each m as Monkey in monkeys
		      m.ProcessItems monkeys
		    next
		    
		    MaybePrint round, monkeys
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SortByInspectionCount(m1 As Monkey, m2 As Monkey) As Integer
		  return m1.InspectionCount - m2.InspectionCount
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kDebug, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Monkey 0:\n  Starting items: 79\x2C 98\n  Operation: new \x3D old * 19\n  Test: divisible by 23\n    If true: throw to monkey 2\n    If false: throw to monkey 3\n\nMonkey 1:\n  Starting items: 54\x2C 65\x2C 75\x2C 74\n  Operation: new \x3D old + 6\n  Test: divisible by 19\n    If true: throw to monkey 2\n    If false: throw to monkey 0\n\nMonkey 2:\n  Starting items: 79\x2C 60\x2C 97\n  Operation: new \x3D old * old\n  Test: divisible by 13\n    If true: throw to monkey 1\n    If false: throw to monkey 3\n\nMonkey 3:\n  Starting items: 74\n  Operation: new \x3D old + 3\n  Test: divisible by 17\n    If true: throw to monkey 0\n    If false: throw to monkey 1", Scope = Private
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
