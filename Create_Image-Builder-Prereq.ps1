# Inline command to download and extract AZCopy
New-Item -Type Directory -Path 'c:\\' -Name ImageBuilder,
invoke-webrequest -uri 'https://aka.ms/downloadazcopy-v10-windows' -OutFile 'c:\\ImageBuilder\\azcopy.zip',
Expand-Archive 'c:\\ImageBuilder\\azcopy.zip' 'c:\\ImageBuilder',
copy-item 'C:\\ImageBuilder\\azcopy_windows_amd64_*\\azcopy.exe\\' -Destination 'c:\\ImageBuilder'