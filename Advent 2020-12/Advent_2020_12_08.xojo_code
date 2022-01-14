#tag Class
Protected Class Advent_2020_12_08
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( Normalize( kInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( Normalize( kInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  return CalculateResultB( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var rows() as string = ToStringArray( input )
		  
		  if rows.Count = 0 then
		    return -1
		  end if
		  
		  var accumulator as integer
		  call Execute( rows, accumulator )
		  return accumulator
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as string = ToStringArray( input )
		  
		  if rows.Count = 0 then
		    return -1
		  end if
		  
		  var changeRow as integer = -1
		  
		  while changeRow < rows.LastIndex
		    changeRow = changeRow + 1
		    
		    var thisRow as string = rows( changeRow )
		    
		    var parts() as string = thisRow.Split( " " )
		    var instruction as string = parts( 0 )
		    
		    if instruction = "acc" then
		      continue
		    end if
		    
		    var value as string = parts( 1 )
		    var newRow as string = thisRow
		    
		    select case instruction
		    case "jmp"
		      newRow = "nop 0" // Value is irrelevant
		      
		    case "nop"
		      newRow = "jmp " + value
		    end select
		    
		    rows( changeRow ) = newRow
		    
		    var accumulator as integer
		    if Execute( rows, accumulator ) then
		      return accumulator
		    end if
		    
		    rows( changeRow ) = thisRow
		  wend
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Execute(rows() As String, ByRef accumulator As Integer) As Boolean
		  var row as integer
		  var stack as new Dictionary
		  var isFinished as boolean = true
		  
		  do
		    if stack.HasKey( row ) then
		      isFinished = false
		      exit
		    end if
		    stack.Value( row ) = nil
		    
		    var parts() as string = rows( row ).Split( " " )
		    var instruction as string = parts( 0 )
		    var value as integer = parts( 1 ).ToInteger
		    
		    select case instruction
		    case "nop"
		      row = row + 1
		      
		    case "acc"
		      accumulator = accumulator + value
		      row = row + 1
		      
		    case "jmp"
		      row = row + value
		      
		    end select
		    
		  loop until row > rows.LastIndex
		  
		  return isFinished
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"acc -9\njmp +1\nacc +3\nacc +32\njmp +118\nacc +8\nnop +405\njmp +179\nacc +43\nacc +24\nacc +11\njmp +545\nacc +26\nacc -6\nacc +24\njmp +560\nacc +39\nacc +42\njmp +1\njmp +457\nacc +36\nacc +7\njmp +190\nacc -12\nacc -10\nacc +30\njmp +110\nacc +20\nacc +22\nacc +20\njmp +513\nacc +7\njmp +110\nacc +35\nacc +4\njmp +51\nacc +42\nacc +23\njmp +158\nacc +7\njmp +156\nacc -15\nacc -7\nacc +27\njmp +30\njmp +141\nacc +33\njmp +12\nacc +5\nacc +4\nnop +49\njmp +296\nacc +46\nnop +358\nacc -3\njmp +276\nacc -1\nacc +22\njmp +220\nnop +178\nacc +34\njmp +363\njmp +4\nacc +2\njmp +173\njmp +484\nacc +26\nacc +2\nacc -10\njmp +58\nnop +137\nacc -17\nacc +15\njmp -14\nacc +27\njmp +512\njmp +415\njmp +489\njmp -12\nacc +34\nacc +31\njmp +438\nacc +4\nacc +31\nacc +47\njmp +302\nnop +446\nacc -8\nacc +42\njmp +305\nnop +504\njmp +89\nacc +25\nacc -2\nnop +279\nacc +5\njmp +19\nacc +38\njmp +121\njmp +87\nacc +26\nacc -18\nacc -18\nacc +34\njmp +500\nacc +0\nacc -1\nacc +38\njmp +1\njmp -46\nacc +39\nacc -14\nacc +48\nacc +19\njmp +480\nacc -3\nacc -7\nnop +316\njmp +1\njmp +406\nacc -3\njmp -44\nacc +21\nacc -5\nacc -3\njmp +447\njmp +478\njmp +53\nacc -2\nnop +202\njmp +264\nacc -17\nacc +16\njmp +405\nacc +28\njmp +393\njmp +320\nacc +35\nacc +38\nacc -19\nacc +11\njmp +86\nacc -8\njmp -97\njmp +350\njmp +35\nnop +448\nacc +7\nacc -6\nacc +6\njmp +444\nacc +11\nacc +42\nacc -15\nacc +44\njmp +145\nacc +1\njmp +46\nacc -6\nacc +1\nnop +183\nacc +20\njmp +413\nacc +42\nacc -9\njmp +391\njmp +197\nacc +27\nacc +7\njmp +68\nacc -11\njmp -140\nacc +11\njmp +238\nacc -11\nacc +33\nacc +41\njmp +391\nacc +2\njmp +389\njmp -134\nacc +2\nacc +29\njmp +1\nacc +34\njmp +358\nacc +39\nacc +2\nacc -12\nacc +16\njmp +97\nacc +25\njmp +412\nacc +42\njmp +129\njmp -21\nacc +39\nacc -9\njmp +130\nacc +21\njmp +1\nacc +5\njmp -97\nacc -16\njmp -188\nacc +15\njmp +72\njmp -76\nacc -2\nacc +33\nacc +13\njmp -175\njmp +250\nacc +4\nacc +25\njmp -163\njmp +184\nacc -17\njmp -195\nacc +20\nacc +45\njmp -18\nacc +28\nacc +48\nacc +43\nnop +53\njmp -111\nnop +51\nacc -15\nacc -16\nacc +46\njmp +150\nnop +121\nacc +46\nacc +11\nnop -65\njmp -62\nacc +37\nacc -7\nacc -16\njmp +19\njmp +1\njmp +187\nacc +6\nacc -2\njmp +217\nnop +32\nnop +186\nacc +5\njmp -134\nacc -3\nacc +49\nacc +19\njmp -34\nnop -127\nacc +0\nacc -4\nacc +43\njmp +253\nacc -18\nnop -183\nacc +6\nacc +32\njmp +76\nnop -37\nacc +0\nnop +65\nacc +12\njmp +275\njmp +263\nacc +22\nacc +38\njmp +59\nacc -10\nacc +14\nacc -7\njmp +141\njmp +156\nacc +3\nacc +20\nacc -11\njmp -74\nacc -1\nacc +0\nacc +35\nacc +48\njmp +57\nacc -16\nacc +27\njmp +1\nacc -2\njmp +82\nacc +34\nacc +5\nacc +12\nnop +233\njmp +32\njmp +79\nacc +27\njmp -30\njmp +1\nnop +210\nacc -18\njmp +84\njmp +221\nnop -297\nacc +35\njmp +1\njmp +304\njmp +266\nacc +26\nacc +2\nacc +16\nacc +14\njmp -148\nnop -193\nacc -9\njmp -181\njmp -282\nacc +16\njmp +1\nacc +18\njmp +102\nacc -17\nnop +70\njmp -109\nnop -83\njmp +4\njmp +128\nacc +34\njmp +172\nacc +47\nacc +7\njmp -121\nnop -107\nacc -6\nacc -12\nnop -206\njmp +187\nacc +35\nacc +44\njmp -68\njmp +87\njmp -185\nacc -6\nacc +50\njmp -3\nacc +40\njmp -79\nacc +14\nnop -50\nacc -5\njmp -286\nacc +39\njmp +44\nacc +3\nacc +40\nacc -17\nacc +41\njmp -318\njmp +131\njmp +1\njmp -220\nacc +22\nacc +11\nacc +35\nacc +48\njmp -7\nacc +34\nacc -10\nacc +45\nnop +233\njmp -202\nacc +38\njmp -27\njmp +193\nnop -345\nacc +0\njmp -109\nacc +24\njmp -357\nacc +15\njmp -72\nacc -15\nnop +10\nnop -126\njmp -309\nacc +2\njmp -35\nacc +7\nacc +31\njmp +1\nnop -313\njmp +145\nacc -19\nnop +209\njmp +98\njmp -282\njmp -80\njmp -203\njmp +41\nacc +33\nacc -1\njmp +108\nacc +15\njmp -306\nacc +9\nacc +8\nacc +28\nacc -3\njmp -324\nacc -10\njmp -242\nacc -11\nacc +14\nacc +35\njmp -85\nacc -7\nacc +24\nacc +38\njmp -341\nacc +21\nacc -15\njmp -92\nacc +18\nacc -14\njmp -148\nnop -341\njmp +166\njmp +82\nacc -13\nacc +36\njmp +100\nacc +18\nacc +40\nacc +1\njmp -384\nacc +26\nnop +87\nacc +28\njmp -298\nacc +35\nnop -132\nacc +19\nacc +24\njmp +57\nacc -4\nacc +17\nacc -7\njmp +83\nacc +36\njmp -208\nnop -429\nacc +0\nacc +19\njmp -432\nacc +24\nacc -19\nnop -406\njmp -209\nacc +19\njmp -98\nacc +33\nacc +30\nnop -328\njmp -238\nacc +41\nacc +9\nacc -14\nacc -11\njmp -139\njmp +145\nacc +18\nnop +102\nacc +38\njmp -132\nacc -3\nacc +6\njmp -386\nacc +7\nacc +3\nacc +6\njmp -430\nacc +32\nacc +28\nacc +40\nacc +0\njmp -83\nacc +0\njmp +1\njmp -283\nacc +11\njmp -299\njmp -224\nnop +34\nacc +21\nnop -34\nacc -10\njmp +27\nacc -7\nacc +8\njmp +67\nnop -436\nacc -15\nacc +3\njmp -22\nacc -12\nnop -421\nacc -13\nacc -18\njmp -388\nacc +30\nacc +13\njmp -408\nacc -3\nacc -9\nacc +34\nacc +0\njmp -137\nacc +4\nacc +22\nacc +7\nacc +48\njmp +61\njmp +70\njmp -484\nacc +19\njmp -382\nacc +45\njmp +75\nacc +34\njmp -144\njmp -381\njmp +1\nacc +48\nacc +48\nacc +0\njmp -108\nacc +0\njmp +1\njmp -477\nacc +48\njmp +62\nacc +1\njmp +1\njmp +49\nacc -13\nacc +20\njmp -406\nacc +48\nacc +3\nacc -9\nacc +32\njmp -124\nacc -16\njmp -131\nacc +27\nacc -4\nacc +36\nacc -12\njmp -255\nacc +0\njmp +1\nacc +8\nacc +41\njmp -407\njmp -543\njmp -73\nnop +4\nacc -6\njmp -504\njmp -28\nnop -450\njmp -226\njmp -274\nacc +1\njmp -568\nacc +29\njmp -570\njmp +1\njmp -494\nacc +29\nacc -12\njmp -127\nacc +32\njmp -135\njmp -383\nnop -59\nacc -19\nacc +2\nacc +26\njmp -446\nacc +47\njmp +1\nacc -18\nacc -10\nacc +32\nnop -423\njmp -476\nacc +39\nacc +27\nacc -9\nacc +28\njmp -325\nacc +37\nacc +28\nnop -81\njmp -310\nacc -2\nacc +8\nacc +28\njmp -43\njmp -141\nacc +5\nnop -2\njmp -457\nacc +25\nacc +13\nacc +0\njmp +1\njmp +1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"nop +0\nacc +1\njmp +4\nacc +3\njmp -3\nacc -99\nacc +1\njmp -4\nacc +6", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
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
