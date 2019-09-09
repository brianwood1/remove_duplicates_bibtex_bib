
if("RefManageR" %in% rownames(installed.packages()) == FALSE) {install.packages("RefManageR")}
library(RefManageR)

clean_bib <- function(in_file=NA, out_file=NA, remove_collisions_on_fields=c("title"), ignore_case=TRUE)
{
  
  
  bib <- ReadBib(file=in_file)
  
  n_fields_to_check <- length(remove_collisions_on_fields)
  
  if(n_fields_to_check > 1)
  {
    temp_bib <- paste(tempfile(), ".bib", sep="")
  }
  
  for(i in 1:n_fields_to_check)
  {
    the_field <- remove_collisions_on_fields[i]
    #fields needing to be checked for equality (all must be unequal to be added to bib)
    
    if(i > 1)
    {
      bib <- ReadBib(file=temp_bib)
    }
    
    BibOptions(merge.fields.to.check=the_field, ignore.case=ignore_case)
    n_entries <- length(bib)
    new_clean_bib <- bib[1]
  
  
    suppressMessages(
  
    for(j in 2:n_entries)
    {
      new_clean_bib <- new_clean_bib + bib[j]
    }
  
  )
  
  n_entries_new <- length(new_clean_bib)
  
  if(i==n_fields_to_check)
  {
    suppressMessages(
    WriteBib(bib = new_clean_bib, file = out_file)
    )
  } else {
    suppressMessages(
      WriteBib(bib = new_clean_bib, file = temp_bib)
    )
  }
  
  
  }
  rm(bib)
}




run_clean_bib_tests<-function(directory_of_test_files="~/Dropbox/Software/clean_bibtex_bib/")
{
  setwd(directory_of_test_files)
  clean_bib_t1()
  clean_bib_t2()
  clean_bib_t3()
}

#test collisions on title, case ignored
clean_bib_t1 <- function()
{
  in_file=c("sample_library_1.bib")
  out_file = paste(tempfile(), ".bib", sep="")
  remove_collisions_on_fields=c("title")
  ignore_case=TRUE
  clean_bib(in_file=in_file, out_file=out_file, remove_collisions_on_fields=remove_collisions_on_fields, ignore_case=ignore_case)
  r <- suppressMessages(ReadBib(file=out_file))
  pass_test <- length(r)==2
  print(paste("Testing collisions on title, with case ignored. Test passes:", pass_test))
  
}

#test collisions on title, case considered
clean_bib_t2 <- function()
{
  in_file=c("sample_library_1.bib")
  out_file = paste(tempfile(), ".bib", sep="")
  remove_collisions_on_fields=c("title")
  ignore_case=FALSE
  clean_bib(in_file=in_file, out_file=out_file, remove_collisions_on_fields=remove_collisions_on_fields, ignore_case=ignore_case)
  r <- suppressMessages(ReadBib(file=out_file))
  pass_test <- length(r)==3
  print(paste("Testing collisions on title, with case considered. Test passes:", pass_test))
}

#test collisions on title (case ignored) OR DOI
#collisions on either title or DOI will result in that reference being removed from the bib
clean_bib_t3 <- function()
{
  in_file=c("sample_library_1.bib")
  out_file = paste(tempfile(), ".bib", sep="")
  remove_collisions_on_fields=c("title", "doi")
  ignore_case=TRUE
  clean_bib(in_file=in_file, out_file=out_file, remove_collisions_on_fields=remove_collisions_on_fields, ignore_case=ignore_case)
  r <- suppressMessages(ReadBib(file=out_file))
  pass_test <- length(r)==1
  print(paste("Testing collisions on title, case ignored, OR DOI. Test passes:", pass_test))
}









