
# Create Dummy Data
dummy_wide <- data.frame(line  = c("Sensitive A", "Sensitive B", "Sensitive C"),
                        `20-24` = c(5,1,24),
                        `25-29` = c(9,6,28),
                        `30-34` = c(14,4,19),
                        `35-39` = c(11,2,22),
                        `40-44` = c(20,8,35),
                        `45-49` = c(3,9,39),
                        `50-54` = c(14, 3, 28),
                        `55-59` = c(10, 11, 27),
                        `Total` = c(86,44,222), check.names=FALSE, stringsAsFactors = FALSE)

# Write out data
write_csv(dummy_wide, "data-raw/dummy_wide.csv")
save(dummy_wide, file = "data/dummy_wide.rda")
