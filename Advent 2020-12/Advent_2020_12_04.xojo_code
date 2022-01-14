#tag Class
Protected Class Advent_2020_12_04
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
		  var recs() as variant = ParseInput( input )
		  var required() as string = array( "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid" )
		  
		  var validCount as integer
		  for each rec as Dictionary in recs
		    for each field as string in required
		      if not rec.HasKey( field ) then
		        //
		        // It's not valid
		        //
		        continue for rec
		      end if
		    next
		    
		    //
		    // If we get here, it's valid
		    //
		    validCount = validCount + 1
		  next
		  
		  return validCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var recs() as variant = ParseInput( input )
		  var required() as string = array( "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid" )
		  
		  var rxHgt as new RegEx
		  rxHgt.SearchPattern = "^(\d+)(cm|in)$"
		  
		  var rxHcl as new RegEx
		  rxHcl.SearchPattern = "^#[[:xdigit:]]{6}$"
		  
		  var validEcl() as string = array( "amb", "blu", "brn", "gry", "grn", "hzl", "oth" )
		  
		  var rxPid as new RegEx
		  rxPid.SearchPattern = "^\d{9}$"
		  
		  var validRecs() as Dictionary
		  
		  for each rec as Dictionary in recs
		    for each field as string in required
		      if not rec.HasKey( field ) then
		        //
		        // It's not valid
		        //
		        continue for rec
		      end if
		      
		      var value as string = rec.Value( field )
		      var isValid as boolean = true // Assume this
		      
		      select case true
		      case field = "byr" and value.ToInteger.IsBetween( 1920, 2002 ) and value.Length = 4
		      case field = "iyr" and value.ToInteger.IsBetween( 2010, 2020 ) and value.Length = 4
		      case field = "eyr" and value.ToInteger.IsBetween( 2020, 2030 ) and value.Length = 4
		      case field = "hgt"
		        var match as RegExMatch = rxHgt.Search( value )
		        if match is nil then
		          isValid = false
		        else
		          var num as integer = match.SubExpressionString( 1 ).ToInteger
		          var unit as string = match.SubExpressionString( 2 )
		          
		          select case unit
		          case "cm"
		            isValid = num.IsBetween( 150, 193 ) 
		          case "in"
		            isValid = num.IsBetween( 59, 76 )
		          case else
		            isValid = false
		          end select
		          
		        end if
		      case field = "hcl" and rxHcl.Search( value ) isa object
		      case field = "ecl" and validEcl.IndexOf( value ) <> -1
		      case field = "pid" and rxPid.Search( value ) isa object
		      case field = "cid"
		      case else
		        //
		        // Not valid
		        //
		        isValid = false
		        
		      end select
		      
		      if not isValid then
		        continue for rec
		      end if
		    next
		    
		    //
		    // If we get here, it's valid
		    //
		    validRecs.Add rec
		  next
		  
		  validRecs = validRecs
		  
		  return validRecs.Count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As Variant()
		  input = input.Trim.ReplaceLineEndings( EndOfLine )
		  
		  var sections() as string = input.Split( EndOfLine + EndOfLine )
		  
		  for i as integer = 0 to sections.LastRowIndex
		    var section as string = sections( i )
		    
		    section = section.ReplaceAll( " ", """, """ )
		    section = section.ReplaceAll( EndOfLine, """, """ )
		    section = section.ReplaceAll( ":", """:""" )
		    
		    section = "{""" + section + """}"
		    sections( i ) = section
		  next
		  
		  var jsonString as string = "[" + String.FromArray( sections, "," ) + "]"
		  var json() as variant = ParseJSON( jsonString )
		  return json
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"byr:1971\neyr:2039\nhgt:172in pid:170cm hcl:17106b iyr:2012 ecl:gry\ncid:339\n\nhgt:161cm eyr:2027\necl:grn iyr:2011 hcl:#a97842 byr:1977 pid:910468396\n\ncid:257\necl:gry hgt:186cm iyr:2012\nbyr:1941\neyr:2029\npid:108935675\nhcl:#cfa07d\n\nhgt:165in\nhcl:#cfa07d eyr:2035 pid:82570731\nbyr:1973\ncid:74 ecl:xry\n\neyr:2020 cid:105 iyr:2012 pid:947726115\nhcl:#ceb3a1 ecl:grn byr:1966 hgt:151cm\n\nhcl:#888785 eyr:2027 ecl:hzl byr:1966\npid:853607760\niyr:2012\nhgt:155cm\n\nhgt:61cm\niyr:2019\nbyr:1952 pid:#1468e6 eyr:2033 ecl:#7d39d5 hcl:z\n\npid:2306523501\neyr:2032 hcl:z ecl:brn\ncid:266 hgt:151in iyr:2024\nbyr:2008\n\nhcl:#a97842 hgt:191cm eyr:2025 ecl:gry byr:1923 pid:574171850 iyr:2019\n\nhgt:140\niyr:1987 byr:2003\neyr:2013 cid:242 hcl:z\necl:#19177c pid:150cm\n\nbyr:1959\nhgt:169cm hcl:#7d3b0c ecl:gry eyr:2028 cid:107 pid:584790749\n\nbyr:1955\ncid:309\nhcl:#a97842\npid:740105085 iyr:2020\nhgt:188cm ecl:oth eyr:2029\n\niyr:2016 hcl:#cfa07d eyr:2026\nhgt:151cm\npid:394185014 ecl:grn byr:1974\n\npid:226566060 ecl:blu cid:272 hgt:188cm hcl:#efcc98\neyr:2029 iyr:2014\nbyr:1956\n\npid:#7c7a9d ecl:#8fa327\neyr:2006 iyr:2022\nhcl:#7d3b0c hgt:169\nbyr:2025\n\nhgt:188in byr:2015 ecl:xry\niyr:1975\neyr:1928\npid:8939875193 hcl:7bbcce\n\nhgt:193cm\neyr:2029\npid:141707808 byr:1997\ncid:83 iyr:2019\necl:hzl hcl:#cfa07d\n\niyr:2019\npid:681586971\nhcl:#6b5442 hgt:165cm\neyr:2022 ecl:brn byr:1985\n\nbyr:1970\niyr:2016 hgt:156in pid:#e32394 eyr:2024\nhcl:#efcc98 ecl:grt\n\niyr:2013\necl:grn pid:341584587 eyr:2027 hgt:185cm hcl:#18171d\nbyr:1935\ncid:113\n\nhcl:#fffffd ecl:grn iyr:2010\npid:738986504 hgt:98 eyr:2024\nbyr:1968\n\npid:175337478 ecl:oth hgt:173cm hcl:#733820\neyr:2025 byr:1960\ncid:283 iyr:2018\n\nbyr:1959\nhcl:#341e13 eyr:2023\npid:566612260 hgt:176cm\niyr:2017 ecl:grn\n\ncid:321 pid:355095309 byr:1945\nhgt:161cm\neyr:2029 iyr:2017\necl:brn hcl:#733820\n\nhcl:#c0946f pid:75316487 iyr:2013 cid:201 hgt:152cm ecl:lzr byr:1996 eyr:1928\n\nhgt:160cm iyr:2010 hcl:#a018b9\neyr:2024 ecl:amb\ncid:347\n\neyr:2021\npid:893047101 iyr:2016 ecl:hzl hcl:#866857 byr:1988\nhgt:166cm\n\nhcl:#7d3b0c\necl:blu pid:085336099 eyr:2024\niyr:2019 hgt:178cm byr:1999\n\necl:grt iyr:2022\nhcl:z\nhgt:192cm byr:2010\n\npid:677187953 eyr:2025 iyr:2020 hgt:163cm byr:1957 ecl:grn hcl:#cfa07d\n\ncid:213\nbyr:1987\npid:113078018 ecl:blu iyr:2013 eyr:2022\nhcl:#7d3b0c hgt:157cm\n\necl:blu hcl:#c0946f hgt:186cm\nbyr:1992 eyr:2028 iyr:2010\n\npid:#b01156 hgt:67\nbyr:2014 ecl:#35dca0 eyr:1922 hcl:790130\n\nhcl:#602927\necl:blu hgt:173cm byr:1974 pid:116377061 cid:294 eyr:2030 iyr:2010\n\nhgt:151cm eyr:2022 iyr:2011 ecl:blu byr:1987 hcl:#733820\npid:#b90d2e\n\ncid:188\nbyr:1990\nhcl:#602927 iyr:2026\npid:530373696\nhgt:154cm ecl:gry\neyr:2029\n\nhgt:178cm eyr:2027\nhcl:#733820\necl:grn iyr:2014 pid:575371227 byr:1965\n\nhcl:#fffffd iyr:2020\nhgt:185cm ecl:amb pid:692760311\nbyr:1961\n\nbyr:1967 pid:397518948 ecl:lzr iyr:2015 hcl:#cfa07d cid:328\nhgt:177cm eyr:2035\n\nhcl:#8e1608\npid:554618249 iyr:2010 hgt:176cm cid:220\necl:brn byr:1928 eyr:2029\n\neyr:2030\necl:oth cid:177 hcl:#602927\niyr:2010 hgt:66in\npid:915661465 byr:1992\n\necl:brn pid:558826437 hgt:151cm byr:1936 hcl:#fffffd\neyr:2021 iyr:2012\n\neyr:2033\niyr:2019 hgt:190cm byr:1953\nhcl:#6b5442\npid:584941735 ecl:hzl\n\nhgt:71cm\nbyr:2015 iyr:2025\necl:#663b65 eyr:2039 hcl:z pid:62548949\n\necl:hzl byr:1943\niyr:2020 hgt:175cm pid:830628564 hcl:#7d3b0c eyr:2021\n\nhgt:182cm byr:1951 cid:175 eyr:2021 pid:635966127 ecl:blu iyr:2014 hcl:#18171d\n\nhcl:#733820 iyr:2011 pid:581100835 eyr:2022 ecl:grn byr:1985 hgt:192cm\n\niyr:2013\necl:grn\nhgt:185cm hcl:#a97842 byr:1981 eyr:2029 pid:711625030\n\nbyr:1995\npid:326992839\niyr:2015\neyr:2028 hcl:#733820 ecl:hzl\n\nhgt:160\neyr:2037 ecl:#6b6b83\ncid:123 iyr:2028\npid:7692333345\nhcl:z byr:2029\n\nhcl:#6b5442 iyr:2030\nhgt:165cm byr:2028 ecl:#21516d\neyr:2039\npid:182cm\n\nhgt:159cm iyr:2018 pid:610521467 eyr:2028 ecl:amb byr:1934 hcl:#602927\n\necl:blu\nhcl:#09d9a5 hgt:162cm iyr:2020\neyr:2025 byr:1971 pid:406714780\n\nhgt:179cm eyr:2022 hcl:#18171d\necl:blu pid:314891131 iyr:2015\nbyr:2002\n\nhcl:#623a2f hgt:181cm pid:442693333 byr:1990 ecl:grn eyr:2027\niyr:2011\n\niyr:2022 eyr:1939\npid:557187110 hcl:#18171d hgt:60cm ecl:#d6ac04 byr:1984\n\necl:grn byr:1948 hgt:174cm pid:438876745 cid:321\niyr:2018\nhcl:#866857 eyr:2023\n\nhgt:189cm iyr:2012 hcl:#602927 pid:978388052 ecl:brn\neyr:2030\n\necl:amb cid:235\nbyr:1938\npid:315825546 hcl:#ceb3a1 eyr:2029\niyr:2013 hgt:171cm\n\necl:dne hcl:z\nhgt:76cm byr:2010\ncid:185 eyr:2001\n\nhcl:#733820 byr:1988 pid:558453117\nhgt:66in\necl:oth iyr:2010 eyr:2021\n\nbyr:1926 pid:796557821 cid:155 hcl:#efcc98\nhgt:159cm eyr:2023 ecl:oth iyr:2016\n\nbyr:2023 eyr:2031 hcl:0ba99a pid:14902250\nhgt:132 ecl:#9b89b1 iyr:2017\n\nhcl:#a97842 byr:1926\ncid:205\necl:blu\niyr:2016 hgt:159cm eyr:2029\n\nbyr:1939 hcl:#866857\npid:025607627 hgt:174cm cid:309 eyr:2026 ecl:brn\n\necl:hzl pid:805133506\niyr:2014\nbyr:1991\nhcl:#cfa07d\ncid:350\nhgt:190cm\n\nhgt:155cm byr:1941 eyr:2024\ncid:164 hcl:#602927 iyr:2013 pid:531781358 ecl:amb\n\nhcl:#72a068 hgt:164cm\npid:621006770\necl:brn\neyr:2029 byr:1969\n\nbyr:1991\necl:grn iyr:2020\npid:9921729009 eyr:2029 hcl:#623a2f\nhgt:62in\n\niyr:2017 ecl:hzl\npid:768217275 eyr:2020 byr:1937\nhcl:#866857 hgt:157cm\n\ncid:270 byr:1993 hcl:#733820 ecl:hzl pid:722650020\nhgt:174cm iyr:2010\neyr:2021\n\nhcl:#c0946f ecl:blu\nhgt:154cm\neyr:2022 byr:1929 pid:357023679 iyr:2010\n\necl:hzl\niyr:2013 hgt:165cm byr:1979 eyr:2023 hcl:#733820 pid:008734536\n\nhcl:#341e13\neyr:2030 byr:1993\niyr:2014 hgt:193cm\ncid:346\necl:blu pid:536339538\n\neyr:2030\necl:hzl\ncid:296 pid:660062554 hcl:#efcc98\nbyr:1977 hgt:179cm\niyr:2010\n\ncid:119 pid:498520651 hgt:159cm\neyr:2029 iyr:2015 hcl:#18171d\necl:gmt\nbyr:1950\n\neyr:2025 iyr:2010 hcl:#efcc98 pid:196372989 hgt:181cm byr:1952 ecl:oth\n\ncid:317\neyr:2026 ecl:blu hcl:#733820\nhgt:184cm\npid:549730813 byr:1927 iyr:2018\n\npid:591769824\nhgt:180cm\nbyr:1920\necl:blu\neyr:2021 hcl:#cfa07d iyr:2017\n\npid:988946348 hgt:183cm cid:117 byr:1955 ecl:blu\niyr:2015 hcl:#623a2f eyr:2029\n\niyr:2014\neyr:2026 hgt:184cm\necl:oth\nhcl:#7d3b0c pid:252101860\n\nbyr:1995\nhgt:182cm ecl:brn hcl:#6b5442\niyr:2012 eyr:2028 pid:482757872\n\niyr:2017 cid:333 ecl:gry hcl:#623a2f hgt:157cm eyr:2021\npid:487895819\nbyr:1951\n\nhcl:#fffffd\nhgt:193cm eyr:2025 byr:1927 iyr:2014 ecl:oth pid:989206297\n\neyr:2030 ecl:brn hcl:#18171d hgt:193cm\niyr:2013 byr:1953 pid:862636088\n\nhcl:#fffffd\npid:204286737 ecl:gry byr:1923\nhgt:181cm\niyr:2015\neyr:2023\n\ncid:288 pid:413935643 ecl:gry\niyr:2012\nhgt:171cm\nhcl:#623a2f\neyr:2020 byr:1943\n\nbyr:2023 hcl:#c0946f\necl:oth\npid:182634296 eyr:2009\ncid:306 hgt:183cm\niyr:2029\n\neyr:2026 ecl:hzl byr:2003\niyr:2027 pid:734296691 hgt:188cm hcl:#fffffd\n\nhcl:#18171d ecl:gry pid:401957684 eyr:2020\niyr:2017 cid:141 byr:1944 hgt:74in\n\necl:grn hcl:z\npid:335097003 byr:1925\nhgt:170in iyr:2020 eyr:2022\n\npid:727198487\nhgt:173cm\ncid:323 hcl:#18171d iyr:2012 eyr:2024\nbyr:1995 ecl:blu\n\necl:amb hcl:#602927\npid:460274414\nhgt:76in byr:1995\niyr:2020\neyr:2028\n\nbyr:2002 ecl:oth pid:101164770\nhgt:172cm hcl:#fffffd eyr:2023 iyr:2016\n\necl:blu hcl:#888785 iyr:2016 pid:031162631 eyr:2025 hgt:186cm\nbyr:1959\n\necl:blu pid:093242619 hgt:188cm byr:1970\neyr:2025\nhcl:#6b5442\niyr:2020\n\nbyr:1990 eyr:2025 ecl:grn\npid:907309460\niyr:2011 hcl:#602927 hgt:62in\n\npid:346468647 eyr:2021\necl:oth hgt:169cm\niyr:2010 cid:233\nhcl:#b6652a byr:1977\n\npid:904834317 iyr:2011\nhcl:#b6652a eyr:2028 cid:281\nbyr:1944 hgt:187cm ecl:gry\n\neyr:1988 pid:663941602\nhgt:156in\nhcl:#fa2e93 iyr:2015 ecl:gry byr:1953\n\nhgt:184cm cid:107 pid:094829817\necl:gry byr:1998 eyr:2023 iyr:2017\n\neyr:2020 ecl:gry byr:1955 hcl:#a97842 pid:553841536\n\nhgt:185cm eyr:2022 hcl:#341e13 ecl:oth byr:1934 pid:863541754 cid:178\niyr:2016\n\neyr:2029 iyr:2014 byr:1937 cid:232 hgt:177cm hcl:#fffffd ecl:blu\npid:076753558\n\nhcl:#cfa07d\nhgt:168cm\necl:grn\npid:664159349 eyr:2028 iyr:2017 byr:1972\n\nhcl:#a97842\nbyr:1987\neyr:2020 hgt:182cm\niyr:2018\necl:brn pid:560272731\n\nhgt:172cm cid:125 ecl:blu pid:291640184\nbyr:1926\niyr:2014 hcl:#ceb3a1\n\niyr:2027 hgt:84 hcl:z\necl:#b68fec\npid:809408661\nbyr:2018 eyr:1927 cid:87\n\npid:951007276 cid:260 eyr:2025\necl:brn iyr:2015 byr:1957\nhcl:#4b8216 hgt:161cm\n\npid:359973697 hcl:#6b5442\neyr:2022 hgt:169cm\nbyr:1965 ecl:brn iyr:2013\n\niyr:2012 hgt:65in eyr:2024 pid:842371195\necl:amb\nhcl:#341e13 byr:2000\n\necl:hzl hgt:170cm byr:1950\ncid:289 eyr:2037 iyr:2021 hcl:#18171d pid:389051819\n\nhgt:159cm\necl:amb hcl:#c0946f eyr:2020 pid:010539976 iyr:2011 byr:1921\n\nhgt:176cm cid:270 pid:838338992\neyr:2024 hcl:#866857\necl:amb iyr:2015 byr:1982\n\necl:blu\ncid:246 hgt:185cm\nbyr:1987\nhcl:#fffffd pid:042361456 eyr:2022\niyr:2010\n\nhgt:164cm\npid:881486702 ecl:brn byr:1969 hcl:#c0946f\niyr:2010 eyr:2030\n\niyr:2019 hcl:#6b5442 hgt:167cm\necl:amb\ncid:207 byr:1922\neyr:2025 pid:343956182\n\necl:oth iyr:2012\nhgt:158cm\neyr:2024 hcl:#602927 byr:1964\n\nbyr:1988 pid:030965463 hgt:154cm\necl:gry eyr:2020 cid:227\niyr:2012\nhcl:#3edc53\n\nhgt:178cm hcl:#c0946f byr:1945 ecl:amb eyr:2030\n\nhgt:158cm pid:270264980 eyr:2027 iyr:2016 byr:1928 cid:259\necl:gry hcl:#733820\n\nbyr:2026 hgt:164in cid:235 ecl:xry\nhcl:z pid:2517730699\neyr:2033 iyr:2024\n\necl:grn hgt:69cm pid:1321222581 byr:1987\neyr:2035\niyr:2018 hcl:#fffffd\n\nhcl:#733820 cid:244\necl:gry iyr:2013 eyr:2028\npid:794178180 hgt:74in byr:1923\n\nhcl:#a97842 byr:1934 ecl:hzl eyr:2027\npid:401882857\niyr:2018 hgt:185cm\n\niyr:2018\npid:665564950 byr:1990 ecl:hzl\nhgt:154cm\neyr:2026 hcl:#623a2f\n\nhcl:#602927 cid:189 byr:1967 pid:332861702 eyr:2021\nhgt:163cm\necl:amb\n\necl:grn pid:734161280 hgt:184cm\niyr:2018 eyr:2020 byr:1929 hcl:#a97842\n\niyr:2018 byr:1925\neyr:2022 hgt:193cm ecl:hzl\nhcl:#341e13\npid:008582320\n\nbyr:2025 ecl:dne hgt:167cm pid:48963526\niyr:2025 hcl:z\neyr:2034\n\nhcl:#cfa07d ecl:hzl eyr:2029 cid:194 byr:1936\niyr:2020\nhgt:186cm\npid:328573727\n\niyr:2011 hgt:188cm pid:338435675 cid:326 ecl:gry\neyr:2027\nhcl:#6b5442\nbyr:1958\n\npid:165cm\nhgt:70 iyr:1996\neyr:2034 cid:210 hcl:z ecl:#75606f byr:2027\n\nhgt:180in hcl:#a0515a pid:#97a753\nbyr:2026 iyr:2016\neyr:1995\n\neyr:2020\nhcl:#18171d byr:1978 iyr:2012 hgt:68in\necl:amb cid:346 pid:332495922\n\necl:blu hgt:61in pid:747650669\nbyr:1961 eyr:2028\niyr:2020\nhcl:#4992f2\n\nbyr:1958 iyr:2017 ecl:oth\nhgt:153cm\nhcl:#602927 eyr:2023 pid:108391213\n\nbyr:1976 eyr:2023 iyr:2015 hgt:177cm pid:391628371 hcl:#8069c4\necl:grn\n\npid:910402636 ecl:gry hgt:188cm byr:1924 hcl:#82dfdc eyr:2029\n\nbyr:1978 pid:302223240 iyr:2017\nhgt:174cm\nhcl:#6b6569 ecl:blu eyr:2027\n\ncid:135\nbyr:1995 iyr:2015 ecl:oth pid:054611703\neyr:2023\nhcl:#7d3b0c hgt:75in\n\necl:grn\neyr:2020 hgt:184cm pid:444944678 iyr:2019 hcl:#efcc98\n\nbyr:1946\nhgt:70in eyr:2022 hcl:#6b5442 ecl:amb iyr:2018 pid:859762925\n\nbyr:1995 eyr:2022\necl:grn pid:575081777\nhcl:#341e13\nhgt:183in iyr:2018\n\neyr:2028 hgt:162cm byr:1989 hcl:#0bd11f\niyr:2020 ecl:gry\npid:073498924\n\niyr:2014\npid:122787281 byr:1982 cid:138 eyr:2021 hcl:#866857 ecl:hzl hgt:184cm\n\ncid:198 byr:2014\npid:5529128129\nhgt:185in\niyr:2025\nhcl:z\neyr:2023\necl:gmt\n\neyr:2021 hgt:170cm\ncid:74\niyr:2019 pid:943445928 byr:1980\necl:oth hcl:#ceb3a1\n\niyr:2020 eyr:2030 pid:201122734 cid:246 hgt:169cm ecl:grn hcl:#fffffd byr:1962\n\npid:025560194\nbyr:1989\nhcl:#cfa07d hgt:182cm ecl:blu eyr:2025 iyr:2012\n\nhgt:151cm\nhcl:#efcc98 ecl:blu\nbyr:1983 eyr:2023 pid:814513328 iyr:2013 cid:73\n\nbyr:1961 pid:536384108 hgt:188cm ecl:amb iyr:2013 eyr:2027 hcl:#888785 cid:121\n\npid:364607819\neyr:2024 ecl:amb hcl:#b6652a iyr:2016\nbyr:2000 hgt:187cm\n\nhcl:z eyr:1956 iyr:2028\nhgt:168cm cid:105\nbyr:2026\necl:#5b17d3\n\ncid:207 pid:913509058 ecl:brn byr:2001 eyr:2026\nhcl:#866857 iyr:2019\nhgt:180cm\n\npid:363979129\neyr:2027 iyr:2013\necl:gry hcl:#866857 byr:1957 hgt:62in\n\nbyr:1932\neyr:2027\nhgt:66in ecl:hzl hcl:#efcc98 pid:417620217 iyr:2013\n\niyr:2013 cid:331 hgt:192cm\nhcl:#d896d9 pid:795744816 byr:1935\n\nbyr:1960 hcl:#888785 hgt:176cm ecl:hzl pid:025206542\niyr:2015 eyr:2030\n\necl:oth hgt:182cm\nhcl:#341e13\npid:526568190 iyr:2018 cid:280 byr:1997\neyr:2028\n\nhgt:186cm pid:273625601 byr:1993 iyr:2018 eyr:2021 hcl:#733820\necl:blu\n\nhgt:74cm\nbyr:1981 eyr:2024\necl:amb iyr:2012 pid:154027492 hcl:#733820\n\nhcl:#a97842 pid:347084450 ecl:oth\neyr:2030 hgt:176cm byr:1955 cid:229\niyr:2013\n\nhcl:#fffffd byr:1979 iyr:2017\npid:183840860 hgt:177cm ecl:blu eyr:2023\n\npid:045246162 eyr:2021 byr:1928 hgt:190cm ecl:gry hcl:#602927\n\npid:273620987\neyr:2022 hgt:162cm\ncid:269\nbyr:1991 hcl:#602927 ecl:amb iyr:2019\n\npid:621069556 ecl:amb\ncid:202 byr:2020 hgt:189cm\niyr:2014 hcl:#fffffd\neyr:2027\n\neyr:2022 byr:1988\nhgt:190cm\npid:349839553 hcl:#602927 iyr:2018 ecl:gry\n\niyr:2014 ecl:gry\nhcl:#733820 eyr:2025 hgt:179cm pid:231854667 byr:1984\ncid:102\n\neyr:2020\npid:509400891 hcl:#cfa07d hgt:172cm\necl:grn byr:1997 iyr:2020\n\niyr:2017 byr:1994 hgt:174cm ecl:amb\npid:685743124\nhcl:#fffffd eyr:2029\n\niyr:2012 hgt:177cm byr:1999 pid:549190825 hcl:#b6652a eyr:2028 ecl:oth cid:316\n\nhgt:192cm ecl:grn byr:1924\niyr:2011 eyr:2029 hcl:#efcc98\npid:215962187\n\niyr:2011 hcl:#866857\ncid:164\nhgt:184cm\necl:gry eyr:2023 byr:1959 pid:204093118\n\nhgt:172cm ecl:hzl hcl:#3f2f3a pid:623470811 byr:1938 iyr:2013 eyr:2022\n\nhcl:#b6652a\niyr:2019 hgt:152in\necl:oth\npid:189008850 byr:2006\n\necl:oth hcl:#602927\npid:049746898 byr:1924 hgt:150cm eyr:2026\niyr:2014\n\necl:oth\neyr:2028 byr:2018 hcl:#733820\npid:8676207205 iyr:2018\nhgt:190cm\n\neyr:2023 cid:308 hgt:170cm ecl:oth iyr:2014 hcl:#18171d pid:874405208 byr:1936\n\neyr:2021 ecl:hzl\npid:423603306\nhcl:#c0946f cid:147\nbyr:1988 iyr:2016 hgt:164cm\n\nhgt:176cm iyr:2010\nhcl:#6b5442 cid:280 byr:1988 ecl:hzl pid:967151288 eyr:2028\n\ncid:299 hgt:163cm ecl:gry\npid:561439154 eyr:2023\nhcl:#cfa07d iyr:2019 byr:1959\n\npid:635547007\necl:blu\nbyr:1996 hcl:#7d3b0c cid:280 eyr:2023\nhgt:170cm iyr:2017\n\nhcl:#888785 iyr:2014\necl:brn\nhgt:190cm byr:1941 eyr:2021\n\nhcl:#c0946f cid:199 hgt:162cm ecl:amb pid:130696599 eyr:2022 iyr:2018 byr:1948\n\ncid:314 hcl:#a4fc09 ecl:hzl iyr:2019\npid:886849824 eyr:2026 byr:1933 hgt:178cm\n\nbyr:1996 iyr:2016 eyr:2030 hgt:169cm\npid:119207760\nhcl:#ef542c\necl:brn\n\niyr:2030 eyr:2039 hcl:#c0946f pid:#7336a0 hgt:182cm cid:347\necl:#c81361 byr:2003\n\npid:727812879 iyr:2013 eyr:2027 hgt:172cm\nhcl:#7d3b0c ecl:gry byr:1966\n\nhcl:#341e13\niyr:2016 pid:744997238\ncid:322\nbyr:1973\necl:hzl eyr:2028 hgt:190cm\n\nhgt:171cm eyr:2026\niyr:2014 ecl:oth\npid:074049558 hcl:#04083f byr:1923\n\npid:973713235\neyr:2021\necl:brn\nbyr:1922 hcl:#fffffd iyr:2012\nhgt:178cm\n\necl:#10165d\ncid:201 eyr:2026 pid:#ceefa8 byr:2020\nhgt:164cm iyr:2011\nhcl:9fccf7\n\necl:blu\nhgt:165cm iyr:2012 eyr:2025 pid:775787557\nbyr:1952 hcl:#623a2f\n\npid:6186829005 ecl:lzr hcl:z hgt:69in iyr:2021 byr:2018 eyr:1974\n\npid:824641755 eyr:2028 byr:1950 hgt:184cm\nhcl:#c0946f\niyr:2014\n\nhcl:#7d3b0c cid:84 hgt:187cm iyr:2015\npid:895876610\nbyr:1988 eyr:2023\n\nhcl:#fffffd\nhgt:157cm iyr:2020 eyr:2030 ecl:grn pid:486236241\n\niyr:2010\neyr:2029\nhgt:74in ecl:hzl byr:1926 pid:348573885 hcl:#9d1214\n\nhgt:171cm ecl:oth\neyr:2022 pid:148728436 byr:1993 hcl:#a97842 iyr:2013\n\niyr:2019\nhgt:151cm\neyr:2020 pid:319882814 ecl:grn byr:1966 cid:256 hcl:#3107b3\n\nhgt:184cm ecl:grn\nbyr:1947\neyr:2025 iyr:2015 pid:827962962 cid:62 hcl:#f3a364\n\niyr:2013\nhcl:#fffffd pid:215012801 ecl:amb eyr:2024\nhgt:154cm\nbyr:1973\n\necl:hzl hgt:152cm\nhcl:#623a2f\nbyr:1944 eyr:2022 pid:295632731\ncid:243 iyr:2019\n\necl:brn\niyr:2011 pid:089250747 byr:1984 hcl:73e739 cid:253 hgt:161cm eyr:2021\n\nhcl:#18171d byr:1944 pid:732054667 eyr:2021\necl:oth hgt:173cm\n\necl:gry pid:445116331\nhcl:#a97842\nhgt:187cm eyr:2026 iyr:2020 byr:1992\n\nhcl:80c091 pid:745555899\niyr:2021\nhgt:170cm\nbyr:1990\n\npid:058987865 byr:1927 cid:209\nhcl:#65ccf6 eyr:2025\necl:brn iyr:2012 hgt:164cm\n\nhgt:67cm\nbyr:2026 hcl:f8e749 iyr:2023 eyr:1921 ecl:lzr\n\neyr:2028 iyr:2013 pid:103268377 hgt:179cm byr:1922\necl:hzl\nhcl:#7d3b0c\n\nbyr:1923 ecl:gry hgt:167cm hcl:#7fc8ee iyr:2015 pid:427963077 eyr:2024\n\nbyr:1927 ecl:grn pid:741328150\neyr:2029 hcl:#733820\niyr:2015 hgt:157cm\n\nhgt:70cm hcl:e76970 iyr:1945 cid:186\nbyr:1921 eyr:2029\npid:823622634\necl:zzz\n\nhgt:61cm cid:87 hcl:d5e5ff\neyr:2024 ecl:dne pid:182634269\niyr:2029\n\nhcl:#623a2f eyr:2020 byr:1936 ecl:gry pid:236984204\niyr:2011 hgt:156cm\n\npid:872645776\nbyr:2023\ncid:220 ecl:blu hgt:172cm eyr:2033\niyr:2010 hcl:ff82f9\n\npid:774489073 iyr:2013 byr:1922 ecl:brn eyr:2025 hcl:#18171d hgt:163cm\n\neyr:2024 hgt:65in byr:1962 iyr:2019\npid:112233558 hcl:#888785 ecl:grn\n\nhgt:172cm eyr:2022\nhcl:#18171d ecl:blu\npid:609008608 iyr:2013\ncid:244 byr:1980\n\ncid:124 hgt:175in eyr:2025\nhcl:674e80 pid:099875931 iyr:1956\n\nbyr:1926 hgt:188cm\necl:hzl eyr:2021\niyr:2018\nhcl:#866857 pid:557800355\n\nbyr:1939 pid:200409089\neyr:2026 hgt:164cm\necl:grn iyr:2013\nhcl:#733820\n\ncid:73 hgt:169cm iyr:2016 byr:1976 ecl:gry eyr:2024\npid:043453462\n\npid:609818712 hcl:#733820 byr:1958\neyr:2025 hgt:187cm iyr:2017 ecl:gry\n\nhgt:66in pid:618590610 iyr:2013 byr:1938 hcl:#d1bda9\neyr:2022\necl:grn cid:69\n\nhgt:156cm pid:755742405\nbyr:1929 hcl:#6b5442 eyr:2024\niyr:2018\necl:gry\ncid:105\n\neyr:2030 pid:77022842\nhgt:160cm byr:1989\niyr:2011 hcl:#7d3b0c ecl:blu\n\niyr:2015\nhcl:#341e13 byr:1968 pid:434159843\necl:amb hgt:150cm\neyr:2030\n\nhcl:z eyr:1993 pid:#b3a5a6 iyr:1947 hgt:176in\necl:#78876d\n\ncid:249 hcl:#cfa07d\nhgt:180cm ecl:gry eyr:2026 byr:1965\npid:048327438 iyr:2010\n\npid:136468890 ecl:gry\nbyr:1940\nhcl:#fffffd hgt:185cm iyr:2016 eyr:2021\n\nhcl:#b6652a hgt:180in byr:1976 eyr:2022 pid:156cm ecl:#737836\niyr:2013\n\necl:amb iyr:2016 hgt:162cm byr:1955 pid:193cm eyr:2028 cid:346\nhcl:#733820\n\niyr:2010 byr:1932 eyr:2025 ecl:grn\npid:595837820\nhcl:#341e13\nhgt:166cm cid:224\n\npid:481646831\neyr:2029\nhcl:#623a2f cid:319 iyr:2016\necl:brn hgt:160cm byr:1944\n\necl:zzz pid:428329840 cid:238 iyr:2022 hgt:76cm\nhcl:#a97842\nbyr:2024 eyr:2028\n\niyr:2014 hgt:170cm\nbyr:1963 hcl:#623a2f\neyr:2026 pid:225910806 ecl:gry\n\necl:grn iyr:2010 hgt:193cm byr:1928 eyr:2028 pid:343022641 hcl:#733820\n\neyr:2023 ecl:grn\nbyr:1950 iyr:2012 hcl:#866857 pid:400725165\nhgt:193cm\n\ncid:195 iyr:2014 ecl:oth eyr:2027 byr:1966\nhgt:177cm hcl:#18171d pid:913894485\n\niyr:2015 hgt:154cm\ncid:206\npid:134599284 hcl:#602927\neyr:2023 ecl:brn\nbyr:1983\n\necl:#2d0e7a pid:#f34625 eyr:1942 iyr:2027 byr:2013 hcl:z hgt:162cm\n\nhgt:189cm byr:1965 iyr:2011\ncid:178 ecl:hzl\nhcl:#b6652a eyr:2026 pid:683560227\n\neyr:2030 pid:047446524 ecl:grn hgt:167cm iyr:2017 hcl:#602927\nbyr:1920\n\ncid:86\niyr:1920 hgt:193cm\neyr:2027 pid:401913877 ecl:hzl\nhcl:#888785 byr:1953\n\nbyr:1991\necl:grn\niyr:2016\nhcl:#5e1ef2 hgt:186cm\npid:076499738\neyr:2025\n\neyr:2030 hcl:#18171d pid:750694893\nhgt:157cm iyr:2020 cid:338\nbyr:1956 ecl:gry\n\niyr:2027 pid:#37f002 hgt:164cm ecl:#80df11\nhcl:#aeacee cid:320\neyr:2039 byr:1956\n\niyr:2014 hcl:#733820 ecl:grn\nbyr:1960\neyr:2025 pid:667089568\n\nhgt:163cm\nbyr:1962 cid:108 ecl:gry hcl:#733820 iyr:2012\neyr:2029 pid:763684725\n\nbyr:1984 hcl:#888785 hgt:159cm iyr:2012 ecl:gry\neyr:2024 cid:236 pid:174711749\n\necl:gry pid:044931271\nhcl:#b6652a eyr:2029 iyr:2013 byr:1985\n\nbyr:1973 iyr:2018 hcl:#a97842 pid:937214113 ecl:blu\ncid:247 hgt:186cm eyr:2023\n\ncid:108 pid:231782961 iyr:2017\neyr:2034 hgt:170cm byr:2025 hcl:#18171d ecl:utc\n\npid:298274796 byr:1928 hcl:#a97842 hgt:188cm iyr:2011 ecl:gry eyr:2028\n\nhgt:65cm iyr:1943 eyr:2025\nhcl:z\npid:65702335 ecl:#bb54e6 byr:2010\n\npid:499116613 eyr:2024\necl:gry hcl:#cfa07d hgt:193cm byr:1999\ncid:278 iyr:2015\n\nhcl:#6b5442 eyr:2027 hgt:175cm byr:1988\necl:brn pid:410075320 iyr:2010\n\npid:269678991 ecl:oth iyr:2013\nhcl:#602927 byr:1991 eyr:2023\n\necl:oth\npid:144593265 hcl:#fffffd\neyr:2020 iyr:2018\nbyr:1975 hgt:160cm\ncid:304\n\niyr:2014 hcl:#ceb3a1 eyr:2029\nbyr:1951 pid:520804395 hgt:185cm ecl:oth\n\nhgt:159cm\npid:312887994\ncid:205\niyr:2016 ecl:hzl hcl:#866857 eyr:2029 byr:1944\n\niyr:2023 ecl:#54c85c byr:2030\neyr:1946 cid:190 pid:512417622\n\nbyr:1946 eyr:2023 hgt:163cm\nhcl:#2d4e9c ecl:brn pid:839043333 iyr:2014\n\niyr:2027 cid:122 hgt:187cm eyr:1975 ecl:grn byr:1920\nhcl:#c0946f\n\neyr:2029 hgt:189cm ecl:blu byr:1922 iyr:2016\npid:924104599\nhcl:#b6652a\n\nhgt:162cm\niyr:2016 byr:1921 hcl:#18171d eyr:1938 ecl:hzl\npid:682222023\n\ncid:118 pid:959515596\nbyr:1921 iyr:2010 eyr:2029 hcl:#7d3b0c ecl:oth hgt:158cm\n\necl:#8ac844 pid:162cm\nhcl:8f4d80 hgt:150in byr:2005\neyr:2008\niyr:2017 cid:174\n\nhcl:z byr:1936\npid:255481052 eyr:2021\niyr:2012 hgt:170cm cid:276 ecl:hzl\n\niyr:2013 byr:1935 hgt:179cm\neyr:2023 ecl:amb pid:073621563 hcl:#623a2f\n\nhcl:#18171d cid:230 byr:1989 ecl:oth eyr:2021 hgt:181cm pid:661224730\niyr:2019\n\npid:748039140 iyr:2020 eyr:2020 ecl:#6ebbc2 hcl:#fffffd hgt:171cm\nbyr:1995\n\necl:hzl pid:758144605 hcl:#ceb3a1 hgt:186cm\neyr:2028 iyr:2014\nbyr:1928\n\necl:hzl\nhgt:66in\nbyr:2000 iyr:2017 eyr:2020\npid:162973694 hcl:#a97842\n\niyr:2012 pid:749770535\nbyr:1969 cid:148\nhcl:#733820\nhgt:180cm eyr:2021 ecl:hzl\n\niyr:2010\nbyr:1958\nhgt:164cm\necl:blu hcl:#733820 pid:890634327 eyr:2024\n\nhgt:70in pid:218397894\niyr:2020 eyr:2025 ecl:gry hcl:#341e13\nbyr:1970\n\neyr:2020 pid:854208004 hgt:157cm hcl:#7d3b0c ecl:amb byr:1981 iyr:2020\n\nbyr:1924\ncid:321 eyr:2028 hcl:#cfa07d iyr:2010 ecl:amb pid:036669613 hgt:170cm\n\necl:#6649d4 pid:0026989865 cid:188\nhgt:152in\nbyr:1950 hcl:z eyr:1928 iyr:1963\n\nhcl:#ceb3a1 ecl:grn eyr:2028 pid:074363489 iyr:2010 hgt:173cm byr:1966\n\neyr:2030\npid:9731612333 ecl:#f8824c\niyr:2022 hgt:161in\nbyr:2023\ncid:316\nhcl:z\n\nhgt:175cm iyr:2016 eyr:2024 cid:244\nbyr:1952\npid:085432899\nhcl:#fffffd ecl:brn\n\necl:brn eyr:2026 iyr:2017 hgt:75in\npid:745302991 byr:1969 hcl:#7394c7", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"ecl:gry pid:860033327 eyr:2020 hcl:#fffffd\nbyr:1937 iyr:2017 cid:147 hgt:183cm\n\niyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884\nhcl:#cfa07d byr:1929\n\nhcl:#ae17e1 iyr:2013\neyr:2024\necl:brn pid:760753108 byr:1931\nhgt:179cm\n\nhcl:#cfa07d eyr:2025 pid:166559648\niyr:2011 ecl:brn hgt:59in", Scope = Private
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
