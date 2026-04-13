# Activation functions between network layers

Activation functions between network layers

## Usage

``` r
activation(values = values_activation)

activation_2(values = values_activation)

values_activation
```

## Format

An object of class `character` of length 23.

## Arguments

- values:

  A character string of possible values. See `values_activation` in
  examples below.

## Details

This parameter is used in `parsnip` models for neural networks such as
`parsnip:::mlp()`.

## Examples

``` r
values_activation
#>  [1] "celu"        "elu"         "exponential" "gelu"       
#>  [5] "hardshrink"  "hardsigmoid" "hardtanh"    "leaky_relu" 
#>  [9] "linear"      "log_sigmoid" "relu"        "relu6"      
#> [13] "rrelu"       "selu"        "sigmoid"     "silu"       
#> [17] "softmax"     "softplus"    "softshrink"  "softsign"   
#> [21] "swish"       "tanh"        "tanhshrink" 
activation()
#> Activation Function (qualitative)
#> 23 possible values include:
#> 'celu', 'elu', 'exponential', 'gelu', 'hardshrink', 'hardsigmoid',
#> 'hardtanh', 'leaky_relu', 'linear', 'log_sigmoid', 'relu', 'relu6',
#> 'rrelu', 'selu', 'sigmoid', 'silu', 'softmax', 'softplus', …, 'tanh',
#> and 'tanhshrink'
```
