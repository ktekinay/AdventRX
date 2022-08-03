#tag Class
Protected Class Advent_2021_12_18
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( GetPuzzleInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var rows() as variant = ParseInput( input )
		  if rows.Count = 0 then
		    return 0
		  end if
		  
		  var sum() as string = rows( 0 )
		  
		  for i as integer = 1 to rows.LastIndex
		    sum.AddAt 0, "["
		    
		    var thisRow() As string = rows( i )
		    for each item as string in thisRow
		      sum.Add item
		    next
		    
		    sum.Add "]"
		    
		    #if kIsDebug
		      System.DebugLog i.ToString + " before: " + RowToString( sum )
		    #endif
		    
		    Reduce sum
		    
		    #if kIsDebug
		      System.DebugLog i.ToString + " after: " + RowToString( sum )
		    #endif
		  next i
		  
		  #if kIsDebug
		    var sumString as string = RowToString( sum )
		    System.DebugLog "Final: " + sumString
		    
		    var expected as string = "[[[[6,6],[7,6]],[[7,7],[7,0]]],[[[7,7],[7,7]],[[7,8],[9,9]]]]"
		    if sumString <> expected then
		      System.DebugLog "EXPECTED: " + expected
		      return -1
		    end if
		  #endif
		  
		  return Magnitude( sum )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as variant = ParseInput( input )
		  if rows.Count = 0 then
		    return 0
		  end if
		  
		  var maxMagnitude as integer
		  
		  for rowIndex1 as integer = 0 to rows.LastIndex
		    for rowIndex2 as integer = 0 to rows.LastIndex
		      if rowIndex1 = rowIndex2 then
		        continue
		      end if
		      
		      var row1() as string = rows( rowIndex1 )
		      var row2() as string = rows( rowIndex2 )
		      
		      var sum() as string
		      sum.Add "["
		      for each item as string in row1
		        sum.Add item
		      next
		      for each item as string in row2
		        sum.Add item
		      next
		      sum.Add "]"
		      
		      Reduce sum
		      var thisMagnitude as integer = Magnitude( sum )
		      maxMagnitude = max( maxMagnitude, thisMagnitude )
		    next
		  next
		  
		  return maxMagnitude
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExplodeRow(row() As String) As Boolean
		  var result as boolean
		  
		  var depth as integer = -1
		  var index as integer
		  
		  while index <= row.LastIndex
		    
		    var item as string = row( index )
		    
		    if item = "[" then
		      depth = depth + 1
		      index = index + 1
		      continue
		    end if
		    
		    if item = "]" then
		      depth = depth - 1
		      index = index + 1
		      continue
		    end if
		    
		    //
		    // Now we are at a value
		    //
		    if depth = 4 then
		      var leftCarry as integer = item.ToInteger
		      var rightCarry as integer = row( index + 1 ).ToInteger
		      
		      #if kIsDebug 
		        System.DebugLog "... Exploding " + leftCarry.ToString + "," + rightCarry.ToString
		      #endif
		      
		      if rightCarry <> 0 then
		        for inner as integer = ( index + 2 ) to row.LastIndex
		          var innerItem as string = row( inner )
		          select case innerItem
		          case "[", "]"
		            
		          case else
		            var val as integer = innerItem.ToInteger
		            var newVal as integer = val + rightCarry
		            
		            #if kIsDebug
		              System.DebugLog "... replacing right index  " + inner.ToString  + " " + val.ToString + "->" + newVal.ToString
		            #endif
		            
		            row( inner ) = newVal.ToString
		            exit for inner
		          end select
		        next
		      end if
		      
		      for inner as integer = ( index - 2 ) downto 0
		        select case row( inner )
		        case "[", "]"
		          
		        case else
		          var val as integer = row( inner ).ToInteger
		          var newVal as integer = val + leftCarry
		          
		          #if kIsDebug
		            System.DebugLog "... replacing left index  " + inner.ToString  + " " + _
		            val.ToString + "->" + newVal.ToString
		          #endif
		          
		          row( inner ) = newVal.ToString
		          exit for inner
		          
		        end select
		      next inner
		      
		      row.RemoveAt index + 2
		      row.RemoveAt index + 1
		      row.RemoveAt index
		      row( index - 1 ) = "0"
		      
		      depth = depth - 1
		      
		      result = true
		      
		    else
		      index = index + 1
		      
		    end if
		    
		  wend
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Magnitude(row() As String) As Integer
		  var index as integer = 1
		  return Magnitude_Recursive( row, index )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Magnitude_Recursive(row() As String, ByRef index As Integer) As Integer
		  var leftValue as integer
		  var rightValue as integer
		  
		  if index = 0 then
		    index = 1
		  end if
		  
		  var item as string = row( index )
		  
		  if item = "[" then
		    index = index + 1
		    leftValue = Magnitude_Recursive( row, index )
		  else
		    leftValue = item.ToInteger
		    index = index + 1
		  end if
		  
		  item = row( index )
		  
		  if item = "[" then
		    index = index + 1
		    rightValue = Magnitude_Recursive( row, index )
		    index = index + 1
		  else
		    rightValue = item.ToInteger
		    index = index + 2
		  end if
		  
		  return ( 3 * leftValue ) + ( 2 * rightValue )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As Variant()
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var rx as new RegEx
		  rx.SearchPattern = "\d+|\D"
		  
		  var result() as variant
		  for each row as string in rows
		    var rowArr() as string
		    var match as RegExMatch = rx.Search( row )
		    while match isa object
		      var matchString as string = match.SubExpressionString( 0 )
		      if matchString <> "," then
		        rowArr.Add matchString
		      end if
		      
		      match = rx.Search
		    wend
		    
		    result.Add rowArr
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Reduce(row() As String)
		  
		  do
		    #if kIsDebug
		      System.DebugLog "Reducing: " + RowToString( row )
		    #endif
		  loop until ExplodeRow( row ) = false and SplitRow( row ) =  false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowToString(row() As String) As String
		  var index as integer
		  var builder() as string
		  
		  var item as string
		  var nextItem as string = row( 0 )
		  
		  while index <= row.LastIndex
		    item = nextItem
		    if index = row.LastIndex then
		      nextItem = ""
		    else
		      nextItem = row( index + 1 )
		    end if
		    
		    select case item
		    case "["
		      builder.Add "["
		      index = index + 1
		      
		    case "]"
		      builder.Add "]"
		      index = index + 1
		      if nextItem <> "]" and nextItem <> "" then
		        builder.Add ","
		      end if
		      
		    case else
		      builder.Add item
		      index = index + 1
		      if nextItem <> "]" and nextItem <> "" then
		        builder.Add ","
		      end if
		    end select
		    
		  wend
		  
		  return String.FromArray( builder, "" )
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SplitRow(row() As String) As Boolean
		  var index as integer = 0
		  
		  while index <= row.LastIndex
		    var item as string = row( index )
		    
		    select case item
		    case "[", "]"
		      
		    case else
		      var val as integer = item.ToInteger
		      if val >= 10 then
		        var rightVal as integer = ( val + 1 ) \ 2
		        var leftVal as integer = val - rightVal
		        
		        #if kIsDebug
		          System.DebugLog "... Splitting " + val.ToString + _
		          " to [" + leftVal.ToString + "," + rightVal.ToString + "]"
		        #endif
		        
		        row( index ) = "["
		        row.AddAt index + 1, "]"
		        row.AddAt index + 1, rightVal.ToString
		        row.AddAt index + 1, leftVal.ToString
		        
		        return true 
		      end if
		      
		    end select
		    
		    index = index + 1
		  wend
		  
		  return false
		End Function
	#tag EndMethod


	#tag Constant, Name = kIsDebug, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"[[[0\x2C[5\x2C8]]\x2C[[1\x2C7]\x2C[9\x2C6]]]\x2C[[4\x2C[1\x2C2]]\x2C[[1\x2C4]\x2C2]]]\n[[[5\x2C[2\x2C8]]\x2C4]\x2C[5\x2C[[9\x2C9]\x2C0]]]\n[6\x2C[[[6\x2C2]\x2C[5\x2C6]]\x2C[[7\x2C6]\x2C[4\x2C7]]]]\n[[[6\x2C[0\x2C7]]\x2C[0\x2C9]]\x2C[4\x2C[9\x2C[9\x2C0]]]]\n[[[7\x2C[6\x2C4]]\x2C[3\x2C[1\x2C3]]]\x2C[[[5\x2C5]\x2C1]\x2C9]]\n[[6\x2C[[7\x2C3]\x2C[3\x2C2]]]\x2C[[[3\x2C8]\x2C[5\x2C7]]\x2C4]]\n[[[[5\x2C4]\x2C[7\x2C7]]\x2C8]\x2C[[8\x2C3]\x2C8]]\n[[9\x2C3]\x2C[[9\x2C9]\x2C[6\x2C[4\x2C9]]]]\n[[2\x2C[[7\x2C7]\x2C7]]\x2C[[5\x2C8]\x2C[[9\x2C3]\x2C[0\x2C2]]]]\n[[[[5\x2C2]\x2C5]\x2C[8\x2C[3\x2C7]]]\x2C[[5\x2C[7\x2C5]]\x2C[4\x2C4]]]", Scope = Private
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
