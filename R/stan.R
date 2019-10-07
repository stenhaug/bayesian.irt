irt_data_wide_to_long <- function(.data_wide){
    .data_wide %>%
        mutate(person = 1:nrow(.)) %>%
        gather(item, correct, -person) %>%
        mutate(item = parse_number(item))
}

irt_data_long_to_stan_list <- function(.data_long){
    list(
        I = max(.data_long[["item"]]),
        J = max(.data_long[["person"]]),
        N = nrow(.data_long),
        ii = .data_long[["item"]],
        jj = .data_long[["person"]],
        y = .data_long[["correct"]]
    )
}
