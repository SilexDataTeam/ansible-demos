#!powershell

# Copyright: (c) 2024, Matthew Hyclak (@mhyclak-silex)
# Copyright: (c) 2020, Brian Scholer (@briantist)
# Copyright: (c) 2015, Jon Hawkesworth (@jhawkesworth) <figs@unity.demon.co.uk>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic
#AnsibleRequires -PowerShell Ansible.ModuleUtils.AddType

$spec = @{
    options = @{
        convert_number = @{ type = "int"; required = $true }
    }
    mutually_exclusive = @()
    required_one_of = @()
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
function NumbersToWords {
    [CmdletBinding(SupportsShouldProcess = $true)]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory = $true)]
        [Ansible.Basic.AnsibleModule]
        $Module,

        [Parameter(Mandatory = $true)]
        [int]
        $ConvertNumber
    )
    Process {
        $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
        $headers.Add("Content-Type", "text/xml; charset=utf-8")

        $body = "<?xml version=`"1.0`" encoding=`"utf-8`"?>`n<soap:Envelope xmlns:soap=`"http://schemas.xmlsoap.org/soap/envelope/`">`n  <soap:Body>`n    <NumberToWords xmlns=`"http://www.dataaccess.com/webservicesserver/`">`n      <ubiNum>$ConvertNumber</ubiNum>`n    </NumberToWords>`n  </soap:Body>`n</soap:Envelope>"

        $response = Invoke-RestMethod 'https://www.dataaccess.com/webservicesserver/NumberConversion.wso' -Method 'POST' -Headers $headers -Body $body
        $words = $response.Envelope.Body.NumberToWordsResponse.NumberToWordsResult.Trim()

        $ret = @{
            changed = $false
            words = $words
        }

        $ret
    }
}

$module.Result.words = ""
$convert_number = $module.Params.convert_number

$result = NumbersToWords -Module $module -ConvertNumber $convert_number

$module.Result.changed = $module.Result.changed -or $result.changed
$module.Result.words = $result.words

$module.ExitJson()