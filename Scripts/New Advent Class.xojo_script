const kTemplateCopyName as string = "AdventTemplate1"

if not DoesProjectItemExist( kTemplateCopyName ) then
print "First duplicate the template into " + kTemplateCopyName
return
end if

var label as string = Input( "Enter year_month_day, or year_day (12 is assumed):" ).Trim

if label = "" then
return
end if

label = label.ReplaceAll( "-", "_" )

var parts() as string = label.Split( "_" )

select case parts.Count
case is < 2
print "Not enough parts!"
return

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

label = String.FromArray( parts, "_" )

var className as string = "Advent_" + label

if not SelectProjectItem( kTemplateCopyName ) then
print "Could not select " + kTemplateCopyName
return
end if

PropertyValue( kTemplateCopyName + ".Name" ) = className

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
