#tag Class
Protected Class Advent_2016_12_07
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Identify good packets based on ABBA or ABA"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Internet Protocol Version 7"
		  
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
		  var rxAbba as new RegEx
		  rxAbba.SearchPattern = "(?mi-Us)(?!([a-z])\g1)([a-z])([a-z])\g3\g2"
		  
		  var rxBracket as new RegEx
		  rxBracket.SearchPattern = "\[[^\]]+\]"
		  
		  var rxNotBracket as new RegEx
		  rxNotBracket.SearchPattern = "\[[^\]]+\](*SKIP)(*FAIL)|[a-z]+"
		  
		  var count as integer
		  
		  var rows() as string = Normalize( input ).Split( EndOfLine )
		  
		  for each row as string in rows
		    var match as RegExMatch = rxBracket.Search( row )
		    if match is nil then
		      continue for row
		    end if
		    
		    while match isa object
		      var s as string = match.SubExpressionString( 0 )
		      if rxAbba.Search( s ) isa object then
		        continue for row
		      end if
		      
		      match = rxBracket.Search
		    wend
		    
		    match = rxNotBracket.Search( row )
		    if match is nil then
		      continue for row
		    end if
		    
		    var foundOne as boolean
		    
		    while match isa object
		      var s as string = match.SubExpressionString( 0 )
		      if rxAbba.Search( s ) isa object then
		        foundOne = true
		        exit while
		      end if
		      
		      match = rxNotBracket.Search
		    wend
		    
		    if foundOne then
		      count = count + 1
		    end if
		  next
		  
		  return count : if( IsTest, 2, 118 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var rows() as string = Normalize( input ).Split( EndOfLine )
		  
		  var count as integer
		  
		  for each row as string in rows
		    var chars() as string = row.Split( "" )
		    var lastIndex as integer = chars.LastIndex - 2
		    
		    var abas() as string
		    
		    var inBracket as boolean
		    
		    for i as integer = 0 to lastIndex
		      var thisChar as string = chars( i )
		      
		      select case thisChar
		      case "["
		        inBracket = true
		      case "]"
		        inBracket = false
		      case else
		        if inBracket then
		          continue for i
		        else
		          var nextChar as string = chars( i + 1 )
		          if nextChar = thisChar or nextChar = "[" then
		            continue for i
		          end if
		          
		          var thirdChar as string = chars( i + 2 )
		          if thirdChar <> thisChar then
		            continue for i
		          end if
		          
		          var aba as string = thisChar + nextChar
		          
		          if abas.IndexOf( aba ) = -1 then
		            var bab as string = nextChar + thisChar + nextChar
		            var babPattern as string = "\[[a-z]*" + bab
		            
		            var rx as new RegEx
		            rx.SearchPattern = babPattern
		            
		            if rx.Search( row ) isa object then
		              count = count + 1
		              continue for row
		            end if
		            
		            abas.Add aba
		          end if
		        end if
		      end select
		    next
		  next
		  
		  return count : if( IsTest, 3, 260 )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"abba[mnop]qrst\nabcd[bddb]xyyx\naaaa[qwer]tyui\nioxxoj[asdfgh]zxcvbn\n", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"aba[bab]xyz\nxyx[xyx]xyx\naaa[kek]eke\nzazbz[bzb]cdb", Scope = Private
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
