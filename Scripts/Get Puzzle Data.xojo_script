var origLocation as string = Location

if origLocation = "" then
print "Select something from the Advent class first."
return
end if

if origLocation.Left( 7 ) <> "Advent_" or origLocation.IndexOf( "12" ) = -1 then
print "This does not appear to be an Advent class."
end if

var aClass as string = origLocation.NthField( ".", 1 )

// Get the year and day
var parts() as string = aClass.Split ( "_" )
var year as string = parts( 1 )
var day as string = parts.Pop

var data as string = GetData( year, day )
if data = "" then
return
end if

//
// Get puzzle title
//
var title as string = Parse( data, "<h2>--- Day 5: ", " ---" )
Location = aClass + ".ReturnName"
Text = "return """ + title + """"

//
// Get answers
//
parts = data.Split( "<p>Your puzzle answer was " )
if parts.Count = 1 then
return
end if

var answer1 as string = Parse( parts( 1 ), "<code>", "</code>" )
if answer1 <> "" then
Location = aClass + ".CalculateResultA"
var t as string = Text.Trim
if t.Right( 5 ) = ", 0 )" then
Text = t.Left( t.Length - 3 ) + answer1 + " )"
end if
end if

if parts.Count >= 3 then
var answer2 as string = Parse( parts( 2 ), "<code>", "</code>" )
if answer1 <> "" then
Location = aClass + ".CalculateResultB"
var t as string = Text.Trim
if t.Right( 5 ) = ", 0 )" then
Text = t.Left( t.Length - 3 ) + answer2 + " )"
end if
end if
end if

//
// Functions
//
Function Parse(data As String, marker1 As String, marker2 As String) As String
var pos1 as integer = data.IndexOf( marker1 )
if pos1 = -1 then
return ""
end if

var targetStartPos as integer = pos1 + marker1.Length

var pos2 as integer = data.IndexOf( targetStartPos, marker2 )
if pos2 = -1 then
return ""
end if

var targetLength as integer = pos2 - targetStartPos
return data.Middle( targetStartPos, targetLength )
End Function

Function GetBaseURL(year As String, day As String) As String
return "https://adventofcode.com/" + year + "/day/" + day.ToInteger.ToString
End Function

Function GetAOCCookie() As String
const kAOCSessionCookie as string = "AOC_SESSION_COOKIE"

var data() as string = LoadText( "~/.zshrc" ).Split( EndOfLine )
for each line as string in data
if line.Contains( kAOCSessionCookie ) then
return line.NthField( "=", 2 ).ReplaceAll( "'", "" ).Trim
end if
next

return ""
End Function

Function GetData(year As String, day As String) As String
var cookie as string = GetAOCCookie
if cookie = "" then
print "Could not get cookie."
return ""
end if

var url as string = GetBaseURL(year, day)

var curl as string = _
"curl " + _
"--silent " + _
"--cookie-jar ""~/curlcookies"" --cookie 'session=" + cookie + "' " + _
"'" + url + "'"

var shellResult as integer
var data as string = DoShellCommand( curl, 3000, shellResult )

if shellResult <> 0 then
print "Curl error: " + shellResult.ToString
end if

return data
End Function
