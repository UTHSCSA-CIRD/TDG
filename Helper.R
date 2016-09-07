# 
# samp = pickSample(obd, .25)
# save(obd,rseed,obd.backup,samp, file = "survProcessed.rdata")
# # We delete the ID-type variables
# samp <- samp[,setdiff(names(samp),c(toOmit,textfields))];
# samp <- samp[,c(vs(samp,'f'),vs(samp))];
# serverHash = digest("ChangeThisInYourCode!", algo = "sha512", ascii = TRUE)
# filter_surv2 = subset(samp,s2resp=='Yes')
# filter_surv2_kids = subset(samp,s2resp=='Yes' & pat_age < 18)
# filter_kids = subset(samp,pat_age < 18)
# serverData = list(samp, filter_surv2, filter_surv2_kids, filter_kids)
# serverDataDic = c("No filter", "Survey 2 Respondants Only", "Survey 2 Respondants & Pat < 18", "Pat < 18")
# serverTitle = "Obesity Survey Sample Data Review."
# serverStatement = quote(h4("Enter valid shiny tags and information here. Mostly... you know... Like a link to a data dictionary or something.")))
# #DEBUG#save(samp, file = "survSavet0.rdata")
# #DEBUG#save(serverData, file = "survSavet1.rdata")
# #DEBUG#save(serverData ,serverDataDic , file="survSavet2.rdata")
# save(serverData ,serverDataDic , serverHash, serverTitle, serverStatement,file="survSave.rdata")