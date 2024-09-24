
./proxy.ps1

winget install JanDeDobbeleer.OhMyPosh -s winget

oh-my-posh font install --user
# Meslo

echo $PROFILE


# Set-ExecutionPolicy RemoteSigned
# Get-ExecutionPolicy

Install-Module -Name posh-git -Scope CurrentUser -Y
Install-Module PSReadLine -Force

$posh_config=@"
oh-my-posh init pwsh --config $env:POSH_THEMES_PATH\montys.omp.json | Invoke-Expression
Import-Module posh-git # 引入 posh-git
Import-Module PSReadLine # 历史命令联想
# 设置预测文本来源为历史记录 
Set-PSReadLineOption -PredictionSource History 
# 设置 Tab 为菜单补全和 Intellisense 
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete 
# 每次回溯输入历史，光标定位于输入内容末尾 
Set-PSReadLineOption -HistorySearchCursorMovesToEnd 
# 设置向上键为后向搜索历史记录 
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward 
# 设置向下键为前向搜索历史纪录 
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
"@
$posh_config | Add-Content -Path $PROFILE
