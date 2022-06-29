#TheSetup########################
library(blastula)
library(tidyverse)
library(glue)
library(palmerpenguins)
library(correlation)
library(effectsize)
library(ggtext)
library(showtext)

source("utils.R")
#Blastula Setup############
#Create/Compose a (first) mail
email <- blastula::compose_email(
  body = "Hello,
  I just wanted to give you an update of our work.
  Cheers, Edgar")

email


#Create smtp credentials file
# create_smtp_creds_file(
#   file = "gmail_creds",
#   user = "user_name@gmail.com",
#   host = "smtp.gmail.com",
#   port = 465,
#   use_ssl = TRUE
# )


#Send the email with smtp_send, but insert a real mail address
# email %>%
#   smtp_send(
#     to = "xxx@xxx.com",
#     from = "xxx@xxx.com",
#     subject = "Update on project X",
#     credentials = creds_file("mail_creds")
#   )


## Improve your mail#########

#Generate a plot


txt <- report_correlation(data = penguins, 
                          x = "bill_length_mm", 
                          y = "body_mass_g")



font_add_google("Ramaraja")
showtext_auto()


plot <- ggplot(penguins, aes(bill_length_mm, body_mass_g, 
                             color = island))+
  geom_point()+
  theme_minimal(base_size = 24, base_family = "Ramaraja")+
  labs(
    x = "Bill length",
    y = "Body mass",
    color = "The Islands:",
    title = paste("Palmer penguins:", txt)
  ) +
  theme(plot.title=element_text(size=24))+
  scale_color_viridis_d(option = "viridis")+
  theme(plot.title.position = "plot")+
  theme(
    plot.title = element_textbox_simple(
      size = 24, lineheight = 1,
      linetype = 1, # turn on border
      box.color = "#748696", # border color
      fill = "#F0F7FF", # background fill color
      r = grid::unit(3, "pt"), # radius for rounded corners
      padding = margin(5, 5, 5, 5), # padding around text inside the box
      margin = margin(0, 0, 10, 0) # margin outside the box
    )
  )

#add plot
mail_plot <- blastula::add_ggplot(plot_object = plot)



#New and improved mail
recipient <- "Mr. Smith"
salutation <- "Best regard,"
sender_name <- "Edgar"

body_text <-
  md(glue(
    "
## Dear {recipient},

I just wanted to send you an update of my work, see the corresponding
graph (and file in the attachment).

{mail_plot}

{salutation}

{sender_name}
"    
  ))

#Compose the mail again
email <- compose_email(body = body_text)
email


#add_attachment before the file is send/before smtp_send
email %>%
  add_attachment(file = "report.pdf") %>%
  smtp_send(
    to = "xxx@xxx.com",
    from = "xxx@xxx.com",
    subject = "Update on project X",
    credentials = creds_file("mail_creds")
  )


#Send mails via functions#################

#Insert your mail address
sent_mails <- function(mail, report) {
  email %>%
    add_attachment(file = report) %>%
    smtp_send(
      to = mail,
      from = "xxx@xxx.com",
      subject = paste0("Update on ", report),
      credentials = creds_file("mail_creds")
    )
}

  
#To send mails
#send_mails("xxx@xxx.com", "report.pdf")
  
  
  
  
#Other shits
#credentials = creds_key("fauad\gu99mywo")
#Lucky list?
  
mails <- as.list(rep("edgar.treischl@me.com", 5))
mails
  
reports <- list.files(path="./", pattern=".html", full.names=FALSE)
reports <- as.list(reports)
reports
  
map2(mails, reports, sent_mails)
  
  
  
  