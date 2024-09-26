clear

$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.8/ToBeScrapedHere.html

# Get a count of the links in the page
$scraped_page.Links.href

# Display links as HTML element
$scraped_page.Links

# Display only URL and its text
$scraped_page.Links | Select-Object outerText, href

# Get outer text of every element with the tag h2
$h2s=$scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object outerText
$h2s

# Print innterText of every element that has the class as "div-1"
$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { `
$_.getAttributeNode("class").Value -ilike "div-1"} | select innerText

$divs1

function gatherClasses(){

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.8/Courses.html

# Get all the tr elements of HTML document
$trs=$page.ParsedHtml.body.getElementsByTagName("tr")

# Empty array to hold results
$FullTable = @()
for($i=1; $i -lt $trs.length; $i++){ # Going over every tr element

    # Get every td element of current tr element
    $tds = $trs[$i].getElementsByTagName("td")

    # Want to separate start time and end time from one time field
    $Times = $tds[5].innerText.split("-")

    $FullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText; `
                                    "Title"      = $tds[1].innerText; `
                                    "Days"       = $tds[4].innerText; `
                                    "Time Start" = $Times[0]; `
                                    "Time End"   = $Times[1]; `
                                    "Instructor" = $tds[6].innerText; `
                                    "Location"   = $tds[9].innerText; `
                                }
}
return $FullTable
}


function daysTranslator($FullTable){

# Go over every record in the table
for($i=0; $i -lt $FullTable.length; $i++){

# Empty array to hold days for every record
$Days = @()

# If  you see "M" --> Monday
if($FullTable[$i].Days -ilike "M*"){ $Days += "Monday" }

# If you see "T" followed by T,W,F -> Tuesday
if($FullTable[$i].Days -ilike "*T[FTW]*") { $Days += "Tuesday" }

# If you see "W" -> Wednesday
if($FullTable[$i].Days -ilike "*W*") { $Days += "Wednesday" }

# If you see "TH" -> Thursday
if($FullTable[$i].Days -ilike "*TH*") { $Days += "Thursday" }

# F -> Friday
if($FullTable[$i].Days -ilike "*F") { $Days += "Friday" }

# Make the switch
$FullTable[$i].Days = $Days
}
return $FullTable
}

