setDateTime <- function(dateTimeColumn, 
                        Table = FALSE) {
  datetime <- strptime(dateTimeColumn,
                       tz = parameters$timeZone,
                       format = "%HH %MM %OS")
  datetime <- format(datetime, format = "%H:%M:%OS", usetz = FALSE)
  return(datetime)
}

edwards_TRIMP <- function(duration, HRmax, HRmean, HRrest) {
  HRR <- (HRmean - HRrest) / (HRmax - HRrest)
  k <- ifelse(HRmax < 160, 1.67, 1.92)  # Set k value based on athlete's age (en gender)
  TRIMP <- duration * HRR * 0.64 * exp(k * HRR)
  return(TRIMP)
}

edwards_SHRZ <- function(duration, HRmax, HRmean, HRrest) {
  # Calculate time spent in each zone
  time_zone1 <- duration * (0.5 * (HRmax - HRrest) / (HRmean - HRrest))
  time_zone2 <- duration * (0.1 * (HRmax - HRrest) / (HRmean - HRrest))
  time_zone3 <- duration * (0.1 * (HRmax - HRrest) / (HRmean - HRrest))
  time_zone4 <- duration * (0.1 * (HRmax - HRrest) / (HRmean - HRrest))
  time_zone5 <- duration * (0.1 * (HRmax - HRrest) / (HRmean - HRrest))
  SHRZ <- (time_zone1 * 1) + (time_zone2 * 2) + (time_zone3 * 3) + (time_zone4 * 4) + (time_zone5 * 5)
  return(SHRZ)
}

# datetime <- strptime(datetime_str, format = "%HH %MM %OS", tz = "UTC")
# datetime <- format(datetime, format = "%H:%M:%OS", usetz = FALSE)