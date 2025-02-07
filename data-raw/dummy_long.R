
# Create Dummy Data
dummy_long <- data.frame(line = c("Sensitive A", "Sensitive B", "Sensitive C","Sensitive A", "Sensitive B", "Sensitive C",
                                 "Sensitive A", "Sensitive B", "Sensitive C","Sensitive A", "Sensitive B", "Sensitive C",
                                 "Sensitive A", "Sensitive B", "Sensitive C","Sensitive A", "Sensitive B", "Sensitive C",
                                 "Sensitive A", "Sensitive B", "Sensitive C","Sensitive A", "Sensitive B", "Sensitive C",
                                 "Sensitive A", "Sensitive B", "Sensitive C"),
                        age_group = c("20-24","20-24","20-24","25-29","25-29","25-29",
                                      "30-34","30-34","30-34","35-39","35-39","35-39",
                                      "40-44","40-44","40-44","45-49","45-49","45-49",
                                      "50-54","50-54","50-54","55-59","55-59","55-59",
                                      "Total","Total","Total"),
                        value = c(5, 1, 24, 9, 6, 28,
                                  14, 4, 19, 11, 2, 22,
                                  20, 8, 35, 3, 9, 39,
                                  14, 3, 28, 10, 11, 27,
                                  86, 44, 222), check.names=FALSE, stringsAsFactors = FALSE)

# Write out data
write_csv(dummy_long, "data-raw/dummy_long.csv")
save(dummy_long, file = "data/dummy_long.rda")
