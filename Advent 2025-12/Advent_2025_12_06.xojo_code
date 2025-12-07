#tag Class
Protected Class Advent_2025_12_06
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Vertical math"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Trash Compactor"
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
		  input = input.Trim.ReplaceLineEndings( EndOfLine )
		  
		  var rows() as string = input.Split( EndOfLine )
		  
		  for i as integer = 0 to rows.LastIndex
		    rows( i ) = rows( i ).Trim.Squeeze( " " )
		  next
		  
		  var newInput as string = String.FromArray( rows, EndOfLine )
		  
		  var values( -1, -1 ) as string = ToStringGrid( newInput, " " )
		  
		  var lastRowIndex as integer = values.LastIndex( 1 )
		  var lastYIndex as integer = lastRowIndex - 1
		  
		  var grandTotal as integer
		  
		  for x as integer = 0 to values.LastIndex( 2 )
		    var op as string = values( lastRowIndex, x )
		    
		    var colTotal as integer
		    
		    if op = "*" then
		      colTotal = 1
		    end if
		    
		    for y as integer = 0 to lastYIndex
		      var val as integer = values( y, x ).ToInteger
		      select case op
		      case "+" 
		        colTotal = colTotal + val
		      case "*"
		        colTotal = colTotal * val
		      case else
		        op = op
		      end select
		    next
		    
		    grandTotal = grandTotal + colTotal
		  next
		  
		  var testAnswer as variant = 4277556
		  var answer as variant = 6605396225322
		  
		  return grandTotal : if( IsTest, testAnswer, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var grid( -1, -1 ) as string = ToStringGrid( input )
		  
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastValueRowIndex as integer = lastRowIndex - 1
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var grandTotal as integer
		  
		  var col as integer = lastColIndex
		  
		  do
		    //
		    // Find the last col and op
		    //
		    var op as string
		    
		    var startCol as integer = col
		    var lastCol as integer = col
		    
		    for testCol as integer = lastCol downto 0
		      op = grid( lastRowIndex, testCol )
		      
		      select case op
		      case "*", "+"
		        lastCol = testCol
		        col = lastCol - 2
		        exit
		      end select
		    next
		    
		    var values() as integer
		    values.ResizeTo startCol - lastCol
		    
		    var valueIndex as integer = 0
		    
		    for startCol = startCol downto lastCol
		      for row as integer = 0 to lastValueRowIndex
		        var data as string = grid( row, startCol )
		        
		        if data >= "0" and data <= "9" then
		          values( valueIndex ) = values( valueIndex ) * 10 + data.ToInteger
		        end if
		      next
		      
		      valueIndex = valueIndex + 1
		    next
		    
		    select case op
		    case "+"
		      grandTotal = grandTotal + SumArray( values )
		    case "*"
		      grandTotal = grandTotal + MultiplyArray( values, false )
		    end select
		  loop until col < 0
		  
		  var testAnswer as variant = 3263827
		  var answer as variant = 11052310600986
		  
		  return grandTotal : if( IsTest, testAnswer, answer )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"123 328  51 64 \n 45 64  387 23 \n  6 98  215 314\n*   +   *   +  \n", Scope = Private
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
