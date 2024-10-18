function getIOC {
$url = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.6/IOC.html

# get tr elements
$trs = $url.parsedhtml.body.GetElementsbytagname("tr")

# empty array
$Table = @()

for($i-1; $i -lt $trs.length; $i++) {
    # get td element of tr elements
    $td = $trs[$i].getElementsbytagname("td")
    $Table += [pscustomobject]@{
                                "Pattern" = $td[0].innertext;
                                "Explanation" = $td[1].innertext;
                                }
    }
return $Table
}
# getIOC
