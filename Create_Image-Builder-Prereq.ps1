# Azure Image Builder Portal Integration Inline Commands

# Inline command to download and extract AZCopy
New-Item -Type Directory -Path 'c:\' -Name ImageBuilder
invoke-webrequest -uri 'https://aka.ms/downloadazcopy-v10-windows' -OutFile 'c:\ImageBuilder\azcopy.zip'
Expand-Archive 'c:\ImageBuilder\azcopy.zip' 'c:\ImageBuilder'
copy-item 'c:\ImageBuilder\azcopy_windows_amd64_*\azcopy.exe\' -Destination 'c:\ImageBuilder'

# Inline command that uses AZCopy to download the archive file and extract to the ImageBuilder directory
# Use the SAS URL for the <ArchiveSource>
c:\ImageBuilder\azcopy.exe copy 'https://ramboeckit.blob.core.windows.net/azureimagebuilder/Software.zip?sp=r&st=2025-04-21T09:56:50Z&se=2025-04-21T17:56:50Z&spr=https&sv=2024-11-04&sr=b&sig=DuQ1FfBRdNpLwBqvFjRWIRqxGCysoUuWZiDByVhaMNk%3D' c:\ImageBuilder\software.zip
Expand-Archive 'c:\ImageBuilder\software.zip' c:\ImageBuilder
