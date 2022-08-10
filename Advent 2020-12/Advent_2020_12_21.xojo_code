#tag Class
Protected Class Advent_2020_12_21
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
		  return "Allergen Assessment"
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( Normalize( GetPuzzleInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( Normalize( GetPuzzleInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  return CalculateResultB( Normalize( input ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  //
		  // Split the ingredients and allergens
		  //
		  
		  var db as Database = CreateDatabase
		  PopulateDatabase db, input
		  'PrintDbInfo db, "Populated"
		  
		  IdentifyMatches db
		  PrintDbInfo db, "Matched"
		  
		  var rs as RowSet = db.SelectSQL( "SELECT * FROM confirmed_match" )
		  Print rs
		  
		  var result as integer = CountUnmatchedIngredients( db )
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  //
		  // Split the ingredients and allergens
		  //
		  
		  var db as Database = CreateDatabase
		  PopulateDatabase db, input
		  
		  IdentifyMatches db
		  
		  var rs as RowSet = db.SelectSQL( "SELECT * FROM confirmed_match" )
		  Print rs
		  
		  var sql as string = _
		  "SELECT ingredient FROM confirmed_match ORDER BY allergen"
		  rs = db.SelectSQL( sql )
		  
		  var ingredients() as string
		  while not rs.AfterLastRow
		    ingredients.Add rs.ColumnAt( 0 ).StringValue
		    rs.MoveToNextRow
		  wend
		  
		  Print String.FromArray( ingredients, "," )
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountUnmatchedIngredients(db As Database) As Integer
		  var sql as string = _
		  "WITH" + EndOfLine + _
		  "unmatched_ingredients AS (" + EndOfLine + _
		  "  SELECT name FROM ingredient WHERE name NOT IN (SELECT ingredient FROM confirmed_match)" + EndOfLine + _
		  ")," + EndOfLine + _
		  "rows AS (" + EndOfLine + _
		  "  SELECT *" + EndOfLine + _
		  "  FROM imported_row" + EndOfLine + _
		  "  WHERE" + EndOfLine + _
		  "    ingredient IN (SELECT name FROM unmatched_ingredients)" + EndOfLine + _
		  ")" + EndOfLine + _
		  EndOfLine + _
		  "SELECT DISTINCT" + EndOfLine + _
		  "  row_num," + EndOfLine + _
		  "  ingredient" + EndOfLine + _
		  "FROM rows"
		  var rs as RowSet = db.SelectSQL( sql )
		  'print rs
		  
		  var unmatchedCount as integer = rs.RowCount
		  
		  sql = _
		  "SELECT name" + EndOfLine + _
		  "FROM allergen" + EndOfLine + _
		  "WHERE name NOT IN (SELECT allergen FROM confirmed_match)"
		  rs = db.SelectSQL( sql )
		  var unmatchedAllergens() as string
		  for each row as DatabaseRow in rs
		    unmatchedAllergens.Add row.ColumnAt( 0 )
		  next
		  
		  for each allergen as string in unmatchedAllergens
		    sql = _
		    "SELECT DISTINCT row_num" + EndOfLine + _
		    "FROM imported_row" + EndOfLine + _
		    "WHERE allergen = ?"
		    rs = db.SelectSQL( sql, allergen )
		    var allergenRowCount as integer = rs.RowCount
		    
		    sql = _
		    "SELECT" + EndOfLine + _
		    "  allergen," + EndOfLine + _
		    "  ingredient," + EndOfLine + _
		    "  COUNT(*)" + EndOfLine + _
		    "FROM" + EndOfLine + _
		    "  imported_row" + EndOfLine + _
		    "WHERE" + EndOfLine + _
		    "  allergen = ?" + EndOfLine + _
		    "  AND ingredient NOT IN (SELECT ingredient FROM confirmed_match)" + EndOfLine + _
		    "GROUP BY allergen, ingredient" + EndOfLine + _
		    "HAVING COUNT(*) = ?"
		    rs = db.SelectSQL( sql, allergen, allergenRowCount )
		    if rs.RowCount <> 0 then
		      unmatchedCount = unmatchedCount - rs.RowCount
		      continue
		    end if
		  next
		  
		  return unmatchedCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateDatabase() As Database
		  var f as FolderItem
		  
		  #if FALSE then
		    f = SpecialFolder.Desktop.Child( "advent-2020-12-21.sqlite" )
		    if f.Exists then
		      f.Delete
		    end if
		  #endif
		  
		  var db as new SQLiteDatabase
		  if f isa object then
		    db.DatabaseFile = f
		    db.CreateDatabase
		  end if
		  db.WriteAheadLogging = true
		  
		  call db.Connect
		  
		  db.ExecuteSQL "CREATE TABLE allergen (name TEXT UNIQUE)"
		  
		  db.ExecuteSQL "CREATE TABLE ingredient (name TEXT UNIQUE)"
		  
		  db.ExecuteSQL "CREATE TABLE imported_row (row_num INTEGER, ingredient TEXT, allergen TEXT)"
		  db.ExecuteSQL "CREATE INDEX imported_row_row_num_idx ON imported_row (row_num)"
		  db.ExecuteSQL "CREATE INDEX imported_row_ingredient_idx ON imported_row (ingredient)"
		  db.ExecuteSQL "CREATE INDEX imported_row_allergen_idx ON imported_row (allergen)"
		  
		  db.ExecuteSQL "CREATE TABLE potential_match (allergen TEXT, ingredient TEXT)"
		  db.ExecuteSQL "CREATE UNIQUE INDEX potential_match_unique_idx ON potential_match (allergen, ingredient)"
		  
		  db.ExecuteSQL "CREATE TABLE confirmed_match (allergen TEXT UNIQUE, ingredient TEXT UNIQUE)"
		  
		  db.ExecuteSQL "CREATE TABLE imported_row_stats (row_num INTEGER UNIQUE, ingredient_count INTEGER, allergen_count INTEGER)"
		  db.ExecuteSQL "CREATE INDEX imported_row_stats_allergen_count_idx ON imported_row_stats (allergen_count)"
		  db.ExecuteSQL "CREATE INDEX imported_row_stats_ingredient_count_idx ON imported_row_stats (ingredient_count)"
		  
		  
		  return db
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub IdentifyMatches(db As Database)
		  var sql as string
		  var rs as RowSet
		  
		  sql = _
		  "SELECT row_num" + EndOfLine + _
		  "FROM imported_row" + EndOfLine + _
		  "WHERE allergen = $1" + EndOfLine + _
		  "GROUP BY row_num" + EndOfLine + _
		  "" + EndOfLine + _
		  "EXCEPT" + EndOfLine + _
		  "" + EndOfLine + _
		  "SELECT row_num" + EndOfLine + _
		  "FROM imported_row" + EndOfLine + _
		  "WHERE" + EndOfLine + _
		  "  allergen = $1" + EndOfLine + _
		  "  AND ingredient = $2" + EndOfLine + _
		  "GROUP BY row_num"
		  
		  var selectPs as PreparedSQLStatement = db.Prepare( sql )
		  selectPs.BindType( 0, SQLitePreparedStatement.SQLITE_TEXT )
		  selectPs.BindType( 1, SQLitePreparedStatement.SQLITE_TEXT )
		  
		  sql = _
		  "INSERT INTO confirmed_match (" + EndOfLine + _
		  "  allergen," + EndOfLine + _
		  "  ingredient" + EndOfLine + _
		  ") VALUES (?, ?)"
		  var insertActualPs as PreparedSQLStatement = db.Prepare( sql )
		  insertActualPs.BindType( 0, SQLitePreparedStatement.SQLITE_TEXT )
		  insertActualPs.BindType( 1, SQLitePreparedStatement.SQLITE_TEXT )
		  
		  var matchPass as integer
		  var allergenCount as integer = db.SelectSQL( "SELECT COUNT(*) FROM allergen" ).ColumnAt( 0 ).IntegerValue
		  
		  do
		    matchPass = matchPass + 1
		    Print "MatchPass " + matchPass.ToString
		    
		    sql = _
		    "SELECT allergen, ingredient" + EndOfLine + _
		    "FROM potential_match" + EndOfLine + _
		    "WHERE" + EndOfLine + _
		    "  TRUE" + EndOfLine + _
		    "  /* allergen NOT IN (SELECT allergen FROM confirmed_match) */" + EndOfLine + _
		    "  AND ingredient NOT IN (SELECT ingredient FROM confirmed_match)" + EndOfLine + _
		    "ORDER BY RANDOM()"
		    rs = db.SelectSQL( sql )
		    
		    var combos() as Pair
		    while not rs.AfterLastRow
		      combos.Add rs.Column( "allergen" ).StringValue : rs.Column( "ingredient" ).StringValue
		      
		      rs.MoveToNextRow
		    wend
		    
		    rs.Close
		    rs = nil
		    
		    for each combo as Pair in combos
		      var allergen as string = combo.Left
		      var ingredient as string = combo.Right
		      
		      rs = selectPs.SelectSQL( allergen, ingredient )
		      if rs.AfterLastRow then
		        #pragma BreakOnExceptions false
		        try
		          insertActualPs.ExecuteSQL allergen, ingredient
		          
		        catch err as DatabaseException
		          #pragma BreakOnExceptions default
		          db.ExecuteSQL "DELETE FROM confirmed_match WHERE allergen = ?", allergen
		        end try
		        #pragma BreakOnExceptions default
		      end if
		      rs.Close
		    next
		    
		    var confirmedCount as integer = db.SelectSQL( "SELECT COUNT(*) FROM confirmed_match" ).ColumnAt( 0 ).IntegerValue
		    if confirmedCount = allergenCount then
		      exit
		    end if
		  loop
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PopulateDatabase(db As Database, input As String)
		  'db.ExecuteSQL "CREATE TABLE allergen (name TEXT)"
		  'db.ExecuteSQL "CREATE TABLE ingredient (name TEXT)"
		  'db.ExecuteSQL "CREATE TABLE imported_row (row_num INTEGER, ingredient TEXT, allergen TEXT)"
		  'db.ExecuteSQL "CREATE TABLE imported_row_stats (row_num INTEGER, ingredient_count INTEGER, allergen_count INTEGER)"
		  
		  
		  var insertIngredientPs as PreparedSQLStatement = db.Prepare( "INSERT INTO ingredient (name) VALUES (?) ON CONFLICT DO NOTHING" )
		  insertIngredientPs.BindType( 0, SQLitePreparedStatement.SQLITE_TEXT )
		  
		  var insertAllergenPs as PreparedSQLStatement = db.Prepare( "INSERT INTO allergen (name) VALUES (?) ON CONFLICT DO NOTHING" )
		  insertAllergenPs.BindType( 0, SQLitePreparedStatement.SQLITE_TEXT )
		  
		  var insertRowPs as PreparedSQLStatement = db.Prepare( "INSERT INTO imported_row (row_num, ingredient, allergen) VALUES (?, ?, ?)" )
		  insertRowPs.BindType( 0, SQLitePreparedStatement.SQLITE_INTEGER )
		  insertRowPs.BindType( 1, SQLitePreparedStatement.SQLITE_TEXT )
		  insertRowPs.BindType( 2, SQLitePreparedStatement.SQLITE_TEXT )
		  
		  var insertPotentialMatchPs as PreparedSQLStatement = db.Prepare( "INSERT INTO potential_match (ingredient, allergen) VALUES (?,?) ON CONFLICT DO NOTHING" )
		  insertPotentialMatchPs.BindType( 0, SQLitePreparedStatement.SQLITE_TEXT )
		  insertPotentialMatchPs.BindType( 1, SQLitePreparedStatement.SQLITE_TEXT )
		  
		  var insertRowStatPs as PreparedSQLStatement = db.Prepare( "INSERT INTO imported_row_stats (row_num, ingredient_count, allergen_count) VALUES (?, ?, ?)" )
		  insertRowStatPs.BindType( 0, SQLitePreparedStatement.SQLITE_INTEGER )
		  insertRowStatPs.BindType( 1, SQLitePreparedStatement.SQLITE_INTEGER )
		  insertRowStatPs.BindType( 2, SQLitePreparedStatement.SQLITE_INTEGER )
		  
		  var rows() as string = self.ToStringArray( input )
		  
		  var rowIndex as integer = 0
		  
		  for each row as string in rows
		    rowIndex = rowIndex + 1
		    
		    var parts() as string = row.Split( "(contains " )
		    parts( 1 ) = parts( 1 ).TrimRight( ")" )
		    var allergens() as string = parts( 1 ).Trim.Split( ", " )
		    
		    var ingredients() as string = parts( 0 ).Trim.Split( " " )
		    
		    insertRowStatPs.ExecuteSQL rowIndex, ingredients.Count, allergens.Count
		    
		    for each ingredient as string in ingredients
		      insertIngredientPs.ExecuteSQL ingredient
		    next
		    
		    for each allergen as string in allergens
		      insertAllergenPs.ExecuteSQL allergen
		    next
		    
		    for each ingredient as string in ingredients
		      for each allergen as string in allergens
		        insertRowPs.ExecuteSQL rowIndex, ingredient, allergen
		        insertPotentialMatchPs.ExecuteSQL ingredient, allergen
		        if ingredient = "" or allergen = "" then
		          ingredient = ""
		        end if
		      next
		    next
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Print(msg As Variant)
		  #if TRUE
		    Super.Print(msg)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PrintDbInfo(db As Database, tag As String)
		  print tag
		  print "================================="
		  
		  var tables() as string = array( "ingredient", "allergen", "imported_row", "imported_row_stats" )
		  
		  var tableRs as RowSet = db.Tables
		  while not tableRs.AfterLastRow
		    var table as string = tableRs.ColumnAt( 0 ).StringValue
		    var countRs as RowSet = db.SelectSQL( "SELECT COUNT (*) FROM " + table )
		    print table + ": " + countRs.ColumnAt( 0 ).StringValue
		    
		    tableRs.MoveToNextRow
		  wend
		  
		  'var rs as RowSet
		  '
		  'rs = db.SelectSQL( "SELECT COUNT(*) FROM imported_row_stats WHERE allergen_count = 1" )
		  'print "  rows where allergen_count = 1: " + rs.ColumnAt( 0 ).StringValue
		  '
		  'rs = db.SelectSQL( "SELECT COUNT(*) FROM imported_row_stats WHERE ingredient_count = 1" )
		  'print "  rows where ingredient_count = 1: " + rs.ColumnAt( 0 ).StringValue
		  
		  
		  print ""
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"mxmxvkd kfcds sqjhc nhms (contains dairy\x2C fish)\ntrh fvjkl sbzzf mxmxvkd (contains dairy)\nsqjhc fvjkl (contains soy)\nsqjhc mxmxvkd sbzzf (contains fish)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
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
