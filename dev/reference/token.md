# Token types

Token types

## Usage

``` r
token(values = values_token)

values_token
```

## Format

An object of class `character` of length 12.

## Arguments

- values:

  A character string of possible values. See `values_token` in examples
  below.

## Details

This parameter is used in `textrecipes::step_tokenize()`.

## Examples

``` r
values_token
#>  [1] "words"             "characters"        "character_shingle"
#>  [4] "lines"             "ngrams"            "paragraphs"       
#>  [7] "ptb"               "regex"             "sentences"        
#> [10] "skip_ngrams"       "tweets"            "word_stems"       
token()
#> Token Unit (qualitative)
#> 12 possible values include:
#> 'words', 'characters', 'character_shingle', 'lines', 'ngrams',
#> 'paragraphs', 'ptb', 'regex', 'sentences', 'skip_ngrams', 'tweets',
#> and 'word_stems'
```
