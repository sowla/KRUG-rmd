library(mailR)
library(purrr)

pwalk(
  list(
    to = rep("suthira.owlarn@gmail.com", 3),
    subject = paste(2015:2017, "report"),
    body = paste0("Please find attached the monthly reservations report for ", 2015:2017, "."),
    attachments = paste0(2015:2017, "_report.html")
  ),
  function(to, subject, body, attachments) {
    send.mail(
      from = "suthira.owlarn@gmail.com",
      to = to,
      subject = subject,
      body = body,
      smtp = list(
        host.name = "smtp.gmail.com", 
        port = 465, 
        user.name = "suthira.owlarn", 
        passwd = pwd, 
        ssl = TRUE
      ),
      authenticate = TRUE,
      attach.files = attachments
    )
  }
)