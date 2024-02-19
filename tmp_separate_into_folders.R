files <- list.files(pattern = "*.Rmd")

# for each rmd create dir
for (f in files) {
  # extension remove
  dir_name <- fs::path_ext_remove(f)
  if (!dir.exists(dir_name)) {
    dir.create(dir_name)
  }
  fs::file_move(f, fs::path(dir_name, f))
}
