# nocov start

.onLoad <- function(libname, pkgname) {
  if (dplyr_pre_1.0.0()) {
    vctrs::s3_register(
      "dplyr::mutate",
      "parameters",
      method = mutate_parameters
    )
    vctrs::s3_register(
      "dplyr::arrange",
      "parameters",
      method = arrange_parameters
    )
    vctrs::s3_register(
      "dplyr::filter",
      "parameters",
      method = filter_parameters
    )
    vctrs::s3_register(
      "dplyr::rename",
      "parameters",
      method = rename_parameters
    )
    vctrs::s3_register(
      "dplyr::select",
      "parameters",
      method = select_parameters
    )
    vctrs::s3_register("dplyr::slice", "parameters", method = slice_parameters)
  } else {
    vctrs::s3_register(
      "dplyr::dplyr_reconstruct",
      "parameters",
      method = dplyr_reconstruct_parameters
    )
  }
}

# nocov end
