$env.PATH = (
  $env.PATH
  | split row (char esep)
  | append ~/devlibs/bin
  | append ~/devlibs/cuda-12.1/bin
  | uniq # filter so the paths are unique
)


$env.LD_LIBRARY_PATH = (
  $env.LD_LIBRARY_PATH
  | split row (char esep)
  | append ~/devlibs/lib
  | append ~/devlibs/cuda-12.1/lib64
  | uniq # filter so the paths are unique
)
