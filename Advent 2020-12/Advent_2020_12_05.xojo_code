#tag Class
Protected Class Advent_2020_12_05
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

	#tag Event
		Function RunTestB() As Integer
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var ids() as integer
		  for each row as string in rows
		    ids.Add ToId( row )
		  next
		  
		  ids.Sort
		  return ids.Pop
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var ids() as integer
		  for each row as string in rows
		    ids.Add ToId( row )
		  next
		  
		  ids.Sort
		  
		  var missingIds() as integer
		  
		  for i as integer = 1 to ids.LastIndex
		    var thisId as integer = ids( i )
		    var prevId as integer = ids( i - 1 )
		    
		    if ( thisId - prevId ) = 2 then
		      missingIds.Add thisId - 1
		      print "Missing " + missingIds( missingIds.LastIndex ).ToString
		    end if
		  next
		  
		  if missingIds.Count <> 0 then
		    return missingIds( 0 )
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToId(code As String) As Integer
		  code = code.Trim.Left( 10 )
		  
		  var frontBack as string = code.Left( 7 )
		  var leftRight as string = code.Right( 3 )
		  
		  var rowLow as integer = 0
		  var rowHigh as integer = 127
		  
		  for each char as string in frontBack.Characters
		    select case char
		    case "F"
		      var midPoint as integer = ( rowHigh - rowLow ) \ 2 + rowLow
		      rowHigh = midPoint
		    case "B"
		      var midPoint as integer = ( rowHigh - rowLow + 1 ) \ 2 + rowLow
		      rowLow = midPoint
		    end select
		  next
		  
		  var leftest as integer = 0
		  var rightest as integer = 7
		  
		  for each char as string in leftRight.Characters
		    select case char
		    case "L"
		      var midPoint as integer = ( rightest - leftest ) \ 2 + leftest
		      rightest = midpoint
		    case "R"
		      var midPoint as integer = ( rightest - leftest + 1 ) \ 2 + leftest
		      leftest = midPoint
		    end select
		  next
		  
		  var row as integer = rowLow
		  var seat as integer = leftest
		  var id as integer = row * 8 + seat
		  
		  'print code + ": row " + row.ToString + ", column " + seat.ToString + ", seat ID " + id.ToString
		  return id
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"BBFFFFBRLL\nBFBBBBFLLL\nFBBBFBFLLR\nBFBBBFBLRR\nFBBFFBFLRR\nFFBFFBFRRR\nFBFBBBBLLL\nBFFBFFFRLR\nBFFBFFFRLL\nBFBBFBFRRL\nFBFFFFBLRR\nBBFFBFBLLR\nBBFBFFBRLR\nBFBFBFFRLR\nFBFFBFBRRL\nBFFFFBFRLR\nFFBBBBBRLR\nBFFFBFBLLR\nFBBBBBBRLL\nFBBFBFBRRL\nFBFBFBFLRL\nFFBFBBFRLL\nBFBFFBFRRL\nFBBBBFBLLR\nFFBBFBFLRR\nBFBFBBFRRL\nFBFFFBBLLR\nFBBFFBFRRR\nFFFBFBBLRL\nFBBBBFBRRL\nBFBFBBFLRL\nBBFFBFBLRL\nBBFFFFFLRL\nBBFBBFFRLR\nFFBFBBBRRL\nFBFFFFFRLR\nFFFBBFFLRR\nBFFFBFFLRL\nBFBFFFBRLR\nBBFBFBFLRR\nFBBBBFFRRR\nFBFFFBFRLL\nFBFFFFFLRL\nBFFFFFBLRR\nFFFBBBFLRL\nFBFBBBFRLL\nFFBFBBBLRR\nFBFFFFFRLL\nFFBFFFFLRR\nBBFBFBBRRL\nFFFBFBBLRR\nBFFBFBBRRR\nFFBBFFBLRL\nBFBBBFFRRL\nFFBBFFFRLL\nFBFFBFBLRR\nFBBFBBBRLL\nFBBFFFBRLR\nFBFFBFFLRL\nFFFBFBBRRR\nBBFFFBBRLL\nBFBFBBBRRR\nBBFFBFFLRR\nFFBFFBBLLL\nFFFBBBFLLL\nFBBFBBBRRL\nBBFBFBFLLR\nBFBFFFFRLL\nBFFBBFFRLR\nBFBBFFFRLR\nBBFFFBBRRL\nBFBFFBFLRR\nFBBFFFBRRR\nFFBFFFBLLR\nBFFFFBBRLR\nBBFFBBFRRR\nBFBBBFBLLL\nFFBBBFBLRR\nFFBFFBFLRL\nFFFBBBBRLR\nBFBFFFBRRR\nBBFFBFFRRL\nBFFBBFFLRR\nFFFBFBBLLL\nFBBBBBFLLL\nBFBFFBFLLR\nBBFBFBBRRR\nFBFBBFBRLR\nFBBFFBFRLL\nBFBBFFBLRL\nBFBBFFFRRL\nFBFFBBFRLR\nFBBFBBBLRL\nFBFFBFFLLR\nFFFBBFBRLR\nFBBFFBBLLR\nFFFBBBFRRL\nBBFBBFFRRL\nFFBBBFFRLR\nBFFFFBBRRR\nFBBBBBFRLR\nBBFBFFBRRR\nBFFBFBFRLL\nBFBFFFFLRL\nFBBBFFBRRR\nFBBFBBFLLL\nBFFFFBFLLR\nBBFFFFBLLR\nFFBFBFFLRR\nFBBBFBBRRL\nBFFFBBFLRL\nFBFFFBFLLL\nBBFFFFFRLR\nFFFBBBFRLL\nFFBBBFBRLL\nBFFBFFBRLR\nBBFFBBFLRR\nFBBBBFBLRR\nBFFBFFBLRL\nFFBFFFFRLR\nFBBBBBBRRL\nFBBFFFBLLR\nFBFFFFFLLR\nFBBFBBFRLL\nBFFBFFFRRL\nFBBFFBFLLR\nFFBBFFBLLR\nFBBBFBBRLR\nBFFBBBFLLR\nFFBBFBFRRR\nFFFBFBBRLL\nFBFFFBBRRL\nBFFFBBBLRL\nBBFFBBBLLL\nFBFBBFBLRL\nBBFFFBBLRL\nFBBBBFBLRL\nBBFFBBFLLL\nFBFBBFFRRR\nBFBBFBFLRL\nFBFFBBFLRL\nBFBFBFBLRL\nBFBBFBBLRL\nFFFBBFBLLR\nFFFBFBFRRL\nFBBBFBFRRR\nFBBBFFBLLR\nBFFFBBFLRR\nBFFFBFFLRR\nBBFFFBFRRR\nFFFBBFBLRR\nBFFFFFFRRL\nFBBFFFFLLR\nBBFBFFFRRR\nFBBBFFFRRR\nBFBFFFFRLR\nBFBBFFFRLL\nFFBBBFBLLR\nBFFBBBFLLL\nFBFFFBFRRL\nFFBFFFFRRR\nFFBBBBFRRL\nFFBFFFBLRR\nFBBBBFBRRR\nBBFFBFFLLL\nFBBBBFFLLR\nFBFFBBFLLL\nBFBBBFBRLL\nFBBFFFFRLL\nFBBFBFBRLR\nBFFBBFBLRR\nFFBFBFBRLL\nBBFFBBFRLL\nFFBFBBFLLL\nBFFBBFBLLL\nFBFFFFFRRL\nFBFFBFBLRL\nFFBFFBFRLL\nBFBBBBBRRR\nFBFFBFBLLR\nFFBFFFBLRL\nFFBFFBBLRR\nBFBFFBBRRL\nFFBFBFBRLR\nFFBFBFFLRL\nBBFBBFFLRL\nFFBFFBFLLR\nFFFBBBBLRR\nBFFBFBBRRL\nFFBBFBBRLR\nBFFBFBFLLR\nFFBBFBBRRR\nBBFFBBBRRR\nBFFFBFFLLR\nBFBBBFFRRR\nBFBBFBBLLL\nFFBBFBBLLL\nFBFBFBBLLR\nFFBBBFFLRR\nFFBFFBFLLL\nBFFBFFBLLL\nFBFBBBFLLL\nBBFBFBBRLL\nFBFFBFBRRR\nBBFBFFFRLL\nBBFBFFFRRL\nBFFFFBBLRL\nBFBFFFFRRL\nFFBFFBFRRL\nFBBFBBFLRR\nBFFFBBBRRL\nFFBFFFBLLL\nFFBBBBBLLR\nBFBFBFBLRR\nFFBBFFFLRL\nFBBBBBBRRR\nFBFBFFBLLL\nFBFFBBBRRL\nBFFBFFFRRR\nBFBBFFBRRR\nBBFBBFFLRR\nBBFBFFBRRL\nBBFFBBBLLR\nFBFFFFBRLR\nBBFFFFFRRR\nBFBFFBFRLL\nFBBBFBBRLL\nFFBBFBFRLR\nBFBFBFBRLR\nFFBBBFFLLR\nFBFFFFFLRR\nFBFFBFFRLR\nBFBBBBFRLR\nFBFBBFBLRR\nFBBBBFBRLR\nBFBFFBBRLL\nFFBBFBFLLL\nFFBFBFBLLL\nFFBFBFBRRR\nBFBFBFBLLR\nBFBBBBBRRL\nFBBBBBFRRR\nBBFBFFBLRL\nFBBBBFFRLR\nBBFFFFFLLR\nFBBFFBBLRR\nFBFFFFBRRR\nBFFFBBFRLL\nFBFBFFBLRR\nBFBBFBBRRL\nBFFFFBFRRL\nFFBFFFBRRR\nFFBFBBBRLL\nBBFFFFFRRL\nBFBBFBBLRR\nFBBFBFFRRR\nBFFBFFBLRR\nBFFFBBFLLL\nBFBFFFBRLL\nBBFBBFBLLL\nBFBFBFFRLL\nFFFBBBFLLR\nFBBBFFFRLL\nBFBFFBFRRR\nFFBBFFFRRR\nBBFFFBBRRR\nBFFFFBFLRR\nBFFFFFFRRR\nBBFFBFBLRR\nFBBBBBBRLR\nBBFFBFFLLR\nBFFBBBBLLR\nFBBBBFFLRR\nFFBBBFFRRL\nFBFBBFFLLL\nBBFFBBBRLL\nFBFFBFBLLL\nBFFBFBBRLR\nFBBFFFBLRL\nFFBFBFFLLL\nFBBBFBFLRL\nFFFBBFFLRL\nFBBBBFFRRL\nBFBFBBBRRL\nBFFFBBBLLR\nFBFBFBBLRL\nBFBBFFBLRR\nBBFBFFFLRR\nFBFFBBBLRR\nFFBFFBBRLL\nBFBFFFFLRR\nBBFBFFBRLL\nFBBBFBFRLL\nBFBBBFFLRL\nBFFBBBBRRL\nBFFBBBBLRR\nFFBBFBFRLL\nFBFBFFFLLL\nBFFFFFFLRL\nBFBBBFBRRL\nFFFBBBBRRL\nFBFFFFBLRL\nFBBBBBFRLL\nFFBBFFFLRR\nFBBFBBFLLR\nBFBFBBFRLL\nBFBFFFBLLR\nBFBFBBBLRL\nFFBFFFBRLR\nBFFBBBFRRL\nBFBBBBBLRR\nFBFFFBBRLL\nFBFBFBBRRR\nFFFBFBBRLR\nBFBFBBFLRR\nFBFBFBBLLL\nFFBBFFBRLL\nFBBFBFBRRR\nBFFFFFBRRL\nFBBBFBBLLL\nBBFBFFBLLL\nFFBFBFBLLR\nFFBBBFBRRL\nFBFBFBFLLL\nBFBFBBFRLR\nFBBFBFFRLR\nFFBFFBBRRR\nBFFBFFBLLR\nFBFFFBFLRL\nFBFFFFFRRR\nFFBBFBBRLL\nFBFFBFFRLL\nBBFFFBFLRR\nBFBBBFFRLL\nFBFBBBBLRL\nFFFBBBBLLL\nBBFFFFBRRR\nFBBBBBBLLL\nFFBFBFBLRL\nBFFBFFBRRL\nFFBBFBBLRR\nBFBFFBFLLL\nFBBBBFFRLL\nFFFBBFBRLL\nBFFFBFBLLL\nBBFBBFBRLL\nFFBFFBBLLR\nBBFFFFBLRL\nBBFBBBFLLR\nBFBBFFBRLR\nBFFFFBFLLL\nBBFFBBFLLR\nBBFBFFFLLL\nFBBBFFFLLL\nBFBBFBBRRR\nFFBBBBFRRR\nBBFBBFBRLR\nBFBBFFFLLL\nFFBFFFFLLR\nFBFBFFBLLR\nFBBBFFFLLR\nBFBBBBFLRR\nFBBFBFFLRR\nFBFBBFBRRL\nBFFBFFFLLL\nFBBFBBFRRR\nFBFFBBBRLL\nFBFBBBBRRL\nFFFBBBFRRR\nFBFBFFBRRL\nFFBBFBFLLR\nBFBFBBBLLL\nFFBFFBFLRR\nBFBFBBFRRR\nFBBBBBBLLR\nBFFBFBFRRR\nFBFFFBFRRR\nBBFFFBFLLL\nFBBFFBBRRR\nBFBFBFBLLL\nBBFFBBBLRR\nFFBFFFFRRL\nFFBFBBFLLR\nFFFBBBFRLR\nFFFBBFBLLL\nFBFBBFFLLR\nFBFBFBFRRR\nBFBBFFFRRR\nBFBFFBBRRR\nFBFBBFFRLR\nFFBFBBFRLR\nBFFBBFFRRR\nBFBFBBFLLL\nFFFBBFBRRR\nBFFBBFFRLL\nFFBFFFFLLL\nFFBBBFFRLL\nBBFBBFBRRL\nBBFBFFBLRR\nFFBFFBBRRL\nFBBFBBFRRL\nBBFFFFBLLL\nBFBBFFBRLL\nFFBFBFFRLL\nBFBBFFFLLR\nFBBFFBBRLR\nBFBFFBFLRL\nBFBBFBBRLL\nFFBBBFFRRR\nFBFBBFFLRL\nBFBBFBFRLR\nFFBBFFBRRL\nFBFFBBFLLR\nFBFBBBFLLR\nBFFFBBFRRL\nFFFBBBBRRR\nBFFFBBBRRR\nFBBFBFFRRL\nBBFFFFBRRL\nBBFFFBBLLR\nBFBBFBFRRR\nBFFFFBBRRL\nFBBFBBFLRL\nFBBFBBBRLR\nFBFBFFFLRL\nBFFBFBFRRL\nFBFBBBFLRL\nBFBBBBBLRL\nFFBFFFBRLL\nBFFBBFBLRL\nFBFBFBFRLR\nBFFBBFFLLL\nBFBBBBBLLL\nFFBFBBFLRR\nBBFBFBFRRR\nFFFBBFFRRR\nBFFFBFFRRL\nBBFBFFFRLR\nBBFBFFFLLR\nBFFFFFFLRR\nFBBFBBFRLR\nFFBBBFFLRL\nFBFBFFFRLR\nFFBFBFFLLR\nBFBFFBBLRR\nBFFBBBFRLL\nFBBFFBBLRL\nBFBBFFBLLR\nFBFFBFFRRR\nBFFBBBFRLR\nBFBFBBBLLR\nBFFFFBBLLR\nBFFBFBFLLL\nBFBBFFFLRR\nBFFFFFFRLR\nBBFFBFFLRL\nBFBFBFFLLR\nBBFFFFFLRR\nFFBFBBFLRL\nFBFBFFBRRR\nFFBBBBFRLR\nBBFBBBFLLL\nBFFFFBBRLL\nFBFBBBFRRR\nBFFBFBFRLR\nFFFBBFFLLR\nFBBFBFFLLL\nFFFBFBBRRL\nBFBBBBFLRL\nFFBFFBFRLR\nFBFFBFBRLL\nFBBBFBFLRR\nBBFFBBFRLR\nFBBBBBFLRR\nFBFFFFBRLL\nBFFBFFFLRL\nBFBFFFFLLL\nBBFFBFBRLR\nBFBBBFBLLR\nFBBFFBBRLL\nFBFBFBFRLL\nBBFBFBBLRL\nBFFBFBBLRL\nFFBBBFBLRL\nFFBBFBBLLR\nBFFBFBFLRR\nFBBBFBFRRL\nBFFBBBFLRL\nBFBBFBBLLR\nBFBFFFBLRR\nFBFFBBBLRL\nFBFFBFFLLL\nBBFFBFFRRR\nBFFBFBBRLL\nBFFFBFFRRR\nBFFBBBBLRL\nFBBFFBFRLR\nFBFFBFFRRL\nFBFFFBBRRR\nBBFFFFBLRR\nFBBBFFFLRL\nFFBBBBFLRL\nBFFFBFFLLL\nBFBBBFFRLR\nFFBFBBFRRL\nFBFBBBFLRR\nFFFBBBFLRR\nBFFFBFBRLR\nFBBBFBBLRR\nFFBBBFFLLL\nFFFBFBFRLR\nFBBFFFBRLL\nFBBFBBBRRR\nBFBFFFFRRR\nBFBBBFBLRL\nBBFFFBBLRR\nBFBFFBBLLR\nBFBBFBFLLR\nBBFFBBBRRL\nFBBFFFFLLL\nBBFBFFBLLR\nBFBBBBBLLR\nFFBFFBBRLR\nFFBBBFBRLR\nFBFBBBBLRR\nFBBFBFBLRR\nBBFFBBFRRL\nBBFFBFFRLL\nFBBBFFBLRR\nBFFFBFBRRR\nBFFBFFFLRR\nFFBBFBBRRL\nFBFBBBBRRR\nBBFBBFFLLL\nFBFFBBBLLL\nFBBFFFBLRR\nBFBBFFBLLL\nFBFFFFBLLL\nBFBFBBBLRR\nBFFFFFBLLR\nBFFBBFBLLR\nFBFFBFFLRR\nFBBFBBBLLR\nFFBBBBBRLL\nBFFFBBFLLR\nFFBFBBBLRL\nFBFBBBFRRL\nBFFFFBFLRL\nFBBFFBFRRL\nFFFBBFBRRL\nFFBBBBBRRL\nBBFFFBFLRL\nFBBFFFFLRR\nBFBBBBFRLL\nBFFBFFBRRR\nFFBBFFFLLL\nBFFBBBBRLR\nBFBBFFFLRL\nBFBFFBBLRL\nBBFFFBFRLR\nFBFBFBFLLR\nBBFFFBBRLR\nFBBBFFBLLL\nFBBBFFFRRL\nBFFFFFFRLL\nFFBFBFFRRR\nBFFFBFBRLL\nFBBBFFFRLR\nBFBBBFFLLL\nFBBFBFBLLL\nFFBBFFFLLR\nBFFFBBFRLR\nBBFFFBFRLL\nFBBBBBBLRL\nBFBFBFBRLL\nFBBBBBFRRL\nBBFBFFFLRL\nBFBBBBFRRR\nBFBFFFBLRL\nFFBFBFBRRL\nBFBFBFBRRR\nFFBFFFFRLL\nBBFBBFFLLR\nFFBFBBBLLR\nBBFBBBFLRL\nFBFBBBBRLL\nFFBBBBFLRR\nFFBFFBBLRL\nBBFFBBBRLR\nBFBBFBFLLL\nFBFBFFBLRL\nBFFFFFBLLL\nFBFFBFBRLR\nFBBBBFBLLL\nFBBFFBFLRL\nBFFFBBBLLL\nFBBFBFFLRL\nFFFBBFFLLL\nBFBFBFFRRL\nBFFFFFBRLL\nBFFBFBFLRL\nBFFBBFBRRL\nBFBBFFBRRL\nFFFBBBBLRL\nFFBFBBBRRR\nFBFBBFBRRR\nFFBBBBFLLL\nBBFFBFBRLL\nFBFFBBFRLL\nFBFBFFFLLR\nBFFFFBFRRR\nFFBBBFBLLL\nFBBBFFBLRL\nBFFFBBBLRR\nFFFBFBFRRR\nFBFFFBBRLR\nFBFBFFFLRR\nFBBBFBBLRL\nFBBBFBBRRR\nBBFBFBBLRR\nBFFBBBFLRR\nBFFFFFFLLR\nBBFBFBFRLL\nBFFBFBBLLL\nFFBBBBFLLR\nBFFFFBBLRR\nFBFBFFFRLL\nBFBFFFBRRL\nBBFBFBBLLR\nFFFBFBBLLR\nFBFFBBBRRR\nFBBFBFFLLR\nFBFBFBBRLL\nBFFBBBBRRR\nBFFBFFFLLR\nBFBFBFBRRL\nBFBBBBFLLR\nFBBFBFBLLR\nBFFFFFBRLR\nFBFFFBBLLL\nBBFFFFFLLL\nFFBBBBBLRR\nFFBBFBBLRL\nBBFFFFFRLL\nFBFBBFFRRL\nFFBFBBBLLL\nBFFFBBBRLR\nFBBBFBFRLR\nFBBFFFFLRL\nFFBBFFBRRR\nFBFBFBFLRR\nBFBFBBBRLL\nBFBFBFFLLL\nFBFFBBBLLR\nBFFFBFBLRL\nFBBFFFFRRR\nFBBBBBFLLR\nBFFFFBBLLL\nFBBFBFBLRL\nBFFFBBFRRR\nBBFFBFBRRR\nBBFFBFBRRL\nFFFBBBBRLL\nBBFFBBBLRL\nBFBBFBBRLR\nBBFBBFBLLR\nBFBBFBFLRR\nFBFFFFBRRL\nBFFBFBBLRR\nBBFFBFBLLL\nFBBBFBBLLR\nFBFBBFBLLL\nBBFBFBFRLR\nBFFBBBBLLL\nBFFBFFBRLL\nBBFBBFBLRR\nFBFFBBFLRR\nBBFFBFFRLR\nBFFFBFFRLR\nFBFBBFFRLL\nBFFBBBFRRR\nFBBBFBFLLL\nBBFBBBFLRR\nFBBFFBFLLL\nBBFBBFBLRL\nFBFFFBBLRL\nFBFBBFBRLL\nBFBBBBFRRL\nBFFFBFFRLL\nBFBFBBBRLR\nFFBFFFFLRL\nFFBFFFBRRL\nFBFFBBFRRR\nBBFFFFBRLR\nBFFFBFBLRR\nBBFFBBFLRL\nFFBBFFFRRL\nFBFBFBBRLR\nFBBFBFFRLL\nFBBBFFBRLL\nFBBFBBBLLL\nFBBFFBBRRL\nBFBFBBFLLR\nFFBBFFBLRR\nFFBBBBBLLL\nBBFFFBFLLR\nFBFBBBBRLR\nBFBFBFFLRL\nFFBBBBBRRR\nBFBFFBFRLR\nFBBBBFBRLL\nBFBBBBBRLL\nBFBBBBBRLR\nFBBBBFFLLL\nFBBFFFBLLL\nBBFBFBFLLL\nBFFFFFBLRL\nFBBFBFBRLL\nBBFBFBBRLR\nBFFBFBBLLR\nFFBBFBFLRL\nFBFBBBFRLR\nFBBBFFBRLR\nFBFFFBFLRR\nBFBFBFFLRR\nBFFFFFBRRR\nBFFBBFBRLL\nFBFBFBFRRL\nBBFBBFFRRR\nFBBFBBBLRR\nFBFFBBBRLR\nBBFBFBBLLL\nFFBFBBFRRR\nFBFBBFBLLR\nBFBFBFFRRR\nBBFBBFBRRR\nFFBFBBBRLR\nFBFBFBBRRL\nBFBFFFBLLL\nFBFBFFBRLL\nFBFFFBFRLR\nFBFFFBBLRR\nFBBFFFFRLR\nBFBBFBFRLL\nFBFBFBBLRR\nFFBBBFBRRR\nFBBFFFFRRL\nFBFBBFFLRR\nFBBBFFBRRL\nFBFFFBFLLR\nFFBFBFFRLR\nFBBFFBBLLL\nFFFBBFFRLR\nBFFFFFFLLL\nFFFBBBBLLR\nFFBFBFFRRL\nBBFBBFFRLL\nFFFBBFFRLL\nBBFFFBFRRL\nFFBBFFBLLL\nFBFFBBFRRL\nBFBBBFBRLR\nBFBFFBBRLR\nFBFBFFFRRR\nBFBBBFFLLR\nFBFBFFFRRL\nBFFBBFFLLR\nFBFBBBBLLR\nFFBBFFBRLR\nFBFFFFFLLL\nBBFBFBFRRL\nFBBBBFFLRL\nBFBBBFBRRR\nBFFBBFFLRL\nBFFBBFFRRL\nBBFBFBFLRL\nFBBFFFBRRL\nBFFFBFBRRL\nFBFFFFBLLR\nFFBBFBFRRL\nBFFBBBBRLL\nBFBFFFFLLR\nFFBBFFFRLR\nBFBFFBBLLL\nBFFBBFBRRR\nBFFFBBBRLL\nFFFBBFBLRL\nFFBFBFBLRR\nFFFBBFFRRL\nFFBBBBBLRL\nBFBBBFFLRR\nFBBBBBFLRL\nFBBBFFFLRR\nBFFBBFBRLR\nBBFFFBBLLL\nFBBBBBBLRR\nFBFBFFBRLR\nFFBBBBFRLL", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"FBFBBFFRLR: row 44\x2C column 5\nBFFFBBFRRR: row 70\x2C column 7\x2C seat ID 567.\nFFFBBBFRRR: row 14\x2C column 7\x2C seat ID 119.\nBBFFBBFRLL: row 102\x2C column 4\x2C seat ID 820.", Scope = Private
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
