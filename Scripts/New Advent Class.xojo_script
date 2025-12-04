const kTemplateCopyName as string = "AdventTemplate1"

var label as string = Input( "Enter year_month_day, or year_day (12 is assumed):" ).Trim

if label = "" then
return
end if

label = label.ReplaceAll( "-", "_" )

var parts() as string = label.Split( "_" )

select case parts.Count
case is < 1
print "Not enough parts!"
return

case 1
var now as new Date
if now.Month  = 12 then
parts.AddAt 0, now.Year.ToString
else
var year as integer = now.Year - 1
parts.AddAt 0, year.ToString
end if
parts.AddAt 1, "12"

case 2
parts.Add parts( 1 )
parts( 1 ) = "12"

case is > 3
print "Too many parts!"
return

end select

if parts( 0 ).Length = 2 then
parts( 0 ) = "20" + parts( 0 )
elseif parts( 0 ).Length <> 4 then
print "Invalid year!"
return
end if

if parts( 1 ).Length < 1 or parts( 1 ).Length > 2 then
print "Invalid month!"
return
elseif parts( 1 ).Length = 1 then
parts( 1 ) = "0" + parts( 1 )
end if

if parts( 2 ).Length < 1 or parts( 2 ).Length > 2 then
print "Invalid day!"
return
elseif parts( 2 ).Length = 1 then
parts( 2 ) = "0" + parts( 2 )
end if

var year as string = parts( 0 )
var month as string = parts( 1 )
var day as string = parts( 2 )

label = String.FromArray( parts, "_" )

var className as string = "Advent_" + label

//
// Try to fetch the data
//
var asDate as new Date( year.ToInteger, month.ToInteger, day.ToInteger )
var now as new Date
var isTooSoon as boolean = now < asDate

if isTooSoon then
print "Too soon for data"
else
var dataFetched as boolean = MaybeGetData( year, day, month )
if not dataFetched then
print "Could not fetch data."
end if

if not DoesProjectItemExist( kTemplateCopyName ) then
print "Could not find " + kTemplateCopyName + _
if( dataFetched, ", but the data was fetched.", "." )

return
end if
end if

if not SelectProjectItem( kTemplateCopyName ) then
print "Could not select " + kTemplateCopyName + "."

//
// But maybe the item is already there so let's try
//
if not isTooSoon then
MaybeUpdateClassValues( className, year, day, month )
end if

return
end if

PropertyValue( kTemplateCopyName + ".Name" ) = className

if not isTooSoon then
MaybeUpdateClassValues( className, year, day, month )
end if

//
// Update the Window method
//
var insertLine as string = "AddRow new " + className

Location = "WndAdvent.InitAdvent"

var code as string = Text
if code.IndexOf( insertLine ) = -1 then
// Doesn't exist

var expecting as string = "// " + year

var sections() as string = code.Split( EndOfLine + EndOfLine )

//
// See if the year is here
//
var foundSectionIndex as integer = -1
for sectionIndex as integer = 0 to sections.LastIndex
var section as string = sections( sectionIndex )
if section.Left( expecting.Length ) = expecting then
foundSectionIndex = sectionIndex
exit
end if
next

if foundSectionIndex = -1 then
// We have to insert it
foundSectionIndex = sections.LastIndex
sections.Insert foundSectionIndex, expecting
end if

var codeLines() as string = sections( foundSectionIndex ).Trim.Split( EndOfLine )
codeLines.Add insertLine
codeLines.Sort
sections( foundSectionIndex ) = String.FromArray( codeLines, EndOfLine )

var newCode as string = String.FromArray( sections, EndOfLine + EndOfLine )
Text = newCode
end if

Location = className

//
// Functions
//
Function DoesProjectItemExist (folderName As String ) As Boolean
var locs() as string = SubLocations( "" ).Split( &u9 )
for each loc as string in locs
if loc = folderName then
return true
end if
next

return false
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

Function GetBaseURL(year As String, day As String, month As String = "12") As String
return "https://adventofcode.com/" + year + "/day/" + day.ToInteger.ToString
End Function

Function CurlCommand(url As String) As String
var cookie as string = GetAOCCookie
if cookie = "" then
return ""
end if

