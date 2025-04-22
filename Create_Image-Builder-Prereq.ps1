# Azure Image Builder Portal Integration Inline Commands

# Inline command to download and extract AZCopy
New-Item -Type Directory -Path 'c:\' -Name ImageBuilder
invoke-webrequest -uri 'https://aka.ms/downloadazcopy-v10-windows' -OutFile 'c:\ImageBuilder\azcopy.zip'
Expand-Archive 'c:\ImageBuilder\azcopy.zip' 'c:\ImageBuilder'
copy-item 'c:\ImageBuilder\azcopy_windows_amd64_*\azcopy.exe\' -Destination 'c:\ImageBuilder'

# Inline command that uses AZCopy to download the archive file and extract to the ImageBuilder directory
# Use the SAS URL for the <ArchiveSource>
c:\ImageBuilder\azcopy.exe copy 'https://ramboeckit.blob.core.windows.net/azureimagebuilder?sp=r&st=2025-04-22T16:48:32Z&se=2025-05-07T23:48:32Z&spr=https&sv=2024-11-04&sr=c&sig=PVSkVAxqnwQpDbuocyOz9gC7Qs6pn1sElJKBoxq2p6U%3D' c:\ImageBuilder\software.zip
Expand-Archive 'c:\ImageBuilder\software.zip' c:\ImageBuilder
