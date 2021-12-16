import smtp

proc createAccount(email, username: string, pass, passconf: string) =
    discard
    # var msg = createMessage("verify your changeblog account",
    #                         "Hello!.\n Is this awesome or what?",
    #                         @["prestosilver.ptp@gmail.com"])
    # let smtpConn = newSmtp(useSsl = true, debug = true)
    # smtpConn.connect("smtp.gmail.com", Port 465)
    # smtpConn.auth("prestosilver.ptp@gmail.com", "hellow65")
    # smtpConn.sendmail("prestosilver.ptp@gmail.com", @[
    #         "prestosilver.ptp@gmail.com"], $msg)