return "curl " + _
"--silent " + _
"--cookie-jar ""~/curlcookies"" --cookie 'session=" + cookie + "' " + _
"'" + url + "'"
End Function

Function TemporaryDirectory() As String
return DoShellCommand("echo $TMPDIR").Trim
End Function

Function CurlToFile(url As String, destPath As String) As Boolean
var curl as string = CurlCommand( url )

var shellResult as integer
var result as string = DoShellCommand( curl + " > " + destPath, 3000, shellResult )

if shellResult <> 0 then
print result
end if

return shellResult = 0
End Function

Function Curl(url As String) As String
var curl as string = CurlCommand(url)

var shellResult as integer
var result as string = DoShellCommand(curl, 3000, shellResult)

if shellResult = 0 then
return result
else
return ""
end if
End Function

Function RipGrep(filePath As String, pattern As String, replacement As String = "") As String
const kRG as string = "/opt/local/bin/rg -o -e "

var cmd as string = kRG + "'" + pattern + "' "

if replacement <> "" then
cmd = cmd + "-r '" + replacement + "' "
end if

cmd = cmd + "'" + filePath + "'"

var shellResult as integer
var result as string = DoShellCommand( cmd, 2000, shellResult ).Trim

if shellResult = 0 then
return result
else
if result <> "" then
Print result
end if

return ""
end if
End Function

Function MaybeGetData(year As String, day As String, month As String = "12") As Boolean
//
// Make sure Puzzle Data exists
//
var destPath as string = ProjectFolderShellPath + "/Puzzle\ Data/"
call DoShellCommand( "mkdir " + destPath )

destPath = destPath + "Advent_" + year + "_" + month + "_" + day + ".txt"

var url as string = GetBaseURL(year, day, month) + "/input"
return CurlToFile(url, destPath)
End Function

Sub MaybeUpdateClassValues(className As String, year As String, day As String, month As String)
var tempFileName as string = "aoc_source_" + year + "_" + day + ".html"
var tempFilePath as string = TemporaryDirectory + tempFileName

var url as string = GetBaseURL( year, day, month )

if not CurlToFile(url, tempFilePath) then
Print "Could not get source"
return
end if

var puzzleName as string = RipGrep( tempFilePath, "--- Day \d+: ([^<]+) ---", "$1" )

if puzzleName <> "" then
Location = className + ".ReturnName"
Text = "return """ + puzzleName + """"
end if

var answersRaw as string = RipGrep( tempFilePath, "<p>Your puzzle answer was <code>([^<]+)</code>", "$1" )

var answerParts() as string = answersRaw.Split( EndOfLine )
var methodSuffixes() as string = array( "A", "B" )

for i as integer = 0 to answerParts.LastIndex
var answer as string = answerParts( i )
var suffix as string = methodSuffixes( i )

Location = className + ".CalculateResult" + suffix
var code as string = Text

code = code.Replace( "var answer as variant = 0", "var answer as variant = " + answer )
Text = code
next

call DoShellCommand( "rm " + tempFilePath )
End Sub

Function ProjectFolderShellPath() As String
var path as string = ProjectShellPath
var parts() As string = path.Split( "/" )
parts.RemoveAt parts.LastIndex
return String.FromArray( parts, "/" )
End Function

Class Date
Private mYear As Integer
Private mMonth As Integer
Private mDay As Integer
Private mSQLDate As String

Sub Constructor()
var d as string = DoShellCommand( "date -I" )
var parts() as string = d.Split( "-" )
mYear = parts( 0 ).ToInteger
mMonth = parts( 1 ).ToInteger
mDay = parts( 2 ).ToInteger
End Sub

Sub Constructor(year As Integer, month As Integer, day As Integer)
mYear = year
mMonth = month
mDay = day
End Sub

Function Operator_Compare(other As Date) As Integer
if SQLDate < other.SQLDate then
return -1
elseif SQLDate > other.SQLDate then
return 1
else
return 0
end if
End Function

Function Year() As Integer
Return mYear
End Function

Function Month() As Integer
Return mMonth
End Function

Function Day() As Integer
Return mDay
End Function

Function SQLDate() As String
if mSQLDate = "" then
mSQLDate = Format( mYear, "0000" ) + "-" + Format( mMonth, "00" ) + "-" + Format( mDay, "00" )
end if

return mSQLDate
End Function
End Class



