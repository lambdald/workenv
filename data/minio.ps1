Invoke-WebRequest -Uri "https://dl.min.io/enterprise/minio/release/windows-amd64/minio.exe" -OutFile "C:\minio.exe"
setx MINIO_ROOT_USER admin
setx MINIO_ROOT_PASSWORD password
C:\minio.exe server F:\Data --console-address ":9001"