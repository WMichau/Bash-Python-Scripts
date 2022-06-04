$IP = Read-Host "IP: "
$Username = ''
$Password = ''
$pass = ConvertTo-SecureString -AsPlainText $Password -Force
$SecureString = $pass
$MySecureCreds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username,$SecureString

psexec.exe \\$IP -u $Username -p $Password powershell.exe -command "& {Enable-PSRemoting -Force}"

Invoke-Command -ComputerName $IP -ScriptBlock { 

$file = "C:\Program Files\iso\rpos\bin\jpos.xml";
$o_string = Select-String -Path $file -Pattern 'readPower' | Select -ExpandProperty Line;

$old_value = $o_string -replace "[^0-9]" , '';

Write-Host -NoNewLine 'Current Value:' $old_value"`n";
$new_value = Read-Host "New Value: ";

$n_string ='        <prop name="readPower" value="' + $new_value + '"/>';

(Get-Content $file).Replace($o_string, $n_string) | Set-Content $file;

 } -Credential $MySecureCreds



