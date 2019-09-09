# remove_duplicates_bibtex_bib

This is R code that extends the functionality of Mathew McLean's RefManageR package. This code will injest an existing bibtex bibliography file, and then remove all duplicate entries from that file, checking the fields you specify to determine if a duplicate entry exists. 

# Inspiration

I use Zotero for organizing my bibtex bibliography. I use a variety of tools for importing bibliographic entries into Zotero, and duplicate entries have a way of finding their way into my master bibliography. Zotero has a UI feature that allows you to identify duplicates, but it is not efficient. A user must hand-check each duplicate identified, and then determine which entry to keep, ad nauseum. Better to just run a script, and let the software remove all duplicate entries! That is what this software does.

An additional inspiration for this code comes from the fact that RefManageR uses somewhat obscure syntax and symbols in its code for working with bibliographic entries, and I thought it would be better to make use of RefManageR functionality with simpler programming conventions.

# Example code

Here is an example of how the code works:

```
clean_bib(in_file="dirty_bib.bib", out_file="clean_bib.bib", remove_collisions_on_fields=c("title"), ignore_case=TRUE)
```
When this code runs, the first entry that is unique according to title, case ignored, will be retained, and all later entries found to be duplicates will be removed. 

Here is slightly more complex example:
```
clean_bib(in_file="dirty_bib.bib", out_file="clean_bib.bib", remove_collisions_on_fields=c("title", "doi"), ignore_case=TRUE)
```
When this code runs, the first entry that is unique according to title (case ignored) and DOI will be retained, and all later entries that are duplicates according to *either* their titles *OR* their DOI, will be removed. Please pay attention to how this works. 

For safety's sake, I recommend only using 'title' and 'doi' for removing duplicates from your bibliography. The reason is that if you were to use, for example, author, this code would remove all but one bibliographic entry for a given author. That is not what you probably want.

For testing purposes, this repository also includes an example bibliography file, and the R source file also includes three simple test cases to make sure the code works as expected.

