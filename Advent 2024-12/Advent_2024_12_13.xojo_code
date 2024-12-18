#tag Class
Protected Class Advent_2024_12_13
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Unknown"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Claw Contraption"
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
		  var machines() as string = Normalize( input ).Split( EndOfLine + EndOfLine )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "X[\+=](\d+), Y[\+=](\d+)"
		  
		  var result as integer
		  
		  for machineIndex as integer = 0 to machines.LastIndex
		    var machine as string = machines( machineIndex )
		    var match as RegExMatch = rx.Search( machine )
		    var ax as integer = match.SubExpressionString( 1 ).ToInteger
		    var ay as integer = match.SubExpressionString( 2 ).ToInteger
		    
		    match = rx.Search
		    var bx as integer = match.SubExpressionString( 1 ).ToInteger
		    var by as integer = match.SubExpressionString( 2 ).ToInteger
		    
		    match = rx.Search
		    var px as integer = match.SubExpressionString( 1 ).ToInteger
		    var py as integer = match.SubExpressionString( 2 ).ToInteger
		    
		    var xy as Pair = Math.SolveForXY( ax, bx, px, ay, by, py )
		    
		    if xy is nil then
		      continue
		    end if
		    
		    result = result + ( xy.Left.IntegerValue * 3 ) + xy.Right.IntegerValue
		    
		  next
		  
		  return result : if( IsTest, 480, 29023 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var machines() as string = Normalize( input ).Split( EndOfLine + EndOfLine )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "X[\+=](\d+), Y[\+=](\d+)"
		  
		  var result as integer
		  
		  for machineIndex as integer = 0 to machines.LastIndex
		    var machine as string = machines( machineIndex )
		    var match as RegExMatch = rx.Search( machine )
		    var ax as integer = match.SubExpressionString( 1 ).ToInteger
		    var ay as integer = match.SubExpressionString( 2 ).ToInteger
		    
		    match = rx.Search
		    var bx as integer = match.SubExpressionString( 1 ).ToInteger
		    var by as integer = match.SubExpressionString( 2 ).ToInteger
		    
		    match = rx.Search
		    var px as integer = match.SubExpressionString( 1 ).ToInteger + 10000000000000
		    var py as integer = match.SubExpressionString( 2 ).ToInteger + 10000000000000
		    
		    var xy as Pair = Math.SolveForXY( ax, bx, px, ay, by, py )
		    
		    if xy is nil then
		      continue
		    end if
		    
		    result = result + ( xy.Left.IntegerValue * 3 ) + xy.Right.IntegerValue
		  next
		  
		  return result : if( IsTest, 875318608908, 96787395375634 )
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Button A: X+94\x2C Y+34\nButton B: X+22\x2C Y+67\nPrize: X\x3D8400\x2C Y\x3D5400\n\nButton A: X+26\x2C Y+66\nButton B: X+67\x2C Y+21\nPrize: X\x3D12748\x2C Y\x3D12176\n\nButton A: X+17\x2C Y+86\nButton B: X+84\x2C Y+37\nPrize: X\x3D7870\x2C Y\x3D6450\n\nButton A: X+69\x2C Y+23\nButton B: X+27\x2C Y+71\nPrize: X\x3D18641\x2C Y\x3D10279", Scope = Private
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
