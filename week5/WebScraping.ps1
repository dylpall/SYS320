clear
$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.8/ToBeScrapedHere.html
<#
# Get a count of the links in the page
$scraped_page.Links.href

# Display links as HTML element
$scraped_page.Links

# Display only URL and its text
$scraped_page.Links | Select-Object outerText, href

# Get outer text of every element with the tag h2
$h2s=$scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object outerText
$h2s
#>
# Print innterText of every element that has the class as "div-1"
$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { `
$_.getAttributeNode("class").Value -ilike "div-1"} | select innerText

$divs1

function gatherCLasses(){
$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.8/Courses-1.html

# Get all the tr elements of HTML document
$trs=$page.ParsedHtml.Links.getElementsByTagName("tr")
