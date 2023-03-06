CRRTrinomial <- function (TypeFlag = c("ce", "pe", "ca", "pa"), S, X, Time, r, 
    b, sigma, n, title = NULL, description = NULL) 
{
    TypeFlag = TypeFlag[1]
    z = NA
    if (TypeFlag == "ce" || TypeFlag == "ca") 
        z = +1
    if (TypeFlag == "pe" || TypeFlag == "pa") 
        z = -1
    if (is.na(z)) 
        stop("TypeFlag misspecified: ce|ca|pe|pa")
    dt = Time/n
    u = exp(sigma * sqrt(2*dt))
    d = 1/u
    dd <- exp(-sigma*sqrt(dt/2))
    pu = ((exp(b * dt/2) - dd)/(1/dd - dd))^2
    pd = (1-sqrt(pu))^2
    pm <- 1-pu-pd
    Df = exp(-r * dt)
    
    # add 1 steps to tree 
    n <- n+1
    # exponent
    iExp <- (1:(2*(n+1)-1))-(n+1)
    OptionValue = z * (S * u^iExp - X)
    OptionValue = (abs(OptionValue) + OptionValue)/2
    if (TypeFlag == "ce" || TypeFlag == "pe") {
        for (j in seq(from = (n), to = 2, by = -1)) 
          for (i in 1:(2*j-1)) 
            OptionValue[i] = (pu*OptionValue[i+2] + pm*OptionValue[i+1] + pd*OptionValue[i]) * Df
    }

    if (TypeFlag == "ca" || TypeFlag == "pa") {
        for (j in seq(from = (n), to = 2, by = -1))
          for (i in 1:(2*j-1)) {
              SS = S * d^(j-1) * u^(i-1)
              exVal =  z * (SS - X)
            OptionValue[i] = (pu*OptionValue[i + 2] + pm*OptionValue[i+1] + pd*OptionValue[i]) * Df
            OptionValue[i] = max(exVal, OptionValue[i])
	  }
    }
    # the middle node is the price
    Sup <- S*u
    Sdown <- S*d
    
    # delta by central difference
    delta <- (OptionValue[3] - OptionValue[1])/(Sup-Sdown)
    du <- (OptionValue[3] - OptionValue[2])/(Sup-S)
    dd <- (OptionValue[2] - OptionValue[1])/(S-Sdown)
    gamma <- (du-dd)/((Sup-Sdown)/2)
 
    param = list()
    param$TypeFlag = TypeFlag
    param$S = S
    param$X = X
    param$Time = Time
    param$r = r
    param$b = b
    param$sigma = sigma
    param$n = n
    if (is.null(title)) 
        title = "CRR Binomial Tree Option"
    if (is.null(description)) 
        description = as.character(date())
    res = list()
    res$param = param
    res$price = OptionValue[2]
    res$delta = delta 
    res$gamma = gamma 
    res$title = title
    res$description = description 

    res
}
