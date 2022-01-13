#tag Class
Protected Class Advent_2021_12_04
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( kInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( kInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var set as Bingo.Set = GetSet( input )
		  var calls() as integer = GetCalls( input )
		  
		  var winner as Bingo.Board
		  var lastCall as integer
		  for each lastCall in calls
		    winner = set.CallValue( lastCall )
		    if winner isa object then
		      exit
		    end if
		  next
		  
		  if winner is nil then
		    return -999
		  end if
		  
		  var sumUmarked as integer = winner.SumUnmarked
		  var result as integer = sumUmarked * lastCall
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var set as Bingo.Set = GetSet( input )
		  var calls() as integer = GetCalls( input )
		  
		  var winCount as integer
		  
		  var winningResult as integer
		  
		  var lastCall as integer
		  for each lastCall in calls
		    if winCount = 68 then
		      winCount = winCount
		    end if
		    
		    var winner as Bingo.Board = set.CallValue( lastCall )
		    if winner isa object then
		      winCount = winCount + 1
		      winningResult = lastCall * winner.SumUnmarked
		      
		      if winCount = set.Boards.Count then
		        exit
		      end if
		    end if
		  next
		  
		  return winningResult
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCalls(input As String) As Integer()
		  var lines() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  var firstLine as string = lines( 0 )
		  var callStrings() as string = firstLine.Split( "," )
		  
		  var calls() as integer
		  for each callString as string in callStrings
		    calls.Add callString.ToInteger
		  next
		  
		  return calls
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetSet(input As String) As Bingo.Set
		  static rx as RegEx
		  
		  if rx is nil then
		    rx = new RegEx
		    rx.SearchPattern = "(?mi-Us)(^( *\d+){5}(\R|\z)){5}"
		  end if
		  
		  var set as new Bingo.Set
		  
		  var match as RegExMatch = rx.Search( input )
		  while match isa RegExMatch
		    set.AddBoard match.SubExpressionString( 0 )
		    match = rx.Search
		  wend
		  
		  return set
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"46\x2C79\x2C77\x2C45\x2C57\x2C34\x2C44\x2C13\x2C32\x2C88\x2C86\x2C82\x2C91\x2C97\x2C89\x2C1\x2C48\x2C31\x2C18\x2C10\x2C55\x2C74\x2C24\x2C11\x2C80\x2C78\x2C28\x2C37\x2C47\x2C17\x2C21\x2C61\x2C26\x2C85\x2C99\x2C96\x2C23\x2C70\x2C3\x2C54\x2C5\x2C41\x2C50\x2C63\x2C14\x2C64\x2C42\x2C36\x2C95\x2C52\x2C76\x2C68\x2C29\x2C9\x2C98\x2C35\x2C84\x2C83\x2C71\x2C49\x2C73\x2C58\x2C56\x2C66\x2C92\x2C30\x2C51\x2C20\x2C81\x2C69\x2C65\x2C15\x2C6\x2C16\x2C39\x2C43\x2C67\x2C7\x2C59\x2C40\x2C60\x2C4\x2C90\x2C72\x2C22\x2C0\x2C93\x2C94\x2C38\x2C53\x2C87\x2C27\x2C12\x2C2\x2C25\x2C19\x2C8\x2C62\x2C33\x2C75\n\n84 94 24 52 44\n96 33 74 35 13\n60 51 41 19 95\n50 93 27 40  1\n67 23 37 88 85\n\n12 85  6 97 77\n79 28 24 70 51\n71 72 78 55 73\n11 36  5 98 19\n30 67 89 95 62\n\n54 38 70 29 51\n16 19 80 96 63\n76 23 10 30 24\n45 81 97 82 90\n60 94 28 11 83\n\n50 56 42 68 48\n 6 70 78 22 27\n75 11 63 24 47\n29 99 91 73 97\n 7 16 28 12 44\n\n20 62 50 36 12\n 3 10 40  8 56\n78 61 66 37 89\n72 26 19 65 22\n30 91 27  5 63\n\n75 91 84  0 96\n 1 58 83 81 20\n36  8 82 66 77\n59 15 71 80 56\n17 45 46 26 73\n\n33 71 28 10 80\n90  0 92 30 74\n66 46 43 88 75\n11 36 42 67 22\n37 79 69 17 94\n\n46 66  4 20 77\n59 34 23 30 52\n85 65 61 33 40\n19 48 82 68 37\n88 11 12 43 75\n\n 4 53 32 29  3\n 0  6 17  5 76\n13 67 92  2 24\n64 57 80 42 30\n18 85 21 65 44\n\n90 98 50  8 89\n40  9 42 62 61\n60 86 48 31 32\n15 96 88 95  1\n93 68 72 74 73\n\n75 90 96 59 95\n84 38 26 70 73\n23 11 63 29 48\n28  1  4 80 55\n15 14 67 12 61\n\n 1 93 54 63 56\n61 19 20  8 95\n 3 73 22 60 36\n91 27 37 38 99\n83 64 74 87 28\n\n13 89 95 72 37\n10 81 47 52 88\n56 78 50 42 73\n38  0  5 43 55\n77 69 74 28 94\n\n 7 59 76 36 43\n48 82 57  4 83\n22 62  1 16 11\n37 27 54 34 87\n95 89 85  3 44\n\n76  6 53 52 89\n31 18 81 23 25\n77 79 20 66  7\n72 19 73 91 57\n17 33 63 92 88\n\n52 51  1 19  7\n36 46 73 37  6\n87 77  2 56 57\n 8 18 40 23 71\n50 58  5 65 31\n\n45 86 87 12 75\n95 20 93 72 50\n90  1 55 13 66\n14  3 70 97 54\n32 26 60 11 62\n\n20 25  0 82 83\n 3 14 61 34 46\n85 58 65 76 26\n47 15 86 81 88\n49 90 16 42 70\n\n87 85 68 17 57\n69 40 99 71 24\n12 55 86 95 64\n42  2  1 72  3\n80  7 18 94 31\n\n27 41 21 89 46\n57  3 18 98  4\n 5 60 62 54 14\n31 26 81 53 71\n91 13 43 12 15\n\n66 82  9 23  8\n52 64 79 99 29\n21  7 39 74 70\n50  0 89 26  5\n 1 83 62  6 93\n\n64 85 74 73 11\n 1 57  0 97 93\n95  7 17 45 47\n52  5 28 81 34\n18  8 80 29 54\n\n 0 10 92 70 88\n30 14 77 24 33\n56  6 75 40 48\n17 34 65 79 68\n51 67 71 64  8\n\n36 10 94 91 34\n 8 23  6 79 40\n 4 44 15  0 67\n90 97 12 26 30\n57 93 22 99 27\n\n22 90 32 83 40\n84 67 69  4 49\n39 42 16 29 71\n47 77 15 13 78\n19 92 43 62 35\n\n50  7 86  9 33\n93 73 51 26 46\n91 84 67 29 56\n69 54 74 19 35\n 2 43 63 53 78\n\n85 51  4 17 90\n21 67 24 40 99\n10 83 84 11 48\n 8 56 87  2  6\n 7 30 74 35 43\n\n11 67 27 60 39\n43 40 94  1 50\n15 42 75 24 21\n87 68 29 41 84\n86 16 63 74  2\n\n84 64  7 11 50\n54 70 40 60 86\n67 66 58 18 98\n85 32 91 90 75\n81 97 74 94 28\n\n56 93 51 46 89\n29 14 53 17 64\n 9 94 82 79 62\n81 84 58 78 90\n95 67 37 30 44\n\n91 17 88 54 41\n 5 22 37 15 63\n36 89 34 48 49\n11 27 83 40 80\n 8  7 26 69 33\n\n77 57 52 75 18\n 8 33 48  9 97\n99 80 10 31 28\n64 14 49 68 72\n26 66 35 36 45\n\n81 22 65 55 39\n32 97 18  4 23\n61 91 60 33 40\n 3 54 48  2 68\n24 62 67 53 77\n\n86 87 78 73 75\n 0  2 54 95 63\n99 83 12 68 27\n13 90 44 77 88\n79 47 72 84  4\n\n30 48 23 81 93\n36 89 79 75 43\n54 55 29 74 92\n71 32 51 52 62\n13 72  6 63 65\n\n44 78  4 57 37\n15 24 88 30 89\n34 35 69 16 91\n36 12 98 55 51\n31 27 49 46 48\n\n60 32 24 98 58\n63 14 91  4  1\n74 69 56 65 40\n36 77 79 28 43\n95 31 12 88 55\n\n22 36 33  3 46\n64 79 25 38 10\n 1  5 99 48 82\n35 96 21 50  7\n15 88 58 27 66\n\n87 62 22 41 79\n57  0 82 18 48\n17 73 83 46 60\n14 97  7 28 31\n90 94 16 58 66\n\n21 56 79  8 54\n35 58 25 12 22\n27 75  7 93 86\n 3 99  9 59 32\n45 40 64 60 68\n\n96 26 19 49 28\n 7 58 72 14 12\n55 80  1 35 71\n29 41 63 74 65\n69 46 75 82 73\n\n57 71 64 13 56\n31 77 95 40 66\n80  9  7 88 49\n73 47 82 46 75\n23 15  1 36  2\n\n62 23 58  0 75\n14 96 60 85 59\n49 43 80 64 29\n 5 44 24 30 54\n78 90 98 97 38\n\n86 40 56 32 41\n27 19 69 30 77\n48 31  4 26 58\n55 78 94 34 99\n72 65 92 37 71\n\n16 23 61 65 34\n62 88 52 10 29\n11 77 67  2 90\n44 30 82 32 13\n26 53 56 93  9\n\n60  6 79 29 12\n28 68 21 71 97\n 3 24 34 63 95\n13 52 74 18 91\n14 64 57 94 20\n\n98 84 40 24 45\n69 81  1 85 49\n91 29 78  7 35\n 5 20 27 93 61\n47 95 43 39 17\n\n49 35 97 41 26\n10 51 36 94 14\n65 83 82 27 55\n24 88 29 13 95\n56 57 38 16 21\n\n98  3 62 58 45\n67 17 81 93 19\n86 42 10 99 51\n 8 57 55 63 92\n25 50 76 18  4\n\n39 99 67 56 30\n41  1  7 68 70\n37 75 29 62 50\n61 55 16 52 15\n84  0 73 31 33\n\n19  3 87 72 90\n57 43 35  8 15\n51 10  4 42 56\n86 62 25 29 83\n97 49 28 70 59\n\n 8 13 31 38 59\n86 94 55 10  1\n81 18 45 48 32\n43 25 37 49 67\n22 95 11 82 44\n\n12 87 40 76  5\n18 43 69 98 27\n30  4 63 20 89\n 7 97  0  9 54\n39 45 25 53 52\n\n14 32 62 54 56\n57 66 19 99 51\n65 41 90 94 11\n36 10 87 83 73\n84 82 50 95 29\n\n 2 92 14  4 11\n 9 63 81 20 46\n26 39 70 15  7\n18 85 68 79 84\n74 32 57 12 28\n\n70 59 90 17 15\n33 16  3 41 26\n 8 49 73 95 76\n93 13 94 55 91\n20 54 30 74 52\n\n95  8 54 84 34\n33 24 68 14 64\n88 42 27 10 20\n70 40 52  6 32\n99  9  1 72 73\n\n81 63 67 98 79\n42 14 48 74  4\n10 51  8 13 56\n90 61  3 18 23\n33 58 43 75 41\n\n93 42 68 44 53\n26  1 21 22 64\n56 32 30  9 35\n63 91 29 40 47\n99 57 11 96 15\n\n43 29 69 68 65\n23 16 15 86  6\n50 56 78  9 21\n73 82 36  7 22\n 8 18 37 58 95\n\n19 85 36 73 71\n65 62 14 52  3\n30 83 44 41  5\n55 15  0 61 95\n28 13 32 31 88\n\n48 92 33 50  7\n11 47 46 35 76\n36 37 54  2 89\n23 63 52 69  9\n56 20 67 14 43\n\n38 28 47 70 57\n 4 85 46 97 34\n14 94  2 35 72\n27 58 63 68 39\n 6 92 54 91 96\n\n28 96 60 89 37\n83 77 57  5 27\n71 67 99 91 29\n88 10 41 19 50\n76  9 20 14 98\n\n52 43 80 33  1\n68 83 59 37 87\n10 85 24 90 58\n48 79 69 27 42\n76 61 86 23  7\n\n72 49 51 12 43\n73 56 83  4 27\n48 94 38 18 32\n14 96 36  8 13\n87 60  5 77 42\n\n41 36 16 28  2\n94 15 97 70 48\n32 39 80 95 69\n31 75 21  8 19\n79 65 50 14 67\n\n76 67 16 49 87\n 3 22 11 82 65\n73 15 78 13 52\n19 17 64  9 56\n60 77 24 91 38\n\n11 56 41  8 86\n53 38 69 62 67\n32  6 35 24 66\n57 84 83 49  2\n82 88 10 28 47\n\n13 60 28 34 76\n57 54 59 48 99\n19 85 53 22 45\n 9 69 55 32 64\n70 15  5 71 33\n\n91 63  9  8 85\n37 46 23 60 24\n59 50 87 43  3\n57 47 51 98 25\n53 86  4 42 52\n\n19 82 11 14 89\n 4 78 92 43  5\n96 61 67 47 69\n50 45 49 86 44\n27 88 32 98 59\n\n83  8 33 54 16\n30 95 23 86 27\n44 72  5 43  2\n76 26 28 63 81\n24 37 45 90 73\n\n16 48  9 62 61\n50 45 92 59  4\n56 86 98  3 44\n76 43 97 40 11\n38 58 67 20 74\n\n14 75 39 44 42\n47 80 99 57 77\n 1 48 24 85 79\n68 38 25 28 49\n17 20 11 36 67\n\n67 59 32 19 53\n45 26  0 35 91\n85 80 89 51 25\n 7 95 11 78 73\n50  5  1 88 62\n\n38 91 25 80 14\n26 96 82 52 67\n 8 53 92 77 34\n49 76 50 35 42\n66 17 85 75 16\n\n36 63 78 73 26\n51 28 74 57 54\n21 27 14  2 67\n19 69 16 40 41\n95 45 38 70  8\n\n12 23 17 46 91\n75 88 58 25  9\n65 64 62 49 33\n27 59 63 21 73\n56 31 87 81  0\n\n14 82 79 46 51\n32 77 11  1 99\n 0 29 15 25 64\n44 16 35 60 95\n41 54 72 61 87\n\n58  2 13 51  1\n29 97 98 71 36\n66 89 50 38 62\n87 42 79 75 76\n37  6 77 11 72\n\n97 98 88 90 73\n36 50 71 33 57\n44  9 37 54 25\n27 15 13 77 60\n21 24 72 68 85\n\n77 58 45 95 32\n38 79 84 56 90\n 1 70 24 88 12\n 7 91 98  9 18\n93 89 37 81 25\n\n53 34 44 59 46\n61 42 89 37 15\n23 30 43  3 55\n49  6 60 79 50\n77 10 92 36 17\n\n60 14 58 49 19\n 9 87 80 76  3\n81 62 66 38 50\n53 28 69 12 64\n98 83 72 34 85\n\n38 30 52 43 24\n75 29 57  4  3\n97 72 94 41 19\n80 90 39  9 20\n 6 91 10 44 67\n\n51 43 76 64 42\n16 56 46 82 99\n55 72 35 39 65\n66 86 93 23 34\n31 84  9 96 74\n\n64 68 14  2 97\n88 22 99 23 28\n 5 41 11 47 63\n81 17 10 27 89\n24 36  0 58 86\n\n20 34  1 89 36\n86 15 79 30 17\n96 31  4 50 16\n92 23 61 12 99\n60 65 91 13 76\n\n41 67 90 27 78\n85 48 40 57 19\n43 36 30 11 68\n16 91 76 74 81\n97 39 86 75 80\n\n94 92 54 14 60\n31 17 39 77 73\n11 12 52 49 40\n63 96 68 35 71\n98 75 37 65 44\n\n 3 97 59 72 85\n14 55 96 87 28\n47 63 91 81 50\n68 79  9 35 37\n49 10  1 24 20\n\n42 66 54 29 95\n47 28 81 14 68\n37 15 22 58 13\n49 36 90 72  5\n74 71 88 34 70\n\n34 65 39  6 86\n80 43  8 14 27\n72 45  0 25 23\n50  2 13 41 26\n64 18  9 69 35\n\n36 43  4  3 90\n69 47 95 10 65\n 6 56 30 13 22\n55 50 63 99 76\n54 92 51 96 23\n\n56  4 52 37 98\n84 49 95 33 85\n34 87 75 15 91\n14 68 13 24 97\n59 58 10 90 93\n\n26 63 36 68 39\n47 79 33 25  8\n91 52 11 59 93\n50 67 96 34  6\n20 54 41 89  3\n\n63 59 34 62 74\n84 76 88 54  8\n15 61 60  7 77\n22 55 18 80 37\n90  2 94 91 70\n\n23 12 16 11 50\n59 27 58 32 35\n92 42 75 19 70\n31 88 28 30 95\n17 72 80 39 91\n\n38 46 18 54 76\n25 22 47 10 11\n63 29 74 71 92\n75 98  0 65  4\n87 14 13 64 12", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"7\x2C4\x2C9\x2C5\x2C11\x2C17\x2C23\x2C2\x2C0\x2C14\x2C21\x2C24\x2C10\x2C16\x2C13\x2C6\x2C15\x2C25\x2C12\x2C22\x2C18\x2C20\x2C8\x2C19\x2C3\x2C26\x2C1\n\n22 13 17 11  0\n 8  2 23  4 24\n21  9 14 16  7\n 6 10  3 18  5\n 1 12 20 15 19\n\n 3 15  0  2 22\n 9 18 13 17  5\n19  8  7 25 23\n20 11 10 24  4\n14 21 16 12  6\n\n14 21 17 24  4\n10 16 15  9 19\n18  8 23 26 20\n22 11 13  6  5\n 2  0 12  3  7", Scope = Private
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
