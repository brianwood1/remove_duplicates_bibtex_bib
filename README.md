# remove_duplicates_bibtex_bib
This is r code that will all duplicate entries from a bibtex bibliography file, checking the fields you specify to determine if a duplicate entry exists. Here is an example of how the code works:

```
clean_bib(in_file="dirty_bibliography.bib", out_file="clean_bibliography.bib", remove_collisions_on_fields=c("title"), ignore_case=TRUE)
```
