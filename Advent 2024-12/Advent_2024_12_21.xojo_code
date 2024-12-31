#tag Class
Protected Class Advent_2024_12_21
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Unknown"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return false
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return ""
		  
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
		  var result as integer = Solve( input, 3 )
		  
		  return result : if( IsTest, 126384, 205160 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var result as integer = Solve( input, 8 )
		  
		  return 0 : if( IsTest, 0, 0 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DirectionalLayout() As Dictionary
		  var directional as Dictionary
		  
		  if directional is nil then
		    directional = new Dictionary
		    
		    directional.Value( kGapKey ) = new Xojo.Point( 0, 0 )
		    directional.Value( "^" )     = new Xojo.Point( 1, 0 )
		    directional.Value( "A" )     = new Xojo.Point( 2, 0 )
		    
		    directional.Value( "<" )     = new Xojo.Point( 0, 1 )
		    directional.Value( "v" )     = new Xojo.Point( 1, 1 )
		    directional.Value( ">" )     = new Xojo.Point( 2, 1 )
		  end if
		  
		  return directional
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function GetSequence(codeString As String, layout As Dictionary) As String
		  var rx as new RegEx
		  rx.SearchPattern = "^([^<A]+)(<+)+"
		  rx.ReplacementPattern = "$2$1"
		  rx.Options.ReplaceAllMatches = true
		  
		  var code() as string = codeString.Split( "" )
		  
		  var gap as Xojo.Point = layout.Value( kGapKey )
		  
		  var current as Xojo.Point = layout.Value( "A" )
		  
		  var x as integer = current.X
		  var y as integer = current.Y
		  
		  var seq() as string
		  
		  for each char as string in code
		    var target as Xojo.Point = layout.Value( char )
		    
		    while x <> target.X or y <> target.Y
		      if x = target.X then
		        MoveUpDown x, y, target, seq, gap
		        
		      elseif y = target.Y then
		        MoveLeftRight x, y, target, seq, gap
		        
		      elseif x = gap.X and target.Y = gap.Y then
		        MoveLeftRight x, y, target, seq, gap
		        MoveUpDown    x, y, target, seq, gap
		        
		      elseif y = gap.Y and target.X = gap.X then
		        MoveUpDown    x, y, target, seq, gap
		        MoveLeftRight x, y, target, seq, gap
		        
		      else
		        var tempSeq() as string
		        
		        MoveUpDown    x, y, target, tempSeq, gap
		        MoveLeftRight x, y, target, tempSeq, gap
		        
		        var temp as string = String.FromArray( tempSeq, "" )
		        temp = rx.Replace( temp )
		        
		        tempSeq = temp.Split( "" )
		        
		        for each tempChar as string in tempSeq
		          seq.Add tempChar
		        next
		      end if
		    wend
		    
		    seq.Add "A"
		  next
		  
		  var result as string = String.FromArray( seq, "" )
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function IsGap(x As Integer, y As Integer, gap As Xojo.Point) As Boolean
		  return gap.X = x and gap.Y = y
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function KeypadLayout() As Dictionary
		  static keypad as Dictionary
		  
		  if keypad is nil then
		    keypad = new Dictionary
		    
		    var key as integer = 9
		    
		    for y as integer = 0 to 2
		      for x as integer = 2 downto 0
		        keypad.Value( key.ToString ) = new Xojo.Point( x, y )
		        key = key - 1
		      next
		    next
		    
		    keypad.Value( "0" )      = new Xojo.Point( 1, 3 )
		    keypad.Value( "A" )      = new Xojo.Point( 2, 3 )
		    keypad.Value( kGapKey )  = new Xojo.Point( 0, 3 )
		  end if
		  
		  return keypad
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub MoveLeftRight(ByRef x As Integer, y As Integer, target As Xojo.Point, seq() As String, gap As Xojo.Point)
		  while x < target.X and not IsGap( x + 1, y, gap )
		    seq.Add ">"
		    x = x + 1
		  wend
		  
		  while x > target.X and not IsGap( x - 1, y, gap )
		    seq.Add "<"
		    x = x - 1
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub MoveUpDown(x As Integer, ByRef y As Integer, target As Xojo.Point, seq() As String, gap As Xojo.Point)
		  while y < target.Y and not IsGap( x, y + 1, gap )
		    seq.Add "v"
		    y = y + 1
		  wend
		  
		  while y > target.Y and not IsGap( x, y - 1, gap )
		    seq.Add "^"
		    y = y - 1
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Numbers(s As String) As Integer
		  var rx as new RegEx
		  rx.SearchPattern = "\d+"
		  var match as RegExMatch = rx.Search( s )
		  return match.SubExpressionString( 0 ).ToInteger
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Solve(input As String, count As Integer) As Integer
		  'IF NOT IsTest THEN RETURN 0
		  
		  var codes() as string = Normalize( input ).Split( EndOfLine )
		  
		  var result as integer
		  
		  var keypadLayoutDict as Dictionary = keypadLayout()
		  var directionalLayoutDict as Dictionary = directionalLayout()
		  
		  for each code as string in codes
		    var newCode as string = code
		    
		    newCode = GetSequence( newCode, keypadLayoutDict )
		    Print code + "(1): " + newCode
		    
		    for thisCount as integer = 2 to count
		      newCode = GetSequence( newCode, directionalLayoutDict )
		      Print code + "(" + thisCount.ToString + "): " + newCode
		    next 
		    
		    var nums as integer = Numbers( code )
		    var complexity as integer = newCode.Length * nums
		    
		    'Print code + ": count=" + newcode.Length.ToString + ", nums=" + nums.ToString + ", complexity=" + complexity.ToString
		    Print ""
		    
		    result = result + complexity
		  next
		  
		  return result 
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kGapKey, Type = String, Dynamic = False, Default = \"*", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"029A\n980A\n179A\n456A\n379A", Scope = Private
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
