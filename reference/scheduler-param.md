# Parameters for neural network learning rate schedulers

These parameters are used for constructing neural network models.

## Usage

``` r
rate_initial(range = c(-3, -1), trans = transform_log10())

rate_largest(range = c(-1, -1/2), trans = transform_log10())

rate_reduction(range = c(1/5, 1), trans = NULL)

rate_steps(range = c(2, 10), trans = NULL)

rate_step_size(range = c(2, 20), trans = NULL)

rate_decay(range = c(0, 2), trans = NULL)

rate_schedule(values = values_scheduler)

values_scheduler
```

## Format

An object of class `character` of length 5.

## Arguments

- range:

  A two-element vector holding the *defaults* for the smallest and
  largest possible values, respectively. If a transformation is
  specified, these values should be in the *transformed units*.

- trans:

  A `trans` object from the `scales` package, such as
  [`scales::transform_log10()`](https://scales.r-lib.org/reference/transform_log.html)
  or
  [`scales::transform_reciprocal()`](https://scales.r-lib.org/reference/transform_reciprocal.html).
  If not provided, the default is used which matches the units used in
  `range`. If no transformation, `NULL`.

- values:

  A character string of possible values. See `values_scheduler` in
  examples below.

## Details

These parameters are often used with neural networks via
`parsnip::mlp(engine = "brulee")`.

The details for how the brulee schedulers change the rates:

- `schedule_decay_time()`: \\rate(epoch) = initial/(1 + decay \times
  epoch)\\

- `schedule_decay_expo()`: \\rate(epoch) = initial\exp(-decay \times
  epoch)\\

- `schedule_step()`: \\rate(epoch) = initial \times
  reduction^{floor(epoch / steps)}\\

- `schedule_cyclic()`: \\cycle = floor( 1 + (epoch / 2 / step size) )\\,
  \\x = abs( ( epoch / step size ) - ( 2 \* cycle) + 1 )\\, and
  \\rate(epoch) = initial + ( largest - initial ) \* \max( 0, 1 - x)\\
